# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v05
- **Fecha:** 2026-05-28
- **Sesión:** 5 — Tooltip interactivo con lista de establecimientos por año × GSE, exportación SVG del supergrid, limpieza de estado, nota metodológica y escáner con 4 outputs
- **Modelo utilizado:** Claude Sonnet 4.6
- **Entorno:** Web (HTML/React/D3), R
- **Archivos principales modificados:**
  - `30_procesamiento/33_motor_template.html`
  - `00_escanear_proyecto.R`

---

## 2. Resumen ejecutivo

La sesión 5 comenzó con backlog cero heredado de la sesión 4 y abordó cuatro áreas. Primero se realizó el commit pendiente (Git-s4) de los cambios de la sesión anterior. Segundo, se implementó la exportación del supergrid como SVG compuesto vectorial (P2), con un SVG raíz que itera entidades × GSE, clona los subgráficos D3 renderizados y los posiciona en una grilla con etiquetas. Tercero, se eliminó el estado `region`/`setRegion` sin uso en el tab de comunas (D3-cleanup). Cuarto, se completó P5 actualizando `00_escanear_proyecto.R` para generar 4 outputs (aliases `.md` y `.txt` + snapshots con timestamp). El trabajo más extenso fue la implementación del tooltip interactivo en los gráficos: hover muestra datos fijos (sin seguir al cursor), clic fija el tooltip con borde de señal y habilita el botón "Ver establecimientos (N) ▸", que abre `EstabPopup` filtrado por entidad × GSE × año. El debugging fue intenso: el problema raíz era una cadena de tres errores independientes — listener `mousedown` global interceptando el clic, `GSE_LABEL_TO_COD` no exportado en `SimceData`, y el popup renderizando fuera de pantalla por confusión entre coordenadas absolutas y `position: fixed`. Además se añadió una nota metodológica sobre Estándares de Aprendizaje en la sección de notas del motor. Al cierre, el backlog queda vacío y el proyecto está en estado estable con todos los cambios commiteados y pusheados a GitHub.

---

## 3. Estado del proyecto al cierre

### Qué funciona
- Pipeline completo: `00_build.R` orquesta los 4 scripts, genera `40_salidas/motor_comparacion.html`
- Motor HTML: entidades Establecimiento, Comuna, SLEP, Región, Grupo personalizado
- Supergrid con sparklines + barras, filtro GSE, tabla de resultados
- Popup de establecimientos desde tabla (cellPopup) y desde estabPopup
- **NUEVO:** Tooltip interactivo en gráficos: hover = datos fijos, clic = tooltip pinned con "Ver establecimientos (N) ▸"
- **NUEVO:** `EstabPopup` desde gráficos filtra por entidad × GSE × año (misma fuente que `n_estab`)
- **NUEVO:** Exportación SVG compuesto del supergrid (botón "Exportar gráficos")
- **NUEVO:** `00_escanear_proyecto.R` genera 4 outputs: aliases `.md`/`.txt` + snapshots con timestamp
- **NUEVO:** Nota metodológica "Estándares de Aprendizaje" en sección de notas del motor

### Qué no funciona
- Sin bugs activos conocidos al cierre

### Qué cambió respecto a v04
- Tooltip completamente rediseñado: de hover-follow a hover-fixed + clic-pinned + botón establecimientos
- `EstabPopup` ahora acepta prop `year` y filtra por `DATA.simce_rbd` cuando se provee
- `GSE_LABEL_TO_COD` exportado en el objeto `SimceData` (faltaba)
- `ChartCell` tiene atributos `data-entity-id` y `data-gse` para que `exportarGraficos` los localice
- Overlay `#tooltip-overlay` agregado al body para cierre por clic-fuera del tooltip pinned
- `00_escanear_proyecto.R`: variable `timestamp`, 4 `writeLines`, cabecera actualizada
- Estado `region`/`setRegion` y constante `currentRegion` eliminados del tab comunas

---

## 4. Registro detallado de cambios

#### Cambio 1: Git-s4 — commit de sesión anterior
- **Archivo(s):** varios (commit `3cc9edb`)
- **Categoría:** Gobernanza
- **Qué se hizo:** `git add -A && git commit && git push` con el mensaje acordado en v04
- **Por qué:** el traspaso v04 lo tenía como pendiente alto
- **Cómo se verificó:** push exitoso, 6 archivos, rama `main`

