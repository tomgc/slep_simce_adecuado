# Decisión: regla de filas, publicación e identidad visual de la vista de trayectorias

**Fecha:** 2026-09-24 (sesión 33). **Decide:** el titular, sobre la propuesta del asistente.
**Código:** `30_procesamiento/36_funciones_trayectorias.R`, `36_generar_trayectorias.R`,
`36_verificar_trayectorias.R` y `36_trayectorias_template.html` (D33-1 y D33-8); el resto se ejecuta en
tareas posteriores de la misma sesión o de la siguiente.

## D33-1. La vista usa la regla de filas del motor

**Contexto.** El traspaso v32 (pendiente 4) registró que la vista incluía las filas con marca de la Agencia
y no aplicaba el umbral de 10 evaluados, mientras el motor excluye ambas (invariante 5,
`33_generar_html.R`). Medido en la sesión 33 sobre `simce_rbd.parquet`: en la base de la vista hay 0 filas
con menos de 10 evaluados (la Agencia no publica porcentajes por nivel bajo ese umbral), así que la
diferencia real son las filas marcadas: 2.008 en el país, 610 en los Servicios Locales (2,1% de sus
evaluados). Excluirlas mueve 178 de 1.665 puntos del total de grupos en 1 punto o más (máximo 15,6), y 37
de los 73 cambios de 5 puntos o más caen en 2014, el año de partida de las trayectorias. El referente pasa
de 1.333 a 1.299 establecimientos.

**Decisión.** Opción A: la vista aplica la regla del motor (sin marca y con al menos `UMBRAL_EVALUADOS = 10`
evaluados). Motivo: la vista y el motor muestran los mismos Servicios Locales, y las filas que la Agencia
marca son las que más mueven el punto de partida de 2014.

**Alternativa descartada.** B, mantener la diferencia declarada: el mismo Servicio Local mostraba cifras
distintas en las dos vistas (Andalién Costa, 2° medio Matemática 2014: 13,8% contra 28,0% en Adecuado).

**Precedente distinto, vigente.** `34_historico_pct_adecuado_costa_central.R` incluye las filas marcadas
por decisión del titular de la sesión 26. Esta decisión no lo toca.

**Verificación.** D14 y D14c de `36_verificar_trayectorias.R`. D10 sigue cotejando la maquinaria de
agregación contra el mockup con su regla original (`excluir_marcadas = FALSE`).

## D33-2. La vista se publica como tercera entrada del menú del motor

**Decisión.** La vista se publica en `docs/trayectorias.html` y se enlaza desde el menú de vistas del
motor, como tercer botón a la derecha de «Panorama territorial» y con su mismo estilo. La página de
trayectorias repite el encabezado del motor con esa tercera entrada activa, y sus otras dos entradas
vuelven al motor en la pestaña correspondiente. Se ejecuta después de corregir los defectos de forma.

**Lectura de la instrucción ⚠️ del traspaso v32** («NO integrar la vista de trayectorias como pestaña de
`33_motor_template.html`»): prohíbe incrustar la vista (su código y sus datos) dentro del motor. Una
entrada de menú que navega a otra página no la infringe: cada vista sigue en su propio archivo. En el
código, la entrada es un enlace con el aspecto de las pestañas, fuera de la lista de pestañas, porque para
la accesibilidad una pestaña y un enlace a otra página son cosas distintas.

**Alternativas descartadas.** A1, página aparte sin enlace (la vista no se encuentra desde la puerta de
entrada pública); B, no publicar.

**Nombres de archivo.** Mandan los de Pages: `index.html` y `trayectorias.html`. La salida local de la vista
pasa a `40_salidas/trayectorias.html`; abiertos desde `40_salidas/`, solo el enlace de vuelta al motor queda
roto, porque el motor local se llama `motor_comparacion.html`.

## D33-3. La vista adopta la identidad visual del motor

**Decisión.** La vista deja de parecer un proyecto aparte: toma el encabezado, la paleta institucional
(océano, ciruela, coral, crema), los componentes y la fuente del motor. Lo que codifica el dato
(burbujas, referente, nube, hueco 2019-2021) no cambia; se conserva el piso tipográfico alto que la vista
tiene para proyección.

- **Tema oscuro:** se elimina. El motor solo tiene tema claro y el modo oscuro de la vista era un
  experimento.
- **Tipografía:** la vista adopta la del motor (fuente del sistema) y deja de incrustar gobCL.
- **Nombre de la entrada del menú:** «Trayectorias de los Servicios Locales».

## D33-4. Migración de todos los sitios y proyectos del equipo a gobCL

**Decisión del titular.** Todos los sitios y proyectos del equipo migran a la fuente institucional gobCL.
En este proyecto, el motor y la vista pasan juntos, en un cambio propio (el motor ya lo anticipa en
`33_motor_template.html`, L79-80). No se hace dentro de D33-3, porque cambia el aspecto de todo el motor y
necesita su propia verificación.

## D33-5. La revisión en Safari se hace después de corregir los defectos de forma

**Decisión.** La duda 1 de la compuerta v32 se mide cuando los nueve defectos estén corregidos, con una
lista nueva escrita como archivo en `50_documentacion/activa/`. La lista de la sesión 32 se entregó en el
chat y no está en el repositorio.

## D33-6. Las cifras de las notas metodológicas se calculan desde los datos

**Contexto.** Las notas traían cifras literales copiadas del mockup, que quedaban obsoletas con cualquier
cambio de regla o de año (la actualización Simce 2026 las habría dejado todas desfasadas).

**Decisión del asistente, informada al titular.** `cifras_notas()` calcula las cifras y el generador las
inserta en marcadores `__NOTA_<NOMBRE>__`; el generador se detiene si queda alguno. Con la regla anterior
reproduce exactas 11 de las cifras del mockup. Dos no se reproducen con ninguna definición medida sobre
el propio DATA del mockup: la mediana del movimiento anual (el mockup decía 2,9; con la definición escrita
en el código da 2,1 con la regla anterior y 2,2 con la vigente) y la correlación con el cambio nacional
(0,53; da 0,52 y 0,51). El ejemplo de Palena queda literal y D11 comprueba que sigue en los datos.
