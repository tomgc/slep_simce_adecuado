# Encargo — Escala tipográfica del SVG y limpieza de código muerto

> **Destino:** `50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.

---

## 0. Contrato

**ENTORNO.** macOS aarch64. Proyecto R con `renv`. Intérprete de los bloques de
comando: `bash`. R se invoca con `Rscript` **desde la raíz del proyecto** (el
`.Rprofile` activa `renv`).

**Nota de entorno, importante.** `grep` en macOS es BSD: interpreta `{…}` como
expresión de intervalo y **no** matchea llaves literales. Todo patrón que
contenga `{` o `}` va con `grep -F`. Sin `-F`, la comprobación devuelve 0
siempre y su rama de detención se vuelve un centinela mudo *(fuente: hallazgo
verificado el 2026-08-26, log
`20260826_homogeneidad_y_quinto_territorio_log.md`)*.

**POSICIÓN.** Ruta absoluta en todos los comandos. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**INSUMOS.** Un solo archivo se edita:

```
/Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

El motor generado (`40_salidas/motor_comparacion.html`) **está en `.gitignore`**:
nunca aparecerá en `git status`, y eso es lo esperado.

**Contexto en una frase.** El motor migró su escala tipográfica a variables CSS,
pero quedaron fuera los tamaños de letra dibujados dentro de SVG por D3 y por
objetos de configuración JS, más algo de código muerto. Este encargo cierra esa
deuda.

**Por qué la migración anterior los dejó fuera, y por qué no se resuelve con
variables CSS.** `.attr("font-size", N)` y `"font-size": N` reciben un **número**,
no una cadena: `var(--fs-…)` ahí no funciona. La solución correcta es una escala
en **constantes JS nombradas**, no una variable CSS. Ese es el objeto de la FASE
1.

---

## 1. Estado de partida (premisas marcadas)

1. `git status` limpio, `main` sincronizada con `origin/main` *(hipótesis, se
   mide en FASE 0)*.
2. Existen 18 declaraciones de tamaño de letra con literal numérico en el
   template: 9 en `.attr("font-size", N)` de D3 y 9 en objetos JS
   `"font-size": N` *(hipótesis, se mide en FASE 0)*.
3. Existe **una** ocurrencia adicional, `font-size",10`, dentro del D3
   minificado vendorizado. **No es del proyecto y no se toca** *(fuente:
   inspección del motor generado, 2026-08-26)*.
4. `const depe2Label` en `handleSave()`, rama `comuna`, está sin uso desde antes
   de agosto de 2026 *(fuente: log
   `20260826_homogeneidad_y_quinto_territorio_log.md` §4e)*.
5. `--fs-display-1` y `--fs-display-2` están definidas en `:root` y no se usan
   *(hipótesis, se mide en FASE 0)*.
6. `.badge-traspaso` tiene `text-transform: uppercase`, preexistente e
   incumpliendo el invariante de proyecto *(fuente: mismo log, §5)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 **La escala del SVG preserva los valores actuales exactos.** No se aplica el
  piso de 12px de la UI: las etiquetas de eje de un gráfico compacto son otro
  contexto y bajan de 12px por diseño. El resultado debe ser visualmente
  idéntico al actual, y esa es la prueba de que el refactor salió bien.
- 🔒 Cero literales `px` en CSS declarativo y cero `fontSize: <número>` inline en
  React: eso ya se logró y no se revierte.
- 🔒 El D3 minificado vendorizado no se toca en ninguna circunstancia.
- 🔒 Identificadores de código con raíz "entidad" permanecen; solo el texto
  visible dice "territorio".
- 🔒 Ningún comentario CSS puede contener la secuencia literal `*/` adentro.
- 🔒 `docs/index.html` no se toca.
- 🔒 `git status --short` antes de cada `git add`. Nunca `git add .`
- 🔒 No se hace `push`.

---

## 3. Autorizaciones

Estás autorizado a:

1. Editar `30_procesamiento/33_motor_template.html`.
2. Crear los commits de §4.
3. Ejecutar `30_procesamiento/33_generar_html.R`.
4. Escribir y commitear el log de §6.

Nada más.

---

## 4. Fases

