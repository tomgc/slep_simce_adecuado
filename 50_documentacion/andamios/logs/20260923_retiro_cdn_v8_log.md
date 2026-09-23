# Log — Retiro de `unpkg.com` del motor (opción C, transpilación en el build con V8)

- **Meta:** el motor publicado no carga nada por red, y el titular sigue editando la app como JSX dentro de la plantilla.
- **Fecha:** 2026-09-23 (sesión 31).
- **Encargo:** `50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md` (formato `encargo_autonomo_claude_code_v1.md` v1.6).
- **Repo y rama:** `slep_simce_adecuado`, `main` (`git rev-parse --abbrev-ref HEAD` → `main`).
- **PUNTO DE RETORNO:** `9908180` (`git rev-parse --short HEAD`, leído al abrir FASE 0).
- **ENTORNO:** Claude Code en la estación macOS del titular (`MacBook-Pro-de-Tomas.local`, macOS 27.0), raíz `/Users/tomgc/Projects/slep_simce_adecuado`; `bash` explícito para shell; `Rscript` (R 4.5.2, renv activado por `.Rprofile`) para todo cálculo sobre archivos del proyecto.
- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión (Opus 5.5, `claude-opus-5-5[1m]`); subagentes 0, total Opus del encargo 0.
- **Modo real de la sesión:** `ultracode` (xhigh + orquestación dinámica); subagentes usados: 0, por contrato (§1 del encargo; v1.6 §2.12 regla 1). Tampoco se usa la herramienta de workflows.
- **Grafo:** T0 es independiente. T2 requiere T1. T3 requiere T2. FASE R y FASE L cierran la cadena, fuera del grafo, y corren aunque una tarea quede congelada.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug (al tercero, la tarea se congela con la evidencia de los tres); 2 ciclos de reparación en FASE R; 1 reintento por comando que falla por causa transitoria (red, lock, timeout).
- **Método de registro:** cada verificación se anexa con un ayudante de shell que vive en el scratchpad de la sesión (fuera del árbol): escribe el comando y la línea `esperado:` antes de correrlo, y la línea `obtenido:` con la salida literal (stdout y stderr) después; si el código de salida no es 0, lo anota entre corchetes. Las salidas de varias líneas van en un bloque `text` bajo `obtenido:`. Dentro de cada sección por fase, la verificación va primero porque se escribe mientras se trabaja; los demás rótulos se anexan al cerrar la fase.

---

## J. Juicio
- Meta y resultado: motor publicado sin carga por red y app editable como JSX → parcial: dependencias vendorizadas (T1) y build sin red que funciona, pero T2 quedó congelada sin commit y nada se publicó.
- Estado por tarea: T0 completada (`2ab9927`) · T1 completada (`65e5e4a`) · T2 congelada (cláusula residual: `grep -c -F '__REACT'` = 1; 🔒 3 en FALLA) · T3 no ejecutada (depende de T2).
- Commits: 3, rango `2ab9927`..`docs(log)` (`git log 9908180..HEAD --oneline`; el hash del `docs(log)` va en el reporte final), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): BLOQUEADO; hallazgos B/R/A = 2/0/3; reparados 0; abiertos 2 (R-14, R-23; BLOQUEA, no se reparan).
- Invariantes: 4/5 PASA; FALLA: 🔒 3 (md5 del payload comprimido; la única diferencia del JSON es `meta.fecha_generacion`, 2026-09-23 contra 2026-08-29).
- Cifras críticas: intactas (`docs/index.html` md5 `c9747962e7f9cc8179de3a717f66f9af` antes y después; JSON idéntico al publicado al igualar la fecha, md5 `1691b8fcb8bebe781ecc084f0d3bde94`).
- Decisiones autónomas de mayor riesgo: no commitear T2 ni ajustar criterios (descartada: commitear declarando la desviación); borrar la línea separadora duplicada del generador, sin commit (descartada: registrarla como ADVIERTE); re-medir HEAD contra origin/main por dos vías (descartada: detener la sesión).
- Desviaciones respecto del encargo: comando de FASE 0 re-medido por dos vías; chequeos propios en T1, T2 y FASE L; criterios de T2 medidos como evidencia tras congelar; sin push (la autorización 4 exige árbol limpio).
- Dudas abiertas: 4; D1 ¿se acepta `grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__'` = 0 como criterio de marcadores reemplazados? (sí/no) · D2 ¿🔒 del payload: (a) reformular sobre el JSON sin fecha, (b) generador determinista, (c) otra? · D3 ¿se corrige `rev-parse --short` en la plantilla v1.6? (sí/no).
- Errores propios: 4 registrados (dos mediciones sin pre-registro, repetidas; un esperado mal derivado, corregido; un RUT ficticio del control de privacidad que entró al log, sustituido); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: el render sin red (T3 no corrió): abrir `40_salidas/motor_comparacion.html` con la red desactivada y recorrer la comparación, el panorama y las tres exportaciones.
- No publicado / queda al usuario: push retenido (3 commits locales); commit de T2 y T3 a la espera de D1 y D2; despliegue a `docs/` tras el gate visual.
- Ejecución: modo de sesión ultracode; subagentes 0, por contrato.

---

## Cierre (lo rellena FASE L)

### C.1 Resumen de la sesión

Entraron cuatro tareas (T0 a T3) y las fases 0, R y L. Siete secciones por fase. T0 completada: commit de la regla 12. T1 completada: se instalaron `openssl` y `V8`, se descargaron las tres dependencias con sha384 verificado y se commitearon. T2 congelada por la cláusula residual. El build corre sin error; sale sin `src="http`, sin `text/babel`, con la app transpilada (408 `React.createElement(`, ningún `_jsx(`, JS válido), y ese transpilado es idéntico al que Babel producía en el navegador. Dos criterios del encargo no pasan, y ninguno por defecto del build: `__REACT` cuenta el identificador `__REACT_DEVTOOLS_GLOBAL_HOOK__` de ReactDOM, y el 🔒 del payload cae por `meta.fecha_generacion`. T3 no ejecutada. FASE R: `BLOQUEADO`. Sin push.

### C.2 Inventario de commits

Derivado de `git log 9908180..HEAD --oneline` (FASE L, antes del commit del LOG):

- `2ab9927` docs(diseno): regla 12 y A29-4, el alcance del instrumento iguala el de la afirmación · FASE T0.
- `65e5e4a` chore(vendor): React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 en 10_utils (s31) · FASE T1.
- `docs(log)`: retiro de unpkg.com con transpilación en el build · FASE L (el hash va en el reporte final; el archivo no puede contener su propio hash).

Ningún `fix(auditoria)`.

### C.3 Tabla de auditoría (FASE R)

La tabla completa está en la sección `FASE R: auditoría y reparación` (R-01 a R-30). Veredicto global `BLOQUEADO`. Hallazgos: BLOQUEA 2 (R-14, criterio `__REACT`; R-23, 🔒 del payload); REPARA 0; ADVIERTE 3 (R-01, comando `rev-parse --short` del encargo; R-06, renv `out-of-sync`; R-27, rutas de T2 sin commit). Reparados 0; abiertos los 2 BLOQUEA. Control positivo: R-30 (tres casos plantados, los tres disparan).

### C.4 Verificación de invariantes

- 🔒 1 `docs/index.html` no cambia: **PASA** (`c9747962e7f9cc8179de3a717f66f9af`; `git diff --quiet 9908180` = 0).
- 🔒 2 D3 y pako no cambian: **PASA** (código 0 contra HEAD y contra `9908180`).
- 🔒 3 payload del build = publicado: **FALLA** (`88f3666b55de9c9be1a938a3e57d3c52` contra `6a868d43d3a9691d1842b1e49c32a980`). Causa diagnosticada por dos vías: `meta.fecha_generacion`.
- 🔒 4 ningún archivo de datos: **PASA** (0 commiteados, 0 pendientes; el patrón dispara sobre un `.parquet` plantado).
- 🔒 5 `andamios/` solo recibe el LOG: **PASA** en FASE R (0 filas antes del commit del LOG); la medición posterior al commit va en el reporte final.

### C.5 Decisiones del usuario registradas

Ninguna tomada en esta sesión: el encargo no tenía gates intermedios. La meta viene aprobada por el titular en el encabezado del encargo.

### C.6 Estado de cifras críticas

- `docs/index.html`: md5 `c9747962e7f9cc8179de3a717f66f9af` en FASE 0 y en FASE R; 2624974 bytes.
- Payload comprimido (`atob("…")`, md5 del encargo): salida `88f3666b55de9c9be1a938a3e57d3c52`, publicado `6a868d43d3a9691d1842b1e49c32a980`.
- JSON descomprimido: 13597252 caracteres en los dos. md5 de la salida `b507337ce8fb71fd3ca86bb0597e3d5c`, del publicado `1691b8fcb8bebe781ecc084f0d3bde94`. Con `fecha_generacion` igualada, la salida da `1691b8fcb8bebe781ecc084f0d3bde94` (idéntica). Por `jsonlite`, solo difiere esa clave.
- Salida `40_salidas/motor_comparacion.html`: 2785497 bytes, md5 `892929f4fa997bae71e66349b428d7ed`, reproducida byte a byte por la regresión.

### C.7 Dudas y pendientes consolidados

1. **D1 (T2, R-14, BLOQUEA).** Contexto: `grep -c -F '__REACT' <salida>` = 1 porque ReactDOM trae `__REACT_DEVTOOLS_GLOBAL_HOOK__` (2 apariciones, todas en su bloque inline); los marcadores exactos dan 0 en la salida y 2 en la plantilla. Pregunta cerrada: ¿se acepta `grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__' <salida>` = 0 como criterio de "marcadores reemplazados" (sí/no)? Bloquea el commit de T2, T3 y el push.
2. **D2 (T2, R-23, BLOQUEA).** Contexto: el 🔒 del payload compara el base64 comprimido, y el JSON lleva `meta.fecha_generacion = format(Sys.Date())`; con la fecha igualada, el JSON es idéntico al publicado. Pregunta cerrada: ¿(a) el 🔒 se reformula sobre el JSON descomprimido con la fecha igualada, (b) el generador se hace determinista en la fecha, o (c) otra? Bloquea el commit de T2 y el push.
3. **D3 (FASE 0, R-01, ADVIERTE).** Contexto: `git rev-parse --short HEAD origin/main` sale con código 128 (`--short` implica `--verify`). Pregunta cerrada: ¿la plantilla de FASE 0 del formato v1.6 pasa a `git rev-parse --short HEAD && git rev-parse --short origin/main` (sí/no)? No bloquea.
4. **D4 (FASE 0, R-06, ADVIERTE).** Contexto: renv reporta `out-of-sync` (`V8`, `openssl`, `openxlsx`, `Rcpp`, `suitedoc` y `zip` sin registrar). Pregunta cerrada: ¿se resuelve con el pendiente "agregar V8 y openssl a `renv.lock`", fuera de esta cadena (sí/no)? No bloquea.
5. **Pendiente derivado:** con D1 y D2 resueltas, falta commitear T2 (el diff sin commit de las dos rutas, que incluye la línea separadora borrada por el ejecutor), correr T3 y hacer el push de los commits locales.
6. **Pendientes excluidos por el encargo, sin cambios:** despliegue a `docs/` (gate visual); desborde bajo 540px y `xmlns` (sesión 33); traslado de la vista de trayectorias (sesión 32); `V8` y `openssl` en `renv.lock` (bloqueado por `suitedoc`).

### C.8 Errores propios consolidados

