# Log — Correcciones derivadas del diagnóstico D1–D3

**Fecha:** 2026-08-27
**Encargo:** `50_documentacion/activa/encargos/encargo_correcciones_d1_d3.md`
**Archivo editado:** `30_procesamiento/33_motor_template.html` (único)
**Resultado:** ejecutado completo. Tres commits de corrección más el del log.
**Push:** no se hizo.

---

## 1. FASE 0 — Medición (salida literal)

### `git status --short --branch`

```
## main...origin/main
?? 50_documentacion/activa/encargos/encargo_correcciones_d1_d3.md
```

### `git log --oneline -1`

```
dbd729b deploy(pages): publica motor con la escala tipografica del SVG en constantes
```

### `git diff --name-only` (cláusula residual: versionados modificados)

```
(vacío)
```

### `git ls-files --others --exclude-standard -- 30_procesamiento 40_salidas`

```
(vacío)
```

### `date "+%Y-%m-%d %H:%M:%S %Z"`

```
2026-08-27 11:18:52 -04
```

**Estados esperados: cumplidos.** `main` en `dbd729b`, cero archivos versionados
modificados, cero untracked bajo `30_procesamiento/` o `40_salidas/`. El único
untracked es el propio archivo de encargo, bajo `50_documentacion/`, que el
encargo declara como reportable y no detiene. **Ninguna cláusula residual se
disparó.**

### `grep -n "ver establecimientos" 30_procesamiento/33_motor_template.html`

```
1648:                {`ver establecimientos (${contarEstablecimientos(entity, nivel, prueba) ?? "…"}) ▸`}
```

### `grep -n -A8 "^\.entity-estab-btn" 30_procesamiento/33_motor_template.html`

```
1023:.entity-estab-btn {
1024-  display: inline-flex; align-items: center; gap: 4px;
1025-  font-size: var(--fs-overline); color: var(--fg-3); cursor: pointer;
1026-  background: transparent; border: 0; padding: 0;
1027-  font-family: var(--font-body);
1028-  white-space: nowrap;
1029-}
1030:.entity-estab-btn:hover { color: var(--ocean); text-decoration: underline; }
```

### `grep -n -A8 "^\.entity-text" 30_procesamiento/33_motor_template.html`

```
300:.entity-text { display: flex; flex-direction: column; line-height: 1.1; }
301-.entity-name {
302-  font-family: var(--font-body);
303-  font-weight: 700; font-size: var(--fs-body); color: var(--fg-1);
304-  overflow-wrap: anywhere;
305-}
306-.entity-meta { font-size: var(--fs-overline); color: var(--fg-3); margin-top: 2px; font-weight: 500; }
```

### `grep -n -A6 "^\.entity-chip" 30_procesamiento/33_motor_template.html`

```
289:.entity-chip {
290-  display: inline-flex; align-items: flex-start; gap: 8px;
291-  padding: 6px 8px 6px 10px;
292-  background: var(--paper);
293-  border: 1px solid var(--border-2);
294-  border-radius: var(--radius-2);
295-  transition: border-color 120ms ease;
296-  max-width: 250px; flex: 0 1 auto;
```

### `grep -n -A30 "function exportarGraficosPNG" 30_procesamiento/33_motor_template.html`

```
2653:    function exportarGraficosPNG({ entities, nivel, prueba }) {
2654-      const { svgStr, totalW, totalH, fnameBase } = construirSvgGraficos({ entities, nivel, prueba });
2655-      const svgBlob = new Blob([svgStr], { type: "image/svg+xml;charset=utf-8" });
2656-      const url = URL.createObjectURL(svgBlob);
2657-      const img = new Image();
2658-      img.onload = () => {
2659-        const canvas = document.createElement("canvas");
2660-        canvas.width = totalW * PNG_SCALE;
2661-        canvas.height = totalH * PNG_SCALE;
2662-        const ctx = canvas.getContext("2d");
2663-        ctx.scale(PNG_SCALE, PNG_SCALE);
2664-        ctx.drawImage(img, 0, 0, totalW, totalH);
2665-        URL.revokeObjectURL(url);
2666-        canvas.toBlob(blob => {
2667-          if (!blob) { alert("No se pudo generar el PNG."); return; }
2668-          descargarBlob(blob, fnameBase + ".png");
2669-        }, "image/png");
2670-      };
2671-      img.onerror = () => {
2672-        URL.revokeObjectURL(url);
2673-        alert("No se pudo rasterizar el SVG a PNG.");
2674-      };
2675-      img.src = url;
2676-    }
```

