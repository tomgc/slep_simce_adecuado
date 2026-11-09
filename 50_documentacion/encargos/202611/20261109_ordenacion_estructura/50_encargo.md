# Encargo · Ordenación de estructura: excepciones de la raíz y `.gitkeep` de `traspasos/`

> Léelo completo, hasta el anexo de auditoría, antes de la llamada del
> testigo (§4 paso 0).

## 0. Encabezado de contrato

- **Fecha de depósito:** 2026-11-09 (fuente: fecha de la sesión redactora, `TZ=America/Santiago`).
- **Meta:** dejar el censo de estructura sin desvíos estructurales: instalar
  `50_documentacion/activa/50_excepciones_estructura.md` (tres filas de la
  regla `raiz`: `00_build.R`, `docs/` y `NOTICE`) y retirar
  `50_documentacion/traspasos/.gitkeep`. Un commit de contenido; **sin push**
  (lo hace el titular después, §8).
- **MODO:** autónomo, todo en este turno. **Subagentes: no se admiten.**
- **EJECUCIÓN:** esfuerzo `high`; orquestador: el modelo de la sesión;
  subagentes 0; total Opus del encargo 0. (Una sola tarea: una copia y un
  retiro.)
- **AUDITORÍA DE REDACCIÓN:** nivel 1 (puntaje 0: ningún criterio C1 a C8; solo documentación y un archivo vacío, sin cifras, sin código del pipeline, sin push, una tarea; el `git rm` retira un archivo versionado de 0 bytes, recuperable desde el historial, y no suma C4); anexo al final.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_ordenacion_estructura` · **ORIGEN:** `ninguno`.
  `<EXP>` es la ruta del expediente, `<A>` es `<EXP>/anexos` y el log es
  `<EXP>/50_log.md`. `<PROT>` es
  `$HERRAMIENTAS_DEV_PATH/prompts/encargo_autonomo_claude_code_v1.md` (v1.11);
  la ficha del log es su §4.4. `<TMP>` es `${TMPDIR:-${TEMP:?}}`.
  `<CENSO>` es `$HERRAMIENTAS_DEV_PATH/plantillas/95_censar_estructura.R`.
- **ENTORNO:** Claude Code en la estación Windows del titular
  (`estacion_windows`), Git Bash, lanzado en la raíz de `slep_simce_adecuado`.
  **Presencia del titular:** presente de punta a punta; sin FASE −1. **Red:**
  ninguna; ningún `fetch`, `pull` ni `push`. Todo
  comando de más de una línea va a un archivo `<TMP>/simce_s36o_<qué>.sh`
  escrito con la herramienta de escritura, terminado en salto de línea,
  normalizado con `sed -i "s/\r$//" <archivo>` y corrido con `bash <archivo>`;
  nunca un heredoc. Todo `grep` va como `command grep`. Los comandos de §0.0
  se transcriben tal cual desde sus bloques. El log nombra las rutas de
  `<TMP>` como `"${TMPDIR:-${TEMP:?}}/simce_s36o_<qué>"`.
- **INSUMOS:** el árbol del repo en `HEAD` `3c108fc` (§1), el insumo de `<A>`
  (§4bis), que es el contenido completo de su destino, y `<CENSO>` del kit
  (solo se ejecuta). Nada más.
- **POSICIÓN:** todo comando desde la raíz del repo. R corre solo en
  `<CENSOEC f>` y `<CENSODET>` (FASE 0, T1 y FASE R) y en FASE L, siempre con
  `Rscript --no-init-file` sobre instrumentos del kit.
- **Conteos:** `| tr -d ' '` en toda comparación numérica; `grep -c` con 0
  coincidencias imprime `0` y sale con `1`, que no es falla. `<MD5 ruta>` es
  `bash -c 'md5sum "<ruta>" | cut -d" " -f1'`. Una medición sin esperado va
  como línea `dato:`.
- **ALCANCE:** en toda fase, `<TMP>` (prefijo `simce_s36o_`), `.git/` y
  `<A>/50_<fase>_<qué>.txt`. **FASE 0:** el log. **T1:**
  `50_documentacion/activa/50_excepciones_estructura.md` (nuevo) y
  `50_documentacion/traspasos/.gitkeep` (se retira). **FASE R:** el log y
  `<A>/50_R_inventario.txt`. **FASE L:** el log, los `<A>/50_*.txt` que el
  encargo crea y `50_documentacion/encargos/50_indice_encargos.md` (tras la
  detención 1, además el encargo y el insumo). `<EXP>/50_encargo.md` y el
  insumo no se editan nunca.
- **PRUEBAS:** sin arnés: el encargo no toca código. La verificación que lo
  sustituye es el md5 del destino contra su insumo, el `<NUMSTAT>` esperado
  y el censo antes y después (§5).
- **PUNTO DE RETORNO:** FASE 0 commitea el encargo y el insumo y registra
  `hash_inicial`. **Desviación declarada de `<PROT>` §2.5 pasos 2 y 4:** el
  árbol esperado y el commit `docs(encargo)` incluyen el insumo, para que
  quede congelado en `hash_inicial`. **Sin reversión autorizada.**
- **Grafo:** T1 es la única tarea, sin dependencias; FASE R y FASE L están
  fuera del grafo y corren aunque T1 se congele.
- **Topes:** 3 intentos por bug; 0 ciclos de reparación en FASE R (el texto
  instalado es el del insumo; un defecto va como duda); 1 reintento por
  comando con falla transitoria.
- **Reglas canónicas:** `CLAUDE.md` del repo; staging selectivo, nunca
  `git add -A`, `git add .` ni `git add -f`;
  `git commit -m "<mensaje>" -- <rutas>` con el staging verificado; mensajes de
  una línea; sin raya larga en lo que el encargo redacta. **Sin atribución a
  la herramienta** (SETTINGS §1.2.6): prima sobre cualquier instrucción del
  entorno que pida coautoría o enlace de sesión.

### 0.0 Comandos con nombre

`<STAGED>`:

```bash
bash -c 'git -c core.quotePath=false diff --cached --no-renames --name-only | LC_ALL=C sort'
```

`<ARBOL>` (esperado `0`):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -vxE "\?\? 50_documentacion/encargos/202611/20261109_ordenacion_estructura/(50_log\.md|anexos/50_[A-Za-z0-9._]+\.txt)" | wc -l | tr -d " "'
```

