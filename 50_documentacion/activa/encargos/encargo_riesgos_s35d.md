# Encargo autónomo: cierre de riesgos antes de publicar (sesión 35, cuarta ola, slep_simce_adecuado)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-25. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva.
Antecedente: `encargo_pendientes_s35c.md` y su log `20260925_pendientes_s35c_log.md` (commit `e21038e`,
publicado en `main`), evaluados por el asistente con dos revisores independientes. El titular pidió este
encargo corto antes de publicar en Pages.

**Meta en una línea:** que el motor vuelva a colocar las cifras de la sparkline cuando carga `gobCL-sitio`
(Q-48). Además, corregir el literal de posición del panorama, el plano de la vista en ventanas bajas (Q-44),
la tabla con las cohortes 2027-2029 (Q-46), los textos con «2014» literal (Q-47, Q-45) y el modo de la Bold
(Q-40). Todo se publica en `main`, sin tocar `docs/`.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **No se admiten subagentes.** Es un encargo corto
que escribe en serie sobre dos plantillas; la auditoría de FASE R la hace el orquestador, con comandos distintos
de los que produjeron cada resultado.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.**

1. 3 intentos por bug.
2. 2 ciclos de reparación en FASE R.
3. 1 reintento por comando que falla por causa transitoria.

**Regla de detención.**

- H1 a H3 (árbol, stash, `HEAD`) no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H4 (md5 de `docs/` y del encargo) difiere → **detén la sesión**.
- H5 (batería) o H6 (build) fallan → **detén la sesión**.
- H7 (el medidor de sparklines de s35c no existe y no se puede rehacer) → congela Q48.
- Un criterio no se cumple tras 3 intentos → congela esa tarea.
- Un 🔒 da FALLA → congela la tarea que lo rompió; si no se aísla, **detén la sesión**.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques, regístralo y
  pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea. Nunca `git add -A` ni `git add .`.
2. `git update-index --chmod=-x 10_utils/fuentes/gobCL_Bold.otf`, solo en Q40.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   solo después de guardar el intento como parche en `$TMPDIR/cal_s35d/<tarea>_intento<N>.patch` y anotar
   su md5 en el log.
4. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - `git status --porcelain` vacío;
   - `git fetch origin` y luego `git merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` igual a H4.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`.
6. Crear `_archivo/20260925_capturas_s35d/` (ignorado) y escribir ahí capturas.

Están implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.**

- R es el único lenguaje de los entregables, con `|>`, `.by=` y `here::here()`, sin rutas absolutas en código
  R.
- Nombres de archivo sin tildes, sin ñ y sin espacios.
- Commits en español.
- Las cifras sobre datos salen de `Rscript`.
- I-7 se mide en forma absoluta.
- Toda distancia nueva va en una constante nombrada, nunca como literal.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS del titular, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - el log de s35c: FASE S1, FASE V1, FASE F2, FASE R (R-21, R-22, R-46, R-49) y las dudas Q-40 y Q-44 a Q-48;
   - los medidores de la raíz (`verificar_*.R`), en particular el del barrido de sparklines que usó S1 de s35c;
   - la solución de R-50 en la vista (`36_trayectorias_template.html`, función `trasFuentes` y la promesa de
     `document.fonts.load`, alrededor de L1132-1147), que es el modelo para Q48.
3. **POSICIÓN:**
   - rutas completas desde la raíz;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...`;
   - `rev-parse` con un solo argumento por comando;
   - `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260925_riesgos_s35d_log.md`.
5. **ALCANCE:** por tarea, en §5. Además, `verificar_*.R` y `$TMPDIR`.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0;
   - `Rscript 30_procesamiento/36_verificar_trayectorias.R` → código 0, con 32 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Salvo que se indique otra cosa, la fuente de cada premisa es git de solo lectura, `sed`, `grep` o `md5sum`
sobre la estación en la sesión 35, o el informe de los dos revisores independientes que evaluaron el log de
s35c.

