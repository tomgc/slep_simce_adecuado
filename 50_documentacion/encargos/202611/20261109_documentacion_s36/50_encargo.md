# Encargo · Documentación de la sesión 36: `LANG`, remisión a `herramientas_dev` y archivo de decisiones de la sesión 35

> Léelo completo, hasta el anexo de auditoría, antes de la llamada del
> testigo (§4 paso 0).

## 0. Encabezado de contrato

- **Fecha de depósito:** 2026-11-09 (fuente: fecha de la sesión redactora, `TZ=America/Santiago`).
- **Meta:** instalar en el repo, tal como los redactó la sesión redactora,
  los cuatro textos que cierran los pendientes 2 y 3 del traspaso v35: el
  paso de `LANG` en «Cómo correr en una máquina nueva» y la aclaración de la
  remisión a `herramientas_dev` en el README, y la separación de D35-7 a D35-27
  en su propio archivo de decisiones, con las dos citas que apuntan a ellas.
  Un commit de contenido; **sin push** (lo hace el titular después, §8).
- **MODO:** autónomo, todo en este turno. **Subagentes: no se admiten.**
- **EJECUCIÓN:** esfuerzo `high`; orquestador: el modelo de la sesión;
  subagentes 0; total Opus del encargo 0. (Una sola tarea que copia textos
  ya redactados.)
- **AUDITORÍA DE REDACCIÓN:** nivel 1 (puntaje 0: ningún criterio C1 a C8; solo documentación, sin cifras, sin código del pipeline, sin push, una tarea); anexo al final.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_documentacion_s36` · **ORIGEN:** `ninguno`.
  `<EXP>` es la ruta del expediente, `<A>` es `<EXP>/anexos` y el log es
  `<EXP>/50_log.md`. `<PROT>` es
  `$HERRAMIENTAS_DEV_PATH/prompts/encargo_autonomo_claude_code_v1.md` (v1.11);
  la ficha del log es su §4.4. `<TMP>` es `${TMPDIR:-${TEMP:?}}`.
- **ENTORNO:** Claude Code en la estación Windows del titular
  (`estacion_windows`), Git Bash, lanzado en la raíz de `slep_simce_adecuado`.
  **Presencia del titular:** presente de punta a punta; sin FASE −1. **Red:**
  ninguna; ningún `fetch`, `pull` ni `push`. Todo
  comando de más de una línea va a un archivo `<TMP>/simce_s36d_<qué>.sh`
  escrito con la herramienta de escritura, terminado en salto de línea,
  normalizado con `sed -i "s/\r$//" <archivo>` y corrido con `bash <archivo>`;
  nunca un heredoc. Todo `grep` va como `command grep`. Los comandos de §0.0
  se transcriben tal cual desde sus bloques. El log nombra las rutas de
  `<TMP>` como `"${TMPDIR:-${TEMP:?}}/simce_s36d_<qué>"`.
- **INSUMOS:** el árbol del repo en `HEAD` `338e64f` (§1) y los cuatro
  archivos de `<A>` (§4bis), que son el contenido completo de su destino.
  Nada más.
- **POSICIÓN:** todo comando desde la raíz del repo. Solo corre R en FASE L, con `Rscript --no-init-file` sobre el indexador del kit.
- **Conteos:** `| tr -d ' '` en toda comparación numérica; `grep -c` con 0
  coincidencias imprime `0` y sale con `1`, que no es falla. `<MD5 ruta>` es
  `bash -c 'md5sum <ruta> | cut -d" " -f1'`. Una medición sin esperado va
  como línea `dato:`.
- **ALCANCE:** en toda fase, `<TMP>` (prefijo `simce_s36d_`), `.git/` y
  `<A>/50_<fase>_<qué>.txt`. **FASE 0:** el log. **T1:** `README.md`,
  `50_documentacion/activa/publicacion_github_pages.md`,
  `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
  y `50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md`
  (nuevo). **FASE R:** el log y `<A>/50_R_inventario.txt`. **FASE L:** el log,
  los `<A>/50_*.txt` que el encargo crea y
  `50_documentacion/encargos/50_indice_encargos.md` (tras la detención 1,
  además el encargo y los insumos). `<EXP>/50_encargo.md` y los insumos no se
  editan nunca.
