# traspaso_cierre_v12.md

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v12
- **Fecha:** 2026-06-10
- **Sesión:** 12. Foco: compresión gzip del motor, inclusión de SLEP con
  traspaso prospectivo 2026, y dos correcciones de raíz (selección de RBDs por
  SLEP; supresión de resultados de la Agencia en popups).
- **Entorno:** interfaz web (diseño + pipeline); el usuario corre el build
  localmente en Positron y pega salida.
- **Archivos principales modificados:** `30_procesamiento/30_construir_auxiliares.R`,
  `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`,
  `10_utils/pako.min.js` (nuevo), `README.md`, `docs/index.html`,
  `40_salidas/intermedios/sleps_chile.parquet`.

## 2. Resumen ejecutivo

Sesión densa con cinco cambios sustantivos sobre el motor, todos verificados y
desplegados. Se cerró el pendiente de optimización de peso comprimiendo el JSON
embebido con gzip+base64 y descompresión en cliente vía pako: el HTML pasó de
14,5 MB a ~1,8 MB (13 % del original) sin tocar la lógica de datos. Se
implementó la inclusión de los 10 SLEP con traspaso educativo 2026 (entre ellos
4 de Valparaíso: Marga Marga, Aconcagua, Los Andes, Petorca), que administran ya
sus establecimientos pero cuyos RBDs figuran como municipales en los datos 2025;
se incluyen con marca visual explícita. Esa inclusión expuso dos bugs latentes
que se corrigieron de raíz: el motor reconstruía el universo de un SLEP por
comuna+dependencia (en vez de usar la lista exacta de RBDs), y los popups
listaban establecimientos cuyo resultado fue suprimido por la Agencia
(`palu = NA`). Ambos corregidos, el segundo confirmado contra el sitio oficial.
Todo commiteado y pusheado (`7486842`), motor desplegado en Pages. La próxima
sesión está dedicada a una **auditoría completa pre-lanzamiento público**, con
encargo documentado.

## 3. Estado al cierre

- **Funciona:** pipeline completo `00_build.R` corre limpio en ~3 s (última
  ejecución exitosa esta sesión). Motor comprimido carga correctamente en
  navegador. SLEP prospectivos 2026 muestran datos, badge y conteo correcto de
  establecimientos. Popups listan solo establecimientos con resultado publicado.
  Costa Central (regresión) sin cambios en cifras ni establecimientos.
- **No funciona / pendiente de verificación dura:** la corrección de cifras no
  se ha auditado exhaustivamente — es justamente el objeto de la próxima sesión.
  El motor muestra nombres de establecimiento en popups, lo que puede chocar con
  las Condiciones de Uso de la Agencia (ver pendientes, decisión de gobernanza).
- **Delta respecto a v11:** +compresión gzip; +10 SLEP prospectivos; +2 fixes de
  raíz; catálogos de popup reducidos (RBDs×GSE 42.134→34.255, RBDs×nivel
  23.026→21.402). Peso HTML 14.531 KB → 1.829 KB.

## 4. Registro detallado de cambios

Ver backlog histórico, ítems **51–56** (`50_documentacion/activa/backlog_historico.md`).
Resumen por bloque:

