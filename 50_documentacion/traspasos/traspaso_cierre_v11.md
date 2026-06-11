# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v11
- **Fecha:** 2026-06-09
- **Sesión:** 11 — Cierre de pendientes heredados de v10: limpieza de CSS huérfano del motor, sustitución de `POLITICA_PROYECTO.md` por la canónica v4, exportación de gráficos a PNG (cierre completo de P2) y consolidación del backlog histórico v01–v10 como documento vivo.
- **Modelo utilizado:** Claude Fable 5 (web, sesión de diseño/implementación asistida; usuario ejecuta localmente)
- **Entorno:** R / JavaScript (template HTML) / Git
- **Archivos principales modificados:**
  - `30_procesamiento/33_motor_template.html`
  - `POLITICA_PROYECTO.md`
  - `50_documentacion/activa/backlog_historico.md` (nuevo)
  - `.gitignore`
  - `docs/index.html` (deploy, ×2)

---

## 2. Resumen ejecutivo

La sesión abordó la ruta planificada en la apertura: cinco de los siete pendientes de v10 quedaron cerrados. Se ejecutó la limpieza quirúrgica del CSS huérfano del motor (bloque `TweaksPanel` completo, reglas `.is-compact`, `.table-legend`, `.dot-prelim` e icono `gear`; 110 líneas eliminadas), verificada con grep cero residuos, parser JSX y build limpio. Se descubrió que el pendiente 4 (estado `region` huérfano) ya había sido resuelto en la sesión 5 — el registro de v10 estaba obsoleto — y se cerró sin cambio. Se sustituyó la `POLITICA_PROYECTO.md` local por la canónica v4. Se completó P2 agregando exportación PNG: la función de exportación SVG se refactorizó en un constructor puro (`construirSvgGraficos`) del que cuelgan ambos exportadores, y el PNG se rasteriza vía canvas a escala 2x. Finalmente se consolidó el backlog histórico v01–v10 (50 ítems al cierre) como documento vivo en `50_documentacion/activa/backlog_historico.md`, eliminando de forma definitiva la nota de continuidad heredada de v09; de paso se alineó `.gitignore` con POLITICA §1.6 (`_archivo/` excluido) y se versionó el traspaso v10 que estaba sin trackear. El proyecto cierra sin bugs activos, con seis commits pusheados (`5496b9c` → `93642b5`) y el motor publicado en GitHub Pages con la nueva exportación. Quedan dos pendientes: enlazar la documentación nueva en el README (no abordado por falta del archivo en sesión) y la optimización del peso del HTML (diferible).

---

## 3. Estado del proyecto al cierre

**Qué funciona:**
- Pipeline completo verificado dos veces en macOS esta sesión: `00_build.R` corre limpio en ~3 segundos, sin warnings.
- Motor HTML: exportación CSV, **SVG y PNG** operativas (PNG verificado por el usuario en navegador). Todas las funcionalidades previas intactas.
- Publicado en GitHub Pages (`docs/index.html`, commit `b77eec0`).
- Repo limpio y sincronizado con `origin/main` en `93642b5`; `_archivo/` ya no aparece en `git status`.

**Qué no funciona:**
- Ningún bug activo conocido al cierre.

**Qué cambió respecto al traspaso v10:**
- `33_motor_template.html`: −110 líneas de CSS/iconografía huérfana; +37 líneas netas de exportación PNG (3.208 → 3.135 líneas finales).
- `POLITICA_PROYECTO.md`: copia local antigua (63 líneas) reemplazada por canónica v4 (628 líneas).
- Nuevo `50_documentacion/activa/backlog_historico.md` (documento vivo, 50 ítems).
- `.gitignore`: `_archivo/` agregado.
- `traspaso_cierre_v10.md` versionado (estaba untracked).

---

## 4. Registro detallado de cambios realizados

