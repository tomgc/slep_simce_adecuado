# Traspaso de Cierre — slep_simce_adecuado

- **Versión de traspaso:** v10
- **Fecha:** 2026-06-09
- **Sesión:** 10 — Documentación visual y conceptual del proyecto (diagrama de arquitectura HTML, presentación conceptual del proyecto en md + html), actualización de `CLAUDE.md`, y simplificación de la UI del motor (remoción del panel de ajustes, eliminación de la franja de tabla, contacto en notas). Cierre con deploy a GitHub Pages.
- **Modelo utilizado:** Claude Opus 4.8
- **Entorno:** R (Positron) + Git/GitHub Pages (zsh, macOS)
- **Archivos principales modificados:**
  - `30_procesamiento/33_motor_template.html` (panel de ajustes removido; franja de tabla eliminada; contacto en notas)
  - `CLAUDE.md` (actualizado al estado real post-v09)
  - `docs/index.html` (redeploy con el motor regenerado)
  - `50_documentacion/activa/arquitectura_slep_simce_adecuado.html` (nuevo)
  - `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md` (nuevo)
  - `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.html` (nuevo)
  - `50_documentacion/estructura/` (sincronización de snapshots tras auto-poda)

---

## 2. Resumen ejecutivo

La sesión abordó tres frentes de la documentación y un refinamiento de la UI del motor. Primero se construyó un diagrama de arquitectura HTML standalone que documenta el flujo del pipeline (insumos → 30 → 31 → 32 → 33 → motor), replicando el formato visual del modelo `arquitectura_seguimiento_ep.html` pero adaptado a track único lineal; durante su construcción se recuperó la definición real de las anomalías A1–A4 (que el v09 daba por conocidas sin definirlas) y se las representó como normalizaciones de datos de origen ya resueltas, no como alertas. Segundo, se actualizó `CLAUDE.md` al estado real post-v09 (pendientes obsoletos eliminados, "Últimos cambios" extendido a v04–v09, datos marcados como versionados, cifras de filas removidas por no verificadas en su momento). Tercero, se creó una presentación conceptual del proyecto (`documentacion_proyecto_slep_simce_adecuado.md` + `.html`) para lectores internos de distinto nivel de dominio SIMCE, con sección de conceptos saltable y decisiones metodológicas con su "por qué". Finalmente, en el motor se removió el panel de ajustes completo (densidad fija en "cómoda", `showElemInsuf`/`yScale` hardcodeados), se eliminó la franja de leyenda bajo la tabla y se agregó el área y contacto al pie de las notas metodológicas. Todo quedó commiteado en tres commits temáticos y publicado en GitHub Pages. El proyecto cierra sin bugs activos, con repo limpio y sincronizado en `origin/main`.

---

## 3. Estado del proyecto al cierre

**Qué funciona:**
- Motor publicado y actualizado en `https://tomgc.github.io/slep_simce_adecuado/`, regenerado con `00_build.R` (build exitoso en 3 s, lee la plantilla nueva de 132.653 caracteres y produce `motor_comparacion.html` de ~14,5 MB).
- Pipeline `00_build.R` intacto y reproducible; las anomalías A1–A4 aparecen resueltas en el log de la corrida (remapeo pre-Ñuble, recuperación de `cod_com_rbd` desde directorio).
- Tres documentos de documentación nuevos versionados en `50_documentacion/activa/`.
- `CLAUDE.md` coherente con el estado real.
- Working tree limpio; `origin/main` sincronizado en `27d56eb`.

**Qué no funciona:**
- Ningún bug activo conocido al cierre.

**Qué cambió respecto al traspaso v09:**
- Nuevo diagrama de arquitectura y nueva documentación conceptual (md + html).
- `CLAUDE.md` actualizado.
- Motor sin panel de ajustes ni franja de tabla; con contacto en notas.
- `docs/index.html` redeployado.
- Snapshots de estructura sincronizados con Git tras la auto-poda.

