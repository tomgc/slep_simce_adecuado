# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v04
- **Fecha:** 2026-05-28
- **Sesión:** 4 — Commit Git-s3, implementación P4 (orquestador), P6 (entidades región y establecimiento), P7 (popup celda GSE), correcciones de bugs UI y mejoras de contenido.
- **Modelo utilizado:** Claude Sonnet 4.6
- **Entorno:** R (Positron) + HTML/React/D3
- **Archivos principales modificados:**
  - `00_build.R`
  - `CLAUDE.md`
  - `30_procesamiento/30_construir_auxiliares.R`
  - `30_procesamiento/33_generar_html.R`
  - `30_procesamiento/33_motor_template.html`

---

## 2. Resumen ejecutivo

Esta sesión se centró en cuatro frentes principales. Primero, se realizó el commit Git-s3 pendiente (sesiones 2 y 3) y se completó el orquestador `00_build.R` (P4), que ahora ejecuta los 4 scripts del pipeline en orden con timer. Segundo, se implementó P6 en dos partes: entidades tipo región (tab en modal, selector con dependencia, agregación desde `simce_comunal`) y entidades tipo establecimiento (tab con buscador de 3+ caracteres, datos inyectados desde `simce_rbd.parquet`, aparición en fila del GSE del año más reciente). Tercero, se implementó P7 (clic en celda de tabla abre popup de establecimientos filtrado por GSE, usando nuevo catálogo `rbd_gse` inyectado en el JSON). Cuarto, se realizaron múltiples correcciones: nombres de región normalizados (de abreviaturas a nombres oficiales), nota metodológica de fórmula corregida, texto de objetivo añadido al header, reordenamiento de tabs del modal, bug de establecimiento repetido en todos los GSE, bug de C stack overflow en R, y corte del 100% en gráficos SVG. El HTML final pesa ~14 MB y el pipeline es estable.

---

## 3. Estado del proyecto al cierre

### Qué funciona

- Pipeline completo ejecutable con `source("00_build.R")`: `30_construir_auxiliares.R` → `31_leer_normalizar.R` → `32_agregar_comunal.R` → `33_generar_html.R`
- Orquestador `00_build.R`: corre los 4 scripts en orden con timer
- Motor HTML (~14 MB) estable con las siguientes entidades:
  - **Establecimiento**: buscador libre (≥3 caracteres), aparece en fila del GSE del año más reciente
  - **Comuna**: búsqueda libre + selector de dependencia
  - **SLEP**: lista filtrable
  - **Región**: lista filtrable + selector de dependencia
  - **Grupo personalizado**: selección múltiple de comunas
- Orden de tabs del modal: Establecimiento → Comuna → SLEP → Región → Grupo personalizado
- Popup "ver establecimientos" desde chip (sin filtro GSE) y desde celda de tabla (filtrado por GSE × nivel × prueba)
- Exportación CSV con separador `;` y BOM UTF-8
- Nombres de región completos (no abreviaturas)
- Texto de objetivo en el header con términos clave en negrita
- Nota metodológica de fórmula corregida
- Etiquetas SVG sin corte (`overflow: visible`)
- 7 parquets en `40_salidas/intermedios/`

### Qué no funciona / pendiente

- **P2** — Exportación de gráficos como imagen: botón muestra `alert("Export pendiente")`
- **P5** — `00_escanear_proyecto.R` adaptado: no iniciado
- **D3** — Estado `region` sin uso en tab comuna del modal: limpieza cosmética pendiente
- **Git-s4** — Cambios de esta sesión no commiteados aún

### Qué cambió respecto al traspaso anterior (v03)

- `00_build.R`: de stub a orquestador completo (4 scripts, timer)
- `CLAUDE.md`: actualizado con estado post-sesión 3 y backlog completo
- `30_construir_auxiliares.R`: Bloque 3 normaliza `nom_reg_rbd` con nombres oficiales de región
- `33_generar_html.R`: inyecta `rbd_gse` y `simce_rbd` en el JSON; `rm()`+`gc()` para liberar memoria; `n_simce_rbd` guardado antes del `rm()`
- `33_motor_template.html`: ~20 cambios (ver sección 4)

---

## 4. Registro detallado de cambios realizados

#### Cambio 34: `00_build.R` completado — orquestador funcional

