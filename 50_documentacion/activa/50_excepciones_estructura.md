# Excepciones de estructura de slep_simce_adecuado

> Las lee `95_censar_estructura.R` del kit (perfil `proyecto`). Una fila exceptúa
> los desvíos de su regla en esa ruta (exacta, o prefijo terminado en `/`);
> el motivo es obligatorio. Una fila que ya no calza con ningún desvío sale en
> el censo como `excepcion_sin_uso`, y se retira (SETTINGS §4.7.2, bloque 5).

| ruta | regla | motivo |
|---|---|---|
| `00_build.R` | raiz | orquestador del proyecto; POLITICA §2 admite varios `00_*` en la raíz, pero la lista del perfil `proyecto` del censo solo nombra `00_run_all.R` y `00_escanear_proyecto.R` (sesión 36, 2026-11-09) |
| `docs/` | raiz | carpeta de publicación del motor y de la vista de trayectorias: GitHub Pages sirve el sitio desde la rama `main`, carpeta `/docs` (`50_documentacion/activa/publicacion_github_pages.md`) |
| `NOTICE` | raiz | aviso de la licencia Apache 2.0, que la convención ubica en la raíz junto a `LICENSE` (sesión 36, 2026-11-09) |