---

## 4. Registro detallado de cambios realizados

#### Cambio 1: Diagrama de arquitectura HTML standalone

- **Archivo(s) afectado(s):** `50_documentacion/activa/arquitectura_slep_simce_adecuado.html` (nuevo, ~19,7 KB)
- **Categoría temática:** DOC
- **Qué se hizo:** Se construyó un HTML autocontenido (sin scripts externos) que documenta las 5 etapas del pipeline con tarjetas, badges de tipo de dato, banderas metodológicas y conectores de flujo, replicando la paleta y los componentes del modelo `arquitectura_seguimiento_ep.html`. Se adaptó de track dual (modelo) a track único lineal (este pipeline). Las anomalías A1–A4 se representan como "normalizaciones de origen resueltas" (bloque verde con ✔) en la etapa 31, no como alertas.
- **Por qué se hizo:** Pendiente 1 del v09. El pipeline carecía de representación visual navegable de su arquitectura.
- **Cómo se verificó:** Validación estructural (divs balanceados, 0 scripts externos, 5 etapas y A1–A4 presentes); revisión visual del usuario.
- **Líneas o secciones clave:** bloque `.norm` en la etapa 31 (anomalías); banderas `.flag` en 31 y 32.
- **Dependencias afectadas:** Referenciado por la documentación conceptual (Cambio 3).

#### Cambio 2: Actualización de CLAUDE.md al estado real post-v09

- **Archivo(s) afectado(s):** `CLAUDE.md`
- **Categoría temática:** DOC
- **Qué se hizo:** Pendientes obsoletos (P5, P6, P7, "nacional") eliminados por estar ya implementados según v04–v09; "Últimos cambios" extendido con bloques de sesiones 4–9 (getSeriesForEntity, tooltip clamp, fix pivot_wider, GitHub Pages, auto-poda, diagrama); datos marcados como versionados (corrige "no versionados"); cifras de filas removidas (no verificadas en su momento); estructura alineada al estado v09 (sin `estructura_proyecto.md`, con `docs/` y el diagrama). Pendientes vigentes: P2, P3, P4, P5 (heredado), D3.
- **Por qué se hizo:** Pendiente 2 del v09. Claude Code lee `CLAUDE.md` primero; desfasado arranca con contexto incorrecto.
- **Cómo se verificó:** Contraste contra traspasos v04–v09, README y escáner.
- **Líneas o secciones clave:** secciones "Pendientes" y "Últimos cambios".
- **Dependencias afectadas:** Ninguna.

#### Cambio 3: Documentación conceptual del proyecto (md + html)

- **Archivo(s) afectado(s):** `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md` (nuevo), `documentacion_proyecto_slep_simce_adecuado.html` (nuevo, ~16,9 KB)
- **Categoría temática:** DOC
- **Qué se hizo:** Presentación conceptual para lectores internos de distinto nivel de dominio SIMCE. 6 secciones: qué es y para qué; conceptos SIMCE (saltable); qué hace; decisiones metodológicas con su "por qué"; de dónde salen los datos (A1–A4 en una línea c/u); cómo se relaciona con el resto de la documentación. El HTML replica el sistema visual del diagrama (render fiel, ancho de lectura 820px). Complementario al diagrama: este documento da el "qué y por qué", el diagrama el "cómo fluye".
- **Por qué se hizo:** Solicitado por el usuario: documento que presente el proyecto conceptualmente para compartir junto al diagrama. No existía.
- **Cómo se verificó:** Validación estructural del HTML (6 secciones, 5 decisiones, A1–A4, cruces internos con el nombre nuevo del diagrama, 0 scripts externos); revisión del usuario.
- **Líneas o secciones clave:** sección 2 (conceptos, saltable); sección 4 (5 decisiones metodológicas con bloque "por qué").
- **Dependencias afectadas:** Referencia al diagrama y al README por nombre de archivo; el usuario renombró el archivo a `documentacion_proyecto_<proyecto>` para habilitar búsqueda cross-proyecto.

