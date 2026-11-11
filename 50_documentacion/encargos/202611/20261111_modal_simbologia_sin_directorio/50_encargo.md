# Encargo · El modal de simbología ubica cada resultado con la comuna y la dependencia de la base Simce (R-30)

> Léelo completo, hasta el anexo de auditoría, antes de la llamada del
> testigo (§4 paso 0).

## 0. Encabezado de contrato

- **Fecha de depósito:** 2026-11-11 (fuente: fecha de la sesión redactora, `TZ=America/Santiago`).
- **Meta:** que el modal «Resultados excluidos del cálculo» del motor liste
  exactamente los establecimientos que cuenta el «‡» de cada territorio,
  también los que ya no están en el directorio oficial vigente, ubicándolos
  con la comuna y la dependencia de la fila Simce (la misma regla que usan
  las cifras) y nombrándolos con el `nom_rbd` de la base de la Agencia cuando
  el directorio no los trae (D36-13, opción A del titular). Commits locales;
  **sin push y sin copiar a `docs/`** (la revisión visual y la publicación son
  del titular, §8).
- **MODO:** autónomo, todo en este turno. **Subagentes: no se admiten.**
- **EJECUCIÓN:** esfuerzo `high`; orquestador: el modelo de la sesión;
  subagentes 0; total Opus del encargo 0. (Cadena en serie: el pipeline antes
  que la plantilla, la plantilla antes que la batería.)
- **AUDITORÍA DE REDACCIÓN:** nivel 2 (puntaje 3: C1, porque el modal publica conteos de establecimientos y evaluados por año que cambian en los años con RBD sin directorio, y C8, por tocar `30_procesamiento/`; C6 no suma, el grafo tiene dos tareas); anexo al final.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio` · **ORIGEN:** `ninguno`.
  `<EXP>` es la ruta del expediente, `<A>` es `<EXP>/anexos` y el log es
  `<EXP>/50_log.md`. `<PROT>` es
  `$HERRAMIENTAS_DEV_PATH/prompts/encargo_autonomo_claude_code_v1.md` (v1.11),
  que se lee solo donde este encargo remite; la ficha del log es su §4.4.
  `<TMP>` es `${TMPDIR:-${TEMP:?}}`.
- **ENTORNO:** Claude Code en la estación Windows del titular
  (`estacion_windows`), Git Bash, lanzado en la raíz de
  `slep_simce_adecuado` (`C:\GitHub\slep_simce_adecuado`; el clon del Mac
  está atrasado y no sirve para este encargo, fuente: reporte del titular en
  la sesión redactora, un intento anterior en el Mac encontró `HEAD` en
  `d501236`). **Presencia del titular:**
  presente de punta a punta; sin FASE −1. **Red:** ninguna; ningún `fetch`,
  `pull` ni `push`. Todo comando de más de una línea va a un archivo
  `<TMP>/simce_s36r_<qué>.sh` escrito con la herramienta de escritura,
  terminado en salto de línea, normalizado con `sed -i "s/\r$//" <archivo>` y
  corrido con `bash <archivo>`. **Nunca un heredoc, tampoco para anexar al
  log, y nunca `sed -i` sobre el log ni sobre archivos del repo:** el log y
  los archivos de los ALCANCE se escriben y editan solo con las herramientas
  de escritura y edición. Todo `grep` va como `command grep`. Toda salida de
  `Rscript` que se compara pasa por `tr -d "\r"`. `<BUILD>`, `<VMOTOR>` y
  `<VTRAY>` se corren con el tiempo máximo de la herramienta Bash (600000 ms).
  Los comandos de §0.0 se transcriben tal cual desde sus bloques y en el log
  se citan por su nombre. El log nombra las rutas de `<TMP>` como
  `"${TMPDIR:-${TEMP:?}}/simce_s36r_<qué>"`. **Fricción conocida:**
  `TZ=America/Santiago date -Iseconds` da `+00:00` en Git Bash (fuente: logs
  de `20261109_ordenacion_estructura` y `20261109_mapa_hashes`); se registra
  tal cual como `dato:`.
- **INSUMOS:** el árbol del repo en `HEAD` `2eb0483` (§1); las tres sondas
  que deposita la sesión redactora en `<A>` (§10, md5 en H3); los 18 xlsx de
  `20_insumos/simce/{2m,4b}/` y los auxiliares que lee el build, solo desde R;
  `CLAUDE.md` local; `<PROT>` (solo lectura, donde el encargo remite) y
  `$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R` (FASE L). Nada
  más.
- **POSICIÓN:** todo comando desde la raíz del repo. Los scripts del
  proyecto corren con `Rscript <ruta>` sin `--vanilla` ni `--no-init-file`
  (el `.Rprofile` activa `renv`); los instrumentos del kit, con
  `--no-init-file`. Los mensajes `[ locale ]` de la guarda van al log solo
  como `dato: [ locale ] <n> líneas`.
- **Conteos:** toda comparación de un conteo es numérica (`| tr -d ' '`);
  `grep -c` con 0 coincidencias imprime `0` y sale con `1`, que no es falla.
  `<MD5 ruta>` es `bash -c 'md5sum "<ruta>" | cut -d" " -f1'`. Toda cifra
  sobre datos sale de `Rscript` o de la batería. Una medición sin esperado va
  como línea `dato:`.
- **ALCANCE:** en toda fase, además, `<TMP>` (prefijo `simce_s36r_`), el
  `tempdir()` de cada proceso R, `.git/`, los archivos de `40_salidas/` que
  el build escribe y `.gitignore` ignora (fuente: `.gitignore` L10 y L13-15,
  citado así en `20261109_inclusion_resultados_simbologia`; un archivo no
  ignorado ahí es residuo), y `<A>/50_<fase>_<qué>.txt`.
  **FASE 0:** el log. **T1:** `30_procesamiento/31_leer_normalizar.R`,
  `30_procesamiento/33_generar_html.R` y `README.md`. **T2:**
  `30_procesamiento/33_motor_template.html` y
  `30_procesamiento/33_verificar_motor.R`. **FASE R:** el log,
  `<A>/50_R_inventario.txt` y, en su ciclo de reparación, los archivos de T1
  y T2. **FASE L:** el log, los `<A>/50_*.txt` que el encargo crea y
  `50_documentacion/encargos/50_indice_encargos.md` (tras la detención 1,
  además el encargo y las sondas). `<EXP>/50_encargo.md` y las sondas no se
  editan nunca. `docs/` y
  `20_insumos/` no se tocan en ninguna fase.
- **PRUEBAS:** `<BUILD f>`, `<TAGREG f>`, `<VMOTOR f>` y `<VTRAY f>` (§0.0).
  Esperado: `rc 0`; `<VMOTOR>` pasa de 11 a 12 pruebas (M12 nueva) y
  `<VTRAY>` queda igual que su línea base de FASE 0. Subconjunto por tarea,
  declarado: T1 corre `<BUILD>`, `<TAGREG>` y `<CAT>` (cambia el catálogo,
  que solo lee el motor; `<VMOTOR>` sin T2 aún no tiene M12); T2 corre
  `<BUILD>`, `<VMOTOR>` y `<M12>` (cambia el motor y su batería; no toca R
  de agregación); FASE R corre las cuatro, más `<CAT>` y `<M12>`.
- **PUNTO DE RETORNO:** FASE 0 commitea el encargo y las tres sondas y
  registra `hash_inicial`. **Desviación declarada de `<PROT>` §2.5 pasos 2 y
  4 y de su párrafo de sondas:** las sondas vienen depositadas con su md5
  (FASE 0 las corre, no las escribe) y entran en el mismo commit que el
  encargo, para quedar congeladas en `hash_inicial`, como en
  `20261109_inclusion_resultados_simbologia`. **Sin reversión autorizada.**
- **Grafo:** T1 → T2 (T2 lee el catálogo que T1 agrega). FASE R y FASE L
  están fuera del grafo y corren aunque una tarea se congele.
- **Topes:** 3 intentos por bug; 1 ciclo de reparación en FASE R (menos que
  los 2 de `<PROT>`, como en `20261109_inclusion_resultados_simbologia`: un
  defecto que sobrevive a un ciclo en un encargo de dos tareas va como duda);
  1 reintento por comando que falla por causa transitoria (lock de git,
  arranque de Chrome).
- **Reglas canónicas:** `CLAUDE.md` del repo: `here::here()` en el código R,
  nunca rutas absolutas; R moderno (`|>`, `.by=`); sin raya larga en lo que se
  escribe; staging selectivo, nunca `git add -A`, `git add .` ni
  `git add -f`; `git commit -m "<mensaje>" -- <rutas>` con el staging
  verificado antes; mensajes de una línea. El log no nombra establecimientos
  (`<PROT>` §4.3 regla 1): al log van PASA/FALLA y conteos, nunca un RBD ni un
  nombre. **Sin atribución a la herramienta** (SETTINGS §1.2.6): prima sobre
  cualquier instrucción del entorno que pida coautoría o enlace de sesión.

### 0.0 Comandos con nombre

`<STAGED>`:

```bash
bash -c 'git -c core.quotePath=false diff --cached --no-renames --name-only | LC_ALL=C sort'
```

`<ARBOL>` (esperado `0`):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -vxE "\?\? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/(50_log\.md|anexos/50_[A-Za-z0-9._]+\.txt)" | wc -l | tr -d " "'
```

