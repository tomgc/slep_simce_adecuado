# Traspaso de cierre v30 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`.
- **Versión del traspaso:** v30. **Fecha:** 2026-09-23. **Sesión:** 30.
- **Foco:** una tercera vista del proyecto. Un visualizador que anima año a año
  la trayectoria de los 36 Servicios Locales tras su traspaso, en el plano
  porcentaje en nivel Adecuado por porcentaje en nivel Insuficiente, segmentado
  por grupo socioeconómico y consolidado, con un referente de sostenedores
  municipales no traspasados para que un movimiento del sistema completo no se
  lea como efecto del traspaso.
- **Nota de identidad (importante para la próxima apertura).** Durante casi toda
  la sesión este trabajo se llamó «spin-off» y se planificó como repositorio
  aparte. El titular resolvió al cierre que es parte de este proyecto: una vista
  más, junto a la comparación y al panorama territorial. Todo lo que este
  traspaso, el backlog y los archivos de `andamios/` llaman «spin-off» se refiere
  a esa vista, no a un proyecto separado. Los nombres de archivo con esa palabra
  se conservan tal cual: son la grafía con la que nacieron y renombrarlos rompería
  las referencias del backlog.
- **Entorno:** Cowork con puente a la estación macOS. Sin identidad ni
  credenciales de Git en el puente: todo commit de esta sesión se delega.
- **Normativos usados:** `POLITICA_PROYECTO.md` y
  `SETTINGS_Y_PROMPTS_OPERACIONALES.md` desde la knowledge base del Project,
  este último con encabezado `**Versión 37.**`, posterior a la citada en v29.
  El paquete se ajustó a `**Versión 38.**` antes de ejecutarse (formato del
  campo `patron` de §2.2.15), porque el kit ya estaba en esa versión.
- **Archivos modificados o creados** (fuente: `git status --short` en esta
  sesión): `50_documentacion/activa/ESTADO.md` (corregido); y en
  `50_documentacion/andamios/`, `mockup_trayectoria_traspasos.html`,
  `verificar_trayectorias.R`, `20260917_instruccion_spinoff_trayectorias.md`,
  `20260911_brief_diseno_spinoff.md`,
  `20260909_plan_spinoff_trayectoria_traspasos.md`,
  `20260911_filas_anomalas_simce_rbd.xlsx` y
  `logs/20260911_sesion30_errores_asistente.md`, más los dos archivos sueltos de
  la sesión 29 que quedaban sin versionar.

## 2. Resumen ejecutivo

La sesión abrió con la corrección de `commit_cierre` que el traspaso v29 dejaba
instruida y siguió con un foco propio: construir una vista que muestre la
trayectoria de los Servicios Locales después del traspaso, sin afirmar
causalidad. Se cerraron cuatro decisiones de diseño (eje en años calendario,
referente municipal en el mismo plano, los 36 Servicios con marca de madurez, y
cero dependencias de red) y el trabajo se hizo íntegramente como archivo
autocontenido, después de que un intento de delegar el diseño a Claude Design
resultara inservible. El instrumento pasó por unas quince iteraciones dirigidas
por el titular y terminó con nube de contexto de 180 sostenedores municipales,
referente congelado, panel de serie completa, modo presentación y disciplina
tipográfica de tres tamaños. Se construyó además una batería de verificación en R
con control positivo (D1 a D8) y se corrió una auditoría de 28 pruebas en cuatro
familias, que destapó dos defectos reales del producto y dos defectos de las
propias pruebas; tras corregirlos, las 28 pasan. Cinco mediciones cambiaron el
trabajo: la cadena de pérdida de filas no era aditiva, la cobertura se calculaba
sobre un denominador inexistente, el margen de error binomial no aplica a un
censo, el movimiento interanual observado dobla al que predice ese modelo, y el
desglose por grupo socioeconómico no suma el total porque la Agencia clasifica el
grupo por nivel. Queda un pendiente estructural: la vista vive hoy en
`50_documentacion/andamios/`, que la política declara congelado, y tiene que
pasar a la arquitectura canónica del proyecto antes de volver a tocarse. La deuda
heredada de v29 (dependencia de `unpkg.com`, desborde bajo 540px, regla 12) quedó
intacta y sigue encabezando la ruta.

## 3. Estado al cierre

**Qué funciona.**

- El motor de comparación y el panorama territorial quedan exactamente como los
  dejó v29: esta sesión no editó `33_motor_template.html` ni `docs/index.html` ni
  ningún script del pipeline. La última ejecución exitosa sigue siendo la de v29.
- La vista de trayectorias
  (`50_documentacion/andamios/mockup_trayectoria_traspasos.html`, 1.681.142 bytes,
  822 líneas) abre y anima los nueve años (2014-2018 y 2022-2025) sin red: su
  única cadena `http` es el espacio de nombres SVG `http://www.w3.org/2000/svg`, y
  las tres caras de gobCL viajan como `data:font` (fuente: conteo por expresión
  regular sobre el archivo, en esta sesión).
- Su payload embebido tiene 12.916 registros de entidad, 21.504 de nube, 180
  comunas y 37 entradas de metadatos (los 36 Servicios Locales más la entrada
  `REF` del referente) (fuente: decodificación del objeto `DATA` del propio
  archivo, en esta sesión).
- `verificar_trayectorias.R` corre D1 a D8 sobre los parquet de
  `40_salidas/intermedios/`, escribe su CSV en `logs/` y sale con código 1 si algo
  falla. D8 es el control positivo: altera una cifra en 0,5 puntos y exige
  exactamente un hallazgo.

**Qué no funciona.**

- La vista de trayectorias está en la carpeta equivocada. `andamios/` aloja
  refactors ejecutados y congelados (política §1.2), no un producto vivo. Mientras
  siga ahí, toda iteración sobre ella infringe esa regla.
- No tiene arquitectura de construcción: el archivo se ensambló con un script
  auxiliar a partir de cuatro fuentes locales, y ese script no es entregable ni
  está versionado. Hoy el producto no se puede regenerar desde el repositorio.
- El payload no tiene grupo socioeconómico 5 en ninguna de sus dos tablas de
  entidad: el dominio observado es `1, 2, 3, 4, T`, mientras que la tabla
  nacional sí trae `5` (fuente: dominio de los campos del objeto `DATA`, medido
  en esta sesión). La causa no se estableció.
