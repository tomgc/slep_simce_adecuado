# Encargo autónomo: pendientes de la sesión 35, segunda ola (slep_simce_adecuado)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-25. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva (contexto limpio).
Antecedente: `encargo_pendientes_s35.md` y su log `20260924_pendientes_s35_log.md` (commit `bd5fc58`),
evaluados por el asistente, con decisiones del titular D35-3 a D35-6 en
`50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` (commit `9d612a3`).

**Meta en una línea:** implementar D35-4, D35-5 y D35-6, corregir la línea 206 de `32_agregar_comunal.R`
con I-7 en forma absoluta, conectar el validador de portabilidad al build, migrar el sitio a gobCL y dejar la
vista y el motor sin desborde en pantallas angostas. Todo va commiteado y pusheado, sin tocar `docs/`: la
publicación es un encargo aparte, después de la revisión en Safari.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. Se admiten subagentes con **tope duro de 3
simultáneos, los 3 en Opus como máximo**, contando lectura, escritura y panel adversarial. La sesión
principal orquesta, no cuenta y no se delega. El plan de concurrencia está en §5.

```text
EJECUCIÓN: esfuerzo ultracode; orquestador Opus (modelo de la sesión);
subagentes tope 3 simultáneos (de ellos ≤ 3 Opus); total Opus del encargo ≤ 10
```

La elección sigue la tabla 2.12: hay dos cadenas de escritura con ALCANCE disjunto (vista y motor), una tarea
que toca las dos plantillas (gobCL), que va sola en su ola, y un panel de lectura en FASE R.

**Topes de esfuerzo.**

1. **3 intentos por bug.** Al tercer fix fallido, la tarea se congela con la evidencia y la cadena sigue.
2. **2 ciclos de reparación en FASE R.** Un hallazgo que sobrevive al segundo ciclo va al log como pendiente.
3. **1 reintento por comando** que falla por causa transitoria. Al segundo fallo, el comando pasa a ser un
   hallazgo registrado.

**Regla de detención (lista medible).** Cada condición congela la tarea indicada y sus descendientes (§5). Las
tareas independientes siguen.

- H1 a H3 (árbol, stash, `HEAD`) no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H4 (md5 de `docs/`, de `10_locale.R` y de este encargo) difiere → **detén la sesión**.
- H5 (batería actual) o H6 (build) fallan → **detén la sesión**.
- H7 (chromote, png y Chrome) falla → congela G, A3 y M3.
- H8 (fuentes gobCL) difiere → congela G y sus descendientes.
- H9 (determinismo de `simce_comunal.parquet`) falla → congela P1.
- Un criterio de tarea no se cumple tras 3 intentos → congela esa tarea.
- Un subagente toca fuera de su ALCANCE → congela su tarea sin commitear sus cambios.
- Un 🔒 da FALLA en un cierre de fase → congela la tarea que lo rompió; si no se aísla, **detén la sesión**.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques, regístralo y
  pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea. Nunca `git add -A` ni `git add .`.
2. `git push origin main`, una sola vez, al final de FASE L, con estas condiciones medidas en el mismo turno:
   veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío;
   `git fetch origin` seguido de `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de
   `docs/index.html` y `docs/trayectorias.html` iguales a H4.
3. Crear, sobrescribir y borrar scripts de medición efímeros `verificar_*.R` en la raíz (ignorados por
   `/verificar_*.R`) y archivos en `$TMPDIR`. Nunca se commitean.
4. Crear `_archivo/20260925_capturas/` (ignorado) y escribir ahí capturas PNG para la revisión del titular.
5. Copiar (no mover) los tres `50_documentacion/suite/fonts/gobCL_*.otf` a `10_utils/fuentes/`, con el md5
   verificado antes y después.

Implícitas en el patrón: los commits `fix(auditoria)` de FASE R y `docs(log)` de FASE L. Ningún subagente
hereda autorizaciones. Nada más.

**Reglas canónicas heredadas.**

- R es el único lenguaje de los entregables: pipe nativo `|>`, `dplyr` con `.by=` y `here::here()`. En código
  R nunca hay rutas absolutas.
- Todo ejecutable nuevo carga `10_utils/10_configuracion.R` en la línea siguiente a `library(here)`.
- Nombres de archivo sin tildes, sin ñ y sin espacios; commits en español.
- Las cifras sobre datos se producen con `Rscript`; el shell solo cuenta archivos, líneas y commits.
- **D35-3 vale solo para el encargo anterior.** En este encargo, I-7 se mide en forma absoluta después de P1.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS del titular, repositorio
   `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS** (se verifican en FASE 0):
   - las decisiones D35-1 a D35-6 en `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
     (léelas completas antes de A1, M1, M2 y G);
   - el log anterior `50_documentacion/andamios/logs/20260924_pendientes_s35_log.md` (las secciones T3, T4,
     T6, T9 y FASE R, y las dudas Q-02, Q-07, Q-08, Q-12 a Q-15 y Q-18 a Q-25);
   - las fuentes `50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf`, que no están versionadas;
   - los scripts de medición del encargo anterior que siguen en la raíz: `verificar_contenido_motor.R` y
     `verificar_navegador.R`.
3. **POSICIÓN:** rutas completas desde la raíz, siempre bajo `bash -c '...'`, con
   `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado` definida en el mismo comando. R corre con
   `cd "$RAIZ" && Rscript ...`. Antes de operar contra el remoto: `git -C "$RAIZ" fetch origin`.
4. **LOG:** `50_documentacion/andamios/logs/20260925_pendientes_s35b_log.md`.
5. **ALCANCE:** por tarea, en la tabla de §5. Además, toda tarea puede escribir `verificar_*.R` en la raíz y
   archivos en `$TMPDIR`.
6. **PRUEBAS:** corren al cierre de toda fase que toque código, y completas en FASE R.
   - `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` → `codigo=0`.
   - `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` → `codigo=0`, con
     las 28 pruebas previas más las que agreguen las tareas ya cerradas.
   - `cd "$RAIZ" && Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0 (§6, paso 5).

