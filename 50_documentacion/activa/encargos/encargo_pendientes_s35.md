# Encargo autónomo: pendientes de la sesión 35 (slep_simce_adecuado)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redactor: asistente de análisis, sesión 35,
2026-09-24. Ejecutor: Claude Code en la estación macOS del titular, en una sesión nueva (contexto limpio).

**Meta en una línea:** implementar D35-1 y D35-2 en la vista de trayectorias, resolver los pendientes
ejecutables de v34 en el motor y en el repositorio, migrar el sitio a gobCL, medir las dudas heredadas, y
dejar todo commiteado y pusheado sin tocar `docs/` (la publicación en Pages es un encargo aparte, después
de la revisión en Safari del titular).

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. Subagentes admitidos con **tope duro de 4
simultáneos, de ellos 3 o menos en Opus**, contando lectura, escritura y panel adversarial. La sesión
principal orquesta, no cuenta y no se delega. Plan de concurrencia en §5.

```text
EJECUCIÓN: esfuerzo ultracode; orquestador Opus (modelo de la sesión);
subagentes tope 4 simultáneos (de ellos ≤ 3 Opus); total Opus del encargo ≤ 12
```

Razón de la elección (tabla 2.12): el encargo tiene dos cadenas de escritura con ALCANCE disjunto (vista y
motor), más revisiones de solo lectura. Por eso se usa `ultracode` con un escritor Opus por cadena en cada
ola. Dentro de cada cadena las tareas van en serie. El agente mecánico (Sonnet) solo diagnostica ramas.

**Topes de esfuerzo.**

1. **3 intentos por bug.** Al tercer fix fallido la tarea se congela con la evidencia de los tres intentos y
   la cadena sigue. No hay cuarto intento.
2. **2 ciclos de reparación en FASE R.** Un hallazgo que sobrevive al segundo ciclo va al log como
   pendiente.
3. **1 reintento por comando** que falla por causa transitoria (red, lock, timeout). Al segundo fallo, el
   comando es un hallazgo registrado.

**Regla de detención (lista medible).** Cada condición congela la tarea indicada y sus descendientes en el
grafo (§5). Las independientes siguen.

- FASE 0, H1 a H3 (árbol, stash, `HEAD`) no dan lo esperado → **detén la sesión entera** y pasa a FASE L.
  Es un estado que compromete el repositorio.
- FASE 0, H4: algún md5 de los archivos de T0 difiere del declarado → congela T0 y **detén la sesión**. Un
  archivo del asistente cambió sin que el encargo lo sepa (ERR-34-01).
- FASE 0, H5 o H6 difieren → **detén la sesión** (un 🔒 ya está roto antes de empezar).
- FASE 0, H8 (batería actual) o H9 (build) fallan → **detén la sesión**. No hay línea base contra la cual
  comparar.
- H10 (chromote y Chrome) no se puede satisfacer tras la autorización 6 → congela T3, T6, T7, T8 y las
  partes de T11 que usan navegador; el resto sigue.
- H11 (catálogo de origen) difiere → congela T1, T2, T3 y T8.
- H12 (fuentes gobCL) difiere → congela T8.
- H13 (conteo de municipales futuros) difiere de 2.564 → congela T1 y descendientes. No ajustes la meta al
  número encontrado.
- Un criterio de tarea (§7) no se cumple tras 3 intentos → congela esa tarea.
- Un subagente toca una ruta fuera de su ALCANCE → congela su tarea y no commitees sus cambios.
- Un 🔒 da FALLA en cualquier cierre de fase → congela la tarea que lo rompió. Si no se puede aislar,
  **detén la sesión**.
- `git push` rechazado o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques, regístralo, y
  pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea. Nunca `git add -A` ni `git add .`.
2. `git rm --cached _archivo/auditoria_agregacion_comunal.R`, solo en T9 y solo si FASE 0 midió
   `git ls-files _archivo` = exactamente esa línea. El archivo queda en disco.
3. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío;
   `git fetch origin` seguido de `git merge-base --is-ancestor origin/main HEAD` con código 0; y md5 de
   `docs/index.html` y `docs/trayectorias.html` iguales a los de H5.
4. Crear y sobrescribir scripts de medición efímeros como `verificar_*.R` en la raíz del repo (ignorados por
   `.gitignore`, regla `/verificar_*.R`) o en `$TMPDIR`. Nunca se commitean.
5. Crear `_archivo/20260924_capturas_gobcl/` (ignorado) y escribir capturas PNG ahí.
6. `Rscript -e 'install.packages("chromote", repos = "https://cloud.r-project.org")'`, solo si H10 mide que
   `chromote` no está instalado y sí existe Chrome. No corras `renv::snapshot()`.
7. Copiar (no mover) `~/Projects/slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv` a
   `20_insumos/auxiliares/dim_slep_comunas.csv`, y los tres `50_documentacion/suite/fonts/gobCL_*.otf` a
   `10_utils/fuentes/`, con md5 verificado antes y después.

Dos autorizaciones vienen implícitas con el patrón: los commits `fix(auditoria)` de FASE R y el commit
`docs(log)` de FASE L. Ningún subagente hereda autorizaciones. Nada más.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables: todo script que quede en el
repositorio va en R, con pipe nativo `|>`, `dplyr` con `.by=`, y `here::here()` para las rutas. Todo
ejecutable nuevo carga `10_utils/10_configuracion.R` en la línea siguiente a `library(here)`. Los nombres de
archivo van sin tildes, sin ñ y sin espacios. Los mensajes de commit van en español. Las cifras sobre datos
se producen con `Rscript`; el shell cuenta archivos, líneas y commits, no filas de datos.

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS del titular, sobre el repositorio local
   `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS** (rutas en esa estación; todas se verifican en FASE 0):
   - Repositorio: `/Users/tomgc/Projects/slep_simce_adecuado`.
   - Catálogo de olas: `/Users/tomgc/Projects/slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv` (solo lectura).
   - Fuentes gobCL: `/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf` (no versionadas).
   - Decisiones que este encargo implementa: `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` (D35-1, D35-2, batería R1-R4 y C1-C5). Léela completa en T1 y T2 antes de escribir código.
   - Página de contexto con las cifras de la sesión 35: `50_documentacion/andamios/20260924_contexto_referente_trayectorias.html`.
3. **POSICIÓN:** todo comando usa rutas completas desde la raíz y corre bajo `bash` explícito
   (`bash -c '...'`), nunca en el shell interactivo. Las variables se definen en el mismo comando:
   `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`. R corre con `cd "$RAIZ" && Rscript ...`, porque
   `here` ancla en el `.Rproj`. Antes de operar contra el remoto: `git -C "$RAIZ" fetch origin` y
   comparación de `main` contra `origin/main`.
4. **LOG:** `50_documentacion/andamios/logs/20260924_pendientes_s35_log.md`.
5. **ALCANCE:** por tarea, en la tabla de §5. Lo que no está listado no se toca.
6. **PRUEBAS** (regresión; corre al cierre de toda fase que toque código y completa en FASE R):
   - `cd "$RAIZ" && Rscript 00_build.R` → código 0.
   - `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R` → código 0, con 19 pruebas
     previas más las nuevas que hayan agregado las tareas ya cerradas.
   - `cd "$RAIZ" && Rscript verificar_contenido_motor.R` (lo escribe FASE 0, §6 paso 7) → «JSON idéntico a
     la línea base» mientras ninguna tarea haya declarado un cambio de datos del motor (ninguna lo declara).
7. **PUNTO DE RETORNO:** FASE 0 mide el árbol y el stash, commitea T0, y registra el hash resultante como
   punto de retorno en el encabezado del log. Toda reversión es un `git revert` de un commit propio.

---

## 2. Estado de partida (premisas marcadas)

Las fuentes son comandos y lecturas que el redactor hizo en la sesión 35, sobre la misma estación, a
través del puente de Cowork.

- `main` y `origin/main` están en `b8c8e1a` (fuente: eco de `/apertura` y `git branch -vv` en la sesión 35).
- El árbol tiene 4 rutas del asistente sin commit, y este encargo será la quinta (fuente: `git status
  --porcelain` en la sesión 35; la quinta es hipótesis, se mide en FASE 0):
  - ` M 50_documentacion/activa/decisiones/20260924_decision_datos_vista_trayectorias.md`, md5 `d76951a793fdcb7225d943f8604b0f64`
  - `?? 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, md5 `f6e79bb619b053c7245b83cd2deb1fee`
  - `?? 50_documentacion/andamios/20260924_contexto_referente_trayectorias.html`, md5 `7d2c0f2a8584ca79a1ce64ab32d262c5`
  - `?? 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`, md5 `100028e3cbdd73c245e1fc41a30345fc`
  - `?? 50_documentacion/activa/encargos/encargo_pendientes_s35.md` (este archivo; su md5 viene en el mensaje de entrega)
