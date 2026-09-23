# Encargo autónomo: base Simce 2025 final en lugar de la preliminar

Formato: `encargo_autonomo_claude_code_v1.md` v1.6. Sesión 31 (2026-09-23).
Meta aprobada por el titular (opción A): el pipeline lee las bases 2025
finales, las preliminares salen de `20_insumos/` a `_archivo/` fuera de git, y
el motor deja de marcar 2025 como preliminar sin que cambie ninguna cifra.

## 1. Encabezado de contrato

- **Modo:** autónomo, todo en este turno. Subagentes: **no se admiten**.
- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión; subagentes 0, total Opus 0.
- **ENTORNO:** Claude Code en la estación macOS, raíz `/Users/tomgc/Projects/slep_simce_adecuado`.
  `bash` explícito; `Rscript` para todo cálculo sobre datos.
- **POSICIÓN:** todo comando antepone `cd /Users/tomgc/Projects/slep_simce_adecuado &&`.
  Primer acto de FASE 0: `git fetch --quiet`.
- **LOG:** `50_documentacion/andamios/logs/20260923_simce2025_final_log.md`.
- **Scratch:** `S=$(mktemp -d)` creado en FASE 0; su ruta va al log. Nada del scratch entra al árbol.
- **ALCANCE (lista cerrada):**
  - T1: `20_insumos/simce/4b/simce4b2025_rbd_final.xlsx`, `20_insumos/simce/2m/simce2m2025_rbd_final.xlsx`,
    las dos rutas `*_2025_rbd_preliminar.xlsx` (solo para sacarlas del índice), `_archivo/20260923/20_insumos/simce/`
    (ignorado por git), `50_documentacion/activa/manifiesto_insumos.md`.
  - T2: `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`,
    `30_procesamiento/31_leer_normalizar.R`, `README.md`; y las salidas ignoradas de `40_salidas/`.
  - Todas: el LOG y este encargo.
- **PRUEBAS:** sin arnés (`tests/` no existe). Sustituto: `Rscript 00_build.R` con código 0 y las verificaciones de T2.
- **PUNTO DE RETORNO:** `git rev-parse --short HEAD` en FASE 0 (una sola revisión por llamada).
- **Topes:** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.

### 1.1 Regla de detención

1. `HEAD` distinto de `origin/main` tras el fetch → detén la sesión.
2. `git status --porcelain` distinto del conjunto de §2 → detén la sesión.
3. md5 de una preliminar movida distinto del de su blob en `HEAD` → congela T1 y T2.
4. `Rscript 00_build.R` con error → tope de 3 intentos a T2; al tercero, congela T2.
5. Cualquier cifra de datos distinta entre el build nuevo y el anterior (verificaciones de T2) → congela T2 sin commit: la meta afirma que no cambia ninguna.
6. Cambio necesario fuera del ALCANCE → congela esa tarea.
7. **Cláusula residual:** cualquier estado, conteo o resultado no enumerado → congela ESTA tarea, regístrala como duda y sigue con la próxima independiente.

### 1.2 Autorizaciones (lista cerrada)

1. `git rm --cached` de exactamente `20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx` y `20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx`.
2. `mkdir -p _archivo/20260923/20_insumos/simce/4b _archivo/20260923/20_insumos/simce/2m` y `mv -n` de cada preliminar a su carpeta homónima ahí.
3. `cp` de `40_salidas/intermedios/*.parquet` y de `40_salidas/motor_comparacion.html` al scratch `$S`, antes del build.
4. `git add` de rutas explícitas del ALCANCE y `git commit`, uno por tarea.
5. `git push origin main` al final de FASE L, con árbol limpio y `origin/main` ancestro de `HEAD`.

Nada más. No se toca `docs/index.html` (gate visual del titular), no se borra nada, no se usa `restore`, `reset` ni `checkout --`.

## 2. Estado de partida (premisas)

- `HEAD` = `origin/main` = `005753c` (fuente: `git log --oneline -1` en la sesión del redactor; hipótesis, se mide en FASE 0).
- Árbol: ` M` en `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_generar_html.R`,
  `30_procesamiento/33_motor_template.html`, `50_documentacion/activa/manifiesto_insumos.md`, `README.md`
  (ediciones del redactor); `??` en las dos `*_2025_rbd_final.xlsx` y en este encargo; nada más
  (fuente: `git status --short` en la sesión del redactor; hipótesis, se mide en FASE 0).
- Las bases finales tienen las mismas 42 columnas, filas y RBD que las preliminares, y solo difieren en
  `codigo_bbdd` (v12025 → v22025) y `fecha_bbdd` (20260427 → 20260622) (fuente: comparación celda a celda
  con pandas en la sesión del redactor, con control positivo; hipótesis, se re-deriva en R en FASE 0).
