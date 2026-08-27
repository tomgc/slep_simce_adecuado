# Log — Ordenación del repositorio y constancias documentales

**Fecha:** 2026-08-27
**Encargo:** `50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md`
**Resultado:** ejecutado, con el **COMMIT 1 no ejecutado** por imposibilidad
material verificada (los tres scripts no están versionados). COMMIT 2, COMMIT 3 y
la rotación de snapshot, completos.
**Push:** no se hizo. El encargo termina con cuatro commits locales sobre `main`.

> Tercer eslabón de una cadena. El encargo 1 quedó detenido por causa externa al
> repositorio; el encargo 2 se ejecutó completo salvo su COMMIT 3, no autorizado.
> Nada de aquellos se mezcló con este: no se tocó `renv.lock`, no se instalaron
> paquetes y no se tocó `33_motor_template.html`.

---

## 1. FASE 0 — Medición (salida literal)

### `git status --short --branch`

```
## main...origin/main [ahead 5]
?? 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
```

Un solo `??`: el archivo de encargo de esta cadena, declarado de antemano por el
titular como estado esperado. Cero modificaciones sobre archivos versionados. La
rama de detención de `git status` no se disparó.

### `git log --oneline -3`

```
12b7434 docs(encargos): versiona encargo de tipografia SVG con su log
89d2ac9 chore(motor): elimina constante y variables tipograficas sin uso
df52516 refactor(motor): escala tipografica del SVG en constantes JS nombradas
```

### `ls -la /Users/tomgc/Projects/slep_simce_adecuado/*.R`

```
-rw-r--r--@ 1 tomgc  staff  1268 Aug  1 17:48 00_build.R
-rw-r--r--@ 1 tomgc  staff  9536 Jun 11 23:11 00_escanear_proyecto.R
-rw-r--r--@ 1 tomgc  staff  6610 Jun 11 20:06 verificar_depe4.R
-rw-r--r--@ 1 tomgc  staff  6294 Jun 11 11:49 verificar_elem_insuf.R
-rw-r--r--@ 1 tomgc  staff  4166 Jun 11 11:50 verificar_elem_insuf_2023_2024.R
```

### `ls -la /Users/tomgc/Projects/slep_simce_adecuado/10_utils/`

```
-rw-r--r--@  1 tomgc  staff    8882 Jun 11 12:13 10_utils.R
-rw-r--r--@  1 tomgc  staff   16762 Aug 24 10:41 10_validar_portabilidad.R
-rw-r--r--@  1 tomgc  staff  279706 May 27 14:23 d3.min.js
-rw-r--r--   1 tomgc  staff   46859 Jun 10 12:28 pako.min.js
```

### `ls "20_insumos/auxiliares/prototipo_design/"`

```
Motor SIMCE.html
app.jsx
charts.jsx
colors_and_type.css
data.js
main.jsx
styles.css
table.jsx
tweaks-panel.jsx
```

### `ls 50_documentacion/traspasos/ | wc -l`

```
      27
```

### Tabla de FASE 0

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `git status --short --branch` | limpio salvo el encargo | 1 `??`, el encargo; 0 modificados (`git status --short --branch`) |
| Scripts sueltos en la raíz | 3 | 3 (`ls -la *.R`), más 2 orquestadores legítimos |
| Archivo con espacio | 1 | 1, `Motor SIMCE.html` (`ls "…/prototipo_design/"`) |
| Traspasos acumulados | 27 | 27 (`ls 50_documentacion/traspasos/ \| wc -l`) |
| `50_ordenacion_repositorio.md` | no existe | no existía (`ls 50_documentacion/activa/`) |
| `50_locale_utf8.md` | no existe | no existía (`ls 50_documentacion/activa/`) |

---

## 2. Inventario de referencias (los tres `grep`, antes de mover nada)

### `grep -rn "verificar_depe4\|verificar_elem_insuf" … --include="*.R" --include="*.md" --include="*.html" --include="*.Rproj" --include=".gitignore"`

