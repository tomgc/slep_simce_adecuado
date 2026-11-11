---
expediente: 50_documentacion/encargos/202611/20261109_mapa_hashes
repo: slep_simce_adecuado
encargo_md5: "7bc3df8e45da2786e6cb2c9680602d48"
origen: ninguno
inicio: 2026-11-11T15:27:56+00:00
fin: 2026-11-11T15:34:15+00:00
hash_inicial: "99757f8"
hash_final: "08d54d9"
auditoria_redaccion: {nivel: 1, puntaje: 0, rondas: 2, bloquea: 0, corregir: 10, menor: 16, menor_abiertos: 0, completa: "si"}
resultado_meta: cumplida
tareas: {completadas: 1, congeladas: 0, no_ejecutadas: 0}
fase_r: {veredicto: "APROBADO", bloquea: 0, repara: 0, advierte: 0, reparados: 0}
invariantes: {pasa: 4, total: 4}
errores_propios: 2
defectos_encargo: 0
fricciones_entorno: 0
dudas_abiertas: 0
intervenciones_humanas: 0
compactaciones_contexto: {n: 0, fases: []}
subagentes: {opus: 0, intermedios: 0}
push: "no"
---

# Log · mapa_hashes

- **Meta:** verificar y versionar `<MAPA>` (`anexos/50_mapa_hashes.md`), el mapa de hashes que `<PROT>` §2.1 (v1.11) exige para una reescritura de historial y que las reescrituras de `main` del 2026-08-24 y del 2026-11-04 no dejaron; un commit de contenido, sin push.
- **Fecha:** 2026-11-11 (encargo depositado el 2026-11-09).
- **Repo y rama:** `slep_simce_adecuado`, `main`.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_mapa_hashes` · **ORIGEN:** `ninguno`.
- **ENTORNO:** Claude Code en la estación Windows del titular (`estacion_windows`), shell Git Bash, directorio de trabajo en la raíz del repo; titular presente de punta a punta; sin red.
- **EJECUCIÓN:** declarada esfuerzo `high`, orquestador el modelo de la sesión, subagentes 0, total Opus 0; modo real de la sesión: `high`, sin subagentes.
- **AUDITORÍA DE REDACCIÓN:** nivel 1 (puntaje 0: ningún criterio C1 a C8; solo documentación del expediente, sin cifras del pipeline, sin código, sin push, una tarea); 2 rondas; anexo del encargo.
- **Grafo:** T1 única tarea, sin dependencias; FASE R y FASE L fuera del grafo.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 0 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.

## J. Juicio
- Meta y resultado: verificar y versionar `<MAPA>`, el mapa de hashes de las reescrituras de `main` del 2026-08-24 y del 2026-11-04, en un commit, sin push → cumplida.
- Estado por tarea: T1 completada (08d54d9).
- Commits: 1 en 99757f8..08d54d9 (`git log --oneline --first-parent`; sin contar `docs(encargo)`, que es hash_inicial, ni `docs(log)`), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): APROBADO; hallazgos B/R/A = 0/0/0; reparados 0; abiertos 0 (ninguno).
- Auditoría de redacción: nivel 1 (puntaje 0); rondas 2; BLOQUEA/CORREGIR/MENOR = 0/10/16; MENOR abiertos 0.
- Invariantes: 4/4 PASA; FALLA: ninguno.
- Cifras críticas: intactas (evidencia: md5 de `<MAPA>` c00dc3ceb166eda06197ad3089f0e067 antes y después; 284 filas; cobertura 0 277; encargo 7bc3df8e45da2786e6cb2c9680602d48).
- Decisiones autónomas de mayor riesgo: commits condicionados a `<STAGED>` en el mismo guion (descartada: staging y commit en llamadas separadas); conteo de RUT y rutas sobre `<MAPA>` antes de versionarlo (descartada: confiar en la exclusión de `<PRIVACIDAD>`); recorte a 7 caracteres en los cruces de FASE R; todas reversibles.
- Desviaciones respecto del encargo: celda de la fila R-05 reescrita tras escribirse (§4.3 regla 4).
- Calidad del encargo: 0 defectos; escapo_a: ninguno.
- Dudas abiertas: 0; ninguna.
- Errores propios: 2 registrados (4.1); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: el emparejamiento `hash_anterior` → `hash_nuevo`, que esta sesión no puede re-derivar sin red (los hashes anteriores no son alcanzables en el clon).
- No publicado / queda al usuario: push retenido (`git push`); solicitud de purga a GitHub (D36-12).
- Ejecución: modo de sesión high; subagentes 0, por contrato; duración 00:06 (ficha); compactaciones de contexto 0.

## Registro por fase

### FASE 0: log, punto de retorno e hipótesis

dato: testigo `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36m\n" > "${TMPDIR:-${TEMP:?}}/simce_s36m_testigo.txt" && echo raiz_ok'` → `raiz_ok` (escrito después: paso 0)
dato: llamada de las rutas corrida; salida solo a la terminal (escrito después: paso 0)
dato: herramientas de lectura, edición (`testigo s36m` → `testigo s36m editado`) y escritura ejercidas sobre `"${TMPDIR:-${TEMP:?}}/simce_s36m_testigo.txt"` y `"${TMPDIR:-${TEMP:?}}/simce_s36m_lecturas.txt"` sin denegación (escrito después: paso 0)
dato: lecturas previas al testigo (`"${TMPDIR:-${TEMP:?}}/simce_s36m_lecturas.txt"`): `ls -la` y `wc -l` del expediente, `ls -la` de `<A>`; `CLAUDE.md` solo por carga automática del arnés; `<MAPA>` no leído
dato: lecturas posteriores al testigo y anteriores al log: encabezados de `<PROT>`, sus L818-999 y L1585-1924; el log de `20261109_ordenacion_estructura` completo, como referencia de formato
dato: inicio `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T15:27:56+00:00` (offset `+00:00`: fricción conocida, no nueva)

