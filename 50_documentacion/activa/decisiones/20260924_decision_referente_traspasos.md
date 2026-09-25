# Decisión: referente y cohortes futuras de la vista de trayectorias

**Fecha:** 2026-09-24 (sesión 35). **Deciden:** el titular (D35-1 y el alcance de D35-2) sobre la propuesta
del asistente; la metodología de D35-2 es del asistente, informada.
**Reemplaza:** D32-2 (`20260924_decision_datos_vista_trayectorias.md`), cuya regla de universo sigue vigente
y se amplía aquí. Resuelve el pendiente 1 de v34 y levanta D34-4 para el rótulo y las marcas de ola.
**Contexto medido:** `50_documentacion/andamios/20260924_contexto_referente_trayectorias.html` (md5
`7d2c0f2a8584ca79a1ce64ab32d262c5`). Las cifras de este archivo salen de recuentos de la sesión 35 sobre
`simce_rbd.parquet`, `sleps_chile.parquet`, `establecimientos_chile.parquet` y
`slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv`, con la regla de filas D33-1 y el
redondeo D32-3.

## D35-1. El referente sigue siendo el grupo anclado en 2014 (opción A), con rótulo explícito y marca de ola

**Contexto.** El titular esperaba que el referente bajara con cada ola de traspaso. La medición de la
sesión 35 encontró tres cosas:

1. Ninguno de los 1.299 establecimientos del referente se traspasó entre 2014 y 2025. De ellos, 1.282 están
   en el directorio oficial como municipales en comunas de las olas 2027 (475), 2028 (406) y 2029 (401) (corregido tras el encargo: ver D35-4). Los
   otros 17 no figuran en el directorio: cerraron antes de su traspaso, y su último resultado es de 2014 a
   2018. El número de la leyenda (994 a 1.124 en 4° básico Lectura) cambia porque la Agencia publica
   resultados distintos cada año, no porque cambie el grupo (A34-5).
2. La regla vigente ya hace que el referente baje con cada ola. Solo suma filas con `cod_depe2 == "1"`, y un
   establecimiento traspasado cambia de dependencia. Con datos de 2027 quedarían 807 establecimientos, con
   los de 2028 quedarían 401 y con los de 2029, 0 (corregido tras el encargo: ver D35-4). El referente se acaba con la ola 2029.
3. Un referente dinámico (opción B: los municipales fuera del catálogo en cada año, sin ancla) suma 313
   establecimientos sin resultado en 2014. Queda entre 1,2 y 1,8 puntos bajo A en la serie combinada (0,0 a
   0,2 en 4° básico Lectura), sin que cambie el aprendizaje de ningún establecimiento.

**Decisión.** Se mantiene el universo de D32-2 (opción A) y se agregan dos reglas de presentación:

- **Rótulo.** La leyenda dice el tamaño del grupo y, aparte, cuántos tienen resultado en el año y la prueba
  elegidos. Texto de la maqueta aprobada: «Referente: 1.299 municipales que se traspasan entre 2027 y 2029 ·
  con resultado en 2025: 1.015». El 1.299 sale de `meta$REF$cat` y el segundo número sale de `e` en el año y
  la prueba elegidos; ninguno de los dos se escribe como literal. Las notas metodológicas agregan que 17 de
  los 1.299 cerraron antes de traspasarse. Cuando haya datos posteriores a una ola, el rótulo dice cuántos
  siguen municipales (maqueta: «807 de 1.282 aún municipales», corregida por D35-4).
- **Marca de ola.** Si la serie tiene un año igual o posterior a una ola, se dibuja en ese año una marca
  vertical rotulada («sale la ola 2027»). La razón es que la composición del grupo cambia. Con los mismos
  años, el grupo que queda tras la ola 2027 difiere del completo en hasta 1,1 puntos, y el que queda solo
  con la ola 2029 difiere en 3,2 a 4,5 puntos en 4° básico Lectura. Sin la marca, ese salto se leería como un
  cambio en el aprendizaje. Los años de marca se calculan en R y viajan en `DATA`, para que se puedan probar
  sin navegador.

**Alternativa descartada.** Opción B, el referente dinámico. Cambia de composición todos los años y mueve
el nivel entre 1,2 y 1,8 puntos, que es justo la distorsión que D34-4 pedía evitar. Además no aporta nada
frente a la expectativa original, porque A ya baja con cada ola cuando llegan los datos.

