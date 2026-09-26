# Encargo autónomo: los años sin Simce salen de la configuración en todos los textos visibles (sesión 35, decimotercera ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Contexto.** `encargo_verificaciones_s35l.md` (segunda emisión) quedó publicado en `main` (`0f419b4`). L3 llevó
`ANIO_INICIO` y `ANIOS_SIN_SIMCE` a `10_utils/10_configuracion.R`, y L4 pasó a un marcador el texto de años
sin Simce de la L425 de la vista. El titular decidió (D35-21, Q-80) que los otros textos fijos de la vista
también salgan de `ANIOS_SIN_SIMCE`. La búsqueda de este turno (`grep -n '2019\|2020\|2021'` sobre las dos
plantillas y el fragmento) halló además dos textos visibles en el motor con los mismos años; entran aquí por
ser el mismo caso.

**Meta en una línea:** ningún texto visible de las páginas escribe a mano los años sin Simce; el contenido
publicado no cambia.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** una tarea corta en serie.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (baterías o build) fallan → **detén la sesión**.
- Si N1 no cumple su criterio tras 3 intentos → revierte sus cambios sin commitear (autorización 3), congélala
  y pasa a FASE R.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y pasa a FASE R.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. (sin uso)
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de N1, después de
   guardar el intento como parche en `$TMPDIR/cal_s35m/` y anotar su md5 en el log.
4. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`.
5. (sin uso)
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío (CLAUDE.md queda ignorado, no cuenta);
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** Las de `CLAUDE.md` en la raíz (léelo primero). R es el único lenguaje de los
entregables. `docs/` solo cambia por copia íntegra, y este encargo no la copia. Antes de dar por buena una
salida, las dos baterías en PASA. La shell es zsh. Un código de salida se lee sin tubería.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:** el log de s35l segunda emisión (L3, L4, R-46, Q-80) y D35-21.
3. **POSICIÓN:** rutas completas; `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`; R con
   `cd "$RAIZ" && Rscript ...`; `rev-parse` con un argumento por comando; `fetch` antes de operar contra el
   remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_textos_anios_s35m_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas;
   - `Rscript 30_procesamiento/33_verificar_motor.R` → código 0 (8 pruebas);
   - `Rscript 30_procesamiento/36_verificar_trayectorias.R` → código 0, con 35 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Todas medidas en este turno con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep` y `sed` sobre la estación.

- `HEAD` y `origin/main` están en `0f419b4`. El árbol tiene dos archivos modificados sin commit, que T0
  commitea: el de decisiones (D35-21) y el registro de errores (ERR-35-26) (fuente: `git rev-parse` y
  `git status --porcelain`).
- `docs/index.html` = `42ab93003e722f9bb6c725fec2d348bd` y `docs/trayectorias.html` =
  `883f76bcefc89d93f2d1e753fc4d75c3` (fuente: `md5sum`, turno anterior; se mide otra vez en H4).
- `grep -n '2019\|2020\|2021'` sobre `36_trayectorias_template.html`, `33_motor_template.html` y
  `33_fragmento_sitio.html` da (fuente: el comando):
  - vista L462: «No existe Simce 2019, 2020 ni 2021.» (texto visible, notas);
  - vista L1032: `gl.textContent='2019 a 2021, sin medición'` (texto visible, pista del eje);
  - vista L1161: un comentario de JavaScript (se deja);
  - motor L5063: `<h4>Gap 2019–2021</h4>` y L5064: «La aplicación del Simce en 2019, 2020 y 2021 fue
    interrumpida…» (texto visible, notas);
  - motor L2347, L2595, L2612 y L2641: comentarios (se dejan).
- `10_utils/10_html.R`: `MARCADOR_ANIOS_SIN_SIMCE <- "__ANIO_SIN_SIMCE__"` (L30); `enumerar_anios()` produce la
  forma «2019, 2020 y 2021»; `sustituir_anios(texto, anios, anios_sin_simce = NULL)` (L98) solo sustituye ese
  marcador si recibe `anios_sin_simce`, y se detiene si queda algo con el prefijo `__ANIO_`. La vista la llama
  con `ANIOS_SIN_SIMCE` (`36_generar_trayectorias.R` L126); el motor, sin él (`33_generar_html.R` L433)
  (fuente: `sed -n 88,125p` y `grep -n`).
- Las tres formas visibles de hoy son distintas: enumeración con «y» («2019, 2020 y 2021»), con «ni»
  («2019, 2020 ni 2021») y rango («2019 a 2021», «2019–2021»). En el motor, Babel escribe el guion largo de
  los textos JSX como `–` en la salida (fuente: log s35k, «Lo que falló»).