1. T1: el conteo de `<!--`, `-->` y `<script` sobre las dependencias JS se corrió primero sin pre-registro; se repitió con esperado. Costo: una medición.
2. T2: el origen del `1` de `__REACT` se midió primero sin pre-registro; se repitió con esperado. Costo: una medición.
3. T2: esperado mal derivado del `--numstat` (141 en vez de 140); corregido en una línea nueva que lo cita. Costo: ninguno.
4. FASE L: el control positivo del grep de privacidad se corrió con el ayudante, que copió al log el comando y la salida con un RUT ficticio plantado; el propio grep de privacidad lo habría encontrado. Se sustituyó antes del commit (C.10). Costo: una sustitución y una re-medición.

### C.9 Notas para el revisor

- R-14 es el caso exacto de la regla 12, commiteada en T0 de esta misma sesión: el criterio mide el archivo cuando la afirmación es de dos marcadores. Tampoco se calibró sobre el caso bueno (v1.6 §2.6, "calla sobre un caso bueno conocido").
- R-23 falla en cualquier build de un día distinto al del publicado, porque la fecha viaja dentro del JSON. Un encargo futuro que declare "payload intacto" tiene que comparar datos, no bytes comprimidos, o fijar la fecha.
- Medición complementaria de FASE L, no auditada en FASE R: el transpilado del build (`sourceType: 'script'`, runtime `classic`) es idéntico carácter por carácter (175217) al que Babel standalone producía en el navegador con `data-presets="env,react"`. Es evidencia de que la app se comporta igual que antes; no reemplaza el render.
- `babel.min.js` (3137752 bytes) queda versionado en `10_utils/` aunque no viaja al HTML: es dependencia del build.
- `V8` y `openssl` no están en `renv.lock`: un clon limpio con `renv::restore()` no los trae, y el generador se detiene con el mensaje de instalación.
- La única mención de `unpkg` en la salida es el comentario HTML de la plantilla, no un `src`.
- El diff sin commit de `33_generar_html.R` incluye una edición del ejecutor: la línea separadora duplicada del Bloque 4, borrada.

### C.10 Estado de cierre

- Commiteado: `2ab9927` (T0), `65e5e4a` (T1) y el `docs(log)` con este LOG y el encargo (hash en el reporte final).
- NO se publica: ningún push. La autorización 4 exige `git status --porcelain` vacío, y quedan ` M` las dos rutas de T2 congelada. `docs/index.html` no se tocó.
- Queda al usuario: responder D1 y D2; commitear T2; T3 o el gate visual sin red; el push de los tres commits locales; el despliegue a `docs/`.
- Sustitución por privacidad (v1.6 §2.8.4): en la sección de FASE L, el comando y la línea `obtenido:` del control positivo del grep de privacidad llevaban un RUT ficticio plantado (formato con puntos y guion). Antes del commit se reemplazó el valor literal por `<RUT ficticio con puntos y guion, sustituido>`; el conteo de esa salida (una línea) se conserva.

---

## Registro por fase

### FASE 0: log y mediciones

**Verificación:**

`git fetch --quiet && git rev-parse --short HEAD origin/main`

esperado: dos veces `9908180`
obtenido: fatal: Needed a single revision [código de salida 128]

`git status --porcelain`

esperado: ` M` en `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html` y `50_documentacion/activa/50_diseno_ramas_deteccion.md`, y `??` en `50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md`; nada más (el log aún vive en el scratchpad y no puede aparecer)
obtenido:

```text
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
 M 50_documentacion/activa/50_diseno_ramas_deteccion.md
?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
```

`git stash list`

esperado: vacío
obtenido: (sin salida)

Nota de instrumento (cita la primera medición de esta sección): `git rev-parse --short` implica `--verify` y acepta una sola revisión, por eso el comando del encargo sale con código 128 sin medir nada; el `git fetch` sí corrió (el `&&` llegó al `rev-parse`). La afirmación no cambia; se re-mide con un `rev-parse` por revisión.

`git fetch --quiet && git rev-parse --short HEAD && git rev-parse --short origin/main`

esperado: dos veces `9908180`
obtenido:

```text
9908180
9908180
```

`git rev-parse HEAD origin/main | sort -u | wc -l | tr -d " "`

esperado: `1` (HEAD y origin/main, completos, son el mismo hash)
obtenido: 1

`md5 -q docs/index.html`

esperado: `c9747962e7f9cc8179de3a717f66f9af`
obtenido: c9747962e7f9cc8179de3a717f66f9af

`grep -c 'src="http' docs/index.html`

esperado: `3`
obtenido: 3

`grep -c 'src="http' 30_procesamiento/33_motor_template.html`

esperado: `0`
obtenido: 0 [código de salida 1]

`grep -c -F '__REACT_INLINE__' 30_procesamiento/33_motor_template.html; grep -c -F '__REACTDOM_INLINE__' 30_procesamiento/33_motor_template.html`

esperado: `1` y `1`
obtenido:

```text
1
1
```

`grep -c -F '<script type="text/babel" data-presets="env,react">' 30_procesamiento/33_motor_template.html`

esperado: `1`
obtenido: 1

`Rscript -e 'cat(sapply(c("V8","openssl"), requireNamespace, quietly=TRUE))'`

esperado: desconocido; se anota, y un `FALSE` habilita la autorización 2 para ese paquete
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
FALSE FALSE
```

`Rscript -e 'invisible(parse("30_procesamiento/33_generar_html.R")); cat("parse OK")'`

esperado: `parse OK`
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
parse OK
```

`Rscript -e 'renv::status()' 2>&1 | head -n 14`

esperado: no enumerado en el encargo; se anota como observación (la advertencia `out-of-sync` de renv apareció en las dos mediciones con Rscript)
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
The following package(s) are in an inconsistent state:

 package  installed recorded used
 openssl  n         n        y   
 openxlsx y         n        y   
 Rcpp     y         n        y   
 suitedoc y         n        y   
 V8       n         n        y   
 zip      y         n        y   

See `?renv::status` for advice on resolving these issues.
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las tres rutas de §2 del encargo, el encargo y el LOG; nada más
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/activa/50_diseno_ramas_deteccion.md
50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

**Estado:** completada. Ninguna regla de detención disparada: `HEAD` = `origin/main` = `9908180` tras `git fetch` (regla 1 no dispara) y `git status --porcelain` igual al conjunto esperado (regla 2 no dispara).

**Commits:** ninguno (FASE 0 no commitea).

**Cambios sustantivos:** se creó este log. Mediciones: premisas de §2 del encargo confirmadas una a una (HEAD, árbol, `docs/index.html`, plantilla con los dos marcadores y el ancla). `V8` y `openssl` miden `FALSE`: queda habilitada la autorización 2 para los dos paquetes. La guarda de sintaxis del generador parsea.

**Alcance:** `⊆`. Rutas fuera de git: las tres modificadas por el redactor, el encargo y el LOG, que es el estado esperado heredado más el LOG.

**Regresión:** no tocó código (solo se creó el LOG).

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno del repositorio.

**Decisiones autónomas:**
1. El LOG se escribió primero en el scratchpad de la sesión y se movió a su ruta después de medir `git status --porcelain`, para que el propio log no apareciera como `??` en la medición del conjunto esperado. El primer acto sobre el estado del repo fue `git fetch` (POSICIÓN); antes solo hubo lecturas (`git rev-parse --short HEAD` para el encabezado, `hostname`, versión de R). Alternativa descartada: crear el log en su ruta y restarlo a mano del estado medido. Reversible.
2. La comparación `HEAD` contra `origin/main` se re-midió con un `rev-parse` por revisión, más una segunda vía con hashes completos (`sort -u | wc -l`), porque el comando del encargo no corre (ver Dudas). La afirmación y el esperado no cambian. Alternativa descartada: congelar la sesión por un resultado no enumerado; se descartó porque el código 128 viene del instrumento, no del repositorio, y la misma afirmación se midió por dos vías. Reversible.

**Errores propios:** ninguno.

**Dudas:**
1. Contexto: el comando de FASE 0 `git rev-parse --short HEAD origin/main` sale con `fatal: Needed a single revision` (código 128), porque `--short` implica `--verify`. Pregunta cerrada: ¿el formato v1.6 debe corregir su plantilla de FASE 0 a `git rev-parse --short HEAD && git rev-parse --short origin/main` (sí/no)? No bloquea nada en esta sesión.
2. Contexto: renv reporta `out-of-sync` al arrancar: `V8` y `openssl` usados y ni instalados ni registrados; `openxlsx`, `Rcpp`, `suitedoc` y `zip` instalados y no registrados en `renv.lock`. Es estado previo al encargo, coherente con el pendiente "agregar `V8` y `openssl` a `renv.lock` (bloqueado por `suitedoc`)". Pregunta cerrada: ¿se resuelve junto con ese pendiente, fuera de esta cadena (sí/no)? No bloquea nada: el encargo prohíbe editar `renv.lock`.

### FASE T0: regla 12 (commit de documentación)

**Verificación:**

`grep -n '^12\. \*\*El alcance del instrumento' 50_documentacion/activa/50_diseno_ramas_deteccion.md`

esperado: una línea
obtenido: 148:12. **El alcance del instrumento iguala el alcance de la afirmación.** Si la

`grep -c '^## ' 50_documentacion/activa/50_diseno_ramas_deteccion.md`

esperado: `7`
obtenido: 7

`git show HEAD:50_documentacion/activa/50_diseno_ramas_deteccion.md | grep -c '^## '`

esperado: `6` (calibración en HEAD)
obtenido: 6

`git show HEAD:50_documentacion/activa/50_diseno_ramas_deteccion.md | grep -c '^12\. \*\*El alcance del instrumento'`

esperado: `0` (control: la regla 12 no existe en HEAD, el patrón distingue)
obtenido: 0 [código de salida 1]

`git diff --numstat HEAD -- 50_documentacion/activa/50_diseno_ramas_deteccion.md`

esperado: solo inserciones (el redactor anexó la regla 12, la línea del checklist y la sección 7): `40	0`
obtenido: 40	0	50_documentacion/activa/50_diseno_ramas_deteccion.md

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: la ruta de T0, las dos de T2 que el redactor dejó modificadas, el encargo y el LOG; nada más
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/activa/50_diseno_ramas_deteccion.md
50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

**Estado:** completada.

**Commits:** `2ab9927` docs(diseno): regla 12 y A29-4, el alcance del instrumento iguala el de la afirmación (1 archivo, 40 inserciones).

**Cambios sustantivos:** se commiteó sin modificarla la edición del redactor a `50_documentacion/activa/50_diseno_ramas_deteccion.md`: regla 12 en el `## 3`, línea nueva en la lista de comprobación y sección `## 7` (A29-4). Solo inserciones.

**Alcance:** `⊆`. Rutas fuera de git antes del commit: la de T0 más el estado heredado de FASE 0 (las dos rutas de T2 del redactor, el encargo y el LOG).

**Regresión:** no tocó código (documentación).

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:** ninguna.

**Errores propios:** ninguno.

**Dudas:** ninguna.

### FASE T1: dependencias vendorizadas

**Verificación:**

`Rscript -e 'install.packages("openssl")' 2>&1 | tail -n 6`

esperado: instalación sin error (autorización 2: FASE 0 midió `FALSE` para `openssl`)
obtenido:

```text

# Installing packages --------------------------------------------------------
- Installing sys ...                            OK [linked from cache]
- Installing askpass ...                        OK [linked from cache]
- Installing openssl ...                        OK [linked from cache]
Successfully installed 3 packages in 3.9 milliseconds.
```

`Rscript -e 'install.packages("V8")' 2>&1 | tail -n 6`