**H1** `bash -c 'basename "$(git remote get-url origin)" .git'`; `git rev-parse --short HEAD`; `git rev-parse --short origin/main`; `git symbolic-ref --short HEAD`; `bash -c 'git stash list | wc -l | tr -d " "'`; `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'`
esperado: slep_simce_adecuado / 7a43615 / 7a43615 / main / 0 / 0

**Árbol** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`
esperado: las 3 líneas `??` de §4 paso 2 (encargo, log y `<MAPA>`), exactamente

**H2** `<MD5 <MAPA>>`; `bash -c 'ls 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos'`; `git cat-file -t d501236`; `bash -c 'git merge-base --is-ancestor dd01260 HEAD 2>/dev/null && echo alcanzable || echo no_alcanzable'`
esperado: c00dc3ceb166eda06197ad3089f0e067 / 50_mapa_hashes.md / commit / no_alcanzable

dato: las mediciones de H1, árbol, H2, el validador y `encargo_md5` corren juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_fase0.sh"`.
obtenido: H1 slep_simce_adecuado / 7a43615 / 7a43615 / main / 0 / 0 → PASA
obtenido: árbol, las 3 líneas `??` de §4 paso 2, idénticas y en el mismo orden → PASA
obtenido: H2 c00dc3ceb166eda06197ad3089f0e067 / 50_mapa_hashes.md / commit / no_alcanzable → PASA
dato: disponibilidad del validador `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'` → `0`
dato: `encargo_md5` `bash -c 'md5sum "50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md" | cut -d" " -f1'` → `7bc3df8e45da2786e6cb2c9680602d48`; `auditoria_redaccion` copiada del anexo del encargo (nivel 1, puntaje 0, 2 rondas, 0/10/16 sumando las rondas, MENOR abiertos 0, completa).

