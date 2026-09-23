# Encargo autónomo: traslado de la vista de trayectorias al paso 36

Formato: `encargo_autonomo_claude_code_v1.md` v1.6. Sesión 32 (2026-09-23).
Meta aprobada por el titular: la vista de trayectorias deja `andamios/` y la
regenera un generador en R desde el repositorio (paso 36), sin red, con la
batería de verificación trasladada y ampliada (D9 a D12), y sin cambiar ninguna
cifra del mockup auditado salvo empates de redondeo. Decisión del titular sobre
el ancla de 2014: **A** (el referente y la nube conservan la regla «municipales
con resultado en 2014»; B31-4 se cierra como diagnóstico errado).

## 1. Encabezado de contrato

- **Modo:** autónomo, todo en este turno. Subagentes: **no se admiten**.
- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión; subagentes 0, total Opus 0.
- **ENTORNO:** Claude Code en la estación macOS, raíz `/Users/tomgc/Projects/slep_simce_adecuado`.
  `bash` explícito; `Rscript` para todo cálculo sobre datos y para los md5 (`tools::md5sum`).
- **POSICIÓN:** todo comando antepone `cd /Users/tomgc/Projects/slep_simce_adecuado &&`.
  Primer acto de FASE 0, después de crear el log: `git fetch --quiet`.
- **LOG:** `50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md`.
- **Scratch:** `/tmp/slep_s32_traslado`, ruta literal en todo comando (las variables de shell no sobreviven entre llamadas). Nada del scratch entra al árbol.
- **ALCANCE (lista cerrada):**
  - T1: `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_generar_trayectorias.R`,
    `30_procesamiento/36_verificar_trayectorias.R`, `30_procesamiento/36_trayectorias_template.html`,
    `00_build.R`, `.gitignore`; y las salidas ignoradas de `40_salidas/`.
  - Todas: el LOG, este encargo (`50_documentacion/activa/encargos/encargo_traslado_trayectorias.md`)
    y el registro de errores del redactor (`50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`),
    que se commitean en FASE L.
- **PRUEBAS:** sin arnés (`tests/` no existe). Sustituto: `Rscript 00_build.R` con código 0 y
  `Rscript 30_procesamiento/36_verificar_trayectorias.R` con código 0.
- **PUNTO DE RETORNO:** `git rev-parse --short HEAD` en FASE 0 (una sola revisión por llamada).
- **Topes:** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.

### 1.1 Regla de detención

1. Tras el fetch, `git rev-parse --short HEAD` distinto de `git rev-parse --short origin/main` → detén la sesión.
2. `git status --porcelain` distinto del conjunto de §2 → detén la sesión.
3. md5 de uno de los cuatro archivos `36_*` distinto del de §2 → congela T1.
4. `Rscript 00_build.R` con error → tope de 3 intentos a T1; al tercero, congela T1.
5. `36_verificar_trayectorias.R` con alguna prueba en FALLA → congela T1 sin commit. No se edita la batería ni sus tolerancias para que pase.
6. Cambio necesario fuera del ALCANCE → congela T1.
7. **Cláusula residual:** cualquier estado, conteo o resultado no enumerado → congela ESTA tarea, regístrala como duda y sigue con la próxima independiente.

### 1.2 Autorizaciones (lista cerrada)

1. `cp` de `40_salidas/intermedios/*.parquet` a `/tmp/slep_s32_traslado/`, antes del build.
2. `git add` de las rutas explícitas del ALCANCE de T1 y `git commit`, uno por tarea.
3. `git push origin main` al final de FASE L, con árbol limpio y `origin/main` ancestro de `HEAD`.

Nada más. No se toca `docs/index.html`, ni `30_procesamiento/3[0-3]*`, ni nada de `andamios/`
salvo el LOG; no se borra nada; no se usa `restore`, `reset` ni `checkout --`.

## 2. Estado de partida (premisas)

- `HEAD` = `origin/main` = `760ce01` (fuente: salida de Claude Code en esta sesión tras el push de la autorización; hipótesis, se mide en FASE 0).
- Árbol: ` M` en `.gitignore` y `00_build.R`; `??` en los cuatro `30_procesamiento/36_*`, en
  `50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md` y en este encargo; nada más
  (fuente: `git status --porcelain` corrido por el redactor en la estación; hipótesis, se mide en FASE 0).
