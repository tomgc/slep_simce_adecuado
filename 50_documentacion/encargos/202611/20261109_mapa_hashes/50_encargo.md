# Encargo · Mapa de hashes de las reescrituras del historial (regularización)

> Léelo completo, hasta el anexo de auditoría, antes de la llamada del
> testigo (§4 paso 0).

## 0. Encabezado de contrato

- **Fecha de depósito:** 2026-11-09 (fuente: fecha de la sesión redactora, `TZ=America/Santiago`).
- **Meta:** verificar y versionar `<MAPA>`, el mapa de hashes que
  `<PROT>` §2.1 (v1.11, «Reescritura de historial con mapa de hashes») exige
  para una reescritura de historial y que las dos reescrituras de `main`
  (2026-08-24 y 2026-11-04) no dejaron. Un commit de contenido; **sin push** (lo hace el titular después,
  §8). **Desviación declarada de `<PROT>` §2.1:** el mapa no nace en el
  expediente del encargo que reescribió (no hubo encargo), sino en este, que
  lo regulariza; sus columnas son las del protocolo. **Segunda desviación
  declarada, de `<PROT>` §2.8 paso 8:** FASE L versiona por nombre los
  `anexos/` que el encargo crea, no `<MAPA>`, que solo entra por el commit de
  T1 después de verificarse.
- **MODO:** autónomo, todo en este turno. **Subagentes: no se admiten.**
- **EJECUCIÓN:** esfuerzo `high`; orquestador: el modelo de la sesión;
  subagentes 0; total Opus del encargo 0. (Una sola tarea: verificar y
  commitear un archivo.)
