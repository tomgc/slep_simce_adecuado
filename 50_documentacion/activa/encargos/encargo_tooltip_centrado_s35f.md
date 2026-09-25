# Encargo autónomo: tooltip y centrado vertical del texto (sesión 35, sexta ola, slep_simce_adecuado)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-25. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva.

**Contexto.** Tras publicar en Pages (`c1e2047`), el titular encontró dos defectos en el sitio público:

1. **El tooltip del motor se sale por el borde derecho.** Nunca se volteó: el traspaso v08 describía un ajuste
   al borde de la ventana, pero ese ajuste no llegó a ningún commit (ERR-35-18).
2. **El texto de los controles queda más arriba que el centro vertical.** Se nota en el selector «Territorio»
   y en los botones de «Nivel». La causa es la métrica de gobCL: `hhea` 750/−250 con una altura de mayúscula
   de 675, así que en macOS e iOS las mayúsculas quedan 0,0875 em sobre el centro. En Windows, con `win`
   1017/399, quedan unos 0,03 em.

El asistente ya corrigió el tooltip en la plantilla del motor, sin commitear. Este encargo lo verifica, corrige
el centrado, reconstruye, publica y comprueba lo que sirve Pages.

**Meta en una línea:** que el tooltip del motor quede siempre dentro de la ventana y que el texto de los
controles quede centrado ópticamente en las dos páginas, publicado en Pages.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** es una cadena corta en serie que
termina en un acto de efecto público.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (batería o build) fallan → **detén la sesión**.
- TT o TB no cumplen su criterio tras 3 intentos → congela esa tarea. **Sin las dos tareas completas no hay
  copia a `docs/` ni push.**
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. `cp 40_salidas/motor_comparacion.html docs/index.html` y
   `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html`, solo en PUB y solo con TT y TB completas.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   con el intento guardado antes como parche en `$TMPDIR/cal_s35f/` y su md5 en el log.
4. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - `git status --porcelain` vacío;
   - `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` iguales a los de PUB.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`.
6. `curl -s` y `curl -sI` de lectura contra las dos URL públicas, solo en P3.
7. Crear `_archivo/20260925_capturas_s35f/` (ignorado) y escribir ahí capturas.

Implícitas en el patrón: `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.**

- R es el único lenguaje de los entregables.
- Commits en español.
- Toda medida nueva va en una constante nombrada.
- `docs/` solo cambia por copia íntegra.
- I-7 se mide en forma absoluta.
- No se editan los `.otf`: su contenido está verificado por md5 (D35-9).

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - las plantillas del motor, de la vista y del fragmento;
   - `10_utils/10_html.R`;
   - `verificar_contenido_motor.R`;
   - las funciones de chromote de `verificar_navegador.R`;
   - las capturas del titular, que describe §2.
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...`;
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260925_tooltip_centrado_s35f_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0;
   - batería → código 0, con 32 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Salvo que se indique otra cosa, la fuente de cada premisa es git de solo lectura, `grep`, `sed` o `md5sum`
sobre la estación en la sesión 35.

- `HEAD` y `origin/main` están en `c1e2047` (fuente: reporte de publicación de Claude Code y `git status`). El
  árbol tiene tres rutas sin commitear (hipótesis, se mide en H1):
  - ` M 30_procesamiento/33_motor_template.html`, md5 `f84001c908044db86c71147b51fb6988` (el tooltip, editado
    por el asistente; el md5 anterior era `1427c375f0adb4612653fc3f94b1ee63`);
  - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`, md5 `cc2502541b70fff2c931db5fa9258b16`;
  - `?? 50_documentacion/activa/encargos/encargo_tooltip_centrado_s35f.md` (md5 en el mensaje de entrega).
- `docs/` y `40_salidas/` son iguales: `601df6d7bfdc8bb60f57c5f9fba3db54` (motor) y
  `1067908ec09ce95dbee692b9696da7fa` (vista), y Pages sirve esos mismos md5 (fuente: `md5sum` y reporte de
  publicación).
- **Tooltip.** El asistente agregó en el motor `TOOLTIP_DIMS = { desplaz: 14, margen: 8 }` y
  `ubicarTooltip(tip, ptX, ptY)` (L1963). `show` y `pin` ahora llenan el tooltip primero y lo ubican después:
  a la derecha del punto; si no cabe, a la izquierda; nunca a menos de 8 px de ningún borde. `.tooltip` es
  `position: absolute` con un ancho de 200 a 280 px (L478-487) (fuente: `sed` y `grep -n`). La vista ya acota
  su tooltip con `Math.min(window.innerWidth-292, ...)` en L1035 y no se toca.
- **Métrica de gobCL** (Regular y Bold iguales): `unitsPerEm` 1000; `hhea` ascender 750, descender −250,
  lineGap 0; `typo` igual; `win` 1017/399; `USE_TYPO_METRICS` falso; `capHeight` 675; `xHeight` 490 (fuente:
  lectura de las tablas `hhea` y `OS/2` con Python sobre los `.otf`, sesión 35).