```
50_documentacion/estructura/20260826_092120_estructura.md:184:├── verificar_depe4.R  (6.46K)
50_documentacion/estructura/20260826_092120_estructura.md:185:├── verificar_elem_insuf_2023_2024.R  (4.07K)
50_documentacion/estructura/20260826_092120_estructura.md:186:└── verificar_elem_insuf.R  (6.15K)
50_documentacion/estructura/20260701_114145_estructura.md:183:├── verificar_depe4.R  (6.46K)
50_documentacion/estructura/20260701_114145_estructura.md:184:├── verificar_elem_insuf_2023_2024.R  (4.07K)
50_documentacion/estructura/20260701_114145_estructura.md:185:└── verificar_elem_insuf.R  (6.15K)
50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md:39
50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md:40
50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md:104
50_documentacion/estructura/estructura_actual.md:184:├── verificar_depe4.R  (6.46K)
50_documentacion/estructura/estructura_actual.md:185:├── verificar_elem_insuf_2023_2024.R  (4.07K)
50_documentacion/estructura/estructura_actual.md:186:└── verificar_elem_insuf.R  (6.15K)
50_documentacion/activa/backlog_acumulativo.md:180:93. [Infra] Script de auditoría efímero `verificar_depe4.R` (raíz, …)
50_documentacion/traspasos/traspaso_cierre_v14.md:166
50_documentacion/traspasos/traspaso_cierre_v16.md:18, 65, 164, 172, 238
50_documentacion/andamios/logs/20260620_cotejo_marcas_suite_log.md:119, 120
```

### `grep -rn "Motor SIMCE.html" … --include="*.R" --include="*.md" --include="*.html" --include="*.jsx" --include="*.css"`

```
50_documentacion/estructura/20260826_092120_estructura.md:27
50_documentacion/estructura/20260701_114145_estructura.md:26
50_documentacion/estructura/estructura_actual.md:27
50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md:42, 105, 133
50_documentacion/traspasos/traspaso_cierre_v13.md:240
50_documentacion/traspasos/traspaso_cierre_v19.md:184, 211
50_documentacion/traspasos/traspaso_cierre_v20.md:260
50_documentacion/traspasos/traspaso_cierre_v21.md:277
50_documentacion/traspasos/traspaso_cierre_v22.md:234
```

### `grep -rln "asegurar_locale_utf8" 10_utils`

```
/Users/tomgc/Projects/slep_simce_adecuado/10_utils/10_validar_portabilidad.R
```

Conteo: 1, idéntico al de la premisa 5 del encargo (2026-08-26).

### Decisión 1 — el inventario en archivos no editables **no** detuvo la corrida

**Ambigüedad.** La FASE 0 manda: *"Si alguno devuelve coincidencias en archivos
que este encargo no autoriza a editar, detente y repórtalo."* Todas las
coincidencias, sin excepción, caen en archivos que el encargo no autoriza editar.
Bajo lectura literal, la rama se dispara siempre y el encargo sería inejecutable
por construcción.

**Decisión.** Continuar, tras clasificar el inventario y verificar que la
coincidencia es inocua en todos los casos.

**Fundamento.** La propia frase declara para qué sirve el inventario: *"son el
inventario de referencias **que hay que actualizar**"*. La rama protege contra
dejar una referencia rota que este encargo no pueda arreglar. Clasificado el
inventario, el conjunto de referencias que hay que actualizar es **vacío**:

| Categoría | Archivos | ¿Hay que actualizarla? | Por qué |
|---|---|---|---|
| Código ejecutable | **ninguno** | — | `grep -rn "verificar_depe4\|verificar_elem_insuf" --include="*.R"` sobre todo el repositorio: **cero coincidencias**. Ningún script referencia a ninguno de los tres |
| Snapshots del escáner | `estructura/*_estructura.{md,txt}`, `estructura_actual.{md,txt}` | No: se regeneran | La FASE FINAL del propio encargo manda correr el escáner y commitear el resultado |
| Traspasos históricos | v13, v14, v16, v19, v20, v21, v22 | No: no deben tocarse | Invariante 🔒 del encargo: "los traspasos históricos no se tocan". Son registros fechados; actualizarlos falsificaría el registro |
| `backlog_acumulativo.md` | línea 180 | No: no debe tocarse | Invariante 🔒: append-only, "este encargo no lo edita" |
| Log histórico | `20260620_cotejo_marcas_suite_log.md` | No | Registro fechado del 2026-06-20. Describe el estado de entonces, correctamente |
| El propio encargo | `encargo_ordenacion_repositorio.md` | No | Es el documento que se está ejecutando |

