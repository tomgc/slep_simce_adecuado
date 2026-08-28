# traspaso_cierre_v14.md

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v14
- **Fecha:** 2026-06-11
- **Sesión:** 14 — Lote de ajustes UI/UX del motor + implementación del toggle
  real de tres niveles (Adecuado / Elemental / Insuficiente) en pipeline y
  frontend. Modelo: Opus 4.8. Entorno: interfaz web (diseño) + Positron (build
  y validación local por el usuario).
- **Archivos principales modificados:**
  `30_procesamiento/33_motor_template.html`,
  `30_procesamiento/31_leer_normalizar.R`,
  `30_procesamiento/32_agregar_comunal.R`,
  `30_procesamiento/33_generar_html.R`,
  `10_utils/10_utils.R`.
  Documentación actualizada: `README.md`,
  `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md`,
  `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.html`.

## 2. Resumen ejecutivo

Sesión larga y productiva con dos grandes bloques. El primero, un conjunto de
~13 ajustes de UI/UX sobre el motor (estado inicial vacío con empty state,
multi-selección por checkbox de SLEP y regiones con límite dinámico, sticky de
Nivel/Prueba con línea naranja, default de dependencia a "Todas", botón
limpiar reposicionado, reorganización masonry de notas metodológicas, favicon
inline, y otros). El segundo, de mayor calado: un disclaimer metodológico sobre
la clasificación SLEP (la dependencia es la *actual* y se aplica a toda la serie
histórica, incluido el periodo de gestión municipal previo al traspaso) y, sobre
todo, el **toggle real de tres niveles** Adecuado/Elemental/Insuficiente, que
exigió tocar el pipeline R completo (leer dos columnas nuevas, agregarlas
ponderadas, embeberlas en el JSON) y el frontend (apilado con normalización a
100). Todo verificado: el build corre limpio y el % Adecuado no cambió ni un
decimal respecto al build previo. Queda pendiente para la sesión 15: auditoría
de Corp. Admin. Delegada, y unos ajustes finos del usuario sobre el motor que no
alcanzamos a detallar.

## 3. Estado al cierre

**Funciona (última ejecución exitosa: 2026-06-11, build OK en 3 s):**
- Pipeline completo de cero, 14 columnas en `simce_rbd.parquet` y
  `simce_comunal.parquet`. JSON 2,1 MB comprimido, HTML 2.507 KB.
- Toggle "Elem. + Insuf.": apila los tres niveles con color propio,
  normalizados a exactamente 100 (verificado sobre datos reales: 24/24 casos
  GSE×año de Costa Central suman 100,0).
- % Adecuado idéntico al build anterior (bloque "Costa Central — 4b/lect" del
  log byte a byte igual).
- Multi-selección de SLEP y regiones, empty state, sticky, disclaimers SLEP en
  modal + tarjetas + notas metodológicas.

**Delta respecto a v13:** v13 cerró la auditoría pre-lanzamiento (filtros
MINEDUC en la vía SLEP, SRI en CDN, limpieza de `generateSeries` legacy). v14
construye encima: nuevas features de UI y la feature de fondo del toggle.

## 4. Registro detallado de cambios

> Numeración global correlativa, continúa desde el ítem 60 (v13). Cada bloque es
> un cambio conceptualmente independiente.

**UI/UX del motor (frontend, `33_motor_template.html`):**

61. [UI] Empty state inicial: el motor arranca con **cero entidades**
    (`useState([])`); cuando no hay entidades, se ocultan las secciones de
    resultados y tabla y se muestra un recuadro guía. `buildInitialEntities()`
    eliminada (huérfana). El reset (botón limpiar) ahora vacía a `[]`.
62. [UI] Texto guía del empty state: sin título de error, una sola línea a 16px,
    color `--fg-2`. Clase `.empty-board` (renombrada desde `.empty-state` para
    no colisionar con el empty-state del modal).