#### Cambio 1: Limpieza quirúrgica de CSS huérfano e icono sin uso

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI
- **Qué se hizo:** Eliminación de: (a) bloque completo `/* TweaksPanel (versión standalone) */` con 24 reglas `.twk-*` (L859–948 de la versión previa); (b) 9 reglas `.is-compact` (L124, 126–129, 138, 166–167, 192), conservando `.app.is-comfy`; (c) `.table-legend` (2 reglas, L699–705); (d) `.dot-prelim` (L706), huérfano adicional no listado en v10 — solo lo consumía la franja de leyenda removida en sesión 10; (e) entrada `gear` del catálogo del componente `Icon` (L1438). Resultado: 3.208 → 3.098 líneas.
- **Por qué se hizo:** Deuda técnica registrada en v10 tras la remoción del panel de ajustes (sesión 10): el CSS quedó sin consumidores.
- **Cómo se verificó:** (1) grep de `twk-`, `is-compact`, `table-legend`, `dot-prelim`, `gear`, `TweaksPanel` = 0 coincidencias; (2) `.btn-ghost`/`.btn-small` conservados tras confirmar que los usan el botón de presets y el Cancelar del modal (precaución explícita de v10); (3) la marca de dato preliminar de la tabla usa `td-prelim`/`th-prelim`/`prelim-mark`, que siguen en uso; (4) llaves CSS balanceadas (255/255); (5) sintaxis del bloque JSX validada con `@babel/parser`; (6) `00_build.R` limpio; (7) verificación visual del usuario.
- **Líneas o secciones clave:** ver rangos en "Qué se hizo".
- **Dependencias afectadas:** Ninguna (todo lo eliminado carecía de consumidores).

#### Cambio 2: Cierre del pendiente 4 (estado `region` huérfano) sin modificación

- **Archivo(s) afectado(s):** Ninguno.
- **Categoría temática:** DT
- **Qué se hizo:** Auditoría de los 12 estados `useState` de `AddEntityModal`: todos tienen consumo (`selectedRegion`/`regionSearch` alimentan el tab región; `comunaCod`/`depe2` el tab comuna, etc.). No existe estado huérfano.
- **Por qué se hizo:** El pendiente venía registrado en v10 como deuda D3.
- **Cómo se verificó:** grep de declaración y consumo de cada estado.
- **Líneas o secciones clave:** L2613–2616 (declaraciones del modal).
- **Dependencias afectadas:** Ninguna.
- **Nota de causa raíz:** la limpieza ya se había hecho en la **sesión 5** (ítem 19 del backlog histórico). El registro de v10 arrastraba un pendiente obsoleto. Lección registrada en sección 7.

#### Cambio 3: Sustitución de `POLITICA_PROYECTO.md` por la canónica v4

- **Archivo(s) afectado(s):** `POLITICA_PROYECTO.md` (raíz del repo)
- **Categoría temática:** REPO
- **Qué se hizo:** Reemplazo de la copia local resumida (63 líneas, con nota de "copia local") por la canónica v4 íntegra de la knowledge base (628 líneas).
- **Por qué se hizo:** Pendiente 1 de v10 (dos desfases conocidos respecto a la canónica).
- **Cómo se verificó:** `grep -m1 "Versión" POLITICA_PROYECTO.md` devuelve "Versión 4 — vigente y definitiva". Commit `dd10557` (599 inserciones, 63 deleciones).
- **Líneas o secciones clave:** archivo completo.
- **Dependencias afectadas:** Ninguna operativa; nota: la v4 exige prefijo numérico en **todos** los archivos (§2.2), lo que el proyecto ya cumple en lo esencial.