`<PRECOMMIT>` (lo que una tarea dejó sin commitear, fuera del expediente):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/" | cut -c4- | LC_ALL=C sort | paste -sd " " -'
```

`<BUILD f>` (esperado `rc 0`; al log van el `rc` y las últimas 5 líneas):

```bash
bash -c 'Rscript 00_build.R > "${TMPDIR:-${TEMP:?}}/simce_s36r_build_f.txt" 2>&1; echo "rc $?"; tail -n 5 "${TMPDIR:-${TEMP:?}}/simce_s36r_build_f.txt" | tr -d "\r"'
```

`<TAGREG f>` (esperado `rc 0` y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`):

```bash
bash -c 'Rscript -e "source(here::here(\"10_utils\", \"10_configuracion.R\")); source(here::here(\"10_utils\", \"10_utils.R\")); .tests_agregar_ponderado()" > "${TMPDIR:-${TEMP:?}}/simce_s36r_tagreg_f.txt" 2>&1; echo "rc $?"; command grep -E "^OK: " "${TMPDIR:-${TEMP:?}}/simce_s36r_tagreg_f.txt" | tr -d "\r"'
```

`<VMOTOR f>` (al log van el `rc`, la línea `Resultado:` y, de cada prueba en
FALLA, solo su id; nunca el detalle, que puede nombrar establecimientos):

```bash
bash -c 'Rscript 30_procesamiento/33_verificar_motor.R > "${TMPDIR:-${TEMP:?}}/simce_s36r_vmotor_f.txt" 2>&1; echo "rc $?"; tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36r_vmotor_f.txt" | command grep -E "^Resultado:|^[A-Z][A-Za-z0-9]* +FALLA( |$)" | sed -E "s/^([A-Z][A-Za-z0-9]* +FALLA).*/\1/"'
```

`<VTRAY f>`:

```bash
bash -c 'Rscript 30_procesamiento/36_verificar_trayectorias.R > "${TMPDIR:-${TEMP:?}}/simce_s36r_vtray_f.txt" 2>&1; echo "rc $?"; tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36r_vtray_f.txt" | command grep -E "^Resultado:|^[A-Z][A-Za-z0-9]* +FALLA( |$)" | sed -E "s/^([A-Z][A-Za-z0-9]* +FALLA).*/\1/"'
```

`<CAT f>` (sonda del catálogo sobre una copia del motor; antes copia el motor
a `<TMP>/simce_s36r_motor_f.html`; esperado en FASE 0, T1 y FASE R la línea de
§4, §5 T1 y §6):

```bash
bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f.html" && Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_catalogo.R "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f.html" 2>&1 | tr -d "\r" | command grep -E "^cat: "'
```

`<M12 f>` (las cifras de M12 sin nombres; esperado en T2 y FASE R la línea
de §5 T2):

```bash
bash -c 'tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36r_vmotor_f.txt" | command grep -oE "^M12 +(PASA|FALLA)|m12: [a-z_0-9 =]+" | sed -E "s/^M12 +/M12 /" | paste -sd " " -'
```

En los comandos con `f`, `f` es `f0` en FASE 0, `T1` o `T2` en las tareas y
`r` en FASE R.

`<ATRIB>` (esperado `0 0`):