63. [UI] Botón "limpiar" (icono `rotate-ccw`): movido del `entities-head` al
    final de `entities-list`, junto a la última tarjeta (sin `margin-left:auto`).
64. [UI] Toggle "Elem. + Insuf.": bug de salto al desmarcar resuelto
    reservando el ancho del chip condicional de `ChartHints`
    (`visibility:hidden` en vez de desmontar).
65. [UI] Tarjetas de entidad: crecen en alto antes de pasar a 2 filas
    (`max-width:340px`, `align-items:flex-start`, nota SLEP con `white-space:normal`).
66. [UI] Sticky de Nivel/Prueba: `controls-bar` con `position:sticky; top:0`
    y `border-top:4px coral` (la línea naranja viaja con el sticky); borde
    coral del header removido para no duplicar.
67. [UI] Default de dependencia en pestañas Comuna/Región/Nacional: pasa de
    "Servicio Local de Educación" (cod 5) a "Todas las dependencias" (`""`).
    Resuelve de raíz el síntoma de "comuna sin datos" (p. ej. Petorca): la
    comuna se guardaba con dependencia SLEP y salía vacía; el selector de
    comuna nunca mezcló SLEPs.
68. [UI] Texto "Resultados por GSE" → "Resultados segmentados por grupo
    socioeconómico (GSE)".
69. [UI] Multi-selección por **checkbox** de SLEP y de regiones: arrays
    `selectedSleps`/`selectedRegions`, helper `toggleSel` con límite dinámico
    `maxSel = slotsLibres` (no permite superar el tope de 4 entidades);
    `saveEntities()` agrega en lote con colores distintos. En edición vuelven a
    radio (selección única). La lista de regiones ya no colapsa al seleccionar.
70. [UI] Favicon inline (data-URI SVG, fondo ocean + tres barras) en `<head>`.
    Elimina el 404 en GitHub Pages.
71. [UI] Notas metodológicas reorganizadas en **masonry de 3 columnas**
    (`columns: 3 280px`, `break-inside: avoid`), eliminando los huecos del
    layout de grid anterior. Orden de lectura: Estándares → SLEP → Fórmula →
    GSE → Gap → Preliminares.

**Disclaimer metodológico SLEP (frontend):**

72. [Metodología/UI] Componente `SlepDisclaimer` + helper
    `SimceData.entidadDependeSlep(entity)` (`kind==="slep"` o `depe2==="5"`).
    Disclaimer permanente en pestaña SLEP del modal; condicional (`depe2==="5"`,
    antes del selector) en Región/Comuna/Nacional; nota permanente en las
    tarjetas de entidades con dependencia SLEP; nota larga en las notas
    metodológicas. Texto: la dependencia es la *actual* y se aplica a toda la
    serie; las cifras previas al traspaso son de gestión municipal y no
    atribuibles al SLEP.
73. [Consistencia/UI] Label de la dependencia 5 normalizado a "Servicio Local
    de Educación Pública (SLEP)" en `DEPE2_LABELS` (robusto frente al JSON,
    sobreescribe lo que traiga).

**Toggle real de tres niveles (pipeline + frontend):**

74. [Pipeline] `31_leer_normalizar.R`: lee `palu_eda_ele` y `palu_eda_ins`
    (espejo de `palu_eda_ade`), las valida como columnas requeridas y las
    incluye en el esquema (12 → 14 columnas de `simce_rbd.parquet`).
75. [Pipeline] `10_utils/10_utils.R`: `agregar_ponderado()` calcula además
    `pct_elemental` y `pct_insuficiente` con la MISMA ponderación por `nalu` y
    los MISMOS filtros (`nalu>=10`, `marca` NA, `palu_eda_ade` no-NA). Condicional:
    solo si las columnas existen, para no romper los tests inline ni llamadas
    históricas. El conjunto de filas lo gobierna `palu_eda_ade`, por lo que el
    % Adecuado es idéntico exista o no ele/ins.