**Punto de retorno** `git add -- 50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md`; `<STAGED>`; `git commit -m "docs(encargo): mapa_hashes" -- 50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md`; `git rev-parse --short HEAD`; `<ARBOL>`
esperado: `<STAGED>` = `50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md`, exactamente; commit rc 0; `<ARBOL>` 0
dato: el punto de retorno corre en `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_commit0.sh"`, que commitea solo si `<STAGED>` es exactamente la ruta del encargo.
obtenido: `<STAGED>` = `50_documentacion/encargos/202611/20261109_mapa_hashes/50_encargo.md`; commit rc 0; hash_inicial `99757f8`; `<ARBOL>` 0 → PASA

- **Estado:** completada.
- **Commits:** `99757f8` docs(encargo): mapa_hashes.
- **Cambios sustantivos:** log creado; encargo congelado en `hash_inicial`; `<MAPA>` sigue sin versionar hasta T1.
- **Alcance:** el log, el encargo, `.git/` y `<TMP>` ⊆ ALCANCE de FASE 0; md5 del encargo igual al de la ficha.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** el guion del punto de retorno condiciona el commit a que `<STAGED>` sea exactamente la ruta del encargo (alternativa descartada: staging y commit en llamadas separadas); reversible.
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna (el offset `+00:00` de `date` es la fricción conocida, registrada como `dato:`).
- **Intervenciones humanas:** ninguna.
- **Dudas:** ninguna.

### FASE T1: verificar y versionar el mapa

**md5 del mapa** `<MD5 <MAPA>>`
esperado: c00dc3ceb166eda06197ad3089f0e067

**Filas** `<FILAS>`
esperado: 284

**Resuelve** `<RESUELVE f>` con `<f>` = `<MAPA>`
esperado: 0

**Huérfanos** `<HUERFANOS f>` con `<f>` = `<MAPA>`
esperado: 0

**Asuntos** `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_asuntos.sh" 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`
esperado: 0

**Cobertura** `<COBERTURA>`
esperado: 0 277

**Alcance** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | command grep -v "^?? 50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md$" | cut -c4- | LC_ALL=C sort | paste -sd " " -'`; `<MD5 <EXP>/50_encargo.md>`
esperado: 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md / 7bc3df8e45da2786e6cb2c9680602d48

**Staging** `git add -- 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`; `<STAGED>`
esperado: 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md, exactamente

**Commit** `git commit -m "docs(historial): mapa de hashes de las reescrituras de main" -- 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`; `<ARBOL>`
esperado: rc 0; `<ARBOL>` 0

dato: las verificaciones hasta el alcance corren juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_t1verif.sh"` (con `"${TMPDIR:-${TEMP:?}}/simce_s36m_asuntos.sh"` transcrito tal cual de §0.0), antes de cualquier `git add`.
obtenido: md5 c00dc3ceb166eda06197ad3089f0e067 → PASA
obtenido: filas 284 → PASA
obtenido: resuelve 0 → PASA
obtenido: huérfanos 0 → PASA
obtenido: asuntos 0 → PASA
obtenido: cobertura 0 277 → PASA
obtenido: alcance 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md / 7bc3df8e45da2786e6cb2c9680602d48 → PASA
dato: antes del `git add`, conteo de RUT y de rutas personales sobre `<MAPA>` con `command grep -cE` → `0` y `0`, y lectura de sus primeras 20 líneas (`head -20`): sin datos personales; asuntos ya presentes en el historial.
dato: staging y commit corren en `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_t1commit.sh"`, que commitea solo si `<STAGED>` es exactamente la ruta de `<MAPA>`.
obtenido: `<STAGED>` = 50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md → PASA
obtenido: rc 0; `08d54d9 docs(historial): mapa de hashes de las reescrituras de main`; `<ARBOL>` 0 → PASA

