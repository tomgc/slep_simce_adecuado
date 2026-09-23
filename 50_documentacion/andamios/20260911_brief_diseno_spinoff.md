# Encargo de diseño — motor de trayectoria de los SLEP tras el traspaso

> **Destino:** `50_documentacion/andamios/20260911_brief_diseno_spinoff.md`
> **Para:** sesión de diseño (Claude Design)
> **Origen:** sesión 30 de `slep_simce_adecuado`, 2026-09-11
> **Uso:** pegar el cuerpo de este documento como encargo, adjuntando los
> archivos de la sección 10.

---

## 1. Qué te estamos pidiendo

Diseñar la interfaz de un motor web de visualización de datos educativos
públicos. Ya existe un prototipo funcional con datos reales (se adjunta): la
mecánica está resuelta y no está en discusión. Lo que falta es el diseño: la
identidad visual, la jerarquía de la pantalla, la tipografía, el tratamiento del
color dentro de las restricciones que se listan abajo, el comportamiento
responsivo y la manera de presentar las advertencias metodológicas sin que se
lean como letra chica.

No necesitamos que escribas el pipeline de datos ni que rehagas la animación.
Necesitamos decisiones de diseño y una propuesta visual que podamos implementar.

## 2. Quién lo usa y para qué

El Área de Monitoreo y Seguimiento de Procesos y Resultados Educativos del SLEP
Costa Central (Chile) produce instrumentos de análisis para equipos directivos,
sostenedores y autoridades del sistema escolar público chileno. Este motor es un
instrumento de lectura pública: se publica en la web, se abre en reuniones y se
proyecta, y lo miran personas que no son analistas de datos.

Registro de la interfaz: institucional, sobrio, en español latinoamericano
neutro. Nada de lenguaje publicitario ni de celebración de resultados.

## 3. Qué muestra el instrumento

Chile transfirió la administración de sus escuelas municipales a Servicios
Locales de Educación Pública (SLEP) en olas sucesivas. El motor anima, año a año,
cómo se mueven los resultados de aprendizaje de cada ola.

- **Plano:** eje horizontal, porcentaje de estudiantes en nivel **Adecuado**,
  ascendente. Eje vertical, porcentaje en nivel **Insuficiente**, **invertido**:
  cero arriba, valores altos abajo. Avanzar es moverse a la derecha y hacia
  arriba, y la meta queda en la esquina superior derecha. Como ambos porcentajes
  pertenecen a la misma distribución de tres niveles, su suma no puede pasar de
  100: hay una frontera diagonal (de abajo-izquierda a arriba-derecha) y la nube
  vive siempre por encima de ella.
  **El eje invertido es un riesgo de lectura y es tu problema de diseño:** hay
  que rotularlo de modo que nadie lo lea al revés desde la última fila de la
  sala. Si encuentras una solución mejor, la alternativa considerada y
  descartada fue graficar el complemento (% fuera del nivel Insuficiente, es
  decir Adecuado más Elemental), que sube naturalmente pero obliga al público a
  hacer una resta mental antes de mirar.
- **Burbuja:** un Servicio Local. Su tamaño es el número de estudiantes evaluados.
- **Animación:** avanza por los nueve años con medición disponible, dejando
  estela del recorrido.
- **Filtros:** cohorte de traspaso, nivel evaluado (4° básico o II medio), prueba
  (Lectura o Matemática), grupo socioeconómico (todos, o uno en particular),
  velocidad de reproducción, tema claro u oscuro.
- **Panel de Servicios Locales visibles:** una tarjeta permanente que lista los
  Servicios Locales de la cohorte en pantalla, cada uno con una casilla para
  mostrarlo u ocultarlo y con el número de establecimientos que efectivamente
  entran en el cálculo, desglosado por grupo socioeconómico. Es tanto control
  como declaración de cobertura: quien mira tiene que poder ver sobre cuántas
  escuelas se está hablando.

