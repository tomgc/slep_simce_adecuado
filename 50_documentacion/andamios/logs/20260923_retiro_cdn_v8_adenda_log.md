# Log — Adenda al retiro de `unpkg.com`: respuestas a D1-D3 y cierre de T2

- **Meta:** la del encargo (el motor publicado no carga nada por red y el titular sigue editando la app como JSX dentro de la plantilla), cerrando T2 con D1 y D2 ya respondidas, más T3 y la publicación de la cadena.
- **Fecha:** 2026-09-23 (sesión 31).
- **Adenda:** `50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md` (formato v1.6, modo reducido). Encargo base: `50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md`; su log (`20260923_retiro_cdn_v8_log.md`) está commiteado en `bb53c8c` y congelado, y esta adenda no lo toca.
- **Repo y rama:** `slep_simce_adecuado`, `main` (`git rev-parse --abbrev-ref HEAD` → `main`).
- **PUNTO DE RETORNO:** `bb53c8c` (`git rev-parse --short HEAD`, leído al abrir FASE 0; se mide abajo).
- **ENTORNO:** el del encargo. Claude Code en la estación macOS del titular (`MacBook-Pro-de-Tomas.local`), raíz `/Users/tomgc/Projects/slep_simce_adecuado`; `bash` explícito; `Rscript` (R 4.5.2, renv activado por `.Rprofile`).
- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión (Opus 5.5, `claude-opus-5-5[1m]`); subagentes 0.
- **Modo real de la sesión:** `ultracode`; subagentes usados: 0, por contrato (v1.6 §2.12 regla 1). No se usa la herramienta de workflows.
- **Grafo:** FASE 0 → T2 (cierre) → T3 (requiere T2) → FASE R → FASE L. FASE R y FASE L corren aunque una tarea quede congelada.
- **Concurrencia:** sin subagentes.
- **Topes:** los del encargo. 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.
- **Criterios que cambian respecto del encargo (respuestas del redactor):** D1 → marcadores con `grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__'` (esperado 0 en la salida y 2 en la plantilla). D2 (a) → el 🔒 3 pasa a `identical()` en R entre los JSON descomprimidos de la salida y de `docs/index.html`, los dos sin `meta.fecha_generacion` (esperado `TRUE`; calibración con un valor numérico alterado en una copia, esperado `FALSE`). D3 → no.
- **Método de registro:** el del encargo. Un ayudante de shell del scratchpad (`medir_adenda.sh`, igual a `medir.sh` salvo la ruta del LOG) anexa el comando y `esperado:` antes de correrlo, y `obtenido:` con la salida literal después. Los instrumentos nuevos se transcriben al final de FASE R.

---

## J. Juicio
- Meta y resultado: cerrar T2 con D1 y D2 respondidas y publicar la cadena → cumplida en el repositorio (build sin red commiteado, con los cinco 🔒 en PASA); el despliegue a `docs/` queda fuera por diseño (gate visual) y el resultado del push va en el reporte final.
- Estado por tarea: T2 completada (`02daaf7`) · T3 no ejecutada (sin `chromote`, no se instala).
- Commits: 2 de la adenda (`02daaf7` y el `docs(log)`, cuyo hash va en el reporte final); la cadena desde `9908180` suma 5; 0 fix(auditoria).
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/2; reparados 0; abiertos 0 (ADVIERTE registrados: R-04, R-16).
- Invariantes: 5/5 PASA (🔒 3 en su forma de D2; 🔒 5 con el esperado conciliado con el ALCANCE, Decisión 2 de FASE 0); FALLA: ninguno.
- Cifras críticas: intactas (`docs/index.html` md5 `c9747962e7f9cc8179de3a717f66f9af`; JSON de la salida sin `fecha_generacion` `identical()` al publicado; salida md5 `892929f4fa997bae71e66349b428d7ed`, reproducida).
- Decisiones autónomas de mayor riesgo: aplicar el ALCANCE (commitear el registro de errores en `andamios/`) sobre la letra del 🔒 5 (descartada: no commitearlo y dejar la cadena sin push); dos calibraciones propias del 🔒 3 sobre datos (descartada: solo la literal, que cayó en `meta$anios`); LOG en el scratchpad hasta medir el árbol (descartada: restarlo a mano).
- Desviaciones respecto de la adenda: esperado del 🔒 5 conciliado con el ALCANCE; mediciones extra en FASE 0 (fetch, stash, numstat, paquetes) y en T2 (dos calibraciones).
- Dudas abiertas: 1; ¿el 🔒 5 de la adenda admite el registro de errores que su ALCANCE nombra? (sí/no).
- Errores propios: 0 registrados.
- Qué debe verificar el revisor por sí mismo: el render sin red (T3 no corrió): abrir `40_salidas/motor_comparacion.html` con la red desactivada y recorrer la comparación, el panorama y las tres exportaciones.
- No publicado / queda al usuario: el push de la autorización 4 corre tras este commit (resultado en el reporte final); despliegue a `docs/` tras el gate visual.
- Ejecución: modo de sesión ultracode; subagentes 0, por contrato.

---

## Cierre (lo rellena FASE L)

### C.1 Resumen de la sesión

Entraron FASE 0, T2 (cierre), T3, FASE R y FASE L: cinco secciones por fase. T2 completada. El build corre al primer intento, reproduce la salida del encargo y pasa todos los criterios con D1 y D2 reemplazados; los cinco 🔒 pasan. Se commiteó en `02daaf7`, que incluye la línea separadora borrada por el ejecutor en el encargo (aceptada, ERR-31-05). T3 no ejecutada por falta de `chromote`. FASE R: `APROBADO CON ADVERTENCIAS`. FASE L commitea este LOG, la adenda y el registro de errores del redactor, y el push corre si el árbol queda limpio.

### C.2 Inventario de commits

Derivado de `git log bb53c8c..HEAD --oneline` y `git log 9908180..HEAD --oneline` (FASE L, antes del commit del LOG):

- `02daaf7` feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31) · FASE T2 de la adenda.
- `docs(log)`: cierre de T2 del retiro de unpkg.com · FASE L de la adenda (hash en el reporte final).
- Del encargo, ya commiteados, suben en el mismo push: `bb53c8c` docs(log), `65e5e4a` chore(vendor), `2ab9927` docs(diseno).

