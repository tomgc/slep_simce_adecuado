# Errores del asistente, sesión 31 (registro en el momento)

Se vuelca a §15 del traspaso v31 con los diez campos de SETTINGS §2.2.15.

**ERR-31-01**
- `momento`: apertura de emergencia, al preparar el árbol para el cierre v30.
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: ejecuté `git restore --staged --worktree` desde el puente de Cowork, que no puede borrar archivos, y el comando dejó un `.git/index.lock` huérfano nuevo, del mismo tipo que el que acababa de retirar.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»; instrucción ⚠️ del traspaso v30 sobre operar git desde el puente.
- `causa_raiz`: leí la restricción del puente como «sin credenciales» (lo que impide commitear) y no como «sin permiso de borrado» (lo que impide a git soltar su propio candado), aunque el candado de 2026-09-09 era evidencia directa de lo segundo.
- `salvaguarda_presente`: SETTINGS y traspaso v30.
- `patron`: PAT-03, sobre capacidades de escritura de git en el puente.
- `gatillo_observable`: comando-entorno: un comando de git que escribe el índice se lanzó en una máquina donde `rm` falla con «Operation not permitted».
- `intentos_previos`: 0.
- `costo`: un candado huérfano más, retirado con `mv` a `_archivo/20260923/`; ESTADO.md restaurado con `git show HEAD:` en vez de `git restore`.

**ERR-31-02**
- `momento`: redacción de `encargo_retiro_cdn_v8.md`, criterio de T2 sobre marcadores.
- `disparador`: el ejecutor lo detectó (T2 congelada, duda D1).
- `que_paso`: escribí `grep -c -F '__REACT'` sobre la página entera para afirmar que se reemplazaron dos marcadores, y el prefijo aparece dentro de ReactDOM (`__REACT_DEVTOOLS_GLOBAL_HOOK__`).
- `regla_violada`: regla 12 de `50_diseno_ramas_deteccion.md`, redactada por mí en la misma sesión, minutos antes.
- `causa_raiz`: apliqué la regla 12 a los criterios que marqué con universo explícito y no a este, que escribí como abreviatura del par de marcadores; abreviar el patrón amplió el universo sin que lo viera.
- `salvaguarda_presente`: `50_diseno_ramas_deteccion.md` (regla 12) y SETTINGS §1.2.6.
- `patron`: PAT-13, criterio que mide un proxy (un prefijo) y no la afirmación (dos marcadores).
- `gatillo_observable`: encargos-premisas: un patrón abreviado sobre un archivo que incluye código de terceros.
- `intentos_previos`: 0.
- `costo`: T2 congelada, una vuelta de dudas con el titular.

**ERR-31-03**
- `momento`: redacción del encargo, tercer 🔒 (payload idéntico).
- `disparador`: el ejecutor lo detectó (🔒 3 en FALLA, duda D2).
- `que_paso`: exigí md5 idéntico del payload comprimido sin inspeccionar que el generador escribe `fecha_generacion = format(Sys.Date())` dentro del JSON.
- `regla_violada`: SETTINGS §1.2.6, «fuente primaria de una estructura es su inspección».
- `causa_raiz`: supuse que el payload dependía solo de los parquet porque los datos no cambiaron; no leí el bloque del generador que arma `meta`.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre la forma de un objeto supuesta y no inspeccionada.
- `gatillo_observable`: afirmar-sin-leer: se fijó un invariante byte a byte sobre un artefacto cuyo constructor no se leyó.
- `intentos_previos`: 0.
- `costo`: 🔒 en FALLA falso y T2 sin commit.

**ERR-31-04**
- `momento`: redacción del encargo, FASE 0.
- `disparador`: el ejecutor lo detectó.
- `que_paso`: escribí `git rev-parse --short HEAD origin/main`, que no corre porque `--short` implica `--verify` y admite una sola revisión.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»; encargo v1.6 §2.10 ítem 13 por analogía (comando no probado).
- `causa_raiz`: combiné dos mediciones en un comando sin correrlo, pese a tener un shell disponible donde probarlo.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-03, sobre la sintaxis de una herramienta no probada.
- `gatillo_observable`: comando-entorno: un comando del encargo que nunca se ejecutó antes de enviarlo.
- `intentos_previos`: 0.
- `costo`: una re-medición por dos vías del ejecutor; ninguno hacia fuera.

