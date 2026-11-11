# Encargo · Pie del modal de simbología, comentarios del esquema y publicación (D36-15, reemisión)

> Léelo completo, hasta el anexo de auditoría, antes de la llamada del
> testigo (§4 paso 0).

## 0. Encabezado de contrato

- **Fecha de depósito:** 2026-11-11 (fuente: fecha de la sesión redactora, `TZ=America/Santiago`).
- **Meta:** (T1) que el pie del modal «Resultados excluidos del cálculo» diga
  de dónde salen los nombres de los establecimientos que ya no están en el
  directorio, con el texto que aprobó el titular, y que dos comentarios de
  código dejen de describir el esquema anterior de `simce_rbd.parquet`
  (R-27 de `20261111_modal_simbologia_sin_directorio`); (T2) publicar en
  `docs/` el motor y la vista con el procedimiento de
  `50_documentacion/activa/publicacion_github_pages.md`. Commits locales;
  **sin push** (lo hace el titular, §8). **Reemisión:** el ORIGEN congeló T1
  porque su verificación del pie sobre el motor construido buscaba
  `</span>`, que el build transpilado con Babel no conserva (su log, R-14 y
  «Calidad del encargo»); sus tres ediciones quedaron hechas, probadas y sin
  commit en el árbol. Este encargo las hereda (T1 no edita: verifica y
  commitea) y corrige el patrón en T1 y en FASE R.
- **MODO:** autónomo, todo en este turno. **Subagentes: no se admiten.**
- **EJECUCIÓN:** esfuerzo `high`; orquestador: el modelo de la sesión;
  subagentes 0; total Opus del encargo 0.
