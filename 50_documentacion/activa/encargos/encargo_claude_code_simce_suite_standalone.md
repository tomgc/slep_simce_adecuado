# Encargo autónomo — slep_simce_adecuado: backlog s21 + suite standalone offline

> Patrón: `encargo_autonomo_claude_code_v1.md` (dirigido por meta). Redactor:
> Claude analista. Ejecutor: Claude Code en modo autónomo.

---

## 1. Contrato

- **Modo:** autónomo, secuencial, ejecuta todo en este turno. Dos fases (A backlog,
  B suite); B depende de A solo en orden, no en datos.
- **Stack:** R-only. Rutas absolutas siempre. No asumir `cd`; el `documentar.R` usa
  `here::i_am()`, así que todo `Rscript` que lo invoque DEBE anteponer
  `setwd("/Users/tomgc/Projects/slep_simce_adecuado")`.
- **Reglas heredadas (no se re-explican):** `POLITICA_PROYECTO.md` (autonomía 0.3,
  commits atómicos §3, gobernanza §6), `DISCIPLINA_OPERATIVA.md` (R1-R9),
  `SETTINGS_Y_PROMPTS_OPERACIONALES.md` §4.6 (suitedoc).
- **Regla de detención (PARA y reporta):** (a) un 🔒 que te obligue a violar el
  contrato de datos/gobernanza; (b) un dato real que contradiga un supuesto de este
  encargo (p. ej. el backlog vivo NO está en 1–109, o `documentar.R` en disco NO es
  el real de ~46.9K sino el stub de ~2.6K); (c) un icono de la cfg que no exista en
  lucide-static y para el que no haya sustituto obvio.

---

## 2. Contexto mínimo

- **Proyecto:** `slep_simce_adecuado`, raíz `/Users/tomgc/Projects/slep_simce_adecuado`.
  Motor SIMCE %Adecuado (React 18 + D3 v7 inline), Rama A pública, GitHub Pages
  (`docs/index.html`). Estado a v21: estable y desplegado; sin bugs.
- **Paquete de documentación:** `suitedoc`, repo
  `/Users/tomgc/Projects/herramientas_dev/suitedoc`, HEAD `c8b3bd7` (saneado en s17,
  con `inlinar_suite()` y `generar_suite(standalone=TRUE)` para salida offline).
  Si no está instalado o no es ese HEAD: `devtools::install("/Users/tomgc/Projects/herramientas_dev/suitedoc")`.
- **Suite actual:** `50_documentacion/suite/` con `documentar.R` (real ~46.9K, en
  HEAD `e14048f`), 4 HTML **enlazados** (no standalone), `suite_estilos.css`, tema
  `fonts/` + `assets/` (ignorados). El `documentar.R` se redactó en s19 por
  reverse-engineering del proyecto hermano y NO incorpora las decisiones de s20-s21.
- **Backlog vivo:** `50_documentacion/activa/backlog_historico.md`, en **1–109 / 20
  sesiones** (cierre de v21 dejó el delta s21 pendiente de anexar).

### Fuentes de contenido para la cfg (provistas, autoritativas)

Las 6 decisiones formales (en `50_documentacion/activa/decisiones/`) y la gobernanza
son la **única** fuente de `cfg$decisiones` y `cfg$gobernanza`. NO inventes
metodología (4.6.3.3 / B.1). Lee de disco:

- `20260611_decision_color_por_nivel.md` — color fijo por nivel de logro.
- `20260611_decision_licencia_apache.md` — Apache 2.0 (desviación de §10).
- `20260611_decision_nombres_establecimientos.md` — D-nombres: §6.4 aplica a
  microdatos por estudiante, no a bases por EE; se conservan nombres.
- `20260611_decision_repo_publico.md` — repo público (Pages Free lo exige).
- `20260620_decision_celda_unico_establecimiento.md` — D20-1: no suprimir por `n_estab`.
- `20260622_decision_cumplimiento_ley_21719.md` — D21-1: de-versionado del directorio
  crudo (MRUN), residual de historial aceptado.
