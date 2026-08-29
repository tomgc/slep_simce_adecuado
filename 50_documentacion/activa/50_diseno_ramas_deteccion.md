# Diseño de ramas de detención y verificadores en encargos autónomos

> **Destino:** `50_documentacion/activa/50_diseno_ramas_deteccion.md`
> **Origen:** auditoría de la sesión 28 (2026-08-27), tras tres detenciones falsas
> y un verificador ciego en cuatro encargos autónomos consecutivos.
> **Ámbito:** aplica a todo encargo autónomo de la cartera `slep_*`, y a la
> plantilla de encargo de `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.

---

## 1. El error de fondo, en una frase

**El verificador midió el síntoma, no la afirmación.**

Las cuatro fallas registradas abajo son la misma: se escribió una comprobación
que era fácil de expresar en `grep`, y se la trató como si probara lo que en
realidad no probaba. El encargo quedó sintácticamente riguroso y epistémicamente
hueco.

Ninguna de las cuatro rompió nada, porque quien ejecutaba razonó por encima del
texto. Esa es precisamente la razón para corregirlas: un encargo que solo
funciona cuando el ejecutor desobedece su letra no es un encargo, es una
sugerencia con formato de contrato.

---

## 2. Las cuatro fallas registradas

### A-s28-1 — Rama de detención que no distingue lo inesperado de lo no contemplado

**Qué pasó.** Tres encargos declararon "si `git status` no está limpio,
DETENTE". En las tres corridas el árbol traía untracked los propios archivos de
encargo que se estaban ejecutando. Bajo lectura literal, la rama se disparaba
siempre y el encargo era inejecutable por construcción.

Variante del mismo error en el encargo de ordenación: "si algún `grep` devuelve
coincidencias en archivos que este encargo no autoriza a editar, detente". Todas
las referencias caían en traspasos, backlog y snapshots, es decir, en archivos
que los propios invariantes declaraban intocables. La rama se disparaba por el
estado normal del repositorio.

**Por qué es un error y no una precaución.** Una rama que se dispara en el
escenario nominal no protege de nada: entrena a quien ejecuta a interpretarla en
vez de obedecerla, y el día que se dispare por un motivo real recibirá el mismo
tratamiento.

**Regla.** Toda rama de detención declara el **conjunto de estados esperados**,
no solo el estado ideal, y cierra con una **cláusula residual**:

> Esperado: árbol limpio, salvo untracked que sean archivos de este mismo
> encargo o su log. Cualquier archivo **versionado** modificado o cualquier otro
> untracked: DETENTE y repórtalo.

Si al redactar no se logra enumerar los estados esperados, la rama todavía no
está lista: falta medir el estado real antes de escribirla.

### A-s28-2 — Verificador de ausencia sin control positivo

**Qué pasó.** El encargo de migración tipográfica del SVG pedía, como única
comprobación, que el conteo de literales numéricos bajara a cero. Ese conteo se
cumple igual si los 18 valores se preservaron que si todos se reemplazaron por
`12`. La afirmación a probar era "los valores se preservaron"; lo medido era "ya
no hay literales".

Quien ejecutó lo notó y añadió una comprobación de multiconjunto que el encargo
no pedía. Sin esa iniciativa, un refactor que cambiara todos los tamaños habría
pasado las verificaciones con todo en verde.

**Precedente en el mismo proyecto.** La sesión 27 declaró "0 residuos" tras
inventariar 96 declaraciones, y el inventario había omitido una familia entera
(`fontSize` inline React). La ausencia se verificó contra un universo incompleto.

**Regla.** Cuando la tarea es **preservar** algo mientras cambia su forma, la
verificación es una **invariante medida antes y después**: multiconjunto de
valores, md5, conteo por categoría. Un conteo de residuos a cero acompaña esa
invariante, nunca la sustituye.

**Corolario del control positivo.** Antes de aceptar un "0 coincidencias" como
prueba de ausencia, hay que comprobar que el instrumento **sí** encuentra el caso
cuando existe. Un patrón mal escrito devuelve 0 y parece una buena noticia.

### A-s28-3 — El instrumento no matchea lo que se cree

**Qué pasó.** `grep -c "repeat(\${entities.length}"` devolvió 0 antes y después
de editar, en las dos corridas, porque `grep` de BSD interpreta `{…}` como
expresión de intervalo. La rama de detención asociada ("si este número cambió,
detente") no podía dispararse en ningún escenario: era un centinela mudo.

**Regla.** En macOS, todo patrón con `{`, `}`, `+` o `?` va con `grep -F`, o con
el metacarácter escapado. Y toda rama de detención basada en un conteo se valida
comprobando que el conteo **inicial** es el esperado: si el baseline no es el
predicho, el instrumento está mal antes de que el trabajo empiece.

### A-s28-4 — La premisa mide una cosa y afirma otra

**Qué pasó, dos veces.**

1. Un encargo afirmó "los tres scripts sueltos están en la raíz" citando el
   escáner. El escáner lista el **disco**; los tres estaban en `.gitignore` y no
   versionados. `git mv` falló con `not under version control`. Es el aprendizaje
   A20 del proyecto, incumplido por quien lo escribió.
2. Otro encargo afirmó "la guarda `asegurar_locale_utf8` existe" citando
   `grep -rl … | wc -l = 1`. Ese comando prueba que **la cadena aparece** en un
   archivo, no que **la función esté definida**. Medido con
   `git grep "asegurar_locale_utf8 *<- *function"`: no existe en el repositorio.

**Regla.** Una premisa citada con `(fuente: …)` obliga a que el comando citado
pruebe **exactamente** la afirmación. Para estado del repositorio, la fuente es
`git ls-files` o `git status`, nunca el escáner. Para existencia de una función,
el patrón incluye la asignación, no solo el identificador.

---

## 3. Reglas operativas para redactar el próximo encargo

1. **Estados esperados como conjunto, más cláusula residual.** Enumera lo que es
   normal; detén ante lo que no enumeraste. Nunca "si no está limpio, detente".
2. **Distingue detener de reportar y seguir.** No todo desvío justifica abortar.
   Cada rama declara cuál de las dos cosas hace y por qué.
3. **Preservar exige invariante, no conteo de residuos.** Mide antes, mide
   después, compara.
4. **Control positivo antes de creer en un cero.** El instrumento debe encontrar
   el caso cuando existe.
5. **Valida el baseline.** Si la medición inicial no coincide con lo predicho, el
   problema está en el encargo, no en el repositorio: repórtalo antes de editar.
6. **La fuente prueba la afirmación, no algo cercano.** Disco no es índice.
   Aparición de una cadena no es definición de una función.
7. **El criterio se expresa como resultado, no como cantidad.** "Ninguno
   sobrevive", no "elimina los dieciocho": si el número real difiere, el encargo
   sigue siendo ejecutable y el desvío queda reportado.
8. **Si una rama se dispararía en el escenario nominal, está mal escrita.**
   Prueba mental obligatoria antes de entregar: recorre el camino feliz y
   comprueba que ninguna rama salta.
9. **Antes de enmendar una herramienta, comprueba su referente.** Si mide
   contra la historia del propio archivo, la herramienta admite enmienda; si
   mide contra una norma escrita y anterior a ella, el desajuste lo tiene el
   archivo, y enmendar la herramienta consagra la desviación.
10. **Ninguna magnitud del proceso sirve de criterio.** Líneas de un `diff`,
    líneas de `git status`, número de commits: son subproductos de cómo quedó
    hecho el trabajo, no del trabajo. El criterio nombra el estado final: "los
    cuatro campos quedan en el valor objetivo", no "el diff son cuatro líneas".
    Es el caso particular de la regla 7 que la sesión 29 incumplió cuatro veces
    seguidas pese a tenerla escrita.
11. **Un patrón sobre prosa se ancla en una palabra, no en una frase.** `grep`
    opera línea a línea y el texto con ajuste de línea parte las frases: una
    frase partida no matchea nunca, y su cero se lee como ausencia. Si hace
    falta la frase completa, normaliza antes (`tr -d '\n'`) o usa `grep -z`.

---

## 4. Comprobación previa a entregar un encargo

- [ ] Recorrí el camino nominal y ninguna rama de detención se dispara.
- [ ] Cada rama declara el conjunto de estados esperados y cierra con cláusula
      residual.
- [ ] Cada rama dice si detiene o si reporta y sigue.
- [ ] Toda tarea de preservación tiene invariante medida antes y después.
- [ ] Ningún patrón con llaves va sin `-F`.
- [ ] Cada premisa `(fuente: …)` se prueba con el comando citado, y ese comando
      mide la afirmación literal, no un síntoma.
- [ ] Los criterios están en forma de resultado, no de cantidad esperada.
- [ ] El log pide salida literal, tabla de esperado contra medido, y lo que quedó
      sin verificar.
- [ ] Si el encargo enmienda una herramienta de verificación, declaré su
      referente y comprobé que no es una norma externa.
- [ ] Ningún criterio cuenta líneas de `diff`, líneas de `git status` ni
      commits.
- [ ] La tabla de estados esperados de FASE 0 enumera los artefactos sin
      versionar del propio encargo: su `.md` y su log.
- [ ] Ningún patrón de verificación sobre prosa abarca más de una palabra
      ancla.

---

## 5. Una quinta falla, de otra familia

### A-s28-6 — Se declaró mal calibrada una herramienta sin comprobar su referente

**Qué pasó.** Ante la detención de F2 se concluyó que el instrumento modelaba un
backlog inexistente y se propuso enmendarlo. Es falso: las tres estructuras las
fija `POLITICA_PROYECTO.md` §10, norma escrita del proyecto y anterior al
instrumento. La herramienta medía lo que decía medir; el desviado era el archivo.

**Por qué no va en el `## 2`.** Las cuatro fallas de ese apartado son una sola,
la que enuncia el `## 1`: el verificador midió el síntoma, no la afirmación.
A-s28-6 no comparte esa tesis. Aquí el verificador estaba bien escrito y midió
exactamente su afirmación; lo que falló fue el diagnóstico posterior sobre a qué
obedece la herramienta. Es un error de atribución, no de instrumentación.
Sumarla a la lista del `## 2` obligaría a decir "las cinco fallas son la misma",
y no lo son.