- **Estado:** completada.
- **Commits:** `08d54d9` docs(historial): mapa de hashes de las reescrituras de main.
- **Cambios sustantivos:** `<MAPA>` versionado sin cambios (md5 c00dc3ceb166eda06197ad3089f0e067) tras verificar sus 284 filas contra `HEAD`: todo `hash_nuevo` es ancestro de `HEAD`, ningún `hash_anterior` lo es, cada asunto coincide con el de su `hash_nuevo` y la tabla 1 cubre exactamente los 277 commits de `d9a485f^..12ddf5b` (D36-11).
- **Alcance:** `<MAPA>`, el log, `.git/` y `<TMP>` ⊆ ALCANCE de T1; md5 del encargo igual al de la ficha.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) conteo de RUT y rutas personales sobre `<MAPA>` antes de versionarlo, por la regla de `CLAUDE.md` de avisar antes de commitear un dato identificable (alternativa descartada: confiar en la exclusión de `<MAPA>` de `<PRIVACIDAD>`); reversible, solo lectura. (2) commit condicionado a `<STAGED>` en el mismo guion; reversible.
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna.
- **Dudas:** ninguna.

### FASE R: auditoría

dato: inventario R-01 a R-16 escrito antes de auditar en `50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_R_inventario.txt`.
dato: corrección de la línea anterior: el inventario va de R-01 a R-17 (R-17 es el control positivo).

**R-01** `git log -1 --format=%p 99757f8`; `git rev-parse --abbrev-ref HEAD`; `git remote get-url origin | sed 's#.*/##'`
esperado: 7a43615 / main / slep_simce_adecuado.git

**R-02** `git show --name-only --format=%s 99757f8`
esperado: `docs(encargo): mapa_hashes` con exactamente `.../50_encargo.md`

**R-03** `git rev-parse --verify --quiet d501236^{commit}` (recortado a 7); `bash -c 'git rev-list HEAD | command grep -c "^dd01260"'`
esperado: d501236 / 0

**R-04** `git hash-object <MAPA>` contra `git rev-parse 08d54d9:50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`
esperado: los dos hashes iguales

**R-05** `awk '/^\| `/{n++} END{print n+0}' <MAPA>`
esperado: 284

**R-06 y R-07** `git rev-list --abbrev-commit --abbrev=7 HEAD` cruzado por `awk` con las columnas `hash_nuevo` (no presentes) y `hash_anterior` (presentes) de `<MAPA>`
esperado: 0 / 0

**R-08** `git log --abbrev=7 --format="%h %s" HEAD` cruzado por `awk` con las filas de `<MAPA>`, contando discrepancias de asunto
esperado: 0

**R-09** `git rev-list --count d9a485f^..12ddf5b` y `awk` con los `hash_nuevo` distintos de la tabla 1 que no están en ese rango
esperado: 277 / 0

**R-10** `git diff-tree --no-commit-id --name-status -r 08d54d9`; `git log --format="%h %s" 99757f8..HEAD`; `<ARBOL>`
esperado: `A	50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md` / una línea `08d54d9 docs(historial): mapa de hashes de las reescrituras de main` / 0

**R-11 🔒1** `bash -c 'git -c core.quotePath=false diff --name-only 7a43615 HEAD | command grep -v "^50_documentacion/encargos/" | wc -l | tr -d " "'`
esperado: 0

**R-12 🔒2** `<ATRIB>`
esperado: 0 0

**R-13 🔒3** `<MD5 <EXP>/50_encargo.md>` y `<MD5 <MAPA>>`
esperado: 7bc3df8e45da2786e6cb2c9680602d48 / c00dc3ceb166eda06197ad3089f0e067

**R-14 🔒4** `bash -c 'git diff --name-only 7a43615 HEAD -- 10_utils 20_insumos 30_procesamiento docs 00_build.R | wc -l | tr -d " "'`
esperado: 0

**R-15** `git -c core.quotePath=false diff --name-only 99757f8..HEAD`; status sin el log ni `anexos/` contado con `wc -l`; `git hash-object` del encargo contra `git rev-parse 99757f8:<EXP>/50_encargo.md`
esperado: `50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md` / 0 / hashes iguales

**R-16** sin arnés de pruebas (declarado en PRUEBAS del encargo)
esperado: no aplica; el encargo no toca código

