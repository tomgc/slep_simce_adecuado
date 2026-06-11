# Informe de auditoría pre-lanzamiento — slep_simce_adecuado

> **Sesión 13** (2026-06-10/11, interfaz web). Encargo:
> `50_documentacion/activa/encargo_auditoria_slep_simce_adecuado.md`.
> Método: por cada caso, criterio de éxito definido ANTES de correr, script R
> autocontenido, ejecución local del usuario, doble camino independiente
> (caché vs. recálculo). Destino de este informe: `50_documentacion/activa/`.

---

## 1. Veredicto global

| Dimensión | Estado |
|-----------|--------|
| A. Corrección | **A1, A2b, A3, A4, A5, A6, A7: PASAN.** A2 (v. inicial) FALLÓ y se corrigió de raíz (sección 3.1). |
| B. Seguridad | **B1, B3, B4: cerrados.** B2 resuelto como decisión de gobernanza del usuario (sección 4.1). |
| C. Optimización | **C1 corregido, C3 PASA, C2/C4 diferidos con justificación.** |

**LISTO PARA LANZAR.** Los criterios del encargo (§5) están todos en verde o
resueltos por decisión explícita del usuario. Falta solo el bloque operativo
de cierre: commit, deploy y verificación post-deploy (sección 5).

## 2. Resultados por caso

### A. Corrección

- **A1 — Reagregación comunal desde RBD: PASA.** Recalculado por camino
  aritmético independiente (`stats::aggregate` sobre numerador/denominador,
  filtros replicados). 44.975 filas, llaves idénticas en ambas direcciones,
  max |Δ pct| = 0 (tolerancia 1e-9), `n_evaluados` y `n_estab` exactos.
- **A2 — Consistencia popup vs. cálculo: FALLÓ en su versión inicial.**
  `U_motor \ U_calc` = 10.166 filas (6.130 solo `nalu < 10`; 2.028 ambos
  motivos; 2.008 solo marca no-NA), 4.495 celdas de popup afectadas, 4.978
  entradas de catálogo sin respaldo. Impacto sobre SLEPs: 742 celdas con
  |Δ| ≥ 0,05 pp, **máximo 42,6 pp** (Valparaíso GSE 3, 2m mate 2016).
  Corregido de raíz (sección 3.1). **A2b (re-test sobre el artefacto): PASA**
  — el JSON transporta exactamente U_calc (140.345 filas) y los catálogos
  (`rbd_gse` 29.277, `rbds_por_nivel` 17.983) coinciden con el universo que
  aporta al cálculo. Re-verificado tras cada edición posterior del template.
- **A3 — Equivalencia de agregación SLEP: PASA.** Réplica exacta en R de
  `generateSeriesByRbd` sobre el JSON embebido vs. referencia de precisión
  completa desde parquet: 3.672 celdas, conjuntos idénticos, max |Δ| =
  1,78e-14 pp (épsilon de máquina), `n_eval`/`n_estab` exactos. Cobertura
  explícita: 10 SLEP prospectivos 2026 y Costa Central.
- **A4 — Universo de RBDs por SLEP: PASA.** Camino independiente leyendo
  directorio y listado SLEP directamente: 0 comunas bajo 2+ SLEP, 0 comunas
  en ambas ramas, 36/36 SLEP con sets exactos, 0 RBDs en 2+ SLEP, 0 RBDs con
  `COD_DEPE ∈ {3,4,5}`, 0 traspasos > 2026. 669 exclusiones, todas
  justificadas por `ESTADO_ESTAB`/`MATRICULA` (decisión del pipeline).
- **A5 — Identidad byte a byte del JSON: PASA.** SHA-256 idéntico entre R
  (`memDecompress`) y navegador (`pako.inflate` sobre el literal del DOM):
  11.839.604 bytes, hash `15e94ef9...aef` en ambos lados. Nota: el hash
  cambia entre días por `meta$fecha_generacion` (mismo largo de bytes); la
  regresión independiente de fecha es A2b.