#### Cambio 2: P2 — Exportación SVG compuesto del supergrid
- **Archivo(s):** `33_motor_template.html`
- **Categoría:** UI / Export
- **Qué se hizo:** función `exportarGraficos({entities, nivel, prueba})` que construye un `<svg>` raíz con grilla (col GSE + N cols entidad × 4 filas GSE), clona los SVGs D3 con `cloneNode(true)`, serializa con `XMLSerializer` y descarga como `.svg`
- **Por qué:** pendiente P2 del backlog; produce archivo vectorial sin dependencias externas
- **Cómo se verificó:** botón genera descarga SVG con layout correcto
- **Líneas clave:** función `exportarGraficos` (~160 líneas); `ChartCell` con `data-entity-id` y `data-gse`; `IconExport` con `onExport` conectado

#### Cambio 3: D3-cleanup — eliminar estado region sin uso
- **Archivo(s):** `33_motor_template.html`
- **Categoría:** Deuda técnica
- **Qué se hizo:** eliminadas 6 líneas: estado `region`/`setRegion` y constante derivada `currentRegion` en el tab de comunas del modal
- **Por qué:** vestigio de versión anterior con selector de región; no se usaba en render ni en handleSave
- **Cómo se verificó:** `grep` sin referencias residuales; modal de comunas funciona igual

#### Cambio 4: P5 — escáner con 4 outputs
- **Archivo(s):** `00_escanear_proyecto.R`
- **Categoría:** Gobernanza / Infraestructura
- **Qué se hizo:** añadida variable `timestamp`, reemplazado `writeLines` único por 4 escrituras: `estructura_actual.md`, `estructura_actual.txt`, `YYYYMMDD_HHMMSS_estructura.md`, `YYYYMMDD_HHMMSS_estructura.txt`; cabecera actualizada; variable `salida` obsoleta eliminada
- **Por qué:** cumplir sección 7.3 de POLITICA_PROYECTO.md
- **Cómo se verificó:** corrida exitosa; 4 archivos generados en `50_documentacion/estructura/`

#### Cambio 5: Tooltip interactivo con hover-fixed + clic-pinned
- **Archivo(s):** `33_motor_template.html`
- **Categoría:** UI / Interactividad
- **Qué se hizo:** refactorización completa de `makeTooltip`: singleton `_tt`, función `populate()` extraída, `show()` ancla el tooltip a las coordenadas del punto SVG (no sigue al cursor), `pin()` fija el tooltip con clase `.is-pinned` y muestra el botón "Ver establecimientos". Eliminado listener `mousedown` global; reemplazado por overlay `#tooltip-overlay` con `onclick` para cerrar. CSS: `.tooltip.is-pinned` habilita `pointer-events: auto` y muestra borde ocean
- **Por qué:** el diseño anterior era inutilizable: el tooltip seguía al cursor y el botón no era clickeable
- **Cómo se verificó:** hover muestra datos fijos; clic fija con borde azul; "Ver establecimientos" abre popup
- **Líneas clave:** `_tt`, `populate()`, `show()`, `pin()`, `hide()` en `makeTooltip`; `#tooltip-overlay` en body; `.tooltip.is-pinned` en CSS

#### Cambio 6: EstabPopup desde gráficos con filtro por año
- **Archivo(s):** `33_motor_template.html`
- **Categoría:** UI / Datos
- **Qué se hizo:** `window.__openChartEstabPopup` expuesta desde `App` via `useEffect`; estado `chartPopup` con `{ entity, gse, year }`; `EstabPopup` acepta nueva prop `year`; cuando `year` está presente, filtra `DATA.simce_rbd` por año × GSE × nivel × prueba (misma fuente que `n_estab`); título incluye año; `GSE_LABEL_TO_COD` exportado en `SimceData`
- **Por qué:** el conteo de establecimientos en el popup debe coincidir con el `n_estab` del tooltip; diferencia era por fuente distinta (`DATA.rbd_gse` vs `DATA.simce_rbd`)
- **Cómo se verificó:** popup muestra 2 establecimientos cuando tooltip dice 2
- **Líneas clave:** `window.__openChartEstabPopup` en `useEffect`; `chartPopup` state; `EstabPopup` prop `year`; rama `simce_rbd` en filtro GSE; `GSE_LABEL_TO_COD` en `return` de `SimceData`

