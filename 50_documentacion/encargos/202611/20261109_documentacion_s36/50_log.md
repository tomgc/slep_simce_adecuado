---
expediente: 50_documentacion/encargos/202611/20261109_documentacion_s36
repo: slep_simce_adecuado
encargo_md5: "16ffb38a5fd15498b40c9af92bf9dbfe"
origen: ninguno
inicio: 2026-11-09T16:46:40+00:00
fin: 2026-11-09T16:49:48+00:00
hash_inicial: "25400c5"
hash_final: "317040d"
auditoria_redaccion: {nivel: 1, puntaje: 0, rondas: 2, bloquea: 1, corregir: 11, menor: 15, menor_abiertos: 0, completa: "si"}
resultado_meta: cumplida
tareas: {completadas: 1, congeladas: 0, no_ejecutadas: 0}
fase_r: {veredicto: "APROBADO CON ADVERTENCIAS", bloquea: 0, repara: 0, advierte: 1, reparados: 0}
invariantes: {pasa: 4, total: 4}
errores_propios: 2
defectos_encargo: 0
fricciones_entorno: 1
dudas_abiertas: 0
intervenciones_humanas: 0
compactaciones_contexto: {n: 0, fases: []}
subagentes: {opus: 0, intermedios: 0}
push: "no"
---

# Log · documentacion_s36

- **Meta:** instalar en el repo los cuatro textos redactados que cierran los pendientes 2 y 3 del traspaso v35 (paso de `LANG` y aclaración de `herramientas_dev` en el README; D35-7 a D35-27 en su propio archivo de decisiones, con las dos citas que apuntan a ellas); un commit de contenido, sin push.
- **Fecha:** 2026-11-09.
- **Repo y rama:** `slep_simce_adecuado`, `main`.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_documentacion_s36` · **ORIGEN:** `ninguno`.
- **ENTORNO:** Claude Code en la estación Windows del titular (`estacion_windows`), shell Git Bash, directorio de trabajo en la raíz del repo; titular presente de punta a punta; sin red.
- **EJECUCIÓN:** declarada esfuerzo `high`, orquestador el modelo de la sesión, subagentes 0, total Opus 0; modo real de la sesión: `high`, sin subagentes.
- **AUDITORÍA DE REDACCIÓN:** nivel 1 (puntaje 0: ningún criterio C1 a C8); 2 rondas; anexo del encargo.
- **Grafo:** T1 única tarea, sin dependencias; luego FASE R y FASE L.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 0 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.

## J. Juicio
- Meta y resultado: instalar los cuatro textos de los pendientes 2 y 3 del traspaso v35 en un commit, sin push → cumplida.
- Estado por tarea: T1 completada (317040d).
- Commits: 1 en 25400c5..317040d (`git log --oneline --first-parent`; sin contar `docs(encargo)`, que es hash_inicial, ni `docs(log)`), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/1; reparados 0; abiertos 0 (ninguno).
- Auditoría de redacción: nivel 1 (puntaje 0); rondas 2; BLOQUEA/CORREGIR/MENOR = 1/11/15; MENOR abiertos 0.
- Invariantes: 4/4 PASA; FALLA: ninguno.
- Cifras críticas: intactas (evidencia: md5 de cada destino igual al de su insumo; encargo `16ffb38a5fd15498b40c9af92bf9dbfe`; 🔒4 `0`).
- Decisiones autónomas de mayor riesgo: ninguna.
- Desviaciones respecto del encargo: un heredoc vacío sin efecto en un comando de FASE 0; R-12 anexado al inventario durante la auditoría.
- Calidad del encargo: 0 defectos; escapo_a: ninguno.
- Dudas abiertas: 0; ninguna.
- Errores propios: 2 registrados (4.1); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: la redacción del texto nuevo del README (esta sesión solo verificó identidad con los insumos).
- No publicado / queda al usuario: push retenido (`git push`).
- Ejecución: modo de sesión high; subagentes 0, por contrato; duración 00:03 (ficha); compactaciones de contexto 0.

## Registro por fase

### FASE 0: log, punto de retorno e hipótesis

dato: testigo `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36d\n" > "${TMPDIR:-${TEMP:?}}/simce_s36d_testigo.txt" && echo raiz_ok'` → `raiz_ok` (escrito después: paso 0)
dato: llamada de las rutas corrida; salida solo a la terminal (escrito después: paso 0)
dato: herramientas de lectura, edición (`testigo s36d` → `testigo s36d editado`) y escritura ejercidas sobre `"${TMPDIR:-${TEMP:?}}/simce_s36d_testigo.txt"` y `"${TMPDIR:-${TEMP:?}}/simce_s36d_lecturas.txt"` sin denegación (escrito después: paso 0)
dato: lectura previa al testigo: `ls -la` del expediente (además del encargo, que no se lista)
dato: lectura posterior al testigo y anterior al log: encabezados de `<PROT>` y sus L818-1002 y L1585-1924
dato: lectura posterior al testigo y anterior al log: `head`/`sed -n 1,130p` del log de `20261109_inclusion_resultados_simbologia` como referencia de formato
dato: inicio `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-09T16:46:40+00:00`
- friccion: `TZ=America/Santiago date -Iseconds` en Git Bash devuelve offset `+00:00` (sin base de zonas horarias), no la hora de Santiago → se registra tal cual; `fin` se mide con la misma forma.

