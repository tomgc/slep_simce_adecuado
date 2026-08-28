# Traspaso de cierre v19 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v19
- **Fecha:** 2026-06-19
- **Sesión:** 19 — doble foco: (a) evaluar y accionar el pendiente de
  gobernanza 4b/depe4 = 1 EE heredado de v18; (b) implementar la suite de
  documentación (`suitedoc`) en el proyecto.
- **Entorno:** sesión en interfaz web; build, escáner y git ejecutados por el
  usuario en terminal (zsh, macOS) y Claude Code / Positron.
- **Archivos principales creados/modificados:** carpeta nueva
  `50_documentacion/suite/` (`documentar.R` + 4 HTML + `suite_estilos.css` +
  tema `fonts/`, `assets/`); `.gitignore` (dos líneas nuevas). Sin cambios de
  pipeline, motor ni constantes.

## 2. Resumen ejecutivo

Sesión de doble foco, sin tocar el pipeline. **(a)** El pendiente de gobernanza
heredado (una celda comuna×GSE de 4b filtrada a una dependencia con `n_estab=1`
podría identificar un establecimiento) se cerró tras leer el motor: el riesgo de
exponer establecimientos individuales ya existe de forma **general** (cualquier
punto con `n_estab===1` muestra el RBD y permite ver el nombre vía el popup), y
está **cubierto por la decisión D-nombres (B2, sesión 13)**, que verificó que la
restricción de §6.4 aplica a las bases por estudiante (microdatos enmascarados,
no usadas aquí) y no a las bases por establecimiento, que son públicas y la
propia Agencia difunde nominalmente. Conclusión: **no procede salvaguarda**;
implementarla contradiría D-nombres y degradaría utilidad. No se tocó código. El
cierre quedó razonado en este traspaso pero **sin archivo de decisión todavía**.
**(b)** A pedido del usuario se implementó la suite `suitedoc`: por
reverse-engineering del `documentar.R` del proyecto hermano
`slep_categoria_desempeno` se redactó un `documentar.R` adaptado a este proyecto,
se generaron los 4 HTML, se auditaron, se quitaron dos referencias al proyecto
hermano para autocontención del manual, se regeneró y se versionó (commit
`e9b251d`, push a `origin/main`).

## 3. Estado al cierre

**Qué funciona:**
- Suite de documentación generada y versionada en `50_documentacion/suite/`
  (4 HTML + `documentar.R` + `suite_estilos.css`; tema `fonts/`/`assets/`
  ignorado). Regenerable de forma determinista con un comando.
- Motor y pipeline sin cambios desde v18 (build limpio, Pages al día).
- Rama `main` al día con `origin/main` tras el push del commit `e9b251d`.

**Qué no funciona / pendiente:**
- El cierre de gobernanza 4b/depe4 quedó **resuelto pero sin formalizar** en un
  archivo de decisión.
- Dos marcas `# REVISAR` en el `documentar.R` sin cotejar contra su archivo de
  decisión original (ver sección 11).

**Delta respecto a v18:**
- Nueva suite `suitedoc` versionada (estructura: +carpeta `50_documentacion/suite/`).
- Pendiente de gobernanza heredado: resuelto (cubierto por D-nombres).

## 4. Registro detallado de cambios (de la sesión)

1. **Evaluación y cierre del pendiente de gobernanza 4b/depe4.** Categoría:
   gobernanza/auditoría. Se leyó el motor (`33_motor_template.html`) y se
   constató que `cod_depe2` es eje de segmentación real (selector "Dependencia"
   + `generateSeriesByDepe`), y que cualquier punto de serie con `n_estab===1`
   ya expone el RBD (tooltip: "un solo establecimiento (RBD …)") y el nombre (popup
   "Ver establecimientos"). Verificado contra la decisión D-nombres: mostrar
   resultados por establecimiento es deliberado y normativamente fundado.
   Conclusión: no implementar supresión. Cómo se verificó: lectura de
   `generateSeriesByDepe`, `getSeriesForEntity`, tooltip/`isLowN`, EstabPopup, y
   contraste con `20260611_decision_nombres_establecimientos.md`. Sin cambios de
   código.

