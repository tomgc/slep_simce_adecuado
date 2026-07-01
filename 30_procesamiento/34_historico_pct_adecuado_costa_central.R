# 34_historico_pct_adecuado_costa_central.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Sidequest (sesión 26): histórico de % de estudiantes en nivel Adecuado,
# TODOS los GSE combinados (sin desagregar por cod_grupo), para el universo
# Costa Central (4 comunas · cod_depe2="5"). Salida separada por prueba
# (4b / 2m); NO se combinan pruebas ni GSE en una misma cifra (segmentación
# GSE inviolable respetada: aquí no se compara entre GSE, se agrega sobre
# todos ellos).
#
# Metodología (decisión del usuario, sesión 26):
#   - Ponderado por nalu: pct_adecuado = sum(nalu * palu_eda_ade / 100) / sum(nalu)
#     (estudiantes reales en adecuado, no promedio simple de porcentajes).
#   - Filas con 'marca' no vacío (no representativas): SE INCLUYEN.
#   - Universo: cod_com_rbd ∈ {5109, 5103, 5107, 5105} (Viña del Mar, Concón,
#     Quintero, Puchuncaví) Y cod_depe2 == "5" (Servicio Local de Educación).
#   - Prueba lect + mate: se agregan por separado, no se suman entre sí
#     (evita mezclar dimensiones distintas del SIMCE en una sola cifra).
#
# Insumo: 40_salidas/intermedios/simce_rbd.parquet (14 columnas, ver
# 31_leer_normalizar.R).
# Salida: 40_salidas/historico_pct_adecuado_costa_central.xlsx
#   4 hojas: "4b-lect", "4b-mate", "2m-lect", "2m-mate"
#   Columnas: anio | n_rbds | n_estudiantes_evaluados |
#             n_estudiantes_adecuado | pct_adecuado
#
# Nota sobre dependencia (proyección retroactiva): cod_depe2 proviene de
# un único snapshot 2025 (mapa_rbd_depe2, 31_leer_normalizar.R L71-74),
# aplicado a TODOS los años del histórico. Esto ya proyecta hacia atrás
# el traspaso a SLEP: un RBD que en 2025 es "Servicio Local" (depe2="5")
# aparece con depe2="5" también en 2014-2018, aunque en esos años haya
# sido administrado municipalmente. No requiere ajuste adicional.
#
# Uso:
#   source(here::here("30_procesamiento", "34_historico_pct_adecuado_costa_central.R"))
# ----------------------------------------------------------------------------

library(here)

# ---- Constantes (decisiones metodológicas nombradas, C.10) ----
COMUNAS_COSTA_CENTRAL_COD <- c("5109", "5103", "5107", "5105")
DEPE2_SLEP                <- "5"

ruta_parquet <- here::here("40_salidas", "intermedios", "simce_rbd.parquet")
ruta_salida  <- here::here("40_salidas", "historico_pct_adecuado_costa_central.xlsx")

stopifnot(
  "Falta simce_rbd.parquet: correr 31_leer_normalizar.R primero." =
    fs::file_exists(ruta_parquet)
)

message("[1] Leyendo simce_rbd.parquet...")
df_simce <- arrow::read_parquet(ruta_parquet)

message("[2] Filtrando universo Costa Central (comuna + cod_depe2=\"5\")...")
df_cc <- df_simce[
  df_simce$cod_com_rbd %in% COMUNAS_COSTA_CENTRAL_COD &
    df_simce$cod_depe2 == DEPE2_SLEP,
]

stopifnot(
  "Filtro Costa Central produjo 0 filas: revisar códigos de comuna/depe2." =
    nrow(df_cc) > 0
)

message(sprintf("    OK: %d filas tras filtro (de %d totales).",
                nrow(df_cc), nrow(df_simce)))