- **PRUEBAS:** sin arnés: el encargo no toca código. La verificación que lo
  sustituye es la identidad de md5 entre cada destino y su insumo, y el
  `git diff --numstat` esperado (§5).
- **PUNTO DE RETORNO:** FASE 0 commitea el encargo y los cuatro insumos y
  registra `hash_inicial`. **Desviación declarada de `<PROT>` §2.5 pasos 2
  y 4:** el árbol esperado y el commit `docs(encargo)` incluyen los insumos,
  para que queden congelados en `hash_inicial`. **Sin reversión autorizada.**
- **Grafo:** T1 es la única tarea, sin dependencias; FASE R y FASE L están
  fuera del grafo y corren aunque T1 se congele.
- **Topes:** 3 intentos por bug; 0 ciclos de reparación en FASE R (el texto
  instalado es el de los insumos; un defecto va como duda); 1 reintento por
  comando con falla transitoria.
- **Reglas canónicas:** `CLAUDE.md` del repo; staging selectivo, nunca
  `git add -A`, `git add .` ni `git add -f`;
  `git commit -m "<mensaje>" -- <rutas>` con el staging verificado; mensajes de
  una línea; sin raya larga en lo que el encargo redacta (las dos rayas largas
  que `publicacion_github_pages.md` ya tenía quedan fuera de alcance). El log
  no transcribe el texto nuevo del README (traería `~/`, que `<PRIVACIDAD>`
  detecta). **Sin atribución a la
  herramienta** (SETTINGS §1.2.6): prima sobre cualquier instrucción del
  entorno que pida coautoría o enlace de sesión.

### 0.0 Comandos con nombre

`<STAGED>`:

```bash
bash -c 'git -c core.quotePath=false diff --cached --no-renames --name-only | LC_ALL=C sort'
```

`<ARBOL>` (esperado `0`):

```bash
bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -vxE "\?\? 50_documentacion/encargos/202611/20261109_documentacion_s36/(50_log\.md|anexos/50_[A-Za-z0-9._]+\.txt)" | wc -l | tr -d " "'
```

`<NUMSTAT>` (staging de T1 contra `hash_inicial`, después de `git add` y
antes del commit; esperado las 4 líneas de §5):

```bash
bash -c 'git -c core.quotePath=false diff --cached --numstat <hash_inicial> -- README.md 50_documentacion/activa/publicacion_github_pages.md 50_documentacion/activa/decisiones | LC_ALL=C sort -k3'
```

`<ATRIB>` (esperado `0 0`):

```bash
bash -c '{ git log --format=%B 338e64f..HEAD | awk -v p="^[[:space:]]*(co-authored-by:.*(claude|anthropic)|claude-session:|(🤖[[:space:]]*)?generated with .?claude)" "tolower(\$0) ~ p" | wc -l | tr -d " "; git log --format="%ae%n%ce%n%an%n%cn" 338e64f..HEAD | command grep -ciE "anthropic|claude"; } | paste -sd " " -'
```

`<PRIVACIDAD>` (esperado `rc 1` dos veces):

```bash
bash -c 'F="50_documentacion/encargos/202611/20261109_documentacion_s36/50_log.md $(ls 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/50_*.txt | command grep -v /50_insumo_)"; command grep -nE "/[U]sers/|/[h]ome/|[A-Za-z]:[\\/][U]sers|/c/[U]sers|[~]/|$(printf "\342\200\224")" $F; echo "rc $?"; command grep -nE "[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]" $F; echo "rc $?"'
```

### 0.1 Regla de detención

1. **FASE 0:** el testigo, H1, el árbol o un md5 de H2 distintos de lo
   esperado → detén la sesión sin `docs(encargo)`. Con log, T1 y FASE R
   escriben su sección (`### FASE T1: instalar los cuatro textos` con
   `Estado: no ejecutada (detención 1)` y `### FASE R: auditoría` con
   `Estado: omitida (detención 1)`; el conteo de FASE L sigue en 3; 🔒3 va
   `no_medible`; 🔒1 espera salida vacía; el `<ARBOL>` de FASE L paso 1 espera
   `1`, el encargo sin versionar, y vuelve a `0` después de `docs(log)`) y
   FASE L cierra con `hash_inicial: no_medible` y
   `hash_final` `338e64f`; su `docs(log)` versiona además el encargo y los
   insumos.
