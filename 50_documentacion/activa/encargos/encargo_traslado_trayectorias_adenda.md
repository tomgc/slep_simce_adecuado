# Adenda al encargo del traslado: redondeo entero y descongelamiento de T1

Formato: `encargo_autonomo_claude_code_v1.md` v1.6. Sesión 32 (2026-09-23). Complementa
`50_documentacion/activa/encargos/encargo_traslado_trayectorias.md` (en adelante, «el encargo»), que se lee
entero antes de empezar. Donde esta adenda no dice nada, rige el encargo.

**Decisión del titular (Duda 1 del log `20260923_traslado_trayectorias_log.md`, R-14): opción (b).** Los
porcentajes se redondean en aritmética entera, con los empates hacia arriba. El redactor ya reemplazó
`36_funciones_trayectorias.R` y `36_verificar_trayectorias.R`. La batería pasa a 17 pruebas, con D13 (el DATA no
depende del orden de las filas) y su control D13c. En D10 el criterio deja de ser un conteo: se exige
`de ellas sin empate 0`, cualquiera sea el número de cifras distintas (ERR-32-03).

Meta: descongelar T1 y completarla con estos archivos (build, batería, commit de las seis rutas, push).

## 1. Cambios al contrato del encargo

- **EJECUCIÓN:** esfuerzo `xhigh`; orquestador el modelo de la sesión; subagentes 0, total Opus 0.
  Si la sesión está en `ultracode`, igual se ejecuta sin subagentes (regla 1 de §2.12).
- **LOG:** `50_documentacion/andamios/logs/20260923_traslado_trayectorias_adenda_log.md` (nuevo; el log del
  encargo ya está commiteado en `801ce5e` y no se toca).
- **ALCANCE:** el de T1 en el encargo, más esta adenda, su LOG y
  `50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md` (modificado por el redactor), que se
  commitean en FASE L.
- **PUNTO DE RETORNO:** `801ce5e` (hipótesis, se mide en FASE 0). Los 🔒 del encargo que citan `760ce01` se
  miden igual contra `760ce01`.
- **Regla de detención, cambio en la regla 5 del encargo:** cualquier prueba en FALLA congela T1. En D10, «cifras
  distintas N» con cualquier N no es causa de detención; «de ellas sin empate» distinto de 0 sí lo es.
- **Autorizaciones:** las del encargo, con el push de la autorización 3 incluyendo `801ce5e`. Nada más.
- Topes, POSICIÓN, scratch (`/tmp/slep_s32_traslado`), PRUEBAS e invariantes: los del encargo, sin cambio.

## 2. Estado de partida (premisas)

- Local `HEAD` = `801ce5e`, `origin/main` = `760ce01` (fuente: `git log` y `git rev-parse` corridos por el redactor
  en la estación; hipótesis, se mide en FASE 0).
- `git status --porcelain`, 8 líneas: ` M .gitignore`, ` M 00_build.R`,
  ` M 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`, `??` en los cuatro
  `30_procesamiento/36_*` y en esta adenda (fuente: `git status --porcelain` del redactor, antes de depositar la
  adenda; hipótesis, se mide en FASE 0).
- md5 (fuente: `md5sum` en la estación; hipótesis, se mide en FASE 0):
  - `36_funciones_trayectorias.R` `642d0bb9645364ee90f64cba4d1e4581`
  - `36_generar_trayectorias.R` `82463db3678bd7f30c275fd0745415ab`
  - `36_trayectorias_template.html` `5c720701a74c74b88d00bcfe0792916b`
  - `36_verificar_trayectorias.R` `220daaf06e9731ebfbe642620ebf1a12`
- En el entorno del redactor (x86_64), el HTML generado tiene md5 `8b0a586bf9577e5164d7f10e2fadd835` y su DATA
  canónico (el JSON reserializado con `JSON.stringify(JSON.parse(...))` en V8) tiene md5
  `661da614aacc67b2d63757534f5f9f55` (fuente: corrida del redactor; hipótesis para esta estación).
- Tres verificadores independientes no pudieron refutar el redondeo: las 6.036 cifras de la nube (grupo T, sin
  «todo») recalculadas con fracciones exactas coinciden; dos barajados y la inversión dan DATA idéntico; las 316
  cifras distintas del mockup difieren en exactamente 0,1 hacia arriba, y todas las que se recalcularon son empates
  exactos (fuente: workflow del redactor `wf_13100bb7-0b7`).

## 3. Fases

### FASE 0

1. Crea el LOG con encabezado, slot `## J. Juicio (lo rellena FASE L)` y bloques de cierre vacíos.
2. `git fetch --quiet`; `git rev-parse --short HEAD` → esperado `801ce5e`; `git rev-parse --short origin/main`
   (otra llamada) → esperado `760ce01`.
3. `git status --porcelain` → esperado: las 8 líneas de §2. `git stash list` → vacío.
4. `Rscript -e 'print(tools::md5sum(Sys.glob("30_procesamiento/36_*")))'` → esperado: los cuatro de §2.
5. `mkdir -p /tmp/slep_s32_traslado` y `ls -A /tmp/slep_s32_traslado`: si trae archivos de la corrida anterior, se
   dejan y se anota; no se borran.
6. Anexa `### FASE 0` al LOG con `esperado:`/`obtenido:`.

### FASE 1 (T1, descongelada)

Los pasos 1 a 7 de la FASE 1 del encargo, con estos cambios:

- Paso 3: esperado `Resultado: 17 pruebas, 17 pasan, 0 fallan`, código 0; en D10, `de ellas sin empate 0` (el
  número de cifras distintas se registra, no se juzga); D13 y D13c en PASA.
- Paso 4: esperado del md5 del HTML `8b0a586bf9577e5164d7f10e2fadd835`. Mide además el DATA canónico:
  `Rscript -e 'h <- paste(readLines("40_salidas/trayectorias_traspasos.html", encoding="UTF-8", warn=FALSE), collapse="\n"); i <- regexpr("var DATA=", h, fixed=TRUE)+9; r <- substr(h, i, nchar(h)); d <- substr(r, 1, regexpr(";\n</script>", r, fixed=TRUE)-1); ctx <- V8::v8(); ctx$assign("d", d); cat(as.character(openssl::md5(ctx$eval("JSON.stringify(JSON.parse(d))"))))'`
  → esperado `661da614aacc67b2d63757534f5f9f55`. Si el DATA canónico coincide y el md5 del HTML no, es ADVIERTE
  (formato de serialización de otra versión de `jsonlite`). Si el DATA canónico difiere, congela T1: el redondeo
  entero promete el mismo resultado en toda estación.
- Paso 6: mismas seis rutas y mismo mensaje de commit del encargo.

### FASE R y FASE L

Las del encargo (§5), íntegras, sobre el LOG de esta adenda. En FASE R, el mínimo del paso 2 sigue siendo Las Condes
(comuna `13114`), 4° básico Lectura 2023, nube, `271`. En FASE L, el `git add` del paso 6 lleva el LOG de esta
adenda, esta adenda y `50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`, con el mensaje
`docs(log): adenda del traslado, redondeo entero (s32)`; después, `git push origin main` (autorización 3).

## 4. Reporte final

Como en §6 del encargo: primera línea con `ls -l` y `wc -l` del LOG y el hash del commit `docs(log)`, después el
bloque J tal cual.
