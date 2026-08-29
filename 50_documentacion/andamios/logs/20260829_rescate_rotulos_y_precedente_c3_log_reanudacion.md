# Log — Rescate de rótulos del panorama (reanudación)

> **Encargo:** `50_documentacion/activa/encargos/encargo_rescate_rotulos_y_precedente_c3.md`
> **Corrida:** 2026-08-29, reanudación tras la congelación de FASE A de la corrida anterior
> (log `20260829_rescate_rotulos_y_precedente_c3_log.md`). Modo autónomo secuencial, 0 subagentes.
> **Resolución del titular:** los cinco bloques ajenos eran una REGRESIÓN, revertida en origen;
> la plantilla fue reemplazada a mano de nuevo. FASE B está completa y no se repite.
> Este log queda sin trackear y sin commitear.

---

## 1. Resumen

- **FASE A: COMPLETA.** Commit `3b256e6` con la plantilla como único archivo, build regenerado
  (md5 `d440aa6e6236fb20c40e9e4269f4e46f`), diff del build 100% atribuido al rescate, push
  ejecutado: `HEAD` = `origin/main` = `3b256e6`.
- **`docs/index.html` NO se tocó:** md5 `f00e9126b86fc703b001e55080de0969` antes y después
  (no se desplegó; el gate visual del titular sigue pendiente).
- **Una duda de instrumento registrada, no congelante (§8):** el conteo
  `fmtPctShort(seg.val)` en el build dio 1 contra un esperado de 0; la aparición es
  **preexistente** (idéntica en `4e8f946`) y vive en `RecentBarsSubchart` (vista de
  comparación), fuera del rescate. La intención de la verificación — el rescate usa
  `fmtPct`, con un decimal — quedó probada con la línea del build que lo muestra.

## 2. Inventario del commit de A1

```
3b256e6 fix(motor): rescata bajo el eje el porcentaje de las franjas delgadas del panorama
 30_procesamiento/33_motor_template.html | 48 ++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)
```

(Comando: `git show --stat --oneline HEAD`. Cifras del stat informativas, no criterio.)
Único archivo: la plantilla. Tras el commit no quedó ningún archivo versionado modificado
(`git status --porcelain` → solo los `??` de encargos y logs de la sesión). El mensaje lleva
el trailer `Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>` como segundo `-m`.

## 3. Por tarea: salidas literales y tablas

### FASE 0 — Remedición

Salida literal:

```
--- status ---
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_rescate_rotulos_y_precedente_c3.md
?? 50_documentacion/activa/encargos/encargo_verificacion_dudas_s29.md
?? 50_documentacion/andamios/logs/20260829_rescate_rotulos_y_precedente_c3_log.md
?? 50_documentacion/andamios/logs/20260829_verificacion_dudas_s29_log.md
--- rev-parse ---
4e8f946f0cf6b252c296cf6d545299d25aa139e7
4e8f946f0cf6b252c296cf6d545299d25aa139e7
--- wc -l ---
    4539 /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
--- conteos ---
text-transform -> 0
sembradas -> 0
TRASPASO {s -> 1
>NIVEL< -> 1
ALTO_MIN_ROTULO -> 2
```

| Medición | Esperado | Medido |
|---|---|---|
| `status` | ` M` plantilla + `??` de encargos y logs de la sesión | exactamente eso ✓ |
| `rev-parse` | ambos `4e8f946` | ambos ✓ |
| `wc -l` | 4539 | 4539 ✓ |
| `text-transform` | 0 | 0 ✓ (control positivo §5) |
| `sembradas` | 0 | 0 ✓ (control positivo §5) |
| `TRASPASO {s` / `>NIVEL<` | 1 / 1 | 1 / 1 ✓ (la regresión revertida: markup original de vuelta) |
| `ALTO_MIN_ROTULO` | ≥1 | 2 ✓ |

### Atribución previa al commit (gate de la reanudación)

`git diff -- 30_procesamiento/33_motor_template.html` produjo seis bloques; cada uno cae en
la lista permitida:

| Bloque (línea vieja) | Contenido | Atribución |
|---|---|---|
| `@@ -1823` | `+ valorFuera: 9.5,` | **FS_SVG.panorama** |
| `@@ -3067` | `+ const ALTO_MIN_ROTULO = 15;` con comentario; `H` 300→328, `M.bottom` 46→74 con comentario | **ALTO_MIN_ROTULO** + **PANORAMA_DIMS** |
| `@@ -3158` | `segs` gana `sigla: "A"/"E"/"I"`; `+ const rescatadas = [];` con comentario | **dibujarPanoramaEnGrupo** |
| `@@ -3175` | `if (h >= 15)` → `if (h >= ALTO_MIN_ROTULO)` | **dibujarPanoramaEnGrupo** / **ALTO_MIN_ROTULO** |
| `@@ -3184` | `+ else { rescatadas.push(seg); }` + `rescatadas.forEach` que dibuja `sigla + " " + fmtPct(seg.val)` bajo el eje | **dibujarPanoramaEnGrupo** |
| `@@ -3509` | Frase nueva de la nota: "Cuando una franja es demasiado delgada... bajo el año con la inicial del nivel (A, E o I) en su color." | **nota metodológica de PanoramaSection** |