76. [Pipeline] `32_agregar_comunal.R`: propaga `pct_elemental`/`pct_insuficiente`
    al `select` final de `simce_comunal.parquet` (12 → 14 columnas).
77. [Pipeline] `33_generar_html.R`: `depe2_labels` corregido a "Servicio Local
    de Educación Pública (SLEP)"; `pct_ele`/`pct_ins` embebidos en el bloque
    comunal (`datos_lst`); `palu_ele`/`palu_ins` crudos en el bloque por
    establecimiento (`simce_rbd_lst`).
78. [Frontend] Las 5 funciones `generateSeriesBy*` acumulan `num_ele`/`num_ins`
    y devuelven `pct_ele`/`pct_ins` vía nuevo helper `mkPunto()`, que normaliza
    los tres niveles a exactamente 100 (Adecuado exacto; Elem+Insuf reescalados
    para sumar 100−Adecuado, absorbiendo el ±0,1 de redondeo de la fuente).
79. [Frontend] `RecentBarsSubchart`: el rectángulo blanco único ("resto") se
    reemplaza por dos segmentos apilados con color fijo (Elemental `#D8C98E`,
    Insuficiente `#B9A9A0`) cuando el toggle está activo. Leyenda (`ChartHints`)
    y tooltip actualizados a tres niveles. Dos selectores CSS huérfanos
    removidos (`.hint-empty-box`, `.tt-seg-sw-empty`).