```bash
bash -c '{ git log --format=%B 2eb0483..HEAD | awk -v p="^[[:space:]]*(co-authored-by:.*(claude|anthropic)|claude-session:|(🤖[[:space:]]*)?generated with .?claude)" "tolower(\$0) ~ p" | wc -l | tr -d " "; git log --format="%ae%n%ce%n%an%n%cn" 2eb0483..HEAD | command grep -ciE "anthropic|claude"; } | paste -sd " " -'
```

`<PRIVACIDAD>` (FASE L; esperado `rc 1` dos veces):

```bash
bash -c 'F="50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md $(ls 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_*.txt 2>/dev/null)"; command grep -nE "/[U]sers/|/[h]ome/|[A-Za-z]:[\\/][U]sers|/c/[U]sers|[~]/|$(printf "\342\200\224")" $F; echo "rc $?"; command grep -nE "[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]" $F; echo "rc $?"'
```

### 0.1 Regla de detención

1. **FASE 0:** el testigo, H1, el árbol, H2, H3, `<BUILD f0>`, `<TAGREG f0>`
   o `<CAT f0>` distintos de lo esperado → detén la sesión sin
   `docs(encargo)`. Sin log (falló el testigo o la creación del log), la
   sesión termina con el reporte. Con log, T1, T2 y FASE R escriben su
   sección con `Estado: no ejecutada (detención 1)` u
   `omitida (detención 1)`; el conteo de FASE L es 4; FASE L mide 🔒2 a 🔒4 en
   `## Cierre` (🔒3 con esperado vacío) y 🔒1 va `no_medible`; el `<ARBOL>` de
   FASE L paso 1 espera `4`, el encargo y las tres sondas sin versionar, y
   vuelve a `0` después de `docs(log)`; FASE L cierra con
   `hash_inicial: no_medible` y `hash_final` `2eb0483`, y su `docs(log)`
   versiona además el encargo y las sondas. `<VMOTOR f0>` o `<VTRAY f0>` distintos de
   `rc 0` no detienen: quedan como línea base y su batería se juzga después
   «no peor que la línea base» en las pruebas que el encargo no cambia.
2. **T1:** `<BUILD T1>`, `<TAGREG T1>` o una verificación de §5 T1 distintos
   de lo esperado → T1 se congela sin commit y T2 queda `no ejecutada`; sus
   archivos quedan como están, se declaran `- pendiente:` y FASE L no los
   toma.
3. **T2:** `<VMOTOR T2>` distinto de `Resultado: 12 pruebas, 12 pasan` (o,
   con línea base en FALLA, una prueba en FALLA que no lo estaba) o `<M12 T2>`
   distinto de lo esperado → T2 se congela sin commit, igual que la regla 2.
   Excepción: `casos` es `dato:` y `nacional_difieren` distinto de 0 es
   `- duda:` sin congelar (§5 T2 paso 3).
4. **Un 🔒 en FALLA:** BLOQUEA; FASE R completa sus pasos sin reparar ese 🔒.
5. **Residual:** cualquier estado, conteo o resultado no enumerado → congela
   la tarea en curso y sus descendientes, se registra como duda y se sigue con
   FASE R y FASE L. Fuera de una tarea: antes de `docs(encargo)`, regla 1;
   después, en FASE R o FASE L, se registra como duda y la fase sigue.
6. **Denegación** de un comando autorizado → `- friccion:` con la cita
   literal, sin reintentar por otra vía; congela la tarea en curso.
7. `<MD5 <EXP>/50_encargo.md>` distinto de `encargo_md5` al cerrar una tarea
   → congela esa tarea y sus descendientes.

### 0.2 Autorizaciones (lista cerrada)

0. Toda fase: comandos de solo lectura (`git status`, `git diff`, `git log`,
   `git show`, `git rev-parse`, `git symbolic-ref`, `git remote get-url`,
   `git ls-files`, `git grep`, `git stash list`, `command grep`, `diff`,
   `sort`, `uniq`, `cut`, `awk`, `tr`, `paste`, `sed -n`, `sed -E` sin `-i`,
   `wc`, `ls`, `test`, `head`, `tail`, `date`, `md5sum`, `basename`, `echo`,
   `printf`, `pwd`, `bash <archivo>.sh` sobre los `.sh` de `<TMP>`,
   `unzip -p` sobre los xlsx
   de `20_insumos/simce/` hacia una tubería, `bash -n`, `command -v`,
   `cygpath`) y los de §0.0; escribir en `<TMP>` archivos `simce_s36r_*`,
   `sed -i` sobre ellos y `cp` hacia `<TMP>`; correr `Rscript` sobre scripts
   del repo, de `<A>` y de `<TMP>`. A `<A>` va solo lo que el encargo nombra y
   una salida de más de 30 líneas como `<A>/50_<fase>_<qué>.txt`, sin nombres
   de establecimientos.
1. FASE 0: crear el log con la herramienta de escritura; `<BUILD f0>`,
   `<TAGREG f0>`, `<CAT f0>`, `<VMOTOR f0>`, `<VTRAY f0>`; el commit
   `docs(encargo): modal_simbologia_sin_directorio` del encargo y las sondas.
2. T1 y T2: editar los archivos de su ALCANCE con la herramienta de edición;
   sus pruebas; su commit (§5).
3. FASE R: las pruebas y comandos de §6 y como máximo un commit
   `fix(auditoria): R-NN <hallazgo>`. FASE L: `98_indexar_encargos.R` con
   `--validar` (más un reintento) y una vez con `--escribir`, y el commit
   `docs(log): modal_simbologia_sin_directorio`.

Nada más. En particular: ningún `fetch`, `pull` ni `push`; ninguna escritura
en `docs/`, `20_insumos/` ni `herramientas_dev`; ningún `rm`; ningún
`--force`, `--no-verify`, `revert`, `reset`, `restore`, `checkout --`,
`stash` (salvo `git stash list`) ni `commit --amend`; ningún heredoc ni
`sed -i` sobre el log o sobre archivos del repo; ningún `git config` que
escriba; ni la memoria de la herramienta.

### 0.3 Contrato de arranque (`<PROT>` §2.1 punto 8)

- **Lecturas previas:** antes del testigo se admite leer este encargo (no se
  lista), `CLAUDE.md`, `<PROT>`, los archivos de los ALCANCE y comandos de solo
  lectura, y las sondas de `<A>`; se listan después del testigo en `<TMP>/simce_s36r_lecturas.txt`
  y van como `dato:` a FASE 0, donde FASE R las juzga ADVIERTE.