esperado: instalación sin error (autorización 2: FASE 0 midió `FALSE` para `V8`)
obtenido:

```text
These packages will be installed into "~/Projects/slep_simce_adecuado/renv/library/macos/R-4.5/aarch64-apple-darwin20".

# Installing packages --------------------------------------------------------
- Installing curl ...                           OK [installed binary and cached]
- Installing V8 ...                             OK [linked from cache]
Successfully installed 2 packages in 70 milliseconds.
```

`Rscript -e 'cat(sapply(c("V8","openssl"), requireNamespace, quietly=TRUE)); cat("\n"); cat(as.character(packageVersion("V8")), as.character(packageVersion("openssl"))); cat("\n"); cat(V8::engine_info()$version)' 2>&1 | tail -n 3`

esperado: `TRUE TRUE`, y las versiones de `V8`, `openssl` y del motor V8
obtenido:

```text
TRUE TRUE
8.2.0 2.4.2
13.6.233.17
```

`curl -fsSL https://unpkg.com/react@18.3.1/umd/react.production.min.js -o 10_utils/react.production.min.js`

esperado: sin salida, código 0
obtenido: (sin salida)

`curl -fsSL https://unpkg.com/react-dom@18.3.1/umd/react-dom.production.min.js -o 10_utils/react-dom.production.min.js`

esperado: sin salida, código 0
obtenido: (sin salida)

`curl -fsSL https://unpkg.com/@babel/standalone@7.29.0/babel.min.js -o 10_utils/babel.min.js`

esperado: sin salida, código 0
obtenido: (sin salida)

`wc -c 10_utils/react.production.min.js 10_utils/react-dom.production.min.js 10_utils/babel.min.js`

esperado: tres archivos no vacíos (no enumerado en el encargo; se anota el tamaño)
obtenido:

```text
   10751 10_utils/react.production.min.js
  131835 10_utils/react-dom.production.min.js
 3137752 10_utils/babel.min.js
 3280338 total
```

`Rscript -e 'con<-file("10_utils/react.production.min.js","rb"); cat(openssl::base64_encode(openssl::sha384(con))); close(con)'`

esperado: `DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z`
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z
```

`Rscript -e 'con<-file("10_utils/react-dom.production.min.js","rb"); cat(openssl::base64_encode(openssl::sha384(con))); close(con)'`

esperado: `gTGxhz21lVGYNMcdJOyq01Edg0jhn/c22nsx0kyqP0TxaV5WVdsSH1fSDUf5YJj1`
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
gTGxhz21lVGYNMcdJOyq01Edg0jhn/c22nsx0kyqP0TxaV5WVdsSH1fSDUf5YJj1
```

`Rscript -e 'con<-file("10_utils/babel.min.js","rb"); cat(openssl::base64_encode(openssl::sha384(con))); close(con)'`

esperado: `m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y`
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y
```

`d=$(mktemp -d) && cp 10_utils/react.production.min.js $d/x.js && printf ' ' >> $d/x.js && Rscript -e 'con<-file("'$d'/x.js","rb"); cat(openssl::base64_encode(openssl::sha384(con))); close(con)'`

esperado: un valor distinto de `DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z` (calibración, caso malo)
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
pIFJYrdDUVTl6Bc04t6/qARj12kag5ohhKzDl3i4xRnieD+UFp0yLea6omqbFp8/
```

Chequeo propio, no enumerado en el encargo (se agrega porque T2 inyecta React y ReactDOM dentro de `<script>`, y un `</script` literal cerraría la etiqueta antes de tiempo):

`grep -ci '</script' 10_utils/react.production.min.js; grep -ci '</script' 10_utils/react-dom.production.min.js`

esperado: `0` y `0`
obtenido: [código de salida 1]

```text
0
0
```

`grep -c '<script>' 10_utils/react-dom.production.min.js; grep -o '<script>[^"]*"' 10_utils/react-dom.production.min.js | head -n 3`

esperado: control positivo del patrón: ReactDOM contiene la cadena `<script>` (crea un script de prueba con innerHTML), y su cierre viene escapado (`\x3c/script>`), por eso el conteo anterior da 0
obtenido:

```text
1
<script>\x3c/script>"
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las tres rutas de T1, las dos de T2 que el redactor dejó modificadas, el encargo y el LOG; nada más
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
10_utils/babel.min.js
10_utils/react-dom.production.min.js
10_utils/react.production.min.js
50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

Chequeo propio (segundo): dentro de un `<script>` inline, la secuencia `<!--` seguida de `<script` hace que el siguiente `</script>` no cierre la etiqueta; con la cadena `<script>` de ReactDOM medida arriba, basta que no haya `<!--`. Esta medición se corrió primero una vez fuera del ayudante, sin pre-registro (ver Errores propios); se repite aquí con su esperado:

`grep -o '<!--' 10_utils/react.production.min.js | wc -l | tr -d ' '; grep -o '<!--' 10_utils/react-dom.production.min.js | wc -l | tr -d ' '`

esperado: `0` y `0`
obtenido:

```text
0
0
```

`grep -o '<!--' 30_procesamiento/33_motor_template.html | wc -l | tr -d ' '`

esperado: mayor que 0 (control positivo del patrón: la plantilla tiene comentarios HTML)
obtenido: 5

**Estado:** completada. Regla 3 no dispara: los tres sha384 igualan su `sri` de `VENDOR_JS`, y la calibración con un byte agregado da un valor distinto.

**Commits:** `65e5e4a` chore(vendor): React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 en 10_utils (s31) (3 archivos, 302 inserciones).

**Cambios sustantivos:** se instalaron `openssl` 2.4.2 y `V8` 8.2.0 (motor V8 13.6.233.17) en la librería renv del proyecto, bajo la autorización 2; renv agregó como dependencias `sys`, `askpass` y `curl`. `renv.lock` no se tocó. Se descargaron las tres dependencias, una vez cada una y sin reintentos, desde las URL de `VENDOR_JS`: `react.production.min.js` (10751 bytes), `react-dom.production.min.js` (131835 bytes) y `babel.min.js` (3137752 bytes). Chequeos propios: ni React ni ReactDOM contienen `</script` ni `<!--`, así que pueden ir inline sin cerrar su etiqueta antes de tiempo.

**Alcance:** `⊆`. Rutas fuera de git antes del commit: las tres de T1 más el estado heredado (las dos rutas de T2 del redactor, el encargo y el LOG).

**Regresión:** no tocó código (archivos de terceros, verificados por hash).

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Se agregaron dos chequeos no enumerados (`</script` y `<!--` en React y ReactDOM), cada uno con esperado y control positivo, porque T2 los inyecta inline. Alternativa descartada: confiar en que T2 o T3 lo detectarían; T3 depende de `chromote` y puede no correr. Reversible (solo lectura).

**Errores propios:**
1. El conteo de `<!--`, `-->` y `<script` sobre las cuatro dependencias JS se corrió primero una vez fuera del ayudante, sin `esperado:` escrito antes. Salida de esa corrida: `<!--` 0 en las cuatro; `-->` 0 en las cuatro; `<script` 1 en ReactDOM y 0 en las otras tres. Se repitió con pre-registro (arriba) para React, ReactDOM y un control positivo. Costo: una medición repetida, sin rehechos.

**Dudas:** ninguna.

### FASE T2: build sin red

**Verificación:**

Antes del build se borró la línea separadora duplicada del encabezado del Bloque 4 de `33_generar_html.R` (edición del redactor; ver Decisiones autónomas).

`set -o pipefail; Rscript 30_procesamiento/33_generar_html.R > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_t2_intento1.txt 2>&1; echo "código Rscript: $?"; grep -A4 '^\[3b\]' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_t2_intento1.txt; tail -n 1 /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_t2_intento1.txt`

esperado: código 0; la línea `[3b]` seguida de `App JSX: <n> caracteres -> JS <m> caracteres`; última línea `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`
obtenido:

```text
código Rscript: 0
[3b] Verificando dependencias vendorizadas y transpilando la app...
    React:     10750 caracteres
    ReactDOM:  131834 caracteres
    App JSX:   156519 caracteres -> JS 175217 caracteres
[4] Construyendo HTML final...
33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
```

Universo: el archivo completo, porque la afirmación ("la página no carga nada por red ni trae Babel ni marcadores sin reemplazar") es sobre la página.

`grep -c 'src="http' 40_salidas/motor_comparacion.html; grep -c 'src="http' docs/index.html`

esperado: `0` en la salida; `3` en `docs/index.html` (control positivo)
obtenido:

```text
0
3
```

`grep -c 'text/babel' 40_salidas/motor_comparacion.html; grep -c 'text/babel' docs/index.html`

esperado: `0` en la salida; `1` en `docs/index.html` (control positivo)
obtenido:

```text
0
1
```

`grep -c -F '__REACT' 40_salidas/motor_comparacion.html; grep -c -F '__REACT' 30_procesamiento/33_motor_template.html`

esperado: `0` en la salida; `2` en la plantilla (control positivo: un marcador por línea)
obtenido:

```text
1
2
```

`grep -c -i 'unpkg' 40_salidas/motor_comparacion.html; grep -c -i 'unpkg' docs/index.html`

esperado: no enumerado; chequeo propio. En la salida, `1`: la única mención es el comentario HTML de la plantilla ("contra los SRI que se usaban con unpkg.com"); en `docs/index.html`, `3` o más (control positivo)
obtenido:

```text
1
4
```

`grep -n -i 'unpkg' 40_salidas/motor_comparacion.html | cut -c1-160`

esperado: una línea, dentro del comentario HTML de la plantilla (no es un `src`)
obtenido: 1217:       unpkg.com y los inyecta aquí. El motor no carga nada por red. -->

**Desviación:** el tercer chequeo de este universo (`grep -c -F '__REACT'`) dio `1` con esperado `0`. Cláusula residual (§1.1.6): **T2 queda congelada** en este punto, sin commit. El esperado no se ajusta. Lo que sigue en esta sección es evidencia de solo lectura para la duda (origen del `1` y los demás criterios de T2 medidos tal como los escribe el encargo); no reabre la tarea. El origen del `1` se miró primero una vez fuera del ayudante, sin pre-registro (ver Errores propios); se repite aquí:

`grep -o '__REACT[A-Za-z_]*' 40_salidas/motor_comparacion.html | sort | uniq -c; grep -n -o '__REACT[A-Za-z_]*' 40_salidas/motor_comparacion.html | cut -d: -f1 | sort -u`

esperado: si el `1` viene de ReactDOM: solo identificadores ajenos a los marcadores, en una sola línea
obtenido:

```text
   2 __REACT_DEVTOOLS_GLOBAL_HOOK__
1510
```

`grep -o '__REACT[A-Za-z_]*' 10_utils/react-dom.production.min.js | sort | uniq -c; grep -c -F '__REACT' 10_utils/react-dom.production.min.js`

esperado: los mismos identificadores y el mismo número de apariciones que en la salida (el archivo verificado por sha384 en T1 ya los contiene)
obtenido:

```text
   2 __REACT_DEVTOOLS_GLOBAL_HOOK__