**Qué no cambia.** El universo, la regla de filas (D33-1), el redondeo (D32-3) y todas las cifras
publicadas. Con los datos actuales (2014 a 2025) no aparece ninguna marca de ola y el único cambio visible es
el rótulo.

## D35-2. Los Servicios Locales de las olas 2027 a 2029 entran a la vista, con su itinerario previo al traspaso

**Decisión del titular.** Aunque todavía no funcionan, sus establecimientos existen y tienen resultados. Se
muestran como cohortes, y su itinerario queda siempre previo al traspaso mientras no se traspasen.

**Metodología (asistente).**

- **Unidad.** Cada par (código de Servicio Local, año de traspaso) del catálogo `dim_slep_comunas.csv` es una
  unidad: 37 en total (13 en 2027, 11 en 2028 y 13 en 2029) para 36 códigos. Del Litoral (502) queda partido
  en dos unidades, porque Santo Domingo se traspasa en 2028. Dos códigos, Petorca (506) y Valle Diguillín
  (1601), ya existen en la vista con su cohorte 2026 y reciben comunas en 2027. Por eso toda unidad futura
  lleva el identificador `<cod_slep>_<año>` y nunca reutiliza el de una unidad vigente.
- **Nombre.** El `slep_formato` del catálogo. Si el código ya existe en la vista, el nombre agrega
  «(comunas que se traspasan en <año>)».
- **Establecimientos.** Los que el directorio (`establecimientos_chile.parquet`) registra con
  `cod_depe2 == "1"` en las comunas de la unidad: 2.564 en total, de los cuales 1.593 tienen algún resultado
  válido. Sus series usan las mismas reglas que las unidades vigentes: filas de cualquier dependencia, D33-1 y
  D32-3.
- **Cohorte.** `tras` es el año de la ola. `post` es 0 con los datos actuales, así que todo el itinerario se
  dibuja como «aún no traspasado».
- **Orden.** Las 36 unidades vigentes conservan su número (los primeros 36 lugares de `ORDEN_SLEP`). Las
  futuras van después, ordenadas por año de ola, luego de norte a sur por región (15, 1, 2, 3, 4, 5, 6, 7,
  16, 8, 9, 14, 10, 11, 12 y la Metropolitana al final) y luego por código.
- **Fuente del catálogo.** Una copia de `dim_slep_comunas.csv` se versiona en `20_insumos/auxiliares/`.
  `manifiesto_insumos.md` registra su md5 y el commit de origen de `slep_central_datos`, y la copia se agrega
  a `50_datos_versionados_autorizados.md`. Así el build no depende de otro repositorio (POLITICA §5.2).
- **Relación con el referente.** Sin cambio (D35-1). 1.282 de los 1.299 establecimientos del referente están
  en las unidades futuras, y los 17 restantes cerraron. El referente es, en la práctica, el agregado de las
  cohortes futuras, lo que coincide con su rótulo de «municipales por traspasar».
- **Vigencia del directorio.** El directorio todavía registra 630 municipales en las comunas de la ola 2026,
  así que es anterior a esa ola. La lista de establecimientos de cada unidad futura se actualiza cuando se
  actualiza el directorio (una vez al año).

**Alternativa descartada.** Reutilizar `sleps_chile.parquet` agregándole las unidades futuras. Ese archivo
también alimenta el motor, y el motor habría ganado 37 territorios sin que nadie lo pidiera.

**Qué no cambia.** El motor. En la vista, las 36 unidades vigentes y el referente conservan fila por fila
sus datos actuales.

## Batería (en `36_verificar_trayectorias.R`, escrita antes del código, cada prueba con control positivo)