2. **Implementación de la suite `suitedoc` (`documentar.R` + 4 HTML).**
   Categoría: documentación. Reverse-engineering de la API de `suitedoc` 0.3.0 a
   partir del `documentar.R` del proyecto hermano; `cfg` poblada desde el escáner,
   el README, los scripts `30`–`33`, el traspaso v18 y la decisión de nombres.
   Contenido **invertido** respecto al hermano donde difiere (agregación ponderada
   por evaluados, GSE inviolable) y runtime/deploy verificados contra el código
   real (React/ReactDOM/Babel por CDN unpkg con SRI, D3/pako inline; deploy a
   `docs/` manual). Se añadió `here::i_am()` para poder correr vía `Rscript`.
   Cómo se verificó: `generar_suite()` produjo los 4 HTML; auditoría manual de
   los cuatro contra los scripts.

3. **Auditoría de la suite, ajuste y versionado.** Categoría: documentación /
   operativo-versionado. Auditados los 4 HTML (fieles, sin residuos del ejemplo
   de fábrica, terminología SLEP correcta). Único ajuste de contenido: se
   quitaron dos referencias al "proyecto hermano" en las decisiones de Agregación
   ponderada y GSE inviolable, para autocontención del manual. Regenerada la
   suite y versionada: `git add` de `.gitignore` + `documentar.R` + 4 HTML +
   `suite_estilos.css`; `fonts/` y `assets/` al `.gitignore`. Commit `e9b251d`,
   push `0bb504c..e9b251d`. Verificado: 7 archivos en stage, nada de tema; push OK.

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md` (documento vivo).
Viene de las sesiones 1–18 (entradas 1–102). **Esta sesión agrega las entradas
103–105**, continuando la numeración. Resumen de la sesión 19:

- **103 (gobernanza/auditoría):** evaluación del pendiente 4b/depe4 = 1 EE y
  cierre como cubierto por la decisión D-nombres (B2); sin salvaguarda, sin
  cambios de código. Resuelve el pendiente foco de la ruta sugerida en v18.
- **104 (documentación):** implementación de la suite `suitedoc` en el proyecto
  (`documentar.R` + 4 HTML) por reverse-engineering del `documentar.R` del
  proyecto hermano.
- **105 (documentación / operativo):** auditoría de la suite, ajuste de
  autocontención (quitar referencias al proyecto hermano) y versionado (commit
  `e9b251d`).

**Sobre la taxonomía:** la categoría documentación absorbe 104–105; gobernanza/
auditoría absorbe 103. Ambas de baja frecuencia; sin recomendación de
subdivisión.

**Delta del backlog:** 3 entradas nuevas (103–105). Sin reclasificaciones. Total
acumulado: 105. **Acción pendiente:** trasladar 103–105 a `backlog_historico.md`.

## 6. Bugs de la sesión

No aplica: no se observaron bugs del proyecto. Hubo dos fricciones **operativas**
de herramienta (no del código del proyecto), registradas como aprendizajes en la
sección 7 (verificador de `suitedoc` y anclaje de `here`).

## 7. Aprendizajes y restricciones descubiertas

- **El riesgo de identificación de EE individuales es general y está cubierto por
  D-nombres.** Cualquier punto con `n_estab===1` (no solo 4b/depe4) expone el RBD
  y el nombre, por diseño. Regla: no implementar supresión de celdas por
  `n_estab`; mostrar resultados por establecimiento es deliberado y fundado
  (bases por EE públicas). Principio: una decisión-contrato vigente
  (`decisiones/`) gobierna; no contradecirla. Contexto: implementar una
  salvaguarda habría degradado utilidad y roto la coherencia con D-nombres.
- **`suitedoc` 0.3.0: `verificar = FALSE` es permanente en este proyecto.** El
  ejemplo de fábrica del paquete está basado en un proyecto Simce, así que el
  verificador marca como "residuo" términos legítimos del dominio (`simce`,
  `nalu`, `palu_eda`, `adecuado`, `slep_simce_adecuado`, `motor_comparacion`).
  Regla: mantener `verificar = FALSE`; está documentado en el header del
  `documentar.R`. No revertir a `TRUE`.
- **`documentar.R` usa `here::i_am()` y debe correr desde la raíz del proyecto.**
  Vía `Rscript` desde otro directorio (p. ej. `~`) falla con "Could not find
  associated project". Regla: anteponer `setwd("<raiz>")` en el comando, o correr
  desde el `.Rproj` en Positron.
- **Reverse-engineering de un artefacto aprobado colapsa el espacio de
  adivinanza (A19).** Para implementar la suite se partió del `documentar.R` del
  hermano como referencia de la API; sin él se habría adivinado la estructura de
  la `cfg`. Regla: ante una API no documentada en la knowledge base, pedir un
  artefacto funcional de referencia.
- **Al adaptar del hermano, invertir lo que difiere y verificar contra el código,
  no copiar.** Decisiones (ponderación por evaluados vs conteo de EE; GSE
  inviolable vs sin GSE), runtime (CDN vs inline) y deploy (manual vs automático)
  son distintos entre proyectos; copiar el texto del hermano habría producido
  afirmaciones falsas.

## 8. Decisiones de diseño

- **D19-1: cerrar el pendiente 4b/depe4 sin salvaguarda (cubierto por
  D-nombres).** Alternativas consideradas: (i) colapsar `cod_depe2` de
  `datos_lst` — descartada: `depe2` es eje de segmentación real del motor, se
  rompería la feature; (ii) suprimir celdas con `n_estab < k_min` — descartada:
  contradice D-nombres, degrada utilidad, y la supresión estática a nivel de fila
  comunal sesgaría los agregados ponderados (nacional×depe sí reúne muchos EE).
  Implicancia: el caso queda cerrado a nivel metodológico; falta formalizarlo en
  `decisiones/`.
- **D19-2: el `documentar.R` lo redacta el asistente, no Claude Code.** El
  protocolo 4.6 carga la redacción de la `cfg` (terminología SLEP, no-invención,
  marcado de voz) sobre el asistente; ese protocolo vive en la knowledge base y
  Claude Code no lo tiene, así que armaría la `cfg` a ciegas.
- **D19-3: versionar `documentar.R` + 4 HTML + `suite_estilos.css`; ignorar
  `fonts/` y `assets/`.** La suite no se publica desde el repo (Pages solo sirve
  `docs/`); el tema es regenerable y pesado. Se versiona el CSS para que los HTML
  se vean en la vista previa del repo.
- **D19-4: quitar las referencias al proyecto hermano en el manual.** Autocontención:
  el manual debe sostenerse sin que el lector conozca otro proyecto.

## 9. Constantes y parámetros vigentes (cambios de la sesión)

No aplica: sin cambios de constantes ni parámetros. Vigentes desde v17/v18
(`OP_PREVIO`, `ANIO_DATOS_MAX`, umbral MINEDUC `nalu >= 10`) sin modificación.

## 10. Arquitectura de archivos

Referencia: escáner de cierre `estructura_actual.md` (sello 2026-06-19 21:39:24).
Delta vs v18: **nueva carpeta `50_documentacion/suite/`** con `assets/`, `fonts/`,
los 4 HTML, `documentar.R` y `suite_estilos.css`; `.gitignore` ampliado (dos
líneas: `50_documentacion/suite/fonts/`, `50_documentacion/suite/assets/`).
Totales: 20 carpetas / 127 archivos (antes 17 / 111). Sin cambios en el pipeline,
el motor ni la documentación previa. Los `verificar_*.R` de raíz siguen untracked
(efímeros). Deuda trivial heredada que persiste: `Motor SIMCE.html` con espacio en
`20_insumos/auxiliares/prototipo_design/` (prototipo congelado).

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

| Pendiente | Tipo | Complejidad | Notas |
|---|---|---|---|
| Formalizar el cierre de 4b/depe4 en un archivo de decisión | documentación | baja | `decisiones/YYYYMMDD_decision_celda_unico_establecimiento.md`, vinculado a D-nombres. Cierra lo concluido en 103. Criterio de éxito: archivo creado, pendiente cerrado en backlog |
| Cotejar las 2 marcas `# REVISAR` del `documentar.R` | documentación / verificación | baja | (1) color fijo por estándar contra `20260611_decision_color_por_nivel.md`; (2) matiz "opción a" del manejo de `marca` (A2). Si difieren, ajustar y regenerar |
| Trasladar entradas 103–105 a `backlog_historico.md` | documentación | baja | El traspaso registra el delta; el archivo vivo debe actualizarse |
| (Opcional) `exportarCSV` → `descargarBlob` | deuda técnica | baja | Heredado v18, sin abrir |
| Refuerzo del punto post-traspaso único | mejora visual | baja | Heredado v18; reevaluar con datos 2026 |
| (Opcional) separar JSON del HTML (fetch externo) | optimización | media | Heredado v18; baja el HTML de ~2.5 MB a ~200 KB |
| §6.4 de la política generaliza en exceso la restricción de nombres | documentación (BIBLIOTECA) | baja | Pendiente desde v13; corregir el documento canónico multi-proyecto, no en sesión de proyecto |

