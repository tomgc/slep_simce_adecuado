# Encargo · Inclusión de todos los resultados publicados y simbología adicional de la Agencia (D36-1)

> Archivo largo: léelo completo, en las lecturas que hagan falta, hasta el
> anexo de auditoría, antes de la llamada del testigo (§4 paso 0).

## 0. Encabezado de contrato

- **Fecha de depósito:** 2026-11-09 (fuente: fecha de la sesión redactora, `TZ=America/Santiago`).
- **Meta:** que el motor y la vista de trayectorias incluyan todo resultado por
  estándar que publica la Agencia, también los que trae con simbología
  adicional (marca), y que el motor los señale con «‡», permita excluirlos con
  una casilla y liste sus motivos por año, tal como lo decidió el titular en
  D36-1 (`<A>/50_insumo_decision_d36_1.md.txt`, que T4 instala). Commits
  locales; **sin push y sin copiar a `docs/`** (la revisión visual y la
  publicación son del titular, §10).
- **MODO:** autónomo, todo en este turno. **Subagentes: no se admiten.**
- **EJECUCIÓN:** esfuerzo `high`; orquestador: el modelo de la sesión;
  subagentes 0; total Opus del encargo 0. (Cadena que escribe en serie sobre
  archivos encadenados: R antes que las plantillas, las plantillas antes que
  las baterías.)
- **AUDITORÍA DE REDACCIÓN:** nivel 3 (puntaje 4: C1, C6, C8; C1 porque cambia cifras publicadas, C6 porque el grafo tiene cuatro tareas, C8 porque toca `10_utils/` y `30_procesamiento/`; C2 no suma: el directorio con MRUN solo se lee, no se escribe ni se publica, y el catálogo nuevo lleva solo RBD); anexo al final.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia` · **ORIGEN:** `ninguno`.
  En lo que sigue, `<EXP>` es la ruta del expediente, `<A>` es `<EXP>/anexos`
  y el log es `<EXP>/50_log.md`. `<PROT>` es
  `$HERRAMIENTAS_DEV_PATH/prompts/encargo_autonomo_claude_code_v1.md` (v1.11),
  que se lee con la herramienta de lectura solo donde este encargo remite a
  una sección suya; la ficha del log es su §4.4. `<TMP>` es
  `${TMPDIR:-${TEMP:?}}` (en Git Bash de Windows `TMPDIR` puede no existir; H2
  lo mide).
- **ENTORNO:** Claude Code en la estación Windows del titular
  (`estacion_windows`), shell Git Bash, lanzado con el directorio de trabajo en
  la raíz de `slep_simce_adecuado`. **Presencia del titular:** presente de
  punta a punta (aprueba cada diálogo de permisos); por eso no hay FASE −1.
  **Red:** ninguna; ningún `fetch`, `pull` ni `push`. Todo comando de más de
  una línea va a un archivo `<TMP>/simce_s36_<qué>.sh` (escrito con la
  herramienta de escritura) y se corre con `bash <archivo>`; nunca un heredoc
  de varias líneas, ni para el log, que se escribe con la herramienta de
  edición. Todo `grep` va como `command grep`. Los códigos de salida se miden
  dentro de `bash -c` o del `.sh`. Toda salida de `Rscript` que se compara
  pasa por `tr -d "\r"`. Todo archivo que escribe la herramienta de escritura
  y que después lee bash (los `.sh`, el archivo de esperados del árbol, el de
  alcance, el de toleradas) termina en salto de línea y, antes de usarlo, se
  normaliza con `sed -i "s/\r$//" <archivo>` (solo en `<TMP>`). `<BUILD>`,
  `<TAGREG>`, `<VMOTOR>` y `<VTRAY>` se corren con el tiempo máximo de la
  herramienta Bash (600000 ms); si una corrida lo agota, se registra como
  `- friccion:` y aplica la regla 6. Los comandos de §0.0 y §0.4 se transcriben tal cual,
  desde sus bloques de código. El log nombra las rutas de `<TMP>` como
  `"${TMPDIR:-${TEMP:?}}/simce_s36_<qué>"`, nunca resueltas.
- **INSUMOS:** el árbol del repo en `HEAD` `d32ad14` (§1); los cuatro
  archivos de `<A>` que deposita la sesión redactora (§4bis); los 18 xlsx de
  `20_insumos/simce/{2m,4b}/`, `20_insumos/auxiliares/glosas_simce_consolidado_simce.xlsx`
  y `20_insumos/auxiliares/directorio_oficial_ee.csv` (corte 2025-04-30,
  ignorado por git), más los demás auxiliares que lee el build, todos solo
  desde R; `CLAUDE.md` local (copia del
  contrato del kit, ignorado por git). Nada más.
- **POSICIÓN:** todo comando se escribe desde la raíz del repo. Los scripts
  del proyecto corren con `Rscript <ruta>` sin `--vanilla` ni
  `--no-init-file` (el proyecto usa `renv` y su `.Rprofile` lo activa); las
  dos sondas de `<A>` también. Los mensajes `[ locale ]` de la guarda y sus
  líneas de continuación no cuentan como distintos de lo esperado y van al log
  solo como `dato: [ locale ] <n> líneas`, nunca su texto.
- **Conteos y códigos:** toda comparación de un conteo es numérica
  (`| tr -d ' '`). `grep -c` imprime `0` con código `1` sin coincidencias, y
  ese código no es falla. `<MD5 ruta>` es
  `bash -c 'md5sum <ruta> | cut -d" " -f1'`. `wc -l` siempre con redirección.
  Toda cifra sobre datos sale de `Rscript`. Una medición que solo se registra
  va como línea `dato:`.
- **ALCANCE:** en toda fase, además, `<TMP>` (prefijo `simce_s36_`), el
  `tempdir()` de cada proceso R, `.git/`, los archivos de `40_salidas/` que el
  build escribe y `.gitignore` ignora (L10, L13-15; un archivo no ignorado ahí
  es residuo) y, por `<PROT>` §4.3 regla 6, `<A>/50_<fase>_<qué>.txt`.
  **FASE 0:** el log. **T1:** `10_utils/10_configuracion.R`,
  `10_utils/10_utils.R`, `30_procesamiento/31_leer_normalizar.R`,
  `30_procesamiento/32_agregar_comunal.R`, `30_procesamiento/33_generar_html.R`.
  **T2:** `30_procesamiento/36_funciones_trayectorias.R`,
  `30_procesamiento/36_trayectorias_template.html`,
  `30_procesamiento/36_verificar_trayectorias.R`. **T3:**
  `30_procesamiento/33_motor_template.html`,
  `30_procesamiento/33_verificar_motor.R`. **T4:** `README.md`,
  `50_documentacion/activa/referencia_glosas_simce.md` y
  `50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md`
  (nuevo, copia del insumo). **FASE R:** el log, `<A>/50_R_inventario.txt` y,
  en su ciclo de reparación, los archivos de T1 a T4. **FASE L:** el log,
  `<A>/50_*.txt` que el encargo crea y `50_documentacion/encargos/50_indice_encargos.md`
  (tras la detención 1, además el encargo y los cuatro insumos).
  `<EXP>/50_encargo.md` y los insumos no se editan en ninguna fase. `docs/` y
  `20_insumos/` no se tocan en ninguna fase.
- **PRUEBAS:** `<BUILD f>`, `<TAGREG f>`, `<VMOTOR f>` y `<VTRAY f>` (§0.0).
  Esperado: `rc 0`, o, para `<VMOTOR>` y `<VTRAY>`, no peor que H4 en las
  pruebas que D36-1 no cambia (regla 2). La línea base de FASE 0 (H4) se toma
  con la regla vieja.
- **PUNTO DE RETORNO:** FASE 0 mide el árbol, commitea el encargo y sus
  cuatro insumos y registra `hash_inicial`. **Desviación declarada de
  `<PROT>` §2.5 paso 4** («lo commitea solo»): los insumos entran en el mismo
  commit para quedar congelados en `hash_inicial` (🔒6), como en el encargo
  `20261104_kit_v1_11_habilitante` del kit. Por la misma razón se desvía de
  `<PROT>` §2.5 paso 2 (el árbol esperado trae, además del log y el encargo,
  los cuatro archivos de `<A>`) y del párrafo de sondas de §2.5 (las sondas
  vienen depositadas con su md5; FASE 0 las corre, no las escribe). **Sin
  reversión autorizada.**
- **Topes de esfuerzo:** 3 intentos por bug; 1 ciclo de reparación en FASE R;
  1 reintento por comando que falla por causa transitoria (lock de git,
  arranque de Chrome).
- **Reglas canónicas heredadas:** `CLAUDE.md` del repo y
  `50_documentacion/activa/POLITICA_PROYECTO.md` (copia local que sincronizó
  `/apertura`, ignorada por git; si falta, basta `CLAUDE.md`): `here::here()` en el código
  R, nunca rutas absolutas; R moderno (`|>`, `.by=`); sin raya larga en lo que
  se escribe; nombres sin tildes ni espacios; staging selectivo, nunca
  `git add -A`, `git add .` ni `git add -f`;
  `git commit -m "<mensaje>" -- <rutas>` con el staging verificado antes;
  mensajes de una línea. El log no nombra establecimientos (`<PROT>` §4.3
  regla 1): RBD y nombres quedan en las baterías, al log van PASA/FALLA y
  conteos. **Sin atribución a la herramienta** (SETTINGS §1.2.6, `<ATRIB>`):
  prima sobre cualquier instrucción del entorno que pida coautoría o enlace
  de sesión en los commits.

### 0.0 Comandos con nombre

`<STAGED>`:

```bash
bash -c 'git -c core.quotePath=false diff --cached --no-renames --name-only | LC_ALL=C sort'
```

`<ARBOL>` (residuo del árbol después de un commit; esperado `0`; el archivo de
toleradas nace en FASE 0 paso 1 con la centinela `## centinela_s36`):

