# Encargo — Pendientes inmediatos de la sesión 29

> **Destino:** `50_documentacion/activa/encargos/encargo_pendientes_inmediatos_s29.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.
> **Redactado:** 2026-08-29, sesión 29 de `slep_simce_adecuado`.

---

## 0. Contrato

**MODO.** Autónomo, secuencial, todo en un turno. **No se admiten subagentes**
(tope duro: 0). Las tareas se ejecutan en el orden del grafo de §5.

**ENTORNO.** macOS aarch64, filesystem local vía Claude Code. Proyecto R con
`renv`. Intérprete de todo bloque de comandos: **`bash`**, nunca el shell
interactivo del titular. R se invoca con `Rscript` desde la raíz del proyecto
(el `.Rprofile` activa `renv`). El aviso de `renv` desincronizado es esperado y
**no** detiene nada *(fuente: cuatro corridas limpias registradas en el traspaso
v28 §10 y tres corridas limpias en esta sesión 29)*.

**Nota de entorno.** `grep` de macOS es BSD: interpreta `{…}` como expresión de
intervalo y no matchea llaves literales. Todo patrón con `{` o `}` va con
`grep -F` *(fuente: A-s28-3, `50_diseno_ramas_deteccion.md` §2)*.

**POSICIÓN.** Ruta absoluta completa en todos los comandos; ningún comando asume
`cd` previo. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**INSUMOS.** Todos los archivos que se leen o editan viven en ese repositorio.
No hay insumos externos, no hay archivos que el titular deba adjuntar.

**Contexto en una frase.** La sesión 29 construyó el panorama territorial y
alineó su encabezado al patrón del motor IDPS; el trabajo está en el working
tree sin commitear, el motor publicado sigue siendo el del 27 de agosto, y
quedan cuatro deudas triviales que se agotan en la misma corrida.

---

## 1. Estado de partida (premisas marcadas)

Cada hipótesis se mide en FASE 0 con su valor esperado y su rama de detención.

1. El working tree tiene **una sola** modificación versionada,
   `30_procesamiento/33_motor_template.html`, sin stage y sin commit
   *(fuente: `git status --porcelain` ejecutado por Claude Code en el turno
   anterior de esta sesión)*.
2. La plantilla tiene **4507** líneas *(fuente: `wc -l` del mismo turno)*.
3. El motor generado `40_salidas/motor_comparacion.html` tiene md5
   `76711302f54b68523806a3c6d2196789` y corresponde a la plantilla actual
   *(fuente: `md5 -q` del mismo turno, tras `Rscript 33_generar_html.R`)*.
4. `40_salidas/motor_comparacion.html` está en `.gitignore` y **nunca** aparece
   en `git status`; su ausencia del status es lo esperado, no un fallo
   *(fuente: `.gitignore:13` y `git ls-files --error-unmatch`, verificado por
   Claude Code en el turno de FASE 2 de esta sesión)*.
5. `docs/index.html` es el build del 27 de agosto y no se ha tocado en esta
   sesión *(fuente: `git status --porcelain` del mismo turno)*.
6. `50_documentacion/andamios/` contiene **solo** el directorio `logs/`: el
   único encargo que quedaba fuera de `activa/encargos/` ya fue reubicado por
   el commit `90bd736` *(fuente: `ls -1` ejecutado por Claude Code en la
   apertura de esta sesión)*. La tarea T6 puede resultar **ya cumplida**; eso
   es un resultado válido, no un error.
7. `entidadesPorDefecto()` declara `const sembradas = Math.min(nComunas,
   MAX_ENTIDADES)` y esa constante solo se lee dentro del `console.warn` de la
   rama `nComunas > MAX_ENTIDADES` *(hipótesis, se mide en FASE 0)*.
8. `MAX_ENTIDADES` vale **5** *(hipótesis, se mide en FASE 0)*.
9. La plantilla tiene **dos** ocurrencias de `text-transform`: `.badge-traspaso`
   y `.hero-card-control-label`, esta última introducida en esta sesión 29
   *(hipótesis, se mide en FASE 0)*.
10. Ninguna otra clase de rótulo del proyecto (`.section-eyebrow`,
    `.control-label`, `.chart-cell-eyebrow`, `.sub-eyebrow`,
    `.territorio-label`) usa `text-transform`: escriben su texto tal como debe
    leerse *(hipótesis, se mide en FASE 0; es la medición que decide si T3
    corresponde)*.
11. `50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md`
    **no** contiene la cadena `D-color-nivel`, y afirma un tope de "4 entidades
    simultáneas (`MAX_ENTIDADES`)" *(fuente: archivo leído íntegro por el
    asistente el 2026-08-29)*.
12. `50_documentacion/activa/50_diseno_ramas_deteccion.md` tiene encabezados
    `## 1.` a `## 4.`, no tiene `## 5.`, su §2 documenta cuatro fallas
    (A-s28-1 a A-s28-4) y su §3 llega hasta la regla **8**
    *(fuente: archivo leído íntegro por el asistente el 2026-08-29)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 **La apariencia del motor no cambia en esta corrida.** Las ediciones T2 y
  T3 son invisibles por construcción: T2 toca una rama que hoy no se ejecuta y
  T3 preserva el texto renderizado escribiéndolo literal. La prueba es el
  `diff` de T4, no una impresión.
