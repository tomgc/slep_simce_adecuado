# Encargo autónomo: retiro de `unpkg.com` del motor (opción C, transpilación en el build con V8)

Formato: `encargo_autonomo_claude_code_v1.md` v1.6. Redactado en la sesión 31
(2026-09-23). Meta aprobada por el titular: el motor publicado no carga nada por
red, y el titular sigue editando la app como JSX dentro de la plantilla.

## 1. Encabezado de contrato

- **Modo:** autónomo, todo en este turno. Subagentes: **no se admiten**.
- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión;
  subagentes 0, total Opus del encargo 0. Si la sesión está en `ultracode`, se
  ejecuta igual sin subagentes y el log lo declara.
- **ENTORNO:** Claude Code en la estación macOS del titular, raíz
  `/Users/tomgc/Projects/slep_simce_adecuado`. Intérprete: `bash` explícito
  para shell, `Rscript` para todo cálculo sobre archivos del proyecto.
- **INSUMOS:** todos en el repositorio, rutas desde la raíz:
  `30_procesamiento/33_generar_html.R` y `30_procesamiento/33_motor_template.html`
  (ya editados en el árbol por el redactor, sin commitear);
  `50_documentacion/activa/50_diseno_ramas_deteccion.md` (regla 12, ya editada,
  sin commitear); `docs/index.html` (build publicado, referencia). Las tres
  dependencias JavaScript se descargan en T1 desde las URL escritas en
  `VENDOR_JS` de `33_generar_html.R`.
- **POSICIÓN:** todo comando con ruta completa desde la raíz, anteponiendo
  `cd /Users/tomgc/Projects/slep_simce_adecuado &&`; ninguno asume `cd`
  previo. Primer acto de FASE 0: `git fetch` y comparación de `main` contra
  `origin/main`.
- **LOG:** `50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md`.
- **ALCANCE (por tarea, lista cerrada):**
  - T0: `50_documentacion/activa/50_diseno_ramas_deteccion.md`.
  - T1: `10_utils/react.production.min.js`, `10_utils/react-dom.production.min.js`,
    `10_utils/babel.min.js`.
  - T2: `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`,
    y la salida ignorada `40_salidas/motor_comparacion.html` (no se versiona).
  - T3: ninguna ruta versionada (solo lectura y archivos temporales fuera del árbol).
  - Todas: el LOG, y este encargo (`50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md`).
- **PRUEBAS:** sin arnés de pruebas (no existe `tests/`, fuente: `ls -d tests`
  en la sesión del redactor). Sustituto: la corrida completa de
  `Rscript 30_procesamiento/33_generar_html.R` con salida `33_generar_html.R: OK`
  y las verificaciones de T2.
- **PUNTO DE RETORNO:** `git rev-parse --short HEAD` en FASE 0, al encabezado del log.
- **Topes de esfuerzo:** 3 intentos por bug (al tercero, la tarea se congela
  con la evidencia de los tres); 2 ciclos de reparación en FASE R; 1 reintento
  por comando que falla por causa transitoria (red, lock, timeout).

### 1.1 Regla de detención (condiciones medibles)

1. `main` local distinto de `origin/main` tras `git fetch` → detén la sesión.
2. `git status --porcelain` distinto del conjunto esperado de FASE 0 → detén la sesión.
3. sha384 de un archivo descargado en T1 distinto de su `sri` en `VENDOR_JS`
   → congela T1 y T2 (no reintentes con otra URL ni otra versión).
4. `Rscript 30_procesamiento/33_generar_html.R` termina con error → aplica el
   tope de 3 intentos a T2; al tercero, congela T2.
5. Cualquier cambio necesario fuera del ALCANCE de la tarea → congela esa tarea.
6. **Cláusula residual:** cualquier estado, conteo o resultado no enumerado en
   este encargo → congela ESTA tarea, regístrala como duda (formato del log,
   §5) y sigue con la próxima tarea independiente.

### 1.2 Autorizaciones (lista cerrada)