- **AUDITORÍA DE REDACCIÓN:** nivel 1 (puntaje 0: ningún criterio C1 a C8; solo documentación del expediente, sin cifras del pipeline, sin código, sin push, una tarea); anexo al final.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_mapa_hashes` · **ORIGEN:** `ninguno`.
  `<EXP>` es la ruta del expediente, `<A>` es `<EXP>/anexos` y el log es
  `<EXP>/50_log.md`. `<MAPA>` es `<A>/50_mapa_hashes.md`. `<PROT>` es
  `$HERRAMIENTAS_DEV_PATH/prompts/encargo_autonomo_claude_code_v1.md` (v1.11);
  la ficha del log es su §4.4. `<TMP>` es `${TMPDIR:-${TEMP:?}}`.
- **ENTORNO:** Claude Code en la estación Windows del titular
  (`estacion_windows`), Git Bash, lanzado en la raíz de `slep_simce_adecuado`.
  **Presencia del titular:** presente de punta a punta; sin FASE −1. **Red:**
  ninguna; ningún `fetch`, `pull` ni `push`. Todo
  comando de más de una línea va a un archivo `<TMP>/simce_s36m_<qué>.sh`
  escrito con la herramienta de escritura, terminado en salto de línea,
  normalizado con `sed -i "s/\r$//" <archivo>` y corrido con `bash <archivo>`.
  **Nunca un heredoc, tampoco para anexar al log, y nunca `sed -i` sobre el
  log ni sobre archivos del repo:** el log se crea y se edita solo con las
  herramientas de escritura y edición (el log de
  `20261109_ordenacion_estructura` registra los dos tropiezos). Todo `grep`
  va como `command grep`. Los comandos de §0.0 se transcriben tal cual desde
  sus bloques; **en el log se citan por su nombre** (`<RESUELVE>`, no su
  texto), porque traen comillas invertidas. El log nombra las rutas de
  `<TMP>` como `"${TMPDIR:-${TEMP:?}}/simce_s36m_<qué>"`. **Fricción conocida:**
  `TZ=America/Santiago date -Iseconds` da `+00:00` en Git Bash (log de
  `20261109_ordenacion_estructura`); se registra tal cual como `dato:` y no
  como fricción nueva.
- **INSUMOS:** el árbol del repo en `HEAD` `7a43615` (§1) y `<MAPA>`, sin
  versionar, depositado por la sesión redactora como único archivo de
  `anexos/`. Nada más.
- **POSICIÓN:** todo comando desde la raíz del repo. R corre solo en FASE L,
  con `Rscript --no-init-file` sobre el indexador del kit.
- **Conteos:** `| tr -d ' '` en toda comparación numérica; `grep -c` con 0
  coincidencias imprime `0` y sale con `1`, que no es falla. `<MD5 ruta>` es
  `bash -c 'md5sum "<ruta>" | cut -d" " -f1'`. Una medición sin esperado va
  como línea `dato:`.
- **ALCANCE:** en toda fase, `<TMP>` (prefijo `simce_s36m_`), `.git/` y
  `<A>/50_<fase>_<qué>.txt`. **FASE 0:** el log. **T1:** ninguno además
  (versiona `<MAPA>` sin cambiarlo). **FASE R:** el log y
  `<A>/50_R_inventario.txt`. **FASE L:** el log, los `<A>/50_*.txt` que el
  encargo crea y `50_documentacion/encargos/50_indice_encargos.md` (tras la
  detención 1, además el encargo). `<EXP>/50_encargo.md` y
  `<MAPA>` no se editan nunca.
- **PRUEBAS:** sin arnés: el encargo no toca código. La verificación que lo
  sustituye es `<FILAS>`, `<RESUELVE>`, `<HUERFANOS>`, `<ASUNTOS>` y
  `<COBERTURA>` sobre `<MAPA>` (§5), con control positivo en FASE R.
- **PUNTO DE RETORNO:** FASE 0 commitea el encargo y registra
  `hash_inicial`. **Sin reversión autorizada.**
- **Grafo:** T1 es la única tarea, sin dependencias; FASE R y FASE L están
  fuera del grafo y corren aunque T1 se congele.
- **Topes:** 3 intentos por bug; 0 ciclos de reparación en FASE R (el mapa
  es el que redactó la sesión redactora; un defecto va como duda); 1
  reintento por comando con falla transitoria.
- **Reglas canónicas:** `CLAUDE.md` del repo; staging selectivo, nunca
  `git add -A`, `git add .` ni `git add -f`;
  `git commit -m "<mensaje>" -- <rutas>` con el staging verificado; mensajes de
  una línea; sin raya larga en lo que el encargo redacta (los asuntos de
  commit que `<MAPA>` transcribe tal como están en el historial quedan fuera
  de esta regla, y el log no los transcribe). **Sin atribución a la
  herramienta** (SETTINGS §1.2.6): prima sobre cualquier instrucción del
  entorno que pida coautoría o enlace de sesión.

### 0.0 Comandos con nombre

`<STAGED>`:

```bash
bash -c 'git -c core.quotePath=false diff --cached --no-renames --name-only | LC_ALL=C sort'
```

`<ARBOL>` (esperado `0`):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -vxE "\?\? 50_documentacion/encargos/202611/20261109_mapa_hashes/(50_log\.md|anexos/50_mapa_hashes\.md|anexos/50_R_[A-Za-z0-9._]+\.txt)" | wc -l | tr -d " "'
```

`<FILAS>` (filas de datos de las dos tablas de `<MAPA>`; esperado `284`,
277 de la tabla 1 y 7 de la tabla 2):

```bash
bash -c 'command grep -cE "^\| \`[0-9a-f]{7}\` \| \`[0-9a-f]{7}\` \| .+ \|$" 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md'
```

`<RESUELVE f>` (valores de `hash_nuevo` del archivo `<f>` que no son
ancestros de `HEAD`; esperado `0`). Forma literal con `<f>` = `<MAPA>`:

```bash
bash -c 'command grep -E "^\| \`" "$1" | cut -d"\`" -f4 | while read h; do git merge-base --is-ancestor "$h" HEAD 2>/dev/null || echo "$h"; done | wc -l | tr -d " "' _ 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md
```

`<HUERFANOS f>` (valores de `hash_anterior` del archivo `<f>` que son
ancestros de `HEAD`; esperado `0`: mide alcanzabilidad y no existencia,
porque un clon puede guardar objetos inalcanzables). Forma literal con
`<f>` = `<MAPA>`:

