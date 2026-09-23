# Encargo — Corrección de memos y auditoría de rutas no ejercidas

> **Destino:** `50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.
> **Redactado:** 2026-08-29, sesión 29 de `slep_simce_adecuado`.

---

## 0. Contrato

**MODO.** Autónomo, secuencial, todo en un turno. **No se admiten subagentes**
(tope duro: 0). Cuatro tareas: T1 escribe y commitea, T2, T3 y T4 son solo
lectura y medición.

**ENTORNO.** macOS aarch64. Intérprete de todo bloque de comandos: **`bash`**. R
se invoca con `Rscript` desde rutas absolutas; el aviso de `renv` desincronizado
es esperado. T2 requiere Node; su disponibilidad **se mide** en FASE 0 y su
ausencia degrada T2 a inspección estática, no la congela.

**Nota de entorno.** `grep` de macOS es BSD: todo patrón con `{` o `}` va con
`grep -F` *(A-s28-3)*. `grep` opera línea a línea: ningún patrón abarca más de
una palabra ancla *(regla 11)*. Ningún criterio cuenta líneas de `diff`, de
`status` ni commits *(regla 10)*.

**Alcance del instrumento igual al alcance de la afirmación.** Esta sesión tuvo
tres verificadores que medían el archivo completo cuando su afirmación era local
a un bloque. Aquí, todo patrón que pruebe algo sobre una función concreta se
ancla dentro de esa función, extrayéndola primero a `/tmp`, no barriendo el
archivo entero.

**POSICIÓN.** Rutas absolutas completas. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**Contexto en una frase.** El panorama tiene un defecto latente en las
dependencias de dos `useMemo`, y tres rutas de exportación no se han ejecutado
nunca desde que existen o desde que se refactorizaron; esto publica lo primero y
mide lo segundo hasta donde alcanza sin navegador.

---

## 1. Estado de partida (premisas marcadas)

1. `HEAD` y `origin/main` en `a668951`, working tree limpio *(fuente:
   `git rev-parse` y `git status --porcelain` del cierre de la corrida de
   despliegue de esta sesión)*.
2. `docs/index.html` y `40_salidas/motor_comparacion.html` comparten md5
   `d440aa6e6236fb20c40e9e4269f4e46f` *(misma fuente)*.
3. El titular ya reemplazó a mano `30_procesamiento/33_motor_template.html` por
   una versión de **4551** líneas, que difiere de la de `a668951` **solo** en
   las listas de dependencias de dos `useMemo` de `PanoramaSection` y en el
   comentario que las explica *(hipótesis; se **verifica por diff contra HEAD**
   en FASE 0, y esa verificación es el gate de T1)*.
4. `exportarPanoramaCSV`, `exportarPanoramaPNG` y `exportarGraficosPNG` no se
   han ejecutado desde que existen o desde que se refactorizaron: la primera y
   la segunda nacieron en esta sesión, y la tercera pasó a ser un envoltorio de
   `rasterizarSvgAPng` en la misma sesión *(fuente: historial de la sesión 29;
   ninguna corrida las ejerció)*.
5. La siembra por defecto del panorama busca la cadena `costa central`
   normalizada dentro de `SimceData.SLEPS` *(hipótesis, se lee en T3)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 **No se despliega en esta corrida.** `docs/index.html` no se toca, no se
  copia nada sobre él, y su md5 debe ser el mismo al abrir y al cerrar.
- 🔒 **T2, T3 y T4 no escriben en el repositorio.** Sus scratch van a `/tmp`.
- 🔒 En T1 no se edita ningún archivo: la plantilla viene reemplazada por el
  titular; tu trabajo es cotejar, commitear y regenerar.
- 🔒 El D3 minificado vendorizado no se toca.
- 🔒 `git status --porcelain` antes de cada `git add`. **Nunca `git add .`**.
- 🔒 Un solo `push`, en la FASE FINAL, y solo del commit de T1.

---

## 3. Autorizaciones (lista cerrada)

1. Leer cualquier archivo del repositorio.
2. Crear **un** commit, el de T1, con la plantilla como único archivo.
3. Ejecutar `Rscript /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_generar_html.R`.
4. Ejecutar `Rscript` con scripts efímeros en `/tmp` que solo lean parquet.
5. Ejecutar `node` sobre scripts efímeros en `/tmp`.
6. Un único `git push` en la FASE FINAL.
7. Escribir el log de §5 en `50_documentacion/andamios/logs/`, sin commitearlo.

**Nada más.** En particular: no `cp` sobre `docs/`, no `npm install`, no
descargas de red, no edición de ningún archivo versionado.

---

## 4. Regla de detención

Cada tarea declara su conjunto de estados esperados y cierra con la residual:

> **Cualquier estado, conteo o resultado no enumerado: congela ESTA tarea,
> regístrala como duda en el log y sigue con la próxima.** T2, T3 y T4 son
> independientes entre sí y de T1.

Los estados esperados de FASE 0 incluyen los artefactos sin versionar de este
mismo encargo (su `.md` y su log): no congelan nada.

---

## FASE 0 — Medición y cotejo de base

El cotejo de base es nuevo y es la lección más cara de esta sesión: una entrega
anterior venía de una copia de trabajo desactualizada y revertía dos commits ya
publicados. La detección no puede depender de que alguien lo note.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R fetch --quiet --all --prune
git -C $R status --porcelain
git -C $R rev-parse HEAD origin/main
wc -l $R/30_procesamiento/33_motor_template.html
md5 -q $R/docs/index.html
md5 -q $R/40_salidas/motor_comparacion.html
node --version || echo "NODE AUSENTE"
git -C $R diff -- 30_procesamiento/33_motor_template.html
```