- **Compatibilidad** (fuente: caniuse, consultado en la sesión 35):
  - `ascent-override` y `descent-override` no funcionan en ninguna versión publicada de Safari;
  - `text-box` (`text-box-trim` y `text-box-edge`) funciona en Safari 18.2 o superior (macOS e iOS),
    Chrome 133 o superior, Edge 132 o superior y Firefox 154 o superior.
- **Controles del motor:** `.segmented` y `.segmented-btn` (L156-180 y L1031-1045), `.select` e `.input`
  (L181-200), `.territorio-select` (L1055) y `.gse-filter select` (L931) (fuente: `grep -n`). Los de la vista y
  el menú del fragmento se inventarían en TB, paso 1.

---

## 3. Contexto mínimo

El sitio usa `gobCL-sitio` (D35-9), incrustada. Para centrar el texto no se toca la fuente. Se usa
`text-box: trim-both cap alphabetic`, que recorta la caja del texto a la altura de mayúscula y a la línea base.
Así el centrado deja de depender de la métrica de cada sistema operativo.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` solo cambia por copia íntegra en PUB | `md5 -q docs/*.html` tras PUB | iguales a `40_salidas/` |
| I-2 | Sin carga por red | `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html` | `0` en cada uno |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | Los datos de la vista no cambian | prueba C3 y el `DATA` de la vista decodificado, contra la base de H6 con `identical()` | PASA e idéntico |
| I-5 | Las fuentes no cambian | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` y `0257bb4b…` |
| I-6 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-7 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |
| I-8 | Sin desborde horizontal | `scrollWidth` en la vista, `#comparacion` y `#panorama` a 375, 540, 768 y 1280 px | igual al viewport |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, TT, TB, PUB, FASE R, FASE L con el push, y P3 después del push.

| Tarea | ALCANCE |
|---|---|
| T0 | las tres rutas de §2 |
| TT | `30_procesamiento/33_motor_template.html` (ya editado; solo ajustes si falla el criterio) |
| TB | `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/33_fragmento_sitio.html`, `_archivo/20260925_capturas_s35f/` |
| PUB | `docs/index.html`, `docs/trayectorias.html`, `40_salidas/*.html` |
| P3 | ninguna (lectura por red; el resultado va al reporte final) |

---

## 6. FASE 0

1. Crea el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → las tres rutas de §2, más el log.
3. **H2.** `git stash list | wc -l` → `0`.
4. **H3.** `fetch`; luego `rev-parse --short HEAD` → `c1e2047` y `rev-parse --short origin/main` → `c1e2047`.
5. **H4.** md5 de las dos rutas modificadas → los de §2; md5 de este encargo → el del mensaje de entrega; md5
   de `docs/` → los de §2.
6. **Línea base (antes de T0).** Guarda en `$TMPDIR/base_s35f/` la plantilla del motor que está en `HEAD`
   (`git show HEAD:30_procesamiento/33_motor_template.html`), sin el cambio del asistente, y las dos salidas de
   `40_salidas/`.
7. **T0.** `git add` de las tres rutas y
   `git commit -m "fix(motor): el tooltip se ubica dentro de la ventana; encargo s35f y ERR-35-18"`. El hash
   resultante es el punto de retorno. Este commit incluye la corrección del tooltip, que TT verifica: si TT
   falla, se revierte con `git revert` (reversión de un commit propio, dentro del patrón).
8. **H5.** Batería → 32 pruebas o más en PASA, código 0.
9. **H6.** `Rscript 00_build.R` → código 0. Apunta `verificar_contenido_motor.R` a la base de H6 y calíbralo
   («idéntico» sobre la base, «difiere» con un número alterado).
10. **Compuerta de dudas previa al acto público** (SETTINGS §2.1, gatillo 2). Anota en el log estas dudas y la
    tarea que mide cada una:
    - el tooltip, en TT;
    - el centrado, en TB;
    - la identidad de lo publicado, en PUB;
    - lo que sirve Pages, en P3.
11. Anexa `### FASE 0`.

---

## 7. Tareas

### TT. El tooltip queda dentro de la ventana

1. Con chromote, en el motor generado, a 1280 × 800 y a 375 × 740:
   - hover sobre el punto de sparkline y la barra más a la derecha de la tarjeta de la última columna, y
     también de la primera columna;
   - hover sobre una barra en la última fila visible (borde inferior);
   - clic (pin) en esos mismos puntos.
2. **Criterio.**
   - En todos los casos, `tip.getBoundingClientRect()` queda completo dentro de
     `[8, clientWidth − 8] × [8, clientHeight − 8]`.
   - Cuando hay espacio a la derecha, el tooltip queda a la derecha del punto (no cambia en el caso normal).
   - En el borde derecho, queda a la izquierda del punto y no lo tapa: `rect.right ≤ ptX − 14 + 1`.
   - El botón «Ver establecimientos» del tooltip fijado sigue funcionando: abre su panel.
   - **Calibración:** con la plantilla de la base de H6 (sin el cambio), el mismo hover en el borde derecho da
     `rect.right > clientWidth` (caso malo).
3. No hay commit propio: la corrección ya viaja en T0. Solo si hizo falta un ajuste, commit
   `fix(motor): ajuste del tooltip tras la medicion (TT)`.

### TB. Centrado óptico del texto de los controles

1. **Inventario.** Lista, en el motor, la vista y el menú del fragmento, los controles de alto fijo o con
   relleno simétrico donde el texto debe verse centrado. Como mínimo:
   - el selector de territorio (`.territorio-select`, `.select`);
   - los botones segmentados (`.segmented-btn`, también en su variante `is-on-dark`);
   - las pestañas del menú del sitio;
   - `.gse-filter select`;
   - los botones y selectores de la vista (cohorte, nivel, cobertura, grupo);
   - las etiquetas tipo píldora.
2. **Medidor.** Escribe `verificar_centrado.R` con chromote a `deviceScaleFactor` 2. Por cada control del
   inventario:
   - captura su caja de contenido (sin borde);
   - toma el texto sin descendentes (o, si tiene descendentes, solo las filas entre la altura de mayúscula y
     la línea base, con la línea base igual a la fila más baja de las letras sin descendente);
   - mide en píxeles del dispositivo el espacio libre arriba (del borde superior del área de contenido a la
     primera fila con tinta) y abajo (de la línea base al borde inferior).
   - **Criterio:** |arriba − abajo| ≤ 2 px de dispositivo (1 px CSS).
   - **Calibración:** el estado de la base de H6 debe dar arriba < abajo en el selector de territorio y en
     «4° Básico», con una diferencia de 2 px de dispositivo o más (el defecto que vio el titular).
3. **Corrección.**
   - Aplica `text-box: trim-both cap alphabetic` al texto de cada control del inventario, en la regla CSS de
     cada uno (el menú, solo en el fragmento). Donde el control no tenga alto fijo, compensa el alto que se
     pierde con relleno o `min-height` en constantes nombradas, para que el alto de la caja no cambie.
   - Si el `<select>` nativo ignora `text-box`, mídelo y regístralo. Para el selector solamente, compensa con
     `padding-block` asimétrico en una constante nombrada (`--ajuste-optico-select`), calculada con la métrica
     de §2 (0,0875 em en macOS). En el log, declara que en Windows ese ajuste deja el texto unos 0,06 em bajo
     el centro. La alternativa (reemplazar el selector nativo) queda como pendiente, sin implementar.
4. **Criterio.**
   - El medidor da el criterio en todos los controles del inventario, a 1280 px y a 375 px.
   - El alto de la caja de cada control es igual al de la base: |Δ| ≤ 0,5 px.
   - I-8, I-3 e I-4.
   - 0 píxeles distintos fuera de los controles, a 1280 px, en las tres vistas. Compara con las capturas de
     la base de H6 enmascarando las cajas de los controles.
   - Capturas antes y después del encabezado del motor, del selector y del menú en
     `_archivo/20260925_capturas_s35f/`, para el titular.
5. Commit: `fix(sitio): texto de los controles centrado opticamente con text-box (gobCL-sitio)`.

### PUB. Copia a `docs/` (solo con TT y TB completas)

1. `Rscript 00_build.R` y la batería → código 0.
2. `cp` a `docs/` (autorización 2).
3. **Verificación.**
   - `md5` de `docs/` igual a `40_salidas/`;
   - I-2;
   - JSON del motor idéntico (I-3);
   - `git status --porcelain` muestra solo los dos archivos de `docs/`.
4. Commit: `deploy(docs): tooltip dentro de la ventana y centrado optico de los controles`.

### P3. Lo que sirve Pages (después del push de FASE L)

1. Cada 60 s, hasta 10 minutos:
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5` → esperado: igual a `md5 -q docs/index.html`;
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/trayectorias.html | md5` → esperado: igual a
     `md5 -q docs/trayectorias.html`.
2. Si a los 10 minutos no coincide, reporta los md5 obtenidos y el `last-modified` de `curl -sI`. No reintentes
   el push.
3. El resultado va al reporte final.

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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260925_tooltip_centrado_s35f_log.md` y
   `git commit -m "docs(log): tooltip y centrado optico (s35f)"`. Después, `git push origin main`, solo
   si se cumple la autorización 4. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   revisión en Safari, capturas y publicación a `docs/`. Incluye el hash de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - los md5 de `docs/` antes y después, y los que sirve Pages;
   - las mediciones de TT (caja del tooltip por caso) y de TB (arriba/abajo por control, antes y después);
   - los `scrollWidth` antes y después por ancho;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos

- **El reemplazo del selector nativo** por uno propio: queda como pendiente, si el ajuste de TB no alcanza en
  Windows.
- Los pendientes Q-42, Q-43, Q-51, Q-52, Q-34, Q-21, `OP_PREVIO`, Q-29, Q-31 y Q-39, v30-5, Museo Sans y los
  pendientes 8, 10, 12 y 13 de v34.

## Apéndice: plantilla del log

```markdown
# Log: tooltip y centrado óptico (s35f) (slep_simce_adecuado)

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

### FASE TT ... ### FASE PUB (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