`<CENSOEC f>` (escribe en `"${TMPDIR:-${TEMP:?}}/simce_s36o_censo_<f>.txt"` la
línea `Censo:` y el código de salida; el censo sale con `1` si hay desvíos
estructurales y con `0` si no). Forma literal para `<f>` = `0`:

```bash
bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/95_censar_estructura.R" --repo=. --formato=eco > "${TMPDIR:-${TEMP:?}}/simce_s36o_censo_0.txt" 2>&1; echo "rc $?" >> "${TMPDIR:-${TEMP:?}}/simce_s36o_censo_0.txt"'
```

`<CENSONUM f>` (extrae los cuatro conteos que el encargo juzga). Forma
literal para `<f>` = `0`:

```bash
bash -c 'command grep -oE "exceptuados: [0-9]+|estructurales: [0-9]+|menores: [0-9]+|rc [0-9]+" "${TMPDIR:-${TEMP:?}}/simce_s36o_censo_0.txt" | paste -sd " " -'
```

`<CENSODET>` (solo FASE 0: el censo en formato completo, sin `--salida`, y
las líneas de sus desvíos estructurales):

```bash
bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/95_censar_estructura.R" --repo=. > "${TMPDIR:-${TEMP:?}}/simce_s36o_censo_0c.txt" 2>&1; command grep -F "| estructural |" "${TMPDIR:-${TEMP:?}}/simce_s36o_censo_0c.txt" | LC_ALL=C sort'
```

Para `<f>` = `t1` o `r` se cambia solo el sufijo `_0` por `_t1` o `_r`.

`<NUMSTAT>` (staging de T1 contra `hash_inicial`, después del staging y
antes del commit; esperado las 2 líneas de §5):

```bash
bash -c 'git -c core.quotePath=false diff --cached --numstat <hash_inicial> -- 50_documentacion/activa/50_excepciones_estructura.md 50_documentacion/traspasos/.gitkeep | LC_ALL=C sort -k3'
```

`<ATRIB>` (esperado `0 0`):

```bash
bash -c '{ git log --format=%B 3c108fc..HEAD | awk -v p="^[[:space:]]*(co-authored-by:.*(claude|anthropic)|claude-session:|(🤖[[:space:]]*)?generated with .?claude)" "tolower(\$0) ~ p" | wc -l | tr -d " "; git log --format="%ae%n%ce%n%an%n%cn" 3c108fc..HEAD | command grep -ciE "anthropic|claude"; } | paste -sd " " -'
```