Ningún `fix(auditoria)`.

### C.3 Tabla de auditoría (FASE R)

Está completa en la sección `FASE R: auditoría y reparación` (R-01 a R-22). Veredicto `APROBADO CON ADVERTENCIAS`. Hallazgos: BLOQUEA 0; REPARA 0; ADVIERTE 2 (R-04, render sin red no medido por falta de `chromote`; R-16, 🔒 5 heredado contra el ALCANCE de la adenda). Control positivo: R-22 (tres casos plantados, los tres disparan) más las tres calibraciones del 🔒 3 en T2.

### C.4 Verificación de invariantes

- 🔒 1 `docs/index.html` no cambia: **PASA** (`c9747962e7f9cc8179de3a717f66f9af`; sin diff desde `9908180`).
- 🔒 2 D3 y pako no cambian: **PASA** (`git diff --quiet HEAD` = 0; blobs iguales a los de `9908180`).
- 🔒 3 (reformulado por D2 a) JSON sin `meta.fecha_generacion` idéntico al publicado: **PASA** (`identical()` = `TRUE`). Las calibraciones dan `FALSE` sobre `meta$anios`, `datos$rows` y `simce_rbd$anio`, y la sustitución de bytes da el mismo resultado.
- 🔒 4 ningún archivo de datos: **PASA** (0 de 2 rutas; el instrumento dispara sobre un `.json` plantado).
- 🔒 5 `andamios/` solo recibe el LOG y el registro que nombra el ALCANCE: **PASA** en FASE R (0 rutas antes del commit del LOG); tras el commit de FASE L se espera exactamente esas dos rutas, medido en el reporte final. La conciliación con la letra del 🔒 queda como Duda 1.

### C.5 Decisiones del usuario registradas

Respuestas del redactor, en la adenda, a las dudas del encargo:

- D1: sí. El criterio de marcadores pasa a los dos marcadores exactos.
- D2: (a). El 🔒 3 se reformula sobre el JSON descomprimido sin `fecha_generacion`, y se descarta cambiar el generador.
- D3: no. El comando defectuoso era del encargo (ERR-31-04), no de la plantilla v1.6.
- La línea separadora borrada queda aceptada (ERR-31-05).

### C.6 Estado de cifras críticas

- `docs/index.html`: md5 `c9747962e7f9cc8179de3a717f66f9af`; 2624974 bytes. Sin cambios.
- Salida: md5 `892929f4fa997bae71e66349b428d7ed`; 2785497 bytes. Idéntica en el build de T2 y en la regresión de FASE R, e idéntica a la del encargo.
- JSON: sin `fecha_generacion`, `identical()` al publicado. Con la fecha igualada por sustitución de bytes, md5 `1691b8fcb8bebe781ecc084f0d3bde94` en los dos.

### C.7 Dudas y pendientes consolidados

1. **Duda 1 (FASE 0, R-16, ADVIERTE).** Contexto: el 🔒 5 heredado admite solo el LOG en `andamios/`, y la adenda ordena commitear también `50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`. Pregunta cerrada: ¿el 🔒 5 de la adenda admite el registro de errores que su ALCANCE nombra (sí/no)? No bloquea: se aplicó "sí".
2. **Pendiente (R-04):** el render sin red; es el gate visual del titular.
3. **Pendientes del encargo que siguen abiertos:** D4 (renv `out-of-sync`: `V8` y `openssl` sin registrar en `renv.lock`, bloqueado por `suitedoc`); despliegue a `docs/`; desborde bajo 540px y `xmlns` (sesión 33); traslado de la vista de trayectorias (sesión 32).

### C.8 Errores propios consolidados

Ninguno en esta adenda.

### C.9 Notas para el revisor

- El 🔒 3 reformulado pasa de verdad: las tres calibraciones disparan, incluida una sobre la columna más larga del JSON (140345 elementos). La primera calibración literal cayó en un metadato (`meta$anios`).
- El 🔒 5 se midió con su comando literal, pero su esperado se concilió con el ALCANCE (Duda 1). Un "no" del titular se corrige con un `git revert` del registro, sin tocar el resto.
- La salida no cambia entre el encargo y la adenda (mismo md5): el commit `02daaf7` es exactamente lo que se construyó y midió (`git diff --quiet HEAD` = 0 sobre las dos rutas).
- T3 sigue sin correr: nada en esta cadena ejecutó la página en un navegador. La equivalencia del transpilado con el del navegador (log del encargo, FASE L) es evidencia indirecta; el gate visual es la prueba.

### C.10 Estado de cierre

- Commiteado: `02daaf7` (T2) y el `docs(log)` con este LOG, la adenda y el registro de errores (hash en el reporte final).
- Publicación: `git push origin main` según la autorización 4 del encargo, que la adenda extiende a los tres commits del encargo. Condición: árbol limpio tras el commit y `origin/main` ancestro de HEAD. El resultado va en el reporte final, porque el archivo no puede registrar lo que ocurre después de su commit.
- NO se publica: `docs/index.html` (lo decide el titular tras el gate visual).
- Queda al usuario: gate visual sin red; Duda 1; despliegue a `docs/`.

---

## Registro por fase

### FASE 0: log y mediciones

**Verificación:**

`git fetch --quiet && git rev-parse --short HEAD && git rev-parse --short origin/main`

esperado: primer acto (POSICIÓN del encargo): `bb53c8c` (PUNTO DE RETORNO) y `9908180` (el remoto no se movió desde el encargo)
obtenido:

```text
bb53c8c
9908180
```

`git status --porcelain`

esperado: ` M` en `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html` y `50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`; `??` en `50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md`; nada más (el LOG aún vive en el scratchpad)
obtenido:

```text
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
 M 50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md
```

`git merge-base --is-ancestor origin/main HEAD; echo "código: $?"`

esperado: `código: 0`
obtenido: código: 0

`git stash list`

esperado: vacío (no enumerado en la adenda; se mide igual que en el encargo)
obtenido: (sin salida)

`git diff --numstat`

esperado: el mismo diff de T2 que dejó el encargo (`140	1` generador, `8	14` plantilla) y las inserciones del redactor al registro de errores
obtenido:

```text
140	1	30_procesamiento/33_generar_html.R
8	14	30_procesamiento/33_motor_template.html
48	0	50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
```

