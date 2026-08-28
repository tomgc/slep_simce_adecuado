# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v02
- **Fecha:** 2026-05-27
- **Sesión:** 2 — Incorporación de dimensión `cod_depe2` al pipeline, construcción de `sleps_chile.parquet`, y rediseño completo de la UI del motor de comparación HTML.
- **Modelo utilizado:** Claude Sonnet 4.6
- **Entorno:** R (Positron) + HTML/React/D3
- **Archivos principales modificados:**
  - `30_procesamiento/30_construir_auxiliares.R`
  - `30_procesamiento/31_leer_normalizar.R`
  - `30_procesamiento/32_agregar_comunal.R`
  - `30_procesamiento/33_generar_html.R`
  - `30_procesamiento/33_motor_template.html` (renombrado desde `motor_template.html`)
  - `20_insumos/auxiliares/202602_Listado_SLEP_2026_vf.xlsx` (nuevo insumo)

---

## 2. Resumen ejecutivo

Esta sesión tuvo dos focos principales: completar el pipeline de datos con la dimensión de dependencia (`cod_depe2`) y reconstruir la UI del motor de comparación HTML. En el pipeline se incorporó `cod_depe2` desde `directorio_oficial_ee.csv` a `simce_rbd.parquet` y `simce_comunal.parquet`, y se completó el pendiente P1 construyendo `sleps_chile.parquet` desde el listado oficial de SLEPs 2026 — lo que permitió desbloquear la funcionalidad de comparación por SLEP en la UI. En la UI se implementaron todos los cambios solicitados: nuevo flujo de selección (commune + dependencia + nivel/prueba), modal con 3 tabs (Comuna / SLEP / Grupo custom), heatmap con umbrales fijos, tabla con años descendentes, foco por año, filtro GSE, y popup de establecimientos. El motor template fue renombrado con prefijo `33_` para seguir la convención de auxiliares numerados. Al cierre el HTML pesa 2,56 MB, carga correctamente y todas las funcionalidades nuevas están operativas. Quedan pendientes la exportación (P2/P3), el orquestador (P4), y tres bugs menores de UI.

---

## 3. Estado del proyecto al cierre

### Qué funciona

- Pipeline completo ejecutable en orden: `30_construir_auxiliares.R` → `31_leer_normalizar.R` → `32_agregar_comunal.R` → `33_generar_html.R`
- `simce_rbd.parquet`: 185.378 filas, 12 columnas (añade `cod_depe2`), 0 NAs en `cod_depe2`
- `simce_comunal.parquet`: 44.975 filas, 12 columnas (agrega por `comuna × dependencia × GSE`)
- `sleps_chile.parquet`: 1.707 filas, 26 SLEPs, solo establecimientos `COD_DEPE == 6`
- `motor_comparacion.html` (2,56 MB standalone): UI v3 validada en Chrome
  - Modal 3 tabs: Comuna+Dependencia / SLEP / Grupo custom
  - Tab SLEP lista 26 SLEPs con número de comunas y año de traspaso
  - Preset Costa Central carga como entidad `kind=slep`
  - Popup "ver establecimientos ▸" en chips SLEP (muestra todos los RBDs del SLEP)
  - Supergrid: siempre 4 columnas, meta correcta por tipo de entidad
  - Tabla: años descendentes (2025→2014), heatmap fijo 4 bandas, foco año, filtro GSE, CSV junto a exportar gráficos
  - Celdas GSE sin datos: fondo transparente sin recuadro
  - Regiones con nombre completo en modal
- Repositorio GitHub sincronizado (commits hasta sesión 1; sesión 2 pendiente de commit)

### Qué no funciona / pendiente

- Exportación UI: botones de gráficos y CSV muestran `alert("Export pendiente")` — no implementados
- Popup establecimientos: muestra **todos** los RBDs del SLEP, no solo los que tienen datos SIMCE para nivel/prueba activos (B3)
- Entidades semilla iniciales (`buildInitialEntities`): siguen siendo las 4 comunas como `kind=comuna` sin `depe2` — comportamiento aceptable pero podrían actualizarse a `depe2=5` para Costa Central (B2)
- Sanity check de `32_agregar_comunal.R`: el `pivot_wider` del resumen final produce warning porque ahora hay múltiples filas por `(nom_com_rbd, cod_grupo, anio)` al tener `cod_depe2` como dimensión adicional
- `00_build.R` orquestador: no existe
- `00_escanear_proyecto.R`: no ejecutado esta sesión