## 4. Los hechos del dominio que condicionan el diseño

Todas estas cifras están medidas sobre los datos del repositorio, no estimadas.

| Hecho | Valor |
|---|---|
| Servicios Locales en el catálogo | 36, con 2.337 establecimientos |
| Olas de traspaso | 2018 (4 SLEP), 2020 (3), 2021 (4), 2024 (4), 2025 (11), 2026 (10) |
| Años con medición Simce | 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025 |
| Años sin medición | 2019, 2020 y 2021 (no existe el dato) |
| 2025 | resultados preliminares, no finales |
| SLEP con cuatro o más mediciones posteriores a su traspaso | 11 de 36 |
| Grupos socioeconómicos | cinco (bajo a alto); en el grupo alto no hay ningún SLEP con dato |
| Establecimientos del catálogo con al menos un resultado utilizable | 1.546 de 2.337 |
| Pares Servicio Local × grupo socioeconómico que existen alguna vez | 130 de 180 |
| Cobertura sobre esos pares reales (4° básico, Lectura) | 1.014 celdas de 1.170, es decir 86,7% |

Cinco consecuencias de diseño que no son negociables:

1. **El hueco 2019-2021 tiene que verse como hueco.** No se interpola, no se
   rellena y no se disimula. En el prototipo la línea de tiempo lo marca y las
   burbujas cruzan el tramo atenuadas, sin valores intermedios. La solución
   puede cambiar de forma, no de principio.
2. **La madurez desigual tiene que ser legible.** Una cohorte con una sola
   medición posterior a su traspaso no puede presentarse igual que una con cinco.
3. **2025 se marca como preliminar** dondequiera que aparezca.
4. **El instrumento no afirma causalidad.** Muestra trayectorias junto a un
   referente de establecimientos municipales todavía no traspasados; no mide el
   efecto del traspaso. El diseño no debe sugerir lo contrario (nada de flechas
   de "antes y después", nada de verde para "mejoró").
5. **La cobertura es parcial y desigual, y tiene que verse.** De las 39.914 filas
   Simce de establecimientos de SLEP sobreviven 27.064: se caen 10.127 que no
   traen los porcentajes por nivel (establecimientos con muy pocos evaluados,
   resultados no reportados o no representativos, o sin ningún dato) y 2.723
   celdas suprimidas por la Agencia. Además, de los 180 pares posibles de
   Servicio Local por grupo socioeconómico, solo 130 existen alguna vez: hay
   Servicios Locales que sencillamente no administran escuelas de ciertos
   grupos. Sobre esos 130 pares reales la cobertura es del 86,7%, y los huecos
   se concentran en el grupo medio alto, donde una o dos escuelas sostienen la
   celda entera. La visualización tiene que distinguir las tres situaciones
   (existe y hay dato, existe y falta el dato ese año, no existe el par) en vez
   de hacer desaparecer la burbuja en silencio, que es lo que hace hoy el
   prototipo y es un defecto.

## 5. Restricciones técnicas duras

- **Un solo archivo HTML autocontenido.** Sin CDN, sin dependencias de red, sin
  React, sin frameworks: el archivo tiene que abrirse sin conexión. El prototipo
  está escrito en SVG y JavaScript sin librerías, y así debe quedar (el proyecto
  tiene D3 vendorizado en el repositorio si hiciera falta).
- **Tema claro y oscuro**, ambos diseñados, no uno derivado del otro por
  inversión automática. El selector ya existe.
- **Pensado para proyección.** El uso principal es una pantalla grande frente a
  una audiencia que mira de lejos. Nada de texto de 9 u 11 píxeles como tiene el
  prototipo: define una escala tipográfica con piso alto (rótulos de ejes,
  valores y nombres incluidos) y verifícala mirando el resultado a tres metros,
  no a cuarenta centímetros. El año en curso y los nombres de los Servicios
  Locales son los dos elementos que hay que poder leer desde el fondo de la sala.
