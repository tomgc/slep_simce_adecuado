# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v01
- **Fecha:** 2026-05-27
- **Sesión:** 1 — Scaffold completo del proyecto, pipeline de datos (scripts 30–32), UI v2 basada en prototipo Claude Design.
- **Modelo utilizado:** Claude Sonnet 4.6
- **Entorno:** R (Positron) + HTML/React/D3
- **Archivos principales modificados:**
  - `10_utils/10_utils.R`
  - `10_utils/d3.min.js`
  - `20_insumos/auxiliares/` (múltiples archivos)
  - `30_procesamiento/30_construir_auxiliares.R`
  - `30_procesamiento/31_leer_normalizar.R`
  - `30_procesamiento/32_agregar_comunal.R`
  - `30_procesamiento/33_generar_html.R`
  - `30_procesamiento/motor_template.html`
  - `50_documentacion/activa/referencia_glosas_simce.md`
  - `CLAUDE.md`

---

## 2. Resumen ejecutivo

Esta sesión inauguró el proyecto `slep_simce_adecuado` desde cero: se creó el
repositorio en GitHub, se construyó el scaffold completo de directorios, se
implementaron todos los scripts del pipeline de datos (lectura, normalización,
construcción de auxiliares y agregación comunal), y se produjo el motor de
comparación como HTML standalone. Los datos cubren 9 años (2014–2025), 2
niveles (4B y 2M) y 2 pruebas (Lectura y Matemática), con 185.378 filas brutas
normalizadas a 32.134 agregaciones comunales × GSE.

Se detectaron y resolvieron 4 anomalías en los datos crudos de la Agencia
(A1–A4), documentadas en `referencia_glosas_simce.md`. El frontend fue
rediseñado completamente en una segunda iteración usando el prototipo de Claude
Design como base, resultando en una UI con React + D3.js con supergrid entidades
× GSE, sparklines históricas, barras de últimas 3 aplicaciones y tabla con heat
map.

Queda pendiente el auxiliar `sleps_chile.parquet` (bloque 4 de
`30_construir_auxiliares.R`) por falta de fuente de datos SLEP→comunas, y la
funcionalidad de exportación desde la UI.

---

## 3. Estado del proyecto al cierre

### Qué funciona

- Pipeline completo ejecutable desde Positron:
  `30_construir_auxiliares.R` → `31_leer_normalizar.R` → `32_agregar_comunal.R`
  → `33_generar_html.R`
- `simce_rbd.parquet`: 185.378 filas, 9 años, 2 niveles, 2 pruebas, con
  anomalías A1–A4 corregidas.
- `simce_comunal.parquet`: 32.134 filas, cobertura uniforme todos los años,
  0 NAs en `cod_com_rbd`.
- `slep_cc_establecimientos.parquet`: 73 establecimientos, columna `rinde_simce`
  correcta.
- `comunas_chile.parquet`: 345 comunas únicas, 16 regiones.
- `motor_comparacion.html` (1.5 MB standalone): UI v2 validada en navegador —
  header, 4 seeds, supergrid 4×5, sparklines, barras, tabla heat map, notas
  metodológicas colapsables.
- Repositorio GitHub sincronizado: 11 commits, 100% reproducible.

### Qué no funciona / pendiente

- `sleps_chile.parquet`: bloque 4 de `30_construir_auxiliares.R` comentado,
  esperando fuente SLEP→comunas.
- Exportación desde UI (gráficos como imagen, tabla como CSV): no implementada.
- Funcionalidad "Preset SLEP" en UI: usa datos mock del prototipo, no conecta
  a `sleps_chile.parquet` real.

### Qué cambió respecto al traspaso anterior

No hay traspaso anterior — esta es la sesión inaugural (v01).

---

## 4. Registro detallado de cambios realizados

### Cambio 1: Scaffold del proyecto

- **Archivo(s):** estructura completa de directorios, `.gitignore`,
  `POLITICA_PROYECTO.md`, `README.md`, `CLAUDE.md`, stubs de scripts.
- **Qué se hizo:** creación del repo GitHub `slep_simce_adecuado`, scaffold de
  17 archivos con la estructura canónica
  `10_utils/20_insumos/30_procesamiento/40_salidas/50_documentacion/`.