#### Cambio 7: Nota metodológica Estándares de Aprendizaje
- **Archivo(s):** `33_motor_template.html`
- **Categoría:** Contenido / Documentación
- **Qué se hizo:** nueva `<article className="note note-full">` al inicio del grid de notas con redacción de 3 párrafos + 3 niveles en negrita; CSS `.note-full { grid-column: 1 / -1 }` para que ocupe el ancho completo
- **Por qué:** requerimiento de contenido para contextualizar los estándares al usuario final
- **Cómo se verificó:** visible en sección de notas del motor

#### Cambio 8: Git-s5 — commit de esta sesión
- **Archivo(s):** varios (commit `1cb39be`)
- **Categoría:** Gobernanza
- **Qué se hizo:** commit y push de todos los cambios de la sesión 5
- **Cómo se verificó:** push exitoso, 8 archivos, rama `main`

---

## 5. Backlog acumulativo de cambios

| Sesión | Cambios | Categorías dominantes |
|--------|---------|----------------------|
| 1 | 8 | Pipeline, datos, estructura |
| 2 | 9 | UI v2, entidades, parquets |
| 3 | 11 | UI v3, orquestador, visualización |
| 4 | 14 | P4–P7, bugs UI, entidades avanzadas |
| 5 | 8 | Tooltip, export SVG, deuda técnica, gobernanza |
| **Total** | **50** | |

---

## 6. Bugs documentados en esta sesión

#### Bug B5.1: Tooltip no clickeable — listener mousedown global interceptaba el botón
- **Síntoma:** clic en "Ver establecimientos" no hacía nada
- **Causa raíz:** el listener `mousedown` en `document` se ejecutaba en fase de burbujeo antes que el `click` del botón, cerrando el tooltip y dejando el evento huérfano. Agravado por `pointer-events: none` del CSS base que hacía incierto el hit-test
- **Solución:** eliminar listener global; reemplazar por overlay `#tooltip-overlay` con `onclick` que se activa solo cuando el tooltip está pinned
- **Regla:** nunca usar `document.addEventListener("mousedown")` para cerrar tooltips con botones interactivos — usar overlay detrás del elemento

#### Bug B5.2: GSE_LABEL_TO_COD undefined en EstabPopup
- **Síntoma:** `Cannot read properties of undefined (reading 'Medio bajo')`
- **Causa raíz:** `GSE_LABEL_TO_COD` se construía dentro del IIFE de `SimceData` pero no se incluía en el objeto `return`
- **Solución:** añadir `GSE_LABEL_TO_COD` al `return` de `SimceData`
- **Regla:** todo objeto construido dentro del IIFE que sea necesario en componentes externos debe estar en el `return` explícitamente

#### Bug B5.3: Popup fuera de pantalla — confusión absolute vs fixed
- **Síntoma:** popup abría (React lo renderizaba) pero no era visible
- **Causa raíz:** `.estab-popup` usa `position: fixed` (coordenadas relativas al viewport), pero el cálculo de posición sumaba `window.scrollY`, desplazando el popup fuera del viewport al hacer scroll
- **Solución:** eliminar `window.scrollY` del cálculo; centrar en viewport con `window.innerHeight/2`
- **Regla:** con `position: fixed`, las coordenadas son relativas al viewport — nunca sumar `scrollY`/`scrollX`

#### Bug B5.4: Discrepancia n_estab tooltip vs lista popup
- **Síntoma:** tooltip decía 2 establecimientos, popup listaba 5
- **Causa raíz:** tooltip usa `DATA.simce_rbd` (filtrado por umbral 10 estudiantes), popup usaba `DATA.rbd_gse` (todos los años, sin umbral)
- **Solución:** pasar `year` desde el tooltip al popup; cuando `year` está presente, filtrar `DATA.simce_rbd` por año × GSE × nivel × prueba
- **Regla:** `n_estab` en el tooltip y la lista del popup deben usar la misma fuente; la fuente canónica es `DATA.simce_rbd` filtrado por año

---

## 7. Restricciones técnicas vigentes

