# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v09
- **Fecha:** 2026-06-09
- **Sesión:** 9 — Publicación del motor en GitHub Pages y limpieza profunda del repositorio (auto-poda de snapshots, consolidación de documentación, eliminación de artefactos obsoletos).
- **Modelo utilizado:** Claude Opus 4.8
- **Entorno:** R (Positron) + Git/GitHub + Claude Code (zsh, macOS)
- **Archivos principales modificados:**
  - `00_escanear_proyecto.R` (reemplazado por versión con auto-poda)
  - `README.md` (consolidación de estructura + esquemas)
  - `docs/index.html` (nuevo — publicación Pages)
  - `50_documentacion/activa/publicacion_github_pages.md` (nuevo)
  - `50_documentacion/estructura/` (poda de snapshots)
  - Eliminados: `40_salidas/sleps_chile_v2.xlsx`, `50_documentacion/estructura/estructura_proyecto.md`, 6 pares de snapshots viejos

---

## 2. Resumen ejecutivo

La sesión tenía dos objetivos que emergieron secuencialmente: primero publicar el motor de comparación SIMCE en GitHub Pages para poder compartir un link, y segundo limpiar el repositorio dejando solo lo esencial para que el pipeline corra. Ambos se completaron. El motor quedó publicado en `https://tomgc.github.io/slep_simce_adecuado/` (servido desde `docs/index.html` en `main`, repo privado con solo `/docs` expuesto), validado en vivo. Antes de publicar se cerró en Git el trabajo pendiente de la sesión 8 (5 fixes documentados en v08 que nunca se habían commiteado). La limpieza adoptó el escáner con auto-poda de snapshots del proyecto hermano `slep_reportes_modelo_resguardo_asistencia`, eliminó 12 snapshots históricos versionados + un xlsx mal ubicado + un doc stale, y consolidó `estructura_proyecto.md` dentro del `README.md` corrigiendo tres datos desactualizados. Quedan pendientes para la próxima sesión: construir un diagrama de arquitectura HTML standalone (replicando el modelo `arquitectura_minuta_desvinculacion.html`), actualizar `CLAUDE.md` al estado real post-v08, y dos cambios en el motor (quitar botón de ajustes, agregar contacto con anti-scraping). El proyecto cierra sin bugs activos, con el repo limpio y el pipeline intacto.

---

## 3. Estado del proyecto al cierre

**Qué funciona:**
- Motor publicado y accesible en `https://tomgc.github.io/slep_simce_adecuado/`, validado en vivo (carga, buscador con diacríticos, tooltip clampeado, segmentación GSE).
- Pipeline `00_build.R` intacto y reproducible (la limpieza no tocó ningún script del pipeline ni los insumos).
- Escáner `00_escanear_proyecto.R` con auto-poda: cada corrida retiene solo los 2 sellos más recientes en disco, eliminando la acumulación.
- `README.md` autocontenido con secciones "Responsabilidades por archivo" y "Esquemas de datos".
- Working tree limpio, `origin/main` sincronizado en `3e4c78d`.

**Qué no funciona:**
- Ningún bug activo conocido al cierre.

**Qué cambió respecto al traspaso v08:**
- Se commiteó el trabajo pendiente de v08 (3 commits temáticos: fix pipeline R, fixes UX del HTML, docs/traspasos).
- Se publicó el motor en GitHub Pages (`docs/index.html`, configuración Settings→Pages branch `main` /docs).
- Se documentó el procedimiento de republicación en `50_documentacion/activa/publicacion_github_pages.md`.
- Se reemplazó `00_escanear_proyecto.R` por la versión con `podar_snapshots()`.
- Se eliminaron del repo: 12 snapshots históricos, `sleps_chile_v2.xlsx`, `estructura_proyecto.md`.
- Se consolidó la documentación de estructura dentro del `README.md`.

---

## 4. Registro detallado de cambios realizados

#### Cambio 1: Cierre en Git del trabajo pendiente de la sesión 8