Ningún bloque fuera de lista → se procedió a A1. Los cinco bloques de la regresión anterior
(uppercase de `.badge-traspaso` y `.hero-card-control-label`, markup `traspaso`/`Nivel`,
refactor `sembradas`) están **ausentes** del diff, consistente con los ceros de FASE 0.

### A1 — Commit

Salida literal en §2. Criterio cumplido: el commit toca exactamente la plantilla; ningún
archivo versionado quedó modificado tras él.

### A2 — Regeneración y verificación por diferencia

```
--- md5 copia previa (/tmp/motor_previo_rescate.html) ---
f00e9126b86fc703b001e55080de0969
[Rscript 33_generar_html.R: OK — 44975 filas, 345 comunas, 36 SLEPs, 9 años,
 JSON 13.6 MB → 2.1 MB gzip+base64, HTML 2561.0 KB; aviso renv esperado]
--- md5 build nuevo ---
d440aa6e6236fb20c40e9e4269f4e46f
--- status tras regenerar ---
(solo los ?? de encargos y logs; el motor generado NO aparece: está en .gitignore)
```

| Medición | Esperado | Medido |
|---|---|---|
| md5 copia previa | `f00e9126b86fc703b001e55080de0969` | idéntico ✓ |
| md5 build nuevo | distinto | `d440aa6e6236fb20c40e9e4269f4e46f` ✓ |
| `diff` | solo bloques del rescate | 8 bloques, todos atribuidos (§4) ✓ |
| `status` | sin el motor generado | ✓ |
| `ALTO_MIN_ROTULO` en build | ≥1 | 2 ✓ |
| `rescatadas` en build | ≥1 | 3 ✓ |
| `fmtPctShort(seg.val)` en build | 0 | **1** — preexistente, fuera del rescate; duda §8 |

### A3 — Cierre de FASE A

No se copió nada a `docs/`. Estado verificado: `docs/index.html` con md5 de FASE 0
(`f00e9126b86fc703b001e55080de0969`), motor generado con md5 nuevo, y exactamente un commit
sobre `4e8f946` (`git log --oneline 4e8f946..HEAD` → `3b256e6`).

### FASE FINAL

```
--- push ---
To https://github.com/tomgc/slep_simce_adecuado.git
   4e8f946..3b256e6  main -> main
--- verificacion ---
status: solo ?? de encargos y logs
rev-parse: 3b256e6c45c7ca04f4ccae6bf0c9b372e31c4fc9 (HEAD y origin/main)
md5 docs/index.html: f00e9126b86fc703b001e55080de0969
```

Estados esperados: todos cumplidos — `HEAD` = `origin/main` tras el push, `docs/index.html`
sin cambiar, `status` sin versionados modificados.

## 4. El diff de A2 íntegro, con atribución bloque a bloque

`diff /tmp/motor_previo_rescate.html $R/40_salidas/motor_comparacion.html` (exit 1 =
hay diferencias, las esperadas). Ningún bloque toca el payload base64 (línea única, ausente
del diff: la fecha de generación es la misma, 2026-08-29, y los datos no cambiaron), ni el
D3 vendorizado, ni la vista de comparación, ni CSS alguno.

| # | Bloque | Contenido | Atribución |
|---|---|---|---|
| 1 | `1827a1828` | `+ valorFuera: 9.5,` | FS_SVG.panorama |
| 2 | `3071a3073,3077` | comentario + `const ALTO_MIN_ROTULO = 15;` | ALTO_MIN_ROTULO |
| 3 | `3073,3074c3079,3084` | `H: 300→328`, `bottom: 46→74`, comentario | PANORAMA_DIMS |
| 4 | `3163,3165c3173,3175` | siglas A/E/I en `segs` | dibujarPanoramaEnGrupo |
| 5 | `3167a3178,3183` | comentario + `const rescatadas = [];` | dibujarPanoramaEnGrupo |
| 6 | `3180c3196` | `h >= 15` → `h >= ALTO_MIN_ROTULO` | dibujarPanoramaEnGrupo / ALTO_MIN_ROTULO |
| 7 | `3188a3205,3206` + `3190a3209,3222` | `else { rescatadas.push(seg); }` + `rescatadas.forEach` con `fmtPct(seg.val)` | dibujarPanoramaEnGrupo |
| 8 | `3514c3546,3548` | frase nueva de la nota metodológica | PanoramaSection |

