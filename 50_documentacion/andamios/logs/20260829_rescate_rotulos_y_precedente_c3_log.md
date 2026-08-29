# Log — Rescate de rótulos del panorama y auditoría del precedente C3

> **Encargo:** `50_documentacion/activa/encargos/encargo_rescate_rotulos_y_precedente_c3.md`
> **Ejecutado:** 2026-08-29, Claude Code, sesión limpia, modo autónomo secuencial, 0 subagentes.
> Este log queda sin trackear y sin commitear.

---

## 1. Resumen

- **FASE A: CONGELADA antes de A1, sin commit, sin regeneración, sin push.** El diff de la plantilla nueva contradice la premisa 4: además del rescate de rótulos contiene **cinco bloques ajenos** (uppercase de `.badge-traspaso` vía CSS + su markup, uppercase de `.hero-card-control-label` vía CSS + su markup `Nivel`, y un refactor `sembradas` en `entidadesPorDefecto`). La rama de detención de A2 ("cualquier regla CSS ajena al panorama... detente") se habría disparado inevitablemente tras el commit; congelar antes evitó crear un commit cuyo mensaje (`fix(motor): rescata bajo el eje...`) describiría solo una parte del cambio, y evitó dejar un commit local impublicable (el push autorizado era "solo del commit de A3"). El árbol quedó exactamente como se encontró: plantilla ` M`, `docs/index.html` intacto, motor generado intacto.
- **FASE B: COMPLETA.** El precedente C3 de `slep_categoria_desempeno` quedó reconstruido con archivo y línea: su motor publicado no carga **nada** por red al abrirse; React/ReactDOM/d3/pako están **vendorizados** en `10_utils/` y se inyectan en cada build por placeholders; el JSX se transpiló **una sola vez** con `npx babel` (preset-react, runtime **classic**) y el template versiona el código ya transpilado; la fuente editable es `33_app.jsx`, reconstruida en s23 por transformación inversa verificada por AST. Sin `package.json`, sin `node_modules`: Node/npx es herramienta manual de edición, no de build ni de runtime.

## 2. Inventario del commit de A1

**No existe.** FASE A se congeló antes de `git add`. Cero commits creados en esta corrida; `HEAD` = `origin/main` = `4e8f946f0cf6b252c296cf6d545299d25aa139e7` antes y después (comando: `git -C $R rev-parse HEAD origin/main` en FASE 0 y FASE FINAL).

## 3. Por tarea: salidas literales y tablas

### FASE 0

Comandos del encargo, salida literal:

```
--- status ---
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_rescate_rotulos_y_precedente_c3.md
?? 50_documentacion/activa/encargos/encargo_verificacion_dudas_s29.md
?? 50_documentacion/andamios/logs/20260829_verificacion_dudas_s29_log.md
--- rev-parse ---
4e8f946f0cf6b252c296cf6d545299d25aa139e7
4e8f946f0cf6b252c296cf6d545299d25aa139e7
--- wc -l plantilla ---
    4541 /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
--- md5 motor ---
f00e9126b86fc703b001e55080de0969
--- md5 docs/index.html ---
f00e9126b86fc703b001e55080de0969
--- conteos plantilla nueva ---
ALTO_MIN_ROTULO -> 2
valorFuera -> 2
rescatadas -> 3
--- H: 328 ---
3078:      W: 520, H: 328,
```

| Medición | Esperado | Medido |
|---|---|---|
| `status --porcelain` | ` M` plantilla + `??` de este encargo y su log | ` M` plantilla + `??` de este encargo + **dos `??` extra**: el `.md` y el log del encargo anterior de esta misma sesión (no son archivos versionados modificados; ver §8) |
| `rev-parse` | ambos `4e8f946` | ambos `4e8f946f0cf6b252c296cf6d545299d25aa139e7` ✓ |
| `wc -l` | 4541 | 4541 ✓ |
| md5 motor y docs | ambos `f00e9126b86fc703b001e55080de0969` | ambos idénticos ✓ |
| conteos | ≥1 cada uno | 2 / 2 / 3 ✓ |
| `H: 328` | una ocurrencia dentro de `PANORAMA_DIMS` | L3078, dentro de `PANORAMA_DIMS` (L3077-3083), con `ALTO_MIN_ROTULO = 15` en L3075 ✓ |

### FASE A — congelada antes de A1

