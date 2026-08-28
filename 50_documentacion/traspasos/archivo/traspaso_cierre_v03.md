# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v03
- **Fecha:** 2026-05-27
- **Sesión:** 3 — Corrección de bugs UI (B3, B2), implementación de exportación CSV (P3), mejoras de UX en la tabla de resultados y el popup de establecimientos, y ajustes de diseño y semántica.
- **Modelo utilizado:** Claude Sonnet 4.6
- **Entorno:** R (Positron) + HTML/React/D3 — sesión ejecutada en Claude Code (pestaña Code)
- **Archivos principales modificados:**
  - `30_procesamiento/30_construir_auxiliares.R`
  - `30_procesamiento/33_generar_html.R`
  - `30_procesamiento/33_motor_template.html`

---

## 2. Resumen ejecutivo

Esta sesión se centró en corregir bugs activos y mejorar la usabilidad del motor de comparación HTML. Se resolvió B3 (popup de establecimientos) de forma progresiva: primero se corrigió el crash por `D.rbd` inexistente, luego se extendió para mostrar establecimientos de cualquier entidad (no solo SLEPs), y finalmente se añadió filtrado por RBD × nivel × prueba usando un nuevo catálogo `establecimientos_chile.parquet` construido en `30_construir_auxiliares.R`. Se implementó P3 (exportación CSV) con separador `;` y BOM UTF-8 para compatibilidad con Excel chileno. Se corrigió B2 parcialmente: las semillas iniciales ahora usan `depe2="5"` (SLEP), con la decisión razonada de no filtrar por `depe2="1"` dado que las comunas Costa Central no tienen registros municipales post-traspaso. Se aplicaron múltiples mejoras de UX: supergrid con columnas dinámicas (placeholders para 4 fijas), etiquetas de barras siempre arriba, conteo de establecimientos en el chip, búsqueda de comuna por input libre, límite de 4 entidades con advertencia, y corrección de leyendas. Al cierre el HTML pesa ~3 MB, el pipeline es estable y todos los bugs activos de la sesión anterior están resueltos.

---

## 3. Estado del proyecto al cierre

### Qué funciona

- Pipeline completo ejecutable en orden: `30_construir_auxiliares.R` → `31_leer_normalizar.R` → `32_agregar_comunal.R` → `33_generar_html.R`
- `establecimientos_chile.parquet`: nuevo parquet con catálogo completo de RBDs (10.945 establecimientos, 5 columnas)
- `rbds_por_nivel` en JSON del HTML: catálogo de qué RBDs rindieron cada nivel × prueba (~22K filas)
- Popup "ver establecimientos" funcional para cualquier entidad (SLEP, comuna+depe2, grupo)
  - Muestra conteo `(N)` en el chip antes de abrir
  - Filtra por nivel × prueba activos usando `DATA.rbds_por_nivel`
  - Para SLEP: filtra por `cod_depe2="5"`; para comuna: respeta `depe2` de la entidad
- Supergrid: siempre 4 columnas fijas con divs placeholder para entidades faltantes
- Exportación CSV: botón activo, descarga `simce_adecuado_<nivel>_<prueba>.csv` con separador `;` y BOM UTF-8
- Etiquetas de barras: siempre encima de la barra, color de la entidad
- Semillas iniciales: 4 comunas Costa Central con `depe2="5"` (SLEP)
- Modal agregar entidad: default `depe2="5"`, búsqueda de comuna por input libre autofiltrable
- Máximo de entidades: 4 (advertencia al intentar agregar la 5ta)
- Leyenda tabla: `▼` eliminado de la tabla; `*` y `(N)` explicados correctamente
- Header: eliminado "Agencia de Calidad / Mineduc", corregido "Simce" y "proporción de estudiantes"

### Qué no funciona / pendiente

