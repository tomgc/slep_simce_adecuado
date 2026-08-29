# Encargo — Verificación de dudas abiertas de la sesión 29

> **Destino:** `50_documentacion/activa/encargos/encargo_verificacion_dudas_s29.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.
> **Redactado:** 2026-08-29, sesión 29 de `slep_simce_adecuado`.
> **Naturaleza:** **solo lectura**. Este encargo no edita ningún archivo
> versionado, no crea commits y no hace `push`. Su producto es evidencia.

---

## 0. Contrato

**MODO.** Autónomo, secuencial, todo en un turno. **No se admiten subagentes**
(tope duro: 0).

**ENTORNO.** macOS aarch64, filesystem local vía Claude Code. Proyecto R con
`renv`. Intérprete de todo bloque de comandos: **`bash`**, nunca el shell
interactivo del titular. R se invoca con `Rscript` desde la raíz del proyecto.
El aviso de `renv` desincronizado es esperado y no detiene nada. Se requiere
salida a internet para T1 (`curl` contra GitHub Pages); si no la hay, T1 se
congela y las demás siguen.

**Nota de entorno.** `grep` de macOS es BSD: interpreta `{…}` como expresión de
intervalo. Todo patrón con `{` o `}` va con `grep -F` *(A-s28-3)*. `grep` opera
línea a línea: ningún patrón de este encargo abarca más de una palabra ancla
*(regla 11)*.

**POSICIÓN.** Ruta absoluta completa en todos los comandos. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**INSUMOS.** Todo lo que se lee vive en ese repositorio, más una URL pública:
`https://tomgc.github.io/slep_simce_adecuado/`.

**Contexto en una frase.** La sesión 29 desplegó el panorama territorial y dejó
cuatro dudas cuya parte estática puede cerrarse midiendo, sin abrir navegador;
este encargo las mide y devuelve evidencia, no arreglos.

---

## 1. Estado de partida (premisas marcadas)

1. `HEAD` y `origin/main` están en `4e8f946`, working tree limpio *(fuente:
   `git rev-parse` y `git status --porcelain` ejecutados por Claude Code al
   cerrar la corrida anterior de esta sesión)*.
2. `docs/index.html` y `40_salidas/motor_comparacion.html` comparten md5
   `f00e9126b86fc703b001e55080de0969` *(fuente: `md5 -q` de ambos, T5 del log
   `20260829_pendientes_inmediatos_s29_log.md`)*.
3. El rótulo de porcentaje de una franja del panorama se dibuja solo si su
   altura en píxeles alcanza un umbral fijado en el código, y ese umbral,
   traducido a porcentaje, ronda el 7% *(hipótesis; el valor exacto se **deriva
   del código** en T2, no se toma de esta línea)*.
4. `construirSvgPanorama` no fija el atributo `xmlns` a mano; `construirSvgGraficos`
   sí lo fija y además serializa con `XMLSerializer`, lo que produciría un
   `xmlns` duplicado *(hipótesis, se mide en T3)*.
5. `xmlns="http://www.w3.org/2000/svg"` es un **falso positivo** conocido en las
   búsquedas de referencias de red: es una declaración de espacio de nombres, no
   una descarga *(fuente: aprendizaje A-xmlns / R-FALSO-POSITIVO-OFFLINE del
   proyecto)*.
6. Los parquet intermedios viven en `40_salidas/intermedios/` y `simce_comunal.parquet`
   es el insumo del motor *(fuente: `estructura_actual.md`, escáner del
   2026-08-28)*. **Sus nombres de columna no se dan por conocidos: se miden en
   FASE 0.**

---

## 2. Invariantes (🔒 intocables)

- 🔒 **Este encargo no escribe en el repositorio.** Ningún archivo versionado se
  edita, mueve, renombra ni elimina. No hay `git add`, `git commit`, `git mv`,
  `git checkout --`, `git reset` ni `git push`.
- 🔒 El único archivo que se crea es el log de §6, sin trackear y sin commitear.
- 🔒 Los scratch van a `/tmp`, nunca al árbol del proyecto.
- 🔒 No se ejecuta el pipeline ni se regenera el motor: `docs/index.html` y
  `40_salidas/motor_comparacion.html` deben terminar con el mismo md5 con el que
  empezaron, y eso se verifica al cerrar.