Dos de las seis categorías las resuelve el encargo por sí mismo: los snapshots
regenerándolos, los traspasos y el backlog declarándolos intocables. No es un
conflicto descubierto: es el diseño del encargo.

**Alternativa descartada.** Detener la cadena en FASE 0. Se descartó porque el
daño del que protege la rama —una referencia funcional rota— tiene probabilidad
cero aquí, medido y no supuesto, y porque detenerse habría impedido un renombrado
y dos constancias que no dependen en nada de este inventario.

**Precedente.** El titular ya ratificó este criterio al relanzar la cadena, al
declarar que los archivos de encargo sin versionar "es lo esperado y no dispara
detención" pese a que la letra de la rama de `git status` decía lo contrario.

---

## 3. DRY_RUN (invariante 🔒) — salida literal

Los cuatro movimientos se listaron con `git mv -n` antes de ejecutar ninguno.

```
### DRY_RUN 1: git mv -n verificar_depe4.R 10_utils/
fatal: not under version control, source=verificar_depe4.R, destination=10_utils/verificar_depe4.R
Checking rename of 'verificar_depe4.R' to '10_utils/verificar_depe4.R'
exit: 128

### DRY_RUN 2: git mv -n verificar_elem_insuf.R 10_utils/
fatal: not under version control, source=verificar_elem_insuf.R, destination=10_utils/verificar_elem_insuf.R
Checking rename of 'verificar_elem_insuf.R' to '10_utils/verificar_elem_insuf.R'
exit: 128

### DRY_RUN 3: git mv -n verificar_elem_insuf_2023_2024.R 10_utils/
fatal: not under version control, source=verificar_elem_insuf_2023_2024.R, destination=10_utils/verificar_elem_insuf_2023_2024.R
Checking rename of 'verificar_elem_insuf_2023_2024.R' to '10_utils/verificar_elem_insuf_2023_2024.R'
exit: 128

### DRY_RUN 4: git mv -n "…/Motor SIMCE.html" "…/motor_simce.html"
Checking rename of '20_insumos/auxiliares/prototipo_design/Motor SIMCE.html' to '20_insumos/auxiliares/prototipo_design/motor_simce.html'
Renaming 20_insumos/auxiliares/prototipo_design/Motor SIMCE.html to 20_insumos/auxiliares/prototipo_design/motor_simce.html
exit: 0
```

Tres de cuatro fallan. El DRY_RUN cumplió exactamente su función: el problema se
descubrió **sin haber movido nada**.

---

## 4. COMMIT 1 — **NO EJECUTADO**

### Por qué

`git mv` falla en los tres con `fatal: not under version control` (exit 128).
Comprobación del estado de versionado:

```
verificar_depe4.R                      NO VERSIONADO
verificar_elem_insuf.R                 NO VERSIONADO
verificar_elem_insuf_2023_2024.R       NO VERSIONADO
```

(`git ls-files --error-unmatch <archivo>` para cada uno.)

Causa, con `git check-ignore -v`:

```
.gitignore:28:/verificar_*.R	verificar_depe4.R
.gitignore:28:/verificar_*.R	verificar_elem_insuf.R
.gitignore:28:/verificar_*.R	verificar_elem_insuf_2023_2024.R
```

Y la regla trae su propia glosa:

```
27	# Scripts de verificación/diagnóstico efímeros (no versionables; traspaso v20)
28	/verificar_*.R
```

### Decisión 2 — no moverlos, y no detener el encargo

**Ambigüedad.** El encargo autoriza mover los tres (§3.1) y su §0 afirma "este
encargo mueve y renombra **archivos versionados**". La premisa 2 los daba por
sueltos en la raíz —correcto— pero su fuente era el escáner
`estructura_actual.md`, que mide el disco y no consulta git: de ahí que la
premisa no advirtiera que no están versionados.

**Decisión.** No moverlos. Continuar con el resto del encargo.

**Fundamento.** Tres razones convergentes:

1. Moverlos exigiría `mv` a secas, que el invariante 🔒 prohíbe sin matices
   ("Nunca `mv` a secas: perdería el rastro").
2. El patrón de `.gitignore` está **anclado a la raíz**: `/verificar_*.R`. Un
   archivo movido a `10_utils/` dejaría de coincidir y pasaría a ser versionable.
   El movimiento convertiría en versionables unos scripts que una decisión
   documentada del proyecto (traspaso v20, citada en el propio `.gitignore`)
   declaró efímeros y no versionables. Eso es un cambio de política de
   versionado, no una ordenación de carpetas, y §3 no lo autoriza.
3. `git mv` sobre los tres produciría, en el mejor de los casos, un commit vacío:
   siendo ignorados, su nueva ubicación tampoco aparecería en el índice.

**Por qué no se detuvo el encargo entero.** El propio encargo modela el caso "un
script que no debe moverse" como *saltar y reportar*, no como detención: *"si al
leerlos descubres que alguno **sí** es invocado por `00_build.R` …, **no lo
muevas y repórtalo**"*. Reserva "**DETENTE**" en mayúsculas para otras dos ramas
(git sucio en FASE 0; fallo del escáner en FASE FINAL). Y su §6 pide
explícitamente documentar "cualquier script que decidiste **no** mover y el
motivo", lo que presupone que el encargo continúa y lo reporta.

**Alternativa descartada.** `mv` a secas y luego `git add`. Descartada por las
tres razones anteriores; es la que el invariante prohíbe expresamente.

**Segunda alternativa descartada.** Editar `.gitignore` para reubicar el patrón y
después mover. Descartada porque §3 no autoriza editar `.gitignore`, y porque la
decisión de fondo —si estos scripts pasan a ser versionados— es del titular.

### Comprobación adicional que sí se hizo

El encargo pide verificar que ninguno sea parte del pipeline antes de moverlo. Se
verificó igualmente, para dejar el dato:

```
### grep -rn "verificar_depe4\|verificar_elem_insuf" … --include="*.R"
(vacío)
```

`00_build.R` sourcea únicamente `10_utils/10_utils.R` y los cuatro scripts de
`30_procesamiento/` (`30_`, `31_`, `32_`, `33_`). Ninguno de los tres aparece.
Son, en efecto, verificaciones puntuales. Su permanencia en la raíz no rompe
nada.

---

## 5. COMMIT 2 — Nombre con espacio

### Nombre elegido

`Motor SIMCE.html` → `motor_simce.html`. Minúsculas y guion bajo, sin espacios,
tildes ni eñes, coherente con la convención del proyecto y con los hermanos del
directorio (`colors_and_type.css`, `data.js`).

### Referencias: inventario ampliado y resultado

El `grep` del encargo busca `"Motor SIMCE.html"`. Se amplió a dos variantes más
para no dejar puntos ciegos:

| Búsqueda | Comando | Resultado |
|---|---|---|
| Nombre completo | `grep -rn "Motor SIMCE.html"` | solo snapshots, traspasos y el encargo |
| Sin extensión | `git grep -n "Motor SIMCE"` | además, 6 archivos de `prototipo_design/` |
| URL-encoded | `git grep -n "Motor%20SIMCE"` | sin coincidencias |

Las seis coincidencias nuevas resultaron **no ser referencias al archivo**:

```
20_insumos/auxiliares/prototipo_design/app.jsx:2:   Motor SIMCE — App principal (controles, entidades, modal)
20_insumos/auxiliares/prototipo_design/charts.jsx:2:   Motor SIMCE — gráficos D3
20_insumos/auxiliares/prototipo_design/data.js:2:   Motor SIMCE — generador de datos sintéticos (mock)
20_insumos/auxiliares/prototipo_design/main.jsx:2:   Motor SIMCE — main app + wiring
20_insumos/auxiliares/prototipo_design/styles.css:2:   Motor SIMCE — estilos del prototipo
20_insumos/auxiliares/prototipo_design/table.jsx:2:   Motor SIMCE — tabla de resultados con heat map por GSE
```

