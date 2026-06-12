# Traspaso de cierre v17 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v17
- **Fecha:** 2026-06-12
- **Sesión:** 17 — foco en segmentación visual pre/post traspaso en la serie
  histórica de un SLEP (marcador de año de traspaso + tramo municipal previo
  atenuado), enmienda de política §10 (Apache 2.0) y fix de ruta del listado
  SLEP que bloqueaba el build.
- **Entorno:** sesión en interfaz web; build, escáner y git ejecutados por el
  usuario en terminal (zsh, macOS) y Positron.
- **Archivos principales modificados:** `30_procesamiento/33_motor_template.html`
  (feature de segmentación); `30_procesamiento/30_construir_auxiliares.R` (fix de
  ruta); `POLITICA_PROYECTO.md` (v6, §10); insumo renombrado en disco
  `20_insumos/auxiliares/202602_Listado_SLEP_2026_vf.xlsx` →
  `listado_slep_2026.xlsx` (rename versionado en el commit de fix).

## 2. Resumen ejecutivo

Sesión de desarrollo sobre base estable que cierra el único pendiente alto vivo
(segmentación histórica por año de traspaso) y la deuda documental D16-1. Se
implementó en el motor la diferenciación visual entre la gestión municipal
previa y la gestión SLEP: marcador vertical punteado en el año de traspaso y
tramo previo (años < traspaso) atenuado con línea dasheada y opacidad reducida,
gobernado por una función única `SimceData.anioCorteTraspaso()` que solo aplica
a SLEP ya traspasados (traspaso ≤ último año con datos); SLEP prospectivos y
entidades filtradas por dependencia (comuna/región/nacional) no reciben corte.
Verificado en Costa Central (traspaso 2025). Durante el primer build surgió un
bug bloqueante no relacionado: el insumo del listado SLEP había sido renombrado
en disco a snake_case (`listado_slep_2026.xlsx`) mientras el código seguía
apuntando al nombre antiguo; se corrigieron las 4 referencias en
`30_construir_auxiliares.R`. Se enmendó la política §10 (v6) reconociendo Apache
2.0 junto a MIT con criterio explícito de cuándo elegir cada una. El pipeline
corre limpio en 4 s con el invariante % Adecuado idéntico (Viña GSE 5 4b/lect:
62.6 en 2014 … 65.0 en 2025). Tres commits temáticos atómicos en `main`; falta
el push y el commit de cierre.

## 3. Estado al cierre

**Qué funciona:**
- Build completo corre limpio en 4 s (última ejecución exitosa esta sesión, vía
  `Rscript 00_build.R`). Invariante Costa Central 4b/lect idéntico a v16.
- Motor regenerado con la segmentación de traspaso, validado visualmente en
  Costa Central: marcador "traspaso" en 2025, tramo ≤2024 atenuado, 2025 a
  opacidad plena. Comuna y nacional sin cambios (sin corte).
- Política en v6: §10 reconoce Apache 2.0 junto a MIT.
- Tres commits locales en `main`: `2b08eb6` (fix ruta listado), `4197d39`
  (feature segmentación), `32b090d` (política v6).

**Qué no funciona / pendiente operativo:**
- **Commits sin push.** Los 3 commits de la sesión + el commit de cierre (este
  traspaso + snapshot del escáner) están locales; falta `git push` antes de
  cerrar.
- **Motor regenerado no commiteado ni desplegado.** El build regeneró
  `40_salidas/motor_comparacion.html` con la feature, pero el HTML de salida y
  `docs/index.html` no se commitearon (no aparecen en `git status`: o están en
  `.gitignore`, o el deploy a `docs/` es un paso manual aparte). **El sitio en
  GitHub Pages aún NO tiene la feature de segmentación.** Decisión pendiente para
  la próxima sesión: desplegar (copiar a `docs/index.html` + commit + push) o
  diferir.

**Delta respecto a v16:**
- Cerrado el pendiente alto de segmentación por año de traspaso (feature en
  producción local, no desplegada).
- Cerrada la deuda documental D16-1 (política §10 enmendada, v6).
- Resuelto un bug bloqueante de build (ruta del listado SLEP).

## 4. Registro detallado de cambios (de la sesión)