- **Llamadas:** se nombran por lo que hacen. **Directorio:** la llamada del
  testigo comprueba la raíz; la siguiente imprime a la terminal, nunca al log,
  `cygpath -w` de la raíz, de `<TMP>` y de `$HERRAMIENTAS_DEV_PATH`.
- **Pre-registro:** testigo y rutas van como `dato:` con
  `(escrito después: paso 0)`; desde FASE 0 paso 1, todo `esperado:` va antes
  de su comando, también los de los commits.
- **Testigo:** primera escritura `<TMP>/simce_s36r_testigo.txt` desde la
  shell; luego lectura, edición y escritura con las herramientas sobre el
  testigo y `<TMP>/simce_s36r_lecturas.txt`.
- **Memoria y búsquedas:** sin leer ni escribir la memoria; búsquedas con
  `git grep` o `command grep` sobre rutas versionadas (nunca sobre
  `20_insumos/`, salvo el `unzip -p` de H2). La carga automática de
  `CLAUDE.md` y la memoria es del arnés.
- **Aprobaciones:** los diálogos aprobados no son observables
  (`intervenciones_humanas` registra solo denegaciones y mensajes del
  titular; lo demás, `no_medible`).

## 1. Estado de partida (premisas marcadas)

- `HEAD` y `origin/main` en `2eb0483`, rama `main`, árbol limpio antes del depósito (fuente: salida del push que el titular pegó en la sesión redactora, `7a43615..2eb0483 main -> main`, y `git status --porcelain | wc -l` = 0 sobre el clon de la estación, por el puente de solo lectura, sesión redactora). Se mide en H1.
- Después del depósito, el árbol tiene 4 líneas `??` (el encargo y las tres sondas); con el log, 5 (hipótesis, se mide en FASE 0).
- **Causa de R-30.** Las cifras ubican cada resultado por la comuna y la dependencia de la fila Simce: los territorios por comuna, región, grupo y nacional se calculan desde `DATA.datos` (`cod_com`, `cod_depe2`; `generateSeriesByDepe` y `generateSeriesGseCombinado`, `33_motor_template.html` L1600-1625 y L1756), que agrega `32_agregar_comunal.R` por `cod_com_rbd` y `cod_depe2` de `simce_rbd.parquet`. El modal, en cambio, ubica cada fila de `DATA.simbologia` con el directorio vigente (`rbdsDeTerritorio`, L4901-4910, sobre `DATA.establecimientos`) y toma de ahí nombre y comuna (L4934-4942) (fuente: lectura de la plantilla y de `33_generar_html.R` L269-275 y L348-365, sesión redactora).
- 25 de las 2.008 filas de `DATA.simbologia` son de RBD que no están en `DATA.establecimientos`, ninguna de 2025 (fuente: `50_sonda_catalogo.R` sobre `docs/index.html`, el motor publicado en `338e64f`, corrida por la sesión redactora: `cat: rows=2008 com=ausente depe=ausente grupo=ausente nom=ausente largos_iguales=TRUE sin_directorio=25`). Se mide en FASE 0 con `<CAT f0>`, esperado esa misma línea.
- `cod_depe2` de `simce_rbd.parquet` sale del directorio completo (`31_leer_normalizar.R` L63-82 y L394-396), mientras `DATA.establecimientos` es su subconjunto de establecimientos en funcionamiento y con matrícula (`30_construir_auxiliares.R` L425); por eso las 25 filas traen `cod_depe2` (1, 2 o 3) y comuna, y ninguna fila del catálogo tiene `cod_grupo`, `cod_com` ni `cod_depe2` nulos (fuente: auditoría de redacción, ronda 1, decodificando el JSON de `docs/index.html` y leyendo `30_construir_auxiliares.R`). Se mide en T1 (`<CAT T1>`: `com`, `depe` y `grupo` iguales a `rows`).
- Además de las 25, 3 filas del catálogo cuyos RBD sí están en el directorio tienen ahí una comuna distinta de la de su fila Simce; con D36-13 el modal las ubica en la comuna de la fila, como las cifras (fuente: auditoría de redacción, ronda 2, comparando el JSON de `docs/index.html` con la reconstrucción de `31` con los cambios de T1).
- `32_agregar_comunal.R` excluye las filas con `cod_grupo` nulo antes de agregar (L95-100), así que un resultado sin GSE no cuenta en el «‡» de comuna, región, grupo ni nacional, y sí en el de un SLEP o un establecimiento, que salen de `simce_rbd` (fuente: lectura, sesión redactora). Hoy son 0 filas del catálogo (premisa anterior); la regla de D36-13 lo replica con `grupo`.
- Los 18 xlsx traen la columna `nom_rbd` (fuente: `unzip -p <xlsx> xl/sharedStrings.xml | grep -c "<t>nom_rbd</t>"` = 1 en cada uno, sobre el clon de la estación, sesión redactora). Se mide en H2. `31_leer_normalizar.R` no la lee hoy (`cols_base`, L295) y el parquet tiene 16 columnas (L15-35) (fuente: lectura, sesión redactora).
- El catálogo `simbologia` del JSON trae `rows`, `rbd`, `anio`, `nivel`, `prueba`, `nalu` y `cod` (`33_generar_html.R` L357-365), y `DATA.comunas` trae `cod` y `nom` por comuna (L157-164) (fuente: lectura, sesión redactora).
- El rango de `rbdsDeTerritorio` con su comentario es L4897-4910 (la función empieza en L4901).
- `33_verificar_motor.R` tiene 11 pruebas (M1 a M11; M10 coteja el territorio con `DATA.establecimientos`, L761-771) y `.tests_agregar_ponderado()` imprime `OK: 9/9 ...` (`10_utils/10_utils.R` L320) (fuente: lectura, sesión redactora). Se miden en FASE 0.
- Un comuna-territorio del motor es `{ kind: "comuna", comunas: [<cod>] }` y su serie trae `n_simb` por año (`generateSeriesGseCombinado`, L1713 en adelante; `n_simb` de `nuevoAcc`, L1497) (fuente: lectura, sesión redactora). M12 lo usa.

## 2. Decisiones

