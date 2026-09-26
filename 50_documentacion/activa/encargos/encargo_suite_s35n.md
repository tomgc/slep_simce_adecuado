# Encargo autónomo: la suite de documentación describe el pipeline actual (sesión 35, decimocuarta ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Contexto.** La suite de documentación (`50_documentacion/suite/`, cuatro HTML standalone generados por
`documentar.R` con `suitedoc`) se regeneró por última vez en junio y julio. Desde entonces el pipeline cambió:
se agregó la vista de trayectorias (paso 36), React, ReactDOM y Babel dejaron de cargarse por CDN, entraron la
guarda de locale, la validación de portabilidad, gobCL incrustada y dos baterías versionadas, y 2025 pasó a
base final. El titular decidió regenerarla (Q-81, D35-21; opción A del 2026-09-26). Todos los cambios de
esta sesión en el producto ya están publicados y revisados por el titular (D35-23).

**Meta en una línea:** que los cuatro documentos de la suite describan el pipeline que hoy corre `00_build.R`,
sin afirmaciones falsas, y queden regenerados en el repositorio.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** una tarea de redacción sobre un
solo archivo y una regeneración.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- Si `documentar.R` no genera los cuatro HTML tras 3 intentos → revierte los HTML sin commitear
  (autorización 3), commitea solo `documentar.R` si S1 cumple su criterio, y regístralo.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → regístralo como duda (4.1) y sigue.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. Correr `documentar.R` (autorización para escribir en `50_documentacion/suite/`, incluidas `fonts/` y
   `assets/`, que git ignora).
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE, después de guardar el
   intento como parche en `$TMPDIR/cal_s35n/` y anotar su md5 en el log.
4. Crear y borrar archivos en `$TMPDIR`.
5. Agregar una línea de s35n a «Últimos cambios» de `CLAUDE.md` al cerrar (D35-22, Q-85; archivo ignorado).
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío (CLAUDE.md queda ignorado, no cuenta);
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más. No se autoriza tocar
`renv.lock`, `renv/settings.json`, instalar paquetes ni tocar código fuera de `documentar.R`.

**Reglas canónicas heredadas.** Las de `CLAUDE.md` (léelo primero). R es el único lenguaje de los entregables.
El texto nuevo va en español latinoamericano neutro, sin guiones largos (se usan paréntesis o comas), con el
tono de los textos vecinos: técnico en los documentos `arq_tec` y `doc_proy`, sin tecnicismos en los
`general`. Un código de salida se lee sin tubería. La shell es zsh.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:** `00_build.R`; los scripts de `10_utils/` y `30_procesamiento/`; `CLAUDE.md`; el archivo de
   decisiones `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` (D35-1 a D35-23);
   `README.md`; `50_documentacion/activa/manifiesto_insumos.md`; el log de s35j (R2.5, estado de la suite).
3. **POSICIÓN:** rutas completas; `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`; R con
   `cd "$RAIZ" && Rscript ...` (con `renv` activo: carga `suitedoc` 0.5.1 de la biblioteca del proyecto);
   `rev-parse` con un argumento por comando; `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_suite_s35n_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:** `Rscript -e 'invisible(parse("50_documentacion/suite/documentar.R"))'` → código 0; la
   generación de S2 → código 0 y cuatro HTML. El producto no cambia, así que no se exigen build ni baterías
   (I-3 lo confirma).
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Todas medidas en este turno con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep`, `sed` y `ls` sobre la
estación.

- `HEAD` y `origin/main` están en `9eb7e52`. El árbol tiene dos archivos modificados sin commit, que T0
  commitea: el de decisiones (D35-22 y D35-23) y el registro de errores (ERR-35-27) (fuente:
  `git status --porcelain` y `git log`).
- `docs/index.html` = `42ab93003e722f9bb6c725fec2d348bd` y `docs/trayectorias.html` =
  `883f76bcefc89d93f2d1e753fc4d75c3`, iguales a lo que sirve Pages (fuente: `md5sum` y `curl`).
- `00_build.R` carga `10_configuracion.R` (L20), `10_utils.R` (L23), `10_validar_portabilidad.R` (L31) y los
  pasos `30_construir_auxiliares.R`, `31_leer_normalizar.R`, `32_agregar_comunal.R`, `33_generar_html.R` y
  `36_generar_trayectorias.R` (L38-46) (fuente: `grep -n 'source('`).
