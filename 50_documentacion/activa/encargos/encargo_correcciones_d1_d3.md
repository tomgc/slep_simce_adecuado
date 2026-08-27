# Encargo — Correcciones derivadas del diagnóstico D1–D3

> **Destino:** `50_documentacion/activa/encargos/encargo_correcciones_d1_d3.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.

---

## 0. Contrato

**ENTORNO.** macOS aarch64. Proyecto R con `renv`. Intérprete de los bloques de
comando: `bash`. R se invoca con `Rscript` **desde la raíz del proyecto** (el
`.Rprofile` activa `renv`).

**Nota de entorno.** `grep` en macOS es BSD: todo patrón con `{` o `}` va con
`grep -F`, o devuelve 0 siempre y su rama de detención no protege nada.

**POSICIÓN.** Ruta absoluta en todos los comandos. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**INSUMOS.** Un solo archivo se edita:

```
/Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

`40_salidas/motor_comparacion.html` está en `.gitignore`: nunca aparece en
`git status`, y eso es lo esperado.

**Contexto en una frase.** Un diagnóstico de solo lectura del 2026-08-27 dejó
tres hallazgos sobre el motor: el enlace "ver establecimientos" desborda su
tarjeta con contadores de cuatro dígitos, la exportación a PNG puede fallar en
silencio, y la siembra del estado por defecto se trunca sin avisar. Este encargo
corrige los tres.

---

## 1. Estado de partida (premisas marcadas)

Todas medidas el 2026-08-27 sobre `33_motor_template.html` *(fuente: diagnóstico
D1–D3, reportado en chat; se re-miden en FASE 0 porque el archivo pudo cambiar)*.

1. `git status` limpio, `main` sincronizada con `origin/main` en `dbd729b`.
2. `.entity-chip` tiene `max-width: 250px`; descontando bordes, padding, swatch,
   `gap` y los dos botones de icono, quedan **≈150 px** para `.entity-text`.
3. El texto más largo del enlace es `ver establecimientos (8325) ▸`, 29
   caracteres, estimados en 162–191 px a 12 px. Desborda entre 8% y 27%.
4. `.entity-estab-btn` tiene `white-space: nowrap` y ningún ancestro declara
   `overflow`, así que el resultado es desborde visible, no recorte.
5. `exportarGraficosPNG` no envuelve `canvas.toBlob` en `try/catch`: un
   `SecurityError` escaparía desde dentro de `img.onload` sin alerta ni descarga.
6. `entidadesPorDefecto()` hace `slep.comunas.slice(0, MAX_ENTIDADES)` y
   descartaría comunas en silencio si el SLEP tuviera más que el tope.
7. El SLEP Costa Central tiene exactamente 4 comunas, medido en
   `sleps_chile.parquet` y en `slep_cc_establecimientos.parquet`.

---

## 2. Invariantes (🔒 intocables)

- 🔒 **El arranque sigue siendo 4 comunas de Costa Central con `depe2="5"`, y el
  contador sigue diciendo "4 de 5 activos".** Es la prueba de que el commit 3 no
  cambió comportamiento.
- 🔒 El grupo personalizado **no** recibe tope de comunas. Un grupo de muchas
  comunas es un agregado legítimo; el defecto estaba en cómo se mostraba el
  contador, no en cuántas comunas se podían elegir.
- 🔒 Cero literales `px` en CSS declarativo y cero `fontSize: <número>` inline en
  React. Los tamaños del SVG viven en el objeto `FS_SVG` y sus valores no se
  tocan.
- 🔒 Identificadores de código con raíz "entidad" permanecen; solo el texto
  visible dice "territorio".
- 🔒 Ningún comentario CSS con la secuencia literal `*/` adentro. Ningún
  `text-transform: uppercase` nuevo (el de `.badge-traspaso` es preexistente y
  **no se toca**).
- 🔒 `docs/index.html` no se toca. No se hace `push`.
- 🔒 `git status --short` antes de cada `git add`. Nunca `git add .`

---

## 3. Autorizaciones

1. Editar `30_procesamiento/33_motor_template.html`.
2. Crear los tres commits de §4.
3. Ejecutar `30_procesamiento/33_generar_html.R`.
4. Escribir y commitear el log de §6.

Nada más.

---

## 4. Fases

