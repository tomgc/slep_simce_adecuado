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
