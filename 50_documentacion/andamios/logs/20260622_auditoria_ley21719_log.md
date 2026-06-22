# Log de cierre — Auditoría de cumplimiento Ley 21.719

- **Fecha:** 2026-06-22
- **Proyecto:** slep_simce_adecuado
- **Encargo:** auditar datos personales en insumos y producto publicado; documentar
  cumplimiento Ley 21.719. Auditoría + documentación, sin modificar pipeline/motor/insumos.
- **Modelo:** Claude Opus 4.8
- **Estado:** **CERRADO** — cumplimiento ejecutado y pusheado. Producto limpio;
  insumo `directorio_oficial_ee.csv` de-versionado going-forward; exposición
  histórica aceptada como riesgo residual documentado y revisable.

---

## 1. Resumen

Se auditaron los tres insumos versionados y el JSON realmente embebido en el
producto publicado (`docs/index.html`). **El producto publicado está limpio**: no
contiene ningún dato personal de persona natural (confirmado por dos caminos
independientes). **Pero un insumo versionado en el repo público
(`directorio_oficial_ee.csv`) contiene la columna MRUN poblada en 946 filas**, que
son exactamente los sostenedores **persona natural** — RUN enmascarado, dato
personal bajo Ley 21.719. Esto dispara el gate estratégico: se reporta y se espera
decisión del titular antes de cualquier mitigación.

**Corrección de un supuesto del encargo (por la Fase 1 determinista):** el riesgo
real estaba en **MRUN** (946 sostenedores persona natural), **no** en
**RUT_SOSTENEDOR** (14.819, todos persona jurídica → no personal). La hipótesis del
encargo apuntaba al cruce RUT × P_JURIDICA, que resultó **nulo**; el conteo
determinista relocalizó el riesgo a MRUN.

---

## 2. Commits

| Hash | Contenido |
|------|-----------|
| `1edc787` | `chore(gobernanza)` — `git rm --cached` del directorio crudo + `.gitignore` + `gobernanza_datos.md` + decisión 21.719 + README |
| `a1271c7` | `docs(log)` — este log de auditoría |

Push: `ed00cd6..a1271c7` → `origin/main`. La revisión de este log a su estado final
se persiste en un commit `docs()` posterior.

---

## 3. Auditoría de diagnóstico

### 3.1 Fase 1 — clasificación de insumos (conteos reales con R)

**`directorio_oficial_ee.csv`** — TRACKEADO, 16.768 filas × 58 columnas.

| Columna | Clasificación | n poblado | Nota |
|---------|---------------|-----------|------|
| MRUN (col 5) | **PERSONAL** | **946** | RUN enmascarado; pobla ⟺ P_JURIDICA==0 (946=946 exacto); numérico 5–8 díg. → persona natural identificable |
| RUT_SOSTENEDOR (col 6) | No personal | 14.819 | **Todos** P_JURIDICA==1 (persona jurídica). Cruce con persona natural = **0** |
| P_JURIDICA (col 7) | No personal | 16.768 | Discriminador: 1→jurídica (14.819), 0→natural (946), 9→s/i (1.003) |
| LATITUD/LONGITUD (col 18/19) | No personal | 13.501 | Geo del **local** del establecimiento, no de una persona |
| RBD, NOM_RBD, COD_COM_RBD, … (resto) | No personal | — | Atributos institucionales del establecimiento |

**`caracterizacion_establecimientos.xlsx`** (hoja "Datos oficiales SLEP CC") —
TRACKEADO. Columnas: RBD, DV, Nombre del establecimiento, Niveles de enseñanza,
Comuna, Macrozona, Emplazamiento, Grupo prioritario IVE 2026. **Todas
institucionales; sin dato personal** (coincide con la confirmación de s13).

**`listado_slep_2026.xlsx`** — TRACKEADO. Columnas: INICIO_FUNCIONES,
AGNO_TRASPASO_EDUC, COD_SLEP, NOMBRE_SLEP, …, COD_COM_RBD, DECRETO, etc. **Todas
institucionales (SLEP/comuna/región); sin dato personal.**

### 3.2 Fase 2 — trazabilidad insumo → producto (dos caminos)

**Camino 1 (trazado de código + decode propio):**
- `30_construir_auxiliares.R` bloque 5: `establecimientos_chile.parquet` se arma con
  `transmute(rbd, nom_rbd, cod_com_rbd, nom_com_rbd, cod_depe2)` — `transmute`
  descarta MRUN/RUT/geo/P_JURIDICA.
- `31_leer_normalizar.R`: del directorio solo usa el mapa RBD→cod_com_rbd (A3) y
  RBD→cod_depe2; no arrastra MRUN/RUT.
- `33_generar_html.R`: `establecimientos_lst = select(rbd, nom_rbd, cod_com_rbd,
  nom_com_rbd, cod_depe2)`; `simce_rbd_lst` sin MRUN/RUT.
- Decode del blob zlib+base64 de `docs/index.html` (13,6 MB JSON): claves por
  establecimiento = `{rbd, nom_rbd, cod_com_rbd, nom_com_rbd, cod_depe2}`; escaneo
  de claves personales en todo el JSON = **ninguna**.