- **Archivo(s) afectado(s):** `30_procesamiento/32_agregar_comunal.R`, `30_procesamiento/33_motor_template.html`, `50_documentacion/` (traspasos v06–v08, snapshots)
- **Categoría temática:** REPO
- **Qué se hizo:** Se commiteó en 3 commits temáticos el trabajo de v08 que nunca se había llevado a Git: (1) fix del warning de `pivot_wider`, (2) los 4 fixes UX del motor HTML, (3) documentación y snapshots.
- **Por qué se hizo:** El traspaso v08 listaba los commits sugeridos pero no se habían ejecutado; el working tree arrastraba ese trabajo sin versionar. Cerrarlo antes de publicar evita mezclar el trabajo de v08 con el deploy (cambios atómicos).
- **Cómo se verificó:** `git log --oneline` mostró los 3 commits; `git status` quedó limpio antes de proceder al deploy.
- **Líneas o secciones clave:** commits `f3318d4`, `9a6a4b7`, `73d8a51`.
- **Dependencias afectadas:** Ninguna; trabajo ya existente en disco.

#### Cambio 2: Publicación del motor en GitHub Pages

- **Archivo(s) afectado(s):** `docs/index.html` (nuevo)
- **Categoría temática:** REPO / Despliegue
- **Qué se hizo:** Se creó `docs/`, se copió `40_salidas/motor_comparacion.html` como `docs/index.html` (14.9 MB), se commiteó y pusheó, y se activó GitHub Pages (Settings→Pages, source branch `main` carpeta `/docs`).
- **Por qué se hizo:** El usuario necesitaba un link compartible del motor. GitHub Pages sirve contenido estático; el HTML es autocontenido con JSON agregado público embebido, así que no hay riesgo de gobernanza (sin datos individuales de NNA).
- **Cómo se verificó:** Se abrió `https://tomgc.github.io/slep_simce_adecuado/` y se validó carga, buscador con diacríticos ("valparaiso" → VALPARAÍSO primero), tooltip clampeado en extremos, y segmentación GSE.
- **Líneas o secciones clave:** commit `b0352dd`.
- **Dependencias afectadas:** El HTML original en `40_salidas/` permanece intacto (la copia no lo movió). El flujo de republicación queda documentado (ver Cambio 3).
- **Tensiones entre principios:** Gobernanza (exposición pública) vs. utilidad (link compartible). Resuelta confirmando que el JSON es 100% agregado público; el repo sigue privado y solo `/docs` se expone.

#### Cambio 3: Documentación del procedimiento de publicación

- **Archivo(s) afectado(s):** `50_documentacion/activa/publicacion_github_pages.md` (nuevo)
- **Categoría temática:** DOC
- **Qué se hizo:** Se creó un documento que describe qué se publica, la gobernanza aplicable, la configuración inicial, el procedimiento de republicación (ciclo de 4 pasos: build → copiar → verificar → push) y la validación post-publicación.
- **Por qué se hizo:** Para que futuras republicaciones tras cada build sean reproducibles sin re-derivar el procedimiento.
- **Cómo se verificó:** Se commiteó (`db4ea1f`); el archivo quedó en `50_documentacion/activa/`.
- **Líneas o secciones clave:** Incluye la nota de optimización pendiente (separar JSON del HTML para reducir peso de carga).
- **Dependencias afectadas:** Ninguna.

#### Cambio 4: Reemplazo del escáner por versión con auto-poda

- **Archivo(s) afectado(s):** `00_escanear_proyecto.R`
- **Categoría temática:** Infraestructura / REPO
- **Qué se hizo:** Se reemplazó el escáner por una adaptación del usado en `slep_reportes_modelo_resguardo_asistencia`, que incluye la función `podar_snapshots()`. Tras generar cada snapshot, conserva los `RETENER_SNAPSHOTS` (2) sellos más recientes en disco y borra el resto. Se adaptaron encabezado, fecha y la nota del data root (en este proyecto los datos son públicos y viven en el repo, no en OneDrive).
- **Por qué se hizo:** El escáner anterior generaba snapshots que se acumulaban en Git indefinidamente. La auto-poda ataca la causa raíz: ni Git ni disco acumulan.
- **Cómo se verificó:** Se corrió el escáner; emitió "Poda: 12 archivo(s) de snapshots antiguos eliminados (retención: 2 sellos)". Quedaron en disco solo los 2 sellos más recientes + aliases.
- **Líneas o secciones clave:** `podar_snapshots()`, constante `RETENER_SNAPSHOTS <- 2L`.
- **Dependencias afectadas:** El comportamiento del escáner cambia en todas las corridas futuras (poda automática).

#### Cambio 5: Limpieza de artefactos obsoletos del repo