- 🔒 `cod_com_rbd` es la clave para agregar por comuna, nunca `nom_com_rbd`.
- 🔒 La segmentación por GSE de la vista de comparación no se toca ni se discute:
  T2 trabaja sobre la combinación del panorama, que es otra vista.

---

## 3. Autorizaciones (lista cerrada)

Estás autorizado a:

1. Leer cualquier archivo del repositorio.
2. Ejecutar `curl` contra `https://tomgc.github.io/slep_simce_adecuado/`.
3. Ejecutar `Rscript` con scripts **efímeros** que escribas en `/tmp`, que solo
   lean parquet y escriban a stdout o a `/tmp`.
4. Escribir el log de §6 en `50_documentacion/andamios/logs/`, sin commitearlo.

**Nada más.** Todo lo no listado está prohibido, en particular cualquier
escritura en el árbol versionado y cualquier operación de git que no sea
`status`, `log`, `rev-parse`, `ls-files` o `grep`.

---

## 4. Regla de detención

Cada tarea declara su conjunto de estados esperados. La lista cierra siempre con
esta cláusula residual:

> **Cualquier estado, conteo o resultado no enumerado: congela ESTA tarea,
> regístrala como duda en el log (§6.7) y sigue con la próxima tarea. Las cuatro
> tareas son independientes entre sí; ninguna detención justifica abortar la
> cadena.**

Tres reglas del proyecto gobiernan la redacción de este encargo y su ejecución:

- **Ninguna magnitud del proceso es criterio** *(regla 10)*. No se cuenta líneas
  de `diff`, de `status` ni commits. Aquí no hay commits.
- **Control positivo antes de creer en un cero** *(regla 4)*. Todo conteo cuyo
  valor esperado sea 0 exige demostrar, en el mismo turno, que el patrón
  encuentra el caso donde sí existe.
- **La fuente prueba la afirmación, no algo cercano** *(regla 6)*. Un md5 igual
  prueba identidad de bytes, no que el servidor sirva ese archivo a un
  navegador con caché.

---

## 5. Fases

### FASE 0 — Medición del punto de partida. Solo lectura.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R fetch --quiet --all --prune
git -C $R status --porcelain
git -C $R rev-parse HEAD origin/main
md5 -q $R/docs/index.html
md5 -q $R/40_salidas/motor_comparacion.html
ls -1 $R/40_salidas/intermedios/
Rscript -e 'x <- arrow::open_dataset("/Users/tomgc/Projects/slep_simce_adecuado/40_salidas/intermedios/simce_comunal.parquet"); print(x$schema)'
Rscript -e 'x <- arrow::open_dataset("/Users/tomgc/Projects/slep_simce_adecuado/40_salidas/intermedios/sleps_chile.parquet"); print(x$schema)'
```

**Estados esperados (conjunto completo).**

| Medición | Valor esperado |
|---|---|
| `git status --porcelain` | vacío, o exclusivamente artefactos sin versionar de **este** encargo: su `.md` y su log. Cualquier archivo **versionado** modificado: DETENTE |
| `rev-parse HEAD origin/main` | dos hashes idénticos, ambos `4e8f946` |
| md5 de `docs/index.html` | `f00e9126b86fc703b001e55080de0969` |
| md5 del motor generado | el mismo hash |
| `ls` de intermedios | seis `.parquet` |
| esquema de `simce_comunal` | se **transcribe literal** al log; nombres y tipos de columna quedan registrados antes de usarse |
| esquema de `sleps_chile` | igual |

Si el esquema no contiene las columnas que T2 necesita, T2 se congela con la
lista de columnas realmente disponibles. **No adaptes nombres por parecido.**

---

### T1 — ¿GitHub Pages sirve el build desplegado?

**Afirmación a probar:** el sitio publicado entrega, hoy, byte a byte, el mismo
archivo que `docs/index.html` en `origin/main`.

Un md5 local igual no prueba eso: prueba que el commit es correcto. Entre el
commit y el servidor hay un build de Pages y una caché.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
U=https://tomgc.github.io/slep_simce_adecuado/
curl -s -o /tmp/pages_index.html -w "http_code=%{http_code} size=%{size_download} tiempo=%{time_total}\n" "$U"
curl -sI "$U" | sed -n '1p;/[Ee][Tt]ag/p;/[Ll]ast-[Mm]odified/p;/[Aa]ge:/p;/[Cc]ache-[Cc]ontrol/p'
md5 -q /tmp/pages_index.html
md5 -q $R/docs/index.html
cmp /tmp/pages_index.html $R/docs/index.html && echo "IDENTICOS" || echo "DIFIEREN"
```

