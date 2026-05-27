# 00_build.R
# ----------------------------------------------------------------------------
# Orquestador del pipeline slep_simce_adecuado.
#
# Ejecuta en orden los pasos de 30_procesamiento/ y produce el artefacto
# final 40_salidas/motor_comparacion.html.
#
# Uso:
#   source("00_build.R")
# ----------------------------------------------------------------------------

library(here)

# Carga utilidades transversales
source(here::here("10_utils", "10_utils.R"))

# Pipeline (descomentar a medida que se implementa cada paso)
# source(here::here("30_procesamiento", "31_leer_normalizar.R"))
# source(here::here("30_procesamiento", "32_agregar_comunal.R"))
# source(here::here("30_procesamiento", "33_generar_html.R"))

message("00_build.R: orquestador listo. Pasos del pipeline aún sin implementar.")