- 🔒 `docs/index.html` se actualiza **por copia íntegra**, jamás por edición
  manual ni parcial.
- 🔒 El D3 minificado vendorizado no se toca en ninguna circunstancia.
- 🔒 Identificadores de código con raíz "entidad" permanecen; solo el texto
  visible dice "territorio".
- 🔒 Ningún comentario CSS puede contener la secuencia literal `*/` adentro.
- 🔒 `cod_com_rbd` es la clave para agregar por comuna, nunca `nom_com_rbd`.
- 🔒 `git status --porcelain` antes de cada `git add`. **Nunca `git add .`**.
- 🔒 Commits atómicos por tipo de contenido: código, publicación y documentación
  no comparten commit.
- 🔒 El log de §7 **no se commitea** en esta corrida: queda para auditoría del
  titular.

---

## 3. Autorizaciones (lista cerrada)

Estás autorizado a:

1. Editar `30_procesamiento/33_motor_template.html` **solo** en los fragmentos
   nombrados en T2 y T3.
2. Editar
   `50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md`
   (T7).
3. Editar `50_documentacion/activa/50_diseno_ramas_deteccion.md` (T8).
4. Ejecutar `Rscript /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_generar_html.R`.
5. Copiar `40_salidas/motor_comparacion.html` sobre `docs/index.html`, **solo**
   con el md5 de origen medido en el mismo turno y verificado idéntico en
   destino después de copiar (T5).
6. `git mv` de un archivo de encargo desde `50_documentacion/andamios/` a
   `50_documentacion/activa/encargos/`, **solo** si FASE 0 mide que existe
   alguno ahí y que está versionado (T6).
7. Crear los commits nombrados en §5.
8. Un único `git push` al final, en FASE FINAL.
9. Escribir el log de §7 en disco, **sin** commitearlo.

**Nada más.** Lo no listado no está autorizado: no `rm`, no `checkout --`, no
`reset`, no `git add .`, no edición de `README.md`, `POLITICA_PROYECTO.md`,
`backlog_acumulativo.md`, `ESTADO.md`, traspasos ni snapshots de estructura.

**Autorización expresa del titular, registrada.** El despliegue a
`docs/index.html` y el commit condicional de `.badge-traspaso` fueron
autorizados explícitamente por Tomás en el chat de la sesión 29, el 2026-08-29,
tras revisar el motor en pantalla. Esta línea es la que habilita T3 y T5.

---

## 4. Regla de detención

Cada tarea declara su conjunto de estados esperados. La lista cierra siempre
con esta cláusula residual:

> **Cualquier estado, conteo o resultado no enumerado en este encargo: congela
> ESTA tarea, regístrala como duda en el log (§7.8) y sigue con la próxima
> tarea independiente según el grafo de §5.** No abortes la cadena completa, no
> ajustes la meta al número encontrado, no interpretes un desvío como
> equivalente a lo esperado.

Dos precisiones que esta sesión ya pagó dos veces:

- **Ningún criterio se expresa como cantidad de líneas de `diff` o de `status`.**
  Se expresa como resultado: "los cuatro campos quedan en el valor objetivo",
  no "el diff son cuatro líneas" *(regla 7 de `50_diseno_ramas_deteccion.md`;
  dos detenciones falsas en esta sesión por incumplirla)*.
- **Antes de creer en un cero, control positivo.** El mismo patrón, con el mismo
  `grep`, debe encontrar el caso donde sí existe *(regla 4 del mismo
  documento)*.

---

## 5. Grafo de tareas

```
T1 (commit panorama) ──┬── T2 (sembradas) ──┐
                       └── T3 (text-transform) ──┴── T4 (rebuild + diff) ── T5 (deploy)

T6 (reubicar encargo)      independiente
T7 (D-color-nivel)         independiente
T8 (A-s28-6)               independiente

T9 (log)                   requiere todas las anteriores, ejecutadas o congeladas
```

- T2 y T3 requieren T1 (el commit del panorama debe ser atómico y anterior).
- T4 requiere T2 y T3, ejecutadas o congeladas: si una se congela, T4 corre
  igual y su `diff` esperado se reduce a la que sí se ejecutó.
- T5 requiere T4.
- T6, T7 y T8 no dependen de nada y se ejecutan aunque la cadena T1–T5 se
  congele.

---

## 5bis. Pendientes deliberadamente excluidos

No entran en esta cadena, y cada exclusión lleva su razón:

| Pendiente | Razón de la exclusión |
|---|---|
| Publicar `herramientas_dev` y registrar `suitedoc` | Bloqueante externo a este repositorio; sesión propia |
| Reparar `renv.lock` y regenerar la suite standalone | Depende del anterior; encargo ya redactado y detenido en `encargo_entorno_y_suite_standalone.md` |
| Desviación triple de taxonomía del backlog | Decisión estratégica del titular, choca con `append-only` |
| Guarda `asegurar_locale_utf8()` ausente | Probablemente vive a nivel de cartera, no de este proyecto |
| `10_validar_portabilidad.R` sin invocador | Misma razón que el anterior |
| Los tres `verificar_*.R` en la raíz | Mover exige decidir antes su condición de ignorados |
| Dos codificaciones de `marca` por época | Requiere el diccionario, que no existe todavía |
| Política de archivado de traspasos | Decisión del titular |
| Actualización anual SIMCE 2025/2026 | Bloqueada: insumos no cargados |

---

## 6. Fases