**Evaluación de deuda técnica:** sin zonas frágiles nuevas; la sesión no tocó
código del pipeline ni del motor.

**Auditoría de cierre (política 5.6, preguntas "Cierre"):**
- ¿Pipeline reproducible de cero? Sí (sin cambios).
- ¿Cada transformación crítica con check? Sí (sin cambios de pipeline).
- ¿Outputs reproducibles e idempotentes? Sí (la suite se regenera de forma
  determinista con `documentar.R`).
- ¿Decisiones metodológicas como constantes nombradas? Sí (sin constantes nuevas).
- ¿Nombres sin tildes/ñ/espacios? Sí en lo nuevo (`suite/`). Persiste la deuda
  trivial heredada `Motor SIMCE.html` en el prototipo congelado.
- Hallazgo nuevo → pendiente: formalizar el cierre de 4b/depe4 (ya listado).

**Ruta sugerida para la sesión 20 (en orden):**
1. **Formalizar el cierre de 4b/depe4** en `decisiones/` (vinculado a D-nombres).
   Criterio de éxito: archivo de decisión creado y pendiente cerrado en backlog.
2. **Cotejar las 2 marcas `# REVISAR`** del `documentar.R`; si difieren del
   archivo de decisión, ajustar y regenerar la suite. Criterio: marcas resueltas.
