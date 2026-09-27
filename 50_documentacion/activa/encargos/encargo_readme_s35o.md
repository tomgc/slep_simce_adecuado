# Encargo autónomo: README y comentarios al día con el pipeline (sesión 35, decimoquinta ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Contexto.** `encargo_suite_s35n.md` dejó la suite de documentación al día (`a79242c`). Su inventario halló
que el `README.md` y tres comentarios de código repiten afirmaciones que la suite ya corrigió. El titular
decidió ponerlos al día (D35-24, Q-87).

**Meta en una línea:** que el `README.md` y los comentarios de los pasos 31 y 32 no afirmen nada que el código
contradiga; el producto no cambia.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** una tarea de redacción.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 (build) falla → **detén la sesión**.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → regístralo como duda (4.1) y sigue.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. (sin uso)
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE, después de guardar el
   intento como parche en `$TMPDIR/cal_s35o/` y anotar su md5 en el log.
4. Crear y borrar archivos en `$TMPDIR`.
5. Agregar una línea de s35o a «Últimos cambios» de `CLAUDE.md` y recortar la lista a las 5 entradas más
   recientes (D35-22 y D35-24; archivo ignorado).
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío (CLAUDE.md queda ignorado, no cuenta);
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** Las de `CLAUDE.md` (léelo primero). Texto en español latinoamericano neutro,
sin guiones largos en lo nuevo. Solo se cambian comentarios en los `.R`: ninguna línea de código. Un código
de salida se lee sin tubería. La shell es zsh.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:** el log de s35n (inventario de hechos H-01 a H-58 y §7, Q-87); `00_build.R`; los scripts de
   `10_utils/` y `30_procesamiento/`; `CLAUDE.md`; la suite regenerada.
3. **POSICIÓN:** rutas completas; `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`; R con
   `cd "$RAIZ" && Rscript ...`; `rev-parse` con un argumento por comando; `fetch` antes de operar contra el
   remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_readme_s35o_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas (el validador lee comentarios: una ruta absoluta
     escrita en un comentario lo haría fallar);
   - `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R`
     → código 0.
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Todas medidas en este turno con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep`, `sed` y `ls` sobre la
estación.

- `HEAD` y `origin/main` están en `a79242c`. El árbol tiene dos archivos modificados sin commit, que T0
  commitea: el de decisiones (D35-24) y el registro de errores (ERR-35-28) (fuente: `git status --porcelain`,
  `git log` y `git rev-parse`).
- `docs/index.html` = `42ab93003e722f9bb6c725fec2d348bd` y `docs/trayectorias.html` =
  `883f76bcefc89d93f2d1e753fc4d75c3` (fuente: `md5sum`).
- `README.md` tiene 254 líneas y 16 encabezados (L1 a L242) (fuente: `wc -l` y `grep -n '^#'`). Afirmaciones
  hoy falsas medidas en este turno:
  - L7-9: «Producto final: un único archivo `motor_comparacion.html`» (hoy son dos: el motor y
    `trayectorias_traspasos.html`, publicados en `docs/`);
  - «Estructura» (L19-41): lista `30_procesamiento/` hasta `33_motor_template.html` y `40_salidas/` con un solo
    HTML; no nombra `10_utils/`, el paso 36, las dos baterías ni `docs/`;
  - L239: `source(here::here("00_run_all.R"))`; en la raíz solo existen `00_build.R` y
    `00_escanear_proyecto.R` (fuente: `ls 00_*.R`).
  El resto del README se revisa en el inventario de R1 (no se supone vigente).
- `30_procesamiento/32_agregar_comunal.R` L9-10 (comentario): «agregación a nivel comuna × GSE × prueba ×
  nivel × año»; `simce_comunal.parquet` agrega también por `cod_depe2` (fuente: log s35n, H-17 y R-08).
- `30_procesamiento/31_leer_normalizar.R` L49 y L315 (comentarios): A3 «en 2015/2m y 2017/4b»; se aplica a tres
  archivos, `simce2m2015`, `simce4b2015` y `simce4b2017` (fuente: log s35n, H-16 y R-08).

---

## 3. Contexto mínimo

El README es lo primero que ve quien clona el repositorio público. Lo que diga debe poder comprobarse en un
archivo; lo que no, no se escribe.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian, salvo `main` | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L | iguales fuera de `refs/heads/main` y `refs/remotes/origin/main` |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | El código de los `.R` no cambia, solo sus comentarios | por archivo tocado: `parse()` del antes y del después, y `identical()` de sus expresiones (sin `srcref`) | `TRUE` |
| I-4 | Las salidas no cambian | build de H5 y final, comparados con `cmp` (la vista) y por contenido fuera de `meta$fecha_generacion` (el motor) | iguales |
| I-5 | El entorno no cambia | md5 de `renv.lock` y `renv/settings.json` en FASE 0 y en FASE L | idénticos |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, R1, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` |
| R1 | `README.md`, `30_procesamiento/31_leer_normalizar.R` (solo comentarios), `30_procesamiento/32_agregar_comunal.R` (solo comentarios) |