`Rscript -e 'cat(sapply(c("V8","openssl","chromote"), requireNamespace, quietly=TRUE))' 2>&1 | grep -v out-of-sync`

esperado: `TRUE TRUE` para V8 y openssl (instalados en el encargo); `chromote` desconocido, decide T3
obtenido: TRUE TRUE FALSE

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las dos rutas de código, el registro de errores, la adenda y el LOG de la adenda; nada más
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
```

`git ls-files --error-unmatch 50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`

esperado: la ruta: el registro de errores ya está versionado y vive dentro de `50_documentacion/andamios/` (dato para el 🔒 5; ver Decisiones autónomas)
obtenido: 50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md

**Estado:** completada. Ninguna regla de detención dispara: HEAD es `bb53c8c` y `origin/main` es ancestro de HEAD (el remoto sigue en `9908180`, tras `git fetch`); el árbol es el conjunto esperado.

**Commits:** ninguno.

**Cambios sustantivos:** se creó este LOG. El diff sin commit de T2 es el que dejó el encargo (140/1 y 8/14). `chromote` no está instalado: T3 queda "no ejecutada: sin chromote" y no se instala (encargo, T3 paso 1).

**Alcance:** `⊆`. Rutas fuera de git: las dos de código, el registro de errores, la adenda y el LOG, todas del ALCANCE de la adenda.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Como en el encargo, el LOG se escribió en el scratchpad hasta medir `git status --porcelain` y después se movió a su ruta; el primer acto sobre el repo fue `git fetch`. Reversible.
2. **🔒 5 frente al ALCANCE.** El 🔒 5 heredado dice que `git diff --name-only <PUNTO DE RETORNO>..HEAD -- 50_documentacion/andamios` devuelve "únicamente la ruta de LOG". Pero la adenda nombra en su ALCANCE, y en el paso de FASE L, un segundo archivo de `andamios/` para commitear: el registro de errores del redactor (`50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`, ya versionado). Cumplir el 🔒 al pie de la letra obliga a no commitear ese archivo, lo que deja el árbol sucio y cierra el push de la autorización 4. Cumplir la adenda hace que el 🔒 devuelva dos rutas. Se aplica la instrucción específica y posterior (el ALCANCE y el paso 4 de la adenda). El 🔒 5 se mide con su comando literal, y su esperado para esta adenda queda así, escrito antes de medir: "el LOG de la adenda y el registro de errores que el ALCANCE nombra; nada más". Queda como duda (abajo) y como ADVIERTE en FASE R. Alternativa descartada: no commitear el registro; contradice el paso 4 y deja la cadena sin publicar. Reversible (un commit local hasta el push).

**Errores propios:** ninguno.

**Dudas:**
1. Contexto: el 🔒 5 heredado admite solo el LOG en `andamios/`, y la adenda ordena commitear también el registro de errores, que vive en `andamios/logs/`. Pregunta cerrada: ¿el 🔒 5 de la adenda admite el registro de errores que su ALCANCE nombra (sí/no)? No bloquea: se aplicó "sí" (Decisión 2), y un "no" se corrige con un `git revert` parcial antes o después del push.

### FASE T2: cierre (build, criterios con D1 y D2, cinco 🔒, commit)

**Verificación:**

`Rscript 30_procesamiento/33_generar_html.R > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_adenda.txt 2>&1; echo "código Rscript: $?"; grep -A4 '^\[3b\]' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_adenda.txt; tail -n 1 /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_adenda.txt; md5 -q 40_salidas/motor_comparacion.html`

esperado: código 0; la línea `[3b]` seguida de `App JSX: 156519 caracteres -> JS 175217 caracteres` (el código no cambió desde el encargo); última línea `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`; md5 `892929f4fa997bae71e66349b428d7ed`, el mismo de FASE R del encargo, porque es el mismo día y el mismo código
obtenido:

```text
código Rscript: 0
[3b] Verificando dependencias vendorizadas y transpilando la app...
    React:     10750 caracteres
    ReactDOM:  131834 caracteres
    App JSX:   156519 caracteres -> JS 175217 caracteres
[4] Construyendo HTML final...
33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
892929f4fa997bae71e66349b428d7ed
```

Universo: el archivo completo (la afirmación es sobre la página).

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

`grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__' 40_salidas/motor_comparacion.html; grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__' 30_procesamiento/33_motor_template.html`

esperado: criterio D1: `0` en la salida; `2` en la plantilla (calibración)
obtenido:

```text
0
2
```

Universo: el bloque de la app, último `<script>` del archivo (método del encargo).

`Rscript -e 's <- "40_salidas/motor_comparacion.html"; x <- paste(readLines(s, warn=FALSE), collapse="\n"); b <- tail(strsplit(x, "<script>", fixed=TRUE)[[1]], 1); cat(grepl("ReactDOM.createRoot", b, fixed=TRUE), lengths(gregexpr("React.createElement(", b, fixed=TRUE)), grepl("_jsx(", b, fixed=TRUE), "\n")' 2>&1 | grep -v out-of-sync`

esperado: `TRUE` (calibración de la extracción), un número mayor que 0, `FALSE`
obtenido: TRUE 408 FALSE 

`Rscript -e 'ctx <- V8::v8(); cat(ctx$validate("const a = <div/>;"), ctx$validate("const a = 1;"), "\n")' 2>&1 | grep -v out-of-sync`

esperado: `FALSE TRUE` (calibración de la guarda de sintaxis)
obtenido: FALSE TRUE 

`wc -c 40_salidas/motor_comparacion.html docs/index.html`

esperado: se anota (el encargo midió 2785497 y 2624974)
obtenido:

```text
 2785497 40_salidas/motor_comparacion.html
 2624974 docs/index.html
 5410471 total
```

Los cinco 🔒, cada uno con su comando (el 🔒 3 en su forma reformulada por D2):

`md5 -q docs/index.html`

esperado: 🔒 1: `c9747962e7f9cc8179de3a717f66f9af`
obtenido: c9747962e7f9cc8179de3a717f66f9af

`git diff --quiet HEAD -- 10_utils/d3.min.js 10_utils/pako.min.js; echo "código: $?"`

esperado: 🔒 2: `código: 0`
obtenido: código: 0

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/payload_adenda.R 40_salidas/motor_comparacion.html docs/index.html 2>&1 | grep -v out-of-sync`