**Por qué importa.** La consecuencia de este error no es un verde falso, como en
las cuatro anteriores, sino algo peor: enmendar el instrumento correcto. Una
herramienta que mide contra una norma externa y detecta un desajuste está
haciendo su trabajo. Ajustarla al archivo desviado consagra la desviación y
destruye la única señal que la delataba.

**Regla.** Antes de declarar que una herramienta de verificación está mal
calibrada, comprueba contra qué mide. Si su referente es la historia del propio
archivo, la herramienta admite enmienda. Si su referente es una norma escrita y
anterior al instrumento, el desajuste lo tiene el archivo.

---

## 6. Reincidencia: la sesión 29 repitió dos reglas ya escritas

El apartado anterior documenta fallas nuevas. Este documenta lo contrario, que
es peor: reglas de este mismo archivo incumplidas por quien lo tenía delante.
Ninguna de las dos exigía una regla nueva. Se registran porque una norma que se
incumple cuatro veces en una sesión no tiene un problema de contenido, tiene un
problema de forma: era demasiado abstracta para verse en el borrador.

### A-s29-1 — Cuatro criterios expresados como cantidad de proceso

**Qué pasó, cuatro veces en una sola sesión.**

1. "El diff es de 4 líneas eliminadas y 4 añadidas." Dos de los cuatro campos ya
   tenían el valor objetivo, así que el diff real fue de 2 y 2. Detención falsa.