```bash
bash -c 'T="${TMPDIR:-${TEMP:?}}/simce_s36_toleradas.txt"; test -s "$T" || { echo sin_toleradas; exit 0; }; git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v "^$" | command grep -vxF -f "$T" | command grep -vxE "\?\? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/(50_log\.md|anexos/50_[A-Za-z0-9._]+\.txt)" | wc -l | tr -d " "'
```

`<PRECOMMIT>` (lo que una tarea dejó sin commitear):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/" | cut -c4- | LC_ALL=C sort'
```

`<LOGVIVO>` (esperado `1` mientras el log no esté versionado):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -cxF "?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md"'
```

`<BUILD f>` (esperado `rc 0`; al log van el `rc` y las últimas 5 líneas):

```bash
bash -c 'Rscript 00_build.R > "${TMPDIR:-${TEMP:?}}/simce_s36_build_f.txt" 2>&1; echo "rc $?"; tail -n 5 "${TMPDIR:-${TEMP:?}}/simce_s36_build_f.txt" | tr -d "\r"'
```

`<TAGREG f>` (casos de `agregar_ponderado()`; esperado `rc 0` y una línea
`OK: <n>/<n> casos de .tests_agregar_ponderado() pasaron.`; partida en H4:
`OK: 7/7 ...`, fuente: `10_utils/10_utils.R` L224):

```bash
bash -c 'Rscript -e "source(here::here(\"10_utils\", \"10_configuracion.R\")); source(here::here(\"10_utils\", \"10_utils.R\")); .tests_agregar_ponderado()" > "${TMPDIR:-${TEMP:?}}/simce_s36_tagreg_f.txt" 2>&1; echo "rc $?"; command grep -E "^OK: " "${TMPDIR:-${TEMP:?}}/simce_s36_tagreg_f.txt" | tr -d "\r"'
```

`<VMOTOR f>` (al log van el `rc`, la línea `Resultado:` y, de cada prueba en
FALLA, solo su id y su estado, nunca el detalle, que puede nombrar
establecimientos):

```bash
bash -c 'Rscript 30_procesamiento/33_verificar_motor.R > "${TMPDIR:-${TEMP:?}}/simce_s36_vmotor_f.txt" 2>&1; echo "rc $?"; tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36_vmotor_f.txt" | command grep -E "^Resultado:|^[A-Z][A-Za-z0-9]* +FALLA( |$)" | sed -E "s/^([A-Z][A-Za-z0-9]* +FALLA).*/\1/"'
```

`<VTRAY f>`:

```bash
bash -c 'Rscript 30_procesamiento/36_verificar_trayectorias.R > "${TMPDIR:-${TEMP:?}}/simce_s36_vtray_f.txt" 2>&1; echo "rc $?"; tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36_vtray_f.txt" | command grep -E "^Resultado:|^[A-Z][A-Za-z0-9]* +FALLA( |$)" | sed -E "s/^([A-Z][A-Za-z0-9]* +FALLA).*/\1/"'
```

En todos los comandos con `f`, `f` es `f0` en
FASE 0, `T1` a `T4` en las tareas y `r` en FASE R.

`<SONDA1>` (S1 sobre los xlsx y el directorio; esperado la fila S1 de §1):

```bash
bash -c 'Rscript 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_sonda_simbologia.R 2>&1 | tr -d "\r" | command grep -E "^(validas|simb|ceros|codigos) |^cc_"'
```

`<SONDA2 f>` (S2 sobre el JSON del motor generado en `40_salidas/`, después de
un build; antes, copia el motor a `<TMP>/simce_s36_motor_f.html` y la sonda lo
lee desde ahí, para que la partida quede medible):

```bash
bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36_motor_f.html" && Rscript 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_sonda_json.R "${TMPDIR:-${TEMP:?}}/simce_s36_motor_f.html" 2>&1 | tr -d "\r" | command grep -E "^(simce_rbd|simb|catalogo|ceros_json) |^cc_"'
```

`<ATRIB>` (esperado `0 0`):

```bash
bash -c '{ git log --format=%B d32ad14..HEAD | awk -v p="^[[:space:]]*(co-authored-by:.*(claude|anthropic)|claude-session:|(🤖[[:space:]]*)?generated with .?claude)" "tolower(\$0) ~ p" | wc -l | tr -d " "; git log --format="%ae%n%ce%n%an%n%cn" d32ad14..HEAD | command grep -ciE "anthropic|claude"; } | paste -sd " " -'
```

`<PRIVACIDAD>` (FASE L; rutas personales, raya larga y RUT en lo que el
encargo versiona fuera de los insumos, que la sesión redactora ya revisó con
los mismos patrones: `rc 1`; esperado dos veces `rc 1`):

```bash
bash -c 'F="50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md $(ls 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_*.txt | command grep -v /50_insumo_)"; command grep -nE "/[U]sers/|/[h]ome/|[A-Za-z]:[\\/][U]sers|/c/[U]sers|[~]/|$(printf "\342\200\224")" $F; echo "rc $?"; command grep -nE "[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]" $F; echo "rc $?"'
```

### 0.1 Regla de detención (lista medible)

1. **FASE 0:** el testigo, H1, H2, el árbol o un md5 de H3 distintos de lo
   esperado → **detén la sesión** sin el commit `docs(encargo)`. Sin log
   (falló el testigo), la sesión termina con el reporte. Con log, FASE R se
   omite pero escribe su sección `### FASE R: auditoría y reparación` con
   `Estado: omitida (detención 1)` y FASE L cierra el log con T1 a T4
   en `Estado: no ejecutada (detención 1)`, `hash_inicial: no_medible` y
   `hash_final` igual a `d32ad14`; su commit `docs(log)` versiona también el
   encargo y los cuatro insumos.
2. **Línea base (H4):** `<BUILD f0>` o `<TAGREG f0>` distintos de `rc 0` →
   regla 1 (sin build no hay contra qué medir; la causa probable es `renv` sin
   restaurar y la resuelve el titular). `<VMOTOR f0>` o `<VTRAY f0>` distintos
   de `rc 0` no detienen: se registran como línea base, y esa batería se
   juzga después «no peor que H4» en las pruebas que D36-1 no cambia.
3. **Sondas (H5):** una línea de `<SONDA1>` distinta de la fila S1, o de
   `<SONDA2 f0>` distinta de la fila S2 de partida (§1) → FASE 0 completa sus
   pasos 3 a 5 (`docs(encargo)` y `hash_inicial`), T1 a T4 quedan congeladas
   (todas dependen de esas cifras) y se pasa a FASE R y FASE L.
4. **Un 🔒 en FALLA:** BLOQUEA; FASE R completa sus pasos sin reparar ese 🔒.
5. **Residuo de una tarea congelada:** sus líneas de `git status` dentro de su
   ALCANCE se agregan al archivo de toleradas, se declaran como
   `- pendiente:` y no se tocan; el commit de FASE L no las toma.
6. **Residual:** cualquier estado, conteo o resultado no enumerado en este
   encargo → congela ESTA tarea y sus descendientes, regístrala como duda y
   sigue con la próxima tarea independiente. Fuera de una tarea: antes de
   `docs(encargo)`, regla 1; después, se registra como duda y la fase sigue.
7. **Denegación** de un comando autorizado → congela la tarea en curso y sus
   descendientes, `- friccion:` con la cita literal, sin reintentar por otra
   vía. Si el titular aprueba en el momento, `- intervencion:` y se sigue.
