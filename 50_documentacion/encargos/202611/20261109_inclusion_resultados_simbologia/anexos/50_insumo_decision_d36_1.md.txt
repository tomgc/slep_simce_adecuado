# Decisión: inclusión de todos los resultados publicados y simbología adicional de la Agencia

**Fecha:** 2026-11-09 (sesión 36). **Decide:** el titular, sobre la propuesta del asistente.
**Código:** `10_utils/10_configuracion.R`, `10_utils/10_utils.R`, `30_procesamiento/31_leer_normalizar.R`,
`32_agregar_comunal.R`, `33_generar_html.R`, `33_motor_template.html`, `33_verificar_motor.R`,
`36_funciones_trayectorias.R` y `36_verificar_trayectorias.R` (encargo
`50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia`).

## D36-1. Se incluye todo resultado por estándar que publica la Agencia

**Contexto.** El titular comparó el CSV exportable de SLEP Costa Central con la página de la Agencia:
4° básico 2025 publica 55 establecimientos y 1.194 estudiantes en Lectura; el motor mostraba 54 y 1.184.
La diferencia es el RBD 1721, que la Agencia publica con simbología adicional (marca 2). La causa es
general: `agregar_ponderado()` excluía toda fila con `marca` no vacía (decisión A2, opción a, de
`referencia_glosas_simce.md`; invariante 5 de `33_generar_html.R`; D33-1 para la vista). En las 18 bases
hay 142.353 filas establecimiento × prueba con resultado por estándar (los tres porcentajes suman entre 99
y 101) y 2.008 de ellas traen marca; las 2.008 tienen además puntaje promedio publicado. Las 8.216 filas
con los tres porcentajes en 0 no son resultados (todas con menos de 10 evaluados) y siguen fuera.

**Decisión.**

1. Entra al cálculo toda fila cuyos tres porcentajes existen y suman entre `SUMA_NIVELES_MIN` y
   `SUMA_NIVELES_MAX` (99 y 101), con o sin marca. Las dos constantes pasan a `10_utils/10_configuracion.R`
   y las usan el motor y la vista. El umbral de 10 evaluados deja de ser filtro: es una aserción, y el
   build se detiene si una fila válida trae menos de 10 evaluados.
2. Una fila válida con marca es un **resultado con simbología adicional**. Su motivo sale de
   `MOTIVOS_SIMBOLOGIA` (`10_configuracion.R`): para el código 2, el texto que la Agencia muestra en su
   sitio, entregado por el titular; para los códigos 1, 3 y 4, el texto de la tabla «Marca: Observaciones
   al puntaje» de la glosa 2025; los valores literales de las bases antiguas («Alumnos insuficientes», «Ajenas a la Agencia: ...»,
   «Ajenas al Establecimiento: ...») se asocian a los códigos 1, 2 y 3 por su texto.
   Un código sin motivo detiene el build.
3. El motor señala con «‡» toda cifra que incorpora uno o más de esos resultados, y el tooltip indica el
   número de establecimientos. «*» sigue marcando el dato preliminar y «†» un solo establecimiento (D35-6).
4. En la fila de acciones de cada vista del motor, a la derecha de «Exportar PNG», va la casilla
   «Excluir resultados con simbología adicional ‡» (texto completo, con «de la Agencia», en `title` y
   `aria-label`). Desmarcada por defecto. Al marcarla, las cifras se recalculan sin esos resultados, el
   signo desaparece y se abre un modal con un año a la vez: botones de año con su número de casos
   (deshabilitados los años sin casos), una línea de resumen y la lista plegada con RBD, establecimiento,
   comuna, evaluados y motivo, para los territorios en pantalla y el nivel y la prueba activos.
5. Los dos CSV exportables suman `n_estab_simbologia` (establecimientos con simbología adicional del
   agregado, incluidos o excluidos) y `excluye_simbologia` (`si`/`no`, el estado de la casilla).
6. Nota metodológica del motor (la vista lleva solo la primera oración, porque no dibuja «‡» ni tiene casilla):

   > Se incluyen todos los resultados por estándar de aprendizaje que publica la Agencia de Calidad de la
   > Educación, incluyendo los que la Agencia acompaña de simbología adicional. Cuando una cifra incorpora
   > uno o más de esos resultados, se señala con «‡», indicando el número de establecimientos. Al marcar
   > «Excluir resultados con simbología adicional de la Agencia», se quitan del cálculo y se muestra cada
   > establecimiento con el motivo que informa la Agencia.

7. La vista de trayectorias aplica la regla de inclusión y la nota en esta fase; su casilla de exclusión
   queda para una segunda fase.

**Alternativas descartadas.** B (quitar solo el filtro de marca y mantener `nalu >= 10` como filtro): el
umbral no excluye ningún resultado válido, así que como filtro no cumple función. C (mantener la regla y
explicar la diferencia): el motor no replicaría las cifras de la Agencia. N1 y N2 (solo nota, o nota más
columna en el CSV): el titular eligió N3, signo en los gráficos, con la casilla para excluir.

**Deroga.** A2 opción a (`referencia_glosas_simce.md`), el invariante 5 de `33_generar_html.R` en lo
que toca a la marca y al umbral, y D33-1 en lo que toca a la regla de filas. `34_historico` ya incluía las
filas con marca (decisión de la sesión 26) y queda alineado.

**Directorio 2026 (D36-2).** El corte 2026-04-30 del directorio quedó en la carpeta de datos de
`slep_directorio_territorio`, pero este encargo usa el corte 2025-04-30: con el de 2026,
`ANIO_DATOS_VIGENTE <- 2025L` (`30_construir_auxiliares.R`) deja fuera de los catálogos a los Servicios
Locales traspasados en 2026, y su ajuste cambia las olas y el referente de la vista. La actualización a
2026 va en un encargo propio, con sus decisiones.

**Verificación.** Con el directorio 2025: Costa Central, 4° básico 2025, Lectura 55 establecimientos y
1.194 evaluados (54 y 1.184 con la casilla marcada); Matemática 53 y 1.187 (52 y 1.175). Total del país
igual al recuento independiente de la sonda S1 del encargo.
