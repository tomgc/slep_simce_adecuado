# Backlog histórico acumulativo — slep_simce_adecuado

- **Cobertura:** sesiones 1–19 (traspasos v01–v19). Consolidado v01–v10 el 2026-06-09 (sesión 11); deltas s11–s19 anexados por su traspaso respectivo.
- **Propósito:** registro acumulativo único de los cambios del proyecto, numerados correlativamente. Resuelve de forma definitiva la nota de continuidad heredada de v09 ("consolidar backlog v01–v08").
- **Regla de mantenimiento:** este es un documento **vivo**. Cada traspaso de cierre futuro documenta solo su delta y **agrega aquí** sus ítems continuando la numeración. Los traspasos (inmutables) referencian este archivo en su sección 5 en lugar de duplicar el histórico.

## Taxonomía vigente

| Código | Categoría |
|--------|-----------|
| P | Pipeline R |
| UI | Motor HTML / React / D3 |
| D | Datos / Insumos |
| DOC | Documentación |
| REPO | Gobernanza del repo / Despliegue |
| Infra | Infraestructura (escáner, orquestador, CI) |
| DT | Deuda técnica |

---

## Sesión 1 — Scaffold, pipeline de datos y UI v2 (traspaso v01)

1. Creación del repo en GitHub y scaffold completo de directorios. — REPO/Infra
2. Pipeline de datos completo (scripts 30–32): lectura, normalización, auxiliares y agregación comunal; 185.378 filas brutas → 32.134 agregaciones comunales × GSE, 9 años, 2 niveles, 2 pruebas. — P
3. Motor de comparación como HTML standalone con React + D3 (supergrid entidades × GSE, sparklines, barras de últimas 3 aplicaciones, tabla con heat map), rediseñado sobre el prototipo Claude Design. — UI
4. Detección y resolución de 4 anomalías en datos crudos de la Agencia (A1–A4), documentadas en `referencia_glosas_simce.md`. — D/DOC

## Sesión 2 — Dimensión depe2, sleps_chile y rediseño UI (traspaso v02)

5. Incorporación de `cod_depe2` a `simce_rbd.parquet` y `simce_comunal.parquet`. — P
6. Construcción de `sleps_chile.parquet` desde el listado oficial de SLEPs 2026 (cierre de P1); desbloqueó la comparación por SLEP. — P/D
7. Rediseño de la UI: flujo comuna + dependencia + nivel/prueba, modal con 3 tabs (Comuna/SLEP/Grupo), heatmap con umbrales fijos, años descendentes, foco por año, filtro GSE, popup de establecimientos. — UI
8. Renombre del template a prefijo `33_` según convención de auxiliares numerados. — REPO

## Sesión 3 — Bugs UI, exportación CSV y UX de tabla (traspaso v03)

9. Resolución de B3 (popup de establecimientos): fix de crash, extensión a toda entidad, filtrado por RBD × nivel × prueba con nuevo catálogo `establecimientos_chile.parquet`. — UI/P
10. Exportación CSV (cierre de P3) con separador `;` y BOM UTF-8 para Excel chileno. — UI
11. Resolución parcial de B2: semillas iniciales con `depe2="5"` (SLEP); decisión razonada de no filtrar por `depe2="1"` (comunas Costa Central sin registros municipales post-traspaso). — UI/D
12. Mejoras de UX: supergrid con columnas dinámicas, etiquetas de barras arriba, conteo de establecimientos en chip, búsqueda de comuna por input libre, límite de 4 entidades, corrección de leyendas. — UI

## Sesión 4 — Orquestador y entidades región/establecimiento (traspaso v04)

13. Orquestador `00_build.R` (cierre de P4): ejecuta los 4 scripts del pipeline en orden con timer. — Infra
14. Entidades tipo región y establecimiento (cierre de P6): tabs en modal, agregación desde `simce_comunal`, buscador 3+ caracteres con datos desde `simce_rbd.parquet`. — UI/P
15. Popup de celda GSE (cierre de P7) con nuevo catálogo `rbd_gse` inyectado en el JSON. — UI/P
16. Correcciones varias: nombres de región oficiales, nota metodológica de fórmula, texto de objetivo en header, reorden de tabs, bug de establecimiento repetido en GSEs, C stack overflow en R, corte del 100% en SVG. — UI/P