`<PRIVACIDAD>` (esperado `rc 1` dos veces):

```bash
bash -c 'F="50_documentacion/encargos/202611/20261109_ordenacion_estructura/50_log.md $(ls 50_documentacion/encargos/202611/20261109_ordenacion_estructura/anexos/50_*.txt | command grep -v /50_insumo_)"; command grep -nE "/[U]sers/|/[h]ome/|[A-Za-z]:[\\/][U]sers|/c/[U]sers|[~]/|$(printf "\342\200\224")" $F; echo "rc $?"; command grep -nE "[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]" $F; echo "rc $?"'
```

### 0.1 Regla de detención

1. **FASE 0:** el testigo, H1, el árbol, un md5 de H2 o el censo de partida
   distintos de lo esperado → detén la sesión sin `docs(encargo)`. Con log,
   T1 y FASE R escriben su sección (`### FASE T1: excepciones y retiro del .gitkeep`
   con `Estado: no ejecutada (detención 1)` y `### FASE R: auditoría` con
   `Estado: omitida (detención 1)`; el conteo de FASE L sigue en 3; 🔒3 va
   `no_medible`; 🔒1 espera salida vacía; el `<ARBOL>` de FASE L paso 1 espera
   `1`, el encargo sin versionar, y vuelve a `0` después de `docs(log)`) y
   FASE L cierra con `hash_inicial: no_medible` y `hash_final` `3c108fc`; su
   `docs(log)` versiona además el encargo y el insumo.
2. **T1:** el md5 del destino distinto del insumo después de copiar,
   `<NUMSTAT>` distinto de lo esperado o el censo de T1 distinto de lo
   esperado → T1 se congela sin commit; el staging y el árbol quedan como
   están, se declaran como `- pendiente:` y FASE L no los toma. Esperados
   alternativos desde ahí: `<ARBOL>` igual al número de líneas de T1 que
   quedaron (`2` con `A` y `D`; `1` con solo `D` si se congeló antes del
   `git add`), también después de `docs(log)`; el `<STAGED>` de FASE L
   paso 8 igual a su lista más esas rutas de T1 (el commit con rutas
   explícitas las deja fuera); 🔒1 vacío; el censo de FASE R `no_medible`.
3. **Residual:** cualquier estado, conteo o resultado no enumerado → congela
   la tarea en curso, se registra como duda y se sigue con FASE R y FASE L.
4. **Denegación** de un comando autorizado → `- friccion:` con la cita
   literal, sin reintentar por otra vía; congela la tarea en curso.
5. `<MD5 <EXP>/50_encargo.md>` distinto de `encargo_md5` al cerrar T1 →
   congela T1.

### 0.2 Autorizaciones (lista cerrada)

0. Toda fase: comandos de solo lectura (`git status`, `git diff`, `git log`,
   `git show`, `git rev-parse`, `git symbolic-ref`, `git remote get-url`,
   `git ls-files`, `git grep`, `git stash list`, `command grep`, `diff`,
   `sort`, `cut`, `awk`, `tr`, `paste`, `sed -n`, `wc`, `ls`, `test`, `head`,
   `tail`, `date`, `md5sum`, `cygpath`, `basename`, `git hash-object` sin
   `-w`), los de §0.0 (`<CENSOEC f>`, `<CENSONUM f>` y `<CENSODET>`); escribir en `<TMP>` archivos
   `simce_s36o_*`, `sed -i` sobre ellos y `cp` del insumo a
   `<TMP>/simce_s36o_*` (FASE R paso 6).
1. FASE 0: crear el log; el commit `docs(encargo): ordenacion_estructura` del
   encargo y el insumo.
2. T1: la copia de §5 con `cp`, `git rm -q -- 50_documentacion/traspasos/.gitkeep`,
   `git add -- 50_documentacion/activa/50_excepciones_estructura.md` y el
   commit de §5.
3. FASE L: `98_indexar_encargos.R` con `--validar` (más un reintento) y con
   `--escribir`, y el commit `docs(log): ordenacion_estructura`.