- **Por qué:** proyecto nuevo sin base preexistente.
- **Verificado:** `git log` confirmó commit `f07c4d9`.

### Cambio 2: `agregar_ponderado()` en `10_utils/10_utils.R`

- **Archivo(s):** `10_utils/10_utils.R`
- **Qué se hizo:** función pura con firma `agregar_ponderado(df, group_vars)`,
  7 tests inline con `stopifnot()`, `dplyr::` prefijado, sin `library()`.
- **Por qué:** fórmula central del proyecto — promedio ponderado por `nalu`
  del % en nivel Adecuado.
- **Verificado:** 7/7 tests pasaron con `Rscript`.

### Cambio 3: Estandarización de nombres xlsx

- **Archivo(s):** `20_insumos/simce/2m/*.xlsx`, `20_insumos/simce/4b/*.xlsx`
- **Qué se hizo:** 14 renombres para uniformar patrón
  `simce<nivel><anio>_rbd_<estado>.xlsx`; manifiesto versionado en
  `50_documentacion/estructura/manifiesto_insumos.md`.
- **Por qué:** nombres heterogéneos (mayúsculas, tildes, `"publica_"` vs
  `"público_"`) impedían glob confiable.

### Cambio 4: Auxiliares documentales

- **Archivo(s):** `20_insumos/auxiliares/` — 6 archivos agregados.
- **Qué se hizo:** `glosas_simce_consolidado_simce.xlsx`, 2 CSV preprocesados
  de glosas, `caracterizacion_establecimientos.xlsx`,
  `glosas_directorio_oficial_ee.pdf`, `directorio_oficial_ee.csv`
  (versionado, 3.6 MB).
- **Por qué:** fuentes de verdad para pipeline y documentación metodológica.

### Cambio 5: `referencia_glosas_simce.md`

- **Archivo(s):** `50_documentacion/activa/referencia_glosas_simce.md`
- **Qué se hizo:** tabla comparativa de disponibilidad de variables por año,
  reglas de negocio R1–R3, anomalías A1–A4 documentadas con causa raíz y
  solución.
- **Por qué:** única referencia metodológica del proyecto para el pipeline.

### Cambio 6: `30_construir_auxiliares.R`

- **Archivo(s):** `30_procesamiento/30_construir_auxiliares.R`
- **Qué se hizo:** 3 parquets generados — `slep_cc_establecimientos.parquet`
  (73 filas, con `rinde_simce`), `comunas_chile.parquet` (345 comunas), bloque
  4 `sleps_chile.parquet` comentado.
- **Verificado:** conteos correctos, 5 RBDs no-SIMCE con `rinde_simce=FALSE`.

### Cambio 7: `31_leer_normalizar.R`

- **Archivo(s):** `30_procesamiento/31_leer_normalizar.R`
- **Qué se hizo:** lee 18 xlsx por glob, normaliza columnas, aplica filtros,
  maneja anomalías A1 (sufijo `2m` en 2018/4b), A3 (`cod_com_rbd` corrupto en
  3 archivos — join con directorio), A4 (pre-Ñuble 8401–8421 → 16101–16207),
  normaliza `cod_grupo` literales → códigos (2014–2017).
- **Verificado:** 185.378 filas, cobertura uniforme post-fixes.

### Cambio 8: `32_agregar_comunal.R`

- **Archivo(s):** `30_procesamiento/32_agregar_comunal.R`
- **Qué se hizo:** agrega `simce_rbd.parquet` a nivel `comuna × GSE × prueba ×
  año` con `agregar_ponderado()`, excluye `cod_grupo` NA, incluye región (join
  con `comunas_chile.parquet`), produce `simce_comunal.parquet`.
- **Verificado:** 32.134 filas, 0 NAs en `cod_com_rbd`, 16 regiones con
  conteos coherentes.

### Cambio 9: `33_generar_html.R` + `motor_template.html` v1

- **Archivo(s):** `30_procesamiento/33_generar_html.R`,
  `30_procesamiento/motor_template.html`
- **Qué se hizo:** script R que inyecta D3 inline y JSON en plantilla HTML;
  v1 con vanilla JS + D3.