8. `<MD5 <EXP>/50_encargo.md>` distinto de `encargo_md5` al cerrar una tarea
   → congela esa tarea y sus descendientes.
9. **Esperado de una prueba que cambia por D36-1:** si una prueba existente de
   `33_verificar_motor.R` o `36_verificar_trayectorias.R` falla después de T1
   porque D36-1 cambia su valor (conteos de establecimientos, filas,
   referente, notas), la tarea dueña de la batería (T3 o T2) actualiza su
   esperado **solo** si el valor nuevo sale de un recuento independiente: las
   sondas, o un script `<TMP>/simce_s36_recuento_<prueba>.R` que lee solo los
   xlsx, la glosa y el directorio (nunca `simce_rbd.parquet`, `10_utils/` ni
   `36_funciones_trayectorias.R`, ni la base de la propia batería), corrido
   con `Rscript` y con su salida en el log; con la línea
   `dato: esperado <prueba>: <viejo> -> <nuevo> (fuente: <comando>)`. No
   aplica a las pruebas de 🔒8. Sin recuento independiente, la prueba queda
   en FALLA y la tarea se congela.

### 0.2 Autorizaciones (lista cerrada)

0. Toda fase: los comandos de medición de solo lectura (`git status`,
   `git diff`, `git log`, `git show`, `git rev-parse`, `git symbolic-ref`,
   `git remote get-url`, `git ls-files`, `git grep`, `git stash list`,
   `git check-ignore`, `command grep`, `diff`, `sort`, `cut`, `awk`, `tr`,
   `paste`, `sed -n`, `wc`, `ls`, `test`, `head`, `tail`, `date`, `md5sum`,
   `bash -n`, `command -v`, `cygpath`) y los comandos de §0.0 y §0.4.
1. Toda fase: escribir en `<TMP>` archivos con prefijo `simce_s36_` (incluido
   `cp` entre archivos de `<TMP>`, o desde `40_salidas/` o `<A>` hacia
   `<TMP>`, y `sed -i` sobre archivos de `<TMP>`); correr
   `Rscript` sobre scripts del repo, de `<A>` y de `<TMP>`, y `<TAGREG>`. A
   `<A>` va solo lo que el encargo nombra y, por `<PROT>` §4.3 regla 6, una
   salida de más de 30 líneas como `<A>/50_<fase>_<qué>.txt`, copiada con
   `bash -c 'cp "${TMPDIR:-${TEMP:?}}/<origen>" 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/<destino>; echo $?'`.
2. FASE 0: crear el log y el archivo de toleradas; `<BUILD f0>`,
   `<TAGREG f0>`, `<VMOTOR f0>`, `<VTRAY f0>`, `<SONDA1>` y `<SONDA2 f0>`; el
   commit `docs(encargo): inclusion_resultados_simbologia`.
3. T1 a T3: editar los archivos de su ALCANCE con la herramienta de edición;
   sus pruebas; su commit (§5). T4: además, copiar el insumo de decisión con
   `bash -c 'cp 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_insumo_decision_d36_1.md.txt 50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md; echo $?'`.
4. FASE R: las pruebas y los comandos de §6, y como máximo un commit
   `fix(auditoria): R-NN <hallazgo>` por el ciclo de reparación. FASE L:
   `98_indexar_encargos.R` con `--validar` (más un reintento) y una vez con
   `--escribir` (§7), y el commit `docs(log): inclusion_resultados_simbologia`.

Nada más. En particular: ningún `fetch`, `pull` ni `push`; ninguna escritura
en `docs/`, `20_insumos/` ni `herramientas_dev`; ningún `rm` (ni en `bash -c`
ni en un `.sh`); ningún `--force`, `--no-verify`, `revert`, `reset`,
`restore`, `checkout --`, `stash` (salvo `git stash list`) ni
`commit --amend`; ningún `git config` que escriba; ninguna escritura en
`~/.claude`; ninguna lectura ni escritura de la memoria de la herramienta.

### 0.3 Contrato de arranque (`<PROT>` §2.1 punto 8)

- **Lecturas previas.** Antes de la llamada del testigo se admite leer este
  encargo (que no se lista), los insumos de `<A>`, `CLAUDE.md` del repo,
  `<PROT>`, los archivos de los ALCANCE y comandos de solo lectura (`ls`, `wc`,
  `GIT_OPTIONAL_LOCKS=0 git status`, `git log`). Se listan después del testigo
  en `<TMP>/simce_s36_lecturas.txt` y van como líneas `dato:` a la sección de
  FASE 0, donde FASE R las juzga ADVIERTE. Detiene una escritura propia antes
  del testigo (en el repo fuera de `.git/` y `.claude/`, o en `<TMP>`).
- **Conteo de llamadas.** Toda referencia a una llamada es por lo que hace.
- **Directorio de trabajo.** La llamada del testigo comprueba la raíz; la
  siguiente imprime a la terminal, nunca al log, las rutas resueltas de la
  raíz, de `<TMP>` y del kit en forma Windows (`cygpath -w`), que son las que
  usan las herramientas de lectura, edición y escritura.
- **Pre-registro antes del log.** El testigo y la llamada de las rutas van
  como `dato:` con la marca `(escrito después: paso 0)`; desde FASE 0 paso 1,
  todo `esperado:` va al log antes de su comando.
- **Testigo de permisos.** La primera escritura es
  `<TMP>/simce_s36_testigo.txt` desde la shell; después, las herramientas de
  lectura, edición y escritura se ejercen sobre el testigo y sobre
  `<TMP>/simce_s36_lecturas.txt`.
- **Esperas.** Ninguna explícita; las baterías abren Chrome con `chromote`
  dentro de su propio proceso R.
- **Memoria y búsquedas.** La memoria de la herramienta no se lee ni se
  escribe por iniciativa propia; las búsquedas en el repo van por
  `git ls-files`, `git grep` o `command grep` sobre rutas versionadas (nunca
  sobre `20_insumos/`). La carga automática de `CLAUDE.md` y de la memoria al
  arrancar, y la lista de tareas de la herramienta, son del arnés: no son
  lectura ni escritura propia.
- **Aprobaciones del titular.** Los diálogos aprobados no son observables
  para la sesión: `intervenciones_humanas` registra solo denegaciones y
  mensajes del titular (`- intervencion: <hora> <qué>`), y los diálogos
  aprobados se declaran `no_medible`.

### 0.4 Comandos de medición sin nombre propio (forma escrita)

- Árbol de FASE 0: la herramienta de escritura escribe las 6 líneas de §4
  paso 2 en `<TMP>/simce_s36_arbol_esperado.txt` y se comparan con
  `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort | diff "${TMPDIR:-${TEMP:?}}/simce_s36_arbol_esperado.txt" -; echo "rc $?"'`,
  esperado solo `rc 0`.
- 🔒1 (datos): `bash -c 'git ls-files | command grep -cE "\.(csv|tsv|xls|xlsx|parquet|rds|sqlite|db|feather)$"; git diff --name-only --diff-filter=A d32ad14 HEAD | command grep -cE "\.(csv|tsv|xls|xlsx|parquet|rds|sqlite|db|feather)$"'`,
  esperado `28` y `0`.
- 🔒2 (`docs/`): `bash -c 'git diff --name-only d32ad14 HEAD -- docs | wc -l | tr -d " "'`, esperado `0`.
- 🔒3 (sin push ni fetch): `bash -c 'git rev-parse --short origin/main'`, esperado `d32ad14`.
- 🔒4 (alcance): la herramienta de escritura escribe en
  `<TMP>/simce_s36_alcance.txt` la centinela `## centinela_s36` y, una por
  línea, las rutas de los ALCANCE de T1 a T4 y
  `50_documentacion/encargos/50_indice_encargos.md`; después
  `bash -c 'git -c core.quotePath=false diff --no-renames --name-only <hash_inicial> HEAD | LC_ALL=C sort | command grep -vxF -f "${TMPDIR:-${TEMP:?}}/simce_s36_alcance.txt" | command grep -v "^50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/" | wc -l | tr -d " "'`,
  esperado `0`.
- 🔒6 (encargo e insumos intactos): `bash -c 'git diff --name-only <hash_inicial> HEAD -- 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_encargo.md 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos | command grep -cE "/50_insumo_|/50_sonda_|/50_encargo[.]md"'`,
  esperado `0`.
- 🔒7 (filas en ceros fuera): la línea `ceros_json` de `<SONDA2 r>`, esperado
  `0`, junto con la línea `ceros` de `<SONDA1>`, esperado `8216` (existen en
  las bases y no entran).
