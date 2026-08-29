# Encargo — Rescate de rótulos del panorama y auditoría del precedente C3

> **Destino:** `50_documentacion/activa/encargos/encargo_rescate_rotulos_y_precedente_c3.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.
> **Redactado:** 2026-08-29, sesión 29 de `slep_simce_adecuado`.

---

## 0. Contrato

**MODO.** Autónomo, secuencial, todo en un turno. **No se admiten subagentes**
(tope duro: 0). Dos fases independientes entre sí: A escribe en este
repositorio, B es **solo lectura** y toca otro repositorio.

**ENTORNO.** macOS aarch64, filesystem local vía Claude Code. Intérprete de todo
bloque de comandos: **`bash`**. R se invoca con `Rscript` desde rutas absolutas.
El aviso de `renv` desincronizado es esperado y no detiene nada.

**Nota de entorno.** `grep` de macOS es BSD: todo patrón con `{` o `}` va con
`grep -F` *(A-s28-3)*. `grep` opera línea a línea: ningún patrón de este encargo
abarca más de una palabra ancla *(regla 11)*. Ningún criterio de este encargo
cuenta líneas de `diff`, líneas de `status` ni commits *(regla 10)*.

**POSICIÓN.** Rutas absolutas completas. Raíces:

```
/Users/tomgc/Projects/slep_simce_adecuado          (FASE A, escritura acotada)
/Users/tomgc/Projects/slep_categoria_desempeno     (FASE B, SOLO LECTURA; ruta hipotética, se mide)
```

**Contexto en una frase.** La medición de dudas dejó dos hallazgos: el panorama
esconde el porcentaje de las franjas delgadas justo cuando ese porcentaje es el
más grave de la serie, y el motor publicado depende de tres scripts servidos por
`unpkg.com`; este encargo publica la corrección del primero y levanta la
evidencia para decidir el segundo.

---

## 1. Estado de partida (premisas marcadas)

1. `HEAD` y `origin/main` en `4e8f946`, working tree sin archivos versionados
   modificados *(fuente: `git rev-parse` y `git status --porcelain` del cierre
   de la corrida anterior de esta sesión)*.
2. `docs/index.html` y `40_salidas/motor_comparacion.html` comparten md5
   `f00e9126b86fc703b001e55080de0969` *(fuente: `md5 -q` de ambos, FASE FINAL
   del log `20260829_verificacion_dudas_s29_log.md`)*.
3. El titular ya reemplazó a mano `30_procesamiento/33_motor_template.html` por
   una versión nueva, de **4541** líneas *(hipótesis, se mide en FASE 0)*.
4. Esa versión cambia **solo** la función de dibujo del panorama y la nota
   metodológica de su sección: rescata bajo el eje el porcentaje de las franjas
   que no lo admiten adentro, sube `PANORAMA_DIMS.H` de 300 a 328 y
   `M.bottom` de 46 a 74 para alojar hasta dos renglones, nombra el umbral como
   `ALTO_MIN_ROTULO`, y agrega `valorFuera` a `FS_SVG.panorama` *(hipótesis, se
   verifica por `diff` en A2)*.
5. El motor publicado solicita al abrirse tres scripts a `unpkg.com` (React,
   ReactDOM y Babel standalone, con SRI) *(fuente: T4 del log
   `20260829_verificacion_dudas_s29_log.md`, líneas 1219, 1222 y 1225 de
   `docs/index.html`)*.
6. `slep_categoria_desempeno` eliminó Babel en su motor ("C3 hecho") *(hipótesis
   heredada de traspasos de esa cartera; **el mecanismo no está documentado en
   este repositorio** y es lo que FASE B va a medir)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 **No se despliega en esta corrida.** `docs/index.html` no se toca. El gate
  visual del titular es previo a cualquier publicación (R5).
- 🔒 **FASE B no escribe nada, en ningún repositorio.** Ni un archivo, ni un
  commit, ni un `git add`. Es una lectura con informe.
- 🔒 En FASE A se edita **cero** archivos: la plantilla ya viene reemplazada por
  el titular; tu trabajo es medir, regenerar y commitear.
- 🔒 El D3 minificado vendorizado no se toca.
- 🔒 `git status --porcelain` antes de cada `git add`. **Nunca `git add .`**.
- 🔒 No se hace `push` hasta la FASE FINAL, y solo del commit de A3.

---

## 3. Autorizaciones (lista cerrada)

1. Leer cualquier archivo de los dos repositorios.
2. Ejecutar `Rscript /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_generar_html.R`.
3. Crear **un** commit en `slep_simce_adecuado`, el de A3, con la plantilla como
   único archivo.
4. Un único `git push` en la FASE FINAL.
5. Escribir el log de §6 en `50_documentacion/andamios/logs/` de
   `slep_simce_adecuado`, sin commitearlo.
6. Escribir scratch en `/tmp`.

**Nada más.** En particular: no `cp` sobre `docs/index.html`, no `git` de
escritura en `slep_categoria_desempeno`, no instalación de paquetes, no `npm`,
no `rm`.

---

## 4. Regla de detención

Cada tarea declara su conjunto de estados esperados y cierra con la residual:

> **Cualquier estado, conteo o resultado no enumerado: congela ESTA tarea,
> regístrala como duda en el log y sigue con la próxima tarea independiente.**
> FASE A y FASE B no dependen entre sí: una detención en A no cancela B.

Los estados esperados de FASE 0 incluyen, explícitamente, los artefactos sin
versionar de este mismo encargo: su `.md` y su log. No congelan nada.

---

## FASE 0 — Medición

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R fetch --quiet --all --prune
git -C $R status --porcelain
git -C $R rev-parse HEAD origin/main
wc -l $R/30_procesamiento/33_motor_template.html
md5 -q $R/40_salidas/motor_comparacion.html
md5 -q $R/docs/index.html
grep -c -F "ALTO_MIN_ROTULO" $R/30_procesamiento/33_motor_template.html
grep -c -F "valorFuera" $R/30_procesamiento/33_motor_template.html
grep -c -F "rescatadas" $R/30_procesamiento/33_motor_template.html
grep -n -F "H: 328" $R/30_procesamiento/33_motor_template.html
```