| Medición | Valor esperado |
|---|---|
| `status --porcelain` | ` M 30_procesamiento/33_motor_template.html`, más los `??` de este encargo y su log. Cualquier **otro** archivo versionado modificado: DETENTE |
| `rev-parse` | dos hashes idénticos, ambos `a668951` |
| `wc -l` | 4551 |
| md5 de `docs/index.html` y del motor | ambos `d440aa6e6236fb20c40e9e4269f4e46f` |
| `node --version` | una versión, o `NODE AUSENTE`: las dos son estados esperados |

### Gate de cotejo de base, previo a cualquier commit

Sobre el `diff` de la plantilla contra `HEAD`, atribuye **cada bloque** a uno de
estos dos: (a) la lista de dependencias de un `useMemo` de `PanoramaSection`, o
(b) el comentario que explica esa lista.

**Si algún bloque no cae en (a) ni en (b), DETENTE y no commitees.** Un bloque
ajeno significa que la copia de la que salió el archivo no descendía de `HEAD`,
que es exactamente el fallo que este gate existe para atrapar. Pega el `diff`
íntegro y sigue con T2, T3 y T4, que no dependen de T1.

Comprobación adicional de no regresión, anclada en lo que ya está publicado:

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -c "text-transform" $R/30_procesamiento/33_motor_template.html
grep -c "sembradas" $R/30_procesamiento/33_motor_template.html
grep -c -F "TRASPASO {s" $R/30_procesamiento/33_motor_template.html
grep -c -F "ALTO_MIN_ROTULO" $R/30_procesamiento/33_motor_template.html
```

Esperado: 0, 0, 1, y uno o más. Los dos ceros exigen control positivo: el mismo
patrón contra `50_documentacion/andamios/logs/20260829_rescate_rotulos_y_precedente_c3_log.md`,
que cita ambas cadenas.

---

## T1 — Publicar la corrección de dependencias

Requiere el gate de cotejo en verde.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R add -- 30_procesamiento/33_motor_template.html
git -C $R status --porcelain
git -C $R commit -m "fix(motor): incluye la composicion del territorio en las dependencias de los memos del panorama"
git -C $R show --stat --oneline HEAD
cp $R/40_salidas/motor_comparacion.html /tmp/motor_previo_memos.html
Rscript $R/30_procesamiento/33_generar_html.R
md5 -q $R/40_salidas/motor_comparacion.html
diff /tmp/motor_previo_memos.html $R/40_salidas/motor_comparacion.html
git -C $R status --porcelain
md5 -q $R/docs/index.html
```