3. Diferir: deudas heredadas de v18 (CSV→blob, refuerzo post-traspaso, JSON/HTML).

## 12. Instrucciones específicas para la próxima sesión

- 🔒 **No implementar supresión de celdas por `n_estab`.** Mostrar resultados por
  establecimiento es deliberado y fundado (decisión D-nombres). El caso 4b/depe4
  está cerrado por esa vía.
- 🔒 **Color por nivel, % Adecuado y corte centralizado intocables** (heredados
  v18): color fijo por estándar; verificar invariante Costa Central 4b/lect ante
  cualquier cambio de pipeline; regla del corte solo en
  `SimceData.anioCorteTraspaso()`.
- ✅ **`verificar = FALSE` es permanente** en el `documentar.R` (ejemplo de
  fábrica de `suitedoc` basado en Simce). No revertir a `TRUE`.
- ✅ **ANTES de regenerar la suite:** correr con `setwd("<raiz>")` o desde el
  `.Rproj`; el `documentar.R` usa `here::i_am()` y falla si R arranca fuera de la
  raíz.
- ✅ **Si se actualiza la suite:** versionar `documentar.R` + 4 HTML +
  `suite_estilos.css`; `fonts/` y `assets/` permanecen ignorados.
- ✅ Deploy del motor a Pages sigue **manual** (heredado v18): `00_build.R` →
  copiar `40_salidas/motor_comparacion.html` a `docs/index.html` → push.
- ⚠️ Los `verificar_*.R` de la raíz son efímeros; no versionarlos.

## 13. Fragmentos de código de referencia

```bash
# Regenerar la suite de documentación (here::i_am exige correr desde la raiz):
Rscript -e 'setwd("/Users/tomgc/Projects/slep_simce_adecuado"); source("/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/documentar.R")'
```

```bash
# Versionar la suite (tema regenerable fuera; CSS y HTML dentro):
git -C /Users/tomgc/Projects/slep_simce_adecuado add \
  .gitignore \
  50_documentacion/suite/documentar.R \
  50_documentacion/suite/suite_estilos.css \
  50_documentacion/suite/arquitectura_slep_simce_adecuado.html \
  50_documentacion/suite/arquitectura_general_slep_simce_adecuado.html \
  50_documentacion/suite/documentacion_proyecto_slep_simce_adecuado.html \
  50_documentacion/suite/documentacion_general_slep_simce_adecuado.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status   # 7 archivos, sin fonts/ ni assets/
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 20 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  > (POLÍTICA + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto el
  > traspaso v19 y el escáner actual. Foco de la sesión: formalizar en un archivo
  > de decisión el cierre de gobernanza 4b/depe4 (cubierto por D-nombres) y
  > cotejar las dos marcas `# REVISAR` del `documentar.R` de la suite (color por
  > estándar y manejo de `marca`/A2).

- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar que estén al día):
     `POLITICA_PROYECTO.md` (v6), `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `50_documentacion/suite/documentar.R` si se ajusta
     la suite tras el cotejo; `20260611_decision_color_por_nivel.md` para cotejar
     la marca de color; `CLAUDE.md` si la sesión corre en Claude Code.
  3. *Específicos de la sesión (SÍ adjuntar):* `traspaso_cierre_v19.md`;
     `estructura_actual.md`.

- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo en el mensaje de apertura.