1. El motor es un HTML autocontenido (`file://`); `CustomEvent` cross-frame puede fallar — usar `window.__functionName` para comunicación DOM→React
2. `.estab-popup` es `position: fixed` — coordenadas siempre relativas al viewport, sin `scrollY`
3. `makeTooltip` es imperativo (fuera de React) — toda comunicación con React pasa por funciones en `window`
4. D3 renderiza SVGs sin IDs únicos — localizar por `data-entity-id` y `data-gse` en el `div` contenedor
5. El tooltip es un singleton `#global-tooltip` en el body — no crear múltiples instancias
6. `SimceData` es un IIFE — todo lo que se use externamente debe estar en el `return` explícito
7. Quarto (`.qmd`) establece working directory al folder del `.qmd` — usar `source("archivo.R")` con ruta relativa, no `here::here()`
8. `annotate()` duplica labels en `facet_wrap`/`facet_grid` — usar datos explícitos por panel o `element_markdown` en subtítulos
9. MINEDUC threshold 10 estudiantes: el campo `n_estab` en `D` (parquet comunal) ya tiene el umbral aplicado; `DATA.rbd_gse` no

---

## 8. Decisiones de diseño tomadas

- **Tooltip hover-fixed vs hover-follow:** se eligió fixed (anclado al punto SVG) para facilitar interacción con el botón
- **Clic-pinned vs siempre visible:** el botón "Ver establecimientos" solo aparece en estado pinned para no saturar el hover
- **Overlay vs listener global:** overlay `position:fixed;inset:0` es más robusto que listener `mousedown` para cierre por clic-fuera
- **window.__fn vs CustomEvent:** `window.__openChartEstabPopup` elegido sobre `CustomEvent` por compatibilidad con `file://`
- **Año en popup:** al llegar desde un punto del gráfico (año concreto), se filtra por ese año; al llegar desde la tabla (sin año), se muestra todos
- **SVG compuesto:** `cloneNode(true)` + `XMLSerializer` sin dependencias externas; layout fijo de 4 columnas

---

## 9. Archivos y estructura actual

```
commit: 1cb39be
rama: main (sincronizado con GitHub)

Archivos clave:
  00_build.R                           — orquestador principal
  00_escanear_proyecto.R               — escáner con 4 outputs
  30_procesamiento/33_motor_template.html — template v5 (sesión 5)
  30_procesamiento/33_generar_html.R   — inyecta datos en template
  40_salidas/motor_comparacion.html    — output generado (no versionado)
  50_documentacion/estructura/         — 4 tipos de outputs del escáner
  50_documentacion/traspasos/          — v01–v05
```

---

## 10. Contexto de datos

- **Parquets en disco:** `simce_rbd.parquet` (1223 KB), `simce_comunal.parquet` (455 KB), `establecimientos_chile.parquet` (260 KB), `sleps_chile.parquet` (43 KB), `comunas_chile.parquet` (7 KB), `slep_cc_establecimientos.parquet` (6 KB)
- **Años disponibles:** 2014–2018, 2022–2025 (2025 preliminar)
- **Niveles:** 4° Básico, 2° Medio
- **Pruebas:** Lectura, Matemática
- **GSE codes:** 1=Bajo, 2=Medio bajo, 3=Medio, 4=Medio alto, 5=Alto

---

## 11. Pendientes para la próxima sesión

### 11.1 Backlog

| ID | Título | Tipo | Impacto | Complejidad | Dependencias |
|----|--------|------|---------|-------------|--------------|
| P8 | Entidad nacional (Chile completo) | Funcionalidad nueva | Alto | Alta | Requiere agregar tipo `nacional` en pipeline y UI |
| P9 | Establecimiento en fila GSE correcta | Funcionalidad nueva | Medio | Media | El resultado del establecimiento debe mostrarse en la fila del GSE que le corresponde, sin desglose por GSE |

### 11.2 Observaciones sobre P9
Al cierre de la sesión 5, el usuario confirmó que los resultados de establecimiento deben aparecer en la fila del GSE al que pertenece el establecimiento (no desglosado), consistente con el principio de ponderación por N evaluados.

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? (C.8) → **Sí** — logs de diagnóstico se añadieron y retiraron correctamente
- ¿Los outputs son reproducibles e idempotentes? (C.2, C.3) → **Sí** — `00_build.R` genera el mismo HTML dado los mismos parquets
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? (C.11) → **Sí** — umbrales y mappings están en `SimceData`