---

## 2. Estado de partida (premisas marcadas)

Salvo que se indique otra cosa, cada premisa se midió en la sesión 35 con git de solo lectura, `grep`,
`sed` o `md5sum` sobre la estación.

- `main` y `origin/main` están en `9d612a3` (fuente: `git log -1` y `git rev-parse --short origin/main`).
- El árbol tiene como única ruta sin commit este encargo:
  `?? 50_documentacion/activa/encargos/encargo_pendientes_s35b.md` (hipótesis, se mide en FASE 0, H1). Su md5
  viene en el mensaje de entrega.
- Los md5 de referencia son (fuente: `md5sum`):
  - `docs/index.html`: `8deb04595510b0f15da8bb65813b7a38`;
  - `docs/trayectorias.html`: `267857a2962602bd9e6c5cc56effcb47`;
  - `10_utils/10_locale.R`: `dc900c1b0d2d252c9e5730875be5d632`;
  - `30_procesamiento/32_agregar_comunal.R`: `4d66fe1f67ea5c5677ab1a814a37b277`.
- Archivos de datos versionados: 28 (fuente: `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`).
  `50_documentacion/activa/50_datos_versionados_autorizados.md` todavía dice «27 rutas» en las líneas 31 y 44
  (fuente: `grep -n`).
- La forma absoluta de I-7 da hoy exactamente una línea (fuente:
  `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`):
  `30_procesamiento/32_agregar_comunal.R:206:    .by = c(nom_com_rbd, cod_grupo, anio)`. Esa línea está en un
  diagnóstico que solo se imprime, después de `arrow::write_parquet` (línea 176), y filtrado a
  `cod_com_rbd %in% c("5103","5105","5107","5109")` (fuente: `sed -n 190,217p`, verificador de la sesión 35).
- `10_utils/10_configuracion.R` es propio del proyecto (su encabezado dice «Punto de arranque común de
  slep_simce_adecuado») y no define `ruta_insumos()` (fuente: `head -20` y `grep -rn ruta_insumos`).
  `10_validar_portabilidad.R` busca, en este orden, `obtener_data_root_proyecto`, `obtener_root_resguardo` y
  `ruta_insumos`, y de esta última usa `dirname()` (fuente: `grep -n`, líneas 255-282).
- Constantes del motor (fuente: `grep -n` en `33_motor_template.html`):
  - `COLOR_ELEM = "#6BA0CE"` (línea 1701), `TINTA_ELEM = "#3874A9"` (1708);
  - `ASTERISCO_UNICO = "*"` (2262) y `NOTA_UNICO` (2263);
  - rótulo interior blanco de las franjas en las barras (2375) y en el panorama (3169);
  - en la sparkline, `opacity = (isLowN ? 0.45 : 1) * opPrevio` en el punto (2198) y `opacity * 0.9` en la
    cifra;
  - `ChartHints` (2649) declara «Baja representatividad (un solo establecimiento)» con un swatch atenuado;
  - `#2E2230` ya existe (`--ink-2`, línea 34, y en `fill` en las líneas 2436 y 3076).
- Contrastes WCAG sobre la franja Elemental (fuente: cálculo del asistente con la fórmula WCAG): blanco sobre
  `#6BA0CE` da 2,78:1 y `#2E2230` sobre `#6BA0CE` da 5,44:1. `--ref` (`#8A8478`) sobre blanco da 3,72:1 e
  `--ink` (`#1C1212`) sobre blanco, 18,35:1.
