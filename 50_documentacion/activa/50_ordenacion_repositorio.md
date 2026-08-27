# Constancia — Ordenación del repositorio

**Fecha:** 2026-08-27
**Encargo que la origina:** `50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md`
**Log de la ejecución:** `50_documentacion/andamios/logs/20260827_ordenacion_repositorio_log.md`

Constancia de la ordenación estructural ejecutada el 2026-08-27. Registra qué se
midió, con qué comando y cuál fue el resultado. No decide política: donde hubo
que decidir, se dice quién decide.

---

## 1. Estado previo medido

Medición del 2026-08-27, sobre `main` en `06d6586..12b7434`.

### Scripts sueltos en la raíz

`ls -la /Users/tomgc/Projects/slep_simce_adecuado/*.R`:

```
00_build.R
00_escanear_proyecto.R
verificar_depe4.R
verificar_elem_insuf.R
verificar_elem_insuf_2023_2024.R
```

Cinco scripts en la raíz. Dos son orquestadores legítimos de raíz (`00_build.R`,
`00_escanear_proyecto.R`); tres son verificaciones puntuales.

### Archivo con espacio en el nombre

`ls 20_insumos/auxiliares/prototipo_design/` listaba `Motor SIMCE.html`, único
archivo del repositorio con un espacio en el nombre.

### Traspasos acumulados

`ls 50_documentacion/traspasos/ | wc -l` → **27**.

---

## 2. Qué se movió

| Origen | Destino | Estado |
|---|---|---|
| `20_insumos/auxiliares/prototipo_design/Motor SIMCE.html` | `20_insumos/auxiliares/prototipo_design/motor_simce.html` | **Renombrado** con `git mv`, commit `0871488` |
| `verificar_depe4.R` | `10_utils/` | **No movido.** Ver §3 |
| `verificar_elem_insuf.R` | `10_utils/` | **No movido.** Ver §3 |
| `verificar_elem_insuf_2023_2024.R` | `10_utils/` | **No movido.** Ver §3 |

### Referencias actualizadas: ninguna, porque ninguna lo requería

El inventario de referencias se levantó **antes** de mover nada. Ninguna
referencia a `Motor SIMCE.html` es funcional:

- Las menciones en `app.jsx`, `charts.jsx`, `data.js`, `main.jsx`, `styles.css`
  y `table.jsx` son cabeceras de título del prototipo ("Motor SIMCE — gráficos
  D3"), no rutas de archivo.
- Nada enlaza *hacia* el HTML. El HTML sí enlaza a sus hermanos
  (`colors_and_type.css`, `styles.css`, `data.js`, los `.jsx`), y esas
  referencias salen del archivo, no entran: el renombrado no las afecta.
- `git grep -n "Motor%20SIMCE"` → sin coincidencias.

El resto de menciones vive en registros históricos fechados —traspasos v13, v19,
v20, v21, v22— y en snapshots del escáner. Los primeros son el registro canónico
del proyecto y no se tocan; los segundos se regeneran.

Verificación posterior: `git ls-files | grep " "` → **0 archivos versionados con
espacio en el nombre**.

---

## 3. Los tres scripts de verificación no se movieron

`git mv` falló en los tres con `fatal: not under version control` (exit 128).
No están versionados: los ignora `.gitignore` línea 28, cuya propia glosa dice

```
# Scripts de verificación/diagnóstico efímeros (no versionables; traspaso v20)
/verificar_*.R
```

`git check-ignore -v` lo confirma para los tres.

Moverlos habría exigido `mv` a secas, prohibido por el encargo. Y hay una razón
de fondo: **el patrón está anclado a la raíz** (`/verificar_*.R`). Un archivo
movido a `10_utils/` dejaría de coincidir y pasaría a ser versionable, lo que
convertiría en versionados unos scripts que una decisión documentada del
proyecto (traspaso v20) declaró efímeros y no versionables.

Eso es un cambio de política de versionado, no una ordenación de carpetas.
**Queda como decisión del titular.** Si se decide moverlos, hay que decidir a la
vez qué pasa con su condición de ignorados: mantenerla con un patrón nuevo, o
levantarla y versionarlos.

Ninguno de los tres es invocado por `00_build.R` ni por script alguno de
`30_procesamiento/`: `grep -rn "verificar_depe4\|verificar_elem_insuf" --include="*.R"`
sobre todo el repositorio no devuelve ni una coincidencia. Siguen siendo
verificaciones puntuales, y su permanencia en la raíz no rompe nada.

---

## 4. Traspasos acumulados: dato de contexto, no decisión

Hay **27** traspasos en `50_documentacion/traspasos/`
(`ls 50_documentacion/traspasos/ | wc -l`).

Se registra como insumo para una eventual política de archivado. **Este encargo
no la decide y no tocó ningún traspaso**: son el registro canónico del proyecto.
Cualquier archivado, renumeración o poda es decisión del titular.

---

## 5. Alcance de esta constancia

Lo que esta ordenación **no** hizo, por no estar autorizado:

- No reorganizó `20_insumos/`, `40_salidas/` ni `docs/index.html`.
- No editó la lógica de ningún script.
- No editó `backlog_acumulativo.md`, que es append-only.
- No borró nada.