- 🔒8 (reglas de v34 y v35): en `simce_s36_vmotor_r.txt`,
  `bash -c 'command grep -cE "^ *(M3|M8) .*PASA|PASA.*\b(M3|M8)\b" "${TMPDIR:-${TEMP:?}}/simce_s36_vmotor_r.txt"'`
  esperado `2`; y
  `bash -c 'command grep -cE "^ *R4 .*PASA|PASA.*\bR4\b" "${TMPDIR:-${TEMP:?}}/simce_s36_vtray_r.txt"'`
  esperado `1`. Si la batería imprime el estado con
  otra forma, FASE 0 registra la forma real como `dato:` sobre la línea base
  y FASE R la usa.
- 🔒9 (insumos de datos intactos):
  `bash -c 'md5sum 20_insumos/auxiliares/directorio_oficial_ee.csv | cut -d" " -f1; git status --porcelain -- 20_insumos | wc -l | tr -d " "'`,
  esperado `80be2b37bf1879dd47875422641bd297` y `0`.
- FASE L paso 7:
  `bash -c 'L=50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md; ls -l "$L" | cut -c1-10; wc -l < "$L"; head -1 "$L"; tail -c 1 "$L" | wc -l | tr -d " "; for p in "^### FASE" "^esperado:" "^- faltante: esperado de" "^obtenido:" "^## J"; do command grep -c "$p" "$L"; done | paste -sd " " -'`.

## 1. Estado de partida (premisas marcadas)

- `HEAD` y `origin/main` en `d32ad14`, rama `main`, árbol limpio antes del depósito (fuente: `git rev-parse --short HEAD`, `git rev-parse --short origin/main` y `git status --porcelain | wc -l` = 0 en la estación, sesión redactora, git de solo lectura). Se mide en H1.
- Después del depósito, el árbol tiene exactamente las 5 líneas `??` del expediente (encargo, dos insumos y dos sondas); con el log, 6 (fuente: `git status --porcelain --untracked-files=all` en la estación, sesión redactora, medido después de la última escritura). Se mide en FASE 0 paso 2.
- `20_insumos/auxiliares/directorio_oficial_ee.csv` es el corte 2025-04-30, md5 `80be2b37bf1879dd47875422641bd297`, ignorado por `.gitignore` L44 (fuente: `md5sum` y `git check-ignore -v` en la estación, sesión redactora). El corte 2026 no está en el repo (D36-2). Se mide en H3 y en 🔒9.
- `CLAUDE.md` existe en la raíz, ignorado por `.gitignore` L49, igual al contrato del kit «Versión 7», md5 `2f2b69acbad905f94946dff865eb575b` (fuente: `md5sum` en la estación, sesión redactora). Se mide en H3.
- Filtro vigente: `agregar_ponderado()` excluye `nalu < 10` y `marca` no vacía (fuente: `10_utils/10_utils.R` L65-70, sesión redactora); `33_generar_html.R` repite la regla en L275-279, L296-300 y L317-321 (fuente: lectura, sesión redactora); la vista la aplica en `base_valida()` (`36_funciones_trayectorias.R` L228-239) y la base independiente de su batería en `36_verificar_trayectorias.R` L104-108 (fuente: lectura, sesión redactora).
- `SUMA_NIVELES_MIN <- 99` y `SUMA_NIVELES_MAX <- 101` viven en `36_funciones_trayectorias.R` L85-86 y `UMBRAL_EVALUADOS <- 10` en L92 (fuente: `grep -n`, sesión redactora).
- `.tests_agregar_ponderado()` (`10_utils/10_utils.R` L98-224) imprime `OK: 7/7 casos de .tests_agregar_ponderado() pasaron.`; ningún script la llama; sus casos no traen `palu_eda_ele` ni `palu_eda_ins` (fuente: lectura, sesión redactora).
- «Marca(s) de supresión», sin distinguir mayúsculas, aparece en `10_utils/10_utils.R:27`, `30_procesamiento/32_agregar_comunal.R:36`, `30_procesamiento/33_generar_html.R:270` y `:291` (4, archivos de T1) y en `README.md:214` (1, T4) (fuente: `grep -n -i -E "marcas? de supresi"`, sesión redactora).
- **Fila S1** (fuente: `<A>/50_sonda_simbologia.R` corrida en la sesión redactora sobre copias del repo con el directorio 2025):
  ```text
  validas 142353
  simb 2008
  ceros 8216
  cc_4b_lect_2025 55 1194 54 1184
  cc_4b_mate_2025 53 1187 52 1175
  codigos 1 | 2 | 3 | 4 | Ajenas a la Agencia: Resultados no representativos | Ajenas al Establecimiento: Resultados no representativos | Alumnos insuficientes
  ```
- **Fila S2 de partida** (fuente: `<A>/50_sonda_json.R` sobre `docs/index.html` publicado, que es el build vigente con el directorio 2025, sesión redactora):
  ```text
  cc_4b_lect_2025 54 1184
  cc_4b_mate_2025 52 1175
  simce_rbd 140345
  simb ausente
  catalogo ausente
  ceros_json 0
  ```
  Se mide en H4 sobre el build de esta estación (`<SONDA2 f0>`).
- Las 2.008 filas con marca y resultado válido traen puntaje promedio publicado; ninguna fila válida tiene menos de 10 evaluados, ni `cod_grupo` o dependencia vacíos (fuente: recuentos sobre los 18 xlsx en la sesión redactora; el revisor técnico reprodujo 142.353 filas en `simce_rbd` con la regla nueva).
- El motor agrega un Servicio Local desde `simce_rbd` con `generateSeriesGseCombinado` (template L1637) y el tooltip de comparación por GSE con `getSeriesForEntity` (L1749-1751); `SimceData` es global (L1335) (fuente: lectura, revisor técnico, sesión redactora).
- La fila de acciones del motor tiene «Exportar PNG» en comparación (L4967) y en el panorama (L4108); los CSV se arman en `exportarCSV` (L3216) y `exportarPanoramaCSV` (L3905); las notas son `article.note` en `.notes-grid` (L5038 en adelante); `ASTERISCO_UNICO = "†"` en L2782; el JSON va en `atob("…")` (L1321) (fuente: `grep -n` y lectura, sesión redactora).
- La batería del motor termina con `Resultado: <n> pruebas, <p> pasan, <f> fallan` y sale con código 1 si hay fallas (fuente: `33_verificar_motor.R` L700-709).
- `50_documentacion/activa/decisiones/` existe con 10 archivos de decisión (fuente: `ls` en la estación, sesión redactora); T4 copia ahí el insumo.
- 28 rutas versionadas con extensión de datos (fuente: `git ls-files | grep -cE '\.(csv|tsv|xls|xlsx|parquet|rds|sqlite|db|feather)$'`, sesión redactora).
- Que el build y las baterías corran en esta estación no se sabe: ninguna corrió aquí (hipótesis, se mide en FASE 0: H4).

## 2. Contexto y decisiones del titular

`slep_simce_adecuado` publica el motor (`docs/index.html`) y la vista de
trayectorias (`docs/trayectorias.html`). `00_build.R` corre los pasos 30, 31,
32, 33 y 36 y escribe sus salidas en `40_salidas/`.

| Id | Decisión | Fuente |
|---|---|---|
| D36-1 | Texto completo en `<A>/50_insumo_decision_d36_1.md.txt`: regla de inclusión por suma de niveles; umbral de 10 como aserción; «‡» con número de establecimientos; casilla a la derecha de «Exportar PNG», desmarcada por defecto; modal por año con lista plegada, filtrada a los territorios en pantalla; dos columnas en los CSV; nota literal en el motor y su primera oración en la vista; vista sin casilla ni «‡» en esta fase | titular, 2026-11-09 |
| D36-1a | Motivo del código 2, literal: «Por causas ajenas a la Agencia de Calidad de la Educación, los resultados de aprendizaje o las respuestas entregadas en los Cuestionarios de Calidad y Contexto de la Educación no son representativos.» | titular, 2026-11-09 |
| D36-2 | Este encargo usa el directorio 2025; la actualización a 2026 va en un encargo propio | titular, 2026-11-09 |
| D36-3 | Sin push ni copia a `docs/`: el titular revisa el motor y la vista generados y publica | titular, 2026-11-09 |