- **Archivo(s) afectado(s):** `40_salidas/sleps_chile_v2.xlsx` (eliminado), 12 snapshots históricos (eliminados)
- **Categoría temática:** REPO
- **Qué se hizo:** Se destrackearon de Git los 6 pares de snapshots viejos (que la poda borró del disco) y se eliminó `sleps_chile_v2.xlsx`, un xlsx con sufijo `_v2` mal ubicado en `40_salidas/` (es insumo, no salida; no lo genera el pipeline).
- **Por qué se hizo:** Dejar el directorio limpio con solo lo esencial. Ningún script del pipeline lee estos archivos.
- **Cómo se verificó:** `git status` confirmó las eliminaciones staged; `00_build.R` no referencia ninguno de estos archivos.
- **Líneas o secciones clave:** commit `3e4c78d`.
- **Dependencias afectadas:** Ninguna verificada.

#### Cambio 6: Consolidación de estructura_proyecto.md en README

- **Archivo(s) afectado(s):** `README.md` (editado), `50_documentacion/estructura/estructura_proyecto.md` (eliminado)
- **Categoría temática:** DOC
- **Qué se hizo:** Se fusionó el contenido único de `estructura_proyecto.md` (responsabilidades por archivo + esquemas de datos) dentro del `README.md`, corrigiendo tres datos stale verificados contra el código: (1) `json_motor()` no existe (solo en comentarios), se omitió; (2) años reales 2014–2018, 2022–2025 (no 2023–2025); (3) columna `n_evaluados` (no `n_total`). Se ajustó el bullet de Documentación para apuntar a las secciones internas + el snapshot autogenerado, sin enlace muerto.
- **Por qué se hizo:** El README es el lugar canónico para "qué hay en el repo y para qué sirve cada pieza"; `estructura_proyecto.md` era un doc stale referenciado solo por el README.
- **Cómo se verificó:** `git diff --staged README.md` confirmó las dos secciones nuevas con datos corregidos y el bullet ajustado. Se verificaron los tres puntos stale con `grep` contra `10_utils.R` y `32_agregar_comunal.R`.
- **Líneas o secciones clave:** commit `3e4c78d`; secciones "Responsabilidades por archivo" y "Esquemas de datos" del README.
- **Dependencias afectadas:** `estructura_proyecto.md` ya no es referenciado por nadie.

---

## 5. Backlog acumulativo del proyecto

> **⚠️ NOTA DE CONTINUIDAD (completar al consolidar):** En esta sesión NO se tuvieron cargados los traspasos v01–v08, por lo que el backlog histórico acumulativo (secciones 5.1–5.6 con el detalle cronológico de los cambios 1–N de sesiones previas) no pudo copiarse íntegramente como exige la regla 5.5 del protocolo de cierre. **Antes de archivar este v09, copiar el backlog completo desde `traspaso_cierre_v08.md` y agregar al final los 6 cambios de la sesión 9 (numerados de forma correlativa global).** Lo que sigue documenta solo el delta de esta sesión.

### Cambios de la sesión 9 (a numerar correlativamente sobre el backlog de v08)

1. Cierre en Git del trabajo pendiente de la sesión 8 (3 commits temáticos). — REPO
2. Publicación del motor en GitHub Pages (`docs/index.html`). — Despliegue
3. Documentación del procedimiento de publicación. — DOC
4. Reemplazo del escáner por versión con auto-poda de snapshots. — Infraestructura
5. Limpieza de artefactos obsoletos (xlsx mal ubicado + 12 snapshots). — REPO
6. Consolidación de `estructura_proyecto.md` en README con corrección de datos stale. — DOC

### 5.3 Clasificación temática (taxonomía vigente del proyecto)

| Código | Categoría |
|--------|-----------|
| P | Pipeline R |
| UI | Motor HTML / React / D3 |
| D | Datos / Insumos |
| DOC | Documentación |
| REPO | Gobernanza del repo / Despliegue |
| Infra | Infraestructura (escáner, orquestador, CI) |
| DT | Deuda técnica |

> Nota: se sugiere unificar "Despliegue" dentro de REPO o crearla como categoría propia al consolidar el backlog histórico, según cómo estén clasificados los cambios de Pages.

---

## 6. Bugs encontrados y su resolución

