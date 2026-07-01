# Backlog histórico acumulativo — slep_simce_adecuado

- **Cobertura:** sesiones 1–22 (traspasos v01–v22). Consolidado v01–v10 el 2026-06-09 (sesión 11); deltas s11–s22 anexados por su traspaso respectivo (s14–s19 reconstruidos en la sesión 20).
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

1. Creación del repo en GitHub y scaffold completo de directorios. [REPO]
2. Pipeline de datos completo (scripts 30–32): lectura, normalización, auxiliares y agregación comunal; 185.378 filas brutas → 32.134 agregaciones comunales × GSE, 9 años, 2 niveles, 2 pruebas. [P]
3. Motor de comparación como HTML standalone con React + D3 (supergrid entidades × GSE, sparklines, barras de últimas 3 aplicaciones, tabla con heat map), rediseñado sobre el prototipo Claude Design. [UI]
4. Detección y resolución de 4 anomalías en datos crudos de la Agencia (A1–A4), documentadas en `referencia_glosas_simce.md`. [D]

## Sesión 2 — Dimensión depe2, sleps_chile y rediseño UI (traspaso v02)

5. Incorporación de `cod_depe2` a `simce_rbd.parquet` y `simce_comunal.parquet`. [P]
6. Construcción de `sleps_chile.parquet` desde el listado oficial de SLEPs 2026 (cierre de P1); desbloqueó la comparación por SLEP. [P]
7. Rediseño de la UI: flujo comuna + dependencia + nivel/prueba, modal con 3 tabs (Comuna/SLEP/Grupo), heatmap con umbrales fijos, años descendentes, foco por año, filtro GSE, popup de establecimientos. [UI]
8. Renombre del template a prefijo `33_` según convención de auxiliares numerados. [REPO]

## Sesión 3 — Bugs UI, exportación CSV y UX de tabla (traspaso v03)

9. Resolución de B3 (popup de establecimientos): fix de crash, extensión a toda entidad, filtrado por RBD × nivel × prueba con nuevo catálogo `establecimientos_chile.parquet`. [UI]
10. Exportación CSV (cierre de P3) con separador `;` y BOM UTF-8 para Excel chileno. [UI]
11. Resolución parcial de B2: semillas iniciales con `depe2="5"` (SLEP); decisión razonada de no filtrar por `depe2="1"` (comunas Costa Central sin registros municipales post-traspaso). [UI]
12. Mejoras de UX: supergrid con columnas dinámicas, etiquetas de barras arriba, conteo de establecimientos en chip, búsqueda de comuna por input libre, límite de 4 entidades, corrección de leyendas. [UI]

## Sesión 4 — Orquestador y entidades región/establecimiento (traspaso v04)

13. Orquestador `00_build.R` (cierre de P4): ejecuta los 4 scripts del pipeline en orden con timer. [Infra]
14. Entidades tipo región y establecimiento (cierre de P6): tabs en modal, agregación desde `simce_comunal`, buscador 3+ caracteres con datos desde `simce_rbd.parquet`. [UI]
15. Popup de celda GSE (cierre de P7) con nuevo catálogo `rbd_gse` inyectado en el JSON. [UI]
16. Correcciones varias: nombres de región oficiales, nota metodológica de fórmula, texto de objetivo en header, reorden de tabs, bug de establecimiento repetido en GSEs, C stack overflow en R, corte del 100% en SVG. [UI]

## Sesión 5 — Exportación SVG, tooltip interactivo y escáner (traspaso v05)

17. Exportación del supergrid como SVG compuesto vectorial (primera parte de P2). [UI]
18. Tooltip interactivo: hover con datos fijos, clic fija el tooltip y habilita "Ver establecimientos (N) ▸" hacia `EstabPopup` filtrado por entidad × GSE × año. [UI]
19. Limpieza del estado `region`/`setRegion` sin uso en el tab de comunas (D3-cleanup). [DT]
20. Escáner con 4 outputs (cierre de P5): aliases `.md`/`.txt` + snapshots con timestamp. [Infra]
21. Nota metodológica sobre Estándares de Aprendizaje en el motor. [DOC]