- **P2** — Exportación de gráficos como imagen: botón muestra `alert("Export pendiente")`, sin implementar
- **P4** — `00_build.R` orquestador: no existe
- **Warning sanity check** — `32_agregar_comunal.R`: `pivot_wider` en resumen final produce warning por múltiples filas por `(nom_com_rbd, cod_grupo, anio)` al tener `cod_depe2` como dimensión adicional
- **B2 parcial** — Semillas sin región: el selector de región fue eliminado del modal (reemplazado por búsqueda libre), pero las semillas no muestran región en el chip (solo "Servicio Local de Educación")
- **Commit sesión 3**: repositorio GitHub no sincronizado con cambios de esta sesión

### Qué cambió respecto al traspaso anterior (v02)

- `30_construir_auxiliares.R`: nuevo Bloque 5 → `establecimientos_chile.parquet`; `COD_DEPE2` y `NOM_RBD` añadidos a validación de columnas CSV
- `33_generar_html.R`: carga `establecimientos_chile.parquet` y `simce_rbd.parquet` (para `rbds_por_nivel`); ambos inyectados en `json_root`
- `33_motor_template.html`: ~20 cambios (ver sección 4)

---

## 4. Registro detallado de cambios realizados

#### Cambio 19: Corrección crash popup — D.rbd inexistente

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de bug
- **Qué se hizo:** Reemplazó el loop `for (let i = 0; i < D.rbd.length; i++)` por uno sobre `D.cod_com` para construir `comunasConDatos`. `DATA.datos` está agregado a nivel comunal, no por RBD.
- **Por qué se hizo:** `D.rbd` no existe en el JSON (datos son comunales), causando `TypeError: Cannot read properties of undefined (reading 'length')` al abrir el popup.
- **Cómo se verificó:** Popup dejó de crashear al hacer clic.
- **Líneas o secciones clave:** Función `EstabPopup`, bloque de construcción del Set de filtro.
- **Dependencias afectadas:** Prerequisito para todos los cambios posteriores del popup.

#### Cambio 20: Popup usando DATA.establecimientos (cobertura universal)