### `grep -n "slice(0, MAX_ENTIDADES)" 30_procesamiento/33_motor_template.html`

```
3343:        return slep.comunas.slice(0, MAX_ENTIDADES).map((cod, i) => {
```

### `grep -n "MAX_ENTIDADES" 30_procesamiento/33_motor_template.html`

```
1471:    const MAX_ENTIDADES = 5;
1664:            <span className="entities-count">{entities.length} de {MAX_ENTIDADES} activos</span>
1678:            {entities.length < MAX_ENTIDADES && (
3312:          if (prev.length >= MAX_ENTIDADES) { alert(`Máximo de comparación: ${MAX_ENTIDADES} territorios. Elimina uno antes de agregar otro.`); return prev; }
3322:          const libres = MAX_ENTIDADES - prev.length;
3337:      // se localiza por coincidencia normalizada. Respeta el tope MAX_ENTIDADES.
3343:        return slep.comunas.slice(0, MAX_ENTIDADES).map((cod, i) => {
3541:              slotsLibres={MAX_ENTIDADES - entities.length}
```

### Baselines tomados para poder juzgar los deltas después

```
text-overflow: ellipsis  ->  0   (grep -c "text-overflow: ellipsis")
white-space: nowrap      ->  6   (grep -c "white-space: nowrap")
try {                    ->  0   (grep -c "try {")
min-width: 0             ->  6   (grep -c "min-width: 0")
max-width: 250px         ->  1   (grep -n "max-width: 250px", linea 296)
```

### Premisa 7, re-medida

```
comunas: 4 | MAX_ENTIDADES = 5 => slice no trunca
  cod_com_rbd  nom_com_rbd
1        5103       CONCÓN
2        5105   PUCHUNCAVÍ
3        5107     QUINTERO
4        5109 VIÑA DEL MAR
```

(`Rscript -e '… arrow::read_parquet(here::here("40_salidas","intermedios","sleps_chile.parquet")) … filter(grepl("costa central", tolower(nombre_slep))) … distinct(cod_com_rbd, nom_com_rbd)'`)

### Tabla de FASE 0 — veredicto de cada premisa

| Premisa | Valor esperado | Valor medido | Veredicto |
|---|---|---|---|
| 1 — árbol limpio, `main` en `dbd729b` | limpio + un untracked del encargo | `dbd729b`, 0 versionados modificados, 1 untracked bajo `50_documentacion/` (`git status --short --branch`, `git diff --name-only`) | **Reproducida** |
| 2 — `.entity-chip` con `max-width: 250px`, ≈150 px para `.entity-text` | 250px | `max-width: 250px` en línea 296 (`grep -n -A6 "^\.entity-chip"`). Los ≈150 px se derivan del CSS medido, no de una medición de pantalla | **Reproducida** |
| 3 — texto más largo `ver establecimientos (8325) ▸`, 29 caracteres | 29 | plantilla literal confirmada en línea 1648; el conteo de 29 caracteres viene del diagnóstico D3 y no se re-midió aquí porque el encargo no lo pide | **Reproducida** |
| 4 — `nowrap` sin `overflow` en ancestros ⇒ desborde, no recorte | así | `white-space: nowrap` en 1028; `.entity-text` (300) y `.entity-chip` (289-296) sin `overflow`; `text-overflow: ellipsis` = 0 en todo el archivo | **Reproducida** |
| 5 — `toBlob` sin `try/catch` | sin | `grep -c "try {"` = **0** en todo el archivo; bloque 2653-2676 sin manejo | **Reproducida** |
| 6 — `slice(0, MAX_ENTIDADES)` trunca en silencio | así | línea 3343, sin comparación previa ni aviso (`grep -n "slice(0, MAX_ENTIDADES)"`) | **Reproducida** |
| 7 — Costa Central tiene 4 comunas | 4 | 4 (`sleps_chile.parquet`, `n_distinct(cod_com_rbd)`) | **Reproducida** |

