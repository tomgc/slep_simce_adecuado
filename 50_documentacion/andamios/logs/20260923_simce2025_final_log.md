# Log — Base Simce 2025 final en lugar de la preliminar

- **Meta:** el pipeline lee las bases 2025 finales, las preliminares salen de `20_insumos/` a `_archivo/` fuera de git, y el motor deja de marcar 2025 como preliminar sin que cambie ninguna cifra (opción A, aprobada por el titular).
- **Fecha:** 2026-09-23 (sesión 31).
- **Encargo:** `50_documentacion/activa/encargos/encargo_simce2025_final.md` (formato v1.6).
- **Repo y rama:** `slep_simce_adecuado`, `main`.
- **PUNTO DE RETORNO:** se mide en FASE 0 con `git rev-parse --short HEAD` (premisa: `005753c`).
- **ENTORNO:** Claude Code en la estación macOS del titular (`MacBook-Pro-de-Tomas.local`), raíz `/Users/tomgc/Projects/slep_simce_adecuado`; `bash` explícito; `Rscript` (R 4.5.2, renv activado por `.Rprofile`) para todo cálculo sobre datos.
- **Scratch `$S`:** `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK` (creado con `mktemp -d`; nada de ahí entra al árbol).
- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión (Opus 5.5, `claude-opus-5-5[1m]`); subagentes 0, total Opus 0.
- **Modo real de la sesión:** `xhigh` (el titular lo fijó con `/effort` antes de este encargo; `ultracode` está apagado); subagentes usados: 0, por contrato.
- **Grafo:** T1 es independiente. T2 requiere T1. FASE R y FASE L cierran, fuera del grafo, y corren aunque algo se congele.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.
- **Método de registro:** el de los logs del retiro de `unpkg.com`. Un ayudante de shell del scratchpad de la sesión (`medir_simce.sh`, igual a `medir.sh` salvo la ruta del LOG) anexa el comando y `esperado:` antes de correrlo, y `obtenido:` con la salida literal después. Los instrumentos en R se transcriben al final de FASE R. Dentro de cada sección, la verificación va primero porque se escribe mientras se trabaja.

---

## J. Juicio
- Meta y resultado: bases 2025 finales en el pipeline, preliminares archivadas fuera de git y 2025 sin marca de preliminar, sin cambiar cifras → parcial: T1 commiteada; T2 construye bien y no cambia ninguna cifra que produce `main`, pero quedó congelada sin commit por el 🔒 2.
- Estado por tarea: T1 completada (`9bad097`) · T2 congelada (regla 5: 🔒 2 en FALLA en `simce_rbd.parquet`).
- Commits: 2, `9bad097` y el `docs(log)` (`git log 005753c..HEAD --oneline`; el hash del `docs(log)` va en el reporte final), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): BLOQUEADO; hallazgos B/R/A = 1/0/3; reparados 0; abiertos 1 (R-11, BLOQUEA).
- Invariantes: 3/4 PASA; FALLA: 🔒 2 (la copia de `simce_rbd.parquet` salió de la rama `feat/contrato-contexto` y trae 5 columnas extra; las 13 que escribe `main` son `identical()`).
- Cifras críticas: intactas (bases finales = preliminares en 40 columnas; cinco parquets `identical()`; `simce_rbd` idéntico en sus 13 columnas; JSON `identical()` salvo `anios_preliminar`; `docs/index.html` `892929f4…` sin cambios).
- Decisiones autónomas de mayor riesgo: no commitear T2 ni reformular el 🔒 2 (descartada: comparar solo las 13 columnas y commitear); medir tras congelar el resto de T2 y diagnosticar la FALLA (descartada: detenerse en la FALLA); comprobar que el destino no existía antes de `mv -n` (descartada: confiar en `mv -n`).
- Desviaciones respecto del encargo: `$S` creado antes del fetch; criterios de T2 medidos como evidencia tras congelar; chequeos propios (tamaños, bytes, destino de `mv`); sin push (la autorización 5 exige árbol limpio).
- Dudas abiertas: 2; D1 ¿se acepta el 🔒 2 medido sobre las columnas que escribe el pipeline de `main` (13 comunes, `TRUE`) y se commitea T2 tal como está? (sí/no) · D2 ¿se conserva la copia en `$S` del `simce_rbd.parquet` de la rama `feat/contrato-contexto`, o basta con que sea regenerable? (conservar/no).
- Errores propios: 3 registrados (`$S` antes del fetch; un `grep` sin propósito en una medición; esperado de byte-identidad sin fundamento); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: el gate visual de `40_salidas/motor_comparacion.html` (sin asteriscos, sin la leyenda ni la nota de preliminares, cifras de 2025 iguales); nada en esta cadena abrió la página en un navegador.
- No publicado / queda al usuario: push retenido (`9bad097` local); commit de T2 a la espera de D1; despliegue a `docs/` tras el gate visual.
- Ejecución: modo de sesión xhigh; subagentes 0, por contrato.

---

## Cierre (lo rellena FASE L)

### C.1 Resumen de la sesión

Entraron T1 y T2 más las fases 0, R y L: cinco secciones por fase. T1 completada: las preliminares 2025 salieron del índice y quedaron en `_archivo/20260923/20_insumos/simce/<nivel>/` (idénticas a sus blobs), y las finales entraron. T2 construye al primer intento: `Años preliminares: ninguno`, 18 archivos leídos, ninguno marcado. El JSON publicado es `identical()` al anterior salvo `anios_preliminar`, y el bloque de la app ya no trae el literal de 2025. Pero el 🔒 2 falla en `simce_rbd.parquet`: la copia de referencia salió de un build de la rama `feat/contrato-contexto` (5 columnas extra), así que T2 quedó congelada sin commit (regla 5). FASE R: `BLOQUEADO`. Sin push.

### C.2 Inventario de commits

Derivado de `git log 005753c..HEAD --oneline` (FASE L, antes del commit del LOG):

- `9bad097` data(simce): bases 2025 finales (v22025) en lugar de las preliminares, archivadas fuera de git · FASE T1.
- `docs(log)`: bases Simce 2025 finales · FASE L (hash en el reporte final).

Ningún `fix(auditoria)`.

### C.3 Tabla de auditoría (FASE R)

Está completa en la sección `FASE R: auditoría y reparación` (R-01 a R-23). Veredicto `BLOQUEADO`. Hallazgos: BLOQUEA 1 (R-11); REPARA 0; ADVIERTE 3 (R-11 por la versión de arrow en los bytes; R-12, el parquet de la rama solo en `$S`; R-20, T2 sin commit). Control positivo: R-23 (celda plantada; dispara solo donde debe) y el caso plantado de R-18.

### C.4 Verificación de invariantes

- 🔒 1 `docs/index.html` no cambia: **PASA** (`892929f4fa997bae71e66349b428d7ed`; sha256 igual en disco y en HEAD).
- 🔒 2 ninguna cifra cambia (parquets `identical()`): **FALLA** en `simce_rbd.parquet` (18 contra 13 columnas sin `preliminar`); los otros cinco PASAN. Las 13 columnas que escribe el pipeline de `main` son `identical()`.
- 🔒 3 preliminares archivadas intactas: **PASA** (md5, sha256 y hash de objeto iguales a los blobs de `005753c`).
- 🔒 4 I8: **PASA** (28 rutas de datos, 28 cubiertas; re-derivado en shell). I1 e I3 fallan y solo se anotan: árbol sucio por T2 y 1 commit por delante.

### C.5 Decisiones del usuario registradas

Ninguna tomada en esta sesión. La meta (opción A) viene aprobada por el titular en el encargo.

### C.6 Estado de cifras críticas

- Bases 2025: final = preliminar en las 40 columnas de datos, en 4b (7143 filas) y 2m (3002 filas); solo cambian `codigo_bbdd` (v12025 → v22025) y `fecha_bbdd` (20260427 → 20260622).
- Preliminares archivadas: md5 `3cde757848ed724bc24a839934902143` (4b) y `f1416a77c98d49de715369bfab083bff` (2m), iguales a sus blobs.
- Parquets: `comunas_chile`, `establecimientos_chile`, `simce_comunal`, `slep_cc_establecimientos` y `sleps_chile` son `identical()`. `simce_rbd` es idéntico en sus 13 columnas; `preliminar` pasa de 20290 filas en `TRUE` (solo 2025) a 0.
- HTML nuevo: md5 `3f9a5b3b9a5f2ea0466d4046ab53f0ab`, 2785749 bytes, reproducido por la regresión. `docs/index.html`: `892929f4fa997bae71e66349b428d7ed`, sin cambios.

### C.7 Dudas y pendientes consolidados

1. **D1 (T2, R-11, BLOQUEA).** Contexto: el 🔒 2 falla en `simce_rbd.parquet`. La copia de referencia (fechada el 11 de julio) salió de un build de la rama local `feat/contrato-contexto` (`6e00830`, "normalizador persiste las señales de la Agencia") y trae `prom`, `dif`, `difgru`, `sigdif`, `siggru`, que el lector de `main` no escribe. Las 13 columnas que sí escribe son `identical()`, los otros cinco parquets también, y el JSON publicado es `identical()` salvo `anios_preliminar`. Pregunta cerrada: ¿se acepta que el 🔒 2 se mida sobre las columnas que escribe el pipeline de `main` (13 comunes, `TRUE`), y con eso se commitea T2 tal como está (sí/no)? Bloquea el commit de T2 y el push.
2. **D2 (T2, R-12, ADVIERTE).** Contexto: el build de `main` sobrescribió en `40_salidas/intermedios/` el `simce_rbd.parquet` de esa rama; hoy solo existe en `$S` (directorio temporal del sistema) y se regenera con `00_build.R` en la rama. Pregunta cerrada: ¿se conserva esa copia (conservar/no)? No bloquea. Si se trabaja en `feat/contrato-contexto`, hay que reconstruir allí antes de usar los intermedios.
3. **Pendiente derivado:** con D1 resuelta, commitear las cuatro rutas de T2 (`31_leer_normalizar.R`, `33_generar_html.R`, `33_motor_template.html`, `README.md`) y hacer el push de `9bad097` y los `docs(log)`.
4. **Excluidos por el encargo, sin cambios:** `documentar.R` y la documentación de la suite (bloqueados por `suitedoc`); `34_historico_pct_adecuado_costa_central.R` (bloqueado por `suitedoc`); despliegue a `docs/` (gate visual).

### C.8 Errores propios consolidados

1. FASE 0: `$S` se creó antes del `git fetch` que POSICIÓN pide como primer acto. Costo: ninguno.
2. T2: una medición de tamaños arrastró un `grep … /dev/null` sin propósito; se anotó. Costo: ninguno.
3. FASE R: esperado propio de byte-identidad de los parquets sin revisar la versión de arrow; se diagnosticó (23.0.1 → 24.0.0). Costo: una medición.

### C.9 Notas para el revisor