**ERR-31-05**
- `momento`: edición de `33_generar_html.R` antes del encargo.
- `disparador`: el ejecutor lo detectó y lo corrigió.
- `que_paso`: el reemplazo que insertó el Bloque 3b duplicó la línea separadora que abre el Bloque 4.
- `regla_violada`: SETTINGS §1.2.6, «generar, verificar, consumar»: no miré el `diff` del generador antes de entregarlo.
- `causa_raiz`: verifiqué la plantilla con su `diff` y el generador solo con `grep` de marcadores.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-02, sobre entregar sin revisar el `diff` completo.
- `gatillo_observable`: otro: archivo editado entregado sin leer su `diff`.
- `intentos_previos`: 0.
- `costo`: una línea corregida por el ejecutor.

**ERR-31-06**
- `momento`: redacción de `encargo_retiro_cdn_v8_adenda.md`.
- `disparador`: el ejecutor lo detectó (Duda 1 de la adenda, ADVIERTE R-16).
- `que_paso`: agregué al ALCANCE de la adenda el registro de errores, que vive en `andamios/`, y dejé heredado sin cambio el 🔒 5 que admitía solo el LOG en esa carpeta.
- `regla_violada`: `50_diseno_ramas_deteccion.md`, regla 8 (recorrer el camino nominal antes de entregar).
- `causa_raiz`: edité el ALCANCE en un segundo paso, para cuadrar FASE 0, y no volví a leer los invariantes heredados contra el cambio.
- `salvaguarda_presente`: `50_diseno_ramas_deteccion.md`.
- `patron`: PAT-07, sobre una restricción propia no propagada a otra sección del mismo encargo.
- `gatillo_observable`: encargos-premisas: una ruta nueva en ALCANCE cae bajo un 🔒 heredado que la excluye.
- `intentos_previos`: 0.
- `costo`: una duda abierta; el ejecutor aplicó la lectura correcta y no hubo rehecho.

**ERR-31-07**
- `momento`: redacción de `encargo_simce2025_final.md`, 🔒 2.
- `disparador`: el ejecutor lo detectó (T2 congelada, R-11 BLOQUEA).
- `que_paso`: tomé como línea base los parquet de `40_salidas/intermedios/` sin comprobar de qué build venían; `simce_rbd.parquet` era del 2026-07-11 y salió de la rama local `feat/contrato-contexto`, con cinco columnas que `main` no escribe.
- `regla_violada`: SETTINGS §1.2.6, marcador S-01 tipo 4 (premisa de hecho de un encargo) y «fuente primaria de una estructura es su inspección».
- `causa_raiz`: la carpeta está ignorada por git y la traté como si fuera producto de `HEAD`; la fecha del parquet (11 de julio, anterior a sesiones de `main` que no lo reconstruyeron) estaba a la vista en el `ls -la` que yo mismo corrí al inicio de la sesión.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre el origen de un artefacto ignorado por git supuesto y no medido.
- `gatillo_observable`: encargos-premisas: un 🔒 byte a byte contra un archivo no versionado cuya procedencia no se midió.
- `intentos_previos`: 0.
- `costo`: T2 congelada, push retenido, una vuelta de dudas.

**ERR-31-08**
- `momento`: gates visuales en Chromium del retiro del CDN y de la base 2025 final.
- `disparador`: usuario lo señaló sin nombrarlo error (captura con rótulos superpuestos en la vista de comparación).
- `que_paso`: di por revisado el render comparando píxeles contra la versión publicada y mirando solo la captura del panorama; nunca miré las barras «Últimas 3 aplicaciones» de la vista de comparación, donde los rótulos de Adecuado y Elemental se pisan cuando Adecuado es delgado.
- `regla_violada`: aviso 9 del mensaje de apertura de esta sesión (mirar lo visual renderizado con una lista de forma, no solo de datos); aprendizaje 6 del traspaso v30.
- `causa_raiz`: una comparación de píxeles contra el publicado prueba que no hubo regresión, no que la forma esté bien; la usé como si probara lo segundo, y la lista de forma no existió.
- `salvaguarda_presente`: mensaje de apertura del titular y traspaso v30 §7.6.
- `patron`: PAT-NUEVO-revision-visual-sin-lista, segunda sesión con el mismo mecanismo (propuesta del traspaso v30).
- `gatillo_observable`: otro: gate visual declarado sin recorrer cada tipo de gráfico con una lista de forma.
- `intentos_previos`: 0.
- `costo`: un defecto de forma publicado llegó al titular por segunda sesión seguida.