#### Cambio 4: Exportación de gráficos a PNG (cierre completo de P2)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI
- **Qué se hizo:** (a) `exportarGraficos` renombrada a `construirSvgGraficos`; ahora es un constructor puro que retorna `{svgStr, totalW, totalH, fnameBase}` en vez de descargar. (b) Nuevo helper `descargarBlob(blob, fname)`. (c) `exportarGraficosSVG`: comportamiento idéntico al exportador previo. (d) `exportarGraficosPNG`: serializa el mismo SVG compuesto, lo carga como `Image` desde blob URL, lo dibuja en un canvas escalado por `PNG_SCALE = 2` y descarga vía `canvas.toBlob`; con manejo de error en `onerror` y en `toBlob` nulo. (e) El botón "Exportar gráficos" se desdobló en "Exportar SVG" (icono `chart`) y "Exportar PNG" (icono `image`, que estaba sin uso en el catálogo).
- **Por qué se hizo:** P2 pedía exportación PNG/SVG; el SVG existía desde la sesión 5, faltaba PNG.
- **Cómo se verificó:** Sintaxis JSX validada con `@babel/parser`; cero referencias huérfanas a `exportarGraficos`; build limpio; **verificación funcional del usuario en navegador** (ambos botones descargan correctamente).
- **Líneas o secciones clave:** L2145–2147 (constructor), L2344 (`descargarBlob`), L2353 (`exportarGraficosSVG`), L2361 (`exportarGraficosPNG`), L2980–2981 (botones).
- **Dependencias afectadas:** Ninguna. `exportarCSV` mantiene su propia lógica de descarga (oportunidad DRY menor, ver 11.2).
- **Tensiones entre principios:** ninguna; la rasterización del SVG existente reutiliza código (C.5) sin agregar dependencias.

#### Cambio 5: Consolidación del backlog histórico como documento vivo

- **Archivo(s) afectado(s):** `50_documentacion/activa/backlog_historico.md` (nuevo)
- **Categoría temática:** DOC
- **Qué se hizo:** Documento con los 43 ítems de las sesiones 1–10, numerados correlativamente, derivados de los resúmenes ejecutivos de v01–v07 (extraídos con `awk` por el usuario), el traspaso v08 íntegro y los deltas de v09–v10 registrados en v10. Incluye la taxonomía vigente y una **regla de mantenimiento**: los traspasos futuros documentan solo su delta y lo anexan a este archivo; nunca duplican el histórico. Los ítems 44–50 de esta sesión 11 ya están anexados.
- **Por qué se hizo:** Pendiente 6 de v10 (nota de continuidad heredada de v09, dos sesiones sin resolver).
- **Cómo se verificó:** Cobertura contrastada sesión por sesión contra los resúmenes fuente. Commit `93642b5`.
- **Líneas o secciones clave:** archivo completo.
- **Dependencias afectadas:** Modifica el contrato de la sección 5 de los traspasos futuros (ver DD11.1 y sección 12).

#### Cambio 6: Gobernanza del repo — `.gitignore` y traspaso v10

- **Archivo(s) afectado(s):** `.gitignore`, `50_documentacion/traspasos/traspaso_cierre_v10.md`, `50_documentacion/estructura/` (rotación de snapshots)
- **Categoría temática:** REPO
- **Qué se hizo:** Se agregó `_archivo/` a `.gitignore` (estaba apareciendo como untracked, en contradicción con POLITICA §1.6); se versionó el traspaso v10 que nunca se había commiteado; se commiteó la rotación de snapshots del escáner (auto-poda de sesión 9 funcionando según diseño).
- **Por qué se hizo:** Hallazgos del `git status` durante el commit del backlog.
- **Cómo se verificó:** Commit `93642b5` pusheado; `_archivo/` ya no aparece en status.
- **Líneas o secciones clave:** última línea de `.gitignore`.
- **Dependencias afectadas:** Ninguna.

---

## 5. Backlog acumulativo del proyecto

> **Nuevo régimen (DD11.1):** el backlog acumulativo vive en `50_documentacion/activa/backlog_historico.md` como documento permanente. Este traspaso y los futuros documentan **solo su delta** y lo anexan allí, continuando la numeración. La nota de continuidad heredada de v09 queda **resuelta definitivamente**.

