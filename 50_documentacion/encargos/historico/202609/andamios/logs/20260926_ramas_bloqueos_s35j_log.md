# Log: diagnóstico de ramas y pendientes bloqueados (s35j) (slep_simce_adecuado)

- Meta: que el titular pueda decidir los pendientes 8, 10, 12 y 13 del traspaso v34 leyendo solo este log (una ficha por pendiente, con una pregunta cerrada y una recomendación), sin cambiar el producto, las ramas ni los paquetes.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: `c504ef8` (commit de T0, H4)
- Encargo: `50_documentacion/activa/encargos/encargo_ramas_bloqueos_s35j.md`, md5 `59a36755270b703cb80cd674382362a8` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); el harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow; todo en serie.
- Grafo y olas (copiados de §5): orden fijo FASE 0 (con las shells), T0, R1, R2, R3, FASE R, FASE L con el push.
- Topes: 3 intentos por medición; 2 ciclos de reparación; 1 reintento por comando
- Carpeta de trabajo: `$TMPDIR/s35j/` (`$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`); worktree de prueba en `$TMPDIR/wt_s35j` (autorización 3). Inicio: 2026-09-26 16:13.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: meta cumplida. Los pendientes 8, 10, 12 y 13 tienen una ficha cada uno, con una pregunta cerrada y una recomendación (§7 del Cierre: seis preguntas). Recomendaciones: borrar `respaldo_prerebase_20260824` y `respaldo_normativos_20260824` (0 archivos únicos); conservar `gobernanza/v16` hasta rescatar su log del contrato; dejar `feat/contrato-contexto`; sacar `suitedoc` del lock (su remoto existe, pero es privado); Simce 2026, bloqueado hasta la base de la Agencia. Sin cambios en el producto, las ramas ni los paquetes.
- Estado por tarea: FASE 0 completa · T0 completa · R1 completa · R2 completa · R3 completa · FASE R: 0 BLOQUEA, 0 REPARA, 11 ADVIERTE (R-32 a R-42) · FASE L en este Cierre.
- Commits: c504ef8 (T0, punto de retorno) y el `docs(log)` de este archivo (hash en el reporte final).
- Auditoría (FASE R): sin subagentes. 31 de 31 afirmaciones confirmadas con instrumentos distintos: `git merge-tree` en vez del worktree, Python en vez de R y `grep`, `curl` sin credenciales en vez de `gh`, `openssl dgst` y `cmp`. Los controles positivos dispararon (I-1, I-5, identidad con `md5` y `hash-object`, `cmp`, backlog y alcance simulado). Veredicto: APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-5 PASA en el estado final (R.3); I-3 se mide otra vez tras el commit del log (reporte final).
- Cifras críticas: archivos de commits «+»: (a) 2, (b) 6, (c) 7 de 15; «−»: 7 de 7 en `main`; merge de prueba: 9 conflictos y un traspaso en la raíz; cherry-pick: 1 + 1; datos versionados tras integrar: 29; lock 40, biblioteca 58, 18 fuera, 5 usos directos; `herramientas_dev` privado (404) con `suitedoc` 0.5.1 desde el 2026-08-30; Simce: 9 años por nivel, 0 de 2026, publicado hasta 2025; `docs/` 42ab9300…/883f76bc…, sin cambio.
- Decisiones autónomas de mayor riesgo: D1-b y D2-a (leer, sin escribir, los repositorios `slep_minuta_buenas_senales` y `herramientas_dev`, y consultar su visibilidad, fuera de los insumos de §1); D1-c (cherry-pick de prueba en el worktree autorizado); D1-a (POLITICA en la clase a); D0-b (no detener el R huérfano de otro proyecto).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE. Las lecturas fuera de los insumos de §1 (D1-b, D2-a) y la prueba adicional con cherry-pick (D1-c) se declaran. CLAUDE.md sin crear (§11, D2).
- Dudas abiertas: Q-70 (R huérfano de `slep-central-datos`), Q-71 (la redacción «`suitedoc` sin remoto» de los traspasos), Q-72 (el manifiesto dice que los xlsx no se versionan), más las seis preguntas de las fichas.
- Errores propios: solo de instrumento, todos corregidos antes de registrar (`cherry-pick --abort` tras un `-n` de un commit; comillas en `bash -c`; un regex demasiado largo; `+` en vez de `>`; `gzip` en vez de `zlib`); una imprecisión escrita en R3.2 («gzip») y una en R.9 (el orden del `sed` del encabezado), declaradas en el Cierre §8 sin reescribir. Ninguno tocó el producto.
- Qué debe verificar el revisor por sí mismo: probar en una copia del lock la vía `renv::snapshot(exclude = "suitedoc")` antes de decidir el pendiente 8 (R-36); confirmar que acepta publicar las citas de metadatos de dos repositorios privados (Cierre §9); decidir sobre el PID 54442 (Q-70).
- No publicado / queda al usuario: las seis decisiones de las fichas y Q-70 a Q-72. El push de este log va en el reporte final.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite, aunque el harness tenía «ultracode» activo); git 2.54.0, R 4.5.2 con `--vanilla` (sin activar `renv`), Python 3.14.7; un worktree temporal desacoplado, ya quitado; 16:13 a 16:40.

### FASE 0: log, punto de retorno y premisas

**Estado:** completa. **Commits:** `c504ef8` (T0). **Cambios sustantivos:** ninguno en el producto.

**Paso 1. Shells de la sesión anterior** (autorización 2). La sesión empezó tras `/clear`; el orquestador no ve una lista de tareas en segundo plano de la sesión anterior, así que se midieron los procesos del sistema.
- `ps -axo pid,ppid,etime,command | /usr/bin/grep -E "v3_medir|until|pgrep"` (sin la línea del propio `grep`)
esperado: bucles `until ! pgrep -f v3_medir.R …`, si quedaran
obtenido: ninguno (código 1 del `grep`, 0 líneas)
- `ps aux | /usr/bin/grep '[R]script.*v3_medir'`
esperado: vacío
obtenido: vacío (código 1)
- **Se detuvo:** nada; no había shells que detener.
- **Hallazgo no enumerado** (regla de detención, último punto; se registra como duda Q-70, no se toca): un R huérfano, PID 54442, `R --no-echo --no-restore --file=r11.R`, padre `launchd` (PPID 1), iniciado el 2026-09-25 a las 21:01, con 100 % de CPU y 19 h de ejecución. Su directorio de trabajo es `/private/tmp/claude-501/-Users-tomgc-Projects-slep-central-datos/…/scratchpad/fase_r/auditor_2`: pertenece a **otro proyecto** (`slep-central-datos`), no a `v3_medir.R`. La autorización 2 no lo cubre y no se detuvo.

**Paso 2.** Log creado antes de H1, con el encabezado y el slot J vacío. Por eso H1 muestra también la línea del propio log. Las secciones siguen la plantilla del Apéndice y se anexan una tras otra.

**H1.** `git -C "$RAIZ" status --porcelain` (salida en `$TMPDIR/s35j/h1.txt`)
esperado: exactamente ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` y `?? 50_documentacion/activa/encargos/encargo_ramas_bloqueos_s35j.md`, más el log
obtenido: status_codigo=0
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
?? 50_documentacion/activa/encargos/encargo_ramas_bloqueos_s35j.md
?? 50_documentacion/andamios/logs/20260926_ramas_bloqueos_s35j_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l` y `git -C "$RAIZ" worktree list`
esperado: 0; solo el árbol principal
obtenido: 0 (stash_codigo=0); `/Users/tomgc/Projects/slep_simce_adecuado 40ac367 [main]` (wt_codigo=0)

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0, sin salida: no había nada nuevo), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: 40ac367 y 40ac367
obtenido: 40ac367 y 40ac367

**H4.** `md5 -q` del encargo; I-1 e I-5 guardados en `$TMPDIR/s35j/`
esperado: 59a36755270b703cb80cd674382362a8 (mensaje de entrega)
obtenido: 59a36755270b703cb80cd674382362a8

