# 10_utils.R
# ----------------------------------------------------------------------------
# Funciones utilitarias del proyecto slep_simce_adecuado.
#
# Funciones expuestas:
#   - fila_con_resultado(ade, ele, ins): TRUE si la fila trae resultado por
#     estándar (los tres porcentajes existen y suman entre SUMA_NIVELES_MIN y
#     SUMA_NIVELES_MAX; D36-1). La regla única de filas del motor y la vista.
#   - marca_presente(marca): TRUE si la Agencia puso marca en la fila. Una fila
#     con resultado y marca es un resultado con simbología adicional (D36-1).
#   - afirmar_umbral_evaluados(nalu, valida, origen): detiene si una fila con
#     resultado trae menos de UMBRAL_EVALUADOS evaluados (D36-1: el umbral es
#     aserción, no filtro).
#   - agregar_ponderado(df, group_vars): agrega el % adecuado, elemental e
#     insuficiente ponderado por número de evaluados sobre las filas con
#     resultado, con o sin marca, y suma los subtotales de las filas con
#     simbología adicional (n_estab_simb, n_evaluados_simb, num_*_simb).
#   - .tests_agregar_ponderado(): pruebas inline de agregar_ponderado() (nueve
#     casos), que se corren a mano desde la consola.
#
# Requiere las constantes de 10_utils/10_configuracion.R (SUMA_NIVELES_MIN,
# SUMA_NIVELES_MAX, UMBRAL_EVALUADOS), cargado antes.
#
# Convención: paquetes prefijados (dplyr::, tibble::). Sin library() acá.
# ----------------------------------------------------------------------------


#' Fila con resultado por estándar (regla de inclusión D36-1)
#'
#' @param ade,ele,ins Vectores numéricos con los porcentajes Adecuado,
#'   Elemental e Insuficiente.
#' @return Vector lógico sin NA: TRUE si los tres existen y su suma cae entre
#'   SUMA_NIVELES_MIN y SUMA_NIVELES_MAX.
fila_con_resultado <- function(ade, ele, ins) {
  suma <- ade + ele + ins
  !is.na(suma) & suma >= SUMA_NIVELES_MIN & suma <= SUMA_NIVELES_MAX
}


#' Marca de la Agencia presente en la fila
#'
#' @param marca Vector con la marca de la fila (texto o código).
#' @return Vector lógico sin NA: TRUE si la marca no es NA ni vacía.
marca_presente <- function(marca) {
  !is.na(marca) & trimws(as.character(marca)) != ""
}


#' Aserción del umbral de evaluados (D36-1)
#'
#' @param nalu Vector de evaluados.
#' @param valida Vector lógico de fila_con_resultado().
#' @param origen Texto que identifica al llamador en el mensaje de error.
#' @return invisible(TRUE); detiene con stop() si alguna fila con resultado trae
#'   nalu NA o menor que UMBRAL_EVALUADOS.
afirmar_umbral_evaluados <- function(nalu, valida, origen) {
  bajo <- valida & (is.na(nalu) | nalu < UMBRAL_EVALUADOS)
  if (any(bajo)) {
    stop(sprintf(
      "%s: %d fila(s) con resultado por estándar y menos de %d evaluados (D36-1: el umbral es aserción).",
      origen, sum(bajo), UMBRAL_EVALUADOS
    ), call. = FALSE)
  }
  invisible(TRUE)
}