Evidencia que motivó la congelación: `git -C $R diff -- 30_procesamiento/33_motor_template.html` (§4, íntegro). Los comandos de A1/A2/A3 **no se ejecutaron**: sin `git add`, sin `commit`, sin `Rscript`, sin `cp` a `/tmp` del motor. Consecuencia verificada en FASE FINAL: los md5 del motor generado y de `docs/index.html` siguen siendo los de FASE 0.

### FASE B

**B1** — `ls -d /Users/tomgc/Projects/slep_categoria_desempeno` → existe (la ruta hipotética era la real). `git -C $C rev-parse HEAD` → `b709400f9345785e69edbb9b75659210942667dc`. Su HTML publicado: `docs/index.html` (único archivo en `docs/`, confirmado con `ls -1 $C/docs/`).

**B2** — instrumento de T4 sobre `$C/docs/index.html`, salida literal:

```
   8 http://www.w3.org/2000/svg
   6 http://www.w3.org/1999/xhtml
   3 http://www.w3.org/1999/xlink
   2 http://www.w3.org/XML/1998/namespace
   1 https://reactjs.org/docs/error-decoder.html?invariant=
   1 https://github.com/nodeca/pako
   1 https://d3js.org
   1 http://www.w3.org/2000/xmlns/
   1 http://www.w3.org/1998/Math/MathML
src="http -> 0        babel -> 0        text/babel -> 0
React.createElement -> 196
href="http -> 0       @import -> 0      fetch( -> 1       XMLHttpRequest -> 0
wc -c -> 1902667      wc -l -> 3297
```

Clasificación de las URL (categorías de T4):

| URL única | Categoría | Detalle |
|---|---|---|
| `www.w3.org/*` (6 URLs únicas, 21 apariciones) | 1 — namespace | declaraciones, no descargas |
| `reactjs.org/docs/error-decoder.html?invariant=` | 2 — texto | string del bundle de React production (mensaje de error minificado) |
| `d3js.org` | 2 — comentario | cabecera del bundle d3 inline |
| `github.com/nodeca/pako` | 2 — comentario | licencia del bundle pako inline |
| **categoría 3** | **ninguna** | ceros con control positivo en §5 |

El `fetch( -> 1` es una línea (el bundle d3 inline): definiciones de `d3.blob`/`d3.buffer`/`d3.json`/`d3.text` (contexto extraído con `perl -ne`), no invocaciones; las invocaciones en el motor dan 0 (`grep -c -F 'd3.json(' → 0`, `'d3.csv(' → 0`, `'d3.text(' → 0`, controles en §5).

**Respuesta de B2 con evidencia:** ese motor **no carga nada por red al abrirse**. Todo recurso ejecutable está inline; las únicas URLs presentes son namespaces y texto.

**B3** — ver §6.

### FASE FINAL

Comandos: `git -C $R status --porcelain; git -C $R rev-parse HEAD origin/main; md5 -q $R/docs/index.html; md5 -q $R/40_salidas/motor_comparacion.html`. Salida literal:

```
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_rescate_rotulos_y_precedente_c3.md
?? 50_documentacion/activa/encargos/encargo_verificacion_dudas_s29.md
?? 50_documentacion/andamios/logs/20260829_verificacion_dudas_s29_log.md
4e8f946f0cf6b252c296cf6d545299d25aa139e7
4e8f946f0cf6b252c296cf6d545299d25aa139e7
f00e9126b86fc703b001e55080de0969
f00e9126b86fc703b001e55080de0969
```

**El `git push` NO se ejecutó**: la autorización (§3.4 del encargo) era "un único git push en la FASE FINAL... solo del commit de A3", y ese commit no existe. No había nada que publicar (`HEAD` = `origin/main`).

## 4. El diff de la plantilla, íntegro, con atribución bloque a bloque

A2 no corrió (no hubo regeneración), así que el diff atribuido es el de la **fuente** del build: `git -C $R diff -- 30_procesamiento/33_motor_template.html`, 15 hunks con `-U0` (conteo informativo de `grep -c "^@@"`, no criterio). Atribución hunk por hunk, en orden:

| # | Ubicación | Contenido | Atribución |
|---|---|---|---|
| 1 | `@@ -647` CSS | `+ text-transform: uppercase;` en `.badge-traspaso` (selector verificado en L641) | **AJENO** — badge del modal de entidades (vista de comparación); regla CSS ajena al panorama |
| 2 | `@@ -1094` CSS | `.hero-card-control-label` gana `text-transform: uppercase` | **Zona gris** — `hero-card` se usa solo en `PanoramaHero` (único uso, L3433), o sea sección del panorama, pero no es "la función de dibujo ni la nota metodológica" de la premisa 4 |
| 3 | `@@ -1823` JS | `+ valorFuera: 9.5,` en `FS_SVG.panorama` | **RESCATE** ✓ (premisa 4) |
| 4 | `@@ -3067` JS | `+ const ALTO_MIN_ROTULO = 15;` con comentario; `PANORAMA_DIMS` H 300→328, `M.bottom` 46→74 con comentario | **RESCATE** ✓ |
| 5 | `@@ -3158` JS | `segs` gana `sigla: "A"/"E"/"I"`; `+ const rescatadas = [];` con comentario que cita la medición de s29 | **RESCATE** ✓ |
| 6 | `@@ -3175` JS | `if (h >= 15)` → `if (h >= ALTO_MIN_ROTULO)` | **RESCATE** ✓ |
| 7 | `@@ -3184` JS | `+ else { rescatadas.push(seg); }` y el bloque `rescatadas.forEach` que dibuja `sigla + " " + fmtPct(seg.val)` bajo el eje (`ih + 44 + k * 12`, `FS_SVG.panorama.valorFuera`) | **RESCATE** ✓ — usa `fmtPct` (un decimal), no `fmtPctShort` |
| 8 | `@@ -3404` JSX | `<span className="hero-card-control-label">NIVEL</span>` → `Nivel` | **Zona gris** — dentro de `PanoramaHero` (panorama), pero fuera del alcance declarado en la premisa 4; par del hunk 2 |
| 9 | `@@ -3509` JSX | La nota metodológica de `PanoramaSection` gana la frase "Cuando una franja es demasiado delgada... el valor aparece bajo el año con la inicial del nivel (A, E o I) en su color." | **RESCATE** ✓ (nota metodológica) |
| 10 | `@@ -4046` JSX | Badge del modal: `TRASPASO {s.anio_traspaso}` → `traspaso {s.anio_traspaso}` (uppercase pasa al CSS del hunk 1) | **AJENO** — modal de selección de SLEP de la vista de comparación (L4070-4086) |
| 11 | `@@ -4236` JS | `+ const sembradas = ...` y su uso en el `console.warn` de `entidadesPorDefecto` | **AJENO** — siembra de entidades por defecto de la vista de comparación; refactor sin cambio de comportamiento aparente (mismo valor calculado), pero fuera del alcance |

(El diff con contexto agrupa estos cambios en menos hunks visuales; la lista cubre el 100% de las líneas cambiadas: 47 inserciones, 11 borrados según `git diff --stat`, cifra informativa.)

Diff íntegro:

```diff
@@ -647,6 +647,7 @@ (.badge-traspaso)
   color: var(--ocean);
   font-size: var(--fs-overline);
   font-weight: 800;
+  text-transform: uppercase;
   letter-spacing: 0.02em;
@@ -1094,7 +1095,7 @@ (.hero-card-control-label)
-  letter-spacing: var(--tracking-overline);
+  letter-spacing: var(--tracking-overline); text-transform: uppercase;
@@ -1823,6 +1824,7 @@ (FS_SVG.panorama)
         leyenda:          11,    // rótulos de la leyenda de niveles
+        valorFuera:       9.5,   // % de una franja demasiado delgada, bajo el eje
@@ -3067,9 +3069,18 @@ (ALTO_MIN_ROTULO + PANORAMA_DIMS)
+    // Altura mínima que necesita una franja para llevar su porcentaje adentro.
+    // Con el área interna de PANORAMA_DIMS equivale a poco más de 7 puntos
+    // porcentuales; por debajo de eso el valor se rescata bajo el eje.
+    const ALTO_MIN_ROTULO = 15;
+
     const PANORAMA_DIMS = {
-      W: 520, H: 300,
-      M: { top: 40, right: 14, bottom: 46, left: 36 },
+      W: 520, H: 328,
+      // El margen inferior reserva, además del año y el N, hasta dos renglones
+      // para los porcentajes de franjas demasiado delgadas para llevar su
+      // rótulo dentro. Dos es el máximo posible: tres franjas bajo el umbral no
+      // pueden sumar 100.
+      M: { top: 40, right: 14, bottom: 74, left: 36 },
     };
@@ -3158,11 +3169,17 @@ (segs + rescatadas)
-            { val: s.pct,     fill: COLOR_ADEC },
-            { val: s.pct_ele, fill: COLOR_ELEM },
-            { val: s.pct_ins, fill: COLOR_INSUF },
+            { val: s.pct,     fill: COLOR_ADEC, sigla: "A" },
+            { val: s.pct_ele, fill: COLOR_ELEM, sigla: "E" },
+            { val: s.pct_ins, fill: COLOR_INSUF, sigla: "I" },
           ];
           let base = 0;
+          // Franjas que no admiten su rótulo adentro. Se rescatan bajo el eje en
+          // vez de perderse: la medición de la sesión 29 mostró que el 11,9% de
+          // los puntos comunales tiene al menos una, y que en 1.529 de 1.614
+          // casos la franja muda es Adecuado. El número que desaparecía era
+          // justamente el más grave de la serie.
+          const rescatadas = [];
@@ -3175,7 +3192,7 @@ (umbral nombrado)
-            if (h >= 15) {
+            if (h >= ALTO_MIN_ROTULO) {
@@ -3184,8 +3201,24 @@ (else + dibujo bajo el eje)
                 .text(fmtPctShort(v));
+            } else {
+              rescatadas.push(seg);
             }
           });
+          // La sigla acompaña al color porque el color solo no basta para
+          // identificar el nivel fuera de su franja. El valor va con un decimal
+          // (fmtPct, no fmtPctShort): redondear 0,2 a "0%" anularía justamente
+          // la cifra que esta línea existe para rescatar.
+          rescatadas.forEach((seg, k) => {
+            g.append("text")
+              .attr("x", xPos + bw / 2).attr("y", ih + 44 + k * 12)
+              .attr("text-anchor", "middle")
+              .attr("font-family", "system-ui, sans-serif")
+              .attr("font-size", FS_SVG.panorama.valorFuera)
+              .attr("font-weight", 700)
+              .attr("fill", seg.fill)
+              .text(seg.sigla + " " + fmtPct(seg.val));
+          });
@@ -3404,7 +3437,7 @@ (PanoramaHero)
-            <span className="hero-card-control-label">NIVEL</span>
+            <span className="hero-card-control-label">Nivel</span>
@@ -3509,7 +3542,9 @@ (nota metodológica de PanoramaSection)
-              publicado por la Agencia, no un recuento de la fuente.
+              publicado por la Agencia, no un recuento de la fuente. Cuando una franja es
+              demasiado delgada para llevar su cifra adentro, el valor aparece bajo el año
+              con la inicial del nivel (A, E o I) en su color.
@@ -4046,7 +4081,7 @@ (badge del modal de SLEP)
-                                  TRASPASO {s.anio_traspaso}
+                                  traspaso {s.anio_traspaso}
@@ -4236,10 +4271,11 @@ (entidadesPorDefecto)
+        const sembradas = Math.min(nComunas, MAX_ENTIDADES);
         if (nComunas > MAX_ENTIDADES) {
           console.warn(
             `entidadesPorDefecto: el SLEP "${slep.nombre}" tiene ${nComunas} comunas y se sembraron ` +
-            `${Math.min(nComunas, MAX_ENTIDADES)}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
+            `${sembradas}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
```

Nota de contenido: la verificación de A2 "el rescate usa `fmtPct`, no `fmtPctShort`" quedó verificada **en la fuente** (hunk 7: `.text(seg.sigla + " " + fmtPct(seg.val))` y su comentario); la verificación sobre el artefacto generado no corrió porque no hubo regeneración.

## 5. Controles positivos (cada cero con su comando)