---

## 6. FASE 0

1. Leer `CLAUDE.md`. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la
   plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_readme_s35o.md`
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `a79242c` y `rev-parse --short origin/main` →
   `a79242c`. Guarda las salidas de I-1 e I-5 en `$TMPDIR/s35o/`.
5. **H4.** md5 de este encargo → el del mensaje de entrega. md5 de `docs/` → los de I-2. Después, `git add` de
   las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimoquinta ola y decision D35-24"`.
   El hash resultante es el punto de retorno.
6. **H5.** `Rscript 00_build.R` → código 0; copia las dos salidas a `$TMPDIR/base_s35o/`.
7. Anexa `### FASE 0`.

---

## 7. Tareas

### R1. README y comentarios al día

1. **Inventario.** Una tabla en el log con cada afirmación del `README.md` que describe el proyecto (producto,
   estructura, stack, datos, cómo correrlo, reglas, responsabilidades, esquemas, portabilidad, dependencias),
   su estado (vigente, desactualizada o falsa) y el archivo que lo prueba; más las tres líneas de comentario de
   §2. Reutiliza el inventario de s35n cuando la afirmación sea la misma.
2. **Edición.** Corrige lo desactualizado o falso con el mismo tono y formato del README; agrega a
   «Estructura» lo que falta (`10_utils/`, el paso 36, las dos baterías, `docs/`); cambia `00_run_all.R` por
   el script real. En los `.R`, solo el texto de los comentarios de §2.
3. **Criterio.**
   - `git grep -n '00_run_all'` fuera de `50_documentacion/` → 0;
   - cada archivo o carpeta que el README nombra existe (`ls`, anota el cotejo);
   - cada paso que carga `00_build.R` aparece en «Estructura»;
   - I-3 e I-4;
   - `grep -c '—'` en las líneas nuevas o cambiadas (según `git diff`) → 0;
   - build y las dos baterías en PASA.
4. Commit: `docs(readme): README y comentarios al dia con el pipeline (Q-87)`.

---

## 8. FASE R: auditoría propia y reparación (penúltima y obligatoria; corre aunque haya tareas congeladas)

La regla de oro: **la reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni
la meta**.

1. **Inventario de afirmaciones auditables.** Se arma desde el log, no desde la memoria: cada línea
   `Verificación:`, cada cifra de las secciones por fase, cada 🔒 de §4 con su comando y el alcance global. Se
   numeran `R-01`, `R-02`, etc., y el inventario se anexa al log **antes** de auditar.
2. **Re-derivación independiente.** Sin subagentes: el orquestador re-deriva cada afirmación con un comando
   distinto del que la produjo. La identidad de lo publicado se comprueba con `git hash-object` sobre `docs/` y
   sobre `40_salidas/`, en vez de `md5`. La ausencia de red se comprueba con un segundo patrón, `grep -c 'http'`,
   y cada acierto se revisa a mano: los enlaces `<a href>` a sitios oficiales en el texto son esperables.
3. **Invariantes 🔒.** Corre el comando de cada uno y anota PASA o FALLA con la salida literal.
4. **Chequeo global de alcance.** `git diff --name-only <punto_de_retorno>..HEAD` debe quedar dentro de la
   unión de los ALCANCE, más el log. Corre también `git status --porcelain`: lo que no esté commiteado es un
   hallazgo, no se limpia.
5. **Regresión completa.** Los tres comandos de PRUEBAS sobre el estado final.
6. **Control positivo de la propia auditoría.** Al menos una cifra alterada en una copia temporal fuera del
   árbol y un archivo fuera de alcance simulado en un diff de prueba. El instrumento debe disparar en los dos
   casos.
7. **Veredicto por hallazgo:**
   - **BLOQUEA:** gobernanza de datos, un 🔒 en FALLA, datos alterados, alcance violado o historia divergente.
     No se repara: se congela la tarea de origen y se registra como duda con pregunta cerrada. Si compromete el
     repositorio, se detiene la sesión y se pasa a FASE L.
   - **REPARA:** un defecto del propio trabajo, dentro del ALCANCE, que no toca un 🔒 y tiene una verificación
     calibrada. Se corrige en el ciclo del paso 8.
   - **ADVIERTE:** una discrepancia sin efecto sobre la meta ni los invariantes, o un riesgo que esta sesión no
     puede medir. Se registra, no se corrige.

   «0 hallazgos» solo se declara junto con el control positivo del paso 6.
