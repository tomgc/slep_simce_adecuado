# Encargo autónomo: pendientes de la sesión 35, tercera ola (slep_simce_adecuado)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-25. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva.
Antecedente: `encargo_pendientes_s35b.md` y su log `20260925_pendientes_s35b_log.md` (commit `5e65bd3`, sin
push). El titular decidió D35-7 a D35-10, registradas en
`50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`.

**Meta en una línea:** aplicar D35-7 (NOTICE de gobCL), D35-8 (regla C de las cifras de la sparkline), D35-9
(Regular y Bold con la familia `gobCL-sitio`) y D35-10 (criterio y referencias de A3); corregir el tooltip del
referente, el plano de la vista entre 680 y 800 px y el documento de datos autorizados; y publicar en `main`
los commits de s35b y de este encargo, sin tocar `docs/`.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. Se admiten subagentes con **tope duro de 3
simultáneos, todos en Opus como máximo**, contando lectura, escritura y panel. La sesión principal orquesta,
no cuenta y no se delega. El plan está en §5.

```text
EJECUCIÓN: esfuerzo ultracode; orquestador Opus (modelo de la sesión);
subagentes tope 3 simultáneos (de ellos ≤ 3 Opus); total Opus del encargo ≤ 8
```

**Topes de esfuerzo.**

1. **3 intentos por bug.** Al tercer fix fallido, la tarea se congela con la evidencia y la cadena sigue.
2. **2 ciclos de reparación en FASE R.**
3. **1 reintento por comando** que falla por causa transitoria.

**Regla de detención.** Cada condición congela la tarea indicada y sus descendientes. Las tareas
independientes siguen.

- H1 a H3 (árbol, stash, `HEAD`) no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H4 (md5 de `docs/`, de `10_locale.R` y de los archivos de T0) difiere → **detén la sesión**.
- H5 (batería) o H6 (build) fallan → **detén la sesión**.
- H7 (no aparece una `gobCL_Bold.otf` legible con peso 700) → congela F1 y sus descendientes; S1 sigue con
  la fuente vigente.
- H8 (no aparece la herramienta de barrido de las sparklines del encargo anterior y no se puede rehacer según
  §7, S1, paso 1) → congela S1.
- Un criterio no se cumple tras 3 intentos → congela esa tarea.
- Un subagente toca fuera de su ALCANCE → congela su tarea sin commitear sus cambios.
- Un 🔒 da FALLA → congela la tarea que lo rompió; si no se aísla, **detén la sesión**.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques, regístralo y
  pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea. Nunca `git add -A` ni `git add .`.
2. `git rm 10_utils/fuentes/gobCL_Light.otf 10_utils/fuentes/gobCL_Heavy.otf`, solo en F1 y solo después de
   que la Bold esté copiada y verificada (H7).
