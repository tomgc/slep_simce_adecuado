> Rescatado a `main` desde `gobernanza/v16` (`667e5ad`) por D35-17 (encargo s35k, 2026-09-26): el «No commitear» del encabezado (y de la línea final) quedó obsoleto; el resto del archivo es el original, byte a byte.
# Implementación del productor del contrato de contexto v1 (slep_simce_adecuado)

**Fecha:** 2026-07-11
**Tipo:** andamio congelado (log de implementación). No commitear.
**Rama:** `feat/contrato-contexto` (2 commits locales, SIN push).

---

## 1. Resumen

Se implementaron **dos cambios encadenados** en `slep_simce_adecuado`:
1. **Extensión del normalizador** (`31_leer_normalizar.R`): ahora persiste en `simce_rbd.parquet` las 5 columnas de señal que antes descartaba (`prom`, `dif`, `difgru` numéricas; `sigdif`, `siggru` banderas normalizadas a `{-1,0,1,NA}`), con un helper `normalizar_bandera()` que maneja la representación mixta (literal/numérica) y falla ruidosamente ante lo inesperado.
2. **Productor del contrato** (`35_exponer_contrato_contexto.R`): deriva de ahí `40_salidas/publico/contexto_simce.parquet`, exponiendo SOLO filas donde el establecimiento mejora, en escala **puntaje** (no % adecuado).

Estado final: **simce_rbd.parquet intacto en todo lo preexistente** (no-regresión verificada), **contexto_simce.parquet = 61.853 filas × 15 columnas**, los chequeos de la Fase 2 y los 10 de la Fase 4 **pasan**, 2 commits atómicos locales. No push.

---

## 2. Inventario de commits

| Hash | Tipo | Título | Qué hizo |
|---|---|---|---|
| `6e00830` | feat | normalizador persiste las señales de la Agencia (puntaje) | Extiende `31_leer_normalizar.R`: helper `normalizar_bandera()` + 5 columnas nuevas apendizadas. Parquet regenerado NO versionado (gitignored). |
| `31befa2` | feat | productor del contrato de contexto v1 (paso 35) | Nuevo `35_exponer_contrato_contexto.R` + enganche en `00_build.R` + contrato congelado + parquet público `contexto_simce.parquet` (no gitignored). |

Ambos path-scoped. Cambios preexistentes ajenos en el working tree (`POLITICA_PROYECTO.md`, `50_documentacion/estructura/*`, `50_documentacion/suite/*`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) **no** se tocaron.

---

## 3. Cambios sustantivos

### 3.1 `30_procesamiento/31_leer_normalizar.R` (extensión quirúrgica)
- **Qué:** (a) helper `normalizar_bandera()`; (b) `extraer_prueba()` gana parámetro `archivo` y extrae `prom/dif/difgru` (numéricas, vía `to_num`) y `sigdif/siggru` (vía `normalizar_bandera`); (c) las 10 columnas nuevas (5 por prueba) se agregan a la validación de columnas requeridas; (d) las 5 columnas de salida se apendizan al final del orden de columnas; (e) cabecera del esquema actualizada 14→19; (f) mensaje final `(14 columnas)` → conteo dinámico.
- **Por qué:** el contrato de contexto necesita las señales de la Agencia (puntaje) que el pipeline descartaba. La normalización de la representación mixta vive AQUÍ (contrato §7), no en el productor.
- **Cómo se verificó:** Fase 2 completa (no-regresión + dominios + cruce sign×bandera). Sin PARADA del helper → todas las banderas mapearon a los 6 valores conocidos.
- **Decisiones:**
  - **Nombres destino sin sufijo de prueba** (`prom`, `dif`, `difgru`, `sigdif`, `siggru`), consistente con el idiom largo del script (igual que `palu_eda_ade`; `prueba` es columna discriminadora). No se inventó convención nueva.
  - **Apéndice al final** del orden de columnas: ninguna columna preexistente cambia de posición (no-regresión para consumidores que usen acceso posicional).
  - **Columnas nuevas como requeridas** (fallan si faltan): están en los 18 xlsx según el inventario; preferible fallar ruidosamente a degradar en silencio.
  - **Comentario extenso** en `normalizar_bandera()` explicando la trampa del `as.numeric()` silencioso, con referencia al contrato §7 y al log de investigación. Parte del entregable.

### 3.2 `30_procesamiento/35_exponer_contrato_contexto.R` (nuevo)
- **Qué:** productor del contrato. Estructura del repo (header Apache, `library(here)`, `here::here()`, paquetes prefijados). Lee `simce_rbd.parquet` (ya en grano largo = grano del contrato, **no requiere pivot**), deriva las 15 columnas, filtra a filas con alguna mejora, escritura atómica.
- **Por qué:** el filtrado de "qué es mejora" vive en el productor (§1, §2); el consumidor recibe el parquet filtrado.
- **Cómo se verificó:** Fase 4 (10 chequeos) sobre el parquet real.
- **Decisiones:**
  - `escala = "simce_puntaje"` (§5, 🔒): la señal es sobre `prom`, nunca sobre `palu_eda_ade`. Documentado en el header con 🔒.
  - `eje_etiqueta` desde constante nombrada `EJE_ETIQUETA <- c(lect="Lectura", mate="Matemática")` (no existía constante de glosa en `10_utils`). Guarda `stop()` si algún `eje` no tiene glosa.
  - `desvio_gse <- difgru` copiado tal cual, incluyendo NA con bandera +1 (§6).
  - Booleanos con idioma que no propaga NA: `!is.na(x) & x == 1L`.
  - Correlativo **35** (siguiente libre: existen 30–34; 34 es el histórico). Enganchado tras el paso 33 en `00_build.R`.