- Vista (fuente: `grep -n` en `36_funciones_trayectorias.R` y en la plantilla):
  - `olas_referente()` está en las líneas 441-455 y usa la comuna de la última fila Simce;
  - el rótulo está en las líneas 784-796 y la marca de ola en 810-815;
  - la plantilla tiene `@media (max-width:640px)` (línea 60) y `(max-width:900px)` (línea 204).
- Cifras que el log del encargo anterior midió en R (fuente: log `bd5fc58`, cierre, punto 6):
  - batería de 28 pruebas;
  - `meta.REF.olas` 479/407/408; con el directorio, 475/406/401 (suma 1.282);
  - la vista desborda a 375 y 540 px (`scrollWidth` 641) y no desborda de 680 a 822 px;
  - `#comparacion` del motor da 376 a 375 px;
  - `#panorama` no desborda de 375 a 1280 px.

  Todas se vuelven a medir en la tarea que las usa.
- `chromote`, `png` y Chrome están disponibles, porque los instaló o usó el encargo anterior (hipótesis, se
  mide en FASE 0, H7).

---

## 3. Contexto mínimo

`slep_simce_adecuado` produce dos páginas HTML autocontenidas que se publican en Pages desde `docs/`:

- el motor: `30_procesamiento/33_motor_template.html`, generado por `33_generar_html.R`;
- la vista de trayectorias: `36_trayectorias_template.html`, con `36_funciones_trayectorias.R` y
  `36_generar_trayectorias.R`, validada por `36_verificar_trayectorias.R`.

El encabezado y el menú salen de `30_procesamiento/33_fragmento_sitio.html`, que `insertar_sitio()` de
`10_utils/10_html.R` inserta en las dos (D34-2). `00_build.R` corre los pasos 30 a 36. Todo el proyecto es
público.

Las decisiones que se implementan están resumidas en §7, en cada tarea. Su texto completo está en el archivo
de decisiones.

---

## 4. Invariantes 🔒 (cada uno con su comando; FASE R los corre todos)

| # | Invariante y por qué | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` no se toca: publicar es otro encargo | `md5 -q docs/index.html docs/trayectorias.html` | `8deb0459…` y `267857a2…` |
| I-2 | El sitio no carga nada por red | `grep -c 'src="http'` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html` | `0` en cada archivo |
| I-3 | Los vendorizados no cambian | `git diff --name-only <punto_de_retorno>..HEAD -- '10_utils/*.js'` | vacío |
| I-4 | La guarda de locale sigue en su sitio | `md5 -q 10_utils/10_locale.R` y `grep -n asegurar_locale_utf8 10_utils/10_configuracion.R` | `dc900c1b…` y una línea |
| I-5 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-6 | Las filas de las 36 vigentes y del referente no cambian | prueba C3 | PASA |
| I-7 | Se agrega por `cod_com_rbd`, nunca solo por `nom_com_rbd` (forma absoluta, D35-3) | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío desde el cierre de P1; antes de P1, exactamente la línea 206 |
| I-8 | Color por nivel: ninguna cifra usa un color literal nuevo, salvo las constantes declaradas | `git diff <punto_de_retorno>..HEAD -- 30_procesamiento/33_motor_template.html \| grep -E '^\+.*attr\("fill", *"#' \| grep -vE '#FFFFFF\|#0A3A5C'` | vacío; `TINTA_SOBRE_ELEM` se declara como constante y no como literal en `attr` |
| I-9 | El mockup de `andamios/` queda congelado | `git diff --name-only <punto_de_retorno>..HEAD -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html` | vacío |
| I-10 | El encabezado y el menú solo se editan en el fragmento | `grep -c '__SITIO_HTML__'` en las dos plantillas | `1` en cada una |
| I-11 | No se agrega ningún archivo de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |
| I-12 | P1 no cambia el parquet comunal | md5 de `40_salidas/intermedios/simce_comunal.parquet` tras el build, contra la línea base de H9 | igual |

---

## 5. Grafo, ALCANCE y olas

**Grafo.**

- T0 es la raíz de todo.
- P1 y P2 requieren T0.
- A1 requiere T0; A2 requiere A1.
- M1 requiere T0; M2 requiere M1.
- G requiere A2 y M2.
- A3 requiere G; M3 requiere G.
- FASE R y FASE L no dependen de ninguna tarea: corren siempre.

**ALCANCE (además de `verificar_*.R` en la raíz y `$TMPDIR`).**

| Tarea | Rutas |
|---|---|
| T0 | `50_documentacion/activa/encargos/encargo_pendientes_s35b.md` |
| P1 | `30_procesamiento/32_agregar_comunal.R` |
| P2 | `10_utils/10_configuracion.R`, `00_build.R` |
| A1 | `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_verificar_trayectorias.R`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/trayectorias_traspasos.html` |
| A2 | `30_procesamiento/36_verificar_trayectorias.R`, `50_documentacion/activa/50_datos_versionados_autorizados.md` |
| M1 | `30_procesamiento/33_motor_template.html`, `40_salidas/motor_comparacion.html` |
| M2 | ídem M1 |
| G | `10_utils/fuentes/gobCL_Light.otf`, `10_utils/fuentes/gobCL_Regular.otf`, `10_utils/fuentes/gobCL_Heavy.otf`, `10_utils/10_html.R`, `30_procesamiento/33_fragmento_sitio.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/*.html`, `_archivo/20260925_capturas/` |
| A3 | `30_procesamiento/36_trayectorias_template.html`, `40_salidas/trayectorias_traspasos.html`, `_archivo/20260925_capturas/` |
| M3 | `30_procesamiento/33_motor_template.html`, `40_salidas/motor_comparacion.html`, `_archivo/20260925_capturas/` |