- Sigue vigente lo que v29 declaró: el motor no abre sin `unpkg.com`, el panorama
  desborda bajo ~540px, la regla 12 no está escrita, y `suitedoc` sigue sin
  publicar.

**Delta respecto a v29.** v29 cerró el panorama territorial y publicó cuatro
veces. v30 no publicó nada ni tocó el pipeline: agregó una tercera vista completa
y auditada, que todavía no está integrada a la arquitectura del proyecto.

## 4. Registro detallado de cambios

**4.1 Corrección de `ESTADO.md` (DOC).** `commit_cierre` apuntaba a `3b17b9b`
cuando el cierre real de v29 fue `f7279eb`, y `ultima_actividad` había quedado en
la fecha de apertura. Se corrigieron ambos y se marcó `sesion_abierta: true`.
Verificación: `git diff --cached` sobre el archivo. El commit se delegó: el
puente no tiene identidad de Git ni credenciales.

**4.2 Plan de la vista (DOC).** `20260909_plan_spinoff_trayectoria_traspasos.md`.
Cierra DS-1 a DS-4 y deja medida la base: 36 Servicios con 2.337
establecimientos, nueve años con medición, hueco 2019-2021, seis cohortes de
traspaso, 11 de 36 Servicios con cuatro o más años posteriores a su traspaso. Por
qué: sin esas cifras el instrumento habría prometido un alcance que el dato no
sostiene. Nota: el plan propone un repositorio aparte, propuesta que el titular
descartó al cierre (D-s30-5).

**4.3 Construcción del visualizador (UI).** Un solo archivo, SVG y JavaScript
escritos a mano, sin librerías y sin CDN, con las tres caras de gobCL incrustadas
como `data:` URI. Se construyó ensamblando cuatro fuentes locales (estilos y
fuentes, marcado, lógica, datos). Por qué en el chat y no delegado: el intento de
encargar el diseño a Claude Design produjo un resultado inservible, declarado así
por el titular. Tensión: el ensamblado se hizo con un script auxiliar que no es
entregable (regla de herramientas: R es el único lenguaje de los entregables), y
por eso no se entrega ni se versiona; reconstruirlo en R es parte del pendiente 2.

**4.4 Selector de cohorte con estelas (UI).** Al elegir una cohorte se dibuja
solo esa cohorte: las demás no quedan como contexto. Tres botones de velocidad.
Se eliminó la codificación por color de madurez que se había agregado sin
pedirla.

**4.5 Brief de diseño (DOC).** `20260911_brief_diseno_spinoff.md`. Corregido dos
veces dentro de la sesión, al descubrirse que dos de sus premisas eran falsas: la
cadena de pérdida de filas no era aditiva y el denominador de la cobertura no
existía.

**4.6 Diagnóstico de filas anómalas (D).**
`20260911_filas_anomalas_simce_rbd.xlsx`, tres hojas: resumen, 1.524 filas sin
`nalu` y 1.073 con `nalu` en cero, sobre columnas que el insumo declara
obligatorias. Afecta a cualquier agregación del proyecto, no solo a esta vista.
Verificación: los conteos se escribieron como valores documentados, con una nota
en celda que explica por qué no hay fórmulas (LibreOffice agotó el tiempo de
recálculo de forma repetida).

**4.7 Tarjeta lateral (UI).** Casilla por entidad, su número, el conteo de
establecimientos que sostienen cada cifra, y el desglose por grupo socioeconómico
plegado por omisión. Por qué: la cobertura se declara en pantalla, no en una nota
al pie.

**4.8 Panel de serie completa (UI).** Interruptor que restringe a los
establecimientos presentes en todos los años, para separar cambio de composición
de cambio de resultado. Se retiró el año preliminar de la vista por decisión del
titular.

**4.9 Nube de sostenedores municipales (UI).** 180 puntos semitransparentes, uno
por comuna, sin estela, con interruptor propio. Con la nube encendida los dos
ejes quedan fijos de 0 a 100 por ciento, porque el sistema de cuadrantes solo
tiene sentido sobre una escala completa.

**4.10 Referente municipal no traspasado (UI).** Círculo gris punteado, agregado
congelado de esa misma nube, con su marca fuera de la escala de área y eso
declarado. Se había eliminado por una lectura equivocada de una instrucción, y se
restituyó; la primera restitución (una cruz de ejes) fue rechazada.

**4.11 Retiro del margen de error y del descuento de tendencia (UI).** Dos
controles construidos y eliminados enteros, por D-s30-1 y D-s30-2. Verificación:
ninguna cadena de los dos conceptos queda en el archivo.

**4.12 Disciplina tipográfica y color (UI).** Tres tamaños (21, 15 y 13 píxeles)
más el año en 42, gobCL incrustada en sus tres caras, y la línea de tiempo en
azul institucional oscuro en lugar de naranjo.

**4.13 Burbujas legibles (UI).** Radio mínimo 12 píxeles para que el número quepa
adentro, tope en 46, y orden de dibujo que pone las chicas sobre las grandes.

**4.14 Modo presentación (UI).** Control de salida movido desde su posición
flotante a la barra del reproductor, como icono de 40×40. Medido en modo
presentación: borde derecho a ras del panel del gráfico (0 px de diferencia),
centrado vertical (0 px de desbalance), 17 px de margen interior, y
`display:none` fuera del modo.

**4.15 Batería de verificación (P).** `verificar_trayectorias.R`, D1 a D8, con
`|>`, `.by=` y `here::here()`, sobre los parquet de este proyecto. D8 es control
positivo. Por qué: ninguna cifra del instrumento se da por buena sin que la
batería corra en verde. Es el primer verificador del proyecto que nace junto con
lo que verifica y no después.

**4.16 Auditoría del visualizador (DOC).** 28 pruebas en cuatro familias: A capa
de datos, B invariantes del motor, C coherencia entre tabla y gráfico, D
presentación. Resultado tras las correcciones: 28 pasan, 0 fallan. Dos de las
pruebas resultaron defectuosas y se acotaron antes de tocar el producto: B3
contaba los rótulos de los ejes como números fuera de burbuja, y D3 contaba el
número escalado por geometría como un quinto tamaño tipográfico. La batería de
invariantes del motor se escribió en Playwright como medición y **no se
versionó**: ver duda 5.

