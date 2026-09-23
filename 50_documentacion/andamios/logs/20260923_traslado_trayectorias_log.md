# Log: traslado de la vista de trayectorias al paso 36

- **Meta:** la vista de trayectorias deja `andamios/` y la regenera un generador en R desde el repositorio (paso 36), sin red, con la batería de verificación trasladada y ampliada (D9 a D12), y sin cambiar ninguna cifra del mockup auditado salvo empates de redondeo.
- **Decisión del titular sobre el ancla de 2014:** **A** (el referente y la nube conservan la regla «municipales con resultado en 2014»; B31-4 se cierra como diagnóstico errado).
- **Fecha:** 2026-09-23 (sesión 32).
- **Encargo:** `50_documentacion/activa/encargos/encargo_traslado_trayectorias.md` (formato `encargo_autonomo_claude_code_v1.md` v1.6).
- **Repo y rama:** `slep_simce_adecuado`, `main` (`git rev-parse --abbrev-ref HEAD` → `main`).
- **PUNTO DE RETORNO:** `760ce01` (`git rev-parse --short HEAD`, leído al abrir FASE 0; se re-mide tras el `git fetch`).
- **ENTORNO:** Claude Code en la estación macOS del titular (`MacBook-Pro-de-Tomas.local`, macOS 27.0), raíz `/Users/tomgc/Projects/slep_simce_adecuado`; `bash` explícito para shell; `Rscript` (R 4.5.2, renv activado por `.Rprofile`) para todo cálculo sobre datos y para los md5 (`tools::md5sum`). Scratch del encargo: `/tmp/slep_s32_traslado` (fuera del árbol).
- **EJECUCIÓN (declarada):** esfuerzo `xhigh`; orquestador el modelo de la sesión; subagentes 0, total Opus 0.
- **Modo real de la sesión:** `ultracode` (xhigh + orquestación dinámica), orquestador Opus 5.5 (`claude-opus-5-5`); subagentes usados: 0, por contrato (§1 del encargo: «Subagentes: no se admiten»). Tampoco se usa la herramienta de workflows.
- **Grafo:** T1 es la única tarea. FASE R y FASE L corren siempre, aunque T1 quede congelada.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug (al tercero, T1 se congela con la evidencia de los tres); 2 ciclos de reparación en FASE R; 1 reintento por comando con falla transitoria.
- **Método de registro:** cada verificación se anexa con un ayudante de shell que vive en el scratchpad de la sesión (fuera del árbol; transcrito íntegro en FASE R): escribe el comando y la línea `esperado:` antes de correrlo, y la línea `obtenido:` con la salida literal (stdout y stderr) después; si el código de salida no es 0, lo anota entre corchetes. Las salidas de varias líneas van en un bloque `text` bajo `obtenido:`. Dentro de cada sección por fase, la verificación va primero porque se escribe mientras se trabaja; los demás rótulos se anexan al cerrar la fase.

---

## J. Juicio (lo rellena FASE L)
- Meta y resultado: vista regenerada desde el repositorio (paso 36), sin red, batería D1 a D12 y cifras del mockup intactas salvo empates → parcial. El generador y la batería funcionan (build con código 0, 15 de 15 PASA, 🔒 5 de 5) y los datos cumplen la meta (13 cifras distintas del mockup, todas empates exactos). Pero T1 quedó congelada sin commit y nada se publicó.
- Estado por tarea: T1 congelada (cláusula residual: D10 dio `cifras distintas 13, de ellas sin empate 0` con esperado 3; sin commit).
- Commits: 1, solo el `docs(log)` (`git log 760ce01..HEAD --oneline` vacío antes de él; el hash va en el reporte final), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): BLOQUEADO; hallazgos B/R/A = 1/0/2; reparados 0; abierto 1 (R-14, BLOQUEA de gobernanza; no se repara).
- Invariantes: 5/5 PASA.
- Cifras críticas: conteos `n` y `e` idénticos al mockup en las 34420 filas; 13 porcentajes distintos, todos empates exactos en aritmética entera; Las Condes 4° básico Lectura 2023 en la nube, 271 = 271; salida md5 `a2658292e115b9f411f1340212e390de` (redactor `c52ad54d0d40f7b84d55bba85aa8eb14`).
- Decisiones autónomas de mayor riesgo: congelar T1 sin commit (descartada: commitear declarando que la meta se cumple); R-14 como BLOQUEA de gobernanza (descartada: ADVIERTE); sin push (la autorización 3 exige árbol limpio).
- Desviaciones respecto del encargo: el LOG se creó en el scratchpad y se copió a su ruta tras medir el árbol; chequeos propios (plantilla contra mockup, V8/openssl, vías de red en CSS/JS); diagnóstico del 13 con instrumentos propios tras congelar; sin push.
- Dudas abiertas: 2; D1 ¿D10 con 13 cifras distintas, todas empates, en esta estación: (a) se acepta y T1 se commitea tal cual; (b) empates decididos en aritmética entera, con un esperado nuevo; (c) otra? · D2 ¿se crea `CLAUDE.md` en un encargo propio (sí/no)?
- Errores propios: 5 registrados (una medición sin pre-registro, repetida; un tramo inerte en un comando de calibración; una fuente no ejecutable pasada al ayudante en R-02, con el cierre de bloque borrado y restituido; un patrón `grep` impreciso en FASE L, re-medido por bloque; un esperado autorreferente en el chequeo de nombres); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: abrir `40_salidas/trayectorias_traspasos.html` con la red desactivada y recorrer la vista (este encargo no prueba el render); decidir D1 con R-15 y R-16 a la vista.
- No publicado / queda al usuario: el commit de T1 y el push, a la espera de D1; el `docs(log)` queda local, sin push.
- Ejecución: modo de sesión ultracode; subagentes 0, por contrato; sin workflows.

---

## Cierre (lo rellena FASE L)

### C.1 Resumen de la sesión

Una tarea (T1) más las fases 0, R y L; cuatro secciones por fase. FASE 0 confirmó todas las premisas de §2: HEAD = origin/main = `760ce01`, árbol de 8 líneas, los cuatro md5, `simce_rbd.parquet` de 14 columnas, `V8` y `openssl`. Confirmó también, como chequeo propio, que la plantilla es el mockup menos su literal de datos. En T1, el build corrió al primer intento con código 0 y escribió `40_salidas/trayectorias_traspasos.html`, sin cargas por red. La batería dio 15 de 15 PASA con código 0, pero D10 contó 13 cifras distintas del mockup donde el encargo esperaba 3. Las 13 son empates exactos en aritmética entera. Ni el generador ni el mockup deciden esos empates por el valor exacto, sino por el ruido de coma flotante: el conteo depende de la plataforma (`aarch64`, sin precisión extendida) y del orden de suma. T1 se congeló sin commit por la cláusula residual. FASE R: 30 afirmaciones re-derivadas por otra vía, cinco 🔒 en PASA con control plantado, veredicto `BLOQUEADO` solo por gobernanza (R-14). Sin push.

### C.2 Inventario de commits

Derivado de `git log 760ce01..HEAD --oneline` (FASE L, antes del commit del LOG): vacío.

- `docs(log)`: traslado de la vista de trayectorias (s32) · FASE L (el hash va en el reporte final; el archivo no puede contener su propio hash).

Ningún `fix(auditoria)`. T1 no tiene commit (congelada).

### C.3 Tabla de auditoría (FASE R)

La tabla completa está en la sección `FASE R: auditoría y reparación` (R-01 a R-30). Veredicto global `BLOQUEADO`. Hallazgos: BLOQUEA 1 (R-14, el esperado de D10 fija un conteo que depende del entorno); REPARA 0; ADVIERTE 2 (R-18, md5 de la salida distinto del del redactor; R-27, rutas de T1 sin commit). Reparados 0; abierto el BLOQUEA. Control del paso 6: el recuento de Las Condes contra `270` se marca `DISTINTOS` (R-30 a); los controles plantados de los 🔒 disparan (R-30 b a e).

### C.4 Verificación de invariantes

- 🔒 1 el motor publicado no cambia: **PASA** (`intacto`; 0 líneas pendientes; `docs/index.html` md5 `5fcb5d9a4baa052f28010d31923c1855` en disco y en el blob de `760ce01`).
- 🔒 2 los andamios congelados no cambian: **PASA** (`intacto`; mockup `2dff9ebc8704dc9eb51726d2a4ba0491` y `verificar_trayectorias.R` `00c24ab566e32edf723e2bb9f25b2768`, disco = blob).
- 🔒 3 la vista no carga nada por red: **PASA** (`0` líneas y `0` apariciones; 0 vías de carga en CSS o JS; el único host mencionado es `www.w3.org`, espacio de nombres SVG).
- 🔒 4 ningún archivo de datos nuevo versionado: **PASA** (0 commiteados, 0 pendientes; el patrón dispara sobre un `.parquet` plantado).
- 🔒 5 los intermedios no cambian con el build: **PASA** (seis `TRUE` en FASE 1 y en FASE R; además, seis pares de bytes iguales tras dos builds).

### C.5 Decisiones del titular registradas

- Ancla de 2014: **A**. El referente y la nube conservan la regla «municipales con resultado en 2014», y B31-4 se cierra como diagnóstico errado. Lo tomado en esta sesión es coherente con esa regla: la re-derivación de R-13 y R-20 la aplica en R base y reproduce los `n` del HTML.
- Autorización del parquet de la rama `feat/contrato-contexto` en `760ce01` («docs(datos): autoriza contexto_simce.parquet de la rama feat/contrato-contexto (s32)»). Es el punto de retorno; esta sesión no la ejerce ni la toca.

### C.6 Estado de cifras

- `40_salidas/trayectorias_traspasos.html`: 1662242 bytes, md5 `a2658292e115b9f411f1340212e390de`, reproducido byte a byte por la regresión. El del redactor era `c52ad54d0d40f7b84d55bba85aa8eb14`.
- DATA: 9 años, 37 entidades (36 Servicios Locales y el referente), 12916 filas en `datos`, 21504 en `nube`, 180 comunas. Referente de 1.333 establecimientos.
- Contra el mockup: `anios`, `meta`, `nac` y `comunas` idénticos; 0 filas sin pareja; 0 conteos distintos; 13 porcentajes distintos (4 en `datos`, 9 en `nube`), todos a un décimo y todos empates exactos.
- Empates: 655 empates exactos en 68840 celdas `ade`/`ins`. Fuera de ellos, generador y mockup coinciden con el valor exacto en las 68185 celdas; dentro, el generador sigue el redondeo exacto al par en 543 y el mockup en 544.
- Celda mínima del encargo: Las Condes (`13114`), 4° básico Lectura 2023, nube, total: 271 desde el parquet y 271 en el HTML.
- Intermedios: los seis parquet iguales en contenido y en bytes antes y después de los dos builds.

### C.7 Dudas y pendientes consolidados

1. **D1 (FASE 1, R-14, BLOQUEA).** Contexto: D10 dio `cifras distintas 13, de ellas sin empate 0`. El encargo esperaba 3, la corrida del redactor (R 4.3.3, dplyr 1.2.1, arrow 25.0.1). Esta estación corre R 4.5.2, dplyr 1.2.0 y arrow 24.0.0 en `aarch64`, con `sizeof.longdouble` 8. Las 13 son empates exactos en aritmética entera; fuera de los empates, todo coincide con el valor exacto. Los dos lados deciden los empates por ruido de coma flotante, e invertir el orden de las filas mueve 14 cifras en esta misma estación. Pregunta cerrada: ¿se acepta el 13 en esta estación? Opciones: (a) sí, y T1 se commitea tal cual, con push; (b) no: el generador decide los empates en aritmética entera (resultado independiente del entorno; unas 111 cifras distintas del mockup, todas empates) y D10 recibe un esperado nuevo; (c) otra. Bloquea el commit de T1 y el push.
2. **D2 (FASE 0).** Contexto: el proyecto no tiene `CLAUDE.md` en la raíz; las instrucciones globales del titular lo piden, y el ALCANCE cerrado no lo admite. Pregunta cerrada: ¿se crea en un encargo propio (sí/no)? No bloquea.
3. **Pendiente derivado:** con D1 resuelta, falta commitear las seis rutas de T1 (sin cambios del ejecutor; md5 de §2) y hacer el push del `docs(log)` y de T1.
4. **Pendiente menor, dentro del ALCANCE de T1, no tocado:** el encabezado de `36_verificar_trayectorias.R` (línea 13) dice «se agregan D9 a D13»; la batería tiene D9 a D12 más los controles D9c, D10c y D12c, como dice el encargo. Corregirlo cambia el md5 del archivo, así que conviene hacerlo junto con la resolución de D1.
5. **Pendiente previo, sin cambios:** renv avisa `out-of-sync` en cada `Rscript`; `V8` y `openssl` siguen fuera de `renv.lock` (Duda 4 de la sesión 31).

### C.8 Errores propios consolidados

1. FASE 1: la medición de tipos y plataforma se corrió primero una vez fuera del ayudante, sin pre-registro; se repitió con esperado. Costo: una medición.
2. FASE 0: el comando de la primera calibración de la plantilla trae un tramo inerte (`tail -c 20000 … | head -c 1 >/dev/null`); no altera la medición. Costo: ninguno.
3. FASE R: en R-02 se pasó al ayudante una fuente no ejecutable. Para quitar su salida, un `sed '$d'` borró el cierre del bloque `text` y se anexó a mano una línea `obtenido:`. Se restituyó el cierre y la línea se reemplazó por un par completo con nota. Costo: una edición declarada del log (C.10).
4. FASE L: la medición complementaria de grupos faltantes usó un patrón `grep` que no mide lo que declaraba su esperado. Calzaba también filas de `nube` con `ade` entero, y dio 14059 en vez de 12916 y dos `,null,` sin ubicar. Se re-midió por bloque: los dos `null` son del código de la plantilla, el literal DATA no trae ninguno y ninguna fila tiene grupo nulo. Costo: una medición repetida.
5. FASE L: el chequeo propio de nombres de personas tenía un esperado mal derivado (`0`). El ayudante escribe el comando en el log antes de correrlo, y el comando trae el patrón literal (`cifuentes`), así que siempre se calza a sí mismo. Se ubicaron las líneas: aparte de las líneas de comando, solo calza el nombre de la estación del encabezado (C.9). Costo: una medición más.

### C.9 Notas para el revisor

- El conteo de D10 no es una propiedad del generador sino del entorno: 655 celdas son empates exactos, y `redondear_pct` («redondea al par más cercano») solo aplica el redondeo al par cuando el flotante cae exactamente en la mitad. Si el ruido lo corre un ulp, decide el lado del ruido. Cualquier esperado que fije el número de diferencias con el mockup fallará en otra plataforma. Lo que sí es invariante: `de ellas sin empate 0`.
- La hipótesis de precisión extendida (x86_64 contra `aarch64`) explica el 3 contra el 13, pero no se puede medir aquí: esta estación no tiene `long double` de 80 bits.
- La batería mide el DATA que construye el generador en memoria (D10) y el HTML escrito (D12). FASE R cotejó además el HTML escrito contra el mockup (R-14) y dio el mismo reparto (4 + 9).
- La base de D1 a D8 excluye filas sin `cod_grupo` y `base_valida` no; la diferencia no tiene efecto hoy, porque ninguna fila válida carece de grupo (0 de 142353) y el DATA no trae ningún `null` (medición complementaria de FASE L).
- `40_salidas/trayectorias_traspasos.html` queda regenerado en la estación, ignorado por git, con la vista lista para el gate visual sin red.
- El build completo tardó 5 segundos las dos veces.
- Privacidad: el grep de RUT da vacío. El chequeo propio de nombres solo calza, fuera de las líneas de comando que traen el patrón, el nombre de la estación (`MacBook-Pro-de-Tomas.local`) en el encabezado ENTORNO. Ese nombre ya está en la historia del repositorio (commit `d510754`) y en el log versionado de la sesión 31. No se editó.