No aplica en esta sesión. No se manifestaron bugs de software; el trabajo fue de despliegue y limpieza de repositorio. El único "estado inconsistente" potencial (commitear la poda de snapshots sin el escáner que la implementa) fue detectado por Claude Code antes del commit y corregido sumando `00_escanear_proyecto.R` al staging.

---

## 7. Aprendizajes y restricciones técnicas descubiertas

- **Regla:** GitHub Pages sobre repo privado en plan gratuito expone públicamente solo la carpeta servida (`/docs`); el resto del repo permanece privado.
  - **Principio relacionado:** Gobernanza de datos.
  - **Contexto:** Publicar es seguro solo si el contenido servido es agregado público. Verificar antes de activar Pages, no asumir.
  - **Ejemplo:** El motor embebe JSON agregado público (SIMCE nivel RBD ponderado por GSE), sin datos individuales de NNA.

- **Regla:** Resolver la acumulación de artefactos regenerables en el generador (auto-poda en el escáner), no con reglas de `.gitignore` sobre un generador que sigue acumulando en disco.
  - **Principio relacionado:** C.2/C.3 (reproducibilidad e idempotencia), atacar causa raíz (C.11).
  - **Contexto:** Gitignorar snapshots deja el escáner viejo generando basura local indefinidamente. Cambiar el escáner elimina el problema en ambos lados.
  - **Ejemplo:** `podar_snapshots()` retiene 2 sellos; el resto se borra en cada corrida.

- **Regla:** Al consolidar documentación stale, verificar cada dato contra el código fuente antes de copiarlo; no propagar afirmaciones obsoletas.
  - **Principio relacionado:** B.1 (sin supuestos), C.11 (trazabilidad).
  - **Contexto:** Documentación vieja puede afirmar cosas que el código ya no cumple. Copiar sin verificar propaga el error a un documento más visible.
  - **Ejemplo:** `estructura_proyecto.md` afirmaba `json_motor()` (inexistente), años 2023–2025 (reales 2014–2025) y `n_total` (real `n_evaluados`); los tres se corrigieron al consolidar en README.

- **Regla:** El peso del HTML embebido (~15 MB) cabe en Pages pero penaliza la primera carga; separar JSON del HTML lo resolvería si llega a molestar.
  - **Principio relacionado:** Mejora de UX (diferible).
  - **Contexto:** Git/Pages comprime con gzip (el push subió 1.18 MB de 14.9 MB), mitigando el problema parcialmente.
  - **Ejemplo:** Optimización registrada como pendiente, no abordada (publicación tal cual aprobada).

---

## 8. Decisiones de diseño tomadas

| ID | Decisión | Alternativas consideradas | Justificación | Implicancia |
|----|----------|---------------------------|---------------|-------------|
| DD9.1 | Publicar desde `/docs` en `main` | Branch `gh-pages` dedicado | Un solo branch, menos pasos en cada republicación | El HTML pesado convive con el código en `main` |
| DD9.2 | Publicar el HTML tal cual (~15 MB) | Separar JSON del HTML (fetch externo) | Da el link funcionando hoy; la optimización se difiere si molesta | Primera carga descarga 15 MB (mitigado por gzip) |
| DD9.3 | Adoptar escáner con auto-poda del proyecto hermano | Gitignorar snapshots + escáner viejo | Ataca causa raíz; ni Git ni disco acumulan | Cambia comportamiento del escáner en toda corrida futura |
| DD9.4 | `RETENER_SNAPSHOTS = 2` | Otro número | Consistencia con el proyecto hermano | 2 sellos + aliases en disco tras cada corrida |
| DD9.5 | Consolidar estructura en README (no en CLAUDE.md) | CLAUDE.md | README es el lugar canónico para "qué hay en el repo"; CLAUDE.md queda enfocado en convenciones/pendientes | README autocontenido |
| DD9.6 | Mantener `POLITICA_PROYECTO.md` local | Borrarla (canónica en KB) | Borrarla exigía cirugía de README por beneficio marginal | Copia local persiste; si la KB v4 la deja obsoleta es decisión de contenido aparte |

---

## 9. Constantes, configuraciones y parámetros vigentes