### FASE 0 — Medición. Solo lectura. No edites nada.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R fetch --quiet --all --prune
git -C $R status --porcelain
git -C $R log --oneline -3
git -C $R rev-parse HEAD origin/main
wc -l $R/30_procesamiento/33_motor_template.html
md5 -q $R/40_salidas/motor_comparacion.html
md5 -q $R/docs/index.html
ls -1 $R/50_documentacion/andamios/
grep -n "const sembradas" $R/30_procesamiento/33_motor_template.html
grep -c "sembradas" $R/30_procesamiento/33_motor_template.html
grep -n "MAX_ENTIDADES = " $R/30_procesamiento/33_motor_template.html
grep -n "text-transform" $R/30_procesamiento/33_motor_template.html
grep -c "text-transform" $R/30_procesamiento/33_motor_template.html
grep -n "badge-traspaso" $R/30_procesamiento/33_motor_template.html
grep -c "D-color-nivel" $R/50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md
grep -rn "D-color-nivel" $R/50_documentacion/ | head -20
grep -n "entidades simultáneas" $R/50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md
grep -n "^## " $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
grep -n "^8\. \*\*Si una rama" $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
grep -c "A-s28-6" $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
```

**Estados esperados (conjunto completo).**

| Medición | Valor esperado |
|---|---|
| `git status --porcelain` | exactamente una línea: ` M 30_procesamiento/33_motor_template.html` |
| `rev-parse HEAD origin/main` | dos hashes idénticos |
| `wc -l` de la plantilla | 4507 |
| `md5` del motor generado | `76711302f54b68523806a3c6d2196789` |
| `md5` de `docs/index.html` | cualquier hash, **distinto** del anterior |
| `ls -1 andamios/` | `logs` solo, o `logs` más uno o más `.md` de encargo |
| `const sembradas` | 1 ocurrencia, dentro de `entidadesPorDefecto()` |
| `sembradas` (total) | 2 ocurrencias: la declaración y su uso en el `console.warn` |
| `MAX_ENTIDADES = ` | 1 ocurrencia, con valor 5 |
| `text-transform` | 2 ocurrencias: `.badge-traspaso` y `.hero-card-control-label` |
| `D-color-nivel` en el archivo de decisión | 0 |
| `D-color-nivel` en `50_documentacion/` | 0 o más; anota **dónde** aparece |
| encabezados `## ` del diseño de ramas | `## 1.` a `## 4.`, sin `## 5.` |
| regla 8 del §3 | presente, es la última |
| `A-s28-6` en el diseño de ramas | 0 |

**Control positivo obligatorio antes de cualquier cero.** Para cada conteo cuyo
valor esperado sea 0, ejecuta el mismo patrón contra un archivo donde el caso
**sí** existe y comprueba que devuelve al menos 1. Para `A-s28-6`, el control es
`grep -c "A-s28-6" $R/50_documentacion/traspasos/traspaso_cierre_v28.md`
(esperado: ≥ 1). Si el control positivo devuelve 0, el instrumento está mudo:
congela la tarea que dependía de él y dilo.

Aplica la cláusula residual de §4 a cualquier medición fuera de la tabla.

---

### T1 — Commit del panorama territorial

Requiere: FASE 0 con `git status` en su estado esperado.

No edites la plantilla. Solo commitea lo que el titular ya colocó y revisó en
pantalla.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R add -- 30_procesamiento/33_motor_template.html
git -C $R status --porcelain
git -C $R commit -m "feat(motor): panorama territorial con GSE combinado y encabezado tipo IDPS"
git -C $R log --oneline -1
```

**Criterio de éxito, como resultado:** existe un commit cuyo único archivo es
`30_procesamiento/33_motor_template.html` y el working tree queda sin
modificaciones versionadas pendientes.

**Calibración del criterio.** Caso malo: el `status` tras el `add` muestra algún
archivo además de la plantilla, o el commit toca más de un archivo. Caso bueno:
`git show --stat` del commit lista exactamente un archivo.

---

### T2 — `const sembradas`: cómputo muerto fuera del aviso

Requiere: T1.

El valor `Math.min(nComunas, MAX_ENTIDADES)` se calcula en el camino nominal y
solo se lee dentro del `console.warn` de una rama que hoy nunca se ejecuta
(Costa Central tiene 4 comunas y el tope es 5).

**Qué hacer.** Elimina la declaración `const sembradas` e interpola la expresión
directamente en el mensaje del `warn`. El texto del mensaje **no cambia**: sus
tres interpolaciones y su redacción se conservan literales.

**Rama de detención previa a editar.** Si `sembradas` aparece en algún lugar
fuera de `entidadesPorDefecto()`, o si aparece más de dos veces en total, no
toques nada y congela la tarea.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -c "sembradas" $R/30_procesamiento/33_motor_template.html
grep -n "el tope de comparacion (MAX_ENTIDADES) es" $R/30_procesamiento/33_motor_template.html
git -C $R add -- 30_procesamiento/33_motor_template.html
git -C $R status --porcelain
git -C $R commit -m "chore(motor): elimina el computo muerto de sembradas fuera del aviso"
```