```bash
bash -c 'command grep -E "^\| \`" "$1" | cut -d"\`" -f2 | while read h; do git merge-base --is-ancestor "$h" HEAD 2>/dev/null && echo "$h"; done | wc -l | tr -d " "' _ 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md
```

`<COBERTURA>` (diferencias entre el conjunto de `hash_nuevo` de `<MAPA>` y
los commits de `d9a485f^..12ddf5b`, que son los reescritos el 2026-11-04;
esperado `0 277`: ninguna diferencia y 277 hashes distintos; la tabla 2 no
suma hashes nuevos porque los suyos están en la tabla 1):

```bash
bash -c 'command grep -E "^\| \`" 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md | cut -d"\`" -f4 | LC_ALL=C sort -u > "${TMPDIR:-${TEMP:?}}/simce_s36m_nuevos.txt"; git rev-list --abbrev-commit --abbrev=7 d9a485f^..12ddf5b | LC_ALL=C sort > "${TMPDIR:-${TEMP:?}}/simce_s36m_revlist.txt"; d=$(diff "${TMPDIR:-${TEMP:?}}/simce_s36m_nuevos.txt" "${TMPDIR:-${TEMP:?}}/simce_s36m_revlist.txt" | wc -l | tr -d " "); n=$(wc -l < "${TMPDIR:-${TEMP:?}}/simce_s36m_nuevos.txt" | tr -d " "); echo "$d $n"'
```

`<ASUNTOS>` (filas cuyo asunto no es el de su `hash_nuevo` en `HEAD`;
esperado `0`). Es un guion de varias líneas: va a
`<TMP>/simce_s36m_asuntos.sh` con este contenido exacto y se corre con
`bash "${TMPDIR:-${TEMP:?}}/simce_s36m_asuntos.sh" <archivo>`:

```bash
F="$1"
command grep -E '^\| `' "$F" | while IFS= read -r l; do
  h=$(printf '%s\n' "$l" | cut -d'`' -f4)
  a=$(printf '%s\n' "$l" | sed -E 's/^\| `[0-9a-f]{7}` \| `[0-9a-f]{7}` \| (.*) \|$/\1/')
  s=$(git log -1 --format=%s "$h" 2>/dev/null | tr '`' "'")
  test "$a" = "$s" || printf '%s\n' "$h"
done | wc -l | tr -d ' '
```

`<ATRIB>` (esperado `0 0`):

```bash
bash -c '{ git log --format=%B 7a43615..HEAD | awk -v p="^[[:space:]]*(co-authored-by:.*(claude|anthropic)|claude-session:|(🤖[[:space:]]*)?generated with .?claude)" "tolower(\$0) ~ p" | wc -l | tr -d " "; git log --format="%ae%n%ce%n%an%n%cn" 7a43615..HEAD | command grep -ciE "anthropic|claude"; } | paste -sd " " -'
```

`<PRIVACIDAD>` (esperado `rc 1` dos veces; excluye `<MAPA>`, que transcribe
asuntos con raya larga):

```bash
bash -c 'F="50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md $(ls 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_*.txt)"; command grep -nE "/[U]sers/|/[h]ome/|[A-Za-z]:[\\/][U]sers|/c/[U]sers|[~]/|$(printf "\342\200\224")" $F; echo "rc $?"; command grep -nE "[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]" $F; echo "rc $?"'
```

### 0.1 Regla de detención

1. **FASE 0:** el testigo, H1, el árbol o un valor de H2 distintos de lo
   esperado → detén la sesión sin `docs(encargo)`. Con log, T1 y FASE R
   escriben su sección (`### FASE T1: verificar y versionar el mapa` con
   `Estado: no ejecutada (detención 1)` y `### FASE R: auditoría` con
   `Estado: omitida (detención 1)`; el conteo de FASE L sigue en 3; 🔒1
   espera `0`; el `<ARBOL>` de FASE L paso 1 espera `1`, el encargo sin
   versionar, y vuelve a `0` después de `docs(log)`) y FASE L cierra con
   `hash_inicial: no_medible` y `hash_final` `7a43615`; su `docs(log)`
   versiona además el encargo, nunca `<MAPA>`, que queda como `- pendiente:`
   (sin versionar, detendría la FASE 0 del encargo siguiente; lo resuelve el
   titular).