- La FALLA del 🔒 2 no viene de las bases finales. Viene de que el directorio de trabajo compartía intermedios generados en otra rama. Todo lo que el pipeline de `main` produce quedó igual, y el JSON publicado solo cambia en `anios_preliminar`.
- El `simce_rbd.parquet` de julio mostraba el trabajo de la rama `feat/contrato-contexto` (5 señales de la Agencia) en el árbol de `main`. Los intermedios ignorados no dicen de qué rama salieron.
- Los parquets difieren en 2 bytes por la versión del escritor (arrow 23.0.1 → 24.0.0); el contenido es el mismo.
- El commit `9bad097` deja `main` con las bases finales, pero con `33_generar_html.R` de `HEAD`, que todavía fija `anios_preliminar = 2025`. Un build desde el `HEAD` commiteado seguiría marcando 2025 hasta que se commitee T2.
- El HTML nuevo (`3f9a5b3b…`) está en `40_salidas/`; `docs/` no se tocó.

### C.10 Estado de cierre

- Commiteado: `9bad097` (T1) y el `docs(log)` con este LOG y el encargo (hash en el reporte final).
- NO se publica: ningún push. La autorización 5 exige árbol limpio y quedan ` M` las cuatro rutas de T2. `docs/index.html` no se tocó.
- Queda al usuario: D1 y D2; commit de T2; push; gate visual; despliegue a `docs/`.

---

## Registro por fase

### FASE 0: log, scratch y mediciones

**Verificación:**

`git fetch --quiet; echo "fetch: $?"; git rev-parse --short HEAD; git rev-parse --short origin/main`

esperado: `fetch: 0`; `005753c` y `005753c`
obtenido:

```text
fetch: 0
005753c
005753c
```

`git status --porcelain`

esperado: ` M` en `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`, `50_documentacion/activa/manifiesto_insumos.md` y `README.md`; `??` en las dos `*_2025_rbd_final.xlsx` y en el encargo; nada más (el LOG aún vive en el scratchpad)
obtenido:

```text
 M 30_procesamiento/31_leer_normalizar.R
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
 M 50_documentacion/activa/manifiesto_insumos.md
 M README.md
?? 20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
?? 20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
?? 50_documentacion/activa/encargos/encargo_simce2025_final.md
```

`git stash list`

