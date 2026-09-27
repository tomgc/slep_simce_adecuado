# Encargo autónomo: últimos textos de documentación al día (sesión 35, decimosexta ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Contexto.** `encargo_readme_s35o.md` dejó el README al día (`f8cadb2`) y dejó cinco dudas que el titular
aprobó resolver juntas (D35-25, abajo). Es el último encargo de documentación de la sesión 35.

**D35-25 (decisión del titular, 2026-09-26; T0 la registra en el archivo de decisiones).**
- Q-90: `.Renviron.example` deja de documentar la raíz de datos y `obtener_data_root_proyecto()`.
- Q-91: el bloque de portabilidad del README pierde la marca «bloque generado, no editar a mano».
- Q-92: `publicacion_github_pages.md` usa la regla del GSE como la dice ahora el README y exige las dos
  baterías antes de publicar.
- Q-93: los comentarios de `10_utils/10_utils.R` y de `30_procesamiento/30_construir_auxiliares.R` se ponen al
  día.
- Q-94: los tres documentos de junio de `50_documentacion/activa/` que la suite reemplaza pasan a `_archivo/`.

**Meta en una línea:** ningún texto de estos cinco puntos afirma algo que el código contradiga; el producto no
cambia.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** cinco ediciones cortas en serie.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 (build) falla → **detén la sesión**.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → regístralo como duda (4.1) y sigue.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. P5: `mkdir -p _archivo/20260926/50_documentacion/activa/`, `mv` de los tres documentos de Q-94 a esa
   carpeta (conservando la ruta relativa, POLITICA §1.5) y `git rm --cached` de sus tres rutas originales si el
   `mv` no las deja fuera del índice; los archivos siguen en el disco (en `_archivo/`, que git ignora) y en el
   historial.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE, después de guardar el
   intento como parche en `$TMPDIR/cal_s35p/` y anotar su md5 en el log.
4. Crear y borrar archivos en `$TMPDIR`.
5. Agregar la línea de s35p a «Últimos cambios» de `CLAUDE.md` y recortar la lista a 5 entradas (D35-22 y
   D35-24; archivo ignorado).
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío (CLAUDE.md queda ignorado, no cuenta);
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** Las de `CLAUDE.md` (léelo primero). Texto en español latinoamericano neutro,
sin guiones largos en lo nuevo. En los `.R`, solo comentarios. Un código de salida se lee sin tubería. La
shell es zsh.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:** el log de s35o (§7, R-18 a R-22, D1-a); `README.md`; `CLAUDE.md`; `00_build.R`;
   `10_utils/10_configuracion.R`; `10_utils/10_validar_portabilidad.R`.