- **Archivo(s) afectado(s):** `00_build.R`
- **Categoría temática:** Pipeline — infraestructura
- **Qué se hizo:** Descomentados los 3 `source()` existentes; añadido `source()` para `30_construir_auxiliares.R` como primer paso; añadido timer con `proc.time()` y mensaje de cierre.
- **Por qué se hizo:** P4 del backlog. El pipeline estaba estable y era el momento adecuado.
- **Cómo se verificó:** `source("00_build.R")` ejecuta los 4 scripts en orden sin error.
- **Líneas o secciones clave:** Todo el archivo.
- **Dependencias afectadas:** Ninguna.

#### Cambio 35: `CLAUDE.md` actualizado post-sesión 3

- **Archivo(s) afectado(s):** `CLAUDE.md`
- **Categoría temática:** Documentación
- **Qué se hizo:** Nombre plantilla corregido a `33_motor_template.html`; filas `simce_comunal` actualizadas a 44.975; parquets `sleps_chile` y `establecimientos_chile` añadidos; bloques 0–5 completos; pendientes actualizados; últimos cambios reescritos con historial por sesión; backlog completo con P2, P5, P6, P7, D3, Nacional.
- **Por qué se hizo:** CLAUDE.md estaba en estado post-sesión 2.
- **Cómo se verificó:** Revisión manual de consistencia.
- **Dependencias afectadas:** Ninguna.

#### Cambio 36: Normalización de nombres de región en `comunas_chile.parquet`

- **Archivo(s) afectado(s):** `30_procesamiento/30_construir_auxiliares.R`
- **Categoría temática:** Pipeline — corrección de datos
- **Qué se hizo:** Añadido vector `nombres_region` con 16 entradas (códigos → nombres oficiales). En Bloque 3, `nom_reg_rbd` se reemplaza vía `dplyr::recode()` usando ese vector.
- **Por qué se hizo:** El CSV fuente usa abreviaturas (TPCA, ANTOF, VALPO…) ilegibles en la UI.
- **Cómo se verificó:** El tab Región del modal muestra "Tarapacá", "Valparaíso", etc.
- **Líneas o secciones clave:** Bloque 3 de `30_construir_auxiliares.R`.
- **Dependencias afectadas:** Requiere correr `30_construir_auxiliares.R` + `33_generar_html.R` para actualizar el parquet y el HTML.

#### Cambio 37: Inyección de `rbd_gse` en el JSON

- **Archivo(s) afectado(s):** `30_procesamiento/33_generar_html.R`
- **Categoría temática:** Pipeline — nuevo catálogo
- **Qué se hizo:** Añadido `df_rbd_gse`: distinct de `rbd × nivel × prueba × cod_grupo` desde `simce_rbd.parquet`. Inyectado como `rbd_gse` en `json_root`.
- **Por qué se hizo:** P7 requiere filtrar establecimientos por GSE en el popup de celda.
- **Cómo se verificó:** `DATA.rbd_gse` disponible en el HTML; popup de celda filtra correctamente.
- **Líneas o secciones clave:** Bloque entre `df_rbd_np` y `sleps_lst` en `33_generar_html.R`.
- **Dependencias afectadas:** Ninguna.

#### Cambio 38: Inyección de `simce_rbd` en el JSON (formato columnar)

- **Archivo(s) afectado(s):** `30_procesamiento/33_generar_html.R`
- **Categoría temática:** Pipeline — nuevos datos
- **Qué se hizo:** Añadido `df_simce_rbd` (8 columnas: `rbd`, `nivel`, `prueba`, `cod_grupo`, `anio`, `nalu`, `palu_eda_ade`, `cod_depe2`). Serializado como `simce_rbd_lst` en formato columnar. Inyectado como `simce_rbd` en `json_root`.
- **Por qué se hizo:** P6-establecimiento requiere datos por RBD para graficar.
- **Cómo se verificó:** HTML pesa ~14 MB; establecimientos grafican correctamente.
- **Líneas o secciones clave:** Bloque `df_simce_rbd` / `simce_rbd_lst` en `33_generar_html.R`.
- **Dependencias afectadas:** Aumenta el HTML de ~7 MB a ~14 MB.

#### Cambio 39: `rm()` + `gc()` para evitar C stack overflow