- **Archivo(s) afectado(s):** `30_procesamiento/30_construir_auxiliares.R`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`
- **Categoría temática:** Pipeline + UI — nueva funcionalidad
- **Qué se hizo:** Creado `establecimientos_chile.parquet` (Bloque 5 en `30_construir_auxiliares.R`) con todas las dependencias. Inyectado como `DATA.establecimientos` en el JSON. Popup reescrito para usar esta fuente en lugar de `DATA.sleps`.
- **Por qué se hizo:** `DATA.sleps` solo cubre establecimientos SLEP formalizados (`COD_DEPE == 6`). Para entidades municipales u otras dependencias no había catálogo disponible.
- **Cómo se verificó:** Popup muestra establecimientos para cualquier tipo de entidad.
- **Líneas o secciones clave:** Bloque 5 de `30_construir_auxiliares.R`; `establecimientos_lst` en `33_generar_html.R`; función `EstabPopup` en template.
- **Dependencias afectadas:** Requiere correr `30_construir_auxiliares.R` antes de `33_generar_html.R`.

#### Cambio 21: Filtro popup por RBDs que rindieron nivel × prueba

- **Archivo(s) afectado(s):** `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`
- **Categoría temática:** Pipeline + UI — corrección de bug
- **Qué se hizo:** Inyectado catálogo `DATA.rbds_por_nivel` (distinct de `rbd × nivel × prueba` desde `simce_rbd.parquet`). Popup filtra contra este Set antes de mostrar establecimientos.
- **Por qué se hizo:** Sin este filtro, el popup mostraba establecimientos que no rindieron el nivel evaluado (ej. escuelas básicas en vista de 2° Medio).
- **Cómo se verificó:** Al seleccionar 2° Medio, el popup excluye establecimientos sin esa evaluación.
- **Líneas o secciones clave:** `df_rbd_np` en `33_generar_html.R`; Set `rbdsNP` en `EstabPopup`.
- **Dependencias afectadas:** Requiere `simce_rbd.parquet` en `40_salidas/intermedios/`.

#### Cambio 22: Conteo de establecimientos en chip ("ver establecimientos (N)")

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — mejora UX
- **Qué se hizo:** Función `contarEstablecimientos(entity, nivel, prueba)` que replica la lógica de filtro del popup. Resultado mostrado en el botón del chip. `nivel` y `prueba` propagados como props desde `App` → `EntitiesBar` → `EntityChip`.
- **Por qué se hizo:** El usuario necesita saber cuántos establecimientos verá antes de abrir el popup. El conteo se actualiza automáticamente al cambiar nivel o prueba.
- **Cómo se verificó:** Chip muestra "ver establecimientos (14) ▸" para Concón en 4° Básico.
- **Líneas o secciones clave:** Función `contarEstablecimientos`; props `nivel` y `prueba` en `EntityChip` y `EntitiesBar`.
- **Dependencias afectadas:** Cambio de firma de `EntitiesBar` y `EntityChip`.

#### Cambio 23: Supergrid con 4 columnas fijas y placeholders

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de bug visual
- **Qué se hizo:** Restaurado `repeat(4, minmax(0, 1fr))` fijo. Añadidos divs placeholder (`4 - entities.length`) tanto en la fila de headers como en cada fila GSE.
- **Por qué se hizo:** Con `repeat(N, ...)` dinámico, 2 entidades ocupaban 50% del ancho cada una en lugar del 25% correcto.
- **Cómo se verificó:** Con 2 entidades, cada columna ocupa el mismo ancho que con 4.
- **Líneas o secciones clave:** `gridTemplateColumns` del supergrid; arrays de placeholders en headers y filas GSE.
- **Dependencias afectadas:** Ninguna.

#### Cambio 24: Exportación CSV (P3)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — nueva funcionalidad
- **Qué se hizo:** Función `exportarCSV({ entities, nivel, prueba, gseFilter })` que itera `entities × GSE × años`, genera CSV con separador `;`, BOM UTF-8, y `pct` con coma decimal. Botón "Exportar CSV" pasa `onExport` al componente `IconExport`.
- **Por qué se hizo:** P3 del backlog. La tabla de resultados no tenía exportación funcional.
- **Cómo se verificó:** Botón descarga archivo `.csv` correctamente estructurado.
- **Líneas o secciones clave:** Función `exportarCSV`; prop `onExport` en `IconExport`; invocación en `App`.
- **Dependencias afectadas:** `IconExport` ahora acepta prop `onExport` opcional; sin `onExport` mantiene el `alert`.

#### Cambio 25: Etiquetas de barras siempre encima

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — mejora visual
- **Qué se hizo:** Eliminada lógica condicional inside/outside. `labelY = yAdec - 5` siempre, con `fill = entity.color`.
- **Por qué se hizo:** El umbral condicional producía inconsistencia visual entre barras del mismo gráfico. En el contexto SIMCE los % Adecuado son bajos, por lo que la etiqueta siempre sobre la barra es la opción más clara.
- **Cómo se verificó:** Todas las etiquetas aparecen consistentemente sobre las barras.
- **Líneas o secciones clave:** Bloque `labelY / fill` en `RecentBarsSubchart`.
- **Dependencias afectadas:** Margen top del gráfico aumentado de 14 → 28 para evitar corte.

#### Cambio 26: Semillas iniciales con depe2="5" (B2)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — decisión de diseño
- **Qué se hizo:** `buildInitialEntities` añade `depe2: "5"` a las 4 semillas Costa Central. Default del modal también cambiado a `"5"`.
- **Por qué se hizo:** Las comunas Costa Central son SLEP — sus establecimientos tienen `cod_depe2="5"` en los datos. `depe2="1"` (Municipal) devuelve 0 registros porque el traspaso ya está efectuado en los datos.
- **Cómo se verificó:** La tabla muestra datos para las 4 comunas semilla al cargar.
- **Líneas o secciones clave:** `buildInitialEntities`; `React.useState(editing?.depe2 || "5")` en modal.
- **Dependencias afectadas:** Decisión metodológica: para comunas en transición, usar `depe2` sin filtro si se quiere ver el territorio completo; usar `"5"` para ver solo post-traspaso.

#### Cambio 27: Búsqueda libre de comuna en modal

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — mejora UX
- **Qué se hizo:** Eliminado selector `<select>` de región + `<select>` de comuna. Reemplazado por input autofiltrable con dropdown que muestra nombre de comuna + región a la derecha. Muestra hasta 30 resultados.
- **Por qué se hizo:** El selector de región con abreviaturas (TPCA, VALPO, LGBO...) era ilegible. La búsqueda libre por nombre de comuna es más intuitiva.
- **Cómo se verificó:** Escribir "viña" filtra y muestra "VIÑA DEL MAR — Valparaíso".
- **Líneas o secciones clave:** Tab "Comuna" en `AddEntityModal`; estado `search` reutilizado.
- **Dependencias afectadas:** El estado `region` quedó sin uso en el tab comuna (puede limpiarse en sesión futura).

#### Cambio 28: Límite de 4 entidades con advertencia

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de comportamiento
- **Qué se hizo:** `MAX_ENTIDADES` reducido de 6 a 4. Añadido `alert("Máximo de comparación: 4 entidades...")` al intentar agregar la 5ta.
- **Por qué se hizo:** El supergrid está diseñado para 4 columnas. El usuario reportó confusión al ver "5 de 6 activas".
- **Cómo se verificó:** Al tener 4 entidades el botón "Agregar entidad" dispara el alert.
- **Líneas o secciones clave:** `MAX_ENTIDADES`; guard en `setEntities`.
- **Dependencias afectadas:** Ninguna.

#### Cambio 29: Corrección de textos del header

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección semántica
- **Qué se hizo:** Eliminado bloque `brand-lockup` (Agencia de Calidad / Mineduc). Corregido "SIMCE" → "Simce". Corregido "% de estudiantes" → "proporción de estudiantes".
- **Por qué se hizo:** Decisión del usuario: el motor es una herramienta interna SLEP, no un producto de la Agencia. "Simce" es la ortografía correcta como nombre propio.
- **Cómo se verificó:** Header muestra solo el título y subtítulo sin atribución externa.
- **Líneas o secciones clave:** `Header` component; `<title>`; `results-title`.
- **Dependencias afectadas:** Ninguna.

#### Cambio 30: SLEP chip muestra conteo de establecimientos

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — mejora informativa
- **Qué se hizo:** `EntityChip` calcula `nEstabSlep` para entidades SLEP filtrando `DATA.establecimientos` por `cod_depe2="5"` y comunas del SLEP. Chip muestra "SLEP · 4 comunas · 61 establecimientos".
- **Por qué se hizo:** El usuario quiere saber cuántos establecimientos compone el SLEP sin abrir el popup.
- **Cómo se verificó:** SLEP Costa Central muestra 61 establecimientos.
- **Líneas o secciones clave:** `nEstabSlep` en `EntityChip`.
- **Dependencias afectadas:** Requiere `DATA.establecimientos`.

#### Cambio 31: Leyenda tabla corregida — eliminación del ▼

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección semántica
- **Qué se hizo:** Eliminado `▼` de las celdas de la tabla. Actualizada leyenda: `(N)` ahora dice "Número de estudiantes a los que corresponde ese porcentaje". Eliminada línea del `▼` de la leyenda.
- **Por qué se hizo:** El `▼` era redundante con el color de la celda (ya indica nivel crítico ≤25%). La descripción de `(N)` era técnica y poco clara para el usuario final.
- **Cómo se verificó:** Tabla sin triángulos; leyenda más legible.
- **Líneas o secciones clave:** `td-alert-dot` en celdas; `HeatLegend`.
- **Dependencias afectadas:** Ninguna.

#### Cambio 32: NIVEL_LABEL_TO_COD y PRUEBA_LABEL_TO_COD expuestos en SimceData

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — corrección de acceso a datos
- **Qué se hizo:** Añadidos `NIVEL_LABEL_TO_COD` y `PRUEBA_LABEL_TO_COD` al `return` de `SimceData`.
- **Por qué se hizo:** `EstabPopup` y `contarEstablecimientos` necesitan convertir labels a códigos para filtrar, pero los mapas solo existían como variables locales dentro del IIFE de `SimceData`.
- **Cómo se verificó:** Popup y conteo funcionan correctamente sin error de referencia.
- **Líneas o secciones clave:** `return { ..., NIVEL_LABEL_TO_COD, PRUEBA_LABEL_TO_COD }` en `SimceData`.
- **Dependencias afectadas:** Cualquier código externo que necesite estos mapas puede usarlos vía `SimceData`.

#### Cambio 33: makeTooltip incluye RBD en warning de baja representatividad

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI — mejora informativa
- **Qué se hizo:** `makeTooltip` ahora recibe `nivel` y `prueba`. Cuando `n_estab === 1`, busca el establecimiento único en `DATA.establecimientos` y muestra "Baja representatividad — un solo establecimiento (RBD XXXX)".
- **Por qué se hizo:** El usuario necesita saber qué establecimiento específico genera el dato de baja representatividad.
- **Cómo se verificó:** Tooltip muestra RBD correcto en celdas con un solo establecimiento.
- **Líneas o secciones clave:** Firma `makeTooltip(entity, gse, nivel, prueba)`; bloque del warning.
- **Dependencias afectadas:** Las dos invocaciones de `makeTooltip` actualizadas para pasar `nivel` y `prueba`.

---

## 5. Backlog acumulativo de cambios

| Sesión | Cambios implementados | Tipo predominante |
|--------|----------------------|-------------------|
| 1      | 1–11                 | Pipeline + UI base |
| 2      | 12–18                | Pipeline (cod_depe2, sleps) + UI rediseño |
| 3      | 19–33                | UI bugs + UX + nuevos catálogos |
| **Total** | **33** | |

---

## 6. Bugs activos al cierre

Ninguno conocido. Todos los bugs reportados en sesión 3 fueron resueltos.

---

## 7. Decisiones de diseño relevantes

### D1: Semillas con depe2="5" (no sin filtro)
Las 4 comunas Costa Central tienen `cod_depe2="5"` en `simce_comunal.parquet` para todos los años post-traspaso. Pre-traspaso, los mismos establecimientos aparecían como `cod_depe2="1"`. La decisión de usar `depe2="5"` como semilla muestra solo los años post-traspaso; para ver el territorio completo el usuario debe editar la entidad y seleccionar "Todas las dependencias".

### D2: DATA.datos es comunal, no por RBD
El JSON del HTML no contiene datos por establecimiento individual — solo agregados por `(comuna × depe2 × gse × nivel × prueba × año)`. Todo filtro que requiera granularidad RBD (popup, baja representatividad) usa catálogos auxiliares (`DATA.establecimientos`, `DATA.rbds_por_nivel`, `DATA.sleps`).

### D3: Búsqueda libre vs selector de región
El selector de región fue eliminado del modal. La búsqueda libre es más usable y no requiere conocer las abreviaturas de región. El estado `region` quedó en el componente pero sin efecto en el tab comuna — puede limpiarse en sesión futura sin impacto funcional.

---

## 8. Anomalías y advertencias activas

> ⚠️ El `cod_depe2` de Costa Central en el directorio oficial (snapshot abril 2025) refleja el traspaso anticipado. Los establecimientos aparecen con `COD_DEPE=6` aunque el traspaso formal fue en julio 2025. Ver nota crítica del Cambio 16 en traspaso v02.

> ⚠️ `simce_rbd.parquet` no tiene columna `nom_rbd`. El nombre de establecimiento solo está disponible en `establecimientos_chile.parquet` (desde directorio oficial) y en `sleps_chile.parquet`.

---

## 9. Lecciones aprendidas

- **`DATA.datos` es comunal**: nunca intentar filtrar por `D.rbd` — no existe. Todo lo que requiera granularidad por establecimiento necesita un catálogo auxiliar.
- **Verificar tipo de datos antes de filtrar**: aunque `cod_depe2` llegue como `character` en R y en el JSON, siempre usar `String(r.cod_depe2)` en comparaciones JS para evitar falsos negativos por coerción.
- **`indicesPCG` no resuelve todo**: el cache de índices por `(nivel, prueba, cod_grupo)` es útil pero no elimina la necesidad de verificar `cod_depe2` en el loop posterior.
- **Props no fluyen solos**: al añadir `nivel` y `prueba` a un componente hoja, hay que propagarlos por toda la cadena de componentes (App → EntitiesBar → EntityChip). Olvidar un eslabón produce comportamiento silencioso incorrecto.

---

## 10. Parquets en disco al cierre

| Archivo | Tamaño aprox. | Descripción |
|---------|---------------|-------------|
| `simce_rbd.parquet` | ~1,2 MB | 185.378 filas, 12 columnas |
| `simce_comunal.parquet` | ~370 KB | 44.975 filas, 12 columnas |
| `comunas_chile.parquet` | 7 KB | 345 comunas |
| `sleps_chile.parquet` | ~50 KB | 1.707 filas, 26 SLEPs |
| `establecimientos_chile.parquet` | ~300 KB | 10.945 establecimientos (nuevo) |
| `slep_cc_establecimientos.parquet` | 6 KB | Establecimientos Costa Central con flag rinde_simce |

---

## 11. Pendientes

### 11.1 Bugs activos

Ninguno al cierre.

### 11.2 Pendientes de funcionalidad

| # | Título | Tipo | Impacto | Dependencia | Criterio de éxito |
|---|--------|------|---------|-------------|-------------------|
| P2 | Exportación UI — gráficos como imagen | UI | Medio | ninguna | Botón descarga SVG/PNG desde supergrid |
| P4 | `00_build.R` — orquestador completo | Pipeline | Medio | scripts 30–33 estables | `source("00_build.R")` reproduce todo end-to-end |
| P5 | `00_escanear_proyecto.R` — adaptado | Infraestructura | Bajo | ninguna | Genera `estructura_actual.md` correctamente |
| D3-cleanup | Limpiar estado `region` en modal | Deuda técnica | Bajo | ninguna | Estado `region` eliminado del tab comuna |
| Git-s3 | Commit cambios sesión 3 | Infraestructura | Alto | ninguna | GitHub sincronizado con estado actual |

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? → **Sí** — `30_construir_auxiliares.R` tiene `stopifnot()` en Bloque 5 para columnas requeridas; scripts 31 y 32 tienen validaciones de NAs y duplicados.
- ¿Los outputs son reproducibles e idempotentes? → **Sí** — todos los parquets y el HTML se regeneran desde cero.
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? → **Parcialmente** — `MAX_ENTIDADES = 4` y `HEAT_THRESHOLDS` son constantes nombradas; el filtro `cod_depe2="5"` en semillas está como literal (pendiente menor extraer a constante).

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

1. **Git-s3 — Commit sesión 3** *(menor)* — antes de cualquier otra cosa, sincronizar GitHub con los cambios de sesión 2 y 3.
2. **P4 — `00_build.R` orquestador** *(menor)* — pipeline estable, momento adecuado; criterio: `source("00_build.R")` corre los 4 scripts en orden con mensajes de progreso.
3. **P2 — Exportación de gráficos** *(medio)* — requiere capturar SVGs del DOM; explorar `SVGElement.outerHTML` + descarga, o biblioteca `html2canvas`.
4. **P5 — Escáner** *(bajo)* — diferir hasta que el proyecto esté más estable.

**Diferir:**
- D3-cleanup — cosmético, sin impacto funcional.

---

## 12. Instrucciones específicas para la próxima sesión

> ⚠️ **NO** modificar `31_leer_normalizar.R` sin leer la sección de anomalías A1–A4 en `referencia_glosas_simce.md`.
> ⚠️ **NO** modificar `30_construir_auxiliares.R` sin considerar que el directorio es snapshot de abril 2025 — para SLEPs traspasados después de esa fecha, validar siempre el xlsx de salida.
> ✅ **ANTES** de regenerar el HTML, verificar que los cinco parquets existen en `40_salidas/intermedios/`: `simce_comunal.parquet`, `comunas_chile.parquet`, `sleps_chile.parquet`, `establecimientos_chile.parquet`, `simce_rbd.parquet` (este último solo para `rbds_por_nivel`).
> 🔒 GSE es inviolable en toda vista de resultados.
> 🔒 `dplyr::` prefijado en todos los scripts — sin `library(dplyr)` en archivos que se `source()`-an.
> 🔒 `DATA.datos` no tiene columna `rbd` — es agregado comunal. No intentar filtrar por RBD desde este objeto.
> 🔒 El filtro `COD_DEPE == 6` en `sleps_chile.parquet` es intencional — no cambiar.

---

## 13. Fragmentos de código de referencia

```javascript
// Contar establecimientos para una entidad (usado en chip y popup)
function contarOFiltrarEstablecimientos(entity, nivel, prueba) {
  const nv = SimceData.NIVEL_LABEL_TO_COD[nivel];
  const pr = SimceData.PRUEBA_LABEL_TO_COD[prueba];
  const rbdsNP = new Set(
    (DATA.rbds_por_nivel || [])
      .filter(r => r.nivel === nv && r.prueba === pr)
      .map(r => String(r.rbd))
  );
  const setCom = new Set(entity.comunas || []);
  return (DATA.establecimientos || []).filter(r => {
    if (!setCom.has(String(r.cod_com_rbd))) return false;
    if (entity.kind === "slep") { if (String(r.cod_depe2) !== "5") return false; }
    else if (entity.depe2) { if (String(r.cod_depe2) !== String(entity.depe2)) return false; }
    return rbdsNP.has(String(r.rbd));
  });
}

