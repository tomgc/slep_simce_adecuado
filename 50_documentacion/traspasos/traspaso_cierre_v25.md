# Traspaso de cierre — slep_simce_adecuado v25

**Proyecto:** slep_simce_adecuado
**Versión:** v25
**Fecha:** 2026-07-01
**Sesión:** 25 — Renombrado UI "entidad"→"territorio" y reparación de backlog truncado
**Entorno:** macOS aarch64, Positron, R 4.5.2
**Archivos principales modificados:** `33_motor_template.html`, `docs/index.html`, `backlog_historico.md`, `POLITICA_PROYECTO.md` (versionado)

---

## 1. Resumen ejecutivo

La sesión abrió verificando que la versión publicada en GitHub Pages estaba sincronizada (confirmado, sin cambios). El trabajo sustantivo fue renombrar el concepto de UI "entidad" a "territorio" en 33 líneas de texto/comentarios/CSV-header de `33_motor_template.html`, ejecutado por Claude Code vía encargo autónomo, con identificadores de código intocables por decisión explícita. Se regeneró y desplegó el motor. En el housekeeping posterior se descubrió que el commit `572324a` (sesión 24, normalización de tags) había truncado por error las secciones de sesión 23-24 del backlog; se reparó tras un intento fallido que corrompió el archivo (revertido con `git revert`) y un segundo intento exitoso vía edición controlada. Sesión cierra con working tree limpio, backlog en 128 entradas, y 3 errores del asistente registrados.

---

## 2. Estado al cierre

**Funciona:** motor desplegado en GitHub Pages con "territorio" en toda la UI visible; `origin/main = 42c6e40`; backlog íntegro 1–128; pipeline reproducible (`00_build.R` verificado esta sesión, ejecución limpia, 44975 filas).

**No funciona / pendiente:** nada activo.

**Delta respecto a v24:** 8 commits (`0c70db0`, `98d489f`, `c9841d8`, `1bec332`, `8e4ee61`, `54197f5`, `a2376e3` [revert], `42c6e40`).

---

## 3. Registro detallado de cambios

**Cambio 1 — Renombrado "entidad"→"territorio" en UI**
Archivo: `30_procesamiento/33_motor_template.html`
Qué: 33 líneas (texto JSX visible, comentarios, header CSV export) renombradas de "entidad" a "territorio"; identificadores de código (`entidadDependeSlep`, `entidadesPorDefecto`, `MAX_ENTIDADES`, `entities`/`entity`) intocables por decisión explícita del usuario (dos gates de alcance resueltos antes de redactar el encargo).
Verificado: conteo `[Ee]ntidad` remanente = 8 (todos identificadores/invocaciones protegidas), `[Tt]erritorio` = 33, identificadores sin variación.
Ejecutado por: Claude Code, encargo autónomo `encargo_renombrar_entidad_territorio.md`.
Commit: `0c70db0`.

**Cambio 2 — Regeneración y deploy del motor**
Archivos: `40_salidas/motor_comparacion.html` (no versionado), `docs/index.html`
Qué: `00_build.R` ejecutado end-to-end (pipeline completo, 44975 filas en `simce_comunal.parquet`); copia manual a `docs/`.
Verificado: gate visual del usuario cumplido; md5 de `docs/index.html` confirmado (`a23d5b6e…`), 33 ocurrencias de "territorio", 0 residuales de "Agregar/Editar entidad".
Commit: `98d489f`.

**Cambio 3 — Versionar POLITICA_PROYECTO.md**
Archivo: `50_documentacion/activa/POLITICA_PROYECTO.md`
Qué: archivo que estaba untracked se versionó por primera vez (decisión: sí, sin datos sensibles, útil para trazabilidad pública).
Commit: `c9841d8`.

**Cambio 4 — Housekeeping: encargo y log**
Archivos: `50_documentacion/activa/encargos/encargo_renombrar_entidad_territorio.md`, `50_documentacion/andamios/logs/20260701_renombrar_entidad_territorio_log.md`
Commit: `1bec332`.

**Cambio 5 — Rotación de snapshots de estructura**
Archivo: `50_documentacion/estructura/*`
Commit: `8e4ee61`.