- **51 (DOC):** enlaces de documentación en README.
- **52 (DT/UI):** `exportarCSV` → `descargarBlob` (DRY).
- **53 (UI/Infra):** compresión gzip+base64+pako del JSON embebido.
- **54 (P/UI/D):** SLEP traspaso prospectivo 2026 con marca visual.
- **55 (UI/DT):** selección de RBDs por SLEP vía `entity.rbds` (fuente única).
- **56 (UI/P/D):** filtro de supresión de la Agencia en catálogos de popup.

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md` (documento vivo).
Esta sesión anexó los ítems 51–56. Numeración global correlativa.

## 6. Bugs de la sesión

- **Bug 12-1 (base64 con saltos de línea).** Síntoma: motor en blanco,
  `Uncaught SyntaxError: Invalid or unexpected token` en la línea del JSON.
  Causa raíz: `jsonlite::base64_enc()` emite formato MIME con `\n` cada 64
  caracteres; esos saltos dentro del literal `atob("...")` rompen el string JS.
  Solución: `gsub("\n", "", json_b64, fixed = TRUE)` en `33_generar_html.R`.
  Verificación: cadena gzip→base64→pako.inflate idéntica byte a byte; motor
  carga. **Regla aprendida:** todo dato binario inyectado como literal JS debe
  ir en una sola línea; validar que el base64 no traiga whitespace MIME.
  Estado: resuelto.

- **Bug 12-2 (SLEP prospectivo con 0 establecimientos / serie vacía).** Síntoma:
  al seleccionar un SLEP 2026, "0 establecimientos" y gráfico vacío. Causa raíz:
  `generateSeriesByRbd` filtraba por `cod_depe2 === "5"` (Servicio Local) pese a
  su nombre; los RBDs de SLEP prospectivos son municipales (1/2) en 2025.
  Solución de raíz: la función agrega por `entity.rbds` exactos desde
  `simce_rbd`, sin pasar por comuna+depe2. **Regla aprendida:** el universo de un
  SLEP es su lista de RBDs (`entity.rbds`), no una reconstrucción por
  comuna+dependencia (dos SLEP pueden compartir comuna; la dependencia varía con
  el traspaso). Estado: resuelto.

- **Bug 12-3 (RBDs ajenos en popup de SLEP).** Síntoma: popup de SLEP Santiago
  Centro listaba colegios particulares ajenos al SLEP. Causa raíz: misma que
  12-2 — los popups re-filtraban por comuna+depe2 en vez de `entity.rbds`.
  Solución: popups, conteos y tooltip migrados a `entity.rbds`. Estado: resuelto
  (mismo fix que 12-2).

- **Bug 12-4 (establecimientos suprimidos listados en popup).** Síntoma: popup
  de celda GSE mostraba escuelas rurales sin resultado SIMCE real (Petorca,
  10 listados vs. 4 con dato). Causa raíz: catálogos `rbds_por_nivel` y `rbd_gse`
  construidos con `distinct()` sin filtrar `palu_eda_ade` no-NA; la Agencia
  suprime resultados de establecimientos con pocos evaluados (`palu = NA`,
  `nalu > 0`). Solución: filtro `!is.na(palu_eda_ade)` en ambos catálogos
  (`33_generar_html.R`) + guard `D2.palu[i] != null` en el motor. Verificación:
  auditoría puntual (`auditoria_popup_petorca.R`) + contraste con sitio oficial
  de la Agencia (RBD 1131 = "-" en 2025); popup pasó de 10 a 4. **Regla
  aprendida:** los catálogos de listado de establecimientos deben exigir dato
  publicable (`palu` no-NA), no solo existencia de fila; un `nalu > 0` no implica
  resultado publicado. Bug latente desde s4; expuesto por SLEP rurales. Estado:
  resuelto. **Pendiente de auditoría:** confirmar que no quedan casos residuales
  en otras entidades (caso A2 del encargo de auditoría).

## 7. Aprendizajes y restricciones descubiertas

1. **`entity.rbds` es la fuente única de verdad del universo de un SLEP** (UI).
   Cualquier cálculo, conteo o popup de SLEP debe partir de esa lista, nunca
   reconstruir por comuna+dependencia. Violarlo reintroduce 12-2/12-3.
2. **La supresión de la Agencia (`palu = NA`) debe respetarse en todo listado**
   (P/D). Mostrar un establecimiento suprimido como si tuviera dato es un error
   de cara a la Agencia. Regla: listar solo con `palu` no-NA.
3. **Base64 inyectado como literal JS va en una sola línea** (Infra).
4. **El traspaso prospectivo se parametriza por dato, no por año fijo**: la marca
   y la inclusión usan `max(YEARS)` / `ANIO_DATOS_VIGENTE`, así el umbral avanza
   solo cuando entren datos del año siguiente.

## 8. Decisiones de diseño

- **Opción A (agrupación) para SLEP 2026, no reasignación de `cod_depe2`.**
  Alternativa considerada: reescribir la dependencia oficial de los RBDs a "5".
  Rechazada: altera el dato oficial de la Agencia. Se eligió incluir los RBDs
  municipales como agrupación del SLEP, con marca visible. Implica que el % del
  SLEP prospectivo refleja gestión municipal previa, lo que la marca comunica.
- **Compresión gzip vs. refactor columnar.** Se eligió gzip (pako) por mejor
  relación impacto/riesgo: una transformación verificable por checksum, sin
  tocar la lógica de datos. Los enfoques de diccionarios/eliminación de
  redundancia se descartaron por bajo retorno sobre un HTML ya en ~1,8 MB.
- **Doble capa de filtro de supresión (R + cliente).** El popup usa dos rutas
  (con año → `simce_rbd`; sin año → `rbd_gse`); se filtró en ambas.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|-----------|-------|---------|------|
| `ANIO_DATOS_VIGENTE` | `2025L` | `30_construir_auxiliares.R` | Último año con datos; define el umbral de traspaso prospectivo (cambio de valor: nuevo en s12) |
| `ANIO_DATOS_MAX` | `max(YEARS)` | `33_motor_template.html` | Derivado del JSON; umbral de `slepEsProspectivo` |
| `PNG_SCALE` | `2` | `33_motor_template.html` | Rasterización export (s11) |
| Umbral heatmap | ≤25/26–50/51–70/>70 | `33_motor_template.html` | Fijo (metodológico) |
| Umbral MINEDUC | `nalu < 10` excluye | `10_utils/10_utils.R` | — |

## 10. Arquitectura de archivos

Sin cambios estructurales de carpetas. Archivos nuevos: `10_utils/pako.min.js`
(dependencia JS para descompresión), `50_documentacion/activa/encargo_auditoria_slep_simce_adecuado.md`.
Ver `estructura_actual.md` (correr el escáner antes de la próxima sesión).

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **[BLOQUEANTE DE LANZAMIENTO — gobernanza] Nombres de establecimiento en
   popups.** El motor muestra `nom_rbd` (nombre de la escuela) en los popups. Las
   Condiciones de Uso de la Agencia (POLÍTICA §6.4) indican: no identificar
   establecimientos por nombre en outputs. Tipo: decisión de gobernanza (no
   técnica). Impacto: alto (puede impedir el lanzamiento público o exigir cambio).
   Sugerencia: el usuario debe decidir si el uso interno/diagnóstico exime, si se
   anonimiza, o si se obtiene autorización. **Resolver antes de publicar.**

2. **[FUNCIONALIDAD] Toggle Elemental / Insuficiente en gráficos.** El usuario
   pidió un botón activador/desactivador que cargue los niveles Elemental e
   Insuficiente en los gráficos (hoy solo Adecuado). Complejidad: media. Tocar
   `33_motor_template.html` (datos ya disponibles; era `showElemInsuf`
   hardcodeado, removido en s10 — ver ítem 41 del backlog). Criterio de éxito:
   toggle que muestra/oculta las series Elemental/Insuficiente sin romper la
   segmentación GSE ni el cálculo Adecuado.

3. **[AUDITORÍA — toda la próxima sesión] Auditoría pre-lanzamiento.** Encargo
   completo en `50_documentacion/activa/encargo_auditoria_slep_simce_adecuado.md`.
   Tres dimensiones: corrección (cifras exactas, casos A1–A7), seguridad
   (B1–B4), optimización (C1–C4). Criterio de "listo para lanzar" definido en el
   encargo. Es la **ruta principal de la próxima sesión.**

4. **[HIGIENE] Scripts de diagnóstico temporales sin trackear.**
   `auditoria_popup_petorca.R` y `diagnostico_peso_json.R` quedaron en la raíz.
   Mover a `_archivo/` (ya en `.gitignore`) o borrar. No versionar en raíz.

### Auditoría de cierre (POLÍTICA 5.6, preguntas "Cierre")

- ¿Cada transformación crítica tiene check de validación? Parcial — el filtro de
  supresión es nuevo; la auditoría próxima lo valida. → pendiente A2.
- ¿Outputs reproducibles e idempotentes? Sí (build determinista), pero conviene
  confirmar en la auditoría (caso A7).
- ¿Decisiones metodológicas como constantes nombradas? Sí (`ANIO_DATOS_VIGENTE`).
- ¿Nombres sin tildes/ñ/espacios? Sí.

### Ruta sugerida para la próxima sesión

**Sesión 13 = auditoría completa**, siguiendo el encargo. Orden: corrección
primero (donde un error es más caro), luego seguridad, optimización al final.
El pendiente 1 (nombres de establecimiento) se eleva como decisión temprano.
El toggle Elemental/Insuficiente (pendiente 2) se difiere a una sesión posterior
a la auditoría, salvo que el usuario lo priorice.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ NO lanzar públicamente sin resolver el pendiente 1 (nombres de
  establecimiento) y sin cerrar los casos A y B del encargo de auditoría.
- ✅ ANTES de tocar el motor, verificar que `entity.rbds` sigue siendo la fuente
  única del universo de SLEP (no reintroducir filtros por comuna+depe2).
- ✅ ANTES de listar establecimientos en cualquier vista nueva, exigir `palu`
  no-NA (respetar supresión de la Agencia).
- 🔒 La segmentación GSE, la ponderación por `nalu` y la no-mezcla de
  pruebas/niveles son invariantes intocables.
- ✅ ANTES de cerrar la sesión de auditoría, mover/borrar los scripts de
  diagnóstico temporales (pendiente 4).

## 13. Fragmentos de código de referencia

```r
# Filtro de supresión de la Agencia (forma correcta para catálogos de popup).
# Un establecimiento solo se lista si tiene resultado publicado (palu no-NA),
# no basta con que exista fila o que nalu > 0.
df_rbd_gse <- arrow::read_parquet(here::here("40_salidas","intermedios","simce_rbd.parquet")) |>
  dplyr::filter(!is.na(.data$palu_eda_ade)) |>
  dplyr::distinct(rbd, nivel, prueba, cod_grupo) |>
  dplyr::mutate(rbd = as.character(rbd))
