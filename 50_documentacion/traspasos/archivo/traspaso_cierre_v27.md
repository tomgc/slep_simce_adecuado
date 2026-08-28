# Traspaso de cierre — slep_simce_adecuado v27

**Proyecto:** slep_simce_adecuado
**Versión:** v27
**Fecha:** 2026-08-26
**Sesión:** 27 — Auditoría pendiente "entidad"→"territorio" en suite (v26 §10) y migración de escala tipográfica del motor a variables CSS
**Entorno:** macOS aarch64, Positron (según protocolo; no verificado en esta sesión, no se ejecutó R)
**Archivos principales modificados:** `50_documentacion/suite/documentar.R` (corregido, entregado como artefacto, no versionado por el asistente — pendiente de reemplazo manual por el usuario, ver §10), `30_procesamiento/33_motor_template.html` (migrado y commiteado)

---

## 1. Resumen ejecutivo

Sesión abrió resolviendo el pendiente declarado en v26 §10 ("evaluar si `documentar.R` referencia 'entidad' pendiente de actualizar a 'territorio'"). Se auditaron `documentar.R` y los 4 HTML standalone ya generados. Se corrigieron 2 residuos de texto UI en `documentar.R` (no versionado aún: es insumo de `suitedoc`, no se confirmó su ruta de versionado en esta sesión). A continuación, por instrucción directa del usuario, se ejecutó una migración de la escala tipográfica de `33_motor_template.html` a 7 variables CSS nombradas (patrón común de la cartera `slep_*`), con piso de 12px. Cambio commiteado y pusheado. Sesión cierra con working tree limpio y push confirmado.

---

## 2. Estado al cierre

**Funciona:** `33_motor_template.html` migrado a variables CSS (`--fs-overline/caption/body/body-lg/h4/h3/h2`), 77 declaraciones sustituidas, sin residuo de literales px salvo `0.92em` (relativo, fuera de scope) y 19 declaraciones D3/JS excluidas por decisión explícita del usuario (ver §7, D-s27-1).

**No funciona / pendiente:**
- `documentar.R` corregido (2 líneas, "entidad"→"territorio" en texto UI) fue entregado como artefacto descargable pero **no se confirmó su reemplazo en el repo ni su commit** en esta sesión. Queda como pendiente abierto.
- Verificación visual en navegador de la migración tipográfica **no ejecutada** (el asistente no tiene navegador; el usuario no reportó haberla corrido). Riesgo de roce señalado: tabla comparativa (L610, contenedor `min-width:1000px`) y popups RBD (L942/944, contenedor angosto).
- Regeneración de la suite standalone (4 HTML) con el `documentar.R` corregido: no se ejecutó.

**Delta respecto a v26:** 1 commit nuevo (`d1d04f6`), pusheado. `git status --short` limpio antes y después del push (confirmado por el usuario, dos corridas).

---

## 3. Registro detallado de cambios

**Cambio 1 — Auditoría y corrección de terminología en `documentar.R`**
Archivo: `50_documentacion/suite/documentar.R` (entregado como artefacto; ruta de versionado real no confirmada esta sesión)
Qué: inventario completo de "entidad" en texto visible (`grep` sobre el archivo completo, no solo fragmentos). Encontrados y corregidos 2 residuos en el bloque `doc_s2_intro`/`doc_s2_cierre` (L395-396 del archivo entregado): "entre distintas entidades" → "entre distintos territorios"; "Para cualquier entidad" → "Para cualquier territorio". No se tocaron: `entidades_tec`/`entidades_gen` (identificadores de código, L254/261, la regla vigente los deja intactos) ni la prosa de la decisión `D-color-nivel` (L195-196, uso analítico neutro de "entidad", no texto UI de cara al lector).
Verificado: `grep -n "entidad"` post-edición sobre el archivo entregado, sin residuo en bloques de texto UI (`rotulos`/`textos`/`notas`/`faq`/`pie_extra`).
Auditoría extendida: se revisaron también los 4 HTML standalone ya generados (`arquitectura_general_*`, `arquitectura_*`, `documentacion_general_*`, `documentacion_proyecto_*`). Confirmado empíricamente: 0 referencias de red (`http(s)://`) en los 4; iconos como `<svg>` embebido, no CDN; fuentes como `data:font` URIs (6 `@font-face` por archivo). Único residuo de "entidad" en los HTML: `documentacion_proyecto_*`, dentro de la misma decisión `D-color-nivel` ya evaluada como fuera de scope.
Ejecutado por: asistente (edición del archivo entregado; sin ejecución en el repo real).
Commit: ninguno (pendiente, ver §10).