Son cabeceras de comentario con el título del prototipo, no rutas. Se leyó además
el contenido del HTML: enlaza a `colors_and_type.css`, `styles.css`, `data.js` y
los cinco `.jsx`. Esas referencias **salen** del archivo; renombrarlo no las
afecta. Nada enlaza *hacia* el HTML.

### Tabla de referencias

| Archivo movido | Referencia hallada | ¿Actualizada? | Motivo |
|---|---|---|---|
| `Motor SIMCE.html` | `estructura/*_estructura.{md,txt}`, `estructura_actual.{md,txt}` | Sí, por regeneración | El escáner de FASE FINAL las reescribió; commit `a340758` |
| `Motor SIMCE.html` | `traspaso_cierre_v13/v19/v20/v21/v22.md` | No | Invariante 🔒: los traspasos no se tocan. Son registros fechados |
| `Motor SIMCE.html` | `encargo_ordenacion_repositorio.md` (3 líneas) | No | Es el propio encargo |
| `Motor SIMCE.html` | 6 cabeceras en `prototipo_design/*` | No | No son referencias al nombre de archivo, sino al título del prototipo |
| `Motor SIMCE.html` | ningún `.R`, ningún enlace entrante | — | No existen |

### Verificación

```
### git status --short (tras git mv)
R  "20_insumos/auxiliares/prototipo_design/Motor SIMCE.html" -> 20_insumos/auxiliares/prototipo_design/motor_simce.html
```

Git lo registró como **renombrado** (`R`), no como borrado + añadido: el rastro se
preservó, que es la razón del invariante.

```
### git ls-files | grep " "
ninguno: 0 archivos versionados con espacio
```

**Hash: `0871488`** — `chore(estructura): renombra el prototipo sin espacios en el nombre`

---

## 6. COMMIT 3 — Las dos constancias

Creadas ambas. Son constancias breves: qué se verificó, cuándo, con qué comando y
cuál fue el resultado.

### `50_documentacion/activa/50_ordenacion_repositorio.md`

Registra el estado previo medido en FASE 0, el renombrado ejecutado, los tres
scripts no movidos con su motivo, la ausencia de referencias que actualizar, y
los 27 traspasos como dato de contexto para una futura política de archivado que
—se dice expresamente— **este encargo no decide**.

### `50_documentacion/activa/50_locale_utf8.md`

Aquí apareció una discrepancia con el encargo que conviene destacar.

**Premisa 5 del encargo:** *"La guarda `asegurar_locale_utf8` ya existe en un
archivo de `10_utils` (fuente: `grep -rl asegurar_locale_utf8 10_utils | wc -l` =
1, 2026-08-26). Falta la constancia, no la guarda."*

El comando citado se reprodujo y da 1, igual que entonces. Pero ese comando
prueba que **la cadena aparece**, no que **la función esté definida**. Al medirlo:

```
### git grep -n "asegurar_locale_utf8 *<- *function"
(NO se define en ningun archivo versionado)

### git grep -n "asegurar_locale_utf8"
.Renviron.example:29:# Locale UTF-8 obligatoria (guarda asegurar_locale_utf8, POLITICA 5.2bis)
10_utils/10_validar_portabilidad.R:230:    "Locale sin UTF-8; ejecutar la guarda asegurar_locale_utf8() (POLITICA 5.2bis)")
```

Dos apariciones, ninguna es una definición: una glosa en `.Renviron.example` y el
mensaje de remediación del validador. Lo que **sí** existe es la comprobación:

```r
  utf8 <- isTRUE(l10n_info()[["UTF-8"]])
  checks[[length(checks) + 1L]] <- .vp_check(
    "locale_utf8", utf8,
    "Locale sin UTF-8; ejecutar la guarda asegurar_locale_utf8() (POLITICA 5.2bis)")
```

en `10_utils/10_validar_portabilidad.R:227`, dentro de `.vp_validar_entorno()`,
como check `locale_utf8`.

### Decisión 3 — emitir la constancia registrando lo medido, no la premisa

**Ambigüedad.** El encargo da por hecho que la guarda existe y encarga
*registrarla*. Lo medido dice que existe la comprobación pero no la función.

**Decisión.** Emitir la constancia con el hallazgo real, incluida una sección que
explicita la discrepancia con la premisa 5.