2. **T1:** cualquier verificación de T1 distinta de lo esperado → T1 se
   congela sin commit y sin staging (todas las verificaciones van antes del
   `git add`); `<MAPA>` queda sin versionar, se declara como `- pendiente:`
   con la misma nota que en la detención 1 y FASE L no lo toma (el
   `<ARBOL>` lo admite, así que sigue en `0`). Desde ahí, 🔒1 a 🔒4 se miden
   igual y los pasos de FASE R sobre el commit de T1 van `no_medible`.
3. **Residual:** cualquier estado, conteo o resultado no enumerado → congela
   la tarea en curso, se registra como duda y se sigue con FASE R y FASE L.
4. **Denegación** de un comando autorizado → `- friccion:` con la cita
   literal, sin reintentar por otra vía; congela la tarea en curso.
5. `<MD5 <EXP>/50_encargo.md>` distinto de `encargo_md5` al cerrar T1 →
   congela T1.

### 0.2 Autorizaciones (lista cerrada)

0. Toda fase: comandos de solo lectura (`git status`, `git diff`, `git log`,
   `git show`, `git rev-parse`, `git symbolic-ref`, `git remote get-url`,
   `git ls-files`, `git grep`, `git stash list`, `git cat-file`,
   `git merge-base --is-ancestor`, `git rev-list`, `command grep`, `diff`, `sort`, `cut`,
   `awk`, `tr`, `paste`, `sed -n`, `sed -E` sin `-i`, `printf`, `wc`, `ls`,
   `test`, `head`, `tail`, `date`, `md5sum`, `cygpath`, `basename`,
   `git hash-object` sin `-w`), los de §0.0; escribir en `<TMP>` archivos
   `simce_s36m_*`, `sed -i` sobre ellos y `cp` de `<MAPA>` a
   `<TMP>/simce_s36m_*` (FASE R paso 6).
1. FASE 0: crear el log con la herramienta de escritura; el commit
   `docs(encargo): mapa_hashes` del encargo.
2. T1: `git add -- 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`
   y el commit de §5.
3. FASE L: `98_indexar_encargos.R` con `--validar` (más un reintento) y con
   `--escribir`, y el commit `docs(log): mapa_hashes`.

Nada más. En particular: ningún `fetch`, `pull`, `push`, `--force`, `--no-verify`,
`rm`, `git rm`, `revert`, `reset`, `restore`, `checkout --`, `stash` (salvo
`git stash list`), `commit --amend` ni `git config` que escriba; ningún
heredoc ni `sed -i` sobre el log o sobre archivos del repo; ninguna edición
de `<MAPA>`; ninguna escritura fuera de los ALCANCE; ni la memoria de la
herramienta.

### 0.3 Contrato de arranque (`<PROT>` §2.1 punto 8)

- **Lecturas previas:** antes del testigo se admite leer este encargo (no se
  lista), `<MAPA>` y `CLAUDE.md`, y comandos de solo lectura; se listan
  después del testigo en `<TMP>/simce_s36m_lecturas.txt` y van como `dato:` a
  FASE 0, donde FASE R las juzga ADVIERTE.
- **Llamadas:** se nombran por lo que hacen. **Directorio:** la llamada del
  testigo comprueba la raíz; la siguiente imprime a la terminal, nunca al log,
  `cygpath -w` de la raíz, de `<TMP>` y de `$HERRAMIENTAS_DEV_PATH`.
- **Pre-registro:** testigo y rutas van como `dato:` con
  `(escrito después: paso 0)`; desde FASE 0 paso 1, todo `esperado:` va antes
  de su comando, **también los de los commits** (el log de
  `20261109_ordenacion_estructura` registra ese tropiezo).
- **Testigo:** primera escritura `<TMP>/simce_s36m_testigo.txt` desde la
  shell; luego lectura, edición y escritura con las herramientas sobre el
  testigo y `<TMP>/simce_s36m_lecturas.txt`.
- **Memoria y búsquedas:** sin leer ni escribir la memoria; búsquedas con
  `git grep`. La carga automática de `CLAUDE.md` y la memoria es del arnés.