1
```

`grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__' 40_salidas/motor_comparacion.html; grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__' 30_procesamiento/33_motor_template.html`

esperado: evidencia, no criterio: `0` en la salida; `2` en la plantilla (control positivo)
obtenido:

```text
0
2
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/bloques_t2.R 40_salidas/motor_comparacion.html 2>&1 | grep -v out-of-sync`

esperado: universo: el bloque inline de ReactDOM, extraído desde su comentario de licencia hasta su `</script>`; calibración: extraído no vacío `TRUE` y contiene `createRoot` `TRUE`; luego `2` apariciones del identificador en el bloque y `2` en el archivo (todas dentro de ReactDOM)
obtenido:

```text
reactdom_extraido_no_vacio: FALSE 
reactdom_contiene_createRoot: FALSE 
hook_en_bloque_reactdom: 0 
hook_en_archivo: 2 
```

Universo: el bloque de la app, que es el último `<script>` del archivo (criterios del encargo, medidos como evidencia).

`Rscript -e 's <- "40_salidas/motor_comparacion.html"; x <- paste(readLines(s, warn=FALSE), collapse="\n"); b <- tail(strsplit(x, "<script>", fixed=TRUE)[[1]], 1); cat(grepl("ReactDOM.createRoot", b, fixed=TRUE), lengths(gregexpr("React.createElement(", b, fixed=TRUE)), grepl("_jsx(", b, fixed=TRUE), "\n")' 2>&1 | grep -v out-of-sync`

esperado: `TRUE` (calibración de la extracción), un número mayor que 0, `FALSE`
obtenido: TRUE 408 FALSE 

`Rscript -e 'ctx <- V8::v8(); cat(ctx$validate("const a = <div/>;"), ctx$validate("const a = 1;"), "\n")' 2>&1 | grep -v out-of-sync`

esperado: `FALSE TRUE` (calibración de la guarda de sintaxis del generador)
obtenido: FALSE TRUE 

La extracción anterior falló su propia calibración (`FALSE`, `FALSE`): el ancla `@license React react-dom.production.min.js` no existe en una sola línea, porque el comentario de licencia pone `@license React` y ` * react-dom.production.min.js` en líneas distintas. Bug del instrumento propio, intento 1 (ver Bugs); se cambia el ancla a ` * react-dom.production.min.js` y se repite con el mismo esperado:

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/bloques_t2.R 40_salidas/motor_comparacion.html 2>&1 | grep -v out-of-sync`

esperado: universo: el bloque inline de ReactDOM; calibración: extraído no vacío `TRUE` y contiene `createRoot` `TRUE`; luego `2` apariciones del identificador en el bloque y `2` en el archivo
obtenido:

```text
reactdom_extraido_no_vacio: TRUE 
reactdom_contiene_createRoot: TRUE 
hook_en_bloque_reactdom: 2 
hook_en_archivo: 2 
```

Invariante del payload (§4, tercer 🔒), tamaños y chequeos propios de estructura (evidencia):

`grep -o 'atob("[^"]*")' 40_salidas/motor_comparacion.html | md5; grep -o 'atob("[^"]*")' docs/index.html | md5`

esperado: dos md5 iguales
obtenido:

```text
88f3666b55de9c9be1a938a3e57d3c52
6a868d43d3a9691d1842b1e49c32a980
```

`grep -o 'atob("[^"]*")' 40_salidas/motor_comparacion.html | wc -c | tr -d ' '; grep -c 'atob("' 40_salidas/motor_comparacion.html`

esperado: control de lectura del 🔒: el segmento no está vacío (más de dos millones de caracteres, el build dice 2.1 MB) y hay una sola línea con `atob(\"`
obtenido:

```text
2096901
1
```

`wc -c 40_salidas/motor_comparacion.html docs/index.html`

esperado: se anota (no hay esperado en el encargo)
obtenido:

```text
 2785497 40_salidas/motor_comparacion.html
 2624974 docs/index.html
 5410471 total
```

`grep -o '</script' 40_salidas/motor_comparacion.html | wc -l | tr -d ' '; grep -o '</script' 30_procesamiento/33_motor_template.html | wc -l | tr -d ' '`

esperado: `6` y `6`: un cierre por cada una de las seis etiquetas `<script>` de la plantilla; ninguna dependencia ni la app transpilada trae un cierre propio
obtenido:

```text
6
6
```

`grep -o '<!--' 40_salidas/motor_comparacion.html | wc -l | tr -d ' '`

esperado: `5`, los cinco comentarios HTML de la plantilla (medidos en T1); nada nuevo desde la app transpilada
obtenido: 5

`grep -c 'Ã' 40_salidas/motor_comparacion.html; grep -c 'Ã' docs/index.html; grep -c $(printf '\xef\xbf\xbd') 40_salidas/motor_comparacion.html; grep -c $(printf '\xef\xbf\xbd') docs/index.html`

esperado: mojibake: el primer par igual entre sí y el segundo par igual entre sí (la salida no gana `Ã` ni caracteres de reemplazo respecto del publicado)
obtenido: [código de salida 1]

```text
0
0
0
0
```

**🔒 del payload en FALLA** (primer comando de este bloque): md5 `88f3666b55de9c9be1a938a3e57d3c52` en la salida contra `6a868d43d3a9691d1842b1e49c32a980` en `docs/index.html`. Hipótesis de causa: `33_generar_html.R` escribe `meta.fecha_generacion = format(Sys.Date())` dentro del JSON (línea 194), y el publicado se construyó el 2026-08-29. Diagnóstico de solo lectura en R (descomprime los dos segmentos; no imprime filas de datos):

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/payload_t2.R 40_salidas/motor_comparacion.html docs/index.html 2>&1 | grep -v out-of-sync`

esperado: si la hipótesis es cierta: JSON de igual largo, md5 distintos, una aparición de `fecha_generacion` en cada uno con fechas distintas, y `TRUE` al sustituir solo la fecha (md5 igual al del publicado)
obtenido:

```text
b64 caracteres a/b: 2096892 2096888 
json caracteres a/b: 13597252 13597252 
json md5 a/b: b507337ce8fb71fd3ca86bb0597e3d5c 1691b8fcb8bebe781ecc084f0d3bde94 
fecha_generacion a: "fecha_generacion":"2026-09-23" | apariciones: 1 
fecha_generacion b: "fecha_generacion":"2026-08-29" | apariciones: 1 
json md5 a con la fecha de b: 1691b8fcb8bebe781ecc084f0d3bde94 
identico a b tras sustituir solo la fecha: TRUE 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/payload_t2.R docs/index.html docs/index.html 2>&1 | grep -v out-of-sync`

esperado: control del instrumento, caso bueno: el publicado contra sí mismo da md5 iguales y `TRUE`
obtenido:

```text
b64 caracteres a/b: 2096888 2096888 
json caracteres a/b: 13597252 13597252 
json md5 a/b: 1691b8fcb8bebe781ecc084f0d3bde94 1691b8fcb8bebe781ecc084f0d3bde94 
fecha_generacion a: "fecha_generacion":"2026-08-29" | apariciones: 1 
fecha_generacion b: "fecha_generacion":"2026-08-29" | apariciones: 1 
json md5 a con la fecha de b: 1691b8fcb8bebe781ecc084f0d3bde94 
identico a b tras sustituir solo la fecha: TRUE 
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las dos rutas de T2 (modificadas, sin commit), el encargo y el LOG; nada más (la salida `40_salidas/motor_comparacion.html` está ignorada)
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

`git check-ignore -v 40_salidas/motor_comparacion.html`

esperado: la regla de `.gitignore` que ignora la salida
obtenido: .gitignore:13:40_salidas/motor_comparacion.html	40_salidas/motor_comparacion.html

`git diff --numstat HEAD -- 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html`

esperado: el diff del redactor menos la línea separadora borrada: `141	1` en el generador (FASE 0 medía 142 inserciones) y `8	14` en la plantilla
obtenido:

```text
140	1	30_procesamiento/33_generar_html.R
8	14	30_procesamiento/33_motor_template.html
```

Corrección al esperado del último comando (error propio, no del repositorio): el `142` que cité era el total de líneas cambiadas del `git diff --stat` inicial (inserciones más borrados), no las inserciones. Re-derivación con los totales de ese mismo `--stat` (189 inserciones y 15 borrados en tres archivos; 40 y 0 del diseño; 8 y 14 de la plantilla): el generador traía 141 inserciones y 1 borrado; menos la línea separadora borrada, 140 y 1, que es lo obtenido.

**Estado:** **congelada** por la cláusula residual (§1.1.6), sin commit. Disparo: `grep -c -F '__REACT' 40_salidas/motor_comparacion.html` dio `1` con esperado `0`. Además, el 🔒 del payload (§4, tercero) está en FALLA: md5 `88f3666b55de9c9be1a938a3e57d3c52` en la salida contra `6a868d43d3a9691d1842b1e49c32a980` en `docs/index.html`. Las dos desviaciones están diagnosticadas; ninguna viene de un defecto del build (ver Dudas).

**Commits:** ninguno. `30_procesamiento/33_generar_html.R` y `30_procesamiento/33_motor_template.html` siguen modificados en el árbol, sin commit.

**Cambios sustantivos:** el build corrió al primer intento con código 0 (`App JSX: 156519 caracteres -> JS 175217 caracteres`; salida de 2785497 bytes contra 2624974 del publicado). Criterios del encargo medidos: sin `src="http` (0; control 3), sin `text/babel` (0; control 1); en el bloque de la app, extracción calibrada (`TRUE`), 408 `React.createElement(` y ningún `_jsx(`; guarda de sintaxis calibrada (`FALSE TRUE`). Falla `__REACT` (1). Chequeos propios: seis `</script`, uno por etiqueta; cinco `<!--`, los de la plantilla; ningún `Ã` ni carácter de reemplazo (igual que el publicado); la única mención de `unpkg` es el comentario HTML de la plantilla. El único cambio de trabajo fue borrar la línea separadora duplicada del Bloque 4 del generador.

**Alcance:** `⊆`. Rutas fuera de git: las dos de T2, el encargo y el LOG; la salida está ignorada por `.gitignore:13`.

**Regresión:** el sustituto de PRUEBAS corrió una vez: `Rscript 30_procesamiento/33_generar_html.R`, código 0, última línea `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`.

**Subagentes:** sin subagentes, por contrato.

**Bugs:**
1. Del instrumento propio, no del repositorio. Síntoma: la extracción del bloque de ReactDOM dio `FALSE` en su propia calibración. Causa raíz: el ancla `@license React react-dom.production.min.js` suponía una sola línea, y el comentario de licencia la parte en dos. Arreglo: ancla ` * react-dom.production.min.js`. Verificación: calibración `TRUE TRUE`. Intento 2 de 3.

**Decisiones autónomas:**
1. Borrar la línea `# ====…` duplicada que la edición del redactor dejó bajo el título del Bloque 4 de `33_generar_html.R`. Es un defecto cosmético dentro del ALCANCE de T2, sin efecto sobre la ejecución. Alternativa descartada: dejarla y registrarla como ADVIERTE. Reversible, y queda sin commit junto con el resto de T2.
2. Tras congelar T2, medir en modo solo lectura los demás criterios de T2 y el 🔒 del payload, más un diagnóstico en R de las dos desviaciones, para que la duda llegue al titular con la evidencia completa. Alternativa descartada: detenerse en el primer desvío, lo que habría dejado sin medir el 🔒 que FASE R igual debía medir. Reversible: no se escribió en el árbol salvo la salida ignorada, que ya era del build.
3. No se commitea T2 ni se ajusta ningún criterio. Alternativa descartada: commitear declarando la desviación; el encargo prohíbe ajustar el esperado (FASE R, paso 9; v1.6 §7, "Corregir el criterio para que pase").

**Errores propios:**
1. El origen del `1` de `__REACT` (`grep -o '__REACT[A-Za-z_]*' … | uniq -c` sobre la salida y sobre ReactDOM) se midió primero una vez fuera del ayudante, sin pre-registro. Salida de esa corrida: `2 __REACT_DEVTOOLS_GLOBAL_HOOK__` en los dos archivos. Se repitió con esperado (arriba). Costo: una medición repetida.
2. Esperado mal derivado en el conteo `--numstat` (141 en vez de 140), corregido arriba en una línea nueva. Costo: ninguno.

