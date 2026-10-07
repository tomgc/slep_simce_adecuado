# Log de cierre — Suite standalone offline (Fase B, cfg s20-s21 + Ley 21.719)

- **Fecha:** 2026-06-22
- **Proyecto:** slep_simce_adecuado
- **Encargo:** `encargo_suite_standalone_faseB.md` (solo Fase B; la Fase A del
  encargo viejo quedó obsoleta — el backlog ya estaba en 1–113).
- **Modelo:** Claude Opus 4.8
- **Estado:** completado. 1 commit local, **sin push** (gate de revisión del titular
  sobre el contenido normativo de la cfg).

---

## 1. Resumen

Se actualizó la `cfg` de `documentar.R` (gobernanza Ley 21.719 + 6 decisiones
formales + diccionario del directorio como no versionado) y se regeneró la suite
en modo **standalone offline** (`generar_suite(standalone=TRUE)`). Resultado: 4
`*_standalone.html` 100% offline (CSS/fuentes/logos en base64, iconos lucide como
`<svg>` embebido, **0 recursos de red**), reemplazando los 4 HTML enlazados.

---

## 2. Inventario de commits
| Hash | Mensaje | Archivos |
|------|---------|----------|
| `6f94729` (local, sin push) | `docs(suite): actualizar cfg (decisiones s20-s21 + gobernanza 21.719) y regenerar standalone offline` | `documentar.R` (M) + 4 `*_standalone.html` (A) + borrado de los 4 enlazados viejos (D). `suite_estilos.css` sin cambio. |

---

## 3. Cambio sustantivo (merge de bloques de la cfg, no reescritura total)

- **`cfg$gobernanza`** (string): de `"Datos públicos de la Agencia de Calidad"` a un
  párrafo denso desde `gobernanza_datos.md` — producto institucional sin dato
  personal (doble vía), base de licitud, MRUN de-versionado (D21-1), residual de
  historial aceptado, retención, marco Ley 21.719 + D-nombres. Se mantuvo el tipo
  `string` (el builder lo consume así).
- **`cfg$decisiones`**: de 8 entradas con `id=''` a 12 con `id` real:
  - 6 metodológicas (ponderación, GSE, niveles/pruebas, %Adecuado, filtros MINEDUC,
    dependencia SLEP) conservadas (sin archivo formal).
  - `id='D-nombres'` y `id='D-color-nivel'` añadidos a las 2 que ya reflejaban
    decisión formal.
  - **4 decisiones formales AGREGADAS** con `id`/`titulo`/`cuerpo`/`por_que`
    extraídos del archivo (no inventado): `D-licencia-apache`, `D-repo-publico`,
    `D-celda-unico-establecimiento` (D20-1), `D-ley-21719` (D21-1).
- **Diccionario de insumos:** la entrada de `directorio_oficial_ee.csv` ahora indica
  **insumo externo, no versionado** (se descarga de MINEDUC, D21-1); el pipeline usa
  solo columnas institucionales (nunca MRUN/RUT natural/geo).
- **Terminología:** 0 "colegio", 0 "EE" visible (ya estaba limpio; verificado).
- **Llamada:** `generar_suite(..., verificar=FALSE, standalone=TRUE, verbose=TRUE)`.

---

## 4. Verificación (empírica, sobre los 4 standalone reales)

| Check | Resultado |
|-------|-----------|
| Paso 0: `npm` disponible | PASA (npm 11.12.1, node v25.9.0) |
| Paso 0: `documentar.R` real (no stub) | PASA (46.909 bytes = HEAD antes de editar) |
| Paso 0: suitedoc HEAD `c8b3bd7` + `standalone` en args | PASA |
| Iconos lucide-static 1.21.0 resueltos (sin abortar) | PASA (`inlinar_suite` no abortó; 0 iconos faltantes) |
| Recursos de red cargados en los 4 HTML | **0** (src/href-a-red=0, link-css=0, script-src=0 por archivo) |
| `data-lucide` sin inlinar | 0 en los 4; iconos como `<svg>` (19/0/5/0 según uso); sin `<script lucide>` |
| Fuentes como `data:` URI | 6 por archivo |
| 6 decisiones formales en el manual del proyecto | PASA (Apache, Repo B3, celda único, Ley 21.719, Color, Nombres) |
| Gobernanza 21.719 en HTML | PASA (MRUN, riesgo residual, minimización, de-versionó) |
| Terminología (0 colegio / 0 EE visible) | PASA en los 4 |
| Tema NO versionado (`git ls-files`) | PASA (fonts/assets ignorados; solo css + documentar.R + 4 standalone) |
| CSV de-versionado sigue fuera del índice | PASA |

---

## 5. Estado de invariantes (🔒)
| 🔒 | Resultado | Evidencia |
|----|-----------|-----------|
| 1. No tocar motor/pipeline | PASA | Solo `documentar.R` + salida de la suite; cero cambios en 30_/docs/40_/parquet/motor. |
| 2. No re-versionar CSV directorio | PASA | CSV fuera del índice; la cfg lo describe como no versionado. |
| 3. Color por nivel intocable | PASA | La cfg documenta `#0C4682/#6BA0CE/#79204F`; no los cambia. |
| 4. `verificar = FALSE` permanece | PASA | Se mantuvo FALSE (no se revirtió a TRUE). |
| 5. Gobernanza: cero nombres reales en la cfg | PASA | Universos en abstracto; sin nombres de establecimiento/persona. |
| 6. No tocar backlog | PASA | Backlog intacto (1–113). |

---

## 6. Lo que costó / honestidad
- La regeneración emitió **"50 o más warnings"** (exit 0, no fatales): consistentes
  con el inlining base64 y el aviso de encoding de locale; no afectan la salida (los
  4 HTML se escribieron y validan). No se inspeccionó cada warning uno a uno.
- `inlinar_suite()` **requiere npm + red** (descarga `lucide-static@1.21.0`); funcionó
  en esta máquina. En un entorno sin npm/red habría abortado (regla d) — no fue el
  caso.

---

## 7. Pendientes / notas para el revisor
- **Push pendiente:** el commit `6f94729` es local. Espera tu visto bueno sobre el
  contenido normativo de la cfg antes de pushear.
- **Working tree:** el archivo `encargos/encargo_claude_code_simce_suite_standalone.md`
  quedó **modificado** (se reemplazó su contenido por el saneado faseB; el duplicado
  `encargo_suite_standalone_faseB.md` se eliminó). Es un cambio aparte del commit de
  la suite, sin commitear — decide si lo versionas.
- **`# REVISAR (voz)`** persisten en `documentar.R` (afinamiento de tono del titular,
  fuera del alcance de este encargo).
- Este log queda **sin commitear** para tu revisión.