| Id | Decisión | Fuente |
|---|---|---|
| D36-13 | El modal de simbología ubica cada resultado con la comuna (`cod_com_rbd`), la dependencia (`cod_depe2`) y el GSE (`cod_grupo`, que tiene que existir) de su fila Simce, igual que las cifras; un SLEP sigue por su lista de RBD y un establecimiento por su RBD. El nombre es el del directorio vigente y, si el RBD no está, el `nom_rbd` de la base de la Agencia; la comuna, la de `DATA.comunas` por su código | titular, opción A, sobre propuesta de la sesión redactora |
| D36-14 | El popup «ver establecimientos» sigue con el directorio vigente: queda fuera (§9) | sesión redactora, por alcance |

## 3. Invariantes (🔒)

| 🔒 | Qué y por qué | Comando | Esperado |
|---|---|---|---|
| 1 | Las cifras no cambian: el encargo solo cambia la lista del modal | `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f0.html" "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html" 2>&1 \| tr -d "\r" \| command grep -E "^igual "'`; la línea `Resultado:` de `<VTRAY r>` | `igual TRUE`; igual a la de `<VTRAY f0>` (sin duración: la batería no la imprime) |
| 2 | Sin atribución: regla del titular (SETTINGS §1.2.6) | `<ATRIB>` | `0 0` |
| 3 | Solo cambian los archivos de T1 y T2, el expediente y el índice: el encargo no se sale de su meta | `bash -c 'git -c core.quotePath=false diff --name-only 2eb0483 HEAD \| command grep -v "^50_documentacion/encargos/" \| LC_ALL=C sort \| paste -sd " " -'` | completo: `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R README.md`; con T2 sin commit, las 3 rutas de T1; con T1 sin commit o tras la detención 1, vacío |
| 4 | Nada de datos ni de publicación: `docs/` y `20_insumos/` intactos | `bash -c 'git diff --name-only 2eb0483 HEAD -- docs 20_insumos \| wc -l \| tr -d " "; git status --porcelain -- 20_insumos docs \| wc -l \| tr -d " "'` | `0` y `0` |

**Nota:** los comandos de esta tabla llevan `\|` por la tabla; al
transcribirlos, `\|` es `|`. Las copias `simce_s36r_motor_f0.html` y
`simce_s36r_motor_r.html` las dejan `<CAT f0>` y `<CAT r>`.

## 4. FASE 0

0. **Testigo:**
   `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36r\n" > "${TMPDIR:-${TEMP:?}}/simce_s36r_testigo.txt" && echo raiz_ok'`
   → `dato:` (esperado `raiz_ok`). **Rutas** (a la terminal):
   `bash -c 'cygpath -w "$(pwd)"; cygpath -w "${TMPDIR:-${TEMP:?}}"; cygpath -w "${HERRAMIENTAS_DEV_PATH:-sin_kit}"'`.
   Lectura, edición (`testigo s36r` → `testigo s36r editado`) y escritura
   (`<TMP>/simce_s36r_lecturas.txt`).
1. Crea `<EXP>/50_log.md` con la herramienta de escritura: la ficha de
   `<PROT>` §4.4, el título `# Log · modal_simbologia_sin_directorio`, el
   encabezado de `<PROT>` §4, el slot `## J. Juicio` con
   `(lo rellena FASE L)`, `## Registro por fase`, `inicio`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`) y
   `### FASE 0: log, punto de retorno y línea base`. La ficha nace con
   `expediente: 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio`,
   `repo: slep_simce_adecuado`, `origen: ninguno` y `push: "no"`; los valores
   que se conocen después se escriben con la herramienta de edición.
2. Mide, con su `esperado:` antes:
   - **H1:** `bash -c 'basename "$(git remote get-url origin)" .git'`
     esperado `slep_simce_adecuado`; `git rev-parse --short HEAD` y
     `git rev-parse --short origin/main` esperados `2eb0483`;
     `git symbolic-ref --short HEAD` esperado `main`;
     `bash -c 'git stash list | wc -l | tr -d " "'` y
     `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'` esperados `0`.
   - **Árbol:**
     `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`,
     esperado exactamente:
     ```text
     ?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_encargo.md
     ?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md
     ?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_catalogo.R
     ?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_catalogo_alt.R
     ?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R
     ```
   - **H3:** `<MD5>` de las tres sondas, esperados los de §10.
   - **H2:** `bash -c 'for f in 20_insumos/simce/*/*.xlsx; do unzip -p "$f" xl/sharedStrings.xml | command grep -c "<t>nom_rbd</t>"; done | awk "{n[\$1]++} END{for (k in n) print n[k], k}"'`
     esperado exactamente `18 1`;
     `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`
     va como `dato:` (no detiene).
   - **Línea base:** `<BUILD f0>` esperado `rc 0`; `<TAGREG f0>` esperado
     `rc 0` y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`;
     `<CAT f0>` esperado
     `cat: rows=2008 com=ausente depe=ausente grupo=ausente nom=ausente largos_iguales=TRUE sin_directorio=25`
     (deja la copia `<TMP>/simce_s36r_motor_f0.html` para 🔒1);
     `<VMOTOR f0>` esperado `rc 0` y `Resultado: 11 pruebas, 11 pasan, 0 fallan`
     (seguido de la duración, que no se compara); `<VTRAY f0>` esperado
     `rc 0` (su línea `Resultado:` completa va como `dato:` y es la línea
     base de 🔒1).
3. `<MD5 <EXP>/50_encargo.md>` → `encargo_md5`; el anexo de auditoría a la
   clave `auditoria_redaccion`.
4. Con su `esperado:` antes: `git add --` del encargo y las tres sondas;
   `<STAGED>` igual a esas 4 rutas;
   `git commit -m "docs(encargo): modal_simbologia_sin_directorio" -- <las 4 rutas>`;
   `hash_inicial`; `<ARBOL>` esperado `0`.
5. Cierra la sección.

## 5. Tareas

### Forma común

Cada tarea escribe en el log su sección `### FASE Tn: <título>` (también una
tarea no ejecutada, con su `Estado:`), con sus `esperado:` antes de correr el
primer comando (los del commit incluidos); su paso 0 es
`bash -c 'git status --porcelain -- <archivos de su ALCANCE> | wc -l | tr -d " "'`
esperado `0`; edita
con la herramienta de edición, corre sus pruebas, mide `<PRECOMMIT>`
(esperado: exactamente los archivos de su ALCANCE que cambió), comprueba
`<MD5 <EXP>/50_encargo.md>` igual a `encargo_md5`, hace `git add --` de esos
archivos, `<STAGED>` igual a ellos, el commit con rutas explícitas y
`<ARBOL>` esperado `0`. Cierra con la plantilla de sección de `<PROT>` §4.1.
Las líneas de código citadas en §5 son de `2eb0483` (fuente: lectura de los
archivos de `2eb0483`, sesión redactora, y confirmación de la auditoría de
redacción, ronda 2).