## Sesión 5 — Exportación SVG, tooltip interactivo y escáner (traspaso v05)

17. Exportación del supergrid como SVG compuesto vectorial (primera parte de P2). — UI
18. Tooltip interactivo: hover con datos fijos, clic fija el tooltip y habilita "Ver establecimientos (N) ▸" hacia `EstabPopup` filtrado por entidad × GSE × año. — UI
19. Limpieza del estado `region`/`setRegion` sin uso en el tab de comunas (D3-cleanup). — DT
20. Escáner con 4 outputs (cierre de P5): aliases `.md`/`.txt` + snapshots con timestamp. — Infra
21. Nota metodológica sobre Estándares de Aprendizaje en el motor. — DOC

## Sesión 6 — Auditoría de agregación y entidad nacional (traspaso v06)

22. Auditoría de reproducibilidad de la agregación comunal desde RBD: diferencia cero en 44.975 filas; valida `simce_comunal` como fuente del cálculo nacional. — P
23. Entidad nacional "Chile" (cierre de P8) con resolución de 3 bugs encadenados (ramas faltantes en subcharts, guard de `entity.comunas`, orden de filtros en `EstabPopup`). — UI
24. Commit `b47e1d5` pusheado a main. — REPO

## Sesión 7 — Portabilidad cross-OS y cierre de deuda técnica (traspaso v07)

25. Portabilidad Windows: xlsx de SIMCE versionados en el repo (datos públicos, 22 MB), `.Rproj` con `Encoding: UTF-8`, pipeline verificado en Windows (R 4.5.1, Positron). — REPO/D
26. Cierre de DT6.2: `auditoria_agregacion_comunal.R` movida a `_archivo/`. — DT
27. Cierre de DT6.1: extracción de `getSeriesForEntity` en `SimceData`, eliminando cinco copias del ternario de despacho por `kind`. Regla arquitectónica vigente. — DT/UI

## Sesión 8 — Bugs UX del motor y warning de pipeline (traspaso v08)

28. Clamp del tooltip al viewport en `show()` y `pin()` (cierre de B8.1). — UI
29. Normalización NFD de diacríticos en los 4 buscadores del modal (cierre de B8.2). — UI
30. Prioridad de matches por nombre sobre matches por región en `filteredComunas` y slice de 30 → 60 (cierre de B8.3). — UI
31. Eliminación del warning `pivot_wider` en sanity check de `32_agregar_comunal.R` re-agregando ponderadamente antes del pivot (cierre de B8.4). — P

## Sesión 9 — Publicación y gobernanza (traspaso v09)

32. Cierre en Git del trabajo pendiente de la sesión 8. — REPO
33. Publicación del motor en GitHub Pages. — REPO
34. Documentación del procedimiento de publicación. — DOC
35. Escáner con auto-poda de snapshots. — Infra
36. Limpieza de artefactos obsoletos. — REPO
37. Consolidación de `estructura_proyecto.md` en README. — DOC

## Sesión 10 — Documentación visual/conceptual y simplificación UI (traspaso v10)

38. Diagrama de arquitectura HTML standalone (insumos → 30 → 31 → 32 → 33 → motor), con A1–A4 representadas como normalizaciones resueltas. — DOC
39. Actualización de `CLAUDE.md` al estado real post-v09. — DOC
40. Presentación conceptual del proyecto (md + html) para lectores internos. — DOC
41. Remoción del panel de ajustes del motor (P3): densidad fija "cómoda", `showElemInsuf`/`yScale` hardcodeados. — UI
42. Eliminación de la franja de leyenda bajo la tabla y contacto al pie de las notas (P4 reformulado). — UI
43. Deploy a Pages y sincronización de snapshots. — REPO

## Sesión 11 — Limpieza CSS, POLITICA v4, exportación PNG y consolidación del backlog (traspaso v11)

