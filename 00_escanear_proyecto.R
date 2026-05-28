# 00_escanear_proyecto.R
# ----------------------------------------------------------------------------
# Escáner canónico de la estructura del proyecto.
#
# Genera cuatro archivos en 50_documentacion/estructura/:
#   estructura_actual.md              — alias, siempre el más reciente
#   estructura_actual.txt             — ídem en .txt
#   YYYYMMDD_HHMMSS_estructura.md     — snapshot histórico
#   YYYYMMDD_HHMMSS_estructura.txt    — snapshot histórico en .txt
#
# Uso:
#   source(here::here("00_escanear_proyecto.R"))
# ----------------------------------------------------------------------------

library(here)

raiz <- here::here()

# ============================================================================
# Árbol con fs::dir_tree() — excluye carpetas problemáticas
# ============================================================================

# Captura el árbol excluyendo: .git, renv, simce (xlsx crudos pesados).
# Los .parquet y .min.js quedan en la lista pero son binarios; se omiten
# con regexp sobre el nombre de archivo.
arbol_lines <- capture.output(
  fs::dir_tree(
    raiz,
    recurse  = TRUE,
    all      = FALSE,
    regexp   = "(\\.git|/renv|/simce|node_modules)$",
    invert   = TRUE
  )
)

# Eliminar líneas que corresponden a binarios pesados (parquet, min.js)
# para no llenar el árbol de rutas ilegibles.
arbol_lines <- arbol_lines[
  !grepl("\\.parquet$|\\.min\\.js$", arbol_lines)
]

# ============================================================================
# Parquets en disco y salidas HTML
# ============================================================================

dir_inter    <- here::here("40_salidas", "intermedios")
parquets     <- character(0)
if (dir.exists(dir_inter)) {
  parquets <- list.files(dir_inter, pattern = "\\.parquet$", full.names = FALSE)
}

html_salidas <- list.files(here::here("40_salidas"),
                           pattern = "\\.html$", full.names = FALSE)

# ============================================================================
# Git log últimos 5 commits
# ============================================================================

git_log <- tryCatch(
  system2("git", c("-C", raiz, "log", "--oneline", "-5"),
          stdout = TRUE, stderr = FALSE),
  error = function(e) character(0)
)

# ============================================================================
# Construir markdown
# ============================================================================

fecha     <- format(Sys.time(), "%Y-%m-%d %H:%M")
timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")

md <- c(
  "# Estructura actual — slep_simce_adecuado",
  "",
  sprintf("_Generado por `00_escanear_proyecto.R` el %s._", fecha),
  "_Los `.parquet` y `.min.js` se omiten del árbol (binarios pesados)._",
  "",
  "## Árbol de archivos versionados",
  "",
  "```",
  arbol_lines,
  "```",
  ""
)

# Intermedios en disco.
md <- c(md, "## Intermedios en disco (no versionados)", "")

if (length(parquets) > 0) {
  md <- c(md,
    "_Parquets presentes en `40_salidas/intermedios/`:_",
    "",
    "| Archivo | Tamaño |",
    "|---------|--------|"
  )
  for (p in sort(parquets)) {
    kb <- round(file.info(file.path(dir_inter, p))$size / 1024, 0)
    md <- c(md, sprintf("| `%s` | %d KB |", p, kb))
  }
  md <- c(md, "")
} else {
  md <- c(md,
    "_No se encontraron parquets. Ejecutar el pipeline para generarlos._",
    ""
  )
}

if (length(html_salidas) > 0) {
  md <- c(md,
    "_Salidas HTML en `40_salidas/`:_",
    "",
    paste0("- `", html_salidas, "`"),
    ""
  )
}

# Git log.
if (length(git_log) > 0) {
  md <- c(md,
    "## Últimos 5 commits",
    "",
    "```",
    git_log,
    "```",
    ""
  )
}

dir_estructura <- here::here("50_documentacion", "estructura")

# Aliases — siempre apuntan al escaneo más reciente
salida_md  <- file.path(dir_estructura, "estructura_actual.md")
salida_txt <- file.path(dir_estructura, "estructura_actual.txt")

# Snapshots con timestamp — histórico navegable
snap_md  <- file.path(dir_estructura, paste0(timestamp, "_estructura.md"))
snap_txt <- file.path(dir_estructura, paste0(timestamp, "_estructura.txt"))

writeLines(md, con = salida_md,  useBytes = FALSE)
writeLines(md, con = salida_txt, useBytes = FALSE)
writeLines(md, con = snap_md,    useBytes = FALSE)
writeLines(md, con = snap_txt,   useBytes = FALSE)

message("00_escanear_proyecto.R: OK")
message(sprintf("    Alias   : %s", fs::path_rel(salida_md,  raiz)))
message(sprintf("    Alias   : %s", fs::path_rel(salida_txt, raiz)))
message(sprintf("    Snapshot: %s", fs::path_rel(snap_md,    raiz)))
message(sprintf("    Snapshot: %s", fs::path_rel(snap_txt,   raiz)))
message(sprintf("    Parquets en disco: %d", length(parquets)))