3. **POSICIÓN:** rutas completas; `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`; R con
   `cd "$RAIZ" && Rscript ...`; `rev-parse` con un argumento por comando; `fetch` antes de operar contra el
   remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_documentacion_s35p_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas (el validador revisa `.Renviron.example`: anota su
     resultado antes y después);
   - `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R`
     → código 0.
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Todas medidas en este turno con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep`, `sed`, `cat` y `ls` sobre
la estación.

- `HEAD` y `origin/main` están en `f8cadb2`; árbol limpio (fuente: `git log`, `git rev-parse` y
  `git status --porcelain`). `docs/` = `42ab9300…` y `883f76bc…` (fuente: `md5sum`).
- **Q-90.** `.Renviron.example` documenta «Opción A» (`WORKSPACE_DATA_ROOT`) y «Opción B»
  (`SLEP_SIMCE_ADECUADO_DATA_ROOT`) y pide validar con `obtener_data_root_proyecto()`; al final trae la sección
  de locale con `LANG=es_ES.UTF-8` (fuente: `cat`). Según el log de s35o, ningún código lee esas variables ni
  define esa función (hipótesis, se mide en P1 con `git grep`).
- **Q-91.** `README.md` L277: `<!-- portabilidad-cross-os: bloque generado, no editar a mano -->` (fuente:
  `grep -n`).
- **Q-92.** `50_documentacion/activa/publicacion_github_pages.md` L33: «La segmentación por GSE es inviolable
  y se mantiene en el output publicado.»; L36-37 y L56-57 exigen solo la batería de la vista (fuente:
  `grep -n`). El README acota la regla a la vista de comparación del motor (log s35o, D1-a).
- **Q-93.** `10_utils/10_utils.R` L9-10 lista `json_motor(df, ...)` «(pendiente)» y L226-232 trae un bloque
  «json_motor(): pendiente» con un `TODO` (fuente: `sed`); `30_construir_auxiliares.R` L8-21 enumera tres
  parquet de salida y escribe cuatro (fuente: `sed` y log s35o, R-21).
- **Q-94.** En `50_documentacion/activa/` están `documentacion_proyecto_slep_simce_adecuado.md`,
  `documentacion_proyecto_slep_simce_adecuado.html` y `arquitectura_slep_simce_adecuado.html` (fuente: `ls`).
  Fuera de logs, traspasos, encargos e instantáneas de estructura, solo se citan entre sí (fuente: `git grep`).
  `.gitignore` L31 ignora `_archivo/` completo, y POLITICA §1.5 dice que los obsoletos van a
  `_archivo/YYYYMMDD/` conservando la ruta relativa, fuera de Git (fuente: `git check-ignore -v` y `sed` de
  POLITICA L272-276).

---

## 3. Contexto mínimo

Cinco textos que describen el proyecto de forma que el código contradice. Se corrigen o se archivan; nada del
producto cambia.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian, salvo `main` | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L | iguales fuera de `refs/heads/main` y `refs/remotes/origin/main` |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | El código de los `.R` no cambia, solo sus comentarios | por archivo tocado: `parse()` antes y después e `identical()` de sus expresiones | `TRUE` |
| I-4 | Las salidas no cambian | build de H5 y final: la vista con `cmp`; el motor por contenido fuera de `meta$fecha_generacion` | iguales |
| I-5 | El entorno no cambia | md5 de `renv.lock` y `renv/settings.json` en FASE 0 y en FASE L | idénticos |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, P1 a P5, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` (agregar D35-25) |
| P1 | `.Renviron.example` |
| P2 | `README.md` (solo la marca de L277) |
| P3 | `50_documentacion/activa/publicacion_github_pages.md` |
| P4 | `10_utils/10_utils.R`, `30_procesamiento/30_construir_auxiliares.R` (solo comentarios) |
| P5 | los tres documentos de §2 (Q-94) y `_archivo/20260926/50_documentacion/activa/` (ignorada) |

---

## 6. FASE 0

1. Leer `CLAUDE.md`. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la
   plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente esta línea, más el log:
   - `?? 50_documentacion/activa/encargos/encargo_documentacion_s35p.md`
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `f8cadb2` y `rev-parse --short origin/main` →
   `f8cadb2`. Guarda las salidas de I-1 e I-5 en `$TMPDIR/s35p/`.
5. **H4.** md5 de este encargo → el del mensaje de entrega. md5 de `docs/` → los de I-2. Agrega al archivo de
   decisiones una sección `### D35-25` con el texto del Contexto de este encargo. Después, `git add` de las dos
   rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimosexta ola y decision D35-25"`. El hash
   resultante es el punto de retorno.
6. **H5.** `Rscript 00_build.R` → código 0; copia las dos salidas a `$TMPDIR/base_s35p/`; anota lo que dice el
   validador de portabilidad sobre `.Renviron.example`.
7. Anexa `### FASE 0`.

---

## 7. Tareas

### P1. `.Renviron.example` sin la raíz de datos (Q-90)

1. `git grep -n 'WORKSPACE_DATA_ROOT\|SLEP_SIMCE_ADECUADO_DATA_ROOT\|obtener_data_root_proyecto'` fuera de
   `50_documentacion/` y de `.Renviron.example`. Si da 0, se quitan del ejemplo las opciones A y B y su
   validación, y queda la sección de locale con una cabecera que diga para qué sirve el archivo. Si da algo,
   se registra y se congela P1.