| Medición | Valor esperado |
|---|---|
| `status --porcelain` | ` M 30_procesamiento/33_motor_template.html`, más los `??` de este encargo y su log. Cualquier **otro** archivo versionado modificado: DETENTE |
| `rev-parse` | dos hashes idénticos, ambos `4e8f946` |
| `wc -l` de la plantilla | 4541 |
| md5 del motor y de `docs/index.html` | ambos `f00e9126b86fc703b001e55080de0969` |
| `ALTO_MIN_ROTULO`, `valorFuera`, `rescatadas` | uno o más cada uno |
| `H: 328` | una ocurrencia, dentro de `PANORAMA_DIMS` |

Los tres conteos anteriores no pueden ser 0: si alguno lo es, la plantilla no es
la versión nueva y **DETENTE**; no es una tarea que congelar, es el insumo
equivocado.

---

## FASE A — Publicar el rescate de rótulos

### A1 — Commit de la plantilla

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R add -- 30_procesamiento/33_motor_template.html
git -C $R status --porcelain
git -C $R commit -m "fix(motor): rescata bajo el eje el porcentaje de las franjas delgadas del panorama"
git -C $R show --stat --oneline HEAD
```

**Criterio, como resultado:** el commit toca exactamente la plantilla y ningún
archivo versionado queda modificado tras él.

### A2 — Regeneración y verificación por diferencia

La afirmación a probar es **"el build nuevo difiere del anterior solo en el
dibujo del panorama y en su nota metodológica"**.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
cp $R/40_salidas/motor_comparacion.html /tmp/motor_previo_rescate.html
md5 -q /tmp/motor_previo_rescate.html
Rscript $R/30_procesamiento/33_generar_html.R
md5 -q $R/40_salidas/motor_comparacion.html
diff /tmp/motor_previo_rescate.html $R/40_salidas/motor_comparacion.html
git -C $R status --porcelain
```