#' Agregar % por estándar ponderado por número de evaluados
#'
#' Toma un data frame en formato largo con una fila por
#' establecimiento × prueba × nivel × año y agrega el porcentaje de
#' estudiantes en cada estándar ponderado por el número de estudiantes
#' evaluados.
#'
#' Regla de filas (D36-1):
#'   1. Entra toda fila con resultado por estándar: palu_eda_ade,
#'      palu_eda_ele y palu_eda_ins existen y suman entre SUMA_NIVELES_MIN y
#'      SUMA_NIVELES_MAX, con o sin marca de la Agencia.
#'   2. Una fila con resultado y menos de UMBRAL_EVALUADOS evaluados detiene
#'      con stop() (aserción; la Agencia no publica porcentajes bajo el umbral).
#'   3. Las filas con resultado y marca (simbología adicional) entran y además
#'      se suman aparte en las columnas *_simb.
#'
#' Fórmula de agregación:
#'   pct_adecuado = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100
#'   (ídem elemental e insuficiente)
#'
#' @param df Data frame / tibble con al menos las columnas `nalu`,
#'   `palu_eda_ade`, `palu_eda_ele`, `palu_eda_ins`, `marca` y todas las
#'   indicadas en `group_vars`.
#' @param group_vars Vector character con los nombres de las columnas por
#'   las que agrupar. Ejemplo:
#'   c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo").
#'
#' @return Tibble (no agrupado) con una fila por combinación única de
#'   `group_vars` y columnas adicionales `n_estab`, `n_evaluados`,
#'   `pct_adecuado`, `pct_elemental`, `pct_insuficiente` y los subtotales de
#'   las filas con simbología adicional: `n_estab_simb`, `n_evaluados_simb` y
#'   los numeradores en estudiantes `num_ade_simb`, `num_ele_simb` y
#'   `num_ins_simb` (nalu * palu / 100).
agregar_ponderado <- function(df, group_vars) {
  # --- Validaciones de input ---
  cols_requeridas <- c("nalu", "palu_eda_ade", "palu_eda_ele", "palu_eda_ins", "marca")

  stopifnot(
    "df debe ser data frame o tibble" = is.data.frame(df),
    "group_vars debe ser character no vacío" =
      is.character(group_vars) && length(group_vars) >= 1,
    "Faltan columnas en df indicadas por group_vars" =
      all(group_vars %in% names(df)),
    "Faltan columnas requeridas en df (nalu, palu_eda_ade, palu_eda_ele, palu_eda_ins, marca)" =
      all(cols_requeridas %in% names(df))
  )

  valida <- fila_con_resultado(df$palu_eda_ade, df$palu_eda_ele, df$palu_eda_ins)
  afirmar_umbral_evaluados(df$nalu, valida, "agregar_ponderado()")

  df[valida, , drop = FALSE] |>
    dplyr::mutate(.simb = marca_presente(marca)) |>
    dplyr::summarise(
      n_estab          = dplyr::n(),
      n_evaluados      = sum(nalu),
      pct_adecuado     = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100,
      pct_elemental    = sum(nalu * palu_eda_ele / 100) / sum(nalu) * 100,
      pct_insuficiente = sum(nalu * palu_eda_ins / 100) / sum(nalu) * 100,
      n_estab_simb     = sum(.simb),
      n_evaluados_simb = sum(nalu[.simb]),
      num_ade_simb     = sum(nalu[.simb] * palu_eda_ade[.simb] / 100),
      num_ele_simb     = sum(nalu[.simb] * palu_eda_ele[.simb] / 100),
      num_ins_simb     = sum(nalu[.simb] * palu_eda_ins[.simb] / 100),
      .by = dplyr::all_of(group_vars)
    )
}


# ----------------------------------------------------------------------------
# Tests inline. Ejecutar manualmente desde consola:
#   source("10_utils/10_configuracion.R"); source("10_utils/10_utils.R")
#   .tests_agregar_ponderado()
# Devuelve TRUE (invisible) si los 9 casos pasan; falla con stopifnot()
# en el primer caso que no se cumpla.
# ----------------------------------------------------------------------------

