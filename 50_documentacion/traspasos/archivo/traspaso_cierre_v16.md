# Traspaso de cierre v16 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v16
- **Fecha:** 2026-06-12
- **Sesión:** 16 — foco en cierre en producción de la sesión 15 (push + deploy),
  auditoría Corp. Admin. Delegada (depe=4), y licenciamiento del proyecto bajo
  Apache 2.0. Archivo de decisión D15-1 (color por nivel) replicado.
- **Entorno:** sesión en interfaz web; build, escáner y git ejecutados por el
  usuario en terminal (zsh, macOS) y Positron.
- **Archivos principales creados/modificados:** `LICENSE`, `NOTICE` (nuevos);
  `README.md` (sección de licencia); encabezado Apache en `00_build.R`,
  `00_escanear_proyecto.R`, `30_construir_auxiliares.R`, `31_leer_normalizar.R`,
  `32_agregar_comunal.R`, `33_generar_html.R`; dos archivos de decisión nuevos
  (`20260611_decision_color_por_nivel.md`, `20260611_decision_licencia_apache.md`);
  `verificar_depe4.R` (efímero, no versionado).

## 2. Resumen ejecutivo

Sesión de cierre operativo y gobernanza sobre una base estable. Se confirmó el
push de los 6 commits pendientes de la sesión 15 a origin/main y se validó el
deploy en GitHub Pages (sitio responde 200, licencia detectada). Se resolvió la
auditoría depe=4 con un script de verificación read-only sobre los parquets: el
conteo bajo de establecimientos Corp. Admin. Delegada es **real, no un
artefacto del pipeline** — el universo nacional es de 70 EE, de los cuales solo
1 imparte 4° básico (el resto son técnico-profesionales de enseñanza media), y
el embudo de filtros cuadra exactamente con el agregado comunal (delta 0 en las
36 combinaciones año×nivel×prueba). Se licenció el proyecto bajo Apache 2.0
(desviación documentada de la política §10, que sugería MIT), con `LICENSE`,
`NOTICE` (con cláusula de alcance código-vs-datos), encabezados en los 6 scripts
del pipeline, sección en el README y archivo de decisión. Se replicó D15-1
(color por nivel) como archivo de decisión, cerrando la deuda de gobernanza
heredada. El pipeline se verificó end-to-end tras los cambios: corre limpio en
4 s con el invariante % Adecuado idéntico.

## 3. Estado al cierre

**Qué funciona:**
- Producción al día: `28f0bf3..a6c4c23` en origin/main, sitio Pages 200, GitHub
  muestra "Apache-2.0 license".
- Build completo corre limpio en 4 s (última ejecución exitosa esta sesión, vía
  `Rscript 00_build.R`). Invariante Costa Central 4b/lect idéntico a v15
  (Viña GSE 5: 62.6 en 2014 … 65.0 en 2025).
- Proyecto licenciado: `LICENSE` + `NOTICE` en raíz, encabezado en los 6 scripts
  versionados, README con sección de licencia.

**Qué no funciona / pendiente operativo:**
- Nada bloqueante. El build regeneró `motor_comparacion.html` localmente, pero NO
  se commiteó (el commit de la sesión fue solo scripts + README + docs); el sitio
  en producción no cambió y no había nada nuevo que desplegar.

**Delta respecto a v15:**
- Sesión 15 cerrada en producción (push + deploy confirmados).
- Auditoría depe=4 resuelta (conteo bajo = real).
- Proyecto licenciado (Apache 2.0) — antes sin LICENSE.
- D15-1 replicada como archivo de decisión (pendiente de v15 cerrado).

## 4. Registro detallado de cambios (de la sesión)

1. **Push de 6 commits a origin/main.** Los 5 commits de v15 + el commit del
   traspaso v15 (`28f0bf3`) estaban locales. Push confirmado
   (`87a9f5d..28f0bf3`). Pages reconstruye desde `docs/` en `main`; sitio 200.
2. **Script de auditoría `verificar_depe4.R`** (efímero, raíz). Read-only sobre
   `directorio_oficial_ee.csv`, `simce_rbd.parquet` y `simce_comunal.parquet`.
   Reconstruye el universo depe4, mide presencia en el parquet largo, calcula el
   embudo de filtros por año×nivel×prueba y contrasta `n_final` contra `n_estab`
   comunal. No toca pipeline ni UI.
