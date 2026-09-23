# Instrucción de apertura — replicar el visualizador de trayectorias

> **Destino:** `50_documentacion/andamios/20260917_instruccion_spinoff_trayectorias.md`
> **Origen:** sesión 30 de `slep_simce_adecuado`, 2026-09-17.
> **Uso:** abrir una sesión de Cowork sobre el repositorio de destino y pegar la
> sección que corresponda. La sección 1 es común a los dos casos.

---

## 1. Qué se replica y de dónde sale

Existe un visualizador terminado y auditado en `slep_simce_adecuado`. Es un
motor web autocontenido que anima, año a año, cómo se mueven los Servicios
Locales de una cohorte de traspaso en un plano de dos indicadores
complementarios, con una nube de contexto detrás y una tarjeta de cobertura al
costado. Este encargo no lo rediseña: lo traslada a otro dominio.

**Archivos que hay que leer antes de escribir una línea** (están en el
repositorio `slep_simce_adecuado`, que conviene tener conectado junto al de
destino durante la sesión):

| Archivo | Para qué |
|---|---|
| `50_documentacion/andamios/mockup_trayectoria_traspasos.html` | La implementación de referencia. Un solo archivo, sin librerías ni red. Ábrelo antes de leerlo. |
| `50_documentacion/andamios/verificar_trayectorias.R` | La batería de verificación de la capa de datos, con control positivo. Se adapta, no se reinventa. |
| `50_documentacion/andamios/20260911_brief_diseno_spinoff.md` | El encargo de diseño con las decisiones ya cerradas y sus razones. |
| `50_documentacion/andamios/logs/20260911_sesion30_errores_asistente.md` | Los trece errores cometidos construyéndolo. Leerlo ahorra repetirlos. |

**Lo que se copia tal cual, sin rediscutir:**

- Un solo archivo HTML autocontenido, SVG y JavaScript sin librerías, sin CDN,
  con las tres caras de gobCL incrustadas como `data:` URI.
- Tema claro por omisión y tema oscuro diseñado aparte, no invertido.
- Tres tamaños de letra (21, 15 y 13 píxeles) más el año en 42. Nada más.
- Todo cabe en una pantalla sin desplazamiento, a 1920×1080, 1680×950 y
  1366×768.
- Controles en una fila, modo presentación con icono, velocidad en tres iconos.
- La tarjeta lateral con casillas por entidad, su número, el conteo de unidades
  que sostienen cada cifra y el desglose plegable.
- La animación no arranca sola; cambiar cualquier filtro la detiene y la
  devuelve al primer período.
- Las burbujas llevan su número adentro (radio mínimo 12 píxeles) y las chicas
  se dibujan sobre las grandes.
- Una unidad sin dato en un período no desaparece: queda en su última posición
  medida, con contorno punteado, y el tooltip declara de qué período vienen las
  cifras.
- Las advertencias metodológicas viven en una sola ventana modal, no al pie.

**Lo que hay que decidir de nuevo en cada dominio** (es el trabajo real de la
sesión, y va antes de tocar el motor):

1. **Los dos ejes.** Tienen que ser dos indicadores de la misma distribución,
   complementarios, de modo que avanzar signifique moverse hacia una esquina.
   En el original son porcentaje en nivel Adecuado (horizontal, ascendente) y
   porcentaje en nivel Insuficiente (vertical, invertido).
2. **El tamaño de la burbuja.** En el original es el número de estudiantes
   evaluados. Debe ser una magnitud que haga comparables a las entidades.
3. **El eje temporal.** En el original son nueve años con medición y un hueco
   declarado de tres años sin dato.
4. **La nube de contexto.** En el original son 180 sostenedores municipales, uno
   por comuna. Debe ser el universo dentro del cual la entidad se ubica.
5. **El referente.** En el original es el agregado congelado de esa misma nube.
   Su marca no sigue la escala de área y eso se declara.
6. **Los controles de rigor.** En el original hay uno: restringir a las unidades
   con serie completa, para separar cambio de composición de cambio de resultado.

**Invariantes que no se negocian, cualquiera sea el dominio:**

- El instrumento describe trayectorias y no afirma causalidad. Nada de flechas
  de antes y después, nada de verde para «mejoró».
- Los períodos sin medición se dibujan como hueco. No se interpola.
- La cobertura se declara en pantalla: cuántas unidades sostienen cada cifra
  respecto del total que la entidad administra.
- Todo agregado acumula numeradores crudos y redondea una sola vez al final.
- Antes de dar por buena cualquier cifra, correr la batería de verificación
  adaptada, con su control positivo.