**Olas.** Dentro de una ola nadie commitea. El orquestador verifica cada retorno con sus propios comandos y
commitea tarea por tarea, en el orden del grafo.

| Ola | Tareas | Subagentes |
|---|---|---|
| (orquestador) | FASE 0, T0, P1, P2 | ninguno |
| 1 | A1, M1 | escritura Opus ×2 |
| 2 | A2, M2 | escritura Opus ×2 |
| 3 | G | escritura Opus ×1 |
| 4 | A3, M3 | escritura Opus ×2 |
| FASE R | panel adversarial | lectura Opus ×3 |

Total Opus declarado: 10. Si se alcanza, la tarea en curso se congela; el tope no se amplía.

**Contrato de subagentes (ocho reglas, en vigor).**

1. Tope de 3 simultáneos, todos Opus como máximo. El orquestador no cuenta.
2. Dos roles:
   - lectura: medir, re-derivar y auditar, sin escribir en el árbol (sus scripts van a `$TMPDIR`);
   - escritura: implementar su tarea dentro de su ALCANCE, sin git, sin log, sin borrar y sin lanzar
     subagentes.
3. En paralelo solo corren tareas independientes y con ALCANCE disjunto. El orquestador commitea tras la ola.
4. Cada subagente recibe:
   - su tarea de §7 completa, con criterio y calibración;
   - su ALCANCE;
   - los 🔒 de §4 con su porqué;
   - la POSICIÓN;
   - la regla «sin git, sin borrar, nada fuera del ALCANCE; ante una duda, detente y devuelve»;
   - el formato de retorno: rutas tocadas, comandos con su salida literal, `esperado:`/`obtenido:` de su
     verificación, y dudas con pregunta cerrada.
5. Lo que devuelve un subagente es una hipótesis. Antes de commitear, el orquestador verifica:
   - que `git diff --name-only` más `git ls-files --others --exclude-standard` coinciden con la lista
     declarada;
   - el criterio de la tarea;
   - PRUEBAS.
6. Sin anidamiento.
7. Ante un fallo, un solo reintento con el mismo contrato. Al segundo fallo, la tarea la hace el orquestador
   en serie, o se congela.
8. Cada tarea lleva en el log una entrada `Subagentes:` con rol, modelo, esfuerzo `xhigh`, ALCANCE, qué
   devolvió, con qué comando se verificó y la cuenta acumulada de Opus.

---

## 6. FASE 0: log, punto de retorno y premisas

Cada medición va al log con su `esperado:` escrito **antes** de correr el comando y su `obtenido:` literal
después.

1. **Crear el log** (`mkdir -p 50_documentacion/andamios/logs`). Lleva el encabezado (meta, fecha,
   repositorio y rama, ENTORNO, `EJECUCIÓN:` y modo real de la sesión, grafo y olas de §5, topes), el slot
   `## J. Juicio (lo rellena FASE L)` vacío y los bloques de cierre de la plantilla del Apéndice.
2. **H1.** `git -C "$RAIZ" status --porcelain` → esperado: exactamente
   `?? 50_documentacion/activa/encargos/encargo_pendientes_s35b.md`. El log recién creado también aparece:
   anótalo y sigue.
3. **H2.** `git -C "$RAIZ" stash list | wc -l` → esperado: `0`.
4. **H3.** Primero `git -C "$RAIZ" fetch origin`. Después, en dos comandos separados,
   `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` → esperado:
   `9d612a3` en los dos. (La forma con dos argumentos en un solo `rev-parse --short` falla: ERR-35-06.)
