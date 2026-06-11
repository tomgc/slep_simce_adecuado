# 10_utils.R
# ----------------------------------------------------------------------------
# Funciones utilitarias del proyecto slep_simce_adecuado.
#
# Funciones expuestas:
#   - agregar_ponderado(df, group_vars): agrega el % adecuado ponderado por
#     número de evaluados, respetando umbral MINEDUC (>=10) y marca de
#     supresión NA. Devuelve tibble con n_estab, n_evaluados, pct_adecuado.
#   - json_motor(df, ...): construye la estructura JSON consumida por el
#     motor_comparacion.html (pendiente).
#
# Convención: paquetes prefijados (dplyr::, tibble::). Sin library() acá.
# ----------------------------------------------------------------------------


#' Agregar % adecuado ponderado por número de evaluados
#'
#' Toma un data frame en formato largo con una fila por
#' establecimiento × prueba × nivel × año y agrega el porcentaje de
#' estudiantes en nivel Adecuado ponderado por el número de estudiantes
#' evaluados. Aplica los filtros de exclusión MINEDUC antes de agregar.
#'
#' Filtros aplicados (en orden):
#'   1. nalu no NA
#'   2. nalu >= 10           (umbral MINEDUC)
#'   3. marca es NA          (sin marca de supresión)
#'   4. palu_eda_ade no NA   (defensivo)
#'
#' Fórmula de agregación:
#'   pct_adecuado = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100
#'
#' @param df Data frame / tibble con al menos las columnas `nalu`,
#'   `palu_eda_ade`, `marca` y todas las indicadas en `group_vars`.
#' @param group_vars Vector character con los nombres de las columnas por
#'   las que agrupar. Ejemplo:
#'   c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo").
#'
#' @return Tibble (no agrupado) con una fila por combinación única de
#'   `group_vars` y columnas adicionales `n_estab`, `n_evaluados`,
#'   `pct_adecuado`.
agregar_ponderado <- function(df, group_vars) {
  # --- Validaciones de input ---
  cols_requeridas <- c("nalu", "palu_eda_ade", "marca")

  stopifnot(
    "df debe ser data frame o tibble" = is.data.frame(df),
    "group_vars debe ser character no vacío" =
      is.character(group_vars) && length(group_vars) >= 1,
    "Faltan columnas en df indicadas por group_vars" =
      all(group_vars %in% names(df)),
    "Faltan columnas requeridas en df (nalu, palu_eda_ade, marca)" =
      all(cols_requeridas %in% names(df))
  )

  # ele/ins son opcionales: si están presentes, se agregan con la MISMA
  # ponderación y los MISMOS filtros que adecuado. El conjunto de filas que
  # entra al cálculo lo gobierna palu_eda_ade (no-NA), de modo que el % adecuado
  # resultante es idéntico exista o no la columna ele/ins. Las filas suprimidas
  # (nalu < 10, o marca presente) quedan fuera por igual para los tres niveles.
  tiene_ele <- "palu_eda_ele" %in% names(df)
  tiene_ins <- "palu_eda_ins" %in% names(df)

  base <- df |>
    dplyr::filter(
      !is.na(nalu),
      nalu >= 10,
      is.na(marca),
      !is.na(palu_eda_ade)
    ) |>
    dplyr::group_by(dplyr::across(dplyr::all_of(group_vars)))

  res <- base |>
    dplyr::summarise(
      n_estab      = dplyr::n(),
      n_evaluados  = sum(nalu, na.rm = TRUE),
      pct_adecuado = sum(nalu * palu_eda_ade / 100, na.rm = TRUE) /
                     sum(nalu, na.rm = TRUE) * 100,
      pct_elemental = if (tiene_ele)
        sum(nalu * palu_eda_ele / 100, na.rm = TRUE) /
        sum(nalu, na.rm = TRUE) * 100 else NA_real_,
      pct_insuficiente = if (tiene_ins)
        sum(nalu * palu_eda_ins / 100, na.rm = TRUE) /
        sum(nalu, na.rm = TRUE) * 100 else NA_real_,
      .groups = "drop"
    )

  # Si no venían ele/ins, no exponer columnas NA espurias (compatibilidad con
  # llamadas históricas y con los tests inline).
  if (!tiene_ele) res$pct_elemental <- NULL
  if (!tiene_ins) res$pct_insuficiente <- NULL
  res
}


# ----------------------------------------------------------------------------
# Tests inline. Ejecutar manualmente desde consola:
#   source("10_utils/10_utils.R"); .tests_agregar_ponderado()
# Devuelve TRUE (invisible) si los 7 casos pasan; falla con stopifnot()
# en el primer caso que no se cumpla.
# ----------------------------------------------------------------------------