esperado: vacío (no enumerado; se mide como en los encargos anteriores)
obtenido: (sin salida)

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/comparar_bases.R 4b 2>&1 | grep -v out-of-sync`

esperado: 4b: una hoja en cada archivo; mismas dimensiones (42 columnas); mismos nombres `TRUE`; rbd únicos `TRUE TRUE` y mismo conjunto `TRUE`; 40 columnas comparadas, identical `TRUE`; difieren solo `codigo_bbdd` y `fecha_bbdd` (v22025/v12025 y 20260622/20260427); calibración `FALSE`
obtenido:

```text
hojas final/preliminar: 1 1 
dim final: 7143 42 | dim preliminar: 7143 42 
mismos nombres: TRUE 
rbd únicos final/preliminar: TRUE TRUE | mismo conjunto de rbd: TRUE 
columnas comparadas: 40 | identical: TRUE 
columnas que difieren en la tabla completa: codigo_bbdd fecha_bbdd 
codigo_bbdd final/preliminar: v22025 / v12025 
fecha_bbdd final/preliminar: 20260622 / 20260427 
calibración (+0.1 en palu_eda_ade_lect4b_rbd ): FALSE 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/comparar_bases.R 2m 2>&1 | grep -v out-of-sync`

esperado: 2m: lo mismo que 4b
obtenido:

```text
hojas final/preliminar: 1 1 
dim final: 3002 42 | dim preliminar: 3002 42 
mismos nombres: TRUE 
rbd únicos final/preliminar: TRUE TRUE | mismo conjunto de rbd: TRUE 
columnas comparadas: 40 | identical: TRUE 
columnas que difieren en la tabla completa: codigo_bbdd fecha_bbdd 
codigo_bbdd final/preliminar: v22025 / v12025 
fecha_bbdd final/preliminar: 20260622 / 20260427 
calibración (+0.1 en palu_eda_ade_lect2m_rbd ): FALSE 
```

`md5 -q docs/index.html`

esperado: 🔒 1: `892929f4fa997bae71e66349b428d7ed`
obtenido: 892929f4fa997bae71e66349b428d7ed

`grep -n 'codigo_bbdd\|fecha_bbdd' 30_procesamiento/*.R 10_utils/*.R 00_build.R; echo "líneas: $(cat 30_procesamiento/*.R 10_utils/*.R 00_build.R | grep -c 'codigo_bbdd\|fecha_bbdd')"`

esperado: premisa de §2: el pipeline no lee las dos columnas de versión: `líneas: 0`
obtenido: líneas: 0

`grep -c 'codigo_bbdd' <(Rscript -e 'cat(names(readxl::read_excel("20_insumos/simce/4b/simce4b2025_rbd_final.xlsx", n_max = 1)), sep = "\n")' 2>/dev/null)`

esperado: control positivo del patrón: `1` (la columna sí existe en el insumo)
obtenido: 1

`sed -n '124,131p' 30_procesamiento/31_leer_normalizar.R; sed -n '321,324p' 30_procesamiento/31_leer_normalizar.R`

esperado: el lector toma los `*.xlsx` del nivel que calzan con `_(final|preliminar)` y marca `preliminar` por el sufijo del archivo
obtenido:

```text

# Patrón de nombre: simce<nivel><anio>_rbd_<estado>.xlsx
patron_archivo <- "^simce(2m|4b)(\\d{4})_rbd_(final|preliminar)\\.xlsx$"

manifiesto <- purrr::map_dfr(niveles, function(nv) {
  paths <- fs::dir_ls(
    here::here("20_insumos", "simce", nv),
    glob = "*.xlsx"
  df_largo$anio       <- as.integer(anio)
  df_largo$nivel      <- nivel
  df_largo$preliminar <- (estado == "preliminar")
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las cinco rutas modificadas por el redactor, las dos finales, el encargo y el LOG; nada más
obtenido:

```text
30_procesamiento/31_leer_normalizar.R
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/activa/manifiesto_insumos.md
README.md
20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
50_documentacion/activa/encargos/encargo_simce2025_final.md
50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

**Estado:** completada. Regla 1 no dispara (`HEAD` = `origin/main` = `005753c` tras el fetch); regla 2 no dispara (el árbol es el conjunto de §2).

**Commits:** ninguno.

**Cambios sustantivos:** se crearon el LOG y `$S`. **PUNTO DE RETORNO: `005753c`.** Premisas de §2 re-derivadas en R: en 4b (7143 × 42) y en 2m (3002 × 42), la base final y la preliminar tienen una sola hoja, los mismos nombres y el mismo conjunto de `rbd` sin duplicados. Ordenadas por `rbd`, las 40 columnas restantes son `identical()`; solo difieren `codigo_bbdd` (v22025 contra v12025) y `fecha_bbdd` (20260622 contra 20260427), y la calibración con +0.1 dispara. El pipeline no lee esas dos columnas (0 líneas; el patrón sí las encuentra en el insumo). El lector marca `preliminar` por el sufijo del archivo (`31_leer_normalizar.R` L323).

**Alcance:** `⊆`. Rutas fuera de git: las cinco del redactor, las dos finales, el encargo y el LOG.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. El LOG se escribió en el scratchpad de la sesión hasta medir `git status --porcelain`, y después se movió a su ruta, como en los logs anteriores. Reversible.

**Errores propios:**
1. `$S` (`mktemp -d`, fuera del árbol) se creó antes del `git fetch`, que POSICIÓN pide como primer acto de FASE 0. No tuvo efecto sobre el repo: el fetch fue el primer acto sobre él. Costo: ninguno.

**Dudas:** ninguna.

### FASE T1: insumos

**Verificación:**

`git show HEAD:20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx | md5; git show HEAD:20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx | md5`

esperado: paso 1: se anotan los md5 de los dos blobs en `005753c` (4b y luego 2m)
obtenido:

```text
3cde757848ed724bc24a839934902143
f1416a77c98d49de715369bfab083bff
```

`md5 -q 20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx 20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx; ls _archivo/20260923/20_insumos 2>&1 | head -n 1`

esperado: chequeo propio antes de mover: los md5 en disco iguales a los de los blobs, y el destino todavía no existe (`No such file or directory`), así que `mv -n` no puede chocar con un archivo previo
obtenido:

```text
3cde757848ed724bc24a839934902143
f1416a77c98d49de715369bfab083bff
ls: _archivo/20260923/20_insumos: No such file or directory
```

`git rm --cached 20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx 20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx`

esperado: autorización 1: dos líneas `rm ...`
obtenido:

```text
rm '20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx'
rm '20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx'
```

`mkdir -p _archivo/20260923/20_insumos/simce/4b _archivo/20260923/20_insumos/simce/2m && mv -n 20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx _archivo/20260923/20_insumos/simce/4b/ && mv -n 20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx _archivo/20260923/20_insumos/simce/2m/; echo "código: $?"; ls _archivo/20260923/20_insumos/simce/4b _archivo/20260923/20_insumos/simce/2m`

esperado: autorización 2: `código: 0` y una preliminar en cada carpeta de `_archivo/`
obtenido:

```text
código: 0
_archivo/20260923/20_insumos/simce/2m:
simce2m2025_rbd_preliminar.xlsx

_archivo/20260923/20_insumos/simce/4b:
simce4b2025_rbd_preliminar.xlsx
```

`ls 20_insumos/simce/4b 20_insumos/simce/2m | grep -c preliminar; git ls-tree -r --name-only HEAD 20_insumos/simce | grep -c preliminar`

esperado: `0` en disco; `2` en `HEAD` (calibración)
obtenido:

```text
0
2
```

`git ls-files 20_insumos/simce | grep -c 2025; git ls-files 20_insumos/simce | grep 2025`

esperado: `2`, y las dos rutas terminan en `_final.xlsx`
obtenido:

```text
2
20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
```

`md5 -q _archivo/20260923/20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx; git show 005753c:20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx | md5; md5 -q _archivo/20260923/20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx; git show 005753c:20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx | md5`

esperado: 🔒 3: pares iguales (`3cde7578…` dos veces y `f1416a77…` dos veces)
obtenido:

```text
3cde757848ed724bc24a839934902143
3cde757848ed724bc24a839934902143
f1416a77c98d49de715369bfab083bff
f1416a77c98d49de715369bfab083bff
```

`git check-ignore -v _archivo/20260923/20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx`

esperado: la regla `_archivo/` de `.gitignore`: lo archivado queda fuera de git
obtenido: .gitignore:25:_archivo/	_archivo/20260923/20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx

`git status --porcelain`

esperado: `D ` en las dos preliminares, `A ` en las dos finales, `M ` en el manifiesto (preparados); ` M` en las cuatro rutas de T2; `??` en el encargo y el LOG; nada más
obtenido:

```text
A  20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
D  20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx
A  20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
D  20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx
 M 30_procesamiento/31_leer_normalizar.R
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
M  50_documentacion/activa/manifiesto_insumos.md
 M README.md
?? 50_documentacion/activa/encargos/encargo_simce2025_final.md
?? 50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: alcance: las cinco rutas de T1 (dos preliminares, dos finales, manifiesto), las cuatro de T2 heredadas del redactor, el encargo y el LOG; nada más
obtenido:

```text
20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx
20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx
30_procesamiento/31_leer_normalizar.R
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
50_documentacion/activa/manifiesto_insumos.md
README.md
50_documentacion/activa/encargos/encargo_simce2025_final.md
50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

`git diff --cached --name-status`

esperado: el índice que se commitea: exactamente `A` de las dos finales, `D` de las dos preliminares y `M` del manifiesto
obtenido:

```text
A	20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
D	20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx
A	20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
D	20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx
M	50_documentacion/activa/manifiesto_insumos.md
```

**Estado:** completada. Regla 3 no dispara: el md5 de cada preliminar archivada es igual al de su blob en `005753c`.

**Commits:** `9bad097` data(simce): bases 2025 finales (v22025) en lugar de las preliminares, archivadas fuera de git (5 rutas: `A` de las dos finales, `D` de las dos preliminares, `M` del manifiesto).

**Cambios sustantivos:**
- Md5 de los blobs en `005753c`: 4b `3cde757848ed724bc24a839934902143` y 2m `f1416a77c98d49de715369bfab083bff`, iguales a los de disco antes de mover.
- `git rm --cached` de las dos preliminares (autorización 1); `mkdir -p` y `mv -n` de cada una a `_archivo/20260923/20_insumos/simce/<nivel>/`, que ignora `.gitignore:25` (autorización 2).
- `git add 20_insumos/simce/4b/simce4b2025_rbd_final.xlsx 20_insumos/simce/2m/simce2m2025_rbd_final.xlsx 50_documentacion/activa/manifiesto_insumos.md` (código 0; corrió fuera del ayudante porque es una acción, no una medición); el índice resultante se midió arriba.
- La edición del redactor a `manifiesto_insumos.md` se commiteó sin cambios.

**Alcance:** `⊆`. Lo commiteado son exactamente las cinco rutas de T1; lo demás fuera de git es lo heredado de §2 para T2, más el encargo y el LOG.

**Regresión:** no tocó código (insumos y documentación). El build corre en T2.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Antes de mover, se comprobó que el destino no existía, porque `mv -n` no sobrescribe y fallaría en silencio si ya hubiera un archivo con ese nombre. Reversible (solo lectura).

**Errores propios:** ninguno.

**Dudas:** ninguna.

### FASE T2: build y motor

**Verificación:**

`cp 40_salidas/intermedios/*.parquet /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/ && cp 40_salidas/motor_comparacion.html /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/ && echo "cp: $?" && ls /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK | sort && for f in 40_salidas/intermedios/*.parquet 40_salidas/motor_comparacion.html; do [ "$(md5 -q $f)" = "$(md5 -q /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/$(basename $f))" ] && echo "igual: $(basename $f)" || echo "DISTINTA: $(basename $f)"; done`

esperado: autorización 3: `cp: 0`; en `$S`, los seis parquets y el HTML, cada copia igual a su original
obtenido:

```text
cp: 0
comunas_chile.parquet
establecimientos_chile.parquet
motor_comparacion.html
simce_comunal.parquet
simce_rbd.parquet
slep_cc_establecimientos.parquet
sleps_chile.parquet
igual: comunas_chile.parquet
igual: establecimientos_chile.parquet
igual: simce_comunal.parquet
igual: simce_rbd.parquet
igual: slep_cc_establecimientos.parquet
igual: sleps_chile.parquet
igual: motor_comparacion.html
```

`md5 -q /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/motor_comparacion.html`

esperado: la copia del HTML es el build desplegado: `892929f4fa997bae71e66349b428d7ed`
obtenido: 892929f4fa997bae71e66349b428d7ed

`Rscript 00_build.R > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_t2.txt 2>&1; echo "código Rscript: $?"; grep -E 'Años preliminares|App JSX|=== 00_build.R: OK|Procesando' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_t2.txt | sed 's/OK en [0-9]* segundos/OK en N segundos/'; echo "líneas de archivo leído: $(grep -cE '^    [ *][0-9]{4}/(4b|2m)' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_t2.txt); marcadas con *: $(grep -cE '^    \*[0-9]{4}/' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_t2.txt)"`

esperado: `código Rscript: 0`; `Años preliminares: ninguno`; la línea `App JSX` con su transpilado (Babel 7.29.0, runtime classic, re-medido); `=== 00_build.R: OK`; 18 archivos leídos y 0 marcados con `*`
obtenido:

```text
código Rscript: 0
[2] Procesando 18 xlsx...
    Años preliminares: ninguno
    App JSX:   156838 caracteres -> JS 175469 caracteres
=== 00_build.R: OK en N segundos ===
líneas de archivo leído: 18; marcadas con *: 0
```

`grep -cE "^    [ *][0-9]{4}/(4b|2m)" /dev/null; ls -l 40_salidas/intermedios/*.parquet | awk "{print \$5, \$NF}"; ls -l /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/*.parquet | awk "{print \$5}"`

esperado: no enumerado; chequeo propio de tamaños (nuevo, luego copia, en el mismo orden): iguales salvo `simce_rbd.parquet`, cuya columna `preliminar` cambió
obtenido:

```text
0
7353 40_salidas/intermedios/comunas_chile.parquet
266585 40_salidas/intermedios/establecimientos_chile.parquet
1012055 40_salidas/intermedios/simce_comunal.parquet
1670034 40_salidas/intermedios/simce_rbd.parquet
5817 40_salidas/intermedios/slep_cc_establecimientos.parquet
60096 40_salidas/intermedios/sleps_chile.parquet
7353
266585
1012055
2342256
5817
60096
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/parquets_t2.R /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync`

esperado: 🔒 2: seis parquets en cada lado; `identical: TRUE` en los seis (en `simce_rbd.parquet`, sin `preliminar`); `sum(preliminar)` nuevo `0` y copia mayor que 0, solo en 2025 (calibración); calibración de `identical()` `FALSE`
obtenido:

```text
parquets nuevos: 6 | copias en S: 6 
comunas_chile.parquet | dim nuevo 345 4 | dim copia 345 4 | identical: TRUE 
establecimientos_chile.parquet | dim nuevo 10945 5 | dim copia 10945 5 | identical: TRUE 
simce_comunal.parquet | dim nuevo 44975 14 | dim copia 44975 14 | identical: TRUE 
simce_rbd.parquet | dim nuevo 185378 13 | dim copia 185378 18 | identical: FALSE 
slep_cc_establecimientos.parquet | dim nuevo 73 8 | dim copia 73 8 | identical: TRUE 
sleps_chile.parquet | dim nuevo 2337 7 | dim copia 2337 7 | identical: TRUE 
sum(preliminar) nuevo: 0 | copia en S: 20290 | años con preliminar en la copia: 2025 
calibración (+0.1 en simce_rbd$palu_eda_ade): FALSE 
```

Nota: el primer comando de este bloque arrastró un `grep -cE … /dev/null` sin propósito (su `0` no mide nada); los tamaños son las líneas siguientes.

**🔒 2 en FALLA** (`simce_rbd.parquet | dim nuevo 185378 13 | dim copia 185378 18 | identical: FALSE`). Regla 5: **T2 queda congelada sin commit**. Lo que sigue es diagnóstico de solo lectura y evidencia para la duda; no reabre la tarea ni ajusta el criterio.

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/diag_simce_rbd.R /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync`

esperado: desconocido. Se registran las columnas que solo tiene la copia del 11 de julio y si las 13 comunes son `identical()`
obtenido:

```text
columnas nuevo: anio nivel prueba rbd cod_com_rbd nom_com_rbd cod_grupo cod_depe2 nalu palu_eda_ade palu_eda_ele palu_eda_ins marca preliminar 
columnas solo en la copia: prom dif difgru sigdif siggru 
tipos de las columnas extra: numeric numeric numeric integer integer 
columnas solo en el nuevo: ninguna 
mismo orden de las comunes en la copia: TRUE 
identical en las 13 comunes, mismo orden de filas: TRUE 
NA por columna extra en la copia: 10013 28717 23681 24038 19582 
atributos de tabla nuevo/copia: names class row.names / names class row.names 
```

`grep -rln 'simce_rbd' --include='*.R' . | grep -v '^./renv/' | sort; echo ---; grep -rn 'write_parquet' --include='*.R' . | grep -v '^./renv/' | grep -i 'rbd' | cut -c1-160`

esperado: qué scripts del repositorio mencionan `simce_rbd` y cuáles escriben un parquet de RBD
obtenido:

```text
./_archivo/20260611/auditoria_a1_reagregacion_comunal.R
./_archivo/20260611/auditoria_a2_consistencia_popup.R
./_archivo/20260611/auditoria_a2b_verificar_html.R
./_archivo/20260611/auditoria_a3_equivalencia_slep.R
./_archivo/20260611/auditoria_a6_muestra_oficial.R
./_archivo/20260611/auditoria_a7_reproducibilidad.R
./_archivo/20260611/auditoria_popup_petorca.R
./_archivo/20260611/diagnostico_peso_json.R
./_archivo/auditoria_agregacion_comunal.R
./30_procesamiento/31_leer_normalizar.R
./30_procesamiento/32_agregar_comunal.R
./30_procesamiento/33_generar_html.R
./30_procesamiento/34_historico_pct_adecuado_costa_central.R
./50_documentacion/andamios/verificar_trayectorias.R
./50_documentacion/suite/documentar.R
./verificar_depe4.R
---
./30_procesamiento/31_leer_normalizar.R:414:arrow::write_parquet(df_simce_rbd, ruta_salida)
```

`grep -rlwE 'prom|dif|difgru|sigdif|siggru' --include='*.R' --include='*.html' --include='*.md' . 2>/dev/null | grep -v '^./renv/' | sort`

esperado: qué archivos del repositorio nombran alguna de las cinco columnas como palabra completa
obtenido:

```text
./50_documentacion/andamios/logs/20260827_medicion_panorama_territorial_log.md
./50_documentacion/andamios/logs/20260829_verificacion_dudas_s29_log.md
./50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

`grep -nwE 'prom|dif|difgru|sigdif|siggru' 30_procesamiento/31_leer_normalizar.R 30_procesamiento/32_agregar_comunal.R 30_procesamiento/33_generar_html.R 30_procesamiento/34_historico_pct_adecuado_costa_central.R 50_documentacion/andamios/verificar_trayectorias.R | cut -c1-170 | head -n 25`

esperado: dónde las nombran el pipeline, el histórico y el verificador de trayectorias
obtenido: (sin salida)

`git log --all --format='%h %ad %s' --date=short -S'siggru' | head -n 5; git log --format='%h %ad %s' --date=short --since=2026-07-10 --until=2026-07-12 | head -n 10`

esperado: si algún commit introdujo o quitó `siggru`, y qué se commiteó alrededor del 11 de julio
obtenido:

```text
a668951 2026-08-29 docs(encargos): versiona los encargos de verificacion y rescate con sus logs
2ecad9d 2026-08-27 docs(log): medicion de insumos para el panorama territorial
667e5ad 2026-08-24 docs(cierre): commitea documentacion pendiente de sesiones previas
31befa2 2026-07-11 feat(contexto): productor del contrato de contexto v1 (paso 35)
6e00830 2026-07-11 feat(contexto): normalizador persiste las señales de la Agencia (puntaje)
```

`git show --stat --format='%h %ad %s' --date=short 6e00830 | head -n 12; git show --stat --format='%h %ad %s' --date=short 31befa2 | head -n 12`

esperado: qué rutas tocaron los dos commits del 11 de julio
obtenido:

```text
6e00830 2026-07-11 feat(contexto): normalizador persiste las señales de la Agencia (puntaje)

 30_procesamiento/31_leer_normalizar.R | 100 +++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 15 deletions(-)
31befa2 2026-07-11 feat(contexto): productor del contrato de contexto v1 (paso 35)

 00_build.R                                      |   2 +
 30_procesamiento/35_exponer_contrato_contexto.R | 147 ++++++++++++
 40_salidas/publico/contexto_simce.parquet       | Bin 0 -> 303863 bytes
 50_documentacion/activa/contrato_contexto_v1.md | 284 ++++++++++++++++++++++++
 4 files changed, 433 insertions(+)
```

`git branch -a --contains 6e00830 | head -n 5; git merge-base --is-ancestor 6e00830 HEAD; echo "6e00830 ancestro de HEAD: $?"`

esperado: si `6e00830` está en la historia de `main`
obtenido:

```text
  feat/contrato-contexto
6e00830 ancestro de HEAD: 1
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/json_t2.R 40_salidas/motor_comparacion.html /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/motor_comparacion.html 2>&1 | grep -v out-of-sync`

esperado: criterio del encargo: difieren solo `meta.anios_preliminar` (`[]` contra `[2025]`) y, si los builds fueran de días distintos, `meta.fecha_generacion` (los dos son del 2026-09-23, así que esa puede coincidir); sin esos dos campos, `identical: TRUE`; calibración `FALSE`
obtenido:

```text
claves de primer nivel iguales: TRUE 
claves de primer nivel que difieren: meta 
campos de meta que difieren: anios_preliminar 
anios_preliminar nuevo: largo 0 valores [ ] | copia: largo 1 valores [ 2025 ]
fecha_generacion nuevo/copia: 2026-09-23 2026-09-23 
identical sin fecha_generacion ni anios_preliminar: TRUE 
calibración: simce_rbd$anio largo 140345 | identical tras alterar una celda: FALSE 
```

Universo: el bloque de la app, último `<script>` del archivo (extracción del encargo, calibrada con `ReactDOM.createRoot`).

`for f in 40_salidas/motor_comparacion.html /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/motor_comparacion.html; do Rscript -e 'x <- paste(readLines(commandArgs(TRUE)[1], warn=FALSE, encoding="UTF-8"), collapse="\n"); b <- tail(strsplit(x, "<script>", fixed=TRUE)[[1]], 1); m <- gregexpr("PRELIMINAR_YEARS.length > 0", b, fixed=TRUE)[[1]]; cat(grepl("ReactDOM.createRoot", b, fixed=TRUE), if (m[1] < 0) 0L else length(m), grepl("Dato preliminar (2025", b, fixed=TRUE), "\n")' $f 2>&1 | grep -v out-of-sync; done`

esperado: nuevo: `TRUE`, 2 o más, `FALSE`; copia en `$S` (calibración): `TRUE`, `0`, `TRUE` (el literal sí aparece)
obtenido:

```text
TRUE 2 FALSE 
TRUE 0 TRUE 
```

`grep -c 'src="http' 40_salidas/motor_comparacion.html; grep -c 'src="http' /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/motor_comparacion.html; md5 -q 40_salidas/motor_comparacion.html; wc -c < 40_salidas/motor_comparacion.html | tr -d ' '`

esperado: página completa: `0` en el nuevo y `0` en la copia (ya sin red desde el retiro de `unpkg.com`); se anotan md5 y tamaño del nuevo
obtenido:

```text
0
0
3f9a5b3b9a5f2ea0466d4046ab53f0ab
2785749
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: alcance: las cuatro rutas de código y documentación de T2 (sin commit), el encargo y el LOG; nada más
obtenido:

```text
30_procesamiento/31_leer_normalizar.R
30_procesamiento/33_generar_html.R
30_procesamiento/33_motor_template.html
README.md
50_documentacion/activa/encargos/encargo_simce2025_final.md
50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

**Estado:** **congelada** por la regla 5 (y el 🔒 2 en FALLA), sin commit. Disparo: `simce_rbd.parquet | dim nuevo 185378 13 | dim copia 185378 18 | identical: FALSE`. El diagnóstico muestra que la diferencia viene de la línea base y no del cambio: ninguna cifra que el pipeline de `main` produce cambió (ver Dudas).

**Commits:** ninguno. `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html` y `README.md` siguen ` M`, sin commit.

**Cambios sustantivos:**
- Copias al scratch verificadas (autorización 3).
- `00_build.R` al primer intento, código 0: `Años preliminares: ninguno`, 18 archivos leídos y ninguno marcado con `*`, `App JSX: 156838 caracteres -> JS 175469 caracteres` (el transpilado con Babel 7.29.0 y runtime `classic` corre sin error).
- Parquets: cinco de seis `identical()`. En `simce_rbd.parquet`, `sum(preliminar)` pasa de 20290 (solo 2025) a 0. Tamaño: 1670034 bytes contra 2342256 de la copia; los otros cinco igualan su tamaño.
- JSON del HTML: solo difiere `meta.anios_preliminar` (`[]` contra `[2025]`); `fecha_generacion` coincide porque los dos builds son del 2026-09-23. Sin esos dos campos, `identical: TRUE` (calibración sobre `simce_rbd$anio`, 140345 elementos: `FALSE`).
- Bloque de la app: 2 `PRELIMINAR_YEARS.length > 0` y ningún `Dato preliminar (2025`; en la copia, 0 y el literal presente.
- Página: 0 `src="http`. Salida: md5 `3f9a5b3b9a5f2ea0466d4046ab53f0ab`, 2785749 bytes.

**Diagnóstico de la FALLA:**
- La copia en `$S` de `simce_rbd.parquet` (fechada el 11 de julio) tiene cinco columnas que el lector de `main` nunca escribe: `prom`, `dif`, `difgru`, `sigdif`, `siggru` (tres numéricas y dos enteras).
- Las 13 columnas comunes, sin `preliminar`, son `identical()` con el mismo orden de filas.
- Esas cinco columnas las agregó `6e00830` ("feat(contexto): normalizador persiste las señales de la Agencia (puntaje)", 2026-07-11), que está en la rama local `feat/contrato-contexto` y no es ancestro de `HEAD`. Junto con `31befa2` (paso 35, contrato de contexto), del mismo día y la misma rama, explica la fecha del parquet: el intermedio del árbol quedó escrito por un build corrido en esa rama.
- Ningún archivo `.R`, `.html` ni `.md` de `main` nombra esas columnas como palabra completa, salvo tres logs; ninguno las consume.

**Alcance:** `⊆`. Las cuatro rutas de T2 sin commit, el encargo y el LOG; las salidas de `40_salidas/` están ignoradas.

**Regresión:** `Rscript 00_build.R`, código 0, `=== 00_build.R: OK`.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Tras congelar, se midieron en modo solo lectura el resto de los criterios de T2 y un diagnóstico de la FALLA, para que la duda llegue con la evidencia completa (patrón de las sesiones anteriores). Alternativa descartada: detenerse en la FALLA. Reversible.
2. No se commitea T2 ni se reformula el 🔒 2 (prohibido: FASE R paso 9). Alternativa descartada: comparar solo las 13 columnas comunes y commitear.

**Errores propios:**
1. El primer comando de medición de tamaños arrastró un `grep -cE … /dev/null` sin propósito; se anotó en una línea nueva. Costo: ninguno.

**Dudas:**
1. Contexto: el 🔒 2 falla en `simce_rbd.parquet` porque la línea base (la copia en `$S`) salió de un build de la rama `feat/contrato-contexto` (`6e00830`) y trae cinco columnas (`prom`, `dif`, `difgru`, `sigdif`, `siggru`) que el lector de `main` no escribe. Las 13 columnas que sí escribe son `identical()`, los otros cinco parquets también, y el JSON publicado es `identical()` salvo `anios_preliminar`. Pregunta cerrada: ¿se acepta que el 🔒 2 se mida sobre las columnas que escribe el pipeline de `main` (13 comunes, `TRUE`), y con eso se commitea T2 tal como está (sí/no)? Bloquea el commit de T2 y el push.
2. Contexto: el build de `main` sobrescribió el `simce_rbd.parquet` de la rama `feat/contrato-contexto` en `40_salidas/intermedios/` (salida ignorada, en el ALCANCE de T2). Esa versión solo sobrevive en `$S`, un directorio temporal del sistema, y se regenera corriendo `00_build.R` en esa rama. Pregunta cerrada: ¿se conserva la copia de `$S` (por ejemplo, en `_archivo/`), o basta con que sea regenerable (conservar/no)? No bloquea.

### FASE R: auditoría y reparación

Panel adversarial: no aplicado (subagentes 0 por contrato). Re-deriva el orquestador con comandos distintos: `shasum -a 256` y hashes de objeto de git donde se usó `md5`, conteos en R donde se usó `grep`, `openxlsx` donde se usó `readxl`, y sustitución de bytes donde se usó `fromJSON`.

**Inventario (anexado antes de auditar):**

- R-01 · FASE 0: HEAD = `origin/main` = `005753c` al empezar.
- R-02 · FASE 0: el árbol de partida era el conjunto de §2.
- R-03 · FASE 0: en 4b y en 2m, final y preliminar coinciden en las 40 columnas de datos y solo difieren en `codigo_bbdd` y `fecha_bbdd`.
- R-04 · FASE 0: el pipeline no lee `codigo_bbdd` ni `fecha_bbdd`.
- R-05 · T1: los blobs de las preliminares en `005753c` tienen md5 `3cde7578…` (4b) y `f1416a77…` (2m).
- R-06 · T1: no queda ninguna preliminar en `20_insumos/simce/`; en `005753c` había 2.
- R-07 · T1: lo versionado de 2025 son exactamente las dos finales.
- R-08 · T1: el commit `9bad097` trae exactamente cinco rutas (A, A, D, D, M).
- R-09 · 🔒 3: las preliminares archivadas son idénticas a sus blobs.
- R-10 · T2: build OK, `Años preliminares: ninguno`, 18 archivos leídos y 0 marcados.
- R-11 · 🔒 2: cinco parquets `identical()`; `simce_rbd.parquet` `FALSE` (FALLA).
- R-12 · T2: en `simce_rbd.parquet`, las 13 columnas comunes son idénticas, la copia trae cinco columnas extra, y estas vienen de `6e00830` (rama `feat/contrato-contexto`).
- R-13 · T2: `sum(preliminar)` es 0 en el nuevo y 20290 (solo 2025) en la copia.
- R-14 · T2: el JSON del HTML solo difiere en `meta.anios_preliminar`.
- R-15 · T2: el bloque de la app tiene 2 condicionales y no trae el literal; la copia, 0 y el literal.
- R-16 · T2: la página tiene 0 `src="http`.
- R-17 · 🔒 1: `docs/index.html` no cambia.
- R-18 · 🔒 4: I8 en PASA.
- R-19 · Alcance global: `git diff --name-only 005753c..HEAD` ⊆ ALCANCE más el LOG.
- R-20 · Estado del árbol al cierre de FASE R.
- R-21 · Regresión: `00_build.R` otra vez; md5 de la salida igual al de T2 (`3f9a5b3b…`).
- R-22 · Registro: cada `esperado:` tiene su `obtenido:`.
- R-23 · Control positivo: un caso plantado en `$S` que el instrumento del 🔒 2 debe detectar.

**Re-derivación:**

`git ls-remote origin refs/heads/main | cut -f1; git rev-parse 005753c; git rev-list --count origin/main..HEAD; git rev-list --count HEAD..origin/main`

esperado: R-01: el hash remoto igual al completo de `005753c`; `1` por delante (`9bad097`); `0` por detrás
obtenido:

```text
005753c7c3cd6fdc29ed8019daae5bbfeb0a33d1
005753c7c3cd6fdc29ed8019daae5bbfeb0a33d1
1
0
```

`git diff --name-status 005753c | sort`

esperado: R-02, por otra vía (árbol contra el retorno): `A` de las dos finales, `D` de las dos preliminares y `M` del manifiesto (T1), más `M` en las cuatro rutas de T2; es el conjunto de §2 más lo que hizo T1
obtenido:

```text
A	20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
A	20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
D	20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx
D	20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx
M	30_procesamiento/31_leer_normalizar.R
M	30_procesamiento/33_generar_html.R
M	30_procesamiento/33_motor_template.html
M	50_documentacion/activa/manifiesto_insumos.md
M	README.md
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-03 2>&1 | grep -v out-of-sync`

esperado: R-03, con `openxlsx` (otro lector) y la preliminar ya archivada: 4b y 2m con las filas de FASE 0, 40 columnas, serialización igual `TRUE`
obtenido:

```text
4b | filas 7143 7143 | columnas comparadas 40 | md5 de la serialización igual: TRUE 
2m | filas 3002 3002 | columnas comparadas 40 | md5 de la serialización igual: TRUE 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-04 2>&1 | grep -v out-of-sync`

esperado: R-04, en R: `0` líneas
obtenido: archivos leídos: 8 | líneas con las columnas de versión: 0 

`git rev-parse 005753c:20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx; git hash-object _archivo/20260923/20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx; git rev-parse 005753c:20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx; git hash-object _archivo/20260923/20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx`

esperado: R-05 y R-09, por hash de objeto git: pares iguales
obtenido:

```text
d2b74204afdeaa3ebecc922d7b910fa7aea23d90
d2b74204afdeaa3ebecc922d7b910fa7aea23d90
1b1b93f0213db821cdf03878e80ec6793ef47b93
1b1b93f0213db821cdf03878e80ec6793ef47b93
```

`git show 005753c:20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx | shasum -a 256 | cut -c1-64; shasum -a 256 _archivo/20260923/20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx | cut -c1-64; git show 005753c:20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx | shasum -a 256 | cut -c1-64; shasum -a 256 _archivo/20260923/20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx | cut -c1-64`

esperado: R-09 🔒 3, con `shasum -a 256`: pares iguales
obtenido:

```text
f5556cbab412e74052af88d2c83d328e8f0e421dd0386ad1e96eff2b29b9d36d
f5556cbab412e74052af88d2c83d328e8f0e421dd0386ad1e96eff2b29b9d36d
67b37661f9ab59af1ccf8788a0303b2034982043111227386dbee6461fea0c6b
67b37661f9ab59af1ccf8788a0303b2034982043111227386dbee6461fea0c6b
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-06 2>&1 | grep -v out-of-sync; git ls-tree -r --name-only 005753c 20_insumos/simce | grep -c preliminar`

esperado: R-06, en R: `0`; en el árbol de `005753c`: `2`
obtenido:

```text
preliminares en 20_insumos/simce: 0 
2
```

`git ls-tree -r --name-only HEAD 20_insumos/simce | grep 2025`

esperado: R-07, sobre el árbol commiteado (no el índice): exactamente las dos `_final`
obtenido:

```text
20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
```

`git diff-tree --no-commit-id --name-status -r 9bad097`

esperado: R-08: A, A, D, D en `20_insumos/simce/` y M en el manifiesto; nada más
obtenido:

```text
A	20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
D	20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx
A	20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
D	20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx
M	50_documentacion/activa/manifiesto_insumos.md
```

`grep -c 'Años preliminares: ninguno' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_t2.txt; Rscript -e 'l <- readLines(commandArgs(TRUE)[1], warn=FALSE); cat(sum(grepl("^    [ *][0-9]{4}/(4b|2m)", l)), sum(grepl("^    [*][0-9]{4}/", l)), "\n")' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_t2.txt 2>&1 | grep -v out-of-sync`

esperado: R-10, en R sobre la salida guardada del build: `1`; luego `18 0`
obtenido:

```text
1
18 0 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-11 /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync`

esperado: R-11 🔒 2, por md5 de la serialización y del archivo: cinco `TRUE` (se espera además que sean iguales byte a byte) y `simce_rbd.parquet` `FALSE`
obtenido:

```text
comunas_chile.parquet | serialización igual: TRUE | archivo byte a byte igual: FALSE 
establecimientos_chile.parquet | serialización igual: TRUE | archivo byte a byte igual: FALSE 
simce_comunal.parquet | serialización igual: TRUE | archivo byte a byte igual: FALSE 
simce_rbd.parquet | serialización igual: FALSE | archivo byte a byte igual: FALSE 
slep_cc_establecimientos.parquet | serialización igual: TRUE | archivo byte a byte igual: FALSE 
sleps_chile.parquet | serialización igual: TRUE | archivo byte a byte igual: FALSE 
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-12 /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync; git show 6e00830 -- 30_procesamiento/31_leer_normalizar.R | grep -c 'siggru'`

esperado: R-12, por esquema de arrow y `all.equal`: 14 contra 19 columnas, las cinco extra en la copia, `all.equal` en las comunes `TRUE`; y `siggru` aparece en el diff de `6e00830` (mayor que 0)
obtenido:

```text
esquema: columnas nuevo 14 | copia 19 | solo en la copia: prom dif difgru sigdif siggru 
all.equal en las comunes: TRUE 
10
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-13 /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync`

esperado: R-13, con `table()`: nuevo solo `FALSE=185378`; copia con `TRUE` solo en 2025, 20290 filas
obtenido: table nuevo: FALSE=185378 | copia TRUE por año: 2025=20290 

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-14 /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync`

esperado: R-14, por sustitución de bytes: `"anios_preliminar":[]` contra `"anios_preliminar":[2025]`, y `TRUE` al sustituir
obtenido:

```text
campo en nuevo: "anios_preliminar":[] | en copia: "anios_preliminar":[2025] 
bytes idénticos tras poner en el nuevo el campo de la copia: TRUE 
```

El esperado propio de byte-identidad en R-11 no se cumplió: los seis archivos difieren en bytes, aunque los cinco que el criterio cubre tienen la serialización del contenido igual y el mismo tamaño. No es criterio del encargo (el 🔒 2 es `identical()` del contenido); se diagnostica en qué difieren:

`cmp -l 40_salidas/intermedios/comunas_chile.parquet /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/comunas_chile.parquet | wc -l | tr -d ' '; Rscript -e 'f <- function(p) { r <- arrow::ParquetFileReader$create(p); m <- r$GetSchema()$metadata; c(names(m)) }; cat(f("40_salidas/intermedios/comunas_chile.parquet"), "|", f(commandArgs(TRUE)[1]), "\n")' /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/comunas_chile.parquet 2>&1 | grep -v out-of-sync`

esperado: bytes distintos: pocos, del orden de decenas; las claves de metadatos de esquema, las mismas en los dos
obtenido:

```text
2
 |  
```

`strings -n 6 40_salidas/intermedios/comunas_chile.parquet | grep -i 'parquet-cpp\|arrow' | head -n 3; echo ---; strings -n 6 /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/comunas_chile.parquet | grep -i 'parquet-cpp\|arrow' | head -n 3`

esperado: la cadena `created_by` del escritor en cada archivo (hipótesis: cambió la versión de arrow, con el mismo largo de texto)
obtenido:

```text
ARROW:schema
 parquet-cpp-arrow version 24.0.0
---
ARROW:schema
 parquet-cpp-arrow version 23.0.1
```

`for f in 40_salidas/motor_comparacion.html /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/motor_comparacion.html; do awk '$0=="  <script>"{s=NR} $0=="  </script>"{e=NR} {a[NR]=$0} END{for(i=s+1;i<e;i++) print a[i]}' $f > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_x.js; echo "$(grep -c 'ReactDOM.createRoot' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_x.js) $(grep -o 'PRELIMINAR_YEARS.length > 0' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_x.js | wc -l | tr -d ' ') $(grep -c 'Dato preliminar (2025' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/app_x.js)"; done`

esperado: R-15, por `awk` entre anclas y `grep -o`: nuevo `1 2 0`; copia `1 0 1`
obtenido:

```text
1 2 0
1 0 1
```

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-16 2>&1 | grep -v out-of-sync`

esperado: R-16, en R: `0`
obtenido: líneas con src="http: 0 

`md5 -q docs/index.html; shasum -a 256 docs/index.html | cut -c1-64; git show HEAD:docs/index.html | shasum -a 256 | cut -c1-64; git diff --quiet 005753c -- docs/index.html; echo "sin cambios desde el retorno: $?"`

esperado: R-17 🔒 1: `892929f4fa997bae71e66349b428d7ed`; dos sha256 iguales (disco y HEAD); `0`
obtenido:

```text
892929f4fa997bae71e66349b428d7ed
d0548faf8cd467322971941ada505a8af0fac5b7d16482d5aab85abc54b48cfd
d0548faf8cd467322971941ada505a8af0fac5b7d16482d5aab85abc54b48cfd
sin cambios desde el retorno: 0
```

`Rscript "$HERRAMIENTAS_DEV_PATH/plantillas/95_verificar_cierre.R" . 2>&1 | grep -v out-of-sync | sed 's/[[:space:]]*$//' | head -n 20`

esperado: R-18 🔒 4: I8 en PASA (18+ rutas de datos, todas cubiertas por la lista de autorización). Los demás invariantes solo se anotan; se prevé I1 en FALLA (árbol sucio) e I3 en FALLA (1 commit por delante)
obtenido:

```text
Compuerta de repositorio - slep_simce_adecuado
rama main | HEAD 9bad097 | corrida 2026-09-23 16:24:33

[I1] FALLA - 6 lineas en status --porcelain: 30_procesamiento/31_leer_normalizar.R, 30_procesamiento/33_generar_html.R, 30_procesamiento/33_motor_template.html, README.md, 50_documentacion/activa/encargos/encargo_simce2025_final.md, 50_documentacion/andamios/logs/20260923_simce2025_final_log.md
[I2] PASA - 0 stashes
[I3] FALLA - 0 detras, 1 adelante contra origin/main (fetch corrido)
[I4] PASA - rama actual 'main'; publicable 'main' (origen: defecto)
[I5] PASA - 1 traspaso vigente y trackeado: traspaso_cierre_v30.md
[I6] PASA - 6/6 llaves presentes; traspaso_vigente 'traspaso_cierre_v30.md' coherente con el disco
[I7] PASA - snapshot 20260923_124131 con sello de hoy e identico a estructura_actual.txt
[I8] PASA - 28 rutas de datos, 28 cubiertas por la lista de autorizacion
[I9] PASA - 1 de 1 entrada(s) declaradas resuelven: ./20_insumos; 2 fila(s) de huella

| raiz | archivo | modificado | tamano |
|---|---|---|---|
| ./20_insumos | auxiliares | 2026-07-27 14:45 | dir |
| ./20_insumos | simce | 2026-08-28 12:12 | dir |

RESULTADO: 7/9 PASA - FALLAN: I1, I3
```

`globs=$(awk '/^[[:space:]]*```/{c++; next} c==1{sub(/#.*/,""); gsub(/^[[:space:]]+|[[:space:]]+$/,""); if (length($0)) print}' 50_documentacion/activa/50_datos_versionados_autorizados.md); n=0; sin=0; while IFS= read -r r; do n=$((n+1)); ok=0; for g in $globs; do case "$r" in $g) ok=1;; esac; done; [ $ok = 0 ] && sin=$((sin+1)) && echo "sin cubrir: $r"; done < <(git ls-tree -r --name-only HEAD | grep -Ei "\.(xlsx|xls|xlsm|xlsb|csv|tsv|parquet|rds|rdata|sav|dta|db|sqlite|sqlite3|json|geojson)$"); echo "rutas de datos en HEAD: $n; sin cubrir: $sin"`

