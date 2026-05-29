# auditoria_agregacion_comunal.R
# ----------------------------------------------------------------------------
# Verifica que reagregar simce_rbd.parquet por comuna reproduce exactamente
# simce_comunal.parquet. Si los resultados coinciden, DATA.datos es fuente
# confiable para la entidad nacional (P8).
#
# Uso: ejecutar desde la raíz del proyecto con here() activo, o abrir el
# .Rproj en Positron y correr con Ctrl+Shift+S (source).
#
# Salida esperada si todo pasa:
#   ✓ N filas comparables
#   ✓ Max diferencia absoluta en pct_adecuado: 0.0 pp
#   ✓ Auditoría APROBADA — agregación reproducible
# ----------------------------------------------------------------------------

library(here)
source(here::here("10_utils", "10_utils.R"))

message("=== Auditoría: reagregación RBD → comunal ===\n")


# ============================================================================
# 1 — Cargar ambas fuentes
# ============================================================================

message("[1] Cargando parquets...")

df_rbd <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_rbd.parquet")
)
df_comunal <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_comunal.parquet")
)

message(sprintf("    simce_rbd.parquet:     %d filas", nrow(df_rbd)))
message(sprintf("    simce_comunal.parquet: %d filas", nrow(df_comunal)))


# ============================================================================
# 2 — Reagregar desde RBD con los mismos filtros de agregar_ponderado()
#     y la misma llave de agrupación que usa 32_agregar_comunal.R
# ============================================================================

message("\n[2] Reagregando desde RBD...")

df_rbd_filt <- df_rbd |>
  dplyr::filter(!is.na(cod_grupo))  # mismo pre-filtro de 32_

df_reagregado <- agregar_ponderado(
  df_rbd_filt,
  group_vars = c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo", "cod_depe2")
)

message(sprintf("    Filas reagregadas: %d", nrow(df_reagregado)))


# ============================================================================
# 3 — Join para comparar
# ============================================================================

message("\n[3] Comparando con simce_comunal.parquet...")

# Renombrar para distinguir fuentes en el join
df_comunal_cmp <- df_comunal |>
  dplyr::select(anio, nivel, prueba, cod_com_rbd, cod_grupo, cod_depe2,
                pct_ref = pct_adecuado,
                n_eval_ref = n_evaluados,
                n_estab_ref = n_estab)

df_reagregado_cmp <- df_reagregado |>
  dplyr::rename(pct_reagr = pct_adecuado,
                n_eval_reagr = n_evaluados,
                n_estab_reagr = n_estab)

llave <- c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo", "cod_depe2")

df_cmp <- dplyr::full_join(df_comunal_cmp, df_reagregado_cmp, by = llave)


# ============================================================================
# 4 — Diagnóstico de cobertura
# ============================================================================

solo_en_comunal   <- df_cmp |> dplyr::filter(is.na(pct_reagr))
solo_en_reagregado <- df_cmp |> dplyr::filter(is.na(pct_ref))
en_ambos           <- df_cmp |> dplyr::filter(!is.na(pct_ref) & !is.na(pct_reagr))

message(sprintf("    Filas en ambas fuentes:         %d", nrow(en_ambos)))
message(sprintf("    Solo en comunal (no en reagr):  %d", nrow(solo_en_comunal)))
message(sprintf("    Solo en reagr (no en comunal):  %d", nrow(solo_en_reagregado)))

if (nrow(solo_en_comunal) > 0) {
  message("\n    ⚠ Muestra de filas solo en comunal:")
  print(utils::head(solo_en_comunal, 5))
}
if (nrow(solo_en_reagregado) > 0) {
  message("\n    ⚠ Muestra de filas solo en reagregado:")
  print(utils::head(solo_en_reagregado, 5))
}


# ============================================================================
# 5 — Comparación numérica: pct_adecuado, n_evaluados, n_estab
# ============================================================================

message("\n[4] Diferencias numéricas en filas presentes en ambas fuentes...")

en_ambos <- en_ambos |>
  dplyr::mutate(
    diff_pct    = abs(pct_reagr    - pct_ref),
    diff_neval  = abs(n_eval_reagr - n_eval_ref),
    diff_nestab = abs(n_estab_reagr - n_estab_ref)
  )

max_diff_pct    <- max(en_ambos$diff_pct,    na.rm = TRUE)
max_diff_neval  <- max(en_ambos$diff_neval,  na.rm = TRUE)
max_diff_nestab <- max(en_ambos$diff_nestab, na.rm = TRUE)
n_diff_pct_gt0  <- sum(en_ambos$diff_pct > 1e-6, na.rm = TRUE)

message(sprintf("    Max |Δ pct_adecuado|:  %.6f pp", max_diff_pct))
message(sprintf("    Max |Δ n_evaluados|:   %.0f",    max_diff_neval))
message(sprintf("    Max |Δ n_estab|:       %.0f",    max_diff_nestab))
message(sprintf("    Filas con |Δ pct| > 1e-6: %d",  n_diff_pct_gt0))

# Mostrar las discrepancias más grandes si existen
if (n_diff_pct_gt0 > 0) {
  message("\n    ⚠ Top 10 discrepancias en pct_adecuado:")
  top_disc <- en_ambos |>
    dplyr::arrange(dplyr::desc(diff_pct)) |>
    dplyr::select(anio, nivel, prueba, cod_com_rbd, cod_grupo, cod_depe2,
                  pct_ref, pct_reagr, diff_pct) |>
    utils::head(10)
  print(top_disc, n = 10)
}


# ============================================================================
# 6 — Veredicto
# ============================================================================

message("\n=== Veredicto ===")

UMBRAL_PCT   <- 0.01   # diferencia máxima tolerada en pct (0,01 pp)
UMBRAL_NEVAL <- 0      # diferencia máxima tolerada en n_evaluados (exacta)

cobertura_ok <- nrow(solo_en_comunal) == 0 && nrow(solo_en_reagregado) == 0
pct_ok       <- max_diff_pct   <= UMBRAL_PCT
neval_ok     <- max_diff_neval <= UMBRAL_NEVAL

if (cobertura_ok && pct_ok && neval_ok) {
  message("✓ Cobertura: idéntica en ambas fuentes")
  message(sprintf("✓ Max |Δ pct_adecuado|: %.6f pp (umbral: %.2f pp)", max_diff_pct, UMBRAL_PCT))
  message(sprintf("✓ Max |Δ n_evaluados|:  %.0f (umbral: %.0f)", max_diff_neval, UMBRAL_NEVAL))
  message("\n✓ Auditoría APROBADA — agregación reproducible")
  message("  DATA.datos es fuente confiable para entidad nacional (P8).")
} else {
  if (!cobertura_ok) {
    message(sprintf(
      "✗ Cobertura: %d filas solo en comunal / %d solo en reagregado",
      nrow(solo_en_comunal), nrow(solo_en_reagregado)
    ))
  }
  if (!pct_ok) {
    message(sprintf(
      "✗ pct_adecuado: max diferencia %.6f pp supera umbral %.2f pp",
      max_diff_pct, UMBRAL_PCT
    ))
  }
  if (!neval_ok) {
    message(sprintf(
      "✗ n_evaluados: max diferencia %.0f supera umbral %.0f",
      max_diff_neval, UMBRAL_NEVAL
    ))
  }
  message("\n✗ Auditoría FALLIDA — revisar discrepancias antes de implementar P8.")
}