# ---- Validación de integridad: NAs en columnas críticas del cálculo ----
n_na_nalu <- sum(is.na(df_cc$nalu))
n_na_ade  <- sum(is.na(df_cc$palu_eda_ade))
if (n_na_nalu > 0 || n_na_ade > 0) {
  warning(sprintf(
    "NAs en columnas críticas dentro del universo filtrado: nalu=%d, palu_eda_ade=%d. Esas filas se excluyen del ponderado (no aportan denominador/numerador válido).",
    n_na_nalu, n_na_ade
  ))
}

message("[3] Calculando agregado ponderado por (anio, nivel, prueba)...")

resumen <- df_cc |>
  dplyr::filter(!is.na(nalu), !is.na(palu_eda_ade)) |>
  dplyr::mutate(
    n_alu_adecuado = nalu * palu_eda_ade / 100
  ) |>
  dplyr::summarise(
    n_rbds                   = dplyr::n_distinct(rbd),
    n_estudiantes_evaluados  = sum(nalu),
    n_estudiantes_adecuado   = sum(n_alu_adecuado),
    .by = c(anio, nivel, prueba)
  ) |>
  dplyr::mutate(
    pct_adecuado = 100 * n_estudiantes_adecuado / n_estudiantes_evaluados
  ) |>
  dplyr::arrange(nivel, prueba, anio)

# ---- Validación: pct_adecuado en rango [0, 100] ----
fuera_rango <- resumen[resumen$pct_adecuado < 0 | resumen$pct_adecuado > 100, ]
if (nrow(fuera_rango) > 0) {
  warning("pct_adecuado fuera de [0,100] en algunas filas. Revisar:")
  print(fuera_rango)
}

message("[4] Escribiendo xlsx (4 hojas: 4b-lect, 4b-mate, 2m-lect, 2m-mate)...")

extraer_hoja <- function(df, nv, pb) {
  df[df$nivel == nv & df$prueba == pb, ] |>
    dplyr::select(-nivel, -prueba) |>
    dplyr::mutate(n_estudiantes_adecuado = round(n_estudiantes_adecuado, 1),
                  pct_adecuado = round(pct_adecuado / 100, 2))
}

hoja_4b_lect <- extraer_hoja(resumen, "4b", "lect")
hoja_4b_mate <- extraer_hoja(resumen, "4b", "mate")
hoja_2m_lect <- extraer_hoja(resumen, "2m", "lect")
hoja_2m_mate <- extraer_hoja(resumen, "2m", "mate")

openxlsx::write.xlsx(
  list(
    "4b-lect" = hoja_4b_lect,
    "4b-mate" = hoja_4b_mate,
    "2m-lect" = hoja_2m_lect,
    "2m-mate" = hoja_2m_mate
  ),
  file = ruta_salida,
  overwrite = TRUE
)

# ---- Formato de porcentaje (0%) sobre pct_adecuado en cada hoja ----
wb <- openxlsx::loadWorkbook(ruta_salida)
estilo_pct <- openxlsx::createStyle(numFmt = "0%")
hojas <- c("4b-lect", "4b-mate", "2m-lect", "2m-mate")
for (h in hojas) {
  n_filas <- nrow(resumen[resumen$nivel == substr(h, 1, 2) &
                             resumen$prueba == sub("^[0-9a-z]+-", "", h), ])
  openxlsx::addStyle(
    wb, sheet = h, style = estilo_pct,
    rows = 2:(n_filas + 1), cols = 5, gridExpand = TRUE
  )
}
openxlsx::saveWorkbook(wb, ruta_salida, overwrite = TRUE)

message(sprintf("    OK: %s", fs::path_rel(ruta_salida, here::here())))

message("")
message("=== Resumen 4b-lect ===")
print(hoja_4b_lect, n = Inf)
message("")
message("=== Resumen 4b-mate ===")
print(hoja_4b_mate, n = Inf)
message("")
message("=== Resumen 2m-lect ===")
print(hoja_2m_lect, n = Inf)
message("")
message("=== Resumen 2m-mate ===")
print(hoja_2m_mate, n = Inf)