- I-1 (`git for-each-ref --format='%(refname) %(objectname)'`, en `i1_fase0.txt`, 8 refs):
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/gobernanza/v16 667e5adaaadcf35ee1a41518d352aa6836178eae
refs/heads/main 40ac3676e0a4577f81d001045781e4aeed7ae8aa
refs/heads/respaldo_normativos_20260824 b9426c22d45ed9b37832cb20a53bcf89bb13bf0c
refs/heads/respaldo_prerebase_20260824 e86b0d250d52d161725cef7d224a7c6c718d3b71
refs/remotes/origin/HEAD 40ac3676e0a4577f81d001045781e4aeed7ae8aa
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main 40ac3676e0a4577f81d001045781e4aeed7ae8aa
```
  `refs/remotes/origin/HEAD` es simbólica (`git symbolic-ref` → `refs/remotes/origin/main`): su `objectname` sigue a `origin/main` y cambiará con el push; se trata con la misma excepción que `origin/main` (ver FASE R).
- I-5 (`$TMPDIR/s35j/i5_fase0.txt`: por cada entrada de `renv/library/macos/R-4.5/aarch64-apple-darwin20/`, el nombre, el `Version:` de su `DESCRIPTION` y el destino del enlace al caché, sin R): 58 paquetes, md5 de la lista 214fc713c1006b05b76772d6e1a355c4; 56 son enlaces al caché de `renv` y 2 son directorios propios: `renv` 1.1.4 y `suitedoc` 0.5.1. `renv.lock` md5 f5e8225e6456614c6c86bc550e449e7b.
- I-2 de partida: `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd, `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3 (los de §4).

**T0.** `git add` de las dos rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decima ola y decision D35-16"`
esperado: un commit con el encargo y el archivo de decisiones
obtenido: `c504ef8 docs(sesion 35): encargo de la decima ola y decision D35-16`, padre `40ac367`; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md` y `A …/encargo_ramas_bloqueos_s35j.md`; `git status --porcelain` = solo este log. **Punto de retorno: c504ef8** (c504ef8b2d3336a40a56abe4160ac6543994951d).

**Alcance:** las dos rutas de T0. **Regresión:** no aplica (no cambia el producto). **Subagentes:** 0. **Bugs:** ninguno. **Decisiones autónomas:** D0-a: el paso 1 se resolvió con `ps` porque tras `/clear` no hay lista de tareas visible; D0-b: el R huérfano de otro proyecto no se detiene (fuera de la autorización 2). **Errores propios:** ninguno. **Dudas:** Q-70 (el R huérfano).

### FASE R1: ramas (pendientes 10 y 12)

**Estado:** completa (lectura, más el worktree temporal de la autorización 3, ya quitado). **Commits:** ninguno. **Cambios sustantivos:** ninguno. Salidas en `$TMPDIR/s35j/r1/`.

**R1.0 Premisas de §2, medidas otra vez.** `git branch -vv`, `git ls-remote --heads origin`, `git config --get-regexp '^branch\.'` y `git cherry -v main <rama>` para las cuatro ramas
esperado: las de §2
obtenido: iguales. `gobernanza/v16` 667e5ad `[origin/gobernanza/v16: gone]`, con `branch.gobernanza/v16.remote origin`; el remoto solo tiene `main` (40ac367) y `feat/contrato-contexto` (31befa2). `git cherry`: `respaldo_prerebase_20260824` 1 «−» (e86b0d2); `gobernanza/v16` «−» e86b0d2 y «+» 667e5ad; `respaldo_normativos_20260824` 6 «−» y «+» 98c3f6a; `feat/contrato-contexto` 9: los mismos 7 más «+» 6e00830 y «+» 31befa2. Coherente con «los mismos 7» de §2: `respaldo_normativos_20260824` es ancestro de `feat/contrato-contexto` y `respaldo_prerebase_20260824` es ancestro de `gobernanza/v16` (`git merge-base --is-ancestor`, código 0 las dos). `git branch -a --contains <punta>`: prerebase está en `gobernanza/v16`; normativos, en `feat/contrato-contexto` y en `origin/feat/contrato-contexto`; `gobernanza/v16`, solo en sí misma. Tamaño `git diff --shortstat main...<rama>`: prerebase 2 archivos (+119/−4); gobernanza 9 (+2046/−68); normativos 11 (+459/−745); feat 16 (+977/−760).

**R1.1 Clasificación por archivo de los commits «+».** Para cada archivo: `git rev-parse <commit>:<ruta>` contra `git rev-parse main:<ruta>` (y contra `git ls-tree -r main` por blob, para hallarlo en otra ruta), `git diff main <commit> -- <ruta>` y lectura
esperado: cada archivo en (a), (b) o (c), con una línea de evidencia
obtenido: 15 archivos distintos (ESTADO.md cuenta una vez: 98c3f6a está en dos ramas): **(a) 2, (b) 6, (c) 7**. La hipótesis de §2 se confirma: 8 de los 15 archivos de commits «+» ya están en `main` o están superados.

| commit (rama) | archivo | clase | evidencia |
|---|---|---|---|
| 667e5ad (gobernanza/v16) | `50_documentacion/activa/POLITICA_PROYECTO.md` | (a) | blob 5e47821a, igual al de la copia local del árbol de `main` (`git hash-object`; «Versión 5.8 — vigente»). `main` no la versiona: la sacó del índice en `4a8a8cb` (2026-08-19, «los normativos no se versionan en repo publico») y la ignora desde `65302c6` (`.gitignore` L50). Ver D1-a |
| 667e5ad | `50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` | (b) | la rama tiene «Versión 34.» (L3); la copia local de `main`, «Versión 38.» (L3), la vigente según el traspaso v34 §1. Ignorada en `main` (`.gitignore` L51) |
| 667e5ad | `50_documentacion/andamios/logs/20260711_contrato_contexto_simce_log.md` | **(c)** | 165 líneas, 12.574 bytes; `git log --all` lo halla solo en 667e5ad (no está en `main`, `feat`, `origin` ni en el árbol). Es el log de implementación de 6e00830 y 31befa2 (conteos, 10 chequeos, trazabilidad desde los xlsx, pendientes). El traspaso v11 de `slep_minuta_buenas_senales` lo cita con esta ruta como registro de ejecución |
| 667e5ad | `50_documentacion/estructura/20260701_145817_estructura.md` y `.txt` | (b) | snapshots sellados; POLITICA §7.4 retiene los 2 más recientes; `main` tiene `20260924_141324` y `20260924_163130` y rotó los anteriores (p. ej. en `6a1c8b6`) |
| 667e5ad | `50_documentacion/estructura/20260710_224110_estructura.md` y `.txt` | (b) | ídem |
| 667e5ad | `50_documentacion/suite/documentacion_proyecto_slep_simce_adecuado_standalone.html` | **(c)** | difiere del de `main` (blob 7ad39c6a, `6f94729`, 2026-06-22) en 1 línea: «distintas <strong>entidades</strong>» → «distintos <strong>territorios</strong>». Es la salida regenerada con el `documentar.R` que `main` ya tiene; `main` no la regeneró (pendiente 8). Regenerable si `suitedoc` corre. Ver D1-d |
| 667e5ad | `50_documentacion/suite/documentar.R` | (a) | blob 6bf8c1d9, igual al de `main`; llegó por otro parche: `6a1c8b6` (2026-08-26, «corrige terminologia entidad->territorio en documentar.R») |
| 98c3f6a (respaldo_normativos, feat) | `50_documentacion/activa/ESTADO.md` | (b) | la rama deja `sesion_actual: v26`, `ultima_actividad: 2026-07-01`; `main`, `v34` y `2026-09-24` (`4496d02`) |
| 6e00830 (feat) | `30_procesamiento/31_leer_normalizar.R` | **(c)** | `grep -cE "normalizar_bandera|sigdif|siggru|difgru"`: 0 en `main` (código 1) y 23 en la rama; `git diff --stat main feat` +86/−17 |
| 31befa2 (feat) | `00_build.R` | **(c)** | 2 líneas: `source(… "35_exponer_contrato_contexto.R")` y `message("")`; `main` no llama al paso 35 |
| 31befa2 | `30_procesamiento/35_exponer_contrato_contexto.R` | **(c)** | ausente en `main` (147 líneas) |
| 31befa2 | `40_salidas/publico/contexto_simce.parquet` | **(c)** | ausente en `main`; blob a3699717, 303.863 bytes, del 2026-07-11, con 2025 **preliminar** (la rama versiona `simce*2025_rbd_preliminar.xlsx`; `main`, los `_final`) |
| 31befa2 | `50_documentacion/activa/contrato_contexto_v1.md` | **(c)** en este repositorio | ausente en `main`; hay una copia byte a byte (md5 297b7297c96128345d1de10b1caec31a) en `slep_minuta_buenas_senales/50_documentacion/activa/` (lectura, D1-b) |

**R1.2 Commits «−»: el contenido está en `main`** (otro método: blobs y texto en `main`, no parches; el equivalente por asunto en `main` se halló con `git log main --grep`)
esperado: los 7 «−» presentes por contenido
obtenido: 7 de 7.

| commit | qué hace | equivalente en `main` | contenido en `main` |
|---|---|---|---|
| e86b0d2 | POLITICA v5.6 y SETTINGS v16 | 5dde691 (2026-08-01) | blobs f9b6ee4b y 78c859f5 iguales a los de 5dde691, ancestro de `main`; después, superados (a1a1c20) y fuera del índice (4a8a8cb) |
| 7ec8461 | borra `POLITICA_PROYECTO.md` de la raíz | d327420 | `main:POLITICA_PROYECTO.md` no existe |
| 34d681d | renombra el backlog | bd71a25 | `main` tiene `backlog_acumulativo.md` y no `backlog_historico.md` |
| 7af874c | README apunta al backlog nuevo | 0136e2d | `README.md` de `main`: 1 mención de `backlog_acumulativo`, 0 de `backlog_historico` |
| f9d8863 | rotación de snapshots (s26) | 7c0d9ef | superada por rotaciones posteriores (retención 2; `main` en `20260924_*`) |
| 6a13f3e | `34_historico_pct_adecuado_costa_central.R` y su `.xlsx` | 0d43f0b | el script de `main` = el de la rama + 1 línea (la guarda de locale de s34); el `.xlsx` con el mismo blob (083d71ed) |
| b9426c2 | cierre de s26: backlog 129-133 y traspaso v26 | b73e221 | `traspaso_cierre_v26.md` con el mismo blob (b7dedded) en `traspasos/archivo/`; las 133 entradas numeradas del backlog de la rama están, con el texto exacto, entre las 216 de `main` (0 ausentes, `comm`) |

**R1.3 Integración de prueba de `feat/contrato-contexto`** (autorización 3). `git worktree add --detach "$TMPDIR/wt_s35j" main` (en c504ef8; worktree limpio), luego `git merge --no-commit --no-ff feat/contrato-contexto`
esperado: se registra si hay conflictos y en qué archivos
obtenido: merge_codigo=1, **9 archivos en conflicto** (bloques `<<<<<<<` por archivo):
- `00_build.R` (1: la línea del paso 36 contra la del paso 35);
- `30_procesamiento/31_leer_normalizar.R` (1: el comentario de la columna `preliminar`);
- `30_procesamiento/34_historico_pct_adecuado_costa_central.R` (add/add, 1: la guarda de locale);
- `50_documentacion/activa/ESTADO.md` (2);
- `50_documentacion/activa/backlog_acumulativo.md` (add/add, 27; además rename/delete de `backlog_historico.md`);
- `50_documentacion/estructura/20260701_114145_estructura.md` y `.txt` (rename/delete y modify/delete);
- `50_documentacion/estructura/estructura_actual.md` y `.txt` (6 y 6).

Sin conflicto entrarían `35_exponer_contrato_contexto.R`, `contexto_simce.parquet`, `contrato_contexto_v1.md` y **`50_documentacion/traspasos/traspaso_cierre_v26.md`**, este en la raíz de `traspasos/`, lo que rompe la regla de POLITICA §1.3.1 (un solo traspaso en la raíz; en `main` vive en `archivo/`). Los conflictos de documentación vienen de los 6 «−»: entraron a `main` con otros parches, y git ve dos historias. `git merge --abort`, código 0; status del worktree vacío.

Medición adicional en el mismo worktree (D1-c): `git cherry-pick -n 6e00830 31befa2` se detiene en el primero con 1 conflicto (`31_leer_normalizar.R`, 1 bloque, el mismo comentario); `git cherry-pick --abort` (código 0). `git cherry-pick -n 31befa2` solo: 1 conflicto (`00_build.R`, 1 bloque, 35 contra 36); los 3 archivos nuevos entran limpios. **Integrar solo los 2 commits propios cuesta 2 conflictos de 1 bloque cada uno.** Cierre: `git worktree remove --force "$TMPDIR/wt_s35j"`, código 0; `git worktree list` = solo el árbol principal; `git worktree prune -n -v` sin salida; el directorio no existe. `for-each-ref` contra FASE 0: solo difiere `refs/heads/main` (40ac367 → c504ef8, T0).

**R1.4 Qué produce el paso 35** (según `contrato_contexto_v1.md` de la rama, leído con `git show`; 284 líneas):
1. Escribe `40_salidas/publico/contexto_simce.parquet`: 15 columnas en orden fijo (§3), llave `(rbd, anio, eje, segmento)`, a nivel de establecimiento; `eje` es la prueba (lect/mate) y `segmento` el nivel (4b/2m).
2. Expone solo las filas en que el establecimiento mejora: por sobre su GSE (`siggru == 1`) o respecto de su evaluación anterior (`sigdif == 1`), con las banderas de la Agencia leídas tal cual y normalizadas de literal a código (§6, §7).
3. La escala es el puntaje promedio (`escala = "simce_puntaje"`), no el % Adecuado: la Agencia no publica significancia sobre el % Adecuado (§5).
4. Cubre 2014-2018 y 2022-2025, con 2025 tratado como preliminar (§8); el parquet de la rama tiene 61.853 filas (2025: 2.350 en 2m y 4.248 en 4b, según el log de 667e5ad).
5. Lo consume `slep_minuta_buenas_senales`, que valida el esquema y reduce a RBD (§11); la copia a su `20_insumos/` es manual (§10).

**Quién lo consume, según `main`** (`git grep -E "contrato_contexto|contexto_simce|buenas_senales|contrato de contexto" main -- 50_documentacion`)
esperado: referencias en `50_documentacion/` de `main`
obtenido: 25 aciertos en 10 archivos: la lista de autorizados (L30 y L58); la entrada 202 del backlog (D32-1: «solo 2 son trabajo propio para `slep_minuta_buenas_senales`»); tres logs de s32 (`20260923_sesion32_errores_asistente.md`, `20260923_simce2025_final_log.md`, `20260923_traslado_trayectorias_log.md`); los traspasos v31 a v34; y este encargo (8). **Ningún script de `main` lo consume**; el consumidor es externo. En el repositorio del consumidor (solo lectura, D1-b): la copia del contrato es idéntica; `20_insumos/` no tiene ningún `contexto_*.parquet`; su `ESTADO.md` (última actividad 2026-07-11) pone como próximo paso P-CTX-4 (integrar el contexto) y como bloqueantes P-CTX-5 («revisión y push del titular de las dos ramas feat/contrato-contexto») y la copia manual de los parquets. La parte de P-CTX-5 que toca a este repositorio, el push, ya ocurrió en s32 (D32-1).

**¿Está `contexto_simce.parquet` en la lista de datos versionados autorizados?** (`grep -n contexto 50_documentacion/activa/50_datos_versionados_autorizados.md`)
esperado: se mide (hipótesis de §2)
obtenido: **sí**, en `main`: L30 (`40_salidas/publico/contexto_simce.parquet # contrato de contexto v1 (paso 35), solo en la rama feat/contrato-contexto (31befa2); 61.853 filas…; nivel establecimiento, sin persona natural`) y L58 (sus 15 columnas; «Ni RUT, ni MRUN, ni nombre de persona»), desde `760ce01` (s32, D32-4). Datos versionados: `main` 28 (I-7) y ningún parquet; la rama 27. Con la integración serían **29**: la prueba de merge solo agrega el parquet entre los datos (los `_preliminar.xlsx` de la rama no vuelven).