- **Archivo(s) afectado(s):** `30_procesamiento/33_generar_html.R`
- **Categoría temática:** Pipeline — corrección de bug
- **Qué se hizo:** Añadidos `rm(json_str, html, d3_code, plantilla, simce_rbd_lst, df_simce_rbd)` y `gc(verbose = FALSE)` tras escribir el HTML. `n_simce_rbd` guardado antes del `rm()` para el resumen.
- **Por qué se hizo:** Con ~14 MB de strings en memoria, R generaba "C stack usage too close to the limit" al limpiar el entorno.
- **Cómo se verificó:** Script completa sin error de stack.
- **Líneas o secciones clave:** Bloque entre escritura del HTML y el resumen final.
- **Dependencias afectadas:** Ninguna.

#### Cambio 40: P7 — Popup de establecimientos desde celda de tabla (filtrado por GSE)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — nueva funcionalidad
- **Qué se hizo:** `EstabPopup` acepta prop `gse` opcional; filtra contra `DATA.rbd_gse` cuando viene. `ResultsTable` acepta `onCellClick` y lo pasa a cada `<td>` con dato (`cursor: pointer`). `App` tiene estado `cellPopup` separado de `estabPopup`; renderiza segundo `<EstabPopup>` con `gse`. Título del popup incluye `— GSE Bajo` etc.
- **Por qué se hizo:** P7 del backlog.
- **Cómo se verificó:** Clic en celda abre popup con lista filtrada por GSE × nivel × prueba.
- **Líneas o secciones clave:** `EstabPopup`, `ResultsTable`, `App` en `33_motor_template.html`.
- **Dependencias afectadas:** Requiere `DATA.rbd_gse` en el JSON.

#### Cambio 41: P6-región — Entidad tipo región

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — nueva funcionalidad
- **Qué se hizo:** Tab "Región" añadido al modal con buscador y lista de regiones (nombre + conteo de comunas) + selector de dependencia. `handleSave` rama `tab === "region"` construye entidad con `kind: "region"`, `cod_reg`, array de comunas de la región, `depe2`. `sg-ent-meta` muestra `Región · N comunas`. `generateSeriesByDepe` ya maneja esta entidad sin cambios.
- **Por qué se hizo:** P6 del backlog — jerarquía completa de entidades.
- **Cómo se verificó:** Tab Región funcional; datos se grafican correctamente.
- **Líneas o secciones clave:** `AddEntityModal`, `handleSave`, `sg-ent-meta`.
- **Dependencias afectadas:** Ninguna en el pipeline.

#### Cambio 42: P6-establecimiento — Entidad tipo establecimiento

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — nueva funcionalidad
- **Qué se hizo:** Tab "Establecimiento" añadido al modal con buscador libre (≥3 caracteres, hasta 20 resultados, búsqueda por nombre o RBD). `SimceData` expone `generateSeriesByEstab`, `gseActualDeEstab` y `ESTAB_LIST`. Establecimiento aparece en la fila del GSE del año más reciente. Supergrid muestra `ChartCell` solo en ese GSE y `div` vacío en los demás. `ResultsTable` itera solo una fila por establecimiento. `getSeries` en todos los puntos de despacho tiene rama `kind === "estab"`.
- **Por qué se hizo:** P6 del backlog.
- **Cómo se verificó:** Establecimiento aparece en un solo GSE en supergrid y tabla.
- **Líneas o secciones clave:** `SimceData` (funciones nuevas), `AddEntityModal`, supergrid, `ResultsTable`, `getSeries` (×4).
- **Dependencias afectadas:** Requiere `DATA.simce_rbd` en el JSON.

#### Cambio 43: Reordenamiento de tabs y renombre "Grupo personalizado"

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — UX
- **Qué se hizo:** Orden de tabs: Establecimiento → Comuna → SLEP → Región → Grupo personalizado. Tab inicial por defecto cambiado a "estab".
- **Por qué se hizo:** Orden de micro a macro solicitado por el usuario.
- **Dependencias afectadas:** Ninguna.

