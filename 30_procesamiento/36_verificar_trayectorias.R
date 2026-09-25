# 36_verificar_trayectorias.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Batería de verificación de la vista de trayectorias (paso 36).
#
# Adapta 50_documentacion/andamios/verificar_trayectorias.R (sesión 30, que
# queda congelado): D1 a D8 se conservan con su cálculo independiente sobre el
# parquet; se agregan D9 a D13, que comprueban el DATA que produce el
# generador y el HTML escrito, y D14, que comprueba la regla de filas del motor
# adoptada en la sesión 33 (sin marca de la Agencia y al menos 10 evaluados).
# C1 a C5 (sesión 35) comprueban las cohortes por traspasar de la decisión
# D35-2 (20260924_decision_referente_traspasos.md).
# Cada prueba mide la afirmación, no un síntoma cercano, y las de ausencia
# llevan control positivo.
#
# Insumos:  40_salidas/intermedios/{simce_rbd,sleps_chile,establecimientos_chile}.parquet
#           20_insumos/auxiliares/dim_slep_comunas.csv
#           40_salidas/trayectorias_traspasos.html (correr antes el paso 36)
#           50_documentacion/andamios/mockup_trayectoria_traspasos.html
# Salida:   el informe en consola, una línea por prueba. No escribe archivos:
#           el log del encargo o de la sesión lo recoge literal (un CSV en el
#           árbol sería un archivo de datos sin autorizar, I8).
#
# Uso:      Rscript 30_procesamiento/36_verificar_trayectorias.R
#           (código de salida 1 si alguna prueba falla)
# ----------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(arrow); library(dplyr); library(here)
})
source(here::here("10_utils", "10_configuracion.R"))  # guarda de locale UTF-8 (POLITICA 5.2bis)

source(here::here("30_procesamiento", "36_funciones_trayectorias.R"))

RUTA        <- here::here("40_salidas", "intermedios")
RUTA_HTML   <- here::here("40_salidas", "trayectorias_traspasos.html")
RUTA_MOCKUP <- here::here("50_documentacion", "andamios",
                          "mockup_trayectoria_traspasos.html")
TOL         <- 0.15   # puntos porcentuales admitidos por redondeo (D1-D8)
PASO_PCT    <- 10^-DECIMALES_PCT

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

# Extrae el literal JSON asignado a `var DATA=` en un HTML.
extraer_data <- function(ruta) {
  html <- paste(readLines(ruta, encoding = "UTF-8", warn = FALSE), collapse = "\n")
  ini <- regexpr("var DATA=", html, fixed = TRUE)
  if (ini < 0) stop("No hay 'var DATA=' en ", ruta)
  ini <- ini + nchar("var DATA=")
  resto <- substr(html, ini, nchar(html))
  fin <- regexpr(";\n</script>", resto, fixed = TRUE)
  if (fin < 0) stop("No se encontró el cierre de DATA en ", ruta)
  substr(resto, 1L, fin - 1L)
}

# ---- Lectura y reconstrucción independiente de los agregados (D1-D8) --------

simce <- read_parquet(file.path(RUTA, "simce_rbd.parquet"))
sleps <- read_parquet(file.path(RUTA, "sleps_chile.parquet"))
stopifnot(nrow(simce) > 0, nrow(sleps) > 0)

base <- simce |>
  filter(!is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
         !is.na(nalu), !is.na(cod_grupo),
         is.na(marca), nalu >= 10) |>
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

# ---- D6-D7. Panel de serie completa contenido en el panel total ------------

anios <- sort(unique(base$anio))
completos <- slep |>
  summarise(.by = c(rbd, np), anios_con_dato = n_distinct(anio)) |>
  filter(anios_con_dato == length(anios))

panel_fijo_ind <- slep |> semi_join(completos, by = c("rbd", "np")) |>
  agregar(cod_slep, anio, np)

cotejo_panel <- panel_fijo_ind |>
  inner_join(consolidado, by = c("cod_slep", "anio", "np"), suffix = c("_f", "_c"))