**R1.5 Número de paso** (`git ls-tree --name-only main 30_procesamiento/` y `ls 30_procesamiento`)
esperado: se anota
obtenido: `main` tiene 30, 31, 32, 33, 34 y 36; `35_*` no existe (conteo 0 en `main` y en el árbol, código 1). **Al integrarse conserva el 35**, sin renumerar. En `00_build.R` va después del 33: el 35 lee solo el `simce_rbd.parquet` del paso 31, y el 36 no lee su salida, así que el único conflicto de `00_build.R` se resuelve conservando las dos líneas (35 y 36).

Otros costos de integrar, medidos en la lectura:
- `35_exponer_contrato_contexto.R` no carga la guarda de locale (`grep -c 10_configuracion` = 0); los 7 scripts ejecutables de `30_procesamiento/` en `main` sí la cargan (A34-2).
- `fecha_calculo = Sys.Date()` y `PERIODO_CORRIDA <- "2026-07"` fijo: con el paso en `00_build.R`, cada build de otro día reescribe un archivo **versionado**, y el árbol queda modificado tras cada build (hoy el build deja el árbol limpio).
- El parquet se construyó con 2025 preliminar; `main` usa 2025 final: hay que regenerarlo.
- `simce_rbd.parquet` (intermedio ignorado) gana 5 columnas que leen los pasos 32, 33 y 36. La no regresión se verificó en julio sobre la base de entonces (log de 667e5ad, §4); sobre el `main` de hoy hay que medirla otra vez (build y batería de 35 pruebas).

**Fichas**

*Ficha `respaldo_prerebase_20260824`* (e86b0d2, 2026-08-01, sin remoto)
- Qué contiene: 1 commit (POLITICA v5.6 y SETTINGS v16), que también está dentro de `gobernanza/v16`.
- Qué se pierde si se borra: nada. 0 archivos de clase (c): sus dos blobs son idénticos a los de 5dde691 en `main`, y el commit sigue en `gobernanza/v16`.
- Qué cuesta integrarla: no aplica; integrarla devolvería normativos viejos al índice de un repositorio público (contra 4a8a8cb).
- Pregunta: **¿se borra la rama local? (borrar / conservar)**
- Recomendación: borrar.

*Ficha `respaldo_normativos_20260824`* (b9426c2, 2026-07-01, sin remoto)
- Qué contiene: los 7 commits del cierre de la sesión 26; es ancestro de `feat/contrato-contexto`, local y remota.
- Qué se pierde si se borra: nada. 0 archivos de clase (c): 6 commits ya están en `main` por contenido; el 7.º (ESTADO v26) está superado por ESTADO v34; y los 7 siguen en `feat/contrato-contexto` y en `origin`.
- Qué cuesta integrarla: no aplica.
- Pregunta: **¿se borra la rama local? (borrar / conservar)**
- Recomendación: borrar.

*Ficha `gobernanza/v16`* (667e5ad, 2026-08-24; su remoto `origin/gobernanza/v16` ya no existe)
- Qué contiene: e86b0d2 («−») y 667e5ad («+», 9 archivos): (a) 2, (b) 5, (c) 2.
- Qué se pierde si se borra (solo clase c): el log `20260711_contrato_contexto_simce_log.md`, único registro de la implementación del paso 35 y citado por el traspaso v11 del consumidor; y el standalone de `documentacion_proyecto` regenerado con «territorios» (1 línea distinta de `main`, regenerable si `suitedoc` corre).
- Qué cuesta integrarla: como rama no conviene, porque devolvería POLITICA y SETTINGS (v34, vieja) al índice de un repositorio público y cuatro snapshots que la retención poda. Rescatar los dos archivos de clase (c) cuesta un encargo corto: `git show 667e5ad:<ruta>`. El log va a una ruta que no existe en `main`; el standalone reemplaza el de `main`.
- Pregunta: **¿se borra la rama local? (borrar / conservar)**
- Recomendación: conservar hasta rescatar a `main` el log (y, si se quiere, el standalone) en un encargo con ese alcance; después, borrar.

*Ficha `feat/contrato-contexto`* (31befa2, 2026-07-11, publicada en `origin`)
- Qué contiene: 9 commits: los 7 de `respaldo_normativos_20260824` y 2 propios, 6e00830 (el normalizador persiste 5 columnas de señal de la Agencia) y 31befa2 (paso 35, el parquet del contrato y el contrato).
- Qué se pierde si se borra (solo clase c): 5 archivos: el `31_leer_normalizar.R` extendido, las 2 líneas de `00_build.R`, `35_exponer_contrato_contexto.R`, `contexto_simce.parquet` y `contrato_contexto_v1.md` (este con copia idéntica en el consumidor). No hay riesgo de pérdida mientras exista `origin/feat/contrato-contexto` (D32-1).
- Qué cuesta integrarla:
  - por merge: 9 conflictos, casi todos de documentación, y un `traspaso_cierre_v26.md` en la raíz de `traspasos/`;
  - por cherry-pick de 6e00830 y 31befa2: 2 conflictos de 1 bloque cada uno;
  - en los dos casos, además: la guarda de locale en el paso 35; regenerar el parquet con 2025 final; decidir la fecha que lleva el parquet (hoy cambiaría un archivo versionado en cada build); I-7 de 28 a 29; build y batería otra vez. El paso conserva el número 35.
- Pregunta: **¿se integra a `main`, se archiva como etiqueta o se deja? (integrar / etiqueta / dejar)**
- Recomendación: dejar (publicada y sin integrar, como en D32-1) hasta que el consumidor programe P-CTX-4; entonces, integrar por cherry-pick de 6e00830 y 31befa2, no por merge, en un encargo propio.

**Alcance:** ninguna ruta del árbol (`git status --porcelain` = solo este log). **Regresión:** no aplica. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D1-a: POLITICA de 667e5ad va en (a) y no en (b): el contenido es idéntico a la copia local vigente que `main` mantiene fuera del índice por diseño. Con otra lectura («ya en `main`» = en el índice) no cabría en ninguna de las tres.
- D1-b: lectura del repositorio del consumidor (`slep_minuta_buenas_senales`: md5 del contrato, `ls` de `20_insumos/`, `git grep`), fuera de los insumos de §1, para completar «quién lo consume». Sin escritura; sin filas de datos.
- D1-c: la prueba adicional con `cherry-pick -n`, en el mismo worktree autorizado y sin commit, para medir el costo de «integrar» sin merge.
- D1-d: el standalone de 667e5ad va en (c): `main` tiene una versión posterior de su fuente (`documentar.R`), pero no del HTML.

**Errores propios:** tras `git cherry-pick -n 31befa2` con conflicto, corrí `git cherry-pick --abort`. Salió con código 128 («no cherry-pick or revert in progress»): un `-n` de un solo commit no deja estado de secuencia. El worktree quedó con 4 líneas de status, y lo quitó `git worktree remove --force`, que ya estaba autorizado. No quedó nada: `worktree list`, `prune -n` y el directorio lo confirman. Lo correcto era quitar el worktree directamente.

