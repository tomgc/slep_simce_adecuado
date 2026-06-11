# traspaso_cierre_v13.md

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v13
- **Fecha:** 2026-06-11
- **Sesión:** 13. Foco: auditoría completa pre-lanzamiento según encargo
  (`encargo_auditoria_slep_simce_adecuado.md`): corrección (A1–A7),
  seguridad (B1–B4), optimización (C1–C4). Veredicto: LISTO PARA LANZAR.
- **Entorno:** interfaz web; el usuario corrió los scripts de auditoría
  localmente (Positron) y pegó salidas; contraste A6 manual contra el sitio
  de la Agencia.
- **Archivos principales modificados:**
  `30_procesamiento/33_generar_html.R`,
  `30_procesamiento/33_motor_template.html`,
  `40_salidas/motor_comparacion.html` y `docs/index.html` (regenerados),
  `50_documentacion/activa/informe_auditoria_prelanzamiento.md` (nuevo),
  `50_documentacion/activa/decisiones/20260611_decision_nombres_establecimientos.md`
  y `20260611_decision_repo_publico.md` (nuevos).

## 2. Resumen ejecutivo

Sesión dedicada íntegramente a la auditoría pre-lanzamiento. Se ejecutaron
los siete casos de corrección, los cuatro de seguridad y los cuatro de
optimización del encargo, cada uno con criterio de éxito definido antes de
correr y doble camino independiente. El hallazgo principal fue una regresión
introducida por el fix 12-2: al cambiar la fuente de las series de SLEP a
`simce_rbd` crudo no se reaplicaron los filtros MINEDUC (`nalu >= 10`,
`marca` NA), produciendo divergencias de hasta 42,6 pp en celdas SLEP y
popups listando establecimientos que no aportan al cálculo; se corrigió de
raíz filtrando los tres bloques del JSON en R (fuente única de verdad) y se
verificó por triple vía (A2b, A3, A7). En seguridad: B1 limpio; B2 resuelto
manteniendo nombres tras verificar que la prohibición citada corresponde a
las bases por estudiante (no usadas); B3 cerrado documentando el repo
público como excepción justificada; B4 corregido (CDN production + SRI). En
optimización se removió `generateSeries` legacy y se verificó la unicidad de
`getSeriesForEntity`. A6 cerró con 7/7 coincidencias exactas contra el sitio
oficial y 3/3 supresiones correctas. Queda el bloque operativo: commit,
deploy y verificación post-deploy.

## 3. Estado al cierre

- **Funciona:** pipeline `00_build.R` limpio (~3 s, múltiples corridas esta
  sesión); HTML 1.713 KB; A1–A7 en verde con el build vigente; motor
  verificado visualmente con template nuevo (production + SRI, sin
  `generateSeries`); JSX validado con `@babel/parser`.
- **No funciona / pendiente operativo:** los cambios de la sesión NO están
  commiteados ni desplegados (el `docs/index.html` publicado es el de s12,
  con la regresión de filtros: **las cifras de SLEP en producción están
  infladas a la baja en celdas rurales hasta que se despliegue**). Ver
  sección 12 y el bloque de cierre.
- **Delta respecto a v12:** JSON `simce_rbd` 185.378 → 140.345 filas
  (solo U_calc); catálogos popup 34.255 → 29.277 y 23.026 → 17.983; HTML
  1.829 → 1.713 KB; React/Babel a production + SRI; `generateSeries` legacy
  removida; informe de auditoría y dos decisiones de gobernanza nuevas.

## 4. Registro detallado de cambios

Backlog histórico, ítems **57–60**
(`50_documentacion/activa/backlog_historico.md`; el delta exacto a anexar
está en la sección 5). Resumen:

- **57 (P/DT — fix de raíz):** filtro completo de producción (`palu` no-NA,
  `nalu >= 10`, `marca` NA) en los tres bloques del JSON (`simce_rbd`,
  `rbd_gse`, `rbds_por_nivel`) en `33_generar_html.R`. Por qué: regresión de
  s12 (ver bug 13-1). Verificación: A2b, A3 (3.672 celdas, Δ = épsilon),
  A7.
- **58 (Infra/Seg):** CDN React/ReactDOM a `production.min` + SRI sha384 +
  `crossorigin` en los tres scripts externos del template (B4 opción 1).
  Hashes calculados desde los tarballs oficiales de npm. Verificación:
  carga del motor (un hash malo = script no carga) + consola sin warnings
  de development.