esperado: R-18, re-derivado en shell sobre el árbol commiteado (`git ls-tree`) y los *globs* de la lista con `case`: `rutas de datos en HEAD: 28; sin cubrir: 0`
obtenido: rutas de datos en HEAD: 28; sin cubrir: 0

`git diff --name-only 005753c..HEAD`

esperado: R-19: las cinco rutas de T1; ⊆ ALCANCE
obtenido:

```text
20_insumos/simce/2m/simce2m2025_rbd_final.xlsx
20_insumos/simce/2m/simce2m2025_rbd_preliminar.xlsx
20_insumos/simce/4b/simce4b2025_rbd_final.xlsx
20_insumos/simce/4b/simce4b2025_rbd_preliminar.xlsx
50_documentacion/activa/manifiesto_insumos.md
```

`git status --porcelain`

esperado: R-20: ` M` en las cuatro rutas de T2 congelada; `??` en el encargo y el LOG; nada más
obtenido:

```text
 M 30_procesamiento/31_leer_normalizar.R
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
 M README.md
?? 50_documentacion/activa/encargos/encargo_simce2025_final.md
?? 50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

Bug del instrumento propio (R-18, intento 1): en el comando anterior, `for g in $globs` sin `set -f` deja que el shell expanda cada *glob* contra los archivos en disco antes del `case`. Para rutas versionadas que existen en disco el resultado no cambia, pero el instrumento no es el correcto. Intento 2, con la expansión desactivada:

`set -f; globs=$(awk '/^[[:space:]]*```/{c++; next} c==1{sub(/#.*/,""); gsub(/^[[:space:]]+|[[:space:]]+$/,""); if (length($0)) print}' 50_documentacion/activa/50_datos_versionados_autorizados.md); echo "globs: $(echo "$globs" | wc -l | tr -d " ")"; n=0; sin=0; while IFS= read -r r; do n=$((n+1)); ok=0; for g in $globs; do case "$r" in $g) ok=1;; esac; done; [ $ok = 0 ] && sin=$((sin+1)) && echo "sin cubrir: $r"; done < <(git ls-tree -r --name-only HEAD | grep -Ei "\.(xlsx|xls|xlsm|xlsb|csv|tsv|parquet|rds|rdata|sav|dta|db|sqlite|sqlite3|json|geojson)$"); echo "rutas de datos en HEAD: $n; sin cubrir: $sin"; printf "20_insumos/plantado.parquet\n" | while IFS= read -r r; do ok=0; for g in $globs; do case "$r" in $g) ok=1;; esac; done; echo "control plantado cubierto: $ok"; done`

esperado: R-18: `rutas de datos en HEAD: 28; sin cubrir: 0`; y un `.parquet` plantado fuera de la lista no queda cubierto (`control plantado cubierto: 0`)
obtenido:

```text
globs: 7
rutas de datos en HEAD: 28; sin cubrir: 0
control plantado cubierto: 0
```

Regresión completa (paso 5):

`Rscript 00_build.R > /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_faseR.txt 2>&1; echo "código Rscript: $?"; grep -E 'Años preliminares|=== 00_build.R: OK' /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/build_simce_faseR.txt | sed 's/OK en [0-9]* segundos/OK en N segundos/'; md5 -q 40_salidas/motor_comparacion.html`

esperado: R-21: `código Rscript: 0`; `Años preliminares: ninguno`; `=== 00_build.R: OK`; md5 `3f9a5b3b9a5f2ea0466d4046ab53f0ab`, el mismo de T2
obtenido:

```text
código Rscript: 0
    Años preliminares: ninguno