**Dudas:** ninguna nueva (las preguntas de las fichas van al titular).

### FASE R2: pendiente 8 (bloqueos de `suitedoc`)

**Estado:** completa (lectura; autorización 4). **Commits:** ninguno. **Cambios sustantivos:** ninguno. R se corrió con `cd "$RAIZ" && Rscript --vanilla <script en $TMPDIR/s35j/>`: `--vanilla` no lee `.Rprofile`, así que `renv` no se activa; la biblioteca del proyecto se agrega con `.libPaths()`. Salidas en `$TMPDIR/s35j/r2_*`.

**R2.1 `suitedoc` en las bibliotecas** (`DESCRIPTION` leído con `grep` y `cat`)
esperado: se mide versión y campos `RemoteType`, `RemoteUrl` o `Repository`
obtenido:
- biblioteca de `renv` (`renv/library/macos/R-4.5/aarch64-apple-darwin20/suitedoc`): **0.5.1**, directorio propio (no es un enlace al caché), `Built: R 4.5.2; ; 2026-08-26 19:31:03 UTC; unix`. **Sin** `RemoteType`, `RemoteUrl` ni `Repository`: se instaló desde una fuente local;
- biblioteca del sistema (`/Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/library`): **0.3.0**, sin campos de origen; `~/Library/R/…/library` no existe.

**R2.2 `V8` y `openssl`: lock, biblioteca y quién los pide** (`$TMPDIR/s35j/r2_lock.R`: `jsonlite::fromJSON("renv.lock")`, `installed.packages()`, `tools::dependsOnPkgs()`; y `grep` sobre `renv.lock` y sobre los `.R` versionados)
esperado: se mide
obtenido: codigo_r2_lock=0.
- `renv.lock`: R 4.5.1; 40 paquetes; `grep -n '"V8"'`, código 1 (0 aciertos); `grep -n suitedoc`, código 1; `grep -ni openssl`: 1 acierto, L53, el `SystemRequirements` de `arrow`. Ninguno de los tres está en el lock.
- Biblioteca de `renv`: 58 paquetes. `V8` 8.2.0 y `openssl` 2.4.2, los dos `Repository: CRAN`, `RemoteType: standard`, enlazados al caché de `renv`. En el sistema: `V8` 8.0.1 y `openssl` 2.3.5.
- **18 paquetes instalados no están en el lock** (y 0 al revés; 0 con versión distinta): AsioHeaders, askpass, chromote, curl, fastmap, later, openssl, openxlsx, otel, processx, promises, ps, Rcpp, suitedoc, sys, V8, websocket, zip. El lock es además inconsistente: `arrow`, `readr` y `vroom` declaran `curl` o `sys` en `Requirements`, y ni `curl` ni `sys` tienen registro.
- **Quién los pide.** Entre los paquetes instalados, nadie: `tools::dependsOnPkgs()` da «(nadie)» para `V8`, `openssl` y `suitedoc`, en directo y en recursivo. Los pide el **código del proyecto** (`grep` sobre los 18 `.R` versionados):
  - `V8`: `30_procesamiento/33_generar_html.R` (L70 exige `V8` y `openssl` con `requireNamespace()` y `stop()`; L102 `V8::v8()` transpila el JSX, D31-1) y `30_procesamiento/36_verificar_trayectorias.R` (L382);
  - `openssl`: `33_generar_html.R` L90 (`openssl::sha384()`, el hash SRI);
  - `chromote`: la batería (L728 y L1274);
  - `openxlsx`: `34_historico_pct_adecuado_costa_central.R` (L124 a L147);
  - `suitedoc`: `50_documentacion/suite/documentar.R` L420 (`suitedoc::generar_suite(`).
- **Los 18 se explican por esos 5 directos**: el cierre recursivo de dependencias de `V8`, `openssl`, `chromote`, `openxlsx` y `suitedoc`, restado lo que ya está en el lock, da los mismos 18, sin resto (`$TMPDIR/s35j/r2_cierre.R`).
- `renv/settings.json`: `snapshot.type` = `"implicit"` (el lock sigue a lo que el código usa), `ignored.packages` vacío, `vcs.ignore.cellar` = true.

**R2.3 Qué dicen los traspasos** (cita literal):
- v28 L50-52: «**`renv` desincronizado.** `openxlsx`, `Rcpp`, `zip` y `suitedoc` instalados y sin registrar en `renv.lock`. Bloquea `documentar.R` y `34_historico_pct_adecuado_costa_central.R`.»
- v28 L53-55: «**Suite standalone desfasada.** Los cuatro HTML siguen generados con el `documentar.R` anterior a la corrección de terminología del commit `6a1c8b6`.»
- v28 L56-59: «**`suitedoc` no existe en ningún remoto.** Vive solo en el disco del titular, dentro de `herramientas_dev`, que tiene 20 commits sin publicar y 13 entradas sucias. Es la causa raíz del bloqueo anterior y **es externa a este repositorio**.»
- v28 L303: «Publicar `herramientas_dev` y registrar `suitedoc` con `git::` | bloqueante externo | … Criterio de éxito: `renv::status()` sincronizado con `suitedoc` sin `Source: unknown`».
- v31 L31: «`V8` y `openssl` no están en `renv.lock`: otra estación sin esos paquetes no puede construir el motor.»
- v31 L112, v32 L105, v33 L117, v34 L109: «**`V8` y `openssl` en `renv.lock`, suite standalone, `documentar.R` y `34_historico`.** Bloqueados por `suitedoc` sin remoto.»
- v34 L118: «`34_historico_pct_adecuado_costa_central.R` ganó la línea de la guarda pero no se corrió en la sesión (bloqueado por `suitedoc`).»
- El mecanismo del bloqueo está en `andamios/logs/20260827_entorno_y_suite_standalone_log.md` L166-187. `renv::snapshot()` aborta **entero** por la validación previa («The following package(s) were installed from an unknown source: suitedoc [0.5.1]… aborting snapshot due to pre-flight validation failure»), y por eso tampoco registra los paquetes de CRAN. El mismo log (L226-235) dejó cuatro opciones al titular: A `snapshot(force = TRUE)` con `Source: unknown`; B reinstalar desde la ruta local; C `renv/cellar/` con el tarball, «la vía técnicamente más sólida»; D `ignored.packages`.

**R2.4 Estado de hoy del remoto de `suitedoc`.** Fuera de los insumos de §1, se leyó `herramientas_dev` (D2-a): `git remote -v`, `git ls-remote`, `git ls-tree`, `git reflog`, y `gh repo view` con GET
esperado: se mide (la premisa heredada es «sin remoto»)
obtenido: **la premisa está desactualizada.** `herramientas_dev` tiene `origin` = `https://github.com/tomgc/herramientas_dev.git`. Su `main` local es igual al remoto (`ls-remote`, 63b3233), con árbol limpio (0 entradas en `status --porcelain`). El remoto contiene `suitedoc/` con `Version: 0.5.1`: `39986e8` («docs(suitedoc): version 0.5.1», 2026-08-26) es ancestro de 63b3233, y el `DESCRIPTION` publicado difiere del instalado solo en el formato (saltos de línea) y en los campos que agrega la instalación. Según el reflog local, el primer push de `origin/main` fue el 2026-08-30 a las 01:39 (-0400), justamente con 39986e8. Después hubo un commit que toca `suitedoc/` sin cambiar la versión: `44d5e51`, 2026-08-30. **Pero el repositorio es privado:** `gh repo view tomgc/herramientas_dev` da `"visibility":"PRIVATE"`, mientras que `slep_simce_adecuado` es `"PUBLIC"`.

**R2.5 Estado de la suite** (`git log` y conteo de «entidad(es)» en los HTML de `main`, sobre copias en `$TMPDIR`)
esperado: se mide
obtenido: los 4 HTML standalone son de `6f94729` (2026-06-22). `documentacion_proyecto_…_standalone.html` tiene 5 apariciones de «entidad(es)» y los otros 3, 0. `documentar.R` de `main` no menciona el paso 36, las trayectorias, `10_configuracion`, la guarda de locale ni `V8` (conteo 0 de cada uno): regenerar hoy reproduciría una suite que no describe el pipeline actual. La rama `gobernanza/v16` trae un `documentacion_proyecto` regenerado que corrige 1 de las 5 (R1, D1-d).

**I-5 tras R2** (la misma lista de FASE 0 y md5 del lock)
esperado: idénticas
obtenido: `diff` contra `i5_fase0.txt`, código 0; `renv.lock` f5e8225e6456614c6c86bc550e449e7b

**Ficha del pendiente 8**
- **Qué falta exactamente para destrabar:** una **decisión** sobre cómo se declara `suitedoc` en el lock de un repositorio público. Ya no falta un remoto: desde el 2026-08-30, `suitedoc` 0.5.1 está en `github.com/tomgc/herramientas_dev` (subcarpeta `suitedoc/`), pero ese repositorio es privado, y un registro `github` en el lock solo se restaura con una credencial (PAT). Las vías:
  - (1) registrar desde el remoto privado;
  - (2) `renv/cellar/` con el tarball (el lock queda restaurable solo donde esté el tarball, que git ignora);
  - (3) sacar `suitedoc` del lock del proyecto (`ignored.packages` o una biblioteca aparte para `documentar.R`), porque no es parte del pipeline de datos;
  - (4) hacer público `herramientas_dev` o solo `suitedoc`.
- **Qué se puede hacer sin eso:**
  - registrar los otros 17 paquetes, todos de CRAN, con `renv::snapshot(exclude = "suitedoc")` o con `renv::snapshot(packages = c("V8", "openssl", "chromote", "openxlsx"), update = TRUE)`. Según la documentación de `renv` 1.1.4 (`?snapshot`: «update: … without removing any prior package records»; `exclude`; `packages` agrega las dependencias recursivas), eso evitaría la validación que aborta por `suitedoc`. **Es una hipótesis**: no se probó, porque `renv::snapshot()` no está autorizado;
  - correr `34_historico_…R`: `openxlsx` está instalado; el lock no bloquea la ejecución, solo la reproducibilidad;
  - correr `documentar.R` en esta estación: `suitedoc` 0.5.1 está en la biblioteca de `renv`. Ojo: fuera de `renv` se cargaría el 0.3.0 del sistema. Con todo, antes de regenerar la suite hay que poner al día su configuración (`cfg` de `documentar.R`), que no describe el paso 36 ni la guarda de locale.