| Medición | Valor esperado |
|---|---|
| commit | toca exactamente la plantilla |
| md5 del build nuevo | distinto de `d440aa6e6236fb20c40e9e4269f4e46f` |
| `diff` del build | solo los bloques de dependencias y su comentario |
| md5 de `docs/index.html` | **sin cambiar**: `d440aa6e6236fb20c40e9e4269f4e46f` |

**No despliegues.** El titular verifica el arreglo cambiando de territorio en el
panorama y comprobando que la línea meta de la tarjeta se actualiza; recién
entonces se publica, en otra corrida.

---

## T2 — Las tres rutas de exportación no ejercidas

**Afirmación a probar, por partes:** que el CSV del panorama sale bien formado y
completo, y que las dos exportaciones a PNG comparten un contrato coherente con
el rasterizador que ahora las sirve a las dos.

### T2a — Ejecutar el CSV del panorama de verdad

Si hay Node, **no te limites a leer la función: córrela.**

Extrae a `/tmp` un script que contenga, copiadas literalmente de la plantilla:
`exportarPanoramaCSV`, y las dependencias mínimas que necesite. Sustituye por
dobles solo lo que no puede existir fuera del navegador: `descargarBlob`, que en
el doble captura el texto en vez de descargarlo, y `SimceData.generateSeriesGseCombinado`,
que devuelve una serie sintética con al menos un año con dato, un año sin dato,
un año preliminar y un valor con decimal.

Comprueba sobre el texto capturado:

1. empieza con BOM (`\ufeff`);
2. el separador de campos es `;`, coherente con el locale español de Excel;
3. el número de campos de **cada** fila es igual al del encabezado;
4. los decimales usan coma;
5. una fila de año sin dato deja los campos numéricos vacíos, no `NaN` ni
   `undefined` ni `null`;
6. el valor `preliminar` es `1` o `0`, nunca `true`/`false`.

**Rama de detención.** Si alguna comprobación falla, **no arregles nada**:
regístrala con el texto capturado literal y sigue. La corrección la decide el
titular.

**Si no hay Node:** verifica 2, 3 y 6 leyendo la función (contando los campos
del encabezado contra los del `push`), y declara 1, 4 y 5 como no verificadas.

### T2b — El contrato del rasterizador

Sin ejecutar nada, lee y responde con archivo y línea:

1. ¿Qué claves destructura `rasterizarSvgAPng` de su argumento?
2. ¿Qué claves devuelve `construirSvgGraficos`?
3. ¿Qué claves devuelve `construirSvgPanorama`?
4. ¿Coinciden las tres listas? Si alguna clave que el rasterizador espera falta
   en alguno de los dos constructores, esa exportación está rota y el titular no
   lo sabe.
5. ¿Queda en el archivo alguna llamada a `URL.revokeObjectURL` para cada
   `createObjectURL`, en ambas rutas de salida (éxito y error)?

**Ancla los patrones dentro de cada función**, extrayéndolas primero a `/tmp`
con `sed`, no barriendo el archivo completo: es la corrección de redacción que
esta sesión aprendió tres veces.

### T2c — Lo que no puedes cerrar

Declara explícitamente que la descarga real (`Blob`, `canvas`, `toBlob`, el
diálogo del navegador) no es observable desde aquí, y que T2 prueba el
contenido y el contrato, no la descarga.

---

## T3 — La siembra por defecto, contra el dato real

**Afirmación a probar:** la búsqueda por texto que siembra el territorio inicial
del panorama encuentra uno y solo un SLEP, y ese SLEP trae comunas y RBDs.

Lee en la plantilla la función que construye el territorio por defecto y **usa
su misma normalización** (minúsculas, `NFD`, sin diacríticos) sobre los nombres
reales de `40_salidas/intermedios/sleps_chile.parquet`, con un script efímero de
R en `/tmp`.