Textos de `MOTIVOS_SIMBOLOGIA` (T1): código `"1"`: «No es posible reportar
resultados, porque la cantidad de estudiantes evaluados es insuficiente. (6 o
menos)»; `"2"`: el de D36-1a; `"3"`: «Por causas ajenas al establecimiento, los
resultados no son representativos del desempeño de los estudiantes»; `"4"`:
«La aplicación de la prueba extendida no permite evaluar esta asignatura.»
(fuente: tabla «Marca: Observaciones al puntaje» de la hoja `2025_4b_rbd` de la glosa, sesión redactora).
`CODIGOS_LITERALES_SIMBOLOGIA`: «Alumnos insuficientes» → `"1"`; «Ajenas a la
Agencia: Resultados no representativos» → `"2"`; «Ajenas al Establecimiento:
Resultados no representativos» → `"3"`. Un código numérico leído como
`"2.0"` se normaliza a `"2"`.

## 3. Invariantes (🔒)

Los comandos están en §0.4; aquí solo su sentido y esperado.

| 🔒 | Qué y por qué | Esperado |
|---|---|---|
| 1 | Nada de datos agregado al repo | `28` y `0` |
| 2 | `docs/` intacto: la publicación es del titular | `0` |
| 3 | Sin push ni fetch | `d32ad14` |
| 4 | Solo cambian los ALCANCE, el expediente y el índice | `0` |
| 5 | Sin atribución a la herramienta (`<ATRIB>`) | `0 0` |
| 6 | El encargo, los insumos y las sondas quedan intactos | `0` |
| 7 | Las filas con los tres porcentajes en 0 siguen fuera | `0` y `8216` |
| 8 | Las reglas de v34 y v35 que cubren M3 (años derivados), M8 (`gobCL-sitio`) y R4 (marcas de ola desde los datos) | `2` y `1` |
| 9 | El directorio y `20_insumos/` intactos | md5 del directorio y `0` |

🔒1 a 🔒9 se miden en FASE R; 🔒4 y 🔒5, otra vez después de `docs(log)`.

## 4. FASE 0

0. **Llamada del testigo:**
   `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36\n" > "${TMPDIR:-${TEMP:?}}/simce_s36_testigo.txt" && echo raiz_ok'`
   → `dato:` (esperado `raiz_ok`; otro valor: regla 1). **Llamada de las
   rutas** (a la terminal): `bash -c 'cygpath -w "$(pwd)"; cygpath -w "${TMPDIR:-${TEMP:?}}"; cygpath -w "${HERRAMIENTAS_DEV_PATH:-sin_kit}"'`;
   al log va solo `dato: llamada de las rutas corrida; salida solo a la terminal`.
   Luego la herramienta de lectura lee el testigo, la de edición cambia
   `testigo s36` por `testigo s36 editado` y la de escritura crea
   `<TMP>/simce_s36_lecturas.txt` (lecturas previas, una por línea, o `ninguna`).
1. Crea `<EXP>/50_log.md` con la ficha de `<PROT>` §4.4 (§9), el título
   `# Log · inclusion_resultados_simbologia`, el encabezado de `<PROT>` §4
   (§8), el slot `## J. Juicio` con `(lo rellena FASE L)`,
   `## Registro por fase`, el `inicio`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`; la misma forma mide `fin`)
   y la sección `### FASE 0: log, punto de retorno, línea base e hipótesis`,
   con los `dato:` del testigo y de las lecturas; y el archivo de toleradas:
   `bash -c 'printf "%s\n" "## centinela_s36" > "${TMPDIR:-${TEMP:?}}/simce_s36_toleradas.txt"; wc -l < "${TMPDIR:-${TEMP:?}}/simce_s36_toleradas.txt" | tr -d " "'`
   esperado `1`.
2. Mide, con su `esperado:` antes:
   - **H1:** `bash -c 'basename "$(git remote get-url origin)" .git'` esperado
     `slep_simce_adecuado`; `git rev-parse --short HEAD` y
     `git rev-parse --short origin/main` esperados `d32ad14`;
     `git symbolic-ref --short HEAD` esperado `main`;
     `bash -c 'git stash list | wc -l | tr -d " "'` y
     `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'` esperados `0`.
   - **Árbol** (comando de §0.4), esperado exactamente estas 6 líneas:
     ```text
     ?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_encargo.md
     ?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md
     ?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_insumo_decision_d36_1.md.txt
     ?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_insumo_errores_s36.md.txt
     ?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_sonda_json.R
     ?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/50_sonda_simbologia.R
     ```
   - **H2:** `bash -c 'test -n "${TMPDIR:-${TEMP:-}}" && command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`
     esperado `0`.
   - **H3:** `<MD5>` de los cuatro archivos de `<A>`, esperados los de §4bis;
     `<MD5 20_insumos/auxiliares/directorio_oficial_ee.csv>` esperado
     `80be2b37bf1879dd47875422641bd297`; `<MD5 CLAUDE.md>` esperado
     `2f2b69acbad905f94946dff865eb575b`.
   - **H4 (línea base, regla vieja):** `<BUILD f0>`, `<TAGREG f0>` (esperado
     `rc 0` y `OK: 7/7 …`), `<VMOTOR f0>`, `<VTRAY f0>` (regla 2) y, después
     del build, `<SONDA2 f0>`, esperado la fila S2 de partida. Como `dato:`, la
     forma en que cada batería imprime PASA/FALLA por prueba (para 🔒8) y el
     par `esperado:`/`obtenido:` del grep de §1 sobre «supresión»
     (`bash -c 'git grep -n -i -E "marcas? de supresi" -- 10_utils 30_procesamiento README.md | wc -l | tr -d " "'`,
     esperado `5`: 4 de T1 y 1 de `README.md`).
   - **H5:** `<SONDA1>`, esperado la fila S1 (regla 3).
3. `<MD5 <EXP>/50_encargo.md>` → `encargo_md5`; copia el anexo de auditoría a
   la clave `auditoria_redaccion` de la ficha.
4. `git add --` del encargo, los dos insumos y las dos sondas (lista en un
   `.sh`, una ruta por línea); `<STAGED>` igual a esas 5 rutas;
   `git commit -m "docs(encargo): inclusion_resultados_simbologia" -- <las 5 rutas>`;
   `hash_inicial`; `<ARBOL>` esperado `0`; `<LOGVIVO>` esperado `1`. El
   registro de errores de la sesión 36 (`50_insumo_errores_s36.md.txt`) queda
   así versionado en el primer commit de la sesión; su destino final es el §15
   del traspaso v36.
5. Cierra la sección con los `obtenido:` y su estado.

## 4bis. Insumos

| Archivo de `<A>` | Uso | md5 |
|---|---|---|
| `50_insumo_decision_d36_1.md.txt` | `50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md`, T4 | `2b89f14e2fd4498e379cb5941699f3d7` |
| `50_insumo_errores_s36.md.txt` | registro de errores de la sesión 36 (versionado en FASE 0) | `d7b79d59153081df784ac0fcf31843ec` |
| `50_sonda_simbologia.R` | sonda S1 (§12) | `62c88269ebdf2deed1d7f34624ce93e2` |
| `50_sonda_json.R` | sonda S2 (§12) | `b3b9b224901a8365f92bc140657ebcfb` |

## 5. Tareas

### Grafo

T1 es la raíz. T2 requiere T1 (constantes y columnas nuevas). T3 requiere T1
(el JSON nuevo). T4 requiere T1, T2 y T3 (documenta el estado final). Orden:
T1, T2, T3, T4. FASE R y FASE L corren siempre (FASE R se omite solo tras la
detención 1).

Commits esperados, en orden:
`docs(encargo): inclusion_resultados_simbologia`,
`fix(pipeline): incluye los resultados con simbologia adicional de la Agencia (D36-1)`,
`fix(vista): regla de inclusion D36-1 en la vista de trayectorias`,
`feat(motor): signo, casilla de exclusion y modal de simbologia adicional (D36-1)`,
`docs(d36-1): decision, README y glosas`,
`docs(log): inclusion_resultados_simbologia`.

### Forma común

La de `<PROT>` §2.5 y §4.1: sección `### FASE Tn: <título>` siempre presente
(una tarea no ejecutada aporta su sección con `Estado: no ejecutada`); Paso 0
de lectura (`bash -c 'git status --porcelain -- <rutas del ALCANCE> | wc -l | tr -d " "'`,
esperado `0`); implementación; cierre en cinco pasos: (1) verificación con
`esperado:` y `obtenido:`, cada criterio con su partida (la línea base de H4,
registrada como `dato:`, distinta del esperado); (2) regresión: las pruebas de
la tarea; (3) alcance: `<PRECOMMIT>` igual a las rutas del commit y
`<MD5 <EXP>/50_encargo.md>` igual a `encargo_md5`; (4) commit con
`git add -- <rutas>`, `<STAGED>` igual y `git commit -m "<mensaje>" -- <rutas>`;
(5) sección cerrada, con `<ARBOL>` esperado `0` y `<LOGVIVO>` esperado `1`.

