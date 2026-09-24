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