- `50_documentacion/activa/gobernanza_datos.md` — categoría de datos por insumo y
  producto, base de licitud, retención, residual de historial §8.

---

## 3. Invariantes (🔒)

1. 🔒 **No tocar el motor ni el pipeline.** Este encargo es backlog + documentación.
   Cero cambios en `30_procesamiento/`, `docs/`, `40_salidas/`, parquet, motor.
2. 🔒 **No re-versionar `directorio_oficial_ee.csv`** ni ningún derivado con `MRUN`,
   `RUT_SOSTENEDOR` de persona natural o geo de personas (D21-1). El diccionario de
   datos de la cfg, al describir ese insumo, debe reflejar que se descarga de MINEDUC
   y NO se versiona — nunca sugerir versionarlo.
3. 🔒 **Color por nivel intocable** en cualquier texto de la cfg: `COLOR_ADEC #0C4682`,
   `COLOR_ELEM #6BA0CE`, `COLOR_INSUF #79204F`. La cfg los documenta, no los cambia.
4. 🔒 **`verificar = FALSE` permanece** en la llamada a `generar_suite()`. El ejemplo
   de fábrica de suitedoc es un proyecto SIMCE; el verificador marcaría términos
   legítimos del dominio como residuo. NO revertir a TRUE.
5. 🔒 **Numeración global del backlog permanente.** No reescribir, renumerar ni
   resumir entradas 1–109. El delta s21 se ANEXA como 110–113.
6. 🔒 **Gobernanza prevalece:** ningún nombre real de EE/estudiante/funcionario entra
   a la cfg (la suite general se publica). Universos en abstracto (§4.6.3.2).

---

## 4. Fases

### FASE A — Anexar el delta de la sesión 21 al backlog (entradas 110–113)

**Paso 0 (leer estado real).** Lee `50_documentacion/activa/backlog_historico.md`
completo. Confirma que está en **1–109 / 20 sesiones**. Si NO lo está (p. ej. ya
tiene 110–113, o está en otro punto), PARA y reporta (regla de detención b).

**Implementación.** Anexa las 4 entradas de s21 al detalle cronológico, continuando
la numeración, usando ancla-a-texto (NO regex de colapso de saltos — bug conocido de
v20). Contenido exacto (del §5 del traspaso v21):

- **110. [DOC]** Anexo del delta de la sesión 20 al backlog (entradas 106–109) y
  actualización de cobertura a 1–20. Commit `0e9d275`.
- **111. [Gobernanza/Auditoría]** Auditoría Ley 21.719: producto publicado verificado
  limpio por dos caminos (trazado de código + panel adversarial: 0 RUT, 0 email, 0
  coordenadas en claves y valores del JSON); hallazgo `MRUN` poblado en 946 filas
  (⟺ `P_JURIDICA==0`, sostenedores persona natural, dato personal) en el insumo
  versionado `directorio_oficial_ee.csv`. Sin cambios de código. Gate activado.
- **112. [REPO/Gobernanza]** Mitigación: de-versionado de `directorio_oficial_ee.csv`
  going-forward (`git rm --cached` + `.gitignore` + README de máquina nueva); residual
  de historial (recuperable hasta `61c3b9b`) aceptado como riesgo documentado
  (D21-1). Commit `1edc787`.
- **113. [DOC/Gobernanza]** `gobernanza_datos.md` (primer archivo de gobernanza del
  proyecto, obligatorio por política §10 al identificarse dato personal en insumo) +
  `20260622_decision_cumplimiento_ley_21719.md`. Commit `1edc787`.

**Actualizaciones de cabecera del backlog:**
- Encabezado de versión → consolidado a v21, total 113, cobertura 1–21.
- Resumen estadístico por sesión: agrega fila **s21 | v21 | 4 | 110–113** y actualiza
  el total a 113 / 1–113.