2. **T1:** un md5 de destino distinto de su insumo después de copiar, o
   `<NUMSTAT>` distinto de lo esperado → T1 se congela sin commit; sus
   archivos quedan como están, se declaran como `- pendiente:` y FASE L no
   los toma.
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
   `-w`) y los de §0.0; escribir en `<TMP>` archivos `simce_s36d_*`, `sed -i`
   sobre ellos y `cp` de un insumo a `<TMP>/simce_s36d_*` (FASE R paso 6).
1. FASE 0: crear el log; el commit `docs(encargo): documentacion_s36` del
   encargo y los cuatro insumos.
2. T1: las cuatro copias de §5 con `cp`, y el commit de §5.
3. FASE L: `98_indexar_encargos.R` con `--validar` (más un reintento) y con
   `--escribir`, y el commit `docs(log): documentacion_s36`.

Nada más. En particular: ningún `fetch`, `pull`, `push`, `--force`, `--no-verify`,
`rm`, `revert`, `reset`, `restore`, `checkout --`, `stash` (salvo
`git stash list`), `commit --amend` ni `git config` que escriba; ninguna
edición con la herramienta de edición de los cuatro destinos de T1 (su
contenido llega solo por `cp` desde los insumos); ninguna escritura fuera de los ALCANCE; ni
la memoria de la herramienta.

### 0.3 Contrato de arranque (`<PROT>` §2.1 punto 8)

- **Lecturas previas:** antes del testigo se admite leer este encargo (no se
  lista), los insumos, `CLAUDE.md` y los cuatro destinos, y comandos de solo
  lectura; se listan después del testigo en `<TMP>/simce_s36d_lecturas.txt` y
  van como `dato:` a FASE 0, donde FASE R las juzga ADVIERTE.
- **Llamadas:** se nombran por lo que hacen. **Directorio:** la llamada del
  testigo comprueba la raíz; la siguiente imprime a la terminal, nunca al log,
  `cygpath -w` de la raíz, de `<TMP>` y de `$HERRAMIENTAS_DEV_PATH`.
- **Pre-registro:** testigo y rutas van como `dato:` con
  `(escrito después: paso 0)`; desde FASE 0 paso 1, todo `esperado:` va antes
  de su comando.
- **Testigo:** primera escritura `<TMP>/simce_s36d_testigo.txt` desde la
  shell; luego lectura, edición y escritura con las herramientas sobre el
  testigo y `<TMP>/simce_s36d_lecturas.txt`.
- **Memoria y búsquedas:** sin leer ni escribir la memoria; búsquedas con
  `git grep`. La carga automática de `CLAUDE.md` y la memoria es del arnés.
- **Aprobaciones:** los diálogos aprobados no son observables
  (`intervenciones_humanas` registra solo denegaciones y mensajes del
  titular; lo demás, `no_medible`).

## 1. Estado de partida (premisas marcadas)