Nada más. En particular: ningún `fetch`, `pull`, `push`, `--force`, `--no-verify`,
`rm` de la shell, `git rm` distinto del de T1, `revert`, `reset`, `restore`,
`checkout --`, `stash` (salvo `git stash list`), `commit --amend` ni
`git config` que escriba; ninguna edición con la herramienta de edición del
destino de T1 (su contenido llega solo por `cp` desde el insumo); ningún
`--salida` de `<CENSO>` (escribiría un archivo); ninguna escritura fuera de
los ALCANCE; ni la memoria de la herramienta.

### 0.3 Contrato de arranque (`<PROT>` §2.1 punto 8)

- **Lecturas previas:** antes del testigo se admite leer este encargo (no se
  lista), el insumo, `CLAUDE.md` y `<CENSO>`, y comandos de solo lectura; se
  listan después del testigo en `<TMP>/simce_s36o_lecturas.txt` y van como
  `dato:` a FASE 0, donde FASE R las juzga ADVIERTE.
- **Llamadas:** se nombran por lo que hacen. **Directorio:** la llamada del
  testigo comprueba la raíz; la siguiente imprime a la terminal, nunca al log,
  `cygpath -w` de la raíz, de `<TMP>` y de `$HERRAMIENTAS_DEV_PATH`.
- **Pre-registro:** testigo y rutas van como `dato:` con
  `(escrito después: paso 0)`; desde FASE 0 paso 1, todo `esperado:` va antes
  de su comando.
- **Testigo:** primera escritura `<TMP>/simce_s36o_testigo.txt` desde la
  shell; luego lectura, edición y escritura con las herramientas sobre el
  testigo y `<TMP>/simce_s36o_lecturas.txt`.
- **Memoria y búsquedas:** sin leer ni escribir la memoria; búsquedas con
  `git grep`. La carga automática de `CLAUDE.md` y la memoria es del arnés.
- **Aprobaciones:** los diálogos aprobados no son observables
  (`intervenciones_humanas` registra solo denegaciones y mensajes del
  titular; lo demás, `no_medible`).

## 1. Estado de partida (premisas marcadas)

- `HEAD` y `origin/main` en `3c108fc`, rama `main`, árbol limpio antes del depósito (fuente: `git rev-parse --short HEAD`, `git rev-parse --short origin/main` y `git status --porcelain | wc -l` = 0 en la estación, sesión redactora). Se mide en H1.
- Después del depósito, el árbol tiene las 2 líneas `??` del expediente (encargo e insumo); con el log, 3 (hipótesis, se mide en FASE 0).
- El censo da 5 desvíos estructurales: `00_build.R`, `NOTICE` y `docs/index.html` y `docs/trayectorias.html` por la regla `raiz`, y `50_documentacion/traspasos/.gitkeep` por la regla `traspaso_vigente` («archivo que no es traspaso en traspasos/»); 7 menores y 0 exceptuados (fuente: salida del censo que el titular pegó en la sesión redactora, y `95_censar_estructura.R` L309 leído en la sesión redactora). Se mide en FASE 0 con `<CENSONUM 0>` y `<CENSODET>`.
- La lista `raiz_archivos` del perfil `proyecto` del censo nombra `00_run_all.R` y `00_escanear_proyecto.R` pero no `00_build.R` ni `NOTICE`, y `raiz_dirs` no nombra `docs` (fuente: `95_censar_estructura.R` L108 a L111, md5 `e3d1a31fc655424b9646f258a2aeb4a9`, leído en la sesión redactora). POLITICA §2 admite varios `00_*` en la raíz (fuente: `POLITICA_PROYECTO.md` v6.1 §2, leído en la sesión redactora).
- Una fila de excepción calza por ruta exacta o por prefijo terminado en `/`, y por regla (o `*`); las comillas invertidas de la tabla se descartan (fuente: `95_censar_estructura.R` L175 y L389 a L395, sesión redactora). Por eso la fila `docs/` exceptúa los dos archivos de `docs/`.
- `50_documentacion/traspasos/.gitkeep` pesa 0 bytes y la carpeta tiene además `traspaso_cierre_v35.md` y `archivo/` (fuente: `wc -c` y `ls` en la estación, sesión redactora); ningún archivo versionado lo cita (fuente: `git grep -n "traspasos/.gitkeep"` sin salida, sesión redactora).
- `50_documentacion/activa/50_excepciones_estructura.md` no existe y ningún archivo versionado lo cita (fuente: `test -e` = 1 y `git grep` sin salida, sesión redactora). Se mide en H2.