3. **Auditoría depe=4 resuelta.** Universo = 70 EE depe4 a nivel nacional (33 RM,
   8 Bío Bío, 6 Valparaíso y O'Higgins). Los 70 aparecen en `simce_rbd` (cobertura
   total, 0 ausentes, 0 extra). La caída por prueba×nivel se explica por el nivel
   de enseñanza: 70 EE en 2m, solo 1 en 4b (sector técnico-profesional de media).
   Pérdida total por filtros: 1278→1254 RBD-instancias (~1.9%, toda por marca de
   supresión; `nalu>=10` no elimina ninguna). Embudo vs comunal: delta 0 en las
   36 combinaciones. **Conclusión: conteo bajo = real.**
4. **Archivo de decisión D15-1** `20260611_decision_color_por_nivel.md` en
   `50_documentacion/activa/decisiones/`. Replica la decisión de color fijo por
   nivel (alternativas, justificación, tensión resuelta). Commit `ffe14ef`.
5. **Licencia Apache 2.0.** Decisión de licenciar el código bajo Apache 2.0 en
   lugar del MIT que sugería la política §10. Artefactos: `LICENSE` (texto
   canónico, 201 líneas, copyright Tomás Ignacio González Cifuentes — SLEP Costa
   Central), `NOTICE` (copyright + cláusula de alcance solo-código + componentes
   de terceros: D3 BSD-3, pako MIT/zlib, React MIT),
   `20260611_decision_licencia_apache.md`. Commit `a8e344e`.
6. **Encabezado Apache en los 6 scripts del pipeline.** Bloque de 6 líneas
   (copyright + cláusula License + URL) tras la primera línea de cada banner, sin
   romper el banner descriptivo. En `00_escanear_proyecto.R` se corrigió además
   `Autor : Tomas` → nombre completo. Commit `a6c4c23`.
