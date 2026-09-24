# 36_funciones_trayectorias.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Funciones y constantes de la vista de trayectorias de los Servicios Locales.
#
# Auxiliar no ejecutable del paso 36 (POLITICA §1.2.4): lo cargan
# 36_generar_trayectorias.R y 36_verificar_trayectorias.R. Reconstruye en R
# la capa de datos del mockup auditado en la sesión 30
# (50_documentacion/andamios/mockup_trayectoria_traspasos.html), cuyo script
# de ensamblado no se versionó.
#
# Insumos (40_salidas/intermedios/):
#   - simce_rbd.parquet      resultados por establecimiento, nivel y prueba
#   - sleps_chile.parquet    catálogo de Servicios Locales (SLEP × RBD)
#   - comunas_chile.parquet  nombres de comuna
#
# Expone:
#   - leer_insumos_trayectorias(): los tres parquet, con la lectura validada.
#   - base_valida(simce): filas con los tres niveles publicados y coherentes.
#   - construir_datos_trayectorias(insumos): la lista DATA que consume la
#     plantilla (anios, meta, nac, datos, nube, comunas).
#   - datos_a_json(DATA): el JSON compacto que se inserta en la plantilla.
#
# Universos (reconstruidos del mockup y comprobados celda a celda contra él en
# la sesión 32, prueba D10 de 36_verificar_trayectorias.R: solo difieren
# cifras que son empates de redondeo, que el mockup resolvía en coma flotante):
#   - Servicios Locales: los RBD del catálogo, con cualquier dependencia.
#   - Referente y nube: los RBD con resultado en el primer año de la serie,
#     municipales en cada fila y fuera del catálogo. Es la regla que declaran
#     las notas de la vista («los 1.333 establecimientos que en 2014 eran
#     municipales»). Ningún grupo socioeconómico se excluye: el único
#     establecimiento municipal fuera de los Servicios Locales con grupo alto
#     no tiene resultado en 2014 (sesión 32; corrige el diagnóstico B31-4).
# ----------------------------------------------------------------------------


# ---- Constantes ------------------------------------------------------------

# Dependencia municipal en COD_DEPE2 (glosa en referencia_glosas_simce.md).
DEPE_MUNICIPAL <- "1"

# Una fila entra a la base solo si Adecuado + Elemental + Insuficiente cae en
# este rango: fuera de él, la fila es una celda suprimida (los tres en 0) o un
# redondeo anómalo de la Agencia.
SUMA_NIVELES_MIN <- 99
SUMA_NIVELES_MAX <- 101

# Decimales de los porcentajes publicados en la vista. El redondeo ocurre una
# sola vez, al final, sobre numeradores acumulados (A29-5).
DECIMALES_PCT <- 1L

# La Agencia publica los porcentajes por nivel con un decimal y los evaluados
# como enteros: el numerador nalu × porcentaje × 10 es un entero exacto y el
# redondeo se decide en aritmética entera, igual en toda estación y en todo
# orden de suma. Los empates (un valor exactamente a la mitad de un décimo) se
# resuelven hacia arriba, como REDONDEAR de Excel (sesión 32, duda D1 del
# encargo del traslado: en coma flotante, 655 de 68.840 cifras eran empates que
# cada plataforma resolvía distinto).
ESCALA_PCT <- 10L

# Clave de la serie consolidada de niveles y pruebas.
NP_TODO <- "todo"

# Clave del total de grupos socioeconómicos.
GSE_TOTAL <- "T"

# Identificador y nombre del referente municipal en `meta`.
ID_REFERENTE  <- "REF"
NOM_REFERENTE <- "Referente municipal"

# Orden de presentación de los 36 Servicios Locales (norte a sur por región,
# con la Región Metropolitana al final). Heredado tal cual del mockup de la
# sesión 30: fija la numeración de las burbujas que el titular ya revisó.
ORDEN_SLEP <- c(
  "1501", "101", "102", "202", "301", "302", "401", "402",
  "506", "505", "508", "509", "501", "503", "605", "702", "704",
  "1601", "1602", "807", "801", "802", "902", "1401",
  "1002", "1003", "1101", "1201",
  "1301", "1311", "1302", "1309", "1307", "1305", "1303", "1304"
)


# ---- Lectura ---------------------------------------------------------------

# Lee un parquet de 40_salidas/intermedios/ y comprueba que trae las columnas
# que el paso usa. Se detiene con el nombre de la columna faltante.
leer_intermedio <- function(archivo, columnas) {
  ruta <- here::here("40_salidas", "intermedios", archivo)
  if (!file.exists(ruta)) stop("No existe ", ruta, ". Correr 00_build.R antes.")
  df <- arrow::read_parquet(ruta)
  faltan <- setdiff(columnas, names(df))
  if (length(faltan) > 0) {
    stop(archivo, " no trae las columnas: ", paste(faltan, collapse = ", "))
  }
  df
}

