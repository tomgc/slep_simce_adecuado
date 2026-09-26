# Encargo autónomo: diagnóstico de ramas y pendientes bloqueados (sesión 35, décima ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva o tras `/clear`.

**Contexto.** `encargo_bateria_familias_s35i.md` quedó publicado (`40ac367`). El titular cerró sus dudas
(D35-16, en `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`). De los pendientes
del traspaso v34 quedan cuatro que dependen de una decisión del titular o de algo externo:

- **Pendiente 10.** Ramas locales sin publicar: `gobernanza/v16`, `respaldo_normativos_20260824` y
  `respaldo_prerebase_20260824`.
- **Pendiente 12.** Destino de la rama `feat/contrato-contexto` (productor del contrato de contexto, paso 35).
- **Pendiente 8.** `V8` y `openssl` en `renv.lock`, la suite standalone, `documentar.R` y `34_historico`,
  bloqueados por `suitedoc` sin remoto.
- **Pendiente 13.** Actualización anual Simce 2026, bloqueada por insumos.

**Este encargo solo diagnostica.** No cambia el producto, no borra ni mueve ramas, no integra nada. Su
entregable es el log, con una ficha por pendiente que termina en una pregunta cerrada y una recomendación.

**Meta en una línea:** que el titular pueda decidir los pendientes 8, 10, 12 y 13 leyendo solo el log.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** es lectura en serie de un solo
repositorio.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por medición; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- Cualquier comando que fuera a cambiar una ref, el árbol de trabajo principal o el remoto, fuera de las
  autorizaciones → no lo corras; regístralo como duda.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add` de las rutas de T0 y `git commit` en T0; `git add` del log y `git commit` en FASE L.
2. **Shells de la sesión anterior.** Si la lista de tareas en segundo plano de Claude Code muestra shells que
   esperan a `v3_medir.R` (bucles `until ! pgrep -f v3_medir.R …`, que nunca terminan porque `pgrep -f` se
   encuentra a sí mismo), detenlas. Antes, confirma con `ps aux | grep '[R]script.*v3_medir'` que no queda un
   R de esa medición corriendo; si queda uno, no lo detengas y regístralo como duda.
3. Crear un worktree temporal en `$TMPDIR/wt_s35j`, **desacoplado** (`git worktree add --detach`), para
   probar en él la integración de `feat/contrato-contexto` sobre `main` (sin commitear en él). Se quita con
   `git worktree remove --force $TMPDIR/wt_s35j` al terminar R1.
4. Leer (sin instalar ni actualizar paquetes) el estado de `suitedoc`, `V8` y `openssl` en la biblioteca de
   `renv` y en `renv.lock`, con R o con `grep`.
5. Archivos en `$TMPDIR`.
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío;
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - `git diff --name-only <punto_de_retorno>^..HEAD` solo con las rutas de T0 y el log.

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más. En particular, **no** se
autoriza `git branch -d/-D`, `git push` de otra rama, `git merge` en el árbol principal, `renv::restore()`,
`renv::snapshot()` ni `install.packages()`.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables. Los commits van en español. Un
código de salida se lee sin tubería. `grep -c` sale con código 1 cuando cuenta 0 (A34-3): va en su propia línea.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - `50_documentacion/traspasos/traspaso_cierre_v34.md`, §11 (pendientes 8, 10, 12 y 13);
   - los traspasos donde nacieron esas ramas y ese bloqueo (búscalos por nombre de rama o por «suitedoc» en
     `50_documentacion/traspasos/`);
   - `50_documentacion/activa/contrato_contexto_v1.md` **tal como está en la rama** (`git show
     feat/contrato-contexto:50_documentacion/activa/contrato_contexto_v1.md`).
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...`;
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_ramas_bloqueos_s35j_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:** no aplica build ni batería (no cambia el producto). La regresión es I-1 a I-4.
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Medidas en la sesión 35 con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`) y `grep` sobre la estación.

- `HEAD` y `origin/main` están en `40ac367`. El árbol tiene un solo archivo modificado, el de decisiones
  (D35-16) (fuente: `git log`, `git rev-parse` y `git status --porcelain`).
- Ramas (fuente: `git branch -a` y `git ls-remote --heads origin`):
  - `gobernanza/v16` (`667e5ad`, 2026-08-24): configurada con remoto `origin`, pero la rama remota **no
    existe** (el remoto solo tiene `main` y `feat/contrato-contexto`).
  - `respaldo_normativos_20260824` (`b9426c2`) y `respaldo_prerebase_20260824` (`e86b0d2`): sin remoto.
  - `feat/contrato-contexto` (`31befa2`, 2026-07-11): publicada en `origin`.
- `git cherry -v main <rama>` (fuente: el comando; «−» = ya en `main` por parche, «+» = no está por parche):
  - `respaldo_prerebase_20260824`: 1 commit, «−».
  - `gobernanza/v16`: 2 commits; «−» `e86b0d2`; «+» `667e5ad` «docs(cierre): commitea documentacion
    pendiente de sesiones previas» (9 archivos: POLITICA, SETTINGS, un log de 2026-07-11, cuatro
    instantáneas de estructura, la suite standalone y `documentar.R`).
  - `respaldo_normativos_20260824`: 7 commits; 6 «−»; «+» `98c3f6a` «docs: actualizar ESTADO.md v24->v26».
  - `feat/contrato-contexto`: 9 commits; los mismos 7 de `respaldo_normativos` (6 «−» y `98c3f6a` «+»),
    más «+» `6e00830` (normalizador, `31_leer_normalizar.R`, +85/−15) y «+» `31befa2` (paso 35:
    `00_build.R`, `35_exponer_contrato_contexto.R`, `40_salidas/publico/contexto_simce.parquet` y
    `contrato_contexto_v1.md`) (fuente: `git show --stat`).
- Hipótesis (se mide en R1): un «+» de `git cherry` no significa que su contenido falte en `main`; puede estar
  integrado con otro parche o haber sido superado. Por eso R1 compara contenido, no solo parches.
- `main` hoy **no** tiene `30_procesamiento/35_*` (fuente: `ls 30_procesamiento`), y `36_*` ya ocupa el paso
  siguiente. `40_salidas/publico/contexto_simce.parquet` sería un archivo de datos versionado (I-7 cuenta hoy
  28) (hipótesis, se mide en R1 contra `50_documentacion/activa/50_datos_versionados_autorizados.md`).
- `suitedoc` no aparece en `renv.lock`; `50_documentacion/suite/documentar.R` lo llama
  (`suitedoc::generar_suite(`, L420) (fuente: `grep`). `V8` y `openssl` en `renv.lock`: hipótesis, se mide en
  R2 (el único acierto de `grep -i openssl` fue un `SystemRequirements` de otro paquete).
- `20_insumos/simce/` tiene las carpetas `2m` y `4b` (fuente: `ls`). Qué años contienen: se mide en R3.

---

## 3. Contexto mínimo

El titular necesita, por pendiente, qué hay, qué se pierde si se descarta, qué cuesta integrarlo y una
pregunta que se responda con una palabra. Nada se ejecuta: la decisión y la acción van en un encargo posterior.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L, salvo `refs/heads/main` y `refs/remotes/origin/main` | idénticas |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab93003e722f9bb6c725fec2d348bd` y `883f76bcefc89d93f2d1e753fc4d75c3` |
| I-3 | El producto no cambia | `git diff --name-only <punto_de_retorno>..HEAD` | solo el log |
| I-4 | Sin worktrees ni stash nuevos | `git worktree list` y `git stash list \| wc -l` en FASE L | solo el árbol principal; `0` |
| I-5 | La biblioteca no cambia | `renv.lock` sin cambios y ningún paquete instalado o actualizado (lista de la biblioteca de `renv` con versiones, en FASE 0 y en FASE L) | idénticas |

---

## 5. Tareas y ALCANCE

El orden es fijo: FASE 0 (con las shells), T0, R1, R2, R3, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` |
| R1, R2, R3 | ninguna ruta del árbol (solo el log y `$TMPDIR`) |

---

## 6. FASE 0

1. **Shells de la sesión anterior** (autorización 2). Registra qué había y qué se detuvo.
2. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
3. **H1.** `git status --porcelain` → esperado, exactamente estas dos líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - `?? 50_documentacion/activa/encargos/encargo_ramas_bloqueos_s35j.md`
4. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
5. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `40ac367` y `rev-parse --short origin/main` →
   `40ac367`.
6. **H4.** md5 de este encargo → esperado: el del mensaje de entrega. Guarda la salida de I-1 y de I-5 en
   `$TMPDIR/s35j/`. Después, `git add` de las dos rutas de T0 y
   `git commit -m "docs(sesion 35): encargo de la decima ola y decision D35-16"`. El hash resultante es el
   punto de retorno.
7. Anexa `### FASE 0`.

---

## 7. Tareas

### R1. Ramas (pendientes 10 y 12)

1. Para cada commit «+» de §2 (`667e5ad`, `98c3f6a`, `6e00830`, `31befa2`), y por cada archivo que toca:
   compara el contenido de la rama con el de `main` (`git diff main <rama> -- <archivo>` y lectura). Clasifica
   cada archivo en una de tres, con una línea de evidencia:
   - **(a) ya en `main`:** el contenido está, aunque con otro parche;
   - **(b) superado:** `main` tiene una versión posterior del mismo documento o instantánea que lo reemplaza
     (por ejemplo, POLITICA o SETTINGS con número de versión mayor, o `ESTADO.md` más nuevo);
   - **(c) único y vigente:** se perdería si se borra la rama.
2. Para los commits «−», confirma con otro método (contenido del archivo en `main`) que de verdad están.
3. **`feat/contrato-contexto`.** Además de lo anterior:
   - en el worktree (autorización 3), desacoplado en `main`, intenta integrar la rama sin commitear
     (`git merge --no-commit --no-ff feat/contrato-contexto`) y registra si hay conflictos y en qué archivos;
     después `git merge --abort` y quita el worktree;
   - resume en cinco líneas qué produce el paso 35 según `contrato_contexto_v1.md` de la rama, quién lo
     consume (busca referencias en `50_documentacion/` de `main`) y si `contexto_simce.parquet` está en la
     lista de datos versionados autorizados;
   - anota qué número de paso tendría al integrarse, dado que `36_*` ya existe.
4. **Ficha por rama** en el log: qué contiene, qué se pierde si se borra (solo lo de la clase c), qué cuesta
   integrarla, una pregunta cerrada y una recomendación en una línea. Para `respaldo_*` y `gobernanza/v16`,
   la pregunta es «¿se borra la rama local? (borrar / conservar)». Para `feat/contrato-contexto`, «¿se integra
   a `main`, se archiva como etiqueta o se deja? (integrar / etiqueta / dejar)».

### R2. Pendiente 8 (bloqueos de `suitedoc`)

1. Mide, sin instalar nada (autorización 4):
   - si `suitedoc` está instalado en la biblioteca de `renv` y en la del sistema, con su versión y los
     campos `RemoteType`, `RemoteUrl` o `Repository` de su `DESCRIPTION`;
   - si `V8` y `openssl` están en `renv.lock` y en la biblioteca, y quién los pide (dependencias inversas de
     lo instalado);
   - qué dice el traspaso de origen sobre «suitedoc sin remoto», la «suite standalone» y `34_historico`
     (cita la línea).
2. **Ficha** en el log: qué falta exactamente para destrabar (un remoto, una versión, una decisión), qué se
   puede hacer sin eso, pregunta cerrada y recomendación.

### R3. Pendiente 13 (Simce 2026)

1. Lista los años disponibles en `20_insumos/simce/2m` y `20_insumos/simce/4b` (nombres de archivo, sin abrir
   datos), y el último año que usa el motor (`meta` del build publicado o la configuración del pipeline).
2. **Ficha** en el log: qué insumo falta, de dónde vendría según los traspasos, qué pasos del pipeline se
   tocarían, pregunta cerrada («¿queda bloqueado hasta que llegue el insumo? (sí / hay otra fuente)») y
   recomendación.

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
5. **Regresión completa.** I-1 a I-5 sobre el estado final.
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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_ramas_bloqueos_s35j_log.md` y
   `git commit -m "docs(log): diagnostico de ramas y pendientes bloqueados (s35j)"`. Después, `git push origin main`, solo
   si se cumple la autorización 4. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   las decisiones de las fichas (una pregunta cerrada por pendiente). Incluye el hash de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - qué shells de la sesión anterior se detuvieron;
   - una tabla por rama con sus archivos clasificados en (a), (b) o (c), y el resultado de la integración de
     prueba de `feat/contrato-contexto`;
   - las fichas de R1, R2 y R3, cada una con su pregunta cerrada y su recomendación;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

Todo cambio del producto, de `docs/`, de ramas o de paquetes. Museo Sans en la suite (decisión de cartera,
D35-7, para una sesión BIBLIOTECA). CLAUDE.md (D2). Lo cerrado o aceptado en D35-11, D35-12, D35-14 y D35-16.

---

## Apéndice: plantilla del log

```markdown
# Log: diagnóstico de ramas y pendientes bloqueados (s35j) (slep_simce_adecuado)

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

### FASE R1 ... ### FASE R3 (una sección por tarea, con sus fichas)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
