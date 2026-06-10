# Backlog histórico acumulativo — slep_simce_adecuado

- **Cobertura:** sesiones 1–10 (traspasos v01–v10), consolidado el 2026-06-09 (sesión 11).
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