#### Cambio 4: Remoción del panel de ajustes del motor (P3)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI
- **Qué se hizo:** Se eliminó el botón "Ajustes" del Header, las definiciones de `TweaksPanel`/`TweakSection`/`TweakRow`/`TweakToggle`/`TweakRadio`/`TweakButton`, el estado `tweaksOpen`, el estado `density`, y el render del `<TweaksPanel>`. `density` se hardcodeó a `is-comfy` en `containerClass`. `showElemInsuf` (true) y `yScale` ("100") se convirtieron de estado a constantes fijas porque los consume el gráfico (`RecentBarsSubchart`, `ChartHints`), no solo el panel. `applyPreset` se conservó (lo usa `openPresetMenu`).
- **Por qué se hizo:** Pendiente 3 del v09: simplificar la UI del motor para compartir. Decisión de alcance confirmada por el usuario: quitar el botón completo (sacrificando los toggles de Elemental/Insuficiente y escala Y, que solo eran configurables vía panel).
- **Cómo se verificó:** `grep` confirmó 0 referencias `<Tweak>` en JSX, balance de tags `<script>`, `showElemInsuf`/`yScale` aún consumidos por el gráfico, `applyPreset` conservado.
- **Líneas o secciones clave:** `Header` (sin `onOpenTweaks`); bloque de estados; `containerClass`.
- **Dependencias afectadas:** Requiere `00_build.R` + redeploy a `/docs`. Quedó CSS huérfano (ver sección 11.2).

#### Cambio 5: Eliminación de la franja de tabla y contacto en notas (P4 reformulado)

- **Archivo(s) afectado(s):** `30_procesamiento/33_motor_template.html`
- **Categoría temática:** UI
- **Qué se hizo:** Se eliminó el bloque `table-legend` ("Dato preliminar 2025 / Formato XX,X% / sin datos") bajo la tabla, por decisión del usuario (se veía innecesario). El contacto inicialmente agregado al Header (P4 original) se revirtió por verse mal, y en su lugar se agregó al pie de las notas metodológicas (`notes-sources`) una línea sutil con el área ("Área de Monitoreo y Seguimiento de Procesos y Resultados Educativos") y el contacto. El correo se ensambla en JS (no aparece como string literal completo en el fuente), aunque va como texto, no como `mailto:`, por estar dentro de la nota.
- **Por qué se hizo:** Ajustes solicitados por el usuario sobre la marcha tras ver el render (imágenes adjuntas).
- **Cómo se verificó:** `grep -c` del correo literal completo = 0; "Área de Monitoreo" presente = 1; `table-legend` solo como CSS huérfano (2 reglas), no en JSX.
- **Líneas o secciones clave:** `notes-sources` dentro de `<footer className="app-footer">`.
- **Dependencias afectadas:** El contacto vive dentro del panel colapsable de notas (solo visible al desplegarlo).

#### Cambio 6: Deploy a GitHub Pages y sincronización de snapshots

- **Archivo(s) afectado(s):** `docs/index.html`, `50_documentacion/estructura/`
- **Categoría temática:** REPO / Despliegue
- **Qué se hizo:** Tres commits temáticos: (1) `277ff57` motor + `docs/index.html`; (2) `806a9cc` docs nuevas + `CLAUDE.md`; (3) `27d56eb` sincronización de snapshots de estructura tras auto-poda. Push a `origin/main`.
- **Por qué se hizo:** Publicar los cambios del motor y versionar la documentación nueva.
- **Cómo se verificó:** `git show --stat HEAD~1` confirmó que `docs/index.html` entró en el commit del motor (110 líneas cambiadas); `grep` sobre `docs/index.html` confirmó `TweaksPanel` ausente (solo comentario CSS) y "Área de Monitoreo" presente.
- **Líneas o secciones clave:** commits `277ff57`, `806a9cc`, `27d56eb`.
- **Dependencias afectadas:** Ninguna.
- **Nota de proceso:** Durante el deploy hubo confusión sobre si el build se había regenerado; se verificó que `docs/index.html` ya tenía los cambios desde el primer commit (el `cp` inicial copió un `motor_comparacion.html` ya regenerado). `40_salidas/motor_comparacion.html` está en `.gitignore` (regenerable); solo `docs/index.html` se versiona para Pages.