1. `curl -fsSL <url> -o <ruta>` para las tres URL de `VENDOR_JS`, una vez cada
   una (más el reintento del tope), solo hacia las tres rutas del ALCANCE de T1.
2. `Rscript -e 'install.packages("V8")'` y `Rscript -e 'install.packages("openssl")'`,
   solo si FASE 0 midió `requireNamespace` en `FALSE` para ese paquete.
3. `git add <rutas explícitas del ALCANCE>` y `git commit`, un commit por tarea.
4. `git push origin main` al final de FASE L, solo si `git status --porcelain`
   está vacío y `git merge-base --is-ancestor origin/main HEAD` pasa.

Nada más. En particular: no se toca `docs/index.html` (el despliegue lo
decide el titular tras su gate visual), no se usa `restore`, `reset` ni
`checkout --`, y no se edita `renv.lock`.

## 2. Estado de partida (premisas)

- `HEAD` es `9908180`, igual a `origin/main` (fuente: `git rev-parse --short HEAD`
  en la sesión del redactor; hipótesis, se mide en FASE 0).
- El árbol trae modificados exactamente tres archivos versionados
  (`33_generar_html.R`, `33_motor_template.html`, `50_diseno_ramas_deteccion.md`)
  y un untracked, este encargo (fuente: `git status --short` en la sesión del
  redactor; hipótesis, se mide en FASE 0).
- `docs/index.html` tiene md5 `c9747962e7f9cc8179de3a717f66f9af`, tres
  `src="http` (React, ReactDOM y Babel en unpkg) y una etiqueta `text/babel`
  (fuente: `md5sum`, `grep -c` y `grep -o` en la sesión del redactor;
  hipótesis, se mide en FASE 0).
- La plantilla ya no contiene `unpkg` en ningún `src`, y contiene
  `__REACT_INLINE__` y `__REACTDOM_INLINE__` una vez cada uno (hipótesis, se
  mide en FASE 0).
- Los paquetes R `V8` y `openssl` pueden no estar instalados (hipótesis, se mide
  en FASE 0).
- `unpkg.com` responde desde la estación (hipótesis, se mide en T1 con el primer `curl`).

## 3. Contexto mínimo

El motor (`33_motor_template.html`, 4.582 líneas en HEAD) cargaba React 18.3.1,
ReactDOM 18.3.1 y Babel standalone 7.29.0 desde `unpkg.com`, y Babel transpilaba
el JSX en el navegador: sin red, pantalla en blanco. El redactor ya editó dos
archivos. La plantilla cambia los tres `<script src>` por dos marcadores
(`__REACT_INLINE__`, `__REACTDOM_INLINE__`) y conserva el bloque
`<script type="text/babel" data-presets="env,react">` como ancla editable. El
generador gana un Bloque 0 (constantes `VENDOR_JS`, ancla y opciones de
Babel; funciones `verificar_vendor`, `reemplazar_literal`, `transpilar_jsx`) y
un Bloque 3b que verifica el sha384 de las tres dependencias, transpila el
bloque de la app con Babel dentro de V8 (presets `env` y `react` con runtime
`classic`) y lo reemplaza por un `<script>` normal. Babel no viaja al HTML.
Precedente auditado: `50_documentacion/andamios/logs/20260829_rescate_rotulos_y_precedente_c3_log.md`, B3 y B4.

## 4. Invariantes (🔒), cada uno con su comando

- 🔒 `docs/index.html` no cambia: `md5 -q docs/index.html` = `c9747962e7f9cc8179de3a717f66f9af`.
- 🔒 El D3 y el pako vendorizados no cambian: `git diff --quiet HEAD -- 10_utils/d3.min.js 10_utils/pako.min.js` (código 0).
- 🔒 El payload de datos del build nuevo es el mismo del publicado: el md5 del
  segmento `atob("…")` de `40_salidas/motor_comparacion.html` es igual al de
  `docs/index.html`. Comando: `grep -o 'atob("[^"]*")' <archivo> | md5`, sobre los dos.