### T1 · Regla de inclusión en el pipeline

- `10_configuracion.R`: recibe `SUMA_NIVELES_MIN`, `SUMA_NIVELES_MAX` y
  `UMBRAL_EVALUADOS` (mismos valores; T2 los quita de
  `36_funciones_trayectorias.R`) y define `MOTIVOS_SIMBOLOGIA` y
  `CODIGOS_LITERALES_SIMBOLOGIA` con los textos de §2.
- `31_leer_normalizar.R`: agrega a `simce_rbd.parquet` las columnas
  `simbologia` (lógica: resultado válido con `marca` no vacía) y
  `cod_simbologia` (`"1"` a `"4"` o `NA`); un código sin entrada en
  `MOTIVOS_SIMBOLOGIA` detiene el build con el código y el archivo. Actualiza
  el esquema del encabezado.
- `10_utils.R`, `agregar_ponderado()`: la regla de filas pasa a «tres
  porcentajes no vacíos con suma entre `SUMA_NIVELES_MIN` y
  `SUMA_NIVELES_MAX`»; una fila válida con `nalu < UMBRAL_EVALUADOS` detiene
  con `stop()`; ya no filtra por `marca`. Suma a la salida `n_estab_simb`,
  `n_evaluados_simb`, `num_ade_simb`, `num_ele_simb` y `num_ins_simb` (sumas
  sobre las filas con `simbologia`; numeradores en estudiantes,
  `nalu * palu / 100`). En `.tests_agregar_ponderado()`: todos los casos
  traen `palu_eda_ele` y `palu_eda_ins` coherentes; el caso de marca pasa a «la
  marca no excluye y cuenta en `n_estab_simb`»; los casos 4 y 6 (`nalu < 10`
  con resultado válido) pasan a esperar el `stop()`; se suma un caso de fila en
  ceros excluida. El docstring y la línea 27 dejan de hablar de «supresión».
- `32_agregar_comunal.R`: propaga las cinco columnas y corrige el comentario de
  filtros (L36).
- `33_generar_html.R`: los tres filtros (L275-321) pasan a una sola función
  compartida con la regla nueva, y sus comentarios (L270, L291) a D36-1;
  `datos` suma las cinco columnas; `simce_rbd` suma `simb` (0 o 1); la raíz
  del JSON suma `simbologia`, un catálogo columnar con `rbd`, `anio`, `nivel`,
  `prueba`, `nalu` y `cod` de cada fila válida con simbología (el nombre y la
  comuna se unen en el navegador con `establecimientos`), y
  `meta$motivos_simbologia`.
- Verificación: `<BUILD T1>` `rc 0`; `<TAGREG T1>` `rc 0` y `OK: <n>/<n>` con
  `n` mayor que 7 (partida: `7/7`); `<SONDA2 T1>` esperado:
  ```text
  cc_4b_lect_2025 55 1194
  cc_4b_mate_2025 53 1187
  simce_rbd 142353
  simb 2008
  catalogo 2008
  ceros_json 0
  ```
  (partida: la fila S2 de H4);
  `bash -c 'git grep -n -i -E "marcas? de supresi" -- 10_utils 30_procesamiento/31_leer_normalizar.R 30_procesamiento/32_agregar_comunal.R 30_procesamiento/33_generar_html.R | wc -l | tr -d " "'`
  esperado `0` (partida: `4`).
- Pruebas: `<BUILD T1>` y `<TAGREG T1>`. Rutas del commit: las cinco del
  ALCANCE de T1. Mensaje:
  `fix(pipeline): incluye los resultados con simbologia adicional de la Agencia (D36-1)`.

### T2 · Vista de trayectorias

- `36_funciones_trayectorias.R`: deja de definir las tres constantes que T1
  movió; `base_valida()` aplica la regla nueva (la marca no excluye; el umbral
  es aserción); `excluir_marcadas` se conserva solo si D10 o D14 lo
  necesitan, declarándolo en el log; `cifras_notas()` cuenta los resultados con
  simbología incluidos.
- `36_trayectorias_template.html`: la nota de filas dice cuántos resultados con
  simbología adicional entran y suma la primera oración de la nota de D36-1.
- `36_verificar_trayectorias.R`: la base independiente (L104-108), la cabecera
  (L15) y el comentario de D14 pasan a la regla nueva; D14: la base no trae
  filas en ceros y trae exactamente las filas válidas con simbología del
  recuento independiente; D14c: plantar una fila en ceros la deja fuera. Toda
  prueba cuyo esperado cambia por D36-1 sigue la regla 9.
- Verificación: `<BUILD T2>` `rc 0`; `<VTRAY T2>` `rc 0`, o no peor que H4 en
  las pruebas que D36-1 no cambia; la lista de esperados cambiados (regla 9)
  en el log.
- Rutas del commit: las tres del ALCANCE de T2. Mensaje:
  `fix(vista): regla de inclusion D36-1 en la vista de trayectorias`.

### T3 · Motor: signo, casilla, modal, CSV y nota

- Estado global `excluirSimb` (falso al cargar). Con falso, las cifras usan
  todo; con verdadero, cada agregado resta los subtotales `_simb` (series
  desde `datos`) o salta las filas con `simb == 1` (series desde `simce_rbd`),
  y un agregado sin estudiantes queda vacío.
- «‡» (`ASTERISCO_SIMB`) junto a toda cifra cuyo agregado incluye
  establecimientos con simbología, con `excluirSimb` falso, en barras,
  sparkline, tabla y panorama, con la misma colocación y familia que «†»; si
  una cifra lleva los dos, «†» va primero. El tooltip suma la línea
  «‡ Incluye <n> establecimiento(s) con simbología adicional de la Agencia».
- Casilla en las dos filas `.section-actions` que tienen «Exportar PNG»
  (comparación y panorama; no la de la tabla), justo
  después del botón «Exportar PNG», con la etiqueta
  «Excluir resultados con simbología adicional ‡» y `title` y `aria-label`
  «Excluir resultados con simbología adicional de la Agencia»; las dos reflejan
  el mismo estado. Al marcarla se abre el modal y aparece el enlace «ver lista».
- Modal (estilos y conducta del modal «Agregar territorio»): título
  «Resultados excluidos del cálculo», subtítulo con territorios, nivel y
  prueba; botones de año con su número de casos (deshabilitados sin casos),
  empezando en el último año con casos; línea de resumen; lista plegada
  (`<details>`) con RBD, establecimiento, comuna, evaluados y motivo
  (`meta.motivos_simbologia[cod]`), solo de los establecimientos de los
  territorios en pantalla y del nivel y la prueba activos; pie «Fuente: Agencia
  de Calidad de la Educación, bases por establecimiento; nombres: directorio
  oficial MINEDUC». Cierra con la ×, con Escape y con un clic fuera.
- CSV: `exportarCSV` y `exportarPanoramaCSV` suman `n_estab_simbologia`
  (establecimientos con simbología del agregado, incluidos o excluidos) y
  `excluye_simbologia` (`si`/`no`).
- Notas: un `article.note` «Resultados con simbología adicional» con el texto
  literal de D36-1 punto 6; la nota de fórmula cambia la frase de filtros si la
  menciona.
- `33_verificar_motor.R`: M9 a M11 nuevas, con chromote y la forma de las
  existentes (`comprobar(id, descripcion, condicion, detalle)`, L124):
  **M9** evaluando en la página
  `SimceData.generateSeriesGseCombinado(<entidad SLEP Costa Central>, <nivel 4° básico>, <prueba Lectura>)`
  en 2025: con `excluirSimb` falso, 55 establecimientos y 1.194 evaluados; con
  verdadero, 54 y 1.184; el control positivo va **dentro** de M9 (cotejar con
  54 la cifra de la casilla desmarcada debe detectar la diferencia;
  `m9_ctl_detecta` en el detalle), nunca como prueba aparte en FALLA.
  **M10** con la casilla marcada, el modal en 2025 lista exactamente los
  establecimientos con simbología de la entidad (1 en Lectura, fuente: fila S1)
  con su motivo, y ningún establecimiento de otro territorio. **M11** a 375 px,
  la fila de acciones con la casilla no desborda (criterio de M4).
- Verificación: `<BUILD T3>` `rc 0`; `<VMOTOR T3>` `rc 0` (o no peor que H4
  en las pruebas que D36-1 no cambia), con M9 a M11 en PASA y
  `m9_ctl_detecta` verdadero.
- Rutas del commit: las dos del ALCANCE de T3. Mensaje:
  `feat(motor): signo, casilla de exclusion y modal de simbologia adicional (D36-1)`.

