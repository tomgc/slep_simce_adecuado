# 31_leer_normalizar.R
# ----------------------------------------------------------------------------
# Lee los xlsx de la Agencia (_rbd) en 20_insumos/simce/{4b,2m}/,
# normaliza nombres de columnas, aplica filtros de exclusión (umbral
# MINEDUC) y exporta un único parquet largo en
# 40_salidas/intermedios/simce_rbd.parquet.
#
# Esquema del parquet de salida:
#   anio           integer
#   nivel          character    "4b" | "2m"
#   prueba         character    "lect" | "mate"
#   rbd            character
#   cod_com_rbd    character
#   nom_com_rbd    character
#   cod_grupo      character    "1".."5" (GSE)
#   nalu           integer      n° estudiantes evaluados
#   palu_eda_ade   double       % en estándar adecuado
#   marca          character    marca de supresión (NA si válido)
# ----------------------------------------------------------------------------

library(here)

# TODO Paso 3 de la sesión actual: implementar el flujo completo.
message("31_leer_normalizar.R: pendiente de implementación.")