### 11.4 Ruta sugerida para la próxima sesión

## Ruta sugerida para la próxima sesión

1. **P9 — Establecimiento en fila GSE correcta** — medio impacto, complejidad media; es un ajuste en cómo `ChartCell` decide qué fila renderizar para entidades de tipo `estab`. Criterio de éxito: el resultado aparece en una sola fila (la del GSE del establecimiento) y las demás filas quedan vacías.
2. **P8 — Entidad nacional** — alto impacto, complejidad alta; requiere tipo `nacional` en pipeline, nuevo preset en UI y aggregación sin filtro de comunas. Abordar al inicio de sesión cuando hay más contexto.

**Diferir para sesión posterior:**
- Ningún pendiente adicional conocido al cierre.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** modificar `makeTooltip` sin leer la sección 6 (bugs B5.1–B5.4) de este traspaso — la arquitectura actual (overlay + `window.__fn`) surgió de debugging iterativo con causas raíz específicas
- ✅ **ANTES** de modificar `EstabPopup`, verificar si el popup recibe `year` o no — el comportamiento de filtro es diferente según este prop
- 🔒 `GSE_LABEL_TO_COD` debe permanecer en el `return` de `SimceData` — su ausencia rompe silenciosamente el filtro GSE en `EstabPopup`
- 🔒 `.estab-popup` usa `position: fixed` — nunca calcular posición con `window.scrollY`

---

## 13. Fragmentos de código de referencia

### Patrón comunicación DOM→React (window.__fn)
```javascript
// En App (React):
React.useEffect(() => {
  window.__openChartEstabPopup = function(detail) {
    const { entity, gse, year } = detail;
    setChartPopup({ entity: { ...entity, _popupPos: { ... } }, gse, year });
  };
  return () => { window.__openChartEstabPopup = null; };
}, []);

// En makeTooltip (DOM imperativo):
if (typeof window.__openChartEstabPopup === "function") {
  window.__openChartEstabPopup({ entity, gse, nivel, prueba, year: yr });
}
```

### Patrón overlay para cerrar tooltip pinned
```javascript
// Al hacer pin():
const overlay = document.getElementById("tooltip-overlay");
overlay.style.display = "block";
overlay.onclick = () => {
  _tt.pinned = false;
  tip.classList.remove("is-pinned");
  tip.style.display = "none";
  overlay.style.display = "none";
  overlay.onclick = null;
};
// El div en HTML: <div id="tooltip-overlay" style="display:none;position:fixed;inset:0;z-index:9998;"></div>
```

### Filtro EstabPopup por año (fuente canónica)
```javascript
// Cuando year está presente: usar DATA.simce_rbd
if (year != null && DATA.simce_rbd) {
  const D2 = DATA.simce_rbd;
  rbdsGSE = new Set();
  for (let i = 0; i < D2.rbd.length; i++) {
    if (String(D2.cod_grupo[i]) === gseCod &&
        D2.nivel[i] === nv && D2.prueba[i] === pr && D2.anio[i] === year) {
      rbdsGSE.add(String(D2.rbd[i]));
    }
  }
}
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 6 (Sonnet)`
(Reemplazar "Sonnet" por el modelo que vayas a usar.)

**Mensaje de apertura:**

> Continuación de sesión sobre el proyecto **slep_simce_adecuado**.
>
> Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de estructura, principios de desarrollo y asistente Claude Code seguro) viven en la knowledge base de este Project; léelos desde ahí. Adjunto el traspaso de la sesión anterior. La próxima sesión se ejecuta en Claude Code — por favor lee también `asistente_claude_code_seguro.md` desde la knowledge base.

**Documentos para la próxima sesión:**

### Documentos de protocolo (knowledge base del Project)
No requieren adjuntarse — el asistente los lee desde la knowledge base:
- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`
- `asistente_claude_code_seguro.md`

### Documentos específicos a adjuntar al nuevo chat
- `traspaso_cierre_v05.md` ← este archivo
- `estructura_actual.md` (correr `00_escanear_proyecto.R` antes de abrir)
- `33_motor_template.html` (si la sesión toca el motor)
- `33_generar_html.R` (si la sesión toca el pipeline)

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