44. Limpieza quirúrgica de CSS huérfano en `33_motor_template.html` (cierre del pendiente 2 de v10): bloque `TweaksPanel` completo (24 reglas `.twk-*`), 9 reglas `.is-compact`, `.table-legend` (2 reglas), `.dot-prelim` (huérfano adicional detectado) e icono `gear` sin uso. 3.208 → 3.098 líneas. — UI
45. Verificación y cierre del pendiente 4 de v10 (estado `region` huérfano en tab comuna): ya había sido resuelto en la sesión 5 (ítem 19 de este backlog); el registro de v10 estaba obsoleto. Cerrado sin cambio. — DT
46. Sustitución de `POLITICA_PROYECTO.md` local por la canónica v4 (cierre del pendiente 1 de v10). — REPO
47. Exportación de gráficos a PNG (cierre completo de P2): refactor de `exportarGraficos` en `construirSvgGraficos` (constructor puro) + `descargarBlob` + `exportarGraficosSVG` + `exportarGraficosPNG` (rasterización canvas con `PNG_SCALE = 2`); dos botones SVG/PNG en la sección de resultados. — UI
48. Consolidación del backlog histórico v01–v10 como documento vivo (`50_documentacion/activa/backlog_historico.md`, este archivo), con regla de mantenimiento por delta (cierre del pendiente 6 de v10). — DOC
49. Exclusión de `_archivo/` en `.gitignore` (alineación con POLITICA §1.6) y versionado del `traspaso_cierre_v10.md` que estaba sin trackear. — REPO
50. Dos deploys a GitHub Pages: motor sin CSS huérfano (`f0cd824`) y motor con exportación SVG/PNG (`b77eec0`). — REPO

## Sesión 12 — Compresión gzip, SLEP traspaso 2026 y auditoría de supresión (traspaso v12)

51. Enlace de la documentación nueva (conceptual md/html, arquitectura html, backlog histórico) en la sección "Documentación" del `README.md`, con aclaración de que los `.html` no se publican por Pages (solo `docs/`). — DOC
52. Migración de la descarga de `exportarCSV` al helper `descargarBlob` (cierre del pendiente DRY de v11): una sola implementación de descarga en el motor; comportamiento del CSV idéntico. — DT/UI
53. Compresión del JSON embebido con gzip + base64, descomprimido en cliente con pako (`__PAKO_INLINE__`): `33_generar_html.R` comprime (`memCompress` + `base64_enc`, con `gsub` para quitar saltos de línea MIME que rompían el literal JS), `pako.min.js` añadido a `10_utils/`. Peso del HTML de 14.531 KB a ~1.830 KB (13% del original, muy bajo el criterio ≤50% de v11). Cierra el pendiente de optimización de peso. — UI/Infra
54. Inclusión de SLEP con traspaso prospectivo (2026) en `30_construir_auxiliares.R`: rama que incorpora los RBDs municipales (`COD_DEPE ∈ {1,2}`) de las comunas de los 10 SLEP cuyo traspaso es el año siguiente al último dato (constante `ANIO_DATOS_VIGENTE`). Catálogo de 26 a 36 SLEP, +630 RBDs. Marca visual en el motor (badge "traspaso 2026", sufijo en meta-label, nota metodológica) vía helper `slepEsProspectivo` derivado de `max(YEARS)`. — P/UI/D
55. Corrección de raíz de la selección de establecimientos por SLEP: el motor reconstruía el universo del SLEP por comuna+`cod_depe2`, lo que (a) vaciaba los SLEP prospectivos (sus RBDs son municipales, no depe 5) y (b) podía incluir RBDs ajenos. `generateSeriesByRbd` reescrita para agregar ponderado por `nalu` sobre `entity.rbds` exactos desde `simce_rbd`; popups, conteos y tooltip migrados a `entity.rbds` como fuente única de verdad. Helper `depe2CodesParaSlep` introducido y luego retirado al volverse innecesario. — UI/DT
56. Auditoría y corrección de supresión de la Agencia: los popups listaban establecimientos cuyo resultado fue suprimido por confidencialidad (`palu_eda_ade = NA` con `nalu > 0`), porque los catálogos `rbds_por_nivel` y `rbd_gse` se construían con `distinct()` sin filtrar `palu`. Confirmado contra el sitio oficial de la Agencia (RBD 1131 muestra "-" en 2025). Filtro `!is.na(palu_eda_ade)` añadido en `33_generar_html.R` (ambos catálogos) y guard `D2.palu[i] != null` en el popup de celda del motor. Bug latente desde la sesión 4; expuesto (no causado) por la entrada de SLEP rurales con el traspaso 2026. `RBDs×GSE` de 42.134 a 34.255; `RBDs×nivel` de 23.026 a 21.402. — UI/P/D