- **Bugs corregidos:** encoding de literales R (`intToUtf8()`),
  `anios_preliminar` serializado como array con `I()`.

### Cambio 10: UI v2 basada en prototipo Claude Design

- **Archivo(s):** `30_procesamiento/motor_template.html` (reemplazo completo),
  `30_procesamiento/33_generar_html.R` (nueva estructura JSON),
  `20_insumos/auxiliares/prototipo_design/` (9 archivos).
- **Qué se hizo:** rediseño completo con React + Babel CDN + D3 inline.
  Supergrid entidades × GSE, sparklines + barras por celda, tabla con heat map
  diverging por columna GSE, TweaksPanel flotante, sistema de diseño SLEP con
  variables CSS.
- **Verificado:** validado en navegador — header, seeds, gráficos y tabla
  funcionando.

### Cambio 11: `d3.min.js` versionado

- **Archivo(s):** `10_utils/d3.min.js`
- **Qué se hizo:** D3.js v7.9.0 minificado (273 KB) versionado en el repo.
- **Por qué:** garantiza reproducibilidad offline del build.

---

## 5. Backlog acumulativo de cambios

| # | Tipo | Descripción breve |
|---|------|-------------------|
| 1 | Estructura | Scaffold proyecto |
| 2 | Función | `agregar_ponderado()` |
| 3 | Datos | Estandarización nombres xlsx |
| 4 | Datos | Auxiliares documentales |
| 5 | Documentación | `referencia_glosas_simce.md` |
| 6 | Script | `30_construir_auxiliares.R` |
| 7 | Script | `31_leer_normalizar.R` |
| 8 | Script | `32_agregar_comunal.R` |
| 9 | Script | `33_generar_html.R` + template v1 |
| 10 | UI | Motor template v2 (Claude Design) |
| 11 | Infraestructura | `d3.min.js` versionado |

**Totales:** 11 cambios — 4 scripts de datos, 1 función utils, 2 UI/template,
2 datos/auxiliares, 1 documentación, 1 infraestructura.

---

## 6. Anomalías de datos documentadas

Todas documentadas en `50_documentacion/activa/referencia_glosas_simce.md`:

| ID | Archivo afectado | Problema | Solución |
|----|-----------------|----------|----------|
| A1 | `simce2018_4b_rbd` | Columnas `nalu`/`palu` con sufijo `2m` en lugar de `4b` | Normalización en `31_leer_normalizar.R` |
| A2 | 2014 solamente | `marca_eda_*` existe solo en 2014 | Decisión: usar marca genérica en todos los años |
| A3 | `simce2m2015`, `simce4b2015`, `simce4b2017` | `cod_com_rbd` corrupto (códigos 1–2 dígitos) | Join con `directorio_oficial_ee.csv` por RBD |
| A4 | 2014, 2016, 2017 | Comunas Ñuble con códigos pre-creación región (8401–8421) | Mapping explícito → códigos 2025 (16101–16207) |

---

## 7. Decisiones técnicas clave

- **JSON embebido vs externo:** JSON embebido en HTML para portabilidad total.
  Durante desarrollo los archivos están separados; `33_generar_html.R` los
  fusiona.
- **React + Babel CDN:** la UI requiere internet para cargar React/Babel la
  primera vez. D3 y datos son inline (offline tras primera carga).
- **Parquet como formato de almacenamiento:** todos los intermedios en parquet.
  El HTML consume JSON generado por R desde parquet.
- **GSE siempre presente:** regla inviolable — ninguna vista omite segmentación
  por GSE.
- **`cod_grupo` NA excluido de agregación:** establecimientos sin clasificación
  GSE no participan en cálculos.
- **Región retroaplicada (A4):** comunas de Ñuble aparecen bajo Región 16 en
  todos los años históricos — coherencia geográfica actual sobre precisión
  histórica administrativa.
- **`dplyr::` prefijado en todos los scripts:** sin `library()` en archivos de
  funciones y scripts de procesamiento.
- **`intToUtf8()` para literales con caracteres especiales:** único patrón
  confiable en locale C de Rscript.

---