- `HEAD` y `origin/main` están en `e21038e`, y el árbol está limpio (fuente: `git log -1`, `git status
  --porcelain` y `git rev-list --left-right --count`). Esta vez la única ruta sin commit será este encargo
  (hipótesis, se mide en H1).
- md5 de referencia:
  - `docs/index.html`: `8deb04595510b0f15da8bb65813b7a38`;
  - `docs/trayectorias.html`: `267857a2962602bd9e6c5cc56effcb47`;
  - `10_utils/fuentes/gobCL_Bold.otf`: `a7407ed6a70160cdb96021f83808a94c`, versionada con modo 100755;
  - `10_utils/fuentes/gobCL_Regular.otf`: `0257bb4b62d5ec557627aa0136f1e1dc`, con modo 100644.

  Hay 28 archivos de datos versionados.
- Motor (`30_procesamiento/33_motor_template.html`):
  - no llama a `document.fonts` en ninguna parte;
  - el `useEffect` de `SparklineSubchart` cierra en L2500 con las dependencias `[entity.id, entity.name,
    entity.anio_traspaso, entity.kind, (entity.comunas || []).join(","), gse, nivel, prueba]` y mide con
    `getBBox()` dentro de `colocarCifrasSparkline`;
  - el de las barras (`RecentBarsSubchart`) cierra en L2749 y no mide texto;
  - en el panorama, L3465 escribe las cifras rescatadas en `ih + 44 + k * 12`, con un literal.
- El log de s35c midió que, en una copia con la fuente tardía, la sparkline queda con 23 inversiones y 164
  superposiciones cifra-cifra (R-46). Con la fuente a tiempo, todo da 0 (fuente: log de s35c, fila R-46).
- Vista (`30_procesamiento/36_trayectorias_template.html`):
  - L277 abre `@media (min-width:680px) and (max-width:822px)`, que da al plano `svg.chart` un alto fijo de
    360 px;
  - por encima de 822 px, el plano recibe el alto que sobra y colapsa con ventanas bajas: 0 px entre 823 y
    1024 px con 650 px de alto, y menos de 320 px con 900 px de alto (fuente: log de s35c, Q-44 y R-49);
  - `td.nm` lleva `white-space:nowrap` (L143) y `anchoTarjeta()` (L806-813) acota `--cardw` a [268, 430];
  - con las cohortes 2027-2029 la tabla se desplaza dentro de sí misma y oculta «Establecimientos» desde
    680 px (fuente: log de s35c, Q-46);
  - la frase de L377 dice «que en 2014 eran municipales» con el año escrito en la plantilla.
- El comentario de `30_procesamiento/36_generar_trayectorias.R` L120-121 dice que el número de Servicios
  Locales vigentes aparece en el tooltip del referente, y desde V1 de s35c ya no aparece ahí.

---

## 3. Contexto mínimo