#### Cambio 44: Texto de objetivo en el header

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — contenido
- **Qué se hizo:** Añadido párrafo `.app-objective` debajo del subtítulo con texto de objetivo institucional. Términos clave en `<strong>`: SLEP Costa Central, Estándares de Aprendizaje, nivel Adecuado, Grupo Socioeconómico (GSE), Agencia de Calidad de la Educación.
- **Por qué se hizo:** Solicitud del usuario para contextualizar el producto.
- **Dependencias afectadas:** Ninguna.

#### Cambio 45: Corrección nota metodológica fórmula de agregación

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de contenido
- **Qué se hizo:** Fórmula corregida a `%adec = Σ(nalu × palu_eda_ade / 100) / Σ(nalu) × 100`. Descripción actualizada: "por combinación de establecimiento × prueba × nivel". Eliminada frase imprecisa sobre comunas.
- **Por qué se hizo:** La fórmula anterior mezclaba notaciones y era metodológicamente imprecisa.
- **Dependencias afectadas:** Ninguna.

#### Cambio 46: Corrección bug establecimiento repetido en todos los GSE (supergrid)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de bug
- **Qué se hizo:** En el supergrid, el loop de `GSE_LEVELS` ahora verifica `ent.kind === "estab"`: si el GSE de la iteración no es el GSE actual del establecimiento, renderiza `<div />` vacío en lugar de `ChartCell`.
- **Por qué se hizo:** Sin esta corrección el establecimiento aparecía graficado en todas las filas GSE.
- **Cómo se verificó:** Establecimiento aparece solo en su fila GSE.
- **Líneas o secciones clave:** Loop `SimceData.GSE_LEVELS.map` en el supergrid de `App`.
- **Dependencias afectadas:** Ninguna.

#### Cambio 47: `overflow: visible` en SVGs para evitar corte de etiquetas

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de bug visual
- **Qué se hizo:** Añadido `overflow: visible` a `.sparkline-svg, .bars-svg, .chart-svg`.
- **Por qué se hizo:** Etiquetas de datos en los bordes del SVG (especialmente "100%") se cortaban en Safari y Chrome.
- **Cómo se verificó:** "100%" visible completo en ambos navegadores.
- **Dependencias afectadas:** Ninguna.

#### Cambio 48: `GSE_LABELS` expuesto en `SimceData`

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de acceso a datos
- **Qué se hizo:** Definida variable `GSE_LABELS = M.gse_labels` dentro del IIFE y añadida al `return` de `SimceData`.
- **Por qué se hizo:** `EstabPopup` usaba `SimceData.GSE_LABELS` pero no estaba expuesto.
- **Dependencias afectadas:** `EstabPopup` y cualquier código que necesite el diccionario código → label de GSE.

---

## 5. Backlog acumulativo de cambios

| Sesión | Cambios implementados | Tipo predominante |
|--------|----------------------|-------------------|
| 1 | 1–11 | Pipeline + UI base |
| 2 | 12–18 | Pipeline (cod_depe2, sleps) + UI rediseño |
| 3 | 19–33 | UI bugs + UX + nuevos catálogos |
| 4 | 34–48 | Orquestador + P4 + P6 + P7 + bugs |
| **Total** | **48** | |

---

## 6. Bugs activos al cierre

Ninguno conocido.

---

## 7. Decisiones de diseño relevantes

### D4: Establecimiento en fila del GSE del año más reciente

Un establecimiento puede cambiar de GSE entre años. Se decidió mostrarlo en la fila del GSE del año más reciente con dato (función `gseActualDeEstab`). En años anteriores con GSE distinto, el dato aparece igualmente en esa fila — no se filtra. Esta decisión prioriza la simplicidad visual sobre la precisión histórica del GSE.

### D5: `simce_rbd` en formato columnar en el JSON

Los datos por establecimiento se serializan en formato columnar (`{rbd: [...], nivel: [...], ...}`) para que el loop en JS sea por índice en lugar de por objeto, reduciendo la presión de memoria en el browser.

### D6: Jerarquía completa de entidades

La jerarquía queda: establecimiento → comuna → SLEP → región. "Nacional" diferido por complejidad.

### D7: Tab por defecto del modal es "Establecimiento"

Al ser la entidad más granular y la más buscada por nombre, se pone primero y es el tab inicial al abrir el modal.

---

## 8. Anomalías y advertencias activas