=== 00_build.R: OK en N segundos ===
3f9a5b3b9a5f2ea0466d4046ab53f0ab
```

Control positivo de la auditoría (paso 6), plantado en `$S`:

`Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/auditoria_simce.R R-23 /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK 2>&1 | grep -v out-of-sync; Rscript /private/tmp/claude-501/-Users-tomgc-Projects-slep-simce-adecuado/3cc083c8-dc4d-48f2-81db-347c6a85c39c/scratchpad/parquets_t2.R /var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/tmp.MptvoAnTsK/plantado 2>&1 | grep -v out-of-sync | grep 'identical'`

esperado: R-23: con las copias de los parquets nuevos en `$S/plantado` y una celda de `simce_comunal` alterada, el instrumento del 🔒 2 da `TRUE` en los otros cinco y `FALSE` solo en `simce_comunal.parquet`
obtenido:

```text
plantado: +1 en una celda de simce_comunal$n_estab dentro de $S/plantado
comunas_chile.parquet | dim nuevo 345 4 | dim copia 345 4 | identical: TRUE 
establecimientos_chile.parquet | dim nuevo 10945 5 | dim copia 10945 5 | identical: TRUE 
simce_comunal.parquet | dim nuevo 44975 14 | dim copia 44975 14 | identical: FALSE 
simce_rbd.parquet | dim nuevo 185378 13 | dim copia 185378 13 | identical: TRUE 
slep_cc_establecimientos.parquet | dim nuevo 73 8 | dim copia 73 8 | identical: TRUE 
sleps_chile.parquet | dim nuevo 2337 7 | dim copia 2337 7 | identical: TRUE 
```

`echo "esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md) obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md)"`

esperado: R-22: `esperado` supera en 1 a `obtenido` (la medición en curso)
obtenido: esperado: 64 obtenido: 63

**Tabla de auditoría:**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | HEAD = origin/main = `005753c` al empezar | `git ls-remote` + `rev-list --count` | hash remoto `005753c7…`; 1 / 0 | igual | — | — | — | — |
| R-02 | árbol de partida = §2 | `git diff --name-status 005753c` | §2 + acciones de T1 | igual | — | — | — | — |
| R-03 | final = preliminar en 40 columnas | `openxlsx` + md5 de la serialización | `TRUE` en 4b y 2m | `TRUE` en 4b y 2m | — | — | — | calibración de FASE 0 |
| R-04 | el pipeline no lee `codigo_bbdd` ni `fecha_bbdd` | R, `grepl` sobre 8 archivos | 0 | 0 | — | — | — | control positivo en FASE 0 |
| R-05 | md5 de los blobs de las preliminares | `git rev-parse <rev>:<ruta>` contra `git hash-object` | iguales | iguales | — | — | — | — |
| R-06 | sin preliminares en `20_insumos/simce/` | R, `list.files` | 0; 2 en `005753c` | 0; 2 | — | — | `9bad097` | — |
| R-07 | 2025 versionado = dos finales | `git ls-tree HEAD` | 2 `_final` | igual | — | — | `9bad097` | — |
| R-08 | commit T1 = 5 rutas | `git diff-tree --name-status` | A A D D M | igual | — | — | `9bad097` | — |
| R-09 | 🔒 3 preliminares archivadas intactas | `shasum -a 256` + hash de objeto | pares iguales | pares iguales | — (PASA) | — | — | — |
| R-10 | build OK; ninguno preliminar; 18 archivos, 0 con `*` | R sobre la salida guardada | 1; 18 0 | 1; 18 0 | — | — | — | R-21 |
| R-11 | 🔒 2 parquets `identical()` | md5 de la serialización y del archivo | 5 `TRUE` + `simce_rbd` `FALSE`; bytes iguales | 5 `TRUE` + `simce_rbd` `FALSE`; bytes distintos en los 6 | **BLOQUEA** (🔒 en FALLA en `simce_rbd.parquet`) y ADVIERTE (bytes: el escritor pasó de arrow 23.0.1 a 24.0.0; 2 bytes en `comunas_chile`, sin efecto sobre el contenido) | T2 congelada; Duda 1 de T2 | — | diagnóstico R-12 |
| R-12 | la FALLA viene de la línea base (rama `feat/contrato-contexto`), no del cambio | esquema de arrow + `all.equal` + `git show 6e00830` | 14 contra 19 columnas; comunes `TRUE`; `siggru` en `6e00830` | igual (`siggru` 10 veces) | ADVIERTE (el `simce_rbd.parquet` de esa rama quedó sobrescrito y solo sobrevive en `$S`) | Duda 2 de T2 | — | — |
| R-13 | `preliminar`: 0 contra 20290 (2025) | `table()` | `FALSE=185378`; `2025=20290` | igual | — | — | — | — |
| R-14 | JSON: solo difiere `anios_preliminar` | sustitución de bytes | `[]` contra `[2025]`; `TRUE` | igual | — | — | — | calibración en T2 |
| R-15 | app: 2 condicionales, sin literal; la copia con literal | `awk` + `grep -o` | `1 2 0`; `1 0 1` | igual | — | — | — | — |
| R-16 | página sin `src="http` | R por línea | 0 | 0 | — | — | — | — |
| R-17 | 🔒 1 `docs/index.html` intacto | `shasum -a 256` disco contra HEAD + `git diff --quiet 005753c` | iguales; 0 | iguales; 0 | — (PASA) | — | — | — |
| R-18 | 🔒 4 I8 PASA | shell: `git ls-tree` + `case` con `set -f` | 28 / 0; plantado 0 | 28 / 0; plantado 0 | — (PASA; I1 e I3 en FALLA, anotados, esperables con T2 congelada y sin push) | — | — | intento 2 del instrumento propio |
| R-19 | alcance global ⊆ ALCANCE | `git diff --name-only 005753c..HEAD` | 5 rutas de T1 | igual | — | — | — | — |
| R-20 | árbol al cierre de FASE R | `git status --porcelain` | 4 ` M` de T2 + 2 `??` | igual | ADVIERTE (lo no commiteado es consecuencia de R-11; no se limpia) | registrada | — | — |
| R-21 | regresión | `00_build.R` + md5 | OK; `3f9a5b3b…` | OK; `3f9a5b3b…` | — | — | — | — |
| R-22 | `esperado:` = `obtenido:` | `grep -c` | +1 | ver la línea anterior | — | — | — | FASE L |
| R-23 | el instrumento del 🔒 2 dispara | celda plantada en `$S/plantado` | `FALSE` solo en `simce_comunal` | igual | — | — | — | — |