**4.17 Corrección del hover y del período del tooltip (UI).** Dos defectos
reales que destapó la auditoría y el titular. Ver bugs s30-2 y s30-3.

**4.18 Hallazgo sobre la asignación del grupo socioeconómico (D).** La Agencia lo
asigna por nivel y no por establecimiento: 6.461 de 53.329 pares escuela-año
pertenecen a grupos distintos en 4° básico y en 2° medio. Por qué importa más
allá de esta vista: la vista de comparación del motor segmenta por grupo, y
cualquier desglose que combine niveles no cuadrará con su total. Verificación:
recuento programático sobre `40_salidas/intermedios/simce_rbd.parquet` en esta
sesión. Se optó por declarar el hecho en vez de forzar el cuadre.

**4.19 Instrucción de replicación (DOC).**
`20260917_instruccion_spinoff_trayectorias.md`: sección común (qué se copia tal
cual, las seis decisiones de dominio a rehacer, los invariantes, el orden de
trabajo) más variante A (asistencia) y variante B (matrícula). A diferencia de
esta vista, esas dos réplicas sí van en otros repositorios. Los nombres de los
repositorios de destino van declarados como hipótesis: no se pudieron verificar
desde esta sesión (duda 4).

**4.20 Decisión de identidad y de ubicación (REPO).** El titular resolvió al
cierre que la vista de trayectorias es parte de este proyecto y no un repositorio
aparte (D-s30-5), y en consecuencia queda pendiente sacarla de `andamios/` a la
arquitectura canónica (D-s30-6). Este traspaso y el backlog se reescribieron para
registrar el trabajo como propio del proyecto.

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 20
entradas.

## 6. Bugs de la sesión

Tres bugs de código, todos en la vista de trayectorias, todos resueltos.

**Bug s30-1 — la línea de tiempo salía deformada.**
Síntoma: texto y círculos estirados horizontalmente. Causa raíz:
`preserveAspectRatio="none"` sobre el SVG de la línea de tiempo, que escala los
dos ejes de forma independiente. Solución: recomputar el `viewBox` en píxeles
reales desde `getBoundingClientRect()`. Verificación: los círculos vuelven a ser
círculos a cualquier ancho de ventana. Patrón: un SVG que debe conservar formas
nunca lleva `preserveAspectRatio="none"`; si la caja cambia, se recalcula el
`viewBox`, no se estira el contenido. Estado: resuelto.

**Bug s30-2 — burbuja desmarcada que seguía respondiendo al cursor.**
Síntoma: se podía leer el tooltip de un Servicio Local que no estaba en pantalla.
Causa raíz: `display:none` oculta el grupo pero no anula el radio de los
círculos, y la búsqueda del cursor recorría todas las marcas. Solución: en el
mismo punto donde se oculta, anular radios y textos, y filtrar la búsqueda por
visibilidad. Verificación: prueba B5 de la auditoría. Patrón: ocultar no es lo
mismo que retirar; toda prueba de visibilidad se hace contra la geometría, no
contra el estilo. Estado: resuelto.

**Bug s30-3 — el tooltip fechaba mal las cifras heredadas.**
Síntoma: un Servicio Local sin dato en 2025 mostraba «50 estudiantes evaluados,
2025» con cifras de 2024. Causa raíz: la función que devuelve el último dato
disponible devolvía el dato pero no su año, y el tooltip usaba el año del
reproductor. Solución: devolver el par dato/año y declarar el período en el
texto. Verificación: reproducido en Huasco, que es donde el titular lo detectó.
Patrón: una cifra heredada de otro período nunca se rotula con el período actual;
el arrastre se declara en el mismo lugar donde se muestra. Estado: resuelto.

## 7. Aprendizajes y restricciones descubiertas

1. **Antes de reportar una descomposición, comprobar que las partes son
   disjuntas.** Contexto: se presentaron cuatro causas de pérdida de filas como
   si fueran sumables. Medición: las 368 filas sin `nalu` y las 652 sin grupo
   socioeconómico están íntegramente contenidas en las 10.127 sin porcentajes.
   Principio: C.11.

2. **Antes de reportar una cobertura, comprobar que el denominador existe.**
   Contexto: se informó 62,6 % sobre 1.620 celdas de Servicio × grupo. Medición:
   solo 130 de los 180 pares existen; la cobertura real es 86,7 % sobre 1.170.
   Una cifra exacta sobre un universo mal definido es peor que una aproximada y
   honesta, porque nadie la cuestiona.

3. **Antes de usar una herramienta estadística, comprobar que su supuesto
   generador describe el dato.** Contexto: se propuso un margen de error binomial
   sobre resultados Simce, que es censo de quienes rindieron y no muestra. La
   corrección no fue afinar el instrumento sino cambiarlo. Medición: el
   movimiento interanual observado es 2,0 veces el que predice el modelo (mediana
   2,93 puntos contra 1,49), y un grupo sin traspaso se movió 6,0 puntos en un
   año.

4. **El grupo socioeconómico es atributo del par establecimiento-nivel, no del
   establecimiento.** Medición: 6.461 de 53.329 pares escuela-año difieren entre
   4° básico y 2° medio. Aplica a cualquier segmentación por grupo del proyecto
   que combine niveles.

5. **Un panel balanceado no cierra la brecha entre grupos, y fijar el grupo
   tampoco.** Medición: la brecha pasa de 1.014 a 967 con panel balanceado y a
   957 fijando el grupo. La causa es la inestabilidad de la clasificación: solo
   341 de 1.296 establecimientos conservan un mismo grupo a lo largo de la serie.

6. **La revisión visual necesita su propia lista de comprobación.** Contexto:
   tres entregas seguidas con defectos de forma visibles que la revisión no
   detectó, porque se corría buscando errores de datos. Un paso de revisión que
   no dice qué mirar no mira nada.

7. **Una prueba de auditoría puede ser el defecto.** Dos de las 28 pruebas medían
   algo distinto de lo que afirmaban, y se acotaron antes de tocar el producto.
   Una prueba que falla obliga a preguntar primero si la prueba mide lo que dice.