- `documentar.R` (427 líneas) construye `cfg` desde cero y llama `suitedoc::generar_suite(cfg, …,
  copiar_tema = TRUE, verificar = FALSE, standalone = TRUE)` (L417-426). Su lista `etapas` (L118-145) describe
  los pasos 30 a 33 y **no** el 36. El texto de L337 dice «pipeline en R de cuatro etapas». Hay 6 menciones de
  trayectorias, locale, portabilidad, gobCL o baterías en todo el archivo (fuente: `sed` y `grep -c`).
- Afirmaciones hoy falsas en `documentar.R` (fuente: `grep -n -i 'unpkg\|cdn\|prelim'`):
  - L142: «React / ReactDOM / Babel por CDN (unpkg, con SRI); D3 y pako inline» (hoy van vendorizados en
    `10_utils/` y el JSX se transpila en el build con `V8`, sin red);
  - L100: el texto del insumo de 2° medio termina en «2025 preli…» (la base 2025 es final: los dos xlsx son
    `simce{2m,4b}2025_rbd_final.xlsx`);
  - L240: la leyenda define «Preliminar» como «Dato del año más reciente (2025) aún sujeto a revisión por la
    Agencia»; la marca de preliminar sigue siendo válida para un año futuro, pero el año 2025 fijo no;
  - L381: el pie técnico describe el runtime del motor; se revisa contra `33_generar_html.R`.
- `git ls-files 50_documentacion/suite` versiona los cuatro `*_standalone.html`, `documentar.R` y
  `suite_estilos.css`; `.gitignore` excluye `fonts/` y `assets/` (L37-38). Tres HTML son del 2026-07-01 y
  `documentacion_proyecto_…_standalone.html` fue reemplazado en s35k por la versión rescatada de
  `gobernanza/v16` (fuente: `ls -la` y `git ls-files`).
- `10_utils/` contiene `react.production.min.js`, `react-dom.production.min.js`, `babel.min.js`, `d3.min.js` y
  `pako.min.js` (fuente: `ls 10_utils`). Los cuatro HTML de la suite dan hoy 0 y 0 en los dos patrones de I-5
  (fuente: `grep -c` sobre cada uno).
- `suitedoc` 0.5.1 está en la biblioteca de `renv` e ignorado en el lock (D35-18); fuera de `renv` se cargaría
  el 0.3.0 del sistema (fuente: log s35j R2.1). El comentario de `documentar.R` L13 nombra 0.3.0.

---

## 3. Contexto mínimo

La suite es lo que lee el equipo para entender el proyecto sin abrir el código. Cada afirmación nueva debe
poder rastrearse a un archivo del repositorio; lo que no se pueda rastrear no se escribe.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian, salvo `main` | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L | iguales fuera de `refs/heads/main` y `refs/remotes/origin/main` |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | El producto no cambia | `git diff --name-only <punto_de_retorno>..HEAD` | solo rutas de `50_documentacion/` |
| I-4 | El entorno no cambia | md5 de `renv.lock` y `renv/settings.json` en FASE 0 y en FASE L | idénticos |
| I-5 | La suite no carga nada por red | `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en los cuatro `*_standalone.html` | `0` en cada uno (si la versión de julio ya daba otro valor, anota la base en FASE 0 y el esperado pasa a «no aumenta») |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, S1, S2, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` |
| S1 | `50_documentacion/suite/documentar.R` |
| S2 | los cuatro `50_documentacion/suite/*_standalone.html`, `50_documentacion/suite/suite_estilos.css` (solo si la regeneración lo cambia), `fonts/` y `assets/` (ignorados) |

---

## 6. FASE 0

1. Leer `CLAUDE.md`. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la
   plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_suite_s35n.md`
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `9eb7e52` y `rev-parse --short origin/main` →
   `9eb7e52`. Guarda las salidas de I-1 e I-4 en `$TMPDIR/s35n/`.
5. **H4.** md5 de este encargo → el del mensaje de entrega. md5 de `docs/` → los de I-2. Después, `git add` de
   las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimocuarta ola y decisiones D35-22 y D35-23"`.
   El hash resultante es el punto de retorno.
6. **Base.** Copia los cuatro HTML y `suite_estilos.css` a `$TMPDIR/base_s35n/`. Mide I-5 sobre la base.
   Con `renv` activo, confirma `packageVersion("suitedoc")` = 0.5.1.
