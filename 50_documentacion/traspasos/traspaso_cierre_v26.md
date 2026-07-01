# Traspaso de cierre — slep_simce_adecuado v26

**Proyecto:** slep_simce_adecuado
**Versión:** v26
**Fecha:** 2026-07-01
**Sesión:** 26 — Auditoría de deuda heredada (A-s25-3, A-s25-4) y sidequest histórico % Adecuado
**Entorno:** macOS aarch64, Positron, R 4.5.2
**Archivos principales modificados:** `POLITICA_PROYECTO.md` (eliminado en raíz), `backlog_historico.md` → `backlog_acumulativo.md`, `README.md`, `ESTADO.md`, `30_procesamiento/34_historico_pct_adecuado_costa_central.R` (nuevo), `40_salidas/historico_pct_adecuado_costa_central.xlsx` (nuevo)

---

## 1. Resumen ejecutivo

Sesión abrió con auditoría de apertura sobre los dos hallazgos sin resolver de v25 (A-s25-3, A-s25-4). Se incorporó un sidequest a mitad de sesión: cálculo de histórico ponderado de % de estudiantes en nivel Adecuado (todos los GSE combinados, sin comparación entre ellos) para Costa Central, separado por nivel (4b/2m) y prueba (lect/mate). Se cerraron ambas deudas heredadas y el sidequest completo. Sesión cierra con working tree limpio, sin bugs activos.

---

## 2. Estado al cierre

**Funciona:** motor sin cambios (no tocado esta sesión); `POLITICA_PROYECTO.md` único y vigente en `50_documentacion/activa/` (v5.2); backlog en `backlog_acumulativo.md` (nombre canónico); script histórico `34_historico_pct_adecuado_costa_central.R` ejecutado y verificado por el usuario contra fuente externa (coincide con cifras ya conocidas del SLEP).

**No funciona / pendiente:** nada activo.

**Delta respecto a v25:** 7 commits (`7ec8461`, `34d681d`, `7af874c`, `f9d8863`, `6a13f3e`, `98c3f6a`, más el pendiente de este cierre).

---

## 3. Registro detallado de cambios

**Cambio 1 — Auditoría A-s25-4: `POLITICA_PROYECTO.md` duplicado**
Archivos: `POLITICA_PROYECTO.md` (raíz, eliminado)
Qué: se determinó mediante `git log -1` que la copia de raíz correspondía a v6 ("vigente y definitiva" según su propio texto, commit `32b090d` del 2026-06-12), mientras que `50_documentacion/activa/POLITICA_PROYECTO.md` es v5.2 (commit `c9841d8` del 2026-07-01, coincide con knowledge base). Pese a que v6 se autodeclaraba posterior, carecía de la regla 0.5 (registro de errores del asistente) y de `backlog_acumulativo.md` como documento obligatorio, ambos presentes en v5.2 — indicio de rama editada en paralelo nunca propagada a `activa/`, no de una sucesora real. Se determinó vigencia por fecha de commit real, no por autodeclaración del texto.
Verificado: `git log -1 --format="%H %ai %s"` en ambas copias antes de decidir.
Ejecutado por: Claude Code (comando dado por el asistente).
Commit: `7ec8461`.

**Cambio 2 — Cierre A-s25-3: rename de backlog**
Archivos: `50_documentacion/activa/backlog_historico.md` → `backlog_acumulativo.md`; `README.md`
Qué: rename vía `git mv` al nombre canónico según POLITICA v5.2 §10. Búsqueda de referencias residuales (`git grep`) confirmó que solo `README.md` es documentación viva con la ruta antigua; traspasos y logs históricos (v11–v25) no se tocan por ser registro inmutable.
Verificado: `git grep` post-commit sin residuos en archivos vivos.
Commits: `34d681d` (rename), `7af874c` (README, corrección de un `add` fallido en el primer intento por pathspec ya renombrado).
Nota: el primer commit (`34d681d`) no incluyó el cambio de README por error de pathspec (el `add` referenciaba el nombre antiguo tras el rename); se detectó vía `git status --short` y se corrigió en el commit siguiente. No se considera error del asistente (fue un comando encadenado del usuario, no instrucción del asistente — el asistente instruyó `add` sobre ambos nombres antes y después del rename correctamente en el turno).

**Cambio 3 — Rotación de snapshots de estructura**
Archivo: `50_documentacion/estructura/*`
Commit: `f9d8863`.