Resumen estadístico: agregar fila `Sesión 14 | traspaso v14 | 19 cambios |
Opus 4.8 | UI/UX + toggle tres niveles`. Total acumulado: **79**.

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md`. Anexar el delta de
la sesión 14 (ítems 61–79 de arriba) al final del detalle cronológico,
respetando la numeración global. Categorías dominantes de la sesión: UI/UX
(~11), Metodología/Consistencia (~3), Pipeline (~4), Frontend-datos (~2).

## 6. Bugs y diagnósticos de la sesión

- **Diag 14-1 (supresión de Elem/Insuf en 2023-2024).** Al verificar la
  viabilidad del toggle, las columnas `palu_eda_ele`/`palu_eda_ins` existen en
  los 18 xlsx y suman 100 con Adecuado, **salvo** en 2023 y 2024 (4b: ~28%
  filas; 2m: ~2%) donde los tres valen 0. **Causa raíz:** el 100% de esas
  filas tienen `nalu < 10` (min 0, p50 3, max 9): es **supresión por
  confidencialidad** de la Agencia. En 2014-2022 y 2025 la Agencia suprime
  como blanco (→ NA); en 2023-2024 cambió la convención a ceros.
  **Implicancia:** `agregar_ponderado()` ya excluye estas filas con
  `nalu >= 10`, así que nunca contaminaron el % Adecuado, y al aplicar el mismo
  filtro a ele/ins quedan fuera idénticamente. **Patrón general aprendido:** la
  convención de supresión de la fuente puede variar entre años (blanco vs.
  cero); antes de incorporar una columna nueva, auditar su comportamiento en
  TODOS los años, no asumir homogeneidad. Verificado con dos scripts auditores
  (`verificar_elem_insuf.R`, `verificar_elem_insuf_2023_2024.R`).
- **Bug 14-2 (botón Preset / comuna sin datos).** No fue un bug de selección:
  el default `depe2="5"` hacía que comunas sin establecimientos SLEP salieran
  vacías. Resuelto con el ítem 67 (default "Todas las dependencias").

## 7. Aprendizajes y restricciones descubiertas

- **R1 (clasificación de dependencia es actual, no histórica).** `cod_depe2`
  es la dependencia *vigente* del establecimiento, fija para toda la serie.
  Verificado empíricamente: Costa Central (traspaso 2025) aparece con depe=5
  desde 2014; "Nacional + SLEP" incluye filas depe=5 en años sin SLEP. Esto
  motivó el disclaimer (ítem 72). **Pendiente conceptual mayor:** el motor NO
  segmenta la serie por año de traspaso (gestión municipal vs. SLEP); hoy
  atribuye todo el histórico al SLEP. Segmentarlo de verdad sería un cambio de
  fondo (pipeline + lógica de series), no un disclaimer. Anotado para sesión
  dedicada.
- **R2 (toggle: el % Adecuado no puede cambiar).** Al agregar ele/ins, el
  criterio de éxito innegociable es que el % Adecuado sea idéntico al modo
  solo-Adecuado. Se garantiza haciendo que el filtro de filas lo gobierne
  `palu_eda_ade` y que la normalización a 100 conserve Adecuado exacto.
  Verificado en el build (bloque Costa Central igual) y en simulación cliente
  (24/24 casos).
- **R3 (normalización a 100 en el apilado).** Los tres porcentajes de la fuente
  suman 99,9–100,1 por redondeo a un decimal. `mkPunto()` reescala Elem+Insuf
  para que el apilado sume exactamente 100, evitando huecos/desbordes visuales.

## 8. Decisiones de diseño

- **D1.** "Limpiar" y default del motor → cero entidades (no las 4 comunas
  iniciales). Alternativa: resetear a Costa Central. Elegido vacío + empty state
  porque el usuario lo pidió explícitamente y da una entrada más neutra.
- **D2.** Multi-selección por checkbox con límite dinámico, no modal repetido.
  Alternativa: seguir agregando de a una. Elegido checkbox por practicidad
  (varias entidades visibles a la vez).
- **D3.** Colores de Elemental/Insuficiente fijos (no por entidad). Alternativa:
  derivar del color de la entidad. Elegido fijo para lectura consistente entre
  tarjetas; el color de la entidad representa Adecuado.
- **D4.** `agregar_ponderado()` extendido condicionalmente (detecta ele/ins).
  Alternativa: nueva función separada. Elegido extender para DRY y porque el
  filtro/ponderación son idénticos; la condicionalidad protege los tests y
  llamadas históricas.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| Umbral MINEDUC | `nalu >= 10` | `10_utils.R` | Filtro de supresión (sin cambio) |
| COLOR_ELEM | `#D8C98E` | `33_motor_template.html` | Segmento Elemental (nuevo) |
| COLOR_INSUF | `#B9A9A0` | `33_motor_template.html` | Segmento Insuficiente (nuevo) |
| MAX_ENTIDADES | `4` | `33_motor_template.html` | Tope de comparación (sin cambio) |
| depe2 "5" label | "Servicio Local de Educación Pública (SLEP)" | `33_generar_html.R` + template | Corregido en origen y normalizado en cliente |
| Esquema simce_rbd | 14 columnas | `31_leer_normalizar.R` | +palu_eda_ele, +palu_eda_ins |
| Esquema simce_comunal | 14 columnas | `32_agregar_comunal.R` | +pct_elemental, +pct_insuficiente |

## 10. Arquitectura de archivos

Sin cambios estructurales (no se movieron ni renombraron carpetas/scripts). Solo
se modificó el contenido de 5 archivos y la documentación. El escáner
(`estructura_actual.md`) sigue vigente del 2026-06-11. Re-ejecutar el escáner al
abrir la sesión 15 por buena práctica.

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

1. **Ajustes finos del motor (foco próximo).** El usuario tiene ajustes sobre
   el motor que no alcanzó a detallar al cierre. Tipo: UI/UX. Complejidad: por
   determinar. Criterio de éxito: por definir con el usuario. **Es el primer
   tema de la sesión 15.**
2. **Auditoría Corp. Admin. Delegada (depe=4).** Baja prioridad. En 4b/lect
   aparece ~1 establecimiento; en 2m/lect ~22. Verificar contra el directorio
   y el registro SIMCE que sea real (pocos colegios depe=4, muchos
   técnico-profesionales que no rinden 4b, varios con `nalu<10`) y no un error.
   Tipo: auditoría de cifras. Enfoque sugerido: script `verificar_*.R` que
   cuente depe=4 con datos por prueba×nivel y cruce con el directorio.