- `docs/index.html` md5 `8deb04595510b0f15da8bb65813b7a38` y `docs/trayectorias.html` md5
  `267857a2962602bd9e6c5cc56effcb47` (fuente: `md5sum` en la sesión 35).
- `10_utils/10_locale.R` md5 `dc900c1b0d2d252c9e5730875be5d632` (fuente: `md5sum` en la sesión 35).
- Archivos de datos versionados: 27 (fuente: `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'` en la
  sesión 35).
- `_archivo/auditoria_agregacion_comunal.R` es el único archivo versionado bajo `_archivo/`, aunque
  `.gitignore` excluye `_archivo/` (fuente: `git ls-files _archivo` y `.gitignore`, sesión 35).
- Ramas locales: `feat/contrato-contexto` (con upstream), `gobernanza/v16` (upstream `gone`),
  `respaldo_normativos_20260824` y `respaldo_prerebase_20260824` (sin upstream) (fuente: `git branch -vv`,
  sesión 35).
- `dim_slep_comunas.csv` de origen: md5 `fdb3015da12264d370a9d670c6886c0b`, último commit que lo toca
  `d7a8ec6` (2026-09-15), `HEAD` de `slep_central_datos` en `fa29dc8`, 346 comunas más encabezado (fuente:
  `md5sum`, `git log -1 -- <archivo>`, `wc -l`, sesión 35).
- Olas 2027, 2028 y 2029: 37 unidades (cod_slep, año), con 13, 11 y 13 por ola; 36 códigos distintos, porque
  `502` (del Litoral) tiene comunas en 2027 y 2028; `506` y `1601` ya existen en `sleps_chile.parquet` con
  cohorte 2026 (fuente: recuento del asistente sobre el catálogo y `sleps_chile.parquet`, sesión 35).
- Municipales (`cod_depe2 == "1"`) de `establecimientos_chile.parquet` en comunas de las olas 2027 a 2029:
  2.564, de ellos 1.593 con algún resultado válido; ninguno está en `sleps_chile.parquet` (fuente: recuento
  del asistente, sesión 35; se re-mide en R en FASE 0, H13).
- Referente: 1.299; 1.282 de ellos entre los 2.564; 17 no están en el directorio (cerrados) (fuente:
  recuento del asistente, sesión 35).
- Botones de cohorte escritos a mano en `36_trayectorias_template.html` (`#c-coh`, 6 botones de 2018 a 2026
  con su número de Servicios Locales) (fuente: `sed -n 220,232p`, sesión 35).
- `S` inicial de la vista: `coh:'2018', np:'4b_lect', gse:'T', panel:0`, año en pantalla por `anioAct()`
  (fuente: `grep -n` en la plantilla, sesión 35).
- En el motor, `isLowN` es `s.n_estab === 1` (un solo establecimiento, D-celda-unico-establecimiento). Con
  `isLowN`, las barras llevan opacidad 0,45 y las cifras 0,7 (líneas ~2323-2420 de
  `33_motor_template.html`) (fuente: `sed -n 2318,2425p`, sesión 35). El pendiente 2 de v34 lo llamaba «pocos
  evaluados»: el nombre correcto de la señal es «un solo establecimiento».
- En el motor quedan reglas CSS `.app-header-right` y `.brand-*` (líneas 129-140 y 314-319) (fuente: `grep
  -n`, sesión 35). Que no tengan uso es hipótesis y se mide en T7.
- `--font-display` y `--font-body` usan hoy el stack del sistema, con un comentario que anticipa gobCL
  (L79-80 del motor) (fuente: `sed -n 70,90p`, sesión 35). Los textos SVG usan el literal
  `"system-ui, sans-serif"` (fuente: `sed`, sesión 35).
- Fuentes gobCL (fuente: `ls -l` y `md5sum`, sesión 35):
  - `gobCL_Light.otf`: 37.960 B, md5 `f5a622b0b5f209c9197b2acfd2e1e299`
  - `gobCL_Regular.otf`: 36.528 B, md5 `0257bb4b62d5ec557627aa0136f1e1dc`
  - `gobCL_Heavy.otf`: 44.776 B, md5 `6f435f30d6a13092b7d5db5255dcca1b`
- `10_utils/10_validar_portabilidad.R` no tiene invocador en el pipeline; solo lo cita el README (fuente:
  `grep -rn`, sesión 35).
- `36_verificar_trayectorias.R` corre 19 pruebas con código 0 (hipótesis, se mide en FASE 0, H8).
- `00_build.R` corre con código 0 (hipótesis, se mide en FASE 0, H9).
- `chromote` está instalado y Chrome existe en la estación (hipótesis, se mide en FASE 0, H10).
- El paquete `png` está instalado, para comparar píxeles (hipótesis, se mide en FASE 0, H10).

---

## 3. Contexto mínimo

`slep_simce_adecuado` produce dos páginas HTML autocontenidas, publicadas en GitHub Pages desde `docs/`:

- **El motor** (`30_procesamiento/33_motor_template.html`, generado por `33_generar_html.R` a
  `40_salidas/motor_comparacion.html` y copiado a `docs/index.html`). Datos en JSON comprimido dentro del
  HTML. React y D3 están vendorizados en `10_utils/` y el build verifica su sha384.
- **La vista de trayectorias** (`36_trayectorias_template.html`, generada por `36_generar_trayectorias.R` con
  `36_funciones_trayectorias.R` a `40_salidas/trayectorias_traspasos.html` y copiada a
  `docs/trayectorias.html`). La valida `36_verificar_trayectorias.R`.

