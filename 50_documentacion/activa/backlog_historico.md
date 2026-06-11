# Backlog histórico acumulativo — slep_simce_adecuado

- **Cobertura:** sesiones 1–13 (traspasos v01–v13). Consolidado v01–v10 el 2026-06-09 (sesión 11); deltas s11, s12 y s13 anexados por su traspaso respectivo.
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