**Hallazgos por severidad:** BLOQUEA 1 (R-11, 🔒 2 en FALLA); REPARA 0; ADVIERTE 3 (R-11, diferencia de bytes por la versión de arrow; R-12, el parquet de la rama `feat/contrato-contexto` solo en `$S`; R-20, rutas de T2 sin commit). Ciclos de reparación: 0. El BLOQUEA no compromete el repositorio: T1 está verificada y ningún 🔒 sobre archivos versionados falla. La sesión no se detiene y pasa a FASE L.

**Veredicto global: `BLOQUEADO`.**

**Estado:** completada.

**Commits:** ninguno.

**Cambios sustantivos:** ninguno en el árbol. La regresión re-escribió las salidas ignoradas con el mismo contenido (mismo md5 del HTML). El caso plantado vive en `$S/plantado`.

**Alcance:** `⊆` (R-19).

**Regresión:** R-21, código 0.

**Subagentes:** sin subagentes, por contrato; sin panel adversarial por la misma razón.

**Bugs:** del instrumento propio (R-18), intento 1 a 2: el shell expandía los *globs* contra el disco. Se arregló con `set -f` y la re-verificación incluye un caso plantado. No toca el repositorio.

**Decisiones autónomas:** ninguna nueva.

**Errores propios:**
1. En R-11 agregué un esperado propio de byte-identidad sin mirar antes la versión de arrow; se registró en una línea nueva, con el diagnóstico. Costo: una medición de diagnóstico.