### T4 · Documentación (no toca código)

- Copia el insumo de decisión (§0.2 punto 3).
- `README.md`: en «Reglas de cálculo» (L138-140) la regla de inclusión de D36-1
  con su referencia, y en L214 la columna `marca` como simbología adicional.
- `referencia_glosas_simce.md`, A2: «Resuelta por D36-1 (2026-11-09): deroga la
  opción a».
- Verificación:
  `bash -c 'git grep -n -i -E "marcas? de supresi" -- README.md | wc -l | tr -d " "'`
  esperado `0` (partida: `1`);
  `bash -c 'git grep -c "D36-1" -- README.md 50_documentacion/activa/referencia_glosas_simce.md | wc -l | tr -d " "'`
  esperado `2` (partida: `0`);
  `bash -c 'test -f 50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md; echo $?'`
  esperado `0`.
- Pruebas: no toca código; regresión declarada «no aplica».
- Rutas del commit: las tres del ALCANCE de T4. Mensaje:
  `docs(d36-1): decision, README y glosas`.

## 6. FASE R

Los diez pasos de `<PROT>` §2.7:

1. **Inventario** de afirmaciones auditables desde el log (cada verificación,
   cada cifra, cada 🔒, el alcance global), numerado `R-01`..., en
   `<A>/50_R_inventario.txt` y en el log antes de auditar.
2. **Re-derivación independiente** con un comando distinto: las cifras del JSON
   con `<SONDA2 r>` (no con lo que escribieron las tareas), los md5 con
   `Rscript -e "cat(unname(tools::md5sum(\"<ruta>\")))"`, los conteos de
   texto con `git grep -c` en lugar de `command grep -c`.
3. **Invariantes:** el comando de cada 🔒 (§0.4), PASA/FALLA con salida literal.
4. **Alcance global:** 🔒4;
   `bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v -e "^?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md$" -e "^?? 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/anexos/" | wc -l | tr -d " "'`
   esperado `0` salvo el residuo declarado; md5 del encargo igual a
   `encargo_md5`, o BLOQUEA.
5. **Regresión completa:** `<BUILD r>`, `<TAGREG r>`, `<VMOTOR r>`, `<VTRAY r>`,
   `<SONDA1>` y `<SONDA2 r>`.
6. **Control positivo:** copia `<A>/50_sonda_json.R` a
   `<TMP>/simce_s36_sonda_json_plantada.R`, cambia con la herramienta de
   edición `d$cod_depe2 == "5"` por `d$cod_depe2 == "1"` y córrela sobre
   `<TMP>/simce_s36_motor_r.html` con
   `bash -c 'Rscript "${TMPDIR:-${TEMP:?}}/simce_s36_sonda_json_plantada.R" "${TMPDIR:-${TEMP:?}}/simce_s36_motor_r.html" 2>&1 | tr -d "\r" | command grep -E "^cc_4b_lect_2025 "'`:
   esperado una línea `cc_4b_lect_2025` distinta de `cc_4b_lect_2025 55 1194` (el instrumento distingue). Una auditoría que solo
   confirmó no auditó.
7. **Veredicto por hallazgo:** BLOQUEA (gobernanza, 🔒 en FALLA, alcance
   violado, datos alterados, historia divergente: no se repara, se registra con
   pregunta cerrada), REPARA (defecto propio dentro del ALCANCE), ADVIERTE (sin
   efecto sobre la meta). Sin hallazgos: «0 hallazgos» junto con el control
   positivo del paso 6.
8. **Ciclo de reparación:** como máximo 1, con commit
   `fix(auditoria): R-NN <hallazgo>` y re-verificación; lo que sobreviva queda
   como duda.
9. **Prohibiciones:** ajustar un criterio, una tolerancia o un esperado para
   que pase (la regla 9 rige solo dentro de T2 y T3, nunca en FASE R);
   ampliar un ALCANCE; tocar un 🔒; editar evidencia ya escrita.
10. **Salida:** la tabla
    `id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
    y el veredicto global (`APROBADO`, `APROBADO CON ADVERTENCIAS`,
    `OBSERVADO` o `BLOQUEADO`), que va al bloque J.

## 7. FASE L

Los nueve pasos de `<PROT>` §2.8:

1. Árbol antes de tocar el log: el comando del paso 4 de FASE R, esperado `0`
   más el residuo declarado; otra cosa se anota en `## Cierre` y no se limpia.
2. `## Cierre` (`<PROT>` §4.2): resumen, `git log <hash_inicial>..HEAD --oneline`,
   tabla de auditoría, invariantes, decisiones (§2), cifras, `- duda:`,
   `- error propio:`, notas para el revisor, la tabla «Calidad del encargo»
   (`| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |`,
   o `ninguno`), `- friccion:` e `- intervencion:`, inicio, fin y
   compactaciones de contexto; lo escrito después de medir lleva
   `(escrito después: FASE L)`. Las mediciones de los pasos 1, 5 y 6 van a
   `## Cierre` como pares `esperado:`/`obtenido:` marcados así; las del paso 8
   (`<STAGED>`, índice, 🔒4 y 🔒5) van solo al reporte, sin `esperado:` en el
   log.
3. Bloque J con los quince campos de `<PROT>` §4.0; `hash_final`.
4. Ficha: `fin`, `hash_final` y las demás claves; ninguna `null`
   (`no_medible` si no se mide); `push: "no"`.
5. Validación:
   `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md; echo "rc $?"'`
   esperado `rc 0`; con `1`, se corrige desde el detalle y un reintento; si
   persiste o es `2`, `ficha: no validada (<causa>)` en `## Cierre`.
6. Privacidad: `<PRIVACIDAD>`, esperado `rc 1` dos veces. Un hit se reemplaza
   por un conteo antes del commit y se declara en `## Cierre`.
7. Verificación del archivo (líneas `dato:`, comando de §0.4): `head -1` =
   `---`; termina en salto de línea (`1`); `^### FASE` igual a 6 (FASE 0, T1 a
   T4 y FASE R); `^esperado:` más `^- faltante: esperado de` igual a
   `^obtenido:`; `^## J` igual a 1. Lo faltante va a `## Cierre` como
   `- faltante: <qué>`.
8. Índice y commit: `git add --` del log y de cada `<A>/50_*.txt` que el
   encargo creó;
   `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --escribir; echo "rc $?"'`
   y `git add --` del índice si cambió; `<STAGED>` igual a esa lista;
   `git commit -m "docs(log): inclusion_resultados_simbologia" -- <lista>`.
   Después, 🔒4 y 🔒5 otra vez (al reporte).
9. Estado de cierre: qué quedó commiteado, que nada se publicó y el hash de
   `docs(log)`.

## 8. Plantilla del log

La de `<PROT>` §4: ficha (§9), título, encabezado (meta, fecha, repo y rama,
`EXPEDIENTE:` y `ORIGEN:`, ENTORNO, `EJECUCIÓN:` y el modo real de la sesión,
`AUDITORÍA DE REDACCIÓN:`, grafo, «sin subagentes», topes), `## J. Juicio`,
`## Registro por fase` con `### FASE 0`, `### FASE T1` a `### FASE T4` y
`### FASE R`, y `## Cierre`.

## 9. Ficha del log

Las claves de `<PROT>` §4.4, con
`expediente: 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia`,
`repo: slep_simce_adecuado` (H1), `origen: ninguno` y, al cerrar,
`push: "no"`; textos que YAML confundiría, entre comillas.

## 10. Reporte final

- Primera línea: `ls -l` y `wc -l <` del log y el hash de `docs(log)`.
- El bloque J copiado del log.
- Los hashes de los commits; 🔒4 y 🔒5 después de `docs(log)`; la salida de
  `<SONDA2 r>`; la lista de esperados cambiados por la regla 9.
- Para el titular, en este orden: abrir `40_salidas/motor_comparacion.html` y
  `40_salidas/trayectorias_traspasos.html` y revisarlos; si los aprueba, la
  copia a `docs/`, su commit y el push los hace él o un encargo de
  publicación.
- Lo que falló o sorprendió; si nada, decirlo.
- Última línea, literal:

  ```text
  → Sesión redactora: lee completo `50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_log.md` (commit docs(log) <hash>, <N> líneas) antes de evaluar. Este reporte es un resumen y no reemplaza al log.
  ```

## 11. Exclusiones declaradas

- **Publicación** (`docs/`, push): del titular, tras su revisión (D36-3).
- **Directorio 2026** y `ANIO_DATOS_VIGENTE`: encargo propio (D36-2).
- **Casilla y «‡» en la vista de trayectorias:** segunda fase (D36-1).
- **Suite de documentación** (`documentar.R`): próxima regeneración, con Q-89
  (requiere `npm` y red).