- **Aprobaciones:** los diálogos aprobados no son observables
  (`intervenciones_humanas` registra solo denegaciones y mensajes del
  titular; lo demás, `no_medible`).

## 1. Estado de partida (premisas marcadas)

- `HEAD` y `origin/main` en `7a43615`, rama `main` (fuente: salida del push que el titular pegó en la sesión redactora, `3c108fc..7a43615 main -> main`). Se mide en H1.
- Después del depósito, el árbol tiene las 2 líneas `??` del expediente (encargo y `<MAPA>`); con el log, 3 (hipótesis, se mide en FASE 0).
- El 2026-11-04 se reescribió el historial para quitar la atribución: la sonda del kit de ese día contó 22 commits con atribución en este repo, hoy `git log --format=%B` no tiene ninguno y `d501236` cambia `commit_cierre` de `dd01260` a `1db4d0a` (fuente: `20261104_sonda_atribucion_anexo_commits.csv` del kit, `git log --format=%B | grep -ci co-authored-by` = 0 y `git show d501236`, corridos por la sesión redactora sobre el clon de la estación, por el puente de solo lectura). Se miden `d501236` y `dd01260` en H2.
- El 2026-08-24 se rehicieron los siete commits del 2026-07-01 (fecha de commit 2026-08-24 sobre fecha de autor 2026-07-01); sus hashes de antes (`b9426c2`, `98c3f6a`, `6a13f3e`, `f9d8863`, `7af874c`, `34d681d`, `7ec8461`) se obtuvieron del remoto por SHA y son la tabla 2 de `<MAPA>` (fuente: `git log --format='%h|%ad|%cd'` sobre el clon de la estación y `git fetch` por SHA en el clon aparte, sesión redactora).
- La tabla 1 de `<MAPA>` se armó en un clon aparte del remoto con `git fetch` de `cf76515` (historia de 362 commits), emparejando por fecha de autor y asunto: 361 con par uno a uno en `main` (84 con el mismo hash y 277 reescritos), `cf76515` sin par (vivía en otra rama) y 0 pares ambiguos; `a6c2eb0` (2026-10-07) se reescribió pero su hash anterior no se obtuvo, y queda declarado en `<MAPA>`; los 303 tokens distintos citados en documentos versionados que resuelven en la historia anterior (variantes de 7 a 40 caracteres de los mismos commits) caen todos en filas de la tabla 1, y `cf76515` no está entre ellos; otros 10 tokens citados son los hashes de antes del 2026-08-24 (tabla 2 y sus tres commits sin par) (fuente: emparejamiento con `awk` en el clon aparte, sesión redactora). El encargo no repite el emparejamiento (no tiene red): verifica cada fila contra `HEAD` (`<RESUELVE>`, `<HUERFANOS>`, `<ASUNTOS>`) y la cobertura de la tabla 1 (`<COBERTURA>`). Ningún asunto del historial trae comillas invertidas (fuente: `git log --format=%s | grep -c` de la comilla invertida = 0 en el clon aparte, sesión redactora), así que la conversión que hace `<ASUNTOS>` no altera ninguno.
- md5 de `<MAPA>` `c00dc3ceb166eda06197ad3089f0e067`, 311 líneas (fuente: `md5sum` y `wc -l` sobre el archivo depositado, sesión redactora). Se mide en H2.
- Sobre `<MAPA>`, `<FILAS>` dio `284`, `<RESUELVE>` `0`, `<HUERFANOS>` `0` (con `merge-base`), `<ASUNTOS>` `0` y `<COBERTURA>` `0 277`; `<ASUNTOS>` dio `1` sobre una copia con un asunto alterado; `git merge-base --is-ancestor dd01260 HEAD` salió con código distinto de `0` (fuente: equivalentes corridos por la sesión redactora sobre el clon de la estación, por el puente de solo lectura). Se miden en T1.
- El censo no mira `50_documentacion/encargos/` (`excluidas` del perfil `proyecto`; fuente: `95_censar_estructura.R` L116, sesión redactora): el encargo no lo corre.