**Camino 2 (panel adversarial, agente independiente, sin ver el código):**
- Re-derivó el JSON desde el HTML con su propio código; mismas claves por
  establecimiento; escaneó claves **y valores** (patrones RUT/email/celular/coord):
  0 aciertos. **Veredicto: sin dato personal en el producto.**

**Ambos caminos coinciden.** Set de columnas del producto confirmado por dos vías
independientes.

### 3.3 Tabla de hallazgos por severidad

| # | Hallazgo | Severidad | ¿Toca el producto? | ¿Insumo versionado? |
|---|----------|-----------|--------------------|---------------------|
| H1 | MRUN poblado (946 filas, sostenedores persona natural) en `directorio_oficial_ee.csv` | **ALTA (gate)** | **No** (no cruza al JSON) | **Sí** (repo público) |
| H2 | RUT_SOSTENEDOR (14.819) — todos persona jurídica | Nula | No | Sí, pero no personal |
| H3 | LATITUD/LONGITUD del local (13.501) | Nula | No | Sí, pero no personal (geo institucional) |
| H4 | Discrepancia de compresión: el código (33) usa gzip; `docs/index.html` trae zlib | Informativa | n/a | build previo; sin efecto en datos |

---

## 4. Verificación de invariantes (🔒)

| 🔒 | Resultado | Evidencia |
|----|-----------|-----------|
| No modificar pipeline/motor/suite/insumos | **PASA** | Solo lecturas (`read.csv2`, `read_excel`, decode de HTML); cero escrituras en código/insumos/datos. |
| No ejecutar mitigación sin aprobación | **PASA** | No se de-versionó nada, no se filtró ninguna columna, no se tocó `.gitignore`. Gate respetado. |
| Decisiones previas (D-nombres, repo_publico) no se reabren | **PASA** | `nom_rbd` se trata como público/institucional según D-nombres; no se cuestiona. |
| md5 de parquets e insumos intacto | **PASA** | Ningún archivo de datos fue escrito. El único artefacto temporal (`/tmp/blob_audit.b64`) está fuera del repo. |

---

## 5. Decisiones del titular en el gate
El titular resolvió el gate con dos decisiones:

1. **Mitigación:** de-versionar el `directorio_oficial_ee.csv` crudo going-forward
   (`git rm --cached` + `.gitignore`; el archivo permanece en disco, regenerable
   desde MINEDUC). Se descartaron "versionar una versión filtrada" y "mantener el
   CSV".
2. **Historial:** **Opción 1 — aceptar la exposición histórica como riesgo residual
   documentado** (dato de rol público, descargable de MINEDUC, desproporción de
   reescribir el historial de un repo público con Pages activo). La Opción 2
   (reescritura `git filter-repo`/BFG + `push --force`) se descartó por
   desproporción; queda como vía de escalamiento si el residual dejara de ser
   aceptable.

Detalle en `decisiones/20260622_decision_cumplimiento_ley_21719.md` §6 y
`gobernanza_datos.md` §8.1.

---

## 6. Pendientes
- **Resuelto:** mitigación decidida y ejecutada; Fase 3 (`gobernanza_datos.md` +
  decisión 21.719 + README) redactada, commiteada (`1edc787`) y pusheada.
- **Residual aceptado:** el CSV permanece en el historial público (commit `61c3b9b`);
  decisión revisable si cambia la naturaleza del dato.
- (Opcional) Alinear la compresión de un futuro redeploy (gzip vs zlib, H4).

---

## 7. Notas para el revisor — opciones de mitigación de H1

> **Elegida: Opción 1** (de-versionar el CSV crudo). Las tres opciones se conservan
> como registro de la deliberación del gate.

1. **De-versionar el CSV crudo** y gitignorarlo. El directorio es regenerable desde
   MINEDUC 1×/año → bajo costo de reproducibilidad (sugerido por el encargo). Costo:
   un clon nuevo no puede correr el pipeline sin descargar el directorio.
2. **Versionar una versión filtrada** del directorio con solo las columnas que el
   pipeline usa (RBD, NOM_RBD, COD_COM_RBD, NOM_COM_RBD, COD_REG_RBD, NOM_REG_RBD_A,
   COD_DEPE2, MATRICULA, ESTADO_ESTAB — todas no personales), reemplazando el CSV de
   58 columnas. Preserva reproducibilidad y elimina MRUN/RUT/geo. **Opción más
   equilibrada.**
3. **Mantener el CSV** alegando que es dato ya público de fuente oficial y MRUN está
   anonimizado. Riesgo: contradice el principio de `repo_publico` ("nada se versiona
   si no es publicable") y el de minimización (se versiona PII que el proyecto no
   usa). No recomendada.

> Nota: el producto publicado NO está comprometido. La exposición está acotada al
> insumo crudo versionado, y MINEDUC ya publica ese directorio; aun así, la
> minimización (no versionar PII que el pipeline no usa) favorece la opción 2.