- **Textos de los códigos 1, 3 y 4 en el sitio de la Agencia:** si el titular
  los entrega, cambian `MOTIVOS_SIMBOLOGIA` en un encargo corto.

## 12. Sondas

Las dos van depositadas en `<A>` (§4bis, md5 en H3); FASE 0 las corre, no las
escribe. Ambas abren con la guarda de locale y validan su lectura.

**S1 · `<A>/50_sonda_simbologia.R`.** Recuento independiente sobre los 18 xlsx
y el directorio. Salida esperada: la fila S1 de §1. Si no la cumple: regla 3.

```r
source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_simbologia")
# Sonda S1 (encargo 20261109_inclusion_resultados_simbologia). Solo lectura.
# Cuenta, desde los 18 xlsx y el directorio, sin usar funciones del pipeline:
#   validas: filas establecimiento x prueba con los tres porcentajes y suma 99-101
#   simb:    de esas, las que traen marca de la Agencia (simbologia adicional)
#   ceros:   filas con los tres porcentajes en 0 (no son resultados)
#   cc_<nivel>_<prueba>_<anio>: Costa Central (4 comunas, COD_DEPE2 5 del
#            directorio), establecimientos y evaluados, con y sin simbologia
#   codigos: valores distintos de la marca entre las filas validas con marca
archivos <- sort(list.files(file.path("20_insumos", "simce"), pattern = "^simce(2m|4b)[0-9]{4}_rbd_final[.]xlsx$",
                            recursive = TRUE, full.names = TRUE))
stopifnot(length(archivos) == 18L)
dir_ee <- utils::read.delim(file.path("20_insumos", "auxiliares", "directorio_oficial_ee.csv"), sep = ";",
                            fileEncoding = "UTF-8-BOM", colClasses = "character")
stopifnot(nrow(dir_ee) == length(readLines(file.path("20_insumos", "auxiliares", "directorio_oficial_ee.csv"),
                                           warn = FALSE)) - 1L)
cc <- dir_ee$RBD[dir_ee$COD_COM_RBD %in% c("5103", "5105", "5107", "5109") & dir_ee$COD_DEPE2 == "5"]
num <- function(x) suppressWarnings(as.numeric(gsub(",", ".", as.character(x), fixed = TRUE)))
validas <- 0L; simb <- 0L; ceros <- 0L; codigos <- character(0); cc_lineas <- character(0)
for (f in archivos) {
  m <- regmatches(basename(f), regexec("^simce(2m|4b)([0-9]{4})_", basename(f)))[[1]]
  nv <- m[2]; an <- m[3]
  d <- readxl::read_excel(f)
  names(d) <- trimws(tolower(names(d)))
  if (an == "2018" && nv == "4b") names(d) <- gsub("_2m_", "_4b_", names(d), fixed = TRUE)
  for (p in c("lect", "mate")) {
    sf <- paste0(p, nv, "_rbd")
    a <- num(d[[paste0("palu_eda_ade_", sf)]]); e <- num(d[[paste0("palu_eda_ele_", sf)]])
    i <- num(d[[paste0("palu_eda_ins_", sf)]]); n <- num(d[[paste0("nalu_", sf)]])
    mk <- d[[paste0("marca_", sf)]]
    s <- a + e + i
    v <- !is.na(s) & s >= 99 & s <= 101
    con_m <- v & !is.na(mk)
    validas <- validas + sum(v); simb <- simb + sum(con_m)
    ceros <- ceros + sum(!is.na(s) & s == 0)
    codigos <- union(codigos, unique(as.character(mk[con_m])))
    if (an == "2025" && nv == "4b") {
      en_cc <- v & as.character(d$rbd) %in% cc
      sin <- en_cc & is.na(mk)
      cc_lineas <- c(cc_lineas, sprintf("cc_%s_%s_%s %d %d %d %d", nv, p, an,
                                        sum(en_cc), as.integer(sum(n[en_cc])), sum(sin), as.integer(sum(n[sin]))))
    }
  }
}
cat(sprintf("validas %d\nsimb %d\nceros %d\n", validas, simb, ceros))
cat(cc_lineas, sep = "\n")
cat("codigos ", paste(sort(codigos), collapse = " | "), "\n", sep = "")
```

**S2 · `<A>/50_sonda_json.R`.** Recuento independiente sobre el JSON
incrustado en un motor generado (argumento: ruta del HTML). Salida esperada:
la fila S2 de partida en H4 y la de T1 después. Si no la cumple en H4: regla 3.

```r
source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_json")
# Sonda S2 (encargo 20261109_inclusion_resultados_simbologia). Solo lectura.
# Lee el JSON incrustado en un motor generado (argumento 1; por omision
# 40_salidas/motor_comparacion.html) y cuenta, sin usar funciones del pipeline:
#   cc_4b_<prueba>_2025: Costa Central en `datos` (cod_com 5103, 5105, 5107,
#     5109; cod_depe2 "5"; nivel 4b; anio 2025): suma de n_estab y n_evaluados
#   simce_rbd: filas de la tabla por establecimiento
#   simb: filas de simce_rbd con simb == 1 (o "ausente" si la columna no existe)
#   catalogo: filas del catalogo `simbologia` (o "ausente")
#   ceros_json: filas de simce_rbd con palu + palu_ele + palu_ins == 0
args <- commandArgs(trailingOnly = TRUE)
ruta <- if (length(args) >= 1L) args[1] else file.path("40_salidas", "motor_comparacion.html")
html <- paste(readLines(ruta, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
b64 <- regmatches(html, regexpr('atob\\("[A-Za-z0-9+/=]+"\\)', html))
stopifnot(length(b64) == 1L)
b64 <- sub('^atob\\("', "", sub('"\\)$', "", b64))
crudo <- memDecompress(jsonlite::base64_dec(b64), type = "gzip")
J <- jsonlite::fromJSON(rawToChar(crudo), simplifyVector = TRUE)
d <- J$datos
stopifnot(length(d$cod_com) == d$rows)
filtro_cc <- d$cod_com %in% c("5103", "5105", "5107", "5109") & d$cod_depe2 == "5" &
  d$nivel == "4b" & d$anio == 2025L
for (p in c("lect", "mate")) {
  k <- filtro_cc & d$prueba == p
  cat(sprintf("cc_4b_%s_2025 %d %d\n", p, as.integer(sum(d$n_estab[k])), as.integer(sum(d$n_evaluados[k]))))
}
r <- J$simce_rbd
stopifnot(length(r$rbd) == r$rows)
cat(sprintf("simce_rbd %d\n", r$rows))
cat("simb ", if (is.null(r$simb)) "ausente" else as.character(sum(r$simb == 1L)), "\n", sep = "")
cat("catalogo ", if (is.null(J$simbologia)) "ausente" else as.character(length(J$simbologia$rbd)), "\n", sep = "")
cat(sprintf("ceros_json %d\n", sum((r$palu + r$palu_ele + r$palu_ins) == 0, na.rm = TRUE)))
```

## Anexo de auditoría de redacción
- Nivel: 3 (puntaje 4: C1, C6, C8; según puntaje)
- Rondas: 4 (tope de 3 ampliado a 4 por decisión del titular del 2026-11-09; ronda 1: conformidad, técnico, gobernanza; ronda 2: revisor nuevo; ronda 3: capa 5, simulación de la herramienta; ronda 4: revisor nuevo de verificación con simulación)
- Decisiones de la sesión entregadas a los revisores: D36-1, D36-1a, D36-2, D36-3, regla sin atribución, entorno Windows con Git Bash, mensaje de lanzamiento literal
- Ronda 1: BLOQUEA 6 · CORREGIR 23 · MENOR 28 (suma de los tres revisores; el BLOQUEA del directorio 2026 se resolvió con D36-2)
- Ronda 2: BLOQUEA 1 · CORREGIR 2 · MENOR 6
- Ronda 3: BLOQUEA 1 · CORREGIR 7 · MENOR 6 (el BLOQUEA es el mismo de la ronda 2)
- Ronda 4: BLOQUEA 0 · CORREGIR 1 · MENOR 4
- Abiertos: BLOQUEA 0 · CORREGIR 0 · MENOR 0
- MENOR abiertos: ninguno
- Límite declarado: los revisores no tienen Chrome, renv del proyecto ni el repo completo; el build, las baterías, `<TAGREG>` con la regla nueva, 🔒1 y los hashes se miden en FASE 0 (H1 a H4); las sondas S1 y S2 se corrieron de verdad en R sobre copias
- Condición de la sesión: completa