Diff literal:

```diff
1827a1828
>         valorFuera:       9.5,   // % de una franja demasiado delgada, bajo el eje
3071a3073,3077
>     // Altura mínima que necesita una franja para llevar su porcentaje adentro.
>     // Con el área interna de PANORAMA_DIMS equivale a poco más de 7 puntos
>     // porcentuales; por debajo de eso el valor se rescata bajo el eje.
>     const ALTO_MIN_ROTULO = 15;
> 
3073,3074c3079,3084
<       W: 520, H: 300,
<       M: { top: 40, right: 14, bottom: 46, left: 36 },
---
>       W: 520, H: 328,
>       // El margen inferior reserva, además del año y el N, hasta dos renglones
>       // para los porcentajes de franjas demasiado delgadas para llevar su
>       // rótulo dentro. Dos es el máximo posible: tres franjas bajo el umbral no
>       // pueden sumar 100.
>       M: { top: 40, right: 14, bottom: 74, left: 36 },
3163,3165c3173,3175
<             { val: s.pct,     fill: COLOR_ADEC },
<             { val: s.pct_ele, fill: COLOR_ELEM },
<             { val: s.pct_ins, fill: COLOR_INSUF },
---
>             { val: s.pct,     fill: COLOR_ADEC, sigla: "A" },
>             { val: s.pct_ele, fill: COLOR_ELEM, sigla: "E" },
>             { val: s.pct_ins, fill: COLOR_INSUF, sigla: "I" },
3167a3178,3183
>           // Franjas que no admiten su rótulo adentro. Se rescatan bajo el eje en
>           // vez de perderse: la medición de la sesión 29 mostró que el 11,9% de
>           // los puntos comunales tiene al menos una, y que en 1.529 de 1.614
>           // casos la franja muda es Adecuado. El número que desaparecía era
>           // justamente el más grave de la serie.
>           const rescatadas = [];
3180c3196
<             if (h >= 15) {
---
>             if (h >= ALTO_MIN_ROTULO) {
3188a3205,3206
>             } else {
>               rescatadas.push(seg);
3190a3209,3222
>           // La sigla acompaña al color porque el color solo no basta para
>           // identificar el nivel fuera de su franja. El valor va con un decimal
>           // (fmtPct, no fmtPctShort): redondear 0,2 a "0%" anularía justamente
>           // la cifra que esta línea existe para rescatar.
>           rescatadas.forEach((seg, k) => {
>             g.append("text")
>               .attr("x", xPos + bw / 2).attr("y", ih + 44 + k * 12)
>               .attr("text-anchor", "middle")
>               .attr("font-family", "system-ui, sans-serif")
>               .attr("font-size", FS_SVG.panorama.valorFuera)
>               .attr("font-weight", 700)
>               .attr("fill", seg.fill)
>               .text(seg.sigla + " " + fmtPct(seg.val));
>           });
3514c3546,3548
<               publicado por la Agencia, no un recuento de la fuente.
---
>               publicado por la Agencia, no un recuento de la fuente. Cuando una franja es
>               demasiado delgada para llevar su cifra adentro, el valor aparece bajo el año
>               con la inicial del nivel (A, E o I) en su color.
```

## 5. Controles positivos

| Cero medido | Comando del cero | Control | Resultado |
|---|---|---|---|
| `text-transform` = 0 (plantilla) | `grep -c 'text-transform'` | mismo patrón sobre el log de la corrida anterior, que cita la regresión (`20260829_rescate_rotulos_y_precedente_c3_log.md`) | `4` ✓ |
| `sembradas` = 0 (plantilla) | `grep -c 'sembradas'` | mismo archivo de control | `5` ✓ |
| `fmtPctShort(seg.val)` — esperado 0, midió 1 | `grep -c -F` | doble control: `grep -c -F 'fmtPctShort('` sobre el propio build → `4` (patrón no mudo); cadena exacta en `/tmp/control_a2.txt` → `1` | patrón validado; el 1 medido es real y se atribuye en §8 |

## 6. FASE B

No se repitió (completa en la corrida anterior; ver
`20260829_rescate_rotulos_y_precedente_c3_log.md`, §6).

## 7. Verificación de invariantes (§2 del encargo)