- **Responsivo** hasta 375px de ancho sin desbordes horizontales, pero la
  prioridad de diseño es la pantalla grande, no el teléfono.
- **Tipografías disponibles en el repositorio:** familia gobCL (Light, Regular,
  Heavy) y MuseoSans (300, 500, 700), ambas en formato `.otf`, que habría que
  incrustar como `data:` URI si se usan. Si propones otra, tiene que poder
  incrustarse igual.

## 6. Restricciones de identidad del proyecto

Vienen de la cartera de instrumentos del Área y valen también aquí:

- **El color nunca codifica el dato.** En los instrumentos de esta cartera, el
  color pertenece al nivel de logro (Adecuado, Elemental, Insuficiente) o a la
  identidad de la entidad, y jamás al valor de una medición. Se adjunta la
  decisión escrita.
- **Paletas categóricas cortas y validadas.** El prototipo pasó de codificar seis
  cohortes con seis colores a usar un solo tono: seis hues categóricos en un
  gráfico de dispersión no se distinguen con seguridad, menos aún con visión
  deficiente al color. Si propones más de tres colores categóricos simultáneos,
  declara cómo se distinguen.
- **Sin mayúsculas sostenidas** salvo siglas (GSE, SLEP, RBD, CSV, SVG, PNG, N).
- **Sin em dash;** los incisos van entre paréntesis.
- La escala tipográfica del SVG y la de la interfaz viven en variables, no en
  literales dispersos.

## 7. Las preguntas de diseño que queremos que respondas

1. **Jerarquía para proyección.** Hoy hay una barra de controles, una barra de
   reproducción, una línea de cohorte, una leyenda, una nota y recién después el
   gráfico. Es demasiada antesala, y en una sala el gráfico debería ocupar casi
   toda la pantalla. ¿Qué queda a la vista durante la presentación y qué se
   repliega?
2. **La tarjeta de Servicios Locales visibles.** Tiene que convivir con el
   gráfico sin robarle espacio ni obligar a desplazarse, y tiene que sostener
   entre tres y once filas con: casilla de selección, nombre, número de
   establecimientos que entran en el cálculo y su desglose por grupo
   socioeconómico. Es el componente más difícil del encargo. ¿Panel lateral,
   sobreimpreso plegable, banda inferior?
3. **El eje invertido.** Cómo se rotula `% Insuficiente` descendente para que
   nadie lo lea al revés desde lejos: dirección de los ticks, flecha de sentido,
   sombreado del cuadrante meta, o lo que propongas.
4. **El gráfico no llena su caja.** Los puntos se alinean a lo largo de una
   diagonal, así que dos esquinas opuestas quedan siempre vacías. ¿Se cambia la
   proporción del lienzo, se usa ese vacío para las anotaciones y la tarjeta, o
   se acepta?
5. **La estela produce marañas.** Con once Servicios Locales y nueve años de
   recorrido, las trayectorias se cruzan hasta volverse ilegibles. ¿Estela
   parcial, desvanecida, solo para lo seleccionado, o alguna otra salida?
6. **Etiquetado.** Los nombres chocan entre sí en las zonas densas. Hoy se
   resuelve con desplazamiento vertical y línea guía, que es funcional y feo, y
   además los nombres tienen que crecer para proyección.
7. **El tramo sin medición.** Queremos una solución visual mejor que la actual
   (desvanecido cruzado con deriva parcial) para comunicar tres años sin dato sin
   romper la continuidad de la lectura.
8. **Ausencia de dato.** Un Servicio Local sin dato en un año y grupo
   determinados hoy simplemente desaparece. ¿Cómo se muestra una ausencia
   legítima (burbuja fantasma en su última posición, fila atenuada en la tarjeta,
   contador de cobertura) sin que parezca una falla del instrumento?