- **Pregunta:** **¿cómo se declara `suitedoc` en `renv.lock`? (remoto privado / cellar / fuera del lock)**
- **Recomendación:** fuera del lock: `suitedoc` es una herramienta de documentación, no del pipeline, y un repositorio público no debería depender de uno privado para restaurarse. En un encargo propio: registrar los 17 paquetes de CRAN (antes, probar la hipótesis en una copia del lock) y después actualizar `cfg` y regenerar la suite.

**Alcance:** ninguna ruta del árbol. **Regresión:** I-5 igual. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D2-a: leer `herramientas_dev` y consultar su visibilidad con `gh repo view` (GET), fuera de los insumos de §1, porque la ficha exige decir «qué falta exactamente» y el traspaso da un dato de agosto. Sin `fetch` en ese repositorio: `ls-remote` no cambia refs.
- D2-b: R con `--vanilla` para no activar `renv` (la activación no instala, pero `--vanilla` quita la duda sobre I-5).

**Errores propios:** un `grep` combinado (`V8|openssl|suitedoc|chromote|…`) sobre `renv.lock` mezcló `Requirements` de otros paquetes con registros propios; se repitió con un patrón por paquete antes de registrar. Un primer script de `bash -c` con comillas anidadas falló por sintaxis (`unmatched '`) y se reescribió como archivo (`r2_usos.sh`).

**Dudas:** Q-71: la premisa «`suitedoc` sin remoto», que repiten los traspasos v29 a v34, está desactualizada desde el 2026-08-30. El bloqueo real es un remoto privado frente a un repositorio público. ¿Se corrige esa redacción en el próximo traspaso? (sí / no)

### FASE R3: pendiente 13 (Simce 2026)

**Estado:** completa (lectura). **Commits:** ninguno. **Cambios sustantivos:** ninguno.

**R3.1 Años disponibles en los insumos** (`ls -la 20_insumos/simce/2m` y `…/4b`, solo nombres y tamaños; ningún archivo abierto)
esperado: se lista
obtenido: las dos carpetas tienen los mismos 9 años, todos `_final`: 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024 y 2025 (`simce2m<anio>_rbd_final.xlsx`, de 520.890 a 762.914 bytes; `simce4b<anio>_rbd_final.xlsx`, de 1.105.457 a 2.067.488 bytes), más `.gitkeep`. **No hay ningún archivo 2026**, ni preliminar ni final. Los 18 xlsx están versionados (`git ls-files 20_insumos/simce`, 18) y autorizados (`50_datos_versionados_autorizados.md` L25 y L26). `git check-ignore` no los ignora (código 1).

**R3.2 Último año que usa el motor** (`$TMPDIR/s35j/r3_meta.R`, con `Rscript --vanilla`: el `meta` del motor publicado se lee de `docs/index.html` (base64 del único `atob("…")`, 2.096.892 caracteres → gzip → JSON); y la vista, de `var DATA=` en `docs/trayectorias.html`)
esperado: se mide
obtenido: codigo_r3_meta=0.
- Motor publicado: `meta$anios` = 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025; `anios_preliminar` vacío; `anios_sin_simce` = 2019, 2020, 2021; `fecha_generacion` 2026-09-26. **Último año: 2025**, como final.
- Vista publicada: `DATA$anios`, los mismos 9; último 2025.
- Configuración del pipeline: `31_leer_normalizar.R` L124 `anios_esperados <- c(2014:2018, 2022:2025)`; L157-167 detiene el build si falta un año esperado o si aparece uno **inesperado** («Nivel %s: años inesperados %s»).

**R3.3 De dónde vendría el insumo, según los traspasos y los documentos:**
- traspaso v31 L45: «El titular dejó `simce{4b,2m}2025_rbd_final.xlsx` en `20_insumos/simce/`»: la carga es manual, del titular;
- v31 L74 (A31-6): «la Agencia identifica la versión de la base por `codigo_bbdd`»;
- `manifiesto_insumos.md` L10-15: la base 2025 llegó primero preliminar (v12025, 2026-04-27) y después final (v22025, 2026-06-22), sin cambio de datos;
- `documentacion_proyecto_slep_simce_adecuado.md` L170-173 y `decisiones/20260611_decision_nombres_establecimientos.md` L20-21: los datos son públicos y se descargan del portal de información estadística de la Agencia de Calidad (`informacionestadistica.agenciaeducacion.cl`);
- traspasos v26 a v34: «Actualización anual … Bloqueada por insumos» / «insumos no cargados», sin otra fuente propuesta.

Por analogía con 2025, la base 2026 preliminar no existiría antes de abril de 2027 y la final, antes de junio de 2027. **Es inferencia**, no un dato medido: el repositorio no registra el calendario de la Agencia.

**R3.4 Qué pasos del pipeline se tocarían** (`git grep` de «2014–2025», «2014 a 2025», «2022-2025» y de los literales 2025 y 2026 en el código, sin comentarios):
- `20_insumos/simce/{2m,4b}/`: los dos xlsx de 2026 (`simce<nivel>2026_rbd_preliminar.xlsx` y, más tarde, `_final`); `manifiesto_insumos.md` (tablas y la línea «hoy, todos los años 2014–2025»); `50_datos_versionados_autorizados.md` L24-26 (el comentario del rango; el patrón `*.xlsx` ya los cubre);
- **paso 31** `31_leer_normalizar.R` L124 `anios_esperados` (sin este cambio el build se detiene); L16 (comentario); las glosas de 2026 si cambian columnas (`20_insumos/auxiliares/glosas_simce_consolidado_simce.xlsx`, `referencia_glosas_simce.md`);
- **paso 30** `30_construir_auxiliares.R` L43 `ANIO_DATOS_VIGENTE <- 2025L`: rige qué Servicios Locales figuran como traspasados según el directorio oficial; subirlo exige revisar el directorio de MINEDUC (L96-97 verifica una columna «Grupo prioritario IVE 2026»);
- **paso 33**: `meta$anios` y `anios_preliminar` se derivan de los datos y de los archivos (sin edición), pero hay literales: `33_fragmento_sitio.html` L85 («Datos 2014–2025»), `33_motor_template.html` L2592 (`d3.scaleLinear().domain([2014, 2025])`), L4139 y L5074;
- **paso 36**: `36_trayectorias_template.html` L475 («2014 a 2025»); las notas de la vista ya no se editan a mano (v33 L122); `OLAS_FUTURAS` (2027-2029) no cambia;
- la batería (35 pruebas) y `docs/` (build y publicación); `README.md` L134; la suite (`documentar.R` L58, L98, L100, L275, L305 y L324), bloqueada por el pendiente 8;
- si se integra el contrato de contexto (R1), su cobertura (§8) y la regeneración del parquet.

**Hallazgo lateral** (sin efecto sobre las tareas): `manifiesto_insumos.md`, «Política de versionado», dice que los xlsx Simce crudos «**no** se versionan (`.gitignore`)», pero los 18 están versionados y autorizados. Ver Q-72.

**Ficha del pendiente 13**
- **Qué insumo falta:** las bases Simce 2026 por RBD de 2° medio y de 4° básico (`simce2m2026_rbd_*.xlsx` y `simce4b2026_rbd_*.xlsx`), primero la preliminar y luego la final.
- **De dónde vendría:** de la Agencia de Calidad de la Educación, por su portal de información estadística, con descarga manual del titular (v31 L45). Ningún traspaso propone otra fuente.
- **Qué pasos se tocarían:** 31 (`anios_esperados`; obligatorio), 30 (`ANIO_DATOS_VIGENTE` y el directorio), 33 y 36 (cinco literales de rango en las plantillas y en el fragmento), la batería, `docs/`, el manifiesto, la lista de autorizados, el README y la suite.
- **Pregunta:** **¿queda bloqueado hasta que llegue el insumo? (sí / hay otra fuente)**
- **Recomendación:** sí, bloqueado hasta la base preliminar 2026 de la Agencia (por analogía, no antes de abril de 2027). Mientras, un encargo corto puede derivar de los archivos `anios_esperados` y los cinco literales de rango, como ya se hizo con `anios_preliminar` en `44dfb07`, para que la llegada de 2026 no exija editar código.

**Alcance:** ninguna ruta del árbol. **Regresión:** no aplica. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:** D3-a: el «último año del motor» se leyó del `meta` del **publicado** (`docs/`), no de `40_salidas/`, porque `docs/` es lo que ve el usuario y es un 🔒 (I-2). Lectura sin escritura.

**Errores propios:** dos intentos fallidos de instrumento, corregidos antes de registrar. (1) Un regex `[A-Za-z0-9+/=]{100000,}` agotó la memoria del motor de regex de R («invalid regular expression, reason 'Out of memory'»); se buscó el ancla `atob("`. (2) Un `bash -c` con un heredoc entre comillas simples falló por sintaxis («bad pattern»); el script se escribió como archivo.

**Dudas:** Q-72: `manifiesto_insumos.md` dice que los xlsx Simce no se versionan, y los 18 están versionados y autorizados. ¿Se corrige la frase en el próximo encargo que toque el manifiesto? (sí / no)

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo)