esperado: 🔒 3 (D2 a): `fecha_generacion` presente en los dos (`TRUE TRUE`); `identical(j_salida, j_publicado)` sin ese campo: `TRUE`; calibración con un valor numérico alterado en una copia: `FALSE`; la copia sin alterar sigue `TRUE`
obtenido:

```text
fecha_generacion presente en salida/publicado: TRUE TRUE 
identical(j_salida, j_publicado): TRUE 
campo alterado en la copia: meta$anios posición 1 
calibración identical(copia_alterada, j_publicado): FALSE 
control: la copia sin alterar sigue identical: TRUE 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/payload_adenda.R 40_salidas/motor_comparacion.html docs/index.html fuera_de_meta 2>&1 | grep -v out-of-sync | tail -n 2`

esperado: chequeo propio: un campo de datos fuera de `meta` alterado en una posición da `FALSE`
obtenido:

```text
calibración 2, campo alterado fuera de meta: datos$rows posición 1 | largo del vector: 1 
calibración 2 identical(copia_alterada, j_publicado): FALSE 
```

La calibración anterior alteró `datos$rows`, que es un conteo de filas y no una columna de datos: el primer vector numérico fuera de `meta` no era el blanco buscado. Disparó (`FALSE`), pero prueba menos de lo que pretendía. Se agrega una calibración que altera el vector numérico más largo del JSON:

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/payload_adenda.R 40_salidas/motor_comparacion.html docs/index.html mas_largo 2>&1 | grep -v out-of-sync | tail -n 2`

esperado: chequeo propio: un vector con decenas de miles de elementos (una columna de datos) y `FALSE` tras alterar un solo elemento
obtenido:

```text
calibración 3, vector numérico más largo: simce_rbd$anio | largo: 140345 | hojas numéricas: 17 
calibración 3 identical(copia_alterada, j_publicado): FALSE 
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las dos rutas de código de T2, el registro de errores, la adenda y el LOG: todas del ALCANCE
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
```

`git diff-tree --no-commit-id --name-only -r HEAD`

esperado: el commit de T2 trae exactamente `30_procesamiento/33_generar_html.R` y `30_procesamiento/33_motor_template.html`
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
```

`git diff --name-only bb53c8c..HEAD | grep -Eic '\.(xlsx|xls|csv|tsv|parquet|rds|json)$'`

esperado: 🔒 4: `0`
obtenido: 0 [código de salida 1]

`git diff --name-only bb53c8c..HEAD -- 50_documentacion/andamios; echo "filas: $(git diff --name-only bb53c8c..HEAD -- 50_documentacion/andamios | wc -l | tr -d " ")"`

esperado: 🔒 5: `filas: 0` tras el commit de T2 (vacío ⊆ {LOG, registro}; se repite tras el commit de FASE L)
obtenido: filas: 0

**Estado:** completada.

**Commits:** `02daaf7` feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31) (2 archivos, 148 inserciones y 15 borrados).

**Cambios sustantivos:** se commiteó el diff de T2 que el encargo dejó congelado: Bloque 0 y Bloque 3b del generador, más los marcadores y el ancla de la plantilla. Incluye la línea separadora duplicada del Bloque 4, borrada por el ejecutor en el encargo y aceptada por el redactor (ERR-31-05). El build corrió al primer intento y reprodujo byte a byte la salida del encargo (md5 `892929f4fa997bae71e66349b428d7ed`). Todos los criterios de T2 pasan con D1 y D2 reemplazados. Los cinco 🔒 pasan; el 🔒 5 se mide otra vez tras FASE L.

**Alcance:** `⊆`. El commit trae exactamente las dos rutas de código; las demás rutas fuera de git son del ALCANCE de la adenda.

**Regresión:** `Rscript 30_procesamiento/33_generar_html.R`, código 0, última línea `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno del repositorio. Del instrumento propio: la calibración 2 del 🔒 3 eligió un conteo (`datos$rows`) en vez de una columna de datos. Disparó igual, y se agregó la calibración 3 sobre la columna más larga (`simce_rbd$anio`, 140345 elementos), que también dispara. No se reintentó un fallo: se amplió la prueba.

**Decisiones autónomas:**
1. Además de la calibración que pide D2, se agregaron dos calibraciones propias sobre campos fuera de `meta`, porque la primera cayó en `meta$anios`, un metadato. Alternativa descartada: quedarse con la calibración literal, que cumple el texto de D2 pero no muestra que el instrumento dispare sobre datos. Reversible (solo lectura).

**Errores propios:** ninguno.

**Dudas:** ninguna nueva.

### FASE T3: render sin red

**Verificación:** `chromote` se midió en FASE 0 (`TRUE TRUE FALSE` para `V8`, `openssl` y `chromote`).

**Estado:** no ejecutada: sin chromote (encargo, T3 paso 1). No se instala. El render sin red queda para el gate visual del titular.

**Commits:** ninguno.

**Cambios sustantivos:** ninguno.

**Alcance:** no tocó rutas.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:** ninguna.

**Errores propios:** ninguno.

**Dudas:** ninguna. El gate visual sin red es un pendiente del titular, no una duda.

### FASE R: auditoría y reparación

Panel adversarial: no aplicado (subagentes 0 por contrato). Re-deriva el orquestador con comandos distintos de los que produjeron cada afirmación. Los instrumentos del encargo (`auditoria_r.R`, `payload_t2.R`) están transcritos en su log (`bb53c8c`) y se reusan sin cambios; los nuevos se transcriben al final de esta sección.

**Inventario (anexado antes de auditar):**

- R-01 · FASE 0: HEAD = `bb53c8c` al empezar; `origin/main` = `9908180`, ancestro de HEAD; el remoto no se movió.
- R-02 · FASE 0: el árbol de partida era el conjunto esperado (tres ` M` y la adenda `??`).
- R-03 · FASE 0 y T2: el diff de T2 es el que dejó el encargo, 140/1 en el generador y 8/14 en la plantilla, y es lo que se commiteó.
- R-04 · FASE 0: `V8` y `openssl` están instalados y `chromote` no.
- R-05 · T2: el build termina en OK y su salida tiene md5 `892929f4fa997bae71e66349b428d7ed`.
- R-06 · T2: la salida tiene 0 `src="http`; el publicado, 3.
- R-07 · T2: la salida tiene 0 `text/babel`; el publicado, 1.
- R-08 · T2 (D1): 0 marcadores exactos en la salida y 2 en la plantilla.
- R-09 · T2: el bloque de la app tiene `ReactDOM.createRoot`, 408 `React.createElement(` y ningún `_jsx(`.
- R-10 · T2: la guarda `validate` rechaza JSX y acepta JS.
- R-11 · T2: tamaños de 2785497 bytes (salida) y 2624974 (publicado).
- R-12 · 🔒 1: `docs/index.html` no cambia.
- R-13 · 🔒 2: D3 y pako no cambian.
- R-14 · 🔒 3 (D2 a): JSON de la salida sin `fecha_generacion` idéntico al del publicado; las calibraciones disparan.
- R-15 · 🔒 4: ningún archivo con extensión de datos entra por la adenda.
- R-16 · 🔒 5: `andamios/` solo recibe el LOG y el registro de errores que nombra el ALCANCE (Decisión 2 de FASE 0).
- R-17 · T2: el commit `02daaf7` trae solo las dos rutas de código, y su contenido es el que se construyó y midió.
- R-18 · Alcance global: `git diff --name-only bb53c8c..HEAD` ⊆ ALCANCE de la adenda.
- R-19 · Estado del árbol al cierre de FASE R.
- R-20 · Regresión: el build sobre el estado final termina en OK y reproduce el md5.
- R-21 · Registro: cada `esperado:` tiene su `obtenido:`.
- R-22 · Control positivo de la auditoría: casos plantados que deben disparar.