**R-17 control positivo** `cp <MAPA> "${TMPDIR:-${TEMP:?}}/simce_s36m_plantado.md"`; con la herramienta de edición, `estado de sesion v35 |` → `estado de sesion v36 |` y `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_asuntos.sh"` sobre la copia; luego `` `12ddf5b` `` → `` `0000000` `` y `<RESUELVE f>` sobre la copia; luego `` `4d647df` `` → `` `d9a485f` `` (primera fila, `hash_anterior`) y `<HUERFANOS f>` sobre la copia
esperado: 1 / 1 / 1

dato: R-01 a R-15 y la copia de R-17 corren juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_r.sh"`; las tres plantas de R-17 van en llamadas separadas, una tras cada edición.
obtenido: R-01 7a43615 / main / slep_simce_adecuado.git → PASA
obtenido: R-02 `docs(encargo): mapa_hashes` con `.../50_encargo.md`, nada más → PASA
obtenido: R-03 d501236 / 0 → PASA
obtenido: R-04 25868ef210be2dbde7e4d47a5d19e15e427ab596 ×2 → PASA
obtenido: R-05 284 → PASA
obtenido: R-06 y R-07 0 / 0 → PASA
obtenido: R-08 0 → PASA
obtenido: R-09 277 / 0 → PASA
obtenido: R-10 `A	50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md` / `08d54d9 docs(historial): mapa de hashes de las reescrituras de main` / 0 → PASA
obtenido: R-11 0 → PASA
obtenido: R-12 0 0 → PASA
obtenido: R-13 7bc3df8e45da2786e6cb2c9680602d48 / c00dc3ceb166eda06197ad3089f0e067 → PASA
obtenido: R-14 0 → PASA
obtenido: R-15 `50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md` / 0 / fcfecce5e595918e630f1c44449a075f4ccc43d5 ×2 → PASA
obtenido: R-16 no aplica (sin arnés; el encargo no toca código)
dato: R-17 `cp 0`; cada cadena a plantar aparece 1 vez en la copia (`command grep -c` → 1 / 1 / 1).
obtenido: R-17 asuntos 1 / resuelve 1 / huérfanos 1 → el instrumento dispara en los tres casos, PASA

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 de partida | `git log -1 --format=%p 99757f8`; `rev-parse --abbrev-ref`; url de origin | 7a43615 / main / slep_simce_adecuado.git | igual | ninguna | ninguna | ninguno | no aplica |
| R-02 | punto de retorno solo con el encargo | `git show --name-only 99757f8` | 1 ruta, título docs(encargo) | igual | ninguna | ninguna | ninguno | no aplica |
| R-03 | H2 de las reescrituras | `rev-parse --verify`; `rev-list HEAD` con `grep -c` | d501236 / 0 | igual | ninguna | ninguna | ninguno | no aplica |
| R-04 | `<MAPA>` versionado sin cambios | `git hash-object` contra el blob de 08d54d9 | iguales | igual | ninguna | ninguna | ninguno | no aplica |
| R-05 | `<FILAS>` 284 | `awk` sobre las filas de datos de `<MAPA>` | 284 | 284 | ninguna | ninguna | ninguno | no aplica |
| R-06 | `<RESUELVE>` 0 | `rev-list --abbrev=7 HEAD` cruzado por `awk` | 0 | 0 | ninguna | ninguna | ninguno | no aplica |
| R-07 | `<HUERFANOS>` 0 | ídem, columna `hash_anterior` | 0 | 0 | ninguna | ninguna | ninguno | no aplica |
| R-08 | `<ASUNTOS>` 0 | `git log --format="%h %s"` cruzado por `awk` | 0 | 0 | ninguna | ninguna | ninguno | no aplica |
| R-09 | `<COBERTURA>` 0 277 | `rev-list --count` del rango y `awk` | 277 / 0 | igual | ninguna | ninguna | ninguno | no aplica |
| R-10 | commit de T1 y árbol limpio | `git diff-tree`; `git log 99757f8..HEAD`; `<ARBOL>` | A `<MAPA>`; 08d54d9; 0 | igual | ninguna | ninguna | ninguno | no aplica |
| R-11 | 🔒1 | comando del encargo | 0 | 0 | ninguna | ninguna | ninguno | no aplica |
| R-12 | 🔒2 | `<ATRIB>` | 0 0 | 0 0 | ninguna | ninguna | ninguno | no aplica |
| R-13 | 🔒3 | md5 del encargo y de `<MAPA>` | 7bc3...2d48 / c00d...e067 | igual | ninguna | ninguna | ninguno | no aplica |
| R-14 | 🔒4 | comando del encargo | 0 | 0 | ninguna | ninguna | ninguno | no aplica |
| R-15 | alcance global y encargo intacto | `git diff --name-only 99757f8..HEAD`; status; `git hash-object` | `<MAPA>` / 0 / iguales | igual | ninguna | ninguna | ninguno | no aplica |
| R-16 | regresión | sin arnés | no aplica | no aplica | ninguna | ninguna | ninguno | no aplica |
| R-17 | control positivo | `<ASUNTOS>`, `<RESUELVE>`, `<HUERFANOS>` sobre la copia plantada | 1 / 1 / 1 | 1 / 1 / 1 | ninguna | ninguna | ninguno | no aplica |