**Cambio 6 — Reparación de backlog truncado (bug A-s25-1)**
Archivo: `50_documentacion/activa/backlog_historico.md`
Qué: se descubrió que el commit `572324a` (sesión 24, "normalizar tags") truncó accidentalmente las secciones de sesión 23–24 (entradas 117–120) del archivo real, aunque el contenido sí existía íntegro en el propio commit `8944c2e` (ancestro directo de `572324a`) — es decir, `572324a` reescribió el detalle cronológico completo para normalizar tags pero perdió las últimas dos secciones en el proceso. Reparado reinsertando 117–120 (con tags ya normalizados al formato `[CÓDIGO]`) más las entradas 121–128 correspondientes a las sesiones 24 y 25.
Primer intento (commit `54197f5`) falló: reconstrucción vía `head -n 116` en terminal capturó una sesión de terminal anterior arrastrada, produciendo un archivo corrupto de 143 líneas con las sesiones 14–22 perdidas. Revertido inmediatamente con `git revert --no-edit 54197f5` (commit `a2376e3`), restaurando el estado íntegro de 116 entradas / 235 líneas.
Segundo intento exitoso: edición controlada vía `str_replace` sobre copia local, verificación de líneas/md5 antes de entregar el archivo completo al usuario para reemplazo manual, luego verificación de líneas/md5/diff en disco antes de comitear.
Verificado: 262 líneas, md5 `0cbaba793afd6f4c14a51edfa769408b` coincidente entre lo generado y lo commiteado, diff `+27/-0` (append puro, sin pérdida).
Commits: `54197f5` (fallido), `a2376e3` (revert), `42c6e40` (reparación correcta).

---

## 4. Backlog acumulativo

Ver `50_documentacion/activa/backlog_historico.md`, entradas 1–128. Entradas nuevas esta sesión: 125–128 (renombrado, reparación de backlog, versionado de política, deploy).

**Delta del backlog s25:** 4 entradas nuevas (125–128). Total acumulado: **128**.

---

## 5. Bugs de la sesión

**Bug 1 — Truncamiento silencioso del backlog en commit `572324a` (sesión 24)**
Síntoma: `backlog_historico.md` en disco terminaba en la entrada 116 pese a que el traspaso v24 declaraba 120 entradas y un commit `572324a` posterior a `8944c2e` (que sí tenía 117–120).
Causa raíz: al normalizar tags del detalle cronológico completo (`— CÓDIGO` → `[CÓDIGO]`), el proceso de reescritura de esa sesión (24) perdió las secciones de sesión 23 y 24 del propio archivo que estaba editando — probablemente un reemplazo de rango mal acotado que no incluyó el tramo final.
Solución: reinsertar 117–120 desde el commit `8944c2e` (que sí las tenía íntegras) con tags ya normalizados, más las entradas 121–128 de las sesiones 24 y 25.
Verificación: diff final `+27/-0` contra el estado post-revert de 116 entradas; md5 confirmado antes y después del reemplazo en disco.
Patrón general aprendido: reescrituras de archivo completo (no apéndices) que tocan "todo el detalle cronológico" deben verificar el conteo de líneas/entradas antes y después del propio commit que las genera, no solo confiar en el mensaje de commit. Regla aplicable: todo commit que reescribe un archivo completo debe declarar en su propio proceso un `wc -l` antes/después como parte de su verificación, no solo el asistente de la sesión siguiente al detectarlo.
Estado: resuelto.

**Bug 2 — Corrupción del backlog en el primer intento de reparación**
Síntoma: tras `head -n 116 backlog_historico.md > /tmp/backlog_reparado.md`, el archivo resultante tenía 143 líneas con contenido de una sesión de terminal anterior mezclado ("## Sesión 13" seguido de nada, sesiones 14–22 perdidas).
Causa raíz: el bloque de comandos se ejecutó en dos tandas separadas (el usuario pegó primero un bloque que falló por ruta relativa, luego un segundo bloque que asumía que el primero había corrido); el `head -n 116` capturó el estado de una terminal con historial de comandos previos arrastrado, no el archivo real esperado.
Solución: `git revert --no-edit 54197f5` restauró el estado exacto pre-error; segundo intento usó edición controlada vía herramienta (`str_replace` sobre copia local) con verificación de líneas y md5 ANTES de entregar el archivo, evitando reconstrucción por comandos de terminal que dependen de estado implícito.
Verificación: `wc -l` y `md5` coincidentes en cada paso del segundo intento.
Patrón general aprendido: nunca reconstruir un archivo completo vía comandos de terminal (`head`/heredoc) cuando hay riesgo de estado de sesión arrastrado entre bloques pegados por el usuario; preferir generar el archivo completo con herramientas propias (str_replace/create_file), verificarlo, y entregarlo para reemplazo mecánico o edición directa por Claude Code en un único bloque atómico.
Estado: resuelto (revertido y reparado correctamente).

---

## 6. Aprendizajes y restricciones

**A-s25-1 (bug crítico del backlog):** ver Bug 1 arriba. Registrado también como nota inline en la entrada 124 del backlog mismo, para que quede visible en el historial temático, no solo en el traspaso.