**Cambio 4 — Sidequest: histórico % Adecuado ponderado, Costa Central**
Archivos: `30_procesamiento/34_historico_pct_adecuado_costa_central.R` (nuevo), `40_salidas/historico_pct_adecuado_costa_central.xlsx` (nuevo)
Qué: cálculo de % de estudiantes en nivel Adecuado, todos los GSE combinados (sin desagregar ni comparar entre ellos — no viola la segmentación GSE inviolable), ponderado por `nalu` (estudiantes reales, no promedio simple de porcentajes por establecimiento). Universo: 4 comunas Costa Central (`cod_com_rbd` ∈ {5109,5103,5107,5105}) + `cod_depe2="5"`. Filas con `marca` no vacío incluidas (decisión explícita del usuario). Salida: 4 hojas (`4b-lect`, `4b-mate`, `2m-lect`, `2m-mate`), columna `pct_adecuado` formateada como porcentaje sin decimales (`numFmt="0%"`).
Verificado: lógica validada en Python (pandas) contra el mismo parquet antes de entregar el script (R no disponible en el entorno del asistente); ejecución real en R por el usuario confirmó cifras idénticas (30/13/8/4 promedio 9 años, coincide con fuente externa del usuario). Auditoría de 130 NAs en `palu_eda_ade` (dentro del universo filtrado): causa raíz confirmada, `nalu` entre 0-9 (bajo umbral mínimo de 10 alumnos, secreto estadístico de la Agencia), correctamente excluidas del ponderado.
Nota metodológica clave: `cod_depe2` proviene de un único snapshot 2025 (`mapa_rbd_depe2`, `31_leer_normalizar.R` L71-74) aplicado retroactivamente a todo el histórico — ya proyecta el traspaso a SLEP hacia atrás sin necesidad de ajuste adicional (confirmado con conteo de RBDs por año, estable en 65-68 desde 2014).
Ejecutado por: asistente (código) + usuario (ejecución en Positron).
Commit: `6a13f3e`.

**Cambio 5 — `ESTADO.md` actualizado v24→v26**
Archivo: `50_documentacion/activa/ESTADO.md`
Qué: `sesion_actual`, `ultima_actividad` y secciones `En que vamos`/`Proximo paso` actualizadas para reflejar s25+s26.
Commit: `98c3f6a`.

---

## 4. Backlog acumulativo

Ver `50_documentacion/activa/backlog_acumulativo.md`. Entradas nuevas de s26: 129–133 (auditoría A-s25-4, cierre A-s25-3, sidequest histórico, ESTADO.md, aprendizajes A-s26-1/A-s26-2).

**Delta del backlog s26:** 5 entradas nuevas (129–133). Total acumulado: **133**.

---

## 5. Bugs de la sesión

No aplica en esta sesión. Sin bugs de código detectados ni corregidos.

---

## 6. Aprendizajes y restricciones

**A-s26-1 (vigencia de política por fecha de commit real, no autodeclaración):** cuando coexisten copias de un documento de gobernanza con distinta versión, la vigencia se determina por `git log -1 --format="%ai"` de cada copia, no por el texto "vigente y definitiva" que el propio documento pueda declarar. Una versión puede autodeclararse definitiva y sin embargo ser una rama abandonada más antigua que otra copia sin esa declaración.

**A-s26-2 (rename con referencias): verificar `git status` tras cualquier `git mv` + `add` encadenado.** El primer intento de commit de un rename no capturó la actualización de una referencia externa porque el `add` usó una ruta ya no vigente tras el rename previo en el mismo bloque. Regla: tras cualquier secuencia `mv`/`add`/`commit`, correr `git status --short` antes de asumir que el commit incluyó todo lo esperado.

---

## 7. Decisiones de diseño

**D-s26-1 — Universo del sidequest: comuna + `cod_depe2="5"`**
Alternativas: solo comuna (todas las dependencias) vs. comuna + depe2 SLEP. Decisión del usuario: comuna + depe2="5", para reflejar exclusivamente los establecimientos bajo administración del SLEP Costa Central (con proyección retroactiva ya incluida en el dato).

**D-s26-2 — Ponderación por `nalu`, no promedio simple**
Decisión del usuario: el % agregado pondera por estudiantes reales evaluados (`sum(nalu*pct/100)/sum(nalu)`), no por promedio simple de porcentajes entre establecimientos. Evita que colegios chicos pesen igual que colegios grandes.

**D-s26-3 — Filas no representativas (`marca` no vacío): incluidas**
Decisión del usuario, explícita, contraria a la práctica por defecto de excluir marcas anómalas. Aplica solo a este cálculo puntual, no altera el pipeline principal (`33_generar_html.R`).

**D-s26-4 — Formato de salida: 4 hojas separadas por nivel × prueba**
Alternativa descartada: 2 hojas (4b/2m) con columna `prueba` y filas intercaladas. Decisión del usuario: 4 hojas separadas para lectura directa sin filtrar.

**D-s26-5 — `POLITICA_PROYECTO.md` raíz: eliminar, no fusionar**
Se descartó fusionar contenido de v6 (raíz) en v5.2 (activa) porque v6 no aportaba contenido nuevo relevante (solo un cambio de criterio de licencia ya superado) y sí carecía de la regla 0.5, ya vigente y en uso activo esta sesión y la anterior.