5. **H4 y T0.** `md5 -q docs/index.html docs/trayectorias.html 10_utils/10_locale.R` → esperado:
   `8deb0459…`, `267857a2…` y `dc900c1b…`. `md5 -q 50_documentacion/activa/encargos/encargo_pendientes_s35b.md`
   → esperado: el md5 del mensaje de entrega. Luego `git add` de este encargo y
   `git commit -m "docs(sesion 35): encargo de la segunda ola de pendientes"`. El hash de ese commit es el
   **punto de retorno** y va al encabezado del log.
6. **H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` →
   esperado: 28 pruebas en PASA y `codigo=0`.
7. **H6 y línea base.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` → esperado: `codigo=0`.
   - Copia `40_salidas/motor_comparacion.html`, `40_salidas/trayectorias_traspasos.html` y
     `40_salidas/intermedios/simce_comunal.parquet` a `$TMPDIR/base_s35b/`, con sus md5.
   - Corre `Rscript verificar_contenido_motor.R`. Si todavía compara contra `$TMPDIR/base_s35/` o esa carpeta
     ya no existe, apúntalo a `$TMPDIR/base_s35b/`.
   - Calibra el comparador otra vez: «idéntico» sobre la base, y «difiere» sobre una copia con un número del
     JSON alterado.
8. **H7.** `Rscript -e 'cat(requireNamespace("chromote", quietly=TRUE), requireNamespace("png", quietly=TRUE))'`
   y `ls "/Applications/Google Chrome.app"` → esperado: `TRUE TRUE` y la carpeta existe.
9. **H8.** `md5 -q 50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf` → esperado:
   `f5a622b0b5f209c9197b2acfd2e1e299`, `0257bb4b62d5ec557627aa0136f1e1dc` y
   `6f435f30d6a13092b7d5db5255dcca1b`.
10. **H9 (determinismo del parquet comunal).** Corre dos veces seguidas
    `cd "$RAIZ" && Rscript 30_procesamiento/32_agregar_comunal.R`. Después de cada corrida, toma
    `md5 -q 40_salidas/intermedios/simce_comunal.parquet` y guarda la salida en consola del bloque «Costa
    Central» en `$TMPDIR/base_s35b/diag_cc_1.txt` y `diag_cc_2.txt` → esperado: el mismo md5 las dos veces y
    `diff` vacío entre los dos textos. Si el md5 no se repite, I-12 no es medible por md5: congela P1.
11. **H10.** Mide la forma absoluta de I-7 (§4) → esperado: exactamente la línea 206.
12. Anexa la sección `### FASE 0` al log.

---

## 7. Tareas

Todas cierran con los cinco pasos fijos, en este orden:

1. verificación con `esperado:` y `obtenido:`;
2. PRUEBAS, si la tarea tocó código;
3. chequeo de alcance (`git diff --name-only HEAD` más `git ls-files --others --exclude-standard`, dentro del
   ALCANCE);
4. commit con rutas explícitas;
5. sección `### FASE <tarea>` en el log.

El paso 0 de cada tarea es leer las rutas de su ALCANCE antes de editarlas.

### P1. `32_agregar_comunal.R`: el diagnóstico agrupa por código (orquestador)

1. Línea 206: `.by = c(cod_com_rbd, nom_com_rbd, cod_grupo, anio)`. La línea 210 queda
   `dplyr::arrange(nom_com_rbd, cod_grupo)`. Agrega un comentario que cite D35-3.
2. **Verificación.**
   - I-7 en forma absoluta → vacío.
   - Corre `Rscript 30_procesamiento/32_agregar_comunal.R` → el md5 del parquet es igual al de H9 (I-12).
   - La salida del bloque «Costa Central», sin la columna `cod_com_rbd`, es idéntica a `diag_cc_1.txt`. Si
     `print` agrega la columna, compara quitándola con `awk`, y declara el comando.
   - **Calibración:** I-7 en forma absoluta da la línea 206 en `git show <punto_de_retorno>:30_procesamiento/32_agregar_comunal.R`
     (caso malo) y vacío en el archivo nuevo (caso bueno).
3. Commit: `fix(pipeline): el diagnostico de Costa Central agrupa por codigo de comuna (D35-3)`.

### P2. El validador de portabilidad entra al build (Q-02) (orquestador)

1. En `10_utils/10_configuracion.R`, después de la guarda de locale, agrega el accesor
   `ruta_insumos <- function(...) here::here("20_insumos", ...)`. El comentario debe decir que la raíz de
   datos es el propio repositorio (POLITICA §6.2, raíz unificada) y que el validador toma `dirname()` de este
   accesor. No edites `10_validar_portabilidad.R`: es copia del kit.