**Criterio de éxito, como resultado:** no queda ninguna declaración
`const sembradas`; el mensaje del `console.warn` conserva su texto y sus tres
valores interpolados; el conteo de `sembradas` en el archivo queda en 0.

**Calibración.** Caso malo: el `warn` pierde una interpolación o cambia su
redacción. Caso bueno: `git diff HEAD~1 -- 30_procesamiento/33_motor_template.html`
muestra la desaparición de la línea de declaración y una sola línea del `warn`
alterada, con el mismo texto y la expresión en lugar del identificador.

---

### T3 — Rótulos escritos en su caja tipográfica

Requiere: T1. Autorizado expresamente por el titular (§3).

**Premisa que decide la tarea.** El proyecto escribe sus rótulos tal como deben
leerse y no los transforma en CSS: ninguna de las clases de rótulo listadas en
§1.10 usa `text-transform`. Las dos excepciones son `.badge-traspaso`
(preexistente) y `.hero-card-control-label` (introducida en esta sesión 29).

**Rama de detención previa.** Si FASE 0 midió que alguna otra clase de rótulo
del proyecto **sí** usa `text-transform`, entonces la convención no es la que
esta tarea supone: congela T3, no edites, y regístralo como duda con la lista
de clases encontradas.

**Qué hacer, si la premisa se sostiene.**

1. `.badge-traspaso`: quita `text-transform: uppercase` de la regla CSS y
   escribe el texto del badge en mayúsculas literales en el JSX, de modo que
   **lo renderizado no cambie**. El badge dice hoy `traspaso {año}` y se ve
   `TRASPASO {año}`: debe seguir viéndose igual.
2. `.hero-card-control-label`: mismo tratamiento. Quita `text-transform:
   uppercase` de la regla y escribe el rótulo literal en el JSX de
   `PanoramaHero`, de modo que se siga leyendo igual.

No toques `letter-spacing` en ninguna de las dos: es una propiedad tipográfica,
no una transformación del texto.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -c "text-transform" $R/30_procesamiento/33_motor_template.html
grep -n "badge-traspaso" $R/30_procesamiento/33_motor_template.html
grep -n "hero-card-control-label" $R/30_procesamiento/33_motor_template.html
git -C $R add -- 30_procesamiento/33_motor_template.html
git -C $R status --porcelain
git -C $R commit -m "style(motor): escribe los rotulos en su caja tipografica y elimina text-transform"
```

**Criterio de éxito, como resultado:** no queda ninguna declaración
`text-transform` en la plantilla, y ambos rótulos siguen renderizando el mismo
texto que antes, ahora escrito literal en el JSX.

**Calibración.** Caso malo: se elimina la propiedad y el texto queda en
minúsculas, cambiando la apariencia. Caso bueno: el `diff` muestra dos líneas
CSS eliminadas y dos cadenas de texto cambiadas a su forma final.

---

### T4 — Regeneración y verificación por diferencia

Requiere: T2 y T3, ejecutadas o congeladas.

La afirmación a probar no es "el build corrió", es **"el build nuevo difiere del
anterior solo en los fragmentos que este encargo autorizó"**. Se prueba
comparando, no mirando.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
cp $R/40_salidas/motor_comparacion.html /tmp/motor_previo_s29.html
md5 -q /tmp/motor_previo_s29.html
Rscript $R/30_procesamiento/33_generar_html.R
md5 -q $R/40_salidas/motor_comparacion.html
diff /tmp/motor_previo_s29.html $R/40_salidas/motor_comparacion.html
diff /tmp/motor_previo_s29.html $R/40_salidas/motor_comparacion.html | wc -l
git -C $R status --porcelain
```

**Estados esperados.**