---

## 8. Constantes y parámetros vigentes

| Constante | Valor | Archivo |
|---|---|---|
| Años cubiertos | 2014–2018, 2022–2025 | `31_leer_normalizar.R` |
| Año preliminar | 2025 | `33_generar_html.R` |
| Umbral mínimo alumnos | 10 | `33_generar_html.R` |
| Estado por defecto motor | 4 comunas Costa Central · depe2="5" | `33_motor_template.html` |
| Comunas Costa Central (cod_com_rbd) | 5109, 5103, 5107, 5105 | `34_historico_pct_adecuado_costa_central.R` (nueva constante) |
| Concepto UI de agrupación | "territorio" (antes "entidad") | `33_motor_template.html` (texto); identificadores de código en "entidad" |
| POLITICA_PROYECTO.md vigente | v5.2, solo en `50_documentacion/activa/` | — |
| Backlog canónico | `backlog_acumulativo.md` | `50_documentacion/activa/` |

---

## 9. Arquitectura de archivos

Escáner al cierre: `2026-07-01 14:31:43` (adjunto). Cambios estructurales: `POLITICA_PROYECTO.md` de raíz eliminado; `backlog_historico.md` renombrado; nuevo `34_historico_pct_adecuado_costa_central.R` en `30_procesamiento/`; nuevo `historico_pct_adecuado_costa_central.xlsx` en `40_salidas/`.

Sin hallazgos nuevos sin auditar.

---

## 10. Pendientes y ruta sugerida

**Inventario:**

| Pendiente | Tipo | Complejidad | Contexto |
|---|---|---|---|
| Regenerar suite standalone | funcionalidad/deuda visual | Media | Evaluar si `documentar.R` referencia "entidad" pendiente de actualizar a "territorio" |
| Actualización anual insumos SIMCE 2025/2026 | funcionalidad | Media-Alta | Requiere insumos nuevos no cargados aún |

**Auditoría de cierre (política 5.6):**
- ¿Pipeline corre de cero sin intervención manual? → Sí, no tocado esta sesión.
- ¿Outputs reproducibles e idempotentes? → Sí, `34_historico_pct_adecuado_costa_central.R` usa `overwrite=TRUE`.
- ¿Decisiones metodológicas como constantes nombradas? → Sí (`COMUNAS_COSTA_CENTRAL_COD`, `DEPE2_SLEP`).
- ¿Nombres sin tildes/ñ/espacios? → Sí.

**Ruta sugerida s27:** (1) evaluar regenerar suite standalone si hay tiempo; (2) actualización anual SIMCE cuando estén disponibles los insumos 2026.

---

## 11. Instrucciones específicas para la próxima sesión

- 🔒 `directorio_oficial_ee.csv`: no re-versionar con MRUN ni columnas de persona natural.
- 🔒 Estado por defecto del motor = 4 comunas Costa Central · Servicio Local.
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- 🔒 Identificadores de código con raíz "entidad" permanecen así; solo texto UI dice "territorio".
- ✅ ANTES de regenerar la suite, verificar `npm --version`.
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`.
- ✅ `docs/index.html` se actualiza por copia manual; no editar directamente.
- ⚠️ `POLITICA_PROYECTO.md` vigente única: `50_documentacion/activa/` (v5.2). No existe copia en raíz.
- ⚠️ Backlog canónico ahora es `backlog_acumulativo.md` (ya no `backlog_historico.md`).
- ⚠️ Tras cualquier `git mv` + `add` encadenado, correr `git status --short` antes de asumir el commit completo (A-s26-2).

---

## 12. Fragmentos de código de referencia

```r
# Ejecución del sidequest histórico:
source(here::here("30_procesamiento", "34_historico_pct_adecuado_costa_central.R"))
```

```bash
# Patrón de verificación de vigencia de documentos duplicados (A-s26-1):
git -C <ruta_proyecto> log -1 --format="%H %ai %s" -- <ruta_copia_1>
git -C <ruta_proyecto> log -1 --format="%H %ai %s" -- <ruta_copia_2>
# La fecha de commit real decide, no el texto "vigente" del propio documento.
```

---

## 13. Errores del asistente (§2.2.15)

Sin errores registrados en esta sesión.

---

## 14. Reapertura

**Nombre del chat:** `slep_simce_adecuado, sesión 27 (Claude Sonnet 5)`

**Mensaje de apertura:**
> Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA v5.2 + SETTINGS v7) vive en la knowledge base; léelo desde ahí. Adjunto el traspaso v26 y el escáner actual.

**Documentos para la próxima sesión:**

*En knowledge base (no adjuntar):*
- `POLITICA_PROYECTO.md` (v5.2)
- `SETTINGS_Y_PROMPTS_OPERACIONALES.md` (v7)

*Adjuntar:*
- `traspaso_cierre_v26.md`
- `estructura_actual.md` (escáner al abrir)