**Delta del backlog:** 6 entradas nuevas (51–56). Sin reclasificación de taxonomía. La categoría UI sigue dominante; DT y P con presencia por los dos fixes de raíz.

## Sesión 13 — Auditoría pre-lanzamiento (traspaso v13)

57. [Pipeline/Corrección] Filtro completo de producción (palu no-NA,
    nalu >= 10, marca NA) aplicado en 33_generar_html.R a los tres bloques
    que viajan al JSON (simce_rbd, rbd_gse, rbds_por_nivel). Corrige de raíz
    la regresión introducida por el ítem 55 (s12): generateSeriesByRbd
    operaba sobre simce_rbd sin filtros MINEDUC, con divergencias de hasta
    42,6 pp en celdas SLEP. JSON: 185.378 → 140.345 filas. (Resuelve el
    caso A2 del encargo de auditoría.)
58. [Infraestructura/Seguridad] Scripts CDN del template a builds
    production.min con SRI sha384 y crossorigin (React 18.3.1, ReactDOM
    18.3.1, @babel/standalone 7.29.0). (Caso B4, opción 1.)
59. [Deuda técnica] Removida la función generateSeries legacy del template
    (42 líneas, cero llamadas) y su export en SimceData. (Caso C1.)
60. [Documentación/Gobernanza] Informe de auditoría pre-lanzamiento +
    decisiones: nombres de establecimiento se mantienen (B2; la prohibición
    citada en POLITICA §6.4 corresponde a bases por estudiante) y repo
    público como excepción justificada por GitHub Pages Free (B3).

**Delta del backlog:** 4 entradas nuevas (57–60). Total acumulado: 60. Modelo: Fable 5 — auditoría pre-lanzamiento.

## Sesión 14 — UI/UX del motor y toggle real de tres niveles (traspaso v14)