**Dudas:**
1. Contexto: el criterio `grep -c -F '__REACT' <salida>` = 0 mide el archivo completo, pero su afirmación es que se reemplazaron los dos marcadores. Por eso cuenta la línea de ReactDOM que trae `__REACT_DEVTOOLS_GLOBAL_HOOK__` (2 apariciones, todas dentro del bloque inline de ReactDOM e idénticas a las del archivo verificado por sha384 en T1). Es el caso que la regla 12 recién commiteada describe. Evidencia: `grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__'` da `0` en la salida y `2` en la plantilla. Pregunta cerrada: ¿se acepta ese conteo de los dos marcadores exactos como criterio de "marcadores reemplazados" (sí/no)? Bloquea el commit de T2, T3 y el push.
2. Contexto: el 🔒 del payload compara el md5 del `atob("…")` comprimido. El generador escribe `meta.fecha_generacion = format(Sys.Date())` dentro del JSON, así que cualquier build de otro día que el publicado (2026-08-29) lo hace fallar. Diagnóstico en R: los dos JSON tienen 13597252 caracteres; al sustituir solo la fecha (una aparición en cada uno), la salida queda idéntica byte a byte al publicado (md5 `1691b8fcb8bebe781ecc084f0d3bde94`). Pregunta cerrada: ¿el 🔒 pasa a medirse sobre el JSON descomprimido con `fecha_generacion` igualada, o se hace determinista la fecha del build? Opciones: (a) reformular el 🔒; (b) cambiar el generador; (c) otra. Bloquea el commit de T2 y el push.

### FASE T3: render sin red

**Verificación:** ninguna. No se midió `chromote`: la tarea no arrancó.

**Estado:** no ejecutada (depende de T2, congelada).

**Commits:** ninguno.

**Cambios sustantivos:** ninguno.

**Alcance:** no tocó rutas.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:** ninguna.

**Errores propios:** ninguno.

**Dudas:** la hereda de T2. El render sin red queda, además, para el gate visual del titular.

### FASE R: auditoría y reparación

Panel adversarial (v1.6 §3.3): no aplicado, porque el contrato fija subagentes en 0. La re-derivación la hace el orquestador con comandos distintos de los que produjeron cada afirmación: R en vez de `grep`, `shasum` en vez de `openssl`, blobs de git en vez de archivos en disco, `jsonlite` en vez de sustitución de bytes.

**Inventario (anexado antes de auditar):**

- R-01 · FASE 0: `HEAD` = `origin/main` = `9908180` tras `git fetch`; el remoto no se movió durante la sesión.
- R-02 · FASE 0: el estado de partida era el conjunto esperado (tres ` M` y el encargo `??`).
- R-03 · FASE 0: `git stash list` vacío.
- R-04 · FASE 0: `docs/index.html` tiene tres `src="http`; la plantilla, cero.
- R-05 · FASE 0: la plantilla tiene `__REACT_INLINE__` y `__REACTDOM_INLINE__` una vez cada uno, y el ancla `text/babel` una vez.
- R-06 · FASE 0 y T1: `V8` y `openssl` no estaban instalados; ahora sí, en la librería renv del proyecto; `renv.lock` no cambió.
- R-07 · FASE 0: `33_generar_html.R` parsea.
- R-08 · T0: la regla 12 está en el documento de diseño, que pasa de 6 a 7 secciones `## `; el commit `2ab9927` trae solo ese archivo, con 40 inserciones y ningún borrado.
- R-09 · T1: los tres archivos vendorizados tienen el sha384 de su `sri`, tanto en disco como en el blob commiteado.
- R-10 · T1: el commit `65e5e4a` trae exactamente las tres rutas de T1.
- R-11 · T1: React y ReactDOM no contienen `</script` ni `<!--`.
- R-12 · T2: la salida tiene 0 `src="http`; `docs/index.html`, 3.
- R-13 · T2: la salida tiene 0 `text/babel`; `docs/index.html`, 1.
- R-14 · T2: `__REACT` aparece en 1 línea de la salida, con 2 apariciones de `__REACT_DEVTOOLS_GLOBAL_HOOK__` y ninguna de los marcadores exactos. Hallazgo de criterio (Duda 1 de T2).
- R-15 · T2: el bloque de la app se extrae con calibración, tiene 408 `React.createElement(` y ningún `_jsx(`, y es JavaScript válido.
- R-16 · T2: la guarda `validate` de V8 rechaza JSX y acepta JS (`FALSE TRUE`).
- R-17 · T2: seis `</script` en la salida y en la plantilla; cinco `<!--` en la salida; ningún `Ã` ni U+FFFD.
- R-18 · T2: tamaños de 2785497 bytes (salida) y 2624974 (publicado).
- R-19 · T2: el diff sin commit es de 140/1 en el generador y 8/14 en la plantilla; la única edición del ejecutor es la línea separadora borrada.
- R-20 · T2: los dos JSON descomprimidos solo difieren en `meta.fecha_generacion` (2026-09-23 contra 2026-08-29).
- R-21 · 🔒 1: `docs/index.html` no cambia.
- R-22 · 🔒 2: D3 y pako vendorizados no cambian.
- R-23 · 🔒 3: el payload del build nuevo es el del publicado (md5 del `atob("…")`). En FALLA en T2.
- R-24 · 🔒 4: ningún archivo con extensión de datos entra por este encargo.
- R-25 · 🔒 5: `andamios/` solo recibe el LOG.
- R-26 · Alcance global: `git diff --name-only 9908180..HEAD` ⊆ unión de los ALCANCE más el LOG.
- R-27 · Estado del árbol: `git status --porcelain` al cierre de FASE R.
- R-28 · Regresión: el sustituto de PRUEBAS sobre el estado final termina en OK y reproduce byte a byte la salida de T2 (mismo día).
- R-29 · Registro: cada `esperado:` del log tiene su `obtenido:`.
- R-30 · Control positivo de la auditoría: un `<script src="https://x">` plantado en una copia de la salida se cuenta (1), y un byte cambiado en una copia del payload cambia su md5.

**Re-derivación:**

Los instrumentos del scratchpad (`medir.sh`, `bloques_t2.R`, `payload_t2.R`, `auditoria_r.R`) se transcriben íntegros al final de esta sección.

`git ls-remote origin refs/heads/main | cut -f1; git rev-parse 9908180; git merge-base --is-ancestor origin/main HEAD; echo "ancestro: $?"`

esperado: R-01: el hash remoto de `main` igual al completo de `9908180` (el remoto no se movió), y `ancestro: 0`
obtenido:

```text
9908180a7153b953362af159b16704afa50406a8
9908180a7153b953362af159b16704afa50406a8
ancestro: 0
```

`instantánea de git status tomada por Claude Code al abrir la conversación, antes de cualquier comando (fuente distinta del comando de FASE 0)`

esperado: R-02: ` M` en las tres rutas de §2 y `??` en el encargo
obtenido: `M 30_procesamiento/33_generar_html.R`, ` M 30_procesamiento/33_motor_template.html`, ` M 50_documentacion/activa/50_diseno_ramas_deteccion.md`, `?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md` (la primera línea viene recortada en la instantánea; su espacio inicial no se ve)

`git rev-parse -q --verify refs/stash; echo "código: $?"`

esperado: R-03: sin hash, `código: 1` (no existe `refs/stash`)
obtenido: código: 1

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-04 2>&1 | grep -v out-of-sync`

esperado: R-04: `3` en el publicado y `0` en la plantilla
obtenido:

```text
lineas con src="http en publicado: 3 
lineas con src="http en plantilla: 0 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-05 2>&1 | grep -v out-of-sync`

esperado: R-05: `1 1 1`
obtenido: 1 1 1 

`Rscript -e 'cat(find.package(c("V8","openssl")), sep="\n")' 2>&1 | grep -v out-of-sync | sed 's|.*/renv/|renv/|'; git diff --quiet 9908180 -- renv.lock; echo "renv.lock sin cambios desde el retorno: $?"`

esperado: R-06: dos rutas bajo `renv/library/…`, y `0`
obtenido:

```text
renv/library/macos/R-4.5/aarch64-apple-darwin20/V8
renv/library/macos/R-4.5/aarch64-apple-darwin20/openssl
renv.lock sin cambios desde el retorno: 0
```

`Rscript -e 'cat(length(parse(file="30_procesamiento/33_generar_html.R")))' 2>&1 | grep -v out-of-sync`

esperado: R-07: un número de expresiones mayor que 0
obtenido: 105

`git show 2ab9927:50_documentacion/activa/50_diseno_ramas_deteccion.md | awk '/^## /{n++} END{print n+0}'; git show 2ab9927~1:50_documentacion/activa/50_diseno_ramas_deteccion.md | awk '/^## /{n++} END{print n+0}'; git show 2ab9927:50_documentacion/activa/50_diseno_ramas_deteccion.md | awk '/^12\. \*\*El alcance del instrumento/{n++} END{print n+0}'; git diff-tree --no-commit-id --numstat -r 2ab9927`

esperado: R-08: `7`, `6`, `1`, y una sola fila `40	0	50_documentacion/activa/50_diseno_ramas_deteccion.md`
obtenido:

```text
7
6
1
40	0	50_documentacion/activa/50_diseno_ramas_deteccion.md
```

`shasum -a 384 -b 10_utils/react.production.min.js | cut -d' ' -f1 | xxd -r -p | base64; git show 65e5e4a:10_utils/react.production.min.js | shasum -a 384 | cut -d' ' -f1 | xxd -r -p | base64`

esperado: R-09 (react.production.min.js): dos veces el `sri` de `VENDOR_JS` para esa ruta (disco y blob commiteado)
obtenido:

```text
DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z
DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z
```

`shasum -a 384 -b 10_utils/react-dom.production.min.js | cut -d' ' -f1 | xxd -r -p | base64; git show 65e5e4a:10_utils/react-dom.production.min.js | shasum -a 384 | cut -d' ' -f1 | xxd -r -p | base64`

esperado: R-09 (react-dom.production.min.js): dos veces el `sri` de `VENDOR_JS` para esa ruta (disco y blob commiteado)
obtenido:

```text
gTGxhz21lVGYNMcdJOyq01Edg0jhn/c22nsx0kyqP0TxaV5WVdsSH1fSDUf5YJj1
gTGxhz21lVGYNMcdJOyq01Edg0jhn/c22nsx0kyqP0TxaV5WVdsSH1fSDUf5YJj1
```

`shasum -a 384 -b 10_utils/babel.min.js | cut -d' ' -f1 | xxd -r -p | base64; git show 65e5e4a:10_utils/babel.min.js | shasum -a 384 | cut -d' ' -f1 | xxd -r -p | base64`

esperado: R-09 (babel.min.js): dos veces el `sri` de `VENDOR_JS` para esa ruta (disco y blob commiteado)
obtenido:

```text
m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y
m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y
```

`git diff-tree --no-commit-id --name-only -r 65e5e4a`

esperado: R-10: exactamente `10_utils/babel.min.js`, `10_utils/react-dom.production.min.js` y `10_utils/react.production.min.js`
obtenido:

```text
10_utils/babel.min.js
10_utils/react-dom.production.min.js
10_utils/react.production.min.js
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-11 2>&1 | grep -v out-of-sync`

esperado: R-11: `0` y `0` en los dos archivos
obtenido:

```text
react.production.min.js </script: 0 <!--: 0 
react-dom.production.min.js </script: 0 <!--: 0 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-12-13-14 2>&1 | grep -v out-of-sync`