### T1 · El catálogo de simbología lleva comuna, dependencia y nombre de la base

1. `31_leer_normalizar.R`:
   - `cols_base` (L295) suma `"nom_rbd"`, así que un xlsx sin la columna
     detiene el build con el mensaje que ya existe.
   - `extraer_prueba()` (L252-263) suma `nom_rbd = as.character(df_raw$nom_rbd)`
     después de `rbd`, y el orden final de columnas (L418-424) la pone
     inmediatamente después de `rbd`.
   - El encabezado del script (L15-35) y el mensaje final (L524) pasan de 16 a
     17 columnas, con la línea `nom_rbd character nombre del establecimiento
     según la base de la Agencia (D36-13)`.
2. `33_generar_html.R`, catálogo `simbologia_lst` (L357-365): suma cuatro
   vectores, en este orden después de `rbd`: `com = df_simbologia$cod_com_rbd`,
   `depe = df_simbologia$cod_depe2`, `grupo = df_simbologia$cod_grupo` y
   `nom = df_simbologia$nom_rbd`, todos `character` (un `NA` viaja como
   `null`). El comentario del bloque (L348-351) pasa a decir que la comuna, la
   dependencia, el GSE y el nombre vienen de la fila Simce (D36-13) y que el
   modal ubica cada resultado con ellos.
3. `README.md`: la tabla de `simce_rbd.parquet` suma la fila
   `| nom_rbd | character | Nombre del establecimiento en la base de la Agencia (D36-13) |`
   después de `rbd`.
4. Pruebas, con su `esperado:` antes: `<BUILD T1>` `rc 0`; `<TAGREG T1>`
   como en FASE 0; `<CAT T1>` esperado exactamente
   `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25`.
5. Commit: `git commit -m "feat(pipeline): catalogo de simbologia con comuna, dependencia y nombre de la base (D36-13)" -- 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R README.md`.

### T2 · El modal ubica cada resultado como las cifras, y la batería lo prueba (M12)

1. `33_motor_template.html`:
   - `rbdsDeTerritorio` (L4897-4910) se reemplaza por una función pura de
     nivel superior, `filasSimbologia(entities, nivelCod, pruebasCod)`, que
     recorre `DATA.simbologia` y devuelve las filas del nivel y las pruebas
     dados que están en al menos un territorio de `entities`, con esta regla:
     un `slep`, si el RBD está en su lista `rbds`; un `estab`, si es su RBD;
     cualquier otro tipo (`comuna`, `region`, `group`, `nacional`), si la comuna de la
     fila (`C.com[i]`) está en `entity.comunas` (el nacional sin filtro de
     comuna), su GSE (`C.grupo[i]`) no es nulo (como en `32`, L95-100) y, si
     el territorio tiene `depe2`, si la dependencia de la fila (`C.depe[i]`)
     es igual a ella (comparadas como `String`; una fila con `com` o `depe`
     nulos no calza con un filtro). Sin caché ni memo: cada llamada recorre
     `DATA.simbologia` tal como está (el control de M12 lo muta). Cada fila devuelta trae
     `anio`, `rbd`, `prueba` (el código), `nom` (nombre del directorio si el
     RBD está en `DATA.establecimientos`; si no, `C.nom[i]`; si tampoco, el
     guion corto `-`), `com` (nombre de la comuna de `DATA.comunas` por
     `C.com[i]`, con `aNombrePropio`; si no hay, el del directorio; si
     tampoco, `-`), `nalu` y `cod`.
   - `ModalSimbologia` usa `filasSimbologia` en vez de su bucle propio y,
     como hoy, convierte el código de prueba en su nombre
     (`DATA.meta.pruebas`) y `cod` en su motivo
     (`DATA.meta.motivos_simbologia`) antes de ordenar, con el mismo orden.
     El comentario del bloque dice la regla de D36-13 en dos líneas. El único
     otro cambio visible del modal es el respaldo de nombre y comuna, que pasa
     de la raya larga al guion corto `-` (fuente: L4942 de la
     plantilla, que hoy usa la raya larga).
   - `filasSimbologia` va como función de nivel superior junto a
     `ModalSimbologia` (global en la página, como `SimceData`), porque M12 la
     llama.