- **Veredicto global:** APROBADO; 0 hallazgos (B/R/A = 0/0/0), declarados junto con el control positivo R-17; 0 ciclos de reparación.
- **Estado:** completada.
- **Commits:** ninguno.
- **Alcance:** el log, `anexos/50_R_inventario.txt` y `<TMP>` ⊆ ALCANCE de FASE R; md5 del encargo igual al de la ficha.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** en R-06, R-07 y R-09 los hashes de `rev-list` se recortan a 7 caracteres (`cut -c1-7`) para que una abreviatura más larga por ambigüedad no produzca falsos negativos (alternativa descartada: el cruce sin recorte); reversible.
- **Errores propios:**
  - error: el `dato:` del inventario dijo `R-01 a R-16` y el inventario llega a R-17; corregido con una línea nueva; costo: ninguno.
  - error: la fila R-05 de la tabla salió con una barra vertical dentro de una celda, que partía la fila; se reescribió esa celda antes de cerrar la sección (edición sobre texto ya escrito, fuera de las excepciones de `<PROT>` §4.3 regla 4); costo: ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna.
- **Dudas:** ninguna.

## Cierre

dato: FASE L paso 1 `<ARBOL>` → 0, sin rutas fuera del log y los anexos (escrito después: FASE L)
dato: `hash_final` `git rev-parse --short HEAD` → `08d54d9`; `fin` `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T15:34:15+00:00` (escrito después: FASE L)

1. **Resumen:** entró un encargo de una tarea (T1: verificar `<MAPA>` contra `HEAD` y versionarlo sin cambios); tres fases con sección (FASE 0, T1, FASE R) más FASE L; T1 completada. Las 284 filas de `<MAPA>` (277 de la tabla 1 y 7 de la tabla 2) resuelven en `HEAD`, sus hashes anteriores no son alcanzables, los asuntos coinciden y la tabla 1 cubre exactamente `d9a485f^..12ddf5b`.
2. **Commits** (`git log 99757f8..HEAD --oneline`, más el punto de retorno):
   - `99757f8` docs(encargo): mapa_hashes (FASE 0, hash_inicial)
   - `08d54d9` docs(historial): mapa de hashes de las reescrituras de main (T1)
3. **Auditoría (FASE R):** tabla en la sección de FASE R; veredicto APROBADO; BLOQUEA 0, REPARA 0, ADVIERTE 0; reparados 0; abiertos 0; control positivo R-17 disparó en los tres casos.
4. Verificación de invariantes (FASE R):
   - 🔒1 nada cambia fuera de encargos/: PASA (`0`)
   - 🔒2 sin atribución: PASA (`0 0`)
   - 🔒3 encargo y mapa intactos: PASA (`7bc3df8e45da2786e6cb2c9680602d48` / `c00dc3ceb166eda06197ad3089f0e067`)
   - 🔒4 nada de datos, código ni publicación: PASA (`0`)