---

## 5. Backlog acumulativo del proyecto

> **⚠️ NOTA DE CONTINUIDAD (heredada de v09, aún sin resolver):** El backlog histórico acumulativo de las sesiones 1–8 no se ha consolidado íntegramente en un solo lugar (el v09 documentó solo su delta y dejó esta tarea pendiente; el v08 nunca llegó a adjuntarse en sesión 9 ni 10). **Antes de archivar definitivamente, copiar el backlog completo desde `traspaso_cierre_v08.md` y renumerar correlativamente.** Lo que sigue documenta el delta de las sesiones 9 y 10.

### Cambios de la sesión 9 (REPO/DOC/Infra)
1. Cierre en Git del trabajo pendiente de la sesión 8. — REPO
2. Publicación del motor en GitHub Pages. — Despliegue
3. Documentación del procedimiento de publicación. — DOC
4. Escáner con auto-poda de snapshots. — Infra
5. Limpieza de artefactos obsoletos. — REPO
6. Consolidación de `estructura_proyecto.md` en README. — DOC

### Cambios de la sesión 10
7. Diagrama de arquitectura HTML standalone. — DOC
8. Actualización de `CLAUDE.md` al estado real post-v09. — DOC
9. Documentación conceptual del proyecto (md + html). — DOC
10. Remoción del panel de ajustes del motor (P3). — UI
11. Eliminación de franja de tabla y contacto en notas (P4 reformulado). — UI
12. Deploy a Pages y sincronización de snapshots. — REPO

### 5.3 Clasificación temática (taxonomía vigente)

| Código | Categoría |
|--------|-----------|
| P | Pipeline R |
| UI | Motor HTML / React / D3 |
| D | Datos / Insumos |
| DOC | Documentación |
| REPO | Gobernanza del repo / Despliegue |
| Infra | Infraestructura (escáner, orquestador, CI) |
| DT | Deuda técnica |

---

## 6. Bugs encontrados y su resolución

No aplica en esta sesión. No se manifestaron bugs de software. El único punto de fricción fue de proceso (no de código): durante el deploy hubo una hipótesis incorrecta de Claude sobre que el build no se había regenerado, cuando en realidad `docs/index.html` ya tenía los cambios desde el primer commit. Se resolvió verificando con `git show --stat` y `grep` sobre el archivo publicado. Aprendizaje en sección 7.

---

## 7. Aprendizajes y restricciones técnicas descubiertas

- **Regla:** Las anomalías A1–A4 son normalizaciones de datos de origen (Agencia de Calidad), no defectos del proyecto. Documentarlas como decisiones resueltas, nunca como alertas.
  - **Principio relacionado:** C.11 (transparencia del cambio), B.1 (sin supuestos).
  - **Contexto:** Su definición vive en `referencia_glosas_simce.md`. A1: sufijo `_2m_` en 2018/4b. A2: `marca_eda_*` solo en 2014. A3: `cod_com_rbd` corrupto en 2015/2m, 2015/4b, 2017/4b → join al directorio. A4: códigos pre-Ñuble 8401–8421 → remapeo a 16101–16207.
  - **Ejemplo:** El diagrama las muestra como bloque verde "Normalizaciones de origen resueltas" en la etapa 31.