1. **Feature: segmentación visual pre/post traspaso**
   (`33_motor_template.html`). Categoría: funcionalidad/UI. Nuevo helper
   `SimceData.anioCorteTraspaso(entity)` que devuelve el año de traspaso solo
   para `entity.kind === "slep"` con `anio_traspaso ≤ ANIO_DATOS_MAX` (SLEP ya
   traspasado), y `null` en los demás casos (prospectivos: ya tienen
   badge/disclaimer; comuna/región/nacional: mezclan años de traspaso distintos,
   sin corte único). En `SparklineSubchart`: marcador vertical punteado con
   rótulo "traspaso" en el año de corte; los tramos del gap 2019-2021
   (`pre≤2018` / `post≥2022`) se subdividen en sub-segmentos previo/post para
   aplicar línea dasheada (`3,2`) + opacidad 0.4 al tramo previo, manteniendo la
   continuidad visual (el subtramo previo enlaza con el primer punto post). Los
   puntos y etiquetas % de años previos heredan la opacidad atenuada. Se agregó
   `entity.anio_traspaso, entity.kind` a las deps del `useEffect`. Por qué: la
   serie de un SLEP ya traspasado mezclaba gestión municipal y gestión SLEP sin
   señal visual; el disclaimer textual era la única marca. Cómo se verificó:
   build limpio + verificación visual en Costa Central (usuario confirmó "se ve
   bien"). Respeta 🔒 color por nivel (solo modula opacidad/estilo, no toca
   `COLOR_ADEC`) y la regla de no duplicar lógica de series (criterio único en
   `SimceData`). Commit `4197d39`.

2. **Fix: ruta del listado SLEP al nombre canónico**
   (`30_construir_auxiliares.R`). Categoría: bugfix/INFRA. El insumo había sido
   renombrado en disco a `listado_slep_2026.xlsx` (snake_case, política §2),
   pero el código apuntaba a `202602_Listado_SLEP_2026_vf.xlsx`; el build fallaba
   en el paso [4] (`path does not exist`). Se actualizaron las 4 referencias (2
   comentarios L21/L230, ruta L253, mensaje de error L267). La ocurrencia en
   `_archivo/20260611/auditoria_a4_universo_slep.R` NO se tocó (andamio
   congelado, política §9.5). Cómo se verificó: build completo OK tras el cambio
   (paso [4] lee el listado: 70 SLEP, 346 combinaciones). El rename quedó
   versionado en el mismo commit (Git lo detectó como rename 100%). Commit
   `2b08eb6`.