Las siete premisas se reprodujeron sin excepción. No hubo que trabajar sobre nada
distinto de lo previsto.

---

## 2. COMMIT 1 — El enlace de establecimientos deja de desbordar

### Qué se cambió

**a) JSX (1651-1657).** Rótulo y flecha en elementos separados. El conteo no se
tocó: sigue siendo `contarEstablecimientos(...)` crudo, sin formato de miles,
como pide el encargo.

```jsx
            {hasEstabs && (
              <button className="entity-estab-btn" onClick={onShowEstab}>
                <span className="entity-estab-label">
                  {`ver establecimientos (${contarEstablecimientos(entity, nivel, prueba) ?? "…"})`}
                </span>
                <span className="entity-estab-arrow">▸</span>
              </button>
            )}
```

**b) `.entity-text` gana `min-width: 0`** (línea 300):

```
.entity-text { display: flex; flex-direction: column; line-height: 1.1; min-width: 0; }
```

**c) y d) La regla del botón, el rótulo y la flecha** (1023-1035):

```
.entity-estab-btn {
  display: flex; align-items: center; gap: 4px; max-width: 100%;
  font-size: var(--fs-overline); color: var(--fg-3); cursor: pointer;
  background: transparent; border: 0; padding: 0;
  font-family: var(--font-body);
  white-space: nowrap;
}
.entity-estab-btn:hover { color: var(--ocean); text-decoration: underline; }
/* El rotulo se recorta con puntos suspensivos cuando el contador es largo;
   la flecha nunca encoge, para que no quede huerfana en otra linea. El
   nowrap del boton es lo que impide ese quiebre, y por eso se conserva. */
.entity-estab-label { overflow: hidden; text-overflow: ellipsis; min-width: 0; }
.entity-estab-arrow { flex-shrink: 0; }
```

### Verificación con rama de detención (salida literal)

```
### grep -c "text-overflow: ellipsis"   (antes 0)
1

### grep -c "white-space: nowrap"   (baseline 6)
6

### RAMA DE DETENCION: nowrap dentro de la regla del boton
PRESENTE — no detiene
```

La rama de detención se comprobó de forma acotada al bloque de la regla, no
contra el archivo entero:

```bash
awk '/^\.entity-estab-btn \{/,/^\}/' 30_procesamiento/33_motor_template.html | grep -q "white-space: nowrap"
```

Un `grep -c` global habría dado un número correcto por la razón equivocada: el
`nowrap` podría haberse conservado en cualquier otra de las seis reglas y la
comprobación habría pasado igual. El `awk` acota a la regla que importa.

### Decisión 1 — reescribir un comentario que falseaba el instrumento

**Qué pasó.** La primera versión del comentario CSS contenía la secuencia literal
`white-space: nowrap`. Eso subió `grep -c "white-space: nowrap"` de 6 a **7** sin
que se hubiera añadido ninguna declaración: el comentario contaminaba el conteo.

**Decisión.** Reescribir el comentario para que diga "nowrap del boton" en vez de
la propiedad completa. El conteo volvió a **6**, igual que el baseline.

**Fundamento.** Es exactamente la falla A-s28-2 documentada en
`50_documentacion/activa/50_diseno_ramas_deteccion.md`: el instrumento mide una
cosa y se lee como si midiera otra. Dejar el comentario habría sembrado un falso
positivo permanente para cualquier auditoría futura que contara declaraciones de
`nowrap`.

**Alternativa descartada.** Dejar el comentario y anotar en el log que el 7
incluye una ocurrencia en comentario. Se descartó porque el log no viaja con el
archivo: quien corra el `grep` dentro de seis meses no lo tendrá delante.

### Tabla del COMMIT 1

| Medición | Valor esperado | Valor medido | Veredicto |
|---|---|---|---|
| `text-overflow: ellipsis` | ≥1 | 1 (`grep -c "text-overflow: ellipsis"`) | OK |
| `white-space: nowrap` total | 6, sin cambio | 6 (`grep -c "white-space: nowrap"`) | OK |
| `nowrap` dentro de la regla del botón | presente | presente (`awk '/^\.entity-estab-btn \{/,/^\}/' … \| grep -q`) | OK, rama no disparada |
| `.entity-text` con `min-width: 0` | sí | sí, línea 300 (`grep -n "^\.entity-text"`) | OK |
| Rótulo y flecha separados | 2 elementos | 2 spans, líneas 1653 y 1656 (`grep -n -B3 -A6 "entity-estab-label"`) | OK |
| Comentario CSS sin `*/` interno | sí | sí, verificado con `awk` sobre el bloque | OK |