8. **Un producto vivo no puede nacer en `andamios/`.** Contexto: la vista se
   construyó ahí porque empezó como exploración, y terminó siendo un entregable
   completo alojado en una carpeta que la política congela. La señal observable
   era temprana: en cuanto un archivo de `andamios/` recibe su segunda iteración
   dirigida, ya no es un andamio.

## 8. Decisiones de diseño

- **DS-1 — Eje temporal en años calendario, con el traspaso marcado sobre la
  burbuja.** Alternativa descartada: tiempo-evento (años desde el traspaso). Con
  medición en 2014-2018 y 2022-2025, la malla queda desigual por cohorte y el
  promedio entre cohortes mezclaría distancias distintas al evento.
- **DS-2 — Referente municipal no traspasado en el mismo plano.** Alternativa
  descartada: trazar solo los Servicios Locales, que haría leer como efecto del
  traspaso una subida que ocurre en todo el país. Descartado también el grupo de
  control emparejado: eso es un estudio, no una visualización.
- **DS-3 — Los 36 Servicios, con marca de madurez.** Las cohortes 2024, 2025 y
  2026 se dibujan declarando cuántos años de medición posterior tienen, incluido
  el cero. Es A29-4 aplicado a la portada.
- **DS-4 — Sin dependencias de red.** Tomada antes de escribir la primera línea,
  como consecuencia directa del pendiente 1 heredado. Implicancia: esta vista
  nace resuelta en lo que el motor sigue debiendo.
- **D-s30-1 — Sin margen de error.** Retirado tras establecerse que el
  instrumento no correspondía al dato. La incertidumbre se comunica mostrando
  cuánto se mueve un grupo que no fue traspasado, no con una banda.
- **D-s30-2 — Sin descuento de tendencia nacional.** Se había agregado sin
  aprobación y se retiró entero. La comparación con el referente la hace el
  lector mirando el plano, no el instrumento restando por dentro.
- **D-s30-3 — El desglose por grupo se declara, no se cuadra.** Alternativa
  descartada: forzar el total a la suma de los grupos, que ocultaría que la
  Agencia clasifica por nivel. Implicancia para el motor: si alguna vista futura
  combina niveles y segmenta por grupo, lleva la misma declaración.
- **D-s30-4 — Una unidad sin dato no desaparece.** Se queda en su última posición
  medida, con contorno punteado, y el tooltip declara de qué período vienen las
  cifras. Alternativa descartada: interpolar, que inventaría dato.
- **D-s30-5 — La vista de trayectorias es parte de este proyecto, no un
  repositorio aparte.** Decisión del titular al cierre, que revierte la propuesta
  del plan (§4.2) y una decisión contraria que este traspaso llegó a contener.
  Alternativa descartada: repositorio propio `slep_trayectoria_traspasos`, que
  habría duplicado la capa de datos, el escáner, el protocolo de cierre y la
  gobernanza para consumir exactamente los mismos insumos. Implicancia: el
  backlog de este proyecto registra las 20 entradas de la sesión, y la vista
  entra al ciclo de vida del repositorio como tercera salida.
- **D-s30-6 — La vista se traslada a la arquitectura canónica.** Consecuencia de
  la anterior: deja `50_documentacion/andamios/` (congelado por política §1.2) y
  pasa a `30_procesamiento/` con el patrón que ya usa el motor, plantilla más
  script generador, y salida publicable en `docs/`. Alternativa descartada:
  integrarla como pestaña de `33_motor_template.html`, que ya tiene 4.582 líneas y
  es la zona frágil del proyecto, y que además depende de red mientras esta vista
  no. Implicancia: el proyecto pasa a tener dos productos web, uno con
  dependencia de CDN y otro sin ella, y esa asimetría es un argumento más para
  resolver el pendiente 1.

Ninguna alcanza peso arquitectónico suficiente para replicarse como archivo en
`50_documentacion/activa/decisiones/`, salvo D-s30-6, que conviene replicar
cuando se ejecute y no antes.

## 9. Constantes y parámetros

Ninguna constante del motor cambió; las vigentes siguen en
`33_motor_template.html` (`FS_SVG` y las variables `--fs-*`). Las constantes
nuevas viven en la vista de trayectorias y en su batería, y se listan completas
porque este traspaso es su única fuente hasta que aterricen en código versionado
del pipeline:

| Constante | Valor anterior | Valor nuevo | Archivo | Motivo |
|---|---|---|---|---|
| Radio mínimo de burbuja | — | 12 px | `radio()` del visualizador | que el número quepa adentro |
| Radio máximo de burbuja | — | 46 px | idem | que no tape a sus vecinas |
| Factor de área | — | `sqrt(n) * 0,85` | idem | área proporcional a evaluados |
| Escala tipográfica | — | 21 / 15 / 13 px, más 42 px para el año | estilos del visualizador | tres tamaños y nada más |
| Piso del dominio de un eje | — | 30 puntos | `dominio()` del visualizador | evita zoom engañoso con series planas |
| Escala con nube encendida | — | 0 a 100 en ambos ejes | idem | el cuadrante exige escala completa |
| `TOL` | — | 0,15 puntos porcentuales | `verificar_trayectorias.R` | margen de redondeo, no de muestreo |
| Perturbación del control positivo | — | 0,5 puntos | idem, D8 | por encima de la tolerancia, por debajo de lo visible |

## 10. Arquitectura de archivos

Sin cambios estructurales todavía. Escáner regenerado por el ejecutor como último
acto que toca el árbol antes del commit de cierre. Todo lo nuevo de esta sesión
está bajo `50_documentacion/andamios/` salvo la corrección de
`50_documentacion/activa/ESTADO.md`, y queda versionado por instrucción
permanente del titular (D-s28-5).