esperado: R-12: `0 3`; R-13: `0 1`; R-14: `1` línea con `__REACT`, `2` apariciones del hook y `0` marcadores exactos
obtenido:

```text
src="http lineas salida/publicado: 0 3 
text/babel lineas salida/publicado: 0 1 
__REACT lineas salida: 1 
__REACT_DEVTOOLS_GLOBAL_HOOK__ apariciones salida: 2 
marcadores exactos salida: 0 
```

`awk '$0=="  <script>"{s=NR} $0=="  </script>"{e=NR} {a[NR]=$0} END{for(i=s+1;i<e;i++) print a[i]}' 40_salidas/motor_comparacion.html > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida.js; awk '$0=="  <script type=\"text/babel\" data-presets=\"env,react\">"{s=NR} $0=="  </script>"{e=NR} {a[NR]=$0} END{for(i=s+1;i<e;i++) print a[i]}' 30_procesamiento/33_motor_template.html > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_plantilla.jsx; wc -l < /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida.js | tr -d ' '; grep -c 'ReactDOM.createRoot' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida.js; grep -o 'React.createElement(' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida.js | wc -l | tr -d ' '; grep -c '_jsx(' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida.js; grep -c 'ReactDOM.createRoot' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_plantilla.jsx`

esperado: R-15, extracción por `awk` entre la última línea `  <script>` y la última `  </script>` (distinta del `strsplit` del encargo): líneas mayor que 0; calibración `1` (`ReactDOM.createRoot`); `408`; `0` (`_jsx(`); y la extracción del bloque JSX de la plantilla también contiene `ReactDOM.createRoot` (`1`)
obtenido:

```text
4204
1
408
0
1
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-15-validar /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida.js /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_plantilla.jsx 2>&1 | grep -v out-of-sync`

esperado: R-15: la app transpilada extraída de la salida es válida (`TRUE`) y el bloque JSX de la plantilla no lo es (`FALSE`, calibración)
obtenido: app transpilada valida: TRUE | app JSX de la plantilla valida (calibracion): FALSE 

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-16 2>&1 | grep -v out-of-sync`

esperado: R-16, otro par de casos: `FALSE TRUE`
obtenido: FALSE TRUE 

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-17 2>&1 | grep -v out-of-sync`

esperado: R-17: `6 6`; `5`; `0` y `0`
obtenido:

```text
</script salida/plantilla: 6 6 
<!-- salida: 5 
U+00C3 salida: 0 | U+FFFD salida: 0 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-18 2>&1 | grep -v out-of-sync`

esperado: R-18: `2785497 2624974`
obtenido: 2785497 2624974 

`git diff --shortstat HEAD -- 30_procesamiento/33_generar_html.R; git diff --shortstat HEAD -- 30_procesamiento/33_motor_template.html; git show HEAD:30_procesamiento/33_generar_html.R | awk '/^# =====/{n++} END{print n+0}'; awk '/^# =====/{n++} END{print n+0}' 30_procesamiento/33_generar_html.R; awk 'p ~ /^# =====/ && $0 ~ /^# =====/ && p==$0 {n++} {p=$0} END{print n+0}' 30_procesamiento/33_generar_html.R`

esperado: R-19: `140 insertions(+), 1 deletion(-)`; `8 insertions(+), 14 deletions(-)`; separadores en HEAD `N` y en el árbol `N+4` (dos del Bloque 0 y dos del Bloque 3b); `0` pares de separadores idénticos consecutivos
obtenido:

```text
 1 file changed, 140 insertions(+), 1 deletion(-)
 1 file changed, 8 insertions(+), 14 deletions(-)
10
14
0
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-20 2>&1 | grep -v out-of-sync`

esperado: R-20, por `jsonlite::fromJSON` y comparación de objetos (distinto de la sustitución de bytes): mismas claves de primer nivel; fechas `2026-09-23 2026-08-29`; solo `meta` difiere en primer nivel; solo `fecha_generacion` difiere en `meta`; `TRUE` sin esa clave
obtenido:

```text
claves de primer nivel iguales: TRUE 
fechas: 2026-09-23 2026-08-29 
claves de primer nivel que difieren: meta 
campos de meta que difieren: fecha_generacion 
identicos sin fecha_generacion: TRUE 
```

`printf '# =====\n# =====\n' | awk 'p ~ /^# =====/ && $0 ~ /^# =====/ && p==$0 {n++} {p=$0} END{print n+0}'`

esperado: R-19, control positivo del detector de separadores duplicados: `1` sobre un par plantado
obtenido: 1

Invariantes 🔒, cada uno con el comando del encargo y una segunda vía:

`md5 -q docs/index.html; git diff --quiet 9908180 -- docs/index.html; echo "sin cambios desde el retorno: $?"`

esperado: R-21 🔒 1: `c9747962e7f9cc8179de3a717f66f9af` y `0`
obtenido:

```text
c9747962e7f9cc8179de3a717f66f9af
sin cambios desde el retorno: 0
```

`git diff --quiet HEAD -- 10_utils/d3.min.js 10_utils/pako.min.js; echo "código: $?"; git diff --quiet 9908180 -- 10_utils/d3.min.js 10_utils/pako.min.js; echo "desde el retorno: $?"`

esperado: R-22 🔒 2: `código: 0` y `desde el retorno: 0`
obtenido:

```text
código: 0
desde el retorno: 0
```

`grep -o 'atob("[^"]*")' 40_salidas/motor_comparacion.html | md5; grep -o 'atob("[^"]*")' docs/index.html | md5; Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-23 2>&1 | grep -v out-of-sync`

esperado: R-23 🔒 3, según el encargo: dos md5 iguales. (T2 ya lo midió en FALLA; aquí se repite con el comando del encargo y en R sobre el base64 sin envoltura)
obtenido:

```text
88f3666b55de9c9be1a938a3e57d3c52
6a868d43d3a9691d1842b1e49c32a980
a5119018632d5a8cb644bea00bb3e843 7cfcde9f9c29ae271fb9662ec157bacf 
```

`git diff --name-only 9908180..HEAD | grep -Eic '\.(xlsx|xls|csv|tsv|parquet|rds|json)$'; git status --porcelain | grep -Eic '\.(xlsx|xls|csv|tsv|parquet|rds|json)$'`

esperado: R-24 🔒 4: `0` en lo commiteado y `0` en lo pendiente
obtenido: [código de salida 1]

```text
0
0
```

`git diff --name-only 9908180..HEAD -- 50_documentacion/andamios; echo "filas: $(git diff --name-only 9908180..HEAD -- 50_documentacion/andamios | wc -l | tr -d " ")"`

esperado: R-25 🔒 5: `filas: 0` en FASE R (el LOG entra recién en el commit de FASE L; vacío ⊆ {LOG}). Se repite tras ese commit (FASE L, reporte final)
obtenido: filas: 0

Alcance global y estado del árbol:

`git diff --name-only 9908180..HEAD`

esperado: R-26: `50_documentacion/activa/50_diseno_ramas_deteccion.md` (T0) y las tres rutas de `10_utils/` de T1; nada más
obtenido:

```text
10_utils/babel.min.js
10_utils/react-dom.production.min.js
10_utils/react.production.min.js
50_documentacion/activa/50_diseno_ramas_deteccion.md
```

`git status --porcelain`

esperado: R-27: ` M` en las dos rutas de T2 (congelada), `??` en el encargo y en el LOG; nada más
obtenido:

```text
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
?? 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

Regresión completa (paso 5):

`md5 -q 40_salidas/motor_comparacion.html > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/md5_salida_t2.txt; cat /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/md5_salida_t2.txt; Rscript 30_procesamiento/33_generar_html.R > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_faseR.txt 2>&1; echo "código Rscript: $?"; tail -n 1 /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_faseR.txt; md5 -q 40_salidas/motor_comparacion.html`

esperado: R-28: el md5 de la salida de T2; `código Rscript: 0`; última línea `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`; y el mismo md5 tras el build (build determinista dentro del mismo día)
obtenido:

```text
892929f4fa997bae71e66349b428d7ed
código Rscript: 0
33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
892929f4fa997bae71e66349b428d7ed
```

`echo "esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md) obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md)"`

esperado: R-29: el conteo de `esperado:` supera en 1 al de `obtenido:`, porque la línea `obtenido:` de esta misma medición se escribe después de contar
obtenido: esperado: 91 obtenido: 90

Control positivo de la auditoría (paso 6), sobre casos plantados fuera del árbol:

`d=$(mktemp -d) && sed 's|^</body>|<script src="https://x"></script>\n</body>|' 40_salidas/motor_comparacion.html > $d/plantado.html && grep -c 'src="http' $d/plantado.html && Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-30 $d/plantado.html 2>&1 | grep -v out-of-sync`

esperado: R-30 a: `1` con `grep` y `1` en R sobre la copia con un `<script src="https://x">` plantado (la salida real da `0`, R-12)
obtenido:

```text
1
lineas con src="http en la copia plantada: 1 
```

`d=$(mktemp -d) && grep -o 'atob("[^"]*")' docs/index.html > $d/p.txt && cp $d/p.txt $d/q.txt && md5 -q $d/p.txt && md5 -q $d/q.txt && sed -i '' 's/atob("H4sI/atob("H4sJ/; s/atob("eJ/atob("fJ/' $d/q.txt && cmp -s $d/p.txt $d/q.txt; echo "copias iguales tras plantar (0 = iguales): $?"; md5 -q $d/q.txt`

esperado: R-30 b: las dos primeras md5 iguales (copia intacta); `1` (la copia plantada difiere en un byte); y una tercera md5 distinta de las dos primeras
obtenido:

```text
6a868d43d3a9691d1842b1e49c32a980
6a868d43d3a9691d1842b1e49c32a980
copias iguales tras plantar (0 = iguales): 1
8e9c225a189615e1bac9f3c1c858966d
```

`printf '10_utils/a.js\n20_insumos/b.parquet\n' | grep -Eic '\.(xlsx|xls|csv|tsv|parquet|rds|json)$'; printf '50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md\n50_documentacion/andamios/x.R\n' | grep -v -x '50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md' | wc -l | tr -d ' '`

esperado: R-30 c: `1` (el patrón del 🔒 4 dispara sobre un `.parquet` plantado) y `1` (una ruta de `andamios/` distinta del LOG se detecta)
obtenido:

```text
1
1
```

**Tabla de auditoría:**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | HEAD = origin/main = 9908180 tras fetch | `git ls-remote origin refs/heads/main` + `merge-base --is-ancestor` | hash remoto = `9908180a…`; ancestro 0 | igual; 0 | ADVIERTE (el comando de FASE 0 del encargo no corre: `--short` implica `--verify`) | registrada (Duda 1 de FASE 0) | — | re-medido con dos vías en FASE 0 |
| R-02 | estado de partida = conjunto esperado | instantánea de `git status` del arranque de la sesión | 3 ` M` + encargo `??` | igual | — | — | — | — |
| R-03 | stash vacío | `git rev-parse -q --verify refs/stash` | código 1 | código 1 | — | — | — | — |
| R-04 | `src="http`: 3 en publicado, 0 en plantilla | R, `grepl` por línea | 3 / 0 | 3 / 0 | — | — | — | — |
| R-05 | marcadores y ancla una vez cada uno | R, `gregexpr` | 1 1 1 | 1 1 1 | — | — | — | — |
| R-06 | V8 y openssl instalados en renv; `renv.lock` intacto | `find.package` + `git diff --quiet 9908180 -- renv.lock` | rutas en renv; 0 | rutas en renv; 0 | ADVIERTE (renv `out-of-sync`: V8 y openssl sin registrar; previo y fuera de alcance) | registrada (Duda 2 de FASE 0) | — | — |
| R-07 | el generador parsea | `length(parse(file=…))` | > 0 | 105 | — | — | — | — |
| R-08 | regla 12; 6 → 7 secciones; commit de 1 archivo 40/0 | `git show` + `awk` + `diff-tree --numstat` | 7, 6, 1, `40 0` | 7, 6, 1, `40 0` | — | — | `2ab9927` | — |
| R-09 | sha384 = sri, en disco y en blob | `shasum -a 384 \| xxd -r -p \| base64` | 3 × 2 sri | 3 × 2 sri | — | — | `65e5e4a` | — |
| R-10 | commit T1 = 3 rutas de T1 | `git diff-tree --name-only` | 3 rutas | 3 rutas | — | — | `65e5e4a` | — |
| R-11 | React/ReactDOM sin `</script` ni `<!--` | R, `tolower` + `gregexpr` | 0 0 / 0 0 | 0 0 / 0 0 | — | — | — | — |
| R-12 | `src="http`: 0 salida, 3 publicado | R por línea | 0 3 | 0 3 | — | — | — | control plantado R-30 a |
| R-13 | `text/babel`: 0 salida, 1 publicado | R por línea | 0 1 | 0 1 | — | — | — | — |
| R-14 | criterio `__REACT` = 0 en la salida | R por línea + apariciones del hook + marcadores exactos | 1 / 2 / 0 (lo medido en T2) | 1 / 2 / 0 | **BLOQUEA** (gobernanza: el criterio del encargo mide el archivo cuando la afirmación es de dos marcadores y no se calibró sobre el caso bueno; repararlo sería ajustar el criterio) | T2 congelada; Duda 1 de T2 | — | origen confirmado por bloque (ReactDOM) en T2 |
| R-15 | app: extracción calibrada, 408 `createElement`, sin `_jsx`, JS válido | `awk` entre anclas + `grep -o` + `V8::validate` | 1, 408, 0; `TRUE`; plantilla `FALSE` | 1, 408, 0; `TRUE`; `FALSE` | — | — | — | — |
| R-16 | guarda `validate` rechaza JSX y acepta JS | otro par de casos | `FALSE TRUE` | `FALSE TRUE` | — | — | — | — |
| R-17 | 6 `</script`; 5 `<!--`; sin mojibake | R, `gregexpr` | 6 6; 5; 0 0 | 6 6; 5; 0 0 | — | — | — | — |
| R-18 | tamaños | `file.size` | 2785497 2624974 | 2785497 2624974 | — | — | — | — |
| R-19 | diff T2 140/1 y 8/14; única edición propia = separador | `--shortstat` + conteo de separadores + detector de duplicados | 140/1; 8/14; N y N+4; 0 | 140/1; 8/14; 10 y 14; 0 | — | — | — | detector calibrado (1 sobre par plantado) |
| R-20 | JSON solo difiere en `meta.fecha_generacion` | `jsonlite::fromJSON` + `identical` por clave | solo `meta` → `fecha_generacion`; `TRUE` | igual | — (evidencia de R-23) | — | — | sustitución de bytes en T2 (`payload_t2.R`) |
| R-21 | 🔒 1 `docs/index.html` intacto | `md5 -q` + `git diff --quiet 9908180` | `c9747962…`; 0 | `c9747962…`; 0 | — (PASA) | — | — | — |
| R-22 | 🔒 2 D3 y pako intactos | `git diff --quiet` contra HEAD y contra 9908180 | 0; 0 | 0; 0 | — (PASA) | — | — | — |
| R-23 | 🔒 3 payload = publicado | comando del encargo + `openssl::md5` del base64 en R | md5 iguales | `88f3666b…` ≠ `6a868d43…`; `a5119018…` ≠ `7cfcde9f…` | **BLOQUEA** (🔒 en FALLA; datos no alterados según R-20: la diferencia es `fecha_generacion`) | T2 congelada; Duda 2 de T2 | — | control plantado R-30 b |
| R-24 | 🔒 4 sin archivos de datos | comando del encargo + `git status` | 0; 0 | 0; 0 | — (PASA) | — | — | control plantado R-30 c |
| R-25 | 🔒 5 `andamios/` solo recibe el LOG | comando del encargo | 0 filas en FASE R | 0 filas | — (PASA a esta altura) | se repite tras el commit de FASE L | — | control plantado R-30 c |
| R-26 | alcance global ⊆ unión de ALCANCE + LOG | `git diff --name-only 9908180..HEAD` | diseño + 3 de `10_utils/` | igual | — | — | — | — |
| R-27 | árbol al cierre de FASE R | `git status --porcelain` | 2 ` M` de T2 + 2 `??` | igual | ADVIERTE (lo no commiteado es consecuencia de R-14 y R-23; no se limpia) | registrada | — | — |
| R-28 | regresión: build OK y determinista | re-correr el build + md5 antes/después | OK; md5 igual | OK; `892929f4…` = `892929f4…` | — | — | — | — |
| R-29 | cada `esperado:` tiene su `obtenido:` | `grep -c` de los dos rótulos | esperado = obtenido + 1 (la medición en curso) | 91 / 90 | — | — | — | se repite en FASE L |
| R-30 | la auditoría dispara | casos plantados en `mktemp -d` | 1/1; md5 distinta; 1; 1 | 1/1; distinta; 1; 1 | — | — | — | — |

**Hallazgos por severidad:** BLOQUEA 2 (R-14, R-23); REPARA 0; ADVIERTE 3 (R-01, R-06, R-27). Ciclos de reparación: 0, porque no hubo REPARA y los BLOQUEA no se reparan. Ningún BLOQUEA compromete el repositorio completo (T0 y T1 están verificados, y ningún 🔒 sobre archivos versionados falla), así que la sesión no se detiene: pasa a FASE L.

**Veredicto global: `BLOQUEADO`.**

**Estado:** completada.

**Commits:** ninguno.

**Cambios sustantivos:** ninguno en el árbol. La regresión re-escribió la salida ignorada con los mismos bytes.

**Alcance:** `⊆` (R-26); los únicos archivos escritos fuera del scratchpad y de `mktemp -d` fueron el LOG y la salida ignorada.

**Regresión:** R-28, código 0, salida idéntica.

**Subagentes:** sin subagentes, por contrato; sin panel adversarial por la misma razón.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. R-02 se re-derivó desde la instantánea de `git status` que Claude Code toma al abrir la conversación, porque el estado de partida ya no se puede volver a medir. Alternativa descartada: declararla no re-derivable. Reversible.
2. R-25 se mide antes del commit del LOG (0 filas) y se repite después del commit de FASE L; esa segunda medición va al reporte final, porque el archivo no puede registrar su propio commit. Reversible.

**Errores propios:** ninguno en esta fase.

**Dudas:** las dos de T2 (R-14, R-23), sin cambios.

**Instrumentos del scratchpad, transcritos íntegros** (viven fuera del árbol y no se versionan; se copian aquí para que el revisor pueda reproducir cada medición):

`medir.sh`:

````bash
# Ayudante de verificación del encargo retiro_cdn_v8.
# Uso: source medir.sh; medir "<comando>" "<esperado>"
# Escribe en $LOG el comando y la línea `esperado:` ANTES de correrlo, y luego
# la línea `obtenido:` con la salida literal (stdout+stderr) y el código de salida
# cuando no es 0. El comando corre con bash explícito desde la raíz del repo.
RAIZ=/Users/tomgc/Projects/slep_simce_adecuado
: "${LOG:=$RAIZ/50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md}"
medir() {
  local cmd="$1" esp="$2" out rc n
  printf '\n`%s`\n\nesperado: %s\n' "$cmd" "$esp" >> "$LOG"
  out=$(cd "$RAIZ" && bash -c "$cmd" 2>&1); rc=$?
  n=$(printf '%s' "$out" | awk 'END{print NR}')
  local sufijo=""
  [ "$rc" -ne 0 ] && sufijo=" [código de salida $rc]"
  if [ -z "$out" ]; then
    printf 'obtenido: (sin salida)%s\n' "$sufijo" >> "$LOG"
  elif [ "$n" -le 1 ]; then
    printf 'obtenido: %s%s\n' "$out" "$sufijo" >> "$LOG"
  else
    printf 'obtenido:%s\n\n```text\n%s\n```\n' "$sufijo" "$out" >> "$LOG"
  fi
  printf '$ %s\n%s\n[rc=%s]\n\n' "$cmd" "$out" "$rc"
}
````

`bloques_t2.R`:

````r
# Evidencia de T2 por bloque (universo = bloque extraído por anclas, regla 12).
# Uso: Rscript bloques_t2.R <salida.html>
args <- commandArgs(trailingOnly = TRUE)
s <- args[1]
lineas <- readLines(s, warn = FALSE, encoding = "UTF-8")
x <- paste(lineas, collapse = "\n")
# Validez de lectura: tantos caracteres \n como líneas leídas menos una.
stopifnot(lengths(gregexpr("\n", x, fixed = TRUE)) == length(lineas) - 1L)
# Bloque ReactDOM: desde su comentario de licencia hasta el siguiente </script>.
ini <- regexpr(" * react-dom.production.min.js", x, fixed = TRUE)
resto <- substr(x, ini, nchar(x))
fin <- regexpr("</script>", resto, fixed = TRUE)
rd <- substr(resto, 1L, fin - 1L)
cat("reactdom_extraido_no_vacio:", ini > 0 && nchar(rd) > 0, "\n")
cat("reactdom_contiene_createRoot:", grepl("createRoot", rd, fixed = TRUE), "\n")
cat("hook_en_bloque_reactdom:", lengths(regmatches(rd, gregexpr("__REACT_DEVTOOLS_GLOBAL_HOOK__", rd, fixed = TRUE))), "\n")
cat("hook_en_archivo:", lengths(regmatches(x, gregexpr("__REACT_DEVTOOLS_GLOBAL_HOOK__", x, fixed = TRUE))), "\n")
````

`payload_t2.R`:

````r
# Diagnóstico de solo lectura del 🔒 del payload: descomprime el segmento
# atob("…") de dos HTML y compara los JSON. No imprime filas de datos: solo
# hashes, tamaños, conteos y el valor de meta.fecha_generacion.
# Uso: Rscript payload_t2.R <html_a> <html_b>
args <- commandArgs(trailingOnly = TRUE)
leer_payload <- function(ruta) {
  lineas <- readLines(ruta, warn = FALSE, encoding = "UTF-8")
  x <- paste(lineas, collapse = "\n")
  m <- regmatches(x, gregexpr('atob\\("[^"]*"\\)', x))[[1]]
  stopifnot(length(m) == 1L)
  b64 <- substr(m, 7L, nchar(m) - 2L)
  js <- rawToChar(memDecompress(jsonlite::base64_dec(b64), type = "gzip"))
  Encoding(js) <- "UTF-8"
  list(b64 = b64, json = js)
}
a <- leer_payload(args[1])
b <- leer_payload(args[2])
cat("b64 caracteres a/b:", nchar(a$b64), nchar(b$b64), "\n")
cat("json caracteres a/b:", nchar(a$json), nchar(b$json), "\n")
cat("json md5 a/b:", as.character(openssl::md5(a$json)), as.character(openssl::md5(b$json)), "\n")
patron <- '"fecha_generacion":"[^"]*"'
fa <- regmatches(a$json, gregexpr(patron, a$json))[[1]]
fb <- regmatches(b$json, gregexpr(patron, b$json))[[1]]
cat("fecha_generacion a:", fa, "| apariciones:", length(fa), "\n")
cat("fecha_generacion b:", fb, "| apariciones:", length(fb), "\n")
# Sustituye en a la fecha de a por la de b y compara byte a byte con b.
a_sust <- sub(fa, fb, a$json, fixed = TRUE)
cat("json md5 a con la fecha de b:", as.character(openssl::md5(a_sust)), "\n")
cat("identico a b tras sustituir solo la fecha:", identical(a_sust, b$json), "\n")
````