- El pipeline no lee `codigo_bbdd` ni `fecha_bbdd` (fuente: `grep` sobre `30_procesamiento/*.R` en la sesión del redactor).
- El lector toma todo `*.xlsx` de `20_insumos/simce/<nivel>/` (fuente: `31_leer_normalizar.R` L128-131): con las dos versiones presentes cargaría 2025 dos veces.
- Las ediciones del redactor transpilan con Babel standalone 7.29.0, runtime `classic` (fuente: transpilación en node en la sesión del redactor; se re-mide en el build de T2).
- La lista de datos autorizados cubre `20_insumos/simce/4b/*.xlsx` y `20_insumos/simce/2m/*.xlsx` (fuente: `50_datos_versionados_autorizados.md`).

## 3. Contexto mínimo

`31_leer_normalizar.R` marca `preliminar = TRUE` según el sufijo del archivo. Hasta hoy
`33_generar_html.R` fijaba `anios_preliminar = I(c(2025L))` a mano; el redactor lo cambió para derivarlo de
`simce_rbd.parquet` (`anio` con `preliminar == TRUE`), e hizo condicionales a esa lista los dos textos fijos de
la plantilla (leyenda del mapa de calor y nota metodológica) y el tooltip (`"* Dato preliminar " + yr`). Con
las bases finales, la lista queda vacía y el motor no muestra asteriscos ni esos textos.

## 4. Invariantes (🔒), cada uno con su comando

- 🔒 1 `docs/index.html` no cambia: `md5 -q docs/index.html` = `892929f4fa997bae71e66349b428d7ed`.
- 🔒 2 Ninguna cifra cambia: en R, cada parquet de `40_salidas/intermedios/` nuevo es `identical()` a su copia en
  `$S`, salvo `simce_rbd.parquet`, donde es `identical()` tras quitar la columna `preliminar` en los dos.
- 🔒 3 Las preliminares no se pierden: existen en `_archivo/20260923/20_insumos/simce/<nivel>/` con md5 igual al de
  `git show <PUNTO DE RETORNO>:<ruta> | md5`.
- 🔒 4 Ningún dato fuera de lo autorizado: `Rscript "$HERRAMIENTAS_DEV_PATH/plantillas/95_verificar_cierre.R" .`
  reporta I8 en PASA (solo I8 es criterio aquí; los demás invariantes se anotan).

## 5. Grafo y fases

T1 independiente. T2 requiere T1. FASE R y FASE L cierran, fuera del grafo, y corren aunque algo se congele.
Cada fase cierra en cinco pasos: verificación (`esperado:` escrito en el log antes del comando, `obtenido:`
literal después), regresión, chequeo de alcance (`git diff --name-only HEAD` más
`git ls-files --others --exclude-standard` ⊆ ALCANCE de la tarea más lo heredado de §2 aún no commiteado),
commit con rutas explícitas, sección del log.

### FASE 0

1. Crear el LOG (encabezado, `EJECUCIÓN:` y modo real, grafo, slot `## J. Juicio (lo rellena FASE L)`); crear `$S`.
2. Medir, con `esperado:` antes:
   - `git rev-parse --short HEAD` y `git rev-parse --short origin/main` → `005753c` y `005753c`.
   - `git status --porcelain` → el conjunto de §2.
   - En R, sobre cada nivel, final contra preliminar con `readxl::read_excel(..., sheet = 1)`: mismas dimensiones,
     mismos nombres, `rbd` únicos en los dos, y `identical()` de las 40 columnas restantes ordenadas por `rbd` →
     `TRUE` en 4b y en 2m. Calibración: alterar `+0.1` una celda no NA de `palu_eda_ade_lect<nivel>_rbd` en una copia → `FALSE`.
   - `md5 -q docs/index.html` → 🔒 1.

### T1: insumos

1. Guardar en el log `git show HEAD:<ruta> | md5` de las dos preliminares.
2. Autorizaciones 1 y 2.
3. Verificación:
   - `ls 20_insumos/simce/4b 20_insumos/simce/2m | grep -c preliminar` → `0`
     (calibración: `git ls-tree -r --name-only HEAD 20_insumos/simce | grep -c preliminar` → `2`).
   - `git ls-files 20_insumos/simce | grep -c 2025` tras el `git add` de las finales → `2`, ambas `_final`.
   - 🔒 3 sobre las dos rutas de `_archivo/`.
4. Commit: preliminares fuera del índice, finales, `manifiesto_insumos.md`:
   `data(simce): bases 2025 finales (v22025) en lugar de las preliminares, archivadas fuera de git`.

### T2: build y motor