### FASE 0 — Medición

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short --branch
git log --oneline -1
grep -n "ver establecimientos" 30_procesamiento/33_motor_template.html
grep -n -A8 "^\.entity-estab-btn" 30_procesamiento/33_motor_template.html
grep -n -A8 "^\.entity-text" 30_procesamiento/33_motor_template.html
grep -n -A6 "^\.entity-chip" 30_procesamiento/33_motor_template.html
grep -n -A30 "function exportarGraficosPNG" 30_procesamiento/33_motor_template.html
grep -n "slice(0, MAX_ENTIDADES)" 30_procesamiento/33_motor_template.html
grep -n "MAX_ENTIDADES" 30_procesamiento/33_motor_template.html
```

**Estados esperados.** `main` en `dbd729b`, árbol limpio; untracked bajo
`50_documentacion/` se reporta y no detiene.

**Cláusula residual.** Cualquier archivo **versionado** modificado, o cualquier
untracked bajo `30_procesamiento/` o `40_salidas/`: **DETENTE**.

Si alguna de las premisas 2 a 6 no se reproduce, dilo y trabaja sobre lo medido:
el criterio de cada commit está expresado como resultado, no como cantidad.

---

### COMMIT 1 — El enlace de establecimientos deja de desbordar

**Defecto.** Con `white-space: nowrap` y sin `overflow` en ningún ancestro, un
contador de cuatro dígitos empuja el texto fuera de la tarjeta. El `nowrap` se
añadió para que la flecha no cayera sola a otra línea, y cambió un salto feo por
un desborde.

**Corrección.** Separar el rótulo de la flecha, para que el rótulo se recorte con
puntos suspensivos y la flecha sobreviva siempre:

- a) En el JSX del botón, divide el contenido en dos elementos: uno con el texto
  `ver establecimientos (N)` y otro con `▸`. No cambies el conteo ni le apliques
  formato de miles: el ancho es el problema, no la legibilidad.
- b) `.entity-text` gana `min-width: 0`, sin lo cual un ítem flex no encoge por
  debajo de su contenido y el recorte nunca se activa.
- c) `.entity-estab-btn` pasa a `display: flex` con `align-items: center`,
  `gap: 4px`, `max-width: 100%`, y conserva `white-space: nowrap`.
- d) El elemento del rótulo gana `overflow: hidden`, `text-overflow: ellipsis` y
  `min-width: 0`. El de la flecha gana `flex-shrink: 0`.

**Verificación, con rama de detención:**

```bash
grep -c "text-overflow: ellipsis" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
grep -n -A10 "^\.entity-estab-btn" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
grep -c "white-space: nowrap" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

El `nowrap` debe seguir presente en la regla del botón: si desapareció, la
flecha vuelve a quebrar y el arreglo es peor que el defecto. **DETENTE** si no
está.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "fix(motor): el enlace de establecimientos se recorta en vez de desbordar la tarjeta"
```

---

### COMMIT 2 — La exportación a PNG deja de poder fallar en silencio

**Defecto.** `canvas.toBlob` puede lanzar de forma síncrona desde dentro de
`img.onload`. La excepción escapa del manejador sin llegar al guard
`if (!blob)`: el usuario no recibe alerta ni archivo, solo una traza en consola.

**Corrección.**

- a) Envuelve el cuerpo de `img.onload` en `try/catch`. En el `catch`, libera la
  URL del objeto si aún no se liberó y avisa al usuario con el mismo tono que las
  alertas existentes, incluyendo el mensaje del error.
- b) Antes de crear el canvas, comprueba que la superficie pedida
  (`totalW * PNG_SCALE * totalH * PNG_SCALE`) no supere un límite declarado como
  **constante nombrada**, con un comentario que diga que es el techo conservador
  de Safari. Si lo supera, avisa al usuario con un mensaje que explique la causa
  (demasiados territorios para exportar a PNG a esta escala) y sugiera el SVG,
  que no tiene ese límite. No degrades la escala en silencio.
- c) No toques `exportarGraficosSVG` ni `construirSvgGraficos`.

**Verificación:**

```bash
grep -n -A45 "function exportarGraficosPNG" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
grep -c "try {" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