## Sesión 6 — Auditoría de agregación y entidad nacional (traspaso v06)

22. Auditoría de reproducibilidad de la agregación comunal desde RBD: diferencia cero en 44.975 filas; valida `simce_comunal` como fuente del cálculo nacional. [P]
23. Entidad nacional "Chile" (cierre de P8) con resolución de 3 bugs encadenados (ramas faltantes en subcharts, guard de `entity.comunas`, orden de filtros en `EstabPopup`). [UI]
24. Commit `b47e1d5` pusheado a main. [REPO]

## Sesión 7 — Portabilidad cross-OS y cierre de deuda técnica (traspaso v07)

25. Portabilidad Windows: xlsx de SIMCE versionados en el repo (datos públicos, 22 MB), `.Rproj` con `Encoding: UTF-8`, pipeline verificado en Windows (R 4.5.1, Positron). [REPO]
26. Cierre de DT6.2: `auditoria_agregacion_comunal.R` movida a `_archivo/`. [DT]
27. Cierre de DT6.1: extracción de `getSeriesForEntity` en `SimceData`, eliminando cinco copias del ternario de despacho por `kind`. Regla arquitectónica vigente. [DT]

## Sesión 8 — Bugs UX del motor y warning de pipeline (traspaso v08)

28. Clamp del tooltip al viewport en `show()` y `pin()` (cierre de B8.1). [UI]
29. Normalización NFD de diacríticos en los 4 buscadores del modal (cierre de B8.2). [UI]
30. Prioridad de matches por nombre sobre matches por región en `filteredComunas` y slice de 30 → 60 (cierre de B8.3). [UI]
31. Eliminación del warning `pivot_wider` en sanity check de `32_agregar_comunal.R` re-agregando ponderadamente antes del pivot (cierre de B8.4). [P]

## Sesión 9 — Publicación y gobernanza (traspaso v09)

32. Cierre en Git del trabajo pendiente de la sesión 8. [REPO]
33. Publicación del motor en GitHub Pages. [REPO]
34. Documentación del procedimiento de publicación. [DOC]
35. Escáner con auto-poda de snapshots. [Infra]
36. Limpieza de artefactos obsoletos. [REPO]
37. Consolidación de `estructura_proyecto.md` en README. [DOC]

## Sesión 10 — Documentación visual/conceptual y simplificación UI (traspaso v10)

38. Diagrama de arquitectura HTML standalone (insumos → 30 → 31 → 32 → 33 → motor), con A1–A4 representadas como normalizaciones resueltas. [DOC]
39. Actualización de `CLAUDE.md` al estado real post-v09. [DOC]
40. Presentación conceptual del proyecto (md + html) para lectores internos. [DOC]
41. Remoción del panel de ajustes del motor (P3): densidad fija "cómoda", `showElemInsuf`/`yScale` hardcodeados. [UI]
42. Eliminación de la franja de leyenda bajo la tabla y contacto al pie de las notas (P4 reformulado). [UI]
43. Deploy a Pages y sincronización de snapshots. [REPO]

## Sesión 11 — Limpieza CSS, POLITICA v4, exportación PNG y consolidación del backlog (traspaso v11)