### 3.3 `50_documentacion/activa/contrato_contexto_v1.md` (versionado)
- Estaba `??`. Se versionó con el productor: es la especificación (copia idéntica a la del consumidor y a la de `slep_idps`, §10; verificado byte a byte con `diff`).

---

## 4. Chequeo de NO-REGRESIÓN (Fase 2) — evidencia

Snapshot del `simce_rbd.parquet` previo tomado ANTES de tocar nada (columnas, tipos, nrow, checksum de `palu_eda_ade`/`nalu`/NA por `anio×nivel×prueba`).

| Chequeo | Resultado |
|---|---|
| Columnas previas presentes, mismo tipo | **SÍ** (0 faltantes; tipos idénticos) |
| Columnas agregadas | `prom, dif, difgru, sigdif, siggru` |
| NROW idéntico | **SÍ** (185.378 = 185.378) |
| Checksum de columnas previas por grupo | **0 grupos distintos** (suma de `palu_eda_ade`, `nalu`, conteos de NA de `cod_grupo`/`marca` idénticos en los 36 grupos `anio×nivel×prueba`) |
| Validación existente (2 filas por `anio,nivel,rbd`) | **PASA** (0 anómalos) |

Conclusión: la extensión **no alteró nada de lo preexistente**; solo agregó 5 columnas.

---

## 5. Verificación de la normalización

**Dominio agregado (parquet nuevo) vs esperado del inventario:**

| Bandera | −1 | 0 | +1 | NA | ¿coincide? |
|---|---|---|---|---|---|
| `siggru` | 58.639 | 58.377 | 48.780 | 19.582 | **exacto** |
| `sigdif` | 27.933 | 103.599 | 29.808 | 24.038 | **exacto** |

**Años de representación literal** (2m: 2014-2017; 4b: 2014-2016): `siggru` no-NA = **59.987**, `sigdif` no-NA = **57.896** (ambos > 0). **La señal histórica sobrevivió a la normalización** (no se borró a NA).

**Cruce sign(diferencia) × bandera (anti-diagonal debe ser 0):**
- `sign(difgru) × siggru`: anti-diagonal = **0** (ninguna difgru>0 con siggru=−1 ni difgru<0 con siggru=+1).
- `sign(dif) × sigdif`: anti-diagonal = **0**.

Réplica exacta del cruce documentado en el log de investigación `20260711_dominio_significancia_simce_log.md`.

---

## 6. Los 10 chequeos de la Fase 4 (conteos reales)

| # | Chequeo | Esperado | Observado | Estado |
|---|---|---|---|---|
| 1 | 15 columnas, orden y tipos | match | orden TRUE; tipos OK (rbd string, anio int32, booleanos bool, fecha date32, valor/desvio double) | **PASA** |
| 2 | `rbd` character | sí | sí | **PASA** |
| 3 | Llave `(rbd,anio,eje,segmento)` única | 0 dup | 0 | **PASA** |
| 4 | Ninguna fila ambos booleanos FALSE | 0 | 0 | **PASA** |
| 5 | Ningún booleano en NA | 0 | 0 | **PASA** |
| 6 | `version_contrato=="contexto_v1"` 100% | sí | sí | **PASA** |
| 7 | `escala=="simce_puntaje"` 100% | sí | sí | **PASA** |
| 8 | Cobertura 2014-2018, 2022-2025, sin 2019-2021 | match | {2014-2018, 2022-2025}, sin 2019-2021 | **PASA** |
| 9 | Trazabilidad re-derivada desde xlsx crudos | coincide | ver abajo | **PASA** |
| 10 | Filas bandera +1 con `desvio_gse` NA | reporte | 132 | **PASA** (informativo) |

**Cobertura por año × segmento (chequeo 8):**

| anio | 2m | 4b | | anio | 2m | 4b |
|---|---|---|---|---|---|---|
| 2014 | 2.155 | 4.487 | | 2022 | 2.084 | 3.811 |
| 2015 | 2.366 | 4.569 | | 2023 | 2.502 | 4.782 |
| 2016 | 2.629 | 4.571 | | 2024 | 2.343 | 4.904 |
| 2017 | 2.672 | 4.564 | | 2025 | 2.350 | 4.248 |
| 2018 | 2.312 | 4.504 | | | | |