| Constante | Valor actual | Archivo | Nota |
|-----------|-------------|---------|------|
| `RETENER_SNAPSHOTS` | `2L` | `00_escanear_proyecto.R` | Nuevo en v09; consistente con proyecto hermano |
| `EXCLUIR_ARCHIVO` | `TRUE` | `00_escanear_proyecto.R` | Excluye `_archivo/` del árbol |
| Fórmula agregación | `sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100` | `10_utils/10_utils.R` | Sin cambios |
| Umbral MINEDUC | `nalu >= 10` | `10_utils/10_utils.R` (vía `agregar_ponderado`) | Sin cambios |
| URL Pages | `https://tomgc.github.io/slep_simce_adecuado/` | (config GitHub) | Nuevo en v09 |
| Source Pages | branch `main`, carpeta `/docs` | (config GitHub) | Nuevo en v09 |

---

## 10. Arquitectura de archivos relevante

El output del escáner al cierre vive en `50_documentacion/estructura/estructura_actual.md` (sello más reciente `20260609_113435`). Cambios estructurales de esta sesión:

- Nueva carpeta `docs/` con `index.html` (publicación Pages).
- Nuevo `50_documentacion/activa/publicacion_github_pages.md`.
- Eliminados `40_salidas/sleps_chile_v2.xlsx` y `50_documentacion/estructura/estructura_proyecto.md`.
- Snapshots de estructura reducidos a 2 sellos + aliases.

**Verificación contra política:** la estructura sigue respetando `POLITICA_PROYECTO.md` (directorios numerados, snake_case, `here::here()`, datos públicos versionados). `docs/` es una adición estándar para GitHub Pages, fuera de la jerarquía numerada, lo cual es aceptable por ser carpeta de publicación, no de pipeline.

---

## 11. Tareas pendientes, próximos pasos y ruta sugerida

### 11.1 Inventario de pendientes

#### Pendiente 1: Diagrama de arquitectura HTML standalone

- **Descripción:** Construir un HTML standalone que documente la arquitectura y flujo de `slep_simce_adecuado`, replicando el formato visual del modelo `arquitectura_minuta_desvinculacion.html` (tarjetas por etapa, badges de tipo de dato, banderas de decisiones metodológicas, conectores, orden de ejecución, leyenda).
- **Contexto:** Solicitado en la sesión 9 pero diferido por ser trabajo mayor que merece contexto fresco.
- **Tipo:** Funcionalidad nueva / Documentación.
- **Impacto:** Sin él, la arquitectura del pipeline no tiene representación visual navegable.
- **Dependencias:** Ninguna bloqueante. Conviene que CLAUDE.md esté actualizado antes (pendiente 2) para coherencia.
- **Complejidad estimada:** Alta.
- **Principios relevantes:** B.4 (criterio de éxito), C.11 (documentar el "para qué").
- **Precauciones:** El modelo replica CONTENIDO de otro proyecto (minuta_desvinculacion); replicar solo el FORMATO, con contenido real de las 5 etapas de este pipeline (30→31→32→33).
- **Sugerencia de enfoque:** Mapear las 5 etapas con sus insumos/salidas/columnas clave (ya documentadas en sección 4 de este traspaso y en los scripts), luego construir el HTML. Los scripts del pipeline ya fueron leídos en sesión 9.
- **Criterio de éxito sugerido (B.4):** El HTML abre en navegador y refleja el flujo real (auxiliares → simce_rbd → simce_comunal → JSON/HTML) con las anomalías A1–A4 visibles como decisiones metodológicas.

#### Pendiente 2: Actualizar CLAUDE.md al estado real post-v08

- **Descripción:** El `CLAUDE.md` actual tiene "Pendientes" (P2, P5, P6, P7, D3) y "Últimos cambios" desfasados (llega hasta sesión 3). P6/P7 ya parecen implementados según v08.
- **Contexto:** Detectado en sesión 9 pero no abordado (se priorizó limpieza).
- **Tipo:** Documentación.
- **Impacto:** Claude Code lee CLAUDE.md primero; si está desfasado, arranca con contexto incorrecto.
- **Dependencias:** Ninguna.
- **Complejidad estimada:** Media.
- **Principios relevantes:** B.1, C.11.
- **Precauciones:** Verificar qué pendientes de CLAUDE.md ya están resueltos consultando traspasos v04–v08 antes de reescribir.
- **Criterio de éxito sugerido (B.4):** "Pendientes" y "Últimos cambios" de CLAUDE.md coinciden con el estado real verificado contra traspasos y código.

#### Pendiente 3: Quitar botón de ajustes; densidad fija en "cómoda"