.tests_agregar_ponderado <- function() {

  gv <- c("cod_com_rbd", "cod_grupo")
  # TRUE si evaluar `expr` termina en error.
  termina_en_error <- function(expr) {
    inherits(tryCatch({ expr; NULL }, error = function(e) e), "error")
  }

  # --- Caso 1: un solo establecimiento válido ---
  caso_1 <- tibble::tibble(
    rbd          = "1",
    cod_com_rbd  = "100",
    cod_grupo    = "3",
    nalu         = 50L,
    palu_eda_ade = 40,
    palu_eda_ele = 35,
    palu_eda_ins = 25,
    marca        = NA_character_
  )
  r1 <- agregar_ponderado(caso_1, group_vars = gv)
  stopifnot(
    "C1: una sola fila"      = nrow(r1) == 1L,
    "C1: n_estab=1"          = r1$n_estab == 1L,
    "C1: n_evaluados=50"     = r1$n_evaluados == 50L,
    "C1: pct=40"             = abs(r1$pct_adecuado - 40) < 1e-9,
    "C1: ele=35, ins=25"     = abs(r1$pct_elemental - 35) < 1e-9 &&
                               abs(r1$pct_insuficiente - 25) < 1e-9,
    "C1: sin simbologia"     = r1$n_estab_simb == 0L && r1$n_evaluados_simb == 0L
  )

  # --- Caso 2: dos establecimientos con mismo palu → pct = palu ---
  caso_2 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(50L, 150L),
    palu_eda_ade = c(40, 40),
    palu_eda_ele = c(30, 30),
    palu_eda_ins = c(30, 30),
    marca        = c(NA_character_, NA_character_)
  )
  r2 <- agregar_ponderado(caso_2, group_vars = gv)
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
    palu_eda_ele = c(50, 30),
    palu_eda_ins = c(30, 10),
    marca        = c(NA_character_, NA_character_)
  )
  r3 <- agregar_ponderado(caso_3, group_vars = gv)
  stopifnot(
    "C3: pct ponderado = 50" = abs(r3$pct_adecuado - 50) < 1e-9,
    "C3: n_evaluados=200"    = r3$n_evaluados == 200L,
    "C3: ele ponderado = 35" = abs(r3$pct_elemental - 35) < 1e-9
  )

  # --- Caso 4: fila con resultado y nalu < 10 → stop() (aserción D36-1) ---
  caso_4 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(9L, 150L),        # rbd 1 bajo el umbral con resultado
    palu_eda_ade = c(99, 30),
    palu_eda_ele = c(1, 40),
    palu_eda_ins = c(0, 30),
    marca        = c(NA_character_, NA_character_)
  )
  stopifnot(
    "C4: nalu < 10 con resultado detiene" =
      termina_en_error(agregar_ponderado(caso_4, group_vars = gv))
  )

  # --- Caso 5: la marca no excluye y cuenta en n_estab_simb ---
  caso_5 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(50L, 150L),
    palu_eda_ade = c(99, 30),
    palu_eda_ele = c(1, 40),
    palu_eda_ins = c(0, 30),
    marca        = c("2", NA_character_)  # rbd 1 con simbología adicional
  )
  r5 <- agregar_ponderado(caso_5, group_vars = gv)
  stopifnot(
    "C5: los dos contribuyen"      = r5$n_estab == 2L,
    "C5: n_evaluados=200"          = r5$n_evaluados == 200L,
    "C5: pct = (49.5 + 45) / 200"  = abs(r5$pct_adecuado - 47.25) < 1e-9,
    "C5: n_estab_simb=1"           = r5$n_estab_simb == 1L,
    "C5: n_evaluados_simb=50"      = r5$n_evaluados_simb == 50L,
    "C5: num_ade_simb=49.5"        = abs(r5$num_ade_simb - 49.5) < 1e-9,
    "C5: num_ele_simb=0.5"         = abs(r5$num_ele_simb - 0.5) < 1e-9,
    "C5: num_ins_simb=0"           = abs(r5$num_ins_simb - 0) < 1e-9
  )

  # --- Caso 6: único establecimiento con resultado y nalu < 10 → stop() ---
  caso_6 <- tibble::tibble(
    rbd          = "1",
    cod_com_rbd  = "100",
    cod_grupo    = "3",
    nalu         = 5L,                  # bajo el umbral con resultado
    palu_eda_ade = 99,
    palu_eda_ele = 1,
    palu_eda_ins = 0,
    marca        = NA_character_
  )
  stopifnot(
    "C6: nalu < 10 con resultado detiene" =
      termina_en_error(agregar_ponderado(caso_6, group_vars = gv))
  )

  # --- Caso 7: GSE como dimensión de agrupación funciona ---
  caso_7 <- tibble::tibble(
    rbd          = c("1", "2", "3"),
    cod_com_rbd  = c("100", "100", "100"),
    cod_grupo    = c("1", "1", "5"),
    nalu         = c(50L, 50L, 100L),
    palu_eda_ade = c(20, 30, 80),
    palu_eda_ele = c(40, 40, 15),
    palu_eda_ins = c(40, 30, 5),
    marca        = rep(NA_character_, 3)
  )
  r7 <- agregar_ponderado(caso_7, group_vars = gv)
  stopifnot(
    "C7: dos GSE distintos" = nrow(r7) == 2L,
    "C7: pct GSE 1 = 25"    =
      abs(r7$pct_adecuado[r7$cod_grupo == "1"] - 25) < 1e-9,
    "C7: pct GSE 5 = 80"    =
      abs(r7$pct_adecuado[r7$cod_grupo == "5"] - 80) < 1e-9
  )

  # --- Caso 8: fila en ceros excluida (no es resultado), aunque traiga marca
  # y menos de 10 evaluados ---
  caso_8 <- tibble::tibble(
    rbd          = c("1", "2"),
    cod_com_rbd  = c("100", "100"),
    cod_grupo    = c("3", "3"),
    nalu         = c(5L, 100L),
    palu_eda_ade = c(0, 30),
    palu_eda_ele = c(0, 40),
    palu_eda_ins = c(0, 30),
    marca        = c("1", NA_character_)
  )
  r8 <- agregar_ponderado(caso_8, group_vars = gv)
  stopifnot(
    "C8: solo la fila con resultado" = r8$n_estab == 1L,
    "C8: n_evaluados=100"            = r8$n_evaluados == 100L,
    "C8: pct=30"                     = abs(r8$pct_adecuado - 30) < 1e-9,
    "C8: la fila en ceros no cuenta como simbologia" = r8$n_estab_simb == 0L
  )

  # --- Caso 9: ninguna fila con resultado → tibble vacío con esquema ---
  caso_9 <- caso_8[1, ]
  r9 <- agregar_ponderado(caso_9, group_vars = gv)
  stopifnot(
    "C9: tibble vacío"           = nrow(r9) == 0L,
    "C9: esquema preservado"     =
      all(c("cod_com_rbd", "cod_grupo", "n_estab", "n_evaluados",
            "pct_adecuado", "n_estab_simb", "n_evaluados_simb",
            "num_ade_simb", "num_ele_simb", "num_ins_simb") %in% names(r9))
  )

  message("OK: 9/9 casos de .tests_agregar_ponderado() pasaron.")
  invisible(TRUE)
}