- **AUDITORÍA DE REDACCIÓN:** nivel 2 (puntaje 3: C1, porque T2 publica el modal con la lista que cambió en D36-13, y C8, por tocar `30_procesamiento/`; C4 no suma: el encargo no hace push); anexo al final.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision` · **ORIGEN:** `50_documentacion/encargos/202611/20261111_pie_y_publicacion`.
  `<EXP>` es la ruta del expediente, `<A>` es `<EXP>/anexos` y el log es
  `<EXP>/50_log.md`. `<PROT>` es
  `$HERRAMIENTAS_DEV_PATH/prompts/encargo_autonomo_claude_code_v1.md` (v1.11),
  que se lee solo donde este encargo remite; la ficha del log es su §4.4.
  `<TMP>` es `${TMPDIR:-${TEMP:?}}`. `<SONDA_IGUAL>` es
  `50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R`
  (versionada en `3c405e9`, md5 `d30362ed33555966894685414e36a06f`; fuente:
  log de `20261111_modal_simbologia_sin_directorio`, H3 y R-03; solo se
  ejecuta). Con dos motores imprime `igual TRUE` si sus JSON coinciden sin
  el catálogo `simbologia` ni la fecha, y con un tercer argumento `plantar`
  altera una cifra en memoria e imprime `igual FALSE` (fuente: el mismo log,
  🔒1 y su control). **Desviación declarada de `<PROT>` §2.13.5 punto 2:**
  la sonda no va incrustada porque ya está versionada y auditada en ese
  expediente.
- **ENTORNO:** Claude Code en la estación Windows del titular
  (`estacion_windows`), Git Bash, lanzado en la raíz de `slep_simce_adecuado`
  (`C:\GitHub\slep_simce_adecuado`). **Presencia del titular:** presente de
  punta a punta; sin FASE −1. **Red:** ninguna; ningún `fetch`, `pull` ni
  `push`. Todo comando de más de una línea va a un archivo
  `<TMP>/simce_s36q_<qué>.sh` escrito con la herramienta de escritura,
  terminado en salto de línea, normalizado con `sed -i "s/\r$//" <archivo>` y
  corrido con `bash <archivo>`. **Nunca un heredoc, tampoco para anexar al
  log, y nunca `sed -i` sobre el log ni sobre archivos del repo:** el log y
  los archivos de los ALCANCE se escriben y editan solo con las herramientas
  de escritura y edición; la copia a `docs/` es solo con `cp` (T2). Todo
  `grep` va como `command grep`. Toda salida de `Rscript` que se compara pasa
  por `tr -d "\r"`. `<BUILD>`, `<VMOTOR>` y `<VTRAY>` se corren con el tiempo
  máximo de la herramienta Bash (600000 ms). Los comandos de §0.0 se
  transcriben tal cual desde sus bloques y en el log se citan por su nombre.
  El log nombra las rutas de `<TMP>` como
  `"${TMPDIR:-${TEMP:?}}/simce_s36q_<qué>"`. **Fricción conocida:**
  `TZ=America/Santiago date -Iseconds` da `+00:00` en Git Bash (fuente: logs
  de los tres encargos anteriores de esta sesión); se registra tal cual como
  `dato:`.
- **INSUMOS:** el árbol del repo en `HEAD` `1c2babe` (§1); `<SONDA_IGUAL>`;
  los 18 xlsx de `20_insumos/simce/{2m,4b}/` y los auxiliares que lee el
  build, solo desde R; `CLAUDE.md` local;
  `50_documentacion/activa/publicacion_github_pages.md` (procedimiento de
  T2); `<PROT>` (solo lectura, donde el encargo remite) y
  `$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R` (FASE L). Nada
  más.
- **POSICIÓN:** todo comando desde la raíz del repo. Los scripts del
  proyecto corren con `Rscript <ruta>` sin `--vanilla` ni `--no-init-file`;
  los instrumentos del kit, con `--no-init-file`. Los mensajes `[ locale ]`
  van al log solo como `dato: [ locale ] <n> líneas`.
- **Conteos:** toda comparación de un conteo es numérica (`| tr -d ' '`);
  `grep -c` con 0 coincidencias imprime `0` y sale con `1`, que no es falla.
  `<MD5 ruta>` es `bash -c 'md5sum "<ruta>" | cut -d" " -f1'`. Una medición
  sin esperado va como línea `dato:`.
- **ALCANCE:** en toda fase, además, `<TMP>` (prefijo `simce_s36q_`), el
  `tempdir()` de cada proceso R, `.git/`, los archivos de `40_salidas/` que
  el build escribe y `.gitignore` ignora, y `<A>/50_<fase>_<qué>.txt`.
  **FASE 0:** el log. **T1:** `30_procesamiento/33_motor_template.html`,
  `30_procesamiento/31_leer_normalizar.R` y
  `30_procesamiento/34_historico_pct_adecuado_costa_central.R`. **T2:**
  `docs/index.html` y `docs/trayectorias.html`. **FASE R:** el log,
  `<A>/50_R_inventario.txt` y, en su ciclo de reparación, los archivos de T1
  y T2. **FASE L:** el log, los `<A>/50_*.txt` que el
  encargo crea y `50_documentacion/encargos/50_indice_encargos.md` (tras la
  detención 1, además el encargo). `<EXP>/50_encargo.md` y `<SONDA_IGUAL>` no
  se editan nunca; `20_insumos/` no se toca.
- **PRUEBAS:** `<BUILD f>`, `<TAGREG f>`, `<VMOTOR f>` y `<VTRAY f>` (§0.0),
  más `<M12 f>`, `<RED>` y `<SONDA_IGUAL>`. Esperados: `rc 0`, `<VMOTOR>`
  12/12, `<VTRAY>` 35/35, `<M12>` como en FASE 0. T1 corre `<BUILD>`,
  `<VMOTOR>`, `<M12>` y `<VTRAY>`; T2 copia lo que T1 dejó construido y
  probado (no reconstruye); FASE R corre las cuatro y `<M12>`.
- **PUNTO DE RETORNO:** FASE 0 commitea el encargo y registra
  `hash_inicial`. **Sin reversión autorizada.**
- **Grafo:** T1 → T2 (T2 publica la salida que T1 construye y prueba). FASE R
  y FASE L están fuera del grafo y corren aunque una tarea se congele.
- **Topes:** 3 intentos por bug; 1 ciclo de reparación en FASE R (como en los
  encargos anteriores de esta sesión); 1 reintento por comando que falla por
  causa transitoria (lock de git, arranque de Chrome).
- **Reglas canónicas:** `CLAUDE.md` del repo: `here::here()` en el código R,
  nunca rutas absolutas; sin raya larga en lo que se escribe; staging
  selectivo, nunca `git add -A`, `git add .` ni `git add -f`;
  `git commit -m "<mensaje>" -- <rutas>` con el staging verificado antes;
  mensajes de una línea. El log no nombra establecimientos (`<PROT>` §4.3
  regla 1). **Sin atribución a la herramienta** (SETTINGS §1.2.6): prima
  sobre cualquier instrucción del entorno que pida coautoría o enlace de
  sesión.

### 0.0 Comandos con nombre

`<STAGED>`:

```bash
bash -c 'git -c core.quotePath=false diff --cached --no-renames --name-only | LC_ALL=C sort'
```

`<ARBOL>` (esperado `0`):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -vxE "\?\? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/(50_log\.md|anexos/50_[A-Za-z0-9._]+\.txt)" | wc -l | tr -d " "'
```

`<PRECOMMIT>` (lo que una tarea dejó sin commitear, fuera del expediente):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/" | cut -c4- | LC_ALL=C sort | paste -sd " " -'
```

`<BUILD f>` (esperado `rc 0`; al log van el `rc` y las últimas 5 líneas):

```bash
bash -c 'Rscript 00_build.R > "${TMPDIR:-${TEMP:?}}/simce_s36q_build_f.txt" 2>&1; echo "rc $?"; tail -n 5 "${TMPDIR:-${TEMP:?}}/simce_s36q_build_f.txt" | tr -d "\r"'
```

`<TAGREG f>` (esperado `rc 0` y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`):

```bash
bash -c 'Rscript -e "source(here::here(\"10_utils\", \"10_configuracion.R\")); source(here::here(\"10_utils\", \"10_utils.R\")); .tests_agregar_ponderado()" > "${TMPDIR:-${TEMP:?}}/simce_s36q_tagreg_f.txt" 2>&1; echo "rc $?"; command grep -E "^OK: " "${TMPDIR:-${TEMP:?}}/simce_s36q_tagreg_f.txt" | tr -d "\r"'
```