- **Regla:** Antes de afirmar que un deploy falló, verificar el estado real del archivo publicado (`git show --stat`, `grep` sobre el archivo), no inferir desde la ausencia de cambios en `git status`.
  - **Principio relacionado:** B.1 (sin supuestos), C.9 (fallar temprano con diagnóstico correcto).
  - **Contexto:** `git status` no mostraba `docs/index.html` porque ya era idéntico al commiteado — señal de que el cambio YA estaba publicado, no de que faltara. La interpretación inicial fue la opuesta.
  - **Ejemplo:** Dos rondas de `cp` + `00_build.R` innecesarias (inofensivas por idempotencia, pero evitables).

- **Regla:** Al quitar un control de UI, distinguir el estado que solo alimentaba ese control (huérfano, se elimina) del que también consumen otros componentes (se conserva como constante).
  - **Principio relacionado:** B.3 (cambios quirúrgicos), limpieza de código huérfano.
  - **Contexto:** `density` era huérfano tras quitar el panel; `showElemInsuf` y `yScale` los usaba el gráfico → se hardcodearon como constantes en vez de eliminarse.
  - **Ejemplo:** `const showElemInsuf = true; const yScale = "100";` reemplazaron al `useState`.

- **Regla:** El nombre de archivo con prefijo de tipo (`arquitectura_`, `documentacion_proyecto_`) habilita búsqueda cross-proyecto. Mantener la convención al crear documentación.
  - **Principio relacionado:** D (naming), C.11.
  - **Contexto:** El usuario renombró la presentación a `documentacion_proyecto_slep_simce_adecuado.md` para poder localizar todas las documentaciones de sus proyectos.

---

## 8. Decisiones de diseño tomadas

| ID | Decisión | Alternativas consideradas | Justificación | Implicancia |
|----|----------|---------------------------|---------------|-------------|
| DD10.1 | Diagrama de track único lineal | Replicar track dual del modelo | Este pipeline no tiene flujos paralelos | Se descartó `.dual` y el conector SVG de merge |
| DD10.2 | A1–A4 como banderas verdes "resueltas" | Cajas rojas de alerta (versión inicial) | No son errores del proyecto; cajas rojas no son compartibles | Las 4 en etapa 31 (todas son normalización de lectura) |
| DD10.3 | Quitar el botón de ajustes completo | Quitar solo el control de densidad | Espíritu de P3: simplificar UI para compartir | Se pierden toggles Elemental/Insuficiente y escala Y |
| DD10.4 | `showElemInsuf`/`yScale` como constantes | Eliminarlos | Los consume el gráfico, no solo el panel | Hardcodeados en su default (true / "100") |
| DD10.5 | Contacto en notas, no en header | Header (revertido); `mailto:` clickeable | En header se veía mal; en notas es sutil | Visible solo al desplegar notas; sin `mailto:` |
| DD10.6 | CSS huérfano diferido | Limpiarlo ahora | Riesgo de tocar selectores compartidos sin ver el archivo completo | Deuda menor registrada (11.2) |
| DD10.7 | Presentación como render fiel del md | Pieza híbrida con mini-diagramas | El diagrama ya cubre lo visual; evitar competencia entre piezas | HTML legible, complementario al diagrama |

---

## 9. Constantes, configuraciones y parámetros vigentes

| Constante | Valor actual | Archivo | Nota |
|-----------|-------------|---------|------|
| `showElemInsuf` | `true` (const) | `33_motor_template.html` | Nuevo en v10: era estado, ahora fijo |
| `yScale` | `"100"` (const) | `33_motor_template.html` | Nuevo en v10: era estado, ahora fijo |
| `containerClass` | `"app is-comfy "` | `33_motor_template.html` | Densidad fija; `density` eliminado |
| `RETENER_SNAPSHOTS` | `2L` | `00_escanear_proyecto.R` | Sin cambios desde v09 |
| Fórmula agregación | `sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100` | `10_utils/10_utils.R` | Sin cambios |
| Umbral MINEDUC | `nalu >= 10` | `10_utils/10_utils.R` | Sin cambios |
| URL Pages | `https://tomgc.github.io/slep_simce_adecuado/` | (config GitHub) | Sin cambios |