**A-s25-2 (reconstrucción de archivos por terminal es frágil):** ver Bug 2. Regla: para reparaciones o reescrituras de archivos completos, generar y verificar el contenido con herramientas propias antes de tocar el filesystem del proyecto; si se delega a Claude Code, un único bloque atómico de comandos, sin asumir estado de pasos anteriores.

**A-s25-3 (nombre real del backlog):** el nombre canónico según `SETTINGS_Y_PROMPTS_OPERACIONALES.md` es `backlog_acumulativo.md`, pero el archivo real del proyecto es `backlog_historico.md`. Deuda heredada ya conocida, no corregida esta sesión (fuera de alcance del pedido).

**A-s25-4 (ESTADO.md y POLITICA_PROYECTO.md duplicado):** el escáner de cierre muestra `50_documentacion/activa/ESTADO.md` (Fase 2 del orquestador de cartera, no mencionado en memoria previa del proyecto) y dos copias de `POLITICA_PROYECTO.md` (raíz, 30.3K, vs `50_documentacion/activa/`, 33K, recién versionado). Ninguno de los dos fue auditado ni tocado esta sesión; quedan como hallazgo para la próxima apertura.

---

## 7. Decisiones de diseño

**D-s25-1 — Alcance del renombrado: solo texto UI, no tabs**
El usuario mostró dos capturas (proyecto propio con 5 tabs "Agregar entidad"; proyecto hermano con 3 tabs "Agregar territorio"). Decisión: solo renombrar texto/labels, mantener las 5 tabs actuales (Establecimiento/Comuna/SLEP/Región/Nacional/Grupo personalizado). No es reducción funcional.

**D-s25-2 — Identificadores de código intactos**
`entidadDependeSlep`, `entidadesPorDefecto`, `MAX_ENTIDADES`, `entities`/`entity` no se renombran. Decisión explícita del usuario tras pregunta de alcance; reduce el riesgo del cambio de ~185 posibles ocurrencias a 33 líneas reales.

**D-s25-3 — Header CSV export sí se renombra**
El campo `"entidad"` en el array de headers del CSV exportado (L2329) se cambia a `"territorio"` pese a que rompe compatibilidad con análisis externos que dependan del nombre de columna anterior. Decisión: consistencia total sobre retrocompatibilidad silenciosa (el usuario eligió explícitamente esta opción tras la pregunta de alcance).

**D-s25-4 — POLITICA_PROYECTO.md se versiona**
Recomendación del asistente (sin dato previo explícito): versionar por ausencia de datos sensibles y valor de trazabilidad pública. Aceptada. Nota: existe ahora una segunda copia en la raíz del proyecto (30.3K, distinta en tamaño a la de `50_documentacion/activa/`, 33K) — no auditada, ver A-s25-4.

---

## 8. Constantes y parámetros vigentes

| Constante | Valor | Archivo |
|---|---|---|
| Años cubiertos | 2014–2018, 2022–2025 | `31_leer_normalizar.R` |
| Año preliminar | 2025 | `33_generar_html.R` |
| Umbral mínimo alumnos | 10 | `33_generar_html.R` |
| Estado por defecto | 4 comunas Costa Central · depe2="5" | `33_motor_template.html` |
| Concepto UI de agrupación | "territorio" (antes "entidad") | `33_motor_template.html` (texto); identificadores de código siguen en "entidad" |
| Lucide-static | 1.21.0 | `documentar.R` |

---

## 9. Arquitectura de archivos

Escáner al cierre: `2026-07-01 11:41:45` (adjunto). Sin cambios estructurales de carpetas esta sesión. Hallazgos sin auditar: `ESTADO.md` nuevo, `POLITICA_PROYECTO.md` duplicado (raíz + activa/), `docs/.DS_Store` nuevo.

Untracked por diseño: `50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md`.

---

## 10. Pendientes y ruta sugerida

No hay pendientes bloqueantes ni activos. El proyecto está estable y desplegado.

Candidatos a sesión futura:
- Auditar `ESTADO.md` y el `POLITICA_PROYECTO.md` duplicado (A-s25-4): confirmar cuál es la fuente canónica y si la duplicación es intencional (Fase 2 del orquestador de cartera) o deuda.
- Regenerar suite standalone (contenido de `documentar.R` no cambió esta sesión, pero el motor sí — evaluar si la suite referencia terminología "entidad" que debería actualizarse a "territorio").
- Actualización anual de insumos Simce (2025 final o 2026).
- Resolver A-s25-3: decidir si renombrar `backlog_historico.md` → `backlog_acumulativo.md` para alinear con el nombre canónico, o formalizar la excepción en la política del proyecto.

---

## 11. Instrucciones específicas para la próxima sesión