- **59 (DT):** remoción de `generateSeries` legacy (42 líneas, cero
  llamadas) y de su entrada en el export de `SimceData` (C1). Verificación:
  grep cero referencias de código + `@babel/parser` OK + verificación
  visual + A2b.
- **60 (DOC/Gob):** `informe_auditoria_prelanzamiento.md` + decisiones
  `20260611_decision_nombres_establecimientos.md` (B2) y
  `20260611_decision_repo_publico.md` (B3) en
  `50_documentacion/activa/` y `activa/decisiones/`.

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md`. **Delta de esta
sesión (anexar al final del detalle cronológico, numeración global):**

```markdown
### Sesión 13 — Auditoría pre-lanzamiento (2026-06-11)

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
```

Resumen estadístico: agregar fila `Sesión 13 | traspaso v13 | 4 cambios |
Fable 5 | auditoría pre-lanzamiento`. Total acumulado: 60.

## 6. Bugs de la sesión

- **Bug 13-1 (regresión de filtros MINEDUC en la vía SLEP).** Síntoma: % de
  SLEP inconsistentes con comunas/regiones (hasta 42,6 pp; Valparaíso GSE 3
  2m mate 2016: 27,3 vs 69,9); popups listando establecimientos que no
  aportan al cálculo (10.166 filas en `U_motor \ U_calc`: 6.130 solo
  `nalu < 10`, 2.028 ambos motivos, 2.008 solo marca). Causa raíz: el fix
  12-2 cambió la fuente de `generateSeriesByRbd` desde `simce_comunal`
  (filtros aplicados en R) a `simce_rbd` crudo sin reaplicar `nalu >= 10` ni
  `marca` NA; la columna `marca` ni siquiera viaja en el JSON, así que el
  cliente no podía filtrar. Solución exacta: filtros completos en
  `33_generar_html.R` (bloques `df_simce_rbd`, `df_rbd_gse`, `df_rbd_np`).
  Verificación: A2b (JSON == U_calc exacto), A3 (equivalencia motor vs.
  parquet a épsilon), A6 (contraste oficial). **Patrón general aprendido:**
  al cambiar la FUENTE de un cálculo hay que reaplicar los FILTROS que la
  fuente original ya traía incorporados; un fix de universo puede introducir
  una regresión de criterio. Principios: C.8 (validación tras
  transformaciones críticas), invariante 5 del encargo. Estado: resuelto.

- **Bugs del asistente corregidos en sesión** (no cuentan en el backlog;
  se listan por sus reglas): (a) script A6 v1 con estrato vacío silencioso
  (`slice_sample` sobre tibble vacío devuelve 0 filas sin warning) →
  regla: toda muestra estratificada valida su tamaño con `stopifnot`;
  (b) script B1 v1 colgado por `gregexpr` sobre 11,8 MB con cientos de
  miles de matches → regla: inventarios de claves por parseo, no por regex
  global; (c) chequeo `git ls-files X && ...` siempre verdadero (exit 0 sin
  matches) → regla: probar `[ -n "$(...)" ]`; (d) criterio de regresión de
  A5 por hash sin considerar `fecha_generacion` (cambia entre días con el
  mismo largo de bytes) → regla: la regresión independiente de fecha es
  A2b, no el hash.

## 7. Aprendizajes y restricciones descubiertas

1. **Fuente nueva exige filtros completos** (P/DT): todo dato que viaje al
   JSON debe salir de R ya con el criterio de producción aplicado
   (invariante 5 una sola vez, en R); el cliente solo agrega, no filtra.
   Violarlo reintroduce 13-1.
2. **El patrón de supresión de la Agencia cambia entre años:** 2014–2022
   `palu` NA con `nalu > 0`; 2023–2024 solo `nalu` 0/NA; 2025 preliminar
   reaparece `nalu > 0` (explica el bug 12-4). No asumir un patrón único al
   diseñar filtros o muestras.
3. **SRI fija versión:** si se cambia la versión de un script CDN, recalcular
   el hash desde el tarball npm (`openssl dgst -sha384 -binary | base64`);
   el comentario en el template lo documenta.
4. **`showElemInsuf` NO fue removido en s10** (corrige al ítem 41 del
   backlog): vive hardcodeado `= true` (template, ~L2933 post-limpieza) y lo
   consumen `RecentBarsSubchart` y `ChartHints`. Es infraestructura ya
   instalada para el toggle Elemental/Insuficiente.
5. **El repo es PÚBLICO:** nada se versiona si no es publicable (decisión
   20260611_decision_repo_publico.md).

## 8. Decisiones de diseño

- **Corrección de 13-1 en R, no en cliente.** Alternativa: embeber `marca` y
  replicar `nalu >= 10` en el motor. Rechazada: duplica la regla en dos
  lenguajes y agrega peso. Elegida: filtrar en `33_generar_html.R` (fuente
  única; beneficio lateral de −45 mil filas).
- **B4 por etapas.** Opción 1 (production + SRI) aplicada como condición de
  lanzamiento; opción 2 (inline + precompilación JSX, elimina Babel del
  cliente) diferida a sesión propia por exigir Node en el pipeline.
- **C4 diferido:** `rbd_gse` y `rbds_por_nivel` son derivables en cliente
  desde el `simce_rbd` ya filtrado, pero el retorno comprimido es marginal
  (decisión s11 vigente) y agregaría lógica de cliente.
- **Gobernanza B2/B3:** ver archivos de decisión (sección 1).

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|-----------|-------|---------|------|
| Filtro de publicación JSON | `!is.na(palu_eda_ade) & nalu >= 10 & is.na(marca)` | `33_generar_html.R` (3 bloques) | **Nuevo s13**; espejo exacto de `agregar_ponderado()` |
| SRI react 18.3.1 | `sha384-DGyLxAyjq0f9...B/Z` | `33_motor_template.html` | Nuevo s13 |
| SRI react-dom 18.3.1 | `sha384-gTGxhz21lVGY...Jj1` | `33_motor_template.html` | Nuevo s13 |
| SRI @babel/standalone 7.29.0 | `sha384-m08KidiNqLdp...F1y` | `33_motor_template.html` | Nuevo s13 |
| `ANIO_DATOS_VIGENTE` | `2025L` | `30_construir_auxiliares.R` | Sin cambio |
| Umbral heatmap | ≤25/26–50/51–70/>70 | template | Sin cambio |
| Umbral MINEDUC | `nalu < 10` excluye | `10_utils/10_utils.R` | Sin cambio |
| Semilla muestra A6 | `1303` | `auditoria_a6_muestra_oficial.R` | Reproducible |

## 10. Arquitectura de archivos

Sin cambios de carpetas. Archivos nuevos en `50_documentacion/activa/`:
`informe_auditoria_prelanzamiento.md` y dos decisiones en `decisiones/`.
Nueve scripts `auditoria_*.R` en raíz (temporales, a `_archivo/` en el
cierre operativo). Correr el escáner tras el bloque de cierre y antes de la
próxima sesión.

## 11. Pendientes y ruta sugerida

### Inventario

1. **[OPERATIVO — primero] Bloque de cierre: higiene + commit + deploy.**
   Mover los `auditoria_*.R` y los dos scripts de diagnóstico de s12 a
   `_archivo/20260611/`; commitear los cambios 57–60 (3 commits temáticos);
   regenerar y desplegar `docs/index.html`; verificar en Pages que el aviso
   `'file:' URLs...` no aparece (era artefacto de file://) y que el motor
   carga con SRI. Tipo: operativo. Complejidad: baja. Criterio de éxito:
   Pages sirviendo el HTML de 1.713 KB con cifras corregidas. Instrucción
   pre-armada para Claude Code incluida en el cierre de sesión.
2. **[FUNCIONALIDAD] Toggle Elemental/Insuficiente.** `showElemInsuf` ya
   existe hardcodeado `= true` y con consumidores instalados (hallazgo C1);
   falta solo el control UI y el cableado de estado. Complejidad: baja-media
   (menor que lo estimado en v12). Criterio: toggle muestra/oculta series
   sin romper GSE ni el cálculo Adecuado. Precaución: 🔒 invariantes.
3. **[GOBERNANZA] Auditoría de `50_documentacion/` pública** (traspasos,
   backlog, encargo): sesión conjunta. Complejidad: baja. Criterio: cada
   documento trackeado clasificado publicable/no publicable, con acción.
4. **[BIBLIOTECA] Corregir POLÍTICA §6.4** (la restricción de nombres
   corresponde a bases por estudiante). Documento canónico multi-proyecto.
5. **[OPTIMIZACIÓN] B4 opción 2 / C2:** inline React production +
   precompilación JSX (elimina Babel del cliente y su warning). Complejidad:
   media-alta (Node en pipeline). Diferible.
6. **[OPTIMIZACIÓN] C4:** derivar catálogos de popup en cliente. Diferido
   con justificación (retorno marginal comprimido).

### Deuda técnica

Sin zonas frágiles nuevas; la zona corregida (vía SLEP) quedó con triple
verificación. La transpilación Babel en cliente es la única deuda de
arquitectura declarada (pendiente 5).

### Auditoría de cierre (POLÍTICA 5.6)

- ¿Transformaciones críticas con check? Sí — A1–A7 + validaciones del
  pipeline.
- ¿Outputs reproducibles e idempotentes? Sí — A7 byte-idéntico.
- ¿Decisiones metodológicas como constantes? Sí — incluido el filtro de
  publicación nuevo.
- ¿Nombres sin tildes/ñ/espacios? Sí (excepción heredada documentada:
  `Motor SIMCE.html` en insumos congelados).

### Ruta sugerida para la sesión 14

(1) Bloque de cierre operativo (pendiente 1) en Claude Code, 15 minutos;
(2) toggle Elemental/Insuficiente (pendiente 2), aprovechando
`showElemInsuf`; (3) si queda espacio, auditoría de documentación
(pendiente 3). Diferir 4–6.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ NO anunciar/difundir el lanzamiento sin completar el pendiente 1: lo
  desplegado hoy en Pages aún es el build de s12 CON la regresión de
  filtros.
- ✅ ANTES de tocar `33_generar_html.R`, verificar que los tres bloques del
  JSON conservan el filtro completo (`palu` no-NA, `nalu >= 10`, `marca`
  NA). Es el espejo de `agregar_ponderado()`: si uno cambia, cambian ambos.
- ✅ ANTES de cambiar versiones de los scripts CDN, recalcular los SRI desde
  los tarballs npm.
- ✅ ANTES de versionar cualquier archivo nuevo, recordar que el repo es
  PÚBLICO.
- 🔒 Segmentación GSE, ponderación por `nalu`, no-mezcla de pruebas/niveles,
  `entity.rbds` como universo de SLEP, supresión de la Agencia respetada en
  todo listado, y el filtro de publicación del JSON: invariantes intocables.

## 13. Fragmentos de código de referencia

```r
# Filtro de publicación del JSON (la forma correcta, espejo de
# agregar_ponderado()). Aplica a TODO bloque de datos por establecimiento
# que viaje al motor: simce_rbd, rbd_gse, rbds_por_nivel.
df <- arrow::read_parquet(here::here("40_salidas","intermedios","simce_rbd.parquet")) |>
  dplyr::filter(
    !is.na(.data$palu_eda_ade),
    !is.na(.data$nalu), .data$nalu >= 10,
    is.na(.data$marca)
  )