---

## 10. Arquitectura de archivos relevante

El output del escáner al cierre vive en `50_documentacion/estructura/estructura_actual.md` (sello más reciente `20260609_131229`). Cambios estructurales de esta sesión:

- Tres archivos nuevos en `50_documentacion/activa/`: `arquitectura_slep_simce_adecuado.html`, `documentacion_proyecto_slep_simce_adecuado.md`, `documentacion_proyecto_slep_simce_adecuado.html`.
- Snapshots de estructura sincronizados con Git (auto-poda dejó 2 sellos + aliases).

**Verificación contra política:** la estructura sigue respetando `POLITICA_PROYECTO.md`. La documentación nueva está correctamente ubicada en `50_documentacion/activa/`. Nota: la copia local de `POLITICA_PROYECTO.md` tiene dos desfases respecto al estado real (ver pendiente en 11.1).

---

## 11. Tareas pendientes, próximos pasos y ruta sugerida

### 11.1 Inventario de pendientes

#### Pendiente 1: Sustituir POLITICA_PROYECTO.md local por la canónica

- **Descripción:** La copia local de `POLITICA_PROYECTO.md` tiene dos desfases: (1) sección 10 cita `estructura_proyecto.md`, eliminado en v09; (2) sección 9 dice "Datos crudos xlsx no se versionan", cuando sí se versionan. Lo correcto es sustituir la copia local por la canónica de la knowledge base, no editar la copia.
- **Contexto:** Detectado en sesión 10; no se tocó porque la política es canónica de la knowledge base.
- **Tipo:** Documentación.
- **Impacto:** La copia local contradice el estado real y al README.
- **Dependencias:** Requiere la versión canónica desde la knowledge base.
- **Complejidad estimada:** Baja.
- **Principios relevantes:** B.1, C.11.
- **Precauciones:** No parchear la copia local; sustituirla.
- **Criterio de éxito sugerido (B.4):** La `POLITICA_PROYECTO.md` del repo coincide con la canónica y no contradice el estado real.

#### Pendiente 2: Limpiar CSS huérfano del motor

- **Descripción:** Tras quitar el panel (Cambio 4) y la franja de tabla (Cambio 5), quedaron reglas CSS sin uso en `33_motor_template.html`: `.twk-*` (estilos del panel), `.app.is-compact` y derivadas (9 reglas), `.table-legend` (2 reglas), el comentario `/* TweaksPanel */`, y el icono `gear` en el catálogo de `Icon`.
- **Contexto:** Diferido en sesión 10 para no tocar selectores compartidos sin ver el archivo completo.
- **Tipo:** Deuda técnica.
- **Impacto:** Código muerto; no afecta render ni peso percibido.
- **Dependencias:** Toca `33_motor_template.html`; requiere redeploy.
- **Complejidad estimada:** Baja-Media.
- **Principios relevantes:** Limpieza de código huérfano, B.3.
- **Precauciones:** `.btn-ghost`/`.btn-small` los usaba el botón de ajustes pero pueden usarse en otros botones; verificar antes de borrar. Trabajar con el archivo completo a la vista.
- **Criterio de éxito sugerido (B.4):** `grep` de `twk-`, `is-compact`, `table-legend`, `gear` no encuentra nada en el HTML servido; el motor renderiza idéntico.

#### Pendiente 3: P2 — Exportación de gráficos como imagen (PNG/SVG desde DOM)

- **Descripción:** Permitir exportar los gráficos del motor como imagen.
- **Tipo:** Funcionalidad nueva / UI.
- **Complejidad estimada:** Media.
- **Criterio de éxito sugerido (B.4):** Un control exporta el gráfico visible como PNG o SVG descargable.

#### Pendiente 4: D3 — Limpiar estado `region` sin uso en tab comuna del modal