---

## 3. Contexto mínimo

Los años sin Simce son un hecho histórico fijo; el objetivo es que el texto de las páginas y la constante no
puedan desacordarse, no que cambien. Con los insumos de hoy, las dos salidas deben quedar iguales a `docs/`.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian, salvo `main` | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L | iguales fuera de `refs/heads/main` y `refs/remotes/origin/main` |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | El contenido de las salidas no cambia | vista: md5 igual a `docs/trayectorias.html`; motor: igual a `docs/index.html` fuera de `meta$fecha_generacion` (si el build corre el mismo día que el publicado, byte a byte) | iguales |
| I-5 | El entorno no cambia | md5 de `renv.lock` y `renv/settings.json` en FASE 0 y en FASE L | idénticos |
| I-6 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, N1, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` |
| N1 | `10_utils/10_html.R`, `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_verificar_motor.R` (solo si M2 necesita conocer marcadores nuevos) |

---

## 6. FASE 0

1. Leer `CLAUDE.md`. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la
   plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_textos_anios_s35m.md`
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `0f419b4` y `rev-parse --short origin/main` →
   `0f419b4`. Guarda las salidas de I-1 e I-5 en `$TMPDIR/s35m/`.
5. **H4.** md5 de este encargo → el del mensaje de entrega. md5 de `docs/` → los de I-2. Después, `git add` de
   las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimotercera ola y decision D35-21"`.
   El hash resultante es el punto de retorno.
6. **H5.** Las dos baterías → código 0 (8 del motor; 35 o más de la vista).
7. **H6.** `Rscript 00_build.R` → código 0, e I-4. Copia las dos salidas a `$TMPDIR/base_s35m/`.
8. **Calibración.** Repite el `grep` de §2 y anota el resultado literal; debe coincidir con §2. Si aparece otra
   línea visible con esos años, entra a N1 si está en el ALCANCE; si no, se registra.
9. Anexa `### FASE 0`.

---

## 7. Tareas

### N1. Los textos visibles de años sin Simce salen de `ANIOS_SIN_SIMCE`

1. En `10_utils/10_html.R`, las formas que faltan como marcadores con el prefijo `__ANIO_` (por ejemplo, una
   con «ni» y una de rango), con funciones de formato junto a `enumerar_anios()`. La de rango se detiene si
   `ANIOS_SIN_SIMCE` no es un tramo consecutivo, con un mensaje que lo diga.
2. Vista L462 y L1032, y motor L5063 y L5064: cada año escrito a mano pasa al marcador de su forma. El motor
   pasa a llamar `sustituir_anios()` con `ANIOS_SIN_SIMCE` (desde `10_configuracion.R`).
3. Si `33_verificar_motor.R` (M2) lee la lista de marcadores desde las fuentes y los nuevos quedan cubiertos,
   no se toca; si no, se ajusta y se anota por qué.
4. **Criterio.**
   - I-4: las dos salidas iguales a `docs/` (en el motor, fíjate en el `–` de Babel);
   - el `grep` de §2 sobre las plantillas: solo comentarios (anota el comando y cada línea que queda);
   - un marcador nuevo mal escrito en una copia de la plantilla detiene el build (control positivo);
   - con `ANIOS_SIN_SIMCE` alterado en una copia a un tramo no consecutivo (por ejemplo 2019 y 2021), la forma
     de rango detiene el build con su mensaje (control positivo);
   - las dos baterías en PASA; I-3.
5. Commit: `refactor(sitio): los años sin Simce de los textos visibles salen de ANIOS_SIN_SIMCE (Q-80)`.

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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_textos_anios_s35m_log.md` y
   `git commit -m "docs(log): textos de anos sin Simce desde la configuracion (s35m)"`. Después, `git push origin main`, solo
   si se cumple la autorización 6. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   la revisión en Safari y en un teléfono de s35h y s35i, y el traspaso de cierre. Incluye el hash de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - el `grep` de FASE 0 y el de N1, línea por línea;
   - los marcadores nuevos y sus funciones de formato;
   - la salida de los dos controles positivos de N1;
   - I-4 con su evidencia y los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

`docs/` y Pages (el contenido no cambia), los comentarios de código con esos años, `documentar.R` y la suite
(Q-81, con su próxima regeneración), `feat/contrato-contexto`, Museo Sans (D35-7), Q-70 y Q-71.

---

## Apéndice: plantilla del log

```markdown
# Log: los años sin Simce en los textos visibles (s35m) (slep_simce_adecuado)

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

### FASE N1

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