.tests_agregar_ponderado <- function() {

  # --- Caso 1: un solo establecimiento válido ---
  caso_1 <- tibble::tibble(
    rbd          = "1",
    cod_com_rbd  = "100",
    cod_grupo    = "3",
    nalu         = 50L,
    palu_eda_ade = 40,
    marca        = NA_character_
  )
  r1 <- agregar_ponderado(caso_1, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C1: una sola fila"      = nrow(r1) == 1L,
    "C1: n_estab=1"          = r1$n_estab == 1L,
    "C1: n_evaluados=50"     = r1$n_evaluados == 50L,
    "C1: pct=40"             = abs(r1$pct_adecuado - 40) < 1e-9
  )

  # --- Caso 2: dos establecimientos con mismo palu → pct = palu ---
  caso_2 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(50L, 150L),
    palu_eda_ade = c(40, 40),
    marca        = c(NA_character_, NA_character_)
  )
  r2 <- agregar_ponderado(caso_2, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C2: una fila resultante" = nrow(r2) == 1L,
    "C2: pct=40 (iguales)"    = abs(r2$pct_adecuado - 40) < 1e-9,
    "C2: n_evaluados=200"     = r2$n_evaluados == 200L,
    "C2: n_estab=2"           = r2$n_estab == 2L
  )

  # --- Caso 3: dos establecimientos distintos → ponderado correcto ---
  # rbd 1: 50 evaluados, 20% adecuado → 10 alumnos adecuado
  # rbd 2: 150 evaluados, 60% adecuado → 90 alumnos adecuado
  # total: 100 / 200 = 50%
  caso_3 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(50L, 150L),
    palu_eda_ade = c(20, 60),
    marca        = c(NA_character_, NA_character_)
  )
  r3 <- agregar_ponderado(caso_3, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C3: pct ponderado = 50" = abs(r3$pct_adecuado - 50) < 1e-9,
    "C3: n_evaluados=200"    = r3$n_evaluados == 200L
  )

  # --- Caso 4: nalu < 10 → establecimiento excluido ---
  caso_4 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(9L, 150L),        # rbd 1 cae por umbral
    palu_eda_ade = c(99, 30),
    marca        = c(NA_character_, NA_character_)
  )
  r4 <- agregar_ponderado(caso_4, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C4: solo el válido contribuye" = r4$n_estab == 1L,
    "C4: pct = palu del válido"     = abs(r4$pct_adecuado - 30) < 1e-9,
    "C4: n_evaluados=150"           = r4$n_evaluados == 150L
  )

  # --- Caso 5: marca distinta de NA → establecimiento excluido ---
  caso_5 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(50L, 150L),
    palu_eda_ade = c(99, 30),
    marca        = c("X", NA_character_)  # rbd 1 suprimido
  )
  r5 <- agregar_ponderado(caso_5, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C5: solo el válido contribuye" = r5$n_estab == 1L,
    "C5: pct = palu del válido"     = abs(r5$pct_adecuado - 30) < 1e-9
  )

  # --- Caso 6: todos los establecimientos excluidos → tibble vacío ---
  caso_6 <- tibble::tibble(
    rbd          = "1",
    cod_com_rbd  = "100",
    cod_grupo    = "3",
    nalu         = 5L,                  # cae por umbral
    palu_eda_ade = 99,
    marca        = NA_character_
  )
  r6 <- agregar_ponderado(caso_6, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C6: tibble vacío"           = nrow(r6) == 0L,
    "C6: esquema preservado"     =
      all(c("cod_com_rbd", "cod_grupo",
            "n_estab", "n_evaluados", "pct_adecuado") %in% names(r6))
  )

  # --- Caso 7: GSE como dimensión de agrupación funciona ---
  caso_7 <- tibble::tibble(
    rbd          = c("1", "2", "3"),
    cod_com_rbd  = c("100", "100", "100"),
    cod_grupo    = c("1", "1", "5"),
    nalu         = c(50L, 50L, 100L),
    palu_eda_ade = c(20, 30, 80),
    marca        = rep(NA_character_, 3)
  )
  r7 <- agregar_ponderado(caso_7, group_vars = c("cod_com_rbd", "cod_grupo"))
  stopifnot(
    "C7: dos GSE distintos" = nrow(r7) == 2L,
    "C7: pct GSE 1 = 25"    =
      abs(r7$pct_adecuado[r7$cod_grupo == "1"] - 25) < 1e-9,
    "C7: pct GSE 5 = 80"    =
      abs(r7$pct_adecuado[r7$cod_grupo == "5"] - 80) < 1e-9
  )

  message("OK: 7/7 casos de .tests_agregar_ponderado() pasaron.")
  invisible(TRUE)
}


# ----------------------------------------------------------------------------
# json_motor(): pendiente — sesión siguiente.
# ----------------------------------------------------------------------------

# TODO: implementar json_motor(df, ...) que construya la estructura JSON
#       consumida por motor_comparacion.html.