> ⚠️ El `cod_depe2` de Costa Central en el directorio oficial (snapshot abril 2025) refleja el traspaso anticipado. Los establecimientos aparecen con `COD_DEPE=6` aunque el traspaso formal fue en julio 2025. Ver nota crítica del Cambio 16 en traspaso v02.

> ⚠️ `simce_rbd.parquet` no tiene columna `nom_rbd`. El nombre de establecimiento solo está disponible en `establecimientos_chile.parquet`.

> ⚠️ El HTML pesa ~14 MB. Si el peso se vuelve un problema, el candidato a comprimir es `simce_rbd` (7.3 MB del JSON) — podría codificarse con índices enteros en lugar de strings repetidos.

---

## 9. Lecciones aprendidas

- **C stack overflow en R**: objetos string muy grandes (>14 MB combinados) en el entorno al finalizar `source()` pueden causar stack overflow durante el GC. Solución: `rm()` + `gc()` explícitos antes del resumen final.
- **`overflow: visible` en SVG**: sin esta propiedad, etiquetas de texto en los bordes del viewBox se cortan en todos los browsers. Es la corrección correcta en lugar de aumentar márgenes.
- **`gseActualDeEstab` debe calcularse antes del render**: la función recorre 185k filas; llamarla dos veces (una en supergrid, otra en ResultsTable) es aceptable pero podría memorizarse si hay problemas de rendimiento.

---

## 10. Parquets en disco al cierre

| Archivo | Tamaño aprox. | Descripción |
|---------|--------------|-------------|
| `simce_rbd.parquet` | ~1,2 MB | 185.378 filas, 12 columnas |
| `simce_comunal.parquet` | ~455 KB | 44.975 filas, 12 columnas |
| `comunas_chile.parquet` | 7 KB | 345 comunas con nombres de región normalizados |
| `sleps_chile.parquet` | ~43 KB | 26 SLEPs × comunas × RBDs |
| `establecimientos_chile.parquet` | ~260 KB | 10.945 establecimientos |
| `slep_cc_establecimientos.parquet` | 6 KB | Establecimientos Costa Central con flag rinde_simce |

---

## 11. Pendientes

### 11.1 Bugs activos

Ninguno al cierre.

### 11.2 Pendientes de funcionalidad

| # | Título | Prioridad | Tipo | Dependencia | Criterio de éxito |
|---|--------|-----------|------|-------------|-------------------|
| P2 | Exportación de gráficos como imagen | Medio | UI | ninguna | Botón descarga SVG/PNG desde supergrid |
| P5 | `00_escanear_proyecto.R` adaptado | Bajo | Infraestructura | ninguna | Genera `estructura_actual.md` correctamente |
| D3 | Limpiar estado `region` sin uso en tab comuna del modal | Bajo | Deuda técnica | ninguna | Estado `region` eliminado del tab comuna |
| Git-s4 | Commit cambios sesión 4 | Alto | Infraestructura | ninguna | GitHub sincronizado con estado actual |
| — | Entidad tipo "nacional" | Diferido | UI + Pipeline | — | — |

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? → **Sí** — `stopifnot()` en todos los bloques críticos de `30_construir_auxiliares.R`; validaciones de placeholders en `33_generar_html.R`.
- ¿Los outputs son reproducibles e idempotentes? → **Sí** — todos los parquets y el HTML se regeneran desde cero con `source("00_build.R")`.
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? → **Parcialmente** — `MAX_ENTIDADES = 4`, `HEAT_THRESHOLDS` son constantes nombradas; el filtro `cod_depe2="5"` en semillas aún es literal.

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

1. **Git-s4 — Commit sesión 4** *(menor)* — primero siempre; mensaje: `"feat: P4 orquestador, P6 región+establecimiento, P7 popup GSE, bugs UI sesión 4"`.
2. **P2 — Exportación de gráficos** *(medio)* — explorar `SVGElement.outerHTML` + descarga directa como `.svg`; criterio: botón descarga el supergrid visible como archivo.
3. **D3-cleanup** *(menor)* — limpiar estado `region` en tab comuna; diferible.
4. **P5 — Escáner** *(bajo)* — diferir hasta que el proyecto esté más estable.

---

## 12. Instrucciones específicas para la próxima sesión