7. **Sección "Licencia" en el README.** Alcance código-vs-datos explícito
   (código Apache 2.0; datos bajo Condiciones de Uso de la Agencia de Calidad).
   Commit `a6c4c23` (junto con los encabezados).

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md` (documento vivo). El
backlog viene de sesiones 1–15 (entradas 1–91). **Esta sesión agrega las
entradas 92–98**, continuando la numeración. El detalle por entrada se anexa a
`backlog_historico.md` al cierre; resumen de la sesión 16:

- **92 (operativo/INFRA):** push + deploy de la sesión 15 a producción.
- **93 (verificación/AUDIT):** auditoría depe=4 (conteo bajo confirmado real).
- **94 (documentación/DOC):** archivo de decisión D15-1 (color por nivel).
- **95 (legal/LEGAL):** licenciamiento Apache 2.0 (LICENSE + NOTICE + decisión).
- **96 (legal/LEGAL):** encabezado Apache en los 6 scripts del pipeline.
- **97 (documentación/DOC):** sección de licencia en el README.
- **98 (verificación/AUDIT):** verificación end-to-end del pipeline post-licencia
  (build limpio 4 s, invariante intacto).

**Delta del backlog:** 7 entradas nuevas (92–98). Posible categoría nueva LEGAL
(2 entradas) a evaluar en la próxima refinación de taxonomía; por ahora puede
absorberse en DOC/INFRA. Total acumulado: 98.

## 6. Bugs de la sesión

No aplica en esta sesión. No se reportaron ni detectaron bugs. La sesión fue de
cierre operativo, verificación y gobernanza; el único riesgo (encabezados de
comentario rompiendo el parseo de los scripts) se descartó con el build limpio
end-to-end.

## 7. Aprendizajes y restricciones descubiertas

- **Licencia ≠ autoría.** La autoría (crédito) se conserva con cualquier
  licencia; la licencia define qué pueden hacer terceros con el código. Las tres
  permisivas/copyleft exigen conservar el aviso de copyright.
- **Apache 2.0 sobre MIT para proyectos institucionales públicos.** Misma
  permisividad que MIT más concesión expresa de patentes y mejor aceptación en
  oficinas de cumplimiento open source; relevante si el proyecto se replica por
  otros SLEP o servicios del Estado. Costo: archivo más largo + NOTICE.
- **El cambio de licencia rige hacia adelante.** No revoca derechos de quien ya
  obtuvo el código; por eso se fija antes del primer release difundido.
- **La licencia cubre solo el código.** Los datos SIMCE siguen bajo las
  Condiciones de Uso de la Agencia de Calidad (política §6.4); el NOTICE lo
  declara explícitamente. Regla aplicable a cualquier proyecto del equipo con
  datos de la Agencia.
- **Conteo bajo no es sinónimo de bug.** Un universo intrínsecamente pequeño
  (70 EE, 1 en 4b) produce series legítimamente ralas. La auditoría con doble
  camino (embudo vs agregado) lo confirma sin ambigüedad. Antes de "arreglar" un
  conteo sospechoso, verificar si el universo lo explica.
- **Comando R en zsh falla.** `source("x.R")` es R, no shell; en terminal se corre
  con `Rscript x.R` o desde la consola de Positron. (Síntoma observado:
  `zsh: unknown file attribute`.)

## 8. Decisiones de diseño

- **D16-1: Licencia Apache 2.0 (desviación de política §10).** Alternativas:
  MIT (statu quo de la política; permisiva pero sin patentes) y GPLv3 (copyleft;
  descartada por bloquear adopción). Elegida Apache 2.0 por concesión de patentes
  + aceptación institucional sin perder permisividad. Documentada en
  `decisiones/20260611_decision_licencia_apache.md`. Implicancia: considerar
  enmendar política §10 para reflejar Apache 2.0 como opción equivalente a MIT.
- **D16-2: Titular del copyright = "Tomás Ignacio González Cifuentes — SLEP Costa
  Central".** El usuario confirmó nombre personal + institución. (Nota: si en el
  futuro se determina que la obra es del servicio por desarrollo como funcionario,
  el titular podría pasar a ser solo el SLEP; no se profundizó.)
- **D16-3: Encabezado en los 6 scripts versionados, no en los efímeros.** Opción
  3 de las planteadas: cubrir todo el código versionado, excluir `verificar_*.R`
  (no entran a Git). El LICENSE de raíz cubre el repo; los encabezados son buena
  práctica por archivo.

## 9. Constantes y parámetros vigentes (cambios de la sesión)

No aplica en esta sesión. No se introdujeron ni modificaron constantes de
cálculo ni de UI. `UMBRAL_NALU = 10` aparece en `verificar_depe4.R` como
réplica del umbral MINEDUC ya vigente en `agregar_ponderado()`, no como
constante nueva del proyecto.

## 10. Arquitectura de archivos

Referencia: escáner al cierre `estructura_actual.md` (2026-06-12 08:04:47,
17 carpetas / 108 archivos). Delta vs v15 (101 archivos): +7 netos — nuevos
`LICENSE`, `NOTICE`, `verificar_depe4.R` (raíz), dos archivos de decisión, y dos
snapshots nuevos del escáner (los anteriores podados por retención=2). Sin
cambios de carpetas. El escáner retiene los 2 sellos más recientes; el vigente
más nuevo es `20260612_080447`.

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

| Pendiente | Tipo | Complejidad | Notas |
|---|---|---|---|
| Segmentación histórica por año de traspaso | funcionalidad de fondo | alta | Distinguir visualmente serie pre/post traspaso de un SLEP. Pipeline + lógica de series. Sesión dedicada. Único pendiente alto vivo |
| Observación de gobernanza: 4b/depe4 = 1 EE | mejora / gobernanza | baja | Una serie comunal×GSE de 4b filtrada a depe4 puede ser un único establecimiento (no anónimo en la práctica). Evaluar si alguna vista del motor expone n_estab y si conviene una salvaguarda. No accionado |
| Enmendar política §10 (MIT → Apache como opción) | documentación | baja | Reflejar D16-1 en la política, o registrar como excepción permanente |
| (Opcional) migrar `exportarCSV` al helper `descargarBlob` | deuda técnica | baja | Heredado de sesiones previas, sin abrir |

**Auditoría de cierre (política 5.6, preguntas "Cierre"):**
- ¿Pipeline reproducible de cero? Sí (build limpio 4 s, invariante verificado).
- ¿Cada transformación crítica con check? Sí (heredado; sin cambios de pipeline).
- ¿Outputs reproducibles e idempotentes? Sí.
- ¿Decisiones metodológicas como constantes nombradas? Sí (sin cambios).
- ¿Nombres sin tildes/ñ/espacios? Sí (los archivos nuevos cumplen).
- Sin hallazgos nuevos que generen pendientes no listados.

**Ruta sugerida para la sesión 17 (en orden):**
1. **Segmentación histórica por año de traspaso** (único pendiente alto; con
   contexto fresco conviene abordarlo en sesión dedicada). Criterio de éxito:
   el motor distingue visualmente la serie pre/post traspaso de un SLEP, con el
   pipeline soportando el corte por año.
2. **Enmendar política §10** (rápido, cierra la desviación documentada de D16-1).
3. Evaluar la observación 4b/depe4=1 EE si se decide accionar.
4. Diferir: `exportarCSV` → `descargarBlob` (mejora menor).

## 12. Instrucciones específicas para la próxima sesión

- 🔒 **Color por nivel es invariable:** Adecuado/Elemental/Insuficiente con color
  fijo (`COLOR_ADEC`/`COLOR_ELEM`/`COLOR_INSUF`), igual en todas las entidades.
  NO atar el color del dato a `entity.color`.
- 🔒 **% Adecuado intocable:** todo cambio que toque el pipeline verifica el bloque
  Costa Central 4b/lect idéntico al build previo.
- 🔒 **La licencia cubre solo el código.** Cualquier salida que incluya datos
  reales sigue bajo las Condiciones de Uso de la Agencia de Calidad; no
  redistribuir bases ni identificar establecimientos por nombre.
- ✅ ANTES de correr scripts desde la terminal: usar `Rscript x.R`, no
  `source("x.R")` (eso es R, no zsh).
- ✅ ANTES de commitear el motor regenerado: si se tocó template o datos,
  regenerar y copiar a `docs/index.html`; si no, no commitear el HTML.
- ⚠️ Los `verificar_*.R` de la raíz son efímeros (sin trackear a propósito); no
  versionarlos salvo decisión explícita.
- ⚠️ NO renombrar al titular del copyright sin confirmar con el usuario (ver
  D16-2).

## 13. Fragmentos de código de referencia

```r
# Encabezado de licencia Apache 2.0 — va tras la primera línea del banner de
# cada script versionado, antes de la línea de guiones.
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
```

```r
# Patrón de auditoría de universo (verificar_depe4.R): embudo de filtros con
# n_distinct condicional, contrastado contra el agregado. La forma correcta de
# confirmar si un conteo bajo es real o artefacto.
embudo <- df_rbd |>
  dplyr::filter(cod_depe2 == "4") |>
  dplyr::summarise(
    n_rbd_total = dplyr::n_distinct(rbd),
    n_final     = dplyr::n_distinct(rbd[!is.na(cod_grupo) & !is.na(nalu) &
                    nalu >= UMBRAL_NALU & is.na(marca) & !is.na(palu_eda_ade)]),
    .by = c(anio, nivel, prueba)
  )
# delta = n_final - n_estab_comunal; si 0 en todas las combinaciones, el conteo
# es real (no hay pérdida silenciosa entre 31 y 32).
```

```bash
# Correr pipeline o escáner desde terminal (NO source()):
cd ~/Projects/slep_simce_adecuado && Rscript 00_build.R
cd ~/Projects/slep_simce_adecuado && Rscript 00_escanear_proyecto.R
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 17 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  > (POLÍTICA + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto el
  > traspaso v16 y el escáner actual. Foco de la sesión: segmentación histórica
  > por año de traspaso (distinguir serie pre/post traspaso de un SLEP en el
  > motor). Pendiente menor: enmendar política §10 (licencia).

- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar que estén al día):
     `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si la sesión corre en Claude Code; para
     la segmentación histórica, `31_leer_normalizar.R`, `32_agregar_comunal.R` y
     `33_motor_template.html` (la lógica de series vive en el template); el
     listado SLEP con años de traspaso si se necesita el corte por año.
  3. *Específicos de la sesión (SÍ adjuntar):* `traspaso_cierre_v16.md`;
     `estructura_actual.md`.

- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo en el mensaje de apertura.
