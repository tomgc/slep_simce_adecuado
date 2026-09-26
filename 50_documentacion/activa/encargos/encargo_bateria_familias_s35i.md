# Encargo autónomo: batería por familias, build que se detiene, tarjeta por cohorte y corte del supergrid (sesión 35, novena ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva.

**Contexto.** `encargo_pantallas_angostas_s35h.md` quedó publicado (`b150d57`; Pages sirve `fe30d56f…` y
`69357a69…`). El titular decidió las dudas de su log (D35-14 y D35-15, en
`50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`) y cómo cerrar v30-5. Este
encargo resuelve:

- **Q-39 (D35-13).** Con `source()` interactivo, una falla crítica de portabilidad no detiene el build.
- **v30-5 (decisión del titular, 2026-09-26).** La auditoría de 28 pruebas de la sesión 30 (vista de
  trayectorias, en Playwright) no se versionó y sus pruebas no están escritas en ninguna parte. Solo se conservan
  sus cuatro familias: **A** capa de datos, **B** invariantes del motor de la vista, **C** coherencia entre
  tabla y gráfico, **D** presentación. Se cierra así: cada prueba de la batería versionada se asigna a una
  familia, y se agregan pruebas, con control positivo, a las familias con menos de dos.
- **Q-65 (D35-15).** Al cambiar de cohorte, `rebuild()` mide la tarjeta desde el ancho anterior.
- **Q-66 (D35-15).** Con 5 territorios, de 641 a unos 686 px, un nombre sale de su columna del supergrid.

**Meta en una línea:** que el build se detenga ante una falla de portabilidad en cualquier modo, que la batería
cubra las cuatro familias de la auditoría de la sesión 30, que la tarjeta mida lo mismo sin importar la cohorte
anterior, y que ningún nombre salga de su columna del supergrid con 5 territorios. Todo publicado en Pages.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** cuatro tareas cortas en serie
que comparten build y batería, y el encargo termina en un acto público.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (batería o build) fallan → **detén la sesión**.
- Si una tarea no cumple su criterio tras 3 intentos → congela esa tarea y sigue con la siguiente. Con
  **cualquier** tarea congelada no hay copia a `docs/` ni push. El resto se commitea igual.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. `cp 40_salidas/motor_comparacion.html docs/index.html` y
   `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html`, solo en PUB y con las cuatro tareas
   completas.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   después de guardar el intento como parche en `$TMPDIR/cal_s35i/` y anotar su md5 en el log.
4. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío;
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` iguales a los de PUB.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`. Crear copias del
   repositorio en `$TMPDIR` para plantar fallas (E1), sin tocar el árbol.
6. `curl -s` y `curl -sI` de lectura contra las dos URL públicas, solo en P3.
7. Crear `_archivo/20260926_capturas_s35i/` (ignorado) y escribir capturas en esa carpeta.
8. **Segundo push, solo del log.** Después de P3: anexar al log la sección `### FASE P3`, `git add` del log,
   `git commit -m "docs(log): P3 de s35i"` y `git push origin main`. Solo si
   `git diff --name-only HEAD~1..HEAD` muestra únicamente el log y si `fetch` y
   `merge-base --is-ancestor origin/main HEAD` dan código 0.

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables. Los commits van en español. Toda
medida nueva va en una constante nombrada (CSS: variable en `:root`; JS: constante en mayúsculas; R: constante
en mayúsculas). `docs/` solo cambia por copia íntegra. I-6 se mide en forma absoluta. Los `.otf` no se editan.
El motor admite como máximo 5 territorios (`MAX_ENTIDADES = 5`, D35-14): ninguna medición usa más.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - el log de s35h (FASE 0 con D0-a, M2, V1, V2, R-39, R-40, Q-65 y Q-66);
   - el log de s35b (A3, R-08, R-69 y Q-39);
   - `50_documentacion/traspasos/archivo/traspaso_cierre_v30.md` (§4.16: las cuatro familias y los dos
     defectos de prueba, B3 y D3);
   - D35-13 a D35-15 en el archivo de decisiones.
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...`;
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto;
   - un código de salida se lee sin tubería.
4. **LOG:** `50_documentacion/andamios/logs/20260926_bateria_familias_s35i_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas;
   - `Rscript 30_procesamiento/36_verificar_trayectorias.R` → código 0, con 33 pruebas o más (tras B1, con
     las nuevas);
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Salvo que se indique otra cosa, cada premisa se midió en la sesión 35 con git de solo lectura, `grep`, `sed`,
`md5sum` o `curl` sobre la estación.