| id | afirmación (fase) |
|---|---|
| R-01 | No quedan shells ni R de `v3_medir`; el R huérfano PID 54442 es de `slep-central-datos` (FASE 0, paso 1) |
| R-02 | H1-H3: árbol con las dos rutas de T0 más el log; stash 0; un worktree; `HEAD` = `origin/main` = 40ac367 al empezar (FASE 0) |
| R-03 | md5 del encargo 59a36755270b703cb80cd674382362a8 (H4) |
| R-04 | T0 = c504ef8, padre 40ac367, 2 rutas (M decisiones, A encargo) (FASE 0) |
| R-05 | Línea base de I-5: 58 paquetes, 56 enlaces y 2 directorios (`renv`, `suitedoc`); lock f5e8225e… (FASE 0) |
| R-06 | Premisas de §2: cherry por rama (1; 1+1; 6+1; 6+3) y ascendencia normativos ⊂ feat, prerebase ⊂ gobernanza (R1.0) |
| R-07 | Clasificación de los 15 archivos de commits «+»: (a) 2, (b) 6, (c) 7 (R1.1) |
| R-08 | Los 7 «−» están en `main` por contenido (R1.2) |
| R-09 | Merge de prueba: 9 archivos en conflicto (con bloques 1, 1, 1, 2, 27, 0, 0, 6, 6) y `traspaso_cierre_v26.md` en la raíz (R1.3) |
| R-10 | Cherry-pick de prueba: 1 conflicto en `31_leer_normalizar.R` (6e00830) y 1 en `00_build.R` (31befa2) (R1.3) |
| R-11 | El worktree se quitó; refs iguales salvo `main` (R1.3) |
| R-12 | `contexto_simce.parquet` está en la lista de autorizados de `main` (L30 y L58, desde 760ce01); con la integración, 29 archivos de datos (R1.4) |
| R-13 | `main` no tiene paso 35; el paso conserva el 35 (R1.5) |
| R-14 | El paso 35 de la rama no carga la guarda de locale; los 7 ejecutables de `main` sí (R1.5) |
| R-15 | Ningún script de `main` consume el contrato; 25 aciertos en 10 archivos de `50_documentacion/`; la copia del contrato en el consumidor es idéntica (R1.4) |
| R-16 | `suitedoc` 0.5.1 en `renv` sin campos de origen; 0.3.0 en el sistema (R2.1) |
| R-17 | `V8`, `openssl` y `suitedoc` fuera del lock; 18 instalados fuera del lock; 40 en el lock (R2.2) |
| R-18 | Ningún paquete instalado pide `V8`, `openssl` ni `suitedoc`; los pide el código (33, 36, 34, `documentar.R`); los 18 se explican por 5 directos (R2.2) |
| R-19 | `herramientas_dev` tiene remoto con `suitedoc` 0.5.1, igual al local, y es privado; `slep_simce_adecuado` es público; primer push 2026-08-30 (R2.4) |
| R-20 | Suite: `documentacion_proyecto` con 5 «entidad(es)», los otros 3 con 0; `documentar.R` sin 36, trayectorias, guarda ni V8 (R2.5) |
| R-21 | Insumos: 9 años por nivel, ninguno 2026; 18 xlsx versionados (R3.1) |
| R-22 | Motor y vista publicados terminan en 2025; `anios_preliminar` vacío (R3.2) |
| R-23 | Literales de año y de rango en 30 L43, 31 L124, 33 fragmento L85, motor L2592, L4139 y L5074, 36 L475 (R3.4) |
| R-24 | El manifiesto dice que los xlsx no se versionan (R3, hallazgo lateral) |
| R-25 a R-29 | I-1 a I-5 (§4) |
| R-30 | Alcance global: `git diff --name-only c504ef8..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-31 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red (`grep -c 'http'`, revisado) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/s35j/fase_r/`: `rd_a.sh` a `rd_e.py`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **31 de 31 confirmadas**, 0 refutadas:
- R-01: `pgrep -lf '[v]3_medir'`, código 1 (ninguno). `ps -p 54442` sigue vivo (PPID 1, 19:31:14 de ejecución). `lsof -Fn` da su cwd en `…-slep-central-datos/…`.
- R-02: `git rev-parse c504ef8^` = `origin/main` = 40ac3676…; `refs/stash` no existe (código 1); `.git/worktrees` no existe.
- R-03: `openssl dgst -md5` del encargo = 59a36755270b703cb80cd674382362a8; `git hash-object` del árbol = blob de c504ef8.
- R-04: `git cat-file -p c504ef8` → padre 40ac3676…; `diff-tree` = M decisiones, A encargo.
- R-05: `find -maxdepth 1`: 58 entradas, 56 enlaces, directorios `renv` y `suitedoc`; `openssl dgst -md5 renv.lock` = f5e8225e….
- R-06: `git log --cherry-mark --right-only main...<rama>`: prerebase `=` 1; gobernanza `=` 1 y `>` 1; normativos `=` 6 y `>` 1; feat `=` 6 y `>` 3 (el `%m` marca con `>` lo no equivalente). `git rev-list <rama> | grep -c <punta>` = 1 y 1 para las dos ascendencias.
- R-07: POLITICA: `cmp` contra la copia local da código 0 (idéntica); ignorada (`check-ignore -q`, código 0); ausente del índice de `main` (`cat-file -e`, 128). SETTINGS: rama «Versión 34», local «Versión 38». Log: 1 commit en `--all`; ausente en `main` y en `feat` (128). `estructura/` de `main` = los 20260924 y los alias. Standalone: `--numstat` 1 1. `documentar.R`: `diff --quiet`, código 0. ESTADO: `main` v34, 98c3f6a v26. `normalizar_bandera`: 0 en `main`, 4 en `feat` (`awk`). `35_exponer`: 0 en `main`, 1 en `feat`. Paso 35, parquet y contrato ausentes en `main` (128). El contrato es idéntico al del consumidor (`cmp`, código 0).
- R-08: `diff --quiet e86b0d2 5dde691` sobre POLITICA y SETTINGS, código 0, y 5dde691 es ancestro; POLITICA de la raíz y `backlog_historico.md` ausentes en `main`; `backlog_acumulativo.md` presente; README con 1 y 0; 34_historico `--numstat` 1 0 y `.xlsx` igual; el blob de v26 aparece 1 vez en `traspasos/archivo/`. Python: 133 entradas en la rama, 216 en `main`, 0 ausentes. Snapshots de 20260701 en `main`: 0.
- R-09: **`git merge-tree --write-tree --name-only main feat/contrato-contexto`** (calcula la fusión sin worktree ni refs; código 1) lista los mismos 9 archivos en conflicto. El árbol fusionado tiene 2 traspasos en la raíz (v26 y v34) y **29** archivos de datos. Calibración: `merge-tree c504ef8 40ac367` (sin conflicto), código 0.
- R-10: `merge-tree --merge-base=<commit>^ main <commit>` (el cherry-pick sin worktree): 6e00830 → 1 archivo, `31_leer_normalizar.R`; 31befa2 → 1 archivo, `00_build.R`.
- R-11: el directorio del worktree no existe; `worktree list --porcelain`, 1; refs sin `main`, `origin/main` ni `origin/HEAD`, iguales a FASE 0 (`diff`, código 0).
- R-12: `awk 'NR==30 || NR==58'` sobre la lista de `main` = las dos entradas del parquet; 760ce01 «docs(datos): autoriza contexto_simce.parquet…».
- R-13: pasos `/35_` en `main`: 0 (`awk`).
- R-14: guarda en el 35 de la rama: 0; en los 7 ejecutables de `main`: 1 cada uno.
- R-15: `git grep -c` = 10 archivos y 25 aciertos; scripts `.R` de `main` que lo leen: 0.
- R-16 a R-18 (Python, lectura propia de `DESCRIPTION` con líneas de continuación y `json` para el lock): `suitedoc` 0.5.1 y 0.3.0, ambos sin campos de origen; lock 40, biblioteca 58, fuera 18 (la misma lista); `V8`, `openssl` y `suitedoc` fuera del lock; «lo piden: (nadie)» para los tres; el cierre de los 5 directos da 18 fuera del lock y 0 sin explicar; usos: `V8` en 33 y 36, `openssl` en 33, `chromote` en 36, `openxlsx` en 34 y `suitedoc` en `documentar.R`.
- R-19: `ls-remote` = `main` local; `suitedoc` 0.5.1 en el remoto; **`curl` sin credenciales: `github.com/tomgc/herramientas_dev` → 404 y `github.com/tomgc/slep_simce_adecuado` → 200**; `git log -g`: primera entrada de `origin/main` el 2026-08-30 a las 01:39:50 (-0400), «update by push». Además, `44d5e51` (el único commit posterior que toca `suitedoc/`) solo agrega 4 archivos `.md` en `suitedoc/dev/`: el código del paquete en el remoto es el de 0.5.1.
- R-20: conteos en Python: 0, 0, 0 y 5 «entidad(es)»; `documentar.R`: 0 para los cinco términos.
- R-21: `os.listdir`: 2m y 4b con los 9 años; 0 archivos con 2026; 18 xlsx en `git ls-files`.
- R-22: Python (base64 → `zlib` → JSON) sobre `docs/index.html`: `anios` hasta 2025, `anios_preliminar` vacío; vista hasta 2025. Ver R-38.
- R-23: las 7 líneas citadas, leídas por número (Python), tienen el literal.
- R-24: la línea del manifiesto existe tal cual.
- R-31: `git hash-object`: `docs/index.html` 2554f9a2… = HEAD = `origin/main` = `40_salidas/motor_comparacion.html`; `docs/trayectorias.html` 7cbbdb75… = HEAD = `origin/main` = `40_salidas/trayectorias_traspasos.html`. Red: `grep -c 'http'` da 17 líneas en el motor y 2 en la vista. Revisadas una por una (clasificador en Python con el contexto): 23 y 2 son `w3.org` (espacios de nombres), y 3 son texto: la cadena de error de ReactDOM (`reactjs.org/docs/error-decoder…`) y los comentarios de licencia de D3 y de pako. **0 cargas por red** y 0 `<a href>` externos.

**R.3 Invariantes 🔒** (`$TMPDIR/s35j/fase_r/invariantes.sh`, salida literal en `invariantes.txt`)

I-1 `git for-each-ref --format='%(refname) %(objectname)'` contra `i1_fase0.txt`
esperado: idénticas salvo `refs/heads/main` y `refs/remotes/origin/main`
obtenido: el `diff` completo difiere en una línea (`refs/heads/main 40ac3676…` → `c504ef8b…`); sin las dos excepciones, `diff` código 0 → **PASA**

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 → **PASA**

I-3 `git diff --name-only c504ef8..HEAD`
esperado: solo el log
obtenido: 0 líneas (`HEAD` = c504ef8; el log aún no está commiteado, `git status` = `?? …/20260926_ramas_bloqueos_s35j_log.md`) → **PASA** (se mide otra vez tras el commit del log, en FASE L)

I-4 `git worktree list` y `git stash list | wc -l`
esperado: solo el árbol principal; 0
obtenido: `/Users/tomgc/Projects/slep_simce_adecuado c504ef8 [main]`; 0 → **PASA**

I-5 lista de la biblioteca de `renv` con versiones y destino, contra `i5_fase0.txt`; `renv.lock`
esperado: idénticas
obtenido: `diff` código 0; `renv.lock` f5e8225e6456614c6c86bc550e449e7b y `git diff --quiet c504ef8 -- renv.lock` código 0 → **PASA**

