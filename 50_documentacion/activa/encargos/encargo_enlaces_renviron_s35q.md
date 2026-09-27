# Encargo autónomo: enlaces del README, `.Renviron.example` y columna COD_DEPE (sesión 35, decimoséptima ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Contexto.** `encargo_documentacion_s35p.md` quedó publicado (`8f10463`) con P1 congelada y tres enlaces rotos
en el README (P5 archivó documentos que el README enlazaba; error del redactor, ERR-35-29). El titular aprobó
(D35-26, abajo):

- **Q-97.** Quitar del README las entradas que enlazan los documentos archivados.
- **Q-95.** Ejecutar P1 de s35p: `.Renviron.example` sin la raíz de datos. Las dos líneas del validador que
  nombran esas variables solo las revisan como parte de la plantilla de la cartera; no cuentan como uso.
- **Q-96.** El criterio de `json_motor` de s35p se mide como palabra completa (`git grep -nw`): queda cumplido.
- **Q-98.** El paso 30 valida también la columna `COD_DEPE` del directorio, que usa y hoy no revisa.

**Meta en una línea:** el README publicado sin enlaces rotos, `.Renviron.example` sin lo que el proyecto no
usa y el paso 30 validando todas las columnas del directorio que lee; las salidas no cambian.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** tres ediciones cortas en serie.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 (build) falla → **detén la sesión**.
- Si una tarea no cumple su criterio tras 3 intentos → revierte sus cambios sin commitear (autorización 3),
  congélala y sigue con la siguiente.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → regístralo como duda (4.1) y sigue.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. (sin uso)
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE, después de guardar el
   intento como parche en `$TMPDIR/cal_s35q/` y anotar su md5 en el log.
4. Crear y borrar archivos en `$TMPDIR`; copias del repositorio en `$TMPDIR` para el control de Q3.
5. Agregar la línea de s35q a «Últimos cambios» de `CLAUDE.md` y recortar la lista a 5 entradas (D35-22 y
   D35-24; archivo ignorado).
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío (CLAUDE.md queda ignorado, no cuenta);
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** Las de `CLAUDE.md` (léelo primero). Texto nuevo sin guiones largos. Una
búsqueda que respalde una ausencia se lee **completa**, nunca con `head` (lección de ERR-35-29). Un código de
salida se lee sin tubería. La shell es zsh.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:** el log de s35p (§7, Q-95 a Q-98, P1, P5); `README.md`; `.Renviron.example`;
   `10_utils/10_validar_portabilidad.R`; `30_procesamiento/30_construir_auxiliares.R`.
3. **POSICIÓN:** rutas completas; `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`; R con
   `cd "$RAIZ" && Rscript ...`; `rev-parse` con un argumento por comando; `fetch` antes de operar contra el
   remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_enlaces_renviron_s35q_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas;
   - `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R`
     → código 0.
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Todas medidas en este turno con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep`, `sed` y `wc`, con la
salida completa.

- `HEAD` y `origin/main` están en `8f10463`. El árbol tiene un solo archivo modificado, el registro de errores
  (ERR-35-29), que T0 commitea (fuente: `git log`, `git rev-parse` y `git status --porcelain`). `docs/` =
  `42ab9300…` y `883f76bc…` (fuente: turno anterior; se mide en H4).
- **Q-97.** `git grep -l` de `documentacion_proyecto_slep_simce_adecuado.(md|html)` y
  `activa/arquitectura_slep_simce_adecuado`, fuera de andamios, traspasos, encargos y estructura, da **solo**
  `README.md` (fuente: el comando, sin `head`). En el README: L246-251 (entrada del `.md`, que nombra también el
  `.html`) y L252-256 (entrada de `arquitectura_…html`); la suite ya está enlazada en L240 (fuente: `sed -n
  236,258p` y `grep -n`).
- **Q-95.** `.Renviron.example` tiene 34 líneas: opciones A (`WORKSPACE_DATA_ROOT`) y B
  (`SLEP_SIMCE_ADECUADO_DATA_ROOT`), su validación con `obtener_data_root_proyecto()` y la sección de locale
  con `LANG=es_ES.UTF-8` (fuente: `cat` y `wc -l`). `10_validar_portabilidad.R` L262 y L280 nombran
  `obtener_data_root_proyecto` y las variables al revisar el entorno (plantilla de la cartera), y L248-249 exige
  que `.Renviron.example` **exista** (fuente: `sed` y `grep -n`). El archivo se queda; cambia su contenido.
- **Q-98.** `30_construir_auxiliares.R` L162-168 valida `AGNO`, `RBD`, `NOM_RBD`, `COD_COM_RBD`,
  `NOM_COM_RBD`, `COD_REG_RBD`, `NOM_REG_RBD_A`, `COD_DEPE2`, `MATRICULA` y `ESTADO_ESTAB`; L334-335 filtra por
  `COD_DEPE` (== 6 y %in% c(1, 2)), que no está en la lista (fuente: `sed -n 158,180p` y `grep -n`).

---

## 3. Contexto mínimo

Un defecto publicado que corregir primero (Q-97) y dos ajustes chicos. El contenido de las páginas publicadas
no cambia.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian, salvo `main` | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L | iguales fuera de `refs/heads/main`, `refs/remotes/origin/main` y `refs/remotes/origin/HEAD` |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | Las salidas no cambian | build de H5 y final: la vista con `cmp`; el motor por contenido fuera de `meta$fecha_generacion` | iguales |
| I-4 | El entorno no cambia | md5 de `renv.lock` y `renv/settings.json` en FASE 0 y en FASE L | idénticos |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, Q1, Q2, Q3, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` (agregar D35-26) |
| Q1 | `README.md` |
| Q2 | `.Renviron.example` |
| Q3 | `30_procesamiento/30_construir_auxiliares.R` |