5. **Decisiones del usuario:** D36-11 (mapa en el expediente; los registros que citan hashes anteriores no se reescriben), aplicada; D36-12 (purga en GitHub de los commits inalcanzables), fuera del encargo, queda al titular.
6. **Cifras críticas:** intactas; `<MAPA>` versionado byte a byte (md5 c00dc3ceb166eda06197ad3089f0e067; blob 25868ef210be2dbde7e4d47a5d19e15e427ab596); encargo 7bc3df8e45da2786e6cb2c9680602d48.
7. **Dudas y pendientes:** ninguno.
8. **Errores propios:**
- error propio: FASE R, el `dato:` del inventario dijo `R-01 a R-16` (llega a R-17); corregido con línea nueva; costo: ninguno.
- error propio: FASE R, celda de la fila R-05 reescrita tras escribirse (barra vertical que partía la fila), fuera de las excepciones de §4.3 regla 4; costo: ninguno.
9. **Notas para el revisor:** el emparejamiento de la historia anterior (qué `hash_anterior` corresponde a cada fila) no se re-derivó: el encargo no tiene red y los hashes anteriores no son alcanzables aquí; lo verificado es el lado `HEAD` de cada fila. La tabla 2 no la cubre `<COBERTURA>`; sus 7 filas pasan `<RESUELVE>`, `<HUERFANOS>` y `<ASUNTOS>`.
10. **Estado de cierre:** commiteados `99757f8` y `08d54d9`, más `docs(log)` (su hash va en el reporte); nada publicado; queda al titular el `git push` y la solicitud de purga a GitHub (D36-12).
11. **Calidad del encargo:**

| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |
|---|---|---|---|---|
ninguno

12. **Fricciones de entorno:** ninguna (el offset `+00:00` de `date` es la fricción conocida, registrada como `dato:`).
13. **Intervenciones y tiempos:** ninguna intervención; inicio `2026-11-11T15:27:56+00:00`, fin `2026-11-11T15:34:15+00:00`, duración 00:06; compactaciones de contexto 0.

**FASE L, paso 5** `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261109_mapa_hashes/50_log.md; echo "rc $?"'` (escrito después: FASE L)
esperado: rc 0
obtenido: `valida 50_documentacion/encargos/202611/20261109_mapa_hashes` / `rc 0` → PASA
dato: el validador imprime además el aviso `[ locale ]` de LANG y LC_CTYPE exportados (escrito después: FASE L)

**FASE L, paso 6** `<PRIVACIDAD>` (escrito después: FASE L)
esperado: rc 1 / rc 1
obtenido: rc 1 / rc 1 → PASA
dato: lectura del log y de `anexos/50_R_inventario.txt`: sin filas de datos ni nombres de personas (escrito después: FASE L)

**FASE L, paso 7** (exento de pre-registro; medido en `bash "${TMPDIR:-${TEMP:?}}/simce_s36m_l67.sh"` antes de anexar el `obtenido:` del paso 6 y este bloque)
dato: `wc -c` 23926; `wc -l` 303; `head -1` `---`; termina en LF; `^### FASE` 3 (FASE 0, T1, FASE R: igual a lo esperado); `^## J` 1; paridad `^esperado:` 31 + `^- faltante: esperado de` 0 contra `^obtenido:` 30, y el `obtenido:` del paso 6, anexado después de medir, la cierra en 31 = 31 (escrito después: FASE L)

**FASE L, paso 8** `git add --` del log y `anexos/50_R_inventario.txt`; `98_indexar_encargos.R --repo=. --escribir`; `git add --` del índice si cambió; `<STAGED>`; `git commit -m "docs(log): mapa_hashes" -- <lista>` (en `"${TMPDIR:-${TEMP:?}}/simce_s36m_commit_log.sh"`; el resultado va en el reporte, porque el log no puede contener su propio commit)