`<VMOTOR f>` (al log van el `rc`, la línea `Resultado:` y, de cada prueba en
FALLA, solo su id; nunca el detalle, que puede nombrar establecimientos):

```bash
bash -c 'Rscript 30_procesamiento/33_verificar_motor.R > "${TMPDIR:-${TEMP:?}}/simce_s36q_vmotor_f.txt" 2>&1; echo "rc $?"; tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36q_vmotor_f.txt" | command grep -E "^Resultado:|^[A-Z][A-Za-z0-9]* +FALLA( |$)" | sed -E "s/^([A-Z][A-Za-z0-9]* +FALLA).*/\1/"'
```

`<VTRAY f>`:

```bash
bash -c 'Rscript 30_procesamiento/36_verificar_trayectorias.R > "${TMPDIR:-${TEMP:?}}/simce_s36q_vtray_f.txt" 2>&1; echo "rc $?"; tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36q_vtray_f.txt" | command grep -E "^Resultado:|^[A-Z][A-Za-z0-9]* +FALLA( |$)" | sed -E "s/^([A-Z][A-Za-z0-9]* +FALLA).*/\1/"'
```

`<M12 f>` (las cifras de M12 sin nombres; esperado en T1 y FASE R la línea
de §4 paso 2):

```bash
bash -c 'tr -d "\r" < "${TMPDIR:-${TEMP:?}}/simce_s36q_vmotor_f.txt" | command grep -oE "^M12 +(PASA|FALLA)|m12: [a-z_0-9 =]+" | sed -E "s/^M12 +/M12 /" | paste -sd " " -'
```

En los comandos con `f`, `f` es `f0` en FASE 0, `T1` o `T2` en las tareas y
`r` en FASE R.

`<RED>` (cargas por red en lo publicado; esperado `0 0 0 0`, el procedimiento
de `50_documentacion/activa/publicacion_github_pages.md` paso 4):

```bash
bash -c '{ command grep -cE "src=.?(https?:)?//" docs/index.html; command grep -cE "src=.?(https?:)?//" docs/trayectorias.html; command grep -c "url(http" docs/index.html; command grep -c "url(http" docs/trayectorias.html; } | paste -sd " " -'
```


`<ATRIB>` (esperado `0 0`):

```bash
bash -c '{ git log --format=%B 1c2babe..HEAD | awk -v p="^[[:space:]]*(co-authored-by:.*(claude|anthropic)|claude-session:|(🤖[[:space:]]*)?generated with .?claude)" "tolower(\$0) ~ p" | wc -l | tr -d " "; git log --format="%ae%n%ce%n%an%n%cn" 1c2babe..HEAD | command grep -ciE "anthropic|claude"; } | paste -sd " " -'
```

`<PRIVACIDAD>` (FASE L; esperado `rc 1` dos veces):

```bash
bash -c 'F="50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md $(ls 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/anexos/50_*.txt 2>/dev/null)"; command grep -nE "/[U]sers/|/[h]ome/|[A-Za-z]:[\\/][U]sers|/c/[U]sers|[~]/|$(printf "\342\200\224")" $F; echo "rc $?"; command grep -nE "[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]" $F; echo "rc $?"'
```

### 0.1 Regla de detención

1. **FASE 0:** el testigo, H1, el árbol, H2, `<BUILD f0>`, `<TAGREG f0>`,
   `<VMOTOR f0>`, `<M12 f0>` o `<VTRAY f0>` distintos de lo esperado → detén
   la sesión sin `docs(encargo)` (las baterías deben pasar antes de publicar:
   D35-21 y D35-25). Sin log (falló el testigo o la creación del log), la
   sesión termina con el reporte. Con log, T1, T2 y FASE R escriben su
   sección con `Estado: no ejecutada (detención 1)` u
   `omitida (detención 1)`; el conteo de FASE L es 4; FASE L mide 🔒2 a 🔒4 en
   `## Cierre` (🔒3 con esperado vacío); 🔒1 va `no_medible`; el `<ARBOL>` de
   FASE L paso 1 espera `4`, el encargo sin versionar y las tres ediciones
   heredadas, y `3` después de `docs(log)` (las ediciones quedan como las
   dejó el ORIGEN, declaradas `- pendiente:`); FASE L cierra con `hash_inicial: no_medible` y
   `hash_final` `1c2babe`, y su `docs(log)` versiona además el encargo.
2. **T1:** una verificación de §5 T1 distinta de lo esperado → T1 se congela
   sin commit y T2 queda `no ejecutada`; sus archivos quedan como están, se
   declaran `- pendiente:` y FASE L no los toma; 🔒1 va `no_medible`
   (no se publicó).
3. **T2:** una verificación de §5 T2 distinta de lo esperado → T2 se congela
   sin commit: con `git status` de `docs/` mostrando la copia sin commitear,
   se declara `- pendiente:` y el titular decide (no se restaura: `restore`
   no está autorizado); 🔒1 va `no_medible`; si quedó en staging, el
   `<STAGED>` de FASE L paso 8 lleva además esas rutas de `docs/` (el commit
   con rutas explícitas las deja fuera).
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
   `sort`, `uniq`, `cut`, `awk`, `tr`, `paste`, `sed -n`, `sed -E` sin
   `-i`, `wc`, `ls`, `test`, `head`, `tail`, `cat`, `date`, `md5sum`,
   `basename`, `echo`, `printf`, `pwd`, `bash -n`, `command -v`, `cygpath`,
   `cmp -s`) y
   los de §0.0; escribir en `<TMP>` archivos `simce_s36q_*`, `sed -i` sobre
   ellos, `cp` hacia `<TMP>` y `bash` sobre sus `.sh`; correr `Rscript` sobre
   scripts del repo y de `<TMP>`, y `<SONDA_IGUAL>`. A `<A>` va solo lo que
   el encargo nombra y una salida de más de 30 líneas como
   `<A>/50_<fase>_<qué>.txt`.