**Re-derivación:**

`git ls-remote origin refs/heads/main | cut -f1; git rev-list --count origin/main..HEAD; git rev-list --count HEAD..origin/main; git rev-parse --short HEAD~1`

esperado: R-01: `9908180a7153b953362af159b16704afa50406a8`; `4` commits por delante (los tres del encargo más `02daaf7`); `0` por detrás; y el padre de HEAD es `bb53c8c`
obtenido:

```text
9908180a7153b953362af159b16704afa50406a8
4
0
bb53c8c
```

`git diff --name-only bb53c8c; git ls-files --others --exclude-standard`

esperado: R-02, por otra vía (árbol contra el retorno): las dos rutas de código (ya commiteadas en `02daaf7`) y el registro; sin trackear, la adenda y el LOG (el LOG es de esta sesión)
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md
50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
```

`git diff --shortstat bb53c8c 02daaf7 -- 30_procesamiento/33_generar_html.R; git diff --shortstat bb53c8c 02daaf7 -- 30_procesamiento/33_motor_template.html`

esperado: R-03: `140 insertions(+), 1 deletion(-)` y `8 insertions(+), 14 deletions(-)`
obtenido:

```text
 1 file changed, 140 insertions(+), 1 deletion(-)
 1 file changed, 8 insertions(+), 14 deletions(-)
```

`Rscript -e 'cat(basename(find.package(c("V8","openssl"))), length(find.package("chromote", quiet=TRUE)), "\n")' 2>&1 | grep -v out-of-sync`

esperado: R-04: `V8 openssl 0`
obtenido: V8 openssl 0 

`Rscript -e 'cat(unname(tools::md5sum("40_salidas/motor_comparacion.html")), "\n")' 2>&1 | grep -v out-of-sync; grep -c 'OK. Producto en 40_salidas/motor_comparacion.html' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_adenda.txt`

esperado: R-05: `892929f4fa997bae71e66349b428d7ed` y `1`
obtenido:

```text
892929f4fa997bae71e66349b428d7ed 
1
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-12-13-14 2>&1 | grep -v out-of-sync; Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-05 2>&1 | grep -v out-of-sync`

esperado: R-06, R-07 y R-08 en R: `0 3`; `0 1`; marcadores exactos en la salida `0`; en la plantilla `1 1 1` (un marcador de cada uno más el ancla: 2 marcadores)
obtenido:

```text
src="http lineas salida/publicado: 0 3 
text/babel lineas salida/publicado: 0 1 
__REACT lineas salida: 1 
__REACT_DEVTOOLS_GLOBAL_HOOK__ apariciones salida: 2 
marcadores exactos salida: 0 
1 1 1 
```

`awk '$0=="  <script>"{s=NR} $0=="  </script>"{e=NR} {a[NR]=$0} END{for(i=s+1;i<e;i++) print a[i]}' 40_salidas/motor_comparacion.html > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida_adenda.js; grep -c 'ReactDOM.createRoot' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida_adenda.js; grep -o 'React.createElement(' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida_adenda.js | wc -l | tr -d ' '; grep -c '_jsx(' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida_adenda.js; Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-15-validar /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_salida_adenda.js /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_plantilla.jsx 2>&1 | grep -v out-of-sync`

esperado: R-09, por `awk` entre anclas: `1`; `408`; `0`; app transpilada válida `TRUE` y JSX de la plantilla `FALSE` (calibración)
obtenido:

```text
1
408
0
app transpilada valida: TRUE | app JSX de la plantilla valida (calibracion): FALSE 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-16 2>&1 | grep -v out-of-sync`

esperado: R-10, otro par de casos: `FALSE TRUE`
obtenido: FALSE TRUE 

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-18 2>&1 | grep -v out-of-sync`

esperado: R-11: `2785497 2624974`
obtenido: 2785497 2624974 

`Rscript -e 'cat(unname(tools::md5sum("docs/index.html")), "\n")' 2>&1 | grep -v out-of-sync; git diff --quiet 9908180 -- docs/index.html; echo "sin cambios desde el retorno del encargo: $?"`

esperado: R-12 🔒 1: `c9747962e7f9cc8179de3a717f66f9af` y `0`
obtenido:

```text
c9747962e7f9cc8179de3a717f66f9af 
sin cambios desde el retorno del encargo: 0
```

`for f in d3.min.js pako.min.js; do [ "$(git hash-object 10_utils/$f)" = "$(git rev-parse 9908180:10_utils/$f)" ] && echo "$f igual al de 9908180" || echo "$f DISTINTO"; done`

esperado: R-13 🔒 2, por hash de blob contra el retorno del encargo: los dos iguales
obtenido:

```text
d3.min.js igual al de 9908180
pako.min.js igual al de 9908180
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/payload_t2.R 40_salidas/motor_comparacion.html docs/index.html 2>&1 | grep -v out-of-sync | tail -n 4`