3. **Docs: política v6, §10 reconoce Apache 2.0** (`POLITICA_PROYECTO.md`).
   Categoría: documentación/LEGAL. Bullet `LICENSE` reescrito (opción B): MIT por
   defecto; Apache 2.0 cuando se requiera concesión expresa de patentes o archivo
   NOTICE (publicación institucional), versionando `LICENSE` + `NOTICE` y
   encabezados de licencia en los scripts; en ambas, cláusula de alcance
   solo-código. Encabezado de versión actualizado a v6 con changelog propio
   (changelog v4→v5 preservado abajo). Cierra D16-1. Por qué: la política sugería
   solo MIT y este proyecto adoptó Apache 2.0 (sesión 16), dejando una desviación
   documentada. Commit `32b090d`. **Acción manual pendiente:** reemplazar también
   la copia en la knowledge base del Project (subida por UI), no solo la copia del
   repo.

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md` (documento vivo). El
backlog viene de sesiones 1–16 (entradas 1–98). **Esta sesión agrega las
entradas 99–101**, continuando la numeración. Resumen de la sesión 17:

- **99 (funcionalidad/UI):** segmentación visual pre/post traspaso en la serie
  SLEP (marcador de año + tramo municipal previo atenuado).
- **100 (bugfix/INFRA):** fix de ruta del listado SLEP (rename de insumo a
  snake_case desincronizado del código; build bloqueado en paso [4]).
- **101 (documentación/LEGAL):** enmienda de política §10 (Apache 2.0 junto a
  MIT, v6).

**Sobre la taxonomía:** la categoría LEGAL (insinuada en v16 con las entradas
95–96) acumula ahora la 101. Sigue bajo el 2% del total; se mantiene la
recomendación de absorberla en DOC salvo que aparezcan más entradas legales.

**Delta del backlog:** 3 entradas nuevas (99–101). Sin refinamientos de
taxonomía ni reclasificaciones. Total acumulado: 101.

## 6. Bugs de la sesión

- **Bug 17-1: build falla en paso [4], listado SLEP no encontrado.**
  - **Síntoma observable:** `Error: path does not exist:
    .../20_insumos/auxiliares/202602_Listado_SLEP_2026_vf.xlsx` al correr
    `Rscript 00_build.R`; el pipeline aborta tras [3].
  - **Causa raíz:** el insumo fue renombrado en disco a `listado_slep_2026.xlsx`
    (snake_case, cumple política §2) en algún momento posterior al último escaneo
    versionado, pero `30_construir_auxiliares.R` seguía referenciando el nombre
    antiguo en 4 lugares. No es un bug del cambio de la sesión (el template aún no
    se alcanzaba en el flujo).
  - **Solución exacta:** `30_construir_auxiliares.R` L21, L230, L253, L267:
    `202602_Listado_SLEP_2026_vf.xlsx` → `listado_slep_2026.xlsx`.
  - **Criterio de verificación:** build completo OK; paso [4] lee el listado.
  - **Patrón general aprendido:** **un rename de insumo en disco que no se propaga
    al código rompe el build en silencio hasta la próxima corrida.** Cuando se
    renombra un insumo para cumplir naming, hay que hacer `grep` de TODAS las
    referencias literales (incluidos comentarios y mensajes de error, no solo la
    ruta de lectura) y actualizarlas en el mismo cambio. Corolario: el escáner
    listaba el nombre viejo, señal de que el rename fue manual y desincronizado;
    correr el escáner tras renombrar insumos.
  - **Principios:** C.7 (portabilidad/rutas), C.10 (transparencia: referencias
    literales explícitas).
  - **Estado:** resuelto.

## 7. Aprendizajes y restricciones descubiertas

- **El dato `anio_traspaso` ya viajaba en `DATA.sleps`.** El pipeline
  (`33_generar_html.R` L234-238, desde `sleps_chile.parquet`) ya inyectaba
  `anio_traspaso` por SLEP; la feature de esta sesión solo consumió un campo
  existente. Verificado en el motor: 2337 filas, 0 nulos, Costa Central = 2025.
  Antes de construir un campo nuevo, verificar si el meta ya lo transporta.
- **Lógica de tramos: capas independientes.** El corte de traspaso (opacidad +
  estilo) y el corte del gap 2019-2021 (segmentación de paths) son ortogonales:
  el primero modula atributos por punto/subtramo, el segundo decide dónde rompe
  la línea. Mantenerlos como capas separadas evita reescribir la lógica del gap.
- **Criterio de corte como función única.** `anioCorteTraspaso()` centraliza la
  regla (qué entidades reciben corte) en `SimceData`, no en el render; replica el
  principio ya aprendido (duplicar lógica de series causa bugs multi-sitio,
  B6.1/B6.2 de sesiones previas).
- **Rename de insumo → grep exhaustivo** (ver bug 17-1). Regla concreta: al
  renombrar un archivo de insumo, `grep -rn "nombre_viejo" --include="*.R"` y
  actualizar todas las referencias activas (excluyendo `_archivo/`) en el mismo
  commit; correr el escáner después.
- **`grep --include=*.R` falla en zsh interactivo.** El glob sin comillas no
  matchea (`zsh: no matches found`); usar `--include="*.R"` entre comillas.

## 8. Decisiones de diseño

- **D17-1: corte de traspaso solo para SLEP ya traspasados.**
  `anioCorteTraspaso()` devuelve `null` para SLEP prospectivos (traspaso > último
  dato: no hay tramo "post" que diferenciar, ya tienen badge/disclaimer) y para
  entidades depe2=5 (comuna/región/nacional mezclan SLEP con años de traspaso
  distintos, no hay corte único; conservan el disclaimer textual). Alternativa
  descartada: dibujar corte en cualquier entidad con algún componente traspasado
  (ambiguo y sin un año único).
- **D17-2: representación = marcador vertical + tramo previo atenuado.**
  Alternativas: (a) solo banda de fondo como el gap, (b) solo cambio de color de
  línea, (c) marcador + atenuación. Elegida (c): comunica "antes vs después" sin
  romper la continuidad de la serie ni introducir un color nuevo (respeta 🔒 color
  por nivel). El tramo previo dasheado + opacidad 0.4 lee como "no atribuible al
  SLEP".
- **D17-3: el punto post-traspaso único se deja sin refuerzo.** Costa Central
  traspasó en 2025, único año post-corte y además preliminar; el tramo "post" es
  un solo punto (sin línea, `postC.length < 2`). Se decidió NO agregar refuerzo
  visual: un punto único con asterisco es fiel al estado real (1 año provisorio);
  reforzarlo arriesga sobre-interpretar un dato preliminar. Reevaluar cuando haya
  un segundo año post-traspaso (datos 2026).
- **D17-4: política §10 con criterio MIT/Apache (opción B), no equivalencia
  neutra.** Se prefirió dar el criterio de cuándo elegir cada licencia (patentes
  / NOTICE / publicación institucional) en vez de listar ambas como
  intercambiables, consistente con la decisión Apache de la sesión 16.

## 9. Constantes y parámetros vigentes (cambios de la sesión)

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| `OP_PREVIO` | `0.4` | `33_motor_template.html` (`SparklineSubchart`) | Opacidad del tramo municipal previo al traspaso. Nueva esta sesión. |

`ANIO_DATOS_MAX` no es nueva: ya existía en `SimceData` (máximo de `YEARS`); la
feature la reutiliza como umbral del corte. Sin otros cambios de constantes.

## 10. Arquitectura de archivos

Referencia: escáner al cierre `estructura_actual.md` (2026-06-12 12:04:22,
17 carpetas / 109 archivos), sello `20260612_120422`. Delta vs v16 (108
archivos): +1 neto por el snapshot nuevo del escáner (los anteriores podados por
retención=2). El insumo del listado figura ahora como `listado_slep_2026.xlsx`
(antes `202602_Listado_SLEP_2026_vf.xlsx`); mismo conteo, es un rename. Sin
cambios de carpetas. Los `verificar_*.R` de raíz siguen untracked (efímeros).

**Anomalía registrada:** el escáner adjunto en la apertura (`20260612_080447`)
listaba el nombre viejo del listado, evidencia de que el rename en disco fue
manual y posterior al escaneo, sin propagarse al código (origen del bug 17-1).
El escáner de cierre ya refleja el nombre correcto.

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

| Pendiente | Tipo | Complejidad | Notas |
|---|---|---|---|
| Desplegar la feature de segmentación a GitHub Pages | operativo / despliegue | baja | El motor local tiene la feature; `docs/index.html` y el sitio NO. Copiar el HTML regenerado a `docs/index.html`, commit y push. Verificar primero cómo se hace el deploy en este repo (¿paso manual? ¿`docs/` ignora el HTML de `40_salidas/`?). Primer ítem de la próxima sesión |
| Push de los commits de la sesión 17 | operativo | baja | 3 commits + commit de cierre locales en `main`; falta `git push` |
| Observación de gobernanza: 4b/depe4 = 1 EE | mejora / gobernanza | baja | Heredado de v16, no accionado. Una serie comunal×GSE de 4b filtrada a depe4 puede ser un único EE (no anónimo en la práctica). Evaluar salvaguarda |
| (Opcional) migrar `exportarCSV` al helper `descargarBlob` | deuda técnica | baja | Heredado, sin abrir |
| Refuerzo del punto post-traspaso único | mejora visual | baja | Diferido por D17-3; reevaluar con datos 2026 (segundo año post-traspaso) |

**Evaluación de deuda técnica:** sin zonas frágiles nuevas. La feature de
segmentación quedó encapsulada en `SimceData` + `SparklineSubchart` sin tocar
`getSeriesForEntity` ni el pipeline R. El fix de ruta eliminó una fragilidad
(referencia literal desincronizada).

**Auditoría de cierre (política 5.6, preguntas "Cierre"):**
- ¿Pipeline reproducible de cero? Sí (build limpio 4 s, invariante verificado).
- ¿Cada transformación crítica con check? Sí (sin cambios de pipeline de
  cálculo; el fix fue de ruta).
- ¿Outputs reproducibles e idempotentes? Sí.
- ¿Decisiones metodológicas como constantes nombradas? Sí; `OP_PREVIO`
  nombrada, no número mágico.
- ¿Nombres sin tildes/ñ/espacios? Sí; el rename del listado mejoró el
  cumplimiento (eliminó mayúsculas y `_vf`).
- Hallazgo nuevo: el deploy a Pages quedó pendiente → registrado como pendiente
  operativo (primer ítem de la ruta).

**Ruta sugerida para la sesión 18 (en orden):**
1. **Desplegar la feature a GitHub Pages** (cerrar el ciclo de la sesión 17:
   copiar a `docs/index.html`, commit, push). Criterio de éxito: el sitio Pages
   muestra la segmentación en Costa Central. Antes, confirmar el mecanismo de
   deploy del repo.
2. **Push de los commits pendientes** (si no se hizo al cerrar esta sesión).
3. Evaluar la observación 4b/depe4=1 EE si se decide accionar.
4. Diferir: `exportarCSV` → `descargarBlob`; refuerzo del punto post-traspaso.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 **Color por nivel es invariable:** Adecuado/Elemental/Insuficiente con color
  fijo (`COLOR_ADEC`/`COLOR_ELEM`/`COLOR_INSUF`). El corte de traspaso modula
  opacidad y estilo de trazo, NUNCA el color.
- 🔒 **% Adecuado intocable:** todo cambio que toque el pipeline verifica el
  bloque Costa Central 4b/lect idéntico al build previo (Viña GSE 5: 62.6 …
  65.0).
- 🔒 **Regla del corte centralizada:** la decisión de qué entidades reciben corte
  de traspaso vive SOLO en `SimceData.anioCorteTraspaso()`. NO replicar el
  criterio con ternarios inline en componentes de render.
- ✅ ANTES de renombrar un insumo: `grep -rn "nombre_viejo" --include="*.R"`
  (con comillas) y actualizar todas las referencias activas en el mismo commit;
  correr el escáner después.
- ✅ ANTES de desplegar: confirmar el mecanismo de deploy (cómo llega el HTML a
  `docs/index.html`); si se tocó template o datos, regenerar y copiar a
  `docs/index.html` antes del commit de deploy.
- ✅ ANTES de correr scripts desde terminal: `Rscript x.R`, no `source("x.R")`.
- ⚠️ Los `verificar_*.R` de la raíz son efímeros; no versionarlos.
- ⚠️ La política v6 debe estar también en la knowledge base del Project, no solo
  en el repo; verificar que la copia de la KB esté al día antes de la próxima
  apertura.

## 13. Fragmentos de código de referencia

```javascript
// Regla única del corte de traspaso (SimceData). Devuelve el año de traspaso
// solo para SLEP ya traspasado; null en los demás casos (prospectivo, o
// entidad filtrada por dependencia que mezcla años distintos).
function anioCorteTraspaso(entity) {
  if (!entity || entity.kind !== "slep") return null;
  const at = entity.anio_traspaso;
  if (at == null) return null;
  if (ANIO_DATOS_MAX != null && at > ANIO_DATOS_MAX) return null;
  return at;
}
```

```javascript
// Subdivisión de un tramo (pre o post gap) en previo/post traspaso, enlazando
// el subtramo previo con el primer punto post para no cortar la línea.
const previo = seg.filter(s => s.year < anioCorte);
const postC  = seg.filter(s => s.year >= anioCorte);
const previoEnlazado = postC.length > 0 ? previo.concat([postC[0]]) : previo;
// previoEnlazado -> path dasheado "3,2" opacidad 0.4 ; postC -> path pleno.
```

```bash
# Buscar referencias literales de un insumo antes de renombrarlo (zsh: comillas).
grep -rn "202602_Listado_SLEP_2026_vf" ~/Projects/slep_simce_adecuado --include="*.R"
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 18 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  > (POLÍTICA + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto el
  > traspaso v17 y el escáner actual. Foco de la sesión: desplegar a GitHub Pages
  > la feature de segmentación por año de traspaso (copiar a `docs/index.html`,
  > commit, push) y verificar el push de los commits de la sesión 17.

- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar que estén al día):
     `POLITICA_PROYECTO.md` (v6), `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si la sesión corre en Claude Code;
     `00_build.R` y `33_generar_html.R` si hay que revisar cómo se genera/despliega
     `docs/index.html`; `publicacion_github_pages.md` (en `50_documentacion/activa/`)
     para el procedimiento de deploy.
  3. *Específicos de la sesión (SÍ adjuntar):* `traspaso_cierre_v17.md`;
     `estructura_actual.md`.

- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo en el mensaje de apertura. La
  política pasó a v6 esta sesión: confirmar que la knowledge base tenga la v6.