### 5.1 Objetivo del proyecto

`slep_simce_adecuado` es un motor interactivo standalone (HTML autocontenido, React 18 + D3 v7) que compara la proporción de estudiantes que alcanzan el estándar de aprendizaje "Adecuado" en SIMCE entre comunas, SLEPs, regiones, establecimientos, grupos personalizados y el agregado nacional, siempre segmentado por GSE. El pipeline es R puro: `xlsx (Agencia de Calidad) → R → Parquet → JSON embebido → HTML (~14,5 MB)`, orquestado por `00_build.R`. Está publicado en `https://tomgc.github.io/slep_simce_adecuado/`. Cubre 9 años (2014–2025, con brecha 2019–2021 y 2025 preliminar), 2 niveles (4B, 2M) y 2 pruebas (Lectura, Matemática). El desarrollo comenzó en la sesión 1 y lleva 11 sesiones.

### 5.2 Nota metodológica

Cada ítem del backlog representa una solicitud distinguible del usuario, no las acciones técnicas para implementarla. Los errores introducidos por el asistente y corregidos en la misma iteración no se cuentan; sí los bugs reportados por el usuario. La clasificación temática es aproximada (intención primaria). Fuentes: traspasos v01–v11 e historial de sesiones.

### Delta de la sesión 11 (ítems 44–50 del backlog histórico)

44. Limpieza quirúrgica de CSS huérfano en el motor (cierre pendiente 2 de v10). — UI
45. Verificación y cierre del pendiente 4 de v10 (`region` huérfano): ya resuelto en sesión 5; registro obsoleto. — DT
46. Sustitución de `POLITICA_PROYECTO.md` por canónica v4 (cierre pendiente 1). — REPO
47. Exportación PNG con refactor del constructor SVG (cierre completo de P2). — UI
48. Consolidación del backlog histórico v01–v10 como documento vivo (cierre pendiente 6). — DOC
49. `_archivo/` excluido en `.gitignore` y traspaso v10 versionado. — REPO
50. Dos deploys a GitHub Pages (`f0cd824`, `b77eec0`). — REPO

### 5.3 Clasificación temática (taxonomía vigente, 50 cambios acumulados)

| Código | Categoría | N° aprox. | % |
|--------|-----------|-----------|---|
| UI | Motor HTML / React / D3 (supergrid, tooltip, exportaciones, buscadores) | 21 | 42% |
| P | Pipeline R (scripts 30–33, agregación, validaciones) | 8 | 16% |
| REPO | Gobernanza del repo / Despliegue (commits, Pages, .gitignore, versionado de insumos) | 10 | 20% |
| DOC | Documentación (diagrama, presentación conceptual, notas metodológicas, backlog) | 7 | 14% |
| Infra | Infraestructura (orquestador, escáner) | 2 | 4% |
| DT | Deuda técnica (limpiezas, extracción getSeriesForEntity) | 4 | 8% |
| D | Datos / Insumos | (absorbida en P/REPO en ítems mixtos) | — |

> Conteo aproximado: varios ítems son mixtos (clasificados por intención primaria). El detalle ítem a ítem vive en `backlog_historico.md`.

### 5.4 Resumen estadístico por sesión

| Sesión | Traspaso | N° de cambios | Foco principal |
|---|---|---|---|
| 1 | v01 | 4 | Scaffold, pipeline, UI v2 |
| 2 | v02 | 4 | depe2, sleps_chile, rediseño UI |
| 3 | v03 | 4 | Bugs UI, export CSV, UX tabla |
| 4 | v04 | 4 | Orquestador, entidades región/estab |
| 5 | v05 | 5 | Export SVG, tooltip interactivo |
| 6 | v06 | 3 | Auditoría agregación, entidad nacional |
| 7 | v07 | 3 | Portabilidad cross-OS, deuda técnica |
| 8 | v08 | 4 | Bugs UX motor, warning pipeline |
| 9 | v09 | 6 | Publicación Pages, gobernanza |
| 10 | v10 | 6 | Documentación visual/conceptual, UI |
| 11 | v11 | 7 | Cierre de pendientes v10, export PNG |