**Hash: `8503745`** — `fix(motor): el enlace de establecimientos se recorta en vez de desbordar la tarjeta`

---

## 3. COMMIT 2 — La exportación a PNG deja de poder fallar en silencio

### Bloque completo después del commit (salida literal de `grep -n -A45`)

```
2660:    const PNG_SCALE = 2;
2661-    // Techo conservador de superficie de canvas de Safari. Por encima de esta
2662-    // area el navegador no avisa: devuelve un canvas en blanco o lanza al
2663-    // serializar. Se comprueba antes de crear el canvas, para poder explicarle
2664-    // la causa al usuario en vez de fallar sin motivo aparente.
2665:    const PNG_MAX_SUPERFICIE_PX = 16777216;
2666:    function exportarGraficosPNG({ entities, nivel, prueba }) {
2667-      const { svgStr, totalW, totalH, fnameBase } = construirSvgGraficos({ entities, nivel, prueba });
2668-      const svgBlob = new Blob([svgStr], { type: "image/svg+xml;charset=utf-8" });
2669-      const url = URL.createObjectURL(svgBlob);
2670-      // Un solo punto de liberacion: el catch no puede saber si el camino
2671-      // feliz alcanzo a liberar la URL antes de fallar.
2672-      let urlLiberada = false;
2673-      const liberarUrl = () => {
2674-        if (!urlLiberada) { URL.revokeObjectURL(url); urlLiberada = true; }
2675-      };
2676-      const img = new Image();
2677-      img.onload = () => {
2678-        // canvas.toBlob puede lanzar de forma sincrona (canvas contaminado,
2679-        // superficie rechazada). Sin este try/catch la excepcion escapa del
2680-        // manejador de eventos y el usuario no recibe ni alerta ni archivo.
2681-        try {
2682-          const superficie = (totalW * PNG_SCALE) * (totalH * PNG_SCALE);
2683-          if (superficie > PNG_MAX_SUPERFICIE_PX) {
2684-            liberarUrl();
2685-            alert(
2686-              "Demasiados territorios para exportar a PNG en esta escala: la imagen pedida son " +
2687-              Math.round(superficie / 1e6) + " millones de píxeles y el máximo seguro son " +
2688-              Math.round(PNG_MAX_SUPERFICIE_PX / 1e6) + ". Exporta en SVG, que no tiene ese límite."
2689-            );
2690-            return;
2691-          }
2692-          const canvas = document.createElement("canvas");
2693-          canvas.width = totalW * PNG_SCALE;
2694-          canvas.height = totalH * PNG_SCALE;
2695-          const ctx = canvas.getContext("2d");
2696-          ctx.scale(PNG_SCALE, PNG_SCALE);
2697-          ctx.drawImage(img, 0, 0, totalW, totalH);
2698-          liberarUrl();
2699-          canvas.toBlob(blob => {
2700-            if (!blob) { alert("No se pudo generar el PNG."); return; }
2701-            descargarBlob(blob, fnameBase + ".png");
2702-          }, "image/png");
2703-        } catch (e) {
2704-          liberarUrl();
2705-          alert("No se pudo generar el PNG: " + ((e && e.message) ? e.message : e));
2706-        }
2707-      };
2708-      img.onerror = () => {
2709-        liberarUrl();
2710-        alert("No se pudo rasterizar el SVG a PNG.");
2711-      };
```

```
### grep -c "try {"   (baseline 0)
1
```

### Decisión 2 — un solo punto de liberación de la URL, con bandera

**Ambigüedad.** El encargo pide que el `catch` "libere la URL del objeto si aún
no se liberó". Doble `URL.revokeObjectURL` sobre la misma URL es inofensivo en la
práctica, así que se podía llamar sin más.

**Decisión.** Introducir `urlLiberada` y `liberarUrl()`, y usarlo en los cuatro
sitios (límite de superficie, camino feliz, `catch`, `onerror`).