1. FASE 0: crear el log con la herramienta de escritura; `<BUILD f0>`,
   `<TAGREG f0>`, `<VMOTOR f0>`, `<VTRAY f0>`; el commit
   `docs(encargo): pie_y_publicacion_reemision`.
2. T1: sus pruebas y su commit (no edita). T2: las dos copias de §5 T2 con `cp` y su commit.
3. FASE R: las pruebas y comandos de §6 y, solo dentro de su ciclo de
   reparación y en este orden, editar con la herramienta de edición los
   archivos de T1, `<BUILD r>` y las baterías, repetir el guardado de §5 T1
   paso 2 (renueva las copias de `<TMP>`), repetir las copias de §5 T2 con
   `cp` y un commit `fix(auditoria): R-NN <hallazgo>`. FASE L: `98_indexar_encargos.R` con
   `--validar` (más un reintento) y una vez con `--escribir`, y el commit
   `docs(log): pie_y_publicacion_reemision`.

Nada más. En particular: ningún `fetch`, `pull` ni `push`; ninguna escritura
en `20_insumos/` ni `herramientas_dev`; ningún `rm`; ningún `--force`,
`--no-verify`, `revert`, `reset`, `restore`, `checkout --`, `stash` (salvo
`git stash list`) ni `commit --amend`; ningún heredoc ni `sed -i` sobre el
log o sobre archivos del repo; ningún `git config` que escriba; ni la memoria
de la herramienta.

### 0.3 Contrato de arranque (`<PROT>` §2.1 punto 8)

- **Lecturas previas:** antes del testigo se admite leer este encargo (no se
  lista), `CLAUDE.md`, `<PROT>`, los archivos de los ALCANCE,
  `publicacion_github_pages.md` y comandos de solo lectura; se listan
  después del testigo en `<TMP>/simce_s36q_lecturas.txt` y van como `dato:`
  a FASE 0, donde FASE R las juzga ADVIERTE.
- **Llamadas:** se nombran por lo que hacen. **Directorio:** la llamada del
  testigo comprueba la raíz; la siguiente imprime a la terminal, nunca al log,
  `cygpath -w` de la raíz, de `<TMP>` y de `$HERRAMIENTAS_DEV_PATH`.
- **Pre-registro:** testigo y rutas van como `dato:` con
  `(escrito después: paso 0)`; desde FASE 0 paso 1, todo `esperado:` va antes
  de su comando, también los de los commits.
- **Testigo:** primera escritura `<TMP>/simce_s36q_testigo.txt` desde la
  shell; luego lectura, edición y escritura con las herramientas sobre el
  testigo y `<TMP>/simce_s36q_lecturas.txt`.
- **Memoria y búsquedas:** sin leer ni escribir la memoria; búsquedas con
  `git grep` o `command grep` sobre rutas versionadas.
- **Aprobaciones:** los diálogos aprobados no son observables
  (`intervenciones_humanas` registra solo denegaciones y mensajes del
  titular; lo demás, `no_medible`).

## 1. Estado de partida (premisas marcadas)