**Total de cambios solicitados: 50**

### 5.6 Cambios respecto a la versión anterior del backlog

- Se agregaron 7 cambios (44–50) correspondientes a la sesión 11.
- Cambio estructural: el histórico completo migró a `backlog_historico.md` (documento vivo); los traspasos dejan de copiarlo íntegramente.

---

## 6. Bugs encontrados y su resolución

No aplica en esta sesión: no se manifestó ningún bug (ni introducido ni reportado). Los cambios fueron limpiezas, refactor de exportación y documentación, todos verificados antes de commitear.

---

## 7. Aprendizajes y restricciones técnicas descubiertas

- **Regla:** Antes de implementar un pendiente heredado de un traspaso, verificar contra el código que siga vigente.
  - **Principio relacionado:** C.11 (causa raíz) / B.4 (criterio de éxito).
  - **Contexto:** Los traspasos pueden arrastrar registros obsoletos cuando el ítem se resolvió en una sesión que no actualizó el backlog. Implementarlo a ciegas duplica trabajo o introduce regresiones.
  - **Ejemplo:** El pendiente 4 de v10 (`region` huérfano) estaba resuelto desde la sesión 5 (ítem 19 del backlog).

- **Regla:** Nunca incluir comentarios inline `#` en comandos destinados a la terminal del usuario.
  - **Principio relacionado:** C.2 (reproducibilidad de fragmentos).
  - **Contexto:** El zsh interactivo del usuario no tiene `interactivecomments` activado: `#` y lo que sigue se interpretan como argumentos o calificadores glob (`zsh: unknown file attribute`).
  - **Ejemplo:** `head -5 archivo # comentario` falló intentando abrir "comentario" como archivo; `git status # debe...` abortó con error de glob.

- **Regla:** La exportación PNG por rasterización de SVG exige que el SVG sea autocontenido (atributos inline, sin webfonts ni referencias externas); de lo contrario el canvas se contamina y `toBlob` falla.
  - **Principio relacionado:** C.5 (reuso) / B.4.
  - **Contexto:** El motor usa `system-ui` y todos los estilos de los subgráficos D3 van como atributos inline, por lo que el SVG compuesto rasteriza sin pasos adicionales. Si en el futuro se agregan clases CSS a elementos SVG, la exportación (SVG y PNG) las perderá: mantener el estilo de subgráficos como atributos.

- **Regla:** El contenedor de trabajo del asistente se reinicia entre turnos; todo archivo entregable debe copiarse a outputs y presentarse en el mismo turno en que se genera.
  - **Principio relacionado:** C.2.
  - **Contexto:** Un archivo presentado en un turno puede desaparecer del directorio de salida en el siguiente; se re-presentó dos veces el template por esto.

---

## 8. Decisiones de diseño tomadas