9. **Las notas metodológicas.** Las advertencias son parte del instrumento, no
   letra chica, pero durante una presentación estorban. Van en una tarjeta
   plegable, cerrada por omisión: resuelve cómo se anuncia sin ser ignorada y
   cómo se abre sin tapar el gráfico.
10. **Identidad.** El Área tiene logotipos y una hoja de estilos de su suite
    documental. ¿Cómo se aplica aquí sin convertir el gráfico en un folleto?

## 8. Un dato que el prototipo todavía no trae

La tarjeta de Servicios Locales visibles pide el número de establecimientos que
entran en el cálculo, total y por grupo socioeconómico. El prototipo adjunto no
lo lleva: su bloque de datos solo trae porcentajes y número de estudiantes
evaluados. Es una ampliación del pipeline que haremos nosotros; para diseñar,
asume que el dato estará disponible por Servicio Local, año y grupo, y usa esta
muestra real como referencia de magnitudes:

> **Costa Central**, 4° básico Lectura. Catálogo: 73 establecimientos.
> Con resultado utilizable: 50 en 2014, 51 en 2018, 49 en 2024, 55 en 2025.
> Desglose de 2024 por grupo socioeconómico: 4 en el bajo, 23 en el medio bajo,
> 22 en el medio, ninguno en el medio alto ni en el alto.

Las cohortes van de tres a once Servicios Locales, así que la tarjeta tiene que
verse bien con tres filas y con once, y cada fila muestra hasta cinco cifras de
desglose, varias de ellas en cero.

## 9. Lo que no necesitamos

Pipeline de datos, código R, cálculo de agregaciones, arquitectura de archivos,
copy extenso de contenidos ni nombres alternativos para el proyecto. Tampoco
hace falta que resuelvas el cálculo del desglose por grupo socioeconómico: solo
dónde y cómo se muestra. Tampoco
necesitamos que respetes el prototipo: es un punto de partida desechable, y si el
diseño correcto lo contradice, mejor.

## 10. Archivos que se adjuntan

**Imprescindibles**

1. `mockup_trayectoria_traspasos.html` — el prototipo funcional con datos reales
   (unos 250 KB, la mayor parte es el bloque de datos incrustado). Es el objeto a
   rediseñar. Ábrelo: la animación arranca sola. Ojo: todavía tiene los ejes en
   la orientación antigua (Insuficiente en horizontal, Adecuado en vertical, meta
   arriba a la izquierda), no lleva la tarjeta de Servicios Locales visibles y su
   tipografía es demasiado chica. Esas tres cosas son justamente parte del
   encargo.
2. `20260909_plan_spinoff_trayectoria_traspasos.md` — el plan del proyecto, con
   las decisiones de diseño ya cerradas y lo que el instrumento no puede afirmar.
3. `50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md` — la
   doctrina de color de la cartera.

**Para la identidad visual**

4. `50_documentacion/suite/suite_estilos.css` — la hoja de estilos de la suite
   documental del Área, que es la referencia de identidad vigente.
5. `50_documentacion/suite/assets/logo-color-stacked.png`,
   `logo-white-stacked.png` y `logo-mark-cc.png` — los logotipos.
6. `50_documentacion/suite/fonts/` — las seis tipografías (`gobCL_Light.otf`,
   `gobCL_Regular.otf`, `gobCL_Heavy.otf`, `MuseoSans-300.otf`,
   `MuseoSans_500.otf`, `MuseoSans_700.otf`).

**Opcional, voluminoso**

7. `30_procesamiento/33_motor_template.html` — el motor del proyecto padre, unas
   4.600 líneas y 197 KB. Es la versión más pulida de la cartera y sirve como
   referencia del lenguaje visual ya establecido (encabezado, pestañas, fichas de
   territorio). Adjúntalo solo si la sesión va a proponer continuidad con ese
   lenguaje; si la idea es partir de cero, agrega ruido.

**No hace falta adjuntar** los datos crudos ni los archivos `.parquet`: el
prototipo ya trae dentro todo lo que el diseño necesita ver.