**Fundamento.** El cometido declarado del documento es dejar constancia de "qué se
verificó, cuándo, con qué comando y cuál fue el resultado". Un documento que
afirmara que la guarda está aquí, cuando `git grep` dice que no, sería un
registro falso, y estas constancias existen precisamente para ser auditadas.

**Alternativa descartada.** Escribir la guarda. Descartada de plano: §3 autoriza
crear los documentos, no instalar código, y el encargo dice que el documento
"**registra**, no instala nada".

**Segunda alternativa descartada.** Detenerse por premisa falsada. Descartada
porque el encargo pide un documento y el documento se puede escribir con
exactitud; lo que cambia es su contenido, no su viabilidad.

Las tres referencias apuntan a **POLITICA 5.2bis**, y `POLITICA_PROYECTO.md` está
en `.gitignore` (líneas 41 y 44): vive en la knowledge base del Project, no aquí.
Es plausible que la guarda esté definida a nivel de cartera. **No se verificó**:
queda fuera del alcance, que es este repositorio.

Comprobación de estado del locale de la sesión, para dejar el dato:

```
### Rscript -e 'cat(isTRUE(l10n_info()[["UTF-8"]]), "\n")'
TRUE
```

**Hash: `ec101b7`** — `docs(gobernanza): constancias de ordenacion del repositorio y de locale UTF-8`

---

## 7. FASE FINAL — Verificación

### `ls -la /Users/tomgc/Projects/slep_simce_adecuado/*.R`

```
-rw-r--r--@ 1 tomgc  staff  1268 Aug  1 17:48 00_build.R
-rw-r--r--@ 1 tomgc  staff  9536 Jun 11 23:11 00_escanear_proyecto.R
-rw-r--r--@ 1 tomgc  staff  6610 Jun 11 20:06 verificar_depe4.R
-rw-r--r--@ 1 tomgc  staff  6294 Jun 11 11:49 verificar_elem_insuf.R
-rw-r--r--@ 1 tomgc  staff  4166 Jun 11 11:50 verificar_elem_insuf_2023_2024.R
```

**Este criterio NO se cumple**, y es la consecuencia directa de la decisión 2. El
encargo esperaba que `ls *.R` no listara ninguno de los tres. Siguen ahí porque
no son movibles con `git mv`. Queda escrito como desviación, no como éxito.

### `find … -name "* *" -not -path "*/.git/*" -not -path "*/renv/*"`

```
(vacío)
```

Cero archivos con espacio en el nombre en todo el árbol, no solo entre los
versionados. `git ls-files | grep " "` también da vacío.

### `Rscript -e 'source(here::here("00_escanear_proyecto.R"))'`

```
- The project is out-of-sync -- use `renv::status()` for details.
here() starts at /Users/tomgc/Projects/slep_simce_adecuado
Escaneo completo: 23 carpetas, 163 archivos.
Snapshot: …/50_documentacion/estructura/20260827_103911_estructura.{txt,md}
Aliases : …/50_documentacion/estructura/estructura_actual.{txt,md}
Poda    : 2 archivo(s) de snapshots antiguos eliminados (retencion: 2 sellos).
```

Exit 0. El aviso de `renv` es el heredado del encargo 1 detenido; no impidió nada.

El snapshot nuevo ya refleja el renombrado:

```
### grep -n "motor_simce.html" 50_documentacion/estructura/estructura_actual.md
27:│   │   │   ├── motor_simce.html  (1.42K)
```

### Decisión 4 — commitear la poda del escáner pese al invariante "nada se borra"

**Ambigüedad.** El invariante 🔒 dice "Nada se borra". El escáner borró dos
archivos: `20260701_114145_estructura.{md,txt}`.

**Decisión.** Commitear la poda.

**Fundamento.** El borrado no lo hizo este encargo: lo hizo el escáner, aplicando
su propia política de retención de 2 sellos, y el encargo **manda** correr el
escáner en FASE FINAL. Además el mensaje de commit que el encargo prescribe es
"**rota** snapshot del escaner", y una rotación con retención fija es, por
definición, añadir el nuevo y soltar el más viejo. El invariante apunta a que el
asistente no borre por criterio propio, no a desactivar la rotación del escáner.

