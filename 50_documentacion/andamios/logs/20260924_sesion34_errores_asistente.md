# Errores del asistente — sesión 34 (2026-09-24)

Registro en el momento en que se identifica (SETTINGS §2.2.15, diez campos).

**ERR-34-01**
- `momento`: primera instrucción corta a Claude Code (regenerar el motor, batería, copia a `docs/`).
- `disparador`: usuario lo señaló sin nombrarlo error (Claude Code reportó dos archivos modificados sin autor conocido).
- `que_paso`: la instrucción no declaró que `33_motor_template.html` y `publicacion_github_pages.md` ya venían editados por el asistente en la carpeta, y el ejecutor tuvo que investigar su origen por la hora de modificación.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente en línea, tipo 4 (toda premisa de hecho de un encargo) y regla «Ningún comando asume el entorno».
- `causa_raiz`: traté el estado del árbol como contexto compartido porque lo había dicho en el chat al titular, sin llevarlo a la instrucción, que es lo único que el ejecutor lee.
- `salvaguarda_presente`: SETTINGS §1.2.6.
- `patron`: PAT-12, encargo sin la premisa de estado que el chat sí tenía.
- `gatillo_observable`: encargos-premisas: una instrucción a Claude Code que regenera desde archivos editados en la sesión sin nombrarlos ni dar su md5.
- `intentos_previos`: 0.
- `costo`: una verificación extra del ejecutor (`git diff --stat` y `ls -lT`); ningún archivo tocado de más.

**ERR-34-02**
- `momento`: compuertas de dudas previas a las dos publicaciones de la sesión (enlace de la vista, `cc7fd64`; fragmento común, `a095a50`).
- `disparador`: asistente lo señaló espontáneamente, al preparar el cierre.
- `que_paso`: entregué la instrucción de commit y push en el mismo mensaje que la comprobación de Safari que cerraba la duda 1, condicionada solo en prosa («si pasan»), y las dos veces el push corrió antes de que el resultado llegara al chat.
- `regla_violada`: SETTINGS §2.1, compuerta de dudas, gatillo 2 (antes de una operación de efecto público), y §1.2.6, «Generar, verificar, consumar: en ese orden».
- `causa_raiz`: optimicé turnos juntando medición y consumo en un solo mensaje; la condición quedó en una frase para el titular y no en la instrucción al ejecutor, que no puede evaluarla.
- `salvaguarda_presente`: SETTINGS §2.1 y §1.2.6.
- `patron`: PAT-02, consumo entregado antes de que llegara la verificación intermedia.
- `gatillo_observable`: costo-sobre-regla: un mensaje que contiene a la vez una medición pendiente del titular y la instrucción de push que depende de ella.
- `intentos_previos`: 1 (la segunda publicación repitió la forma de la primera).
- `costo`: dos publicaciones hechas antes de cerrar su duda; ambas verificadas después en Safari sobre Pages (4 de 4), sin cifra ni enlace erróneo publicado.