Reporta el bloque completo. Debe verse el `try/catch` y la constante de
superficie con su comentario.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "fix(motor): la exportacion PNG avisa al fallar y ante superficie excesiva"
```

---

### COMMIT 3 — La siembra por defecto deja de truncarse en silencio

**Defecto.** `entidadesPorDefecto()` hace `slice(0, MAX_ENTIDADES)`. Hoy es
inocuo, porque Costa Central tiene 4 comunas y el tope es 5. Con un SLEP de más
comunas que el tope, la función sembraría un territorio incompleto sin ninguna
señal.

**Nota de diseño, para que no se corrija de más.** El acoplamiento no se puede
eliminar: el tablero no puede sembrar más territorios de los que admite. Lo que
se corrige es el **silencio**, no el tope.

**Corrección.**

- a) Calcula el total de comunas del SLEP antes de recortar y compáralo con el
  tope. Si hay truncamiento, emite un `console.warn` que diga cuántas comunas
  tiene el SLEP, cuántas se sembraron y cuál es el tope.
- b) Añade sobre la función un comentario que declare la relación: el estado por
  defecto son las comunas del SLEP, acotadas por `MAX_ENTIDADES` porque el
  tablero no admite más, y hoy no hay truncamiento porque Costa Central tiene 4.
- c) **No cambies el valor de `MAX_ENTIDADES` ni el comportamiento observable.**

**Verificación de invariante, medida antes y después.** Esta es la comprobación
que importa: el commit no debe cambiar nada de lo que se ve.

```bash
grep -n -A30 "entidadesPorDefecto" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html | head -40
grep -c "MAX_ENTIDADES = 5" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

El tope debe seguir en 5 y el `slice` debe seguir devolviendo las 4 comunas.
**DETENTE** si el valor del tope cambió.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "chore(motor): declara y advierte el truncamiento de la siembra por defecto"
```

---

### FASE FINAL — Regeneración y verificación

Control positivo antes de regenerar: el build en disco debe valer
`79921d5efbe8667e8ac10dc8cfceba75`. Si no vale eso, dilo y sigue igual, pero
declara que la comparación de md5 pierde su punto de referencia.

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
md5 -q 40_salidas/motor_comparacion.html
Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'
md5 -q 40_salidas/motor_comparacion.html
grep -c "fontSize: *[0-9]" 40_salidas/motor_comparacion.html
grep -o "font-size: *[0-9.]*px" 40_salidas/motor_comparacion.html | sort | uniq -c
grep -c "MAX_ENTIDADES = 5" 40_salidas/motor_comparacion.html
grep -o 'attr("font-size", *[0-9.]*)' 40_salidas/motor_comparacion.html | sort | uniq -c
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado log --oneline -4
```

| Criterio | Esperado | Si difiere |
|---|---|---|
| Generador | exit 0 | **DETENTE**, error literal completo, no borres nada |
| md5 | distinto del previo | **DETENTE**: el script no reescribió |
| `fontSize: <núm>` | 0 | **DETENTE** |
| `font-size: Npx` | listado vacío | **DETENTE** |
| `MAX_ENTIDADES = 5` | 1 | **DETENTE** |
| `attr("font-size", <núm>)` | 1, la del D3 minificado vendorizado | **DETENTE**: 0 significa que tocaste el vendor, más de 1 que se reintrodujo un literal |
| `git status --short` | solo lo declarado | Repórtalo |

---

## 5. Reporte final al chat

1. Salidas literales de FASE 0, con el veredicto de cada premisa 2 a 6:
   reproducida o no.
2. Los tres hashes con su alcance.
3. El bloque completo de `exportarGraficosPNG` después del commit 2.
4. La tabla de la FASE FINAL con el valor medido de cada criterio.
5. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No hagas `push`. La comprobación visual es del titular: la tarjeta con un
territorio de contador largo, el arranque en "4 de 5 activos", y una exportación
PNG con cinco territorios.

---

## 6. Log

Escribe, y **commitea**, un log en:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/AAAAMMDD_correcciones_d1_d3_log.md
```

con la fecha real del día. Es el documento que se audita después, así que debe
permitir reconstruir la ejecución sin tenerte delante:

- Salida **literal** de cada comando de verificación, no su resumen.
- Una tabla por fase: medición, valor esperado, valor medido, veredicto.
- Para el commit 3, la evidencia de que el comportamiento observable **no**
  cambió: el tope sigue en 5 y la siembra sigue devolviendo 4.
- Toda cifra que afirmes debe venir del comando que la produjo, citado en la
  misma línea. Una cifra sin comando al lado es un defecto del log.
- Cada decisión ante una ambigüedad, con la alternativa descartada y por qué.
- Todo lo que quedó **sin verificar** y por qué. En particular: el asistente no
  abre navegador, así que el recorte del enlace, el aviso del PNG y la
  rasterización quedan declarados como no verificados.
- Si algo salió distinto de lo esperado, queda escrito aunque después se haya
  arreglado.

Último commit del encargo, junto con este archivo de encargo si aún no está
versionado:

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/andamios/logs/AAAAMMDD_correcciones_d1_d3_log.md 50_documentacion/activa/encargos/encargo_correcciones_d1_d3.md
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(encargos): versiona encargo de correcciones D1-D3 con su log"
```