8. **Ciclo de reparación (máximo 2 ciclos).** Por cada REPARA:
   - (a) causa raíz;
   - (b) fix quirúrgico dentro del ALCANCE;
   - (c) re-verificación con el mismo chequeo **y** con uno distinto;
   - (d) regresión;
   - (e) commit `fix(auditoria): R-NN <hallazgo>`;
   - (f) fila en la tabla.

   Luego se repiten los pasos 2 a 5 sobre lo tocado. Un hallazgo que sobrevive al segundo ciclo, o que destapa
   otro, se congela y se registra como pendiente.
9. **Prohibido:** ajustar un criterio, una tolerancia o un valor esperado; ampliar un ALCANCE; tocar un 🔒;
   editar evidencia ya escrita; reparar un BLOQUEA; aceptar una reparación de un subagente sin verificarla.
10. **Salida.** Una tabla con las columnas `id | afirmación | comando de re-derivación | esperado | obtenido |
    severidad | acción | commit | re-verificación` y un veredicto global: `APROBADO`,
    `APROBADO CON ADVERTENCIAS`, `OBSERVADO` o `BLOQUEADO`. El veredicto va al bloque J.

---

## 9. FASE L: cierre del log (última y obligatoria; corre siempre)

1. **Estado del árbol.** `git status --porcelain` → esperado: vacío o solo el log. Cualquier otra cosa es un
   hallazgo y no se limpia.
2. **Cierre del log.** Se completan las secciones de la plantilla: resumen, inventario de commits (desde
   `git log <punto_de_retorno>..HEAD --oneline`), tabla de auditoría, invariantes, cifras, dudas y
   pendientes, errores propios y notas para el revisor. Las secciones por fase no se reescriben.
3. **Bloque J.** Se rellena copiando del detalle, nunca de memoria.
4. **Privacidad.** `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' <LOG>` → esperado: vacío. Una lectura
   confirma que no hay filas de datos ni nombres de personas o de establecimientos: se usan RBD o conteos.
5. **Verificación del archivo.**
   - `ls -l <LOG> && wc -l <LOG>`;
   - `grep -c '^### FASE' <LOG>` igual al número de fases ejecutadas;
   - `grep -c '^esperado:' <LOG>` igual a `grep -c '^obtenido:' <LOG>`;
   - `grep -c '^## J' <LOG>` igual a 1, con el bloque relleno.

   Si algo falta, se anexa con su estado real, sin ajustar el conteo.
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_readme_s35o_log.md` y
   `git commit -m "docs(log): README y comentarios al dia (s35o)"`. Después, `git push origin main`, solo
   si se cumple la autorización 6. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   el traspaso de cierre. Incluye el hash de `docs(log)` y la línea agregada a `CLAUDE.md` (autorización 5).

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - el inventario del README (cuántas afirmaciones vigentes, desactualizadas y falsas);
   - el cotejo de rutas nombradas y de pasos de `00_build.R`;
   - I-3 e I-4 con su evidencia y los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

El código (solo comentarios), `docs/`, la suite (Q-89, con su próxima regeneración), `renv`,
`feat/contrato-contexto`, Museo Sans (D35-7), Q-70 y Q-71.

---

## Apéndice: plantilla del log

```markdown
# Log: README y comentarios al día (s35o) (slep_simce_adecuado)

- Meta: <una línea>
- Fecha: <AAAA-MM-DD> · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: <hash de T0>
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: <...>
- Grafo y olas: <copiados de §5>
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando

## J. Juicio (lo rellena FASE L)

<!-- trece campos, una línea cada uno:
- Meta y resultado:
- Estado por tarea:
- Commits:
- Auditoría (FASE R):
- Invariantes:
- Cifras críticas:
- Decisiones autónomas de mayor riesgo:
- Desviaciones respecto del encargo:
- Dudas abiertas:
- Errores propios:
- Qué debe verificar el revisor por sí mismo:
- No publicado / queda al usuario:
- Ejecución:
-->

### FASE 0: log, punto de retorno y premisas
(Estado, Commits, Cambios sustantivos, Verificación con esperado/obtenido, Alcance, Regresión, Subagentes,
Bugs, Decisiones autónomas, Errores propios, Dudas)

### FASE R1

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