### C.10 Estado de cierre

- Commiteado: solo el `docs(log)`, con el LOG, el encargo y el registro de errores del redactor (hash en el reporte final).
- NO se publica: ningún push. La autorización 3 exige árbol limpio, y quedan sin commit las seis rutas de T1 congelada (` M` en `.gitignore` y `00_build.R`; `??` en los cuatro `36_*`). `docs/` no se tocó.
- Queda al usuario: responder D1 (y D2); commitear T1; el push; el gate visual sin red de la vista.
- Ediciones sobre texto ya escrito: en FASE R, R-02, se restituyó el cierre del bloque `text` que un `sed '$d'` había borrado, y una línea `obtenido:` escrita a mano se reemplazó por un par `esperado:`/`obtenido:` completo con una nota que cita la medición. El conteo de rótulos quedó balanceado (R-29). Fuera de eso, solo se rellenaron J y C.1 a C.10.

---

## Registro por fase

### FASE 0: log, punto de retorno y premisas

**Verificación:**

`git fetch --quiet`

esperado: sin salida, código 0
obtenido: (sin salida)

`git rev-parse --short HEAD`

esperado: `760ce01`
obtenido: 760ce01

`git rev-parse --short origin/main`

esperado: `760ce01`
obtenido: 760ce01

`git status --porcelain`

esperado: exactamente el conjunto de §2 (8 líneas): ` M` en `.gitignore` y `00_build.R`; `??` en los cuatro `30_procesamiento/36_*`, en `50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md` y en el encargo; nada más (el LOG aún vive en el scratchpad de la sesión y no puede aparecer)
obtenido:

```text
 M .gitignore
 M 00_build.R
?? 30_procesamiento/36_funciones_trayectorias.R
?? 30_procesamiento/36_generar_trayectorias.R
?? 30_procesamiento/36_trayectorias_template.html
?? 30_procesamiento/36_verificar_trayectorias.R
?? 50_documentacion/activa/encargos/encargo_traslado_trayectorias.md
?? 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md
```

`git status --porcelain | wc -l | tr -d " "`

esperado: `8`
obtenido: 8

`git stash list`

esperado: vacío
obtenido: (sin salida)

`Rscript -e 'print(tools::md5sum(Sys.glob("30_procesamiento/36_*")))'`

esperado: los cuatro de §2: `36_funciones_trayectorias.R` `227d4ada13163ed6d4a9dd9ba327d883`; `36_generar_trayectorias.R` `82463db3678bd7f30c275fd0745415ab`; `36_trayectorias_template.html` `5c720701a74c74b88d00bcfe0792916b`; `36_verificar_trayectorias.R` `27871b145f52d409bbe4d6ac81845678`
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
  30_procesamiento/36_funciones_trayectorias.R 
            "227d4ada13163ed6d4a9dd9ba327d883" 
    30_procesamiento/36_generar_trayectorias.R 
            "82463db3678bd7f30c275fd0745415ab" 
30_procesamiento/36_trayectorias_template.html 
            "5c720701a74c74b88d00bcfe0792916b" 
  30_procesamiento/36_verificar_trayectorias.R 
            "27871b145f52d409bbe4d6ac81845678" 
```

`Rscript -e 'f <- "40_salidas/intermedios/simce_rbd.parquet"; print(file.info(f)$mtime); print(names(arrow::read_parquet(f)))'`

esperado: fecha 2026-09-23 y 14 columnas, ninguna de `prom`, `dif`, `difgru`, `sigdif`, `siggru`
obtenido:

```text
- The project is out-of-sync -- use `renv::status()` for details.
[1] "2026-09-23 16:25:15 -03"
 [1] "anio"         "nivel"        "prueba"       "rbd"          "cod_com_rbd" 
 [6] "nom_com_rbd"  "cod_grupo"    "cod_depe2"    "nalu"         "palu_eda_ade"