leer_insumos_trayectorias <- function() {
  list(
    simce = leer_intermedio(
      "simce_rbd.parquet",
      c("anio", "nivel", "prueba", "rbd", "cod_com_rbd", "cod_grupo",
        "cod_depe2", "nalu", "palu_eda_ade", "palu_eda_ele", "palu_eda_ins")
    ),
    sleps = leer_intermedio(
      "sleps_chile.parquet",
      c("cod_slep", "nombre_slep", "anio_traspaso", "rbd")
    ),
    comunas = leer_intermedio(
      "comunas_chile.parquet",
      c("cod_com_rbd", "nom_com_rbd")
    )
  )
}


# ---- Base y agregación -----------------------------------------------------

# Filas con los tres niveles y el número de evaluados publicados, y con una
# suma de niveles coherente. Agrega la clave nivel_prueba y los numeradores
# crudos de Adecuado e Insuficiente.
base_valida <- function(simce) {
  simce |>
    dplyr::filter(
      !is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
      !is.na(nalu)
    ) |>
    dplyr::mutate(suma_niveles = palu_eda_ade + palu_eda_ele + palu_eda_ins) |>
    dplyr::filter(suma_niveles >= SUMA_NIVELES_MIN,
                  suma_niveles <= SUMA_NIVELES_MAX) |>
    dplyr::mutate(
      rbd     = as.character(rbd),
      anio    = as.integer(anio),
      np      = paste0(nivel, "_", prueba),
      p_ade   = round(palu_eda_ade * ESCALA_PCT),
      p_ins   = round(palu_eda_ins * ESCALA_PCT)
    )
}

# Porcentaje con DECIMALES_PCT decimales a partir de un numerador y un
# denominador enteros (num / den = porcentaje × ESCALA_PCT), redondeado en
# aritmética entera con los empates hacia arriba. Los enteros caben de sobra
# en la precisión exacta de un double (menos de 2^53).
redondear_exacto <- function(num, den) {
  ((2 * num + den) %/% (2 * den)) / ESCALA_PCT
}

# Agrega por `claves`: porcentajes ponderados por evaluados, evaluados y
# establecimientos distintos. Redondeo único al final.
agregar_trayectorias <- function(df, claves) {
  df |>
    dplyr::summarise(
      .by = dplyr::all_of(claves),
      ade_num = sum(nalu * p_ade),
      ins_num = sum(nalu * p_ins),
      den     = sum(nalu),
      n   = as.integer(round(sum(nalu))),
      e   = dplyr::n_distinct(rbd)
    ) |>
    dplyr::mutate(ade = redondear_exacto(ade_num, den),
                  ins = redondear_exacto(ins_num, den))
}

# Duplica las filas bajo la clave NP_TODO: la serie que combina los dos
# niveles y las dos pruebas.
con_todo <- function(df) {
  dplyr::bind_rows(df, dplyr::mutate(df, np = NP_TODO))
}

# Total (GSE_TOTAL) más un desglose por grupo socioeconómico.
total_y_grupos <- function(df, claves) {
  dplyr::bind_rows(
    agregar_trayectorias(df, claves) |> dplyr::mutate(g = GSE_TOTAL),
    agregar_trayectorias(df, c(claves, "cod_grupo")) |>
      dplyr::rename(g = cod_grupo)
  )
}

# Serie completa: para cada nivel y prueba, los establecimientos con resultado
# en todos los años; para la serie NP_TODO, los que tienen algún resultado en
# todos los años. Devuelve las filas de `df` que pertenecen al panel fijo, con
# la serie NP_TODO ya incluida.
panel_fijo <- function(df, n_anios) {
  completos_np <- df |>
    dplyr::summarise(.by = c(rbd, np), k = dplyr::n_distinct(anio)) |>
    dplyr::filter(k == n_anios) |>
    dplyr::select(rbd, np)
  completos_rbd <- df |>
    dplyr::summarise(.by = rbd, k = dplyr::n_distinct(anio)) |>
    dplyr::filter(k == n_anios) |>
    dplyr::pull(rbd)
  dplyr::bind_rows(
    dplyr::semi_join(df, completos_np, by = c("rbd", "np")),
    df |> dplyr::filter(rbd %in% completos_rbd) |> dplyr::mutate(np = NP_TODO)
  )
}

# Filas de `datos` para un universo con identificador `id`: panel 0 (todos los
# establecimientos con resultado) y panel 1 (serie completa).
filas_datos <- function(df, n_anios) {
  dplyr::bind_rows(
    total_y_grupos(con_todo(df), c("id", "anio", "np")) |>
      dplyr::mutate(panel = 0L),
    total_y_grupos(panel_fijo(df, n_anios), c("id", "anio", "np")) |>
      dplyr::mutate(panel = 1L)
  )
}

# Orden de las claves de grupo: el total primero, después los grupos.
orden_gse <- function(g) ifelse(g == GSE_TOTAL, "0", g)


# ---- Construcción de DATA --------------------------------------------------