**Fundamento.** El encargo dice "si aún no se liberó", que es literalmente una
condición. Una bandera la expresa; una llamada incondicional la ignora y funciona
por accidente. Además centraliza: antes había dos `URL.revokeObjectURL` sueltos y
ahora hay un solo punto, que es lo que hace tratable añadir caminos de salida.

**Alternativa descartada.** `URL.revokeObjectURL(url)` incondicional en el
`catch`. Se descartó por lo anterior.

### Decisión 3 — el límite se declara en px², no en ancho o alto

**Ambigüedad.** El encargo pide comparar `totalW * PNG_SCALE * totalH * PNG_SCALE`
contra una constante nombrada. Safari también tiene topes por dimensión, no solo
por área.

**Decisión.** Implementar exactamente lo pedido: superficie en px² contra
`PNG_MAX_SUPERFICIE_PX = 16777216`.

**Fundamento.** Es lo que el encargo autoriza, y el tope de área es el que muerde
primero en este layout, que crece a lo ancho al añadir territorios pero mantiene
el alto fijo. Añadir topes por dimensión sería corregir de más.

**Alternativa descartada.** Comprobar también `canvas.width` y `canvas.height`
contra un máximo por lado. Se descartó por lo anterior; queda anotado como
mejora posible si algún día el alto también crece.

### Cuándo se dispara el límite, medido

Simulación con las constantes reales de `construirSvgGraficos` —`COL_GSE = 110`,
`CELL_W = 340`, `COL_GAP = 10` (línea 2449), `CELL_H = SPARK_H + BARS_H + 30`,
`HEADER_H = 72`, `TITLE_H = 56`, `PAD = 20`, fórmulas de `totalW`/`totalH` en
2455-2456— y 5 niveles GSE (medidos: `n_distinct(cod_grupo)` = 5 en
`simce_comunal.parquet`):

```
1 territorio(s): 490x1593 px -> superficie 3.122.280 px2  bajo el limite
2 territorio(s): 840x1593 px -> superficie 5.352.480 px2  bajo el limite
3 territorio(s): 1190x1593 px -> superficie 7.582.680 px2  bajo el limite
4 territorio(s): 1540x1593 px -> superficie 9.812.880 px2  bajo el limite
5 territorio(s): 1890x1593 px -> superficie 12.043.080 px2  bajo el limite

limite PNG_MAX_SUPERFICIE_PX = 16.777.216 px2
```

**Conclusión que conviene registrar sin adornos:** con el layout actual, **la
guarda no se dispara nunca**, ni siquiera con los 5 territorios del tope. El caso
máximo alcanzable usa el 72% del límite (12.043.080 / 16.777.216). La guarda es
una red para crecimiento futuro del layout —más niveles GSE, celdas más altas,
una escala PNG mayor—, no el arreglo de un fallo hoy alcanzable. El fallo hoy
alcanzable es el otro: el `try/catch`.

### Tabla del COMMIT 2

| Medición | Valor esperado | Valor medido | Veredicto |
|---|---|---|---|
| `try {` en el template | ≥1 | 1 (`grep -c "try {"`) | OK |
| Constante nombrada de superficie | presente con comentario | `PNG_MAX_SUPERFICIE_PX` en 2665, comentario en 2661-2664 (`grep -n -B5 "const PNG_MAX_SUPERFICIE_PX"`) | OK |
| `exportarGraficosSVG` intacta | sin cambios | no aparece en `git diff -U0` | OK |
| `construirSvgGraficos` intacta | sin cambios | no aparece en `git diff -U0` | OK |
| Sintaxis del bloque | válida | válida (`node --check` sobre 2660-2714) | OK |
| Balance de llaves del archivo | igual en `{` y `}` | 1041 y 1041 (`python3 -c "…count…"`) | OK |

**Hash: `a8386e6`** — `fix(motor): la exportacion PNG avisa al fallar y ante superficie excesiva`

---

## 4. COMMIT 3 — La siembra por defecto deja de truncarse en silencio

### Qué se cambió, texto literal