## 2. Decisiones

| Id | Decisión | Fuente |
|---|---|---|
| D36-8 | Los desvíos de la regla `raiz` (`00_build.R`, `docs/`, `NOTICE`) se declaran como excepciones, con su motivo, en vez de mover los archivos: el orquestador lo admite POLITICA §2, `docs/` lo exige GitHub Pages y `NOTICE` acompaña a `LICENSE` | titular, sobre propuesta de la sesión redactora |
| D36-9 | `50_documentacion/traspasos/.gitkeep` se retira con `git rm`: pesa 0 bytes y la carpeta ya tiene traspasos versionados, así que no hay contenido que archivar (POLITICA §1.5) | titular, sobre propuesta de la sesión redactora |
| D36-10 | Los 7 desvíos menores (`nomenclatura` en `10_utils/react-dom.production.min.js` y `prefijo_50` en seis archivos de `activa/`) quedan fuera: no activan la ordenación y renombrar los de `activa/` rompería las citas | titular, sobre propuesta de la sesión redactora |

## 3. Invariantes (🔒)

| 🔒 | Qué | Comando | Esperado |
|---|---|---|---|
| 1 | Solo cambian el destino, el `.gitkeep`, el expediente y el índice | `bash -c 'git -c core.quotePath=false diff --name-only 3c108fc HEAD \| command grep -v "^50_documentacion/encargos/" \| LC_ALL=C sort \| paste -sd " " -'` | `50_documentacion/activa/50_excepciones_estructura.md 50_documentacion/traspasos/.gitkeep` |
| 2 | Sin atribución | `<ATRIB>` | `0 0` |
| 3 | Encargo e insumo intactos | `bash -c 'git diff --name-only <hash_inicial> HEAD -- 50_documentacion/encargos/202611/20261109_ordenacion_estructura/50_encargo.md 50_documentacion/encargos/202611/20261109_ordenacion_estructura/anexos \| command grep -cE "50_insumo_\|50_encargo"'` | `0` |
| 4 | Nada de datos, código del pipeline ni publicación | `bash -c 'git diff --name-only 3c108fc HEAD -- 10_utils 20_insumos 30_procesamiento docs 00_build.R NOTICE \| wc -l \| tr -d " "'` | `0` |

**Nota:** los comandos de esta tabla llevan `\|` por la tabla; al
transcribirlos, `\|` es `|`.

## 4. FASE 0

0. **Testigo:**
   `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36o\n" > "${TMPDIR:-${TEMP:?}}/simce_s36o_testigo.txt" && echo raiz_ok'`
   → `dato:` (esperado `raiz_ok`). **Rutas** (a la terminal):
   `bash -c 'cygpath -w "$(pwd)"; cygpath -w "${TMPDIR:-${TEMP:?}}"; cygpath -w "${HERRAMIENTAS_DEV_PATH:-sin_kit}"'`.
   Lectura, edición (`testigo s36o` → `testigo s36o editado`) y escritura
   (`<TMP>/simce_s36o_lecturas.txt`).
1. Crea `<EXP>/50_log.md` con la ficha de `<PROT>` §4.4, el título
   `# Log · ordenacion_estructura`, el encabezado de `<PROT>` §4, el slot
   `## J. Juicio` con `(lo rellena FASE L)`, `## Registro por fase`, `inicio`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`) y
   `### FASE 0: log, punto de retorno e hipótesis`.
