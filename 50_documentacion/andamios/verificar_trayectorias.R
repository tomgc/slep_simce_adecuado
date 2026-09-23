# ============================================================================
# verificar_trayectorias.R
# Batería de verificación de la capa de datos del visualizador de trayectorias.
#
# Destino: 50_documentacion/andamios/verificar_trayectorias.R
# Uso:     Rscript 50_documentacion/andamios/verificar_trayectorias.R
#
# Comprueba invariantes que deben cumplirse sobre los agregados que alimentan
# el motor. Cada prueba mide la afirmación, no un síntoma cercano, y las de
# ausencia llevan control positivo.
# ============================================================================

suppressPackageStartupMessages({
  library(arrow); library(dplyr); library(tidyr); library(here)
})

RUTA <- here::here("40_salidas", "intermedios")
TOL  <- 0.15   # puntos porcentuales admitidos por redondeo

resultados <- new.env(parent = emptyenv())
resultados$filas <- list()

comprobar <- function(id, descripcion, condicion, detalle = "") {
  estado <- if (isTRUE(condicion)) "PASA" else "FALLA"
  resultados$filas[[length(resultados$filas) + 1]] <-
    data.frame(id = id, estado = estado, descripcion = descripcion, detalle = detalle)
  cat(sprintf("%-6s %-5s %s%s\n", id, estado, descripcion,
              if (nzchar(detalle)) paste0(" (", detalle, ")") else ""))
  invisible(isTRUE(condicion))
}

# ---- Lectura y reconstrucción de los agregados ------------------------------

simce <- read_parquet(file.path(RUTA, "simce_rbd.parquet"))
sleps <- read_parquet(file.path(RUTA, "sleps_chile.parquet"))

niveles <- c("palu_eda_ade", "palu_eda_ele", "palu_eda_ins")

base <- simce |>
  filter(!is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
         !is.na(nalu), !is.na(cod_grupo)) |>
  mutate(suma_niveles = palu_eda_ade + palu_eda_ele + palu_eda_ins) |>
  filter(suma_niveles >= 99, suma_niveles <= 101) |>
  mutate(np      = paste0(nivel, "_", prueba),
         num_ade = nalu * palu_eda_ade / 100,
         num_ins = nalu * palu_eda_ins / 100)

catalogo <- sleps |> distinct(cod_slep, rbd)
slep <- base |> inner_join(catalogo, by = "rbd")

agregar <- function(datos, ...) {
  datos |>
    summarise(.by = c(...),
              ade = round(sum(num_ade) / sum(nalu) * 100, 1),
              ins = round(sum(num_ins) / sum(nalu) * 100, 1),
              n   = as.integer(round(sum(nalu))),
              e   = n_distinct(rbd))
}

consolidado <- agregar(slep, cod_slep, anio, np)
por_grupo   <- agregar(slep, cod_slep, anio, np, cod_grupo)

# ---- D1. Frontera de lo posible --------------------------------------------

comprobar(
  "D1", "Ningún agregado supera Adecuado + Insuficiente = 100",
  all(consolidado$ade + consolidado$ins <= 100 + TOL),
  sprintf("máximo observado %.1f", max(consolidado$ade + consolidado$ins))
)

# ---- D2. El consolidado equivale a los cinco grupos ponderados --------------

recombinado <- por_grupo |>
  summarise(.by = c(cod_slep, anio, np),
            ade_g = sum(n * ade / 100) / sum(n) * 100,
            n_g   = sum(n),
            e_g   = sum(e))

cotejo <- consolidado |> inner_join(recombinado, by = c("cod_slep", "anio", "np"))

comprobar(
  "D2", "El consolidado equivale a los cinco grupos combinados y ponderados",
  all(abs(cotejo$ade_g - cotejo$ade) < TOL),
  sprintf("desviación máxima %.2f puntos en %d combinaciones",
          max(abs(cotejo$ade_g - cotejo$ade)), nrow(cotejo))
)

comprobar(
  "D3", "Los estudiantes evaluados del consolidado igualan la suma por grupo",
  all(cotejo$n == cotejo$n_g),
  sprintf("%d desajustes", sum(cotejo$n != cotejo$n_g))
)

# ---- D4. El grupo socioeconómico se asigna por nivel, no por escuela --------
# No es un defecto del pipeline: es cómo publica la Agencia. La prueba existe
# para que el motor no prometa que el desglose suma el total en la vista que
# combina niveles.

grupos_por_escuela_anio <- base |>
  summarise(.by = c(rbd, anio), grupos = n_distinct(cod_grupo))

comprobar(
  "D4", "Dentro de un mismo nivel y prueba, cada escuela tiene un solo grupo",
  all(base |> summarise(.by = c(rbd, anio, np), g = n_distinct(cod_grupo)) |> pull(g) == 1),
  "condición que sí debe cumplirse siempre"
)

mezclan <- sum(grupos_por_escuela_anio$grupos > 1)
comprobar(
  "D5", "Se declara cuántas escuelas cambian de grupo entre niveles",
  mezclan > 0,
  sprintf("%d de %d pares escuela-año, es decir %.1f%%; por eso el desglose no suma el total en la vista combinada",
          mezclan, nrow(grupos_por_escuela_anio), 100 * mezclan / nrow(grupos_por_escuela_anio))
)

# ---- D6. Panel de serie completa contenido en el panel total ----------------

anios <- sort(unique(base$anio))
completos <- slep |>
  summarise(.by = c(rbd, np), anios_con_dato = n_distinct(anio)) |>
  filter(anios_con_dato == length(anios))

panel_fijo <- slep |> semi_join(completos, by = c("rbd", "np")) |>
  agregar(cod_slep, anio, np)

cotejo_panel <- panel_fijo |>
  inner_join(consolidado, by = c("cod_slep", "anio", "np"), suffix = c("_f", "_c"))

comprobar(
  "D6", "El panel de serie completa nunca tiene más establecimientos que el total",
  all(cotejo_panel$e_f <= cotejo_panel$e_c),
  sprintf("%d violaciones", sum(cotejo_panel$e_f > cotejo_panel$e_c))
)

comprobar(
  "D7", "Toda combinación del panel de serie completa existe en el panel total",
  nrow(panel_fijo) == nrow(cotejo_panel),
  sprintf("%d combinaciones sin contraparte", nrow(panel_fijo) - nrow(cotejo_panel))
)

# ---- D8. Control positivo: la batería detecta un error introducido ----------

adulterado <- cotejo
adulterado$ade[1] <- adulterado$ade[1] + 0.5
detectados <- sum(abs(adulterado$ade_g - adulterado$ade) >= TOL)

comprobar(
  "D8", "Control positivo: alterar una cifra en 0,5 puntos dispara exactamente un hallazgo",
  detectados == 1,
  sprintf("detectados %d", detectados)
)

# ---- Salida ----------------------------------------------------------------

tabla <- do.call(rbind, resultados$filas)
fallan <- sum(tabla$estado == "FALLA")

cat("\n")
cat(sprintf("Resultado: %d pruebas, %d pasan, %d fallan\n",
            nrow(tabla), sum(tabla$estado == "PASA"), fallan))

destino <- here::here("50_documentacion", "andamios", "logs",
                      format(Sys.Date(), "%Y%m%d_verificacion_trayectorias.csv"))
if (dir.exists(dirname(destino))) {
  write.csv(tabla, destino, row.names = FALSE, fileEncoding = "UTF-8")
  cat("Registro escrito en", destino, "\n")
}

if (fallan > 0) quit(status = 1)