**Trazabilidad (chequeo 9), re-derivada de forma INDEPENDIENTE leyendo los 18 xlsx crudos** (con su propio mapeo literal→código, sin usar `normalizar_bandera` — para no heredar su punto ciego):
- `siggru == +1`: crudo **48.780** = salida `mejora_sobre_gse=TRUE` **48.780** → COINCIDE.
- `sigdif == +1`: crudo **29.808** = salida `mejora_ano_ano=TRUE` **29.808** → COINCIDE.

Sin pérdida ni invención de señal. Que estos conteos igualen los dominios `+1` del inventario confirma que la señal de los años literales llegó completa a la salida.

**Total filas de salida: 61.853.**

---

## 7. Verificación de invariantes (🔒)

| Invariante | Estado | Evidencia |
|---|---|---|
| Banderas leídas verbatim, nunca recalculadas | **PASA** | Solo se mapea representación (literal↔código) y se deriva `== 1L`. Chequeo 9: conteos idénticos al crudo. |
| Normalización de representación mixta, falla ante lo inesperado | **PASA** | `normalizar_bandera()` mapea los 6 valores y `stop()` ante otros; sin PARADA en la corrida → 0 valores no mapeados. Años literales con señal viva (dominio §5). |
| Segregación de escala (puntaje, no % adecuado) | **PASA** | `valor=prom`, `desvio_gse=difgru`, `escala="simce_puntaje"`. Nunca se toca `palu_eda_*`. Chequeo 7 = 100%. |
| GSE no se promedia ni arrastra (R1) | **PASA** | `cod_grupo` viaja en la llave `(rbd,anio,segmento)` sin agregación. |
| `rbd` siempre character | **PASA** | Chequeos 1/2. |
| Booleanos nunca NA (0/-1/NA → FALSE) | **PASA** | Chequeo 5 = 0; idioma `!is.na(x) & x==1L`. |
| Solo filas con alguna mejora TRUE | **PASA** | Chequeo 4 = 0 doble-FALSE; filtro en el productor. |
| No romper consumidores de simce_rbd.parquet | **PASA** | Fase 2: columnas previas intactas, checksum idéntico, nrow idéntico. |
| No tocar 20_insumos | **PASA** | Solo lectura de los xlsx; `git status` sin cambios en `20_insumos/`. |
| Gobernanza (sin RBD ni filas en logs) | **PASA** | Este log solo tiene conteos agregados y esquemas. |
| No push | **PASA** | 2 commits locales; ningún push. |

---

## 8. Pendientes abiertos

1. **Copia manual al consumidor:** `contexto_simce.parquet` debe copiarse a `slep_minuta_buenas_senales/20_insumos/` (tarea del titular; contrato §10). El parquet quedó versionado en este repo (publico/ no está gitignored).
2. **`periodo` hardcodeado** a `"2026-07"` (`PERIODO_CORRIDA`). Re-correr en otro mes exige actualizarlo.
3. **2025 es preliminar:** el contrato lo expone (§8) pero el productor no marca la fila como preliminar (el contrato v1 no reserva columna para eso, §9). `simce_rbd.parquet` sí tiene `preliminar`, pero no se propaga al contrato porque el esquema de 15 columnas no lo contempla. Si el titular quiere distinguirlo, es material de v2 (o embeberlo en `eje_etiqueta`, §9).
4. **`simce_rbd.parquet` no versionado:** al estar gitignored, la regeneración con las 5 columnas nuevas vive solo local. Cualquier clon del repo debe re-correr el paso 31 para obtener el parquet extendido.

---

## 9. Notas para el revisor (ojo crítico)

- **Chequeo 9 es el crítico:** re-derivado de forma independiente desde los xlsx crudos, con mapeo literal propio, precisamente para NO heredar el punto ciego de `normalizar_bandera`. Coincide exacto (48.780 y 29.808). Si se hubiera usado el mismo helper, el chequeo sería circular.
- **La trampa del `as.numeric()`:** el riesgo central del encargo era borrar la señal de los años literales en silencio. Verificado que NO ocurrió: años literales con 59.987 (siggru) y 57.896 (sigdif) valores no-NA. El comentario en `normalizar_bandera()` documenta la trampa para el futuro.
- **132 filas con `desvio_gse` NA y `mejora_sobre_gse` TRUE** (chequeo 10): son legítimas (§6: bandera oficial +1, magnitud suprimida por confidencialidad). El consumidor debe tolerar `desvio_gse` NA. Coincide con las 132 del cruce `difgru×siggru` en la investigación.
- **Escala puntaje, no % adecuado:** el punto conceptualmente más delicado. Todo texto del consumidor a partir de estas filas debe decir "puntaje". El proyecto SIMCE gira en torno a % adecuado, pero la señal de significancia solo existe sobre puntaje. Revisar que el consumidor no confunda escalas.
- **No-regresión:** el snapshot previo y el checksum por grupo son la prueba de que extender no rompió nada. Si se re-corre el paso 31, `fecha_calculo` del contrato cambia pero `simce_rbd.parquet` no (no lleva fecha).

---

*Fin del andamio. Congelado 2026-07-11. No commitear. Rama `feat/contrato-contexto`, 2 commits locales, sin push.*