3. **Descartar un intento de reparación sin commitear**:
   `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso, y solo si antes se guardó el
   intento como parche (`git diff -- <ruta> > $TMPDIR/cal_s35c/<tarea>_intento<N>.patch`) y se anotó su md5
   en el log. Así se cubre el caso de ERR-35-14.
4. `git push origin main`, una sola vez, al final de FASE L, con estas condiciones medidas en el mismo turno:
   veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío;
   `git fetch origin` seguido de `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de
   `docs/index.html` y `docs/trayectorias.html` iguales a H4. El push publica también los commits de s35b:
   el titular lo decidió en D35-7, con los `.otf` de gobCL incluidos en la historia.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`.
6. Crear `_archivo/20260925_capturas_s35c/` (ignorado) y escribir ahí capturas PNG.
7. Copiar (no mover) la `gobCL_Bold.otf` hallada en H7 a `10_utils/fuentes/gobCL_Bold.otf`, con el md5
   verificado antes y después.

Implícitas en el patrón: `fix(auditoria)` en FASE R y `docs(log)` en FASE L. Ningún subagente hereda
autorizaciones. Nada más.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables, con `|>`, `.by=` y `here::here()`,
y sin rutas absolutas en código R. Todo ejecutable nuevo carga `10_configuracion.R` después de
`library(here)`. Los nombres de archivo van sin tildes, sin ñ y sin espacios, y los commits en español. Las
cifras sobre datos salen de `Rscript`. I-7 se mide en forma absoluta (D35-3 valió solo para s35).

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS del titular, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS** (se verifican en FASE 0):
   - las decisiones D35-7 a D35-10 (léelas completas antes de F1, S1 y F2);
   - el log de s35b: FASE M2, FASE G, FASE A3 y FASE R (R-47 a R-53, R-59, R-62, R-65, R-73), y las dudas Q-26,
     Q-28, Q-32, Q-33, Q-35, Q-36 y Q-38;
   - los parches de R-48, si todavía existen en `$TMPDIR/cal_s35b/r48/`;
   - los scripts de medición que siguen en la raíz (`verificar_*.R`).
3. **POSICIÓN:** rutas completas desde la raíz; `bash -c '...'`, con
   `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado` en el mismo comando; R con `cd "$RAIZ" && Rscript ...`.
   Antes de operar contra el remoto, `git -C "$RAIZ" fetch origin`. `rev-parse` va con un argumento por
   comando.
4. **LOG:** `50_documentacion/andamios/logs/20260925_pendientes_s35c_log.md`.
5. **ALCANCE:** por tarea, en §5. Además, `verificar_*.R` en la raíz y `$TMPDIR`.
6. **PRUEBAS:** al cierre de toda fase que toque código, y completas en FASE R.
   - `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` → `codigo=0`.
   - `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` → `codigo=0`, con
     31 pruebas más las nuevas.
   - `cd "$RAIZ" && Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Salvo indicación, cada premisa se midió en la sesión 35 con git de solo lectura, `grep`, `sed` o `md5sum`
sobre la estación, o salió de la evaluación independiente del log de s35b.

- `HEAD` está en `5e65bd3` y `origin/main` en `9d612a3`, con 14 commits sin publicar (fuente: `git log`,
  evaluación de cumplimiento).