// Exportar CSV con BOM UTF-8 y separador ; (compatible con Excel chileno)
function exportarCSV({ entities, nivel, prueba, gseFilter }) {
  // ... genera rows[][]
  const csvContent = rows.map(r => r.map(v => {
    const str = String(v);
    return str.includes(";") ? '"' + str.replace(/"/g, '""') + '"' : str;
  }).join(";")).join("\n");
  const blob = new Blob(["\uFEFF" + csvContent], { type: "text/csv;charset=utf-8;" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url; a.download = "simce_...csv"; a.click();
  URL.revokeObjectURL(url);
}
```

```r
# Construcción de establecimientos_chile.parquet (Bloque 5 de 30_construir_auxiliares.R)
df_establecimientos <- df_dir_raw |>
  dplyr::filter(.data$ESTADO_ESTAB == 1, .data$MATRICULA == 1) |>
  dplyr::transmute(
    rbd         = as.character(RBD),
    nom_rbd     = NOM_RBD,
    cod_com_rbd = as.character(COD_COM_RBD),
    nom_com_rbd = NOM_COM_RBD,
    cod_depe2   = as.character(COD_DEPE2)
  ) |>
  dplyr::distinct() |>
  dplyr::arrange(cod_com_rbd, nom_rbd)
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 4 (Sonnet)`
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

- `50_documentacion/traspasos/traspaso_cierre_v03.md`

### Output del escáner (adjuntar — correr `00_escanear_proyecto.R` antes de abrir)

- `50_documentacion/estructura/estructura_actual.md`

### Archivos críticos para retomar (adjuntar según foco)

- `30_procesamiento/33_motor_template.html` — UI v4 (voluminoso, ~3 MB; necesario si la sesión trabaja en P2)
- `30_procesamiento/33_generar_html.R` — si se trabaja en el pipeline o en P4
- `30_procesamiento/30_construir_auxiliares.R` — si se modifica el pipeline de auxiliares
- `50_documentacion/activa/referencia_glosas_simce.md` — consultar antes de tocar pipeline

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