- Clasificación temática: incorpora las 4 entradas según la taxonomía vigente del
  proyecto (respeta D20-3: los tags compuestos 57+ se conservan; la tabla de
  clasificación usa las categorías oficiales del backlog). Si la suma de la tabla no
  cuadra con 113, NO reasignes entradas históricas a ciegas (igual criterio que la
  deuda de integridad de idps); declara el descuadre en la línea de delta y sigue.
- Agrega un bloque **"Delta del backlog (consolidación v21)"** al final: +4 entradas
  (110–113), categorías afectadas, y la nota de que cierra la deuda de cierre de s21.

**Verificación (B.4):** `diff` de las entradas 1–109 idéntico antes/después (solo
adiciones). Backlog en 1–113 / 21 sesiones. Última entrada = 113.

**Commit atómico:** `docs(backlog): anexar delta s21 (entradas 110-113), consolidar a v21/113`.

---

### FASE B — Actualizar la cfg y regenerar la suite como standalone offline

**Paso 0 (leer estado real, CRÍTICO).** Antes de tocar nada:
1. Verifica que `50_documentacion/suite/documentar.R` en disco es el REAL (~46.9K),
   no el stub de fábrica (~2.6K). Compara contra HEAD: `git -C <raiz> show HEAD:50_documentacion/suite/documentar.R | wc -c`. Si el de disco es el stub, restáuralo
   con `git restore` ANTES de seguir (incidente conocido de s21). Si ni HEAD tiene el
   real, PARA y reporta (regla b).
2. Lee el `documentar.R` real completo. Identifica los bloques de la cfg que vas a
   tocar: `cfg$decisiones`, `cfg$gobernanza`, y el diccionario de insumos
   (`dic_crudos` o equivalente) donde se describe `directorio_oficial_ee.csv`.
3. Lee las 7 fuentes de contenido del §2 de este encargo.
4. Confirma que el paquete `suitedoc` instalado expone `generar_suite(standalone=)` e
   `inlinar_suite()` (HEAD `c8b3bd7`). Si no, instálalo desde el repo local.

**Implementación — actualización de la cfg (merge de bloques, no reescritura total).**

1. **`cfg$decisiones`:** sincroniza con las 6 decisiones reales. Cada una con `id`,
   `titulo`, `cuerpo`, `por_que` extraídos del archivo de decisión correspondiente.
   Las que el `documentar.R` de s19 no contenía (celda único establecimiento /D20-1,
   cumplimiento Ley 21.719 /D21-1, y verifica licencia Apache y repo público si
   faltan) se AGREGAN. Las existentes (color por nivel, D-nombres) se cotejan contra
   su archivo y se corrigen si difieren. NO inventes el `por_que`: sale del archivo.
2. **`cfg$gobernanza`:** poblar/actualizar desde `gobernanza_datos.md`. Categoría de
   datos (institucionales en producto; el insumo directorio contenía dato personal
   MRUN, ya de-versionado), base de licitud, qué se publica, retención, y el residual
   de historial (§8 de gobernanza_datos.md). Marco: Ley 21.719 (minimización),
   D-nombres para la legitimidad de exhibir EE por nombre desde bases públicas por
   establecimiento.
3. **Diccionario de insumos:** la entrada de `directorio_oficial_ee.csv` debe indicar
   que es insumo externo descargable de MINEDUC, NO versionado (D21-1), del que el
   pipeline usa solo columnas institucionales (nunca MRUN/RUT natural/geo).
4. **Terminología SLEP (§4.6.3.6):** "establecimiento educacional" completo en primera
   mención de cada párrafo, "establecimiento(s)" en repeticiones; nunca "EE" en texto
   visible (sí en notación técnica `n_EE`); nunca "colegio" como genérico. Si el
   `documentar.R` de s19 tiene usos de "colegio", corrígelos (barrido como en idps s17).
5. **Iconos (A17-2 / R3):** valida TODOS los `ico=`/`icon=` de la cfg contra los
   nombres reales de `lucide-static@1.21.0` (los `.svg` de `package/icons/` en el
   paquete instalado). Cualquiera inexistente (recuerda `sitemap`→`network` en idps):
   sustitúyelo por el equivalente lucide más cercano y regístralo en el log. Si no hay
   equivalente obvio, PARA y reporta (regla c).
