# Encargo autónomo — slep_simce_adecuado: suite standalone offline (solo Fase B)

> Patrón: `encargo_autonomo_claude_code_v1.md`. Redactor: Claude analista.
> Ejecutor: Claude Code autónomo. **Reemplaza** al encargo
> `encargo_claude_code_simce_suite_standalone.md`, cuya Fase A quedó OBSOLETA
> (el backlog ya está en 1–113; anexar 110–113 lo duplicaría). Este encargo es
> SOLO Fase B.

---

## 1. Contrato

- **Modo:** autónomo, secuencial, ejecuta todo en este turno.
- **Stack:** R-only. Rutas absolutas. El `documentar.R` usa `here::i_am()`: todo
  `Rscript` que lo invoque DEBE anteponer
  `setwd("/Users/tomgc/Projects/slep_simce_adecuado")`.
- **Reglas heredadas (no se re-explican):** `POLITICA_PROYECTO.md` (autonomía 0.3,
  commits atómicos §3, gobernanza §6, terminología SLEP), `DISCIPLINA_OPERATIVA.md`
  (R1–R9), `SETTINGS_Y_PROMPTS_OPERACIONALES.md` §4.6 (suitedoc).
- **Regla de detención (PARA y reporta):** (a) un 🔒 que te obligue a violar el
  contrato de datos/gobernanza; (b) un dato real que contradiga un supuesto del
  encargo (p. ej. `documentar.R` en disco es el stub ~2.6K, no el real ~46.9K); (c)
  un icono de la cfg que `inlinar_suite()` no resuelva en lucide-static 1.21.0 y
  sin sustituto obvio; (d) `npm` no disponible para descargar lucide-static (ver §2,
  caveat operativo).

---

## 2. Contexto mínimo

- **Proyecto:** `slep_simce_adecuado`, raíz `/Users/tomgc/Projects/slep_simce_adecuado`.
  Rama A pública, motor desplegado en GitHub Pages. Estable a v21.
- **Paquete:** `suitedoc`, `/Users/tomgc/Projects/herramientas_dev/suitedoc`, HEAD
  `c8b3bd7`. Si el instalado no es ese HEAD:
  `devtools::install("/Users/tomgc/Projects/herramientas_dev/suitedoc")`.
- **API real verificada (no asumir otra):**
  - `generar_suite(cfg, salida_dir=".", copiar_tema=TRUE, verificar=TRUE, standalone=FALSE, verbose=TRUE)`.
  - `standalone=TRUE` hace que `generar_suite` llame internamente a
    `inlinar_suite(salida_dir, limpiar_enlazados=TRUE)`: escribe los 4
    `*_standalone.html` (CSS/fuentes/logos en base64, iconos lucide como `<svg>`
    embebido) y borra los enlazados intermedios. **No** llamar `inlinar_suite()`
    por separado.
  - Versión fijada de iconos: **lucide-static 1.21.0** (`.SD_LUCIDE_VERSION`).
    `inlinar_suite()` valida todos los `data-lucide` y **aborta sin escribir nada**
    si alguno no existe, listando los faltantes.
- **Caveat operativo (🔴 importante):** `inlinar_suite()` descarga lucide-static vía
  `npm pack lucide-static@1.21.0`. Requiere `npm` en el PATH y red al registro npm
  EN TIEMPO DE GENERACIÓN (la suite resultante sí es 100% offline; generarla no).
  **Paso 0 de este encargo:** verifica `npm --version`. Si no hay npm, PARA y reporta
  (regla d): el titular debe instalar npm antes de continuar.
- **Suite actual:** `50_documentacion/suite/documentar.R` es el REAL (~46.9K,
  confirmado idéntico a HEAD `e14048f`), con cfg completa. Llamada actual:
  `generar_suite(cfg, salida_dir=..., copiar_tema=TRUE, verificar=FALSE, verbose=TRUE)`
  — modo enlazado, SIN standalone. Genera 4 HTML enlazados (no offline).

### Fuentes de contenido para la cfg (autoritativas, leer de disco)

- `50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md`
- `…/20260611_decision_licencia_apache.md`
- `…/20260611_decision_nombres_establecimientos.md`
- `…/20260611_decision_repo_publico.md`
- `…/20260620_decision_celda_unico_establecimiento.md`
- `…/20260622_decision_cumplimiento_ley_21719.md`
- `50_documentacion/activa/gobernanza_datos.md`