- `HEAD` en `1c2babe`, `origin/main` en `2eb0483` (seis commits sin push: cuatro de `20261111_modal_simbologia_sin_directorio` y dos del ORIGEN), rama `main` (fuente: `git rev-parse --short HEAD` y el reporte del ORIGEN, sesión redactora). Se mide en H1.
- Antes del depósito, el árbol tiene exactamente las tres ediciones heredadas sin commit, ` M 30_procesamiento/31_leer_normalizar.R`, ` M 30_procesamiento/33_motor_template.html` y ` M 30_procesamiento/34_historico_pct_adecuado_costa_central.R`, con `git diff --numstat` `1	1` en cada una y md5 `40e250a046b855abe98eead84664482b`, `d59e4e3ed75d00968b9e905c54eb66bc` y `0bcc8b665d24fe5497c9adf8ac98695e` (fuente: `git status --porcelain`, `git diff --numstat` y `md5sum` sobre el clon de la estación, por el puente de solo lectura, sesión redactora). Después del depósito suma 1 línea `??` (el encargo); con el log, 5 líneas. Se mide en FASE 0.
- En el motor construido, el pie es una cadena de JavaScript: `command grep -c -F 'base de la Agencia"'` da `1` y `command grep -c -F 'directorio oficial MINEDUC"'` da `0` sobre el `40_salidas/motor_comparacion.html` que dejó la FASE R del ORIGEN; sobre `docs/index.html` (lo publicado) dan `0` y `1` (fuente: esos `grep` sobre el clon de la estación, sesión redactora; log del ORIGEN, diagnóstico de T1).
- Las tres ediciones heredadas son las de §5 T1 del ORIGEN: el pie de D36-15 en la plantilla, el comentario de `31_leer_normalizar.R` y «17 columnas» en `34_historico_pct_adecuado_costa_central.R` (fuente: log del ORIGEN, R-10, R-11 y R-13, que contaron las tres líneas agregadas completas). Ninguna prueba de `33_verificar_motor.R` cita el pie (fuente: log del ORIGEN, nota (a)).
- `docs/index.html` md5 `6017a43e10068dacbf998ff69fcca0b3` y `docs/trayectorias.html` md5 `e0681b9e486428a6ab3cc38e2c531cfc` (publicados en `338e64f`); el `40_salidas/trayectorias_traspasos.html` del último build tiene el mismo md5 que su copia publicada (fuente: `md5sum` sobre el clon de la estación, sesión redactora). Por eso T2 espera cambio solo en `docs/index.html` (hipótesis: el build no cambia la vista; se mide en FASE 0 con `cmp`). `36_*` no usa la fecha del sistema (fuente: auditoría de redacción, ronda 1).
- Con las tres ediciones, las baterías dieron VMOTOR 12/12, VTRAY 35/35 y M12 `casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado`, y la sonda de cifras `igual TRUE` contra la línea base (fuente: log del ORIGEN, T1 y FASE R). Se miden en FASE 0.
- Texto aprobado por el titular para el pie (D36-15): `Fuente: Agencia de Calidad de la Educación, bases por establecimiento; nombres: directorio oficial MINEDUC o, para establecimientos que ya no figuran en él, base de la Agencia` (fuente: mensaje del titular en la sesión redactora, «aprobado»).

## 2. Decisiones

| Id | Decisión | Fuente |
|---|---|---|
| D36-15 | El pie del modal cita también la base de la Agencia como fuente de nombres, con el texto de §1 | titular, sobre propuesta de la sesión redactora (duda del log de `20261111_modal_simbologia_sin_directorio`) |
| D36-16 | Se publica en `docs/` el motor con D36-13 y D36-15, con el procedimiento de `publicacion_github_pages.md`; el push lo hace el titular | titular, sobre propuesta de la sesión redactora |

## 3. Invariantes (🔒)

| 🔒 | Qué y por qué | Comando | Esperado |
|---|---|---|---|
| 1 | Lo publicado es lo construido y probado en T1: `docs/` es copia byte a byte de las salidas que T1 guardó tras sus pruebas (estables frente a builds posteriores) | `bash -c 'cmp -s docs/index.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html" && cmp -s docs/trayectorias.html "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html" && echo identicos \|\| echo distintos'` | `identicos` (en T2 paso 2, antes de su commit, y en FASE R y FASE L); en FASE R y FASE L, con T1 o T2 sin commit, `no_medible` (no se publicó) |
| 2 | Sin atribución: regla del titular (SETTINGS §1.2.6) | `<ATRIB>` | `0 0` |
| 3 | Solo cambian los archivos de T1 y T2, el expediente y el índice: el encargo no se sale de su meta | `bash -c 'git -c core.quotePath=false diff --name-only 1c2babe HEAD \| command grep -v "^50_documentacion/encargos/" \| LC_ALL=C sort \| paste -sd " " -'` | completo: `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R docs/index.html` (más `docs/trayectorias.html` si cambió, dato de T2); con T2 sin commit, las 3 de T1; con T1 sin commit o tras la detención 1, vacío |
| 4 | Sin cargas por red ni datos en lo publicado: gobernanza de `publicacion_github_pages.md` | `<RED>`; `bash -c 'git status --porcelain -- 20_insumos \| wc -l \| tr -d " "'` | `0 0 0 0`; `0` |

**Nota:** los comandos de esta tabla llevan `\|` por la tabla; al
transcribirlos, `\|` es `|`.

## 4. FASE 0

0. **Testigo:**
   `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36q\n" > "${TMPDIR:-${TEMP:?}}/simce_s36q_testigo.txt" && echo raiz_ok'`
   → `dato:` (esperado `raiz_ok`). **Rutas** (a la terminal):
   `bash -c 'cygpath -w "$(pwd)"; cygpath -w "${TMPDIR:-${TEMP:?}}"; cygpath -w "${HERRAMIENTAS_DEV_PATH:-sin_kit}"'`.
   Lectura, edición (`testigo s36q` → `testigo s36q editado`) y escritura
   (`<TMP>/simce_s36q_lecturas.txt`).
1. Crea `<EXP>/50_log.md` con la herramienta de escritura: la ficha de
   `<PROT>` §4.4 (nace con
   `expediente: 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision`,
   `repo: slep_simce_adecuado`, `origen: 50_documentacion/encargos/202611/20261111_pie_y_publicacion` y `push: "no"`), el título
   `# Log · pie_y_publicacion_reemision`, el encabezado de `<PROT>` §4, el slot
   `## J. Juicio` con `(lo rellena FASE L)`, `## Registro por fase`, `inicio`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`) y
   `### FASE 0: log, punto de retorno y línea base`.