## 2. Decisiones

| Id | Decisión | Fuente |
|---|---|---|
| D36-11 | Los hashes anteriores a las reescrituras del 2026-08-24 y del 2026-11-04 se resuelven con el mapa que pide `<PROT>` §2.1, en el expediente de este encargo; los registros que los citan (traspasos, backlog, decisiones, logs) no se reescriben, y el traspaso v36 cita el mapa | titular, sobre propuesta de la sesión redactora (opción A); la ubicación sigue al protocolo |
| D36-12 | Se pide a soporte de GitHub purgar los commits inalcanzables, que siguen exponiendo la atribución por SHA; lo gestiona el titular, fuera de este encargo | titular, sobre propuesta de la sesión redactora (opción C) |

## 3. Invariantes (🔒)

| 🔒 | Qué y por qué | Comando | Esperado |
|---|---|---|---|
| 1 | Nada cambia fuera de `encargos/`: el mapa es registro del expediente, no documentación viva | `bash -c 'git -c core.quotePath=false diff --name-only 7a43615 HEAD \| command grep -v "^50_documentacion/encargos/" \| wc -l \| tr -d " "'` | `0` |
| 2 | Sin atribución: es justo lo que la reescritura quitó | `<ATRIB>` | `0 0` |
| 3 | Encargo y mapa intactos: el mapa se versiona tal como se verificó (se mide siempre, también tras la detención 1) | `<MD5 <EXP>/50_encargo.md>` y `<MD5 <MAPA>>` | `encargo_md5` y `c00dc3ceb166eda06197ad3089f0e067` |
| 4 | Nada de datos, código ni publicación: el encargo es solo documental | `bash -c 'git diff --name-only 7a43615 HEAD -- 10_utils 20_insumos 30_procesamiento docs 00_build.R \| wc -l \| tr -d " "'` | `0` |

**Nota:** los comandos de esta tabla llevan `\|` por la tabla; al
transcribirlos, `\|` es `|`.

## 4. FASE 0

0. **Testigo:**
   `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36m\n" > "${TMPDIR:-${TEMP:?}}/simce_s36m_testigo.txt" && echo raiz_ok'`
   → `dato:` (esperado `raiz_ok`). **Rutas** (a la terminal):
   `bash -c 'cygpath -w "$(pwd)"; cygpath -w "${TMPDIR:-${TEMP:?}}"; cygpath -w "${HERRAMIENTAS_DEV_PATH:-sin_kit}"'`.
   Lectura, edición (`testigo s36m` → `testigo s36m editado`) y escritura
   (`<TMP>/simce_s36m_lecturas.txt`).
1. Crea `<EXP>/50_log.md` con la herramienta de escritura: la ficha de
   `<PROT>` §4.4, el título `# Log · mapa_hashes`, el encabezado de `<PROT>`
   §4, el slot `## J. Juicio` con `(lo rellena FASE L)`,
   `## Registro por fase`, `inicio`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`) y
   `### FASE 0: log, punto de retorno e hipótesis`. Los valores de la ficha
   que se conocen después (`encargo_md5`, `auditoria_redaccion`,
   `hash_inicial`) se escriben con la herramienta de edición.
2. Mide, con su `esperado:` antes:
   - **H1:** `bash -c 'basename "$(git remote get-url origin)" .git'`
     esperado `slep_simce_adecuado`; `git rev-parse --short HEAD` y
     `git rev-parse --short origin/main` esperados `7a43615`;
     `git symbolic-ref --short HEAD` esperado `main`;
     `bash -c 'git stash list | wc -l | tr -d " "'` y
     `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'` esperados `0`.
   - **Árbol:**
     `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`,
     esperado exactamente:
     ```text
     ?? 50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md
     ?? 50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md
     ?? 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md
     ```
   - **H2:** `<MD5 <MAPA>>` esperado `c00dc3ceb166eda06197ad3089f0e067`;
     `bash -c 'ls 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos'`
     esperado exactamente `50_mapa_hashes.md`;
     `git cat-file -t d501236` esperado `commit`;
     `bash -c 'git merge-base --is-ancestor dd01260 HEAD 2>/dev/null && echo alcanzable || echo no_alcanzable'`
     esperado `no_alcanzable`.
   - **Disponibilidad del validador** (no detiene, `<PROT>` §2.8 paso 5; va
     como `dato:`):
     `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`.
