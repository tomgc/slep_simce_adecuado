# =============================================================================
# 10_configuracion.R — Punto de arranque común de slep_simce_adecuado
# -----------------------------------------------------------------------------
# Todo proceso de R del pipeline lo carga antes de su primera lectura o
# escritura: 00_build.R y cada script de 30_procesamiento/ que se corre suelto
# con Rscript. Instala la guarda de locale UTF-8 (POLITICA 5.2bis), declara
# el accesor ruta_insumos() (los insumos viven en el propio repositorio,
# ./20_insumos, así que no hay raíz de datos externa que resolver), las dos
# constantes de la serie Simce, ANIO_INICIO y ANIOS_SIN_SIMCE, y las de la regla
# de inclusión y la simbología adicional de D36-1.
# =============================================================================

# Guarda de locale UTF-8: va ANTES que todo. Un proceso en locale C (cron, CI,
# shells no interactivos) escribe texto acentuado escapado como <c3><a1> sin
# error visible (medido en este proyecto en la sesión 34: el JSON del motor
# salió con «Educaci<c3><b3>n»). El helper aborta si no puede corregirlo.
source(here::here("10_utils", "10_locale.R"))
asegurar_locale_utf8("10_configuracion")

# Accesor de insumos. La raíz de datos es el propio repositorio (POLITICA
# §6.2, raíz unificada): no hay <PROYECTO>_DATA_ROOT que declarar. El
# validador de portabilidad (10_validar_portabilidad.R) sondea este accesor y
# toma dirname() de su valor, es decir, la raíz del repositorio.
ruta_insumos <- function(...) here::here("20_insumos", ...)

# Serie Simce (D35-19). Los años de los datos no son un literal: salen de los
# nombres de archivo de 20_insumos/simce/{2m,4b}/. La serie empieza en
# ANIO_INICIO y no tiene aplicación en ANIOS_SIN_SIMCE (2019, estallido social;
# 2020 y 2021, pandemia; ver manifiesto_insumos.md). El paso 31 valida con ellas
# los años de los archivos y el paso 33 publica ANIOS_SIN_SIMCE en
# meta$anios_sin_simce. Viven aquí desde el encargo s35l (Q-75): antes estaban en
# el paso 31 y, como literal, en el paso 33.
ANIO_INICIO     <- 2014L
ANIOS_SIN_SIMCE <- c(2019L, 2020L, 2021L)

# Regla de inclusión de filas (D36-1, decisiones/20261109_decision_inclusion_
# resultados_simbologia.md). Una fila establecimiento x prueba entra al cálculo
# si Adecuado + Elemental + Insuficiente existen y suman entre SUMA_NIVELES_MIN y
# SUMA_NIVELES_MAX, con o sin marca de la Agencia; fuera de ese rango es una
# celda sin resultado (los tres en 0) o un redondeo anómalo. UMBRAL_EVALUADOS ya
# no filtra: es una aserción, y el build se detiene si una fila válida trae menos
# evaluados. Las usan el motor (pasos 31 a 33) y la vista (paso 36).
SUMA_NIVELES_MIN <- 99
SUMA_NIVELES_MAX <- 101
UMBRAL_EVALUADOS <- 10

# Simbología adicional (D36-1 punto 2): una fila válida con marca es un resultado
# con simbología adicional, y su motivo es el texto de su código. Código "2": el
# texto del sitio de la Agencia (D36-1a); "1", "3" y "4": la tabla «Marca:
# Observaciones al puntaje» de la glosa 2025. Las bases antiguas traen el motivo
# como texto literal; CODIGOS_LITERALES_SIMBOLOGIA lo lleva a su código. Un
# código sin motivo detiene el build (paso 31).
MOTIVOS_SIMBOLOGIA <- c(
  "1" = "No es posible reportar resultados, porque la cantidad de estudiantes evaluados es insuficiente. (6 o menos)",
  "2" = paste0("Por causas ajenas a la Agencia de Calidad de la Educación, los resultados ",
               "de aprendizaje o las respuestas entregadas en los Cuestionarios de Calidad ",
               "y Contexto de la Educación no son representativos."),
  "3" = "Por causas ajenas al establecimiento, los resultados no son representativos del desempeño de los estudiantes",
  "4" = "La aplicación de la prueba extendida no permite evaluar esta asignatura."
)
# Los textos llevan escapes \u en lugar de tildes literales: así el objeto queda
# marcado UTF-8 aunque el archivo se lea en otra locale (sesión 34).
CODIGOS_LITERALES_SIMBOLOGIA <- c(
  "Alumnos insuficientes" = "1",
  "Ajenas a la Agencia: Resultados no representativos" = "2",
  "Ajenas al Establecimiento: Resultados no representativos" = "3"
)