**H1** `bash -c 'basename "$(git remote get-url origin)" .git'`; `git rev-parse --short HEAD`; `git rev-parse --short origin/main`; `git symbolic-ref --short HEAD`; `bash -c 'git stash list | wc -l | tr -d " "'`; `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'`
esperado: slep_simce_adecuado / 338e64f / 338e64f / main / 0 / 0

**Árbol** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`
esperado: las 6 líneas `??` de §4 paso 2 (encargo, log y cuatro insumos), exactamente

**H2** `<MD5>` de los cuatro insumos (orden readme, publicacion, decision_referente, decision_cierre_v34), de los tres destinos existentes (README, publicacion, decision_referente), `test -e` del destino nuevo y prueba de Rscript con el indexador
esperado: bd0591cec2d6b22a9e80bc6b6ebd79bf / 2fdb2d0f47ebf2ed6f3e4eb87bdc470a / f5658adf2a9b83c497e0f94daba70d20 / 333b0fe170ceb410becb8de1f8d18671 / 243df934249456e26802c79fd0a6bfa4 / 510544bd7578edf1ea5dbdec946fd35f / b780dda1c254da032994cfffc0150307 / 1 / 0

dato: las tres mediciones corren juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36d_fase0.sh"`.
obtenido: H1 slep_simce_adecuado / 338e64f / 338e64f / main / 0 / 0 → PASA
obtenido: árbol, las 6 líneas `??` de §4 paso 2, idénticas y en el mismo orden → PASA
obtenido: H2 bd0591cec2d6b22a9e80bc6b6ebd79bf / 2fdb2d0f47ebf2ed6f3e4eb87bdc470a / f5658adf2a9b83c497e0f94daba70d20 / 333b0fe170ceb410becb8de1f8d18671 / 243df934249456e26802c79fd0a6bfa4 / 510544bd7578edf1ea5dbdec946fd35f / b780dda1c254da032994cfffc0150307 / 1 / 0 → PASA
- error propio: el comando que anexó al log los esperados de H1, árbol y H2 llevaba por delante un heredoc vacío sin efecto (`cat >> /dev/null`), que el ENTORNO prohíbe, y fue de una línea compuesta en vez de un archivo `<TMP>` (costo: ninguno sobre el árbol; sin rehecho).

**Paso 3** `bash -c 'md5sum 50_documentacion/encargos/202611/20261109_documentacion_s36/50_encargo.md | cut -d" " -f1'` → `encargo_md5`
dato: encargo_md5 `16ffb38a5fd15498b40c9af92bf9dbfe`; `auditoria_redaccion` copiada a la ficha (BLOQUEA 1+0 = 1, CORREGIR 9+2 = 11, MENOR 13+2 = 15, abiertos 0, completa si).