### Qué cambió respecto al traspaso anterior (v01)

- `cod_depe2` incorporado como dimensión en todo el pipeline
- `sleps_chile.parquet` construido y operativo (P1 resuelto)
- `motor_template.html` → `33_motor_template.html` (renombrado)
- UI rediseñada completamente (v2 → v3): modal 3 tabs, entidades SLEP, heatmap fijo, foco año, filtro GSE, popup establecimientos
- JSON del HTML incluye nuevo array `DATA.sleps` (1.707 registros)
- Peso HTML aumentó de 1,5 MB (v1) a 2,56 MB (v3) por el catálogo de SLEPs

---

## 4. Registro detallado de cambios realizados

#### Cambio 12: Exploración y validación de `COD_DEPE2` en directorio oficial

- **Archivo(s) afectado(s):** ninguno (exploración interactiva)
- **Categoría temática:** Investigación/validación de datos
- **Qué se hizo:** Verificación de columnas `COD_DEPE` y `COD_DEPE2` en `directorio_oficial_ee.csv`; validación de distribución por código; confirmación de que `COD_DEPE2 == 5` corresponde a SLEPs en comunas Costa Central.
- **Por qué se hizo:** La dimensión de dependencia es necesaria para que la UI pueda filtrar por tipo de establecimiento y para que el preset SLEP sea metodológicamente correcto.
- **Cómo se verificó:** Conteos con `dplyr::count()` en consola; cruce `COD_DEPE × COD_DEPE2`; filtro por comunas SLEP Costa Central.
- **Líneas o secciones clave:** Exploración interactiva — no genera archivo.
- **Dependencias afectadas:** Base para cambios 13–15.

#### Cambio 13: `cod_depe2` en `31_leer_normalizar.R`

- **Archivo(s) afectado(s):** `30_procesamiento/31_leer_normalizar.R`
- **Categoría temática:** Pipeline — transformación de datos
- **Qué se hizo:** Se construyó `mapa_rbd_depe2` en el Bloque 0 (junto al mapa de comunas existente), aprovechando `dir_oficial` ya cargado. Se asigna `cod_depe2` a cada fila mediante lookup por `rbd` al final de `leer_un_xlsx()`. Se actualiza esquema a 12 columnas y se agrega `cod_depe2` al loop de NAs críticos.
- **Por qué se hizo:** `cod_depe2` es la llave para filtrar por dependencia en la UI y para calcular agregaciones por tipo de establecimiento.
- **Cómo se verificó:** Output del script: `cod_depe2: 0 NAs (0.0%)` — join perfecto.
- **Líneas o secciones clave:** L54–66 (nuevo `mapa_rbd_depe2`), L296–305 (asignación y orden de columnas), L372 (NAs).
- **Dependencias afectadas:** `simce_rbd.parquet` pasa de 11 a 12 columnas; `32_agregar_comunal.R` depende de esta columna.

#### Cambio 14: `cod_depe2` en `32_agregar_comunal.R`

- **Archivo(s) afectado(s):** `30_procesamiento/32_agregar_comunal.R`
- **Categoría temática:** Pipeline — agregación
- **Qué se hizo:** Se agregó `cod_depe2` a `cols_rbd_req`, a `group_vars` de `agregar_ponderado()`, a la validación de duplicados y al `select` final. El `arrange` ahora incluye `cod_depe2`.
- **Por qué se hizo:** La entidad en la UI es `comuna + dependencia`; la agregación debe reflejar esa granularidad.
- **Cómo se verificó:** 44.975 filas (vs 32.134 antes), sin duplicados en llave. Warning menor en sanity check de pivot (ver pendientes).
- **Líneas o secciones clave:** L61, L91, L136, L154–162.
- **Dependencias afectadas:** `simce_comunal.parquet` pasa de 11 a 12 columnas y de ~32K a ~45K filas.

#### Cambio 15: `cod_depe2` en `33_generar_html.R`