esperado: R-14 🔒 3, por sustitución de bytes (método del encargo, distinto de `fromJSON` + `identical`): fechas `2026-09-23` y `2026-08-29`, una aparición cada una; tras sustituir solo la fecha, md5 `1691b8fcb8bebe781ecc084f0d3bde94` y `TRUE`
obtenido:

```text
fecha_generacion a: "fecha_generacion":"2026-09-23" | apariciones: 1 
fecha_generacion b: "fecha_generacion":"2026-08-29" | apariciones: 1 
json md5 a con la fecha de b: 1691b8fcb8bebe781ecc084f0d3bde94 
identico a b tras sustituir solo la fecha: TRUE 
```

`Rscript -e 'x <- system("git log --name-only --format= bb53c8c..HEAD", intern=TRUE); x <- x[nzchar(x)]; cat(length(x), sum(grepl("[.](xlsx|xls|csv|tsv|parquet|rds|json)$", x, ignore.case=TRUE)), "\n")' 2>&1 | grep -v out-of-sync`

esperado: R-15 🔒 4, en R sobre `git log --name-only`: `2 0` (dos rutas commiteadas, ninguna de datos)
obtenido: 2 0 

`git log --name-only --format= bb53c8c..HEAD -- 50_documentacion/andamios | grep -c .`

esperado: R-16 🔒 5, por `git log --name-only`: `0` antes del commit de FASE L (vacío ⊆ {LOG, registro}); tras ese commit se espera exactamente el LOG y el registro, medido en el reporte final
obtenido: 0 [código de salida 1]

`git diff --quiet HEAD -- 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html; echo "árbol = commit: $?"; git show --numstat --format= 02daaf7`

esperado: R-17: `árbol = commit: 0` (lo construido y medido es lo commiteado); `140	1` y `8	14` en las dos rutas de código, sin otras
obtenido:

```text
árbol = commit: 0
140	1	30_procesamiento/33_generar_html.R
8	14	30_procesamiento/33_motor_template.html
```

`git log --name-only --format= bb53c8c..HEAD | sort -u`

esperado: R-18: `30_procesamiento/33_generar_html.R` y `30_procesamiento/33_motor_template.html`; ⊆ ALCANCE
obtenido:

```text
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
```

`git status --porcelain`

esperado: R-19: ` M` en el registro de errores; `??` en la adenda y en el LOG (los tres entran en el commit de FASE L por diseño de la adenda); nada más
obtenido:

```text
 M 50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md
?? 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
```

Regresión completa (paso 5):

`Rscript 30_procesamiento/33_generar_html.R > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_adenda_faseR.txt 2>&1; echo "código Rscript: $?"; tail -n 1 /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_adenda_faseR.txt; md5 -q 40_salidas/motor_comparacion.html`

esperado: R-20: `código Rscript: 0`; `33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html`; `892929f4fa997bae71e66349b428d7ed`
obtenido:

```text
código Rscript: 0
33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
892929f4fa997bae71e66349b428d7ed
```

`echo "esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md) obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md)"`

esperado: R-21: `esperado` supera en 1 a `obtenido` (la medición en curso)
obtenido: esperado: 43 obtenido: 42

Control positivo de la auditoría (paso 6), sobre casos plantados fuera del árbol:

`d=$(mktemp -d) && sed 's|^</body>|<script src="https://x"></script>\n</body>|' 40_salidas/motor_comparacion.html > $d/plantado.html && grep -c 'src="http' $d/plantado.html && Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_r.R R-30 $d/plantado.html 2>&1 | grep -v out-of-sync`

esperado: R-22 a: `1` con `grep` y `1` en R (la salida real da `0`, R-06)
obtenido:

```text
1
lineas con src="http en la copia plantada: 1 
```

`Rscript -e 'x <- c("30_procesamiento/33_generar_html.R", "20_insumos/plantado.json"); cat(sum(grepl("[.](xlsx|xls|csv|tsv|parquet|rds|json)$", x, ignore.case=TRUE)), "\n")' 2>&1 | grep -v out-of-sync`

esperado: R-22 b: `1` (el instrumento de R-15 dispara sobre un `.json` plantado)
obtenido: 1 

`printf '50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md\n50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md\n50_documentacion/andamios/plantado.R\n' | grep -v -x -e '50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md' -e '50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md'`

esperado: R-22 c: `50_documentacion/andamios/plantado.R` (el filtro del 🔒 5 deja pasar solo la ruta no autorizada)
obtenido: 50_documentacion/andamios/plantado.R