| Medición | Valor esperado |
|---|---|
| md5 de la copia previa | `76711302f54b68523806a3c6d2196789` |
| md5 del build nuevo | distinto del anterior |
| `diff` | **solo** las líneas de T2 y T3; ninguna otra |
| `git status --porcelain` | vacío (el motor generado está en `.gitignore`) |

**Rama de detención.** Si el `diff` toca cualquier línea que no provenga de T2 o
de T3 (el bloque base64 del payload, el D3 vendorizado, cualquier otra regla
CSS), **detente**: el gate visual del titular cubre el motor que él revisó, y un
cambio no explicado invalida la premisa del despliegue. Pega el `diff` íntegro y
congela T5.

Si T2 y T3 quedaron ambas congeladas, el `diff` esperado es **vacío** y el md5
debe coincidir con el de la copia previa; en ese caso T5 sigue siendo válida.

**Calibración.** Caso malo: aceptar como equivalente un `diff` que además toca
el bloque base64 del payload, argumentando que "el pipeline recomprime". No
recomprime: los parquet no cambiaron. Caso bueno: cada bloque del `diff` se
puede señalar con el dedo en el commit de T2 o en el de T3.

---

### T5 — Despliegue

Requiere: T4 en verde.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
md5 -q $R/40_salidas/motor_comparacion.html
md5 -q $R/docs/index.html
cp $R/40_salidas/motor_comparacion.html $R/docs/index.html
md5 -q $R/docs/index.html
git -C $R status --porcelain
git -C $R add -- docs/index.html
git -C $R status --porcelain
git -C $R commit -m "deploy(docs): publica el motor con el panorama territorial"
```

**Criterio de éxito, como resultado:** `docs/index.html` y
`40_salidas/motor_comparacion.html` tienen el **mismo** md5 después de la copia,
y el commit toca exclusivamente `docs/index.html`.

**Calibración.** Caso malo: los md5 difieren tras copiar (copia parcial o
destino equivocado), o el commit arrastra otro archivo. Caso bueno: los dos
`md5 -q` posteriores a la copia imprimen la misma cadena.

---

### T6 — Reubicación de encargos fuera de `activa/encargos/`

Independiente. Puede resultar **ya cumplida**: es un resultado válido.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
ls -1 $R/50_documentacion/andamios/
git -C $R ls-files 50_documentacion/andamios/ | grep -v "^50_documentacion/andamios/logs/" || echo "sin encargos versionados fuera de logs/"
```

**Si el listado no muestra ningún `.md` de encargo en `andamios/`:** la tarea
está cumplida. Regístralo en el log con la evidencia y **no crees ningún
commit**.

**Si aparece alguno y está versionado:**

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R mv 50_documentacion/andamios/<archivo>.md 50_documentacion/activa/encargos/<archivo>.md
git -C $R status --porcelain
git -C $R commit -m "docs(encargos): reubica <archivo> a activa/encargos"
```

**Rama de detención.** Si aparece un `.md` de encargo en `andamios/` que **no**
está versionado (`git ls-files` no lo lista), no lo muevas: `git mv` fallará con
`not under version control`. Es el aprendizaje A20 y la falla A-s28-4. Congela y
repórtalo.

**Criterio de éxito, como resultado:** ningún archivo de encargo queda
versionado fuera de `50_documentacion/activa/encargos/`.

**Calibración.** Caso malo: crear un commit vacío o un `git mv` de un archivo no
versionado para "dejar la tarea hecha". Caso bueno: o bien `git ls-files
50_documentacion/andamios/` solo lista rutas bajo `logs/` desde el principio, o
bien un commit mueve el archivo y después las lista solo bajo `logs/`.

---

### T7 — Identificador `D-color-nivel` y tope declarado

Independiente. Archivo:
`50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md`.

**Problema 1.** Otros documentos citan la decisión como `D-color-nivel` y el
archivo no declara ese identificador en ninguna parte.

**Qué hacer.** Agrega al bloque de metadatos del encabezado, junto a `Fecha`,
`Sesión`, `Estado`, `Componente afectado` y `Referencia`, una línea:

```
- **Identificador:** D-color-nivel
```

**Rama de detención.** FASE 0 lista dónde aparece `D-color-nivel` en
`50_documentacion/`. Si la búsqueda devuelve un identificador **distinto** para
esta misma decisión (por ejemplo `D15-1` usado como identificador canónico en
otro documento), no inventes la coincidencia: congela la tarea y reporta ambos.
No compongas el identificador desde el nombre del archivo.

**Problema 2.** El archivo afirma "el tope de 4 entidades simultáneas
(`MAX_ENTIDADES`)". El tope se elevó a 5 en la sesión 28.

**Qué hacer.** Corrige la cifra **al valor medido en FASE 0**, no al que dice
este encargo. Si el valor medido no es 5, usa el medido y dilo en el log.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -c "D-color-nivel" $R/50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md
grep -n "entidades simultáneas" $R/50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md
git -C $R add -- 50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md
git -C $R status --porcelain
git -C $R commit -m "docs(decisiones): declara el identificador D-color-nivel y corrige el tope"
```