2. Corre
   `Rscript -e 'source(here::here("10_utils","10_configuracion.R")); source(here::here("10_utils","10_validar_portabilidad.R")); r <- validar_portabilidad(detener_si_falla = FALSE); print(r)'`
   → esperado: 0 críticas. Corre también `validar_portabilidad_autotest()` → esperado: detecta la violación
   que siembra.
3. Si hay 0 críticas, agrega a `00_build.R`, después de `source(... "10_utils.R")`, la carga del validador y la
   llamada `validar_portabilidad()`, con un comentario que cite el pendiente 9 de v34.
   - Verificación: `Rscript 00_build.R` → código 0.
   - Control positivo: crea `verificar_portabilidad_plantada.R` en la raíz con una ruta absoluta de usuario;
     el build debe fallar. Bórralo (autorización 3) y el build debe volver a código 0. Si el validador no
     escanea ese archivo, la calibración queda en el autotest y se declara así.
4. Si quedan críticas: no edites `00_build.R`, congela la tarea y registra la lista como duda.
5. Commit: `chore(build): valida portabilidad al inicio del build con raiz unificada (pendiente 9 de v34)`.

### A1. D35-4: el referente se cuenta por ola con el directorio (ola 1, escritor Opus)

Lee D35-4 y las dudas Q-12 a Q-15 y Q-22 del log anterior.

1. **Primero las pruebas.** Agrega a `36_verificar_trayectorias.R` las pruebas que siguen, y corre la batería
   → esperado: R5 y R6 en FALLA, y las 28 previas en PASA.
   - **R5:** `meta$REF$olas` vale 475, 406 y 401 y suma 1.282. El recuento independiente cruza los RBD del
     referente con `establecimientos_chile.parquet` (presencia, sin filtrar por dependencia) y con el
     catálogo por `cod_com_rbd` del directorio.
   - **R6:** en la copia sintética de R3 (año 2027 con dependencia «5» para la ola 2027), la leyenda
     calculada dice «807 de 1.282 aún municipales». R3 se amplía para cubrir `olas` (Q-13).
   - **Calibración:** R5 falla si `olas` se calcula por la comuna de la última fila Simce (479, caso malo), y
     pasa con la regla nueva.
2. **Código.**
   - `olas_referente()` cuenta, por ola de `OLAS_FUTURAS`, los RBD del referente **presentes** en el
     directorio, según la comuna que registra el directorio.
   - `meta$REF` gana `vig`: los presentes en el directorio (1.282).
   - Corrige el comentario de las líneas 435-440 para que diga la regla nueva.
3. **Plantilla.**
   - Rótulo: «Referente: <cat> municipales en 2014 · <vig> se traspasan entre <primera> y <última> · con
     resultado en <año>: <e>». El rango de años usa solo olas con conteo mayor que 0. Con marcas, agrega
     «· <vig − salen> de <vig> aún municipales», calculado para el año en pantalla (Q-14).
   - El texto de la marca de ola usa `--ink` (18,35:1) y la línea conserva `--ref` (Q-15).
   - En las notas, el párrafo del referente queda coherente con 1.299, 1.282 y 17.
4. **Verificación.**
   - Batería en PASA (28 + R5 + R6).
   - Con chromote a 1280 px en el estado inicial, el texto de `#lg` contiene «1.299 municipales en 2014 ·
     1.282 se traspasan entre 2027 y 2029» y el `e` esperado, calculado en R desde `DATA`.
   - C3 en PASA (I-6).
5. Commit: `fix(trayectorias): referente contado por ola con el directorio y rotulo con 1.282 (D35-4)`.

### A2. Pruebas y documentación pendientes de la vista (ola 2, escritor Opus)

1. **D9 ampliada (Q-23).** El recuento independiente del total `T` se extiende a las 37 unidades futuras.
   Calibración: falla con una fila futura alterada en una copia.
2. **Q-25.** En `50_datos_versionados_autorizados.md`, las líneas 31 y 44 pasan de 27 a 28 rutas, y se agrega
   la fila de inspección de `20_insumos/auxiliares/dim_slep_comunas.csv` (catálogo público, sin persona
   natural, commit de origen `d7a8ec6`).
3. **Verificación.** Batería en PASA. `grep -c '28 rutas' 50_documentacion/activa/50_datos_versionados_autorizados.md`
   → esperado: al menos 1, y `grep -c '27 rutas'` → esperado: `0`.
4. Commit: `test(trayectorias): recuento independiente de las unidades futuras; docs: 28 rutas autorizadas`.

### M1. D35-5: la cifra dentro de la franja Elemental usa tinta oscura (ola 1, escritor Opus)