| Cero medido | Comando del cero | Control positivo | Resultado |
|---|---|---|---|
| `src="http` = 0 en `$C/docs/index.html` | `grep -c -F 'src="http'` | mismo patrón sobre `$R/docs/index.html` (donde sí hay CDN) | `3` ✓ |
| `babel` = 0 en `$C/docs/index.html` | `grep -c -F 'babel'` | ídem sobre `$R/docs/index.html` | `2` ✓ |
| `text/babel` = 0 en `$C/docs/index.html` | `grep -c -F 'text/babel'` | ídem sobre `$R/docs/index.html` | `1` ✓ |
| `href="http` = 0 en `$C/docs/index.html` | `grep -c -F 'href="http'` | sobre `$R/50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` | `1` ✓ |
| `@import` = 0 | `grep -c -F '@import'` | `/tmp/control_b2.txt` (creado con `printf`, registrado) | `1` ✓ |
| `XMLHttpRequest` = 0 | `grep -c -F 'XMLHttpRequest'` | `/tmp/control_b2.txt` | `1` ✓ |
| `npx`/`babel`/`node`/`esbuild`/`terser` = 0 en `$C/30_procesamiento/33_generar_html.R` | `grep -n -F` cada uno | `grep -c -F 'npx' $C/30_procesamiento/33_app.jsx` (donde sí está) | `1` ✓ |
| `d3.json(`/`d3.csv(`/`d3.text(` = 0 en `$C/docs/index.html` | `grep -c -F` cada uno | `/tmp/control_b2_d3.txt` | `1 1 1` ✓ |

## 6. FASE B completa

### B3 — Las seis respuestas, con archivo y línea

1. **Dónde está React: vendorizado e inyectado inline en cada build.** Archivos `10_utils/react.production.min.js` y `10_utils/react-dom.production.min.js` (listados con `ls -1 $C/10_utils/`). El generador los lee y los sustituye en los placeholders del template: `33_generar_html.R` L404 (`react_path <- here::here("10_utils", "react.production.min.js")`), L418-420 (aborta con instrucción `curl` si falta el archivo), L448 y L455 (`html <- sub("__REACT_INLINE__", react_code, plantilla, fixed = TRUE)`). En el artefacto publicado no queda ningún `src=` externo (B2).
2. **Cómo desaparece Babel: el JSX se transpiló UNA VEZ y el template versiona el resultado.** `33_motor_template.html` contiene 196 `React.createElement` (`grep -c -F`); la cabecera del generador (L27-29 de `33_generar_html.R`) lo declara: "El JSX se transpiló a React.createElement (s21, C3): el motor ya no depende de Babel ni de ninguna dependencia de red en runtime". El backlog (c.87) detalla: se retiró el `<script src>` de `@babel/standalone` y el `<script type="text/babel" data-presets="env,react">` pasó a `<script>` normal; Babel se usó "una sola vez como herramienta de migración desechable".
3. **Herramienta de transpilación: `npx babel` con `@babel/preset-react`, runtime `classic`, manual.** Documentada en la cabecera de `33_app.jsx` (L20-27: comando `npx babel 33_app.jsx --out-file app_transpilado.js --presets '@babel/preset-react'` con `babel.config.json` `{ "runtime": "classic" }`). **En el generador y scripts de build no hay ninguna invocación** a `node`/`npx`/`esbuild`/`babel`/`terser` (greps con control positivo, §5): el paso es **manual**, se ejecuta solo cuando se edita la UI, y el runtime `classic` es obligatorio (el automático emite `_jsx`, que el motor inline no resuelve — incidente real registrado en c.87, regla A34).
4. **Dependencias de entorno: ninguna en build ni runtime; Node/npx solo como herramienta manual de edición.** No hay `package.json` ni `node_modules` en el repo (`find -maxdepth 2` → vacío fuera de `renv/`). El build es R puro (leer .min.js vendorizados + `sub()` de placeholders). Editar la UI sí requiere Node/npx disponibles en la máquina del que edita, fuera del producto.
5. **Dónde está documentada la decisión.** Plan: `50_documentacion/activa/decisiones/20260618_decision_plan_c3_eliminar_babel.md`. Ejecución: `50_documentacion/activa/backlog_acumulativo.md`, cambio 87 (sesión 21, commits `5f53259`, `3303b31`, `d065dc1`). Recuperación de la fuente editable: `50_documentacion/activa/decisiones/20260619_reconstruccion_app_jsx.md` (s23, c.88): reconstrucción inversa `createElement → JSX` con `babel-plugin-transform-react-createelement-to-jsx` + Prettier, verificada por AST con "EQUIVALENCIA TOTAL".
6. **Qué costó en tamaño.** El peso "antes de C3" **no consta** en lo leído. Consta el después: "2328 kB todos los recursos inline, 0/2 requests de red" (backlog c.87, verificación offline del titular con DevTools). Hoy su `docs/index.html` mide 1.902.667 bytes (`wc -c`); adelgazó después de C3 por retiro de dato muerto del desglose por grado (nota de s16/s17 en la cabecera del generador, L38-45). El costo del paso C3 en sí fue de legibilidad, no de peso: el cuerpo transpilado (~1.417 líneas de `createElement`) es menos legible que el JSX, riesgo que el plan registró y que motivó la reconstrucción de `33_app.jsx` en s23.