**Cambio 2 — Migración de escala tipográfica a variables CSS en `33_motor_template.html`**
Archivo: `30_procesamiento/33_motor_template.html`
Qué: definidas 7 variables en `:root` (`--fs-overline:12px`, `--fs-caption:14px`, `--fs-body:16px`, `--fs-body-lg:18px`, `--fs-h4:18px`, `--fs-h3:22px`, `--fs-h2:28px`). Inventariadas 96 declaraciones `font-size` totales en el archivo (CSS declarativo + `fontSize` inline React + `.attr("font-size",N)` D3 + objetos JS `"font-size":N`). Mapeadas por rol (no por rango numérico ciego) las 77 declaraciones CSS/React a las 7 variables; 19 declaraciones D3/objetos JS excluidas del commit por decisión explícita del usuario (D-s27-1).
Overrides por rol resueltos: L153 (30px, `.app-title`) mapeado a `--fs-h2` (28px) por ausencia de nivel "display" entre las 7 variables pedidas — aproximación declarada, no hay variable exacta. Nueve valores sin variable exacta (9px, 9.5px, 10px, 10.5px, 11.5px) mapeados a `--fs-overline` (12px), suben el tamaño real entre 0.5px y 3px: L457, 482, 496, 568, 637, 655, 659, 701, 735, 890, 942, 944, 951, 953.
Verificado: conteo de `font-size` total (96) idéntico antes/después (77 migradas + 19 excluidas). `:root` bien formado (llaves balanceadas, verificado por regex). 0 residuos de literales `px` fuera de las 19 excluidas y `0.92em` (L905, relativo, fuera de scope).
No verificado (R1, el asistente no ejecuta R ni navegador): regeneración del motor con `33_generar_html.R`, verificación visual en navegador de ninguna combinación vista/foco.
Ejecutado por: asistente (código) + usuario (commit y push en Positron/terminal).
Commit: `d1d04f6`. Push confirmado: `65302c6..d1d04f6 main -> main` (fuente: output de terminal pegado por el usuario, este turno).

---

## 4. Backlog acumulativo

**No actualizado en esta sesión.** El asistente no tiene acceso de escritura al repo real; `backlog_acumulativo.md` requiere edición directa en `50_documentacion/activa/` que no se ejecutó. Entradas pendientes de añadir en la próxima apertura (ver §10): auditoría terminología documentar.R, migración escala tipográfica, hallazgo D3/JS sin migrar, aprendizaje A-s27-1.

**Delta del backlog s27:** no aplicado. Total acumulado sigue en 133 (v26) hasta que se registre esta sesión.

---

## 5. Bugs de la sesión

No aplica. Sin bugs de código detectados ni corregidos.

---

## 6. Aprendizajes y restricciones

**A-s27-1 (verificación de commit real antes de asumir "listo"):** el primer intento de commit reportó `nothing to commit, working tree clean` porque el archivo descargado por el usuario no había sido reemplazado aún en el repo local. El asistente detectó la discrepancia contrastando el hash de commit resultante (de otro tema, `65302c6d`, fecha 24-08) contra lo esperado, y preguntó explícitamente antes de asumir que el commit correspondía a la tarea. Regla: un `git commit` que retorna "nothing to commit" tras una edición reportada como lista es señal de reemplazo manual no ejecutado, nunca se asume commit exitoso solo porque el comando corrió sin error.

---

## 7. Decisiones de diseño