comprobar(
  "D6", "El panel de serie completa nunca tiene más establecimientos que el total",
  all(cotejo_panel$e_f <= cotejo_panel$e_c),
  sprintf("%d violaciones", sum(cotejo_panel$e_f > cotejo_panel$e_c))
)

comprobar(
  "D7", "Toda combinación del panel de serie completa existe en el panel total",
  nrow(panel_fijo_ind) == nrow(cotejo_panel),
  sprintf("%d combinaciones sin contraparte", nrow(panel_fijo_ind) - nrow(cotejo_panel))
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

# ---- DATA del generador, con los porcentajes sin redondear -----------------

insumos <- leer_insumos_trayectorias()
DATA    <- construir_datos_trayectorias(insumos, conservar_brutos = TRUE)
base_g  <- base_valida(insumos$simce)

# ---- D9. El total T es la suma de todos los grupos del parquet --------------
# Recuento independiente: evaluados por universo, año y nivel-prueba, sumando
# las filas válidas del parquet de todos los grupos socioeconómicos, contra el
# `n` del total que publica la vista. Cubre Servicios Locales, referente y nube,
# en el panel 0. B31-4 atribuía al mockup la exclusión del grupo 5 del total;
# esta prueba es la que lo habría detectado.

anio_ancla <- min(base_g$anio)
rbd_ancla  <- unique(base_g$rbd[base_g$anio == anio_ancla])
municipal_ind <- base_g |>
  filter(cod_depe2 == DEPE_MUNICIPAL,
         !rbd %in% as.character(sleps$rbd),
         rbd %in% rbd_ancla)

recuento <- bind_rows(
  base_g |> inner_join(mutate(catalogo, rbd = as.character(rbd)), by = "rbd") |>
    summarise(.by = c(cod_slep, anio, np), n_ind = sum(nalu)) |>
    rename(id = cod_slep),
  municipal_ind |> summarise(.by = c(anio, np), n_ind = sum(nalu)) |>
    mutate(id = ID_REFERENTE)
)
totales <- DATA$datos |> filter(g == GSE_TOTAL, panel == 0L, np != NP_TODO) |>
  inner_join(recuento, by = c("id", "anio", "np"))

recuento_nube <- municipal_ind |>
  summarise(.by = c(cod_com_rbd, anio, np), n_ind = sum(nalu)) |>
  rename(com = cod_com_rbd)
totales_nube <- DATA$nube |> filter(g == GSE_TOTAL, np != NP_TODO) |>
  inner_join(recuento_nube, by = c("com", "anio", "np"))

suma_grupos <- bind_rows(
  DATA$datos |> filter(g != GSE_TOTAL) |>
    summarise(.by = c(id, anio, np, panel), n_g = sum(n)) |>
    inner_join(filter(DATA$datos, g == GSE_TOTAL), by = c("id", "anio", "np", "panel")) |>
    transmute(n, n_g),
  DATA$nube |> filter(g != GSE_TOTAL) |>
    summarise(.by = c(com, anio, np), n_g = sum(n)) |>
    inner_join(filter(DATA$nube, g == GSE_TOTAL), by = c("com", "anio", "np")) |>
    transmute(n, n_g)
)

desajustes_d9 <- function(tot, tot_nube, sg) {
  sum(tot$n != round(tot$n_ind)) + sum(tot_nube$n != round(tot_nube$n_ind)) +
    sum(sg$n != sg$n_g)
}
comprobar(
  "D9", "El n del total T iguala la suma de todos los grupos del parquet (entidades, referente y nube)",
  desajustes_d9(totales, totales_nube, suma_grupos) == 0 &&
    nrow(totales) == nrow(recuento) && nrow(totales_nube) == nrow(recuento_nube),
  sprintf("%d desajustes en %d + %d + %d combinaciones",
          desajustes_d9(totales, totales_nube, suma_grupos),
          nrow(totales), nrow(totales_nube), nrow(suma_grupos))
)

# Control positivo de D9: restar un evaluado a un total dispara un hallazgo.
plantado <- totales
plantado$n[1] <- plantado$n[1] - 1L
comprobar(
  "D9c", "Control positivo: un total con un evaluado de menos dispara exactamente un hallazgo",
  desajustes_d9(plantado, totales_nube, suma_grupos) == 1,
  sprintf("detectados %d", desajustes_d9(plantado, totales_nube, suma_grupos))
)

# ---- D10. Fidelidad al mockup auditado de la sesión 30 ----------------------
# Coteja la maquinaria de agregación con la regla de filas del mockup, que
# incluía las filas marcadas (excluir_marcadas = FALSE): la regla vigente la
# comprueba D14. Las mismas filas y claves que el mockup; toda cifra distinta debe ser un
# empate exacto de redondeo (el mockup los resolvía en coma flotante; el
# generador, hacia arriba en aritmética entera) y distar un décimo. El número de
# empates que difieren depende de la plataforma que construyó el mockup: no es
# criterio (ERR-32-03). El mockup trae solo los 36 Servicios Locales y el
# referente: el cotejo se hace sin las unidades futuras (incluir_futuras =
# FALSE, sesión 35), sobre el mismo universo de siempre; C3 comprueba que
# agregarlas no cambia esas filas.

M <- jsonlite::fromJSON(extraer_data(RUTA_MOCKUP), simplifyVector = TRUE)
a_df <- function(m, columnas) {
  d <- as.data.frame(m, stringsAsFactors = FALSE)
  names(d) <- columnas
  d
}
mock_datos <- a_df(M$datos, c("id", "anio", "np", "g", "panel", "ade", "ins", "n", "e")) |>
  mutate(across(c(anio, panel, n, e), as.integer), across(c(ade, ins), as.numeric))
mock_nube <- a_df(M$nube, c("com", "anio", "np", "g", "ade", "ins", "n")) |>
  mutate(across(c(anio, n), as.integer), across(c(ade, ins), as.numeric))

# Empate exacto: num / den (porcentaje × ESCALA_PCT) termina justo en ,5.
es_empate <- function(num, den) (2 * num) %% (2 * den) == den
cotejar <- function(gen, mock, claves) {
  x <- inner_join(gen, mock, by = claves, suffix = c("", "_m"))
  dif_ade <- x$ade != x$ade_m
  dif_ins <- x$ins != x$ins_m
  list(
    faltan  = nrow(gen) + nrow(mock) - 2L * nrow(x),
    n_dif   = sum(x$n != x$n_m) + if ("e" %in% names(x)) sum(x$e != x$e_m) else 0L,
    pct_dif = sum(dif_ade) + sum(dif_ins),
    no_empate = sum(dif_ade & !(es_empate(x$ade_num, x$den) & abs(x$ade - x$ade_m) < 1.5 * PASO_PCT)) +
                sum(dif_ins & !(es_empate(x$ins_num, x$den) & abs(x$ins - x$ins_m) < 1.5 * PASO_PCT))
  )
}
DATA_M  <- construir_datos_trayectorias(insumos, conservar_brutos = TRUE,
                                        excluir_marcadas = FALSE,
                                        incluir_futuras = FALSE)
c_datos <- cotejar(DATA_M$datos, mock_datos, c("id", "anio", "np", "g", "panel"))
c_nube  <- cotejar(DATA_M$nube, mock_nube, c("com", "anio", "np", "g"))

ctx <- V8::v8()
ctx$assign("a", extraer_data(RUTA_MOCKUP))
ctx$assign("b", datos_a_json(construir_datos_trayectorias(insumos, excluir_marcadas = FALSE,
                                                          incluir_futuras = FALSE)))
ctx$assign("r", datos_a_json(construir_datos_trayectorias(insumos)))
ctx$eval("var A=JSON.parse(a), B=JSON.parse(b), R=JSON.parse(r);")
iguales_js <- vapply(c("anios", "meta", "nac", "comunas"), function(k) {
  isTRUE(ctx$eval(sprintf("JSON.stringify(A.%s)===JSON.stringify(B.%s)", k, k)) == "true")
}, logical(1))

comprobar(
  "D10", "Fidelidad al mockup de la sesión 30: mismas filas; solo difieren empates de redondeo",
  all(iguales_js) && c_datos$faltan == 0 && c_nube$faltan == 0 &&
    c_datos$n_dif == 0 && c_nube$n_dif == 0 &&
    c_datos$no_empate == 0 && c_nube$no_empate == 0,
  sprintf("anios/meta/nac/comunas idénticos: %s; filas sin pareja %d; conteos distintos %d; cifras distintas %d, de ellas sin empate %d",
          paste(names(iguales_js)[iguales_js], collapse = ","),
          c_datos$faltan + c_nube$faltan, c_datos$n_dif + c_nube$n_dif,
          c_datos$pct_dif + c_nube$pct_dif, c_datos$no_empate + c_nube$no_empate)
)

# Control positivo de D10: una cifra movida un décimo fuera de un empate.
mock_plantado <- mock_datos
no_empate_idx <- which(!es_empate(DATA_M$datos$ade_num, DATA_M$datos$den))[1]
fila_p <- DATA_M$datos[no_empate_idx, c("id", "anio", "np", "g", "panel")]
k <- which(mock_plantado$id == fila_p$id & mock_plantado$anio == fila_p$anio &
           mock_plantado$np == fila_p$np & mock_plantado$g == fila_p$g &
           mock_plantado$panel == fila_p$panel)
mock_plantado$ade[k] <- mock_plantado$ade[k] + PASO_PCT
comprobar(
  "D10c", "Control positivo: una cifra movida un décimo sin empate dispara exactamente un hallazgo",
  cotejar(DATA_M$datos, mock_plantado, c("id", "anio", "np", "g", "panel"))$no_empate == 1,
  sprintf("detectados %d", cotejar(DATA_M$datos, mock_plantado, c("id", "anio", "np", "g", "panel"))$no_empate)
)

# ---- D11. Las cifras escritas en las notas coinciden con los datos ----------

html <- paste(readLines(RUTA_HTML, encoding = "UTF-8", warn = FALSE), collapse = "\n")
n_ref_txt <- format(DATA$meta[[ID_REFERENTE]]$cat, big.mark = ".", decimal.mark = ",")
n_com_txt <- sprintf("(%d en total)", length(DATA$comunas))
# Recuento independiente de las filas marcadas que excluye la regla del motor.
marcadas_ind <- simce |>
  filter(rbd %in% as.character(sleps$rbd),
         !is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
         !is.na(nalu),
         palu_eda_ade + palu_eda_ele + palu_eda_ins >= 99,
         palu_eda_ade + palu_eda_ele + palu_eda_ins <= 101,
         !is.na(marca) | nalu < 10) |>
  nrow()
marcadas_txt <- sprintf("y %s filas con marca de la Agencia",
                        format(marcadas_ind, big.mark = ".", decimal.mark = ","))
# El ejemplo de la nube es literal en la plantilla: debe seguir en los datos.
cod_palena <- names(DATA$comunas)[unlist(DATA$comunas) == "Palena"]
palena_ok <- grepl("Palena aparece con 72,7% en Adecuado sobre 11 estudiantes", html, fixed = TRUE) &&
  nrow(filter(DATA$nube, com %in% cod_palena, g == GSE_TOTAL, np != NP_TODO,
              ade == 72.7, n == 11L)) == 1
sin_marcador <- !grepl("__NOTA_", html, fixed = TRUE)
comprobar(
  "D11", "Las notas declaran el referente, la nube, las filas excluidas y el ejemplo que traen los datos",
  grepl(sprintf("los %s establecimientos", n_ref_txt), html, fixed = TRUE) &&
    grepl(n_com_txt, html, fixed = TRUE) && grepl(marcadas_txt, html, fixed = TRUE) &&
    palena_ok && sin_marcador,
  sprintf("referente %s, nube %s, filas marcadas %d, ejemplo de la nube: %s, sin marcadores: %s",
          n_ref_txt, n_com_txt, marcadas_ind, palena_ok, sin_marcador)
)

# ---- D12. El HTML escrito no depende de la red y trae el DATA del generador --

cargas_red <- lengths(regmatches(html, gregexpr('(src|href)="https?:', html)))
ctx$assign("h", extraer_data(RUTA_HTML))
data_igual <- ctx$eval("JSON.stringify(JSON.parse(h))===JSON.stringify(R)") == "true"
comprobar(
  "D12", "El HTML no carga nada por red y su DATA es el que construye el generador",
  cargas_red == 0 && data_igual && !grepl("__DATA_TRAYECTORIAS__", html, fixed = TRUE),
  sprintf("cargas por red %d; DATA idéntico: %s", cargas_red, data_igual)
)

# Control positivo de D12: el patrón encuentra una carga plantada.
comprobar(
  "D12c", "Control positivo: el patrón de red detecta un <script src=\"https:...\"> plantado",
  lengths(regmatches('<script src="https://x.y/z.js">', gregexpr('(src|href)="https?:', '<script src="https://x.y/z.js">'))) == 1
)

# ---- D13. El DATA no depende del orden de las filas del parquet -------------
# Con el redondeo en aritmética entera, invertir el orden de las filas no puede
# mover ninguna cifra (en coma flotante movía 14; sesión 32, R-16).

insumos_inv <- insumos
insumos_inv$simce <- insumos$simce[rev(seq_len(nrow(insumos$simce))), ]
DATA_inv  <- construir_datos_trayectorias(insumos_inv)
json_base <- datos_a_json(construir_datos_trayectorias(insumos))
comprobar(
  "D13", "Invertir el orden de las filas del parquet deja el DATA idéntico byte a byte",
  identical(datos_a_json(DATA_inv), json_base),
  sprintf("%d bytes", nchar(json_base, type = "bytes"))
)

# Control positivo de D13: el mismo cotejo detecta un DATA con una cifra movida.
DATA_plantado <- DATA_inv
DATA_plantado$datos$ade[1] <- DATA_plantado$datos$ade[1] + PASO_PCT
comprobar(
  "D13c", "Control positivo: un DATA con una cifra movida un décimo no pasa el cotejo",
  !identical(datos_a_json(DATA_plantado), json_base)
)

# ---- D14. La regla de filas es la del motor --------------------------------
# Ninguna fila de la base tiene marca de la Agencia ni menos de 10 evaluados, y
# la regla excluye exactamente las filas que cumplen alguna de las dos
# condiciones (recuento independiente sobre el parquet).

base_sin_regla <- base_valida(insumos$simce, excluir_marcadas = FALSE)
excluidas_ind  <- sum(!is.na(base_sin_regla$marca) | base_sin_regla$nalu < 10)
comprobar(
  "D14", "La base no trae filas con marca ni con menos de 10 evaluados, y excluye exactamente esas",
  sum(!is.na(base_g$marca)) == 0 && sum(base_g$nalu < 10) == 0 &&
    nrow(base_sin_regla) - nrow(base_g) == excluidas_ind && excluidas_ind > 0,
  sprintf("excluidas %d de %d filas coherentes", nrow(base_sin_regla) - nrow(base_g),
          nrow(base_sin_regla))
)

# Control positivo de D14: marcar una fila válida la saca de la base.
simce_plantado <- insumos$simce
idx_valida <- which(is.na(simce_plantado$marca) & !is.na(simce_plantado$palu_eda_ade) &
                      simce_plantado$nalu >= 10)
idx_valida <- idx_valida[as.character(simce_plantado$rbd[idx_valida]) %in% base_g$rbd][1]
simce_plantado$marca[idx_valida] <- "plantada"
comprobar(
  "D14c", "Control positivo: marcar una fila válida la saca de la base, exactamente una",
  nrow(base_g) - nrow(base_valida(simce_plantado)) == 1,
  sprintf("filas que salen %d", nrow(base_g) - nrow(base_valida(simce_plantado)))
)

# ---- Cohortes futuras (D35-2): insumos y recuentos independientes -----------
# Las olas de traspaso posteriores a la última cohorte del catálogo de
# Servicios Locales entran a la vista como unidades propias
# (50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md).
# Una unidad futura se reconoce por su año de traspaso, no por su
# identificador: así C2 puede detectar un identificador reutilizado. Los
# recuentos independientes leen el catálogo de olas y el directorio sin pasar
# por 36_funciones_trayectorias.R. Las pruebas se escribieron antes del código
# (sesión 35): un error de construcción se informa como FALLA de la prueba y no
# detiene la batería.

# Valores esperados con los insumos vigentes (catálogo de slep_central_datos en
# d7a8ec6 y directorio de establecimientos_chile.parquet). Cambian solo cuando
# se recopia el catálogo o se actualiza el directorio (decisión D35-2).
ESPERADO_POR_OLA     <- c("2027" = 13L, "2028" = 11L, "2029" = 13L)
ESPERADO_EST_FUTURAS <- 2564L

intentar <- function(expr) tryCatch(expr, error = function(e) e)
exigir   <- function(x) if (inherits(x, "error")) stop(conditionMessage(x), call. = FALSE) else x
evaluar  <- function(expr) {
  tryCatch(expr, error = function(e) list(ok = FALSE, detalle = paste("error:", conditionMessage(e))))
}

ultima_vigente <- max(as.integer(sleps$anio_traspaso))
olas_ind <- intentar(
  readr::read_delim(
    here::here("20_insumos", "auxiliares", "dim_slep_comunas.csv"), delim = ";",
    col_types = readr::cols(.default = readr::col_character()),
    locale = readr::locale(encoding = "UTF-8"), show_col_types = FALSE, progress = FALSE
  ) |>
    filter(as.integer(anio_traspaso) > ultima_vigente)
)
est_fut_ind <- intentar(
  read_parquet(file.path(RUTA, "establecimientos_chile.parquet")) |>
    filter(cod_depe2 == "1", cod_com_rbd %in% exigir(olas_ind)$cod_comuna) |>
    pull(rbd) |>
    n_distinct()
)

DATA_T <- intentar(construir_datos_trayectorias(insumos, incluir_futuras = TRUE))
DATA_F <- intentar(construir_datos_trayectorias(insumos, incluir_futuras = FALSE))

# Identificadores de las unidades futuras de un `meta`: las de traspaso
# posterior a la última cohorte del catálogo de Servicios Locales.
ids_futuras <- function(meta) {
  tras <- vapply(meta, function(m) as.integer(m$tras), integer(1))
  names(meta)[tras > ultima_vigente]
}
campo_futuras <- function(meta, campo) {
  vapply(meta[ids_futuras(meta)], function(m) as.integer(m[[campo]]), integer(1))
}
a_texto <- function(x) paste(names(x), x, sep = "=", collapse = ", ")

# ---- C1. Hay 37 unidades futuras, con 13, 11 y 13 por ola -------------------
# Además, las unidades son exactamente los pares (Servicio Local, ola) del
# catálogo.

c1 <- evaluar({
  meta  <- exigir(DATA_T)$meta
  pares <- distinct(exigir(olas_ind), cod_slep, anio_traspaso)
  por_ola     <- table(campo_futuras(meta, "tras"))
  por_ola     <- stats::setNames(as.integer(por_ola), names(por_ola))
  por_ola_ind <- table(pares$anio_traspaso)
  por_ola_ind <- stats::setNames(as.integer(por_ola_ind), names(por_ola_ind))
  mismos_pares <- setequal(ids_futuras(meta),
                           paste0(pares$cod_slep, SEP_ID_FUTURO, pares$anio_traspaso))
  list(ok = identical(por_ola, ESPERADO_POR_OLA) && identical(por_ola_ind, ESPERADO_POR_OLA) &&
         mismos_pares,
       detalle = sprintf("%d unidades futuras; por ola en DATA %s; en el catálogo %s; mismos pares: %s",
                         length(ids_futuras(meta)), a_texto(por_ola), a_texto(por_ola_ind),
                         mismos_pares))
})
comprobar("C1", "Hay 37 unidades futuras, con 13, 11 y 13 por ola", c1$ok, c1$detalle)

# ---- C2. Ningún identificador futuro coincide con uno vigente ---------------
# Tampoco se repiten entre sí, y las unidades vigentes siguen siendo las de
# ORDEN_SLEP. Control positivo: un identificador futuro plantado igual a uno
# vigente se detecta.

choques <- function(fut, vig) sum(fut %in% c(vig, ID_REFERENTE)) + sum(duplicated(fut))
c2 <- evaluar({
  meta <- exigir(DATA_T)$meta
  fut  <- ids_futuras(meta)
  tras <- vapply(meta, function(m) as.integer(m$tras), integer(1))
  vig  <- names(meta)[tras > 0L & tras <= ultima_vigente]
  n_choques <- choques(fut, vig) + anyDuplicated(names(meta))
  control   <- choques(c(fut, vig[1]), vig)
  list(ok = length(fut) > 0 && n_choques == 0 && setequal(vig, ORDEN_SLEP) && control == 1,
       detalle = sprintf("%d futuros contra %d vigentes: %d coincidencias; control plantado detectado %d",
                         length(fut), length(vig), n_choques, control))
})
comprobar("C2", "Ningún identificador futuro coincide con uno vigente", c2$ok, c2$detalle)

# ---- C3. Las filas de las 36 vigentes y del referente no cambian ------------
# Autocontenida: el DATA con las unidades futuras, filtrado a las vigentes y al
# referente, es idéntico al DATA sin ellas. Control positivo: una cifra vigente
# movida un décimo rompe la identidad.

c3 <- evaluar({
  ids_c3 <- c(ORDEN_SLEP, ID_REFERENTE)
  con    <- filter(exigir(DATA_T)$datos, id %in% ids_c3)
  sin    <- filter(exigir(DATA_F)$datos, id %in% ids_c3)
  plantado <- con
  k <- which(plantado$id %in% ORDEN_SLEP)[1]
  plantado$ade[k] <- plantado$ade[k] + PASO_PCT
  list(ok = nrow(sin) > 0 && all(ids_c3 %in% sin$id) && identical(con, sin) &&
         !identical(plantado, sin),
       detalle = sprintf("%d filas de %d unidades; idénticas: %s; control plantado detectado: %s",
                         nrow(sin), length(ids_c3), identical(con, sin), !identical(plantado, sin)))
})
comprobar("C3", "Las filas de datos de las 36 unidades vigentes y del referente no cambian",
          c3$ok, c3$detalle)

# ---- C4. Toda unidad futura tiene post == 0 con los datos actuales ----------

c4 <- evaluar({
  meta <- exigir(DATA_T)$meta
  post <- campo_futuras(meta, "post")
  list(ok = length(post) > 0 && all(post == 0L),
       detalle = sprintf("%d unidades futuras; con post distinto de 0: %d; último año con datos %d",
                         length(post), sum(post != 0L), max(exigir(DATA_T)$anios)))
})
comprobar("C4", "Toda unidad futura tiene post == 0 con los datos actuales", c4$ok, c4$detalle)

# ---- C5. Las unidades futuras suman 2.564 establecimientos ------------------
# Recuento independiente: RBD que el directorio registra con cod_depe2 == "1"
# en las comunas de las olas futuras del catálogo.

c5 <- evaluar({
  suma <- sum(campo_futuras(exigir(DATA_T)$meta, "cat"))
  ind  <- exigir(est_fut_ind)
  list(ok = suma == ESPERADO_EST_FUTURAS && ind == ESPERADO_EST_FUTURAS,
       detalle = sprintf("suma en DATA %s; recuento independiente del directorio %s; esperado %s",
                         format(suma, big.mark = ".", decimal.mark = ","),
                         format(ind, big.mark = ".", decimal.mark = ","),
                         format(ESPERADO_EST_FUTURAS, big.mark = ".", decimal.mark = ",")))
})
comprobar("C5", "La suma de establecimientos de las unidades futuras es 2.564", c5$ok, c5$detalle)

# ---- Salida ----------------------------------------------------------------

tabla <- do.call(rbind, resultados$filas)
fallan <- sum(tabla$estado == "FALLA")

cat("\n")
cat(sprintf("Resultado: %d pruebas, %d pasan, %d fallan\n",
            nrow(tabla), sum(tabla$estado == "PASA"), fallan))

if (fallan > 0) quit(status = 1)