2. **Criterio.** El `grep` de arriba sobre `.Renviron.example` → 0; `LANG=es_ES.UTF-8` sigue; el validador de
   portabilidad no cambia su resultado respecto de H5 (o mejora; anota cuál).
3. Commit: `docs(entorno): .Renviron.example sin la raiz de datos que el codigo no usa (Q-90)`.

### P2. El bloque de portabilidad del README deja de decir «generado» (Q-91)

1. La marca de L277 pasa a una que diga que el bloque se mantiene a mano desde s35o (o se quita, con su cierre
   si lo tiene). Nada más del README cambia.
2. **Criterio.** `grep -c 'no editar a mano' README.md` → 0; `git diff` del README solo toca esa marca.
3. Commit: `docs(readme): el bloque de portabilidad se mantiene a mano (Q-91)`.

### P3. La guía de publicación al día (Q-92)

1. En `publicacion_github_pages.md`: la regla del GSE con la redacción del README (D1-a de s35o); el
   procedimiento exige las dos baterías (motor y vista) antes de copiar a `docs/`, con sus comandos; revisa el
   resto del documento contra `CLAUDE.md` y el README y corrige lo que el código contradiga (inventario breve
   en el log).
2. **Criterio.** `grep -n 'inviolable'` → 0 o acotado igual que el README; `grep -n '33_verificar_motor.R'` →
   al menos 1; cada comando del documento corre o existe (anota el cotejo).
3. Commit: `docs(publicacion): regla del GSE acotada y las dos baterias antes de publicar (Q-92)`.

### P4. Comentarios de `10_utils.R` y del paso 30 (Q-93)

1. `10_utils.R`: la lista de funciones expuestas refleja las que el archivo define (`grep -n '<- function'`);
   se quita el bloque «json_motor(): pendiente» y su `TODO` si solo son comentarios. `30_construir_auxiliares.R`:
   el encabezado enumera los parquet que escribe (cotéjalo con sus `write_parquet`).
2. **Criterio.** I-3 en los dos; `grep -n 'json_motor'` fuera de `50_documentacion/` → 0; el número de parquet
   del encabezado = el de `write_parquet` del archivo.
3. Commit: `docs(codigo): comentarios de 10_utils.R y del paso 30 al dia (Q-93)`.

### P5. Documentos de junio a `_archivo/` (Q-94)

1. Mueve los tres a `_archivo/20260926/50_documentacion/activa/` (autorización 2). Salen del repositorio (en
   GitHub quedan en el historial) y se conservan en el disco, como pide POLITICA §1.5.
2. Si algún documento vigente fuera de logs, traspasos, encargos y estructura los cita, se actualiza la ruta
   (anota cuál; si no está en el ALCANCE, se registra).
3. **Criterio.** `git ls-files` ya no lista las tres rutas; los tres existen en
   `_archivo/20260926/50_documentacion/activa/` con el mismo md5 que tenían en `activa/` (anótalo antes de
   moverlos); `git status --porcelain` tras el commit no los muestra.
4. Commit: `docs(activa): retira la documentacion de junio que reemplaza la suite (Q-94)`.

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
5. **Regresión completa.** Los tres comandos de PRUEBAS sobre el estado final.
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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_documentacion_s35p_log.md` y
   `git commit -m "docs(log): ultimos textos de documentacion al dia (s35p)"`. Después, `git push origin main`, solo
   si se cumple la autorización 6. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   el traspaso de cierre. Incluye el hash de `docs(log)` y la línea agregada a `CLAUDE.md` (autorización 5).

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - por tarea P1 a P5: el `grep` o cotejo del criterio, antes y después;
   - I-3 e I-4 con su evidencia y los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

El código (solo comentarios), `docs/`, la suite (Q-89), `renv`, `feat/contrato-contexto`, Museo Sans (D35-7),
Q-70 y Q-71. Si el inventario de P3 halla textos desactualizados fuera del ALCANCE, se registran sin editar.

---

## Apéndice: plantilla del log

```markdown
# Log: últimos textos de documentación al día (s35p) (slep_simce_adecuado)

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

### FASE P1 ... ### FASE P5 (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