**Cambio estructural pendiente (D-s30-6).** El siguiente número libre de
`30_procesamiento/` es el 35: los ocupados son `30_construir_auxiliares.R`,
`31_leer_normalizar.R`, `32_agregar_comunal.R`, `33_generar_html.R` con su
`33_motor_template.html`, y `34_historico_pct_adecuado_costa_central.R` (fuente:
`ls 30_procesamiento` en esta sesión). El traslado de la vista debe seguir ese
patrón (plantilla más script generador) y publicar su salida junto a
`docs/index.html`, no dentro de él.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Dependencia de `unpkg.com`** — tipo: bloqueante técnico. Heredado de v29 e
   intacto: el motor carga React, ReactDOM y Babel por red y no abre sin CDN.
   Impacto: alto. Dependencias: ninguna externa; el precedente C3 está auditado
   con archivo y línea en
   `logs/20260829_rescate_rotulos_y_precedente_c3_log.md`. Complejidad:
   media-alta. Principios: B.3 (cambio quirúrgico sobre una zona frágil).
   Precaución: sin `runtime: "classic"` la transpilación falla en silencio;
   versionar el JSX hermano desde el día uno. Criterio de éxito: `src="http"` en 0
   sobre el HTML publicado, con control positivo.

2. **Trasladar la vista de trayectorias a la arquitectura canónica (D-s30-6)** —
   tipo: deuda técnica con componente de funcionalidad. Contexto: hoy vive en
   `andamios/`, que la política §1.2 congela, y no se puede regenerar desde el
   repositorio porque el ensamblado se hizo con un script auxiliar no entregable.
   Impacto: alto sobre la mantenibilidad, nulo sobre lo que hoy funciona.
   Dependencias: ninguna. Complejidad: media. Principios: política §1.2 y §2
   (estructura y nomenclatura); regla de herramientas (el generador va en R).
   Precauciones: el payload pesa 1,6 MB embebidos, así que el generador debe
   producirlo desde los parquet y no copiarlo; y la propiedad de cero red es un
   invariante de esta vista, no un detalle. Criterio de éxito: `35_*` en
   `30_procesamiento/` regenera el HTML byte a byte equivalente al actual en
   contenido, el archivo sale de `andamios/` con `git mv`, y
   `verificar_trayectorias.R` corre en verde con su control positivo sobre la
   salida regenerada.

3. **Panorama desborda bajo ~540px** — tipo: mejora visual. Heredado de v29.
   Complejidad: baja. Criterio: el grid pasa a una columna sin recorte en 375px.

4. **Grupo socioeconómico 5 ausente del payload de la vista** — tipo: bug activo
   de datos, descubierto al cierre. Ver duda 1. Criterio: el dominio de `gse`
   coincide en las tres tablas del payload, o la ausencia queda explicada y
   declarada en el instrumento.

5. **Regla 12 sin redactar** — tipo: documentación. Heredado de v29: A29-4 no
   llegó a `50_diseno_ramas_deteccion.md`.

6. **Comparabilidad del estándar Simce entre 2018 y 2022** — tipo: verificación
   pendiente. Ver duda 2.

7. **Las 652 filas sin grupo socioeconómico en el consolidado** — tipo: decisión
   de metodología sin resolver. Ver duda 3.

8. **La batería de invariantes del motor no está versionada** — tipo: deuda
   técnica. Ver duda 5.

9. **`xmlns` duplicado, `renv` desincronizado, suite standalone desfasada, guarda
   `asegurar_locale_utf8()` ausente, `10_validar_portabilidad.R` sin invocador,
   actualización anual Simce 2025/2026** — heredados de v29, sin cambio.

**Deuda técnica.** `33_motor_template.html` sigue siendo la zona frágil: 4.582
líneas que mezclan CSS, JSX y D3 en un archivo. Esta sesión no la agravó porque
no lo tocó. Pero el proyecto acaba de adquirir un segundo archivo con el mismo
defecto de acumulación en miniatura, y esa es justamente la oportunidad que abre
el pendiente 2: separarlo al trasladarlo, antes de que crezca.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero sin
intervención manual: sí, y esta sesión no lo tocó. Nombres sin tildes ni
espacios: sí, tras eliminar dos residuos (una carpeta `Claude outputs/` con una
copia obsoleta del visualizador y un archivo de bloqueo de LibreOffice).
Estructura conforme: **no**, por el archivo vivo en `andamios/` → pendiente 2.
Guarda de locale instalada: **no** → pendiente 9.

**Compuerta de repositorio.** No se ejecutó desde esta sesión:
`95_verificar_cierre.R` vive en `herramientas_dev`, que no está conectado al
puente, y el puente carece además de identidad y credenciales de Git. La ejecuta
el instrumento de cierre en la estación, que es su lugar. Los dos residuos que
habrían roto I1 se eliminaron antes de emitir el paquete.

### Compuerta de dudas (5 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | El payload de la vista cubre los cinco grupos socioeconómicos, igual que la tabla nacional que lo acompaña | El dominio del campo de grupo en las tablas de entidad y de nube del objeto `DATA` incluye el valor `5` | Decodificar `DATA` del HTML y listar el dominio de ese campo en las tres tablas; hoy da `1,2,3,4,T` en las dos primeras y `1..5,T` en la nacional |
| 2 | Los estándares de aprendizaje de 2018 y de 2022 son comparables, de modo que el salto del hueco no mezcla dos reglas de corte | `referencia_glosas_simce.md` no declara ningún cambio de punto de corte entre 2018 y 2022 | `grep -n "estándar\|punto de corte" 50_documentacion/activa/referencia_glosas_simce.md` |
| 3 | Excluir del consolidado las 652 filas sin grupo socioeconómico no mueve la cifra consolidada | El porcentaje consolidado calculado con y sin esas filas difiere en menos de 0,15 puntos en las cuatro combinaciones de nivel y prueba | Correr el agregado consolidado dos veces sobre `40_salidas/intermedios/simce_rbd.parquet`, con y sin el filtro, y comparar |
| 4 | Los repositorios de destino de las dos réplicas existen con los nombres que la instrucción declara | Existe un directorio para cada uno de los nombres citados en `20260917_instruccion_spinoff_trayectorias.md` | `ls -d ~/Projects/slep_minuta_asistencia ~/Projects/slep_reportes_modelo_resguardo_asistencia ~/Projects/slep_costapresente ~/Projects/slep_analisis_matricula` en la estación |
| 5 | La batería de pruebas de motor escrita en Playwright durante la auditoría se puede rehacer cuando haga falta, así que no versionarla no cuesta nada | Existe en el repositorio un archivo que reproduce las 28 pruebas de las cuatro familias | `ls 50_documentacion/andamios/*motor*` y `git ls-files 50_documentacion/andamios` |