**Paso 4** `git add --` de las 5 rutas, `<STAGED>`, `git commit -m "docs(encargo): documentacion_s36" -- <las 5 rutas>`, `hash_inicial`, `<ARBOL>` (en `"${TMPDIR:-${TEMP:?}}/simce_s36d_commit_encargo.sh"`)
esperado: STAGED = las 5 rutas (encargo y cuatro insumos); commit rc 0; ARBOL 0
obtenido: STAGED = `50_encargo.md`, `anexos/50_insumo_decision_cierre_v34.md.txt`, `anexos/50_insumo_decision_referente.md.txt`, `anexos/50_insumo_publicacion.md.txt`, `anexos/50_insumo_readme.md.txt`; commit rc 0; `hash_inicial` `25400c5`; ARBOL `0` → PASA

- **Estado:** completada.
- **Commits:** `25400c5` docs(encargo): documentacion_s36.
- **Cambios sustantivos:** log creado; encargo e insumos congelados en `hash_inicial` (desviación declarada por el encargo respecto de `<PROT>` §2.5).
- **Alcance:** el log y el commit `docs(encargo)` ⊆ ALCANCE de FASE 0; md5 del encargo medido en el paso 3.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** ninguna.
- **Errores propios:** uno (heredoc vacío, registrado arriba).
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** una (offset de `TZ`, registrada arriba).
- **Intervenciones humanas:** ninguna.
- **Dudas:** ninguna.

### FASE T1: instalar los cuatro textos

**Paso 0** `bash -c 'git status --porcelain -- README.md 50_documentacion/activa | wc -l | tr -d " "'`
esperado: 0

**Copias** `bash -c 'cp 50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/<insumo> <destino>; echo $?'`, una llamada por archivo (§4bis)
esperado: 0 / 0 / 0 / 0
obtenido: Paso 0 `0` → PASA
obtenido: copias readme `0`, publicacion `0`, decision_referente `0`, decision_cierre_v34 `0` → PASA
dato: la línea `obtenido:` del Paso 0 va junto a la de las copias; su `esperado:` estaba escrito antes de correrlo.

**Staging y verificación** `git add --` de los cuatro destinos, `<STAGED>`, `<MD5>` de cada destino (orden README, publicacion, decision_referente, decision_cierre_v34), `<NUMSTAT>` con `hash_inicial` `25400c5`, `git grep` del nombre viejo, alcance y md5 del encargo (en `"${TMPDIR:-${TEMP:?}}/simce_s36d_t1_verif.sh"`)
esperado: STAGED = las 4 rutas de destino
esperado: md5 bd0591cec2d6b22a9e80bc6b6ebd79bf / 2fdb2d0f47ebf2ed6f3e4eb87bdc470a / f5658adf2a9b83c497e0f94daba70d20 / 333b0fe170ceb410becb8de1f8d18671
esperado: NUMSTAT `4 167 …20260924_decision_referente_traspasos.md` / `174 0 …20260925_decision_cierre_pendientes_v34.md` / `1 1 …publicacion_github_pages.md` / `6 2 README.md` (tabuladas, en ese orden)
esperado: git grep del nombre viejo `0`
esperado: alcance = las 4 rutas de destino separadas por espacio; md5 del encargo `16ffb38a5fd15498b40c9af92bf9dbfe`
obtenido: STAGED = `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md`, `50_documentacion/activa/publicacion_github_pages.md`, `README.md` → PASA
obtenido: md5 bd0591cec2d6b22a9e80bc6b6ebd79bf / 2fdb2d0f47ebf2ed6f3e4eb87bdc470a / f5658adf2a9b83c497e0f94daba70d20 / 333b0fe170ceb410becb8de1f8d18671 → PASA (iguales a §4bis; partida §1 distinta, medida en H2)
obtenido: NUMSTAT `4 167 …20260924_decision_referente_traspasos.md` / `174 0 …20260925_decision_cierre_pendientes_v34.md` / `1 1 …publicacion_github_pages.md` / `6 2 README.md` → PASA
obtenido: git grep del nombre viejo `0` → PASA
obtenido: alcance = las 4 rutas, idénticas a lo esperado; md5 del encargo `16ffb38a5fd15498b40c9af92bf9dbfe` → PASA