- 🔒 Ningún archivo con extensión de datos entra por este encargo:
  `git diff --name-only <PUNTO DE RETORNO>..HEAD | grep -Eic '\.(xlsx|xls|csv|tsv|parquet|rds|json)$'` = 0.
- 🔒 `andamios/` solo recibe el log: `git diff --name-only <PUNTO DE RETORNO>..HEAD -- 50_documentacion/andamios`
  devuelve únicamente la ruta de LOG.

## 5. Grafo de tareas y fases

Grafo: T0 es independiente. T2 requiere T1. T3 requiere T2. FASE R y FASE L
cierran la cadena, fuera del grafo, y corren aunque una tarea quede congelada.

Cada fase cierra en cinco pasos, en este orden: (1) verificación con
`esperado:` escrito en el log antes del comando y `obtenido:` literal después;
(2) regresión (el sustituto de PRUEBAS si la fase tocó código; si no, se
declara); (3) chequeo de alcance: `git diff --name-only HEAD` más
`git ls-files --others --exclude-standard` ⊆ ALCANCE de la tarea, más el
estado esperado heredado de FASE 0 (las rutas de T2 que el redactor dejó
modificadas y que aún no se commitean no violan el alcance de T0 ni de T1;
cualquier otra ruta sí); (4) commit
con rutas explícitas; (5) sección `### FASE <n>: <título>` en el log con
Estado, Commits, Cambios, Verificación, Alcance, Regresión, Subagentes
("sin subagentes, por contrato"), Bugs, Decisiones autónomas, Errores propios y
Dudas (contexto, pregunta cerrada, qué bloquea).

### FASE 0: log y mediciones

1. `mkdir -p 50_documentacion/andamios/logs` y crear LOG con: meta en una línea,
   fecha, repo y rama (`git rev-parse --abbrev-ref HEAD`), PUNTO DE RETORNO,
   ENTORNO, línea `EJECUCIÓN:` y modo real de la sesión, grafo, "sin
   subagentes", topes, el slot `## J. Juicio (lo rellena FASE L)` vacío, y las
   secciones vacías de cierre.
2. Mediciones, cada una con `esperado:` antes y `obtenido:` después:
   - `git fetch --quiet && git rev-parse --short HEAD origin/main` → esperado: dos veces `9908180`.
   - `git status --porcelain` → esperado: ` M` en los tres archivos de §2 y `??`
     en este encargo; nada más (otro estado dispara la detención 2).
   - `git stash list` → esperado: vacío.
   - `md5 -q docs/index.html` → esperado: `c9747962e7f9cc8179de3a717f66f9af`.
   - `grep -c 'src="http' docs/index.html` → esperado: `3` (es también el
     control positivo del criterio de T2).
   - `grep -c 'src="http' 30_procesamiento/33_motor_template.html` → esperado: `0`.
   - `grep -c -F '__REACT_INLINE__' 30_procesamiento/33_motor_template.html` y
     lo mismo con `__REACTDOM_INLINE__` → esperado: `1` y `1`.
   - `grep -c -F '<script type="text/babel" data-presets="env,react">' 30_procesamiento/33_motor_template.html` → esperado: `1`.
   - `Rscript -e 'cat(sapply(c("V8","openssl"), requireNamespace, quietly=TRUE))'`
     → esperado: desconocido; se anota, y un `FALSE` habilita la autorización 2.
   - `Rscript -e 'invisible(parse("30_procesamiento/33_generar_html.R")); cat("parse OK")'`
     → esperado: `parse OK`.
3. Anexar la sección `### FASE 0`.

### T0: regla 12 (commit de documentación)

- Verificación: `grep -n '^12\. \*\*El alcance del instrumento' 50_documentacion/activa/50_diseno_ramas_deteccion.md`
  → esperado: una línea. `grep -c '^## ' <mismo archivo>` → esperado: `7`
  (calibración: en HEAD da `6`, `git show HEAD:<ruta> | grep -c '^## '`).