61. [UI] Empty state inicial: el motor arranca con cero entidades (`useState([])`); sin entidades se ocultan resultados y tabla y se muestra un recuadro guía. `buildInitialEntities()` eliminada (huérfana); el botón limpiar vacía a `[]`.
62. [UI] Texto guía del empty state: una sola línea a 16px, color `--fg-2`. Clase `.empty-board` (renombrada desde `.empty-state` para no colisionar con el empty-state del modal).
63. [UI] Botón "limpiar" (icono `rotate-ccw`) movido del `entities-head` al final de `entities-list`, junto a la última tarjeta.
64. [UI] Toggle "Elem. + Insuf.": bug de salto al desmarcar resuelto reservando el ancho del chip condicional de `ChartHints` (`visibility:hidden` en vez de desmontar).
65. [UI] Tarjetas de entidad: crecen en alto antes de pasar a 2 filas (`max-width:340px`, `align-items:flex-start`, nota SLEP con `white-space:normal`).
66. [UI] Sticky de Nivel/Prueba: `controls-bar` con `position:sticky; top:0` y `border-top:4px coral` (la línea naranja viaja con el sticky); borde coral del header removido para no duplicar.
67. [UI] Default de dependencia en pestañas Comuna/Región/Nacional: de "Servicio Local de Educación" (cod 5) a "Todas las dependencias" (`""`). Resuelve de raíz el síntoma de "comuna sin datos" (p. ej. Petorca), que se guardaba con dependencia SLEP y salía vacía.
68. [UI] Texto "Resultados por GSE" → "Resultados segmentados por grupo socioeconómico (GSE)".
69. [UI] Multi-selección por checkbox de SLEP y de regiones: arrays `selectedSleps`/`selectedRegions`, helper `toggleSel` con límite dinámico `maxSel = slotsLibres` (no supera el tope de 4 entidades); `saveEntities()` agrega en lote con colores distintos. En edición vuelve a radio (selección única).
70. [UI] Favicon inline (data-URI SVG, fondo ocean + tres barras) en `<head>`; elimina el 404 en GitHub Pages.
71. [UI] Notas metodológicas en masonry de 3 columnas (`columns: 3 280px`, `break-inside: avoid`). Orden: Estándares → SLEP → Fórmula → GSE → Gap → Preliminares.
72. [Metodología/UI] Componente `SlepDisclaimer` + helper `SimceData.entidadDependeSlep(entity)` (`kind==="slep"` o `depe2==="5"`): disclaimer permanente en pestaña SLEP, condicional en Región/Comuna/Nacional, nota en tarjetas con dependencia SLEP y nota larga en las notas metodológicas. La dependencia es la actual y aplica a toda la serie; las cifras previas al traspaso son de gestión municipal, no atribuibles al SLEP.
73. [Consistencia/UI] Label de la dependencia 5 normalizado a "Servicio Local de Educación Pública (SLEP)" en `DEPE2_LABELS` (sobreescribe lo que traiga el JSON).
74. [Pipeline] `31_leer_normalizar.R`: lee `palu_eda_ele` y `palu_eda_ins` (espejo de `palu_eda_ade`), las valida como requeridas y las incluye en el esquema (12 → 14 columnas de `simce_rbd.parquet`).
75. [Pipeline] `10_utils/10_utils.R`: `agregar_ponderado()` calcula además `pct_elemental` y `pct_insuficiente` con la misma ponderación por `nalu` y los mismos filtros, condicional a que existan las columnas. El % Adecuado es idéntico exista o no ele/ins (lo gobierna `palu_eda_ade`).
76. [Pipeline] `32_agregar_comunal.R`: propaga `pct_elemental`/`pct_insuficiente` al `select` final de `simce_comunal.parquet` (12 → 14 columnas).
77. [Pipeline] `33_generar_html.R`: `depe2_labels` corregido a "Servicio Local de Educación Pública (SLEP)"; `pct_ele`/`pct_ins` embebidos en el bloque comunal (`datos_lst`); `palu_ele`/`palu_ins` crudos en el bloque por establecimiento (`simce_rbd_lst`).
78. [Frontend] Las 5 funciones `generateSeriesBy*` acumulan `num_ele`/`num_ins` y devuelven `pct_ele`/`pct_ins` vía helper `mkPunto()`, que normaliza los tres niveles a 100 (Adecuado exacto; Elem+Insuf reescalados para sumar 100−Adecuado, absorbiendo el ±0,1 de redondeo de la fuente).
79. [Frontend] `RecentBarsSubchart`: el rectángulo blanco "resto" se reemplaza por dos segmentos apilados con color fijo (Elemental `#D8C98E`, Insuficiente `#B9A9A0`) cuando el toggle está activo. Leyenda (`ChartHints`) y tooltip actualizados a tres niveles; dos selectores CSS huérfanos removidos.

**Delta del backlog:** 19 entradas nuevas (61–79). Total acumulado: 79. Modelo: Opus 4.8 — UI/UX + toggle de tres niveles.

## Sesión 15 — Ajustes finos de UI: color fijo por nivel y default Adecuado (traspaso v15)