**Commit** `git commit -m "docs(sesion 36): LANG y herramientas_dev en el README; D35-7 a D35-27 en su archivo" -- <las 4 rutas>`; `git rev-parse --short HEAD`; `<ARBOL>`
esperado: commit rc 0; ARBOL 0
obtenido: commit rc 0; HEAD `317040d`; ARBOL `0` → PASA

- **Estado:** completada.
- **Commits:** `317040d` docs(sesion 36): LANG y herramientas_dev en el README; D35-7 a D35-27 en su archivo.
- **Cambios sustantivos:** los cuatro destinos reciben por `cp` el contenido de sus insumos (D36-5, D36-7); ninguna edición con la herramienta de edición sobre ellos.
- **Alcance:** las 4 rutas de T1 ⊆ ALCANCE de T1; md5 del encargo igual a `encargo_md5`.
- **Regresión:** no tocó código (sin arnés, declarado).
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** ninguna.
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna.
- **Dudas:** ninguna.

### FASE R: auditoría

dato: inventario R-01 a R-11 en `50_documentacion/encargos/202611/20261109_documentacion_s36/anexos/50_R_inventario.txt`, escrito antes de auditar.

**Re-derivación e invariantes** (en `"${TMPDIR:-${TEMP:?}}/simce_s36d_r.sh"`)
esperado: R-01 md5 de `git show 338e64f:<destino>` = 243df934249456e26802c79fd0a6bfa4 / 510544bd7578edf1ea5dbdec946fd35f / b780dda1c254da032994cfffc0150307 y `git cat-file -e 338e64f:<destino nuevo>` rc distinto de 0
esperado: R-02 `git hash-object` de cada destino igual al de su insumo: 4 líneas `igual`
esperado: R-03 `git diff --stat 25400c5 HEAD` con las cifras `171` (referente: 4+167), `174` (nuevo), `2` (publicacion), `8` (README) y `4 files changed, 185 insertions(+), 170 deletions(-)`
esperado: R-04 `command grep -c` del nombre viejo en README.md y publicacion_github_pages.md `0` y `0`
esperado: R-05 🔒1 `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md 50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md 50_documentacion/activa/publicacion_github_pages.md README.md`
esperado: R-06 🔒2 `0 0`
esperado: R-07 🔒3 `0`
esperado: R-08 🔒4 `0`
esperado: R-09 `git diff --name-only 25400c5 HEAD` = las 4 rutas de T1; residuo `<ARBOL>` `0`; md5 del encargo `16ffb38a5fd15498b40c9af92bf9dbfe`
esperado: R-11 control positivo: md5 de `"${TMPDIR:-${TEMP:?}}/simce_s36d_plantado.txt"` tras agregarle una línea distinto de `bd0591cec2d6b22a9e80bc6b6ebd79bf`
obtenido: R-01 243df934249456e26802c79fd0a6bfa4 / 510544bd7578edf1ea5dbdec946fd35f / b780dda1c254da032994cfffc0150307; `cat-file rc 128` → PASA
obtenido: R-02 igual / igual / igual / igual → PASA
obtenido: R-03 `171` / `174` / `2` / `8`; `4 files changed, 185 insertions(+), 170 deletions(-)` → PASA
obtenido: R-04 `0` / `0` → PASA
obtenido: R-05 🔒1 `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md 50_documentacion/activa/decisiones/20260925_decision_cierre_pendientes_v34.md 50_documentacion/activa/publicacion_github_pages.md README.md` → PASA
obtenido: R-06 🔒2 `0 0` → PASA
obtenido: R-07 🔒3 `0` → PASA
obtenido: R-08 🔒4 `0` → PASA
obtenido: R-09 las 4 rutas de T1; residuo `0`; md5 del encargo `16ffb38a5fd15498b40c9af92bf9dbfe` → PASA
obtenido: R-11 `cp rc 0`; línea `linea plantada` agregada con la herramienta de edición; md5 `4615cdabcb418e5f4d4d0607b05aaa03` ≠ `bd0591cec2d6b22a9e80bc6b6ebd79bf` → el instrumento dispara
dato: R-10 sin arnés de pruebas: el encargo no toca código (PRUEBAS, declarado).
dato: R-12 agregado al inventario durante la auditoría (lo omití al derivarlo); `ls -la` del expediente antes del testigo, solo lectura, sin efecto sobre la meta.
- error propio: R-12 no entró al inventario antes de auditar; se anexó durante la auditoría, declarado en el propio inventario (costo: 1 edición).

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | md5 de partida de los destinos | `git show 338e64f:<f> \| md5sum`; `git cat-file -e` | 3 md5 de §1; rc ≠ 0 | iguales; rc 128 | ninguna | ninguna | ninguno | ninguna |
| R-02 | destino = insumo | `git hash-object` de ambos | 4 `igual` | 4 `igual` | ninguna | ninguna | ninguno | ninguna |
| R-03 | numstat de T1 | `git diff --stat 25400c5 HEAD` | 171/174/2/8; 185+, 170- | igual | ninguna | ninguna | ninguno | ninguna |
| R-04 | sin citas del nombre viejo | `command grep -c` por archivo | 0 / 0 | 0 / 0 | ninguna | ninguna | ninguno | ninguna |
| R-05 | 🔒1 | comando de §3 | 4 rutas | 4 rutas | ninguna | ninguna | ninguno | ninguna |
| R-06 | 🔒2 | `<ATRIB>` | 0 0 | 0 0 | ninguna | ninguna | ninguno | ninguna |
| R-07 | 🔒3 | comando de §3 | 0 | 0 | ninguna | ninguna | ninguno | ninguna |
| R-08 | 🔒4 | comando de §3 | 0 | 0 | ninguna | ninguna | ninguno | ninguna |
| R-09 | alcance global y md5 del encargo | `git diff --name-only`; `<ARBOL>`; `md5sum` | 4 rutas; 0; encargo_md5 | igual | ninguna | ninguna | ninguno | ninguna |
| R-10 | regresión | sin arnés (declarado) | no aplica | no aplica | ninguna | ninguna | ninguno | ninguna |
| R-11 | control positivo | md5 de copia plantada | ≠ md5 del insumo | distinto | ninguna | ninguna | ninguno | ninguna |
| R-12 | lectura previa al testigo | líneas `dato:` de FASE 0 | juzgada por §0.3 | `ls -la` del expediente | ADVIERTE | registrar | ninguno | ninguna |