- `HEAD` y `origin/main` están en `b150d57` (fuente: `git log` y `git rev-parse`). El árbol tiene dos archivos
  modificados sin commit, que T0 commitea: el archivo de decisiones (D35-14 y D35-15) y
  `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` (ERR-35-20 a 22) (fuente:
  `git status --porcelain`). Pages sirve `fe30d56f866d082501bd8937a24f752e` y
  `69357a69dc04db6186e75d3245c6b873`, iguales a `docs/` (fuente: `curl | md5sum` y `md5sum docs/*.html`).
- El motor incrusta `meta$fecha_generacion` (`format(Sys.Date())`, `33_generar_html.R:200`), así que su md5
  cambia de un día a otro sin que cambie el contenido (fuente: log s35h, D0-a). H6 compara por eso **sin** ese
  campo.
- **Q-39.** `00_build.R` (L29-30) hace `source()` de `10_utils/10_validar_portabilidad.R` y llama a
  `validar_portabilidad()` sin argumentos. La firma es
  `validar_portabilidad <- function(detener_si_falla = !interactive())` (L301 del validador) (fuente: `grep -n`
  y `sed`). En s35b, con `source()` interactivo y una ruta plantada, el build no se detuvo (fuente: log s35b,
  R-69).
- **Batería.** `30_procesamiento/36_verificar_trayectorias.R` tiene 33 llamadas a `comprobar(` (fuente:
  `grep -c`). Su encabezado nombra D1 a D14 y D9f (datos), C1 a C6 (cohortes y marcado) y R1 a R7 (referente);
  R2, R4, R6 y R7 usan chromote (fuente: `sed -n 1,60p`). Ninguna prueba declara hoy a qué familia de la
  auditoría de la sesión 30 pertenece (hipótesis, se mide en B1).
- **Q-65.** `rebuild()` (L1167 de la vista) llama a `tarjeta(); anchoTarjeta(); unaColumna();` sin
  `removeProperty('--cardw')`. El manejador de `resize` (L1225) y `trasFuentes()` (L1246) sí lo reinician
  (fuente: `grep -n`). En s35h, de la cohorte 2027 a la 2018 quedaba `--cardw` = 403 px, cuando una carga
  nueva da 317 (fuente: log s35h, Q-65).
- **Q-66.** `--supergrid-col-min` vale `0px` en `:root` (L116 del motor) y `112px` dentro de
  `@media (max-width: 640px)` (L1222-1247), que también contiene la regla del panorama y las del modal (M1 de
  s35h). Las columnas usan `minmax(var(--supergrid-col-min), 1fr)` (L4966) (fuente: `grep -n` y `sed`). Con 5
  territorios, de 641 a unos 686 px, un nombre sale hasta ~9 px de su celda (fuente: log s35h, R-40).

---

## 3. Contexto mínimo