- **Descripción:** El panel de tweaks deja de ser configurable por el usuario; la densidad queda hardcodeada en "cómoda".
- **Contexto:** Solicitado en sesión 9.
- **Tipo:** Mejora visual / UI.
- **Impacto:** Simplifica la UI del motor.
- **Dependencias:** Toca `33_motor_template.html`; requiere redeploy a `/docs` tras el cambio.
- **Complejidad estimada:** Media.
- **Principios relevantes:** Limpieza de código huérfano (no dejar estado/handlers sin uso).
- **Precauciones:** Verificar que `SimceData.getSeriesForEntity` siga siendo el punto de entrada; no agregar ternarios inline por `kind`. Limpiar estado React y handlers que el botón deje sin uso.
- **Criterio de éxito sugerido (B.4):** El motor regenerado no muestra el botón de ajustes y la densidad es "cómoda" sin opción de cambiarla; sin código muerto.

#### Pendiente 4: Párrafo de contacto con ofuscación anti-scraping (nivel B)

- **Descripción:** Agregar al final del párrafo de intro ("El objetivo de esta herramienta de análisis interno...") un párrafo con **Contacto:** (en negrita) seguido de `tomas.gonzalez@slepcostacentral.gob.cl`, ensamblado por JS para que no aparezca como string literal en el fuente (protección nivel B), manteniendo `mailto:` clickeable.
- **Contexto:** Solicitado en sesión 9; nivel de protección B confirmado por el usuario.
- **Tipo:** Funcionalidad nueva / UI.
- **Impacto:** Expone canal de contacto sin facilitar cosecha automatizada del correo.
- **Dependencias:** Toca `33_motor_template.html`; requiere redeploy a `/docs`. Puede abordarse junto al pendiente 3 (mismo archivo).
- **Complejidad estimada:** Baja.
- **Principios relevantes:** —
- **Precauciones:** El correo no debe existir como string completo en el HTML servido (ensamblar de partes en JS).
- **Criterio de éxito sugerido (B.4):** El correo se ve correctamente y es clickeable en el motor renderizado, pero un `grep` del string completo en el HTML no lo encuentra.

#### Pendiente 5 (heredado, diferible): Optimización del peso del HTML

- **Descripción:** Separar el JSON del HTML (fetch externo) para reducir el HTML servido de ~15 MB a ~200 KB.
- **Tipo:** Mejora de UX.
- **Complejidad estimada:** Media (toca `33_generar_html.R`).
- **Sugerencia de enfoque:** Solo si la carga inicial molesta en la práctica.
- **Criterio de éxito sugerido (B.4):** HTML liviano que carga el JSON por fetch; segunda visita instantánea por caché.

### 11.2 Evaluación de deuda técnica

- No se introdujo deuda técnica en esta sesión. La limpieza redujo deuda (repo más limpio, escáner que no acumula).
- **Pendiente de cierre administrativo:** completar el backlog histórico de la sección 5 desde el v08 (ver nota de continuidad).

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? (C.8) → **Sí** — no se tocó la lógica del pipeline; los checks de v08 siguen vigentes.
- ¿Los outputs son reproducibles e idempotentes? (C.2, C.3) → **Sí** — `00_build.R` intacto; el escáner ahora es idempotente respecto a la acumulación (poda determinista).
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? (C.11) → **Sí** — `RETENER_SNAPSHOTS` documentada; invariantes metodológicos sin cambios.

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

## Ruta sugerida para la próxima sesión

1. **Actualizar CLAUDE.md (pendiente 2)** — rápido y habilita coherencia para el diagrama. Criterio: pendientes y cambios coinciden con el estado real.
2. **Diagrama de arquitectura HTML (pendiente 1)** — el trabajo mayor, abordarlo con contexto fresco al inicio. Criterio: abre en navegador y refleja el flujo real con anomalías A1–A4 visibles.
3. **Cambios del motor (pendientes 3 y 4)** — agrupables (mismo archivo `33_motor_template.html`), cerrar con redeploy a `/docs`. Criterio: botón de ajustes ausente, densidad cómoda fija, contacto ofuscado clickeable.