- Commit: `docs(diseno): regla 12 y A29-4, el alcance del instrumento iguala el de la afirmación`.

### T1: dependencias vendorizadas

1. `curl -fsSL` de las tres URL de `VENDOR_JS` a sus tres rutas.
2. Verificación en R, una fila por archivo, con el mismo cálculo del generador:
   `Rscript -e 'con<-file("<ruta>","rb"); cat(openssl::base64_encode(openssl::sha384(con))); close(con)'`
   → esperado: el `sri` de `VENDOR_JS` para esa ruta.
   Calibración (caso malo): copiar `10_utils/react.production.min.js` a
   `$(mktemp -d)/x.js`, agregarle un byte (`printf ' ' >> <copia>`), y el mismo
   comando debe dar un valor distinto del `sri`.
3. Commit: `chore(vendor): React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 en 10_utils (s31)`.

### T2: build sin red

1. `Rscript 30_procesamiento/33_generar_html.R` → esperado: última línea
   `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`, y la
   línea `[3b]` con `App JSX: <n> caracteres -> JS <m> caracteres`.
2. Verificaciones sobre `40_salidas/motor_comparacion.html` (cada una declara
   su universo, regla 12 de `50_diseno_ramas_deteccion.md`):
   - Universo: el archivo completo, porque la afirmación es sobre la página.
     `grep -c 'src="http' <salida>` → esperado: `0` (control positivo: `3` sobre
     `docs/index.html`, medido en FASE 0). `grep -c 'text/babel' <salida>` →
     esperado: `0` (control: `1` sobre `docs/index.html`). `grep -c -F '__REACT' <salida>` → esperado: `0`.
   - Universo: el bloque de la app, que es el último `<script>` del archivo.
     En R: `x <- paste(readLines(s, warn=FALSE), collapse="\n"); b <- tail(strsplit(x, "<script>", fixed=TRUE)[[1]], 1)`;
     calibración de la extracción: `grepl("ReactDOM.createRoot", b, fixed=TRUE)` → esperado `TRUE`;
     luego `lengths(gregexpr("React.createElement(", b, fixed=TRUE))` → esperado: mayor que 0;
     `grepl("_jsx(", b, fixed=TRUE)` → esperado `FALSE`.
   - Calibración de la guarda de sintaxis del generador: en R,
     `ctx <- V8::v8(); ctx$validate("const a = <div/>;")` → esperado `FALSE`, y
     `ctx$validate("const a = 1;")` → esperado `TRUE`.
3. Invariante del payload (§4, tercer 🔒) sobre la salida → esperado: md5 igual al de `docs/index.html`.
4. Anotar en el log el tamaño de la salida (`wc -c`) junto al de `docs/index.html`.
5. Commit: `feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31)`
   con `30_procesamiento/33_generar_html.R` y `30_procesamiento/33_motor_template.html`.

### T3: render sin red (solo si el entorno lo permite)

1. Medir `Rscript -e 'cat(requireNamespace("chromote", quietly=TRUE))'`. Si da
   `FALSE`, T3 queda "no ejecutada: sin chromote" y el render queda para el gate
   visual del titular. No se instala.
2. Si da `TRUE`: con `chromote`, activar `Network.emulateNetworkConditions`
   con `offline = TRUE`, abrir `file://` de la salida, esperar la carga y medir
   `document.querySelectorAll('#root *').length` → esperado: mayor que 0.
   Control positivo: el mismo procedimiento sobre `docs/index.html` → esperado: `0`
   (sin red no carga React). Sin commit: no toca archivos versionados.

### FASE R: auditoría propia y reparación (penúltima, obligatoria)

La reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni la meta.

1. Inventario numerado (`R-01`, …) derivado del log: cada verificación, cada
   cifra, cada 🔒 con su comando, y el alcance global. Se anexa antes de auditar.
2. Re-derivación con un comando distinto del que produjo cada afirmación (por
   ejemplo, el sha384 con `shasum -a 384 -b <ruta> | xxd -r -p | base64`; el
   conteo de `src="http` con R en vez de `grep`).