- **A6 — Contraste contra fuente oficial: PASA.** Muestra reproducible
  (semilla 1303): 7 establecimientos con dato (4 urbanos grandes 2m, 3
  rurales pequeños 4b) con coincidencia EXACTA del % Adecuado contra el
  buscador de la Agencia (30,8 / 17,6 / 4,8 / 16,0 / 50,0 / 15,8 / 63,6);
  3 suprimidos (4b mate 2024) con "-" en el sitio y sin punto 2024 en el
  motor, los tres. Hallazgo lateral documentado: el patrón de supresión
  cambió entre años (2014–2022: `palu` NA con `nalu > 0`; 2023–2024: solo
  `nalu` 0/NA; 2025 preliminar: reaparece `nalu > 0`, lo que explica el
  bug 12-4).
- **A7 — Reproducibilidad: PASA.** Doble corrida de `00_build.R`: 7 archivos
  (6 parquets + HTML) byte-idénticos.

### B. Seguridad

- **B1 — Datos personales: PASA.** 0 patrones RUT y 0 correos en HTML y en
  JSON descomprimido; 51 claves inventariadas por parseo, 0 sospechosas.
- **B2 — Nombres de establecimiento: resuelto por decisión del usuario**
  (sección 4.1). Los nombres se mantienen.
- **B3 — Repo y Pages: cerrado.** `docs/` solo con `index.html`. Hallazgo: el
  repo es **PUBLIC** (condición de Pages en plan Free); el estándar sube a
  "todo lo trackeado es público". Verificado: insumos de fuente pública o de
  creación interna sin datos privados (confirmación del usuario);
  `.claude/settings.local.json` no trackeado. Pendiente nuevo: auditoría
  conjunta de `50_documentacion/` pública (sección 5).
- **B4 — Dependencias externas: corregido (opción 1).** Hallazgo: React y
  ReactDOM en builds *development* + Babel standalone desde unpkg, sin SRI.
  Corrección aplicada: builds `production.min` + atributos `integrity`
  (sha384 calculados desde los tarballs oficiales de npm) + `crossorigin`.
  Diferido con justificación: inline + precompilación de JSX (elimina Babel
  del cliente; exige Node en el pipeline; sesión propia).

### C. Optimización

- **C1 — Código muerto: corregido.** `generateSeries` legacy (42 líneas,
  definida y exportada, cero llamadas) removida del template y del export de
  `SimceData`. Sintaxis JSX validada con `@babel/parser`. `depe2CodesParaSlep`
  sin residuos. Hallazgo que corrige al backlog (ítem 41): `showElemInsuf`
  NO fue removido en s10; vive hardcodeado `= true` y lo consumen
  `RecentBarsSubchart` y `ChartHints` — es infraestructura ya instalada para
  el pendiente del toggle Elemental/Insuficiente.
- **C2 — Rendimiento de arranque: diferido.** Los builds production de B4
  reducen el costo por sí solos; la medición formal y la eliminación de la
  transpilación en cliente quedan ligadas a la opción 2 de B4.
- **C3 — Unicidad de selección de series: PASA.** Las cuatro
  `generateSeriesBy*` se llaman únicamente dentro de `getSeriesForEntity`;
  todos los componentes consumen `SimceData.getSeriesForEntity`. Los
  `kind ===` restantes son metadata/labels/popups (invariante 10 respetado).
- **C4 — Tamaño: diferido con justificación.** `rbd_gse` y `rbds_por_nivel`
  son ahora derivables en cliente desde `simce_rbd` (≈47 mil filas
  pre-compresión), pero el retorno comprimido es marginal (decisión s11
  vigente) y agregaría lógica de cliente. HTML: 1.829 → **1.713 KB**.

## 3. Hallazgo principal y corrección de raíz

### 3.1 Regresión introducida en s12: filtros MINEDUC ausentes en la vía SLEP

- **Síntoma:** % de SLEP inconsistentes con comunas/regiones; popups listando
  establecimientos que no aportan al cálculo. Divergencias de hasta 42,6 pp,
  concentradas en celdas rurales GSE Bajo de 4b 2023–2024.
- **Causa raíz:** la corrección 12-2 cambió la fuente de las series de SLEP
  desde `simce_comunal` (filtros de producción ya aplicados en R) a
  `simce_rbd` crudo, sin reaplicar `nalu >= 10` ni `marca` NA (la columna
  `marca` ni siquiera viaja en el JSON). Misma condición incompleta en los
  catálogos de popup (solo `palu` no-NA).