| ID | Decisión | Alternativas consideradas | Justificación | Implicancia |
|----|----------|---------------------------|---------------|-------------|
| DD11.1 | Backlog histórico como documento vivo en `50_documentacion/activa/backlog_historico.md`; traspasos solo anexan delta | Incrustar el histórico completo en cada traspaso (regla original del protocolo de cierre §5) | Un documento permanente elimina la deuda de consolidación de raíz; copiar 50+ ítems en cada traspaso infla los archivos y reintroduce el riesgo de divergencia | Los traspasos futuros referencian el archivo y anexan su delta continuando la numeración. Esta decisión **modifica el contrato de la sección 5** del protocolo de cierre para este proyecto |
| DD11.2 | PNG por rasterización del mismo SVG compuesto (`construirSvgGraficos` compartido) | Captura del DOM con html2canvas u otra librería | Cero dependencias nuevas; consistencia pixel-perfect entre exportes SVG y PNG; reusa código probado desde sesión 5 | Cualquier mejora futura al SVG compuesto beneficia a ambos formatos |
| DD11.3 | `PNG_SCALE = 2` como constante con nombre | Valor mágico inline; escala configurable por el usuario | C.11: decisión metodológica parametrizada; 2x equilibra nitidez en documentos vs. peso del archivo | Cambiar la resolución de exportación es editar una constante |
| DD11.4 | Helper `descargarBlob` compartido entre SVG y PNG | Duplicar la lógica de descarga en cada exportador | C.5 (DRY) | `exportarCSV` aún no lo usa (oportunidad menor, ver 11.2) |
| DD11.5 | Eliminar `.dot-prelim` aunque no estaba listado en el pendiente de v10 | Limitarse estrictamente a la lista de v10 | "Vamos a la raíz": era huérfano por la misma causa (franja de tabla removida); verificado que la marca preliminar vigente usa otras clases | Ninguna |

---

## 9. Constantes, configuraciones y parámetros vigentes

| Constante | Valor actual | Archivo | Nota |
|-----------|--------------|---------|------|
| `PNG_SCALE` | 2 | `30_procesamiento/33_motor_template.html` | **Nueva esta sesión.** Factor de rasterización del PNG exportado |
| Umbrales heatmap | ≤25 / 26–50 / 51–70 / >70 | `33_motor_template.html` | Fijos por transparencia metodológica (sesión 2) |
| Slice buscador comunas | 60 | `33_motor_template.html` | Sesión 8 (cubre RM con 52 comunas) |
| Densidad UI | "cómoda" (hardcoded) | `33_motor_template.html` | Sesión 10 (panel de ajustes removido) |
| Límite de entidades | 4 | `33_motor_template.html` | Sesión 3 |

---

## 10. Arquitectura de archivos relevante

Referencia: `50_documentacion/estructura/estructura_actual.md` (**correr `00_escanear_proyecto.R` antes de la próxima apertura**: esta sesión agregó `backlog_historico.md`, modificó `.gitignore` y el snapshot vigente es previo a los cambios).

Cambios estructurales de la sesión: nuevo `50_documentacion/activa/backlog_historico.md`; `_archivo/` dejó de ser visible para Git (alineación con POLITICA §1.6). La estructura respeta `POLITICA_PROYECTO.md` v4 y `regla_estructura_proyectos.md`.

---

## 11. Tareas pendientes, próximos pasos y ruta sugerida

### 11.1 Inventario de pendientes

#### Pendiente 1: Enlazar documentación nueva en el README

- **Descripción:** En la sección "Documentación" del `README.md`, enlazar `arquitectura_slep_simce_adecuado.html` y `documentacion_proyecto_slep_simce_adecuado.md`/`.html` (producidos en sesión 10).
- **Contexto:** Heredado de v10 (pendiente 7); no se abordó porque el `README.md` no se cargó en sesión.
- **Tipo:** Documentación.
- **Impacto:** Bajo — la documentación existe pero no es descubrible desde el README.
- **Dependencias:** Ninguna.
- **Complejidad estimada:** Baja (~5 líneas).
- **Principios relevantes:** C.11.
- **Precauciones:** Ninguna.
- **Sugerencia de enfoque:** Adjuntar `README.md` al abrir y resolverlo como primer paso (5 minutos).
- **Criterio de éxito (B.4):** Los enlaces aparecen en el README renderizado en GitHub y resuelven correctamente.

#### Pendiente 2: Optimización del peso del HTML (14,5 MB)