dato: veredicto global `APROBADO CON ADVERTENCIAS`; B/R/A = 0/0/1; reparados 0; 0 ciclos.

- **Estado:** completada.
- **Commits:** ninguno.
- **Cambios sustantivos:** ninguno; solo auditoría e inventario.
- **Alcance:** el log y `anexos/50_R_inventario.txt` ⊆ ALCANCE de FASE R; md5 del encargo igual a `encargo_md5`.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** ninguna.
- **Errores propios:** uno (R-12 fuera del inventario inicial, registrado arriba).
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna.
- **Dudas:** ninguna.

## Cierre

1. **Resumen:** entró el encargo de documentación de la sesión 36; tres fases (FASE 0, T1, FASE R) más FASE L; T1 completada.
2. **Commits** (`git log --oneline --first-parent 25400c5..HEAD`, más `hash_inicial`):
   - `25400c5` docs(encargo): documentacion_s36 (FASE 0)
   - `317040d` docs(sesion 36): LANG y herramientas_dev en el README; D35-7 a D35-27 en su archivo (T1)
3. **Auditoría:** tabla en FASE R; veredicto `APROBADO CON ADVERTENCIAS`; BLOQUEA 0, REPARA 0, ADVIERTE 1 (R-12); reparados 0; abiertos 0.
4. Verificación de invariantes (FASE R, R-05 a R-08, salida literal en esa sección):
   - 🔒1 solo cambian los cuatro destinos: PASA (4 rutas)
   - 🔒2 sin atribución: PASA (`0 0`)
   - 🔒3 encargo e insumos intactos: PASA (`0`)
   - 🔒4 nada de datos ni código del pipeline: PASA (`0`)