1. Declara la constante `const TINTA_SOBRE_ELEM = "#2E2230";` junto a `TINTA_ELEM`. Úsala solo en el rótulo
   interior de las franjas, en las barras (línea ~2375) y en el panorama (~3169):
   `.attr("fill", seg.fill === COLOR_ELEM ? TINTA_SOBRE_ELEM : "#FFFFFF")`. Las franjas no cambian de color
   (D-color-nivel).
2. **Verificación.** Con chromote, en modo apilado en `#comparacion` y en `#panorama`, a 1280 px:
   - todo rótulo interior de Elemental usa `#2E2230`;
   - su contraste, calculado en R contra `#6BA0CE`, es 4,5 o más (esperado: 5,44);
   - mide y registra el contraste del rótulo interior de Insuficiente (blanco sobre `COLOR_INSUF`). Si da menos
     de 4,5 es ADVIERTE: no está decidido y no se corrige;
   - I-5 e I-8.
   - **Calibración:** el medidor da 2,78 sobre el estado base (caso malo).
3. Commit: `fix(motor): cifra dentro de la franja Elemental con tinta oscura (D35-5)`.

### M2. D35-6: «un solo establecimiento» se marca con «†», también en la sparkline (ola 2, escritor Opus)

1. `ASTERISCO_UNICO` pasa a `"†"`. `NOTA_UNICO` se actualiza sola.
2. **Sparkline** (líneas ~2193-2217): el punto y la cifra dejan de atenuarse por `isLowN`
   (`opacity = opPrevio`), y la cifra agrega `ASTERISCO_UNICO` cuando `isLowN`. La atenuación de los años
   previos al traspaso (`OP_PREVIO`) no se toca: es otro pendiente.
3. **ChartHints:** el ítem «Baja representatividad (un solo establecimiento)» cambia su swatch atenuado por el
   signo «†» y queda «† Un solo establecimiento».
4. El «*» del dato preliminar no se toca.
5. **Verificación.**
   - En un estado con `n_estab == 1` (el que midió T4 del encargo anterior), a 375 y 1280 px:
     - 0 `<text>` con `opacity` menor que 1 por `isLowN`, en barras y en sparkline;
     - las cifras de ese punto terminan en «†»;
     - 0 «*» fuera de los usos preliminares (con `meta.anios_preliminar` vacío, 0 «*» en total);
     - 0 textos superpuestos.
   - La nota y el SVG exportado dicen «† Un solo establecimiento».
   - I-5.
   - **Calibración:** el conteo de «*» da más de 0 en el estado base (caso malo).
6. Commit: `fix(motor): un solo establecimiento se marca con † en barras y sparkline (D35-6)`.

### G. Migración del sitio a gobCL (pendiente 3 de v34, D33-4) (ola 3, escritor Opus)

1. Copia los tres `.otf` a `10_utils/fuentes/` (autorización 5) y verifica el md5 contra H8. Son vendorizados
   de terceros, así que conservan su nombre.
2. En `10_html.R`:
   - declara la constante `FUENTES_GOBCL` (archivo, peso, md5). Pesos: Light 300, Regular 400 y Heavy 700;
   - `insertar_sitio()` se detiene si un md5 no coincide;
   - inserta tres `@font-face` con `src: url(data:font/otf;base64,...) format("opentype")` y
     `font-display: swap` en un marcador nuevo, `/*__FUENTES__*/`, dentro del CSS de
     `33_fragmento_sitio.html`;
   - `PATRON_SITIO_RESTO` incluye el marcador nuevo.
3. En las dos plantillas:
   - `--font-display` y `--font-body` pasan a `"gobCL", system-ui, ...` (con el stack actual como respaldo);
   - actualiza el comentario de L79-80 del motor;
   - los literales `"system-ui, sans-serif"` de los textos SVG pasan a una constante `FONT_SVG` con gobCL
     primero.
4. **Criterio de no regresión** (reemplaza al del encargo anterior, Q-18):
   - antes de editar, mide `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 540, 640, 680, 768 y
     1280 px, y guárdalo;
   - después, cada valor debe ser menor o igual al anterior;
   - `document.fonts.check('16px gobCL')` y `document.fonts.check('700 16px gobCL')` dan `true` en las dos
     páginas;
   - I-2;
   - cada HTML crece entre 145.000 y 175.000 B;
   - 0 textos superpuestos en `svg.bars-svg` a 375 y 1280 px en la carga inicial y en el estado de M2;
   - I-5 y la batería en PASA;
   - capturas antes y después, a 375 y 1280 px, de las tres vistas en `_archivo/20260925_capturas/`.
   - **Calibración:** el md5 de `insertar_sitio()` detiene el build con un `.otf` alterado en una copia en
     `$TMPDIR`.
   - **ADVIERTE esperado:** el PNG exportado puede caer al respaldo del sistema. Mídelo y regístralo.
5. Commit: `feat(sitio): tipografia gobCL incrustada en motor y vista (D33-4)`.

### A3. La vista sin desborde en pantallas angostas (pendiente 4 de v34) (ola 4, escritor Opus)

1. **Diagnóstico antes de editar.** Con chromote, a 375, 540 y 641-665 px, anota
   `getBoundingClientRect().right` de cada `.ctls > .f`, `.hdacc`, `.pl`, `.tk`, `.main` y `#g`. Referencias
   nuevas: capturas del estado posterior a G a 768, 1024, 1280 y 1920 px.