80. [UI] Default del toggle a solo-Adecuado: `showElemInsuf` inicia en `false`; el motor abre mostrando solo el % Adecuado y el desglose es opt-in.
81. [UI] Renombre del botón "Elem. + Insuf." → "Mostrar niveles Elemental e Insuficiente".
82. [UI] Texto de la nota del gap 2019-2021 reescrito a la redacción del usuario.
83. [UI/DOC] "SIMCE" → "Simce" en el motor (nota de gap + fuente) y en toda la documentación; identificadores de código (`SimceData`) intactos.
84. [UI] Tres niveles con color fijo por nivel (decisión de diseño 8.1): Adecuado #0C4682, Elemental #6BA0CE, Insuficiente #79204F, iguales en todas las entidades; los puntos que usaban `entity.color` para Adecuado pasan a `COLOR_ADEC`. `entity.color` queda solo como identidad (swatch de tarjeta, encabezado, export, borde de ficha).
85. [UI] Colores distintos en alta múltiple (causa raíz): `handleSave` fijaba un único color en las ramas region/slep; fix: dejan `color: undefined` en alta múltiple y `saveEntities` asigna un color por índice desde `ENTITY_PALETTE`.
86. [UI] Borde de color por entidad en la ficha del gráfico (1px rodeando la ficha) y color de entidad en la línea bajo el nombre en el encabezado del supergrid.
87. [UI] Reorganización de la leyenda: sale de `section-actions` a una fila propia bajo el título; "2025 preliminar" eliminado (ya está en notas); orden Baja repr. · Adecuado · Elemental · Insuficiente.
88. [UI] Sin líneas entre segmentos apilados: removido `stroke #C8BDA0`/`stroke-width 0.5` y el inset de 0.5px; los segmentos se pegan sin gap.
89. [UI] Etiquetas blancas en segmentos apilados: cada segmento (Elemental, Insuficiente) muestra su % en blanco a la base si el alto ≥16px; en modo solo-Adecuado la etiqueta se mantiene encima en azul.
90. [UI] Tipografía del sparkline ampliada (etiqueta % 8.5→10.5, año 8→9.5, asterisco 9→10.5, radio de punto 2.2→2.6).
91. [DOC] Documentación actualizada al estado actual (md+html de presentación, arquitectura.html, README): "Simce", colores fijos por nivel, default solo-Adecuado, desglose de tres niveles.

**Delta del backlog:** 12 entradas nuevas (80–91). Sin reclasificación de taxonomía. Total acumulado: 91.

## Sesión 16 — Cierre en producción, auditoría depe4 y licencia Apache 2.0 (traspaso v16)