3. `<MD5 <EXP>/50_encargo.md>` → `encargo_md5`; el anexo de auditoría a la
   clave `auditoria_redaccion`.
4. Con su `esperado:` escrito antes: `git add --` del encargo; `<STAGED>`
   igual a esa ruta; `git commit -m "docs(encargo): mapa_hashes" -- 50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md`;
   `hash_inicial`; `<ARBOL>` esperado `0`.
5. Cierra la sección.

## 5. Tarea

### T1 · Verificar y versionar el mapa

En el log, su sección es `### FASE T1: verificar y versionar el mapa`; la de
FASE R, `### FASE R: auditoría`. Todos los `esperado:` de esta lista, el del
commit incluido, van al log antes de correr el primer comando.

- Verificación (todo antes del `git add`): `<MD5 <MAPA>>` esperado
  `c00dc3ceb166eda06197ad3089f0e067`; `<FILAS>` esperado `284`;
  `<RESUELVE f>` y `<HUERFANOS f>` con `<f>` = `<MAPA>`, esperados `0` y
  `0`; `<ASUNTOS>` sobre
  `50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`
  esperado `0`; `<COBERTURA>` esperado `0 277`.
- Alcance (antes del `git add`):
  `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md$" | cut -c4- | LC_ALL=C sort | paste -sd " " -'`
  esperado `50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`;
  `<MD5 <EXP>/50_encargo.md>` igual a `encargo_md5`.
- Staging y commit, sin pasos intermedios que puedan congelar la tarea:
  `git add -- 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`;
  `<STAGED>` esperado exactamente esa ruta;
  `git commit -m "docs(historial): mapa de hashes de las reescrituras de main" -- 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`,
  esperado rc `0`; `<ARBOL>` esperado `0`.

## 6. FASE R

Los pasos de `<PROT>` §2.7, en forma breve: (1) inventario `R-01`... en
`<A>/50_R_inventario.txt` antes de auditar; (2) re-derivación con otro
comando: md5 con `git hash-object` de `<MAPA>` contra
`git rev-parse <commit de T1>:50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`;
`<FILAS>` con `awk` contando las líneas que empiezan por `` | ` ``;
`<RESUELVE>` y `<HUERFANOS>` con pertenencia a `git rev-list --abbrev-commit --abbrev=7 HEAD`
(cruce con `awk`, esperados `0` y `0`); `<ASUNTOS>` con
`git log --format="%h %s" HEAD` cruzado con las filas por `awk`, contando
discrepancias (esperado `0`; el log registra solo el conteo, nunca un
asunto); (3) 🔒1 a 🔒4 con su comando; (4) alcance global y md5 del
encargo; (5) sin arnés de pruebas (declarado); (6) control positivo, con
cada esperado escrito antes: `cp` de `<MAPA>` a
`"${TMPDIR:-${TEMP:?}}/simce_s36m_plantado.md"`; en esa copia, con la
herramienta de edición, cambiar `estado de sesion v35 |` por
`estado de sesion v36 |` (aparece una vez) y correr `<ASUNTOS>` sobre la
copia, esperado `1`; luego cambiar en la copia `` `12ddf5b` `` por
`` `0000000` `` (aparece una vez) y correr `<RESUELVE f>` con `<f>` = la
copia, esperado `1`; y cambiar `` `4d647df` `` por `` `d9a485f` `` en la
columna `hash_anterior` (la primera fila) y correr `<HUERFANOS f>` con `<f>`
= la copia, esperado `1`; (7) veredicto por hallazgo (BLOQUEA, REPARA,
ADVIERTE); (8) 0 ciclos; (9) sin ajustar criterios ni ALCANCE; (10) tabla
`id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
y veredicto global al bloque J.

## 7. FASE L