`auditoria_r.R`:

````r
# Re-derivaciones en R para FASE R del encargo retiro_cdn_v8 (solo lectura).
# Uso: Rscript auditoria_r.R <id>   (desde la raíz del repositorio)
# No imprime filas de datos: solo conteos, tamaños, hashes y booleanos.
id <- commandArgs(trailingOnly = TRUE)[1]
SAL <- "40_salidas/motor_comparacion.html"
PUB <- "docs/index.html"
PLA <- "30_procesamiento/33_motor_template.html"

leer <- function(ruta) {
  l <- readLines(ruta, warn = FALSE, encoding = "UTF-8")
  x <- paste(l, collapse = "\n")
  # Validez de lectura: una marca de fin de línea menos que líneas leídas.
  stopifnot(lengths(gregexpr("\n", x, fixed = TRUE)) == length(l) - 1L)
  list(l = l, x = x)
}
lineas_con <- function(l, p) sum(grepl(p, l, fixed = TRUE))
apariciones <- function(x, p) {
  m <- gregexpr(p, x, fixed = TRUE)[[1]]
  if (m[1] < 0) 0L else length(m)
}

if (id == "R-04") {
  cat("lineas con src=\"http en publicado:", lineas_con(leer(PUB)$l, 'src="http'), "\n")
  cat("lineas con src=\"http en plantilla:", lineas_con(leer(PLA)$l, 'src="http'), "\n")
}
if (id == "R-05") {
  x <- leer(PLA)$x
  cat(apariciones(x, "__REACT_INLINE__"), apariciones(x, "__REACTDOM_INLINE__"),
      apariciones(x, '<script type="text/babel" data-presets="env,react">'), "\n")
}
if (id == "R-11") {
  for (f in c("10_utils/react.production.min.js", "10_utils/react-dom.production.min.js")) {
    x <- tolower(leer(f)$x)
    cat(basename(f), "</script:", apariciones(x, "</script"), "<!--:", apariciones(x, "<!--"), "\n")
  }
}
if (id == "R-12-13-14") {
  s <- leer(SAL); p <- leer(PUB)
  cat("src=\"http lineas salida/publicado:", lineas_con(s$l, 'src="http'), lineas_con(p$l, 'src="http'), "\n")
  cat("text/babel lineas salida/publicado:", lineas_con(s$l, "text/babel"), lineas_con(p$l, "text/babel"), "\n")
  cat("__REACT lineas salida:", lineas_con(s$l, "__REACT"), "\n")
  cat("__REACT_DEVTOOLS_GLOBAL_HOOK__ apariciones salida:", apariciones(s$x, "__REACT_DEVTOOLS_GLOBAL_HOOK__"), "\n")
  cat("marcadores exactos salida:", apariciones(s$x, "__REACT_INLINE__") + apariciones(s$x, "__REACTDOM_INLINE__"), "\n")
}
if (id == "R-15-validar") {
  ctx <- V8::v8()
  js  <- paste(readLines(commandArgs(trailingOnly = TRUE)[2], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  jsx <- paste(readLines(commandArgs(trailingOnly = TRUE)[3], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  cat("app transpilada valida:", ctx$validate(js), "| app JSX de la plantilla valida (calibracion):", ctx$validate(jsx), "\n")
}
if (id == "R-16") {
  ctx <- V8::v8()
  cat(ctx$validate("var x = <App />;"), ctx$validate("var x = function () { return 1; };"), "\n")
}
if (id == "R-17") {
  s <- leer(SAL); t <- leer(PLA)
  cat("</script salida/plantilla:", apariciones(s$x, "</script"), apariciones(t$x, "</script"), "\n")
  cat("<!-- salida:", apariciones(s$x, "<!--"), "\n")
  cat("U+00C3 salida:", apariciones(s$x, "Ã"), "| U+FFFD salida:", apariciones(s$x, "�"), "\n")
}
if (id == "R-18") {
  cat(file.size(SAL), file.size(PUB), "\n")
}
if (id == "R-20") {
  payload_json <- function(ruta) {
    x <- leer(ruta)$x
    m <- regmatches(x, gregexpr('atob\\("[^"]*"\\)', x))[[1]]
    stopifnot(length(m) == 1L)
    js <- rawToChar(memDecompress(jsonlite::base64_dec(substr(m, 7L, nchar(m) - 2L)), type = "gzip"))
    Encoding(js) <- "UTF-8"
    jsonlite::fromJSON(js)
  }
  a <- payload_json(SAL); b <- payload_json(PUB)
  cat("claves de primer nivel iguales:", identical(names(a), names(b)), "\n")
  cat("fechas:", a$meta$fecha_generacion, b$meta$fecha_generacion, "\n")
  difieren <- names(a)[!vapply(names(a), function(k) identical(a[[k]], b[[k]]), logical(1))]
  cat("claves de primer nivel que difieren:", if (length(difieren)) difieren else "ninguna", "\n")
  dm <- names(a$meta)[!vapply(names(a$meta), function(k) identical(a$meta[[k]], b$meta[[k]]), logical(1))]
  cat("campos de meta que difieren:", if (length(dm)) dm else "ninguno", "\n")
  a$meta$fecha_generacion <- NULL; b$meta$fecha_generacion <- NULL
  cat("identicos sin fecha_generacion:", identical(a, b), "\n")
}
if (id == "R-23") {
  b64 <- function(ruta) {
    x <- leer(ruta)$x
    m <- regmatches(x, gregexpr('atob\\("[^"]*"\\)', x))[[1]]
    stopifnot(length(m) == 1L)
    substr(m, 7L, nchar(m) - 2L)
  }
  cat(as.character(openssl::md5(b64(SAL))), as.character(openssl::md5(b64(PUB))), "\n")
}
if (id == "R-30") {
  copia <- commandArgs(trailingOnly = TRUE)[2]
  cat("lineas con src=\"http en la copia plantada:", lineas_con(leer(copia)$l, 'src="http'), "\n")
}
````

### FASE L: cierre del log

**Verificación:**

`git status --porcelain`

esperado: según el encargo, vacío o solo el LOG. Con T2 congelada se prevé además ` M` en sus dos rutas y `??` en el encargo; eso se anota como hallazgo y no se limpia
obtenido:

```text
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md
?? 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

Medición complementaria, no inventariada ni auditada en FASE R: se agrega para las notas del revisor. Compara el transpilado del build con el que Babel standalone producía en el navegador (presets del atributo, plugins por defecto de `transformScriptTags`, `sourceType` por defecto `module`), sobre la extracción `awk` del bloque JSX de la plantilla (R-15):

`d=$(mktemp -d) && Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/equivalencia_babel.R /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_plantilla.jsx $d 2>&1 | grep -v out-of-sync && diff $d/build.js $d/navegador.js | head -n 20; echo "líneas de diff: $(diff $d/build.js $d/navegador.js | grep -c '^[<>]')"`

esperado: desconocido. Si el `sourceType` no altera nada, `identicos: TRUE`; si difiere, el diff muestra dónde (se anota sin juzgar)
obtenido:

```text
[1] "true"
caracteres build/navegador: 175217 175217 
identicos: TRUE 
líneas de diff: 0
```

`git log 9908180..HEAD --oneline`

esperado: dos commits: `2ab9927` (T0) y `65e5e4a` (T1); el `docs(log)` todavía no existe
obtenido:

```text
65e5e4a chore(vendor): React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 en 10_utils (s31)
2ab9927 docs(diseno): regla 12 y A29-4, el alcance del instrumento iguala el de la afirmación
```

**Estado:** completada. Estos rótulos se anexan antes de las verificaciones finales del archivo (privacidad y conteos), para que esas verificaciones cubran el log entero; por eso aquí la verificación no va toda primero.

**Commits:** `docs(log): retiro de unpkg.com con transpilación en el build`, con el LOG y el encargo. El hash va en el reporte final.

**Cambios sustantivos:** cierre C.1 a C.10 y bloque J rellenos (el bloque J es la única edición sobre texto ya escrito). Medición complementaria de equivalencia entre el transpilado del build y el del navegador: idénticos.

**Alcance:** el commit de esta fase trae solo el LOG y el encargo, las dos rutas de "Todas" del ALCANCE.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Sin push. La autorización 4 exige `git status --porcelain` vacío, y las dos rutas de T2 congelada quedan ` M`. Alternativa descartada: ninguna legal (el encargo prohíbe `restore`, `reset` y `checkout --`). Reversible.
2. Se agregó la medición complementaria de equivalencia Babel build/navegador, rotulada como no auditada. Alternativa descartada: dejarlo solo como nota sin medir. Reversible (solo lectura).

**Errores propios:** ninguno en esta fase.

**Dudas:** ninguna nueva; las consolidadas están en C.7.

Verificaciones finales del archivo:

`grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md`

esperado: vacío
obtenido: (sin salida) [código de salida 1]

`grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' <(printf 'plantado <RUT ficticio con puntos y guion, sustituido>\n')`

esperado: control positivo del patrón de privacidad: una línea con el RUT plantado (ficticio)
obtenido: 1:plantado <RUT ficticio con puntos y guion, sustituido> (una línea; el valor literal se sustituyó antes del commit, v1.6 §2.8.4; ver C.10)

`ls -l 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md | awk '{print $1, $5, $NF}' && wc -l 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md`

esperado: el archivo existe; se anotan su tamaño y sus líneas
obtenido:

```text
-rw-r--r-- 84806 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
    1507 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

`echo "secciones FASE: $(grep -c '^### FASE' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md); J: $(grep -c '^## J' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md); esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md); obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md)"`

esperado: `secciones FASE: 7` (seis fases ejecutadas, contando T2 congelada, FASE R y FASE L, más la sección de T3 no ejecutada que pide v1.6 §4.1); `J: 1`; `esperado` supera en 1 a `obtenido` (la línea `obtenido:` de esta medición se escribe después de contar)
obtenido: secciones FASE: 7; J: 1; esperado: 101; obtenido: 100

Corrección a los rótulos de esta sección (cita "**Errores propios:** ninguno en esta fase"): hubo un error propio en FASE L, el RUT ficticio del control de privacidad que entró al log. Está registrado en C.8 (error 4), la sustitución se declara en C.10 y el grep de privacidad se repite abajo.

`grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md; echo "líneas con patrón de RUT: $(grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md)"`

esperado: `líneas con patrón de RUT: 0` (repetición tras la sustitución)
obtenido: líneas con patrón de RUT: 0

`ls -l 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md | awk '{print $1, $5, $NF}' && wc -l 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md`

esperado: el archivo existe; se anotan su tamaño y sus líneas finales antes del commit
obtenido:

```text
-rw-r--r-- 87520 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
    1531 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md
```

`echo "secciones FASE: $(grep -c '^### FASE' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md); J: $(grep -c '^## J' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md); esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md); obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md)"`

esperado: `secciones FASE: 7`; `J: 1`; `esperado` supera en 1 a `obtenido` (la línea `obtenido:` de esta medición se escribe después de contar; tras escribirla quedan iguales)
obtenido: secciones FASE: 7; J: 1; esperado: 104; obtenido: 103