**Tabla de auditoría:**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | HEAD de partida `bb53c8c`; remoto en `9908180`, ancestro | `git ls-remote` + `rev-list --count` en los dos sentidos + `HEAD~1` | `9908180a…`; 4; 0; `bb53c8c` | igual | — | — | — | — |
| R-02 | árbol de partida = conjunto esperado | `git diff --name-only bb53c8c` + `ls-files --others` | 2 de código + registro; adenda y LOG | igual | — | — | — | — |
| R-03 | diff de T2 = el del encargo = lo commiteado | `git diff --shortstat bb53c8c 02daaf7` | 140/1; 8/14 | 140/1; 8/14 | — | — | `02daaf7` | — |
| R-04 | V8 y openssl sí, chromote no | `find.package` | `V8 openssl 0` | `V8 openssl 0` | ADVIERTE (sin `chromote`, el render sin red no se midió; T3 no ejecutada) | queda al gate visual del titular | — | — |
| R-05 | build OK, md5 `892929f4…` | `tools::md5sum` + `grep -c` en la salida del build | `892929f4…`; 1 | igual | — | — | — | R-20 |
| R-06 | `src="http` 0 / 3 | R por línea | 0 3 | 0 3 | — | — | — | control plantado R-22 a |
| R-07 | `text/babel` 0 / 1 | R por línea | 0 1 | 0 1 | — | — | — | — |
| R-08 | marcadores exactos 0 / 2 (D1) | R, `gregexpr` | 0; `1 1 1` | 0; `1 1 1` | — | — | — | — |
| R-09 | app: `createRoot`, 408, sin `_jsx`, JS válido | `awk` entre anclas + `grep -o` + `V8::validate` | 1, 408, 0; `TRUE`; `FALSE` | igual | — | — | — | — |
| R-10 | `validate` rechaza JSX y acepta JS | otro par de casos | `FALSE TRUE` | `FALSE TRUE` | — | — | — | — |
| R-11 | tamaños | `file.size` | 2785497 2624974 | igual | — | — | — | — |
| R-12 | 🔒 1 `docs/index.html` intacto | `tools::md5sum` + `git diff --quiet 9908180` | `c9747962…`; 0 | igual | — (PASA) | — | — | — |
| R-13 | 🔒 2 D3 y pako intactos | `git hash-object` contra blobs de `9908180` | iguales | iguales | — (PASA) | — | — | — |
| R-14 | 🔒 3 (D2 a) JSON sin fecha idéntico | sustitución de bytes (`payload_t2.R`) | `TRUE`, md5 `1691b8fc…` | igual | — (PASA) | — | — | tres calibraciones en T2, todas `FALSE` |
| R-15 | 🔒 4 sin archivos de datos | R sobre `git log --name-only` | `2 0` | `2 0` | — (PASA) | — | — | control plantado R-22 b |
| R-16 | 🔒 5 `andamios/` solo recibe el LOG y el registro | `git log --name-only -- andamios` | 0 antes de FASE L | 0 | ADVIERTE (el 🔒 heredado dice "solo el LOG" y la adenda ordena commitear además el registro de errores; se aplicó el ALCANCE, Decisión 2 de FASE 0) | registrada (Duda 1 de FASE 0); se re-mide tras FASE L | — | control plantado R-22 c |
| R-17 | commit T2 = 2 rutas; árbol = commit | `git diff --quiet HEAD` + `git show --numstat` | 0; 140/1 y 8/14 | igual | — | — | `02daaf7` | — |
| R-18 | alcance global ⊆ ALCANCE | `git log --name-only bb53c8c..HEAD \| sort -u` | 2 rutas de código | igual | — | — | — | — |
| R-19 | árbol al cierre de FASE R | `git status --porcelain` | registro ` M`; adenda y LOG `??` | igual | — (entran en el commit de FASE L por diseño) | — | — | FASE L |
| R-20 | regresión | build + md5 | OK; `892929f4…` | OK; `892929f4…` | — | — | — | — |
| R-21 | `esperado:` = `obtenido:` | `grep -c` | +1 (la medición en curso) | 43 / 42 | — | — | — | FASE L |
| R-22 | la auditoría dispara | casos plantados en `mktemp -d` y en memoria | 1/1; 1; 1 ruta | 1/1; 1; `plantado.R` | — | — | — | — |

**Hallazgos por severidad:** BLOQUEA 0; REPARA 0; ADVIERTE 2 (R-04, R-16). Ciclos de reparación: 0.

**Veredicto global: `APROBADO CON ADVERTENCIAS`.**

**Estado:** completada.

**Commits:** ninguno.

**Cambios sustantivos:** ninguno en el árbol. La regresión re-escribió la salida ignorada con los mismos bytes.

**Alcance:** `⊆` (R-18).

**Regresión:** R-20, código 0, salida idéntica.

**Subagentes:** sin subagentes, por contrato; sin panel adversarial por la misma razón.

**Bugs:** ninguno.

**Decisiones autónomas:** ninguna nueva.

**Errores propios:** ninguno.

**Dudas:** la de FASE 0 (🔒 5), sin cambios.

**Instrumentos nuevos, transcritos íntegros.** `medir_adenda.sh` es `medir.sh` del encargo (transcrito en su log) con dos cambios: la ruta por defecto del LOG y la primera línea de comentario. `auditoria_r.R` y `payload_t2.R` se reusan sin cambios desde el log del encargo.

`diff medir.sh medir_adenda.sh`:

````text
1c1
< # Ayudante de verificación del encargo retiro_cdn_v8.
---
> # Ayudante de verificación de la adenda del encargo retiro_cdn_v8.
7c7
< : "${LOG:=$RAIZ/50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md}"
---
> : "${LOG:=$RAIZ/50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md}"
````

`payload_adenda.R`:

````r
# 🔒 3 reformulado por la adenda (D2, opción a), solo lectura. El JSON
# descomprimido de la salida sin meta.fecha_generacion es identical() al de
# docs/index.html sin ese campo. Método de descompresión del log del encargo:
# base64_dec -> memDecompress(gzip) -> jsonlite::fromJSON. Calibración: el
# mismo identical() con un valor numérico alterado en una copia de j_salida.
# No imprime valores de datos: solo booleanos, nombres de campo y posiciones.
# Uso: Rscript payload_adenda.R <salida.html> <publicado.html>
args <- commandArgs(trailingOnly = TRUE)
payload_json <- function(ruta) {
  l <- readLines(ruta, warn = FALSE, encoding = "UTF-8")
  x <- paste(l, collapse = "\n")
  stopifnot(lengths(gregexpr("\n", x, fixed = TRUE)) == length(l) - 1L)
  m <- regmatches(x, gregexpr('atob\\("[^"]*"\\)', x))[[1]]
  stopifnot(length(m) == 1L)
  js <- rawToChar(memDecompress(jsonlite::base64_dec(substr(m, 7L, nchar(m) - 2L)), type = "gzip"))
  Encoding(js) <- "UTF-8"
  jsonlite::fromJSON(js)
}
j_salida    <- payload_json(args[1])
j_publicado <- payload_json(args[2])
cat("fecha_generacion presente en salida/publicado:",
    !is.null(j_salida$meta$fecha_generacion), !is.null(j_publicado$meta$fecha_generacion), "\n")
j_salida$meta$fecha_generacion    <- NULL
j_publicado$meta$fecha_generacion <- NULL
cat("identical(j_salida, j_publicado):", identical(j_salida, j_publicado), "\n")