- md5 de los cuatro archivos nuevos (fuente: `md5sum` en la estación, sesión del redactor; hipótesis, se mide en FASE 0):
  - `36_funciones_trayectorias.R` `227d4ada13163ed6d4a9dd9ba327d883`
  - `36_generar_trayectorias.R` `82463db3678bd7f30c275fd0745415ab`
  - `36_trayectorias_template.html` `5c720701a74c74b88d00bcfe0792916b`
  - `36_verificar_trayectorias.R` `27871b145f52d409bbe4d6ac81845678`
- `36_trayectorias_template.html` es el mockup de `andamios/` con el literal de `var DATA=` reemplazado por
  `__DATA_TRAYECTORIAS__`: mismo prefijo y mismo sufijo byte a byte (fuente: comparación en el entorno del redactor).
- `simce_rbd.parquet` de `40_salidas/intermedios/` es del build de `main` del 2026-09-23 y trae 14 columnas, sin
  `prom`, `dif`, `difgru`, `sigdif` ni `siggru` de la rama `feat/contrato-contexto` (fuente: lectura del parquet en el
  entorno del redactor; hipótesis, se mide en FASE 0 porque `intermedios/` lo comparten todas las ramas, A31-2).
- `V8` y `openssl` cargan en esta estación (fuente: `requireNamespace` corrido por Claude Code en esta sesión: `TRUE TRUE`).
- En el entorno del redactor (R 4.3.3, dplyr 1.2.1, arrow 25.0.1) el generador escribió un HTML de md5
  `c52ad54d0d40f7b84d55bba85aa8eb14` y la batería dio 15 pruebas, 15 PASA, con 3 cifras distintas del mockup, las
  tres empates de redondeo (fuente: corrida del redactor; hipótesis para esta estación, se mide en T1).

## 3. Contexto mínimo

La vista de trayectorias se construyó en la sesión 30 como mockup autocontenido en
`50_documentacion/andamios/mockup_trayectoria_traspasos.html`; el script que armó sus datos no se versionó.
En esta sesión el redactor reconstruyó en R la capa de datos (`36_funciones_trayectorias.R`) y la comprobó
celda a celda contra el mockup. El generador (`36_generar_trayectorias.R`) inserta el JSON en la plantilla y
escribe `40_salidas/trayectorias_traspasos.html`, ignorado por git como `motor_comparacion.html`. `00_build.R`
gana el paso 36 al final. La batería `36_verificar_trayectorias.R` conserva D1 a D8 del andamio y agrega D9
(el `n` del total iguala la suma de todos los grupos del parquet), D10 (fidelidad al mockup), D11 (las cifras
de las notas coinciden con los datos) y D12 (sin red; el HTML trae el DATA del generador), con controles
positivos D9c, D10c y D12c. El andamio y el mockup quedan congelados.

## 4. Invariantes (🔒), con su comando

1. 🔒 El motor publicado no cambia: `git diff --quiet 760ce01 -- docs/ 30_procesamiento/30_construir_auxiliares.R 30_procesamiento/31_leer_normalizar.R 30_procesamiento/32_agregar_comunal.R 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html && echo intacto` → `intacto`.
2. 🔒 Los andamios congelados no cambian: `git diff --quiet 760ce01 -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html 50_documentacion/andamios/verificar_trayectorias.R && echo intacto` → `intacto`.
3. 🔒 La vista no carga nada por red: `grep -cE '(src|href)="https?:' 40_salidas/trayectorias_traspasos.html` → `0`.
4. 🔒 Ningún archivo de datos nuevo versionado: `git diff --name-only 760ce01..HEAD | grep -cE '\.(csv|xlsx|parquet|rds|json)$'` → `0`.
5. 🔒 Los intermedios del pipeline no cambian con el build: por cada parquet,
   `Rscript -e 'a <- arrow::read_parquet(Sys.getenv("A")); b <- arrow::read_parquet(Sys.getenv("B")); cat(identical(as.data.frame(a), as.data.frame(b)))'`
   con `A=/tmp/slep_s32_traslado/<archivo>` y `B=40_salidas/intermedios/<archivo>` → `TRUE` en cada parquet copiado en FASE 1.