2. Mide, con su `esperado:` antes:
   - **H1:** `bash -c 'basename "$(git remote get-url origin)" .git'`
     esperado `slep_simce_adecuado`; `git rev-parse --short HEAD` esperado
     `1c2babe`; `git rev-parse --short origin/main` esperado `2eb0483`;
     `git symbolic-ref --short HEAD` esperado `main`;
     `bash -c 'git stash list | wc -l | tr -d " "'` y
     `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'` esperados `0`.
   - **Árbol:**
     `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`,
     esperado exactamente:
     ```text
      M 30_procesamiento/31_leer_normalizar.R
      M 30_procesamiento/33_motor_template.html
      M 30_procesamiento/34_historico_pct_adecuado_costa_central.R
     ?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md
     ?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md
     ```
     (cada línea ` M` empieza con un espacio; el archivo de esperados del
     `diff`, si se usa, lo conserva).
   - **H2:** `<MD5 <SONDA_IGUAL>>` esperado `d30362ed33555966894685414e36a06f`;
     `<MD5>` de las tres ediciones heredadas, esperados los de §1;
     `bash -c 'git diff --numstat -- 30_procesamiento | LC_ALL=C sort -k3'`
     esperado las tres líneas `1	1` de §5 T1; `<MD5 docs/index.html>` esperado
     `6017a43e10068dacbf998ff69fcca0b3`; `<MD5 docs/trayectorias.html>`
     esperado `e0681b9e486428a6ab3cc38e2c531cfc`; la disponibilidad del
     validador
     (`bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`)
     va como `dato:` (no detiene).
   - **Línea base:** `<BUILD f0>` `rc 0`; `<TAGREG f0>` `rc 0` y
     `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`; `<VMOTOR f0>`
     `rc 0` y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (seguido de la
     duración, que no se compara); `<M12 f0>`
     `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado`;
     `<VTRAY f0>` `rc 0` y `Resultado: 35 pruebas, 35 pasan, 0 fallan`;
     `bash -c 'cmp -s 40_salidas/trayectorias_traspasos.html docs/trayectorias.html; echo "cmp $?"'`
     esperado `cmp 0` (la vista no cambia; si da `cmp 1`, va como `dato:` y
     T2 espera también `docs/trayectorias.html`). Antes de seguir, copia el
     motor de la línea base:
     `bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_f0.html"; echo $?'`
     esperado `0`.
3. `<MD5 <EXP>/50_encargo.md>` → `encargo_md5`; el anexo de auditoría a la
   clave `auditoria_redaccion`.
4. Con su `esperado:` antes: `git add --` del encargo; `<STAGED>` igual a
   esa ruta;
   `git commit -m "docs(encargo): pie_y_publicacion_reemision" -- 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md`;
   `hash_inicial`; `<ARBOL>` esperado `3` (las tres ediciones heredadas,
   que commitea T1).
5. Cierra la sección.

## 5. Tareas

### Forma común

Cada tarea escribe en el log su sección `### FASE Tn: <título>` (también una
tarea no ejecutada, con su `Estado:`), con sus `esperado:` antes de correr el
primer comando (los del commit incluidos); su paso 0 es
`bash -c 'git status --porcelain -- <archivos de su ALCANCE> | wc -l | tr -d " "'`
esperado `3` en T1 (las ediciones heredadas) y `0` en T2; T1 no edita y T2
copia con `cp`; corre sus pruebas, mide `<PRECOMMIT>` (esperado: exactamente
los archivos de su ALCANCE que cambió; en T1, las tres ediciones heredadas), comprueba `<MD5 <EXP>/50_encargo.md>`
igual a `encargo_md5`, hace `git add --` de esos archivos, `<STAGED>` igual a
ellos, el commit con rutas explícitas y `<ARBOL>` esperado `0`. Cierra con la
plantilla de sección de `<PROT>` §4.1.

### T1 · Verificar y commitear las ediciones heredadas

1. No se edita nada: las tres ediciones son las que dejó el ORIGEN (§1).
2. Pruebas, con su `esperado:` antes:
   `bash -c 'command grep -c "base de la Agencia</span>" 30_procesamiento/33_motor_template.html; command grep -c "nombres: directorio oficial MINEDUC</span>" 30_procesamiento/33_motor_template.html'`
   esperado `1` y `0`; `bash -c 'git diff --numstat -- 30_procesamiento | LC_ALL=C sort -k3'`
   esperado exactamente
   ```text
   1	1	30_procesamiento/31_leer_normalizar.R
   1	1	30_procesamiento/33_motor_template.html
   1	1	30_procesamiento/34_historico_pct_adecuado_costa_central.R
   ```
   `<BUILD T1>` `rc 0`; `<VMOTOR T1>` `rc 0` y
   `Resultado: 12 pruebas, 12 pasan, 0 fallan`; `<M12 T1>` igual a
   `<M12 f0>`; `<VTRAY T1>` `rc 0` y `Resultado: 35 pruebas, 35 pasan, 0 fallan`;
   `bash -c 'command grep -c -F "# Extrae las columnas base (rbd, nom_rbd, comuna y GSE)" 30_procesamiento/31_leer_normalizar.R; command grep -c -F "(17 columnas, ver" 30_procesamiento/34_historico_pct_adecuado_costa_central.R'`
   esperado `1` y `1`;
   `bash -c 'command grep -c -F "base de la Agencia\"" 40_salidas/motor_comparacion.html; command grep -c -F "directorio oficial MINEDUC\"" 40_salidas/motor_comparacion.html'`
   esperado `1` y `0` (el motor construido trae el pie nuevo como cadena de
   JavaScript, y no el anterior); y las cifras no cambian:
   `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_f0.html" 40_salidas/motor_comparacion.html 2>&1 | tr -d "\r" | command grep -E "^igual "'`
   esperado `igual TRUE`. Con todo en PASA, guarda las salidas probadas:
   `bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html"; echo $?; cp 40_salidas/trayectorias_traspasos.html "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html"; echo $?'`
   esperado `0` y `0`.