```
      // Estado por defecto del motor: las comunas del SLEP Costa Central con
      // dependencia Servicio Local (depe2="5"). Se derivan EN RUNTIME desde
      // SimceData.SLEPS (sin hardcodear cod_com ni cod_slep); el nombre del SLEP
      // se localiza por coincidencia normalizada.
      // Si el SLEP no aparece, devuelve [] y no rompe el render.
      //
      // Relacion con el tope de comparacion. La siembra queda acotada por
      // MAX_ENTIDADES, y ese acoplamiento no se puede eliminar: el tablero no
      // admite mas territorios de los que caben en la comparacion. Lo que si
      // se corrige aqui es el silencio: si el SLEP tuviera mas comunas que el
      // tope, la funcion sembraba un territorio incompleto sin ninguna senal.
      // Hoy no hay truncamiento, porque Costa Central tiene 4 comunas.
      function entidadesPorDefecto() {
        const norm = s => String(s).toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "");
        const slep = SimceData.SLEPS.find(s => norm(s.nombre).includes("costa central"));
        if (!slep) return [];
        const nComunas = slep.comunas.length;
        const sembradas = Math.min(nComunas, MAX_ENTIDADES);
        if (nComunas > MAX_ENTIDADES) {
          console.warn(
            `entidadesPorDefecto: el SLEP "${slep.nombre}" tiene ${nComunas} comunas y se sembraron ` +
            `${sembradas}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
            `El territorio por defecto queda incompleto.`
          );
        }
        return slep.comunas.slice(0, MAX_ENTIDADES).map((cod, i) => {
```

### Evidencia de que el comportamiento observable NO cambió

Esta es la comprobación que el encargo señala como la que importa, y se hizo de
tres formas independientes.

**Primera: el tope sigue en 5.**

```
### grep -c "MAX_ENTIDADES = 5"   (esperado 1)
1
### grep -n "const MAX_ENTIDADES"
1476:    const MAX_ENTIDADES = 5;
```

La rama de detención "**DETENTE** si el valor del tope cambió" no se disparó.

**Segunda: las líneas que gobiernan lo observable están intactas.**

```
3396:        return slep.comunas.slice(0, MAX_ENTIDADES).map((cod, i) => {
1672:            <span className="entities-count">{entities.length} de {MAX_ENTIDADES} activos</span>
```

El `slice` es idéntico al de FASE 0 y el contador también. Solo cambió su número
de línea, por el desplazamiento de los commits 1 y 2.

**Tercera: ejecución de la lógica añadida, aislada, con los datos reales.**

```
(sin advertencia) Costa Central: 4 comunas, sembradas 4
caso real hoy   -> devuelve 4 entidades
entidadesPorDefecto: el SLEP "SLEP Grande" tiene 7 comunas y se sembraron 5; el tope de comparacion (MAX_ENTIDADES) es 5. El territorio por defecto queda incompleto.
caso hipotetico -> devuelve 5 entidades
```

Con las 4 comunas reales de Costa Central: **ninguna advertencia y 4 entidades**,
que es exactamente lo que devolvía antes. La advertencia solo aparece en el caso
hipotético de un SLEP con más comunas que el tope, que es el defecto que se venía
a corregir. El invariante del encargo —arranque con 4 comunas y contador en "4 de
5 activos"— se conserva por construcción.

### Decisión 4 — la advertencia no nombra `MAX_ENTIDADES = ` en su texto

**Ambigüedad.** El mensaje tenía que decir cuál es el tope. La redacción natural
era `` `MAX_ENTIDADES = ${MAX_ENTIDADES}` ``.

**Decisión.** Redactar `el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}`.

**Fundamento.** La FASE FINAL verifica `grep -c "MAX_ENTIDADES = 5"` esperando
**1**. La redacción natural inserta la subcadena `MAX_ENTIDADES = ` en el archivo
y, aunque en este caso concreto no habría producido un falso positivo porque va
seguida de `${`, deja el archivo a un carácter de romper una verificación que el
proyecto usa. Mismo criterio que la decisión 1.

**Alternativa descartada.** La redacción natural, anotando la sutileza en el log.
Descartada por la misma razón: el log no viaja con el archivo.

### Tabla del COMMIT 3

| Medición | Valor esperado | Valor medido | Veredicto |
|---|---|---|---|
| `MAX_ENTIDADES = 5` en el template | 1 | 1 (`grep -c "MAX_ENTIDADES = 5"`) | OK, rama no disparada |
| `slice(0, MAX_ENTIDADES)` intacto | sí | sí, línea 3396 (`grep -n "slice(0, MAX_ENTIDADES)"`) | OK |
| Contador "de N activos" intacto | sí | sí, línea 1672 | OK |
| Siembra con 4 comunas | 4 entidades, sin aviso | 4 entidades, sin aviso (ejecución aislada en node) | OK |
| Siembra con 7 comunas hipotéticas | 5 entidades, con aviso | 5 entidades, con aviso | OK |
| Sintaxis de la función | válida | válida (`node --check` sobre 3383-3407) | OK |
| Balance de llaves del archivo | igual | 1046 y 1046 | OK |

**Hash: `72372b0`** — `chore(motor): declara y advierte el truncamiento de la siembra por defecto`

---

## 5. FASE FINAL — Regeneración y verificación

### Control positivo

```
### md5 del build en disco ANTES de regenerar
79921d5efbe8667e8ac10dc8cfceba75
CONTROL POSITIVO OK: la comparacion de md5 conserva su punto de referencia
```

### `Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'`

```
- The project is out-of-sync -- use `renv::status()` for details.
here() starts at /Users/tomgc/Projects/slep_simce_adecuado
[1] Cargando insumos...
    simce_comunal.parquet: 44975 filas
    comunas_chile.parquet: 345 comunas
    sleps_chile.parquet:   2337 filas (36 SLEPs)
    establecimientos_chile.parquet: 10945 establecimientos
[2] Construyendo JSON...
    JSON listo: 13597252 caracteres (13.6 MB sin comprimir).
    JSON comprimido: 2.1 MB (gzip+base64, 15.4% del plano).
[3] Leyendo plantilla, D3 y pako...
    Plantilla: 158191 caracteres
    D3:        279702 caracteres (273 KB)
    pako:      46858 caracteres (46 KB)
[4] Construyendo HTML final...
    OK: 40_salidas/motor_comparacion.html (2522 KB)

=== Resumen ===
  Filas en JSON: 44975
  Comunas:       345
  Regiones:      16
  SLEPs:         36 (2337 RBDs)
  Establec.:     10945 RBDs distintos
  RBDs×nivel:    17983 filas (catálogo popup)
  RBDs×GSE:      29277 filas (catálogo popup celda)
  simce_rbd:     140345 filas (datos por establecimiento)
  Años:          9 (2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025)
  Peso HTML:     2521.5 KB

33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
### exit: 0
```

La plantilla pasó de 155.275 a 158.191 caracteres, coherente con las tres
correcciones. El aviso de `renv` fuera de sincronía es el heredado del encargo de
entorno, que sigue detenido; no impidió nada.

### Verificaciones (salida literal)

```
### md5 antes:  79921d5efbe8667e8ac10dc8cfceba75
### md5 despues: 7dd16d922182df69e21ddb422a005bc7

### grep -c "fontSize: *[0-9]"   (esperado 0)
0

### grep -o "font-size: *[0-9.]*px" | sort | uniq -c   (esperado vacio)
(fin del listado)

### grep -c "MAX_ENTIDADES = 5"   (esperado 1)
1

### grep -o 'attr("font-size", *[0-9.]*)' | sort | uniq -c   (esperado 1, la del vendor)
   1 attr("font-size",10)
(fin del listado)

### git status --short
?? 50_documentacion/activa/encargos/encargo_correcciones_d1_d3.md

### git log --oneline -4
72372b0 chore(motor): declara y advierte el truncamiento de la siembra por defecto
a8386e6 fix(motor): la exportacion PNG avisa al fallar y ante superficie excesiva
8503745 fix(motor): el enlace de establecimientos se recorta en vez de desbordar la tarjeta
dbd729b deploy(pages): publica motor con la escala tipografica del SVG en constantes
```

### Control positivo adicional: las tres correcciones llegaron al producto

El encargo no lo pide, pero verificar que el generador reescribió es distinto de
verificar que reescribió **con estos cambios**. Un md5 nuevo lo produce cualquier
diferencia.

```
entity-estab-label           2
entity-estab-arrow           2
text-overflow: ellipsis      1
PNG_MAX_SUPERFICIE_PX        3
urlLiberada                  2
entidadesPorDefecto: el SLEP 1
```

(`grep -c -F "<patrón>" 40_salidas/motor_comparacion.html` para cada uno.)

### Tabla de la FASE FINAL

| Criterio | Valor esperado | Valor medido | Veredicto |
|---|---|---|---|
| Generador | exit 0 | exit 0, "OK. Producto en 40_salidas/motor_comparacion.html" | OK |
| md5 | distinto del previo | `79921d5e…` → `7dd16d92…` (`md5 -q`) | OK |
| `fontSize: <núm>` | 0 | 0 (`grep -c "fontSize: *[0-9]"`) | OK |
| `font-size: Npx` | listado vacío | vacío (`grep -o … \| sort \| uniq -c`) | OK |
| `MAX_ENTIDADES = 5` | 1 | 1 (`grep -c "MAX_ENTIDADES = 5"`) | OK |
| `attr("font-size", <núm>)` | 1, la del D3 minificado | 1, `attr("font-size",10)` | OK |
| `git status --short` | solo lo declarado | solo el encargo untracked | OK |

Ninguna rama de detención de la FASE FINAL se disparó.

---

## 6. Qué quedó sin verificar

- **El recorte del enlace en pantalla.** No se abre navegador. Que
  `text-overflow: ellipsis` esté declarado y que la cadena de `min-width: 0`
  llegue desde `.entity-text` hasta `.entity-estab-label` es condición necesaria
  del recorte, pero **no** es la observación del recorte. Falta ver una tarjeta
  con contador de cuatro dígitos.
- **Que la flecha no quede huérfana.** Mismo motivo. `flex-shrink: 0` y el
  `nowrap` conservado lo hacen esperable; no está visto.
- **El aviso del PNG y su rasterización.** Ni el `catch` ni el aviso de superficie
  se ejecutaron en navegador. Lo que sí se verificó: la sintaxis (`node --check`)
  y que la guarda de superficie **no se dispara** con el layout actual, medido en
  la simulación de §3. El `catch` cubre el modo de falla que el diagnóstico D2
  identificó como el único hoy alcanzable, pero no se provocó.
- **Que el `console.warn` aparezca en la consola del navegador.** Se ejecutó la
  lógica aislada en node, no dentro del motor. Y con los datos reales la rama ni
  siquiera se recorre: hoy es código latente por diseño.
- **El caso de 8325 establecimientos.** No se construyó un grupo de 345 comunas
  para ver el recorte con el contador más largo posible. El diagnóstico D3 dejó
  establecido que ese caso es alcanzable; aquí no se reprodujo.
- **`renv::status()` sigue fuera de sincronía**, por el encargo de entorno
  detenido. Fuera del alcance de este encargo.

---

## 7. Qué falló o sorprendió

1. **Falló mi primer intento de sustitución del bloque PNG.** Construí el patrón
   de búsqueda con un placeholder y la sustitución dejó una llave de más, así que
   el bloque no matcheaba y el script abortó **antes de escribir**. Lo rehice por
   rango de líneas. No llegó a tocarse el archivo: el guard `if n != 1: sys.exit`
   hizo su trabajo.

2. **Mi propio comentario CSS falseó una verificación del encargo.**
   `grep -c "white-space: nowrap"` subió de 6 a 7 porque el comentario contenía el
   literal. Descrito en §2, decisión 1. Es la falla A-s28-2 del documento de
   gobernanza, cometida por quien acababa de leerlo.

3. **Sorpresa: la guarda de superficie PNG no se dispara nunca hoy.** Medido:
   el caso máximo —5 territorios, 5 niveles GSE— pide 12.043.080 px², el 72% del
   límite. La corrección b) del commit 2 es prevención, no reparación. Conviene
   que quede claro para no atribuirle un arreglo que no hace.

4. **Falló un `node --check` mío por un corte mal puesto.** Recorté 3383-3410 en
   vez de 3383-3407 e incluí la apertura de `resetEntities` sin su cierre. El
   error era del recorte, no del código; con el rango correcto pasó. Queda escrito
   porque un `node --check` que falla es exactamente el tipo de señal que no
   conviene descartar sin mirar.

5. **Todo lo demás salió como estaba previsto.** Las siete premisas se
   reprodujeron sin excepción, ninguna rama de detención se disparó, y los siete
   criterios de la FASE FINAL dieron el valor esperado.