| Medición | Valor esperado |
|---|---|
| md5 de la copia previa | `f00e9126b86fc703b001e55080de0969` |
| md5 del build nuevo | distinto del anterior |
| `diff` | solo bloques atribuibles a `dibujarPanoramaEnGrupo`, `PANORAMA_DIMS`, `ALTO_MIN_ROTULO`, `FS_SVG.panorama` y la nota de `PanoramaSection` |
| `status --porcelain` | sin el motor generado (está en `.gitignore`) |

**Atribuye cada bloque del `diff`, uno por uno, en el log.** Si alguno toca el
bloque base64 del payload, el D3 vendorizado, la vista de comparación o
cualquier regla CSS ajena al panorama, **detente** y no sigas a A3.

**Verificación de contenido, no solo de forma.** Comprueba en el artefacto
generado que el rescate quedó incrustado y que usa un decimal:

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -c -F "ALTO_MIN_ROTULO" $R/40_salidas/motor_comparacion.html
grep -c -F "rescatadas" $R/40_salidas/motor_comparacion.html
grep -c -F "fmtPctShort(seg.val)" $R/40_salidas/motor_comparacion.html
```

El tercero debe dar **0**: los valores rescatados usan `fmtPct`, con un decimal,
porque redondear `0,2` a `0%` anularía la cifra que la corrección existe para
mostrar. **Control positivo obligatorio de ese cero:** el mismo patrón, con
`grep -F`, contra un archivo donde `fmtPctShort(` sí aparezca (la propia
plantilla lo usa para los rótulos de dentro de la barra). Si el control no
encuentra nada, el patrón está mudo y el 0 no prueba nada.

### A3 — Cierre de FASE A, sin desplegar

No copies nada a `docs/`. El commit de A1 es el único de esta fase; A2 no
produce commit porque su salida está en `.gitignore`.

**Estado en que debe quedar el repositorio:** `docs/index.html` con su md5 de
FASE 0 intacto, el motor generado con el md5 nuevo, y un commit nuevo sobre
`4e8f946`.

---

## FASE B — Auditoría del precedente C3 (solo lectura, otro repositorio)

**Por qué.** El motor de este proyecto no arranca sin `unpkg.com`: React,
ReactDOM y Babel se cargan por red. La cartera ya resolvió esto una vez, en
`slep_categoria_desempeno`, y ese mecanismo no está documentado aquí. Antes de
redactar una migración, hay que saber **cómo** se hizo, no suponerlo.

### B1 — Localiza el repositorio, no lo asumas

```bash
ls -d /Users/tomgc/Projects/slep_categoria_desempeno 2>/dev/null || ls -1 /Users/tomgc/Projects/
```

Si la ruta no existe, busca el repositorio por su nombre dentro de
`/Users/tomgc/Projects/` y usa lo que encuentres. Si no aparece, **congela FASE
B entera** y dilo: sin el precedente, no hay auditoría.

### B2 — Mide su artefacto publicado con el mismo instrumento de T4

Sobre su HTML publicado (`docs/index.html` o el que corresponda; identifícalo
primero):

```bash
C=<ruta medida en B1>
grep -o -E 'https?://[^"'"'"' )>]+' $C/docs/index.html | sort | uniq -c | sort -rn
grep -c -F 'src="http' $C/docs/index.html
grep -c -F 'babel' $C/docs/index.html
grep -c -F 'text/babel' $C/docs/index.html
grep -c -F 'React.createElement' $C/docs/index.html
```

Clasifica las URL en las tres categorías de T4 (namespace / texto / carga real).
Todo cero lleva control positivo.

**Pregunta que debe quedar respondida con evidencia:** ¿ese motor carga algo por
red al abrirse, sí o no, y qué exactamente?

### B3 — Reconstruye el mecanismo, con las líneas a la vista

Determina, leyendo:

1. **Dónde está React.** ¿Incrustado en el HTML, vendorizado en un directorio de
   utilidades, o desde CDN? Cita archivo y línea.
2. **Cómo desaparece Babel.** ¿El JSX se transpiló una vez y se versionó ya
   transpilado, se transpila en cada build, o se reescribió a
   `React.createElement` a mano? Cita el código que lo prueba.
3. **Qué herramienta hace la transpilación, si la hay.** Busca en su script
   generador y en sus scripts de build las invocaciones a `node`, `npx`,
   `esbuild`, `babel`, `terser` o similares, con `grep -F` y citando líneas.
   **Si no hay ninguna, dilo:** significa que el paso es manual o que no existe.
4. **Qué dependencias de entorno introduce.** ¿Requiere Node instalado? ¿Un
   `package.json`? ¿Un directorio `node_modules` versionado o ignorado?
5. **Dónde está documentada la decisión.** Busca en su documentación un archivo
   de decisión o una entrada de backlog que la registre, y cita su ruta.
6. **Qué costó en tamaño.** Peso del HTML publicado antes y después, si su
   historial o su documentación lo registran; si no, di que no consta.

### B4 — Traducción a este proyecto, sin ejecutarla

Escribe en el log, **sin tocar nada**, qué implicaría replicar ese mecanismo
aquí:

- qué archivos de `slep_simce_adecuado` habría que cambiar (nómbralos);
- qué pasaría con la plantilla como fuente editable: si tras la migración se
  sigue editando JSX y se transpila al construir, o si el JSX deja de existir;
- qué se rompería de lo que hoy funciona (por ejemplo, el flujo en el que el
  titular reemplaza la plantilla a mano y tú regeneras);
- una estimación de riesgo en tres niveles, con su razón.

**Prohibido proponer un plan de ejecución.** El producto de B4 es evidencia y
consecuencias, no un encargo: la decisión de migrar es del titular.

---

## FASE FINAL — Publicación y auto-auditoría

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R status --porcelain
git -C $R push
git -C $R rev-parse HEAD origin/main
md5 -q $R/docs/index.html
```

**Estados esperados:** `HEAD` igual a `origin/main` tras el push;
`docs/index.html` con el md5 de FASE 0, **sin cambiar** (no se desplegó);
`status` sin archivos versionados modificados.

**Auto-auditoría, por escrito en el log.**

1. ¿Alguna rama de detención se disparó en el camino nominal? Si sí, estaba mal
   escrita.
2. ¿Cada cero tiene su control positivo ejecutado?
3. ¿Cada cifra viene del comando que la produjo, citado en la misma línea?
4. ¿Alguna conclusión de FASE B afirma más de lo que su comando midió? En
   particular, ¿distinguiste lo que leíste en el código de lo que inferiste
   sobre su flujo de trabajo?

---

## 6. Log

Escribe, **sin commitear**:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/20260829_rescate_rotulos_y_precedente_c3_log.md
```

1. Resumen: qué se publicó y qué se midió.
2. Inventario del commit de A1.
3. Por tarea: salidas literales y tabla de medición, esperado y medido.
4. **El `diff` de A2 íntegro, con la atribución bloque a bloque.**
5. Controles positivos, cada cero con su comando.
6. **FASE B completa:** las seis respuestas de B3 con archivo y línea, y el B4
   con sus cuatro puntos.
7. Verificación de invariantes de §2, con evidencia de que `docs/index.html` no
   se tocó.
8. Dudas y tareas congeladas, con pregunta cerrada.
9. Lo que quedó sin verificar. Como mínimo: no abres navegador, así que el
   rescate de rótulos no fue visto renderizado por ti.

---

## 7. Reporte final al chat

1. Hash del commit de A1 y la atribución resumida del `diff` de A2.
2. Confirmación de que `docs/index.html` **no** cambió, con su md5.
3. Las seis respuestas de B3, en una tabla corta.
4. El B4 completo: archivos afectados, qué se rompe, riesgo.
5. Ruta del log, sin commitear.
6. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

El despliegue del rescate de rótulos queda pendiente del gate visual del
titular. No lo hagas tú.