| Medición | Valor esperado |
|---|---|
| SLEPs cuyo nombre normalizado contiene `costa central` | exactamente 1 |
| comunas de ese SLEP | 4 |
| RBDs de ese SLEP | uno o más |

**Rama de detención.** Si son 0, el panorama abre vacío y hay un defecto; si son
2 o más, la siembra depende del orden de la lista y es frágil. En cualquiera de
los dos casos, regístralo con los nombres encontrados y **no cambies nada**.

---

## T4 — Umbrales de ancho, por aritmética

**Afirmación a probar:** por debajo de cierto ancho de ventana, algún elemento
del encabezado o del panorama desborda o se apila. No puedes renderizar, pero
puedes calcular a partir del CSS.

Extrae del bloque `<style>` los valores de: padding lateral de `.panorama-section`,
`.territorio-row`, `.view-tabs-inner` y el margen de `.hero-card`; el
`grid-template-columns` de `.panorama-grid`; el `flex`/`min-width` de
`.territorio-select`; y el `max-width` de `.app-main`.

Calcula y reporta, con la aritmética a la vista:

1. el ancho de ventana bajo el cual `.panorama-grid` pasa de dos columnas a una;
2. el ancho bajo el cual `.territorio-select` alcanza su `min-width` y la fila
   se parte;
3. si el `viewBox` del SVG del panorama escala sin recorte al reducirse su
   contenedor, o si algún elemento tiene ancho fijo en píxeles.

**No propongas un rediseño.** El producto es el número y su derivación; qué
hacer con él lo decide el titular.

---

## FASE FINAL — Publicación y auto-auditoría

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R status --porcelain
git -C $R push
git -C $R rev-parse HEAD origin/main
md5 -q $R/docs/index.html
```

**Esperado:** `HEAD` igual a `origin/main`; `docs/index.html` con
`d440aa6e6236fb20c40e9e4269f4e46f`, sin cambiar; `status` sin archivos
versionados modificados. Si T1 quedó congelada, no hay nada que empujar y el
`push` se omite: dilo.

**Auto-auditoría, por escrito.**

1. ¿Alguna rama de detención se disparó en el camino nominal?
2. ¿Cada cero tiene su control positivo?
3. ¿Cada patrón que prueba algo sobre una función se ancló dentro de esa
   función, o barriste el archivo completo?
4. ¿Alguna conclusión afirma más de lo que su comando midió? En particular:
   ¿distinguiste el contenido del CSV de su descarga?

---

## 5. Log

Escribe, **sin commitear**:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/20260829_memos_y_rutas_no_ejercidas_log.md
```

1. Resumen y veredicto por tarea.
2. El `diff` del gate de cotejo, con su atribución bloque a bloque.
3. Por tarea: salidas literales y tabla de medición, esperado y medido.
4. **T2a:** el script efímero íntegro y el texto CSV capturado, literal.
5. **T2b:** las cinco respuestas con archivo y línea.
6. **T3:** el script de R íntegro y los nombres encontrados.
7. **T4:** la aritmética de cada umbral, paso a paso.
8. Controles positivos.
9. Verificación de invariantes, con la prueba de que `docs/index.html` no se
   tocó.
10. Dudas, cada una con su pregunta cerrada.
11. Lo que quedó sin verificar: como mínimo, la descarga real de los tres
    exportadores y el render en pantalla estrecha.

---

## 6. Reporte final al chat

1. Veredicto del gate de cotejo y hash del commit de T1, si lo hubo.
2. Confirmación de que `docs/index.html` no cambió, con su md5.
3. T2a: las seis comprobaciones con su resultado, y el encabezado del CSV.
4. T2b: si los tres contratos coinciden, sí o no.
5. T3: cuántos SLEPs matchean y con cuántas comunas.
6. T4: los dos anchos umbral.
7. Ruta del log, sin commitear.
8. Qué falló o sorprendió. **Si nada, dilo explícitamente.**