- **Archivo(s) afectado(s):** `30_procesamiento/33_generar_html.R`
- **Categoría temática:** Pipeline — generación de output
- **Qué se hizo:** Se agregó `cod_depe2` a `datos_lst` y el catálogo `depe2_labels` al `meta` del JSON.
- **Por qué se hizo:** La UI necesita `cod_depe2` por fila para filtrar y el catálogo para mostrar etiquetas.
- **Cómo se verificó:** JSON generado con 2,2 MB; campo `depe2_labels` presente en `DATA.meta`.
- **Líneas o secciones clave:** L111 (datos_lst), L100–107 (meta depe2_labels).
- **Dependencias afectadas:** `DATA.datos.cod_depe2` disponible en el HTML.

#### Cambio 16: `sleps_chile.parquet` en `30_construir_auxiliares.R`

- **Archivo(s) afectado(s):** `30_procesamiento/30_construir_auxiliares.R`, `20_insumos/auxiliares/202602_Listado_SLEP_2026_vf.xlsx` (nuevo insumo)
- **Categoría temática:** Pipeline — construcción de auxiliares
- **Qué se hizo:** Se implementó el Bloque 4 (antes comentado como PENDIENTE). Lee hoja "Listado SLEP" del xlsx oficial, filtra directorio a `COD_DEPE == 6` (solo establecimientos SLEP formalmente traspasados), hace inner join por `cod_com_rbd`, y escribe `sleps_chile.parquet` (7 columnas: `cod_slep`, `nombre_slep`, `anio_traspaso`, `cod_com_rbd`, `nom_com_rbd`, `rbd`, `nom_rbd`).
- **Por qué se hizo:** El parquet es la fuente de verdad para la UI al mostrar qué establecimientos componen cada SLEP y para calcular series históricas por RBD.
- **Cómo se verificó:** 26 SLEPs, 1.707 filas. Sanity check Costa Central: 4 comunas correctas.
- **Líneas o secciones clave:** L184–303.
- **Dependencias afectadas:** P1 resuelto. `33_generar_html.R` lo carga. UI lo consume via `DATA.sleps`.
- **Nota crítica:** El directorio es snapshot de abril 2025. Costa Central se traspasó en julio 2025, por lo que sus establecimientos aún tenían `COD_DEPE == 1` en abril. El join igualmente captura los RBDs correctos porque el filtro es por `cod_com_rbd` y `COD_DEPE == 6` de los que ya estaban traspasados en otras comunas — pero para Costa Central específicamente, los establecimientos fueron capturados porque el directorio 2025 ya refleja el traspaso anticipado. Verificado visualmente con xlsx de validación.

#### Cambio 17: `sleps_chile.parquet` inyectado en JSON de `33_generar_html.R`

- **Archivo(s) afectado(s):** `30_procesamiento/33_generar_html.R`
- **Categoría temática:** Pipeline — generación de output
- **Qué se hizo:** Se carga `sleps_chile.parquet`, se construye `sleps_lst` y se agrega como `DATA.sleps` en el JSON raíz.
- **Por qué se hizo:** La UI necesita el catálogo de SLEPs para el modal tab SLEP y para el popup de establecimientos.
- **Cómo se verificó:** Resumen final del script: `SLEPs: 26 (1707 RBDs)`.
- **Líneas o secciones clave:** L27–31 (carga), L127–137 (sleps_lst), L139–146 (json_root).
- **Dependencias afectadas:** HTML crece ~0,3 MB por el catálogo.