---

## 3. Invariantes (🔒)

1. 🔒 **No tocar motor ni pipeline.** Cero cambios en `30_procesamiento/`, `docs/`,
   `40_salidas/`, parquet, motor. Solo `documentar.R` + salida de la suite.
2. 🔒 **No re-versionar `directorio_oficial_ee.csv`** ni derivados con `MRUN`,
   `RUT_SOSTENEDOR` de persona natural o geo de personas (D21-1). El diccionario de
   la cfg debe reflejar que ese insumo se descarga de MINEDUC y NO se versiona;
   nunca sugerir versionarlo.
3. 🔒 **Color por nivel intocable** en el texto de la cfg: `COLOR_ADEC #0C4682`,
   `COLOR_ELEM #6BA0CE`, `COLOR_INSUF #79204F`. La cfg los documenta, no los cambia.
4. 🔒 **`verificar = FALSE` permanece** en `generar_suite()`. NO revertir a TRUE.
5. 🔒 **Gobernanza prevalece:** ningún nombre real de establecimiento educacional,
   estudiante o funcionario entra a la cfg (la suite general se publica). Universos
   en abstracto.
6. 🔒 **No tocar el backlog.** Está en 1–113 y es correcto. Este encargo NO lo
   modifica (la Fase A del encargo viejo queda anulada).

---

## 4. Fase única — Actualizar cfg y regenerar standalone offline

**Paso 0 (precondiciones, CRÍTICO):**
1. `npm --version`. Si falla, PARA (regla d).
2. `git -C <raiz> show HEAD:50_documentacion/suite/documentar.R | wc -c` y compara con
   el de disco: confirma que el de disco es el real (~46.9K), no el stub. Si es stub,
   `git restore` antes de seguir; si ni HEAD lo tiene, PARA (regla b).
3. Confirma `suitedoc` en HEAD `c8b3bd7` con `generar_suite(standalone=)` disponible;
   si no, instálalo desde el repo local.
4. Lee el `documentar.R` real completo y las 7 fuentes de contenido del §2.

**Implementación — merge de bloques de la cfg (no reescritura total):**

1. **`cfg$gobernanza`:** hoy es la cadena `"Datos públicos de la Agencia de Calidad"`.
   Reemplázala por el contenido real desde `gobernanza_datos.md`: categoría de datos
   (producto = institucionales; el insumo directorio contenía dato personal `MRUN`,
   ya de-versionado D21-1), base de licitud (datos públicos de fuente oficial),
   qué se publica, retención, y el residual de historial (§8 de gobernanza_datos.md).
   Si el motor de suitedoc espera `cfg$gobernanza` como string y quieres estructura
   más rica, respeta el tipo que el builder consume (verifícalo en `builders.R`/
   `generar.R` antes de cambiar el tipo; si solo acepta string, redacta un párrafo
   denso, no un `list()`).

2. **`cfg$decisiones`:** hoy tiene 8 entradas temáticas SIN `id` y sin citar archivo
   (salvo D-nombres). Sincroniza con las 6 decisiones formales:
   - Cada decisión formal con su `id` real (D-nombres, color por nivel, Apache, repo
     público, D20-1 celda único, D21-1 Ley 21.719), `titulo`, `cuerpo`, `por_que`
     extraídos del archivo de decisión (NO inventar el `por_que`; sale del archivo).
   - Las que faltan en el documentar.R de s19 (D20-1, D21-1, y verifica Apache/repo
     público) se AGREGAN.
   - Las entradas temáticas existentes que ya reflejan una decisión formal (color por
     nivel, D-nombres, GSE inviolable, ponderación) se cotejan y se les añade la
     referencia al archivo; las puramente metodológicas sin archivo formal (p. ej.
     "niveles y pruebas nunca se mezclan") se conservan como están.
   - Quita las marcas `# REVISAR (decisión)` de las que queden cotejadas contra su
     archivo.