**Criterio de éxito, como resultado:** el archivo declara su identificador y no
afirma un tope distinto del medido en el código.

**Calibración.** Caso malo: se agrega el identificador pero el archivo sigue
diciendo 4, o se cambia la cifra a 5 sin medirla. Caso bueno: el `diff` muestra
una línea agregada en el encabezado y una cifra corregida al valor que imprimió
`grep -n "MAX_ENTIDADES = "`.

---

### T8 — A-s28-6 en el diseño de ramas de detención

Independiente. Archivo:
`50_documentacion/activa/50_diseno_ramas_deteccion.md`.

**Dónde va y por qué ahí.** No dentro de `## 2`. Ese apartado agrupa cuatro
fallas que el `## 1` declara explícitamente como **una sola** ("el verificador
midió el síntoma, no la afirmación"). A-s28-6 es de otra familia: no es un
verificador mal escrito, es un diagnóstico equivocado sobre a qué obedece una
herramienta. Meterla en `## 2` rompería la tesis del `## 1`.

**Qué hacer, tres ediciones.**

1. Una sección nueva **después de `## 4`**, encabezada:

   ```
   ## 5. Una quinta falla, de otra familia
   ```

   con el contenido de A-s28-6: qué pasó (ante la detención de F2 se concluyó
   que el instrumento modelaba un backlog inexistente y se propuso enmendarlo;
   falso, las tres estructuras las fija POLITICA §10, norma escrita y anterior
   al instrumento), por qué es un error distinto de los cuatro anteriores, y la
   regla: antes de declarar que una herramienta está mal calibrada, comprobar si
   su referente es la historia del archivo o una norma externa; si es lo
   segundo, el desajuste lo tiene el archivo.

2. Una regla **9** al final del `## 3`, en el mismo estilo imperativo de las
   ocho existentes, que enuncie esa comprobación del referente.

3. Una línea al final de la lista de comprobación del `## 4`:

   ```
   - [ ] Si el encargo enmienda una herramienta de verificación, declaré su
         referente y comprobé que no es una norma externa.
   ```

**Rama de detención.** Si FASE 0 midió que el `## 3` ya tiene una regla 9, o que
`A-s28-6` ya aparece en el archivo, congela la tarea: alguien la hizo antes y
duplicarla es peor que no hacerla.

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
grep -n "^## " $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
grep -c "A-s28-6" $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
git -C $R add -- 50_documentacion/activa/50_diseno_ramas_deteccion.md
git -C $R status --porcelain
git -C $R commit -m "docs(gobernanza): incorpora A-s28-6 al diseno de ramas de deteccion"
```

**Criterio de éxito, como resultado:** el documento registra A-s28-6 sin alterar
la tesis del `## 1` ni renumerar las cuatro fallas existentes, y sus reglas de
redacción incluyen la comprobación del referente.

**Calibración.** Caso malo: A-s28-6 queda insertada dentro de `## 2` y el `## 1`
sigue diciendo "las cuatro fallas". Caso bueno: `grep -n "^## "` devuelve `## 1`
a `## 5`, y el texto del `## 1` no fue tocado.

---

### FASE FINAL — Auto-auditoría y publicación

**Auto-auditoría antes de reportar.** Recorre el encargo entero y responde por
escrito, en el log:

1. ¿Alguna rama de detención se disparó en el camino nominal? Si sí, la rama
   estaba mal escrita: dilo, no lo escondas.
2. ¿Cada cero que reportas tiene su control positivo ejecutado?
3. ¿Cada cifra del reporte viene del comando que la produjo, citado en la misma
   línea?
4. ¿Algún commit toca más archivos que los que su tarea autorizaba?

```bash
R=/Users/tomgc/Projects/slep_simce_adecuado
git -C $R log --oneline -8
git -C $R log --stat -6 --format="%h %s"
git -C $R status --porcelain
git -C $R push
git -C $R rev-parse HEAD origin/main
```

**Estados esperados.**

| Medición | Valor esperado |
|---|---|
| `log --stat` | ningún commit toca un archivo fuera de su tarea |
| `status --porcelain` antes del push | solo el log sin trackear, si ya lo escribiste |
| `rev-parse HEAD origin/main` | dos hashes idénticos tras el push |

---

## 7. Log

Escribe en disco, **sin commitear**:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/20260829_pendientes_inmediatos_s29_log.md
```

con la fecha real del día si no es el 29 de agosto de 2026. Es el documento que
el titular audita, así que debe permitir reconstruir la ejecución sin tenerte
delante. Estructura fija:

1. **Resumen:** qué entró, cuántas tareas se ejecutaron, cuántas se congelaron,
   estado final del repositorio.
2. **Inventario de commits:** todos, con hash corto, tipo, título, archivos
   tocados y una línea de qué hizo cada uno.
3. **Por cada tarea:** salida **literal** de sus comandos de verificación, no su
   resumen, y una tabla de tres columnas: medición, valor esperado, valor
   medido.
4. **El `diff` íntegro de T4**, pegado literal. Es la única evidencia de que el
   despliegue publica lo que el titular revisó.
5. **Controles positivos:** cada cero reportado, con el comando de control y su
   resultado.
6. **Verificación de invariantes:** cada 🔒 de §2 con PASA / FALLA y su
   evidencia.
7. **Decisiones autónomas:** cada decisión tomada sin gate, con la alternativa
   descartada y su reversibilidad (reversible / costosa / irreversible).
8. **Dudas y tareas congeladas:** cada una con contexto en una línea, la
   pregunta **cerrada** que la resuelve, y qué quedó bloqueado por ella.
9. **Cifras críticas:** md5 del motor antes y después, md5 de `docs/index.html`
   antes y después, hashes de todos los commits.
10. **Lo que quedó sin verificar y por qué.** En particular: no abres navegador,
    así que la equivalencia visual tras T2 y T3 queda declarada como **no
    verificada por ti**; lo que sí verificaste es el `diff`.
11. **Notas para el revisor:** qué mirar con ojo crítico.

Toda cifra que afirmes lleva el comando que la produjo en la misma línea. Una
cifra sin comando al lado es un defecto del log.

---

## 8. Reporte final al chat

1. Tabla de tareas: ejecutada / congelada, con una línea por cada una.
2. Los hashes de todos los commits creados.
3. La tabla de esperado contra medido de FASE 0 y de T4.
4. El `diff` de T4, íntegro.
5. Confirmación de que `docs/index.html` y el motor generado comparten md5.
6. Ruta del log, y la advertencia de que quedó **sin commitear** a la espera de
   auditoría.
7. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No commitees el log ni este archivo de encargo: el titular los revisa primero.
