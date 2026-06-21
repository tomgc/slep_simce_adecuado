# Log de cierre — Reconstrucción del backlog 61–105 desde los traspasos

- **Fecha:** 2026-06-20
- **Proyecto:** slep_simce_adecuado
- **Encargo:** reconstruir las entradas 61–105 del backlog histórico desde los
  traspasos v14–v19 y anexarlas al archivo vivo
  `50_documentacion/activa/backlog_historico.md`. Sin commit.
- **Modelo:** Claude Opus 4.8

---

## 1. Resumen

El archivo vivo estaba congelado en la entrada 60 / sesión 13. Se reconstruyeron
las **45 entradas faltantes (61–105, sesiones 14–19)** a partir del texto de los
traspasos y se anexaron tras la entrada 60, conservando intacto todo lo previo.
El archivo ahora cubre **1–105 sin huecos ni duplicados, en 19 sesiones**.

**Hallazgo de fuente:** el encargo indicaba leer el **§5** de cada traspaso, pero
en v14–v19 el §5 es solo un **puntero** ("ítems N–M *de arriba*"); las entradas
numeradas con detalle viven en el **§4 (Registro detallado de cambios)**. La
reconstrucción se hizo desde el §4 de cada traspaso (fiel a la intención del
encargo: extraer las entradas reales del traspaso).

**Nivel de detalle:** las fuentes resultaron **detalladas**, en varios casos más
extensas que las entradas 1–56 del backlog. NO se gatilló la detención blanda por
brevedad. Se condensó cada entrada a la densidad del backlog **sin inventar**
(condensar no es inventar); por eso no hay marcas `# REVISAR (detalle)`.

---

## 2. Qué se reconstruyó, por traspaso (y esquema de numeración)

| Traspaso | Sesión | Entradas (global) | Esquema de numeración en el §4 | Detalle de la fuente |
|----------|--------|-------------------|--------------------------------|----------------------|
| v14 | 14 | 61–79 (19) | **Global directa** (el §4 ya numera 61–79) | Detallado, con tags `[UI]`/`[Pipeline]`/`[Frontend]`/`[Metodología/UI]`/`[Consistencia/UI]` por entrada |
| v15 | 15 | 80–91 (12) | **Local 1–12** → global = local + 79 (rango declarado en §5) | Detallado; **sin tag de categoría por entrada** (intro de §4: "todos sobre `33_motor_template.html`") |
| v16 | 16 | 92–98 (7) | **Local 1–7** → global = local + 91 | Detallado; **sin tag de categoría por entrada** |
| v17 | 17 | 99–101 (3) | **Local 1–3** → global = local + 98 | Muy detallado, con campo "Categoría:" explícito por entrada |
| v18 | 18 | 102 (1) | **Local 1** → global 102 | Detallado, con "Categoría: operativo/despliegue" |
| v19 | 19 | 103–105 (3) | **Local 1–3** → global = local + 102 | Detallado, con "Categoría:" explícita; §5 además resume 103–105 global |

Total reconstruido: **45 entradas**. 60 + 45 = **105**.

---

## 3. Spot-checks 1:1 (auto-auditoría)

| # | Fuente | Contraste |
|---|--------|-----------|
| **67** (v14, global directa) | v14 §4 ítem 67 `[UI] Default de dependencia… cod 5 → "Todas las dependencias"` | Número 67 ✓ · categoría `[UI]` ✓ · descripción fiel (incl. síntoma Petorca) ✓ |
| **96** (v16, local 5 → global 96) | v16 §4 ítem 5 `Licencia Apache 2.0… LICENSE/NOTICE… commit a8e344e` | Número 96 = 5+91 ✓ · categoría `[REPO]` (inferida, marcada) ✓ · descripción fiel (incl. `a8e344e`) ✓ |
| **102** (v18, local 1 → global 102) | v18 §4 ítem 1 `Deploy: motor con segmentación a Pages… commit 39e56ef` | Número 102 ✓ · categoría `[REPO]` (de "operativo/despliegue") ✓ · descripción fiel (incl. `39e56ef`) ✓ |

Los tres contrastes coinciden 1:1.

---

## 4. Marcas `# REVISAR (categoría)` introducidas (19)

Motivo único: el §4 de v15 y v16 **no asigna categoría por entrada**, así que la
categoría se **infirió del contenido** y se marcó para revisión del titular.

- **Sesión 15 — entradas 80–91 (12 marcas):** inferidas como `[UI]` (motor /
  diseño), salvo 83 `[DOC/UI]` ("SIMCE"→"Simce" en motor y docs) y 91 `[DOC]`
  (documentación actualizada).
- **Sesión 16 — entradas 92–98 (7 marcas):** inferidas como `[REPO]` (92, 96,
  97), `[Infra]` (93), `[D]` (94) y `[DOC]` (95, 98).

Sin marcas en v14/v17/v18/v19 (esas fuentes traen categoría explícita por
entrada). Sin marcas `# REVISAR (detalle)`: ninguna entrada quedó más escueta que
el estándar 1–56 (las fuentes eran detalladas).

> Nota de formato: las marcas se anexan al **final** de cada entrada (mid-línea),
> no a inicio de línea, para no renderizar como encabezado markdown; siguen siendo
> grep-ables por `REVISAR`.

---

## 5. Estado de invariantes (🔒)