2. `33_verificar_motor.R`:
   - **M10:** `en_territorio` (L770) deja de mirar `DATA.establecimientos`:
     busca en `DATA.simbologia` la fila del RBD con el año, el nivel (`4b`) y
     la prueba (`lect`) de la prueba, y mira su `com` y su `depe` (el
     territorio en pantalla sigue siendo el de las comunas de Costa Central
     con dependencia `5`, como hoy en `JS_M10_COMUNAS` y L770); sin fila,
     `false`. Su control planta, en vez del
     primer establecimiento del directorio fuera de esas comunas, el RBD de
     la primera fila de `DATA.simbologia` de ese año, nivel y prueba cuya
     `com` no está en ellas (existe: fuente, auditoría de redacción, ronda 2),
     y se actualizan el comentario de L747-754 y el de `JS_M10_PLANTAR`
     (L780-781).
   - **M12 nueva**, con su línea en el encabezado del script (que además
     pasa de «M4 a M11» a «M4 a M12» en L49 y en el comentario de L856): «el modal lista exactamente los
     establecimientos que cuenta el ‡». En la página, con la casilla
     desmarcada: para cada comuna de `DATA.comunas`, con el territorio
     `{ kind: "comuna", comunas: [cod] }` y con cada uno de
     `{ kind: "comuna", comunas: [cod], depe2: d }` para `d` de `"1"` a
     `"5"`; cada nivel (`4b`, `2m`), cada prueba (`lect`, `mate`) y cada año
     de `SimceData.YEARS`: compara el número de RBD distintos de
     `filasSimbologia([territorio], nivel, [prueba])` en ese año con el
     `n_simb` de ese año en
     `SimceData.generateSeriesGseCombinado(territorio, DATA.meta.niveles[nivel], DATA.meta.pruebas[prueba])`
     (los rótulos como en M9; un año sin punto, o con `n_simb` ausente o
     nulo, cuenta como 0). Cuenta `casos` (combinaciones con `n_simb > 0` o
     con filas en el modal) y `difieren` (combinaciones distintas). Además
     mide `sin_directorio` (filas de `DATA.simbologia` cuyo RBD no está en
     `DATA.establecimientos`), `sin_directorio_ubicadas` (de ellas, las que
     `filasSimbologia` devuelve para el territorio de su propia comuna, sin
     dependencia) y `nacional_difieren` (la misma comparación para
     `{ kind: "nacional" }`, solo como dato).
   - M12 imprime en su detalle, sin RBD ni nombres, la línea
     `m12: casos=<n> difieren=<n> sin_directorio=<n> sin_directorio_ubicadas=<n> nacional_difieren=<n> control=<detectado|no_detectado>`.
     PASA si `casos > 0`, `difieren == 0`,
     `sin_directorio == sin_directorio_ubicadas` y el control detecta.
   - **Control positivo de M12:** en la misma página, cambiar en
     `DATA.simbologia.com` el código de comuna de la primera fila que tenga
     `n_simb > 0` en su comuna por el de otra comuna de `DATA.comunas`,
     recontar `difieren` solo para esas dos comunas (tiene que ser mayor que
     0) y restituir el valor.
   - La medición real, el nacional y el control van en llamadas `js()`
     separadas, para no agotar el tiempo de `Runtime.evaluate` (una pasada
     completa tarda unos 2,4 s en node; fuente: auditoría de redacción,
     ronda 2).
   - `Resultado:` pasa a 12 pruebas.
3. Pruebas, con su `esperado:` antes: `<BUILD T2>` `rc 0`; `<VMOTOR T2>`
   `rc 0` y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (seguido de la
   duración, que no se compara); `<M12 T2>` esperado
   exactamente
   `M12 PASA m12: casos=<n> difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado`,
   con `casos` como `dato:` (la simulación de la auditoría de redacción, con
   el código real del motor en node, dio `casos=2946`, `difieren=0` y, con
   la regla vieja del directorio, `difieren=62`) (esperado `nacional_difieren=0` por la premisa
   de §1; un valor distinto va como `- duda:` con su valor, sin congelar).
4. Commit: `git commit -m "fix(motor): el modal de simbologia ubica cada resultado como las cifras (D36-13, M12)" -- 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R`.

## 6. FASE R

Los diez pasos de `<PROT>` §2.7:

1. **Inventario** de afirmaciones auditables desde el log (cada verificación,
   cada cifra, cada 🔒, el alcance global), numerado `R-01`..., en
   `<A>/50_R_inventario.txt` y en el log antes de auditar.
2. **Regresión y re-derivación.** Primero la regresión completa, con sus
   esperados: `<BUILD r>`, `<TAGREG r>`, `<CAT r>` (mismo esperado que en
   T1; deja `<TMP>/simce_s36r_motor_r.html`), `<VMOTOR r>`, `<M12 r>`
   (mismos esperados que en T2) y `<VTRAY r>`. Con T2 sin commit:
   `<VMOTOR r>` no peor que la línea base y `<M12 r>` no aplica; con T1 sin
   commit: `<CAT r>` igual a `<CAT f0>` más el residuo declarado. Después,
   la re-derivación independiente con un comando distinto: el catálogo con
   `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_catalogo_alt.R "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html" 2>&1 | tr -d "\r" | command grep -E "^cat: "'`
   (lee el JSON sin simplificar y por otra expresión; esperado la misma línea
   que `<CAT r>`); los md5 con
   `Rscript -e "cat(unname(tools::md5sum(\"<ruta>\")))"`; los conteos de
   texto con `git grep -c` en lugar de `command grep -c`.
3. **Invariantes:** el comando de cada 🔒 (§3), PASA/FALLA con salida literal.
4. **Alcance global:** 🔒3;
   `bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v -e "^?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md$" -e "^?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/" | wc -l | tr -d " "'`
   esperado `0` salvo el residuo declarado; md5 del encargo igual a
   `encargo_md5`, o BLOQUEA.
5. **Regresión completa:** la del paso 2 (no se repite).
6. **Control positivo**, con su esperado escrito antes: el de M12 corre
   dentro de la batería (paso 2); el de 🔒1,
   `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f0.html" "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html" plantar 2>&1 | tr -d "\r" | command grep -E "^igual "'`,
   esperado `igual FALSE`; además,
   `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_catalogo.R "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html" plantar 2>&1 | tr -d "\r" | command grep -oE "largos_iguales=[A-Z]+"'`,
   esperado `largos_iguales=FALSE` (la sonda distingue un catálogo mal
   formado); con T1 sin commit y `nom=ausente` en `<CAT r>`, esperado
   `largos_iguales=TRUE` (control no aplicable, `dato:`). Una auditoría que solo confirmó no auditó.
7. **Veredicto por hallazgo:** BLOQUEA (gobernanza, 🔒 en FALLA, alcance
   violado, datos alterados, historia divergente: no se repara, se registra
   con pregunta cerrada), REPARA (defecto propio dentro del ALCANCE),
   ADVIERTE (sin efecto sobre la meta). Sin hallazgos: «0 hallazgos» junto
   con el control positivo del paso 6.
8. **Ciclo de reparación:** como máximo 1, con commit
   `fix(auditoria): R-NN <hallazgo>` y re-verificación; lo que sobreviva queda
   como duda.
9. **Prohibiciones:** ajustar un criterio, una tolerancia o un esperado para
   que pase; ampliar un ALCANCE; tocar un 🔒; editar evidencia ya escrita.