### B4 — Traducción a `slep_simce_adecuado` (evidencia y consecuencias, sin plan)

**Archivos que habría que cambiar:**

- `30_procesamiento/33_motor_template.html` — retirar los tres `<script src>` de CDN (React, ReactDOM, Babel, con sus SRI), cambiar el `<script type="text/babel">` a `<script>` normal, y reemplazar el cuerpo JSX de la app por su transpilado `React.createElement`; agregar dos placeholders tipo `__REACT_INLINE__`/`__REACTDOM_INLINE__`.
- `30_procesamiento/33_generar_html.R` — leer los dos `.min.js` vendorizados, validar su presencia y sustituir los placeholders (equivalente a L404-455 del precedente).
- **Archivos nuevos:** `react.production.min.js` y `react-dom.production.min.js` vendorizados (este repo no tiene `10_utils/`; dónde alojarlos es decisión del titular), y una fuente JSX editable equivalente a `33_app.jsx` si se quiere conservar la editabilidad (el precedente la perdió en s21 y la tuvo que reconstruir en s23 — lección directamente aprovechable: versionar la fuente JSX desde el día uno).
- `docs/index.html` — cambia solo al desplegar el build regenerado (gate visual del titular, como siempre).

**Qué pasa con la plantilla como fuente editable:** el JSX **deja de existir dentro del template**. El template pasa a contener código transpilado, y la fuente editable se muda a un archivo JSX hermano. La edición de UI se vuelve un flujo de dos archivos: editar el JSX → transpilar manualmente (`npx babel`, runtime `classic`) → pegar el output en el bloque `<script>` del template → regenerar. En el precedente la transpilación NO ocurre en cada build: es manual y solo cuando la UI cambia.

**Qué se rompería de lo que hoy funciona:**

- El flujo de esta misma sesión — "el titular reemplaza la plantilla a mano con JSX nuevo y Claude regenera" — deja de funcionar tal cual: un reemplazo a mano tendría que venir ya transpilado, o venir como JSX en el archivo fuente más su transpilado en el template. Hoy Babel-en-navegador absorbe el JSX del template; tras la migración, cualquier JSX residual en el template sería error de sintaxis al abrir el motor.
- La revisión por diff del template pierde legibilidad en el cuerpo de la app (~miles de líneas de `createElement`; el precedente evaluó `htm` como paliativo y lo difirió).
- Los SRI actuales desaparecen con los tags de CDN (inline no los necesita; el precedente lo registró como A30).
- A cambio deja de romperse lo que hoy está roto: el motor no abre sin `unpkg.com` (los tres `src` medidos en T4/s29), y `file://` gana la hipótesis de causa del "Unsafe attempt to load URL".

**Riesgo: MEDIO.** Razón: el mecanismo está probado de punta a punta en la cartera (C3 auditado F1-F4 en verde, reconstrucción verificada por AST, incidente del runtime automático ya documentado con su regla A34), así que el riesgo conceptual es bajo; pero la ejecución aquí toca el archivo más grande y más editado del proyecto (4.541 líneas con el JSX entretejido), cambia el flujo de trabajo del titular (aparece un paso manual de transpilación con Node/npx, que hoy no es requisito de nada), y el incidente A34 muestra que la transpilación puede salir mal en silencio si no se fija `runtime: "classic"`. No es ALTO porque no toca datos ni aritmética y es reversible por git; no es BAJO porque cruza el flujo de edición, no solo el artefacto.

## 7. Verificación de invariantes (§2)

| Invariante | Veredicto | Evidencia |
|---|---|---|
| No se despliega; `docs/index.html` no se toca | PASA | md5 en FASE FINAL: `f00e9126b86fc703b001e55080de0969`, idéntico a FASE 0 (`md5 -q`) |
| FASE B no escribe nada en ningún repositorio | PASA | cero comandos de escritura contra `$C`; `git -C $C rev-parse HEAD` → `b709400` antes y después; su único `??` (`40_salidas/categoria_rbd_contrato.parquet`) es preexistente y no fue creado por esta corrida (ningún comando escribió en esa ruta) |
| FASE A edita cero archivos | PASA | solo lecturas y `git diff`; la plantilla sigue ` M` tal como la dejó el titular |
| D3 vendorizado intocado | PASA | no se tocó archivo alguno en ninguno de los dos repos |
| `status --porcelain` antes de cada `git add`; nunca `git add .` | PASA (vacuo) | no hubo ningún `git add` |
| Sin push hasta FASE FINAL y solo del commit de A3 | PASA | no hubo push: el commit de A3 no existe (FASE A congelada) |