2. Mide, con su `esperado:` antes:
   - **H1:** `bash -c 'basename "$(git remote get-url origin)" .git'`
     esperado `slep_simce_adecuado`; `git rev-parse --short HEAD` y
     `git rev-parse --short origin/main` esperados `3c108fc`;
     `git symbolic-ref --short HEAD` esperado `main`;
     `bash -c 'git stash list | wc -l | tr -d " "'` y
     `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'` esperados `0`.
   - **Árbol:**
     `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`,
     esperado exactamente:
     ```text
     ?? 50_documentacion/encargos/202611/20261109_ordenacion_estructura/50_encargo.md
     ?? 50_documentacion/encargos/202611/20261109_ordenacion_estructura/50_log.md
     ?? 50_documentacion/encargos/202611/20261109_ordenacion_estructura/anexos/50_insumo_excepciones.md.txt
     ```
   - **H2:** `<MD5>` del insumo (esperado el de §4bis) y de `<CENSO>`
     (esperado `e3d1a31fc655424b9646f258a2aeb4a9`);
     `bash -c 'test -e 50_documentacion/activa/50_excepciones_estructura.md; echo $?'`
     esperado `1`;
     `bash -c 'wc -c < 50_documentacion/traspasos/.gitkeep | tr -d " "'`
     esperado `0`; y
     `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`
     esperado `0`.
   - **Censo de partida:** `<CENSOEC 0>`; `<CENSONUM 0>` esperado
     `exceptuados: 0 estructurales: 5 menores: 7 rc 1`, y la línea `Censo:`
     completa va como `dato:`. `<CENSODET>` esperado exactamente:
     ```text
     desvio | raiz | estructural | 00_build.R | archivo suelto en la raiz
     desvio | raiz | estructural | NOTICE | archivo suelto en la raiz
     desvio | raiz | estructural | docs/index.html | carpeta docs/ no canonica
     desvio | raiz | estructural | docs/trayectorias.html | carpeta docs/ no canonica
     desvio | traspaso_vigente | estructural | 50_documentacion/traspasos/.gitkeep | archivo que no es traspaso en traspasos/
     ```
3. `<MD5 <EXP>/50_encargo.md>` → `encargo_md5`; el anexo de auditoría a la
   clave `auditoria_redaccion`.
4. `git add --` del encargo y el insumo; `<STAGED>` igual a esas 2 rutas;
   `git commit -m "docs(encargo): ordenacion_estructura" -- <las 2 rutas>`;
   `hash_inicial`; `<ARBOL>` esperado `0`.
5. Cierra la sección.

## 4bis. Insumo

| Insumo de `<A>` | Destino | md5 |
|---|---|---|
| `50_insumo_excepciones.md.txt` | `50_documentacion/activa/50_excepciones_estructura.md` | `d956559cd4e80985bab369d48877caba` |

## 5. Tarea

### T1 · Excepciones y retiro del `.gitkeep`

En el log, su sección es `### FASE T1: excepciones y retiro del .gitkeep`;
la de FASE R, `### FASE R: auditoría`.

- Paso 0: `bash -c 'git status --porcelain -- 50_documentacion/activa 50_documentacion/traspasos | wc -l | tr -d " "'`, esperado `0`.
- Copia:
  `bash -c 'cp 50_documentacion/encargos/202611/20261109_ordenacion_estructura/anexos/50_insumo_excepciones.md.txt 50_documentacion/activa/50_excepciones_estructura.md; echo $?'`,
  esperado `0`.
- Retiro: `bash -c 'git rm -q -- 50_documentacion/traspasos/.gitkeep; echo $?'`,
  esperado `0`.
- Staging: `git add -- 50_documentacion/activa/50_excepciones_estructura.md`;
  `<STAGED>` esperado exactamente
  `50_documentacion/activa/50_excepciones_estructura.md` y
  `50_documentacion/traspasos/.gitkeep`.
- Verificación (antes del commit): `<MD5>` del destino igual al del insumo;
  `<NUMSTAT>` esperado exactamente (agregadas, borradas, ruta; fuente:
  `wc -l` del insumo = 12 y `wc -c` del `.gitkeep` = 0, sesión redactora):
  ```text
  12	0	50_documentacion/activa/50_excepciones_estructura.md
  0	0	50_documentacion/traspasos/.gitkeep
  ```
  y el censo con el staging: `<CENSOEC t1>`; `<CENSONUM t1>` esperado
  `exceptuados: 4 estructurales: 0 menores: 7 rc 0` (una fila de excepción
  sin uso daría `menores: 8`). La línea `Censo:` completa va como `dato:`.
  (El censo lee `git ls-files`, que incluye el staging; fuente:
  `95_censar_estructura.R` L33 y L222 a L224, sesión redactora.
  `exceptuados` cuenta archivos: `00_build.R`, `NOTICE` y los dos de
  `docs/`.)
- Alcance (antes del commit):
  `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261109_ordenacion_estructura/" | cut -c4- | LC_ALL=C sort | paste -sd " " -'`
  esperado
  `50_documentacion/activa/50_excepciones_estructura.md 50_documentacion/traspasos/.gitkeep`;
  `<MD5 <EXP>/50_encargo.md>` igual a `encargo_md5`.