```

```r
# Extraccion + verificacion del JSON embebido (patron de auditoria A2b/A5,
# reutilizable como regresion tras cualquier edicion del template):
html <- readChar(p, file.info(p)$size, useBytes = TRUE)
b64  <- sub('^atob\\("', "", sub('"\\)$', "",
        regmatches(html, regexpr('atob\\("[A-Za-z0-9+/=]+"\\)', html))))
json <- rawToChar(memDecompress(jsonlite::base64_dec(b64), type = "gzip"))
```

```zsh
# SRI para un nuevo script CDN (desde el tarball oficial de npm):
curl -sL https://registry.npmjs.org/react/-/react-18.3.1.tgz | tar xzO package/umd/react.production.min.js | openssl dgst -sha384 -binary | base64
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 14 (Fable 5)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  > (POLÍTICA + SETTINGS) vive en la knowledge base; léelo desde ahí.
  > Adjunto el traspaso v13 y el escáner actual. Foco: cierre operativo
  > (pendiente 1, si no se ejecutó ya en Claude Code) y toggle
  > Elemental/Insuficiente (pendiente 2).
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (no adjuntar):* `POLITICA_PROYECTO.md`,
     `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales:* `CLAUDE.md` si el cierre operativo corre en Claude Code;
     `informe_auditoria_prelanzamiento.md` como referencia.
  3. *Específicos (adjuntar):* `traspaso_cierre_v13.md`;
     `estructura_actual.md` (correr el escáner tras el bloque de cierre);
     para el toggle: `33_motor_template.html` vigente.
- **Nota final:** si algún archivo cambió entre sesiones (en particular el
  template tras el deploy), adjuntar la versión más actualizada y avisarlo
  en la apertura.