---

## 6. FASE 0

1. Leer `CLAUDE.md`. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la
   plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas dos líneas, más el log:
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_enlaces_renviron_s35q.md`
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `8f10463` y `rev-parse --short origin/main` →
   `8f10463`. Guarda las salidas de I-1 e I-4 en `$TMPDIR/s35q/`.
5. **H4.** md5 de este encargo → el del mensaje de entrega. md5 de `docs/` → los de I-2. Agrega al archivo de
   decisiones una sección `### D35-26` con las cuatro decisiones del Contexto. Después, `git add` de las tres
   rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimoseptima ola y decision D35-26"`. El hash
   resultante es el punto de retorno.
6. **H5.** `Rscript 00_build.R` → código 0; copia las dos salidas a `$TMPDIR/base_s35q/`; anota el resultado
   del validador para `.Renviron.example`.
7. **Q-96.** `git grep -nw 'json_motor' -- ':!50_documentacion'` → esperado 0 (salida completa); se anota como
   cierre del criterio de P4 de s35p.
8. Anexa `### FASE 0`.

---

## 7. Tareas

### Q1. El README sin enlaces a los documentos archivados (Q-97)

1. Quita las dos entradas de §2 (L246-256). Si otra línea del README los nombra, también.
2. **Criterio.** El `git grep -l` de §2 (sin `head`) → vacío; cada enlace relativo del README apunta a un
   archivo o carpeta que existe (anota el cotejo completo); `git diff` del README solo quita esas entradas.
3. Commit: `docs(readme): quita los enlaces a la documentacion de junio archivada (Q-97)`.

### Q2. `.Renviron.example` sin la raíz de datos (Q-95)

1. Quita las opciones A y B y su validación; deja la sección de locale con `LANG=es_ES.UTF-8` y una cabecera
   que diga para qué sirve el archivo y que se copia a `~/.Renviron`.
2. **Criterio.** `grep -c 'DATA_ROOT\|obtener_data_root'` sobre `.Renviron.example` → 0; `LANG=es_ES.UTF-8`
   presente; el validador da para `.Renviron.example` el mismo resultado que en H5 (anótalo).
3. Commit: `docs(entorno): .Renviron.example sin la raiz de datos que el proyecto no usa (Q-95)`.

### Q3. El paso 30 valida `COD_DEPE` (Q-98)

1. Agrega `"COD_DEPE"` a `cols_csv_esperadas` (L162-168), con el comentario que ya explica la lista.
2. **Criterio.**
   - I-3 (las salidas no cambian);
   - control positivo: en una copia del repositorio en `$TMPDIR` con la columna `COD_DEPE` quitada del
     directorio, el build se detiene en el paso 30 con «Faltan columnas en directorio_oficial_ee.csv»; con el
     código de antes, esa misma copia **no** se detiene ahí (anota dónde falla o si pasa);
   - build y las dos baterías en PASA.
3. Commit: `fix(pipeline): el paso 30 valida la columna COD_DEPE del directorio (Q-98)`.

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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_enlaces_renviron_s35q_log.md` y
   `git commit -m "docs(log): enlaces del README, Renviron y COD_DEPE (s35q)"`. Después, `git push origin main`, solo
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
   - Q-96: la salida del `git grep -nw` de FASE 0;
   - por tarea Q1 a Q3: el criterio antes y después, y el control positivo de Q3;
   - I-3 con su evidencia y los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

`docs/`, la suite, `10_validar_portabilidad.R` (plantilla de la cartera), `renv`, `feat/contrato-contexto`,
Museo Sans (D35-7), Q-70 y Q-71.

---

## Apéndice: plantilla del log

```markdown
# Log: enlaces del README, `.Renviron.example` y columna COD_DEPE (s35q) (slep_simce_adecuado)

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

### FASE Q1 ... ### FASE Q3 (una sección por tarea)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