**D-s27-1 — Alcance de la migración tipográfica: excluir D3 SVG y objetos JS**
Alternativas presentadas: (A) incluir ambas familias no-CSS/React en el mapeo; (B) dejar ambas fuera de este commit, reportar como hallazgo aparte; (C) incluir solo objetos JS, dejar D3 SVG fuera. Decisión del usuario: (B). Razón: el encargo original definía scope explícito (CSS declarativo + `fontSize` inline React); D3 SVG tiene decimales atípicos (9.5, 10.5) sin variable exacta y varios valores <12px por diseño (etiquetas de eje compactas), forzar el piso ahí arriesga roce en gráficos compactos sin mandato explícito para tocarlos.

**D-s27-2 — Overrides por rol, no por rango numérico**
Aplicado el criterio ya establecido en el encargo del usuario: valores que numéricamente caen en un rango pero funcionan como otro nivel (L153, 30px funcionando como título máximo) se mapean por rol, no por proximidad numérica ciega, y se reportan como override explícito.

---

## 8. Constantes y parámetros vigentes

| Constante | Valor | Archivo |
|---|---|---|
| Escala tipográfica (nueva, s27) | `--fs-overline:12px · --fs-caption:14px · --fs-body:16px · --fs-body-lg:18px · --fs-h4:18px · --fs-h3:22px · --fs-h2:28px` | `33_motor_template.html` `:root` |
| Piso tipográfico | 12px | `33_motor_template.html` |
| Familias fuera de la migración (deuda) | D3 `.attr("font-size")` (líneas ~1849-2103 del archivo pre-migración) y objetos JS `"font-size":N` (líneas ~2414-2536) | `33_motor_template.html` |
| Años cubiertos | 2014–2018, 2022–2025 | `31_leer_normalizar.R` |
| Umbral mínimo alumnos | 10 | `33_generar_html.R` |
| POLITICA_PROYECTO.md vigente | ver §9, discrepancia de tamaño no investigada esta sesión | `50_documentacion/activa/` |
| Backlog canónico | `backlog_acumulativo.md` (sin actualizar esta sesión) | `50_documentacion/activa/` |

---

## 9. Arquitectura de archivos

Escáner al cierre: `2026-08-26 09:21:20` (adjunto, `estructura_actual.md`). `33_motor_template.html`: 148K → 149K, consistente con +86/-77 líneas del commit `d1d04f6`.

**Discrepancias frente al escáner de v26 (2026-07-01) no atribuibles a esta sesión — declaradas, no investigadas:**
- `POLITICA_PROYECTO.md`: 33K → 42.8K.
- `SETTINGS_Y_PROMPTS_OPERACIONALES.md`: 46.7K → 137K.
- `CLAUDE.md` (6.92K en v26) ausente del árbol actual.
- Nuevos: `10_utils/10_validar_portabilidad.R`, `.Renviron.example`, `.Rprofile`, `renv.lock`.
- Desaparecidos: varios `.DS_Store` (`docs/`, `40_salidas/`, `20_insumos/simce/`, `20_insumos/`).

(hipotesis, verificar con: `git log --oneline -- 50_documentacion/activa/POLITICA_PROYECTO.md 50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md CLAUDE.md` para atribuir estos cambios a sesiones anteriores no documentadas en un traspaso, o a edición fuera de protocolo)

Sin hallazgos nuevos sin auditar más allá de lo anterior.

---

## 10. Pendientes y ruta sugerida

**Inventario:**

| Pendiente | Tipo | Complejidad | Contexto |
|---|---|---|---|
| Reemplazar `documentar.R` en el repo y commitear | deuda de cierre | Baja | Artefacto ya corregido y entregado en la sesión, falta el paso manual + commit |
| Verificación visual en navegador de la migración tipográfica | verificación | Baja-Media | Regenerar motor (`33_generar_html.R`) y revisar tabla comparativa (L610) y popups RBD (L942/944) primero |
| Migrar D3 SVG + objetos JS a variables CSS | deuda técnica | Media | Excluida de s27 por decisión D-s27-1; requiere su propio análisis de roce en gráficos compactos |
| Regenerar suite standalone con `documentar.R` corregido | funcionalidad/deuda visual | Media | Depende del pendiente anterior (reemplazo + commit de `documentar.R`) |
| Actualización anual insumos SIMCE 2025/2026 | funcionalidad | Media-Alta | Bloqueada, insumos no cargados (heredado de v26) |
| Actualizar `backlog_acumulativo.md` con entradas de s27 | administrativo | Baja | No ejecutado esta sesión por falta de acceso de escritura al repo |