2. **Corrección.** Solo con CSS y marcado de `36_trayectorias_template.html`, **todo dentro de
   `@media (max-width:679px)`**, ampliando el de 640 px o agregando uno. Enfoque sugerido, en orden de ancho
   probable:
   - el grupo «Cobertura» pasa a una clase con `flex-wrap:wrap`, y `.sw` a `white-space:normal`;
   - `.ctls .f{flex:1 1 100%;min-width:0}`;
   - `.pl` con `flex-wrap:wrap` o `.tk{min-width:0}`;
   - `.main` apilado con `minmax(0,1fr)`, y un alto explícito para `svg.chart`.

   Después de cada corrección, vuelve a medir: `scrollWidth` solo muestra el elemento más ancho.
3. **Criterio.**
   - `scrollWidth` igual al viewport a 375, 540, 640, 641, 665, 680 y 768 px;
   - 0 píxeles distintos a 768, 1024, 1280 y 1920 px frente a las referencias del paso 1;
   - el plano (`svg.chart`) tiene un alto de 320 px o más a 375 px;
   - batería en PASA;
   - capturas a 375 y 540 px en `_archivo/20260925_capturas/`.
   - **Calibración:** la comparación de píxeles dispara con un color alterado en una copia.
4. Commit: `fix(trayectorias): sin desborde horizontal bajo 680 px (pendiente 4 de v34)`.

### M3. El motor sin desborde a 375 px (Q-19 y Q-20) (ola 4, escritor Opus)

1. Mide `scrollWidth` de `#comparacion` y `#panorama` a 375, 540 y 768 px. Localiza el elemento que suma 1 px
   en `#comparacion` a 375 px (el log anterior sospecha de `.hero-card`).
2. Corrige solo dentro de una media query de `max-width` 767 px o menos.
3. **Criterio.**
   - `scrollWidth` igual al viewport en los tres anchos y en las dos vistas;
   - 0 píxeles distintos a 768, 1024, 1280 y 1920 px frente al estado posterior a G;
   - I-5.
   - **Calibración:** como en A3.
4. Commit: `fix(motor): sin desborde a 375 px en comparacion (Q-19)`.

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
   - auditor 1: A1, A2, R5, R6 y D9, con un conteo propio en R sobre el directorio y el catálogo;
   - auditor 2: I-5, M1, M2 y M3, con su propio decodificador del JSON, su propio medidor de superposición y
     su propio cálculo de contraste;
   - auditor 3: P1, P2, G, A3 e I-1 a I-4 e I-7 a I-12.
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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260925_pendientes_s35b_log.md` y
   `git commit -m "docs(log): pendientes de la sesion 35, segunda ola"`. Después, `git push origin main`, solo
   si se cumple la autorización 2. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   revisión en Safari, capturas y publicación a `docs/`. Incluye el hash de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - los contrastes medidos (Elemental, Insuficiente y la sparkline);
   - los `scrollWidth` antes y después por ancho;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos de este encargo, con su razón

- **Publicación a `docs/`:** efecto público; requiere la revisión en Safari del titular sobre las capturas.
- **Q-21** (si las unidades con muy pocos establecimientos, `504_2027` y `1310_2029`, fijan el marco de los
  ejes): es una decisión de diseño del titular.
- **Atenuación `OP_PREVIO`** de los años previos al traspaso en el motor, con cifras bajo 4,5:1: es un pendiente
  nuevo y necesita su propia decisión.
- **v30-5:** la batería de 28 pruebas del motor nunca se versionó. Rehacerla es un encargo propio.
- **Pendiente 8 de v34 y Q-16** (`renv.lock`, `suitedoc`): siguen bloqueados.
- **Pendientes 10, 12 y 13 de v34:** decisión del titular o insumos pendientes.
- **Fin del referente:** se decide con el Simce 2028.

---

## Apéndice: plantilla del log

```markdown
# Log: pendientes de la sesión 35, segunda ola (slep_simce_adecuado)

- Meta: <una línea>
- Fecha: <AAAA-MM-DD> · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: <hash de T0>
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo ultracode; orquestador Opus; subagentes tope 3 (≤ 3 Opus); total Opus ≤ 10
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

### FASE P1 ... ### FASE M3 (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