5. **Decisiones del usuario:** D36-5, D36-6 y D36-7 (§2 del encargo), aplicadas tal cual: separación del archivo, L280 sin tocar, remisión conservada con aclaración.
6. **Cifras críticas:** cada destino idéntico a su insumo (md5 y `git hash-object`, R-02); encargo intacto (md5 `16ffb38a5fd15498b40c9af92bf9dbfe`); sin cambios en `10_utils`, `20_insumos`, `30_procesamiento` ni `docs` (🔒4).
7. **Dudas:** ninguna.
8. **Errores propios:**

- error propio: FASE 0, heredoc vacío y comando compuesto de una línea al anexar los esperados (costo: ninguno sobre el árbol).
- error propio: FASE R, R-12 no entró al inventario antes de auditar (costo: 1 edición).

9. **Notas para el revisor:** leer el texto nuevo del README (paso 2 de «Cómo correr en una máquina nueva» y «Portabilidad cross-OS»): esta sesión verificó identidad con los insumos, no su redacción.
10. **Estado de cierre:** commiteados `25400c5`, `317040d` y el `docs(log)` de esta fase; sin push (queda al titular).
11. **Calidad del encargo:**

| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |
|---|---|---|---|---|
ninguno

12. **Fricciones de entorno:**

- friccion: FASE 0, `TZ=America/Santiago date -Iseconds` en Git Bash devuelve offset `+00:00` → registrado tal cual.
13. **Intervenciones y tiempos:** ninguna intervención; inicio `2026-11-09T16:46:40+00:00`, fin `2026-11-09T16:49:48+00:00`, duración 00:03 (medida de la ficha); compactaciones de contexto 0.

dato: FASE L paso 1 `<ARBOL>` → `0` (escrito después: FASE L)
dato: `hash_final` `git rev-parse --short HEAD` → `317040d` (escrito después: FASE L)
dato: `fin` `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-09T16:49:48+00:00` (escrito después: FASE L)

**FASE L, paso 5** `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261109_documentacion_s36/50_log.md; echo "rc $?"'` (escrito después: FASE L)
esperado: rc 0
obtenido: primer intento `invalida ...: invariantes` / `- invariantes: ## Cierre no trae el punto «Verificación de invariantes»` / `rc 1`; corregido el rótulo y la forma del punto 4 del Cierre (de tabla a líneas `- 🔒N ...: PASA`); reintento `valida 50_documentacion/encargos/202611/20261109_documentacion_s36` / `rc 0` → PASA
dato: el validador imprime además el aviso `[ locale ]` de LANG y LC_CTYPE exportados.

**FASE L, paso 6** `<PRIVACIDAD>` (escrito después: FASE L)
esperado: rc 1 / rc 1
obtenido: rc 1 / rc 1 → PASA
dato: lectura del log y de `anexos/50_R_inventario.txt`: sin filas de datos ni nombres de personas (escrito después: FASE L)

**FASE L, paso 7** (exento de pre-registro; en `"${TMPDIR:-${TEMP:?}}/simce_s36d_l.sh"`, medido antes de anexar este bloque)
dato: `ls -l` 19975 bytes; `wc -l` 249; `head -1` `---`; termina en LF; `^### FASE` 3 (FASE 0, T1, FASE R: igual a lo esperado); `^## J` 1 (escrito después: FASE L)
dato: paridad medida antes de reponer el `obtenido:` del paso 6: `^esperado:` 24, `^- faltante: esperado de` 0, `^obtenido:` 23; la línea `obtenido:` del paso 6 de arriba cierra la diferencia (24 = 24) (escrito después: FASE L)

**FASE L, paso 8** `git add --` del log y `anexos/50_R_inventario.txt`; `98_indexar_encargos.R --repo=. --escribir`; `git add --` del índice si cambió; `<STAGED>`; `git commit -m "docs(log): documentacion_s36" -- <lista>` (en `"${TMPDIR:-${TEMP:?}}/simce_s36d_commit_log.sh"`; el resultado va en el reporte, porque el log no puede contener su propio commit)