> ⚠️ **NO** modificar `31_leer_normalizar.R` sin leer la sección de anomalías A1–A4 en `referencia_glosas_simce.md`.
> ⚠️ **NO** modificar `30_construir_auxiliares.R` sin considerar que el directorio es snapshot de abril 2025.
> ✅ **ANTES** de regenerar el HTML, verificar que los 6 parquets existen en `40_salidas/intermedios/`.
> ✅ **ANTES** de trabajar en P2, leer cómo está estructurado el supergrid en `App` — los SVGs son generados por D3 con refs, no por React directo.
> 🔒 GSE es inviolable en toda vista de resultados.
> 🔒 `dplyr::` prefijado en todos los scripts.
> 🔒 `DATA.datos` no tiene columna `rbd` — es agregado comunal. No intentar filtrar por RBD desde este objeto.
> 🔒 `DATA.simce_rbd` es formato columnar: acceder por índice (`D2.rbd[i]`, `D2.nalu[i]`), no como array de objetos.
> 🔒 El filtro `COD_DEPE == 6` en `sleps_chile.parquet` es intencional — no cambiar.

---

## 13. Fragmentos de código de referencia

```javascript
// Despacho de series — patrón completo para los 4 puntos del template
const series = entity.kind === "slep"
  ? SimceData.generateSeriesByRbd({ rbds: entity.rbds, gse, nivel, prueba })
  : entity.kind === "estab"
  ? SimceData.generateSeriesByEstab({ rbd: entity.rbd, gse, nivel, prueba })
  : SimceData.generateSeriesByDepe({ comunas: entity.comunas, depe2: entity.depe2, gse, nivel, prueba });

// GSE actual de un establecimiento (para mostrar en qué fila aparece)
const gseActual = SimceData.gseActualDeEstab({ rbd: ent.rbd, nivel, prueba });
const gseActualLabel = SimceData.GSE_LABELS[gseActual] || gseActual;

// Supergrid: render condicional para establecimiento
if (ent.kind === "estab") {
  const gseActual = SimceData.gseActualDeEstab({ rbd: ent.rbd, nivel, prueba });
  const gseActualLabel = SimceData.GSE_LABELS[gseActual] || gseActual;
  if (gse !== gseActualLabel) return <div key={ent.id + "|" + gse} />;
}
```

```r
# Liberar objetos grandes en 33_generar_html.R para evitar C stack overflow
n_simce_rbd <- nrow(df_simce_rbd)  # guardar métricas antes del rm()
rm(json_str, html, d3_code, plantilla, simce_rbd_lst, df_simce_rbd)
gc(verbose = FALSE)

# Normalización de nombres de región en 30_construir_auxiliares.R
nombres_region <- c("1" = "Tarapacá", "2" = "Antofagasta", ..., "16" = "Ñuble")
nom_reg_rbd = dplyr::recode(as.character(COD_REG_RBD), !!!nombres_region, .default = NOM_REG_RBD_A)
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 5 (Sonnet)`
(Reemplazar "Sonnet" por el modelo que vayas a usar.)

**Mensaje de apertura:**

> Continuación de sesión sobre el proyecto **slep_simce_adecuado**.
>
> Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de estructura, principios de desarrollo y asistente Claude Code seguro) viven en la knowledge base de este Project; léelos desde ahí.
>
> Adjunto el traspaso de la sesión anterior. La próxima sesión se ejecuta en Claude Code — por favor lee también `asistente_claude_code_seguro.md` desde la knowledge base.

---

**Documentos para la próxima sesión:**

### Protocolo (knowledge base del Project — no se adjuntan)

- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`
- `asistente_claude_code_seguro.md` ← leer en Claude Code

### Documento de traspaso (adjuntar)

- `50_documentacion/traspasos/traspaso_cierre_v04.md`

### Output del escáner (adjuntar — correr `00_escanear_proyecto.R` antes de abrir)

- `50_documentacion/estructura/estructura_actual.md`

### Archivos críticos para retomar (adjuntar según foco)

- `30_procesamiento/33_motor_template.html` — UI v4 (~14 MB; necesario si la sesión trabaja en P2)
- `30_procesamiento/33_generar_html.R` — si se trabaja en el pipeline
- `30_procesamiento/30_construir_auxiliares.R` — si se modifica el pipeline de auxiliares

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