3. Cada 🔒 de §4 con su comando: PASA/FALLA y salida literal.
4. Alcance global: `git diff --name-only <PUNTO DE RETORNO>..HEAD` ⊆ unión de
   los ALCANCE más el LOG; y `git status --porcelain` (lo no commiteado es
   hallazgo, no se limpia).
5. Regresión completa: el sustituto de PRUEBAS sobre el estado final.
6. Control positivo de la auditoría: al menos una afirmación auditada además
   contra un caso plantado (una copia de la salida en `$(mktemp -d)` con un
   `<script src="https://x">` agregado, sobre la que el conteo debe dar 1).
7. Severidad por hallazgo: BLOQUEA (gobernanza, 🔒 en FALLA, datos alterados,
   alcance violado, historia divergente; no se repara, se congela y se
   registra), REPARA (defecto propio dentro del ALCANCE, sin tocar un 🔒, con
   verificación calibrada; se corrige en el paso 8), ADVIERTE (sin efecto sobre
   la meta; se registra).
8. Ciclo de reparación, máximo 2: causa raíz; fix dentro del ALCANCE;
   re-verificación con el chequeo que lo detectó y con uno distinto; regresión;
   commit `fix(auditoria): R-NN <hallazgo>`; fila en la tabla. Luego, pasos 2 a
   5 sobre lo tocado. Lo que sobrevive al segundo ciclo queda pendiente.
9. Prohibido: ajustar criterio, tolerancia o esperado; ampliar un ALCANCE;
   tocar un 🔒; editar evidencia ya escrita; reparar un BLOQUEA.
10. Salida: tabla `id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`
    y veredicto global (`APROBADO`, `APROBADO CON ADVERTENCIAS`, `OBSERVADO`, `BLOQUEADO`).

### FASE L: cierre del log (última, obligatoria, siempre)

1. `git status --porcelain` → esperado: vacío, o solo el LOG. Otra cosa se anota, no se limpia.
2. Completar el cierre: resumen, inventario de commits desde
   `git log <PUNTO DE RETORNO>..HEAD --oneline`, tabla de auditoría,
   invariantes, cifras críticas (md5 de `docs/index.html` y del payload),
   dudas y pendientes consolidados con su pregunta cerrada, errores propios,
   notas para el revisor.
3. Rellenar el bloque J (trece campos, una línea cada uno, copiados del detalle).
4. Privacidad: `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' <LOG>` →
   esperado: vacío; y el log no contiene filas de datos ni nombres de personas
   ni de establecimientos.
5. `ls -l <LOG> && wc -l <LOG>`; `grep -c '^### FASE' <LOG>` igual a las fases
   ejecutadas (congeladas y FASE R incluidas); `grep -c '^esperado:' <LOG>` igual
   a `grep -c '^obtenido:' <LOG>`; `grep -c '^## J' <LOG>` = 1.
6. `git add <LOG> 50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md` y
   `git commit -m "docs(log): retiro de unpkg.com con transpilación en el build"`.
7. Push según la autorización 4, y estado de cierre declarado con
   `git log -1 --format=%h`.

## 6. Reporte final

Primera línea: la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash del
commit `docs(log)`. Segundo bloque: el bloque J copiado tal cual. Después:
hashes, tamaños de la salida y de `docs/index.html`, lo que falló o sorprendió
(si nada, decirlo), y la instrucción al titular para su gate visual: abrir
`40_salidas/motor_comparacion.html` con la red desactivada y recorrer la vista
de comparación, el panorama y las tres exportaciones.

**Pendientes excluidos de esta cadena, con su razón:** despliegue a `docs/`
(gate visual del titular); desborde bajo 540px y `xmlns` (tocan la plantilla y
se hacen sobre la base ya estabilizada, sesión 33); traslado de la vista de
trayectorias (su propia cadena, sesión 32); agregar `V8` y `openssl` a
`renv.lock` (bloqueado por `suitedoc`, fuera de este repositorio).