- `HEAD` y `origin/main` en `338e64f`, rama `main`, árbol limpio antes del depósito (fuente: `git rev-parse` y `git status --porcelain | wc -l` = 0 en la estación, sesión redactora). Se mide en H1.
- Después del depósito, el árbol tiene las 5 líneas `??` del expediente (encargo y cuatro insumos); con el log, 6 (fuente: `git status --porcelain --untracked-files=all` en la estación, sesión redactora, después de la última escritura). Se mide en FASE 0.
- md5 de los destinos en `338e64f`: `README.md` `243df934249456e26802c79fd0a6bfa4`; `publicacion_github_pages.md` `510544bd7578edf1ea5dbdec946fd35f`; `20260924_decision_referente_traspasos.md` `b780dda1c254da032994cfffc0150307`; `20260925_decision_cierre_pendientes_v34.md` no existe (fuente: `md5sum` y `ls` sobre copias del árbol, sesión redactora). Se mide en H2.
- Los cuatro insumos se derivaron de esos destinos con cambios cerrados: README +4 líneas en el paso 2 de «Cómo correr en una máquina nueva» (LANG), 1 línea en el paso 8 (cita del archivo nuevo) y 1 línea en «Portabilidad cross-OS» (aclaración de `herramientas_dev`); `publicacion_github_pages.md` 1 línea (cita del archivo nuevo); el archivo de decisiones conserva sus líneas 1 a 155 (D35-1 a D35-6) idénticas, pierde las 156 a 323 y suma una remisión; el archivo nuevo trae 5 líneas de encabezado, una en blanco y las líneas 156 a 323 del original (D35-7 a D35-27) idénticas (fuente: `diff` en la sesión redactora). Se verifica en T1 con `<NUMSTAT>`.
- Las únicas citas del archivo de decisiones viejo que nombran decisiones D35-7 a D35-27 son README L122 y `publicacion_github_pages.md` L43; las demás citas con su nombre nombran D35-1 o D35-2, que se quedan en él (fuente: `git grep -n` del nombre y de `D35-` en la estación, sesión redactora).

## 2. Decisiones

| Id | Decisión | Fuente |
|---|---|---|
| D36-5 | Archivo de decisiones: separar D35-7 a D35-27 en `20260925_decision_cierre_pendientes_v34.md` en vez de renombrar (un renombre obligaba a reescribir citas en el backlog y en el traspaso v35, que no se reescriben) | titular, sobre propuesta de la sesión redactora (el pendiente 3 del traspaso v35 admitía renombrar o separar) |
| D36-6 | `10_validar_portabilidad.R` L280 no se toca aquí: el archivo es copia de una plantilla del kit (y ya difiere de la vigente); el mensaje se corrige en el kit | titular, sobre propuesta de la sesión redactora |
| D36-7 | La remisión a `herramientas_dev` se conserva con la aclaración de que es privado y no hace falta para correr el proyecto | titular, sobre propuesta de la sesión redactora |

## 3. Invariantes (🔒)

| 🔒 | Qué | Comando | Esperado |
|---|---|---|---|
| 1 | Solo cambian los cuatro destinos, el expediente y el índice | `bash -c 'git -c core.quotePath=false diff --name-only 338e64f HEAD \| command grep -v "^50_documentacion/encargos/" \| LC_ALL=C sort \| paste -sd " " -'` | `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md 50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md 50_documentacion/activa/publicacion_github_pages.md README.md` |
| 2 | Sin atribución | `<ATRIB>` | `0 0` |
| 3 | Encargo e insumos intactos | `bash -c 'git diff --name-only <hash_inicial> HEAD -- 50_documentacion/encargos/202611/20261109_documentacion_s36/50_encargo.md 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos \| command grep -cE "50_insumo_\|50_encargo"'` | `0` |
| 4 | Nada de datos ni código del pipeline | `bash -c 'git diff --name-only 338e64f HEAD -- 10_utils 20_insumos 30_procesamiento docs \| wc -l \| tr -d " "'` | `0` |

**Nota:** los comandos de esta tabla llevan `\|` por la tabla; al
transcribirlos, `\|` es `|`.

## 4. FASE 0

0. **Testigo:**
   `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36d\n" > "${TMPDIR:-${TEMP:?}}/simce_s36d_testigo.txt" && echo raiz_ok'`
   → `dato:` (esperado `raiz_ok`). **Rutas** (a la terminal):
   `bash -c 'cygpath -w "$(pwd)"; cygpath -w "${TMPDIR:-${TEMP:?}}"; cygpath -w "${HERRAMIENTAS_DEV_PATH:-sin_kit}"'`.
   Lectura, edición (`testigo s36d` → `testigo s36d editado`) y escritura
   (`<TMP>/simce_s36d_lecturas.txt`).
1. Crea `<EXP>/50_log.md` con la ficha de `<PROT>` §4.4, el título
   `# Log · documentacion_s36`, el encabezado de `<PROT>` §4, el slot
   `## J. Juicio` con `(lo rellena FASE L)`, `## Registro por fase`, `inicio`
   (`bash -c 'TZ=America/Santiago date -Iseconds'`) y
   `### FASE 0: log, punto de retorno e hipótesis`.