Las cuatro tareas son independientes en su efecto. E1 solo cambia el build (no las salidas). B1 solo agrega
pruebas (no cambia el producto). V3 solo cambia la vista después de un cambio de cohorte. M5 solo cambia el
supergrid entre 641 px y el corte nuevo. Por eso el invariante I-9 exige 0 píxeles distintos en el estado
inicial a 1280 y 1440 px, y cada criterio de píxeles se mide contra el build de la tarea anterior, no contra la
base de FASE 0 (lección de ERR-35-22).

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` solo cambia por copia íntegra en PUB | `md5 -q docs/*.html` tras PUB | iguales a `40_salidas/` |
| I-2 | Sin carga por red | `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html` | `0` en cada uno |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | Los datos de la vista no cambian | el `DATA` decodificado de la vista, comparado con la base de H6 con `identical()` | `TRUE` |
| I-5 | Las fuentes no cambian | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` (Bold) y `0257bb4b…` (Regular) |
| I-6 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-7 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |
| I-8 | Sin desborde horizontal | `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 414, 540, 641, 660, 690, 768, 1024 y 1280 px | igual al viewport |
| I-9 | El estado inicial de escritorio no cambia | capturas de las tres vistas a 1280 × 900 y 1440 × 900, estado inicial, contra la base de H6 | 0 píxeles distintos |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, E1, B1, V3, M5, PUB, FASE R, FASE L con el push, P3 y su commit (autorización 8).

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` |
| E1 | `00_build.R` |
| B1 | `30_procesamiento/36_verificar_trayectorias.R` |
| V3 | `30_procesamiento/36_trayectorias_template.html`, `_archivo/20260926_capturas_s35i/` |
| M5 | `30_procesamiento/33_motor_template.html`, `_archivo/20260926_capturas_s35i/` |
| PUB | `docs/index.html`, `docs/trayectorias.html`, `40_salidas/*.html` |
| P3 | el log |

---

## 6. FASE 0

1. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_bateria_familias_s35i.md`
3. **H2.** `git stash list | wc -l` → esperado: `0`.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `b150d57` y `rev-parse --short origin/main` → `b150d57`.
5. **H4.** md5 de este encargo → esperado: el del mensaje de entrega. md5 de `docs/` → esperado:
   `fe30d56f…` y `69357a69…`. Después, `git add` de las tres rutas de T0 y
   `git commit -m "docs(sesion 35): encargo de la novena ola y decisiones D35-14 y D35-15"`. El hash
   resultante es el punto de retorno.
6. **H5.** Batería → esperado: 33 en PASA, código 0.
7. **H6.** `Rscript 00_build.R` → esperado: código 0. La vista, con md5 igual a `docs/trayectorias.html`. El
   motor, idéntico a `docs/index.html` **fuera de `meta$fecha_generacion`** (compara el HTML sin el bloque de
   datos byte a byte, y el JSON sin ese campo con `identical()`, como D0-a de s35h).
   - Copia las dos salidas a `$TMPDIR/base_s35i/`.
   - Calibra `verificar_contenido_motor.R`: «idéntico» sobre la base y «difiere» con un número alterado.
   - Guarda las capturas de I-9 y comprueba que dos cargas dan 0 píxeles distintos.
8. **Mediciones de partida (calibraciones de cada tarea).** Cada una se anota con esperado/obtenido:
   - E1: en una copia del repositorio en `$TMPDIR`, planta una ruta absoluta en un `.R` que el validador
     escanea (como A3 de s35b) y ejecuta el build **en modo interactivo** (una sesión de R donde
     `interactive()` sea `TRUE`; registra cómo lo lograste y comprueba ese `TRUE` en la misma sesión).
     Esperado: el build **no** se detiene (R-69 de s35b). Con `Rscript` sobre la misma copia: se detiene.
   - B1: tabla de las 33 pruebas con su familia (A, B, C o D) según lo que mide cada una, con una línea de
     justificación por prueba. Esperado: se registra; si todas las familias ya tienen dos o más, B1 se
     reduce a escribir esa asignación en la batería.
   - V3: `--cardw` al llegar a cada cohorte desde cada una de las otras (todos los pares ordenados), a 1280 ×
     900 y a 900 × 900, contra el valor al llegar a esa cohorte desde la inicial en una carga nueva.
     Esperado: al menos un par distinto (2027 → 2018: 403 contra 317, Q-65).
   - M5: con 5 territorios (los del estado inicial más los que falten hasta 5, siempre los mismos y
     anotados), de 641 a 760 px en pasos de 1 px, cuántos textos del supergrid superan el borde derecho de su
     celda (el mismo medidor de M2 de s35h). Anota el ancho más grande con algún texto fuera: es `W_FUERA`.
     Esperado: `W_FUERA` entre 641 y 700 (R-40 de s35h dice ~686).
9. Anexa `### FASE 0`.

---

## 7. Tareas

### E1. El build se detiene ante una falla de portabilidad en cualquier modo (Q-39)

1. En `00_build.R`, la llamada pasa a `validar_portabilidad(detener_si_falla = TRUE)`, y el comentario de
   arriba dice que se detiene también con `source()` interactivo (D35-13).
2. **Criterio.**
   - En la copia con la ruta plantada, en modo interactivo (el mismo de FASE 0): el build se detiene antes de
     «iniciando pipeline», con un error que nombra la falla.
   - Con `Rscript`: también se detiene (código distinto de 0).
   - Sobre el árbol real, sin ruta plantada: `Rscript 00_build.R` da código 0 y sus salidas son iguales a las
     de H6 (el motor, fuera de `meta$fecha_generacion`).
   - **Calibración:** FASE 0, paso 8 (E1).
3. Commit: `fix(build): la falla de portabilidad detiene el build tambien en modo interactivo (Q-39)`.

### B1. La batería cubre las cuatro familias de la auditoría de la sesión 30 (v30-5)

1. En el encabezado de la batería, una tabla o lista que asigna cada prueba a su familia (A datos, B
   invariantes del motor de la vista, C coherencia entre tabla y gráfico, D presentación), con la definición
   de cada familia en una línea y la referencia a `traspaso_cierre_v30.md` §4.16.
2. Para cada familia con menos de dos pruebas, agrega las que falten hasta dos. Cada prueba nueva:
   - tiene un id propio que no choque con los existentes (anótalo), por ejemplo con el prefijo de su familia;
   - mide una afirmación del producto, no un síntoma cercano, y lleva control positivo dentro de la misma
     prueba (un HTML de control en `tempdir()` o un valor plantado), como C2, C3 y C6;
   - evita los dos defectos de prueba de la sesión 30: B3 contaba los rótulos de los ejes como números fuera
     de burbuja, y D3 contaba el número escalado por geometría como un quinto tamaño tipográfico.

   Ejemplos que califican, si la familia los necesita (elige tú y justifica): B, cada burbuja dibujada
   corresponde a una unidad del `DATA` de la cohorte elegida y no hay dos burbujas de la misma unidad; C, para
   cada fila de la tabla, la cifra que muestra es la del `DATA` para el año que muestra el plano; D, sin
   desborde horizontal de la vista a 375, 768 y 1280 px.
3. **Criterio.**
   - Cada prueba de la batería tiene familia, y cada familia tiene dos o más pruebas.
   - Batería en PASA, con código 0 y con más de 33 pruebas si se agregaron.
   - **Calibración:** cada prueba nueva, con su control positivo, da FALLA sobre el valor plantado (anota la
     salida literal de cada una).
   - El producto no cambia: `git diff --name-only` de B1 = solo la batería.
4. Commit: `test(trayectorias): la bateria cubre las cuatro familias de la auditoria de la sesion 30 (v30-5)`.

### V3. La tarjeta se mide igual sin importar la cohorte anterior (Q-65)

1. En `rebuild()`, antes de `anchoTarjeta()`: `document.documentElement.style.removeProperty('--cardw')`, como
   en el manejador de `resize` y en `trasFuentes()`.
2. **Criterio.**
   - En todos los pares ordenados de cohortes de FASE 0, a 1280 × 900 y 900 × 900: `--cardw` al llegar a una
     cohorte es igual al de llegar a esa misma cohorte desde la inicial en una carga nueva, y la clase
     `una-col` coincide.
   - En la carga inicial (sin cambiar de cohorte): 0 píxeles distintos contra el build de B1 a 375, 768, 1024 y
     1280 px.
   - **Calibración:** FASE 0, paso 8 (V3).
3. Commit: `fix(trayectorias): la tarjeta se mide igual sin importar la cohorte anterior (Q-65)`.

### M5. Ningún nombre sale de su columna del supergrid con 5 territorios (Q-66)

1. Las variables CSS no valen en la condición de un `@media`, así que el corte va como literal en un
   `@media (max-width: <corte>px)` propio, con un comentario que da su origen: el primer múltiplo de 10 mayor
   que `W_FUERA`. Dentro de ese `@media`, solo
   `:root { --supergrid-col-min: 112px; }` y `.supergrid { overflow-x: auto; }`; esas dos reglas salen del
   `@media (max-width: 640px)`, que conserva el panorama y el modal sin cambios.
2. **Criterio.**
   - Con los 5 territorios de FASE 0, de 375 a 760 px en pasos de 1 px: 0 textos fuera de su celda.
   - I-8 en esos anchos, más 641, 660 y 690.
   - Sobre el corte nuevo: 0 píxeles distintos contra el build de V3 a 768, 1024 y 1280 px en `#comparacion`.
   - Bajo 641 px: 0 píxeles distintos contra el build de V3 en `#comparacion` y en el modal abierto, a 375 y
     414 px.
   - **Calibración:** FASE 0, paso 8 (M5).
3. Commit: `fix(motor): el supergrid usa su ancho minimo hasta que ningun nombre sale de su columna (Q-66)`.

### PUB. Copia a `docs/` (solo con las cuatro tareas completas)

1. `Rscript 00_build.R` y la batería → código 0.
2. `cp` a `docs/` (autorización 2).
3. **Verificación.**
   - md5 de `docs/` igual a `40_salidas`;
   - I-2, I-3 e I-4;
   - `git status --porcelain` muestra solo los dos archivos de `docs/` (más el log sin seguimiento).
4. Commit: `deploy(docs): tarjeta por cohorte y corte del supergrid`.

### P3. Lo que sirve Pages (después del push de FASE L)

1. Cada 60 s, hasta 10 minutos:
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5` → esperado: igual a
     `md5 -q docs/index.html`;
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/trayectorias.html | md5` → esperado: igual a
     `md5 -q docs/trayectorias.html`.
2. Si a los 10 minutos no coincide, anota los md5 y el `last-modified` que devuelve `curl -sI`. No
   reintentes el push de FASE L.
3. Anexa `### FASE P3` al log con esperado/obtenido y cierra con la autorización 8 (commit y push solo del
   log).

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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_bateria_familias_s35i_log.md` y
   `git commit -m "docs(log): bateria por familias, build, tarjeta y supergrid (s35i)"`. Después, `git push origin main`, solo
   si se cumple la autorización 4. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   revisión en Safari y en un teléfono real. Incluye el hash de `docs(log)`. P3 y su commit se anexan después
   (autorización 8), sin reescribir esta sección.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` (tras el commit de P3), el hash de
   `docs(log)` y el de `docs(log): P3 de s35i`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - E1: cómo se logró el modo interactivo, y si el build se detiene antes y después, en ese modo y con `Rscript`;
   - B1: la tabla de pruebas por familia, las pruebas nuevas con su id y la salida de su control positivo;
   - V3: pares de cohortes con `--cardw` distinto de la carga nueva, antes y después;
   - M5: `W_FUERA`, el corte elegido y los textos fuera de su celda por tramo, antes y después;
   - los md5 de `docs/` antes y después, los que sirve Pages (P3) y el hash del commit de P3;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

Museo Sans en la suite, los pendientes 8, 10, 12 y 13 del traspaso v34, CLAUDE.md (D2), el tope de 5
territorios y `ANCHO_PLANO_MIN` = 384 (D35-14), y lo cerrado o aceptado en D35-11 y D35-12. Si una tarea de
este encargo los roza, se anotan como duda y no se corrigen.

---

## Apéndice: plantilla del log

```markdown
# Log: batería por familias, build que se detiene, tarjeta por cohorte y corte del supergrid (s35i) (slep_simce_adecuado)

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

### FASE E1 ... ### FASE P3 (una sección por tarea, en el orden en que cierran: E1, B1, V3, M5, PUB; P3 se anexa tras el push, autorización 8)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