- **Descripción:** Reducir el peso del motor publicado (JSON embebido de 14,5 MB domina el total).
- **Contexto:** Diferido desde v10; no es bloqueante (carga aceptable en condiciones normales).
- **Tipo:** Mejora / Deuda técnica.
- **Impacto:** Carga lenta en conexiones pobres; límite blando de GitHub Pages lejano aún.
- **Dependencias:** Ninguna.
- **Complejidad estimada:** Media-alta.
- **Principios relevantes:** C.5, C.11, B.2.
- **Precauciones:** Cualquier compresión (p. ej. JSON → estructura columnar, pako/gzip + decodificación en cliente) debe preservar la integridad de los datos y la regla de GSE inviolable; requiere criterio de éxito definido **antes** de optimizar (lección de sesiones previas sobre iteración sin criterio).
- **Sugerencia de enfoque:** Medir primero la composición del peso (JSON vs D3 vs template); evaluar codificación columnar de `DATA.datos` antes que compresión binaria.
- **Criterio de éxito (B.4):** Peso final ≤ 50% del actual con render y datos idénticos (validación por checksum de los datos decodificados).

#### Pendiente 3 (menor): Migrar `exportarCSV` al helper `descargarBlob`

- **Descripción:** `exportarCSV` mantiene su propia lógica de descarga, duplicando lo que ahora hace `descargarBlob`.
- **Contexto:** Detectado en el refactor de P2; no se tocó para mantener el commit atómico.
- **Tipo:** Deuda técnica.
- **Impacto:** Mínimo (duplicación de ~8 líneas).
- **Complejidad estimada:** Baja.
- **Principios relevantes:** C.5.
- **Criterio de éxito (B.4):** CSV descarga idéntico; una sola implementación de descarga en el template.

### 11.2 Evaluación de deuda técnica

- **Oportunidad de mejora:** `exportarCSV` con descarga propia (ver Pendiente 3).
- No se observaron zonas frágiles nuevas; `SimceData.getSeriesForEntity` sigue siendo el punto de entrada único de series.

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? (C.8) → **Sí** — sin cambios en la lógica del pipeline; sanity checks intactos y build limpio.
- ¿Los outputs son reproducibles e idempotentes? (C.2, C.3) → **Sí** — `00_build.R` corrió limpio dos veces en la sesión (3 s).
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? (C.11) → **Sí** — `PNG_SCALE = 2` nombrada y comentada.

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

1. **README: enlazar documentación nueva** — cierre rápido del último pendiente administrativo de v10; criterio: enlaces funcionando en GitHub.
2. **Migrar `exportarCSV` a `descargarBlob`** — DRY de 10 minutos mientras el template está fresco; criterio: descarga idéntica.
3. **Optimización del peso del HTML** — abordarlo como foco principal solo si se le dedica la sesión completa, con medición previa y criterio de éxito definido antes de tocar código.

**Diferir para sesión posterior:**
- Funcionalidad nueva (p. ej. filtro por dependencia en panel de entidades, datos 8b si la Agencia los publica) — el backlog funcional está limpio; conviene decidir la dirección con el usuario.

---

## 12. Instrucciones específicas para la próxima sesión

- 🔒 La segmentación por GSE es inviolable: todo componente que muestre datos respeta el filtro `gse`.
- 🔒 `SimceData.getSeriesForEntity` es el punto de entrada único de la lógica de series. No agregar ternarios inline por `kind`.
- 🔒 **Nuevo régimen de backlog (DD11.1):** al cerrar la próxima sesión, documentar solo el delta en el traspaso y **anexarlo a `50_documentacion/activa/backlog_historico.md`** continuando la numeración (próximo ítem: 51). No copiar el histórico al traspaso.
- ✅ **ANTES** de abrir: correr `00_escanear_proyecto.R` (el snapshot vigente es previo a los cambios de esta sesión).
- ✅ **DESPUÉS** de cualquier cambio en `33_motor_template.html`: `Rscript 00_build.R`, verificación visual local, y solo entonces `cp 40_salidas/motor_comparacion.html docs/index.html` + commit + push.
- ✅ Al agregar buscadores al modal, aplicar `norm()` en ambos lados de la comparación.
- ⚠️ Si se agregan estilos a elementos SVG de los subgráficos, usar **atributos inline**, no clases CSS — las clases se pierden en la exportación SVG/PNG (ver sección 7).
- ⚠️ No incluir comentarios `#` inline en comandos para la terminal del usuario (zsh interactivo sin `interactivecomments`).

