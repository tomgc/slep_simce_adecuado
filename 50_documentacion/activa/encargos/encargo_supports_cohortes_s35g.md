# Encargo autónomo: navegadores sin text-box, cohortes y tooltip angosto (sesión 35, séptima ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-25. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva.

**Contexto.** `encargo_tooltip_centrado_s35f.md` quedó publicado (`6c51362`, Pages con md5 `65f2f59b…`) y el
titular lo aprobó en Safari. Quedan tres dudas de su log que el titular decidió resolver:

- **Q-59.** En navegadores sin `text-box` (Safari < 18.2, Firefox < 154, Chrome < 133), el relleno que compensa
  el recorte se aplica igual, y el menú y los botones crecen entre 4,5 y 6,8 px.
- **Q-58.** El `<span class="tx">` de los botones de cohorte lo agrega JavaScript al iniciar la vista, en vez
  del generador en R.
- **Q-54.** A 375 px, cuando el tooltip no cabe a ningún lado del punto, lo tapa.

**Meta en una línea:** que un navegador sin `text-box` vea el sitio exactamente como antes de s35f, que el
marcado de las cohortes salga del generador, y que el tooltip no tape el punto a 375 px. Todo publicado en
Pages.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** es una cadena corta en serie que
termina en un acto público.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (batería o build) fallan → **detén la sesión**.
- Si G1, G2 o G3 no cumplen su criterio tras 3 intentos → congela esa tarea. **Con cualquier tarea congelada
  no hay copia a `docs/` ni push**. El resto se commitea igual.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. `cp 40_salidas/motor_comparacion.html docs/index.html` y
   `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html`, solo en PUB y con G1, G2 y G3 completas.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   después de guardar el intento como parche en `$TMPDIR/cal_s35g/` y anotar su md5 en el log.
4. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío;
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` iguales a los de PUB.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`.
6. `curl -s` y `curl -sI` de lectura contra las dos URL públicas, solo en P3.
7. Crear `_archivo/20260925_capturas_s35g/` (ignorado) y escribir capturas en esa carpeta.
8. Crear un worktree temporal fuera del árbol, en `$TMPDIR/wt_476b1e1`, con
   `git worktree add --detach $TMPDIR/wt_476b1e1 476b1e1`, y construir ahí la referencia «antes de s35f». Se
   quita con `git worktree remove $TMPDIR/wt_476b1e1` al terminar G1.

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables. Los commits van en español. Toda
medida nueva va en una constante nombrada. `docs/` solo cambia por copia íntegra. I-7 se mide en forma
absoluta. Los `.otf` no se editan.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - el log de s35f: FASE TB, FASE TT, R-33, R-38, R-40, Q-54, Q-58 y Q-59;
   - el diff del commit `fa89e7c` (centrado) y el de `6f74d70` (tooltip);
   - los medidores de la raíz: `verificar_centrado.R` y los de TT de s35f.
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...`;
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260925_supports_cohortes_s35g_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0;
   - batería → código 0, con 32 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Salvo que se indique otra cosa, cada premisa se midió en la sesión 35 con git de solo lectura, `grep`, `sed`,
`md5sum` o `curl` sobre la estación.

- `HEAD` y `origin/main` están en `6c51362`, y el árbol está limpio salvo este encargo (hipótesis, se mide
  en H1). Pages sirve `65f2f59bcccd8da57e0aa4aa07a2533c` para el motor, igual a `docs/index.html`
  (fuente: `curl` y `md5sum`). `docs/trayectorias.html` tiene md5 `713dfa9d1e6750b8562ff0300179b53a`.
- El commit `fa89e7c` (centrado de s35f) cambió `33_fragmento_sitio.html`, `33_motor_template.html` y
  `36_trayectorias_template.html` (fuente: `git show --stat`). Esas reglas usan `text-box: trim-both cap
  alphabetic`, relleno `calc(... + var(--compensa-recorte))`, `min-height` con `1lh`, y
  `--ajuste-optico-select` con `1cap` y `round()` (fuente: `git show fa89e7c | grep`). Ninguna de las tres
  plantillas tiene hoy un `@supports` (fuente: `grep -c '@supports'`, 0 en las tres).
- Riesgo agregado por el asistente (hipótesis, se mide en G1). Un navegador que no conoce `1cap` o `lh`
  invalida al momento de calcular las declaraciones que los usan. Por ejemplo, el `padding-top` del
  `<select>` podría quedar en 0 en vez de volver al valor anterior. Por eso G1 lleva **todas** esas
  declaraciones al bloque `@supports`, y no solo el relleno.
- Cohortes: `botones_cohortes()` está en `30_procesamiento/36_generar_trayectorias.R` (L72) y se inserta en la
  L119. La plantilla de la vista reescribe el texto de cada botón con JavaScript en la L1153
  (`var e=document.createElement('span');e.className='tx';...b.replaceChild(e,t);`) (fuente: `grep -n`).
- Tooltip: `ubicarTooltip()` en el motor (L2016-2033) prueba derecha, luego izquierda, luego acota a la
  ventana. No prueba arriba ni abajo del punto (fuente: `grep -A`).

---

## 3. Contexto mínimo

`text-box` recorta la caja del texto a la altura de mayúscula y a la línea base, y s35f devolvió lo recortado
como relleno. En un navegador que no conoce `text-box` no se recorta nada, pero el relleno igual se suma. La
solución es que todo lo que s35f cambió para el centrado viva dentro de
`@supports (text-box: trim-both cap alphabetic)`, y que fuera de ese bloque queden las reglas de antes de s35f.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` solo cambia por copia íntegra en PUB | `md5 -q docs/*.html` tras PUB | iguales a `40_salidas/` |
| I-2 | Sin carga por red | `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html` | `0` en cada uno |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | Los datos de la vista no cambian | C3 y el `DATA` decodificado de la vista, comparado con la base de H6 con `identical()` | PASA e idéntico |
| I-5 | Las fuentes no cambian | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` y `0257bb4b…` |
| I-6 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-7 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |
| I-8 | Sin desborde horizontal | `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 540, 768 y 1280 px | igual al viewport |
| I-9 | Con soporte de `text-box`, el sitio se ve igual que el publicado en s35f | capturas a 375 y 1280 px de las tres vistas, contra la base de H6 | 0 píxeles distintos (salvo lo que cambie G3 en el tooltip abierto) |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, G1, G2, G3, PUB, FASE R, FASE L con el push, y P3.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo |
| G1 | `30_procesamiento/33_fragmento_sitio.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `_archivo/20260925_capturas_s35g/` |
| G2 | `30_procesamiento/36_generar_trayectorias.R`, `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/36_verificar_trayectorias.R` |
| G3 | `30_procesamiento/33_motor_template.html` |
| PUB | `docs/index.html`, `docs/trayectorias.html`, `40_salidas/*.html` |
| P3 | ninguna |

---

## 6. FASE 0

1. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado: solo `?? 50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md`, más el log.
3. **H2.** `git stash list | wc -l` → esperado: `0`.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `6c51362` y `rev-parse --short origin/main` → `6c51362`.
5. **H4.** md5 de este encargo → esperado: el del mensaje de entrega. md5 de `docs/` → esperado: `65f2f59b…`
   y `713dfa9d…`. Después, `git add` del encargo y
   `git commit -m "docs(sesion 35): encargo de la septima ola (supports, cohortes, tooltip)"`. El hash
   resultante es el punto de retorno.
6. **H5.** Batería → esperado: 32 o más en PASA, código 0.
7. **H6.** `Rscript 00_build.R` → esperado: código 0.
   - Copia las dos salidas a `$TMPDIR/base_s35g/`.
   - Calibra `verificar_contenido_motor.R`: «idéntico» sobre la base y «difiere» con un número alterado.
   - Guarda capturas de la base a 375 y 1280 px (vista, `#comparacion`, `#panorama`, más el menú y los
     controles) en `$TMPDIR/base_s35g/`.
8. **Referencia «antes de s35f».** Crea el worktree de `476b1e1` (autorización 8) y corre ahí
   `Rscript 00_build.R`. Guarda sus dos salidas y sus capturas, con los mismos anchos y estados, en
   `$TMPDIR/ref_476b1e1/`. Es la vista que debe recibir un navegador sin `text-box`.
9. **Simulador de navegador sin soporte.** Escribe `verificar_sin_textbox.R`. El script toma un HTML generado,
   crea una copia en `$TMPDIR` y en esa copia:
   - reemplaza la condición de todo `@supports (text-box: trim-both cap alphabetic)` por una condición falsa
     (`@supports (text-box: no-existe)`);
   - borra cada declaración `text-box:` que quede fuera de un `@supports`.

   Después abre la copia con chromote. **Calibración:** aplicado a la salida actual (sin `@supports`), el
   simulador debe mostrar el defecto de Q-59: el menú o los botones miden entre 4 y 7 px más que en
   `ref_476b1e1`.
10. Anexa `### FASE 0`.

---

## 7. Tareas

### G1. Guarda `@supports` (Q-59)

1. En las tres plantillas, lleva **todas** las reglas que agregó o cambió `fa89e7c` para el centrado a un
   bloque `@supports (text-box: trim-both cap alphabetic) { ... }`. Eso incluye:
   - `text-box`;
   - el relleno con `--compensa-recorte`;
   - los `min-height` con `lh`;
   - `--ajuste-optico-select` y su uso en el `<select>`;
   - `.control-texto` y `.tx`;
   - la regla de `#c-coh button`;
   - `--holgura-tinta`.

   Fuera del bloque quedan las reglas equivalentes de `476b1e1` (lee `git show 476b1e1:<ruta>`), para que sin
   soporte el resultado sea el de antes de s35f. Los `<span class="control-texto">` y `<span class="tx">` del
   marcado quedan, pero fuera del bloque no llevan estilo, así que se comportan como texto normal.
2. **Criterio.**
   - **Con soporte:** 0 píxeles distintos contra la base de H6 en las tres vistas a 375 y 1280 px, más el
     menú y los controles (I-9). Además, `verificar_centrado.R` sigue dando 90 de 90 dentro de ±2 px de
     dispositivo.
   - **Sin soporte:** con el simulador de FASE 0, los altos de cada control del inventario de s35f y del menú
     son iguales a los de `ref_476b1e1` (|Δ| ≤ 0,5 px), y hay 0 píxeles distintos contra `ref_476b1e1` en el
     encabezado, el menú y la barra de controles de las tres vistas a 1280 px. Donde las capturas no se
     comparen por píxel (por los datos distintos entre versiones), compara el alto y la posición de cada
     control.
   - `grep` en las tres plantillas: ninguna aparición de `1cap`, `lh` (como unidad), `round(` ni `text-box`
     fuera de un bloque `@supports`. Anota el comando con el que lo mides.
   - **Calibración:** el simulador, aplicado a la base de H6, da el defecto de Q-59 (FASE 0, paso 9).
3. Quita el worktree (autorización 8).
4. Commit: `fix(sitio): el centrado optico solo aplica con soporte de text-box (Q-59)`.

### G2. El marcado de las cohortes sale del generador (Q-58)

1. `botones_cohortes()` emite el año de cada botón dentro de `<span class="tx">`. Borra de la plantilla la
   reescritura de la L1153 y su comentario.
2. Agrega a la batería una prueba **C6**: en el HTML generado, cada botón de `#c-coh` tiene exactamente un
   `span.tx` con su año. **Calibración:** C6 falla con el generador anterior.
3. **Criterio.**
   - El DOM de `#c-coh` después de cargar la página (`outerHTML` tras `DOMContentLoaded`) es idéntico al de la
     base de H6.
   - 0 píxeles distintos en la vista a 375 y 1280 px.
   - Batería en PASA, con C6.
4. Commit: `refactor(trayectorias): el texto de los botones de cohorte sale del generador (Q-58)`.

### G3. El tooltip no tapa el punto en pantallas angostas (Q-54)

1. En `ubicarTooltip()`, cuando no cabe ni a la derecha ni a la izquierda del punto sin taparlo, pruébalo
   abajo del punto (`ptY + desplaz`) y luego arriba (`ptY − alto − desplaz`), ambos acotados a la ventana.
   Si ninguno cabe sin tapar el punto, queda como hoy. Usa `TOOLTIP_DIMS` y no agregues literales nuevos.
2. **Criterio.**
   - Con los casos de TT de s35f a 375 × 740 y a 414 × 896: el punto no queda dentro del rectángulo del
     tooltip, con 4 px de margen, en todos los casos donde cabe arriba o abajo.
   - El tooltip queda dentro de la ventana en todos los casos.
   - A 1280 × 800, los casos de TT dan el mismo rectángulo que en la base (lo que ya funcionaba no cambia).
   - El panel «Ver establecimientos» abre en todos los clics.
   - **Calibración:** la base da al menos un caso a 375 px con el punto tapado (R-38 de s35f).
3. Commit: `fix(motor): a 375 px el tooltip no tapa el punto (Q-54)`.

### PUB. Copia a `docs/` (solo con G1, G2 y G3 completas)

1. `Rscript 00_build.R` y la batería → código 0.
2. `cp` a `docs/` (autorización 2).
3. **Verificación.**
   - md5 de `docs/` igual a `40_salidas`;
   - I-2 e I-3;
   - `git status --porcelain` muestra solo los dos archivos de `docs/`.
4. Commit: `deploy(docs): centrado solo con text-box, cohortes desde R y tooltip angosto`.

### P3. Lo que sirve Pages (después del push de FASE L)

1. Cada 60 s, hasta 10 minutos:
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5` → esperado: igual a
     `md5 -q docs/index.html`;
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/trayectorias.html | md5` → esperado: igual a
     `md5 -q docs/trayectorias.html`.
2. Si a los 10 minutos no coincide, reporta los md5 y el `last-modified` que devuelve `curl -sI`. No
   reintentes el push.
3. El resultado va en el reporte final.

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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260925_supports_cohortes_s35g_log.md` y
   `git commit -m "docs(log): supports, cohortes y tooltip angosto (s35g)"`. Después, `git push origin main`, solo
   si se cumple la autorización 4. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   revisión en Safari 18.2+ y en un navegador sin `text-box`, y el tooltip en un teléfono real. Incluye el hash
   de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - G1: alto de cada control con y sin `text-box` (simulador), contra la referencia «antes de s35f»;
   - G2: la salida de la prueba C6 y el diff del marcado de cohortes antes y después;
   - G3: por caso, a 375 y 414 px, si el punto queda fuera del tooltip y si el tooltip queda dentro de la
     ventana; y el resultado a 1280 px;
   - los md5 de `docs/` antes y después, y los que sirve Pages (P3);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

Q-55 (modal desbordado a 375 px), Q-56, Q-57, Q-42, Q-43, Q-51, Q-52, Q-34, Q-21, OP_PREVIO, Q-29, Q-31,
Q-39, v30-5 (batería del motor sin versionar), Museo Sans en la suite y los pendientes 8, 10, 12 y 13 del
traspaso v34. Si una tarea de este encargo los roza, se anotan como duda y no se corrigen.

---

## Apéndice: plantilla del log

```markdown
# Log: navegadores sin text-box, cohortes y tooltip angosto (s35g) (slep_simce_adecuado)

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

### FASE G1 ... ### FASE P3 (una sección por tarea, en el orden en que cierran: G1, G2, G3, PUB, P3)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