- **Corrección (fuente única de verdad en R):** `33_generar_html.R` aplica el
  filtro completo de producción (`palu` no-NA, `nalu >= 10`, `marca` NA) a
  los tres bloques que viajan al JSON: `simce_rbd`, `rbd_gse`,
  `rbds_por_nivel`. El cliente no cambia (guards quedan como defensa).
  Beneficio lateral: 185.378 → 140.345 filas en el JSON.
- **Regla aprendida:** al cambiar la FUENTE de un cálculo, hay que reaplicar
  los FILTROS de la fuente original; un fix de universo (12-2) puede
  introducir una regresión de criterio. Verificación: invariante 5 se aplica
  una sola vez, en R; el JSON solo transporta U_calc.
- **Efecto visible esperado:** las cifras de SLEP publicadas cambian respecto
  a lo desplegado pre-auditoría (incluida Costa Central donde tenga filas
  bajo umbral). Es la corrección, no una regresión.

## 4. Decisiones de gobernanza

### 4.1 B2 — Nombres de establecimiento (decisión del usuario: mantener)

La premisa de POLÍTICA §6.4 ("no identificar establecimientos por nombre en
ningún output") resultó ser una generalización: la verificación web indica
que la cadena formulario + Condiciones de Uso aplica a las bases POR
ESTUDIANTE (que este proyecto no usa); las bases por establecimiento son de
libre descarga pública y la propia Agencia identifica establecimientos por
nombre con sus resultados en su buscador público. El usuario resolvió:
mantener nombres (el RBD identifica igual; anonimizar era cosmético).
Acciones derivadas: documentar esta verificación en
`50_documentacion/activa/decisiones/` y corregir POLÍTICA §6.4 (tarea
BIBLIOTECA, multi-proyecto).

### 4.2 B3 — Repo público

Visibilidad PUBLIC justificada (GitHub Pages en plan Free). Decisión:
mantener público, con el estándar de que todo lo trackeado es publicable.
Confirmado por el usuario para los insumos; la documentación queda con
auditoría pendiente (sección 5).

## 5. Pendientes que deja la auditoría

1. **Auditoría de `50_documentacion/` pública** (traspasos, backlog,
   encargo): sesión conjunta usuario + asistente.
2. **POLÍTICA §6.4** — corregir el resumen de las Condiciones de Uso (sesión
   BIBLIOTECA; documento canónico multi-proyecto).
3. **B4 opción 2 / C2:** inline React production + precompilación JSX
   (elimina Babel del cliente y el warning de consola).
4. **Higiene (pendiente 4 de v12):** mover a `_archivo/` los scripts de
   diagnóstico de raíz, ahora incluyendo los 8 `auditoria_*.R` de esta sesión
   (referencia metodológica reutilizable).
5. **Verificación post-deploy:** el aviso de consola `'file:' URLs are
   treated as unique security origins` no debería aparecer en Pages (https);
   si persiste, investigar.
6. **Commit y deploy:** los cambios de esta sesión (`33_generar_html.R`,
   `33_motor_template.html`, `docs/index.html` regenerado) están sin
   commitear; bloque propio al cierre, con A6 cerrado.
7. **Toggle Elemental/Insuficiente** (pendiente 2 de v12): aprovechar que
   `showElemInsuf` ya está instalado (hallazgo C1).

## 6. Archivos modificados en la auditoría

| Archivo | Cambio |
|---------|--------|
| `30_procesamiento/33_generar_html.R` | Filtro completo de producción en `simce_rbd`, `rbd_gse`, `rbds_por_nivel` (3.1) |
| `30_procesamiento/33_motor_template.html` | B4: CDN production + SRI; C1: remoción de `generateSeries` legacy y su export |
| `40_salidas/motor_comparacion.html`, `docs/index.html` | Regenerados (1.713 KB) |

Scripts de auditoría generados (raíz, no versionados): `auditoria_a1_reagregacion_comunal.R`,
`auditoria_a2_consistencia_popup.R`, `auditoria_a2b_verificar_html.R`,
`auditoria_a3_equivalencia_slep.R`, `auditoria_a4_universo_slep.R`,
`auditoria_a5_checksum_json.R`, `auditoria_a6_muestra_oficial.R`,
`auditoria_a7_reproducibilidad.R`, `auditoria_b1_datos_personales.R`.