44. Limpieza quirúrgica de CSS huérfano en `33_motor_template.html` (cierre del pendiente 2 de v10): bloque `TweaksPanel` completo (24 reglas `.twk-*`), 9 reglas `.is-compact`, `.table-legend` (2 reglas), `.dot-prelim` (huérfano adicional detectado) e icono `gear` sin uso. 3.208 → 3.098 líneas. [UI]
45. Verificación y cierre del pendiente 4 de v10 (estado `region` huérfano en tab comuna): ya había sido resuelto en la sesión 5 (ítem 19 de este backlog); el registro de v10 estaba obsoleto. Cerrado sin cambio. [DT]
46. Sustitución de `POLITICA_PROYECTO.md` local por la canónica v4 (cierre del pendiente 1 de v10). [REPO]
47. Exportación de gráficos a PNG (cierre completo de P2): refactor de `exportarGraficos` en `construirSvgGraficos` (constructor puro) + `descargarBlob` + `exportarGraficosSVG` + `exportarGraficosPNG` (rasterización canvas con `PNG_SCALE = 2`); dos botones SVG/PNG en la sección de resultados. [UI]
48. Consolidación del backlog histórico v01–v10 como documento vivo (`50_documentacion/activa/backlog_historico.md`, este archivo), con regla de mantenimiento por delta (cierre del pendiente 6 de v10). [DOC]
49. Exclusión de `_archivo/` en `.gitignore` (alineación con POLITICA §1.6) y versionado del `traspaso_cierre_v10.md` que estaba sin trackear. [REPO]
50. Dos deploys a GitHub Pages: motor sin CSS huérfano (`f0cd824`) y motor con exportación SVG/PNG (`b77eec0`). [REPO]

## Sesión 12 — Compresión gzip, SLEP traspaso 2026 y auditoría de supresión (traspaso v12)

51. Enlace de la documentación nueva (conceptual md/html, arquitectura html, backlog histórico) en la sección "Documentación" del `README.md`, con aclaración de que los `.html` no se publican por Pages (solo `docs/`). [DOC]
52. Migración de la descarga de `exportarCSV` al helper `descargarBlob` (cierre del pendiente DRY de v11): una sola implementación de descarga en el motor; comportamiento del CSV idéntico. [DT]
53. Compresión del JSON embebido con gzip + base64, descomprimido en cliente con pako (`__PAKO_INLINE__`): `33_generar_html.R` comprime (`memCompress` + `base64_enc`, con `gsub` para quitar saltos de línea MIME que rompían el literal JS), `pako.min.js` añadido a `10_utils/`. Peso del HTML de 14.531 KB a ~1.830 KB (13% del original, muy bajo el criterio ≤50% de v11). Cierra el pendiente de optimización de peso. [UI]
54. Inclusión de SLEP con traspaso prospectivo (2026) en `30_construir_auxiliares.R`: rama que incorpora los RBDs municipales (`COD_DEPE ∈ {1,2}`) de las comunas de los 10 SLEP cuyo traspaso es el año siguiente al último dato (constante `ANIO_DATOS_VIGENTE`). Catálogo de 26 a 36 SLEP, +630 RBDs. Marca visual en el motor (badge "traspaso 2026", sufijo en meta-label, nota metodológica) vía helper `slepEsProspectivo` derivado de `max(YEARS)`. [P]
55. Corrección de raíz de la selección de establecimientos por SLEP: el motor reconstruía el universo del SLEP por comuna+`cod_depe2`, lo que (a) vaciaba los SLEP prospectivos (sus RBDs son municipales, no depe 5) y (b) podía incluir RBDs ajenos. `generateSeriesByRbd` reescrita para agregar ponderado por `nalu` sobre `entity.rbds` exactos desde `simce_rbd`; popups, conteos y tooltip migrados a `entity.rbds` como fuente única de verdad. Helper `depe2CodesParaSlep` introducido y luego retirado al volverse innecesario. [UI]
56. Auditoría y corrección de supresión de la Agencia: los popups listaban establecimientos cuyo resultado fue suprimido por confidencialidad (`palu_eda_ade = NA` con `nalu > 0`), porque los catálogos `rbds_por_nivel` y `rbd_gse` se construían con `distinct()` sin filtrar `palu`. Confirmado contra el sitio oficial de la Agencia (RBD 1131 muestra "-" en 2025). Filtro `!is.na(palu_eda_ade)` añadido en `33_generar_html.R` (ambos catálogos) y guard `D2.palu[i] != null` en el popup de celda del motor. Bug latente desde la sesión 4; expuesto (no causado) por la entrada de SLEP rurales con el traspaso 2026. `RBDs×GSE` de 42.134 a 34.255; `RBDs×nivel` de 23.026 a 21.402. [UI]