1. Autorización 3 (copias al scratch).
2. `Rscript 00_build.R` → código 0; en la salida, la línea `Años preliminares: ninguno`.
3. Verificaciones:
   - 🔒 2 en R (parquets nuevos contra `$S`).
   - En R: `sum(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet")$preliminar)` → `0`
     (calibración: sobre la copia en `$S` → mayor que 0).
   - JSON del HTML nuevo contra el de `$S/motor_comparacion.html` (método de descompresión del log
     `20260923_retiro_cdn_v8_adenda_log.md`): las únicas diferencias son `meta.fecha_generacion` y
     `meta.anios_preliminar` (`[]` contra `[2025]`); tras quitar esos dos campos, `identical()` → `TRUE`.
     Calibración: una celda de datos alterada en una copia → `FALSE`.
   - Universo: el bloque de la app (último `<script>` del archivo, extracción calibrada con `ReactDOM.createRoot`):
     contiene `PRELIMINAR_YEARS.length > 0` al menos dos veces y no contiene el literal `Dato preliminar (2025`.
     Calibración: el mismo conteo sobre `$S/motor_comparacion.html` → el literal sí aparece.
   - Universo: la página completa: `grep -c 'src="http' 40_salidas/motor_comparacion.html` → `0`.
4. Commit de las cuatro rutas de código y documentación de T2:
   `feat(motor): el año preliminar se deriva de los insumos; 2025 deja de marcarse (s31)`.

### FASE R (penúltima, obligatoria)

La reparación cambia el trabajo, nunca el criterio, la tolerancia, el esperado ni la meta.
1. Inventario numerado `R-NN` derivado del log, anexado antes de auditar.
2. Re-derivación con comando distinto (p. ej. `shasum -a 256` donde se usó `md5`; conteos en R donde se usó `grep`).
3. Cada 🔒 con su comando, PASA/FALLA con salida literal.
4. Alcance global: `git diff --name-only <PUNTO DE RETORNO>..HEAD` ⊆ unión de ALCANCE más el LOG; `git status --porcelain`.
5. Regresión: `Rscript 00_build.R` otra vez; md5 de la salida igual al de T2.
6. Control positivo propio: un caso plantado en `$S` que alguno de los instrumentos debe detectar.
7. Severidad: BLOQUEA (gobernanza, 🔒 en FALLA, datos alterados, alcance violado; se congela), REPARA (defecto propio
   dentro del ALCANCE; ciclo del paso 8), ADVIERTE (se registra).
8. Hasta 2 ciclos: causa raíz, fix, re-verificación doble, regresión, commit `fix(auditoria): R-NN <hallazgo>`.
9. Prohibido: ajustar criterio o esperado, ampliar ALCANCE, tocar un 🔒, editar evidencia, reparar un BLOQUEA.
10. Tabla `id | afirmación | comando | esperado | obtenido | severidad | acción | commit | re-verificación` y veredicto
    (`APROBADO`, `APROBADO CON ADVERTENCIAS`, `OBSERVADO`, `BLOQUEADO`).

### FASE L (última, siempre)

1. `git status --porcelain` → vacío o solo el LOG y este encargo.
2. Cierre del log: resumen, commits desde `git log <PUNTO DE RETORNO>..HEAD --oneline`, tabla de auditoría, 🔒,
   cifras críticas, dudas con pregunta cerrada, errores propios, notas al revisor.
3. Bloque J (trece campos, una línea cada uno, copiados del detalle).
4. Privacidad: el patrón de RUT sobre el LOG → sin líneas; el control positivo se arma por partes y solo se registra el conteo.
   El LOG no lleva filas de datos ni nombres de establecimientos.
5. `ls -l <LOG> && wc -l <LOG>`; `grep -c '^### FASE'` = fases ejecutadas; `grep -c '^esperado:'` = `grep -c '^obtenido:'`; `grep -c '^## J'` = 1.
6. `git add <LOG> 50_documentacion/activa/encargos/encargo_simce2025_final.md`;
   `git commit -m "docs(log): bases Simce 2025 finales"`.
7. Autorización 5 y estado de cierre con `git log -1 --format=%h`.

## 6. Reporte final

Primera línea: `ls -l <LOG> && wc -l <LOG>` y el hash del `docs(log)`. Luego el bloque J tal cual, los hashes,
lo que falló o sorprendió (si nada, decirlo), y para el titular: gate visual de
`40_salidas/motor_comparacion.html` (sin asteriscos, sin la leyenda ni la nota de preliminares, cifras de 2025
iguales), tras el cual el despliegue a `docs/` es el mismo procedimiento de la sesión 31.

**Excluidos, con su razón:** `50_documentacion/suite/documentar.R` y `documentacion_proyecto_slep_simce_adecuado.md`
(la suite está bloqueada por `suitedoc`); `34_historico_pct_adecuado_costa_central.R` (bloqueado por `suitedoc`);
despliegue a `docs/` (gate visual).