7. **Calibración.** Genera la suite **sin cambios** en `documentar.R` hacia un directorio en `$TMPDIR` (copia
   del archivo con `salida_dir` apuntando ahí, o el mecanismo que la función admita; anota cuál). Esperado: la
   generación funciona con 0.5.1 y produce cuatro HTML. Compara su texto visible con la base para saber qué
   cambia solo por la versión de `suitedoc` (se registra; no es un criterio).
8. Anexa `### FASE 0`.

---

## 7. Tareas

### S1. `documentar.R` describe el pipeline actual

1. **Inventario de hechos.** Antes de editar, una tabla en el log: cada afirmación de `cfg` que describe el
   pipeline (etapas, insumos, intermedios, garantías, pie técnico, prosa, FAQ), con su estado (vigente,
   desactualizada o falsa) y el archivo que lo prueba.
2. **Edición.**
   - `etapas`: una etapa por cada paso que carga `00_build.R` (30, 31, 32, 33 y 36), con el mismo formato que
     las existentes. La del 33 dice que React, ReactDOM, Babel, D3 y pako van vendorizados en `10_utils/`, que
     el JSX se transpila en el build y que la salida no carga nada por red. La del 36 describe la vista de
     trayectorias (qué muestra, su referente de 2014 y las cohortes 2027 a 2029, según D35-1 y D35-2).
   - Donde el texto cuente las etapas, el número coincide con la lista.
   - Garantías o notas: la guarda de locale, la validación de portabilidad que detiene el build, las dos
     baterías versionadas y la regla de copiar a `docs/` solo con las dos en PASA.
   - Insumos: 2025 como base final; la leyenda «Preliminar» sin año fijo (define la marca para cualquier año
     cuya base aún sea preliminar).
   - Los documentos `general` mencionan la vista de trayectorias en lenguaje llano (qué pregunta responde y
     dónde se abre: `https://tomgc.github.io/slep_simce_adecuado/trayectorias.html`).
   - El comentario de L13 sobre la versión de `suitedoc` queda al día.
   - Nada de lo que no esté en el inventario con su archivo de respaldo.
3. **Criterio.**
   - `grep -n -i 'unpkg\|cdn\|(2025)'` sobre `documentar.R` → 0 aciertos que afirmen el estado actual (anota
     cada acierto que quede y por qué es válido);
   - cada paso cargado por `00_build.R` aparece en `etapas` (anota el cotejo);
   - `grep -c '—'` sobre las líneas nuevas o cambiadas → 0 (compáralo con el `git diff`);
   - `parse()` con código 0.
4. Commit: `docs(suite): documentar.R describe el pipeline actual (Q-81)`.

### S2. Regeneración de la suite

1. Corre `documentar.R` con `renv` activo (autorización 2).
2. **Criterio.**
   - código 0 y cuatro `*_standalone.html` nuevos (fecha de hoy);
   - I-5;
   - en el texto visible de cada HTML (sin etiquetas): aparecen «36_generar_trayectorias», «trayectorias» y
     las dos baterías donde corresponde, y no aparecen «unpkg» ni «(2025)» como año preliminar;
   - el diff de texto visible contra la base de FASE 0 solo contiene lo que S1 cambió más lo que la
     calibración atribuyó a la versión de `suitedoc` (anota cualquier otra diferencia);
   - `git status --porcelain` → solo rutas del ALCANCE de S2.
3. Commit: `docs(suite): regenera la suite con el pipeline actual`.

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
5. **Regresión completa.** Los comandos de PRUEBAS e I-1 a I-5 sobre el estado final.
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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_suite_s35n_log.md` y
   `git commit -m "docs(log): suite de documentacion al dia (s35n)"`. Después, `git push origin main`, solo
   si se cumple la autorización 6. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   la lectura de la suite regenerada y el traspaso de cierre. Incluye el hash de `docs(log)` y la línea
   agregada a `CLAUDE.md` (autorización 5).

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - el inventario de hechos de S1 (resumen: cuántas afirmaciones vigentes, desactualizadas y falsas);
   - la lista de etapas antes y después, y el cotejo con `00_build.R`;
   - los `grep` de S1 y de S2, y el resultado de I-5;
   - las diferencias de texto que la calibración atribuyó a la versión de `suitedoc`;
   - los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

El producto (`30_procesamiento/`, `10_utils/`, `docs/`), `renv`, `feat/contrato-contexto`, Museo Sans en la
suite (D35-7, decisión de cartera) y Q-70 y Q-71.

---

## Apéndice: plantilla del log

```markdown
# Log: la suite de documentación describe el pipeline actual (s35n) (slep_simce_adecuado)

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

### FASE S1 y ### FASE S2

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