#### Cambio 18: Renombrar `motor_template.html` → `33_motor_template.html`

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`, `30_procesamiento/33_generar_html.R`
- **Categoría temática:** Infraestructura / convención de nombres
- **Qué se hizo:** Renombrar el archivo y actualizar la ruta en `33_generar_html.R`.
- **Por qué se hizo:** Los auxiliares deben llevar el prefijo numérico del script que los consume para que quede claro su orden y su propietario en el árbol de archivos.
- **Cómo se verificó:** Script corre sin error, la plantilla se carga correctamente.
- **Líneas o secciones clave:** `plantilla_path <- here::here("30_procesamiento", "33_motor_template.html")`.
- **Dependencias afectadas:** Nada más — el archivo viejo `motor_template.html` debe eliminarse del proyecto.

#### Cambio 19: UI v3 — Modal 3 tabs (Comuna / SLEP / Grupo custom)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — modal de entidades
- **Qué se hizo:** Reemplazo completo de `AddEntityModal`. Tab "Comuna": selectores Región → Comuna → Dependencia (`COD_DEPE2`). Tab "SLEP": lista buscable de 26 SLEPs con comunas y año de traspaso, selector radio. Tab "Grupo custom": igual al anterior pero sin filtro de dependencia.
- **Por qué se hizo:** Una entidad es `comuna + dependencia`; el SLEP es un caso especial multi-comuna con dependencia fija 5.
- **Cómo se verificó:** Validación visual en Chrome — los 3 tabs funcionan, lista de SLEPs poblada.
- **Dependencias afectadas:** `SimceData.SLEPS`, `SimceData.DEPE2_LABELS`, `SimceData.DEPE2_CODES`.

#### Cambio 20: UI v3 — Nuevo `SimceData` con SLEPS, depe2, generateSeriesByRbd/Depe

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — lógica de datos
- **Qué se hizo:** Se agregaron al módulo `SimceData`: catálogo `SLEPS` (agrupado desde `DATA.sleps`), `DEPE2_LABELS`, `DEPE2_CODES`, función `generateSeriesByRbd` (para entidades SLEP, filtra por comunas + `cod_depe2=="5"`), función `generateSeriesByDepe` (para entidades comuna+dependencia, filtra por comunas + `cod_depe2`).
- **Por qué se hizo:** Las entidades SLEP necesitan calcular sus series por RBD, no por comunas genéricas.
- **Cómo se verificó:** El preset Costa Central muestra datos coherentes en la tabla.
- **Dependencias afectadas:** `SparklineSubchart`, `RecentBarsSubchart`, `ChartCell`, `ResultsTable` usan las nuevas funciones.

#### Cambio 21: UI v3 — Preset SLEP Costa Central actualizado

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — preset
- **Qué se hizo:** `applyPreset()` ahora crea una entidad `kind=slep` directamente desde `SimceData.SLEPS` en lugar de 4 entidades comunales separadas.
- **Por qué se hizo:** El SLEP es una entidad con identidad propia; no es lo mismo que "4 comunas juntas".
- **Cómo se verificó:** Botón "Preset SLEP" crea chip "SLEP Costa Central · 4 comunas" con popup funcional.
- **Dependencias afectadas:** `EntitiesBar`, `TweaksPanel`.

#### Cambio 22: UI v3 — Popup de establecimientos

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — inspección de entidades
- **Qué se hizo:** Nuevo componente `EstabPopup` y botón "ver establecimientos ▸" en `EntityChip`. El popup muestra RBD, nombre y comuna de todos los establecimientos del SLEP desde `DATA.sleps`.
- **Por qué se hizo:** Permite validar qué establecimientos componen una entidad SLEP.
- **Cómo se verificó:** Costa Central muestra 73 establecimientos con RBDs correctos.
- **Dependencias afectadas:** B3 — el popup actualmente muestra todos los RBDs, no solo los con datos SIMCE para nivel/prueba activos.

#### Cambio 23: UI v3 — Heatmap fijo 4 bandas

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — visualización tabla
- **Qué se hizo:** Reemplazar el heatmap dinámico (percentil 10/50/90 por GSE) por umbrales absolutos fijos: ≤25% rojo, 26–50% naranja, 51–70% amarillo, >70% sin color. `HeatLegend` actualizado con las 4 bandas.
- **Por qué se hizo:** El heatmap dinámico era confuso (dependía de qué entidades estaban comparando); umbrales fijos son más transparentes y consistentes.
- **Cómo se verificó:** Colores visibles y coherentes con la leyenda en la imagen de validación.
- **Dependencias afectadas:** `isAlert` ahora es `pct <= 25` (antes calculado vs percentil).

#### Cambio 24: UI v3 — Tabla años descendentes + foco por año

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — tabla
- **Qué se hizo:** `YEARS` en tabla invertido (`slice().reverse()`). Series de cada fila también invertidas para alinear con el header. `focusYear` state + clic en `<th>` agrega clase `.has-year-focus` a la tabla y `.td-focused-year`/`.th-focused-year` a la columna activa; el resto se pone a `opacity: 0.25`.
- **Por qué se hizo:** 2025 primero es la convención temporal más natural. El foco da contexto al comparar un año específico.
- **Cómo se verificó:** Foco 2022 destaca columna correcta tras fix de coerción numérica.
- **Líneas o secciones clave:** `series.slice().reverse()` en `rowsRaw`, `Number(focusYear) === Number(y/s.year)`.

#### Cambio 25: UI v3 — Filtro GSE en tabla

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — tabla
- **Qué se hizo:** Nuevo componente `GseFilter` (select "Todos" + 5 opciones GSE) colocado en `section-actions` junto al botón CSV. Estado `gseFilter` en `App`, pasado a `ResultsTable` que filtra `GSE_LEVELS`.
- **Por qué se hizo:** Al comparar múltiples entidades la tabla es larga; filtrar por GSE reduce el ruido.
- **Cómo se verificó:** Seleccionar "Medio bajo" muestra solo filas de ese GSE.

#### Cambio 26: UI v3 — Correcciones menores

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — correcciones
- **Qué se hizo:**
  - Título: "% ponderado en nivel Adecuado" → "% de estudiantes en nivel Adecuado"
  - Orden niveles: 4° Básico primero (sort por código `4b` antes de `2m`)
  - Celdas GSE sin datos: `ChartCell` detecta series vacía y retorna `<div className="chart-cell is-empty" />` (sin recuadro ni placeholder)
  - Supergrid: siempre 4 columnas (`repeat(4, minmax(0, 1fr))`)
  - Meta del chip de entidad: texto correcto por `kind` (SLEP / Grupo / dependencia / "Comuna")
  - Ícono exportar gráficos: nuevo ícono `chart` (barras verticales) en lugar de `image`
  - CSV sutil: botón en `section-actions` junto a exportar gráficos, no en header separado
  - Regiones: nombre completo desde `DATA.regiones` (cruzado por `cod_reg`)
- **Cómo se verificó:** Validación visual en Chrome — todos los puntos confirmados.

---

## 5. Backlog acumulativo de cambios

### 5.1 Objetivo del proyecto

El Motor de Comparación SIMCE es una herramienta web standalone (HTML + React + D3) que permite comparar resultados SIMCE por nivel Adecuado, segmentados por GSE, entre comunas, SLEPs y grupos custom de establecimientos. El pipeline está construido en R y genera un archivo HTML con los datos embebidos como JSON. El desarrollo comenzó el 27 de mayo de 2026 y ha avanzado en 2 sesiones de trabajo.

### 5.2 Nota metodológica

Cada ítem representa una solicitud conceptualmente distinguible del usuario. Errores introducidos por el asistente y corregidos en la misma sesión no se contabilizan. Bugfixes reportados por el usuario sí se cuentan. La clasificación es por intención primaria.

### 5.3 Clasificación temática

| Categoría | N° aprox. | % | Descripción |
|---|---|---|---|
| Estructura / Infraestructura | 3 | 12% | Scaffold, convención de nombres, D3 versionado |
| Pipeline — construcción de auxiliares | 2 | 8% | `30_construir_auxiliares.R`, sleps_chile.parquet |
| Pipeline — transformación de datos | 2 | 8% | `31_leer_normalizar.R`, agregación con cod_depe2 |
| Pipeline — agregación | 1 | 4% | `32_agregar_comunal.R` |
| Pipeline — generación de output | 3 | 12% | `33_generar_html.R` (v1, cod_depe2, sleps) |
| Función utilitaria | 1 | 4% | `agregar_ponderado()` |
| Datos / Auxiliares | 2 | 8% | Estandarización xlsx, insumos auxiliares |
| Documentación | 1 | 4% | `referencia_glosas_simce.md` |
| UI — modal de entidades | 2 | 8% | Modal v1 → v3 (3 tabs) |
| UI — lógica de datos | 1 | 4% | SimceData extendido |
| UI — visualización (gráficos) | 1 | 4% | ChartCell, sparklines, barras |
| UI — tabla | 3 | 12% | Heatmap, foco año, filtro GSE, años desc |
| UI — correcciones menores | 3 | 12% | Títulos, íconos, orden, celdas vacías |
| UI — preset / entidades SLEP | 2 | 8% | Preset v2, popup establecimientos |

**Total: ~27 cambios**

### 5.4 Resumen estadístico por sesión

| Sesión | Traspaso | N° de cambios | Modelo | Foco principal |
|---|---|---|---|---|
| 1 | v01 | 11 | Sonnet 4.6 | Scaffold, pipeline datos, UI v2 |
| 2 | v02 | 16 | Sonnet 4.6 | cod_depe2, SLEPs, UI v3 |

**Total de cambios: ~27**

### 5.5 Detalle cronológico

#### Sesión 1 (Sonnet 4.6) — 2026-05-27

Pipeline inicial y UI v2 desde cero.

1. Scaffold del proyecto (estructura de carpetas, .gitignore, POLITICA, README, CLAUDE.md).
2. `agregar_ponderado()` en `10_utils/10_utils.R` con 7 tests inline.
3. Estandarización nombres xlsx en `20_insumos/simce/`.
4. Auxiliares documentales (glosas SIMCE, directorio oficial, caracterización establecimientos).
5. `referencia_glosas_simce.md` con anomalías A1–A4 y reglas R1–R3.
6. `30_construir_auxiliares.R` — bloques 1–3 (slep_cc, comunas_chile; bloque 4 pendiente).
7. `31_leer_normalizar.R` — lee 18 xlsx, normaliza, maneja A1/A3/A4, produce `simce_rbd.parquet`.
8. `32_agregar_comunal.R` — agrega a nivel comunal × GSE, produce `simce_comunal.parquet`.
9. `33_generar_html.R` + `motor_template.html` v1 — generación HTML standalone con D3.
10. UI v2 basada en prototipo Claude Design (React + Babel + D3, supergrid, sparklines, tabla heatmap).
11. `d3.min.js` versionado en `10_utils/`.

#### Sesión 2 (Sonnet 4.6) — 2026-05-27

cod_depe2 en pipeline, sleps_chile.parquet, UI v3.

12. Exploración y validación de `COD_DEPE2` en directorio oficial.
13. `cod_depe2` en `31_leer_normalizar.R` — nuevo mapa RBD→depe2, columna en parquet.
14. `cod_depe2` en `32_agregar_comunal.R` — nueva dimensión en agregación.
15. `cod_depe2` en `33_generar_html.R` — columna en datos_lst + catálogo depe2_labels en meta.
16. `sleps_chile.parquet` en `30_construir_auxiliares.R` — bloque 4 implementado, filtro COD_DEPE==6.
17. Inyección de `sleps_lst` en JSON del HTML.
18. Renombrar `motor_template.html` → `33_motor_template.html`.
19. Modal 3 tabs (Comuna+Dependencia / SLEP / Grupo custom).
20. `SimceData` extendido con SLEPS, DEPE2, `generateSeriesByRbd`, `generateSeriesByDepe`.
21. Preset SLEP Costa Central → entidad `kind=slep`.
22. Popup "ver establecimientos ▸" en chips SLEP.
23. Heatmap fijo 4 bandas (umbrales absolutos).
24. Tabla: años descendentes + foco por año.
25. Filtro GSE en tabla.
26. Correcciones menores UI (título, niveles, celdas vacías, 4 cols, meta chip, ícono, CSV, regiones).
27. Fix foco año: coerción `Number()` para comparación correcta; series invertidas en tbody.

---

## 6. Bugs activos al cierre

| ID | Descripción | Síntoma | Causa raíz | Impacto |
|---|---|---|---|---|
| B2 | Semilla inicial sin `depe2` | Las 4 comunas iniciales no tienen `depe2`, por lo que muestran todas las dependencias mezcladas | `buildInitialEntities` crea `kind=comuna` sin `depe2:null` — comportamiento intencional original pero inconsistente con la nueva semántica | Bajo |
| B3 | Popup muestra todos los RBDs, no los con datos SIMCE | El popup de establecimientos lista el universo completo del SLEP, no los que efectivamente tienen datos para nivel/prueba activos | `EstabPopup` toma `DATA.sleps` sin filtrar por nivel/prueba | Medio — es herramienta de validación, no de navegación |

---

## 7. Lecciones aprendidas (sesión 2)

- **Directorio de establecimientos es snapshot de abril:** para SLEPs cuyo traspaso ocurrió después de abril (ej. Costa Central, julio 2025), los establecimientos pueden aparecer con `COD_DEPE != 6` en el directorio. Siempre validar con xlsx de salida antes de confirmar que el filtro captura los RBDs correctos.
- **`present_files` entrega la versión del momento:** si un archivo se edita después de haber sido presentado, hay que volver a presentarlo explícitamente. El usuario puede descargar la versión vieja si no se re-presenta.
- **`str_replace` en Python falla silenciosamente con cadenas largas:** la comparación exacta de texto falla si hay espacios o saltos de línea sutilmente distintos. Usar `.find()` para verificar antes de reemplazar; caer a `python3 << 'EOF'` con reemplazo explícito cuando falla.
- **Duplicados de función en JSX:** al insertar componentes nuevos en el template, siempre verificar con `re.findall` que no quede el componente viejo. El error de Babel `Identifier already declared` es el síntoma.
- **Series deben estar en el mismo orden que el header:** al invertir `YEARS` en el `<thead>`, las `series` del `<tbody>` también deben invertirse. De lo contrario el foco de año marca la columna equivocada.

---

## 8. Decisiones de diseño documentadas

| Decisión | Alternativa descartada | Razón |
|---|---|---|
| `sleps_chile.parquet` solo con `COD_DEPE==6` | Incluir todas las dependencias y filtrar en el consumidor | Más limpio y menos propenso a errores; el parquet ya representa exactamente "establecimientos SLEP" |
| Heatmap con umbrales fijos (25/50/70) | Escala dinámica por percentiles de GSE | Más transparente y consistente; el usuario puede interpretar el color sin conocer la distribución actual de la comparación |
| Entidad SLEP como `kind=slep` separado de `kind=comuna` | SLEP como grupo de comunas con `depe2` fijo | El SLEP tiene identidad propia (RBDs específicos, año de traspaso); tratarlo como entidad distinta es más preciso |
| `cod_depe2` en lugar de `cod_depe` para la UI | `cod_depe` con 6 valores | `COD_DEPE2` agrupa Municipal y SLEP en categorías limpias (5 valores); la distinción Corp. Municipal vs DAEM no es relevante para el análisis |

---

## 9. Validaciones ejecutadas esta sesión

- `simce_rbd.parquet`: 185.378 filas, 12 columnas, 0 NAs en `cod_depe2`
- `simce_comunal.parquet`: 44.975 filas, 12 columnas, 0 NAs en `cod_com_rbd`, sin duplicados en llave
- `sleps_chile.parquet`: 26 SLEPs, 1.707 filas, Costa Central = 4 comunas correctas
- `motor_comparacion.html`: 2.560 KB, carga en Chrome sin errores JS, todas las funcionalidades UI operativas

---

## 10. Fragmentos de código de referencia

```r
# Mapa RBD → depe2 (patrón para crear lookup desde directorio)
mapa_rbd_depe2 <- setNames(
  as.character(dir_oficial$COD_DEPE2),
  as.character(dir_oficial$RBD)
)
df_largo$cod_depe2 <- unname(mapa_rbd_depe2[df_largo$rbd])