# Calibración: primer vector numérico con algún valor no NA, recorrido en orden.
buscar_num <- function(x, idx = integer()) {
  if (is.numeric(x) && any(!is.na(x))) return(idx)
  if (is.list(x)) for (k in seq_along(x)) {
    r <- buscar_num(x[[k]], c(idx, k))
    if (!is.null(r)) return(r)
  }
  NULL
}
idx <- buscar_num(j_salida)
nombres <- character()
obj <- j_salida
for (k in idx) { nm <- names(obj)[k]; nombres <- c(nombres, if (is.null(nm) || nm == "") as.character(k) else nm); obj <- obj[[k]] }
v <- j_salida[[idx]]
pos <- which(!is.na(v))[1]
v[pos] <- v[pos] + 1
copia <- j_salida
copia[[idx]] <- v
cat("campo alterado en la copia:", paste(nombres, collapse = "$"), "posición", pos, "\n")
cat("calibración identical(copia_alterada, j_publicado):", identical(copia, j_publicado), "\n")
cat("control: la copia sin alterar sigue identical:", identical(j_salida, j_publicado), "\n")

# Calibración 2 (chequeo propio): primer vector numérico fuera de `meta`.
if (length(commandArgs(trailingOnly = TRUE)) >= 3 && commandArgs(trailingOnly = TRUE)[3] == "fuera_de_meta") {
  cand <- which(names(j_salida) != "meta")
  idx2 <- NULL
  for (k in cand) { r <- buscar_num(j_salida[[k]], k); if (!is.null(r)) { idx2 <- r; break } }
  nombres2 <- character(); obj <- j_salida
  for (k in idx2) { nm <- names(obj)[k]; nombres2 <- c(nombres2, if (is.null(nm) || nm == "") as.character(k) else nm); obj <- obj[[k]] }
  v2 <- j_salida[[idx2]]; pos2 <- which(!is.na(v2))[1]; v2[pos2] <- v2[pos2] + 1
  copia2 <- j_salida; copia2[[idx2]] <- v2
  cat("calibración 2, campo alterado fuera de meta:", paste(nombres2, collapse = "$"), "posición", pos2,
      "| largo del vector:", length(v2), "\n")
  cat("calibración 2 identical(copia_alterada, j_publicado):", identical(copia2, j_publicado), "\n")
}

# Calibración 3 (chequeo propio): el vector numérico más largo del JSON (una
# columna de datos), alterado en su posición no NA central.
if (length(commandArgs(trailingOnly = TRUE)) >= 3 && commandArgs(trailingOnly = TRUE)[3] == "mas_largo") {
  hojas <- list()
  recorrer <- function(x, idx = integer()) {
    if (is.numeric(x)) { hojas[[length(hojas) + 1L]] <<- list(idx = idx, n = length(x)); return(invisible()) }
    if (is.list(x)) for (k in seq_along(x)) recorrer(x[[k]], c(idx, k))
  }
  recorrer(j_salida)
  mejor <- hojas[[which.max(vapply(hojas, `[[`, numeric(1), "n"))]]
  nombres3 <- character(); obj <- j_salida
  for (k in mejor$idx) { nm <- names(obj)[k]; nombres3 <- c(nombres3, if (is.null(nm) || nm == "") as.character(k) else nm); obj <- obj[[k]] }
  v3 <- j_salida[[mejor$idx]]; nn <- which(!is.na(v3)); pos3 <- nn[ceiling(length(nn) / 2)]
  v3[pos3] <- v3[pos3] + 1
  copia3 <- j_salida; copia3[[mejor$idx]] <- v3
  cat("calibración 3, vector numérico más largo:", paste(nombres3, collapse = "$"), "| largo:", mejor$n,
      "| hojas numéricas:", length(hojas), "\n")
  cat("calibración 3 identical(copia_alterada, j_publicado):", identical(copia3, j_publicado), "\n")
}
````

### FASE L: cierre del log

**Verificación:**

`git status --porcelain`

esperado: el encargo dice "vacío o solo el LOG"; la adenda agrega a su commit la adenda y el registro de errores, así que lo esperado es ` M` en el registro y `??` en la adenda y en el LOG; nada más
obtenido:

```text
 M 50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_retiro_cdn_v8_adenda.md
?? 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
```

`git log bb53c8c..HEAD --oneline; echo "--- cadena desde el retorno del encargo:"; git log 9908180..HEAD --oneline`

esperado: desde `bb53c8c`: solo `02daaf7`; desde `9908180`: `02daaf7`, `bb53c8c`, `65e5e4a` y `2ab9927`
obtenido:

```text
02daaf7 feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31)
--- cadena desde el retorno del encargo:
02daaf7 feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31)
bb53c8c docs(log): retiro de unpkg.com con transpilación en el build
65e5e4a chore(vendor): React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 en 10_utils (s31)
2ab9927 docs(diseno): regla 12 y A29-4, el alcance del instrumento iguala el de la afirmación
```

**Estado:** completada. Estos rótulos se anexan antes de las verificaciones finales del archivo, para que cubran el log entero.

**Commits:** `docs(log): cierre de T2 del retiro de unpkg.com`, con el LOG, la adenda y el registro de errores del redactor. El hash va en el reporte final.

**Cambios sustantivos:** cierre C.1 a C.10 y bloque J rellenos.

**Alcance:** el commit de esta fase trae exactamente las tres rutas que nombra el paso 4 de la adenda.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. El control positivo del grep de privacidad arma el RUT ficticio con `printf` a partir de trozos separados y solo registra el conteo, para que el valor plantado no entre al log (lección del error 4 del log del encargo). Reversible.

**Errores propios:** ninguno.

**Dudas:** ninguna nueva; las consolidadas están en C.7.

Verificaciones finales del archivo:

`grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md; echo "líneas con patrón de RUT: $(grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md)"`

esperado: `líneas con patrón de RUT: 0`
obtenido: líneas con patrón de RUT: 0

`printf '%s.%s.%s-%s\n' 12 345 678 9 | grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'`

esperado: control positivo del patrón: `1` (RUT ficticio armado por partes; solo se registra el conteo)
obtenido: 1

`ls -l 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md | awk '{print $1, $5, $NF}' && wc -l 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md`

esperado: el archivo existe; se anotan su tamaño y sus líneas
obtenido:

```text
-rw-r--r-- 49233 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
     847 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md
```

`echo "secciones FASE: $(grep -c '^### FASE' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md); J: $(grep -c '^## J' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md); esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md); obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md)"`

esperado: `secciones FASE: 5` (FASE 0, T2, FASE R y FASE L ejecutadas, más la sección de T3 no ejecutada que pide v1.6 §4.1); `J: 1`; `esperado` supera en 1 a `obtenido` (la medición en curso)
obtenido: secciones FASE: 5; J: 1; esperado: 52; obtenido: 51