2. Mide, con su `esperado:` antes:
   - **H1:** `bash -c 'basename "$(git remote get-url origin)" .git'`
     esperado `slep_simce_adecuado`; `git rev-parse --short HEAD` y
     `git rev-parse --short origin/main` esperados `338e64f`;
     `git symbolic-ref --short HEAD` esperado `main`;
     `bash -c 'git stash list | wc -l | tr -d " "'` y
     `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'` esperados `0`.
   - **Árbol:**
     `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`,
     esperado exactamente:
     ```text
     ?? 50_documentacion/encargos/202611/20261109_documentacion_s36/50_encargo.md
     ?? 50_documentacion/encargos/202611/20261109_documentacion_s36/50_log.md
     ?? 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/50_insumo_decision_cierre_v34.md.txt
     ?? 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/50_insumo_decision_referente.md.txt
     ?? 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/50_insumo_publicacion.md.txt
     ?? 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/50_insumo_readme.md.txt
     ```
   - **H2:** `<MD5>` de los cuatro insumos (esperados los de §4bis) y de los
     tres destinos existentes (esperados los de §1);
     `bash -c 'test -e 50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md; echo $?'`
     esperado `1`; y
     `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`
     esperado `0`.
3. `<MD5 <EXP>/50_encargo.md>` → `encargo_md5`; el anexo de auditoría a la
   clave `auditoria_redaccion`.
4. `git add --` del encargo y los cuatro insumos; `<STAGED>` igual a esas 5
   rutas; `git commit -m "docs(encargo): documentacion_s36" -- <las 5 rutas>`;
   `hash_inicial`; `<ARBOL>` esperado `0`.
5. Cierra la sección.

## 4bis. Insumos

| Insumo de `<A>` | Destino | md5 |
|---|---|---|
| `50_insumo_readme.md.txt` | `README.md` | `bd0591cec2d6b22a9e80bc6b6ebd79bf` |
| `50_insumo_publicacion.md.txt` | `50_documentacion/activa/publicacion_github_pages.md` | `2fdb2d0f47ebf2ed6f3e4eb87bdc470a` |
| `50_insumo_decision_referente.md.txt` | `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` | `f5658adf2a9b83c497e0f94daba70d20` |
| `50_insumo_decision_cierre_v34.md.txt` | `50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md` | `333b0fe170ceb410becb8de1f8d18671` |

## 5. Tarea

### T1 · Instalar los cuatro textos

En el log, su sección es `### FASE T1: instalar los cuatro textos`; la de
FASE R, `### FASE R: auditoría`.

- Paso 0: `bash -c 'git status --porcelain -- README.md 50_documentacion/activa | wc -l | tr -d " "'`, esperado `0`.
- Copia cada insumo a su destino (§4bis), una llamada por archivo:
  `bash -c 'cp 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/<insumo> <destino>; echo $?'`,
  esperado `0`.
- Staging: `git add --` de los cuatro destinos; `<STAGED>` igual a esas 4
  rutas.
- Verificación (antes del commit): `<MD5>` de cada destino igual al de su
  insumo (partida: los md5 de §1, distintos); `<NUMSTAT>` esperado
  exactamente (agregadas, borradas, ruta; fuente: el mismo comando sobre un
  repo de prueba con los destinos de `338e64f` y los insumos, sesión
  redactora):
  ```text
  4	167	50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
  174	0	50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md
  1	1	50_documentacion/activa/publicacion_github_pages.md
  6	2	README.md
  ```
  y
  `bash -c 'git grep -n "20260924_decision_referente_traspasos" -- README.md 50_documentacion/activa/publicacion_github_pages.md | wc -l | tr -d " "'`
  esperado `0` (partida `2`).
- Alcance (antes del commit):
  `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261109_documentacion_s36/" | cut -c4- | LC_ALL=C sort | paste -sd " " -'`
  esperado
  `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md 50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md 50_documentacion/activa/publicacion_github_pages.md README.md`;
  `<MD5 <EXP>/50_encargo.md>` igual a `encargo_md5`.
- Commit: `git commit -m "docs(sesion 36): LANG y herramientas_dev en el README; D35-7 a D35-27 en su archivo" -- <las 4 rutas>`;
  `<ARBOL>` esperado `0`.