3. Commit: `git commit -m "fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15)" -- 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`.

### T2 · Publicación en `docs/`

El procedimiento de `publicacion_github_pages.md` (fuente: lectura de sus
pasos 1 a 6, sesión redactora), sobre lo que T1 construyó y probó, sin
reconstruir (sus pasos 1 y 2, build y baterías, los cubre T1; el paso 6,
push, es del titular): paso 1 de T2 = su paso 3 (copia); paso 2 = su paso 4
(`<RED>`, equivalente a sus dos `grep`, con un patrón que también cubre
`src=` sin comillas) y su paso 5 (status); paso 3 = commit. Regresión: T2 no
toca código.

1. `bash -c 'cp "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html" docs/index.html; echo $?; cp "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html" docs/trayectorias.html; echo $?'`
   esperado `0` y `0`.
2. Verificación, con su `esperado:` antes: 🔒1 `identicos`; `<RED>`
   `0 0 0 0`;
   `bash -c 'git -c core.quotePath=false status --porcelain -- docs | cut -c4- | LC_ALL=C sort | paste -sd " " -'`
   esperado `docs/index.html`, más `docs/trayectorias.html` solo si FASE 0
   midió `cmp 1` para la vista; `<MD5 docs/index.html>` distinto de
   `6017a43e10068dacbf998ff69fcca0b3`.
3. Commit: `git add --` de las rutas de `docs/` que cambiaron; `<STAGED>`
   igual a ellas;
   `git commit -m "deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio" -- <esas rutas>`;
   `<ARBOL>` esperado `0`.

## 6. FASE R

Los diez pasos de `<PROT>` §2.7:

1. **Inventario** de afirmaciones auditables desde el log, numerado
   `R-01`..., en `<A>/50_R_inventario.txt` y en el log antes de auditar.
2. **Regresión y re-derivación.** Primero la regresión, con sus esperados:
   `<BUILD r>`, `<TAGREG r>`, `<VMOTOR r>`, `<M12 r>`, `<VTRAY r>` (los de
   T1); y, con T2 commiteada, que lo publicado sigue siendo igual a lo que
   construye FASE R, sin el catálogo ni la fecha:
   `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R docs/index.html 40_salidas/motor_comparacion.html 2>&1 | tr -d "\r" | command grep -E "^igual "'`
   esperado `igual TRUE`. Después, la re-derivación con otro comando: los
   md5 con `Rscript -e "cat(unname(tools::md5sum(\"<ruta>\")))"` de
   `docs/index.html` (igual al de `<MD5 "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html">`,
   que se toma con `md5sum` porque R en Windows no resuelve la ruta de
   `<TMP>` de Git Bash; con T1 o T2 sin commit, `no_medible`), del encargo
   (igual a `encargo_md5`) y de `<SONDA_IGUAL>` (igual a
   `d30362ed33555966894685414e36a06f`); el pie, sobre lo commiteado, con
   `git grep -c "base de la Agencia</span>" HEAD -- 30_procesamiento/33_motor_template.html`
   (la plantilla, que sí lleva el marcado; esperado
   `HEAD:30_procesamiento/33_motor_template.html:1`; con T1 sin commit, sin
   salida) y
   `git grep -c -F "base de la Agencia\"" HEAD -- docs/index.html`
   (lo publicado, transpilado; esperado `HEAD:docs/index.html:1`; con T2 sin
   commit, sin salida);
   el diff de T1 con `git show --numstat --format= <commit de T1>` (esperado
   las tres líneas `1	1` de §5 T1).
3. **Invariantes:** el comando de cada 🔒 (§3), PASA/FALLA con salida literal.
4. **Alcance global:** 🔒3;
   `bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v -e "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md$" -e "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/anexos/" | wc -l | tr -d " "'`
   esperado `0`, o el número de rutas declaradas `- pendiente:` (T1
   congelada: 3; T2 congelada: las de `docs/` copiadas); md5 del encargo
   igual a `encargo_md5`, o BLOQUEA.
5. **Regresión completa:** la del paso 2 (no se repite).
6. **Control positivo**, con su esperado escrito antes:
   `bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R docs/index.html 40_salidas/motor_comparacion.html plantar 2>&1 | tr -d "\r" | command grep -E "^igual "'`
   esperado `igual FALSE`; y
   `bash -c 'git diff --quiet 1c2babe -- docs/index.html; echo "diff $?"'`
   esperado `diff 1` (lo publicado difiere de lo de antes de este encargo;
   el motor de FASE 0 ya trae las ediciones heredadas y no sirve de
   control); con T2 sin commit, `no_medible`.