[11] "palu_eda_ele" "palu_eda_ins" "marca"        "preliminar"  
```

`Rscript -e 'n <- names(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet")); cat(length(n), length(intersect(n, c("prom","dif","difgru","sigdif","siggru"))), "\n")' 2>&1 | grep -v out-of-sync`

esperado: conteo exacto de la misma premisa: `14 0`
obtenido: 14 0 

`ls -A 40_salidas/intermedios/`

esperado: no enumerado en el encargo; se anota el inventario de intermedios que copiará la autorización 1 (el patrón `*.parquet`)
obtenido:

```text
.gitkeep
comunas_chile.parquet
establecimientos_chile.parquet
simce_comunal.parquet
simce_rbd.parquet
slep_cc_establecimientos.parquet
sleps_chile.parquet
```

`mkdir -p /tmp/slep_s32_traslado && ls -A /tmp/slep_s32_traslado`

esperado: la carpeta existe y está vacía: sin salida, código 0
obtenido: (sin salida)

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: las dos rutas ` M` y las seis `??` de §2 más el LOG, ya en su ruta; nada más
obtenido:

```text
.gitignore
00_build.R
30_procesamiento/36_funciones_trayectorias.R
30_procesamiento/36_generar_trayectorias.R
30_procesamiento/36_trayectorias_template.html
30_procesamiento/36_verificar_trayectorias.R
50_documentacion/activa/encargos/encargo_traslado_trayectorias.md
50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md
50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
```
Chequeos propios de premisas de §2 no enumeradas en los pasos de FASE 0 (plantilla = mockup menos el literal; V8 y openssl cargan):

`Rscript /tmp/slep_s32_traslado/plantilla_vs_mockup.R 30_procesamiento/36_trayectorias_template.html 50_documentacion/andamios/mockup_trayectoria_traspasos.html 2>&1 | grep -v out-of-sync`

esperado: una aparición del marcador y una de `var DATA=`; prefijo igual `TRUE`; sufijo igual `TRUE`; la plantilla mide prefijo + marcador + sufijo `TRUE`
obtenido:

```text
apariciones del marcador en plantilla: 1 
apariciones de 'var DATA=' en mockup: 1 
bytes plantilla/mockup: 209552 1681142 
prefijo igual ( 179443 bytes): TRUE 
sufijo igual ( 30088 bytes): TRUE 
largo del literal DATA del mockup: 1471611 bytes
bytes plantilla = prefijo + marcador + sufijo: TRUE 
```

`sed "1s/html/htmX/" 30_procesamiento/36_trayectorias_template.html > /tmp/slep_s32_traslado/plantilla_plantada.html && tail -c 20000 30_procesamiento/36_trayectorias_template.html | head -c 1 >/dev/null && Rscript /tmp/slep_s32_traslado/plantilla_vs_mockup.R /tmp/slep_s32_traslado/plantilla_plantada.html 50_documentacion/andamios/mockup_trayectoria_traspasos.html 2>&1 | grep -v out-of-sync`

esperado: calibración, caso malo: una copia de la plantilla con un byte cambiado en la línea 1 da prefijo igual `FALSE` (sufijo `TRUE`)
obtenido:

```text
apariciones del marcador en plantilla: 1 
apariciones de 'var DATA=' en mockup: 1 
bytes plantilla/mockup: 209552 1681142 
prefijo igual ( 179443 bytes): FALSE 
sufijo igual ( 30088 bytes): TRUE 
largo del literal DATA del mockup: 1471611 bytes
bytes plantilla = prefijo + marcador + sufijo: TRUE 
```

`sed "\$s/html/htmX/" 30_procesamiento/36_trayectorias_template.html > /tmp/slep_s32_traslado/plantilla_plantada2.html && tail -n 1 /tmp/slep_s32_traslado/plantilla_plantada2.html && Rscript /tmp/slep_s32_traslado/plantilla_vs_mockup.R /tmp/slep_s32_traslado/plantilla_plantada2.html 50_documentacion/andamios/mockup_trayectoria_traspasos.html 2>&1 | grep -v out-of-sync | grep "igual"`

esperado: calibración del sufijo, caso malo: la última línea de la copia cambia (`</htmX>`) y el instrumento da prefijo igual `TRUE`, sufijo igual `FALSE`
obtenido:

```text
</htmX>
prefijo igual ( 179443 bytes): TRUE 
sufijo igual ( 30088 bytes): FALSE 
```

`Rscript -e 'cat(sapply(c("V8","openssl"), requireNamespace, quietly=TRUE), "\n")' 2>&1 | grep -v out-of-sync`

esperado: `TRUE TRUE` (premisa de §2)
obtenido: TRUE TRUE 

**Estado:** completada. Ninguna regla de detención disparada: `HEAD` = `origin/main` = `760ce01` tras `git fetch` (regla 1 no dispara); `git status --porcelain` igual al conjunto de §2, 8 líneas (regla 2 no dispara); los cuatro md5 de `36_*` iguales a los de §2 (regla 3 no dispara).

**Commits:** ninguno (FASE 0 no commitea).

**Cambios sustantivos:** se creó este log. Premisas de §2 confirmadas una a una: HEAD y origin/main, árbol de 8 líneas, stash vacío, los cuatro md5, `simce_rbd.parquet` del 2026-09-23 16:25:15 con 14 columnas y ninguna de las cinco de `feat/contrato-contexto`, `V8` y `openssl` cargan. Chequeo propio: la plantilla es el mockup con el literal de `var DATA=` (1471611 bytes) reemplazado por el marcador; prefijo (179443 bytes) y sufijo (30088 bytes) iguales byte a byte, con calibración por los dos lados. Se creó `/tmp/slep_s32_traslado`, vacía al medirla; después recibió el instrumento `plantilla_vs_mockup.R` y las dos copias plantadas de la calibración.

**Alcance:** `⊆`. Rutas fuera de git: las ocho heredadas de §2 más el LOG.

**Regresión:** no tocó código (solo se creó el LOG).

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. El LOG se escribió primero en el scratchpad de la sesión y se copió a su ruta después de medir `git status --porcelain`. Así el propio log no aparece como `??` en la medición del conjunto de §2 (8 líneas). El encargo pide crear el LOG (paso 1) antes de medir las 8 líneas (paso 3), y con el LOG en su ruta saldrían 9. Precedente: sesión 31, FASE 0, decisión 1. Antes del `git fetch` solo hubo lecturas: `git rev-parse --short HEAD` y `--abbrev-ref HEAD` para el encabezado, `hostname`, `sw_vers` y la versión de R. Alternativa descartada: crear el LOG en su ruta y restarlo a mano. Reversible.
2. El ayudante `medir.sh` vive en el scratchpad de la sesión y no en `/tmp/slep_s32_traslado`, porque tenía que existir antes del paso 7, que exige esa carpeta vacía. Los instrumentos que vienen después viven en `/tmp/slep_s32_traslado`. Reversible.
3. Chequeos propios de dos premisas de §2 que los pasos de FASE 0 no miden: la identidad plantilla/mockup fuera del literal y la carga de `V8`/`openssl`. Los dos sostienen la meta: D10 compara datos y no la plantilla, y D10 y D12 usan `V8`. Alternativa descartada: darlas por ciertas. Reversible (solo lectura).

**Errores propios:**
1. El comando de la primera calibración de la plantilla trae un tramo inerte (`tail -c 20000 … | head -c 1 >/dev/null`), resto de una edición del comando. No cambia la medición: descarta su salida y el `&&` siguió. Costo: ninguno.

**Dudas:**
1. Contexto: el proyecto no tiene `CLAUDE.md` en la raíz, y las instrucciones globales del titular piden crearlo antes de cualquier tarea. El ALCANCE del encargo es una lista cerrada que no lo incluye (§1.1, regla 6). Pregunta cerrada: ¿se crea `CLAUDE.md` en un encargo propio, fuera de esta cadena (sí/no)? No bloquea nada: no se creó.

### FASE 1 (T1): build, batería y commit del paso 36

**Verificación:**

Paso 0 (autorización 1), antes del build:

`cp 40_salidas/intermedios/*.parquet /tmp/slep_s32_traslado/ && ls /tmp/slep_s32_traslado/*.parquet`

esperado: código 0 y las seis copias: `comunas_chile`, `establecimientos_chile`, `simce_comunal`, `simce_rbd`, `slep_cc_establecimientos` y `sleps_chile` (`.parquet`)
obtenido:

```text
/tmp/slep_s32_traslado/comunas_chile.parquet
/tmp/slep_s32_traslado/establecimientos_chile.parquet
/tmp/slep_s32_traslado/simce_comunal.parquet
/tmp/slep_s32_traslado/simce_rbd.parquet
/tmp/slep_s32_traslado/slep_cc_establecimientos.parquet
/tmp/slep_s32_traslado/sleps_chile.parquet
```

`Rscript -e 'f <- basename(Sys.glob("40_salidas/intermedios/*.parquet")); a <- tools::md5sum(file.path("40_salidas/intermedios", f)); b <- tools::md5sum(file.path("/tmp/slep_s32_traslado", f)); cat(length(f), all(unname(a) == unname(b)), "\n")' 2>&1 | grep -v out-of-sync`

esperado: `6 TRUE` (las copias son byte a byte las del árbol antes del build)
obtenido: 6 TRUE 

`Rscript 00_build.R > /tmp/slep_s32_traslado/build_t1_intento1.txt 2>&1; echo "código Rscript: $?"; grep -n "^\[36\]" /tmp/slep_s32_traslado/build_t1_intento1.txt; grep -A2 "^\[36\] Vista" /tmp/slep_s32_traslado/build_t1_intento1.txt | tail -n 2; tail -n 1 /tmp/slep_s32_traslado/build_t1_intento1.txt`

esperado: `código Rscript: 0`; entre las líneas `[36]`, la línea `[36] Escrito 40_salidas/trayectorias_traspasos.html` (con el tamaño entre paréntesis); última línea `=== 00_build.R: OK en <n> segundos ===`
obtenido:

```text
código Rscript: 0
231:[36] Vista de trayectorias: leyendo insumos...
234:[36] Insertando datos en la plantilla...
235:[36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)
    simce_rbd.parquet: 185378 filas; sleps_chile.parquet: 2337 filas
    DATA: 9 años, 37 entidades, 12916 filas en datos, 21504 en nube, 180 comunas (1.5 MB)
=== 00_build.R: OK en 5 segundos ===
```

`grep -ciE "warn|advert|error" /tmp/slep_s32_traslado/build_t1_intento1.txt; grep -ciE "warn|advert|error" <(printf "Warning message:\n")`

esperado: chequeo propio, no enumerado: `0` líneas con aviso o error en la salida del build; `1` sobre una línea plantada (control positivo del patrón)
obtenido:

```text
0
1
```

Batería (paso 3); su salida va literal al LOG:

`Rscript 30_procesamiento/36_verificar_trayectorias.R 2>&1 | grep -v out-of-sync; echo "código Rscript: ${PIPESTATUS[0]}"`

esperado: código 0 y `Resultado: 15 pruebas, 15 pasan, 0 fallan`; en D10, `cifras distintas 3, de ellas sin empate 0`. Calibración: D9c, D10c y D12c son los casos malos plantados y deben PASAR (detectar); el caso bueno es el propio DATA del generador
obtenido:

```text
D1     PASA  Ningún agregado supera Adecuado + Insuficiente = 100 (máximo observado 89.7)
D2     PASA  El consolidado equivale a los cinco grupos combinados y ponderados (desviación máxima 0.09 puntos en 1296 combinaciones)
D3     PASA  Los estudiantes evaluados del consolidado igualan la suma por grupo (0 desajustes)
D4     PASA  Dentro de un mismo nivel y prueba, cada escuela tiene un solo grupo (condición que sí debe cumplirse siempre)
D5     PASA  Se declara cuántas escuelas cambian de grupo entre niveles (6461 de 53329 pares escuela-año, es decir 12.1%; por eso el desglose no suma el total en la vista combinada)
D6     PASA  El panel de serie completa nunca tiene más establecimientos que el total (0 violaciones)
D7     PASA  Toda combinación del panel de serie completa existe en el panel total (0 combinaciones sin contraparte)
D8     PASA  Control positivo: alterar una cifra en 0,5 puntos dispara exactamente un hallazgo (detectados 1)
D9     PASA  El n del total T iguala la suma de todos los grupos del parquet (entidades, referente y nube) (0 desajustes en 1332 + 6036 + 10958 combinaciones)
D9c    PASA  Control positivo: un total con un evaluado de menos dispara exactamente un hallazgo (detectados 1)
D10    PASA  Fidelidad al mockup de la sesión 30: mismas filas; solo difieren empates de redondeo (anios/meta/nac/comunas idénticos: anios,meta,nac,comunas; filas sin pareja 0; conteos distintos 0; cifras distintas 13, de ellas sin empate 0)
D10c   PASA  Control positivo: una cifra movida un décimo sin empate dispara exactamente un hallazgo (detectados 1)
D11    PASA  Las notas declaran el mismo referente y la misma nube que los datos (referente 1.333, nube (180 en total))
D12    PASA  El HTML no carga nada por red y su DATA es el que construye el generador (cargas por red 0; DATA idéntico: TRUE)
D12c   PASA  Control positivo: el patrón de red detecta un <script src="https:..."> plantado

Resultado: 15 pruebas, 15 pasan, 0 fallan
código Rscript: 0
```

**Desviación:** el paso 3 dio código 0 y `Resultado: 15 pruebas, 15 pasan, 0 fallan`, pero D10 dio `cifras distintas 13, de ellas sin empate 0` con esperado `cifras distintas 3, de ellas sin empate 0`. La batería no falla (regla 5 no dispara); el conteo 13 es un resultado no enumerado. Cláusula residual (§1.1, regla 7): **T1 queda congelada** en este punto, sin commit. No se ajusta el esperado ni se edita la batería. Lo que sigue en esta sección es evidencia de solo lectura para la duda (pasos 4 y 5 medidos tal como los escribe el encargo, y diagnóstico del 13); no reabre la tarea.

Diagnóstico del 13 (evidencia). La primera medición de tipos y plataforma se corrió una vez fuera del ayudante, sin pre-registro (ver Errores propios); se repite aquí:

`Rscript -e 's <- arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet"); x <- s$palu_eda_ade[!is.na(s$palu_eda_ade)]; y <- s$nalu[!is.na(s$nalu)]; cat("nalu", class(s$nalu), "entero:", all(y == round(y)), "| palu", class(x), "un decimal exacto:", all(abs(x*10 - round(x*10)) < 1e-9), "\n"); cat("arch:", R.version$arch, "| sizeof.longdouble:", .Machine$sizeof.longdouble, "| longdouble.digits:", if (is.null(.Machine$longdouble.digits)) "NULL" else .Machine$longdouble.digits, "\n"); cat("R", as.character(getRversion()), "| dplyr", as.character(packageVersion("dplyr")), "| arrow", as.character(packageVersion("arrow")), "\n")' 2>&1 | grep -v out-of-sync`

esperado: si la hipótesis de plataforma es cierta: `nalu` entero y `palu` con un decimal exacto (los porcentajes son racionales exactos y los empates se pueden decidir en aritmética entera); arquitectura `aarch64` con `sizeof.longdouble` 8 (sin precisión extendida en `sum()`, a diferencia de x86_64); se anotan las versiones de R, dplyr y arrow (el redactor: R 4.3.3, dplyr 1.2.1, arrow 25.0.1)
obtenido:

```text
nalu integer entero: TRUE | palu numeric un decimal exacto: TRUE 
arch: aarch64 | sizeof.longdouble: 8 | longdouble.digits: NULL 
R 4.5.2 | dplyr 1.2.0 | arrow 24.0.0 
```

`Rscript /tmp/slep_s32_traslado/diag_d10.R 2>&1 | grep -v out-of-sync`

esperado: universo: todas las celdas `ade` e `ins` de `datos` y `nube` (generador contra mockup, más el valor exacto en aritmética entera). Si la hipótesis de ruido de coma flotante en empates exactos es cierta: `palu … un decimal exacto: TRUE`; `distintas` suma `13` y `distintas_con_empate_exacto` suma `13`; fuera de los empates exactos, generador y mockup iguales al valor exacto en todas las celdas (`gen_igual_exacto_sin_empate` y `mock_igual_exacto_sin_empate` = celdas − empates exactos, por fila); dentro de los empates, el reparto entre generador y mockup es desconocido y se anota
obtenido:

```text
palu ade e ins con un decimal exacto: TRUE 
          celdas empates_exactos casi_empates_1e9 distintas
datos ade  12916              43               43         2
datos ins  12916              70               70         2
nube ade   21504             267              267         5
nube ins   21504             275              275         4
          distintas_con_empate_exacto gen_igual_exacto mock_igual_exacto
datos ade                           2            12908             12908
datos ins                           2            12901             12903
nube ade                            5            21453             21452
nube ins                            4            21466             21466
          gen_igual_exacto_en_empates mock_igual_exacto_en_empates
datos ade                          35                           35
datos ins                          55                           57
nube ade                          216                          215
nube ins                          237                          237
          gen_igual_exacto_sin_empate mock_igual_exacto_sin_empate
datos ade                       12873                        12873
datos ins                       12846                        12846
nube ade                        21237                        21237
nube ins                        21229                        21229
          distintas_en_T
datos ade              1
datos ins              0
nube ade               2
nube ins               1
suma: celdas=68840 empates_exactos=655 casi_empates_1e9=655 distintas=13 distintas_con_empate_exacto=13 gen_igual_exacto=68728 mock_igual_exacto=68729 gen_igual_exacto_en_empates=543 mock_igual_exacto_en_empates=544 gen_igual_exacto_sin_empate=68185 mock_igual_exacto_sin_empate=68185 distintas_en_T=4 
```

`Rscript /tmp/slep_s32_traslado/diag_d10.R control 2>&1 | grep -v out-of-sync | tail -n 1`

esperado: control positivo del instrumento (caso malo plantado: una celda `ade` de `datos` sin empate exacto, movida un décimo en la copia del generador): `distintas` suma `14` y `distintas_con_empate_exacto` sigue en `13`; `gen_igual_exacto_sin_empate` baja a `68184`
obtenido: suma: celdas=68840 empates_exactos=655 casi_empates_1e9=655 distintas=14 distintas_con_empate_exacto=13 gen_igual_exacto=68727 mock_igual_exacto=68729 gen_igual_exacto_en_empates=543 mock_igual_exacto_en_empates=544 gen_igual_exacto_sin_empate=68184 mock_igual_exacto_sin_empate=68185 distintas_en_T=5 

`Rscript /tmp/slep_s32_traslado/diag_orden.R 2>&1 | grep -v out-of-sync`

esperado: desconocido en magnitud. Si el conteo de D10 depende del ruido de coma flotante, invertir el orden de las filas del parquet cambia brutos (más de 0) y mueve alguna cifra publicada, siempre en un empate (cifras distintas = de ellas en empate). Si da 0 cifras distintas, la hipótesis de orden no se sostiene en esta estación y queda solo la de plataforma
obtenido:

```text
datos | brutos distintos: 9386 | cifras publicadas distintas: 6 | de ellas en empate: 6 
nube | brutos distintos: 6211 | cifras publicadas distintas: 8 | de ellas en empate: 8 
```

Pasos 4 y 5 (evidencia tras congelar):

`Rscript -e 'print(tools::md5sum("40_salidas/trayectorias_traspasos.html"))' 2>&1 | grep -v out-of-sync`

esperado: `c52ad54d0d40f7b84d55bba85aa8eb14`. Si difiere y el paso 3 pasó, no es falla: ADVIERTE con las versiones de `dplyr` y `arrow`. Con 13 cifras distintas del mockup contra 3 en el entorno del redactor, se prevé un md5 distinto
obtenido:

```text
40_salidas/trayectorias_traspasos.html 
    "a2658292e115b9f411f1340212e390de" 
```

`Rscript -e 'cat(as.character(packageVersion("dplyr")), as.character(packageVersion("arrow")))' 2>&1 | grep -v out-of-sync`

esperado: las versiones de la estación (el redactor: dplyr 1.2.1, arrow 25.0.1)
obtenido: 1.2.0 24.0.0

`grep -cE '(src|href)="https?:' 40_salidas/trayectorias_traspasos.html`

esperado: 🔒 3: `0`
obtenido: 0 [código de salida 1]

`for f in comunas_chile establecimientos_chile simce_comunal simce_rbd slep_cc_establecimientos sleps_chile; do printf "%s: " $f; A=/tmp/slep_s32_traslado/$f.parquet B=40_salidas/intermedios/$f.parquet Rscript -e 'a <- arrow::read_parquet(Sys.getenv("A")); b <- arrow::read_parquet(Sys.getenv("B")); cat(identical(as.data.frame(a), as.data.frame(b)))' 2>&1 | grep -v out-of-sync; echo; done`

esperado: 🔒 5: `TRUE` en cada uno de los seis parquet copiados en el paso 0
obtenido:

```text
comunas_chile: TRUE

establecimientos_chile: TRUE

simce_comunal: TRUE

simce_rbd: TRUE

slep_cc_establecimientos: TRUE

sleps_chile: TRUE
```

`git diff --name-only HEAD; git ls-files --others --exclude-standard`

esperado: alcance: las seis rutas de T1 (sin commit, T1 congelada), el encargo, el registro de errores del redactor y el LOG; nada más (las salidas de `40_salidas/` están ignoradas)
obtenido:

```text
.gitignore
00_build.R
30_procesamiento/36_funciones_trayectorias.R
30_procesamiento/36_generar_trayectorias.R
30_procesamiento/36_trayectorias_template.html
30_procesamiento/36_verificar_trayectorias.R
50_documentacion/activa/encargos/encargo_traslado_trayectorias.md
50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md
50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
```

`git check-ignore -v 40_salidas/trayectorias_traspasos.html 40_salidas/intermedios/simce_rbd.parquet`

esperado: las reglas de `.gitignore` que ignoran la salida nueva y los intermedios
obtenido:

```text
.gitignore:14:40_salidas/trayectorias_traspasos.html	40_salidas/trayectorias_traspasos.html
.gitignore:10:40_salidas/intermedios/*.parquet	40_salidas/intermedios/simce_rbd.parquet
```

`Rscript -e 'print(tools::md5sum(Sys.glob("30_procesamiento/36_*")))' 2>&1 | grep -v out-of-sync`

esperado: chequeo propio: los cuatro md5 de FASE 0, sin cambios (el ejecutor no editó ningún `36_*`)
obtenido:

```text
  30_procesamiento/36_funciones_trayectorias.R 
            "227d4ada13163ed6d4a9dd9ba327d883" 
    30_procesamiento/36_generar_trayectorias.R 
            "82463db3678bd7f30c275fd0745415ab" 
30_procesamiento/36_trayectorias_template.html 
            "5c720701a74c74b88d00bcfe0792916b" 
  30_procesamiento/36_verificar_trayectorias.R 
            "27871b145f52d409bbe4d6ac81845678" 
```

**Estado:** **congelada** por la cláusula residual (§1.1, regla 7), sin commit. Disparo: en el paso 3, D10 dio `cifras distintas 13, de ellas sin empate 0` con esperado `cifras distintas 3, de ellas sin empate 0`. El resto del esperado del paso 3 se cumplió (código 0; `Resultado: 15 pruebas, 15 pasan, 0 fallan`), y también el paso 2 (código 0 y la línea `[36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)`), 🔒 3 (`0`) y 🔒 5 (`TRUE` en los seis parquet). El md5 de la salida (paso 4) difiere del del redactor, como se preveía con 13 cifras distintas en vez de 3. Diagnóstico: las 13 cifras son empates exactos en aritmética entera, y el conteo depende del ruido de coma flotante (ver Dudas).

**Commits:** ninguno. Las seis rutas de T1 (`.gitignore`, `00_build.R` y los cuatro `30_procesamiento/36_*`) siguen en el árbol sin commit, con los md5 de FASE 0.

**Cambios sustantivos:** ninguno en archivos versionados; el ejecutor no editó ningún `36_*`, `00_build.R` ni `.gitignore`. El build (intento 1 de 3, sin error) re-escribió las salidas ignoradas: los intermedios, que quedan idénticos a sus copias previas (🔒 5), `40_salidas/motor_comparacion.html` y la nueva `40_salidas/trayectorias_traspasos.html` (md5 `a2658292e115b9f411f1340212e390de`, sin cargas por red). DATA: 9 años, 37 entidades, 12916 filas en `datos`, 21504 en `nube`, 180 comunas. Batería: 15 de 15 PASA; D9 con 0 desajustes en 1332 + 6036 + 10958 combinaciones; D10 con `anios`, `meta`, `nac` y `comunas` idénticos al mockup, 0 filas sin pareja, 0 conteos distintos y 13 cifras distintas, todas empates; D11 con referente 1.333 y nube de 180. Diagnóstico de solo lectura del 13, con instrumento calibrado: sobre 68840 celdas `ade`/`ins` hay 655 empates exactos. Fuera de ellos, generador y mockup coinciden con el valor exacto en las 68185 celdas. Dentro, el generador sigue el redondeo exacto al par en 543 y el mockup en 544. Las 13 distintas son empates exactos: en 7 acierta el mockup y en 6 el generador. Si se invierte el orden de las filas del parquet, en esta misma estación cambian 14 cifras publicadas, todas en empate.

**Alcance:** `⊆`. Rutas fuera de git: las seis de T1, el encargo, el registro de errores del redactor y el LOG. La salida nueva está ignorada por `.gitignore:14`; los intermedios, por `.gitignore:10`.

**Regresión:** el sustituto de PRUEBAS corrió una vez: `Rscript 00_build.R` (código 0, `=== 00_build.R: OK en 5 segundos ===`, 0 líneas de aviso o error) y `Rscript 30_procesamiento/36_verificar_trayectorias.R` (código 0, 15 de 15).

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno del repositorio ni de los instrumentos.

**Decisiones autónomas:**
1. Congelar T1 sin commit por la cláusula residual, porque el conteo 13 de D10 no está enumerado (el encargo enumera 3). El encargo solo prevé una salida para el md5 (paso 4), no para ese conteo. Alternativa descartada: commitear declarando la desviación, con el argumento de que la meta («ninguna cifra cambia salvo empates de redondeo») se cumple. Eso habría sido ajustar el esperado (FASE R, paso 9). Reversible: los seis archivos siguen intactos en el árbol.
2. Tras congelar, medir en modo solo lectura los pasos 4 y 5 y el alcance, y diagnosticar el 13 con dos instrumentos propios (aritmética entera exacta y sensibilidad al orden de suma), calibrados con un caso malo plantado. Así la duda llega al titular con la evidencia completa. Alternativa descartada: detenerse en el primer desvío; FASE R igual debía medir 🔒 3 y 🔒 5. Reversible: solo se escribió en `/tmp/slep_s32_traslado` y en las salidas ignoradas del build.
3. El md5 distinto del paso 4 se registra como ADVIERTE, con `dplyr` 1.2.0 y `arrow` 24.0.0 (el redactor: 1.2.1 y 25.0.1). La condición del encargo («si el paso 3 pasó») se cumple en lo que mide la batería (15 de 15, código 0), aunque no en el conteo de D10; el md5 distinto es consecuencia directa de ese conteo. Reversible.

**Errores propios:**
1. La medición de tipos (`nalu` entero, `palu` con un decimal) y de plataforma (`aarch64`, `sizeof.longdouble` 8, versiones) se corrió primero una vez fuera del ayudante, sin pre-registro. Salida de esa corrida: `integer numeric`, `palu 1 decimal exacto: TRUE`, `nalu entero: TRUE`, `8 aarch64`, `aarch64-apple-darwin20`, `1.2.0 24.0.0`. Se repitió con esperado (arriba). Costo: una medición repetida.

**Dudas:**
1. Contexto: D10 dio 13 cifras distintas del mockup, todas empates de redondeo (`de ellas sin empate 0`); el encargo esperaba 3, que es la corrida del redactor (R 4.3.3, dplyr 1.2.1, arrow 25.0.1). Esta estación corre R 4.5.2, dplyr 1.2.0 y arrow 24.0.0 en `aarch64`, sin precisión extendida en `sum()` (`sizeof.longdouble` 8). En aritmética entera exacta, las 13 son empates exactos. Ni el generador ni el mockup siguen el redondeo exacto al par en todos los empates (543 y 544 de 655): los dos deciden los empates por el ruido de coma flotante. Invertir el orden de las filas mueve 14 cifras en esta misma estación. El conteo de D10 depende, entonces, del entorno y del orden de suma. La meta («ninguna cifra cambia salvo empates de redondeo») se cumple. Pregunta cerrada: ¿se acepta `cifras distintas 13, de ellas sin empate 0` como resultado de D10 en esta estación? Opciones: (a) sí, y T1 se commitea tal cual en un encargo corto (el commit y el push de este encargo); (b) no: antes, el generador decide los empates en aritmética entera, lo que da un resultado independiente del entorno pero separa del mockup unas 111 cifras (655 − 544), todas empates, y exige re-escribir el esperado de D10; (c) otra. Bloquea el commit de T1 y el push.

### FASE R: auditoría y reparación

Panel adversarial: no se aplica, porque el contrato fija subagentes en 0. El orquestador re-deriva cada afirmación con un comando distinto del que la produjo: R base en vez de dplyr, `shasum`/`md5` en vez de `tools::md5sum`, blobs de git y `stat` en vez de listados, `grep` sobre el HTML en vez de V8.

**Inventario (anexado antes de auditar):**

- R-01 · FASE 0: `HEAD` = `origin/main` = `760ce01` tras `git fetch`; el remoto no se movió durante la sesión.
- R-02 · FASE 0: el estado de partida era el conjunto de §2 (8 líneas).
- R-03 · FASE 0: `git stash list` vacío.
- R-04 · FASE 0 y FASE 1: los cuatro `36_*` tienen los md5 de §2, antes y después del build (el ejecutor no los editó).
- R-05 · FASE 1: `00_build.R` y `.gitignore` traen solo la edición del redactor (`--numstat` 5/2 y 2/0, leído al abrir la sesión); el ejecutor no los editó.
- R-06 · FASE 0: `simce_rbd.parquet` es del 2026-09-23 y trae 14 columnas, ninguna de `prom`, `dif`, `difgru`, `sigdif`, `siggru`.
- R-07 · FASE 0: `/tmp/slep_s32_traslado` estaba vacía al crearla; todo lo que contiene lo escribió esta sesión.
- R-08 · FASE 0: la plantilla es el mockup con el literal de `var DATA=` (1471611 bytes) reemplazado por el marcador; prefijo de 179443 bytes y sufijo de 30088 iguales.
- R-09 · FASE 0: `V8` y `openssl` cargan.
- R-10 · FASE 1: las seis copias de los parquet son byte a byte las del árbol antes del build.
- R-11 · FASE 1: el build termina con código 0, la línea `[36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)` y 0 líneas de aviso o error.
- R-12 · FASE 1: DATA tiene 9 años, 37 entidades, 12916 filas en `datos`, 21504 en `nube` y 180 comunas.
- R-13 · FASE 1: la batería da 15 de 15 PASA y código 0; D9 con 0 desajustes; D11 con referente 1.333 y nube de 180.
- R-14 · FASE 1: D10 da 13 cifras distintas del mockup (esperado 3), todas empates; `anios`, `meta`, `nac` y `comunas` idénticos; 0 filas sin pareja y 0 conteos distintos. Disparo de la congelación.
- R-15 · FASE 1: las 13 son empates exactos en aritmética entera; hay 655 empates exactos en 68840 celdas; fuera de ellos, generador y mockup coinciden con el valor exacto en todas las celdas.
- R-16 · FASE 1: invertir el orden de las filas del parquet mueve 14 cifras publicadas, todas en empate.
- R-17 · FASE 1: la estación es `aarch64` con `sizeof.longdouble` 8, R 4.5.2, dplyr 1.2.0, arrow 24.0.0; `nalu` es entero y `palu` tiene un decimal exacto.
- R-18 · FASE 1: md5 de la salida `a2658292e115b9f411f1340212e390de`, distinto de `c52ad54d0d40f7b84d55bba85aa8eb14` (ADVIERTE).
- R-19 · FASE 1: la salida nueva y los intermedios están ignorados por git.
- R-20 · Mínimo del encargo: el total de Las Condes (`13114`), 4° básico Lectura 2023, en la nube, contado desde el parquet con la regla del ancla, es `271` e iguala el `n` de la fila `["13114",2023,"4b_lect","T",…]` del DATA del HTML.
- R-21 · 🔒 1: el motor publicado no cambia.
- R-22 · 🔒 2: los andamios congelados no cambian.
- R-23 · 🔒 3: la vista no carga nada por red.
- R-24 · 🔒 4: ningún archivo de datos nuevo versionado.
- R-25 · 🔒 5: los intermedios no cambian con el build.
- R-26 · Alcance global: `git diff --name-only 760ce01..HEAD` ⊆ unión de los ALCANCE más el LOG.
- R-27 · Estado del árbol al cierre de FASE R (`git status --porcelain`).
- R-28 · Regresión: los pasos 2 y 3 de FASE 1 sobre el estado final dan lo mismo que en FASE 1.
- R-29 · Registro: cada `esperado:` del log tiene su `obtenido:`.
- R-30 · Control positivo de la auditoría: el recuento de R-20 comparado contra `270` se marca como distinto, y los controles plantados de 🔒 3, 🔒 4 y 🔒 5 disparan.

**Re-derivación:**

`git ls-remote origin refs/heads/main | cut -f1; git rev-parse 760ce01; git merge-base --is-ancestor origin/main HEAD; echo "ancestro: $?"`

esperado: R-01: el hash remoto de `main` igual al completo de `760ce01` (el remoto no se movió) y `ancestro: 0`
obtenido:

```text
760ce01d153b7eec1520e2eda09a99fe5553fdf2
760ce01d153b7eec1520e2eda09a99fe5553fdf2
ancestro: 0
```

`instantánea de git status tomada por Claude Code al abrir la conversación, antes de cualquier comando (fuente distinta del comando de FASE 0)`

esperado: R-02: ` M` en `.gitignore` y `00_build.R`; `??` en los cuatro `36_*`, el encargo y el registro de errores del redactor; 8 líneas
obtenido: [código de salida 2]

```text
bash: -c: line 0: syntax error near unexpected token `('
bash: -c: line 0: `instantánea de git status tomada por Claude Code al abrir la conversación, antes de cualquier comando (fuente distinta del comando de FASE 0)'
```

Corrección (error propio; cita la medición anterior): se pasó al ayudante una fuente que no es un comando, y el ayudante la ejecutó (código 2). Al querer quitar esa salida, se borró la última línea del log, que era el cierre del bloque `text`, y se anexó a mano una línea `obtenido:`. Se restituyó el cierre del bloque y la línea a mano se reemplaza por el par de abajo. Esas dos son las únicas ediciones sobre texto ya escrito (ver Errores propios de esta fase y C.10). La afirmación y el esperado no cambian:

`(sin comando) instantánea de git status tomada por Claude Code al abrir la conversación`

esperado: R-02: ` M` en `.gitignore` y `00_build.R`; `??` en los cuatro `36_*`, el encargo y el registro de errores del redactor; 8 líneas
obtenido: `M .gitignore`, ` M 00_build.R`, `?? 30_procesamiento/36_funciones_trayectorias.R`, `?? 30_procesamiento/36_generar_trayectorias.R`, `?? 30_procesamiento/36_trayectorias_template.html`, `?? 30_procesamiento/36_verificar_trayectorias.R`, `?? 50_documentacion/activa/encargos/encargo_traslado_trayectorias.md`, `?? 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`: 8 líneas (la primera viene recortada en la instantánea; su espacio inicial no se ve)

`git rev-parse -q --verify refs/stash; echo "código: $?"`

esperado: R-03: sin hash, `código: 1` (no existe `refs/stash`)
obtenido: código: 1

`for f in 30_procesamiento/36_funciones_trayectorias.R 30_procesamiento/36_generar_trayectorias.R 30_procesamiento/36_trayectorias_template.html 30_procesamiento/36_verificar_trayectorias.R; do echo "$(md5 -q $f) $f"; done`

esperado: R-04, con `md5` de macOS en vez de `tools::md5sum`: `227d4ada13163ed6d4a9dd9ba327d883`, `82463db3678bd7f30c275fd0745415ab`, `5c720701a74c74b88d00bcfe0792916b`, `27871b145f52d409bbe4d6ac81845678`, en ese orden
obtenido:

```text
227d4ada13163ed6d4a9dd9ba327d883 30_procesamiento/36_funciones_trayectorias.R
82463db3678bd7f30c275fd0745415ab 30_procesamiento/36_generar_trayectorias.R
5c720701a74c74b88d00bcfe0792916b 30_procesamiento/36_trayectorias_template.html
27871b145f52d409bbe4d6ac81845678 30_procesamiento/36_verificar_trayectorias.R
```

`git diff --numstat HEAD -- .gitignore 00_build.R`

esperado: R-05: `2	0	.gitignore` y `5	2	00_build.R` (el diff del redactor leído al abrir la sesión: dos líneas agregadas en `.gitignore`; en `00_build.R`, tres líneas por dos en el encabezado más las dos del paso 36)
obtenido:

```text
2	0	.gitignore
5	2	00_build.R
```

`Rscript -e 'sc <- arrow::read_parquet("/tmp/slep_s32_traslado/simce_rbd.parquet", as_data_frame = FALSE)$schema; n <- sc$names; cat(length(n), sum(n %in% c("prom","dif","difgru","sigdif","siggru")), "\n")' 2>&1 | grep -v out-of-sync; stat -f '%Sm' -t '%Y-%m-%d' 40_salidas/intermedios/simce_rbd.parquet`

esperado: R-06, por el esquema Arrow de la copia previa al build (no por `names()` del data frame): `14 0`; y la fecha del archivo actual `2026-09-23` (el build lo re-escribió; la hora de FASE 0, 16:25:15, ya no es re-derivable desde el archivo)
obtenido:

```text
14 0 
2026-09-23
```

`stat -f "%B" /tmp/slep_s32_traslado; for f in /tmp/slep_s32_traslado/* /tmp/slep_s32_traslado/.[!.]*; do [ -e "$f" ] && echo "$(stat -f "%B" "$f") $(basename "$f")"; done | sort -n | awk -v d=$(stat -f "%B" /tmp/slep_s32_traslado) '{print ($1 >= d ? "posterior" : "ANTERIOR"), $2}'`

esperado: R-07, por fecha de nacimiento (`stat %B`) en vez de `ls -A`: la de la carpeta y, por entrada, `posterior` en todas; solo archivos de esta sesión: `plantilla_vs_mockup.R`, `plantilla_plantada.html`, `plantilla_plantada2.html`, los seis `.parquet`, `build_t1_intento1.txt`, `diag_d10.R`, `diag_orden.R`; ningún oculto
obtenido:

```text
1790203728
posterior plantilla_vs_mockup.R
posterior plantilla_plantada.html
posterior plantilla_plantada2.html
posterior comunas_chile.parquet
posterior establecimientos_chile.parquet
posterior simce_comunal.parquet
posterior simce_rbd.parquet
posterior slep_cc_establecimientos.parquet
posterior sleps_chile.parquet
posterior build_t1_intento1.txt
posterior diag_d10.R
posterior diag_orden.R
```

`T=30_procesamiento/36_trayectorias_template.html; M=50_documentacion/andamios/mockup_trayectoria_traspasos.html; echo "prefijo: $(head -c 179443 $T | md5) $(head -c 179443 $M | md5)"; echo "sufijo: $(tail -c 30088 $T | md5) $(tail -c 30088 $M | md5)"; echo "marcador: $(head -c 179464 $T | tail -c 21)"; echo "bytes: $(wc -c < $T | tr -d " ") = $((179443 + 21 + 30088)); $(wc -c < $M | tr -d " ") = $((179443 + 1471611 + 30088))"; echo "cola del prefijo: $(head -c 179443 $T | tail -c 9)"`

esperado: R-08, con `head`/`tail -c` y `md5` en vez de bytes en R: prefijo con dos md5 iguales; sufijo con dos md5 iguales; los 21 bytes tras el prefijo son `__DATA_TRAYECTORIAS__`; `209552 = 209552` y `1681142 = 1681142`; el prefijo termina en `var DATA=`
obtenido:

```text
prefijo: 394a89faa6a64efac21ef223221c7540 394a89faa6a64efac21ef223221c7540
sufijo: 5d86bf6530cb820b19ab9b0cce422963 5d86bf6530cb820b19ab9b0cce422963
marcador: __DATA_TRAYECTORIAS__
bytes: 209552 = 209552; 1681142 = 1681142
cola del prefijo: var DATA=
```

`Rscript -e 'ctx <- V8::v8(); cat(ctx$eval("1+1"), as.character(openssl::md5("a")), "\n")' 2>&1 | grep -v out-of-sync`

esperado: R-09, usando los paquetes en vez de `requireNamespace`: `2 0cc175b9c0f1b6a831c399e269772661` (md5 conocido de la cadena `a`)
obtenido: 2 0cc175b9c0f1b6a831c399e269772661 

`for f in comunas_chile establecimientos_chile simce_comunal simce_rbd slep_cc_establecimientos sleps_chile; do [ "$(md5 -q /tmp/slep_s32_traslado/$f.parquet)" = "$(md5 -q 40_salidas/intermedios/$f.parquet)" ] && echo "$f: bytes iguales" || echo "$f: bytes distintos"; done`

esperado: R-10, con `md5` de macOS sobre la copia y el archivo actual: desconocido. Si el build re-escribe los parquet con los mismos bytes, seis `bytes iguales` (y R-10 queda re-derivado por transitividad); si alguno difiere, R-10 no se re-deriva por esta vía, porque el build re-escribió los originales (el 🔒 5 compara contenido, no bytes)
obtenido:

```text
comunas_chile: bytes iguales
establecimientos_chile: bytes iguales
simce_comunal: bytes iguales
simce_rbd: bytes iguales
slep_cc_establecimientos: bytes iguales
sleps_chile: bytes iguales
```

`awk '/^\[36\] Escrito /{print NR": "$0}' /tmp/slep_s32_traslado/build_t1_intento1.txt; awk 'tolower($0) ~ /warn|advert|error|fall|stop|aviso/{n++} END{print "líneas con aviso o error: " n+0}' /tmp/slep_s32_traslado/build_t1_intento1.txt; tail -n 1 /tmp/slep_s32_traslado/build_t1_intento1.txt`

esperado: R-11, con `awk` y un patrón más amplio (agrega `fall`, `stop`, `aviso`) sobre la salida guardada del build: la línea 235 `[36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)`; `líneas con aviso o error: 0`; última línea `=== 00_build.R: OK en 5 segundos ===` (el código 0 se re-deriva en R-28)
obtenido:

```text
235: [36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)
líneas con aviso o error: 0
=== 00_build.R: OK en 5 segundos ===
```

`Rscript /tmp/slep_s32_traslado/auditoria_r.R R-12 2>&1 | grep -v out-of-sync`

esperado: R-12, desde el HTML escrito (readBin + parse_json) en vez del mensaje del generador: `9 37 12916 21504 180`
obtenido: 9 37 12916 21504 180 

`Rscript /tmp/slep_s32_traslado/auditoria_r.R R-13 2>&1 | grep -v out-of-sync`

esperado: R-13 (D9 y D11 por otra vía: R base sobre el parquet contra el DATA del HTML): `desajustes SL/REF/nube: 0 0 0` en `1296 36 6036` combinaciones (las 1332 de D9 son 1296 + 36); referente `1333` RBD y `180` comunas desde el parquet; las dos frases de las notas `TRUE TRUE`
obtenido:

```text
desajustes SL/REF/nube: 0 0 0 | combinaciones: 1296 36 6036 
referente (RBD distintos): 1333 | comunas de la nube: 180 
notas: 'los 1.333 establecimientos': TRUE | '(180 en total)': TRUE 
```

`Rscript /tmp/slep_s32_traslado/auditoria_r.R R-14 2>&1 | grep -v out-of-sync`

esperado: R-14 (D10 desde el HTML escrito, no desde el DATA en memoria del generador; parse_json y cotejo por clave): `anios/meta/nac/comunas iguales: TRUE TRUE TRUE TRUE`; `datos`: filas 12916 12916, sin pareja 0, conteos distintos 0, cifras distintas 4; `nube`: filas 21504 21504, sin pareja 0, conteos distintos 0, cifras distintas 9 (4 + 9 = 13, el reparto de `diag_d10.R`); a más de un décimo 0 en las dos
obtenido:

```text
anios/meta/nac/comunas iguales: TRUE TRUE TRUE TRUE 
datos | filas: 12916 12916 | sin pareja: 0 | conteos distintos: 0 | cifras distintas: 4 | a más de un décimo: 0 
nube | filas: 21504 21504 | sin pareja: 0 | conteos distintos: 0 | cifras distintas: 9 | a más de un décimo: 0 
```

`Rscript /tmp/slep_s32_traslado/auditoria_r.R R-15 2>&1 | grep -v out-of-sync`

esperado: R-15 en el subconjunto nube total T, en R base con otra forma del criterio de empate (`(2*S1 - S0) mod 2*S0 == 0`): `distintas` 2 en `ade` y 1 en `ins` (las `distintas_en_T` de la nube en `diag_d10.R`), todas en empate exacto (`distintas_en_empate_exacto` igual a `distintas`); `n_igual` igual a `celdas` (el `n` del HTML es la suma exacta del parquet); los empates exactos del subconjunto se anotan
obtenido:

```text
    celdas empates_exactos distintas distintas_en_empate_exacto n_igual
ade   7628              36         2                          2    7628
ins   7628              31         1                          1    7628
```

`Rscript /tmp/slep_s32_traslado/diag_orden2.R 2>&1 | grep -v out-of-sync`

esperado: R-16 por otra permutación (orden por rbd, año, nivel y prueba): brutos distintos más de 0; cifras publicadas distintas = de ellas en empate (el número no tiene por qué ser 14; lo que se re-deriva es que el orden mueve cifras y solo en empates)
obtenido: brutos distintos: 11816 | cifras publicadas distintas: 10 | de ellas en empate: 10 

`uname -m; for p in dplyr arrow; do d=$(Rscript -e "cat(find.package(\"$p\"))" 2>/dev/null | tail -n 1); echo "$p $(grep "^Version:" $d/DESCRIPTION)"; done; Rscript /tmp/slep_s32_traslado/auditoria_r.R R-17 2>&1 | grep -v out-of-sync`

esperado: R-17 por otras vías: `arm64`; `dplyr Version: 1.2.0` y `arrow Version: 24.0.0` desde sus DESCRIPTION; tipos Arrow `int32` para `nalu` y `double` para los dos `palu`; desviación máxima de `palu` a un decimal menor que 1e-9
obtenido:

```text
arm64
dplyr Version: 1.2.0
arrow Version: 24.0.0
tipos Arrow: nalu int32 | palu_eda_ade double | palu_eda_ins double 
desviación máxima de palu a un decimal: 0 
```

`md5 -q 40_salidas/trayectorias_traspasos.html; wc -c < 40_salidas/trayectorias_traspasos.html | tr -d " "`

esperado: R-18, con `md5` de macOS: `a2658292e115b9f411f1340212e390de` (distinto de `c52ad54d0d40f7b84d55bba85aa8eb14`); se anota el tamaño
obtenido:

```text
a2658292e115b9f411f1340212e390de
1662242
```

`git status --porcelain --ignored -- 40_salidas/`

esperado: R-19, por `--ignored` en vez de `check-ignore`: `!!` en `40_salidas/trayectorias_traspasos.html`, `40_salidas/motor_comparacion.html` y los seis `40_salidas/intermedios/*.parquet` (o su carpeta); ninguna línea `??` ni ` M`
obtenido:

```text
!! 40_salidas/intermedios/comunas_chile.parquet
!! 40_salidas/intermedios/establecimientos_chile.parquet
!! 40_salidas/intermedios/simce_comunal.parquet
!! 40_salidas/intermedios/simce_rbd.parquet
!! 40_salidas/intermedios/slep_cc_establecimientos.parquet
!! 40_salidas/intermedios/sleps_chile.parquet
!! 40_salidas/motor_comparacion.html
!! 40_salidas/trayectorias_traspasos.html
```

Mínimo del encargo (paso 2) y su control positivo (paso 6):

`Rscript /tmp/slep_s32_traslado/auditoria_r.R R-20 2>&1 | grep -v out-of-sync; grep -o "\[\"13114\",2023,\"4b_lect\",\"T\",[^]]*\]" 40_salidas/trayectorias_traspasos.html | awk -F, "{print \"n del HTML por grep/awk: \" \$7}" | tr -d "]"`

esperado: R-20: calibración de la extracción, filas del parquet en la celda mayor que 0 y una fila del HTML con la clave; `recuento desde el parquet: 271 | n del HTML: 271 | comparación: iguales`; por una tercera vía (`grep`/`awk` sobre el HTML), `271`
obtenido:

```text
filas del parquet en la celda: 5 | RBD: 5 | filas del HTML con la clave: 1 
recuento desde el parquet: 271 | n del HTML: 271 | comparación: iguales 
n del HTML por grep/awk: 271
```

`Rscript /tmp/slep_s32_traslado/auditoria_r.R R-30 2>&1 | grep -v out-of-sync`

esperado: R-30 a, control positivo de la auditoría: el mismo recuento contra `270` con la misma comparación: `DISTINTOS`
obtenido: recuento: 271 contra 270 | comparación: DISTINTOS 

Invariantes 🔒, cada uno con el comando del encargo y una segunda vía:

`git diff --quiet 760ce01 -- docs/ 30_procesamiento/30_construir_auxiliares.R 30_procesamiento/31_leer_normalizar.R 30_procesamiento/32_agregar_comunal.R 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html && echo intacto`

esperado: R-21 🔒 1: `intacto`
obtenido: intacto

`git status --porcelain -- docs/ 30_procesamiento/30_construir_auxiliares.R 30_procesamiento/31_leer_normalizar.R 30_procesamiento/32_agregar_comunal.R 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html | wc -l | tr -d " "; echo "$(git show 760ce01:docs/index.html | md5) $(md5 -q docs/index.html)"`

esperado: R-21, segunda vía: `0` líneas pendientes en esas rutas, y el md5 del blob de `docs/index.html` en `760ce01` igual al del disco
obtenido:

```text
0
5fcb5d9a4baa052f28010d31923c1855 5fcb5d9a4baa052f28010d31923c1855
```

`git diff --quiet 760ce01 -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html 50_documentacion/andamios/verificar_trayectorias.R && echo intacto`

esperado: R-22 🔒 2: `intacto`
obtenido: intacto

`for f in 50_documentacion/andamios/mockup_trayectoria_traspasos.html 50_documentacion/andamios/verificar_trayectorias.R; do echo "$(git show 760ce01:$f | md5) $(md5 -q $f)"; done`

esperado: R-22, segunda vía: dos pares de md5 iguales (blob en `760ce01` contra disco)
obtenido:

```text
2dff9ebc8704dc9eb51726d2a4ba0491 2dff9ebc8704dc9eb51726d2a4ba0491
00c24ab566e32edf723e2bb9f25b2768 00c24ab566e32edf723e2bb9f25b2768
```

`grep -cE '(src|href)="https?:' 40_salidas/trayectorias_traspasos.html`

esperado: R-23 🔒 3: `0` (grep sale con código 1 cuando cuenta 0)
obtenido: 0 [código de salida 1]

`Rscript -e 'h <- rawToChar(readBin("40_salidas/trayectorias_traspasos.html", "raw", file.size("40_salidas/trayectorias_traspasos.html"))); m <- gregexpr("(src|href)=\"https?:", h, perl = TRUE)[[1]]; cat("apariciones:", sum(m > 0), "| script/link/img con src o href:", lengths(regmatches(h, gregexpr("<(script|link|img|iframe)[^>]*(src|href)=", h, perl = TRUE))), "\n")' 2>&1 | grep -v out-of-sync`

esperado: R-23, segunda vía en R por apariciones (no por líneas): `apariciones: 0`; y se anota cuántas etiquetas `script`/`link`/`img`/`iframe` traen `src` o `href` de cualquier tipo (esperado `0`: la vista es autocontenida)
obtenido: apariciones: 0 | script/link/img con src o href: 0 

`git diff --name-only 760ce01..HEAD | grep -cE '\.(csv|xlsx|parquet|rds|json)$'; git status --porcelain | grep -cE '\.(csv|xlsx|parquet|rds|json)$'`

esperado: R-24 🔒 4: `0` en lo commiteado (no hay commits aún) y, como segunda vía, `0` en lo pendiente
obtenido: [código de salida 1]

```text
0
0
```

`F=40_salidas/trayectorias_traspasos.html; for p in 'url\(["'"'"']?https?:' '@import' 'fetch\(' 'XMLHttpRequest' 'import\(' 'new WebSocket' 'navigator\.sendBeacon'; do printf '%s: %s\n' "$p" "$(grep -oE "$p" $F | wc -l | tr -d ' ')"; done; echo 'hosts http(s) mencionados:'; grep -oE 'https?://[A-Za-z0-9.-]+' $F | sort | uniq -c`

esperado: chequeo propio, no enumerado (el patrón del 🔒 3 no cubre CSS ni JS): `0` en cada vía de carga por red (`url(http`, `@import`, `fetch(`, `XMLHttpRequest`, `import(`, `WebSocket`, `sendBeacon`); los hosts mencionados, si los hay, son espacios de nombres o texto (p. ej. `www.w3.org` de SVG), no cargas
obtenido:

```text
url\(["']?https?:: 0
@import: 0
fetch\(: 0
XMLHttpRequest: 0
import\(: 0
new WebSocket: 0
navigator\.sendBeacon: 0
hosts http(s) mencionados:
   1 http://www.w3.org
```

`for f in comunas_chile establecimientos_chile simce_comunal simce_rbd slep_cc_establecimientos sleps_chile; do printf "%s: " $f; A=/tmp/slep_s32_traslado/$f.parquet B=40_salidas/intermedios/$f.parquet Rscript -e 'a <- arrow::read_parquet(Sys.getenv("A")); b <- arrow::read_parquet(Sys.getenv("B")); cat(identical(as.data.frame(a), as.data.frame(b)))' 2>&1 | grep -v out-of-sync; echo; done`

esperado: R-25 🔒 5, comando del encargo, repetido tras la regresión de FASE 1: `TRUE` en los seis (la segunda vía, bytes iguales con `md5`, es R-10)
obtenido:

```text
comunas_chile: TRUE

establecimientos_chile: TRUE

simce_comunal: TRUE

simce_rbd: TRUE

slep_cc_establecimientos: TRUE

sleps_chile: TRUE
```

`stat -f "%Sm %N" -t "%Y-%m-%d %H:%M:%S" 40_salidas/intermedios/*.parquet`

esperado: evidencia de R-25: fechas de modificación de los intermedios; si el build los re-escribió, son posteriores a las 16:25:15 de FASE 0 (y aun así iguales en bytes, R-10)
obtenido:

```text
2026-09-23 19:50:12 40_salidas/intermedios/comunas_chile.parquet
2026-09-23 19:50:12 40_salidas/intermedios/establecimientos_chile.parquet
2026-09-23 19:50:14 40_salidas/intermedios/simce_comunal.parquet
2026-09-23 19:50:13 40_salidas/intermedios/simce_rbd.parquet
2026-09-23 19:50:11 40_salidas/intermedios/slep_cc_establecimientos.parquet
2026-09-23 19:50:12 40_salidas/intermedios/sleps_chile.parquet
```

Controles positivos de los instrumentos de los 🔒 (R-30 b a e), sobre casos plantados fuera del árbol:

`sed 's|^</body>|<script src="https://x.y/z.js"></script>\n</body>|' 40_salidas/trayectorias_traspasos.html > /tmp/slep_s32_traslado/salida_plantada.html && grep -cE '(src|href)="https?:' /tmp/slep_s32_traslado/salida_plantada.html`

esperado: R-30 b (🔒 3): `1` sobre una copia de la salida con un `<script src="https://…">` plantado antes de `</body>`
obtenido: 1

`printf '30_procesamiento/x.R\n40_salidas/publico/y.parquet\n' | grep -cE '\.(csv|xlsx|parquet|rds|json)$'`

esperado: R-30 c (🔒 4): `1` (el patrón dispara sobre una ruta `.parquet` plantada)
obtenido: 1

`A=/tmp/slep_s32_traslado/sleps_chile.parquet Rscript -e 'a <- arrow::read_parquet(Sys.getenv("A")); arrow::write_parquet(a[-1, ], "/tmp/slep_s32_traslado/plantado_sleps.parquet"); b <- arrow::read_parquet("/tmp/slep_s32_traslado/plantado_sleps.parquet"); cat(identical(as.data.frame(a), as.data.frame(b)), "\n")' 2>&1 | grep -v out-of-sync`

esperado: R-30 d (🔒 5): `FALSE` con la misma comparación sobre una copia de `sleps_chile` sin su primera fila
obtenido: FALSE 

`git diff --name-only 760ce01~1 760ce01; git diff --quiet 760ce01~1 760ce01 -- $(git diff --name-only 760ce01~1 760ce01 | head -n 1); echo "código: $?"`

esperado: R-30 e (🔒 1 y 🔒 2): `git diff --quiet` sobre una ruta que sí cambió entre `760ce01~1` y `760ce01` da `código: 1` (el instrumento distingue)
obtenido:

```text
50_documentacion/activa/50_datos_versionados_autorizados.md
código: 1
```

Alcance global, estado del árbol y regresión completa:

`git diff --name-only 760ce01..HEAD; echo "filas: $(git diff --name-only 760ce01..HEAD | wc -l | tr -d " ")"`

esperado: R-26: `filas: 0` (sin commits desde el punto de retorno; vacío ⊆ unión de los ALCANCE más el LOG)
obtenido: filas: 0

`git status --porcelain`

esperado: R-27: ` M` en `.gitignore` y `00_build.R`; `??` en los cuatro `36_*` (T1 congelada), el encargo, el registro de errores del redactor y el LOG; 9 líneas, nada más
obtenido:

```text
 M .gitignore
 M 00_build.R
?? 30_procesamiento/36_funciones_trayectorias.R
?? 30_procesamiento/36_generar_trayectorias.R
?? 30_procesamiento/36_trayectorias_template.html
?? 30_procesamiento/36_verificar_trayectorias.R
?? 50_documentacion/activa/encargos/encargo_traslado_trayectorias.md
?? 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md
?? 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
```

`md5 -q 40_salidas/trayectorias_traspasos.html; Rscript 00_build.R > /tmp/slep_s32_traslado/build_faseR.txt 2>&1; echo "código Rscript: $?"; grep "^\[36\] Escrito" /tmp/slep_s32_traslado/build_faseR.txt; tail -n 1 /tmp/slep_s32_traslado/build_faseR.txt; md5 -q 40_salidas/trayectorias_traspasos.html`

esperado: R-28 (paso 2 de FASE 1 sobre el estado final): md5 previo `a2658292e115b9f411f1340212e390de`; `código Rscript: 0`; la línea `[36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)`; `=== 00_build.R: OK en <n> segundos ===`; el mismo md5 tras el build (determinista en la misma estación)
obtenido:

```text
a2658292e115b9f411f1340212e390de
código Rscript: 0
[36] Escrito 40_salidas/trayectorias_traspasos.html (1.66 MB)
=== 00_build.R: OK en 5 segundos ===
a2658292e115b9f411f1340212e390de
```

`Rscript 30_procesamiento/36_verificar_trayectorias.R > /tmp/slep_s32_traslado/bateria_faseR.txt 2>&1; echo "código Rscript: $?"; grep -v out-of-sync /tmp/slep_s32_traslado/bateria_faseR.txt | grep -E "^(D10 |Resultado)"; grep -c "  PASA  " /tmp/slep_s32_traslado/bateria_faseR.txt; grep -c "  FALLA " /tmp/slep_s32_traslado/bateria_faseR.txt`

esperado: R-28 (paso 3 de FASE 1 sobre el estado final): `código Rscript: 0`; la línea de D10 igual a la de FASE 1 (`cifras distintas 13, de ellas sin empate 0`); `Resultado: 15 pruebas, 15 pasan, 0 fallan`; `15` líneas PASA y `0` FALLA
obtenido: [código de salida 1]

```text
código Rscript: 0
D10    PASA  Fidelidad al mockup de la sesión 30: mismas filas; solo difieren empates de redondeo (anios/meta/nac/comunas idénticos: anios,meta,nac,comunas; filas sin pareja 0; conteos distintos 0; cifras distintas 13, de ellas sin empate 0)
Resultado: 15 pruebas, 15 pasan, 0 fallan
15
0
```

`for f in comunas_chile establecimientos_chile simce_comunal simce_rbd slep_cc_establecimientos sleps_chile; do [ "$(md5 -q /tmp/slep_s32_traslado/$f.parquet)" = "$(md5 -q 40_salidas/intermedios/$f.parquet)" ] && echo "$f: bytes iguales" || echo "$f: bytes distintos"; done`

esperado: R-25 tras la segunda corrida del build (regresión): seis `bytes iguales`
obtenido:

```text
comunas_chile: bytes iguales
establecimientos_chile: bytes iguales
simce_comunal: bytes iguales
simce_rbd: bytes iguales
slep_cc_establecimientos: bytes iguales
sleps_chile: bytes iguales
```

`echo "esperado: $(grep -c "^esperado:" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md) obtenido: $(grep -c "^obtenido:" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md)"`

esperado: R-29: el conteo de `esperado:` supera en 1 al de `obtenido:`, porque la línea `obtenido:` de esta misma medición se escribe después de contar
obtenido: esperado: 74 obtenido: 73

**Tabla de auditoría:**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | HEAD = origin/main = 760ce01 tras fetch; remoto quieto | `git ls-remote` + `merge-base --is-ancestor` | hash remoto = `760ce01d…`; ancestro 0 | igual; 0 | — | — | — | — |
| R-02 | estado de partida = 8 líneas de §2 | instantánea de `git status` del arranque | 2 ` M` + 6 `??` | igual | — | — | — | primer intento mal formado (error propio, corregido) |
| R-03 | stash vacío | `git rev-parse -q --verify refs/stash` | código 1 | código 1 | — | — | — | — |
| R-04 | md5 de los cuatro `36_*` = §2 | `md5 -q` de macOS | 4 md5 de §2 | iguales | — | — | — | — |
| R-05 | `00_build.R` y `.gitignore` solo con la edición del redactor | `git diff --numstat HEAD` | `2 0` y `5 2` | igual | — | — | — | — |
| R-06 | `simce_rbd` de 14 columnas sin las 5 de la rama; del 2026-09-23 | esquema Arrow de la copia previa + `stat` | `14 0`; fecha | `14 0`; `2026-09-23` | — (la hora 16:25:15 ya no es re-derivable: el build re-escribió el archivo) | — | — | — |
| R-07 | scratch vacío al crearlo; todo lo escribió la sesión | `stat %B` de carpeta y entradas | todas `posterior` | 12 `posterior`, 0 `ANTERIOR` | — | — | — | — |
| R-08 | plantilla = mockup menos el literal | `head`/`tail -c` + `md5` | md5 pares iguales; marcador; tamaños | igual | — | — | — | calibrado en FASE 0 por los dos lados |
| R-09 | V8 y openssl cargan | `ctx$eval("1+1")` + `openssl::md5("a")` | `2 0cc175b9…` | igual | — | — | — | — |
| R-10 | copias = originales previos al build | `md5 -q` copia contra archivo | 6 iguales (o no re-derivable) | 6 `bytes iguales` | — | — | — | repetido tras la regresión: 6 iguales |
| R-11 | build código 0, línea `[36] Escrito`, 0 avisos | `awk` + patrón ampliado sobre la salida guardada | línea 235; 0 | igual | — | — | — | R-28 |
| R-12 | DATA 9/37/12916/21504/180 | readBin + `parse_json` del HTML | `9 37 12916 21504 180` | igual | — | — | — | — |
| R-13 | D9 0 desajustes; D11 1.333 y 180 | R base sobre el parquet contra el HTML | 0 0 0 en 1296/36/6036; 1333; 180; `TRUE TRUE` | igual | — | — | — | — |
| R-14 | D10: 13 cifras distintas (esperado 3), todas empates; resto idéntico | cotejo por clave desde el HTML escrito | 4 + 9 = 13; 0 sin pareja; 0 conteos; 0 a más de un décimo | igual | **BLOQUEA** (gobernanza: el esperado del encargo fija un conteo que depende del entorno; repararlo sería ajustar el esperado, paso 9) | T1 congelada; Duda 1 de FASE 1 | — | `diag_d10.R` con control plantado (14/13) |
| R-15 | las 13 son empates exactos; 655 empates; fuera de ellos, todo exacto | R base, otra forma del criterio, en nube T | 2 y 1 distintas, todas en empate exacto; `n` exacto | 2/2 y 1/1; `n_igual` 7628/7628 | — | — | — | — |
| R-16 | el orden de suma mueve cifras solo en empates | otra permutación (orden por rbd, año, nivel, prueba) | brutos > 0; distintas = en empate | 11816; 10 = 10 | — | — | — | — |
| R-17 | aarch64, longdouble 8, versiones; tipos de `nalu` y `palu` | `uname -m`, DESCRIPTION, esquema Arrow | `arm64`; 1.2.0; 24.0.0; `int32`/`double`; < 1e-9 | igual; desviación 0 | — | — | — | — |
| R-18 | md5 de la salida `a2658292…` ≠ `c52ad54d…` | `md5 -q` de macOS | `a2658292…` | igual (1662242 bytes) | ADVIERTE (paso 4: md5 distinto con la batería en PASA; dplyr 1.2.0 y arrow 24.0.0 contra 1.2.1 y 25.0.1; consecuencia de R-14) | registrada | — | R-28: mismo md5 tras rebuild |
| R-19 | salida e intermedios ignorados | `git status --ignored` | `!!` en 8 rutas | igual | — | — | — | — |
| R-20 | Las Condes 4° básico Lectura 2023, nube T: 271 = HTML | R base con la regla del ancla + regex en R + `grep`/`awk` | 271 = 271 = 271 | `iguales`; 271 | — | — | — | control R-30 a |
| R-21 | 🔒 1 motor publicado intacto | comando del encargo + `git status` + md5 de blob | `intacto`; 0; md5 iguales | igual | — (PASA) | — | — | control R-30 e |
| R-22 | 🔒 2 andamios congelados intactos | comando del encargo + md5 de blob contra disco | `intacto`; 2 pares iguales | igual | — (PASA) | — | — | control R-30 e |
| R-23 | 🔒 3 sin carga por red | comando del encargo + R por apariciones + chequeo propio de CSS/JS | 0; 0; 0 vías | igual; solo `www.w3.org` (espacio de nombres SVG) | — (PASA) | — | — | control R-30 b |
| R-24 | 🔒 4 sin archivos de datos | comando del encargo + `git status` | 0; 0 | 0; 0 | — (PASA) | — | — | control R-30 c |
| R-25 | 🔒 5 intermedios sin cambios | comando del encargo (6 `identical`) + `md5` | 6 `TRUE`; 6 iguales | igual, antes y después de la regresión | — (PASA) | — | — | control R-30 d |
| R-26 | alcance global ⊆ ALCANCE + LOG | `git diff --name-only 760ce01..HEAD` | 0 filas | 0 | — | — | — | — |
| R-27 | árbol al cierre de FASE R | `git status --porcelain` | 2 ` M` + 7 `??` | igual | ADVIERTE (las seis rutas de T1 sin commit son consecuencia de R-14; no se limpian) | registrada | — | — |
| R-28 | regresión: build y batería iguales a FASE 1 | re-correr pasos 2 y 3 + md5 antes/después | código 0; md5 igual; 15/15; D10 igual | igual | — | — | — | — |
| R-29 | cada `esperado:` tiene su `obtenido:` | `grep -c` de los dos rótulos | esperado = obtenido + 1 | 74 / 73 | — | — | — | se repite en FASE L |
| R-30 | la auditoría dispara | casos plantados en `/tmp/slep_s32_traslado` | `DISTINTOS`; 1; 1; `FALSE`; código 1 | igual | — | — | — | — |

**Hallazgos por severidad:** BLOQUEA 1 (R-14, gobernanza del esperado de D10); REPARA 0; ADVIERTE 2 (R-18, md5 distinto; R-27, rutas de T1 sin commit). Ciclos de reparación: 0. No hubo REPARA, y el BLOQUEA no se repara. Control del paso 6: el recuento de R-20 contra `270`, con la misma comparación, da `DISTINTOS` (R-30 a). El BLOQUEA no compromete el repositorio: los cinco 🔒 PASAN, los datos no cambian (🔒 5; R-13; R-14 sin conteos distintos) y el alcance se respeta (R-26). La sesión pasa a FASE L.

**Veredicto global: `BLOQUEADO`.** El bloqueo es solo de gobernanza: T1 espera la Duda 1 de FASE 1, sin ningún 🔒 en FALLA.

**Estado:** completada.

**Commits:** ninguno.

**Cambios sustantivos:** ninguno en archivos versionados. La regresión re-escribió las salidas ignoradas con los mismos bytes (HTML `a2658292…` antes y después; los seis intermedios iguales en bytes a sus copias). Los casos plantados viven en `/tmp/slep_s32_traslado`.

**Alcance:** `⊆` (R-26). Los únicos archivos escritos fuera de `/tmp/slep_s32_traslado` y del scratchpad de la sesión fueron el LOG y las salidas ignoradas del build.

**Regresión:** R-28: los dos sustitutos de PRUEBAS con código 0 y los mismos resultados que en FASE 1.

**Subagentes:** sin subagentes, por contrato; sin panel adversarial por la misma razón.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. R-14 se clasifica BLOQUEA de gobernanza y no ADVIERTE. La meta se cumple (todas las diferencias son empates), pero el hallazgo impide entregarla (T1 sin commit) y no tiene reparación legal: la única sería ajustar el esperado. Precedente: sesión 31, R-14. Alternativa descartada: ADVIERTE, que el paso 7 reserva a hallazgos sin efecto sobre la meta. Reversible (clasificación).
2. R-02 se re-derivó desde la instantánea de `git status` que Claude Code toma al abrir la conversación, porque el estado de partida ya no se puede volver a medir. Alternativa descartada: declararla no re-derivable. Reversible.
3. Se agregó un chequeo propio a 🔒 3 (vías de carga por red en CSS y JS que el patrón `(src|href)=` no ve). Alternativa descartada: limitarse al patrón del encargo. Reversible (solo lectura).

**Errores propios:**
1. Al re-derivar R-02, se pasó al ayudante `medir` una fuente que no es un comando (la instantánea de `git status`). El ayudante la ejecutó (código 2, `syntax error`). Para quitar esa salida se corrió `sed -i '' '$d'` sobre el LOG, que borró la última línea, el cierre del bloque `text`, y se anexó a mano una línea `obtenido:`. Corrección: se restituyó el cierre del bloque y la línea a mano se reemplazó por un par `esperado:`/`obtenido:` completo, con una nota que cita la medición. Son las únicas ediciones sobre texto ya escrito (C.10). Costo: una edición del log y una re-medición del conteo de rótulos.

**Dudas:** la de FASE 1 (R-14), sin cambios.

**Instrumentos, transcritos íntegros** (viven fuera del árbol y no se versionan; se copian aquí para que el revisor pueda reproducir cada medición):

`medir.sh`:

````bash
# Ayudante de verificación del encargo traslado_trayectorias (sesión 32).
# Uso: source medir.sh; medir "<comando>" "<esperado>"
# Escribe en $LOG el comando y la línea `esperado:` ANTES de correrlo, y luego
# la línea `obtenido:` con la salida literal (stdout+stderr) y el código de salida
# cuando no es 0. El comando corre con bash explícito desde la raíz del repo.
RAIZ=/Users/tomgc/Projects/slep_simce_adecuado
: "${LOG:=$RAIZ/50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md}"
medir() {
  local cmd="$1" esp="$2" out rc n
  printf '\n`%s`\n\nesperado: %s\n' "$cmd" "$esp" >> "$LOG"
  out=$(cd "$RAIZ" && bash -c "$cmd" 2>&1); rc=$?
  n=$(printf '%s' "$out" | awk 'END{print NR}')
  local sufijo=""
  [ "$rc" -ne 0 ] && sufijo=" [código de salida $rc]"
  if [ -z "$out" ]; then
    printf 'obtenido: (sin salida)%s\n' "$sufijo" >> "$LOG"
  elif [ "$n" -le 1 ]; then
    printf 'obtenido: %s%s\n' "$out" "$sufijo" >> "$LOG"
  else
    printf 'obtenido:%s\n\n```text\n%s\n```\n' "$sufijo" "$out" >> "$LOG"
  fi
  printf '$ %s\n%s\n[rc=%s]\n\n' "$cmd" "$out" "$rc"
}
````

`plantilla_vs_mockup.R`:

````r
# Premisa de §2: la plantilla es el mockup con el literal de `var DATA=`
# reemplazado por __DATA_TRAYECTORIAS__ (mismo prefijo y mismo sufijo, byte a byte).
# Uso: Rscript plantilla_vs_mockup.R <plantilla> <mockup>
# No imprime datos: solo tamaños, posiciones y booleanos.
args <- commandArgs(trailingOnly = TRUE)
leer_raw <- function(r) readBin(r, "raw", file.size(r))
pos_raw <- function(x, patron) {
  p <- charToRaw(patron); k <- length(p)
  cand <- which(x == p[1])
  cand <- cand[cand + k - 1L <= length(x)]
  hits <- cand[vapply(cand, function(i) identical(x[i:(i + k - 1L)], p), logical(1))]
  hits
}
t <- leer_raw(args[1]); m <- leer_raw(args[2])
marca <- "__DATA_TRAYECTORIAS__"
pt <- pos_raw(t, marca)
pm <- pos_raw(m, "var DATA=")
cat("apariciones del marcador en plantilla:", length(pt), "\n")
cat("apariciones de 'var DATA=' en mockup:", length(pm), "\n")
stopifnot(length(pt) == 1L, length(pm) == 1L)
ini_t <- pt; ini_m <- pm + nchar("var DATA=")
prefijo_igual <- ini_t == ini_m && identical(t[1:(ini_t - 1L)], m[1:(ini_m - 1L)])
# Fin del literal en el mockup: primera ";\n</script>" después de var DATA=.
cierre <- charToRaw(";\n</script>")
fin_c <- pos_raw(m[ini_m:length(m)], ";\n</script>")[1] + ini_m - 1L
suf_t <- t[(ini_t + nchar(marca)):length(t)]
suf_m <- m[fin_c:length(m)]
cat("bytes plantilla/mockup:", length(t), length(m), "\n")
cat("prefijo igual (", ini_t - 1L, "bytes):", prefijo_igual, "\n")
cat("sufijo igual (", length(suf_t), "bytes):", identical(suf_t, suf_m), "\n")
cat("largo del literal DATA del mockup:", fin_c - ini_m, "bytes\n")
cat("bytes plantilla = prefijo + marcador + sufijo:",
    length(t) == (ini_t - 1L) + nchar(marca) + length(suf_t), "\n")
````

`diag_d10.R`:

````r
# Diagnóstico de solo lectura del conteo de D10 (13 cifras distintas del mockup,
# esperado 3). No escribe archivos ni imprime filas de datos: solo conteos.
# Uso: Rscript /tmp/slep_s32_traslado/diag_d10.R [control]
# Con "control", planta un error de un décimo en una celda sin empate de una
# copia del DATA del generador (control positivo del instrumento).
#
# Aritmética exacta: `nalu` es entero y `palu` tiene un decimal exacto, así que
# el porcentaje*10 de cada celda es el racional S1/S0, con S1 = sum(nalu *
# round(palu*10)) y S0 = sum(nalu) = n. La celda es un empate exacto si
# 2*S1 es múltiplo impar de S0; el redondeo exacto al par es entonces el
# entero par más cercano a S1/S0.
suppressPackageStartupMessages(library(dplyr))
modo <- commandArgs(trailingOnly = TRUE)[1]
if (is.na(modo)) modo <- ""
source(here::here("30_procesamiento", "36_funciones_trayectorias.R"))
extraer_data <- function(ruta) {
  html <- paste(readLines(ruta, encoding = "UTF-8", warn = FALSE), collapse = "\n")
  ini <- regexpr("var DATA=", html, fixed = TRUE) + nchar("var DATA=")
  resto <- substr(html, ini, nchar(html))
  substr(resto, 1L, regexpr(";\n</script>", resto, fixed = TRUE) - 1L)
}

ins <- leer_insumos_trayectorias()
s <- ins$simce
p10 <- c(s$palu_eda_ade, s$palu_eda_ins); p10 <- p10[!is.na(p10)]
cat("palu ade e ins con un decimal exacto:", all(abs(p10 * 10 - round(p10 * 10)) < 1e-9), "\n")

# Corrida 0: funciones originales, con brutos.
D0 <- construir_datos_trayectorias(ins, conservar_brutos = TRUE)

# Corrida 1: la misma construcción, pero ade_bruto/ins_bruto guardan S1 exacto.
agregar_original <- agregar_trayectorias
agregar_trayectorias <- function(df, claves) {
  df |>
    dplyr::summarise(
      .by = dplyr::all_of(claves),
      ade_bruto = sum(as.numeric(nalu) * round(palu_eda_ade * 10)),
      ins_bruto = sum(as.numeric(nalu) * round(palu_eda_ins * 10)),
      n   = as.integer(round(sum(nalu))),
      e   = dplyr::n_distinct(rbd)
    ) |>
    dplyr::mutate(ade = 0, ins = 0)
}
D1 <- construir_datos_trayectorias(ins, conservar_brutos = TRUE)
agregar_trayectorias <- agregar_original
stopifnot(all(D1$datos$ade_bruto < 2^53), all(D1$nube$ade_bruto < 2^53))

exacto <- function(S1, S0) {
  dos <- 2 * S1
  empate <- (dos %% S0 == 0) & ((dos %/% S0) %% 2 == 1)
  m <- floor(S1 / S0)
  # Sin empate: entero más cercano; con empate: el par.
  cerca <- floor((2 * S1 + S0) / (2 * S0))
  par <- ifelse(m %% 2 == 0, m, m + 1)
  list(empate = empate, valor = ifelse(empate, par, cerca) / 10)
}

M <- jsonlite::fromJSON(extraer_data(here::here(
  "50_documentacion", "andamios", "mockup_trayectoria_traspasos.html")))
a_df <- function(m, col) { d <- as.data.frame(m, stringsAsFactors = FALSE); names(d) <- col; d }
mock <- list(
  datos = a_df(M$datos, c("id", "anio", "np", "g", "panel", "ade", "ins", "n", "e")) |>
    mutate(across(c(anio, panel, n, e), as.integer), across(c(ade, ins), as.numeric)),
  nube = a_df(M$nube, c("com", "anio", "np", "g", "ade", "ins", "n")) |>
    mutate(across(c(anio, n), as.integer), across(c(ade, ins), as.numeric))
)
claves <- list(datos = c("id", "anio", "np", "g", "panel"), nube = c("com", "anio", "np", "g"))

tot <- list()
for (tabla in c("datos", "nube")) {
  k <- claves[[tabla]]
  g0 <- D0[[tabla]]
  stopifnot(identical(g0[k], D1[[tabla]][k]))
  if (modo == "control" && tabla == "datos") {
    # Una celda sin empate exacto, movida un décimo en la copia del generador.
    i <- which(!exacto(D1$datos$ade_bruto, D1$datos$n)$empate)[1]
    g0$ade[i] <- g0$ade[i] + 0.1
  }
  x <- g0 |>
    inner_join(select(D1[[tabla]], all_of(k), s1_ade = ade_bruto, s1_ins = ins_bruto, n1 = n), by = k) |>
    inner_join(select(mock[[tabla]], all_of(k), ade_m = ade, ins_m = ins), by = k)
  stopifnot(nrow(x) == nrow(g0), nrow(x) == nrow(mock[[tabla]]), all(x$n == x$n1))
  for (v in c("ade", "ins")) {
    ex <- exacto(x[[paste0("s1_", v)]], x$n)
    gen <- x[[v]]; mk <- x[[paste0(v, "_m")]]
    casi <- abs(x[[paste0(v, "_bruto")]] / 0.1 - floor(x[[paste0(v, "_bruto")]] / 0.1) - 0.5) < 1e-9
    dif <- gen != mk
    tot[[paste(tabla, v)]] <- c(
      celdas = nrow(x), empates_exactos = sum(ex$empate), casi_empates_1e9 = sum(casi),
      distintas = sum(dif), distintas_con_empate_exacto = sum(dif & ex$empate),
      gen_igual_exacto = sum(abs(gen - ex$valor) < 1e-9),
      mock_igual_exacto = sum(abs(mk - ex$valor) < 1e-9),
      gen_igual_exacto_en_empates = sum(ex$empate & abs(gen - ex$valor) < 1e-9),
      mock_igual_exacto_en_empates = sum(ex$empate & abs(mk - ex$valor) < 1e-9),
      gen_igual_exacto_sin_empate = sum(!ex$empate & abs(gen - ex$valor) < 1e-9),
      mock_igual_exacto_sin_empate = sum(!ex$empate & abs(mk - ex$valor) < 1e-9),
      distintas_en_T = sum(dif & x$g == GSE_TOTAL)
    )
  }
}
r <- do.call(rbind, tot)
print(r)
cat("suma:", paste(colnames(r), colSums(r), sep = "=", collapse = " "), "\n")
````

`diag_orden.R`:

````r
# Sensibilidad del redondeo al orden de suma (solo lectura; solo conteos).
# Construye DATA dos veces con las funciones del paso 36: con el parquet en su
# orden y con sus filas invertidas. Las sumas son las mismas en aritmética
# exacta; si cambian cifras, cambian por ruido de coma flotante, y solo
# deberían cambiar en empates exactos.
# Uso: Rscript /tmp/slep_s32_traslado/diag_orden.R
suppressPackageStartupMessages(library(dplyr))
source(here::here("30_procesamiento", "36_funciones_trayectorias.R"))
ins <- leer_insumos_trayectorias()
A <- construir_datos_trayectorias(ins, conservar_brutos = TRUE)
ins_inv <- ins; ins_inv$simce <- ins$simce[rev(seq_len(nrow(ins$simce))), ]
B <- construir_datos_trayectorias(ins_inv, conservar_brutos = TRUE)
claves <- list(datos = c("id", "anio", "np", "g", "panel"), nube = c("com", "anio", "np", "g"))
for (tabla in c("datos", "nube")) {
  x <- inner_join(A[[tabla]], B[[tabla]], by = claves[[tabla]], suffix = c("", "_b"))
  stopifnot(nrow(x) == nrow(A[[tabla]]), nrow(x) == nrow(B[[tabla]]))
  brutos_distintos <- sum(x$ade_bruto != x$ade_bruto_b) + sum(x$ins_bruto != x$ins_bruto_b)
  cifras_distintas <- sum(x$ade != x$ade_b) + sum(x$ins != x$ins_b)
  casi <- function(b) abs(b / 0.1 - floor(b / 0.1) - 0.5) < 1e-9
  en_empate <- sum(x$ade != x$ade_b & casi(x$ade_bruto)) + sum(x$ins != x$ins_b & casi(x$ins_bruto))
  cat(tabla, "| brutos distintos:", brutos_distintos, "| cifras publicadas distintas:",
      cifras_distintas, "| de ellas en empate:", en_empate, "\n")
}
````

`diag_orden2.R`:

````r
# R-16 por otra vía: la misma sensibilidad al orden de suma con otra permutación
# (filas ordenadas por rbd, anio, nivel y prueba, en vez de invertidas).
# Solo lectura; solo conteos. Uso: Rscript /tmp/slep_s32_traslado/diag_orden2.R
suppressPackageStartupMessages(library(dplyr))
source(here::here("30_procesamiento", "36_funciones_trayectorias.R"))
ins <- leer_insumos_trayectorias()
A <- construir_datos_trayectorias(ins, conservar_brutos = TRUE)
s <- ins$simce
ins$simce <- s[order(as.character(s$rbd), s$anio, s$nivel, s$prueba), ]
B <- construir_datos_trayectorias(ins, conservar_brutos = TRUE)
claves <- list(datos = c("id", "anio", "np", "g", "panel"), nube = c("com", "anio", "np", "g"))
casi <- function(b) abs(b / 0.1 - floor(b / 0.1) - 0.5) < 1e-9
tot <- c(brutos = 0, cifras = 0, en_empate = 0)
for (tabla in names(claves)) {
  x <- inner_join(A[[tabla]], B[[tabla]], by = claves[[tabla]], suffix = c("", "_b"))
  stopifnot(nrow(x) == nrow(A[[tabla]]))
  tot <- tot + c(sum(x$ade_bruto != x$ade_bruto_b) + sum(x$ins_bruto != x$ins_bruto_b),
                 sum(x$ade != x$ade_b) + sum(x$ins != x$ins_b),
                 sum(x$ade != x$ade_b & casi(x$ade_bruto)) + sum(x$ins != x$ins_b & casi(x$ins_bruto)))
}
cat("brutos distintos:", tot[["brutos"]], "| cifras publicadas distintas:", tot[["cifras"]],
    "| de ellas en empate:", tot[["en_empate"]], "\n")
````

`auditoria_r.R`:

````r
# Re-derivaciones en R para FASE R del encargo traslado_trayectorias (solo lectura).
# Uso: Rscript /tmp/slep_s32_traslado/auditoria_r.R <id>   (desde la raíz del repo)
# R base sobre el parquet, sin dplyr y sin cargar 36_funciones_trayectorias.R;
# el DATA del HTML se lee con readBin + jsonlite::parse_json (la batería usa
# readLines + fromJSON/V8). No imprime filas de datos: solo conteos y booleanos,
# salvo la celda que el encargo fija para R-20.
id <- commandArgs(trailingOnly = TRUE)[1]
HTML   <- "40_salidas/trayectorias_traspasos.html"
MOCKUP <- "50_documentacion/andamios/mockup_trayectoria_traspasos.html"

texto_utf8 <- function(ruta) {
  s <- rawToChar(readBin(ruta, "raw", file.size(ruta)))
  Encoding(s) <- "UTF-8"
  s
}
data_html <- function(ruta) {
  s <- texto_utf8(ruta)
  i <- regexpr("var DATA=", s, fixed = TRUE)
  stopifnot(i > 0)
  r <- substr(s, i + nchar("var DATA="), nchar(s))
  j <- regexpr(";\n</script>", r, fixed = TRUE)
  stopifnot(j > 0)
  jsonlite::parse_json(substr(r, 1L, j - 1L))
}

# Base válida y universo del ancla, en R base.
base_r <- function() {
  s <- as.data.frame(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet"))
  ok <- !is.na(s$palu_eda_ade) & !is.na(s$palu_eda_ele) & !is.na(s$palu_eda_ins) & !is.na(s$nalu)
  suma <- s$palu_eda_ade + s$palu_eda_ele + s$palu_eda_ins
  b <- s[ok & suma >= 99 & suma <= 101, ]
  b$rbd <- as.character(b$rbd)
  b$com <- as.character(b$cod_com_rbd)
  b$np  <- paste0(b$nivel, "_", b$prueba)
  b
}
catalogo_r <- function() {
  c <- as.data.frame(arrow::read_parquet("40_salidas/intermedios/sleps_chile.parquet"))
  unique(data.frame(cod_slep = as.character(c$cod_slep), rbd = as.character(c$rbd)))
}
ancla_r <- function(b, cat_rbd) {
  anio0 <- min(b$anio)
  en_ancla <- unique(b$rbd[b$anio == anio0])
  b[as.character(b$cod_depe2) == "1" & !(b$rbd %in% cat_rbd) & b$rbd %in% en_ancla, ]
}
# Filas de DATA (listas) a data.frame con las columnas dadas.
filas_df <- function(filas, col) {
  d <- as.data.frame(lapply(seq_along(col), function(k)
    vapply(filas, function(f) as.character(f[[k]]), character(1))), stringsAsFactors = FALSE)
  names(d) <- col
  d
}
suma_por <- function(v, clave) tapply(v, clave, sum)

if (id == "R-12") {
  D <- data_html(HTML)
  cat(length(D$anios), length(D$meta), length(D$datos), length(D$nube), length(D$comunas), "\n")
}

if (id == "R-13") {
  b <- base_r(); catl <- catalogo_r(); mun <- ancla_r(b, unique(catl$rbd))
  D <- data_html(HTML)
  dd <- filas_df(D$datos, c("id", "anio", "np", "g", "panel", "ade", "ins", "n", "e"))
  nb <- filas_df(D$nube, c("com", "anio", "np", "g", "ade", "ins", "n"))
  # Servicios Locales: panel 0, total T, sin la serie "todo".
  sl <- merge(b, catl, by = "rbd")
  r_sl <- suma_por(sl$nalu, paste(sl$cod_slep, sl$anio, sl$np))
  h_sl <- dd[dd$id != "REF" & dd$g == "T" & dd$panel == "0" & dd$np != "todo", ]
  v_sl <- setNames(as.numeric(h_sl$n), paste(h_sl$id, h_sl$anio, h_sl$np))
  # Referente.
  r_ref <- suma_por(mun$nalu, paste("REF", mun$anio, mun$np))
  h_ref <- dd[dd$id == "REF" & dd$g == "T" & dd$panel == "0" & dd$np != "todo", ]
  v_ref <- setNames(as.numeric(h_ref$n), paste(h_ref$id, h_ref$anio, h_ref$np))
  # Nube.
  r_nb <- suma_por(mun$nalu, paste(mun$com, mun$anio, mun$np))
  h_nb <- nb[nb$g == "T" & nb$np != "todo", ]
  v_nb <- setNames(as.numeric(h_nb$n), paste(h_nb$com, h_nb$anio, h_nb$np))
  des <- function(r, v) {
    if (!setequal(names(r), names(v))) return(NA)
    sum(r[names(v)] != v)
  }
  cat("desajustes SL/REF/nube:", des(r_sl, v_sl), des(r_ref, v_ref), des(r_nb, v_nb),
      "| combinaciones:", length(v_sl), length(v_ref), length(v_nb), "\n")
  cat("referente (RBD distintos):", length(unique(mun$rbd)),
      "| comunas de la nube:", length(unique(mun$com)), "\n")
  h <- texto_utf8(HTML)
  cat("notas: 'los 1.333 establecimientos':", grepl("los 1.333 establecimientos", h, fixed = TRUE),
      "| '(180 en total)':", grepl("(180 en total)", h, fixed = TRUE), "\n")
}

if (id == "R-14") {
  A <- data_html(HTML); M <- data_html(MOCKUP)
  plano <- function(x) { u <- unlist(x); list(names(u), as.character(u)) }
  iguales <- vapply(c("anios", "meta", "nac", "comunas"),
                    function(k) identical(plano(A[[k]]), plano(M[[k]])), logical(1))
  cat("anios/meta/nac/comunas iguales:", iguales, "\n")
  for (t in c("datos", "nube")) {
    col <- if (t == "datos") c("id", "anio", "np", "g", "panel", "ade", "ins", "n", "e") else
      c("com", "anio", "np", "g", "ade", "ins", "n")
    k <- if (t == "datos") 1:5 else 1:4
    a <- filas_df(A[[t]], col); m <- filas_df(M[[t]], col)
    ka <- do.call(paste, a[k]); km <- do.call(paste, m[k])
    stopifnot(!anyDuplicated(ka), !anyDuplicated(km))
    idx <- match(ka, km)
    sin_pareja <- sum(is.na(idx)) + sum(!(km %in% ka))
    mm <- m[idx[!is.na(idx)], ]; aa <- a[!is.na(idx), ]
    cont <- sum(as.numeric(aa$n) != as.numeric(mm$n)) +
      if (t == "datos") sum(as.numeric(aa$e) != as.numeric(mm$e)) else 0
    cif <- sum(as.numeric(aa$ade) != as.numeric(mm$ade)) + sum(as.numeric(aa$ins) != as.numeric(mm$ins))
    lejos <- sum(abs(as.numeric(aa$ade) - as.numeric(mm$ade)) > 0.1 + 1e-9) +
      sum(abs(as.numeric(aa$ins) - as.numeric(mm$ins)) > 0.1 + 1e-9)
    cat(t, "| filas:", nrow(a), nrow(m), "| sin pareja:", sin_pareja, "| conteos distintos:", cont,
        "| cifras distintas:", cif, "| a más de un décimo:", lejos, "\n")
  }
}

if (id == "R-15") {
  # Empates exactos en la nube, total T (niveles-pruebas y serie "todo"), en R base.
  b <- base_r(); mun <- ancla_r(b, unique(catalogo_r()$rbd))
  A <- data_html(HTML); M <- data_html(MOCKUP)
  col <- c("com", "anio", "np", "g", "ade", "ins", "n")
  a <- filas_df(A$nube, col); m <- filas_df(M$nube, col)
  a <- a[a$g == "T", ]; m <- m[m$g == "T", ]
  km <- paste(m$com, m$anio, m$np); ka <- paste(a$com, a$anio, a$np)
  m <- m[match(ka, km), ]
  todo <- mun; todo$np <- "todo"; u <- rbind(mun, todo)
  clave <- paste(u$com, u$anio, u$np)
  S0 <- suma_por(as.numeric(u$nalu), clave)[ka]
  res <- c()
  for (v in c("ade", "ins")) {
    S1 <- suma_por(as.numeric(u$nalu) * round(u[[paste0("palu_eda_", v)]] * 10), clave)[ka]
    empate <- ((2 * S1 - S0) %% (2 * S0)) == 0
    dif <- as.numeric(a[[v]]) != as.numeric(m[[v]])
    res <- rbind(res, c(celdas = length(ka), empates_exactos = sum(empate),
                        distintas = sum(dif), distintas_en_empate_exacto = sum(dif & empate),
                        n_igual = sum(as.numeric(a$n) == S0)))
  }
  rownames(res) <- c("ade", "ins"); print(res)
}

if (id == "R-17") {
  sc <- arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet", as_data_frame = FALSE)$schema
  cat("tipos Arrow: nalu", sc$GetFieldByName("nalu")$type$ToString(),
      "| palu_eda_ade", sc$GetFieldByName("palu_eda_ade")$type$ToString(),
      "| palu_eda_ins", sc$GetFieldByName("palu_eda_ins")$type$ToString(), "\n")
  s <- as.data.frame(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet"))
  p <- c(s$palu_eda_ade, s$palu_eda_ins); p <- p[!is.na(p)]
  cat("desviación máxima de palu a un decimal:", max(abs(round(p, 1) - p)), "\n")
}

if (id == "R-20" || id == "R-30") {
  b <- base_r(); mun <- ancla_r(b, unique(catalogo_r()$rbd))
  lc <- mun[mun$com == "13114" & mun$anio == 2023 & mun$np == "4b_lect", ]
  recuento <- as.numeric(sum(lc$nalu))
  h <- texto_utf8(HTML)
  fila <- regmatches(h, gregexpr('\\["13114",2023,"4b_lect","T",[^]]*\\]', h))[[1]]
  n_html <- as.numeric(jsonlite::parse_json(fila[1])[[7]])
  igual <- function(x, y) isTRUE(all.equal(x, y, tolerance = 0))
  if (id == "R-20") {
    cat("filas del parquet en la celda:", nrow(lc), "| RBD:", length(unique(lc$rbd)),
        "| filas del HTML con la clave:", length(fila), "\n")
    cat("recuento desde el parquet:", recuento, "| n del HTML:", n_html,
        "| comparación:", if (igual(recuento, n_html)) "iguales" else "DISTINTOS", "\n")
  } else {
    cat("recuento:", recuento, "contra 270 | comparación:",
        if (igual(recuento, 270)) "iguales" else "DISTINTOS", "\n")
  }
}
````

### FASE L: cierre del log

**Verificación:**

`git status --porcelain`

esperado: según el encargo, solo el LOG, este encargo y el registro de errores del redactor. Con T1 congelada se prevén además ` M` en `.gitignore` y `00_build.R` y `??` en los cuatro `36_*`; eso se anota como hallazgo (R-27) y no se limpia
obtenido:

```text
 M .gitignore
 M 00_build.R
?? 30_procesamiento/36_funciones_trayectorias.R
?? 30_procesamiento/36_generar_trayectorias.R
?? 30_procesamiento/36_trayectorias_template.html
?? 30_procesamiento/36_verificar_trayectorias.R
?? 50_documentacion/activa/encargos/encargo_traslado_trayectorias.md
?? 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md
?? 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
```

`git log 760ce01..HEAD --oneline; echo "commits: $(git rev-list --count 760ce01..HEAD)"`

esperado: ningún commit desde el punto de retorno (`commits: 0`); el `docs(log)` todavía no existe
obtenido: commits: 0

**Estado:** completada. Estos rótulos se anexan antes de las verificaciones finales del archivo (privacidad y conteos), para que esas verificaciones cubran el log entero; por eso aquí la verificación no va toda primero.

**Commits:** `docs(log): traslado de la vista de trayectorias (s32)`, con el LOG, el encargo y el registro de errores del redactor. El hash va en el reporte final, porque el archivo no puede contener su propio hash.

**Cambios sustantivos:** se rellenaron C.1 a C.10 y el bloque J. Aparte de la corrección de R-02, declarada en C.10, son las únicas ediciones sobre texto ya escrito: rellenan los espacios que FASE 0 dejó vacíos.

**Alcance:** el commit de esta fase trae solo las tres rutas de «Todas» del ALCANCE.

**Regresión:** no tocó código.

**Subagentes:** sin subagentes, por contrato.

**Bugs:** ninguno.

**Decisiones autónomas:**
1. Sin push. La autorización 3 exige árbol limpio, y tras el commit del LOG quedan sin commit las seis rutas de T1 congelada. Alternativa descartada: ninguna legal (el encargo prohíbe `restore`, `reset` y `checkout --`, y commitear T1 sería levantar la congelación). Reversible: el commit queda local.

**Errores propios:** ninguno en esta fase.

**Dudas:** ninguna nueva; las consolidadas están en C.7.

Verificaciones finales del archivo:

Medición complementaria, no inventariada ni auditada en FASE R; sostiene una nota de C.9 (grupos faltantes):

`Rscript -e 's <- as.data.frame(arrow::read_parquet("40_salidas/intermedios/simce_rbd.parquet")); ok <- !is.na(s$palu_eda_ade) & !is.na(s$palu_eda_ele) & !is.na(s$palu_eda_ins) & !is.na(s$nalu); su <- s$palu_eda_ade + s$palu_eda_ele + s$palu_eda_ins; ok <- ok & su >= 99 & su <= 101; cat("filas válidas sin cod_grupo:", sum(is.na(s$cod_grupo[ok])), "de", sum(ok), "\n")' 2>&1 | grep -v out-of-sync; grep -oE '"(T|[0-9]+)",(0|1),' 40_salidas/trayectorias_traspasos.html | wc -l | tr -d ' '; grep -oE ',null,' 40_salidas/trayectorias_traspasos.html | wc -l | tr -d ' '`

esperado: filas válidas sin `cod_grupo`: `0`; se anota el número de filas de `datos` con grupo y panel reconocibles (`"g",panel,`), que debe ser 12916; ningún `,null,` en el HTML
obtenido:

```text
filas válidas sin cod_grupo: 0 de 142353 
14059
2
```

La medición anterior no midió lo que decía su esperado (error propio del instrumento, no del repositorio): el patrón `"g",panel,` también calza en filas de `nube` cuyo `ade` es exactamente 0 o 1, de ahí 14059; y hay dos `,null,` en el HTML, sin ubicar. Se re-mide por bloque:

`grep -oE ',null,' 30_procesamiento/36_trayectorias_template.html | wc -l | tr -d ' '; Rscript -e 's <- rawToChar(readBin("40_salidas/trayectorias_traspasos.html", "raw", 2e7)); i <- regexpr("var DATA=", s, fixed = TRUE); r <- substr(s, i, nchar(s)); d <- substr(r, 1, regexpr(";\n</script>", r, fixed = TRUE)); cat("null en el literal DATA:", lengths(regmatches(d, gregexpr("null", d, fixed = TRUE))), "\n"); D <- jsonlite::parse_json(substr(d, 10, nchar(d) - 1)); cat("filas de datos/nube con g nulo:", sum(vapply(D$datos, function(f) is.null(f[[4]]), logical(1))), sum(vapply(D$nube, function(f) is.null(f[[4]]), logical(1))), "\n")' 2>&1 | grep -v out-of-sync`

esperado: si los dos `,null,` vienen del código de la plantilla y no de los datos: `2` en la plantilla; `null en el literal DATA: 0`; `filas de datos/nube con g nulo: 0 0`
obtenido:

```text
2
null en el literal DATA: 0 
filas de datos/nube con g nulo: 0 0 
```

Corrección a los rótulos de esta sección (cita «**Errores propios:** ninguno en esta fase»): hubo un error propio en FASE L, el patrón `grep` impreciso de la medición complementaria, re-medido por bloque. Está registrado en C.8 (error 4).

`grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md`

esperado: vacío (privacidad: ningún RUT)
obtenido: (sin salida) [código de salida 1]

`printf '%s.%s.%s-%s\n' 12 345 678 9 | grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'`

esperado: control positivo del patrón de privacidad, sin escribir el valor en el log: un RUT ficticio armado por partes da `1` (solo el conteo sale a la salida)
obtenido: 1

`grep -ciE 'tom[aá]s|gonz[aá]lez|cifuentes' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md; grep -ciE 'tom[aá]s|gonz[aá]lez' 30_procesamiento/36_generar_trayectorias.R`

esperado: chequeo propio de nombres de personas: `0` en el log; control positivo del patrón: `1` o más en `36_generar_trayectorias.R`, cuyo encabezado de licencia trae el nombre del autor
obtenido:

```text
2
1
```

`ls -l 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md | awk '{print $1, $5, $NF}' && wc -l 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md`

esperado: el archivo existe; se anotan su tamaño y sus líneas
obtenido:

```text
-rw-r--r-- 104349 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
    1584 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
```

`echo "secciones FASE: $(grep -c "^### FASE" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md); J: $(grep -c "^## J" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md); esperado: $(grep -c "^esperado:" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md); obtenido: $(grep -c "^obtenido:" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md)"`

esperado: `secciones FASE: 4` (FASE 0, FASE 1, FASE R y FASE L, las cuatro ejecutadas); `J: 1`; `esperado` supera en 1 a `obtenido` (la línea `obtenido:` de esta medición se escribe después de contar; tras escribirla quedan iguales)
obtenido: secciones FASE: 4; J: 1; esperado: 83; obtenido: 82

El chequeo de nombres dio `2` con esperado `0`. Se ubican las dos líneas (solo número de línea y el fragmento que calza):

`grep -noiE 'tom[aá]s|gonz[aá]lez|cifuentes' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md | grep -v "$(grep -n 'grep -noiE' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md | cut -d: -f1):"; git log --oneline -1 d510754; git show 760ce01:50_documentacion/andamios/logs/20260923_retiro_cdn_v8_log.md | grep -c 'MacBook-Pro-de-Tomas.local'`

esperado: hipótesis: una de las dos es la línea del propio comando del chequeo (el patrón trae `cifuentes` literal) y la otra es el nombre de la estación `MacBook-Pro-de-Tomas.local` del encabezado ENTORNO, que ya está en la historia del repositorio (commit `d510754`) y en el log versionado de la sesión 31; ninguna es un dato de persona
obtenido:

```text
9:Tomas
1572:cifuentes
1601:cifuentes
1601:Tomas
d510754 chore(estado): abre sesion en MacBook-Pro-de-Tomas.local
1
```

Corrección a los rótulos de esta sección (cita la corrección anterior, que registraba un error propio de FASE L): hubo un segundo, el esperado autorreferente del chequeo de nombres (C.8, error 5; C.9, privacidad). Se repiten las verificaciones finales sobre el log completo:

`grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md; echo "líneas con patrón de RUT: $(grep -cE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md)"`

esperado: `líneas con patrón de RUT: 0`
obtenido: líneas con patrón de RUT: 0

`ls -l 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md | awk '{print $1, $5, $NF}' && wc -l 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md`

esperado: el archivo existe; se anotan su tamaño y sus líneas finales antes del commit
obtenido:

```text
-rw-r--r-- 107955 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
    1624 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md
```

`echo "secciones FASE: $(grep -c "^### FASE" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md); J: $(grep -c "^## J" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md); esperado: $(grep -c "^esperado:" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md); obtenido: $(grep -c "^obtenido:" 50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md)"`

esperado: `secciones FASE: 4`; `J: 1`; `esperado` supera en 1 a `obtenido` (la línea `obtenido:` de esta medición se escribe después de contar; tras escribirla quedan iguales)
obtenido: secciones FASE: 4; J: 1; esperado: 87; obtenido: 86