# `conservar_brutos = TRUE` agrega a `datos` y `nube` los numeradores y el
# denominador enteros (ade_num, ins_num, den); solo lo usa la verificación,
# para distinguir un empate de redondeo de una diferencia real.
construir_datos_trayectorias <- function(insumos, conservar_brutos = FALSE) {
  catalogo <- insumos$sleps |>
    dplyr::mutate(rbd = as.character(rbd), cod_slep = as.character(cod_slep))

  base <- base_valida(insumos$simce)

  anios   <- sort(unique(base$anio))
  n_anios <- length(anios)
  anio_ancla <- min(anios)

  # -- Universos --
  # Servicios Locales: los establecimientos del catálogo, con cualquier
  # dependencia (eran municipales antes del traspaso).
  slep <- base |>
    dplyr::inner_join(dplyr::distinct(catalogo, cod_slep, rbd), by = "rbd") |>
    dplyr::rename(id = cod_slep)

  # Referente y nube: establecimientos con resultado en el primer año de la
  # serie, municipales en cada fila y fuera del catálogo de Servicios Locales.
  rbd_ancla <- unique(base$rbd[base$anio == anio_ancla])
  municipal <- base |>
    dplyr::filter(cod_depe2 == DEPE_MUNICIPAL,
                  !rbd %in% catalogo$rbd,
                  rbd %in% rbd_ancla)

  # -- meta --
  fichas <- catalogo |>
    dplyr::summarise(.by = cod_slep,
                     nom  = dplyr::first(nombre_slep),
                     tras = as.integer(dplyr::first(anio_traspaso)),
                     cat  = dplyr::n_distinct(rbd))
  if (!setequal(fichas$cod_slep, ORDEN_SLEP)) {
    stop("ORDEN_SLEP no coincide con el catálogo de Servicios Locales: ",
         paste(sort(setdiff(union(fichas$cod_slep, ORDEN_SLEP),
                            intersect(fichas$cod_slep, ORDEN_SLEP))),
               collapse = ", "))
  }
  meta <- lapply(ORDEN_SLEP, function(cod) {
    f <- fichas[fichas$cod_slep == cod, ]
    list(nom = f$nom, tras = f$tras, post = sum(anios >= f$tras), cat = f$cat)
  })
  names(meta) <- ORDEN_SLEP
  meta[[ID_REFERENTE]] <- list(nom = NOM_REFERENTE, tras = 0L, post = -1L,
                               cat = dplyr::n_distinct(municipal$rbd))

  # -- nac: todos los establecimientos del país --
  nac_df <- total_y_grupos(con_todo(base), c("anio", "np")) |>
    dplyr::mutate(clave = paste0(np, "|", g),
                  bloque = ifelse(g == GSE_TOTAL, 0L, 1L)) |>
    dplyr::arrange(bloque, np, orden_gse(g), anio)
  nac <- lapply(split(nac_df, factor(nac_df$clave, levels = unique(nac_df$clave))),
                function(d) {
                  v <- lapply(seq_len(nrow(d)), function(i) c(d$ade[i], d$ins[i]))
                  names(v) <- as.character(d$anio)
                  v
                })

  # -- datos: Servicios Locales y referente --
  datos_df <- dplyr::bind_rows(
    filas_datos(slep, n_anios),
    filas_datos(dplyr::mutate(municipal, id = ID_REFERENTE), n_anios)
  ) |>
    dplyr::arrange(panel, orden_gse(g), id, anio, np) |>
    dplyr::select(id, anio, np, g, panel, ade, ins, n, e,
                  dplyr::any_of(if (conservar_brutos) c("ade_num", "ins_num", "den")))

  # -- nube: una fila por comuna con sus establecimientos municipales --
  nube_df <- total_y_grupos(con_todo(dplyr::rename(municipal, com = cod_com_rbd)),
                            c("com", "anio", "np")) |>
    dplyr::arrange(orden_gse(g), com, anio, np) |>
    dplyr::select(com, anio, np, g, ade, ins, n,
                  dplyr::any_of(if (conservar_brutos) c("ade_num", "ins_num", "den")))

  # -- comunas: nombre en tipo título, solo las de la nube --
  comunas_df <- insumos$comunas |>
    dplyr::filter(cod_com_rbd %in% nube_df$com) |>
    dplyr::distinct(cod_com_rbd, nom_com_rbd) |>
    dplyr::arrange(cod_com_rbd)
  comunas <- as.list(stringr::str_to_title(comunas_df$nom_com_rbd))
  names(comunas) <- comunas_df$cod_com_rbd

  list(anios = anios, meta = meta, nac = nac,
       datos = datos_df, nube = nube_df, comunas = comunas)
}

# Serializa DATA como JSON compacto: `datos` y `nube` como arreglos de filas
# ([id, anio, np, g, panel, ade, ins, n, e] y [com, anio, np, g, ade, ins, n]),
# que es la forma que lee la plantilla.
datos_a_json <- function(DATA) {
  enc2utf8(as.character(jsonlite::toJSON(
    DATA, dataframe = "values", auto_unbox = TRUE, digits = NA,
    null = "null", na = "null"
  )))
}