### FASE 0 — Medición

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short --branch
git log --oneline -3
grep -n 'attr("font-size"' 30_procesamiento/33_motor_template.html
grep -c 'attr("font-size"' 30_procesamiento/33_motor_template.html
grep -n '"font-size":' 30_procesamiento/33_motor_template.html
grep -c '"font-size":' 30_procesamiento/33_motor_template.html
grep -n "depe2Label" 30_procesamiento/33_motor_template.html
grep -n -- "--fs-display" 30_procesamiento/33_motor_template.html
grep -n "text-transform" 30_procesamiento/33_motor_template.html
```

Registra el **multiconjunto completo** de valores numéricos encontrados en las
dos familias: es el contrato de la FASE 1. Si el total no es 18, dilo y trabaja
con los que existan: el criterio es "ninguno queda como literal", no "son
dieciocho".

Rama de detención: si `git status` no está limpio, **DETENTE**.

### COMMIT 1 — Escala tipográfica del SVG en constantes JS

Define, junto a las demás constantes de layout de los gráficos, un objeto de
escala con **nombres por rol**, no por número, y con un comentario que declare
que es la escala del SVG y que **no** está sujeta al piso de 12px de la UI.
Deriva los nombres de los roles reales que encuentres al leer cada llamada
(etiqueta de eje, valor sobre la barra, rótulo de serie, etc.), no de una lista
inventada de antemano.

Sustituye las 18 declaraciones por referencias a ese objeto, **conservando el
valor numérico exacto de cada una**. Un literal `9.5` pasa a una constante que
vale `9.5`, no a una que vale 12.

Verificación con ramas de detención:

```bash
grep -c 'attr("font-size", *[0-9]' /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html   # esperado: 0
grep -c '"font-size": *[0-9]' /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html        # esperado: 0
```

Ambos deben dar 0. Si alguno no lo da, **detente**.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "refactor(motor): escala tipografica del SVG en constantes JS nombradas"
```

### COMMIT 2 — Código muerto

- Elimina `const depe2Label` de la rama `comuna` de `handleSave()`, previa
  comprobación de que sigue sin uso.
- Elimina `--fs-display-1` y `--fs-display-2` de `:root`, previa comprobación de
  que ningún `var(--fs-display` las referencia.

Rama de detención: si alguna de las tres resulta **usada**, no la toques y
repórtalo.

```bash
grep -c "depe2Label" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html      # esperado: 0
grep -c -- "--fs-display" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html # esperado: 0
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "chore(motor): elimina constante y variables tipograficas sin uso"
```

### COMMIT 3 — `.badge-traspaso` (condicional)

**Solo si el titular lo autorizó explícitamente al entregarte este encargo.** Si
no hay autorización expresa, **sáltate este commit** y déjalo anotado en el log
como pendiente de decisión.

Quita `text-transform: uppercase` de `.badge-traspaso` y escribe el texto del
badge directamente en la caja tipográfica que corresponda, sin depender de la
transformación.

```bash
grep -c "text-transform" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html   # esperado: 0
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "style(motor): elimina uppercase del badge de traspaso"
```

### FASE FINAL — Regeneración y verificación

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'
md5 -q 40_salidas/motor_comparacion.html
grep -c 'attr("font-size", *[0-9]' 40_salidas/motor_comparacion.html
grep -c "fontSize: *[0-9]" 40_salidas/motor_comparacion.html
grep -o "font-size: *[0-9.]*px" 40_salidas/motor_comparacion.html | sort | uniq -c
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado log --oneline -4
```

El primer conteo debe ser **1**: la única ocurrencia superviviente es la del D3
minificado vendorizado. Si es 0, tocaste el vendor; si es mayor que 1, quedó
código del proyecto sin migrar. En ambos casos, **detente**.

Los otros dos deben dar 0 y listado vacío.

---

## 5. Reporte final al chat

1. Salidas literales de FASE 0 con el multiconjunto de valores encontrados.
2. Los nombres de rol que elegiste para la escala del SVG y a qué valor quedó
   asignado cada uno.
3. Los hashes (dos o tres, según el commit 3).
4. Las verificaciones de la FASE FINAL con su valor medido.
5. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No hagas `push`. La comprobación visual la hace el titular: los gráficos deben
verse **idénticos** a como estaban, porque los valores se preservaron.

---

## 6. Log

Escribe, y **commitea**, un log en:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/AAAAMMDD_tipografia_svg_y_codigo_muerto_log.md
```

con la fecha real del día. Es el documento que se audita después, así que debe
permitir reconstruir la ejecución sin tenerte delante:

- Salida **literal** de cada comando de verificación, no su resumen.
- Una tabla por fase con tres columnas: medición, valor esperado, valor medido.
- **La tabla de mapeo completa** de la FASE 1: cada declaración migrada, su valor
  antes, la constante que la reemplaza y su valor después. Es la única forma de
  auditar que se preservaron los valores.
- Toda cifra que afirmes debe venir del comando que la produjo, citado en la
  misma línea. Una cifra sin comando al lado es un defecto del log.
- Cada decisión tomada ante una ambigüedad, con la alternativa descartada y por
  qué.
- Todo lo que quedó **sin verificar** y por qué. En particular: el asistente no
  abre navegador, así que la equivalencia visual queda declarada como no
  verificada.
- Si algo salió distinto de lo esperado, queda escrito aunque después se haya
  arreglado.

Último commit del encargo, junto con este archivo de encargo si aún no está
versionado:

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/andamios/logs/AAAAMMDD_tipografia_svg_y_codigo_muerto_log.md 50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(encargos): versiona encargo de tipografia SVG con su log"
```