- El árbol tiene tres rutas sin commit (fuente: `git status --porcelain` y `md5sum`; la tercera es
  hipótesis, se mide en H1):
  - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, md5 `f31780f85bdadd6e1c50c63903a38036`;
  - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`, md5 `15e6fbb6860435c72e9e9b8665e7d221`;
  - `?? 50_documentacion/activa/encargos/encargo_pendientes_s35c.md` (este archivo; su md5 va en el mensaje de
    entrega).
- md5 de referencia (fuente: `md5sum`):
  - `docs/index.html`: `8deb04595510b0f15da8bb65813b7a38`;
  - `docs/trayectorias.html`: `267857a2962602bd9e6c5cc56effcb47`;
  - `10_utils/10_locale.R`: `dc900c1b0d2d252c9e5730875be5d632`.
- `10_utils/fuentes/` tiene Light (`f5a622b0…`), Regular (`0257bb4b…`) y Heavy (`6f435f30…`), y ninguna
  Bold (fuente: `ls` y `md5sum`). En la carpeta del repositorio no hay ninguna `gobCL_Bold.otf` (fuente:
  `find`). El evaluador reportó una Bold del kit con md5 `a7407ed6a70160cdb96021f83808a94c` y
  `usWeightClass` 700 (hipótesis, se mide en H7).
- `10_html.R` declara la familia `"gobCL"` en su `@font-face` (línea 33) y la lista de archivos en la línea 24
  (fuente: `grep -n`). El motor declara `FONT_SVG = "gobCL, system-ui, sans-serif"` (línea 1733) y `"gobCL"`
  en `--font-display` y `--font-body` (líneas 86-87). La «†» usa la familia del sistema (línea 386, R-47)
  (fuente: `grep -n`).
- La sparkline del motor (`SparklineSubchart`, línea 2106) resuelve los choques con `cajaCifraPrevia` y
  `cajaTraspaso`, subiendo siempre la segunda cifra (líneas 2226-2271) (fuente: `grep -n` y evaluación
  independiente). El log de s35b midió en su barrido de 2.832 sparklines 627 inversiones (métrica del auditor),
  893 (estricta), 0 superposiciones y 1 cifra fuera del SVG (fuente: log de s35b, líneas 674 y 827).
- Antes de M2 (`1a92827`), cada cifra iba en `max(8, cy - 6)`: 0 inversiones por construcción (fuente:
  `git show 1a92827`, evaluación independiente). Sus superposiciones en el barrido amplio nunca se midieron.
- Geometría de la sparkline en `HEAD`: `W=320, H=90, M={top:28,right:12,bottom:22,left:12}`, `ih=40`, año en
  `ih+13`, «traspaso» en `y=-2`, preliminar en `(cx+7, labelY-1)` y sin caja de choque (fuente: evaluación
  independiente, `sed` sobre `HEAD`).
- NOTICE declara Apache 2.0 «solo para el código» y lista D3, pako y React como componentes de terceros. No
  menciona tipografías (fuente: `cat NOTICE`).
- El criterio de A3 no se cumple contra las referencias posteriores a G después de R-50 (R-73). D35-10 lo
  redefine (fuente: evaluación de cumplimiento).

---

## 3. Contexto mínimo

`slep_simce_adecuado` produce dos páginas HTML autocontenidas que se publican en Pages desde `docs/`: el motor
(`33_motor_template.html` y `33_generar_html.R`) y la vista de trayectorias (`36_*`). El encabezado, el menú y
las `@font-face` salen de `33_fragmento_sitio.html` a través de `insertar_sitio()` en `10_utils/10_html.R`.
`00_build.R` corre todo. El proyecto es público.

---

## 4. Invariantes 🔒 (cada uno con su comando; FASE R los corre todos)

| # | Invariante y por qué | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` no se toca | `md5 -q docs/index.html docs/trayectorias.html` | `8deb0459…` y `267857a2…` |
| I-2 | El sitio no carga nada por red | `grep -c 'src="http'` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html` | `0` en cada uno |
| I-3 | Los vendorizados `.js` no cambian | `git diff --name-only <punto_de_retorno>..HEAD -- '10_utils/*.js'` | vacío |
| I-4 | La guarda de locale sigue en su sitio | `md5 -q 10_utils/10_locale.R` y `grep -n asegurar_locale_utf8 10_utils/10_configuracion.R` | `dc900c1b…` y una línea |
| I-5 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-6 | Las filas vigentes y del referente no cambian | prueba C3 | PASA |
| I-7 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-8 | Color por nivel, sin literales nuevos en `fill` | `git diff <punto_de_retorno>..HEAD -- 30_procesamiento/33_motor_template.html \| grep -E '^\+.*attr\("fill", *"#' \| grep -vE '#FFFFFF\|#0A3A5C'` | vacío |
| I-9 | El mockup de `andamios/` queda congelado | `git diff --name-only <punto_de_retorno>..HEAD -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html` | vacío |
| I-10 | El encabezado y el menú solo se editan en el fragmento | `grep -c '__SITIO_HTML__'` en las dos plantillas | `1` en cada una |
| I-11 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |

---

## 5. Grafo, ALCANCE y olas

**Grafo.**

- T0 es la raíz.
- N1 y D1 requieren T0.
- F1 requiere T0.
- S1 requiere F1, porque la regla se mide con la fuente final.
- V1 requiere F1.
- F2 requiere S1 y V1.
- FASE R y FASE L no dependen de ninguna tarea: corren siempre.

**ALCANCE (además de `verificar_*.R` y `$TMPDIR`).**

| Tarea | Rutas |
|---|---|
| T0 | las 3 rutas de §2 |
| N1 | `NOTICE` |
| D1 | `50_documentacion/activa/50_datos_versionados_autorizados.md` |
| F1 | `10_utils/fuentes/gobCL_Bold.otf` (nueva), `10_utils/fuentes/gobCL_Light.otf` y `10_utils/fuentes/gobCL_Heavy.otf` (se retiran), `10_utils/10_html.R`, `30_procesamiento/33_fragmento_sitio.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/*.html` |
| S1 | `30_procesamiento/33_motor_template.html`, `40_salidas/motor_comparacion.html` |
| V1 | `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_verificar_trayectorias.R`, `40_salidas/trayectorias_traspasos.html` |
| F2 | `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/*.html`, `_archivo/20260925_capturas_s35c/` |

**Olas.** Nadie commitea dentro de una ola. El orquestador verifica y commitea en el orden del grafo.

| Ola | Tareas | Subagentes |
|---|---|---|
| (orquestador) | FASE 0, T0, N1, D1 | ninguno |
| 1 | F1 | escritura Opus ×1 |
| 2 | S1 (motor), V1 (vista) | escritura Opus ×2 |
| 3 | F2 | escritura Opus ×1 |
| FASE R | panel adversarial | lectura Opus ×3 |

Total Opus declarado: 7 (tope 8). Si se alcanza el tope, la tarea en curso se congela.

**Contrato de subagentes (ocho reglas, en vigor).**

1. Tope de 3 simultáneos, todos en Opus como máximo.
2. Lectura: medir, re-derivar y auditar, sin escribir en el árbol. Escritura: su tarea dentro de su ALCANCE,
   sin git, sin log, sin borrar y sin lanzar subagentes.
3. En paralelo solo corren tareas independientes y con ALCANCE disjunto; commitea el orquestador.
4. Cada subagente recibe:
   - su tarea de §7 completa;
   - su ALCANCE;
   - los 🔒 con su porqué;
   - la POSICIÓN;
   - la regla «sin git, sin borrar, nada fuera del ALCANCE; ante una duda, detente y devuelve»;
   - el formato de retorno: rutas tocadas, comandos con salida literal, `esperado:`/`obtenido:` y dudas con
     pregunta cerrada.
5. Lo que devuelve un subagente es una hipótesis. El orquestador verifica las rutas (`git diff --name-only`
   más las no rastreadas), el criterio de la tarea y PRUEBAS.
6. Sin anidamiento.
7. Ante un fallo, un reintento con el mismo contrato. Al segundo fallo, la tarea la hace el orquestador en
   serie o se congela.
8. Cada tarea registra `Subagentes:` en el log, con rol, modelo, esfuerzo `xhigh`, ALCANCE, qué devolvió, con
   qué se verificó y la cuenta de Opus.

---

## 6. FASE 0: log, punto de retorno y premisas

Cada medición va con `esperado:` antes del comando y `obtenido:` literal después.

1. **Crear el log** con el encabezado (meta, fecha, repositorio y rama, ENTORNO, `EJECUCIÓN:` y modo real,
   grafo y olas, topes), el slot `## J. Juicio (lo rellena FASE L)` vacío y los bloques de la plantilla del
   Apéndice.
2. **H1.** `git -C "$RAIZ" status --porcelain` → esperado: las tres rutas de §2, más el log recién creado.
3. **H2.** `git -C "$RAIZ" stash list | wc -l` → esperado: `0`.
4. **H3.** `git -C "$RAIZ" fetch origin`. Después, `git -C "$RAIZ" rev-parse --short HEAD` → `5e65bd3`, y
   `git -C "$RAIZ" rev-parse --short origin/main` → `9d612a3`.
5. **H4 y T0.** md5 de `docs/index.html`, `docs/trayectorias.html` y `10_utils/10_locale.R` → esperado: los
   valores de §2. md5 de las dos rutas modificadas → esperado: `f31780f8…` y `15e6fbb6…`. md5 de este encargo →
   esperado: el del mensaje de entrega. Luego, `git add` de las tres rutas y
   `git commit -m "docs(sesion 35): decisiones D35-7 a D35-10, errores ERR-35-12 a ERR-35-15 y encargo de la tercera ola"`.
   El hash de ese commit es el **punto de retorno**.
6. **H5.** `Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` → esperado: 31 pruebas en
   PASA y `codigo=0`.
7. **H6 y línea base.** `Rscript 00_build.R; echo "codigo=$?"` → `codigo=0`.
   - Copia las dos salidas HTML a `$TMPDIR/base_s35c/`, con su md5.
   - Apunta `verificar_contenido_motor.R` a esa base y calíbralo: «idéntico» sobre la base, y «difiere» sobre
     una copia con un número alterado.
8. **H7 (fuente Bold).** Busca `gobCL_Bold.otf` en `"$HERRAMIENTAS_DEV_PATH"` (con `find`), en
   `~/Library/Fonts` y en `renv/library/*/*/*/suitedoc/tema/fonts/` → esperado: al menos un archivo con md5
   `a7407ed6a70160cdb96021f83808a94c`. Lee su `usWeightClass` y su cadena de copyright desde la tabla `name`,
   con una función de R que lea los bytes del archivo (`readBin`), o con `systemfonts::font_info()` si está
   instalado → esperado: `usWeightClass` 700. Si aparece con otro md5 pero con peso 700, anótalo y úsalo: el
   md5 del evaluador era hipótesis. Si no aparece ninguna, se aplica la regla de detención. Lee también el
   copyright de la Regular, para NOTICE.
9. **H8 (barrido de sparklines).** Busca el medidor del barrido amplio de s35b (en `$TMPDIR/cal_s35b/` o en
   `verificar_*.R`).
   - Si existe, córrelo sobre la base: esperado 627 inversiones con la métrica del auditor, 893 con la
     estricta, 0 superposiciones y 1 cifra fuera.
   - Si no existe, S1 lo rehace (§7, S1, paso 1).
10. Anexa la sección `### FASE 0` al log.

---

## 7. Tareas

Todas cierran con los cinco pasos fijos: verificación con `esperado:`/`obtenido:`; PRUEBAS si hubo código;
chequeo de alcance; commit con rutas explícitas; sección `### FASE <tarea>` en el log. El paso 0 de cada
tarea es leer las rutas de su ALCANCE.

### N1. NOTICE declara gobCL (D35-7) (orquestador)

Agrega a NOTICE, después de «COMPONENTES DE TERCEROS», una sección «TIPOGRAFÍA» que diga:

- que el sitio incrusta y el repositorio versiona la tipografía gobCL (caras Regular y Bold), tipografía
  institucional del Gobierno de Chile;
- el copyright leído en H7 (se transcribe tal como aparece en la tabla `name`; si no se pudo leer, se dice que
  no se pudo leer);
- que la licencia Apache 2.0 del proyecto **no** la cubre;
- que se usa por decisión del titular, como tipografía institucional de un servicio público del Estado
  (D35-7), y que quien reutilice el código debe obtenerla de su fuente oficial.

Agrega también una línea que excluya los activos tipográficos del alcance de «plantillas HTML/JS/CSS».
Verificación: `grep -c 'gobCL' NOTICE` → esperado: 2 o más; `grep -n 'TIPOGRAF' NOTICE` → una línea.
Commit: `docs(licencia): NOTICE declara la tipografia gobCL fuera de Apache 2.0 (D35-7)`.

### D1. Documento de datos autorizados (Q-36) (orquestador)

En `50_datos_versionados_autorizados.md`:

- corrige la afirmación de que los globs no cruzan `/` ni cubren `directorio_oficial_ee.csv` (R-54): el
  verificador I8 sí los cubriría, y el archivo se mantiene fuera del repositorio solo porque lo ignora
  `.gitignore`;
- actualiza las citas a líneas de `.gitignore` (R-55) con los números actuales, medidos con `grep -n`.

Verificación: cada número de línea citado coincide con `grep -n` del patrón en `.gitignore`. Commit:
`docs(gobernanza): datos autorizados precisa el alcance de sus globs (Q-36)`.

### F1. Dos caras de gobCL con familia propia (D35-9) (ola 1, escritor Opus)

1. Copia la Bold de H7 a `10_utils/fuentes/gobCL_Bold.otf` (autorización 7) y verifica el md5. Luego
   `git rm` de Light y Heavy (autorización 2).
2. En `10_html.R`:
   - `FUENTES_GOBCL` lista `gobCL_Regular.otf` (400) y `gobCL_Bold.otf` (700), con su md5;
   - la `@font-face` usa `font-family: "gobCL-sitio"`;
   - `insertar_sitio()` sigue deteniéndose si un md5 no coincide.
3. En las dos plantillas y en el fragmento:
   - `--font-display` y `--font-body` pasan a `"gobCL-sitio", system-ui, ...`, sin la gobCL local en el
     respaldo;
   - `FONT_SVG` pasa a `"gobCL-sitio, system-ui, sans-serif"`;
   - los comentarios que citan Light, Heavy o tres caras se actualizan;
   - la «†» sigue con la familia del sistema (R-47): verifica que en la Bold tampoco se confunda con «+».
4. **Criterio de carga** (reemplaza a `document.fonts.check()`, que no discrimina: ERR-35-12, Q-32). Con
   chromote, tras `await document.fonts.ready`, en las dos páginas:
   - (i) `[...document.fonts].filter(f => f.family.replace(/"/g,'') === 'gobCL-sitio' && f.status === 'loaded').map(f => f.weight)`
     → esperado: exactamente `400` y `700`;
   - (ii) `CSS.getPlatformFontsForNode` (CDP) sobre el título, el menú, una cifra de barras y una de la
     sparkline → esperado: `isCustomFont` verdadero y familia gobCL;
   - (iii) el ancho de `measureText('Establecimiento 42%')` en `700 32px "gobCL-sitio"` difiere en más de
     1 px del ancho en `700 32px system-ui`.
   - **Calibración:** (i) y (iii) deben fallar sobre una copia del HTML en `$TMPDIR` a la que se le quitó la
     `@font-face` (caso malo).
5. **Criterio de tamaño.** Cada HTML pesa menos que en la base, porque salen tres caras y entra una.
   Esperado: una diferencia negativa, anotada en B.
6. **Verificación.** I-2, I-5 y la batería en PASA. `scrollWidth` a 375, 540, 640, 680, 768 y 1280 px en la
   vista, `#comparacion` y `#panorama` → esperado: igual al viewport. Si no se cumple, registra el valor: F2
   lo corrige.
7. Commit: `feat(sitio): gobCL-sitio con Regular 400 y Bold 700; retira Light y Heavy (D35-9)`.

### S1. Regla C de las cifras de la sparkline (D35-8) (ola 2, escritor Opus)

Lee D35-8 y las secciones de s35b sobre R-48, R-51 y R-53.

1. **Medidor.** Si H8 no encontró el medidor, escribe `verificar_sparkline_barrido.R`, que recorre con
   chromote las mismas 2.832 sparklines del barrido de s35b (la definición del recorrido está en el log de
   s35b, FASE R, R-20 y R-48). El medidor cuenta:
   - inversiones, con la métrica del auditor y con la estricta (todo par de cifras visibles de años contiguos
     del mismo tramo, con redondeos distintos, cuyo centro vertical tenga el orden opuesto al de sus valores);
   - superposiciones cifra-cifra, cifra-«traspaso», cifra-año y cifra-«*»;
   - cifras fuera del `viewBox`, por lado;
   - cifras ocultas, con su lista.

   **Calibración (antes de tocar código):**
   - sobre la base (`HEAD` al punto de retorno) → esperado: 627 y 893 inversiones, 0 superposiciones y 1 fuera;
   - sobre el motor construido desde `1a92827` (en un worktree temporal fuera del árbol o con
     `git show 1a92827:30_procesamiento/33_motor_template.html` a `$TMPDIR`, generado con el mismo
     `33_generar_html.R`) → esperado: 0 inversiones, y registra sus superposiciones.
2. **Regla C.** Implementa D35-8 en `SparklineSubchart`:
   - posición inicial `cy - 6`;
   - para resolver un choque, sube la cifra de mayor valor o baja la de menor valor. La menor baja solo si su
     caja queda por encima de la banda de años;
   - el choque con «traspaso» se resuelve bajando la cifra;
   - la caja del «*» preliminar entra como obstáculo;
   - una pasada final de validación oculta la cifra del año más antiguo del par ante cualquier inversión,
     superposición o salida del SVG, y deja su valor (con su «†») en el tooltip;
   - todas las distancias van en constantes nombradas (`RECENT_DIMS` o un bloque `SPARK_DIMS`), sin literales.
3. **Criterio.**
   - Barrido amplio: 0 inversiones (las dos métricas), 0 superposiciones de las cuatro clases, 0 cifras fuera
     por arriba o por abajo, y por los lados no más que las 5 cifras de 1,8 u de R-62.
   - Número de cifras ocultas y su lista, en el log; cada oculta con su valor en el tooltip (verificado con
     chromote en 3 casos).
   - En la tarjeta 5103, grupo Medio bajo, «52%†» queda sobre «42%†», o la de 2014-2018 oculta con tooltip.
   - Casos de borde: SLEP 1305 (R-53) dentro del SVG; un Servicio Local traspasado con «traspaso»; una serie
     con valores bajo 30 % y «†» contiguas; una racha monótona de 2014 a 2018 con «†».
   - I-5, 0 errores en consola y 0 solicitudes de red.
   - **Calibración:** el medidor da 627 sobre la base (caso malo) y 0 sobre `1a92827` (caso bueno).
4. Commit: `fix(motor): cifras de la sparkline ordenadas por valor, con ocultamiento de respaldo (D35-8, R-48)`.

### V1. Vista: tooltip del referente y plano entre 680 y 800 px (Q-26, Q-33) (ola 2, escritor Opus)

1. **Tooltip del referente (Q-26, R-59).** Cambia «los traspasan las olas siguientes», con «2014» literal, por
   un texto armado desde `DATA`: el año del ancla, `cat` y `vig`, y los 17 cerrados. Agrega una prueba R7 a la
   batería que lea el tooltip con chromote y compare sus cifras con las de `DATA`. Calibración: R7 falla con el
   texto anterior.
2. **Plano (Q-33, R-65).** Entre 680 y ~800 px, `svg.chart` mide de 0 a 30 px de alto. Mide el alto a 680,
   700, 720, 760, 800 y 822 px, y corrige dentro de una media query acotada a ese tramo. Criterio: alto de
   `svg.chart` de 320 px o más en esos seis anchos, y 0 píxeles distintos a 1024, 1280 y 1920 px frente a la
   base de esta tarea. Calibración: el medidor da menos de 30 px en el estado base.
3. **Verificación.** Batería en PASA (31 + R7), C3 e I-6.
4. Commits:
   - `fix(trayectorias): tooltip del referente desde los datos (Q-26)`;
   - `fix(trayectorias): el plano no colapsa entre 680 y 800 px (Q-33)`.

### F2. Desborde y referencias después de la fuente final (D35-10) (ola 3, escritor Opus)

1. Mide `scrollWidth` en la vista, `#comparacion` y `#panorama` a 375, 540, 640, 641, 665, 680 y 768 px.
   Donde no sea igual al viewport, corrige dentro de las media queries vigentes (vista: `max-width:679px`;
   motor: `max-width` de 767 px o menos).
2. Regenera las capturas de referencia a 768, 1024, 1280 y 1920 px de las tres vistas en
   `_archivo/20260925_capturas_s35c/`.
3. **Criterio (D35-10).**
   - `scrollWidth` igual al viewport en todos los anchos de F2;
   - 0 píxeles distintos entre tres cargas en cada ancho de referencia;
   - capturas a 375 y 1280 px para la revisión del titular;
   - I-5 y la batería en PASA.
   - **Calibración:** la comparación de píxeles dispara con un color alterado en una copia.
4. Commit (solo si hubo corrección): `fix(sitio): sin desborde con la fuente final (D35-10)`. Si no hubo
   cambios, se declara y no se commitea.

---

## 8. FASE R: auditoría propia y reparación (penúltima y obligatoria; corre aunque haya tareas congeladas)

La regla de oro: **la reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni
la meta**.

1. **Inventario de afirmaciones auditables.** Se arma desde el log, no desde la memoria: cada línea
   `Verificación:`, cada cifra de las secciones por fase, cada 🔒 de §4 con su comando y el alcance global. Se
   numeran `R-01`, `R-02`, etc., y el inventario se anexa al log **antes** de auditar.
2. **Re-derivación independiente.** Cada afirmación se re-deriva con un comando distinto del que la produjo,
   con un panel adversarial de 3 lectores Opus en una sola ola. Cada auditor recibe la afirmación, la ruta de
   la fuente y el repositorio, sin el razonamiento ni el código que la produjo. Reparto:
   - auditor 1: S1 (con su propio medidor de inversiones y superposiciones sobre una muestra de 300 sparklines y los casos de borde);
   - auditor 2: F1, F2 y V1 (caras cargadas, anchos, desborde, alto del plano, tooltip del referente);
   - auditor 3: N1, D1, T0 e I-1 a I-11.
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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260925_pendientes_s35c_log.md` y
   `git commit -m "docs(log): pendientes de la sesion 35, tercera ola"`. Después, `git push origin main`, solo
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
   - el barrido de la sparkline antes y después (inversiones, superposiciones, fuera, ocultas);
   - las caras cargadas y el peso de cada HTML;
   - los `scrollWidth` antes y después por ancho;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos de este encargo, con su razón

- **Publicación a `docs/`:** efecto público. Requiere la revisión en Safari del titular sobre las capturas de F2.
- **Museo Sans en la suite** (D35-7): decisión de cartera, en una sesión BIBLIOTECA.
- **Q-21** (marco de ejes con unidades de muy pocos establecimientos) y **Q-34** (legibilidad del supergrid del
  motor bajo 540 px): son decisiones de diseño del titular.
- **`OP_PREVIO`** (cifras de los años previos al traspaso bajo 4,5:1), **Q-29** (opacidad 0,9 de las cifras de
  la sparkline), **Q-31** (el PNG exportado sin la fuente incrustada) y **Q-39** (el build interactivo): quedan
  como pendientes; ninguno toca datos.
- **v30-5** (la batería del motor que nunca se versionó): es un encargo propio.
- **Pendientes 8, 10, 12 y 13 de v34, y Q-16:** siguen bloqueados o dependen de una decisión del titular.

## Apéndice: plantilla del log

```markdown
# Log: pendientes de la sesión 35, tercera ola (slep_simce_adecuado)

- Meta: <una línea>
- Fecha: <AAAA-MM-DD> · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: <hash de T0>
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo ultracode; orquestador Opus; subagentes tope 3 (≤ 3 Opus); total Opus ≤ 8
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

### FASE N1 ... ### FASE F2 (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