**Ruta sugerida.** Dos candidatos encabezan. El primero es la dependencia de
`unpkg.com`, que v29 fijó como prioridad 1 y esta sesión no tocó: es el único
pendiente que hoy puede dejar inutilizable lo que ya está publicado. El segundo es
el traslado de la vista de trayectorias fuera de `andamios/`, que además desbloquea
poder seguir trabajándola sin infringir la política.
Recomendación: el CDN primero, y el traslado inmediatamente después en la misma
sesión si queda espacio — el CDN depende de un tercero que puede caerse cualquier
día, mientras que el traslado depende solo de nosotros y no se degrada por
esperar. Diferir el resto.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 `cod_com_rbd` es la clave para agregar por comuna; nunca `nom_com_rbd`.
- 🔒 La segmentación por grupo socioeconómico de la vista de comparación es
  inviolable; el panorama combina porque es otra vista.
- 🔒 Color por nivel (`D-color-nivel`); `entity.color` nunca codifica el dato.
- 🔒 `docs/index.html` se actualiza por copia íntegra, jamás por edición.
- 🔒 El D3 minificado vendorizado no se toca.
- 🔒 La escala del SVG vive en `FS_SVG`; la de la interfaz en `--fs-*`. Sin
  literales.
- 🔒 Sin mayúsculas sostenidas en el texto salvo siglas.
- 🔒 El backlog conserva sus cinco secciones de POLITICA §10 y su detalle en `###`.
- 🔒 El grupo socioeconómico es atributo del par establecimiento-nivel: toda vista
  que combine niveles y segmente por grupo declara que el desglose no suma el
  total.
- 🔒 La vista de trayectorias no depende de la red: cero CDN, fuentes como
  `data:font`, D3 y React fuera. Ese invariante sobrevive al traslado.
- 🔒 Los períodos sin medición se dibujan como hueco. No se interpola.
- ✅ ANTES de entregar un archivo editado, cotejar su base contra `HEAD`.
- ✅ ANTES de desplegar, gate visual del titular.
- ✅ ANTES de dar por buena cualquier cifra de la vista de trayectorias, correr
  `verificar_trayectorias.R` y comprobar que D8 detecta su perturbación.
- ⚠️ NO iterar sobre `mockup_trayectoria_traspasos.html` en su ubicación actual:
  `andamios/` está congelado (política §1.2). El pendiente 2 va primero.
- ⚠️ NO integrar la vista como pestaña de `33_motor_template.html`: son dos
  productos con dependencias incompatibles (D-s30-6).
- ⚠️ NO importar un instrumento estadístico sin comprobar que su supuesto
  generador describe el dato.
- ⚠️ NO reportar una descomposición sin comprobar que las partes son disjuntas,
  ni una cobertura sin comprobar que el denominador existe.
- ⚠️ NO commitear desde el puente de Cowork: esa máquina no tiene identidad de
  Git ni credenciales.
- ⚠️ NO expresar criterios de verificación como cantidad de líneas de `diff`, de
  `status` ni de commits.

## 13. Fragmentos de código de referencia

Tres patrones nuevos, todos en `mockup_trayectoria_traspasos.html`, que viajan con
la vista cuando se traslade:

```js
// Área proporcional a los estudiantes evaluados, con piso para que el número
// quepa dentro de la burbuja y techo para que no tape a sus vecinas.
function radio(n){ return Math.max(12, Math.min(46, Math.sqrt(n) * 0.85)); }
```

```js
// Ocultar de verdad: display:none esconde, pero deja el radio vivo y la
// busqueda del cursor lo sigue encontrando (bug s30-2).
if(!visible(id)){
  m.g.setAttribute('display','none');
  m.a.setAttribute('r',0); m.b.setAttribute('r',0);
  m.na.textContent=''; m.nb.textContent='';
  return;
}
```

```js
// Los dos ejes al maximo redondeado a la decena, con piso de 30 y techo de 100;
// con la nube encendida, escala completa fija (el cuadrante exige 0 a 100).
function dominio(){
  if(S.nube) return {x:[0,100], y:[0,100]};
  var b = IDX[clave()] || {}, ma = 0, mi = 0;
  Object.keys(b).forEach(function(y){ b[y].forEach(function(d){
    if(d.ade > ma) ma = d.ade; if(d.ins > mi) mi = d.ins; }); });
  return {x:[0, Math.min(100, Math.max(30, Math.ceil(ma/10)*10))],
          y:[0, Math.min(100, Math.max(30, Math.ceil(mi/10)*10))]};
}
```

