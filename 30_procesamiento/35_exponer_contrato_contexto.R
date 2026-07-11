# 35_exponer_contrato_contexto.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Productor del CONTRATO DE CONTEXTO v1 para slep_simce_adecuado.
#
# Lee 40_salidas/intermedios/simce_rbd.parquet (ya con las 5 columnas de señal
# que 31_leer_normalizar.R persiste) y expone SOLO las filas donde el
# establecimiento MEJORA — por sobre su GSE (siggru == 1) o respecto de su
# evaluación anterior (sigdif == 1) — a un parquet que consume
# slep_minuta_buenas_senales. El filtrado ocurre AQUÍ, en el productor
# (contrato §1, §2); el consumidor recibe el parquet ya filtrado.
#
# Especificación: 50_documentacion/activa/contrato_contexto_v1.md (LEER). Este
# script la implementa, no la repite. Esquema de 15 columnas en §3.
#
# 🔒 SEGREGACIÓN DE ESCALA (contrato §5): las señales de la Agencia operan sobre
#    PUNTAJE PROMEDIO (prom), NO sobre % adecuado (palu_eda_*). No existe ninguna
#    señal de significancia sobre el % adecuado. escala = "simce_puntaje". Todo
#    texto del consumidor a partir de estas filas debe decir "puntaje".
#
# Insumos  : 40_salidas/intermedios/simce_rbd.parquet (paso 31; no se modifica).
# Salidas  : 40_salidas/publico/contexto_simce.parquet (escritura atómica).
#
# Uso:
#   source(here::here("30_procesamiento", "35_exponer_contrato_contexto.R"))
#
# Convención: paquetes prefijados. library() solo para here.
# ----------------------------------------------------------------------------

library(here)

# ============================================================================
# Constantes del contrato (el contrato es la fuente de verdad)
# ============================================================================
PROYECTO_ORIGEN  <- "slep_simce_adecuado"  # §3 col 12
ESCALA_SIMCE     <- "simce_puntaje"        # §5 (puntaje promedio, NO % adecuado)
VERSION_CONTRATO <- "contexto_v1"          # §3 col 15 / §9
PERIODO_CORRIDA  <- "2026-07"              # AAAA-MM de esta corrida (§3 col 13)

# Glosa del eje (prueba -> nombre legible). El productor la provee (§4); el
# consumidor no mantiene un diccionario paralelo.
EJE_ETIQUETA <- c(lect = "Lectura", mate = "Matemática")

# Orden EXACTO de las 15 columnas (contrato §3). No alterar.
COLS_CONTRATO <- c(
  "rbd", "anio", "eje", "eje_etiqueta", "segmento", "escala",
  "valor", "desvio_gse", "mejora_sobre_gse", "mejora_ano_ano",
  "cod_grupo", "proyecto_origen", "periodo", "fecha_calculo", "version_contrato"
)

RUTA_FUENTE <- here::here("40_salidas", "intermedios", "simce_rbd.parquet")
DIR_PUBLICO <- here::here("40_salidas", "publico")
RUTA_SALIDA <- file.path(DIR_PUBLICO, "contexto_simce.parquet")


# ============================================================================
# Helpers
# ============================================================================

# Mapea una bandera tri-estado {-1,0,1,NA} al booleano de mejora del contrato:
# TRUE solo si == 1; 0, -1 y NA -> FALSE. Idioma que NO propaga NA (§6).
bandera_a_mejora <- function(x) !is.na(x) & x == 1L

# Escritura atómica: write a .tmp -> rename. Evita dejar un parquet a medias si
# el proceso muere durante la escritura.
escribir_parquet_atomico <- function(df, ruta_final) {
  tmp <- paste0(ruta_final, ".tmp")
  arrow::write_parquet(df, tmp)
  file.rename(tmp, ruta_final)
  invisible(ruta_final)
}


# ============================================================================
# Flujo principal
# ============================================================================

message("[1] Leyendo simce_rbd.parquet (fuente; no se modifica)...")
if (!file.exists(RUTA_FUENTE)) {
  stop("No existe ", RUTA_FUENTE, ". Corre el paso 31 primero.")
}
simce <- arrow::read_parquet(RUTA_FUENTE)

# El parquet YA está en grano largo (una fila por rbd × anio × nivel × prueba),
# que es exactamente el grano del contrato. No requiere pivot.
message(sprintf("    %d filas leídas.", nrow(simce)))

# --- Derivación de las 15 columnas del contrato -----------------------------
contexto <- simce |>
  dplyr::transmute(
    rbd              = as.character(rbd),
    anio             = as.integer(anio),
    eje              = as.character(prueba),
    eje_etiqueta     = unname(EJE_ETIQUETA[prueba]),
    segmento         = as.character(nivel),
    escala           = ESCALA_SIMCE,
    valor            = as.double(prom),
    # desvio_gse se copia TAL CUAL, incluyendo NA cuando la magnitud está
    # suprimida pero la bandera es +1 (§6: esas filas SÍ se exponen).
    desvio_gse       = as.double(difgru),
    mejora_sobre_gse = bandera_a_mejora(siggru),
    mejora_ano_ano   = bandera_a_mejora(sigdif),
    cod_grupo        = as.character(cod_grupo),
    proyecto_origen  = PROYECTO_ORIGEN,
    periodo          = PERIODO_CORRIDA,
    fecha_calculo    = Sys.Date(),
    version_contrato = VERSION_CONTRATO
  )

# --- Guarda: eje_etiqueta nunca NA (§3 no admite nulos) ---------------------
ejes_sin_glosa <- sort(unique(contexto$eje[is.na(contexto$eje_etiqueta)]))
if (length(ejes_sin_glosa) > 0) {
  stop("prueba sin glosa en EJE_ETIQUETA: ", paste(ejes_sin_glosa, collapse = ", "),
       ". eje_etiqueta no puede ser NA (contrato §3/§4).")
}

# --- Regla de exposición (🔒 §2): solo filas con alguna mejora TRUE ----------
n_antes <- nrow(contexto)
contexto <- dplyr::filter(contexto, mejora_sobre_gse | mejora_ano_ano)
message(sprintf("[2] Filas con alguna mejora: %d (de %d).", nrow(contexto), n_antes))

# --- Orden EXACTO de columnas (contrato §3) ---------------------------------
contexto <- contexto[, COLS_CONTRATO]

# --- Guardas internas (fallan ruidosamente antes de escribir) ---------------
stopifnot(
  "eje_etiqueta con NA"     = !anyNA(contexto$eje_etiqueta),
  "mejora_sobre_gse con NA" = !anyNA(contexto$mejora_sobre_gse),
  "mejora_ano_ano con NA"   = !anyNA(contexto$mejora_ano_ano),
  "fila sin ninguna mejora" =
    all(contexto$mejora_sobre_gse | contexto$mejora_ano_ano),
  "llave (rbd,anio,eje,segmento) no unica" =
    !any(duplicated(contexto[, c("rbd", "anio", "eje", "segmento")]))
)

# --- Escritura atómica (contrato §10) ---------------------------------------
if (!dir.exists(DIR_PUBLICO)) dir.create(DIR_PUBLICO, recursive = TRUE)
escribir_parquet_atomico(contexto, RUTA_SALIDA)

message(sprintf("[3] OK: %d filas x %d columnas en %s.",
                nrow(contexto), ncol(contexto),
                fs::path_rel(RUTA_SALIDA, here::here())))