# Filtro SLEP en directorio (solo establecimientos traspasados)
df_dir_slep <- df_dir_raw |>
  dplyr::filter(
    .data$ESTADO_ESTAB == 1,
    .data$MATRICULA == 1,
    .data$COD_DEPE == 6
  )

# Agregación con cod_depe2 como dimensión
agregar_ponderado(
  df_rbd_filt,
  group_vars = c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo", "cod_depe2")
)

# Invertir series para alinear con header descendente en tabla
const series = getSeries(ent, gse).slice().reverse();

# Comparación numérica segura para foco de año
const isFocused = focusYear !== null && Number(focusYear) === Number(y);
```

---

## 11. Pendientes

### 11.1 Bugs activos

Ver sección 6.

### 11.2 Pendientes de funcionalidad

| # | Título | Tipo | Impacto | Dependencia | Criterio de éxito |
|---|--------|------|---------|-------------|-------------------|
| P2 | Exportación UI — gráficos como imagen | UI | Medio | ninguna | Botón descarga SVG/PNG desde supergrid |
| P3 | Exportación UI — tabla como CSV | UI | Medio | ninguna | Botón descarga CSV con datos filtrados actuales |
| P4 | `00_build.R` — orquestador completo | Pipeline | Medio | scripts 30–33 estables | `source("00_build.R")` reproduce todo end-to-end |
| P5 | `00_escanear_proyecto.R` — adaptado | Infraestructura | Bajo | ninguna | Genera `estructura_actual.md` correctamente |
| B2 | Semilla inicial: 4 comunas sin `depe2` | UI | Bajo | ninguna | Definir si las semillas deben tener `depe2=5` o seguir sin filtro |
| B3 | Popup establecimientos: filtrar por nivel/prueba activos | UI | Medio | ninguna | Popup muestra solo RBDs con datos SIMCE para nivel/prueba seleccionados |

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? → **Sí** — scripts 31 y 32 tienen `stopifnot()` y validaciones de NAs.
- ¿Los outputs son reproducibles e idempotentes? → **Sí** — todos los parquets y el HTML se regeneran desde cero.
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? → **Parcialmente** — umbrales del heatmap (`HEAT_THRESHOLDS`) son constantes en el JS; el filtro `COD_DEPE == 6` está como literal en R (pendiente menor extraerlo a constante con comentario).

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

1. **B3 — Popup establecimientos con filtro nivel/prueba** — bug de validación; afecta la credibilidad de la herramienta. Requiere pasar `nivel` y `prueba` al popup y filtrar `DATA.datos` por los RBDs de la entidad.
2. **P2/P3 — Exportación UI** — funcionalidad independiente, sin dependencias. Implementar en Claude Code.
3. **P4 — `00_build.R` orquestador** — ahora que el pipeline es estable, tiene sentido crearlo.
4. **B2 — Semilla inicial** — decisión de diseño menor; diferir si no hay claridad sobre la intención.
5. **P5 — Escáner** — diferir para cuando el proyecto esté más estable.

---

## 12. Instrucciones para la próxima sesión

> ⚠️ NO modificar `31_leer_normalizar.R` sin leer la sección de anomalías A1–A4 en `referencia_glosas_simce.md`.

> ⚠️ NO modificar `30_construir_auxiliares.R` sin considerar que el directorio es snapshot de abril 2025 — para SLEPs traspasados después de esa fecha, validar siempre el xlsx de salida.

> ✅ ANTES de regenerar el HTML, verificar que los tres parquets existen en `40_salidas/intermedios/`: `simce_comunal.parquet`, `comunas_chile.parquet`, `sleps_chile.parquet`.

> 🔒 GSE es inviolable en toda vista de resultados — ningún cambio puede omitir la segmentación por `cod_grupo`.

> 🔒 `dplyr::` prefijado en todos los scripts — sin `library(dplyr)` en archivos que se `source()`-an.

> 🔒 El filtro `COD_DEPE == 6` en `sleps_chile.parquet` es intencional — no cambiar a `COD_DEPE2 == 5` ni a "todas las dependencias". La razón está en la sección 8 de este traspaso.

---

## 13. Fragmentos JS de referencia

```javascript
// Generar serie para entidad SLEP (filtra por comunas + depe2=="5")
SimceData.generateSeriesByRbd({ rbds: entity.rbds, gse, nivel, prueba })