**Estados esperados.**

| Medición | Valor esperado |
|---|---|
| `http_code` | `200` |
| `cmp` | `IDENTICOS` |
| md5 del descargado | `f00e9126b86fc703b001e55080de0969` |

**Si difieren, no concluyas nada todavía: discrimina entre las tres causas.**

1. **Build de Pages aún en curso o caché intermedia.** Evidencia: el md5
   descargado coincide con el build **anterior**,
   `7dd16d922182df69e21ddb422a005bc7`. Repite el `curl` una sola vez más, tras
   `sleep 90`, y reporta ambos resultados. No entres en bucle.
2. **El sitio sirve otro archivo.** Evidencia: el md5 no coincide con ninguno de
   los dos hashes conocidos. Reporta el tamaño y las primeras 40 líneas del
   descargado.
3. **Sin salida a internet.** Evidencia: `http_code` distinto de `200` o `curl`
   con error de resolución. Congela T1 y dilo; no es un hallazgo sobre el sitio.

**Calibración.** Caso malo: declarar "Pages está al día" con un `http_code=200`
sin comparar bytes, o declarar "Pages está desactualizado" sin distinguir la
causa 1 de la 2. Caso bueno: `cmp` imprime `IDENTICOS`, o el reporte nombra cuál
de las tres causas se midió y con qué evidencia.

---

### T2 — ¿Cuántas franjas del panorama quedarían sin rótulo?

**Contexto.** En el panorama territorial, el porcentaje de una franja se escribe
dentro de la barra solo si la franja alcanza cierta altura; por debajo de eso la
cifra no se muestra en pantalla (sí en el CSV). La pregunta abierta es si eso
afecta a casos reales o es una hipótesis de laboratorio.

**Paso 1 — Deriva el umbral del código, no de este encargo.**

Lee en `30_procesamiento/33_motor_template.html`:

- el objeto `PANORAMA_DIMS` (alto total y márgenes superior e inferior);
- la condición que decide si se dibuja el rótulo dentro de
  `dibujarPanoramaEnGrupo`.

Con esos dos datos calcula el umbral en puntos porcentuales:
`umbral = altura_minima_del_rotulo / (H - M.top - M.bottom) * 100`.
Transcribe al log las líneas exactas de las que salió cada número.

**Rama de detención.** Si la condición del rótulo no es una comparación directa
de altura contra una constante, o si `PANORAMA_DIMS` no tiene la forma que esta
descripción supone, congela T2 y transcribe lo que sí encontraste.

**Paso 2 — Replica la aritmética del motor, no la aproximes.**

Lee `mkPunto` y `generateSeriesGseCombinado` en la misma plantilla y **replica
en R su cálculo exacto**: la acumulación ponderada por evaluados, el filtro de
filas suprimidas y el reescalado que hace que los tres niveles sumen 100.

**Rama de detención.** Si no puedes replicar la aritmética con certeza a partir
del código (por ejemplo, si el reescalado depende de una rama que no logras
determinar), **congela T2**. Una estimación aproximada aquí no responde la
pregunta: la haría parecer respondida.

**Paso 3 — Cuenta sobre un universo declarado.**

Universo, en este orden y por separado:

- cada **comuna** con dato, para cada nivel, prueba y año;
- cada **región**;
- el **nacional**;
- cada **SLEP**, solo si el esquema de `sleps_chile.parquet` medido en FASE 0
  permite mapear comunas a SLEP sin inventar la clave; si no, se omite el
  estrato y se dice.

Para cada punto (territorio, nivel, prueba, año) con dato, cuenta cuántos de los
tres niveles quedan **bajo el umbral**, y produce:

1. una tabla: estrato × número de puntos × puntos con al menos una franja bajo
   el umbral × porcentaje;
2. el desglose por nivel de logro (cuál de los tres es el que suele quedar sin
   rótulo);
3. los **diez casos concretos** más extremos, con territorio, nivel, prueba,
   año y los tres porcentajes.

**Calibración.** Caso malo: reportar "es un caso raro" sin universo declarado, o
contar sobre filas crudas por GSE en vez de sobre la combinación del panorama
(son distribuciones distintas y la pregunta es sobre la vista). Caso bueno: la
tabla dice sobre cuántos puntos se contó y de qué universo salieron, y los diez
ejemplos se pueden abrir en el motor y verificar a ojo.

---

### T3 — `xmlns` duplicado en la exportación del supergrid

**Afirmación a probar:** `construirSvgGraficos` fija `xmlns` a mano **y** además
serializa con `XMLSerializer`, patrón que produce el atributo duplicado; y
`construirSvgPanorama` ya no lo hace.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -n "XMLSerializer" $R/30_procesamiento/33_motor_template.html
grep -n "createElementNS" $R/30_procesamiento/33_motor_template.html
grep -n "xmlns" $R/30_procesamiento/33_motor_template.html
```

Determina, leyendo el código y no solo los conteos, para cada uno de los dos
constructores de SVG:

- si el nodo raíz se crea con `createElementNS`;
- si además se le fija un atributo `xmlns` explícito;
- con qué se produce la cadena final.

**Estados esperados.**

| Constructor | Esperado |
|---|---|
| `construirSvgPanorama` | crea con `createElementNS`, **no** fija `xmlns`, serializa con `XMLSerializer` |
| `construirSvgGraficos` | pendiente de medir: reporta lo que encuentres |

**Lo que no puedes cerrar y debes declarar.** La cadena que emite el
`XMLSerializer` del navegador no es observable desde aquí: los serializadores
difieren en si reemiten la declaración cuando ya existe un atributo homónimo.
Lo que sí queda probado es el **patrón en el código**. Si el patrón está
presente, la duda pasa de "¿existe?" a "¿lo tolera el navegador?", que es una
pregunta distinta y para el titular.

**Calibración.** Caso malo: concluir "hay `xmlns` duplicado en el archivo
exportado" a partir de un `grep` sobre el template, que no es el artefacto
exportado. Caso bueno: el reporte distingue lo probado (el patrón en el código)
de lo no probado (el resultado de la serialización real).

---

### T4 — Referencias de red en el artefacto publicado

**Afirmación a probar:** el motor publicado es autocontenido, es decir, no
solicita ningún recurso por red al abrirse.

Es la parte estática de la duda del error "Unsafe attempt to load URL": si
existe una referencia de red, es candidata a la causa; si no existe ninguna, la
hipótesis del origen `file://` gana peso.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -o -E 'https?://[^"'"'"' )>]+' $R/docs/index.html | sort | uniq -c | sort -rn
grep -o -E 'https?://[^"'"'"' )>]+' $R/docs/index.html | grep -v "www.w3.org" | sort | uniq -c | sort -rn
grep -c -F 'src="http' $R/docs/index.html
grep -c -F 'href="http' $R/docs/index.html
grep -c -F '@import' $R/docs/index.html
grep -c -F 'fetch(' $R/docs/index.html
grep -c -F 'XMLHttpRequest' $R/docs/index.html
```

**Clasifica cada URL encontrada en una de tres categorías, y dilo por cada una:**

1. **Declaración de espacio de nombres** (`www.w3.org/2000/svg`, `xlink`): falso
   positivo conocido, no es una descarga *(A-xmlns)*.
2. **Texto o comentario**: aparece en prosa, atributo `title`, comentario o
   licencia; no la solicita el navegador.
3. **Carga real**: `src`, `href` de hoja de estilo o fuente, `@import`,
   `fetch`, `XMLHttpRequest`, `new Image().src`.

Solo la categoría 3 responde la pregunta.

**Control positivo obligatorio.** Los conteos con valor esperado 0 exigen
demostrar que el patrón no está mudo. Para `src="http` y `href="http`, ejecuta
el mismo `grep -F` contra un archivo del repositorio donde esa cadena **sí**
exista (por ejemplo, cualquier `.md` de `50_documentacion/` que enlace a una
URL entre comillas; si ninguno la tiene en esa forma exacta, créate uno en
`/tmp` con la cadena y úsalo como control, dejándolo registrado en el log).
Sin control positivo, un 0 no se reporta como ausencia.

**Estados esperados.**

| Medición | Valor esperado |
|---|---|
| URLs de categoría 1 | una o más; todas de `www.w3.org` |
| URLs de categoría 3 | **ninguna** |
| `@import`, `fetch(`, `XMLHttpRequest` | 0 cada uno, con su control positivo |

**Calibración.** Caso malo: reportar "hay 12 referencias http" sin separar los
`xmlns`, que es exactamente el falso positivo que el proyecto ya documentó. Caso
bueno: la tabla del log lista cada URL única con su categoría, y la conclusión
se apoya solo en la categoría 3.

---

### FASE FINAL — Cierre y auto-auditoría

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
md5 -q $R/docs/index.html
md5 -q $R/40_salidas/motor_comparacion.html
git -C $R status --porcelain
git -C $R rev-parse HEAD origin/main
ls -1 /tmp/pages_index.html 2>/dev/null
```

**Estados esperados.** Los dos md5 idénticos al valor de FASE 0
(`f00e9126b86fc703b001e55080de0969`); `HEAD` y `origin/main` en `4e8f946`;
`status` sin ningún archivo versionado modificado. Si alguno cambió, este
encargo escribió donde no debía: dilo en primera línea del reporte.

**Auto-auditoría, respondida por escrito en el log.**

1. ¿Alguna rama de detención se disparó en el camino nominal? Si sí, estaba mal
   escrita: dilo.
2. ¿Cada cero reportado tiene su control positivo ejecutado?
3. ¿Cada cifra del reporte viene del comando que la produjo, citado en la misma
   línea?
4. ¿Alguna conclusión afirma más de lo que su comando midió? En particular:
   ¿distinguiste "el patrón está en el código" de "el navegador produce el
   defecto"?

---

## 6. Log

Escribe en disco, **sin commitear**:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/20260829_verificacion_dudas_s29_log.md
```

con la fecha real del día. Estructura fija:

1. **Resumen:** qué duda quedó cerrada, cuál parcialmente y cuál congelada.
2. **Veredicto por duda**, una tabla: duda, veredicto (CERRADA / PARCIAL /
   CONGELADA), evidencia en una línea.
3. **Por tarea:** salida **literal** de cada comando, y tabla de medición, valor
   esperado y valor medido.
4. **T2 completo:** el umbral derivado con las líneas de código de las que
   salió, el script de R que replicó la aritmética (íntegro), las tres tablas y
   los diez casos.
5. **T4 completo:** la lista de URLs únicas con su categoría, una por línea.
6. **Controles positivos:** cada cero con su comando de control y su resultado.
7. **Dudas y tareas congeladas:** cada una con contexto en una línea, la
   pregunta **cerrada** que la resuelve y qué quedó bloqueado.
8. **Verificación de invariantes:** cada 🔒 de §2 con PASA / FALLA y evidencia;
   en particular, la prueba de que el repositorio quedó como estaba.
9. **Lo que quedó sin verificar y por qué.** Como mínimo: no abres navegador,
   así que el badge `TRASPASO` renderizado y la consola del sitio publicado
   siguen siendo del titular.

Toda cifra que afirmes lleva el comando que la produjo en la misma línea.

---

## 7. Reporte final al chat

1. Tabla de las cuatro dudas con su veredicto.
2. Para T1: el `http_code`, el resultado de `cmp` y los dos md5.
3. Para T2: el umbral derivado, y la tabla estrato × puntos × puntos afectados.
4. Para T3: qué hace cada constructor, y la frontera entre lo probado y lo no
   probado.
5. Para T4: las URLs de categoría 3 (o la afirmación de que no hay ninguna, con
   su control positivo).
6. La prueba de que el repositorio quedó intacto.
7. Ruta del log, y que quedó **sin commitear**.
8. Qué falló o sorprendió. **Si nada, dilo explícitamente.**