**Dudas:** las dos de T2, sin cambios.

**Instrumentos del scratchpad, transcritos íntegros** (`medir_simce.sh` es `medir.sh`, transcrito en el log del retiro de `unpkg.com`, con otra ruta por defecto del LOG):

`comparar_bases.R`:

````r
# FASE 0 del encargo simce2025_final (solo lectura): base 2025 final contra
# preliminar de un nivel, leídas con readxl::read_excel(..., sheet = 1).
# No imprime filas de datos: solo dimensiones, nombres de columnas, booleanos
# y los valores de las dos columnas de versión (codigo_bbdd, fecha_bbdd).
# Uso: Rscript comparar_bases.R <nivel: 4b | 2m>
nivel <- commandArgs(trailingOnly = TRUE)[1]
fin <- sprintf("20_insumos/simce/%s/simce%s2025_rbd_final.xlsx", nivel, nivel)
pre <- sprintf("20_insumos/simce/%s/simce%s2025_rbd_preliminar.xlsx", nivel, nivel)
cat("hojas final/preliminar:", length(readxl::excel_sheets(fin)), length(readxl::excel_sheets(pre)), "\n")
a <- readxl::read_excel(fin, sheet = 1)
b <- readxl::read_excel(pre, sheet = 1)
cat("dim final:", dim(a), "| dim preliminar:", dim(b), "\n")
cat("mismos nombres:", identical(names(a), names(b)), "\n")
cat("rbd únicos final/preliminar:", anyDuplicated(a$rbd) == 0, anyDuplicated(b$rbd) == 0,
    "| mismo conjunto de rbd:", setequal(a$rbd, b$rbd), "\n")
excl <- c("codigo_bbdd", "fecha_bbdd")
stopifnot(all(excl %in% names(a)), all(excl %in% names(b)))
cols <- setdiff(names(a), excl)
a2 <- a[order(a$rbd), cols]
b2 <- b[order(b$rbd), cols]
cat("columnas comparadas:", length(cols), "| identical:", identical(a2, b2), "\n")
ao <- a[order(a$rbd), ]; bo <- b[order(b$rbd), ]
difs <- names(a)[!vapply(names(a), function(k) identical(ao[[k]], bo[[k]]), logical(1))]
cat("columnas que difieren en la tabla completa:", if (length(difs)) difs else "ninguna", "\n")
cat("codigo_bbdd final/preliminar:", unique(a$codigo_bbdd), "/", unique(b$codigo_bbdd), "\n")
cat("fecha_bbdd final/preliminar:", unique(a$fecha_bbdd), "/", unique(b$fecha_bbdd), "\n")
# Calibración: +0.1 en la primera celda no NA de palu_eda_ade_lect<nivel>_rbd.
col <- paste0("palu_eda_ade_lect", nivel, "_rbd")
stopifnot(col %in% cols)
c2 <- a2
i <- which(!is.na(c2[[col]]))[1]
c2[[col]][i] <- c2[[col]][i] + 0.1
cat("calibración (+0.1 en", col, "):", identical(c2, b2), "\n")
````

`parquets_t2.R`:

````r
# 🔒 2 del encargo simce2025_final (solo lectura): cada parquet nuevo de
# 40_salidas/intermedios/ es identical() a su copia en $S, salvo
# simce_rbd.parquet, donde se compara tras quitar `preliminar` en los dos.
# Además: sum(preliminar) en el nuevo y en la copia, y una calibración.
# No imprime filas de datos: solo nombres, dimensiones, conteos y booleanos.
# Uso: Rscript parquets_t2.R <S>
S <- commandArgs(trailingOnly = TRUE)[1]
ps <- sort(basename(list.files("40_salidas/intermedios", pattern = "\\.parquet$")))
cat("parquets nuevos:", length(ps), "| copias en S:", length(list.files(S, pattern = "\\.parquet$")), "\n")
for (p in ps) {
  a <- arrow::read_parquet(file.path("40_salidas/intermedios", p))
  b <- arrow::read_parquet(file.path(S, p))
  if (p == "simce_rbd.parquet") { a$preliminar <- NULL; b$preliminar <- NULL }
  cat(p, "| dim nuevo", dim(a), "| dim copia", dim(b), "| identical:", identical(a, b), "\n")
}
n <- arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet", col_select = c("anio", "preliminar"))
v <- arrow::read_parquet(file.path(S, "simce_rbd.parquet"), col_select = c("anio", "preliminar"))
cat("sum(preliminar) nuevo:", sum(n$preliminar), "| copia en S:", sum(v$preliminar),
    "| años con preliminar en la copia:", sort(unique(v$anio[v$preliminar])), "\n")
# Calibración: una celda de palu_eda_ade alterada en una copia de simce_rbd.
a <- arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet"); a$preliminar <- NULL
b <- arrow::read_parquet(file.path(S, "simce_rbd.parquet")); b$preliminar <- NULL
stopifnot("palu_eda_ade" %in% names(a))
i <- which(!is.na(a$palu_eda_ade))[1]
a$palu_eda_ade[i] <- a$palu_eda_ade[i] + 0.1
cat("calibración (+0.1 en simce_rbd$palu_eda_ade):", identical(a, b), "\n")
````

`diag_simce_rbd.R`:

````r
# Diagnóstico de solo lectura de la FALLA del 🔒 2 en simce_rbd.parquet.
# No imprime filas de datos: nombres de columnas, tipos, conteos y booleanos.
# Uso: Rscript diag_simce_rbd.R <S>
S <- commandArgs(trailingOnly = TRUE)[1]
a <- arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet")
b <- arrow::read_parquet(file.path(S, "simce_rbd.parquet"))
cat("columnas nuevo:", names(a), "\n")
extra <- setdiff(names(b), names(a))
cat("columnas solo en la copia:", extra, "\n")
cat("tipos de las columnas extra:", vapply(b[extra], function(x) class(x)[1], character(1)), "\n")
cat("columnas solo en el nuevo:", if (length(setdiff(names(a), names(b)))) setdiff(names(a), names(b)) else "ninguna", "\n")
comunes <- setdiff(names(a), "preliminar")
cat("mismo orden de las comunes en la copia:", identical(names(b)[names(b) %in% comunes], comunes), "\n")
cat("identical en las", length(comunes), "comunes, mismo orden de filas:",
    identical(as.data.frame(a[comunes]), as.data.frame(b[comunes])), "\n")
cat("NA por columna extra en la copia:", vapply(b[extra], function(x) sum(is.na(x)), numeric(1)), "\n")
md <- function(x) names(attributes(x))
cat("atributos de tabla nuevo/copia:", md(a), "/", md(b), "\n")
````

`json_t2.R`:

````r
# T2 del encargo simce2025_final (solo lectura): JSON del HTML nuevo contra el
# de la copia en $S, con el método de descompresión del log de la adenda
# (base64_dec -> memDecompress(gzip) -> jsonlite::fromJSON). Lista los campos
# que difieren, compara sin meta.fecha_generacion ni meta.anios_preliminar, y
# calibra con una celda de datos alterada en una copia.
# No imprime filas de datos: solo nombres de campo, largos y booleanos.
# Uso: Rscript json_t2.R <html_nuevo> <html_copia>
args <- commandArgs(trailingOnly = TRUE)
payload_json <- function(ruta) {
  l <- readLines(ruta, warn = FALSE, encoding = "UTF-8")
  x <- paste(l, collapse = "\n")
  stopifnot(lengths(gregexpr("\n", x, fixed = TRUE)) == length(l) - 1L)
  m <- regmatches(x, gregexpr('atob\\("[^"]*"\\)', x))[[1]]
  stopifnot(length(m) == 1L)
  js <- rawToChar(memDecompress(jsonlite::base64_dec(substr(m, 7L, nchar(m) - 2L)), type = "gzip"))
  Encoding(js) <- "UTF-8"
  jsonlite::fromJSON(js)
}
a <- payload_json(args[1]); b <- payload_json(args[2])
cat("claves de primer nivel iguales:", identical(names(a), names(b)), "\n")
dif1 <- names(a)[!vapply(names(a), function(k) identical(a[[k]], b[[k]]), logical(1))]
cat("claves de primer nivel que difieren:", if (length(dif1)) dif1 else "ninguna", "\n")
difm <- union(names(a$meta), names(b$meta))
difm <- difm[!vapply(difm, function(k) identical(a$meta[[k]], b$meta[[k]]), logical(1))]
cat("campos de meta que difieren:", if (length(difm)) difm else "ninguno", "\n")
cat("anios_preliminar nuevo: largo", length(a$meta$anios_preliminar), "valores [", unlist(a$meta$anios_preliminar), "]",
    "| copia: largo", length(b$meta$anios_preliminar), "valores [", unlist(b$meta$anios_preliminar), "]\n")