El encabezado y el menú salen de `30_procesamiento/33_fragmento_sitio.html`, que `insertar_sitio()` de
`10_utils/10_html.R` inserta en los marcadores `/*__SITIO_CSS__*/` y `<!--__SITIO_HTML__-->` (D34-2).
`00_build.R` corre los pasos 30 a 36. Todo el proyecto es público: sus datos son publicaciones de la Agencia
y del MINEDUC a nivel de establecimiento.

Las decisiones que se implementan están en `20260924_decision_referente_traspasos.md`. En resumen:

- **D35-1.** Se mantiene el referente anclado en 2014. Su leyenda dice el tamaño del grupo y cuántos tienen
  resultado en el año elegido, y la serie lleva una marca vertical en cada ola que sale.
- **D35-2.** Los Servicios Locales de las olas 2027 a 2029 entran a la vista como 37 unidades con
  identificador `<cod_slep>_<año>`, con sus municipales del directorio y el itinerario siempre previo al
  traspaso.

---

## 4. Invariantes 🔒 (cada uno con su comando; FASE R los corre todos)

| # | Invariante y porqué | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` no se toca: la publicación es otro encargo, tras la revisión en Safari | `md5 -q docs/index.html docs/trayectorias.html` | `8deb0459…` y `267857a2…` (H5) |
| I-2 | El sitio no carga nada por red | `grep -c 'src="http' 40_salidas/motor_comparacion.html 40_salidas/trayectorias_traspasos.html docs/index.html docs/trayectorias.html` y `grep -c 'url(http' <mismos>` | `0` en cada archivo |
| I-3 | React, ReactDOM, Babel, D3 y pako vendorizados no cambian | `git diff --name-only <punto_de_retorno>..HEAD -- 10_utils/*.js` | vacío |
| I-4 | La guarda de locale sigue en su lugar (D34-1) | `md5 -q 10_utils/10_locale.R` y `grep -n 'asegurar_locale_utf8' 10_utils/10_configuracion.R` | `dc900c1b…` y una línea |
| I-5 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-6 | En la vista, las filas de las 36 unidades vigentes y del referente no cambian (C3) | prueba C3 de `36_verificar_trayectorias.R` | PASA |
| I-7 | Se agrega por `cod_com_rbd`, nunca por `nom_com_rbd` | `grep -nE '(\.by|by|group_by)[^#]*nom_com_rbd' 30_procesamiento/*.R` | vacío |
| I-8 | Color por nivel: las cifras solo usan `tintaNivel()`, blanco o `COLOR_*` | `git diff <punto_de_retorno>..HEAD -- 30_procesamiento/33_motor_template.html \| grep -E '^\+.*attr\("fill", *"#' \| grep -vE '#FFFFFF\|#0A3A5C'` | vacío |
| I-9 | El mockup de `andamios/` queda congelado | `git diff --name-only <punto_de_retorno>..HEAD -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html` | vacío |
| I-10 | El encabezado y el menú solo se editan en el fragmento | `grep -c '__SITIO_HTML__' 30_procesamiento/33_motor_template.html 30_procesamiento/36_trayectorias_template.html` | `1` en cada uno |
| I-11 | Solo se agrega un archivo de datos, y está autorizado | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | 28 (27 + `dim_slep_comunas.csv`) |
| I-12 | La segmentación por grupo socioeconómico del motor no cambia | cubierto por I-5 (mismo JSON) | «idéntico» |

---

## 5. Grafo de tareas, ALCANCE y olas

**Grafo.**

- T0 (docs del asistente) es la raíz de todo.
- T9 requiere T0.
- T1 requiere T0; T2 requiere T1; T3 requiere T2.
- T4 requiere T0; T5 requiere T4; T6 requiere T5; T7 requiere T6.
- T8 requiere T3 y T7.
- T10 y T11 requieren T0 y son independientes de todo lo demás.
- FASE R y FASE L no dependen de ninguna tarea: corren siempre, también si alguna quedó congelada.

**ALCANCE (lista cerrada por tarea; además, toda tarea puede escribir `verificar_*.R` en la raíz y archivos
en `$TMPDIR`).**