7. **Veredicto por hallazgo:** BLOQUEA (gobernanza, 🔒 en FALLA, alcance
   violado, datos alterados, historia divergente: no se repara, se registra
   con pregunta cerrada), REPARA (defecto propio dentro del ALCANCE),
   ADVIERTE (sin efecto sobre la meta). Sin hallazgos: «0 hallazgos» junto
   con el control positivo del paso 6.
8. **Ciclo de reparación:** como máximo 1. Por cada REPARA: (a) causa raíz
   en una línea; (b) arreglo quirúrgico dentro del ALCANCE, en el orden de
   §0.2 punto 3; (c) re-verificación con el mismo chequeo que lo detectó y
   con uno distinto; (d) regresión: los pasos 2 a 4; (e) commit
   `fix(auditoria): R-NN <hallazgo>`; (f) su fila en la tabla del paso 10.
   Lo que sobreviva queda como duda.
9. **Prohibiciones:** ajustar un criterio, una tolerancia o un esperado para
   que pase; ampliar un ALCANCE; tocar un 🔒; editar evidencia ya escrita.
10. **Salida:** la tabla
    `id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
    y el veredicto global (`APROBADO`, `APROBADO CON ADVERTENCIAS`,
    `OBSERVADO` o `BLOQUEADO`), que va al bloque J.

## 7. FASE L

Los pasos de `<PROT>` §2.8:

1. `<ARBOL>`, esperado `0` (salvo el residuo declarado).
2. `## Cierre` con los trece puntos de `<PROT>` §4.2. Lo escrito después de
   medir lleva `(escrito después: FASE L)`. Las mediciones de los pasos 1, 5
   y 6 van a `## Cierre` como pares `esperado:`/`obtenido:`; las del paso 8
   van solo al reporte. El punto 4 va con esta forma (fuente: validada con
   `rc 0` en los logs de `20261109_mapa_hashes` y
   `20261111_modal_simbologia_sin_directorio`):

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
5. `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md; echo "rc $?"'`
   esperado `rc 0` (un reintento). Si sigue en `rc 1`, da `rc 2`, falta el
   script o la variable: `ficha: no validada (<causa>)` en `## Cierre`, y se
   sigue.
6. `<PRIVACIDAD>`.
7. Forma del log, exento de pre-registro:
   `bash -c 'L=50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md; ls -l "$L" | cut -c1-10; wc -l < "$L"; head -1 "$L"; tail -c 1 "$L" | wc -l | tr -d " "; for p in "^### FASE" "^esperado:" "^- faltante: esperado de" "^obtenido:" "^## J"; do command grep -c "$p" "$L"; done | paste -sd " " -'`:
   `head -1` igual a `---`, salto de línea final `1`, `^### FASE` igual a 4
   (FASE 0, T1, T2, FASE R), `^## J` igual a 1 y paridad
   `esperado:` + faltantes = `obtenido:`.
8. `git add --` del log y de cada `<A>/50_*.txt` creado, por su nombre,
   nunca la carpeta ni un glob;
   `98_indexar_encargos.R --repo=. --escribir` y el índice si cambió;
   `<STAGED>`; `git commit -m "docs(log): pie_y_publicacion_reemision" -- <lista>`.
9. Estado de cierre.

## 8. Reporte final

- Primera línea: `ls -l` y `wc -l <` del log y el hash de `docs(log)`.
  Segundo bloque: el bloque J. Después: los commits, 🔒1 a 🔒4 medidos otra
  vez después de `docs(log)` y lo que falló o sorprendió (si nada, decirlo).
- Para el titular: el push (todos los commits desde `2eb0483`), que
  publica el motor; después, verificar la URL pública.
- Última línea, literal:

  ```text
  → Sesión redactora: lee completo `50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md` (commit docs(log) <hash>, <N> líneas) antes de evaluar. Este reporte es un resumen y no reemplaza al log.
  ```

## 9. Exclusiones

- El push y la verificación de la URL pública (titular).
- Otros textos del motor o de la vista.

## Anexo de auditoría de redacción
- Nivel: 2 (puntaje 3: C1 y C8)
- Rondas: 1 de 3 (reemisión: hereda las dos rondas del ORIGEN, conformidad y técnico separados más un revisor nuevo, 0 abiertos; esta ronda revisa el delta con un revisor independiente, más la medición directa en el clon de la estación de los patrones nuevos: `base de la Agencia"` 1 y `directorio oficial MINEDUC"` 0 en el motor construido, 0 y 1 en lo publicado)
- Decisiones de la sesión entregadas a los revisores: D36-15, D36-16, reemisión por R-14 del ORIGEN
- Ronda 1: BLOQUEA 0 · CORREGIR 3 · MENOR 2 (revisor independiente sobre el delta, con simulación de los comandos nuevos)
- Abiertos: BLOQUEA 0 · CORREGIR 0 · MENOR 0
- MENOR abiertos: ninguno
- Límite declarado: una sola ronda sobre el delta; el riesgo se acota a los patrones del pie (medidos) y al árbol heredado (medido en H2)
- Condición de la sesión: completa