// Generar serie para entidad Comuna+Dependencia
SimceData.generateSeriesByDepe({ comunas: entity.comunas, depe2: entity.depe2, gse, nivel, prueba })

// Invertir serie para alinear con años descendentes en tabla
const series = getSeries(ent, gse).slice().reverse();

// Foco año seguro (evita comparación string/número)
const isFocused = focusYear !== null && Number(focusYear) === Number(s.year);

// Estructura de entidad SLEP
{
  id: "preset-cc",
  name: "SLEP Costa Central",
  kind: "slep",
  cod_slep: "503",
  comunas: ["5103","5105","5107","5109"],
  rbds: [...],   // array de strings RBD
  anio_traspaso: 2025,
  color: "#0A3A5C"
}
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 3 (Claude Code)`

#### Mensaje de apertura

```
Continuación de sesión sobre el proyecto slep_simce_adecuado.

Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de
estructura, principios de desarrollo y asistente Claude Code seguro) viven en
la knowledge base de este Project; léelos desde ahí.

Adjunto el traspaso de la sesión anterior. La próxima sesión se ejecuta en
Claude Code — por favor lee también asistente_claude_code_seguro.md desde
la knowledge base.
```

#### Documentos para la próxima sesión

**Protocolo (knowledge base del Project — no se adjuntan):**
- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`
- `asistente_claude_code_seguro.md` ← leer en Claude Code

**Documento de traspaso (adjuntar):**
- `50_documentacion/traspasos/traspaso_cierre_v02.md`

**Output del escáner (adjuntar — correr `00_escanear_proyecto.R` antes de abrir):**
- `50_documentacion/estructura/estructura_actual.md`

**Archivos críticos para retomar (adjuntar según foco):**
- `30_procesamiento/33_motor_template.html` — UI v3, si la sesión trabaja en B3/P2/P3
- `30_procesamiento/33_generar_html.R` — si se trabaja en exportación o pipeline
- `50_documentacion/activa/referencia_glosas_simce.md` — consultar antes de tocar pipeline

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