**Delta del backlog:** 6 entradas nuevas (51–56). Sin reclasificación de taxonomía. La categoría UI sigue dominante; DT y P con presencia por los dos fixes de raíz.

## Sesión 13 — Auditoría pre-lanzamiento (traspaso v13)


## Sesión 23 — Estado por defecto del motor y auditoría de suite standalone (traspaso v23)

117. [UI] Estado por defecto del motor = 4 comunas del SLEP Costa Central con dependencia Servicio Local (depe2="5"), en montaje y reset; derivación en runtime sin hardcodear códigos (`entidadesPorDefecto()`). Commit `4d647df`.
118. [DOC] Regeneración de la suite standalone offline a pedido del titular; resultó determinista byte-idéntica (no-op de versionado, sin commit).
119. [DOC] Auditoría minuciosa de los 4 `*_standalone.html`: red real 0 verificada, `946` en general identificado como falso positivo (base64 de fuente), `MRUN` en general confirmado heredado/aceptado. Sin commit (análisis).
120. [DOC] README: subtítulo sin "comunal" (el motor compara entidades de todo nivel). Commit `f87a3f7`.

**Delta del backlog:** 4 entradas nuevas (117–120). Sin reclasificación (D20-3). Total acumulado: 120.

## Sesión 24 — Cierre de backlog y pendientes de documentación (traspaso v24)

121. [DOC] Anexo del delta de la sesión 23 al backlog (entradas 117–120) y actualización de cobertura a 1–23. Commit `8944c2e`.
122. [DOC] Reseña final versionada como espejo verbatim del bloque `orden: 3` de `data.js` del portafolio del Área. Commit `d4051d0`.
123. [DOC] Retiro de 7 marcas `# REVISAR (voz)` de `documentar.R` (6 inline + nota de L23); la marca `# REVISAR (decisión)` restante se conservó. Commit `ef2aded`.
124. [DOC] Normalización de todos los tags del detalle cronológico a la taxonomía canónica de 7 códigos (D20-3): entradas 1–56 de `— CÓDIGO` a `[CÓDIGO]`; tags compuestos libres mapeados por intención primaria. Commit `572324a`. **Nota de bug (A-s25-1):** este mismo commit truncó por error las secciones de sesión 23–24 (entradas 117–120) del archivo; reparado en la sesión 25 (ver entrada 126).

**Delta del backlog:** 4 entradas nuevas (121–124). Sin reclasificación adicional de taxonomía. Total acumulado: 124.

## Sesión 25 — Renombrado UI "entidad" → "territorio" y reparación de backlog truncado (traspaso v25)

125. [UI] Renombrado del concepto de UI "entidad" a "territorio" en 33 líneas de texto visible, comentarios y header CSV exportado de `33_motor_template.html`; identificadores de código (`entidadDependeSlep`, `entidadesPorDefecto`, `MAX_ENTIDADES`, `entities`/`entity`) intocables por decisión explícita. Encargo autónomo ejecutado por Claude Code, verificación de conteos exacta. Commit `0c70db0`.
126. [DOC] Reparación del bug A-s25-1: el commit `572324a` (entrada 124) truncó las secciones de sesión 23 y 24 (entradas 117–120) al normalizar tags; reinsertadas desde `8944c2e` con tags ya en formato canónico `[CÓDIGO]`.
127. [DOC] `POLITICA_PROYECTO.md` versionado por primera vez (antes untracked). Commit `c9841d8`.
128. [REPO] Regeneración y deploy de `docs/index.html` con el cambio de renombrado; solo `docs/index.html` en stage (gobernanza OK). Commit `98d489f`.

**Delta del backlog:** 4 entradas nuevas (125–128). Total acumulado: 128.