| Invariante | Veredicto | Evidencia |
|---|---|---|
| No se despliega; `docs/index.html` no se toca | PASA | md5 `f00e9126b86fc703b001e55080de0969` en FASE 0, A3 y FASE FINAL (`md5 -q`, tres mediciones) |
| FASE B no escribe | PASA (vacuo) | FASE B no se ejecutó en esta corrida |
| FASE A edita cero archivos | PASA | ningún Edit/Write sobre versionados; la plantilla venía reemplazada por el titular; únicos escritos: este log y scratch en `/tmp` |
| D3 vendorizado intocado | PASA | ausente del diff de A2 (§4) |
| `status --porcelain` antes de cada `git add`; nunca `git add .` | PASA | un único `git add -- 30_procesamiento/33_motor_template.html`, precedido del status de FASE 0 y seguido de status de verificación |
| Push solo en FASE FINAL, solo del commit de A1 | PASA | un único push, `4e8f946..3b256e6 main -> main` |

## 8. Dudas y tareas congeladas

**Tareas congeladas: ninguna.**

**Duda registrada, no congelante — el cero de `fmtPctShort(seg.val)`:**

- **Contexto en una línea:** A2 esperaba 0 apariciones de `fmtPctShort(seg.val)` en el build
  y midió 1 (línea 2465).
- **Pregunta cerrada que la resuelve:** ¿esa aparición viene del rescate? **No.** Evidencia:
  (a) está también en el build previo (línea 2464 de `/tmp/motor_previo_rescate.html`),
  (b) está en la plantilla de `4e8f946` (línea 2462, vía `git show`), (c) el diff de A2 no
  contiene ningún bloque cerca de esa línea (el corrimiento 2462→2463→2465 lo explican las
  inserciones de los bloques 1 y 2, muy por encima), y (d) pertenece a
  `RecentBarsSubchart` (plantilla L2363), las barras apiladas de la **vista de comparación**,
  con su propio umbral `h >= 16` y `FS_SVG.barras.valorSegmento` — uso interno legítimo de
  `fmtPctShort` para rótulos dentro de barra, igual que el del panorama.
- **Lo que la verificación quería probar quedó probado:** el único `.text()` nuevo del
  rescate usa `fmtPct(seg.val)` (build L3221, bloque 7 del diff §4); ningún valor rescatado
  pasa por `fmtPctShort`.
- **Por qué no congeló:** el esperado-0 estaba midiendo el archivo completo cuando su
  intención (declarada en el propio encargo: "los valores rescatados usan fmtPct") es local
  al bloque rescatado; la aparición extra es preexistente e idéntica a la que hoy sirve
  `docs/index.html` en producción. Congelar habría dejado un commit local sin publicar por
  un instrumento demasiado ancho, contra la instrucción expresa de la reanudación. Mismo
  patrón ya registrado dos veces en esta sesión (estado esperado de T4; `??` de FASE 0).
- **Sin acción pendiente sobre el producto.** La corrección de redacción del encargo (acotar
  el patrón al bloque del rescate, p. ej. buscando `sigla + " + fmtPctShort"`) es del titular.

## 9. Lo que quedó sin verificar y por qué

- **El rescate renderizado:** no se abre navegador. El gate visual (R5) es del titular:
  franjas delgadas con su `A/E/I + valor` bajo el eje, hasta dos renglones, en pantalla y en
  el SVG exportado (mismo código de dibujo, pero el render real no fue visto por mí).
- **El despliegue:** `docs/index.html` sigue siendo el build anterior; publicar el rescate
  (copiar el build nuevo a `docs/` y commitear) queda pendiente del gate visual.
- **El comportamiento del margen nuevo (`H: 328`) en los layouts que consumen el SVG del
  panorama:** aritmética verificada por lectura (dos renglones caben en `bottom: 74`), no
  renderizada.

## Auto-auditoría

1. **¿Alguna rama de detención se disparó en el camino nominal?** El gate de atribución
   previa al commit pasó limpio (seis bloques, todos en lista). La única desviación fue el
   esperado-0 de `fmtPctShort(seg.val)` en A2, que resultó estar mal calibrado (medía el
   archivo completo, no el rescate): estaba mal escrita la expectativa, no la verificación,
   y se resolvió con evidencia de preexistencia en vez de congelar (§8).
2. **¿Cada cero tiene su control positivo?** Sí (§5): `text-transform` y `sembradas` contra
   el log que cita la regresión; el patrón `fmtPctShort(seg.val)` validado por partida doble
   aunque no dio cero.
3. **¿Cada cifra viene del comando que la produjo?** Sí: cada tabla cita su comando y las
   salidas literales están en §3 y §4.
4. **¿Alguna conclusión afirma más de lo que su comando midió?** La frontera quedó
   declarada: el diff prueba qué cambió en los bytes; que el rescate se vea bien es render y
   sigue sin verificar (§9). La atribución del 1 de `fmtPctShort(seg.val)` se apoya en
   cuatro mediciones independientes (dos builds, dos versiones de la plantilla), no en
   inferencia.