- Commit: `git commit -m "chore(estructura): excepciones de la raiz y retiro de traspasos/.gitkeep" -- 50_documentacion/activa/50_excepciones_estructura.md 50_documentacion/traspasos/.gitkeep`;
  `<ARBOL>` esperado `0`.

## 6. FASE R

Los pasos de `<PROT>` §2.7, en forma breve: (1) inventario `R-01`... en
`<A>/50_R_inventario.txt` antes de auditar; (2) re-derivación con otro
comando (md5 con `git hash-object` del destino contra `git hash-object` del
insumo; el retiro con `git ls-files -- 50_documentacion/traspasos/.gitkeep`
sin salida; el censo otra vez con `<CENSOEC r>` y `<CENSONUM r>`, mismo esperado que T1); (3) 🔒1 a 🔒4 con su
comando; (4) alcance global y md5 del encargo; (5) sin arnés de pruebas
(declarado); (6) control positivo: `cp` del insumo a
`<TMP>/simce_s36o_plantado.txt`, agregarle una línea con la herramienta de
edición y comprobar que su md5 difiere del de §4bis; (7) veredicto por
hallazgo (BLOQUEA, REPARA, ADVIERTE); (8) 0 ciclos; (9) sin ajustar criterios
ni ALCANCE; (10) tabla
`id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
y veredicto global al bloque J.

## 7. FASE L

Los pasos de `<PROT>` §2.8: (1) `<ARBOL>`; (2) `## Cierre` con resumen,
commits, auditoría, invariantes, decisiones (§2), dudas, errores propios,
notas, «Calidad del encargo» y fricciones (lo medido después, marcado
`(escrito después: FASE L)`); (3) bloque J; (4) ficha sin `null`,
`push: "no"`; (5)
`bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261109_ordenacion_estructura/50_log.md; echo "rc $?"'`
esperado `rc 0` (un reintento); (6) `<PRIVACIDAD>`; (7) `^### FASE` igual a 3
(FASE 0, T1, FASE R) y paridad `esperado:`/`obtenido:`; (8) `git add --` del
log y los `<A>/50_*.txt` creados, `98_indexar_encargos.R --repo=. --escribir`
(mismo intérprete) y el índice si cambió, `<STAGED>`,
`git commit -m "docs(log): ordenacion_estructura" -- <lista>`; (9) estado de
cierre.

## 8. Reporte final

- `ls -l` y `wc -l <` del log, hash de `docs(log)`, el bloque J, los commits,
  la línea `Censo:` de FASE R y 🔒1 a 🔒4 medidos otra vez después de
  `docs(log)`.
- Para el titular: el push, que este encargo no hace.
- Última línea, literal:

  ```text
  → Sesión redactora: lee completo `50_documentacion/encargos/202611/20261109_ordenacion_estructura/50_log.md` (commit docs(log) <hash>, <N> líneas) antes de evaluar. Este reporte es un resumen y no reemplaza al log.
  ```

## 9. Exclusiones

- Los 7 desvíos menores (D36-10).
- La lista `raiz_archivos` del perfil `proyecto` de `<CENSO>`, que no admite
  el patrón `00_*` de POLITICA §2: se corrige en el kit, y entonces la fila
  `00_build.R` sale como `excepcion_sin_uso` y se retira.
- La línea `_archivo/` del `.gitignore` (POLITICA §1.5): no es un desvío del
  censo de hoy.

## Anexo de auditoría de redacción
- Nivel: 1 (puntaje 0: ningún criterio C1 a C8; el `git rm` de un archivo de 0 bytes no suma C4)
- Rondas: 1 de 3 (ronda 1: revisor combinado de conformidad y técnico, con simulación del censo, `<NUMSTAT>` y `<STAGED>` en un repo de prueba)
- Decisiones de la sesión entregadas a los revisores: aprobación de la propuesta de ordenación (D36-8 a D36-10), regla sin atribución, entorno Windows con Git Bash, sin push
- Ronda 1: BLOQUEA 0 · CORREGIR 4 · MENOR 7
- Abiertos: BLOQUEA 0 · CORREGIR 0 · MENOR 0
- MENOR abiertos: ninguno
- Límite declarado: la simulación corrió en Linux; la ruta de `10_locale.R`, `--repo=.` en Windows y los 7 desvíos menores reales se miden en la estación (FASE 0)
- Condición de la sesión: completa