| Prueba | Predicado |
|---|---|
| R1 | `meta$REF$cat` es 1.299 con los insumos vigentes |
| R2 | En la selección por defecto, el texto de la leyenda contiene `meta$REF$cat` formateado y el `e` del referente en ese año y prueba |
| R3 | En una copia de `simce_rbd` que agrega un año con `cod_depe2 == "5"` para los RBD de la ola 2027, el referente de ese año pierde exactamente esos RBD |
| R4 | Los años de marca de ola en `DATA` salen vacíos con los datos actuales y no vacíos con la copia de R3 |
| C1 | Hay 37 unidades futuras, con 13, 11 y 13 por ola |
| C2 | Ningún identificador futuro coincide con uno vigente |
| C3 | Las filas de `datos` de las 36 unidades vigentes y del referente son idénticas a las de antes del cambio |
| C4 | Toda unidad futura tiene `post == 0` con los datos actuales |
| C5 | La suma de establecimientos de las unidades futuras es 2.564 |

## Pendientes derivados

1. **Fin del referente.** Qué muestra la vista cuando, con datos de 2029, queden 5 municipales del grupo. Se
   decide cuando la Agencia publique el Simce 2028, que es el último con 401 o más (D35-4).
2. **Actualización anual del directorio.** Las unidades futuras dependen de su vigencia (ver D35-2).

El dato a verificar de la página de contexto (5 establecimientos en comunas ya traspasadas y fuera del
catálogo) queda resuelto: son 5 de los 17 que cerraron antes de su traspaso y no están en el directorio.

## Enmiendas tras el encargo `encargo_pendientes_s35.md` (sesión 35, 2026-09-25)

Deciden el titular sobre la propuesta del asistente, con el log
`50_documentacion/andamios/logs/20260924_pendientes_s35_log.md` (commit `bd5fc58`) y una verificación
independiente de solo lectura sobre la estación.

### D35-3. I-7 se evalúa como no-regresión sobre el rango del encargo

El único acierto de I-7 es `30_procesamiento/32_agregar_comunal.R:206` (`.by = c(nom_com_rbd, cod_grupo,
anio)`). Viene del commit `f3318d4` (2026-06-08), no cambia en `f4bd59e..bd5fc58` y solo imprime un
diagnóstico en consola después de escribir el parquet. El comando de I-7 del encargo se escribió sin correrlo
(ERR-35-05). Para ese encargo, I-7 se mide sobre las líneas agregadas en el rango: 0 aciertos. El veredicto
de FASE R pasa de BLOQUEADO a APROBADO CON ADVERTENCIAS y se autoriza el push. La línea 206 se corrige en el
encargo siguiente (agregar `cod_com_rbd` al `.by`), y desde ahí I-7 se mide en forma absoluta:
`grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`, con
resultado esperado vacío. El log del encargo queda congelado tal como se commiteó; esta enmienda es la que
registra el cambio de veredicto.

### D35-4. El referente se cuenta por ola con el directorio, y el rótulo lo dice

Reemplaza la regla que dejó el encargo en `olas_referente()`, que usa la comuna de la última fila Simce
(479/407/408, con 12 cerrados dentro y 5 cerrados fuera de las olas futuras). Desde ahora `meta$REF$olas` cuenta
los RBD del referente **presentes** en el directorio (no «municipales en el directorio», para que la
actualización anual del directorio no los saque por la razón equivocada): 475, 406 y 401, que suman 1.282.
«Aún municipales» descuenta desde el inicio a los 17 cerrados: 807, 401 y 0 tras cada ola. El rótulo pasa a
«Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 · con resultado en <año>: <e>», con
todas las cifras desde `DATA`. El rango de años del rótulo usa solo olas con conteo mayor que 0. Ninguna cifra de
aprendizaje cambia: la serie del referente se calcula con filas municipales de cada año. Corrige ERR-35-08.

### D35-5. La cifra dentro de la franja Elemental usa tinta oscura

El rótulo blanco dentro de la franja Elemental da 2,78:1 en las barras y en el panorama, desde antes del encargo.
Solo ese rótulo pasa a `TINTA_SOBRE_ELEM = "#2E2230"` (5,44:1), un color que ya existe en la plantilla. Las
franjas no cambian (D-color-nivel). I-8 se amplía para admitir esa constante.

### D35-6. «Un solo establecimiento» se marca con «†»

El «*» ya marca el dato preliminar en todo el motor. Hoy no hay años preliminares, pero volverá a haberlos con la
base preliminar del Simce 2026. `ASTERISCO_UNICO` pasa a «†». La cifra de la sparkline con un solo
establecimiento sigue la misma regla (sin atenuar, con «†»), y la leyenda de ChartHints declara el signo.