**Auditoría de cierre (política 5.6):**
- ¿Pipeline corre de cero sin intervención manual? → Sí, no tocado en su lógica (solo CSS/template).
- ¿Outputs reproducibles e idempotentes? → No verificado (no se regeneró el motor esta sesión).
- ¿Decisiones metodológicas como constantes nombradas? → Sí (7 variables CSS en `:root`, nombradas por rol).
- ¿Nombres sin tildes/ñ/espacios? → Sí (variables en inglés/convención CSS estándar).

**Ruta sugerida s28:** (1) reemplazar y commitear `documentar.R`; (2) regenerar motor y verificar visualmente la migración tipográfica, con foco en tabla comparativa y popups RBD; (3) si hay tiempo, evaluar migración D3/JS como tarea separada con su propio análisis de roce.

---

## 11. Instrucciones específicas para la próxima sesión

- 🔒 `directorio_oficial_ee.csv`: no re-versionar con MRUN ni columnas de persona natural.
- 🔒 Estado por defecto del motor = 4 comunas Costa Central · Servicio Local.
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- 🔒 Identificadores de código con raíz "entidad" permanecen así; solo texto UI dice "territorio".
- 🔒 Escala tipográfica del motor: las 7 variables CSS de `33_motor_template.html` `:root` son ahora la fuente única para CSS declarativo y `fontSize` inline React; no reintroducir literales px en esos contextos.
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`.
- ✅ `docs/index.html` se actualiza por copia manual; no editar directamente.
- ⚠️ `documentar.R` corregido (terminología) no está aún en el repo: ver pendiente §10.
- ⚠️ D3 SVG y objetos JS de `33_motor_template.html` NO usan las variables CSS nuevas (deuda declarada, D-s27-1).
- ⚠️ Discrepancias de tamaño en `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` frente a v26 no investigadas (§9); verificar antes de asumir versión vigente.
- ⚠️ Backlog acumulativo NO actualizado con entradas de s27; hacerlo al abrir s28 antes de cualquier otro trabajo.

---

## 12. Fragmentos de código de referencia

```css
/* Bloque :root añadido en 33_motor_template.html, s27 */
:root {
  --fs-overline: 12px;
  --fs-caption:  14px;
  --fs-body:     16px;
  --fs-body-lg:  18px;
  --fs-h4:       18px;
  --fs-h3:       22px;
  --fs-h2:       28px;
  /* ... resto de variables existentes ... */
}
```

```bash
# Verificación de push y árbol limpio (s27, fuente: terminal del usuario):
# git -C <ruta> status --short   -> vacío
# git -C <ruta> push origin main -> 65302c6..d1d04f6 main -> main
# git -C <ruta> log origin/main..HEAD --oneline -> vacío (sin huérfanos)
```

---

## 13. Errores del asistente (§2.2.15)

Ninguno registrado como error del asistente propiamente dicho. Nota de proceso (no error): el primer intento de commit por parte del usuario retornó "nothing to commit" porque el archivo aún no había sido reemplazado manualmente; el asistente lo detectó antes de asumir cierre y pidió confirmación (ver A-s27-1). No se clasifica como error del asistente porque el paso de reemplazo manual es responsabilidad del usuario según protocolo, y el asistente no asumió commit exitoso sin verificar el hash resultante.

---

## 14. Reapertura

**Nombre del chat:** `slep_simce_adecuado, sesión 28 (Claude Sonnet 5)`

**Mensaje de apertura:**
> Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA + SETTINGS vigentes) vive en la knowledge base; léelo desde ahí. Adjunto el traspaso v27 y el escáner actual.

**Documentos para la próxima sesión:**

*En knowledge base (no adjuntar):*
- `POLITICA_PROYECTO.md` (verificar versión vigente real, ver §9)
- `SETTINGS_Y_PROMPTS_OPERACIONALES.md` (verificar versión vigente real, ver §9)

*Adjuntar:*
- `traspaso_cierre_v27.md`
- `estructura_actual.md` (escáner al abrir)
- `documentar.R` corregido (si aún no se reemplazó en el repo, ver pendiente §10)