2. "`git status` muestra dos líneas modificadas." El motor generado está en
   `.gitignore` y no puede aparecer nunca en `status`. Detención falsa.
3. "`git status --porcelain`: exactamente una línea." Había dos, y la segunda era
   el archivo del propio encargo sin versionar. Detención falsa, y además ya
   normada por la regla 1 de este documento, que la cita textualmente.
4. "Tres commits nuevos sobre `2e75100`." Eran dos: la tercera línea de
   `git log --oneline -3` es la base, no un commit nuevo. Desvío reportado.

**Por qué la regla 7 no bastó.** La regla decía "el criterio se expresa como
resultado, no como cantidad", y su ejemplo hablaba de cantidades del *objeto*
("elimina los dieciocho"). Las cuatro reincidencias son cantidades del
*proceso*: cuánto ocupó el cambio en un `diff`, cuántas líneas imprimió un
comando, cuántos commits salieron. Quien redacta no las reconoce como cantidades
porque las siente descripciones de rigor. Por eso la regla 10 las nombra una por
una: una lista cerrada es visible en el borrador, un principio no.

**Regla.** Ver la regla 10 del `## 3`.

### A-s29-2 — Verificador mudo por salto de línea

**Qué pasó.** `grep -n "entidades simultáneas"` sobre un archivo de decisión
devolvió 0. La premisa que lo citaba era correcta: la frase existe, partida
entre dos líneas por el ajuste del texto.

```
53:swatch y borde de ficha, canales suficientes con el tope de 4 entidades
54:simultáneas (`MAX_ENTIDADES`).
```

El control positivo lo delató: el mismo patrón matchea en los archivos donde la
frase cabe en una línea. Sin ese control, el cero habría pasado por ausencia y
la premisa por falsa.

**Familia.** Es A-s28-3 con otra causa. Allí el instrumento era mudo por la
sintaxis de `grep` en BSD; aquí, por la unidad de trabajo de `grep`, que es la
línea y no el párrafo. La lección común: un patrón que no puede matchear en
ningún escenario es un centinela mudo, y el control positivo es lo único que lo
distingue de una ausencia real.

**Regla.** Ver la regla 11 del `## 3`.