cat("fecha_generacion nuevo/copia:", a$meta$fecha_generacion, b$meta$fecha_generacion, "\n")
for (k in c("fecha_generacion", "anios_preliminar")) { a$meta[[k]] <- NULL; b$meta[[k]] <- NULL }
cat("identical sin fecha_generacion ni anios_preliminar:", identical(a, b), "\n")
# Calibración: el vector numérico más largo (una columna de datos), una celda +1.
hojas <- list()
recorrer <- function(x, idx = integer()) {
  if (is.numeric(x)) { hojas[[length(hojas) + 1L]] <<- list(idx = idx, n = length(x)); return(invisible()) }
  if (is.list(x)) for (k in seq_along(x)) recorrer(x[[k]], c(idx, k))
}
recorrer(a)
mejor <- hojas[[which.max(vapply(hojas, `[[`, numeric(1), "n"))]]
nom <- character(); obj <- a
for (k in mejor$idx) { nm <- names(obj)[k]; nom <- c(nom, if (is.null(nm) || nm == "") as.character(k) else nm); obj <- obj[[k]] }
v <- a[[mejor$idx]]; nn <- which(!is.na(v)); p <- nn[ceiling(length(nn) / 2)]; v[p] <- v[p] + 1
c3 <- a; c3[[mejor$idx]] <- v
cat("calibración:", paste(nom, collapse = "$"), "largo", mejor$n, "| identical tras alterar una celda:", identical(c3, b), "\n")
````

`auditoria_simce.R`:

````r
# Re-derivaciones en R para FASE R del encargo simce2025_final (solo lectura
# sobre el árbol; el caso plantado se escribe solo dentro de $S).
# No imprime filas de datos: solo conteos, hashes, nombres y booleanos.
# Uso: Rscript auditoria_simce.R <id> [<S>]
args <- commandArgs(trailingOnly = TRUE)
id <- args[1]; S <- if (length(args) > 1) args[2] else NA_character_

if (id == "R-03") {
  # Otro lector (openxlsx) sobre la final en su lugar y la preliminar archivada.
  for (nv in c("4b", "2m")) {
    fin <- sprintf("20_insumos/simce/%s/simce%s2025_rbd_final.xlsx", nv, nv)
    pre <- sprintf("_archivo/20260923/20_insumos/simce/%s/simce%s2025_rbd_preliminar.xlsx", nv, nv)
    a <- openxlsx::read.xlsx(fin, sheet = 1); b <- openxlsx::read.xlsx(pre, sheet = 1)
    cols <- setdiff(names(a), c("codigo_bbdd", "fecha_bbdd"))
    a <- a[order(a$rbd), cols]; b <- b[order(b$rbd), cols]; rownames(a) <- NULL; rownames(b) <- NULL
    cat(nv, "| filas", nrow(a), nrow(b), "| columnas comparadas", length(cols),
        "| md5 de la serialización igual:", identical(as.character(openssl::md5(serialize(a, NULL))),
                                                      as.character(openssl::md5(serialize(b, NULL)))), "\n")
  }
}
if (id == "R-04") {
  fs_r <- c(Sys.glob("30_procesamiento/*.R"), Sys.glob("10_utils/*.R"), "00_build.R")
  n <- sum(vapply(fs_r, function(f) sum(grepl("codigo_bbdd|fecha_bbdd", readLines(f, warn = FALSE))), numeric(1)))
  cat("archivos leídos:", length(fs_r), "| líneas con las columnas de versión:", n, "\n")
}
if (id == "R-06") {
  cat("preliminares en 20_insumos/simce:", length(list.files("20_insumos/simce", pattern = "preliminar", recursive = TRUE)), "\n")
}
if (id == "R-11") {
  # Otra vía: md5 de la serialización de cada data frame, y md5 de archivo.
  for (p in sort(basename(list.files("40_salidas/intermedios", pattern = "\\.parquet$")))) {
    a <- as.data.frame(arrow::read_parquet(file.path("40_salidas/intermedios", p)))
    b <- as.data.frame(arrow::read_parquet(file.path(S, p)))
    if (p == "simce_rbd.parquet") { a$preliminar <- NULL; b$preliminar <- NULL }
    h <- function(x) as.character(openssl::md5(serialize(x, NULL)))
    fa <- unname(tools::md5sum(file.path("40_salidas/intermedios", p))); fb <- unname(tools::md5sum(file.path(S, p)))
    cat(p, "| serialización igual:", identical(h(a), h(b)), "| archivo byte a byte igual:", identical(fa, fb), "\n")
  }
}
if (id == "R-12") {
  sa <- names(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet", as_data_frame = FALSE)$schema)
  sb <- names(arrow::read_parquet(file.path(S, "simce_rbd.parquet"), as_data_frame = FALSE)$schema)
  cat("esquema: columnas nuevo", length(sa), "| copia", length(sb), "| solo en la copia:", setdiff(sb, sa), "\n")
  a <- as.data.frame(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet"))
  b <- as.data.frame(arrow::read_parquet(file.path(S, "simce_rbd.parquet")))
  com <- setdiff(sa, "preliminar")
  cat("all.equal en las comunes:", isTRUE(all.equal(a[com], b[com], check.attributes = FALSE)), "\n")
}
if (id == "R-13") {
  n <- arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet", col_select = c("anio", "preliminar"))
  v <- arrow::read_parquet(file.path(S, "simce_rbd.parquet"), col_select = c("anio", "preliminar"))
  cat("table nuevo:", paste(names(table(n$preliminar)), table(n$preliminar), sep = "=", collapse = " "),
      "| copia TRUE por año:", paste(names(table(v$anio[v$preliminar])), table(v$anio[v$preliminar]), sep = "=", collapse = " "), "\n")
}
if (id == "R-14") {
  # Otra vía: sustitución de bytes sobre el JSON sin parsear.
  js <- function(ruta) {
    x <- paste(readLines(ruta, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
    m <- regmatches(x, gregexpr('atob\\("[^"]*"\\)', x))[[1]]; stopifnot(length(m) == 1L)
    j <- rawToChar(memDecompress(jsonlite::base64_dec(substr(m, 7L, nchar(m) - 2L)), type = "gzip")); Encoding(j) <- "UTF-8"; j
  }
  a <- js("40_salidas/motor_comparacion.html"); b <- js(file.path(S, "motor_comparacion.html"))
  pa <- regmatches(a, gregexpr('"anios_preliminar":\\[[^]]*\\]', a))[[1]]
  pb <- regmatches(b, gregexpr('"anios_preliminar":\\[[^]]*\\]', b))[[1]]
  cat("campo en nuevo:", pa, "| en copia:", pb, "\n")
  cat("bytes idénticos tras poner en el nuevo el campo de la copia:", identical(sub(pa, pb, a, fixed = TRUE), b), "\n")
}
if (id == "R-16") {
  l <- readLines("40_salidas/motor_comparacion.html", warn = FALSE)
  cat("líneas con src=\"http:", sum(grepl('src="http', l, fixed = TRUE)), "\n")
}
if (id == "R-23") {
  # Caso plantado: copias de los parquets nuevos en $S/plantado, con una celda
  # de simce_comunal alterada. El instrumento del 🔒 2 debe dar FALSE solo ahí.
  d <- file.path(S, "plantado"); dir.create(d, showWarnings = FALSE)
  for (p in list.files("40_salidas/intermedios", pattern = "\\.parquet$")) file.copy(file.path("40_salidas/intermedios", p), d, overwrite = TRUE)
  x <- arrow::read_parquet(file.path(d, "simce_comunal.parquet"))
  num <- names(x)[vapply(x, is.numeric, logical(1))]
  col <- num[length(num)]; i <- which(!is.na(x[[col]]))[1]; x[[col]][i] <- x[[col]][i] + 1
  arrow::write_parquet(x, file.path(d, "simce_comunal.parquet"))
  cat("plantado: +1 en una celda de simce_comunal$", col, " dentro de $S/plantado\n", sep = "")
}
````

### FASE L: cierre del log

**Verificación:**

`git status --porcelain`

esperado: según el encargo, vacío o solo el LOG y el encargo. Con T2 congelada se prevén además ` M` en sus cuatro rutas; eso se anota y no se limpia
obtenido:

```text
 M 30_procesamiento/31_leer_normalizar.R
 M 30_procesamiento/33_generar_html.R
 M 30_procesamiento/33_motor_template.html
 M README.md
?? 50_documentacion/activa/encargos/encargo_simce2025_final.md
?? 50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

`git log 005753c..HEAD --oneline`

esperado: un commit: `9bad097` (T1)
obtenido: 9bad097 data(simce): bases 2025 finales (v22025) en lugar de las preliminares, archivadas fuera de git

**Estado:** completada. Estos rótulos se anexan antes de las verificaciones finales del archivo, para que cubran el log entero.

**Commits:** `docs(log): bases Simce 2025 finales`, con el LOG y el encargo. El hash va en el reporte final.

**Cambios sustantivos:** cierre C.1 a C.10 y bloque J rellenos.

**Alcance:** el commit de esta fase trae solo el LOG y el encargo.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Sin push: la autorización 5 exige árbol limpio y quedan las cuatro rutas de T2. Alternativa descartada: ninguna legal (no se usa `restore`, `reset` ni `checkout --`). Reversible.

**Errores propios:** ninguno.

**Dudas:** ninguna nueva; las consolidadas están en C.7.

Verificaciones finales del archivo:

`echo "líneas con patrón de RUT: $(grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md)"`

esperado: `líneas con patrón de RUT: 0`
obtenido: líneas con patrón de RUT: 0

`printf '%s.%s.%s-%s\n' 12 345 678 9 | grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'`

esperado: control positivo del patrón: `1` (RUT ficticio armado por partes; solo se registra el conteo)
obtenido: 1

`grep -ciE 'escuela|colegio|liceo|instituto|complejo educacional' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md`

esperado: nombres de establecimientos: `0` líneas con esas palabras (el log solo trae conteos, hashes, nombres de columnas y rutas)
obtenido: 1

`ls -l 50_documentacion/andamios/logs/20260923_simce2025_final_log.md | awk '{print $1, $5, $NF}' && wc -l 50_documentacion/andamios/logs/20260923_simce2025_final_log.md`

esperado: el archivo existe; se anotan tamaño y líneas
obtenido:

```text
-rw-r--r-- 81407 50_documentacion/andamios/logs/20260923_simce2025_final_log.md
    1376 50_documentacion/andamios/logs/20260923_simce2025_final_log.md
```

`echo "secciones FASE: $(grep -c '^### FASE' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md); J: $(grep -c '^## J' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md); esperado: $(grep -c '^esperado:' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md); obtenido: $(grep -c '^obtenido:' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md)"`

esperado: `secciones FASE: 5` (FASE 0, T1, T2 congelada, FASE R y FASE L); `J: 1`; `esperado` supera en 1 a `obtenido` (la medición en curso)
obtenido: secciones FASE: 5; J: 1; esperado: 71; obtenido: 70

`grep -niE 'escuela|colegio|liceo|instituto|complejo educacional' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md | cut -d: -f1 | while read n; do sed -n "${n}p" 50_documentacion/andamios/logs/20260923_simce2025_final_log.md | grep -c '^`grep -ciE'; done`

esperado: hipótesis: una sola línea calza (más la de este comando, escrita antes de correrlo) y es el comando de la medición anterior o este mismo; cada una da `1` (empieza con el comando `grep -ciE`) o es este comando
obtenido: [código de salida 1]

```text
1
0
```

`grep -iE 'escuela|colegio|liceo|instituto|complejo educacional' 50_documentacion/andamios/logs/20260923_simce2025_final_log.md | grep -vc 'grep -'`

esperado: `0`: fuera de las líneas de comando, ninguna línea del log nombra un establecimiento
obtenido: 0 [código de salida 1]