| 🔒 | Invariante | Resultado | Evidencia |
|----|-----------|-----------|-----------|
| 1 | Numeración correlativa global permanente (sin renumerar/reiniciar/compactar) | **PASA** | Secuencia 1–105 continua, 105 entradas, 0 duplicados, 0 huecos. Cada entrada conserva el número de su traspaso (global directo en v14; rango global declarado en el §5 para v15–v19). |
| 2 | No modificar las entradas 1–60 | **PASA** | `git diff --stat`: 76 inserciones, 1 borrado. El único borrado es la línea de cabecera de cobertura. `grep "^-[0-9]\."` del diff → vacío (ninguna entrada numerada eliminada). |
| 3 | Fidelidad sobre completitud (sin inventar) | **PASA** | Cada entrada proviene del §4 de su traspaso; spot-checks 1:1; condensación fiel de fuentes detalladas. |
| 4 | Preservar la categoría del traspaso; inferir + marcar si falta | **PASA** | v14/v17/v18/v19: categoría del traspaso. v15/v16: inferida + 19 marcas `# REVISAR (categoría)`. |
| — | Solo se actualizó la cabecera de cobertura | **PASA** | Cobertura "1–13 (v01–v13)" → "1–19 (v01–v19)"; "deltas s11, s12 y s13" → "deltas s11–s19". Regla de mantenimiento no declara tope de sesión: intacta. |
| — | Nada commiteado | **PASA** | Cambio solo en el working tree; sin `git add`/`commit`/`push`. |

---

## 6. Pendientes
- **Revisar las 19 categorías inferidas** (entradas 80–98) y retirar las marcas
  `# REVISAR (categoría)` una vez confirmadas.
- **Persistir el cambio:** el archivo está en el working tree, sin commitear, a la
  espera de revisión del titular.
- Pendiente heredado (no creado aquí), transcrito en la entrada 101: reemplazar la
  copia de `POLITICA_PROYECTO.md` en la knowledge base del Project por la v6.

---

## 7. Notas para el revisor
- **Fuente real = §4, no §5.** El §5 de v14–v19 es un puntero a las entradas "de
  arriba"; el detalle numerado está en el §4. Si la política espera que el §5
  contenga las entradas (como en v13), conviene homogeneizar el formato de los
  traspasos futuros.
- **Numeración local vs global.** v15–v19 numeran localmente en su §4 (1, 2, 3…);
  el número global correcto lo declara el §5 de cada traspaso. El mapeo aplicado:
  v15 +79, v16 +91, v17 +98, v18 +102 (1→102), v19 +102. Verificado contra los
  rangos declarados (80–91, 92–98, 99–101, 102, 103–105).
- **Condensación.** Las entradas de v17–v19 eran notablemente más extensas (con
  "Por qué"/"Cómo se verificó"); se condensaron a la densidad del backlog
  preservando hechos sustantivos (archivos, cifras, hashes de commit). Si se
  prefiere el verbatim completo, puede reexpandirse desde los traspasos.
- **Vocabulario de categorías.** Se conservaron tags descriptivos del traspaso
  (`[Metodología/UI]`, `[Consistencia/UI]`, `[Frontend]`, `[Gobernanza/Auditoría]`)
  aunque excedan la taxonomía oficial P/UI/D/DOC/REPO/Infra/DT, siguiendo el
  precedente de las entradas 57–60. Decisión de normalizarlos: del titular.

---

## Cotejo de categorías 80–98 (2026-06-20, paso posterior)

Retiro de las 19 marcas `# REVISAR (categoría)` y fijación de la categoría final,
tras cotejo contra el §4 verbatim de v15/v16. Sin commit.

| Entrada | Categoría antes | Categoría después | ¿Cambió? |
|---------|-----------------|-------------------|----------|
| 80 | UI | UI | — (solo retiro de marca) |
| 81 | UI | UI | — |
| 82 | UI | UI | — |
| 83 | DOC/UI | **UI/DOC** | **SÍ** (reorden: primaria UI) |
| 84 | UI | UI | — |
| 85 | UI | UI | — |
| 86 | UI | UI | — |
| 87 | UI | UI | — |
| 88 | UI | UI | — |
| 89 | UI | UI | — |
| 90 | UI | UI | — |
| 91 | DOC | DOC | — |
| 92 | REPO | REPO | — |
| 93 | Infra | Infra | — |
| 94 | D | D | — |
| 95 | DOC | DOC | — (ya estaba en el destino) |
| 96 | REPO | REPO | — |
| 97 | REPO | REPO | — (ya inequívoco, sin Infra) |
| 98 | DOC | DOC | — |

**Único cambio real de categoría: la entrada 83** (DOC/UI → UI/DOC).

**Discrepancia con la asunción del encargo (reportada, no bloqueante):** el
encargo asumía que 95 estaba en `REPO` (a cambiar a `DOC`) y que 97 traía `Infra`
a aclarar. En el archivo, 95 ya estaba en `DOC` y 97 ya en `REPO` puro: la
reconstrucción previa ya los había categorizado así, por lo que ambos "cambios"
fueron no-op (solo perdieron la marca). Las descripciones coincidían con lo que el
encargo asumía, de modo que no se gatilló la detención.

**Incidente y reparación (honestidad).** El primer intento de retiro de marcas usó
`replace_all` de `" # REVISAR (categoría)"` con reemplazo vacío; esto colapsó los
saltos de línea y concatenó las entradas 80–91 en una sola línea y 92–98 en otra
(verificado por el conteo de continuidad: 88 en vez de 105). Se reparó
reinsertando los saltos de línea en ambos bloques y restaurando la línea en blanco
previa a cada `Delta del backlog`. Verificación final: continuidad 1–105 sin
huecos ni duplicados, 19 sesiones, 0 marcas residuales, descripciones intactas.
Aprendizaje: para borrar un sufijo repetido por línea, anclar el patrón al texto
vecino (no reemplazar la cadena suelta con vacío) o validar el conteo de líneas
inmediatamente después.