## 8. Estructura del JSON embebido

```json
{
  "meta": {
    "anios": [2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025],
    "anios_sin_simce": [2019, 2020, 2021],
    "anios_preliminar": [2025],
    "gse": ["1", "2", "3", "4", "5"],
    "gse_labels": {
      "1": "Bajo", "2": "Medio bajo", "3": "Medio",
      "4": "Medio alto", "5": "Alto"
    },
    "niveles": {"2m": "2° Medio", "4b": "4° Básico"},
    "pruebas": {"lect": "Lectura", "mate": "Matemática"}
  },
  "comunas": [{"cod": "...", "nom": "...", "cod_reg": "...", "nom_reg": "..."}, ...],
  "datos": {
    "cod_com": [...], "nivel": [...], "prueba": [...],
    "cod_grupo": [...], "anio": [...], "pct": [...],
    "n_evaluados": [...], "n_estab": [...]
  }
}
```

**Seeds:** Concón = `5103`, Puchuncaví = `5105`, Quintero = `5107`,
Viña del Mar = `5109`.

---

## 9. Historial de commits

```
40d15d4 Actualizar CLAUDE.md con estado post-v2
e5c2166 Versionar D3.js v7.9.0 minificado en 10_utils/
654a354 Rediseño completo UI v2 basado en prototipo Claude Design
7c8e4fe Implementar 32_agregar_comunal.R y manejar anomalía A4 (pre-Ñuble)
2bfedcc Corregir cod_com_rbd anómalo en 2015 y 2017/4b (Anomalía A3)
7fffd58 Implementar 31_leer_normalizar.R
726a15e Implementar 30_construir_auxiliares.R
61c3b9b Agregar insumos auxiliares y documentación de referencia SIMCE
216b439 Estandarizar nombres de archivos xlsx de insumo
b949a20 Implementar agregar_ponderado() con tests inline
53da34b Excluir .claude/ del versionado
f07c4d9 Scaffold inicial del proyecto
```

---

## 10. Lecciones aprendidas

- **locale C de Rscript rompe literales con ñ/tildes:** usar `intToUtf8()` para
  construir strings con caracteres especiales. Renombrar columnas por posición
  en vez de comparar nombres con caracteres especiales.
- **`jsonlite` + `auto_unbox` serializa escalares sin array:** cualquier campo
  que el JS consuma con `.includes()` debe forzarse como array con `I()`.
- **Bases de la Agencia tienen anomalías históricas predecibles:** `cod_com_rbd`
  corrupto en años pre-2018, GSE como literales en 2014–2017, sufijo equivocado
  en un archivo. Siempre validar esquema al leer.
- **`directorio_oficial_ee.csv` como ancla:** el join por RBD con el directorio
  2025 resuelve múltiples problemas de codificación histórica. Vale la pena
  versionarlo (3.6 MB aceptable).

---

## 11. Pendientes

### 11.1 Bugs activos

Ninguno conocido al cierre.

### 11.2 Pendientes de funcionalidad

| # | Título | Tipo | Impacto | Dependencia | Criterio de éxito |
|---|--------|------|---------|-------------|-------------------|
| P1 | `sleps_chile.parquet` — bloque 4 | Datos | Alto | Fuente SLEP→comunas externa | Parquet generado, selector SLEP funcional en UI |
| P2 | Exportación UI — gráficos como imagen | UI | Medio | ninguna | Botón descarga SVG/PNG desde supergrid |
| P3 | Exportación UI — tabla como CSV | UI | Medio | ninguna | Botón descarga CSV con datos filtrados actuales |
| P4 | `00_build.R` — orquestador completo | Pipeline | Medio | scripts 30–33 estables | `source("00_build.R")` reproduce todo el pipeline end-to-end |
| P5 | `00_escanear_proyecto.R` — adaptado al proyecto | Infraestructura | Bajo | ninguna | Genera `estructura_actual.md` correctamente |

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? → **Sí** —
  scripts 31 y 32 tienen `message()` de progreso y validaciones con
  `stopifnot()` en `agregar_ponderado()`.