## 5. Fases

### FASE 0: log, punto de retorno y premisas

1. `mkdir -p 50_documentacion/andamios/logs` y crea el LOG con encabezado (meta, fecha, repo, rama,
   ENTORNO, `EJECUCIÓN:` declarada y modo real, grafo, topes), el slot `## J. Juicio (lo rellena FASE L)`
   vacío y los bloques vacíos de cierre.
2. `git fetch --quiet`; `git rev-parse --short HEAD` y, en otra llamada, `git rev-parse --short origin/main`.
   esperado: `760ce01` las dos.
3. `git status --porcelain`. esperado: exactamente el conjunto de §2 (8 líneas).
4. `git stash list`. esperado: vacío.
5. md5 de los cuatro `36_*`:
   `Rscript -e 'print(tools::md5sum(Sys.glob("30_procesamiento/36_*")))'`.
   esperado: los cuatro de §2.
6. Procedencia de los intermedios (A31-2):
   `Rscript -e 'f <- "40_salidas/intermedios/simce_rbd.parquet"; print(file.info(f)$mtime); print(names(arrow::read_parquet(f)))'`.
   esperado: fecha 2026-09-23 y 14 columnas, ninguna de `prom`, `dif`, `difgru`, `sigdif`, `siggru`.
7. `mkdir -p /tmp/slep_s32_traslado`; esperado: la carpeta existe y está vacía (`ls -A /tmp/slep_s32_traslado` sin salida).
8. Anexa `### FASE 0` al LOG con cada `esperado:` y `obtenido:`.

### FASE 1 (T1): build, batería y commit del paso 36

1. Paso 0: `cp 40_salidas/intermedios/*.parquet /tmp/slep_s32_traslado/` (autorización 1).
2. `Rscript 00_build.R`. esperado: código 0 y la línea `[36] Escrito 40_salidas/trayectorias_traspasos.html`.
3. `Rscript 30_procesamiento/36_verificar_trayectorias.R`. esperado: código 0 y
   `Resultado: 15 pruebas, 15 pasan, 0 fallan`; en D10, `cifras distintas 3, de ellas sin empate 0`.
   La batería no escribe archivos: su salida va literal al LOG.
   Calibración: D9c, D10c y D12c son los casos malos plantados (deben PASAR, es decir, detectar); el caso bueno
   es el propio DATA del generador.
4. `Rscript -e 'print(tools::md5sum("40_salidas/trayectorias_traspasos.html"))'`.
   esperado: `c52ad54d0d40f7b84d55bba85aa8eb14`. Si difiere y el paso 3 pasó, no es falla: se registra como
   ADVIERTE con la versión de `dplyr` y `arrow` de la estación (`Rscript -e 'cat(as.character(packageVersion("dplyr")), as.character(packageVersion("arrow")))'`).
5. 🔒 3 y 🔒 5.
6. Cierre de fase: regresión (pasos 2 y 3 ya lo son); alcance con `git diff --name-only HEAD` más
   `git ls-files --others --exclude-standard`, que deben quedar dentro del ALCANCE; commit con rutas explícitas:
   `git add 30_procesamiento/36_funciones_trayectorias.R 30_procesamiento/36_generar_trayectorias.R 30_procesamiento/36_verificar_trayectorias.R 30_procesamiento/36_trayectorias_template.html 00_build.R .gitignore`
   y `git commit -m "feat(trayectorias): traslada la vista de trayectorias a 30_procesamiento, paso 36 (s32)"`.
7. Anexa `### FASE 1` al LOG (estado, commit, cambios, verificación con `esperado:`/`obtenido:`, alcance,
   regresión, subagentes: ninguno, bugs, decisiones, errores propios, dudas).

Grafo: T1 es la única tarea. FASE R y FASE L corren siempre, aunque T1 quede congelada.