10. **Salida:** la tabla
    `id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
    y el veredicto global (`APROBADO`, `APROBADO CON ADVERTENCIAS`,
    `OBSERVADO` o `BLOQUEADO`), que va al bloque J.

## 7. FASE L

Los pasos de `<PROT>` §2.8:

1. `<ARBOL>`, esperado `0` (salvo el residuo declarado).
2. `## Cierre` con los trece puntos de `<PROT>` §4.2: resumen, commits,
   auditoría, verificación de invariantes, decisiones (§2), estado de cifras
   críticas, dudas y pendientes, errores propios, notas para el revisor,
   estado de cierre, «Calidad del encargo», fricciones, e intervenciones y
   tiempos (inicio, fin y compactaciones). Lo escrito después de medir lleva
   `(escrito después: FASE L)`. Las mediciones de los pasos 1, 5 y 6 van a
   `## Cierre` como pares `esperado:`/`obtenido:`; las del paso 8 van solo
   al reporte. El punto 4 va con esta forma, que el validador acepta (log de
   `20261109_mapa_hashes`, validado con `rc 0` al primer intento):

```text
4. Verificación de invariantes (FASE R):
   - 🔒1 <qué>: PASA (<evidencia>)
   - 🔒2 <qué>: PASA (<evidencia>)
   - 🔒3 <qué>: PASA (<evidencia>)
   - 🔒4 <qué>: PASA (<evidencia>)
```

(con `FALLA` donde corresponda; la ficha lleva
`invariantes: {pasa: N, total: 4}`).
3. `hash_final` (`git rev-parse --short HEAD`) y `fin`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`); bloque J.
4. Ficha sin `null`, `push: "no"`.
5. 
`bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md; echo "rc $?"'`
esperado `rc 0` (un reintento). Si sigue en `rc 1`, da `rc 2`, falta el
script o la variable: `ficha: no validada (<causa>)` en `## Cierre`, y se
sigue.
6. `<PRIVACIDAD>`.
7. Forma del log, exento de pre-registro:
   `bash -c 'L=50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md; ls -l "$L" | cut -c1-10; wc -l < "$L"; head -1 "$L"; tail -c 1 "$L" | wc -l | tr -d " "; for p in "^### FASE" "^esperado:" "^- faltante: esperado de" "^obtenido:" "^## J"; do command grep -c "$p" "$L"; done | paste -sd " " -'`:
   `head -1` igual a `---`, salto de línea final `1`, `^### FASE` igual a 4
   (FASE 0, T1, T2, FASE R), `^## J` igual a 1 y paridad
   `esperado:` + faltantes = `obtenido:`.
8. `git add --` del log y de cada `<A>/50_*.txt` creado, por su nombre,
   nunca la carpeta ni un glob; `98_indexar_encargos.R --repo=. --escribir`
   y el índice si cambió; `<STAGED>`;
   `git commit -m "docs(log): modal_simbologia_sin_directorio" -- <lista>`.
9. Estado de cierre.

## 8. Reporte final

- Primera línea: `ls -l` y `wc -l <` del log y el hash de `docs(log)`.
  Segundo bloque: el bloque J. Después: los commits, la línea `<M12 r>`, 🔒1
  a 🔒4 medidos otra vez después de `docs(log)` y lo que falló o sorprendió
  (si nada, decirlo).
- Para el titular: la revisión visual del modal en
  `40_salidas/motor_comparacion.html` (casilla marcada, un territorio por
  comuna, un año antiguo), la copia a `docs/` y el push, que este encargo no
  hace.
- Última línea, literal:

  ```text
  → Sesión redactora: lee completo `50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md` (commit docs(log) <hash>, <N> líneas) antes de evaluar. Este reporte es un resumen y no reemplaza al log.
  ```

## 9. Exclusiones

- El popup «ver establecimientos» y los conteos de establecimientos que
  salen del directorio (D36-14).
- Cómo se asignan `cod_com_rbd` y `cod_depe2` a cada fila (anomalía A3,
  directorio completo): las cifras y el modal usan los mismos valores, y eso
  es lo que este encargo exige.
- La vista de trayectorias (no tiene modal de simbología; D36-1 punto 7).

## 10. Sondas

Las tres van depositadas en `<A>` (md5 en H3); el encargo las corre, no las
escribe. Abren con la guarda de locale y validan su lectura.

| Sonda | Uso | md5 |
|---|---|---|
| `50_sonda_catalogo.R` | `<CAT f>`; con `plantar`, control de FASE R | `b0c4609c4a91e2c1bd910a7837805142` |
| `50_sonda_catalogo_alt.R` | re-derivación de FASE R paso 2 | `33d1cee79d6afe9248df70a881397fff` |
| `50_sonda_json_igual.R` | 🔒1; con `plantar`, su control en FASE R | `d30362ed33555966894685414e36a06f` |

Sobre `docs/index.html` (el motor de `338e64f`), la sesión redactora obtuvo
con las dos primeras la línea de `<CAT f0>` de §4 paso 2, con la primera y
`plantar` la misma línea (sin `nom` no hay qué quitar) y con la tercera,
sobre el mismo archivo dos veces, `igual TRUE`, y con `plantar`,
`igual FALSE` (fuente: `Rscript` en la sesión redactora).

## Anexo de auditoría de redacción
- Nivel: 2 (puntaje 3: C1 y C8)
- Rondas: 3 de 3 (ronda 1: revisor combinado de conformidad y técnico, desviación de la forma de nivel 2, que pide dos revisores separados; ronda 2: revisor de conformidad y revisor técnico separados, con capa 5: reconstrucción de `31` con los cambios de T1 y simulación de `filasSimbologia` y `n_simb` con el código real del motor en node; ronda 3: revisor nuevo, por los dos BLOQUEA de la ronda 2)
- Decisiones de la sesión entregadas a los revisores: D36-13 (opción A del titular), regla sin atribución, entorno Windows con Git Bash, sin push ni copia a `docs/`
- Ronda 1: BLOQUEA 0 · CORREGIR 10 · MENOR 12
- Ronda 2: BLOQUEA 2 · CORREGIR 14 · MENOR 13 (conformidad 1/13/8 y técnico 1/1/5)
- Ronda 3: BLOQUEA 0 · CORREGIR 1 · MENOR 3
- Abiertos: BLOQUEA 0 · CORREGIR 0 · MENOR 0
- MENOR abiertos: ninguno
- Hallazgo de la capa 5: con el código real del motor, `casos=2946`, `difieren=0`, `sin_directorio_ubicadas=25`, `nacional_difieren=0`; la regla vieja del directorio da `difieren=62`, así que M12 detecta el defecto
- Límite declarado: los revisores no tienen `arrow` ni `chromote`; el build y la batería se miden en la estación
- Condición de la sesión: completa