Los patrones estables del proyecto siguen en `33_motor_template.html`.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y
`SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se
lee desde ahí; no se adjunta.

**Se adjuntan:** `traspaso_cierre_v30.md`;
`50_documentacion/andamios/logs/20260829_rescate_rotulos_y_precedente_c3_log.md`,
que trae el precedente C3 auditado con archivo y línea, insumo directo del foco
propuesto; y `50_documentacion/andamios/mockup_trayectoria_traspasos.html`
(voluminoso, 1,6 MB, y crítico si la sesión alcanza el pendiente 2). El backlog y
el escáner no se adjuntan.

**Estado:** `main` al cierre `f7279eb`, previo al commit de cierre. Sesión 30
cerrada con una tercera vista construida y auditada, alojada todavía en
`andamios/` a la espera de su traslado.

**Foco propuesto:** la dependencia de `unpkg.com`, con el precedente C3 ya
auditado; y, si queda espacio, el traslado de la vista de trayectorias a
`30_procesamiento/`.

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más
actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

Trece errores registrados en el momento en que ocurrieron, en
`50_documentacion/andamios/logs/20260911_sesion30_errores_asistente.md`. Se
vuelcan aquí con los diez campos de §2.2.15 en layout de bloque.

**ERR-30-01**
- `momento`: primer acto de la sesión, al commitear la corrección de `ESTADO.md`.
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: intenté `git commit` y `git push` desde el puente sin comprobar antes que esa máquina tuviera identidad de Git ni credenciales.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno».
- `causa_raiz`: traté el puente como una terminal de la estación porque el árbol de archivos es el mismo, sin distinguir que el sistema de archivos compartido no implica credenciales compartidas.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-03, sobre capacidades de Git del entorno remoto.
- `gatillo_observable`: comando-entorno: se iba a ejecutar un comando que necesita credenciales en una máquina cuya configuración de Git no se había leído.
- `intentos_previos`: 0.
- `costo`: dos comandos fallidos; la corrección quedó en el índice y todo commit de la sesión tuvo que delegarse.

**ERR-30-02**
- `momento`: primera versión de la línea de tiempo del mockup.
- `disparador`: usuario lo corrigió («¿por qué se ve todo alargado?»).
- `que_paso`: dibujé la línea de tiempo con `preserveAspectRatio="none"`.
- `regla_violada`: ninguna regla escrita; defecto de construcción, y SETTINGS §1.2.6, revisión antes de entregar.
- `causa_raiz`: usé el atributo para que el SVG llenara su contenedor, sin considerar que eso escala los dos ejes por separado; no miré el resultado antes de entregarlo.
- `salvaguarda_presente`: ninguna específica.
- `patron`: PAT-NUEVO-revision-visual-sin-lista, propuesta de entrada de catálogo: entregar un artefacto visual sin correr una lista de comprobación de forma, distinta de la de datos.
- `gatillo_observable`: otro: se entregó un artefacto visual sin mirarlo renderizado.
- `intentos_previos`: 0.
- `costo`: una iteración completa rehecha.

**ERR-30-03**
- `momento`: segunda tanda de ajustes del mockup.
- `disparador`: usuario lo corrigió («añade demasiado ruido tanto color»).
- `que_paso`: codifiqué con tres colores una segmentación por madurez que nadie pidió.
- `regla_violada`: SETTINGS §1.2.6, «nunca aplicar cambios no solicitados ni aprobados» (B.3), y B.2 simplicidad.
- `causa_raiz`: confundí una mejora que me pareció evidente con una instrucción; las mejoras detectadas se mencionan, no se implementan.
- `salvaguarda_presente`: SETTINGS y POLITICA.
- `patron`: PAT-04, sobre iniciativa no pedida en el diseño.
- `gatillo_observable`: restriccion-no-propagada: se agregó una dimensión visual que no estaba en el encargo.
- `intentos_previos`: 0.
- `costo`: un ciclo completo de deshacer.

**ERR-30-04**
- `momento`: implementación del selector de cohorte.
- `disparador`: usuario lo corrigió, repitiendo la instrucción («repito, no quiero otras cohortes graficadas al mismo tiempo que las cohortes»).
- `que_paso`: tras pedirme trayectorias por cohorte, dejé las demás cohortes dibujadas como contexto.
- `regla_violada`: B.4, ejecución dirigida por objetivos; SETTINGS §1.2.6, un cambio conceptual por intervención.
- `causa_raiz`: interpreté la instrucción en lugar de obedecerla, asumiendo que el contexto siempre suma.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-07, sobre restricción explícita no propagada al dibujo.
- `gatillo_observable`: restriccion-no-propagada: la instrucción decía «solo la cohorte seleccionada» y el resultado mostraba todas.
- `intentos_previos`: 0.
- `costo`: el titular tuvo que repetir la misma instrucción.

**ERR-30-05**
- `momento`: redacción del brief de diseño.
- `disparador`: usuario lo señaló sin nombrarlo error (preguntó cómo podía faltar una columna obligatoria).
- `que_paso`: presenté la cadena de pérdida de filas como cuatro causas sumables (10.127 sin porcentajes, 2.723 suprimidas, 652 sin grupo, 368 sin `nalu`) sin comprobar el solapamiento.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente S-01, tipo 3: toda cifra comunicada exige recuento programático del mismo turno.
- `causa_raiz`: conté bien cada conjunto por separado y presenté los cuatro conteos como si fueran una partición, sin que ningún paso me obligara a comprobar la disyunción.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre descomposición no verificada.
- `gatillo_observable`: cifras-datos: se emitió una suma de subconjuntos sin medir su intersección.
- `intentos_previos`: 0.
- `costo`: brief corregido y reemitido; sobreestimación de las causas.

**ERR-30-06**
- `momento`: cálculo de la cobertura del instrumento.
- `disparador`: asistente lo señaló espontáneamente al medir.
- `que_paso`: llamé «faltantes» a 606 celdas de Servicio Local por grupo socioeconómico que no existen.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente S-01, tipo 3.
- `causa_raiz`: construí el denominador como producto cartesiano de dos dimensiones sin comprobar cuáles de sus pares están poblados.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre denominador supuesto.
- `gatillo_observable`: cifras-datos: se publicó un porcentaje cuyo denominador no se contó, se dedujo.
- `intentos_previos`: 0.
- `costo`: cifra de cobertura errada (62,6 % contra 86,7 % real) que llegó al brief y hubo que corregir.

**ERR-30-07**
- `momento`: tanda de sugerencias aprobadas para el mockup.
- `disparador`: usuario lo corrigió («El margen de error no lo entiendo, ¿no estamos tratando con datos exactos?»).
- `que_paso`: propuse e implementé un margen de error binomial sobre resultados Simce.
- `regla_violada`: SETTINGS §1.2.6, «fuente primaria de una estructura es su inspección»; A29-4 del proyecto, el alcance del instrumento iguala el de la afirmación.
- `causa_raiz`: importé un instrumento estándar por familiaridad, sin comprobar que su supuesto generador (muestreo aleatorio de una población) describiera un censo de quienes rindieron.
- `salvaguarda_presente`: SETTINGS y el propio traspaso del proyecto.
- `patron`: PAT-13, sobre instrumento que mide un proxy y no el riesgo.
- `gatillo_observable`: cifras-datos: se aplicó un modelo de muestreo a datos censales.
- `intentos_previos`: 0.
- `costo`: una funcionalidad construida y retirada entera.

**ERR-30-08**
- `momento`: el mismo turno del error anterior.
- `disparador`: asistente lo señaló espontáneamente al medir la serie real.
- `que_paso`: la banda que reporté con ese instrumento además subestimaba la inestabilidad.
- `regla_violada`: marcador de fuente S-01, tipo 3: cifra no contrastada contra el dato.
- `causa_raiz`: deduje la variabilidad de un modelo en vez de medirla en la serie que tenía delante.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre cifra deducida y no medida.
- `gatillo_observable`: cifras-datos: se publicó una dispersión que nunca se calculó sobre los datos.
- `intentos_previos`: 1 (el propio margen de error del error anterior).
- `costo`: ninguno adicional: se retiró junto con el instrumento.

**ERR-30-09**
- `momento`: implementación de la tanda aprobada.
- `disparador`: usuario lo corrigió («¿Qué es descontar la tendencia nacional? ¿Cuándo aprobamos eso?»).
- `que_paso`: agregué el interruptor «Descontar la tendencia nacional» sin que estuviera entre las sugerencias aprobadas.
- `regla_violada`: SETTINGS §1.2.6, «nunca aplicar cambios no solicitados ni aprobados» (B.3).
- `causa_raiz`: una aprobación global («apruebo todas tus sugerencias») se leyó como licencia para agregar una sugerencia posterior que nunca se presentó.
- `salvaguarda_presente`: SETTINGS y POLITICA.
- `patron`: PAT-04, sobre ampliar el alcance de una autorización.
- `gatillo_observable`: restriccion-no-propagada: se implementó un control que no figura en la lista aprobada.
- `intentos_previos`: 0.
- `costo`: un control construido y retirado entero, más una pregunta del titular.

**ERR-30-10**
- `momento`: tres entregas consecutivas del mockup, hacia la mitad de la sesión.
- `disparador`: usuario lo corrigió («te pido más pulcritud para trabajar»).
- `que_paso`: entregué tres versiones seguidas con defectos visibles que no detecté (rótulos duplicados en el tramo sin medición, aviso superpuesto a la leyenda, flecha «Mejor» sin apuntar a la esquina, rótulo del eje Y lejos de su eje).
- `regla_violada`: SETTINGS §1.2.6, «generar, verificar, consumar: en ese orden».
- `causa_raiz`: el paso de verificación existía pero se corría buscando errores de datos; ningún paso obligaba a mirar la forma.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-02, sobre consumar sin verificación de la superficie entregada.
- `gatillo_observable`: otro: se entregó un artefacto visual sin lista de comprobación de forma.
- `intentos_previos`: 2 (las dos entregas anteriores con el mismo modo de fallo).
- `costo`: tres ciclos de revisión del titular que debieron ser míos.

**ERR-30-11**
- `momento`: revisión del tooltip, tras una pregunta sobre Huasco.
- `disparador`: usuario lo corrigió («¿qué significa esto de Huasco? ¿Por qué no tiene datos para ese año?»).
- `que_paso`: el tooltip atribuía al año en curso cifras que venían de la última medición disponible.
- `regla_violada`: A29-4 del proyecto: el alcance de la afirmación iguala el del dato.
- `causa_raiz`: la función de arrastre devolvía el dato sin su año, y el rótulo tomó el año del reproductor porque era el que tenía a mano.
- `salvaguarda_presente`: el propio traspaso del proyecto.
- `patron`: PAT-01, sobre rotular una cifra con un período que no es el suyo.
- `gatillo_observable`: cifras-datos: se mostró una cifra con un período distinto del de su origen.
- `intentos_previos`: 0.
- `costo`: una corrección de código y la duda del titular sobre la validez del instrumento.

**ERR-30-12**
- `momento`: auditoría del visualizador, familia B.
- `disparador`: asistente lo señaló espontáneamente (lo encontró su propia prueba B5).
- `que_paso`: una burbuja desmarcada en la tarjeta seguía respondiendo al cursor.
- `regla_violada`: B.4, criterio de éxito verificable: «ocultar» se implementó como estilo y se dio por cumplido sin probar la geometría.
- `causa_raiz`: `display:none` es la forma habitual de ocultar y se asumió suficiente, sin considerar que la búsqueda del cursor recorre marcas, no estilos.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-13, sobre criterio que mide un proxy (el estilo) y no el riesgo (la interacción).
- `gatillo_observable`: otro: se declaró oculto un elemento sin comprobar que dejara de ser alcanzable.
- `intentos_previos`: 0.
- `costo`: ninguno hacia fuera: la auditoría lo atrapó antes de cualquier entrega final.

**ERR-30-13**
- `momento`: auditoría del visualizador, familia A.
- `disparador`: asistente lo señaló espontáneamente (lo encontró su propia prueba A5).
- `que_paso`: el desglose por grupo socioeconómico no suma el total en la vista que combina niveles, y el motor no lo declaraba.
- `regla_violada`: A29-4 del proyecto: el alcance del instrumento iguala el de la afirmación.
- `causa_raiz`: se asumió que el grupo socioeconómico es un atributo del establecimiento, cuando la Agencia lo asigna por nivel; la estructura del dato no se inspeccionó antes de construir el desglose.
- `salvaguarda_presente`: SETTINGS §1.2.6, fuente primaria de una estructura es su inspección.
- `patron`: PAT-01, sobre atributo supuesto y no inspeccionado.
- `gatillo_observable`: cifras-datos: la suma de las partes no se comparó con el total antes de mostrar ambas.
- `intentos_previos`: 0.
- `costo`: ninguno hacia fuera; se declaró en el instrumento con una nota al pie.

**Propuesta de entrada de catálogo.** `PAT-NUEVO-revision-visual-sin-lista`:
entregar un artefacto visual sin correr sobre él una lista de comprobación de
forma, distinta de la de datos. Evidencia en esta sesión: ERR-30-02 y ERR-30-10,
cuatro defectos de forma en cuatro entregas, todos detectados por el titular y
ninguno por la revisión. Clasificación según §2.2.16: **omisión** (falta un
elemento de algo que el asistente ya produce), así que la forma correcta del
arreglo es un paso obligatorio en la plantilla de entrega de artefactos
visuales, no una prohibición ni un recordatorio en prosa.

### Fricciones

- `friccion: demasiados tamaños de letra en dos entregas seguidas → escala fijada en tres tamaños más el año, y verificada por conteo sobre el archivo.`
- `friccion: el naranjo de la línea de tiempo se leyó como poco sobrio → azul institucional oscuro.`
- `friccion: el control para salir del modo presentación quedaba flotando y desalineado → movido a la barra del reproductor como icono, con sus márgenes medidos.`
- `friccion: la tabla lateral era demasiado ancha y los controles obligaban a desplazarse → ancho reducido y controles en una sola fila.`