---

## 13. Fragmentos de código de referencia

### Exportación PNG desde SVG compuesto (patrón canónico)

```javascript
// El constructor es puro: retorna el SVG serializado y sus dimensiones.
// Ambos exportadores cuelgan de él — nunca duplicar la construcción.
const PNG_SCALE = 2; // C.11: factor de rasterización con nombre

function exportarGraficosPNG({ entities, nivel, prueba }) {
  const { svgStr, totalW, totalH, fnameBase } = construirSvgGraficos({ entities, nivel, prueba });
  const url = URL.createObjectURL(new Blob([svgStr], { type: "image/svg+xml;charset=utf-8" }));
  const img = new Image();
  img.onload = () => {
    const canvas = document.createElement("canvas");
    canvas.width = totalW * PNG_SCALE;
    canvas.height = totalH * PNG_SCALE;
    const ctx = canvas.getContext("2d");
    ctx.scale(PNG_SCALE, PNG_SCALE);
    ctx.drawImage(img, 0, 0, totalW, totalH);
    URL.revokeObjectURL(url);
    canvas.toBlob(blob => { if (blob) descargarBlob(blob, fnameBase + ".png"); }, "image/png");
  };
  img.onerror = () => URL.revokeObjectURL(url);
  img.src = url;
}
```

### Descarga de blob (helper único)

```javascript
function descargarBlob(blob, fname) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = fname;
  a.click();
  URL.revokeObjectURL(url);
}
```

### Extracción de resúmenes ejecutivos desde traspasos (para consolidaciones)

```bash
for f in 50_documentacion/traspasos/traspaso_cierre_v0{1..7}.md; do
  echo "=== $f ==="
  grep -m1 -- "Sesión:" "$f"
  awk '/^## 2\./{p=1;next} /^## /{p=0} p' "$f"
done
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 12 (Opus)`
(Reemplazar "Opus" por el modelo que vayas a usar.)

**Mensaje de apertura:**

> Continuación de sesión sobre el proyecto **slep_simce_adecuado**.
>
> Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de estructura y principios de desarrollo) viven en la knowledge base de este Project; léelos desde ahí. Adjunto el traspaso, el escáner actual y los archivos críticos de la sesión anterior.
>
> Por favor sigue el protocolo de apertura definido en mis userPreferences y entrega el plan de trabajo en el formato estándar (Estado al cierre / Pendientes / Ruta propuesta / Decisiones que necesitas), basado en el handoff adjunto.

**Documentos para la próxima sesión:**

### Documentos de protocolo (knowledge base del Project)

No requieren adjuntarse; verificar que estén disponibles:

- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`

### Documentos opcionales según el foco

- `asistente_claude_code_seguro.md` — solo si la sesión se ejecuta en Claude Code.

### Documento de traspaso de esta sesión (adjuntar al nuevo chat)

- `50_documentacion/traspasos/traspaso_cierre_v11.md`

### Output del escáner del proyecto (adjuntar al nuevo chat)

- `50_documentacion/estructura/estructura_actual.md` (**correr `00_escanear_proyecto.R` antes de abrir** — el snapshot vigente es previo a esta sesión)

### Archivos del proyecto críticos para retomar

- `README.md` — necesario para el Pendiente 1 (primer paso de la ruta sugerida)
- `30_procesamiento/33_motor_template.html` — solo si se abordan los Pendientes 2 o 3 (voluminoso pero necesario; ver sección 4 para contexto de los cambios recientes)
- `50_documentacion/activa/backlog_historico.md` — solo para verificar el anexado del delta al cierre

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