92. [REPO] Push de 6 commits a origin/main (los 5 de v15 + el commit del traspaso v15, `28f0bf3`); push `87a9f5d..28f0bf3`. Pages reconstruye desde `docs/`; sitio 200.
93. [Infra] Script de auditoría efímero `verificar_depe4.R` (raíz, read-only sobre `directorio_oficial_ee.csv`, `simce_rbd.parquet` y `simce_comunal.parquet`): reconstruye el universo depe4, mide presencia en el parquet largo, calcula el embudo de filtros por año×nivel×prueba y contrasta `n_final` vs `n_estab`. No toca pipeline ni UI.
94. [D] Auditoría depe=4 resuelta: universo = 70 EE depe4 nacionales (33 RM, 8 Bío Bío, 6 Valparaíso y O'Higgins); los 70 aparecen en `simce_rbd` (0 ausentes, 0 extra). 70 EE en 2m, solo 1 en 4b. Pérdida por filtros 1278→1254 RBD-instancias (~1.9%, toda por marca; `nalu>=10` no elimina ninguna). Delta 0 vs comunal en las 36 combinaciones. Conclusión: conteo bajo = real.
95. [DOC] Archivo de decisión D15-1 `20260611_decision_color_por_nivel.md` en `decisiones/` (replica la decisión de color fijo por nivel: alternativas, justificación, tensión resuelta). Commit `ffe14ef`.
96. [REPO] Licencia Apache 2.0 (en lugar del MIT que sugería la política §10): `LICENSE` (201 líneas, copyright Tomás Ignacio González Cifuentes — SLEP Costa Central), `NOTICE` (alcance solo-código + terceros: D3 BSD-3, pako MIT/zlib, React MIT) y `20260611_decision_licencia_apache.md`. Commit `a8e344e`.
97. [REPO] Encabezado Apache en los 6 scripts del pipeline (bloque de 6 líneas tras el banner); en `00_escanear_proyecto.R` además `Autor: Tomas` → nombre completo. Commit `a6c4c23`.
98. [DOC] Sección "Licencia" en el README: alcance código-vs-datos explícito (código Apache 2.0; datos bajo Condiciones de Uso de la Agencia de Calidad). Commit `a6c4c23`.

**Delta del backlog:** 7 entradas nuevas (92–98). Posible categoría nueva LEGAL (licencia/uso), absorbible en DOC/Infra; sin reclasificación. Total acumulado: 98.

## Sesión 17 — Segmentación visual pre/post traspaso (traspaso v17)

99. [UI] Feature: segmentación visual pre/post traspaso (`33_motor_template.html`). Helper `SimceData.anioCorteTraspaso(entity)` que devuelve el año de traspaso solo para `kind==="slep"` con `anio_traspaso ≤ ANIO_DATOS_MAX`, y `null` en los demás casos. En `SparklineSubchart`: marcador vertical punteado "traspaso" en el año de corte; los tramos del gap 2019-2021 (`pre≤2018`/`post≥2022`) se subdividen para aplicar línea dasheada (`3,2`) + opacidad 0.4 al tramo previo. Respeta el color por nivel (solo modula opacidad/estilo, no toca `COLOR_ADEC`). Commit `4197d39`.
100. [Infra] Fix: ruta del listado SLEP al nombre canónico (`30_construir_auxiliares.R`): el insumo fue renombrado a `listado_slep_2026.xlsx` (snake_case, política §2) pero el código apuntaba a `202602_Listado_SLEP_2026_vf.xlsx` y el build fallaba en el paso [4]. Actualizadas las 4 referencias; la ocurrencia en `_archivo/` no se tocó. Build OK (70 SLEP, 346 combinaciones). Commit `2b08eb6`.
101. [DOC] Política v6, §10 reconoce Apache 2.0 (`POLITICA_PROYECTO.md`): bullet `LICENSE` reescrito (MIT por defecto; Apache 2.0 con NOTICE para publicación institucional), cláusula de alcance solo-código. Cierra D16-1. Commit `32b090d`. Acción manual pendiente: reemplazar también la copia en la knowledge base del Project.

**Delta del backlog:** 3 entradas nuevas (99–101). Sin refinamientos de taxonomía ni reclasificaciones. Total acumulado: 101.

## Sesión 18 — Deploy de la segmentación a GitHub Pages (traspaso v18)

102. [REPO] Deploy: motor con segmentación a GitHub Pages (`docs/index.html`). Se regeneró el HTML con `00_build.R` (el motor de v17 no se había commiteado), se copió `40_salidas/motor_comparacion.html` (2513 KB) a `docs/index.html` y se publicó. `git status` mostró solo `docs/index.html` en stage (gobernanza OK, sin datos sensibles). Commit `39e56ef`, push `614dada..39e56ef`.

**Delta del backlog:** 1 entrada nueva (102). Sin refinamientos de taxonomía ni reclasificaciones. Total acumulado: 102.

## Sesión 19 — Gobernanza 4b/depe4 y suite suitedoc (traspaso v19)

103. [Gobernanza/Auditoría] Evaluación y cierre del pendiente 4b/depe4: se constató que `cod_depe2` es eje de segmentación real (selector "Dependencia" + `generateSeriesByDepe`) y que todo punto con `n_estab===1` ya expone el RBD (tooltip "un solo establecimiento (RBD …)") y el nombre (popup "Ver establecimientos"), lo cual es deliberado y fundado en la decisión D-nombres. Conclusión: no implementar supresión. Sin cambios de código.
104. [DOC] Implementación de la suite `suitedoc` (`documentar.R` + 4 HTML): reverse-engineering de la API de `suitedoc` 0.3.0 desde el `documentar.R` del proyecto hermano; `cfg` poblada desde el escáner, el README, los scripts 30–33, el traspaso v18 y la decisión de nombres; contenido invertido donde difiere (agregación ponderada por evaluados, GSE inviolable); runtime/deploy verificados contra el código real (React/ReactDOM/Babel por CDN unpkg con SRI, D3/pako inline; deploy a `docs/` manual). `here::i_am()` añadido para correr vía `Rscript`.
105. [DOC] Auditoría de la suite, ajuste y versionado: auditados los 4 HTML (fieles, sin residuos del ejemplo de fábrica, terminología SLEP correcta); único ajuste de contenido: se quitaron dos referencias al "proyecto hermano" en las decisiones de Agregación ponderada y GSE inviolable (autocontención del manual). Regenerada y versionada (`git add` de `.gitignore` + `documentar.R` + 4 HTML + `suite_estilos.css`; `fonts/` y `assets/` al `.gitignore`). Commit `e9b251d`, push `0bb504c..e9b251d`.

**Delta del backlog:** 3 entradas nuevas (103–105). Sin reclasificaciones. Total acumulado: 105.