6. **`verificar = FALSE`** permanece (🔒 #4).

**Regeneración standalone offline.**
```r
# Desde la raíz (here::i_am exige setwd a la raíz):
Rscript -e 'setwd("/Users/tomgc/Projects/slep_simce_adecuado"); source("/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/documentar.R")'
# documentar.R debe llamar generar_suite(cfg, DESTINO, standalone = TRUE, verificar = FALSE)
# standalone=TRUE limpia los enlazados intermedios y deja solo los 4 *_standalone.html
```
Resultado esperado: 4 `*_standalone.html` en `50_documentacion/suite/`, 100% offline
(CSS/fuentes/logos en base64, iconos lucide como `<svg>` embebido, 0 referencias de
red). Los enlazados previos quedan limpiados por `limpiar_enlazados=TRUE`.

**Verificación empírica sobre los standalone reales (no sobre supuestos):**
- `grep` de referencias de red en los 4 HTML = 0 (`http://`, `https://`, `src=` a CDN,
  `<link rel="stylesheet" href="http`). Reporta el conteo real.
- Iconos embebidos como `<svg>` (no `<i data-lucide>` ni `<script>` de lucide).
- Fuentes como `data:` URIs.
- Terminología: 0 usos de "colegio" como genérico y 0 de "EE" en texto visible.
- Las 6 decisiones presentes en el HTML de documentación; la gobernanza 21.719
  presente.

**Versionado (D19-3, igual que la suite actual):** versiona `documentar.R` + los 4
`*_standalone.html` + `suite_estilos.css`. `fonts/` y `assets/` permanecen ignorados.
Revisa `git status` antes de `git add`; nunca `git add .`. Confirma con `git ls-files`
(no con el escáner, A20) que el tema NO entra y el CSV de-versionado sigue fuera.

**Commit atómico:** `docs(suite): actualizar cfg (decisiones s20-s21 + gobernanza 21.719) y regenerar standalone offline`.

---

## 5. Criterios de éxito (verificables, por fase)

**Fase A:** entradas 1–109 byte-idénticas (diff limpio); backlog en 1–113 / 21
sesiones; última entrada = 113; bloque delta v21 presente.

**Fase B:** `documentar.R` confirmado real antes de editar (no stub); 4
`*_standalone.html` con 0 referencias de red (conteo grep reportado); 6 decisiones y
gobernanza 21.719 presentes en los HTML; terminología SLEP correcta (0 "colegio"
genérico, 0 "EE" visible); iconos validados contra lucide 1.21.0; tema NO versionado
(`git ls-files`); 2 commits atómicos pusheados.

---

## 6. Auto-auditoría antes de reportar

Tras Fase B, lanza un chequeo independiente (no confíes en los checks inline que
escribiste): re-deriva con `grep`/lectura propia sobre los 4 HTML finales que (a) no
hay red, (b) las 6 decisiones están, (c) la gobernanza 21.719 está, (d) `documentar.R`
versionado == el de disco editado (no el stub). Si algo falla, corrige y re-verifica
antes de reportar "listo".

---

## 7. Log y reporte

- Escribe el log en `50_documentacion/andamios/logs/YYYYMMDD_suite_standalone_simce_log.md`
  (plantilla fija del patrón v1, honesto: incluye lo que costó). Puede quedar sin
  commitear para revisión, o como `docs()` aparte.
- **Reporte final al chat:** hashes de los 2 commits; resultado del grep de red
  (número exacto); lista de iconos sustituidos si hubo; confirmación de que
  `documentar.R` era el real antes de editar; estado de invariantes 🔒 (PASA/FALLA con
  evidencia); ruta del log; cualquier `# REVISAR (voz)` que persista (no se cierran
  en este encargo, son afinamiento de tono del titular).