3. **Segmentación histórica por año de traspaso (gestión municipal vs. SLEP).**
   Cambio de fondo, no un disclaimer. Cortaría la serie de cada SLEP en su
   `anio_traspaso`. Toca pipeline y lógica de series. Complejidad: alta. Tipo:
   metodología/feature. Solo si el equipo decide que el disclaimer no basta.
4. **Documentación restante.** README, presentación conceptual y .html ya
   actualizados en esta sesión (ver §1). Falta solo regenerar/actualizar el
   diagrama `arquitectura_slep_simce_adecuado.html` si se quiere reflejar las
   14 columnas y los tres niveles (baja prioridad; el diagrama de flujo no
   cambió, solo los esquemas).

**Auditoría de cierre (POLITICA 5.6):** sin deuda nueva. Naming, estructura,
constantes nombradas, validaciones y reproducibilidad respetados. El % Adecuado
se validó idéntico (reproducibilidad e idempotencia OK).

**Ruta sugerida sesión 15:** (1) ajustes finos del motor que traiga el usuario;
(2) si hay tiempo, auditoría depe=4; (3) cierre. Diferir la segmentación
histórica (pendiente 3) a una sesión dedicada por su envergadura.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 El % Adecuado del modo apilado debe seguir siendo idéntico al modo
  solo-Adecuado. Cualquier cambio en `mkPunto` o `agregar_ponderado` se valida
  contra el bloque "Costa Central — 4b/lect" del log de build.
- 🔒 Segmentación GSE, ponderación por `nalu`, no mezclar pruebas/niveles,
  filtro `nalu>=10` + `marca NA`: invariantes intocables.
- ✅ ANTES de tocar cualquier `generateSeriesBy*`, recordar que las 5 deben
  permanecer consistentes entre sí (misma forma de acumular y normalizar).
- ✅ ANTES de modificar el pipeline R, leer el archivo completo (los scripts no
  estaban adjuntos al inicio de esta sesión; pedirlos si faltan).
- ⚠️ NO asumir que las convenciones de supresión de la fuente son homogéneas
  entre años (ver Diag 14-1).

## 13. Fragmentos de código de referencia

**Forma correcta de agregar un nivel ponderado (patrón del proyecto):**

```r
# En agregar_ponderado(): mismo filtro y ponderación que adecuado.
pct_elemental = sum(nalu * palu_eda_ele / 100, na.rm = TRUE) /
                sum(nalu, na.rm = TRUE) * 100
```

**Normalización a 100 en el cliente (mkPunto, frontend):**

```javascript
// Adecuado exacto; Elem+Insuf reescalados a (100 - Adecuado).
const resto = Math.max(0, 100 - pct);
const sumaEI = pe + pi;
if (sumaEI > 0) { pe = Math.round((pe/sumaEI)*resto*10)/10; pi = Math.round((resto-pe)*10)/10; }
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 15 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  > (POLÍTICA + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto
  > el traspaso v14, el escáner actual y los archivos del foco. Foco: ajustes
  > finos del motor (los detallo al inicio); de haber tiempo, auditoría de
  > Corp. Admin. Delegada.
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO adjuntar; verificar que estén al día):*
     `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `33_motor_template.html` si los ajustes son de
     UI; los scripts R del pipeline si el ajuste toca cálculo; `CLAUDE.md` si
     se corre en Claude Code.
  3. *Específicos (adjuntar):* `traspaso_cierre_v14.md`; `estructura_actual.md`
     (re-escanear antes); `33_motor_template.html` vigente; los 4 scripts R
     vigentes si el foco toca pipeline.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada y avisarlo en el mensaje de apertura.