### FASE R: auditoría propia y reparación (penúltima, obligatoria)

La reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni la meta.

1. Inventario de afirmaciones auditables desde el LOG (cada `Verificación:`, cada cifra, cada 🔒, el
   alcance global), numerado `R-01`, `R-02`, …, anexado **antes** de auditar.
2. Re-derivación independiente con un comando distinto del que produjo cada afirmación. Mínimo: el total de
   Las Condes (comuna `13114`), 4° básico Lectura 2023, en la nube, contado desde el parquet con la regla del
   ancla (`Rscript` propio, sin cargar `36_funciones_trayectorias.R`). esperado: `271`, igual al `n` de la fila
   `["13114",2023,"4b_lect","T",...]` del DATA del HTML.
3. Los cinco 🔒 con su comando, PASA/FALLA y salida literal.
4. Alcance global: `git diff --name-only <hash_inicial>..HEAD` ⊆ unión de los ALCANCE más el LOG; y
   `git status --porcelain` (lo no commiteado es hallazgo, no se limpia).
5. Regresión completa: pasos 2 y 3 de FASE 1 sobre el estado final.
6. Control positivo de la auditoría: compara tu recuento del paso 2 contra `270` (un evaluado menos) con la
   misma comparación que usaste contra el HTML y comprueba que la marca como distinta.
7. Veredicto por hallazgo: **BLOQUEA** (🔒 en FALLA, alcance violado, datos alterados: no se repara, se
   congela y se registra), **REPARA** (defecto propio dentro del ALCANCE, con verificación calibrada),
   **ADVIERTE** (sin efecto sobre la meta, o no medible aquí). Sin hallazgos: «0 hallazgos» junto con el
   control del paso 6, o no se declara.
8. Ciclo de reparación, máximo 2: causa raíz; fix dentro del ALCANCE; re-verificación con el mismo chequeo y
   con uno distinto; regresión; commit `fix(auditoria): R-NN <hallazgo>`; fila en la tabla. Se repiten los
   pasos 2 a 5 sobre lo tocado. Lo que sobrevive al segundo ciclo se congela como pendiente.
9. Prohibido: ajustar criterio, tolerancia o esperado; ampliar ALCANCE; tocar un 🔒; editar evidencia ya
   escrita; reparar un BLOQUEA.
10. Salida: tabla `id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción |
    commit | re-verificación` y veredicto global (`APROBADO`, `APROBADO CON ADVERTENCIAS`, `OBSERVADO`,
    `BLOQUEADO`), anexados como `### FASE R: auditoría y reparación`.

### FASE L: cierre del log (última, obligatoria)

1. `git status --porcelain`. esperado: solo el LOG, este encargo y el registro de errores del redactor.
2. Cierre del log: resumen, inventario de commits desde `git log <hash_inicial>..HEAD --oneline`, tabla de
   auditoría, invariantes, decisiones del titular (ancla A; autorización del parquet en `760ce01`), estado de
   cifras, dudas y pendientes, errores propios, notas para el revisor, estado de cierre.
3. Bloque J relleno copiando del detalle (13 campos, una línea cada uno).
4. Privacidad: `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md`
   → vacío; el log no contiene filas de datos ni nombres de personas.
5. Verificación del archivo: `ls -l` y `wc -l` del LOG; `grep -c '^### FASE'` igual a las fases ejecutadas;
   `grep -c '^esperado:'` igual a `grep -c '^obtenido:'`; `grep -c '^## J'` = 1.
6. `git add 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md 50_documentacion/activa/encargos/encargo_traslado_trayectorias.md 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`
   y `git commit -m "docs(log): traslado de la vista de trayectorias (s32)"`. Luego `git push origin main`
   (autorización 3).
7. Estado de cierre con el hash del commit `docs(log)` (`git log -1 --format=%h`) y
   `git ls-remote origin refs/heads/main`.

## 6. Reporte final

Primera línea: salida literal de `ls -l` y `wc -l` del LOG y el hash del commit `docs(log)`. Después, el
bloque J tal cual. Después, hashes, verificaciones con evidencia, pendientes y lo que falló o sorprendió
(si nada, decirlo).