**Diferir para sesión posterior:**
- Optimización del peso del HTML (pendiente 5) — solo si la carga molesta en la práctica.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **ANTES** de construir el diagrama de arquitectura, recordar que el modelo `arquitectura_minuta_desvinculacion.html` es de OTRO proyecto: replicar solo el FORMATO visual, con contenido real de `slep_simce_adecuado`.
- ⚠️ **ANTES** de tocar `33_motor_template.html` (pendientes 3 y 4), verificar que `SimceData.getSeriesForEntity` siga siendo el punto de entrada para toda lógica de series. No agregar ternarios inline por `kind`.
- ✅ **DESPUÉS** de cualquier cambio en `33_motor_template.html`, regenerar el HTML (`Rscript 00_build.R`) y republicar a `/docs` siguiendo `50_documentacion/activa/publicacion_github_pages.md`.
- ✅ **ANTES** de archivar el v09, completar el backlog histórico de la sección 5 desde el v08.
- 🔒 La segmentación por GSE es inviolable: todo componente que muestre datos respeta el filtro `gse`.
- 🔒 El correo de contacto (pendiente 4) no debe existir como string literal completo en el HTML servido.

---

## 13. Fragmentos de código de referencia

### Auto-poda de snapshots (patrón canónico del escáner)

```r
# Conserva los `retener` sellos más recientes; borra el resto.
# Los aliases estructura_actual.* (sin sello) nunca se tocan.
podar_snapshots <- function(dir_estructura, retener) {
  patron <- "^[0-9]{8}_[0-9]{6}_estructura\\.(txt|md)$"
  todos  <- fs::dir_ls(dir_estructura, recurse = FALSE, fail = FALSE)
  sellados <- todos[grepl(patron, fs::path_file(todos))]
  if (length(sellados) == 0) return(0L)
  sellos <- substr(fs::path_file(sellados), 1L, 15L)
  sellos_unicos <- sort(unique(sellos), decreasing = TRUE)
  if (length(sellos_unicos) <= retener) return(0L)
  sellos_a_borrar <- sellos_unicos[-seq_len(retener)]
  a_borrar <- sellados[sellos %in% sellos_a_borrar]
  fs::file_delete(a_borrar)
  length(a_borrar)
}
```

### Ciclo de republicación en GitHub Pages (zsh)

```bash
cd ~/Projects/slep_simce_adecuado
Rscript 00_build.R                                    # 1. regenerar HTML
cp 40_salidas/motor_comparacion.html docs/index.html  # 2. copiar a docs/
git add docs/index.html && git status                 # 3. verificar gobernanza
git commit -m "deploy: actualizar motor de comparacion SIMCE"
git push origin main                                  # 4. Pages reconstruye en 1-2 min
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 10 (Opus)`
(Reemplazar "Opus" por el modelo que vayas a usar.)

**Mensaje de apertura:**

> Continuación de sesión sobre el proyecto **slep_simce_adecuado**.
>
> Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de estructura y principios de desarrollo) viven en la knowledge base de este Project; léelos desde ahí. Adjunto el traspaso, el escáner actual y los archivos críticos de la sesión anterior.
>
> Por favor sigue el protocolo de apertura definido en mis userPreferences y entrega el plan de trabajo en el formato estándar (Estado al cierre / Pendientes / Ruta propuesta / Decisiones que necesitas), basado en el handoff adjunto.

**Documentos para la próxima sesión:**

### Documentos de protocolo (knowledge base del Project)

No requieren adjuntarse; el asistente los lee desde la knowledge base:

- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`

### Documentos opcionales según el foco de la próxima sesión

- `asistente_claude_code_seguro.md` — si la próxima sesión se ejecuta en Claude Code (probable para los pendientes 3 y 4).

### Documento de traspaso de esta sesión (adjuntar al nuevo chat)

- `50_documentacion/traspasos/traspaso_cierre_v09.md`

### Output del escáner (adjuntar al nuevo chat)

- `50_documentacion/estructura/estructura_actual.md` (correr `00_escanear_proyecto.R` antes de abrir)

### Archivos del proyecto críticos para retomar

- `30_procesamiento/33_motor_template.html` — template React/D3 del motor (~3.300 líneas); voluminoso pero necesario para los pendientes 1, 3 y 4.
- `arquitectura_minuta_desvinculacion.html` — modelo de formato para el diagrama (pendiente 1); adjuntar desde donde lo tengas guardado.
- `CLAUDE.md` — a actualizar (pendiente 2).
- Los 5 scripts del pipeline (`30`–`33`) — si el foco es el diagrama (pendiente 1), para detalle fino; ya fueron leídos en sesión 9 y están resumidos en la sección 4 de este traspaso.

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