| Tarea | Rutas que puede crear o editar |
|---|---|
| T0 | las 5 rutas de §2 (solo `git add` y commit) |
| T9 | `00_build.R`; índice de `_archivo/auditoria_agregacion_comunal.R` (`git rm --cached`) |
| T1 | `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_generar_trayectorias.R`, `30_procesamiento/36_verificar_trayectorias.R`, `30_procesamiento/36_trayectorias_template.html`, `20_insumos/auxiliares/dim_slep_comunas.csv`, `50_documentacion/activa/50_datos_versionados_autorizados.md`, `50_documentacion/activa/manifiesto_insumos.md`, `40_salidas/trayectorias_traspasos.html` (ignorado) |
| T2 | `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_verificar_trayectorias.R`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/trayectorias_traspasos.html` |
| T3 | `30_procesamiento/36_trayectorias_template.html`, `40_salidas/trayectorias_traspasos.html` |
| T4 | `30_procesamiento/33_motor_template.html`, `40_salidas/motor_comparacion.html` (ignorado) |
| T5 | ídem T4 |
| T6 | ídem T4 |
| T7 | ídem T4 |
| T8 | `10_utils/fuentes/gobCL_Light.otf`, `10_utils/fuentes/gobCL_Regular.otf`, `10_utils/fuentes/gobCL_Heavy.otf`, `10_utils/10_html.R`, `30_procesamiento/33_fragmento_sitio.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/*.html`, `_archivo/20260924_capturas_gobcl/` (ignorado) |
| T10 | ninguna (solo lectura; resultado al log) |
| T11 | ninguna (solo lectura; resultado al log) |

**Plan de concurrencia (olas; cada una con 4 subagentes o menos y 3 o menos en Opus).** Dentro de una ola
nadie commitea. El orquestador espera a la ola entera, verifica cada retorno con comandos propios y
commitea tarea por tarea, en orden del grafo.

| Ola | Tareas | Subagentes |
|---|---|---|
| (orquestador) | FASE 0, T0, T9 | ninguno |
| 1 | T1 (vista), T4 (motor), T11 (dudas), T10 (ramas) | T1: escritura Opus; T4: escritura Opus; T11: lectura Opus; T10: lectura Sonnet |
| 2 | T2 (vista), T5 (motor) | escritura Opus ×2 |
| 3 | T3 (vista), T6 (motor) | escritura Opus ×2 |
| 4 | T7 (motor) | escritura Opus ×1 |
| 5 | T8 (gobCL) | escritura Opus ×1 |
| FASE R | panel adversarial | lectura Opus ×3 |

Total Opus declarado: 3 + 2 + 2 + 1 + 1 + 3 = 12. Si se alcanza el total, la tarea en curso se congela y el
tope no se amplía.

**Contrato de subagentes (las ocho reglas, en vigor).**

1. Tope de 4 simultáneos, de ellos 3 o menos en Opus. El orquestador no cuenta.
2. Dos roles. Lectura: medir, re-derivar, auditar; sin escribir en el árbol (sus scripts van a
   `$TMPDIR`). Escritura: implementar una tarea dentro de su ALCANCE; sin git, sin log, sin borrar y sin
   lanzar subagentes.
3. Solo corren en paralelo tareas independientes en el grafo y con ALCANCE disjunto. El orquestador
   commitea tras la ola.
4. Cada subagente recibe su tarea completa de §7 (con criterio y calibración), su ALCANCE, los 🔒 de §4
   con su porqué, la POSICIÓN, la regla «sin git, sin borrar, nada fuera del ALCANCE; ante una duda, detente
   y devuelve», y este **formato de retorno**:
   - rutas tocadas (lista);
   - comandos corridos, con su salida literal;
   - `esperado:` y `obtenido:` de su verificación;
   - dudas, cada una con una pregunta cerrada.
5. Su retorno es hipótesis. El orquestador verifica antes de commitear:
   - `git diff --name-only` más `git ls-files --others --exclude-standard`, idénticos a la lista declarada;
   - el criterio de la tarea;
   - PRUEBAS.
6. Sin anidamiento.
7. Si un subagente falla, se reintenta una vez con el mismo contrato. Al segundo fallo, la tarea la hace
   el orquestador en serie o se congela.
8. La sección del log de cada tarea lleva `Subagentes:` con rol, modelo, esfuerzo `xhigh`, ALCANCE, qué
   devolvió, con qué comando se verificó y la cuenta acumulada de Opus.

---

## 6. FASE 0: log, punto de retorno y premisas

1. **Crear el log** (`mkdir -p 50_documentacion/andamios/logs`), con:
   - el encabezado de §4 del instrumento: meta, fecha, repositorio y rama, ENTORNO, la línea `EJECUCIÓN:` y
     el modo real de la sesión, el grafo y el plan de concurrencia copiados de §5, y los topes;
   - el slot `## J. Juicio (lo rellena FASE L)`, vacío;
   - los bloques vacíos de cierre de la plantilla del Apéndice.

   Cada medición que sigue va al log con su `esperado:` escrito **antes** de correr el comando y su
   `obtenido:` literal después.
2. **H1.** `git -C "$RAIZ" status --porcelain` → esperado: exactamente las 5 líneas de §2 (una ` M` y
   cuatro `??`).
3. **H2.** `git -C "$RAIZ" stash list | wc -l` → esperado: `0`.
4. **H3.** `git -C "$RAIZ" fetch origin && git -C "$RAIZ" rev-parse --short HEAD origin/main` → esperado:
   `b8c8e1a` dos veces. Si `HEAD` avanzó, pero `origin/main` es igual a `HEAD` y los commits nuevos solo
   tocan `50_documentacion/activa/ESTADO.md`, regístralo y sigue. Cualquier otra diferencia detiene la
   sesión.
5. **H4.** `md5 -q` de las 4 rutas de §2 con md5 declarado → esperado: los cuatro valores de §2. La quinta
   (este encargo) → esperado: el md5 del mensaje de entrega.
6. **H5 y H6.** `md5 -q docs/index.html docs/trayectorias.html 10_utils/10_locale.R` → esperado: `8deb0459…`,
   `267857a2…` y `dc900c1b…`.
7. **T0 (commit de los archivos del asistente).** `git add` de las 5 rutas de §2 y
   `git commit -m "docs(sesion 35): decisiones D35-1 y D35-2, contexto del referente, encargo y errores"`.
   Luego `git rev-parse --short HEAD`: ese hash es el **punto de retorno** y va al encabezado del log.
8. **H7.** `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'` → esperado: `27`.
9. **H8.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` →
   esperado: 19 pruebas en PASA y `codigo=0`. Anota el número exacto de pruebas que imprime: es la línea
   base de PRUEBAS.
10. **H9 y línea base.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` → esperado: `codigo=0`. Después:
    - copia `40_salidas/motor_comparacion.html` y `40_salidas/trayectorias_traspasos.html` a
      `$TMPDIR/base_s35/` y anota su md5 en el log;
    - escribe `verificar_contenido_motor.R` en la raíz. Primero lee en `33_generar_html.R` cómo se inserta el
      JSON (marcador, compresión, codificación). El script extrae el JSON del HTML generado y de la copia
      base, lo decodifica en R, quita `fecha_generacion` y compara con `identical()`. Imprime
      «JSON idéntico a la línea base» o el primer camino que difiere. El resto del HTML no se compara, porque
      las tareas del motor lo cambian a propósito.
    - **Calibración de ese comparador.** (a) Sobre la propia línea base debe imprimir «idéntico». (b) Sobre
      una copia en `$TMPDIR` a la que se altera un número del JSON (se decodifica, se cambia un valor, se
      recodifica) debe imprimir «difiere». Anota las dos salidas.
11. **H10 (navegador y píxeles).**
    `Rscript -e 'cat(requireNamespace("chromote", quietly=TRUE), requireNamespace("png", quietly=TRUE))'` y
    `ls "/Applications/Google Chrome.app"` → esperado: `TRUE TRUE` y la carpeta existe.
    - Si falta `chromote` y Chrome existe, aplica la autorización 6 y vuelve a medir.
    - Escribe `verificar_navegador.R` en la raíz, con funciones de chromote para cuatro cosas: abrir un
      `file://` a un ancho dado; devolver `document.documentElement.scrollWidth`; capturar un PNG; y devolver
      la lista de cajas de los `<text>` de un SVG.
    - Calibra `scrollWidth`: la vista en su estado base a 375 px debe dar más de 375 (caso malo conocido,
      pendiente 4 de v34), y a 1280 px debe dar 1280 (caso bueno).
12. **H11.** `md5 -q /Users/tomgc/Projects/slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv`
    → esperado: `fdb3015da12264d370a9d670c6886c0b`. Además, `git -C /Users/tomgc/Projects/slep_central_datos
    log -1 --format=%h -- 30_procesamiento/catalogo/dim_slep_comunas.csv` → esperado: `d7a8ec6`.
13. **H12.** `md5 -q 50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf` → esperado: `f5a622b0…`,
    `0257bb4b…` y `6f435f30…`.
14. **H13.** En R, lee `40_salidas/intermedios/establecimientos_chile.parquet` y el CSV de origen (separador
    `;`, todo como `character`). Valida la lectura con
    `stopifnot(nrow(cat) == length(readLines(ruta)) - 1L)`. Cuenta los RBD con `cod_depe2 == "1"` cuyo
    `cod_com_rbd` está en comunas con `anio_traspaso` en 2027, 2028 o 2029 → esperado: `2564`. Cuenta
    también los pares (`cod_slep`, `anio_traspaso`) de esas olas → esperado: `37`, repartidos 13, 11 y 13.
15. **H14.** `git -C "$RAIZ" ls-files _archivo` → esperado: una sola línea,
    `_archivo/auditoria_agregacion_comunal.R`.
16. Anexar la sección `### FASE 0` al log con todas las mediciones (esperado y obtenido) y el hash de T0.

---

## 7. Tareas

Todas cierran con los cinco pasos fijos, en este orden:

1. Verificación observable, con `esperado:` y `obtenido:`.
2. PRUEBAS, si la tarea tocó código.
3. Chequeo de alcance: `git diff --name-only HEAD` más `git ls-files --others --exclude-standard` debe
   estar contenido en su ALCANCE.
4. Commit con rutas explícitas.
5. Sección `### FASE <tarea>` en el log (4.1).

El «Paso 0» de cada tarea es leer las rutas de su ALCANCE antes de editarlas.

### T9. Higiene del repositorio (orquestador, antes de la ola 1)

1. `git rm --cached _archivo/auditoria_agregacion_comunal.R` (autorización 2). Verificación:
   `git ls-files _archivo | wc -l` → esperado `0`; `test -f _archivo/auditoria_agregacion_comunal.R && echo
   presente` → esperado `presente`. Commit: `chore(repo): saca _archivo/ del índice (pendiente 11 de v34)`.
2. **Portabilidad.** Corre
   `Rscript -e 'source(here::here("10_utils","10_validar_portabilidad.R")); r <- validar_portabilidad(detener_si_falla = FALSE); print(r)'`
   y `validar_portabilidad_autotest()`. Esperado: 0 fallas críticas, y el autotest detecta sus violaciones
   plantadas (eso es la calibración).
   - Si hay 0 críticas, agrega a `00_build.R`, en la línea siguiente a `source(... "10_utils.R")`, la carga
     de `10_validar_portabilidad.R` y la llamada `validar_portabilidad()`, con un comentario que cite el
     pendiente 9 de v34.
   - Verificación: `Rscript 00_build.R` → código 0.
   - Control positivo: crea en la raíz un `verificar_portabilidad_plantada.R` con una ruta absoluta
     `/Users/x/y`, y `00_build.R` debe fallar con código distinto de 0. Después borra el caso plantado (`rm`
     de ese archivo, incluido en la autorización 4 porque es un `verificar_*.R`) y vuelve a correr → código
     0. Si el validador no escanea la raíz y el build no falla, la calibración queda a cargo de
     `validar_portabilidad_autotest()` y se declara así en el log. No se planta nada fuera del ALCANCE.
   - Commit: `chore(build): valida portabilidad al inicio del build (pendiente 9 de v34)`.
   - Si hay críticas: no edites `00_build.R`, congela esta subtarea y registra la lista de críticas como
     duda.

### T1. Cohortes futuras en la vista (D35-2) (ola 1, escritor Opus)

Lee completa `20260924_decision_referente_traspasos.md` (D35-2) antes de escribir.

1. **Primero las pruebas.** Agrega a `36_verificar_trayectorias.R`, con el estilo de las existentes (`# ----
   C1. ... ----`), las pruebas C1 a C5 de la decisión, y corre la batería.
   - Esperado: las 19 previas en PASA y C1 a C5 en FALLA, porque las unidades futuras y el argumento
     `incluir_futuras` todavía no existen.
   - C3 es autocontenida: construye `DATA` con `construir_datos_trayectorias(insumos, incluir_futuras =
     TRUE)` y con `incluir_futuras = FALSE`, filtra `datos` a las 36 unidades vigentes y a `REF`, y compara
     con `identical()`. Con `FALSE`, la función debe reproducir exactamente el `DATA` de hoy: compruébalo
     una vez contra una copia guardada en `$TMPDIR/base_s35/` antes de tocar el código (la copia no la usa
     la prueba permanente).
   - Anota qué pruebas fallan.
2. **Insumo.** Copia el CSV de origen a `20_insumos/auxiliares/dim_slep_comunas.csv` (autorización 7);
   `md5 -q` de la copia → esperado `fdb3015d…`.
   - En `manifiesto_insumos.md`, agrega una sección «Catálogo de olas de traspaso» con origen
     (`slep_central_datos`, ruta, commit `d7a8ec6`), md5, fecha de copia y regla de actualización (se recopia
     cuando cambie el catálogo de origen; el build no lee el otro repositorio).
   - En `50_datos_versionados_autorizados.md`, extiende la descripción de la entrada
     `20_insumos/auxiliares/*.csv` para que nombre también el catálogo público de comunas por Servicio Local
     y año de traspaso. No hace falta una entrada nueva: el patrón ya lo cubre.
3. **Código** en `36_funciones_trayectorias.R`:
   - Lectura validada del CSV en `leer_insumos_trayectorias()`, con `leer_intermedio()` o una función
     hermana, y lectura de `establecimientos_chile.parquet`.
   - Constantes nombradas: `OLAS_FUTURAS <- c(2027L, 2028L, 2029L)`,
     `ORDEN_REGIONES <- c(15, 1, 2, 3, 4, 5, 6, 7, 16, 8, 9, 14, 10, 11, 12, 13)`,
     `SEP_ID_FUTURO <- "_"`.
   - Unidades futuras según D35-2: identificador `<cod_slep>_<año>`; nombre `slep_formato`, con el sufijo
     «(comunas que se traspasan en <año>)» si el código ya existe en `ORDEN_SLEP`; establecimientos del
     directorio con `cod_depe2 == "1"` en sus comunas; series con `filas_datos()` igual que las vigentes;
     `tras` igual al año; `post` calculado como hoy.
   - `ORDEN_SLEP` conserva sus 36 códigos al inicio. Las futuras se agregan en orden de ola, luego
     `ORDEN_REGIONES` y luego código, calculado desde el catálogo, no escrito a mano.
   - La validación `setequal(fichas$cod_slep, ORDEN_SLEP)` sigue aplicando a las vigentes. Las futuras se
     validan contra el catálogo.
4. **Plantilla**:
   - Los botones de `#c-coh` se generan desde los datos: el generador inserta un marcador nuevo,
     `<!--__COHORTES__-->`, con un botón por año de `tras` y su número de unidades. Así desaparecen los
     literales, y los años 2027, 2028 y 2029 aparecen con 13, 11 y 13.
   - El comentario y el cálculo del encuadre (hoy «sobre los 36 Servicios Locales») pasan a todas las
     unidades, vigentes y futuras. Mide y anota el máximo de los ejes antes y después; si cambia, eso es un
     ADVIERTE esperado, no un error.
   - Cualquier texto de las notas que diga «36» se reemplaza por una cifra de `cifras_notas()`.
5. **Verificación.**
   - Batería completa → esperado: todas en PASA (19 + C1-C5), código 0.
   - `Rscript 36_generar_trayectorias.R` → código 0.
   - Con chromote a 1280 px, al pulsar el botón 2027 la cohorte muestra 13 Servicios Locales (texto de
     `#cnt` o del encabezado de la lista), 0 errores en consola y 0 solicitudes de red.
   - **Calibración:** C5 dispara si se cuenta `cod_depe2 %in% c("1","5")` en una copia temporal (caso
     malo), y C3 dispara si se altera una fila vigente en una copia de `DATA` (caso malo). Anota las dos
     salidas.
6. Commits:
   - `feat(insumos): catalogo de olas de traspaso desde slep_central_datos (D35-2)` con el CSV y los dos
     `.md`;
   - `feat(trayectorias): cohortes futuras 2027-2029 con itinerario previo al traspaso (D35-2)` con los
     scripts 36 y la plantilla.

### T2. Rótulo del referente y marca de ola (D35-1) (ola 2, escritor Opus)

1. **Primero las pruebas.** Agrega R1 a R4 de la decisión y corre la batería.
   - Esperado: R1 en PASA (ya se cumple), y R2, R3 y R4 en FALLA.
   - R3 trabaja sobre una copia en memoria de `simce_rbd`: agrega un año sintético 2027 que copia las filas
     de 2025 de los RBD del referente, con `cod_depe2 == "5"` para los de la ola 2027. El referente de 2027
     debe perder exactamente esos RBD.
   - R2 lee el HTML generado con chromote: el texto de `#lg` en el estado inicial contiene
     `fmt(meta.REF.cat)` y el `e` del referente para `anioAct()` y `S.np`. El número esperado se calcula en R
     desde `DATA`, no se escribe.
2. **Código.**
   - En `construir_datos_trayectorias()`, `meta$REF` gana dos campos: `olas`, con el número de
     establecimientos del referente por ola desde el catálogo (esperado con los insumos actuales: 2027 = 479,
     2028 = 407, 2029 = 408), y `marcas`, con los años de `anios` iguales o posteriores a una ola (vacío con
     los datos actuales).
   - Las notas ganan la cifra de cerrados (17), calculada como los RBD del referente que no están en el
     directorio, desde `cifras_notas()`.
3. **Plantilla.**
   - La leyenda del referente queda como «Referente: <cat> municipales que se traspasan entre 2027 y 2029 ·
     con resultado en <año>: <e>», con `<cat>`, el rango de olas, `<año>` y `<e>` desde `DATA` y el estado.
   - Si `marcas` no está vacío, cada marca se dibuja como línea vertical punteada en su año con el rótulo
     «sale la ola <año>», y la leyenda agrega «<n> de <cat> aún municipales».
   - La marca usa el color del referente (`--ref`) y constantes nombradas, sin literales.
   - La frase de las notas «son las mismas escuelas en los nueve años» se conserva y se le agrega que el
     número del rótulo cuenta a los que tienen resultado publicado ese año, y que 17 cerraron antes de su
     traspaso.
4. **Verificación.**
   - Batería completa en PASA, código 0.
   - Con chromote a 1280 px en el estado inicial, el texto de `#lg` contiene «1.299» y el `e` esperado
     (calculado en R).
   - El SVG no tiene ninguna marca de ola (`querySelectorAll` del selector de marca = 0).
   - **Calibración de R4:** falla si la plantilla dibuja la marca sin mirar `marcas` (caso malo simulado en
     una copia en `$TMPDIR`).
5. Commit: `feat(trayectorias): rotulo del referente y marca de ola (D35-1)`.

### T3. La vista sin desborde a 375 px (pendiente 4 de v34) (ola 3, escritor Opus)

1. Mide con chromote `scrollWidth` a 375, 540, 680, 768 y 1280 px, y captura PNG a 768, 1280 y 1920 px →
   esperado antes: más de 375 a 375 px.
2. Corrige solo con CSS y marcado de `36_trayectorias_template.html`, usando `@media` y las variables
   existentes.
3. **Criterio.** `scrollWidth` igual al ancho del viewport en los cinco anchos. A 768, 1280 y 1920 px,
   0 píxeles distintos frente a las capturas del paso 1 (comparación con `png::readPNG` y
   `identical()`). La batería sigue en PASA.
   - **Calibración:** la comparación de píxeles dispara si se altera un color en una copia de la plantilla
     en `$TMPDIR`.
4. Commit: `fix(trayectorias): sin desborde horizontal bajo 680 px (pendiente 4 de v34)`.

### T4. Motor: señal de un solo establecimiento con asterisco (pendiente 2 de v34) (ola 1, escritor Opus)

Decisión del titular (sesión 35): se quita la atenuación y la señal pasa a un asterisco con nota.
Metodología del asistente:

1. **Cifras.** En el bloque de barras recientes (`isLowN = s.n_estab === 1`), toda cifra (la de Adecuado
   encima o dentro de la barra, las de Elemental e Insuficiente dentro de su franja, y las rescatadas bajo el
   año) pierde `.attr("opacity", isLowN ? 0.7 : 1)` y agrega `ASTERISCO_UNICO` (constante, `"*"`)
   inmediatamente después de la cifra.
2. **Barras.** Con `isLowN`, las barras del bloque reciente pasan a opacidad plena. Sin eso, las cifras
   blancas dentro de la franja no llegan a 4,5:1 y la señal ya está en el asterisco. Los puntos de las
   sparklines conservan su 0,45, porque no llevan texto.
3. **Nota.** Cuando una tarjeta tiene al menos un punto con `isLowN`, el SVG agrega una línea de nota bajo
   el eje, «* Un solo establecimiento», con tamaño desde `FS_SVG` y margen desde `RECENT_DIMS` (constantes
   nuevas, sin literales). Aparece también en el SVG y el PNG exportados, porque es parte del SVG.
4. **Verificación.**
   - En R, busca en el JSON del motor un estado con `n_estab == 1` en el bloque reciente (territorio, nivel,
     prueba y grupo) y anótalo.
   - Con chromote en ese estado, a 375 y 1280 px: (a) 0 `<text>` con atributo `opacity` en `svg.bars-svg`
     de esa tarjeta; (b) las cifras de ese punto terminan en «*»; (c) la nota existe una vez; (d) 0 pares de
     `<text>` que se superponen (intersección de cajas mayor que 0); (e) contraste de cada cifra contra su
     fondo real, calculado con la fórmula WCAG en R a partir del color de relleno efectivo (barra en
     opacidad plena o blanco) → esperado: 4,5 o más en todas.
   - En un estado sin `isLowN`, la nota no aparece.
   - El SVG exportado (botón de exportación, descarga a `$TMPDIR` con
     `Browser.setDownloadBehavior`) contiene la nota.
   - I-5 (JSON idéntico).
   - **Calibración:** (d) dispara sobre dos textos plantados en la misma posición, y (e) da menos de 4,5
     para blanco sobre la barra de Elemental con opacidad 0,45.
5. Commit: `fix(motor): un solo establecimiento se marca con asterisco y nota, sin atenuar (pendiente 2 de v34)`.

### T5. Motor: columna vacía en las notas metodológicas (pendiente 5 de v34) (ola 2, escritor Opus)

1. Con chromote, abre las notas metodológicas (alrededor de L4420 de la plantilla) en las vistas donde
   existen, y mide las columnas de tabla (o de grilla) cuyas celdas están todas vacías → esperado antes: 1 o
   más. Si da 0, congela la tarea: la premisa heredada falló.
2. Corrige la causa en la plantilla, sin borrar contenido con texto.
3. **Criterio.** 0 columnas vacías; el texto visible de las notas (`innerText`) es idéntico al de antes;
   I-5.
   - **Calibración:** el medidor da más de 0 sobre el estado base (caso malo) y 0 sobre una tabla completa
     de otra sección (caso bueno).
4. Commit: `fix(motor): notas metodologicas sin columna vacia (pendiente 5 de v34)`.

### T6. Motor: el panorama sin desborde a 375 px (pendiente 6 de v34) (ola 3, escritor Opus)

Es el mismo procedimiento que T3, sobre `motor_comparacion.html#panorama`. Esperado antes: `scrollWidth`
mayor a 375 a 375 px. Criterios: `scrollWidth` igual al viewport en los cinco anchos; 0 píxeles distintos a
768, 1280 y 1920 px en `#panorama` y en `#comparacion`; I-5.
Commit: `fix(motor): panorama sin desborde bajo 540 px (pendiente 6 de v34)`.

### T7. Motor: CSS sin uso de la cabecera antigua (deuda técnica de v34) (ola 4, escritor Opus)

1. Con chromote, en `#comparacion` y en `#panorama`, y con cada modal o panel del motor abierto:
   `document.querySelectorAll('.app-header-right, [class*="brand-"]').length` → esperado: `0` en todos los
   estados. Si alguno da más de 0, esa regla está en uso: no la borres y regístralo.
2. Quita solo las reglas cuyo selector dio 0 (L129-140, L314-319 y cualquier otra `.brand-*`).
3. **Criterio.** 0 píxeles distintos a 375, 768, 1280 y 1920 px en las dos vistas frente al estado previo a
   T7; I-5.
4. Commit: `refactor(motor): quita CSS sin uso de la cabecera antigua`.

### T8. Migración del sitio a gobCL (pendiente 3 de v34, D33-4) (ola 5, escritor Opus)

Metodología del asistente:

1. Copia los tres `.otf` a `10_utils/fuentes/` (autorización 7) y verifica los md5 contra H12. Son archivos
   vendorizados de terceros: conservan su nombre original, como `d3.min.js`.
2. En `10_html.R`:
   - constante `FUENTES_GOBCL` con archivo, peso y md5 esperado de cada `.otf`. Pesos: Light 300,
     Regular 400, Heavy 700, para que los `font-weight` 600 y 700 del sitio usen Heavy.
   - `insertar_sitio()` se detiene si un md5 no coincide, como el build hace con el sha384 de los
     vendorizados.
   - Inserta tres `@font-face` con `src: url(data:font/otf;base64,...) format("opentype")` y
     `font-display: swap` en un marcador nuevo, `/*__FUENTES__*/`, del CSS de `33_fragmento_sitio.html`. Así
     hay una sola fuente de verdad para las dos páginas (D34-2).
3. En las dos plantillas:
   - `--font-display` y `--font-body` pasan a `"gobCL", system-ui, ...` (el stack actual como respaldo). El
     comentario de L79-80 se actualiza.
   - Los literales `"system-ui, sans-serif"` de los textos SVG se reemplazan por una constante `FONT_SVG`
     con el mismo orden (gobCL primero).
   - `PATRON_SITIO_RESTO` incluye el marcador nuevo.
4. **Verificación.**
   - En las dos páginas: `document.fonts.check('16px gobCL')` → `true`, y `document.fonts.check('700 16px
     gobCL')` → `true`.
   - I-2 (0 red, incluido `url(http`).
   - Aumento de tamaño de cada HTML entre 145.000 y 175.000 B (tres `.otf` de 119.264 B en total, más un
     tercio por base64).
   - Con los anchos de T3 y T6, `scrollWidth` igual al viewport; 0 textos superpuestos en `svg.bars-svg` del
     motor a 375 y 1280 px en el estado de T4 y en la carga inicial; I-5; batería en PASA.
   - Capturas antes y después de las dos páginas a 375 y 1280 px en `_archivo/20260924_capturas_gobcl/`,
     para la revisión del titular.
   - **Calibración:** el md5 de `insertar_sitio()` detiene el build con un `.otf` alterado en una copia en
     `$TMPDIR` (caso malo).
   - **ADVIERTE esperado:** el PNG exportado desde un SVG serializado puede caer al respaldo, porque la
     fuente vive en el documento. Mídelo y regístralo; no se corrige en este encargo.
5. Commit: `feat(sitio): tipografia gobCL incrustada en motor y vista (D33-4)`.

### T10. Diagnóstico de ramas (ola 1, lector Sonnet)

Por cada rama local distinta de `main` (esperado: 4; H de T10, `git branch --format='%(refname:short)' |
grep -vc '^main$'` → `4`): `git log --oneline main..<rama> | wc -l`, `git cherry main <rama> | grep -c
'^+'`, `git diff --stat main...<rama> | tail -n 1`, `git branch -r --contains <rama>` y la fecha del último
commit. El resultado es una tabla en el log, sin juicio y sin escribir nada. El orquestador la re-deriva con
un comando distinto (`git rev-list --count main..<rama>`) antes de aceptarla.

### T11. Dudas heredadas (ola 1, lector Opus)

Cada duda se mide y se reporta con PASA, FALLA o NO MEDIBLE, y con la evidencia literal. No se corrige nada.

- **v30-2.** `grep -n "estándar\|punto de corte" 50_documentacion/activa/referencia_glosas_simce.md` →
  predicado: no se declara ningún cambio de punto de corte entre 2018 y 2022.
- **v30-3.** En R, % Adecuado nacional por año, nivel y prueba, ponderado por `nalu` con la regla D33-1,
  con y sin las filas sin `cod_grupo`. Tolerancia `TOL_PP <- 0.15`. Predicado: diferencia absoluta menor que
  `TOL_PP` en las cuatro combinaciones y en todos los años. Anota cuántas filas sin grupo hay (la herencia
  dice 652). Calibración: con `TOL_PP <- 0` debe reportar al menos una diferencia, salvo que todas sean
  exactamente 0; si lo son, decláralo.
- **v30-5.** `ls 50_documentacion/andamios/*motor*` y `git ls-files 50_documentacion/andamios` → predicado:
  existe un archivo que reproduce las 28 pruebas de la auditoría del motor.
- **v31-2.** Con chromote a 375 px, 2° medio Matemática, con Elemental e Insuficiente visibles, recorre las
  tarjetas → predicado: 0 pares de `<text>` superpuestos en `svg.bars-svg`. Usa el medidor calibrado de T4
  (si T4 aún no terminó, calíbralo tú con dos textos plantados).
- **v31-3.** En el mismo estado, exporta el PNG del supergrid a `$TMPDIR` → predicado: la tarjeta de
  Concón, grupo Bajo, muestra completo el segundo renglón bajo el año. Mídelo comparando la altura del
  lienzo exportado con la del SVG, y que el `<text>` del segundo renglón quede dentro del `viewBox`. Si no se
  puede medir sin un juicio visual, repórtalo como NO MEDIBLE y deja la captura en
  `_archivo/20260924_capturas_gobcl/` para el titular.

El orquestador re-deriva al menos una de las cifras (v30-3) con un cálculo propio distinto antes de
aceptarla.

---

## 8. FASE R: auditoría propia y reparación (penúltima y obligatoria; corre aunque haya tareas congeladas)

La regla de oro: **la reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni
la meta**.

1. **Inventario de afirmaciones auditables.** Se deriva del log, no de la memoria: cada línea
   `Verificación:` y cada cifra de las secciones por fase, cada 🔒 de §4 con su comando, y el alcance
   global. Numéralas (`R-01`, `R-02`, ...) y anexa el inventario al log **antes** de auditar nada.
2. **Re-derivación independiente.** Cada afirmación se re-deriva con un comando distinto del que la
   produjo. Como hay riesgo sobre datos y cifras, se usa un panel adversarial de 3 lectores Opus en una sola
   ola. Cada auditor recibe la afirmación, la ruta de la fuente y el repositorio; no recibe el razonamiento
   ni el código que la produjo. Reparto:
   - auditor 1: C1-C5 y R1-R4 (con un conteo propio en R sobre los parquet y el CSV);
   - auditor 2: I-5 y los criterios de T4 a T7 (con su propio decodificador del JSON y su propia medición de
     superposición);
   - auditor 3: T8, T9 e I-1 a I-4, I-7 a I-11.
3. **Invariantes 🔒.** Corre el comando de cada uno de §4 y anota PASA o FALLA con la salida literal.
4. **Chequeo global de alcance.** `git diff --name-only <punto_de_retorno>..HEAD` debe estar contenido en la
   unión de los ALCANCE (más el log). Además, `git status --porcelain`: lo no commiteado es un hallazgo, no
   se limpia.
5. **Regresión completa.** Los tres comandos de PRUEBAS sobre el estado final, con `esperado:` y
   `obtenido:`.
6. **Control positivo de la propia auditoría.** Al menos una afirmación se audita además con un caso
   plantado: una cifra alterada en una copia temporal fuera del árbol (p. ej., un `e` del referente en una
   copia de `DATA`) y un archivo fuera de alcance simulado en un diff de prueba. El instrumento debe
   disparar en los dos.
7. **Veredicto por hallazgo, con severidad.**
   - **BLOQUEA:** gobernanza de datos, 🔒 en FALLA, datos alterados, alcance violado o historia divergente.
     No se repara: se congela la tarea de origen y se registra como duda con pregunta cerrada. Si
     compromete el repositorio completo, se detiene la sesión y se pasa a FASE L.
   - **REPARA:** defecto del propio trabajo, dentro del ALCANCE, que no toca un 🔒 y tiene una verificación
     calibrada disponible. Se corrige en el ciclo del paso 8.
   - **ADVIERTE:** discrepancia sin efecto sobre la meta ni los invariantes, o un riesgo que esta sesión no
     puede medir. Se registra, no se corrige.

   «0 hallazgos» solo se declara junto con el control positivo del paso 6.
8. **Ciclo de reparación (máximo 2 ciclos).** Por cada REPARA:
   - (a) causa raíz, no síntoma;
   - (b) fix quirúrgico dentro del ALCANCE;
   - (c) re-verificación con el mismo chequeo que lo detectó **y** con uno distinto;
   - (d) regresión;
   - (e) commit propio `fix(auditoria): R-NN <hallazgo>`;
   - (f) fila en la tabla.

   Al cerrar el ciclo, repite los pasos 2 a 5 sobre lo tocado. Un hallazgo que sobrevive al segundo ciclo,
   o cuya reparación destapa otro en otra parte, se congela y se registra como pendiente.
9. **Prohibiciones de la fase.** Ajustar un criterio, una tolerancia o un valor esperado para que pase;
   ampliar un ALCANCE; tocar un 🔒; borrar o editar evidencia ya escrita en el log; reparar un BLOQUEA;
   lanzar la reparación en un subagente sin que el orquestador la verifique.
10. **Salida.** La tabla de auditoría en el log, con las columnas `id | afirmación | comando de
    re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación`, y el veredicto
    global: `APROBADO`, `APROBADO CON ADVERTENCIAS`, `OBSERVADO` o `BLOQUEADO`. El veredicto va al bloque J.

---

## 9. FASE L: cierre del log (última y obligatoria; corre siempre)

1. **Estado del árbol antes de tocar el log.** `git status --porcelain` → esperado: vacío, o solo el propio
   log. Otra cosa es un hallazgo: se anota en el cierre del log y no se «limpia».
2. **Cierre del log** (plantilla del Apéndice). Se completan las secciones consolidadas: resumen,
   inventario de commits derivado de `git log <punto_de_retorno>..HEAD --oneline`, tabla de auditoría,
   invariantes, estado de cifras, dudas y pendientes, errores propios y notas para el revisor. Las secciones
   por fase ya están escritas y no se reescriben.
3. **Bloque J.** Se rellena el slot reservado en FASE 0, copiando del detalle (hashes de `git log`, conteos
   de la tabla), nunca de memoria.
4. **Grep de privacidad.** `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' <LOG>` → esperado: vacío.
   Además, una lectura confirma que el log no contiene filas de datos ni nombres de personas. Los nombres de
   establecimientos también se evitan: se usan RBD o conteos. Un hit se reemplaza por un conteo antes del
   commit y la sustitución se declara.
5. **Verificación del archivo.** `ls -l <LOG> && wc -l <LOG>`; `grep -c '^### FASE' <LOG>` igual al número
   de fases ejecutadas (FASE 0, las tareas con sección, incluidas las congeladas, y FASE R); `grep -c
   '^esperado:' <LOG>` igual a `grep -c '^obtenido:' <LOG>`; `grep -c '^## J' <LOG>` igual a 1, con el
   bloque relleno. Si un conteo difiere, anexa lo que falta con su estado real; no ajustes el conteo.
6. **Commit propio.** `git add 50_documentacion/andamios/logs/20260924_pendientes_s35_log.md` y
   `git commit -m "docs(log): pendientes de la sesion 35"`. Luego, `git push origin main` solo si se cumplen
   las condiciones de la autorización 3; si no, el log queda local y se declara.
7. **Estado de cierre declarado:** qué quedó commiteado, qué se publicó (push sí o no, con la condición
   medida), qué queda al titular (revisión en Safari, capturas de gobCL, publicación a `docs/`), y el hash
   de `docs(log)` (`git log -1 --format=%h`).

---

## 10. Reporte final

1. **Primera línea, sin excepción:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash del commit
   `docs(log)`.
2. **Segundo bloque:** el bloque J copiado tal cual del log.
3. Después:
   - hashes;
   - verificaciones con evidencia;
   - la tabla de T10 y el veredicto por duda de T11;
   - pendientes y `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Pendientes excluidos de este encargo, con su razón

- **Publicación a `docs/` y push de Pages:** efecto público. Requiere la revisión en Safari del titular
  sobre lo producido aquí (capturas en `_archivo/20260924_capturas_gobcl/`). Se hará en un encargo corto
  posterior.
- **Pendiente 8 de v34** (`V8` y `openssl` en `renv.lock`, suite standalone, `documentar.R`, `34_historico`):
  bloqueado por `suitedoc` sin remoto.
- **Pendiente 13 de v34** (Simce 2026): bloqueado por insumos.
- **Pendiente 12 de v34** (destino de `feat/contrato-contexto`): decisión del titular. T10 aporta el
  diagnóstico.
- **Pendiente 10 de v34** (ramas locales): decisión del titular tomada en la sesión 35, solo diagnosticar
  (T10).
- **Compuerta de dudas de v34:** la duda 1 exige una segunda estación y la duda 2 se mide en el próximo
  cierre (I8).
- **Fin del referente (D35-2, pendiente derivado 1):** se decide cuando se publique el Simce 2028.

---

## Apéndice: plantilla del log

```markdown
# Log: pendientes de la sesión 35 (slep_simce_adecuado)

- Meta: <una línea>
- Fecha: <AAAA-MM-DD> · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: <hash de T0>
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo ultracode; orquestador Opus; subagentes tope 4 (≤ 3 Opus); total Opus ≤ 12
- Modo real de la sesión: <...>
- Grafo y plan de concurrencia: <copiados de §5>
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

### FASE T9 ... ### FASE T11 (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación
(inventario R-NN, tabla, control positivo, veredicto)

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
