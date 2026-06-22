# Decisión — Cumplimiento Ley 21.719: de-versionado del directorio crudo

- **Fecha:** 2026-06-22
- **Sesión:** 21 (auditoría de cumplimiento Ley 21.719)
- **Estado:** adoptada (mitigación going-forward); **residual de historial pendiente** (ver §6)
- **Relacionada con:** `decisiones/20260611_decision_nombres_establecimientos.md`
  (D-nombres), `decisiones/…repo_publico…`, `50_documentacion/activa/gobernanza_datos.md`

---

## 1. Contexto y problema

El repositorio es **público** (GitHub Pages Free exige visibilidad pública; ver
decisión repo_publico, principio "nada se versiona si no es publicable"). La
Ley 21.719 (vigente dic-2026) define dato personal como cualquier dato de persona
natural identificada o identificable; el RUN de persona natural es dato personal.

Una auditoría columna por columna del insumo `directorio_oficial_ee.csv`
(versionado) detectó un dato personal que el proyecto **no usa** pero **sí
versionaba**.

## 2. Hallazgo de auditoría (hechos verificados)

Directorio: 16.768 filas × 58 columnas. Conteos reales (R):

- **MRUN poblado en 946 filas**, que corresponden **exactamente** a los
  sostenedores **persona natural** (`P_JURIDICA == 0`; 946 = 946, correlación
  perfecta). MRUN es el RUN enmascarado (numérico, 5–8 dígitos) de una persona
  natural identificable → **dato personal** Ley 21.719.
- **RUT_SOSTENEDOR poblado en 14.819 filas, todas `P_JURIDICA == 1` (persona
  jurídica)**; sostenedores persona natural con RUT poblado = **0**. RUT de
  persona jurídica **no** es dato personal → sin riesgo.
- **LATITUD/LONGITUD** (13.501): geo del **local** del establecimiento, no de una
  persona → no personal.
- Los otros dos insumos versionados (`caracterizacion_establecimientos.xlsx`,
  `listado_slep_2026.xlsx`): solo datos institucionales, sin dato personal.

**Producto publicado (`docs/index.html`): limpio.** El JSON embebido (13,6 MB
descomprimido) lleva por establecimiento educacional solo
`{rbd, nom_rbd, cod_com_rbd, nom_com_rbd, cod_depe2}`; ninguna columna personal
(MRUN/RUT/geo) cruza al producto. Confirmado por **dos caminos independientes**
(trazado de código + decode propio; y panel adversarial con código propio que
escaneó claves y valores: 0 RUT, 0 email, 0 coordenadas). El pipeline nunca
selecciona MRUN/RUT/geo (`transmute` explícito en `30_construir_auxiliares.R` y
`33_generar_html.R`).

**Conclusión del riesgo:** la única exposición de dato personal es el **MRUN en el
insumo crudo versionado** — no en el producto. El proyecto versiona PII que no
utiliza (falla de minimización), en un repo público.

## 3. Decisión adoptada

**De-versionar el `directorio_oficial_ee.csv` crudo** going-forward:

- `git rm --cached 20_insumos/auxiliares/directorio_oficial_ee.csv` (se conserva en
  disco; el pipeline lo sigue leyendo localmente).
- Regla en `.gitignore` para que no se vuelva a versionar.

El directorio es **regenerable 1×/año desde MINEDUC** (descarga pública), de modo
que el costo de reproducibilidad es bajo: un clon nuevo debe descargar el
directorio antes de correr el pipeline (documentado en `gobernanza_datos.md`).

## 4. Alternativas consideradas

- **Versionar una versión filtrada** (solo las 9 columnas no personales que el
  pipeline usa). Preserva reproducibilidad offline y elimina la PII. Se **descartó
  frente al de-versionado** por simplicidad y porque introduce un artefacto derivado
  que habría que regenerar y mantener sincronizado con MINEDUC; el de-versionado es
  más simple y el insumo es regenerable. *(Sigue disponible si en el futuro se
  prioriza la reproducibilidad offline.)*
- **Mantener el CSV** alegando dato público de fuente oficial y MRUN anonimizado.
  Descartada: contradice el principio repo_publico y la minimización; se versionaba
  PII no utilizada.

## 5. Justificación

- Minimización (Ley 21.719): no tratar/publicar datos personales innecesarios. El
  proyecto no usa MRUN → no hay razón para versionarlo.
- Coherencia con repo_publico: "nada se versiona si no es publicable"; un RUN
  enmascarado de persona natural no es publicable por el proyecto.
- Costo bajo: insumo regenerable desde la fuente oficial.

## 6. Residual del historial — decisión

🔴 **El `git rm --cached` NO purga el historial.** El CSV (con los 946 MRUN) fue
agregado en el commit `61c3b9b` y permanece **recuperable** desde el historial del
repo público (`git show 61c3b9b:20_insumos/auxiliares/directorio_oficial_ee.csv`).
La remoción going-forward corta la exposición en el *tip* tras el push, pero no en
la historia.

**Decisión: Opción 1 — aceptar la exposición histórica como riesgo residual** y
de-versionar going-forward (commit + push). Fundamento: es un dato de **rol
público** (sostenedor), de **descarga pública en MINEDUC**, no originado por el
proyecto; reescribir el historial de un repo **público con Pages activo** es
desproporcionado frente al riesgo. **Revisable** si cambia la naturaleza del dato.
Detalle en `gobernanza_datos.md` §8.1.

**Opción 2 descartada — reescribir el historial** (`git filter-repo`/BFG +
`git push --force`): remoción completa pero **destructiva** (reescribe todos los
hashes, afecta clones/forks y el despliegue Pages, requiere aprobación individual).
Se descartó por desproporción: el costo y el riesgo operativo superan al beneficio
de ocultar un dato que la fuente oficial ya publica abiertamente. Queda como vía de
escalamiento si el residual dejara de ser aceptable.