- **Descripción:** Estado `region` huérfano en el tab comuna del modal de edición de entidad.
- **Tipo:** Deuda técnica.
- **Complejidad estimada:** Baja.

#### Pendiente 5 (heredado, diferible): Optimización del peso del HTML

- **Descripción:** Separar el JSON del HTML (fetch externo) para reducir el HTML servido de ~14,5 MB a ~200 KB.
- **Tipo:** Mejora de UX.
- **Complejidad estimada:** Media (toca `33_generar_html.R`).
- **Sugerencia de enfoque:** Solo si la carga inicial molesta en la práctica.

#### Pendiente 6 (administrativo): Consolidar backlog histórico v01–v08

- **Descripción:** Copiar el backlog completo de las sesiones 1–8 desde `traspaso_cierre_v08.md` y renumerar correlativamente (heredado de v09).
- **Tipo:** Documentación.
- **Complejidad estimada:** Baja (requiere adjuntar v08).

#### Pendiente 7 (opcional): Sumar documentación nueva al README

- **Descripción:** En la sección "Documentación" del README, enlazar el diagrama de arquitectura y la presentación conceptual.
- **Tipo:** Documentación.
- **Complejidad estimada:** Baja.

### 11.2 Evaluación de deuda técnica

- **Zona frágil:** `33_motor_template.html` — CSS huérfano tras la remoción del panel (ver pendiente 2). No es frágil funcionalmente, pero acumula código muerto que confunde futuras ediciones.
- **Oportunidad de mejora:** Limpieza de CSS + icono `gear` en una pasada dedicada con el archivo completo cargado.

### 11.3 Auditoría de cierre

- ¿Cada bloque de transformación tiene un check de validación? (C.8) → **Sí** — no se tocó la lógica del pipeline; los checks de sesiones previas siguen vigentes (el build los ejecutó: validación de `cod_grupo`, conteo de filas por llave, NAs por columna).
- ¿Los outputs son reproducibles e idempotentes? (C.2, C.3) → **Sí** — `00_build.R` corrió de cero en 3 s y regeneró todos los parquets y el HTML.
- ¿Hay decisiones metodológicas documentadas como constantes con nombre? (C.11) → **Sí** — invariantes sin cambios; `showElemInsuf`/`yScale` ahora son constantes nombradas en el motor.

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

## Ruta sugerida para la próxima sesión

1. **Limpiar CSS huérfano del motor (pendiente 2)** — deuda técnica concreta de esta sesión; abordarla con el archivo completo cargado evita reintroducir el panel por error. Criterio: `grep` limpio + render idéntico.
2. **Sustituir POLITICA_PROYECTO.md local (pendiente 1)** — copy-paste desde la knowledge base; resuelve dos contradicciones de una. Criterio: coincide con la canónica.
3. **P2 — Exportación de gráficos (pendiente 3)** — funcionalidad nueva; abordar con contexto fresco. Criterio: gráfico exportable a PNG/SVG.

**Diferir para sesión posterior:**
- Optimización del peso del HTML (pendiente 5) — solo si molesta en la práctica.
- Consolidación del backlog v01–v08 (pendiente 6) — requiere adjuntar v08; tarea administrativa.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **ANTES** de limpiar CSS en `33_motor_template.html` (pendiente 2), verificar que `.btn-ghost`/`.btn-small` no se usen en otros botones además del ya removido panel de ajustes.
- ⚠️ **ANTES** de tocar el motor, verificar que `SimceData.getSeriesForEntity` sigue siendo el punto de entrada único de la lógica de series. No agregar ternarios inline por `kind`.
- ✅ **DESPUÉS** de cualquier cambio en `33_motor_template.html`, regenerar (`Rscript 00_build.R`), verificar el render local, y solo entonces `cp 40_salidas/motor_comparacion.html docs/index.html` + commit + push.
- ✅ **VERIFICAR** el deploy con `git show --stat` y `grep` sobre `docs/index.html`, no inferir desde `git status` (si `docs/index.html` no aparece en status, puede ser que YA esté publicado, no que falte).
- 🔒 La segmentación por GSE es inviolable; ponderación por `nalu` (nunca promedio simple); no mezclar pruebas ni niveles.
- 🔒 El correo de contacto no debe existir como string literal completo en el HTML servido (ensamblado en JS).