- 🔒 `directorio_oficial_ee.csv`: no re-versionar con MRUN ni columnas de persona natural (D21-1).
- 🔒 Estado por defecto del motor = 4 comunas Costa Central · Servicio Local; el reset restaura ese estado (D23-1).
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- 🔒 Identificadores de código con raíz "entidad" (`entidadDependeSlep`, `entidadesPorDefecto`, `MAX_ENTIDADES`, `entities`/`entity`) permanecen así; solo el texto UI dice "territorio" (D-s25-2).
- ✅ ANTES de regenerar la suite, verificar `npm --version` (requiere npm + red para lucide-static 1.21.0).
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`.
- ✅ `docs/index.html` se actualiza por copia manual desde `40_salidas/motor_comparacion.html`; no editar directamente.
- ⚠️ Para afirmar qué está versionado usar `git ls-files`, no el escáner (A20).
- ⚠️ `SETTINGS_Y_PROMPTS_OPERACIONALES.md` se mantiene local (untracked) por diseño.
- ⚠️ Nombre real del backlog es `backlog_historico.md`, no `backlog_acumulativo.md` (A-s25-3, deuda heredada).
- ⚠️ Existe `ESTADO.md` y un `POLITICA_PROYECTO.md` duplicado sin auditar (A-s25-4).
- ⚠️ Nunca reconstruir archivos completos vía `head`/heredoc en terminal sin verificar estado previo (A-s25-2).

---

## 12. Fragmentos de código de referencia

```r
# Ejecución canónica del pipeline:
source("00_build.R")

# Deploy a Pages (manual, el pipeline no toca docs/):
# copiar 40_salidas/motor_comparacion.html a docs/index.html y git push.
```

```bash
# Patrón seguro de reparación de archivo completo (evita Bug 2):
# 1. Generar y verificar el contenido con herramientas propias (no terminal).
# 2. Confirmar wc -l y md5 antes de tocar el filesystem real.
# 3. Reemplazar en un único paso, sin bloques de comandos dependientes de estado previo.
```

---

## 13. Errores del asistente (§2.2.15)

| momento | disparador | que_paso | regla_violada | causa_raiz | salvaguarda_presente | patron |
|---|---|---|---|---|---|---|
| Reparación del backlog, primer intento | usuario lo corrigió | pedí "descarga y reemplaza manualmente" para una tarea editable por Claude Code | userPreferences, Autonomy: tareas mecánicas manuales son solo descargar/arrastrar/reemplazar por mano, no edición de contenido delegable | clasifiqué mal el tipo de tarea (confundí "edición de archivo" con "acción manual del titular") | userPreferences (Autonomy) | nuevo |
| Reparación del backlog, primer intento | usuario lo corrigió | di instrucción de verificación después de la instrucción de ejecución/commit, en vez de antes | orden lógico de instrucciones a Claude Code (verificar antes de actuar, no después) | redacté los pasos en el orden en que los pensé, no en el orden de ejecución segura | ninguna explícita (buen juicio operativo) | nuevo |
| Reparación del backlog, primer intento (commit `54197f5`) | asistente lo señaló espontáneamente (tras ver el resultado corrupto) | generé un bloque `head -n 116 ... > archivo` que, al ejecutarse en una terminal con estado de comandos previos arrastrado entre dos bloques pegados por separado, produjo un archivo corrupto (143 líneas, sesiones 14–22 perdidas), commiteado y pusheado antes de detectarlo | POLITICA/DISCIPLINA_OPERATIVA R9 (verificar estado real antes de actuar) — no verifiqué el contenido generado antes de indicar el commit | no exigí una verificación intermedia (`tail`/`wc -l` del archivo temporal) antes de la instrucción de mover+commitear+pushear, y asumí que un bloque de comandos pegado por el usuario se ejecuta en un entorno de terminal sin estado previo | POLITICA (R9) | nuevo |

---

## 14. Reapertura

**Nombre del chat:** `slep_simce_adecuado, sesión 26 (Claude Sonnet 5)`

**Mensaje de apertura:**
> Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA v5 + SETTINGS v4 + DISCIPLINA_OPERATIVA v1) vive en la knowledge base; léelo desde ahí. Adjunto el traspaso v25 y el escáner actual.

**Documentos para la próxima sesión:**

*En knowledge base (no adjuntar):*
- `POLITICA_PROYECTO.md` (v5)
- `SETTINGS_Y_PROMPTS_OPERACIONALES.md` (v4)
- `DISCIPLINA_OPERATIVA.md` (v1) — nota: no presente en esta knowledge base de Project; verificar si corresponde añadirlo.

*Adjuntar:*
- `traspaso_cierre_v25.md`
- `estructura_actual.md` (escáner al abrir)