Además: el único archivo creado en el árbol del proyecto es este log (§6 del encargo, autorización 5); scratch en `/tmp`: `control_b2.txt`, `control_b2_d3.txt`.

## 8. Dudas y tareas congeladas

**CONGELADA — FASE A completa (A1, A2, A3 y el push de FASE FINAL).**

- **Contexto en una línea:** la plantilla reemplazada a mano contiene, además del rescate de rótulos, cinco bloques ajenos al panorama (hunks 1, 2, 8, 10 y 11 de §4), y la detención de A2 prohíbe publicar un build con bloques no atribuibles al rescate.
- **Pregunta cerrada que la resuelve:** ¿los cinco bloques ajenos (uppercase de `.badge-traspaso` vía CSS + markup `traspaso`, uppercase de `.hero-card-control-label` vía CSS + markup `Nivel`, y el refactor `sembradas`) se commitean junto al rescate con un mensaje que los cubra, se commitean aparte, o se revierten de la plantilla?
- **Qué quedó bloqueado:** el commit de A1, la regeneración de A2, el cierre de A3 y el push. Nada de FASE B dependía de esto.

**Duda registrada, no congelante (FASE 0):** el `status` traía dos `??` más que los enumerados (el `.md` y el log del encargo **anterior** de esta sesión). No son archivos versionados modificados — la condición DETENTE de la tabla — y el propio encargo los cita como fuente (premisas 2 y 5 citan `20260829_verificacion_dudas_s29_log.md`), así que se trataron como estado conocido. La enumeración de FASE 0 podría incluirlos explícitamente la próxima vez.

## 9. Lo que quedó sin verificar y por qué

- **El rescate de rótulos renderizado**: no se abre navegador; ni siquiera existe build con el rescate (FASE A congelada). El gate visual sigue íntegramente en manos del titular.
- **El diff del build (A2)**: no corrió; la atribución de §4 es sobre la fuente. Si el titular resuelve la duda de §8 y se re-ejecuta FASE A, el diff del artefacto debe atribuirse igual (la fuente predice, no reemplaza, esa verificación).
- **La equivalencia visual de los bloques ajenos** (uppercase vía CSS vs texto en mayúsculas): plausible por lectura, no probada — es render, y es del titular.
- **En FASE B**: el comportamiento en runtime del motor del precedente (0 requests) se toma de la verificación offline del titular registrada en su backlog (c.87), no de una ejecución propia; lo medido aquí es el artefacto estático. Y el peso "antes de C3" no consta.

## Auto-auditoría

1. **¿Alguna rama de detención se disparó en el camino nominal?** Sí y no: la detención que se disparó (bloques ajenos en el diff) estaba **bien escrita** — existe exactamente para este caso — pero estaba ubicada en A2, después del commit de A1. Se aplicó antes de A1 porque la evidencia (el diff de la fuente) ya estaba disponible en FASE 0 y commitear primero habría dejado un commit impublicable con mensaje parcial. La lección de redacción: el chequeo de atribución conviene ANTES del commit, no después.
2. **¿Cada cero tiene su control positivo?** Sí — §5, nueve patrones, todos con control ejecutado en el mismo turno.
3. **¿Cada cifra viene del comando que la produjo?** Sí — cada tabla y afirmación cita su comando (`grep -c -F`, `wc`, `md5 -q`, `git diff`, `ls`, `sed -n`) o reproduce la salida literal.
4. **¿Alguna conclusión de FASE B afirma más de lo que su comando midió?** Se cuidó la frontera: lo leído en el código (vendorización, placeholders, 196 `createElement`, ausencia de invocaciones de build) se cita con archivo y línea; lo que es flujo de trabajo (transpilación manual por edición, verificación offline 0-requests) se atribuye a su documentación (`33_app.jsx` L20-27, backlog c.87) y no se presenta como observación propia. El "no carga nada por red al abrirse" de B2 se apoya en el artefacto estático más los ceros controlados; el runtime real lo verificó el titular del precedente, no esta corrida (§9).