---

## 13. Fragmentos de código de referencia

### Estado vs. constante al quitar un control de UI (patrón v10)

```javascript
// Si el valor solo alimentaba el control removido → eliminar.
// Si lo consume otro componente (ej. el gráfico) → conservar como constante fija.
const showElemInsuf = true;   // consumido por RecentBarsSubchart / ChartHints
const yScale = "100";         // idem
// density era huérfano → se eliminó y se hardcodeó containerClass:
const containerClass = "app is-comfy ";
```

### Ofuscación de correo nivel B (ensamblado en JS)

```javascript
// El correo no aparece como string literal completo en el fuente servido.
{["tomas", "gonzalez"].join(".") + String.fromCharCode(64) + ["slepcostacentral", "gob", "cl"].join(".")}
```

### Ciclo de republicación en GitHub Pages (zsh) — verificación incluida

```bash
cd ~/Projects/slep_simce_adecuado
Rscript 00_build.R                                    # 1. regenerar HTML (lee plantilla de 30_procesamiento/)
# 2. verificar render local del motor_comparacion.html en el navegador
cp 40_salidas/motor_comparacion.html docs/index.html  # 3. copiar a docs/
git add docs/index.html && git status                 # 4. si NO aparece, puede que ya esté publicado
git commit -m "deploy: ..." && git push origin main   # 5. Pages reconstruye en 1-2 min
```

---

## 14. Reapertura de la sesión

**Nombre sugerido del chat:** `slep_simce_adecuado, sesión 11 (Opus)`
(Reemplazar "Opus" por el modelo que vayas a usar.)

**Mensaje de apertura:**

> Continuación de sesión sobre el proyecto **slep_simce_adecuado**.
>
> Tipo: CONTINUATION. Los documentos de protocolo (apertura, POLITICA, regla de estructura y principios de desarrollo) viven en la knowledge base de este Project; léelos desde ahí. Adjunto el traspaso, el escáner actual y los archivos críticos de la sesión anterior.
>
> Por favor sigue el protocolo de apertura definido en mis userPreferences y entrega el plan de trabajo en el formato estándar (Estado al cierre / Pendientes / Ruta propuesta / Decisiones que necesitas), basado en el handoff adjunto.

**Documentos para la próxima sesión:**

### Documentos de protocolo (knowledge base del Project)

No requieren adjuntarse; el asistente los lee desde la knowledge base:

- `prompt-apertura-sesion.md`
- `POLITICA_PROYECTO.md`
- `regla_estructura_proyectos.md`
- `principios_desarrollo_v3.md`

### Documentos opcionales según el foco de la próxima sesión

- `asistente_claude_code_seguro.md` — si la próxima sesión se ejecuta en Claude Code (probable para los pendientes 2 y 3, que tocan el motor).

### Documento de traspaso de esta sesión (adjuntar al nuevo chat)

- `50_documentacion/traspasos/traspaso_cierre_v10.md`

### Output del escáner (adjuntar al nuevo chat)

- `50_documentacion/estructura/estructura_actual.md` (correr `00_escanear_proyecto.R` antes de abrir)

### Archivos del proyecto críticos para retomar

- `30_procesamiento/33_motor_template.html` — template React/D3 del motor (~3.200 líneas); voluminoso pero necesario para los pendientes 2 (CSS huérfano), 3 (P2) y 4 (D3). Ver secciones 4 y 11 de este traspaso para contexto.
- `traspaso_cierre_v08.md` — solo si se aborda el pendiente 6 (consolidar backlog histórico).

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
