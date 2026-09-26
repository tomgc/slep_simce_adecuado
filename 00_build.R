# 00_build.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Orquestador del pipeline slep_simce_adecuado.
#
# Ejecuta en orden los pasos de 30_procesamiento/ y produce los artefactos
# finales 40_salidas/motor_comparacion.html y
# 40_salidas/trayectorias_traspasos.html (paso 36, sesión 32).
#
# Uso:
#   source("00_build.R")
# ----------------------------------------------------------------------------

library(here)
source(here::here("10_utils", "10_configuracion.R"))  # guarda de locale UTF-8 (POLITICA 5.2bis)

# Carga utilidades transversales
source(here::here("10_utils", "10_utils.R"))

# Validación de portabilidad al inicio del build (pendiente 9 de v34). Una
# falla crítica detiene el build antes de leer insumos, con Rscript y también
# con source() interactivo (Q-39, decisión D35-13): el valor por omisión del
# validador (detener_si_falla = !interactive()) solo lo detenía con Rscript.
# La raíz de datos se resuelve con ruta_insumos() de 10_configuracion.R (raíz
# unificada en el propio repositorio).
source(here::here("10_utils", "10_validar_portabilidad.R"))
validar_portabilidad(detener_si_falla = TRUE)

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
source(here::here("30_procesamiento", "36_generar_trayectorias.R"))
message("")

elapsed <- round((proc.time() - t0)[["elapsed"]])
message(sprintf("=== 00_build.R: OK en %d segundos ===", elapsed))