**R.4 Alcance global** (`$TMPDIR/s35j/fase_r/alcance.sh` sobre `git diff --name-only c504ef8^..HEAD` más `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE (las dos rutas de T0; R1 a R3, ninguna) más el log; `status` solo con el log
obtenido: «rutas: 3 | fuera: (ninguna)», código 0: las dos de T0 y el log; `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260926_ramas_bloqueos_s35j_log.md` (se commitea en FASE L) → **PASA**

**R.5 Regresión completa.** No aplica build ni batería (§1, PRUEBAS: el producto no cambia). La regresión es I-1 a I-5 sobre el estado final: R.3, todas PASA; `docs/` y `40_salidas/` con los mismos blobs (R-31).

**R.6 Control positivo de la propia auditoría** (`control_positivo.sh`, copias en `$TMPDIR/s35j/fase_r/ctl/`)
esperado: cada instrumento dispara con una cifra alterada y con una ruta fuera de alcance
obtenido: **disparan todos**:
- I-5 con `V8 8.2.0` → `8.2.1` en una copia de la lista: `diff`, código 1;
- I-1 con el hash de `gobernanza/v16` alterado en una copia: código 1;
- identidad de lo publicado con un año de la vista (`"anios":[…,2025]` → `2026`) en una copia de `docs/trayectorias.html`: `md5` distinto (código 1) y `git hash-object` distinto del blob de HEAD (código 1);
- R-07 con «5.8» → «5.9» en una copia de POLITICA: `cmp`, código 1;
- R-08 con la entrada 129 alterada en una copia del backlog de `main`: «ausentes con la copia alterada: 1», código 1;
- alcance con un diff simulado que agrega `30_procesamiento/31_leer_normalizar.R` y `docs/index.html`: «fuera: 30_procesamiento/31_leer_normalizar.R docs/index.html», código 1;
- además, `merge-tree` sin conflicto da código 0 (R-09), así que el instrumento distingue los dos casos.

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: ninguno. Ninguna afirmación se refutó. La imprecisión de R-38 está en evidencia ya escrita (R.9 prohíbe editarla) y no cambia ningún resultado: se registra como ADVIERTE.
- ADVIERTE: R-32 a R-42 (tabla R.10).

**R.8 Ciclo de reparación.** No hubo (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado ni ALCANCE, y no se tocó ningún 🔒. No se editó evidencia ya escrita: cada sección se anexó después de la anterior; solo el encabezado recibió el hash del punto de retorno, antes de anexar FASE 0. No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | sin `v3_medir`; R huérfano de otro proyecto | `pgrep -lf '[v]3_medir'`, `ps -p`, `lsof -Fn` | ninguno; otro proyecto | ninguno; `slep-central-datos` | ADVIERTE (R-32) | registrar (Q-70) | — | — |
| R-02 | H1-H3 | `rev-parse c504ef8^`, `refs/stash`, `.git/worktrees` | 40ac367; 0; 1 | así | — | ninguna | — | — |
| R-03 | md5 del encargo | `openssl dgst -md5`, `hash-object` | 59a36755… | 59a36755…; blob igual | — | ninguna | — | — |
| R-04 | T0 | `cat-file -p`, `diff-tree` | padre 40ac367; 2 rutas | así | — | ninguna | — | — |
| R-05 | base de I-5 | `find` | 58; 56; 2 | así | — | ninguna | — | — |
| R-06 | cherry y ascendencias | `log --cherry-mark`, `rev-list` | 1; 1+1; 6+1; 6+3; 1; 1 | así | — | ninguna | — | — |
| R-07 | clasificación (a) 2, (b) 6, (c) 7 | `cmp`, `diff --quiet`, `cat-file -e`, `awk` | las 15 clases | las 15 confirmadas | ADVIERTE (R-33) | registrar (D1-a) | — | — |
| R-08 | 7 «−» en `main` | `diff --quiet`, `cat-file -e`, Python | 7 | 7 | — | ninguna | — | — |
| R-09 | merge: 9 conflictos; v26 en la raíz | `git merge-tree --write-tree` | 9; 2 en la raíz | 9; 2; 29 datos | — | ninguna | — | — |
| R-10 | cherry-pick: 1 y 1 | `merge-tree --merge-base=<c>^` | 1; 1 | 1; 1 | — | ninguna | — | — |
| R-11 | worktree quitado; refs | `ls`, `worktree list --porcelain`, `diff` | ausente; 1; igual | así | — | ninguna | — | — |
| R-12 | parquet autorizado; 29 datos | `awk` sobre la lista; árbol de `merge-tree` | L30, L58; 29 | así | — | ninguna | — | — |
| R-13 | paso 35 libre | `awk` sobre `ls-tree` | 0 | 0 | — | ninguna | — | — |
| R-14 | 35 sin guarda; 7 con guarda | `awk` | 0; 7×1 | así | — | ninguna | — | — |
| R-15 | consumidores | `git grep -c`; `cmp` | 10/25; 0 scripts; idéntico | así | ADVIERTE (R-34) | registrar (D1-b) | — | — |
| R-16 | `suitedoc` 0.5.1 / 0.3.0 sin origen | Python (`DESCRIPTION`) | así | así | — | ninguna | — | — |
| R-17 | 18 fuera del lock | Python (`json`) | 40; 58; 18 | así | — | ninguna | — | — |
| R-18 | nadie los pide; 5 directos | Python (dependencias propias) | así | así | ADVIERTE (R-36) | registrar | — | — |
| R-19 | remoto privado con 0.5.1 | `ls-remote`, `curl` sin credenciales, `log -g` | privado; 0.5.1; 2026-08-30 | 404 / 200; 0.5.1; 2026-08-30 | ADVIERTE (R-35) | registrar (Q-71) | — | — |
| R-20 | suite desfasada | Python | 5; 0 | así | — | ninguna | — | — |
| R-21 | 9 años, sin 2026; 18 versionados | `os.listdir`, `ls-files` | así | así | — | ninguna | — | — |
| R-22 | publicado hasta 2025 | Python (`zlib`) | 2025; vacío | así | ADVIERTE (R-38) | registrar | — | — |
| R-23 | literales de año | Python por número de línea | 7 líneas | 7 | — | ninguna | — | — |
| R-24 | manifiesto discrepante | Python | la línea | la línea | ADVIERTE (R-40) | registrar (Q-72) | — | — |
| R-25 a R-29 | I-1 a I-5 | R.3 y R-31 | PASA | PASA | ADVIERTE (R-39, sobre I-1) | registrar | — | — |
| R-30 | alcance global | `alcance.sh` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-31 | identidad y red | `git hash-object`; `grep -c http` + revisión | iguales; 0 cargas | iguales; 0 cargas | — | ninguna | — | — |
| R-32 | un R huérfano (PID 54442, `r11.R`, 100 % de CPU desde el 2026-09-25 a las 21:01) de `slep-central-datos` sigue corriendo; la autorización 2 no lo cubre | `ps`, `lsof` | — | vivo | ADVIERTE | registrar (Q-70) | — | — |
| R-33 | POLITICA de 667e5ad va en (a) aunque `main` la mantenga fuera del índice por diseño (D1-a) | `cmp`, `check-ignore` | — | idéntica e ignorada | ADVIERTE | registrar | — | — |
| R-34 | lecturas fuera de los insumos de §1: el repositorio del consumidor (md5, `ls`, `git grep`) y `herramientas_dev` (`remote`, `ls-remote`, `reflog`, `gh repo view` con GET, `curl`) (D1-b, D2-a). El `ESTADO.md` del consumidor sigue dando por pendiente el push de esta rama (P-CTX-5), que ocurrió en s32 | — | — | sin escritura | ADVIERTE | registrar | — | — |
| R-35 | la premisa «`suitedoc` sin remoto» de los traspasos v29 a v34 está desactualizada desde el 2026-08-30: el remoto existe, pero es privado. No se comparó el binario instalado con la fuente (sí que el código del remoto no cambió desde 0.5.1) | R-19 | — | privado | ADVIERTE | registrar (Q-71) | — | — |
| R-36 | la vía `renv::snapshot(exclude = "suitedoc")` o `packages = …, update = TRUE` para los 17 de CRAN es una hipótesis leída de `?snapshot`: no se probó (snapshot no autorizado) | `formals()`, `Rd2txt` | — | no medible aquí | ADVIERTE | registrar | — | — |
| R-37 | la fecha de la base 2026 (no antes de abril de 2027) es una inferencia por analogía con 2025 | — | — | inferencia | ADVIERTE | registrar | — | — |
| R-38 | R3.2 dice «base64 → gzip → JSON», pero el bloque es zlib (RFC 1950): `memCompress(type = "gzip")` de R escribe zlib, y `memDecompress` lo lee. El resultado no cambia | Python `gzip` falla («Not a gzipped file (b'x\x9c')») y `zlib` lee | — | zlib | ADVIERTE | registrar (evidencia escrita no se edita) | — | — |
| R-39 | `refs/remotes/origin/HEAD` es simbólica y seguirá a `origin/main` tras el push; la lista de excepciones de I-1 no la nombra. Medida antes del push, no cambió | `symbolic-ref` | — | igual | ADVIERTE | registrar | — | — |
| R-40 | `manifiesto_insumos.md` dice que los xlsx Simce no se versionan; los 18 están versionados y autorizados | R-21, R-24 | — | discrepa | ADVIERTE | registrar (Q-72) | — | — |
| R-41 | errores propios de instrumento, todos corregidos antes de registrar: `cherry-pick --abort` tras un `-n` de un commit (R1); `grep` combinado sobre el lock (R2); comillas en `bash -c` (R2, R3); regex de 100.000 caracteres (R3); conteo de `+` en vez de `>` con `--cherry-mark` (R-06); `gzip` en vez de `zlib` en Python (R-22) | — | — | corregidos | ADVIERTE | registrar | — | — |
| R-42 | no se creó CLAUDE.md (regla global frente a §11, que lo excluye como D2, y a D32-5), como en s35 a s35i | — | — | D2 | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA ni REPARA. Las 31 afirmaciones del inventario quedaron confirmadas con instrumentos distintos (`merge-tree` en vez del worktree; Python en vez de R y `grep`; `curl` sin credenciales en vez de `gh`), y los controles positivos dispararon. Hay 11 ADVIERTE (R-32 a R-42), ninguno sobre datos, invariantes ni alcance. Los que más pesan para las decisiones: R-35 (el remoto de `suitedoc` existe pero es privado), R-36 (hipótesis sin probar para registrar los paquetes de CRAN) y R-32 (el R huérfano).

## Cierre

### 1. Resumen

Diagnóstico sin cambios en el producto, en las ramas ni en los paquetes. Una ficha por pendiente:
- **Pendiente 10 (tres ramas locales).**
  - `respaldo_prerebase_20260824` y `respaldo_normativos_20260824` no tienen nada propio: sus commits están en `main` por contenido o están superados, y siguen dentro de `gobernanza/v16` y de `feat/contrato-contexto` (local y `origin`). Recomendación: borrar las dos.
  - `gobernanza/v16` tiene dos archivos únicos: el log de implementación del contrato de contexto (`20260711_contrato_contexto_simce_log.md`, que cita el consumidor) y un standalone regenerado. Su resto está en `main` o superado, y no conviene integrarla como rama (devolvería normativos a un repositorio público). Recomendación: conservar hasta rescatar esos archivos; después, borrar.
- **Pendiente 12 (`feat/contrato-contexto`).** Tiene 5 archivos únicos del paso 35, que conservaría su número.
  - Integrarla por merge da 9 conflictos y un traspaso en la raíz; por cherry-pick de sus 2 commits propios, 2 conflictos de un bloque.
  - Integrar exige además la guarda de locale, regenerar el parquet con 2025 final, decidir su fecha (cambiaría un archivo versionado en cada build) y llevar I-7 de 28 a 29.
  - El parquet ya está autorizado en `main`. Ningún script de `main` lo consume; el consumidor externo no ha avanzado desde el 2026-07-11.
  - Recomendación: dejar.
- **Pendiente 8 (`suitedoc`).** Ya no falta un remoto: `suitedoc` 0.5.1 está en `herramientas_dev` desde el 2026-08-30, pero ese repositorio es privado y este es público. Falta una decisión sobre cómo declararlo en el lock.
  - `V8` y `openssl` los usa el build mismo (paso 33), y hay 18 paquetes fuera del lock, todos explicados por 5 usos directos.
  - Recomendación: sacar `suitedoc` del lock y registrar los 17 paquetes de CRAN (vía por probar).
- **Pendiente 13 (Simce 2026).** No hay insumo 2026; el motor y la vista publicados terminan en 2025. La fuente es la Agencia (descarga manual). Llegar a 2026 toca los pasos 30, 31, 33 y 36 más documentos. Recomendación: sí, bloqueado; mientras tanto, derivar de los archivos los años y los literales de rango.

FASE R: 31 de 31 afirmaciones confirmadas con otros instrumentos; controles positivos disparan; 0 BLOQUEA, 0 REPARA, 11 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log --oneline c504ef8^..HEAD`, antes del commit de este log)