```

```javascript
// Universo de un SLEP = su lista exacta de RBDs. Nunca reconstruir por
// comuna+depe2. Vale para SLEP traspasados y prospectivos por igual.
const rbdsSlep = entity.kind === "slep" ? new Set((entity.rbds || []).map(String)) : null;
// ... filter: if (entity.kind === "slep") { if (!rbdsSlep.has(String(r.rbd))) return false; }
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 13 (auditoría) (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: ONE-OFF extendida — auditoría
  > pre-lanzamiento dedicada. El protocolo (POLÍTICA + SETTINGS) vive en la
  > knowledge base; léelo desde ahí. El encargo de auditoría está en la knowledge
  > base / adjunto. Adjunto el traspaso v12, el escáner actual y los scripts del
  > pipeline para revisión línea por línea.
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (no adjuntar):* `POLITICA_PROYECTO.md`,
     `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales:* el `encargo_auditoria_slep_simce_adecuado.md` (si no está ya
     en la knowledge base, adjuntarlo).
  3. *Específicos (adjuntar):* `traspaso_cierre_v12.md`; `estructura_actual.md`
     (correr el escáner antes); todos los `.R` de `30_procesamiento/`
     (30,31,32,33), `10_utils/10_utils.R`, `00_build.R`; `33_motor_template.html`;
     y para los casos A4/A6, `directorio_oficial_ee.csv` y
     `202602_Listado_SLEP_2026_vf.xlsx`.
- **Nota final:** si algún archivo cambió entre sesiones, adjuntar la versión más
  actualizada y avisarlo en la apertura.