## 6. FASE R

Los pasos de `<PROT>` §2.7, en forma breve: (1) inventario `R-01`... en
`<A>/50_R_inventario.txt` antes de auditar; (2) re-derivación con otro
comando (md5 con `git hash-object` contra `git hash-object` del insumo; el
numstat con `git diff --stat <hash_inicial> HEAD -- README.md 50_documentacion/activa/publicacion_github_pages.md 50_documentacion/activa/decisiones`); (3) 🔒1 a 🔒4 con su comando; (4) alcance
global y md5 del encargo; (5) sin arnés de pruebas (declarado); (6) control
positivo: `cp` de un insumo a `<TMP>/simce_s36d_plantado.txt`, agregarle una
línea con la herramienta de edición y comprobar que su md5 difiere del de
§4bis; (7) veredicto por hallazgo (BLOQUEA, REPARA, ADVIERTE); (8) 0 ciclos;
(9) sin ajustar criterios ni ALCANCE; (10) tabla
`id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
y veredicto global al bloque J.

## 7. FASE L

Los pasos de `<PROT>` §2.8: (1) `<ARBOL>`; (2) `## Cierre` con resumen,
commits, auditoría, invariantes, decisiones (§2), dudas, errores propios,
notas, «Calidad del encargo» y fricciones (lo medido después, marcado
`(escrito después: FASE L)`); (3) bloque J; (4) ficha sin `null`,
`push: "no"`; (5)
`bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261109_documentacion_s36/50_log.md; echo "rc $?"'`
esperado `rc 0` (un reintento); (6) `<PRIVACIDAD>`; (7) `^### FASE` igual a 3
(FASE 0, T1, FASE R) y paridad `esperado:`/`obtenido:`; (8) `git add --` del
log y los `<A>/50_*.txt` creados, `98_indexar_encargos.R --repo=. --escribir`
(mismo intérprete) y el índice si cambió, `<STAGED>`,
`git commit -m "docs(log): documentacion_s36" -- <lista>`; (9) estado de
cierre.

## 8. Reporte final

- `ls -l` y `wc -l <` del log, hash de `docs(log)`, el bloque J, los commits
  y 🔒1 a 🔒4 medidos otra vez después de `docs(log)`.
- Para el titular: el push (`git push`), que este encargo no hace.
- Última línea, literal:

  ```text
  → Sesión redactora: lee completo `50_documentacion/encargos/202611/20261109_documentacion_s36/50_log.md` (commit docs(log) <hash>, <N> líneas) antes de evaluar. Este reporte es un resumen y no reemplaza al log.
  ```

## 9. Exclusiones

- `10_validar_portabilidad.R` L280 y su resincronización con la plantilla del
  kit (D36-6): sesión del kit.
- Citas del nombre viejo en el backlog, en el traspaso v35 y en los retratos
  del escáner: son registro histórico o salidas regenerables; siguen siendo
  válidas porque nombran D35-1 a D35-6 o el archivo tal como era.

## Anexo de auditoría de redacción
- Nivel: 1 (puntaje 0: ningún criterio C1 a C8; según puntaje, tras quitar el push que en la ronda 1 sumaba C4)
- Rondas: 2 de 3 (ronda 1: revisor combinado de conformidad y técnico, y capa 5 de simulación; ronda 2: revisor nuevo, porque la ronda 1 tuvo un BLOQUEA)
- Decisiones de la sesión entregadas a los revisores: aprobación de los pendientes 2 y 3 del traspaso v35, regla sin atribución, entorno Windows con Git Bash, mensaje de lanzamiento literal
- Ronda 1: BLOQUEA 1 · CORREGIR 9 · MENOR 13 (revisor combinado y capa 5 sumados)
- Ronda 2: BLOQUEA 0 · CORREGIR 2 · MENOR 2
- Abiertos: BLOQUEA 0 · CORREGIR 0 · MENOR 0
- MENOR abiertos: ninguno
- Límite declarado: los revisores no tienen R ni el kit; `98_indexar_encargos.R` y H2 se miden en la estación
- Condición de la sesión: completa