Los pasos de `<PROT>` §2.8: (1) `<ARBOL>`; (2) `## Cierre` con resumen,
commits, auditoría, invariantes, decisiones (§2), dudas, errores propios,
notas, «Calidad del encargo» y fricciones (lo medido después, marcado
`(escrito después: FASE L)`). El punto 4 del Cierre va con la forma que
quedó en el log de `20261109_ordenacion_estructura` después de dos rechazos
del validador, y que el titular validó después con `rc 0` (fuente: salida
que el titular pegó en la sesión redactora):

```text
4. Verificación de invariantes (FASE R):
   - 🔒1 <qué>: PASA (<evidencia>)
   - 🔒2 <qué>: PASA (<evidencia>)
   - 🔒3 <qué>: PASA (<evidencia>)
   - 🔒4 <qué>: PASA (<evidencia>)
```

(con `FALLA` en vez de `PASA` donde corresponda; los cuatro 🔒 se miden
siempre, también tras una detención, así que la ficha lleva
`invariantes: {pasa: N, total: 4}` con `N` igual a las viñetas `PASA`); (3)
bloque J; (4) ficha
sin `null`, `push: "no"`; (5)
`bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md; echo "rc $?"'`
esperado `rc 0` (un reintento); (6) `<PRIVACIDAD>`; (7) `^### FASE` igual a 3
(FASE 0, T1, FASE R) y paridad `esperado:`/`obtenido:`; (8) `git add --` del
log y los `<A>/50_*.txt` creados, `98_indexar_encargos.R --repo=. --escribir`
(mismo intérprete) y el índice si cambió, `<STAGED>`,
`git commit -m "docs(log): mapa_hashes" -- <lista>`, con cada ruta por su
nombre, nunca la carpeta ni un glob; (9) estado de cierre.

## 8. Reporte final

- `ls -l` y `wc -l <` del log, hash de `docs(log)`, el bloque J, los commits
  y 🔒1 a 🔒4 medidos otra vez después de `docs(log)`.
- Para el titular: el push, que este encargo no hace.
- Última línea, literal:

  ```text
  → Sesión redactora: lee completo `50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md` (commit docs(log) <hash>, <N> líneas) antes de evaluar. Este reporte es un resumen y no reemplaza al log.
  ```

## 9. Exclusiones

- Reescribir hashes en traspasos, backlog, decisiones o logs (D36-11).
- La solicitud de purga a GitHub (D36-12): la hace el titular.
- Los tokens hexadecimales citados que no resuelven ni en la historia actual
  ni en la anterior (hashes de otros repositorios, fragmentos de md5 o
  números de línea de `diff`; 261 tokens distintos, 33 de ellos de 7
  caracteres, después de descontar los 10 de la tabla 2; fuente: barrido con
  `git cat-file -e` en el clon aparte y consulta por SHA a la API de GitHub,
  sesión redactora): fuera del alcance del mapa.
- El hash anterior de `a6c2eb0` (2026-10-07), que no se pudo obtener.

## Anexo de auditoría de redacción
- Nivel: 1 (puntaje 0: ningún criterio C1 a C8)
- Rondas: 2 de 3 (ronda 1: revisor combinado de conformidad y técnico, sobre la versión con el mapa en `activa/`; ronda 2: revisor nuevo, sobre la versión con el mapa en el expediente, con simulación en un repo de prueba reescrito con `filter-branch`)
- Decisiones de la sesión entregadas a los revisores: opción A (mapa) y C (purga a cargo del titular), regla sin atribución, entorno Windows con Git Bash, sin push
- Ronda 1: BLOQUEA 0 · CORREGIR 4 · MENOR 9
- Ronda 2: BLOQUEA 0 · CORREGIR 6 · MENOR 7
- Abiertos: BLOQUEA 0 · CORREGIR 0 · MENOR 0
- MENOR abiertos: ninguno
- Hallazgo de la ronda 2 que amplió el alcance: la búsqueda de cobertura encontró una reescritura anterior (rebase del 2026-08-24), que pasó a la tabla 2 del mapa
- Límite declarado: los revisores no tienen el repo real ni el validador; los comandos de §0.0 se corrieron sobre el clon de la estación por el puente de solo lectura (§1)
- Condición de la sesión: completa