3. **Diccionario de insumos (`auxiliares` / `dic_crudos`):** la entrada de
   `directorio_oficial_ee.csv` debe indicar que es insumo externo descargable de
   MINEDUC, NO versionado (D21-1), del que el pipeline usa solo columnas
   institucionales (nunca MRUN/RUT natural/geo). Hoy la describe como insumo normal:
   corrígelo.

4. **Terminología SLEP (§4.6.3.6):** "establecimiento educacional" completo en
   primera mención de cada párrafo, "establecimiento(s)" en repeticiones; nunca "EE"
   en texto visible; nunca "colegio" como genérico. Barre el documentar.R y corrige
   usos de "colegio" si los hay.

5. **`verificar = FALSE`** permanece (🔒 #4).

6. **Cambiar la llamada a standalone.** En el bloque final de `documentar.R`,
   `generar_suite(...)` pasa a:
   ```r
   suitedoc::generar_suite(
     cfg,
     salida_dir = here::here("50_documentacion", "suite"),
     copiar_tema = TRUE,
     verificar   = FALSE,
     standalone  = TRUE,
     verbose     = TRUE
   )
   ```

**Regeneración:**
```r
Rscript -e 'setwd("/Users/tomgc/Projects/slep_simce_adecuado"); source("/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/documentar.R")'
```
Resultado esperado: 4 `*_standalone.html` en `50_documentacion/suite/`, enlazados
intermedios borrados por `limpiar_enlazados=TRUE`.

**Verificación empírica (sobre los standalone reales, no supuestos):**
- `grep -c` de red en los 4 HTML = 0: `https://`, `http://`, `src=`/`href=` a CDN,
  `<link rel="stylesheet" href="http`. Reporta el conteo real por archivo.
- Iconos como `<svg>` embebido (no `<i data-lucide>` ni `<script>` de lucide).
- Fuentes como `data:` URIs.
- 0 usos de "colegio" genérico y 0 de "EE" en texto visible (`grep`).
- Las 6 decisiones presentes en el HTML de documentación; gobernanza Ley 21.719
  presente.

**Versionado:** `git status` antes de `git add`; nunca `git add .`. Versiona
`documentar.R` + los 4 `*_standalone.html` + `suite_estilos.css`. `fonts/` y
`assets/` permanecen ignorados. Confirma con `git ls-files` (no con el escáner, A20)
que el tema NO entra y que el CSV de-versionado sigue fuera.

**Commit atómico:** `docs(suite): actualizar cfg (decisiones s20-s21 + gobernanza 21.719) y regenerar standalone offline`.
NO hagas push hasta mi visto bueno (gate de revisión del contenido normativo de la
cfg).

---

## 5. Criterios de éxito (verificables)

- `documentar.R` confirmado real antes de editar (no stub).
- `npm` disponible; lucide-static 1.21.0 resuelto sin iconos faltantes.
- 4 `*_standalone.html` con 0 referencias de red (conteo grep reportado por archivo).
- 6 decisiones formales (con `id` y `por_que` del archivo) + gobernanza Ley 21.719
  presentes en los HTML.
- Terminología SLEP correcta (0 "colegio" genérico, 0 "EE" visible).
- Diccionario: `directorio_oficial_ee.csv` marcado como no versionado (MINEDUC).
- Tema NO versionado (`git ls-files`); CSV de-versionado sigue fuera.
- 1 commit atómico, local, SIN push.

---

## 6. Auto-auditoría antes de reportar

Tras generar, re-deriva con `grep`/lectura propia sobre los 4 HTML finales (no confíes
en checks inline): (a) 0 red, (b) las 6 decisiones están, (c) gobernanza 21.719 está,
(d) el `documentar.R` versionado == el de disco editado (no el stub). Si algo falla,
corrige y re-verifica antes de reportar "listo" (R1).

---

## 7. Log y reporte

- Log en `50_documentacion/andamios/logs/20260622_suite_standalone_simce_log.md`
  (plantilla fija, honesto). SIN commitear (revisión del titular).
- **Reporte al chat:** hash del commit (local, sin push); grep de red por archivo
  (número exacto); iconos sustituidos si hubo; confirmación de que documentar.R era
  el real antes de editar; estado de invariantes 🔒 (PASA/FALLA con evidencia); las
  marcas `# REVISAR (voz)` que persistan (no se cierran aquí); ruta del log.