**Orden de trabajo:** primero medir el dato disponible y decidir los seis puntos
de arriba; después adaptar la batería de verificación y correrla; recién
entonces tocar el motor.

---

## 2. Variante A — asistencia

> Repositorio de destino: confirmar cuál corresponde entre
> `~/Projects/slep_minuta_asistencia`,
> `~/Projects/slep_reportes_modelo_resguardo_asistencia` y
> `~/Projects/slep_costapresente` (hipótesis: no pude verificar los nombres
> desde la sesión que generó este documento).

Tipo de sesión: NEW PROJECT anidado en una CONTINUATION del repositorio de
destino. Lee `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`
desde la knowledge base antes de proponer nada.

**Encargo.** Construir el equivalente del visualizador de trayectorias para
asistencia escolar, usando la implementación de referencia como base técnica y
visual, y resolviendo primero las seis decisiones de dominio de la sección 1.

**Punto de partida sugerido para las decisiones, a validar contra el dato real
antes de adoptarlo:**

- Ejes: porcentaje de estudiantes con asistencia regular (horizontal,
  ascendente) contra porcentaje de estudiantes con inasistencia grave
  (vertical, invertido). Son dos tramos de la misma distribución de asistencia,
  así que su suma tiene un techo y el plano tiene una zona imposible, igual que
  el original.
- Tamaño de la burbuja: matrícula del establecimiento o del territorio.
- Eje temporal: aquí hay una diferencia de fondo con el original. La asistencia
  se mide todos los meses, no una vez al año, así que la serie es mucho más
  densa y tiene estacionalidad (marzo y diciembre no son comparables con junio).
  **Decidir explícitamente** si la animación corre por meses, por año escolar, o
  por mes con el mismo mes del año anterior como referencia, y declarar la
  elección en las notas. Es la decisión más importante de esta variante.
- Nube de contexto: un punto por establecimiento del propio Servicio Local, o
  por sostenedor, según la unidad que se esté comparando.
- Control de rigor: restringir a los establecimientos con serie completa en
  todos los períodos.

**Advertencia propia de este dominio.** La asistencia tiene un quiebre conocido
en 2020 y 2021 que no es un hueco de medición sino un cambio de régimen.
Tratarlo como hueco sería falso. Decidir si la serie parte en 2022 o si el
tramo anterior se marca como otro régimen, y declararlo.

---

## 3. Variante B — matrícula

> Repositorio de destino: `~/Projects/slep_analisis_matricula` (hipótesis: no
> pude verificar el nombre desde la sesión que generó este documento).

Tipo de sesión: NEW PROJECT anidado en una CONTINUATION del repositorio de
destino, con el mismo protocolo.

**Encargo.** Construir el equivalente del visualizador de trayectorias para
matrícula, con la misma base técnica y visual.

**Punto de partida sugerido para las decisiones, a validar contra el dato real:**

- Ejes: aquí la elección es menos obvia que en asistencia y merece medición
  antes de decidir. Dos candidatos:
  - Participación en la matrícula del territorio (horizontal, ascendente)
    contra porcentaje de estudiantes que emigran a otro sostenedor (vertical,
    invertido). Son complementarios y describen la posición competitiva.
  - Matrícula efectiva sobre capacidad declarada (horizontal) contra
    porcentaje de cursos bajo el mínimo viable (vertical, invertido). Describe
    la sostenibilidad de la oferta.
  **Recomendación:** el primero, porque la pregunta que el Área hace sobre
  matrícula es de posición en el territorio y no de ocupación de plazas, y
  porque el segundo exige un dato de capacidad que no siempre está.
- Tamaño de la burbuja: matrícula total de la entidad.
- Eje temporal: matrícula sí tiene serie anual continua, sin el hueco de Simce.
  Aprovecharlo, y verificar que la ausencia de hueco no deje código muerto
  heredado del original (el tramo de cruce con deriva y su aviso).
- Nube de contexto: un punto por comuna o por sostenedor del territorio.
- Control de rigor: restringir a los establecimientos presentes en todos los
  años, para separar el cierre o apertura de escuelas del cambio de matrícula.

**Advertencia propia de este dominio.** La matrícula de un Servicio Local crece
cuando recibe establecimientos traspasados, no solo cuando capta estudiantes.
Distinguir las dos cosas o el instrumento contará un traspaso administrativo
como una ganancia de matrícula.

---

## 4. Cómo cerrar

La sesión termina con el motor construido, la batería de verificación adaptada
corriendo en verde con su control positivo, y el registro de lo que se decidió
en cada uno de los seis puntos de la sección 1, con su justificación. Si alguna
decisión quedó sin resolver, se declara como pendiente con su criterio de éxito,
no se resuelve por omisión.