```text
c504ef8 docs(sesion 35): encargo de la decima ola y decision D35-16
```

Más el commit de este log, `docs(log): diagnostico de ramas y pendientes bloqueados (s35j)`. Su hash va en el reporte final: un archivo no puede llevar el hash de su propio commit.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-42).

### 4. Invariantes

I-1 a I-5 en PASA en el estado final (FASE R, R.3), con re-derivación por otra vía (R.2 y R-31). I-3 se mide otra vez tras el commit de este log (condición del push, §10 más abajo y el reporte final). En ninguna tarea un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (59a36755270b703cb80cd674382362a8, verificado).
- En el encargo: D35-16 (Q-67 a Q-69 se cierran sin cambios), commiteada en T0.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2 con `--vanilla`, Python 3.14.7)

- Ramas: prerebase 1 commit (0 únicos); gobernanza 2 (1 único, 9 archivos: a 2, b 5, c 2); normativos 7 (1 único, superado); feat 9 (3 «+»: 1 superado y 2 propios, 5 archivos c).
- Archivos de commits «+»: 15; (a) 2, (b) 6, (c) 7. Commits «−»: 7 de 7 en `main` por contenido.
- Merge de prueba: 9 conflictos (bloques 1, 1, 1, 2, 27, 0, 0, 6, 6) y un `traspaso_cierre_v26.md` en la raíz. Cherry-pick de prueba: 1 + 1 conflictos. Datos versionados tras integrar: 29 (hoy 28).
- Paquetes: lock 40; biblioteca 58; 18 fuera del lock; 5 usos directos (`V8`, `openssl`, `chromote`, `openxlsx`, `suitedoc`); `suitedoc` 0.5.1 en `renv` y 0.3.0 en el sistema; `V8` 8.2.0 y `openssl` 2.4.2 en `renv`.
- `herramientas_dev`: privado (HTTP 404 sin credenciales), con `suitedoc` 0.5.1 en su remoto desde el 2026-08-30; `slep_simce_adecuado`: público (200).
- Insumos Simce: 9 años por nivel (2014-2018, 2022-2025), 0 de 2026, 18 xlsx versionados. Motor y vista publicados: último año 2025; `anios_preliminar` vacío.
- `docs/`: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 (blobs 2554f9a2… y 7cbbdb75…), sin cambio e iguales a `40_salidas/`; 0 cargas por red.

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Preguntas de las fichas (una por pendiente o rama; se responden con una palabra):
1. `respaldo_prerebase_20260824`: ¿se borra la rama local? (borrar / conservar). Recomendación: borrar.
2. `respaldo_normativos_20260824`: ¿se borra la rama local? (borrar / conservar). Recomendación: borrar.
3. `gobernanza/v16`: ¿se borra la rama local? (borrar / conservar). Recomendación: conservar hasta rescatar el log (y el standalone) en un encargo; después, borrar.
4. `feat/contrato-contexto`: ¿se integra a `main`, se archiva como etiqueta o se deja? (integrar / etiqueta / dejar). Recomendación: dejar; integrar por cherry-pick cuando el consumidor programe P-CTX-4.
5. Pendiente 8: ¿cómo se declara `suitedoc` en `renv.lock`? (remoto privado / cellar / fuera del lock). Recomendación: fuera del lock, y registrar los 17 de CRAN tras probar la vía en una copia.
6. Pendiente 13: ¿queda bloqueado hasta que llegue el insumo? (sí / hay otra fuente). Recomendación: sí; mientras, derivar de los archivos los años y los literales de rango.

Dudas nuevas:
- Q-70 (R-32). Un R huérfano de `slep-central-datos` (PID 54442, `r11.R`, 100 % de CPU desde el 2026-09-25 a las 21:01) sigue corriendo; la autorización 2 no lo cubre. ¿Se detiene? (sí / no)
- Q-71 (R-35). Los traspasos v29 a v34 dicen «`suitedoc` sin remoto», pero desde el 2026-08-30 está en un remoto privado. ¿Se corrige esa redacción en el próximo traspaso? (sí / no)
- Q-72 (R-40). `manifiesto_insumos.md` dice que los xlsx Simce no se versionan, y los 18 están versionados y autorizados. ¿Se corrige la frase en el próximo encargo que toque el manifiesto? (sí / no)

Pendientes fuera del encargo (§11): Museo Sans en la suite (D35-7), CLAUDE.md (D2; no se creó) y lo cerrado en D35-11, D35-12, D35-14 y D35-16. Ninguna tarea los tocó.

`# REVISAR` nuevos: ninguno (`grep -c "# REVISAR"` sobre este log = 0, código 1; ningún otro archivo cambió desde el punto de retorno).

### 8. Errores propios consolidados

- Instrumentos, corregidos antes de registrar resultados:
  - `git cherry-pick --abort` tras un `cherry-pick -n` de un solo commit (código 128; lo limpió `worktree remove --force`);
  - un `grep` combinado sobre `renv.lock`;
  - comillas anidadas en `bash -c` (dos veces);
  - un regex de 100.000 caracteres que agotó la memoria;
  - en R-06, contar `+` en vez de `>` con `--cherry-mark`;
  - en R-22, `gzip` en vez de `zlib` en Python.
- Evidencia escrita con una imprecisión que no cambia resultados (no se edita): R3.2 dice «gzip» y el bloque es zlib (R-38).
- R.9 dice que el encabezado recibió el hash del punto de retorno «antes de anexar FASE 0». En realidad fue **justo después** de anexar FASE 0 (orden: FASE 0 anexada → `sed` del encabezado → lectura del traspaso v34). La línea del encabezado no es evidencia y ninguna otra sección cambió. Se declara aquí, sin reescribir R.9.
- Ninguno tocó el producto, las ramas ni los paquetes.

### 9. Notas para el revisor

- Las seis preguntas de §7 bastan para decidir los pendientes 8, 10, 12 y 13. La evidencia de cada ficha está en su FASE (R1, R2, R3).
- Si decide rescatar el log de `gobernanza/v16`: `git show 667e5ad:50_documentacion/andamios/logs/20260711_contrato_contexto_simce_log.md` (165 líneas). Su encabezado dice «No commitear», escrito cuando era un andamio de una rama sin push. Hoy lo cita el traspaso v11 del consumidor.
- La vía para registrar `V8` y `openssl` sin resolver `suitedoc` (`renv::snapshot(exclude = "suitedoc")` o `packages = …, update = TRUE`) salió de `?snapshot` y **no se probó**. Conviene probarla primero en una copia del lock (R-36).
- Este log se publica en un repositorio público y cita, sin datos, metadatos de dos repositorios privados: el `ESTADO.md` y el traspaso v11 de `slep_minuta_buenas_senales` (P-CTX-4 y P-CTX-5) y la visibilidad y los commits de `herramientas_dev`. Los traspasos públicos ya cruzan referencias del mismo tipo.
- El paso 6 de §9 del encargo condiciona el push a la «autorización 4»; la del push es la 6. Se aplicaron las condiciones de la 6.
- Q-70 a Q-72.

### 10. Estado de cierre

- **Commiteado:** T0 (`c504ef8`) y, al cerrar esta sección, este log (`docs(log)`), en `main`.
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío; `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; `git diff --name-only c504ef8^..HEAD` solo con las dos rutas de T0 y este log. Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado del push y el hash de este commit van en el reporte final.
- **Queda al titular:** las seis preguntas de §7 y Q-70 a Q-72.
- **Verificación del archivo** (antes del commit): ver el reporte final (`ls -l`, `wc -l`, conteos de `^### FASE`, `^esperado:`, `^obtenido:` y `^## J`). FASE L es este «Cierre», así que `^### FASE` cuenta 5 (FASE 0, R1, R2, R3 y R).