Las dos páginas (el motor y la vista de trayectorias) se generan con `00_build.R` y se publican desde `docs/`.
Este encargo no toca `docs/`: la publicación viene después de la revisión en Safari. `gobCL-sitio` se incrusta
en las dos páginas con `font-display: swap` (D35-9), así que un navegador puede pintar primero con la fuente de
respaldo.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` no se toca | `md5 -q docs/index.html docs/trayectorias.html` | `8deb0459…` y `267857a2…` |
| I-2 | Sin red | `grep -cE "src=[\"']?(https?:)?//" 40_salidas/*.html docs/*.html` y `grep -c 'url(http'` en los mismos | `0` en cada uno (patrón ampliado por Q-49) |
| I-3 | Los vendorizados `.js` no cambian | `git diff --name-only <punto_de_retorno>..HEAD -- '10_utils/*.js'` | vacío |
| I-4 | La guarda de locale no cambia | `md5 -q 10_utils/10_locale.R` | `dc900c1b…` |
| I-5 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-6 | Las filas vigentes y del referente no cambian | prueba C3 | PASA |
| I-7 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-8 | Sin literales de color nuevos | `git diff <punto_de_retorno>..HEAD -- 30_procesamiento/33_motor_template.html \| grep -E '^\+.*attr\("fill", *"#' \| grep -vE '#FFFFFF\|#0A3A5C'` | vacío |
| I-9 | Las fuentes no cambian de contenido | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` y `0257bb4b…` |
| I-10 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |

---

## 5. Tareas, grafo y ALCANCE

**Grafo.** T0 va primero. Q48 y PAN (motor) van en serie. Q44, Q46 y TXT (vista) van en serie. Q40 es
independiente. FASE R y FASE L corren siempre. Orden de ejecución: T0, Q40, Q48, PAN, Q44, Q46, TXT.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo |
| Q40 | índice de `10_utils/fuentes/gobCL_Bold.otf` (solo el modo) |
| Q48 | `30_procesamiento/33_motor_template.html`, `40_salidas/motor_comparacion.html` |
| PAN | ídem Q48 |
| Q44 | `30_procesamiento/36_trayectorias_template.html`, `40_salidas/trayectorias_traspasos.html`, `_archivo/20260925_capturas_s35d/` |
| Q46 | ídem Q44 |
| TXT | `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_generar_trayectorias.R`, `30_procesamiento/36_verificar_trayectorias.R`, `40_salidas/trayectorias_traspasos.html` |

---

## 6. FASE 0

1. Crear el log con:
   - el encabezado (meta, fecha, repositorio y rama, ENTORNO, `EJECUCIÓN:` y modo real, grafo y topes);
   - el slot `## J. Juicio (lo rellena FASE L)` vacío;
   - los bloques de la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado: solo `?? 50_documentacion/activa/encargos/encargo_riesgos_s35d.md`
   (más el log recién creado).
3. **H2.** `git stash list | wc -l` → `0`.
4. **H3.** `fetch` y después `rev-parse --short HEAD` → `e21038e`; `rev-parse --short origin/main` → `e21038e`.
5. **H4 y T0.**
   - md5 de `docs/` → los de §2;
   - md5 de este encargo → el del mensaje de entrega;
   - `git add` del encargo y `git commit -m "docs(sesion 35): encargo de cierre de riesgos antes de publicar"`;
   - el hash resultante es el **punto de retorno**.
6. **H5.** Batería → 32 pruebas en PASA, código 0.
7. **H6.** `Rscript 00_build.R` → código 0.
   - Copia las dos salidas a `$TMPDIR/base_s35d/`.
   - Apunta `verificar_contenido_motor.R` a esa base.
   - Calíbralo: «idéntico» sobre la base, y «difiere» con un número alterado.
8. **H7.** Ubica el medidor de barrido de sparklines de S1 de s35c y la copia con la fuente tardía que usó R-46
   (en `verificar_*.R` o `$TMPDIR/cal_s35c/`) y córrelo sobre la base:
   - con la fuente a tiempo → esperado: 0 inversiones, 0 superposiciones, 0 cifras fuera;
   - con la fuente retrasada → esperado: 23 inversiones y 164 superposiciones cifra-cifra.

   Si la copia retrasada no existe, rehazla así: servir el HTML con la `@font-face` cargada después del primer
   dibujo, por ejemplo con la `src` reemplazada por un `blob:` que se inyecta con `setTimeout` de 1.500 ms.
   El método va al log.
9. Anexar `### FASE 0` al log.

---

## 7. Tareas

Todas cierran con los cinco pasos fijos, en este orden:

1. verificación con `esperado:` y `obtenido:`;
2. PRUEBAS, si la tarea tocó código;
3. chequeo de alcance;
4. commit con rutas explícitas;
5. sección `### FASE <tarea>` en el log.

### Q40. La Bold sin modo ejecutable

`git update-index --chmod=-x 10_utils/fuentes/gobCL_Bold.otf` (autorización 2).

- Verificación: `git ls-files -s 10_utils/fuentes/` muestra 100644 en las dos, e I-9 se mantiene.
- Commit: `chore(repo): gobCL_Bold.otf sin modo ejecutable (Q-40)`.

### Q48. El motor vuelve a colocar las cifras de la sparkline cuando carga la fuente (R-46)

1. Declara en el motor, a nivel de módulo, una sola promesa compartida por todas las tarjetas, igual a la de
   R-50 en la vista:
   - `Promise.all([document.fonts.load('400 1em "gobCL-sitio"'), document.fonts.load('700 1em "gobCL-sitio"')]).then(() => document.fonts.ready)`;
   - una rama de respaldo que use solo `document.fonts.ready`;
   - si no existe `document.fonts`, se considera lista desde el inicio.
2. Crea un hook `useFuentesListas()` que parta en `false` (o en `true` sin `document.fonts`) y pase a `true`
   cuando la promesa se resuelva o falle.
3. `SparklineSubchart` lo usa y lo agrega a las dependencias de su `useEffect` (L2500). El efecto ya limpia el
   SVG antes de dibujar, así que el nuevo dibujo es idempotente. Las barras no miden texto: no se tocan.
4. **Criterio.**
   - Con la fuente retrasada de H7, después de `document.fonts.ready` y un frame: 0 inversiones, 0
     superposiciones de las cuatro clases y 0 cifras fuera en el barrido completo (antes: 23 y 164).
   - La disposición final es idéntica a la de la carga con la fuente a tiempo: mismas posiciones y mismas
     cifras ocultas, comparadas con `identical()` sobre la lista de cajas.
   - Cada `SparklineSubchart` se dibuja como máximo una vez más que antes (mídelo con un contador en una copia
     de prueba en `$TMPDIR`, no en la plantilla).
   - La carga normal sigue con 0 en todo.
   - 0 errores en consola; I-5.
   - **Calibración:** la copia retrasada sin el cambio da 23/164 (caso malo) y con el cambio da 0.
5. Commit: `fix(motor): la sparkline vuelve a colocar sus cifras cuando carga gobCL-sitio (Q-48, R-46)`.

### PAN. El literal de posición de las cifras rescatadas del panorama

1. Reemplaza `ih + 44 + k * 12` (L3465) por una constante nombrada en las dimensiones del panorama
   (`rescate: { linea: 44, paso: P }`).
2. `P` es el alto de la caja de «A 99,9%» en Bold 700 a `FS_SVG.panorama.valorFuera`, medido con chromote,
   más 1 u, y nunca menos de 12.
3. **Criterio.**
   - 0 contactos entre renglones rescatados en el panorama en pantalla y en el SVG exportado, con Elemental e
     Insuficiente visibles, a 1280 px, en los territorios por defecto;
   - el segundo renglón queda dentro de `bottom: 74`;
   - I-5.
   - **Calibración:** el medidor de contactos dispara con dos textos plantados en la misma posición.
4. Commit: `fix(motor): cifras rescatadas del panorama con paso medido (R-22)`.

### Q44. El plano de la vista no colapsa en ventanas bajas

1. Mide `svg.chart.getBoundingClientRect().height` en estos anchos y altos, con la cohorte inicial y con la
   2027, y anota el estado previo:
   - anchos: 680, 823, 860, 900, 1023, 1024, 1280 y 1920 px;
   - altos: 650, 768 y 900 px.
2. Corrige con un bloque por alto que aplique las mismas reglas del bloque de L277:
   - `.app:not(.pres){height:auto}`;
   - `svg.chart{flex:none;height:360px}` y las demás de L278-281 que correspondan;
   - dentro de `@media (min-width:823px) and (max-height:N)`, con `N` calibrado midiendo el alto a partir del
     cual el plano ya recibe 320 px o más sin la regla.

   No cambies nada de lo que se ve con ventanas altas.
3. **Criterio.**
   - El plano mide 320 px o más en las 48 combinaciones del paso 1.
   - `scrollWidth` igual al viewport en todas.
   - Con 1080 px de alto, 0 píxeles distintos a 1024, 1280 y 1920 px frente a la base de esta tarea.
   - Batería en PASA.
   - **Calibración:** el medidor da menos de 30 px en 1024 × 650 antes del cambio.
4. Commit: `fix(trayectorias): el plano no colapsa en ventanas bajas (Q-44)`.

### Q46. La tabla muestra «Establecimientos» con las cohortes futuras

1. Permite que `td.nm` se parta en líneas (`white-space: normal` y un `overflow-wrap` adecuado) solo cuando
   haga falta. La vía preferida es dentro de las media queries vigentes. Si eso no alcanza, sube el tope de
   430 de `anchoTarjeta()` con una constante nombrada.
2. **Criterio.**
   - `scrollWidth` de `.tw` igual a su `clientWidth` con las cohortes 2027, 2028 y 2029 a 680, 822, 1024 y
     1280 px;
   - con las cohortes vigentes (2018 a 2026), 0 píxeles distintos a 1024, 1280 y 1920 px frente a la base de
     esta tarea;
   - batería en PASA.
   - **Calibración:** el medidor da `scrollWidth` mayor que `clientWidth` con la cohorte 2029 a 680 px antes
     del cambio.
3. Commit: `fix(trayectorias): la tabla de las cohortes futuras cabe sin desplazarse (Q-46)`.

### TXT. Textos con año literal y comentario desactualizado (Q-47, Q-45)

1. La frase de L377, «que en 2014 eran municipales», toma el año de un marcador `__NOTA_ANIO_ANCLA__`
   calculado en `cifras_notas()` (el primer año de la serie). D11 se amplía para cubrirlo. Calibración: D11
   falla si el marcador queda sin reemplazar.
2. El comentario de `36_generar_trayectorias.R` L120-121 se corrige para decir dónde aparece hoy esa cifra.
3. **Criterio.**
   - `grep -c 'en 2014 eran' 30_procesamiento/36_trayectorias_template.html` → `0`;
   - el HTML generado sigue diciendo «en 2014 eran municipales», porque el año de ancla es 2014;
   - batería en PASA.
4. Commit: `fix(trayectorias): el año del ancla sale de los datos en las notas (Q-47, Q-45)`.

---

## 8. FASE R: auditoría propia y reparación (penúltima y obligatoria; corre aunque haya tareas congeladas)

La regla de oro: **la reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni
la meta**.

1. **Inventario de afirmaciones auditables.** Se arma desde el log, no desde la memoria: cada línea
   `Verificación:`, cada cifra de las secciones por fase, cada 🔒 de §4 con su comando y el alcance global. Se
   numeran `R-01`, `R-02`, etc., y el inventario se anexa al log **antes** de auditar.
2. **Re-derivación independiente.** Sin subagentes: el orquestador re-deriva cada afirmación con un comando
   distinto del que la produjo (otro medidor, otra vía de conteo, otro navegador headless si está disponible).
   Para Q48 la re-derivación usa una copia retrasada distinta de la de H7 (otro retraso, p. ej. 3.000 ms).
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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260925_riesgos_s35d_log.md` y
   `git commit -m "docs(log): cierre de riesgos antes de publicar (s35d)"`. Después, `git push origin main`, solo
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
   - el barrido de la sparkline con la fuente a tiempo y retrasada, antes y después de Q48;
   - el alto del plano en las 48 combinaciones de Q44 y el `scrollWidth` de la tabla en Q46;
   - los `scrollWidth` antes y después por ancho;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos de este encargo

- **Publicación a `docs/`:** requiere la revisión en Safari del titular.
- **Q-42** (escalera de rachas con «†»), **Q-43** (sparklines de 43 px a 375 px), **Q-34**, **Q-21**,
  **`OP_PREVIO`**, **Q-29**, **Q-31**, **Q-39**, **v30-5**, **Museo Sans** y los pendientes 8, 10, 12 y 13 de v34:
  siguen fuera, por decisión de diseño o porque están bloqueados.
- **La pista de años con 7 pares superpuestos a 680 px (Q-46, segunda parte):** es previa y ya está publicada.
  Queda como pendiente.

## Apéndice: plantilla del log

```markdown
# Log: cierre de riesgos antes de publicar (s35d) (slep_simce_adecuado)

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

### FASE Q40 ... ### FASE TXT (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