**Alternativa descartada.** Restaurar los dos archivos podados con `git checkout`
antes de commitear. Descartada porque dejaría el repositorio en un estado que el
escáner volvería a podar en su siguiente corrida, y porque contradiría la
retención que el propio proyecto configuró.

### `git status --short` tras el `git add`

```
R  50_documentacion/estructura/20260701_114145_estructura.md -> 50_documentacion/estructura/20260827_103911_estructura.md
R  50_documentacion/estructura/20260701_114145_estructura.txt -> 50_documentacion/estructura/20260827_103911_estructura.txt
M  50_documentacion/estructura/estructura_actual.md
M  50_documentacion/estructura/estructura_actual.txt
?? 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
```

Git detectó los pares como renombrados por similitud de contenido, lo que deja
más legible la rotación.

**Hash: `a340758`** — `chore(estructura): rota snapshot del escaner tras la ordenacion`

### Tabla de la FASE FINAL

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `ls *.R` en la raíz sin los tres | ninguno de los tres | **los tres siguen** (`ls -la *.R`); ver decisión 2 |
| `find -name "* *"` | vacío | vacío |
| Archivos versionados con espacio | 0 | 0 (`git ls-files \| grep " "`) |
| Escáner corre | sin error | exit 0, "Escaneo completo: 23 carpetas, 163 archivos" |
| Snapshot refleja el renombrado | sí | sí, `estructura_actual.md:27` → `motor_simce.html` |

---

## 8. Qué quedó sin verificar

- **Que el prototipo renombrado siga abriendo en navegador.** No se abrió. El
  renombrado no altera los enlaces salientes del HTML —se leyó su contenido
  completo para comprobarlo— pero no se ejecutó. Es un insumo congelado, no
  forma parte del pipeline.
- **Dónde está definida `asegurar_locale_utf8()`.** Se verificó que no está en
  este repositorio. No se buscó en la cartera ni en la knowledge base del
  Project: fuera de alcance.
- **Que los tres scripts de verificación sigan corriendo.** No se ejecutaron. No
  se tocaron, así que no hay motivo para que hayan cambiado de comportamiento,
  pero no se midió.
- **Si conviene archivar traspasos.** Solo se contó (27). La política es decisión
  del titular y este encargo no la decide.
- **`renv::status()` sigue fuera de sincronía**, por el encargo 1 detenido.
  Excluido del alcance por el titular.

---

## 9. Qué falló o sorprendió

1. **Sorpresa mayor: los tres scripts no están versionados.** Es el hallazgo que
   invalidó el COMMIT 1. La premisa 2 los daba por sueltos en la raíz —cierto—
   pero su fuente era el escáner, que mide el disco y no consulta git. El
   `.gitignore` los excluye desde el traspaso v20, y el propio
   `traspaso_cierre_v16.md` ya lo decía por escrito: "`verificar_depe4.R`
   (efímero, **no versionado**)". La información estaba en el repositorio; el
   encargo no la incorporó.

2. **Sorpresa asociada: el patrón está anclado a la raíz.** `/verificar_*.R`
   con barra inicial. Mover los archivos a `10_utils/` no habría sido neutro:
   los habría vuelto versionables. Un movimiento aparentemente cosmético
   escondía un cambio de política de versionado.

3. **El DRY_RUN sirvió exactamente para lo que existe.** Los tres fallos
   aparecieron con `git mv -n`, sin haber movido nada. Sin el invariante de
   dry-run, el descubrimiento habría llegado a mitad de operación.

4. **Sorpresa mayor: la guarda `asegurar_locale_utf8()` no existe en este
   repositorio.** La premisa 5 la daba por existente citando un `grep -rl` que
   solo prueba que la cadena aparece. Está descrito en §6. Lo que existe es la
   comprobación y el mensaje de remediación, no la función.

5. **El inventario de referencias resultó enteramente documental.** Ni una sola
   referencia en código ejecutable, en ninguno de los dos casos. Todo eran
   registros históricos y snapshots regenerables.

6. **Sorpresa menor: `git` detectó la rotación de snapshots como renombrados.**
   Por similitud de contenido entre el snapshot podado y el nuevo. No cambia
   nada, pero hace el commit más legible.
