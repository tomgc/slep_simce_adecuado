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

t0 <- proc.time()
message("=== 00_build.R: iniciando pipeline ===")
message("")

source(here::here("30_procesamiento", "30_construir_auxiliares.R"))
message("")
source(here::here("30_procesamiento", "31_leer_normalizar.R"))
message("")
source(here::here("30_procesamiento", "32_agregar_comunal.R"))
message("")
source(here::here("30_procesamiento", "33_generar_html.R"))
message("")

elapsed <- round((proc.time() - t0)[["elapsed"]])
message(sprintf("=== 00_build.R: OK en %d segundos ===", elapsed))