- ¿Los outputs son reproducibles e idempotentes? → **Sí** — todos los parquets
  se regeneran desde cero en cada ejecución; el HTML ídem.
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? →
  **Parcialmente** — las reglas R1–R3 están en `referencia_glosas_simce.md`
  pero no como constantes R en el código. Pendiente menor: agregar comentarios
  explícitos en los scripts donde se aplican.

### 11.4 Ruta sugerida para la próxima sesión

1. **P1 — `sleps_chile.parquet`** — bloqueante para la funcionalidad de grupos
   custom real. Requiere que Tomás provea la fuente (CSV o tabla manual). Una
   vez disponible, completar bloque 4 comentado en `30_construir_auxiliares.R`.
2. **P4 — `00_build.R` orquestador** — permite correr todo el pipeline en un
   solo `source()`. Depende de que P1 esté resuelto o al menos que el bloque 4
   sea opcional.
3. **P2/P3 — Exportación UI** — funcionalidad independiente del pipeline, puede
   hacerse en paralelo.
4. **P5 — escáner** — diferir para cuando el proyecto esté más estable.

---

## 12. Instrucciones para la próxima sesión

> ⚠️ NO modificar `31_leer_normalizar.R` sin leer la sección de anomalías
> A1–A4 en `referencia_glosas_simce.md` — los fixes son frágiles y dependen de
> orden de aplicación.

> ✅ ANTES de regenerar el HTML, verificar que `simce_comunal.parquet` existe
> en `40_salidas/intermedios/`.

> 🔒 GSE es inviolable en toda vista de resultados — ningún cambio de UI puede
> omitir la segmentación por `cod_grupo`.

> 🔒 `dplyr::` prefijado en todos los scripts — sin `library(dplyr)` en
> archivos que se `source()`-an.

---

## 13. Fragmentos de código de referencia

```r
# Agregación ponderada canónica
df |>
  agregar_ponderado(
    group_vars = c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo")
  )

# Literales con caracteres especiales en locale C
deg     <- intToUtf8(176L)   # °
a_acute <- intToUtf8(225L)   # á
nivel_labels <- c(
  "2m" = paste0("2", deg, " Medio"),
  "4b" = paste0("4", deg, " B", a_acute, "sico")
)

# Forzar array en JSON (evitar escalar con auto_unbox)
anios_preliminar = I(c(2025L))

# Leer parquet con here
df <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_comunal.parquet")
)
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 2 (Sonnet)`
_(Reemplazar por Opus si la sesión requiere razonamiento más profundo.)_

**Mensaje de apertura:**

```
Continuación de sesión sobre el proyecto slep_simce_adecuado.

Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de
estructura y principios de desarrollo) viven en la knowledge base de este
Project; léelos desde ahí. Adjunto el traspaso y los archivos críticos de la
sesión anterior.

Por favor sigue el protocolo de apertura definido en mis userPreferences y
entrega el plan de trabajo en el formato estándar (Estado al cierre /
Pendientes / Ruta propuesta / Decisiones que necesitas), basado en el handoff
adjunto.
```

### Documentos para la próxima sesión

**Documentos de protocolo (knowledge base del Project)**
No requieren adjuntarse — viven en la knowledge base:
- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`

**Documentos opcionales según foco:**
- `asistente_claude_code_seguro.md` — la próxima sesión continuará en Claude Code

**Documento de traspaso (adjuntar al nuevo chat):**
- `50_documentacion/traspasos/traspaso_cierre_v01.md`

**Output del escáner (adjuntar al nuevo chat):**
- `50_documentacion/estructura/estructura_actual.md` — correr
  `00_escanear_proyecto.R` antes de abrir

**Archivos críticos para retomar (adjuntar al nuevo chat):**
- `30_procesamiento/30_construir_auxiliares.R` — bloque 4 pendiente
  (`sleps_chile.parquet`)
- `30_procesamiento/33_generar_html.R` — si se trabaja en exportación UI
- `50_documentacion/activa/referencia_glosas_simce.md` — anomalías A1–A4,
  consultar antes de tocar pipeline

> **Nota:** si algún archivo de los listados cambió después de este cierre
> (entre sesiones), adjunta la versión más actualizada al abrir y avísalo
> explícitamente en el mensaje de apertura.
