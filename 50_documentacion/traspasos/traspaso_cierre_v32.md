# Traspaso de cierre v32 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`, motor de comparación interactivo de resultados Simce por estándares de aprendizaje.
- **Versión del traspaso:** v32. **Fecha:** 2026-09-24 (la sesión abrió el 2026-09-23). **Sesión:** 32.
- **Foco:** decidir el destino de la rama local `feat/contrato-contexto` y trasladar la vista de trayectorias de `andamios/` a `30_procesamiento/` (paso 36).
- **Entorno:** Cowork con puente a la estación macOS (lectura, edición de archivos y pruebas en R, V8 y Chromium dentro del contenedor del asistente); todo commit y push delegados a Claude Code en la estación, por cuatro corridas (una instrucción de publicación, el encargo, su adenda y la reanudación).
- **Normativos usados:** `POLITICA_PROYECTO.md` con encabezado `**Versión 5.8 — vigente.**` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` con encabezado `**Versión 38.**`, desde la knowledge base; iguales a las copias de `activa/`.
- **`main` previo al commit de cierre:** `4c5cc3a` (igual a `origin/main`).
- **Archivos principales creados o modificados:** `30_procesamiento/36_funciones_trayectorias.R`, `36_generar_trayectorias.R`, `36_verificar_trayectorias.R`, `36_trayectorias_template.html` (nuevos), `00_build.R`, `.gitignore`, `50_documentacion/activa/50_datos_versionados_autorizados.md`, `50_documentacion/activa/decisiones/20260924_decision_datos_vista_trayectorias.md` (nuevo), tres encargos en `activa/encargos/` y sus tres logs en `andamios/logs/`.

## 2. Resumen ejecutivo

La sesión abrió sin el eco de `/apertura`; el candado se midió a mano en lectura y `/apertura` corrió después (`d510754`). La rama local `feat/contrato-contexto` resultó tener solo dos commits de trabajo real, para el consumidor `slep_minuta_buenas_senales`: el cierre de la sesión 26 que el traspaso v31 daba por ausente ya estaba en `main`. Se publicó sin integrar (D32-1) tras autorizar su parquet en `main`, porque el hook pre-push lee la lista del árbol de trabajo (`760ce01`). El diagnóstico B31-4 resultó errado: el mockup nunca excluyó el grupo 5; el referente y la nube se anclan a los municipales con resultado en 2014, y el titular mantuvo esa regla (D32-2). El traslado se construyó en R, fue fiel al mockup celda a celda, y destapó que 655 cifras eran empates que la coma flotante resolvía distinto en cada plataforma: el titular eligió redondeo en aritmética entera (D32-3), que da el mismo HTML byte a byte en x86_64 y en la estación aarch64. El paso 36 quedó commiteado y publicado (`7768383`, push hasta `4c5cc3a`). Una revisión de forma sin red en 332 estados no encontró regresiones, pero sí nueve defectos de forma heredados del mockup, que son la prioridad propuesta para la próxima sesión.

## 3. Estado al cierre

**Qué funciona.**

- `00_build.R` regenera `40_salidas/trayectorias_traspasos.html` en el paso 36, sin red: 0 cargas externas y 0 errores de consola en 332 estados recorridos en Chromium sin conexión (fuente: logs de la reanudación y workflow `wf_5ed2b111-9b0`).
- `Rscript 30_procesamiento/36_verificar_trayectorias.R`: 17 pruebas, 17 en PASA, en la estación (fuente: `20260923_traslado_trayectorias_reanudacion_log.md`).
- La vista es reproducible: md5 `8b0a586bf9577e5164d7f10e2fadd835` en la estación (aarch64, dplyr 1.2.0, arrow 24.0.0) y en el entorno del asistente (x86_64, dplyr 1.2.1, arrow 25.0.1) (fuente: `md5sum` en la estación en esta sesión y log de la reanudación).
- El motor publicado no cambió: `docs/index.html` md5 `5fcb5d9a4baa052f28010d31923c1855` (fuente: `md5sum` en la estación).
- Última ejecución completa del pipeline: `Rscript 00_build.R`, código 0, en la reanudación (`4c5cc3a`).

**Qué no funciona o queda a medias.**

- Nueve defectos de forma de la vista de trayectorias, heredados del mockup (pendiente 1).
- La vista incluye filas con marca de la Agencia (2.008 filas, 74.726 evaluados de 7.215.717 en su base) que el motor excluye (fuente: conteo con pandas en el entorno del asistente sobre `simce_rbd.parquet`); es una regla distinta entre vistas, declarada en las notas de la vista pero no decidida (pendiente 4).
- `V8` y `openssl` siguen fuera de `renv.lock` (bloqueado por `suitedoc`).

**Delta respecto de v31.** La vista de trayectorias sale de `andamios/` y la regenera el pipeline en R. El motor no cambió.

## 4. Registro detallado de cambios

**4.1 Apertura y rama local (REPO).** Candado 0bis medido a mano en lectura (árbol limpio, `HEAD` = `origin/main`, `commit_cierre` ancestro, `ESTADO.md` idéntico); `/apertura` corrió después (`d510754`). Candado huérfano `.git/objects/maintenance.lock` (2026-09-09) movido a `_archivo/20260923/` por Claude Code. Medición de la rama (duda 4 de v31): 9 commits en `main..feat`, 6 con parche equivalente en `main` (`git cherry`), incluido el cierre de la sesión 26; solo `6e00830` y `31befa2` son trabajo propio. Decisión D32-1: publicar sin integrar. El primer push fue rechazado por el hook (R1, parquet sin autorizar; ERR-32-01); la autorización se escribió en `main` (`760ce01`), porque el hook lee la lista del árbol de trabajo, y la rama se publicó en `31befa2` sin cambiar.

**4.2 Diagnóstico de B31-4 (D).** Reconstrucción del DATA del mockup en R: universos, órdenes y redondeo, comprobados celda a celda. El mockup no filtra grupos: el referente y la nube son municipales fuera del catálogo con resultado en 2014 (1.333 establecimientos y 180 comunas, iguales con o sin grupo 5); el único municipal fuera de los Servicios Locales con grupo 5 (6 filas, 2022-2024) no tiene resultado en 2014. Las Condes, 4° básico Lectura 2023: 271 con el ancla, 344 sin ella. D32-2: se mantiene el ancla.

**4.3 Traslado al paso 36 (P).** `36_funciones_trayectorias.R` (universos, agregación, DATA, JSON), `36_generar_trayectorias.R` (plantilla, chequeo sin red, escritura atómica), `36_trayectorias_template.html` (el mockup con el literal de datos reemplazado por `__DATA_TRAYECTORIAS__`, prefijo y sufijo byte a byte iguales), `36_verificar_trayectorias.R` (D1 a D8 del andamio; D9 a D13 nuevas, con controles positivos D9c, D10c, D12c y D13c). `00_build.R` gana el paso 36; `.gitignore` ignora la salida y `Claude outputs/`. Tres corridas: el encargo congeló T1 por un esperado dependiente de plataforma (ERR-32-03); la adenda se detuvo en FASE 0 por `Claude outputs/` (ERR-32-04); la reanudación completó T1 (`7768383`) y publicó (`4c5cc3a`), FASE R `APROBADO CON ADVERTENCIAS` (0/0/2).

**4.4 Redondeo en aritmética entera (P).** D32-3: porcentajes con numerador y denominador enteros y empates hacia arriba. Tres verificadores independientes no pudieron refutarlo (workflow `wf_13100bb7-0b7`), y la reanudación lo re-derivó en R base sobre las 68.840 cifras: 0 distintas del HTML; las 316 distintas del mockup son empates exactos un décimo arriba.

**4.5 Revisión de forma sin red (UI, verificación).** Tres recorridos independientes en Chromium sin conexión, 332 estados, generador contra mockup: 0 defectos introducidos por el traslado; nueve defectos heredados (pendiente 1). Checklist de diez puntos entregada al titular para Safari (duda 1).

**4.6 Decisión documentada (DOC).** `activa/decisiones/20260924_decision_datos_vista_trayectorias.md` con D32-2 y D32-3.

**Registro de ejecución detallado:** `50_documentacion/andamios/logs/20260923_traslado_trayectorias_log.md`, `20260923_traslado_trayectorias_adenda_log.md` y `20260923_traslado_trayectorias_reanudacion_log.md` (logs de Claude Code; detalle no reproducido aquí).

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 4 entradas.

## 6. Bugs de la sesión

**B31-4 (reabierto y cerrado): diagnóstico errado.** Síntoma atribuido: el `T` de la nube y del referente excluía el grupo 5. Causa real: la regla del universo anclado a 2014, declarada en las notas de la vista. Verificación: D9 y la reconstrucción celda a celda. **Patrón:** una diferencia entre dos conteos se atribuye al mecanismo solo después de reproducirlo; «falta el grupo X» y «falta un subconjunto que casualmente es del grupo X» dan la misma cifra. Estado: cerrado sin cambio de código.

**B32-1: redondeo no reproducible entre plataformas.** Síntoma: D10 dio 13 cifras distintas del mockup en la estación y 3 en el entorno del asistente. Causa: 655 empates exactos resueltos por el ruido de coma flotante, sensible a la plataforma y al orden de suma (`36_funciones_trayectorias.R`, agregación). Solución: redondeo entero (D32-3). Verificación: D13 y md5 idéntico en dos plataformas. **Patrón:** con porcentajes publicados con un decimal y conteos enteros, el agregado se calcula y se redondea en enteros; la coma flotante vuelve azaroso cada empate. Estado: resuelto.

## 7. Aprendizajes y restricciones descubiertas

1. **A32-1: un esperado numérico medido en una plataforma no es criterio en otra.** Lo que se exige es la afirmación («0 fuera de empate»), no el conteo que la acompaña. Ejemplo: 3 contra 13 (ERR-32-03).
2. **A32-2: el hook pre-push lee la lista de autorizados del árbol de trabajo desde el que se publica, no del commit publicado.** Publicar una rama con datos exige la entrada en la rama activa al hacer push. Ejemplo: `760ce01`.
3. **A32-3: entregar archivos al chat con una carpeta conectada deja copias en `Claude outputs/` dentro de ella.** Desde esta sesión la carpeta está en `.gitignore`; aun así, nada se entrega al chat entre la medición del estado de un encargo y su ejecución. Ejemplo: ERR-32-04.
4. **A32-4: en Claude Code las variables de shell no sobreviven entre llamadas.** El scratch de un encargo va con ruta literal (`/tmp/slep_s32_traslado`), nunca en `$S`.
5. **A32-5: un encargo encadenado (encargo, adenda, reanudación) necesita precedencia escrita y reemplazo explícito de cada regla que cambia.** Dos revisores encontraron dos detenciones seguras en la reanudación antes de enviarla (regla 1 contra `HEAD` adelantado; el LOG como línea más del `status`).

## 8. Decisiones de diseño

- **D32-1: `feat/contrato-contexto` se publica sin integrar** y el traslado toma el paso 36. Alternativas: integrar (35 para el contrato) o archivar con etiqueta (35 libre). Razón: quita el riesgo de pérdida sin tocar `main` y el 36 sirve con cualquier destino futuro del contrato.
- **D32-2: el referente y la nube conservan el ancla de 2014.** Archivo `decisiones/20260924_decision_datos_vista_trayectorias.md`.
- **D32-3: redondeo en aritmética entera, empates hacia arriba.** Mismo archivo.
- **D32-4: la autorización del parquet de la rama vive en `main`.** Razón: el hook la lee del árbol de trabajo; un commit en la rama no la habría hecho visible.
- **D32-5: no se crea `CLAUDE.md`.** El `.gitignore` lo excluye a propósito (la gobernanza vive en la knowledge base).

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `DEPE_MUNICIPAL` | no existía | `"1"` | `36_funciones_trayectorias.R` | universo del referente y la nube |
| `SUMA_NIVELES_MIN` / `MAX` | no existían | `99` / `101` | idem | filas con niveles coherentes (regla del mockup) |
| `DECIMALES_PCT` / `ESCALA_PCT` | no existían | `1L` / `10L` | idem | redondeo entero (D32-3) |
| `ORDEN_SLEP` | no existía | 36 códigos, norte a sur, RM al final | idem | numeración de burbujas heredada del mockup |
| `ID_REFERENTE`, `NOM_REFERENTE`, `NP_TODO`, `GSE_TOTAL` | no existían | `"REF"`, `"Referente municipal"`, `"todo"`, `"T"` | idem | claves de `DATA` |
| `MARCADOR_DATA_TRAY`, `PATRON_RED` | no existían | `__DATA_TRAYECTORIAS__`, `(src|href)="https?:` | `36_generar_trayectorias.R` | inserción y chequeo sin red |

Fuente canónica de las vigentes: los dos scripts citados.

## 10. Arquitectura de archivos

Nuevos en `30_procesamiento/`: el paso 36 (cuatro archivos). `40_salidas/trayectorias_traspasos.html` es salida ignorada. El mockup y `verificar_trayectorias.R` quedan congelados en `andamios/`. Nuevo `activa/decisiones/20260924_decision_datos_vista_trayectorias.md`. Escáner regenerado por el ejecutor al cierre.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Defectos de forma de la vista de trayectorias, heredados del mockup.** Tipo: mejora visual y bug de interfaz. Contexto: revisión de 332 estados (workflow `wf_5ed2b111-9b0`), todos también en el mockup: (a) errata «mediciónes»; (b) porcentajes con punto decimal en el tooltip; (c) «Solo grupo alto» vacío sin aviso, y la tarjeta muestra conteos del total de grupos (`clave('T')`) cuando el grupo elegido no tiene datos; (d) burbujas amontonadas con números ilegibles en las cohortes 2025 y 2026, y burbujas que cruzan el eje Y cuando Adecuado es cercano a 0; (e) referente tapado y su tooltip inalcanzable en 6 de 9 años (cohorte 2018); (f) contraste de las cifras en burbujas rellenas (2,85:1) y del texto gris secundario (4,09:1) en tema claro; (g) tabla lateral que no cabe a 1366 px con 10 u 11 filas; (h) texto del SVG que escala con el ancho (unos 12 px a 1366 y 20 px a 1920); (i) en las notas, un título separado de su texto, y el modal que reabre desplazado. Complejidad: media. Principios: A31-1 (lista de forma en pantalla y exportación). Precaución: se editan en `30_procesamiento/36_trayectorias_template.html`, nunca en el mockup; D10 compara solo datos, así que no protege la forma. Criterio de éxito: cada punto corregido y re-verificado en su estado, sin regresión en los otros, con 17 de 17 en la batería.
2. **Contraste de las cifras rescatadas del motor** (`#6BA0CE`, 2,78:1; v31 pendiente 3). Tipo: mejora visual. Criterio: ≥ 4,5:1 medido en el panorama y en las barras.
3. **Publicación de la vista de trayectorias.** Hoy no está en `docs/`. Tipo: decisión del titular. Criterio: decidida (publicar, y dónde) y registrada.
4. **Regla de filas de la vista frente al motor.** La vista incluye filas con marca de la Agencia (2.008 filas, 1,0% de los evaluados de su base) y no aplica el umbral de 10 evaluados; el motor excluye ambas (invariante 5). Tipo: decisión metodológica. Criterio: una regla decidida y declarada en las notas de las dos vistas.
5. **Columna vacía en las notas metodológicas del motor.** Heredado.
6. **El panorama desborda bajo ~540 px.** Heredado.
7. **Dudas 2 y 3 de v31** (cifras rescatadas a 375 px; PNG del supergrid) y **dudas 2, 3 y 5 de v30.** Heredadas, sin cambio.
8. **`V8` y `openssl` en `renv.lock`, suite standalone, `documentar.R` y `34_historico`.** Bloqueados por `suitedoc` sin remoto.
9. **Guarda `asegurar_locale_utf8()` ausente**, sin `10_utils/10_configuracion.R` donde instalarla (decisión del titular), y `10_validar_portabilidad.R` sin invocador. Heredados.
10. **Ramas locales sin publicar:** `gobernanza/v16` (su remoto ya no existe), `respaldo_normativos_20260824` y `respaldo_prerebase_20260824`. Tipo: gobernanza del repositorio. Criterio: cada una publicada, archivada o borrada por decisión del titular.
11. **`_archivo/auditoria_agregacion_comunal.R` versionado desde mayo** (`e25ee59`), aunque `_archivo/` está ignorado. Tipo: deuda heredada. Criterio: decidido si sale del índice.
12. **Destino del contrato de contexto** (`feat/contrato-contexto`, consumidor `slep_minuta_buenas_senales`). Tipo: decisión del titular; no bloquea.
13. **Actualización anual Simce 2026.** Bloqueada por insumos.

**Cerrado en esta sesión:** v31 pendiente 1 (rama local), pendiente 2 (traslado, con B31-4 cerrado como diagnóstico errado) y duda 1 de v31 (`V8` y `openssl` cargan en la estación).

**Deuda técnica.** `reemplazar_literal_tray` duplica `reemplazar_literal` de `33_generar_html.R`; con dos usos reales, candidata a `10_utils/` (POLITICA §1.4), en un cambio aparte que toque el paso 33.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero: sí (`00_build.R`, código 0, en la reanudación). Check por transformación crítica: sí (batería de 17). Reproducible e idempotente: sí, byte a byte en dos plataformas (D13 y md5). Constantes nombradas: sí. Nombres sin tildes: sí. Estructura conforme: sí para la vista; **no** para `_archivo/auditoria_agregacion_comunal.R` versionado → pendiente 11. Guarda de locale: **no** → pendiente 9.

### Compuerta de dudas (3 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | La vista se ve bien en Safari de macOS, no solo en Chromium | Los diez puntos de la checklist entregada al titular pasan con el wifi apagado | El titular abre `40_salidas/trayectorias_traspasos.html` en Safari sin red y recorre la checklist |
| 2 | La entrada de la lista de autorizados para una ruta que `main` no contiene no hace fallar I8 | `95_verificar_cierre.R` da I8 en PASA en este cierre | La salida de I8 en el eco de este cierre |
| 3 | El paso 36 corre en otra estación con otras versiones de `jsonlite` y produce el mismo HTML | El md5 del HTML generado en otra estación es `8b0a586bf9577e5164d7f10e2fadd835` | `Rscript 00_build.R` y `md5` del HTML en la segunda estación |

**Ruta sugerida.** Primero, los defectos de forma de la vista (pendiente 1), en un encargo con lista de forma y capturas antes y después. Si queda espacio, el contraste del motor (pendiente 2), que es el mismo tipo de trabajo. Traer a la sesión la decisión de la regla de filas (pendiente 4) y de la publicación (pendiente 3). Diferir el resto.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 `cod_com_rbd` es la clave para agregar por comuna; nunca `nom_com_rbd`.
- 🔒 La segmentación por grupo socioeconómico de la vista de comparación es inviolable; el panorama combina porque es otra vista.
- 🔒 Color por nivel (`D-color-nivel`); `entity.color` nunca codifica el dato.
- 🔒 `docs/index.html` se actualiza por copia íntegra, jamás por edición.
- 🔒 El D3 minificado vendorizado no se toca, y tampoco React, ReactDOM ni Babel en `10_utils/`: el build verifica su sha384.
- 🔒 El motor no carga nada por red: `grep -c 'src="http' docs/index.html` = 0.
- 🔒 La escala del SVG vive en `FS_SVG`; la de la interfaz en `--fs-*`; las medidas de las barras en `RECENT_DIMS`. Sin literales.
- 🔒 Una cifra va dentro de su franja solo si cabe; si no, baja bajo el año con la inicial del nivel.
- 🔒 Sin mayúsculas sostenidas en el texto salvo siglas.
- 🔒 El backlog conserva sus cinco secciones de POLITICA §10 y su detalle en `###`.
- 🔒 El grupo socioeconómico es atributo del par establecimiento-nivel.
- 🔒 La vista de trayectorias no depende de la red, y los períodos sin medición se dibujan como hueco.
- 🔒 La vista de trayectorias se edita en `30_procesamiento/36_trayectorias_template.html` y `36_funciones_trayectorias.R`; el mockup de `andamios/` queda congelado.
- 🔒 El referente y la nube son municipales fuera del catálogo con resultado en el primer año de la serie (D32-2); los porcentajes se redondean en enteros con los empates hacia arriba (D32-3).
- ✅ ANTES de entregar un archivo editado, cotejar su base contra `HEAD`.
- ✅ ANTES de dar por revisado algo visual, recorrer con una lista de forma cada tipo de gráfico **y cada exportación**, no solo comparar píxeles contra lo publicado.
- ✅ ANTES de usar `40_salidas/intermedios/` como línea base, medir su fecha y sus columnas: lo comparten todas las ramas.
- ✅ ANTES de dar por buena una cifra de la vista de trayectorias, correr `Rscript 30_procesamiento/36_verificar_trayectorias.R` (17 pruebas, código 0).
- ✅ ANTES de enviar a Claude Code cualquier comando, incluso una verificación de una línea, correrlo en el entorno propio.
- ⚠️ NO correr ningún comando de git que escriba (commit, `restore`, `rm --cached`) desde el puente de Cowork.
- ⚠️ NO integrar la vista de trayectorias como pestaña de `33_motor_template.html`.
- ⚠️ NO escribir en un encargo un comando que no se corrió antes.
- ⚠️ NO expresar criterios como cantidad de líneas de `diff`, de `status` ni de commits, ni como un conteo medido en otra plataforma.
- ⚠️ NO entregar archivos al chat entre la medición del estado de un encargo y su ejecución.

## 13. Fragmentos de código de referencia

```r
# 36_funciones_trayectorias.R: porcentaje con un decimal desde enteros exactos,
# empates hacia arriba (D32-3). num / den = porcentaje × ESCALA_PCT.
redondear_exacto <- function(num, den) {
  ((2 * num + den) %/% (2 * den)) / ESCALA_PCT
}
# En la agregación: ade_num = sum(nalu * round(palu_eda_ade * 10)), den = sum(nalu).
```

```r
# 36_verificar_trayectorias.R: empate exacto (el porcentaje × 10 termina en ,5).
es_empate <- function(num, den) (2 * num) %% (2 * den) == den
```

Los patrones estables siguen en los scripts del paso 36 y en `33_generar_html.R`.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se lee desde ahí; no se adjunta.

**Se adjuntan:** `traspaso_cierre_v32.md`. La plantilla `30_procesamiento/36_trayectorias_template.html` (209 KB) está en el repositorio y se lee desde la carpeta conectada; no hace falta adjuntarla. El backlog y el escáner no se adjuntan.

**Estado:** `main` en `4c5cc3a`, previo al commit de cierre. Vista de trayectorias en el paso 36, reproducible y publicada en el repositorio; motor sin cambios.

**Foco propuesto:** corregir los nueve defectos de forma heredados de la vista de trayectorias (pendiente 1), con lista de forma y capturas antes y después.

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

Cuatro errores, registrados en el momento en que ocurrieron en `50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`; se vuelcan con los diez campos de §2.2.15. Los errores propios de Claude Code están en los logs de sus tres corridas.

**ERR-32-01**
- `momento`: Fase C, recomendación sobre el destino de la rama local `feat/contrato-contexto` (opción B, publicarla sin integrar).
- `disparador`: el ejecutor lo detectó (hook pre-push, R1: `40_salidas/publico/contexto_simce.parquet` sin autorizar; push rechazado).
- `que_paso`: recomendé B como «un solo push» sin medir que la rama versiona un parquet no declarado en `50_datos_versionados_autorizados.md`, aunque en el mismo análisis había medido ese parquet y había atado la autorización I8 solo a la opción A.
- `regla_violada`: SETTINGS §2.1, compuerta de repositorio I8, y aviso 8 de la apertura («ningún comando va a un encargo sin haberlo corrido antes»).
- `causa_raiz`: asocié la autorización de datos a la integración en `main` y no a cualquier publicación de la rama; la restricción que yo mismo escribí para A no se propagó a B.
- `salvaguarda_presente`: SETTINGS y POLITICA §6; mensaje de apertura del titular.
- `patron`: PAT-07, restricción leída no propagada a otra opción del mismo análisis.
- `gatillo_observable`: restriccion-no-propagada: la opción recomendada publica un árbol que contiene un `.parquet` que `git diff --stat main...feat/contrato-contexto` ya mostraba.
- `intentos_previos`: 0.
- `costo`: un push rechazado y una vuelta de decisión con el titular; ningún cambio en el repositorio.

**ERR-32-02**
- `momento`: instrucción a Claude Code para autorizar el parquet y publicar la rama, paso 4 de verificación.
- `disparador`: el ejecutor lo detectó (`fatal: Needed a single revision`; lo midió por separado).
- `que_paso`: escribí `git rev-parse --short HEAD origin/main`, que no corre porque `--short` admite una sola revisión; es el mismo comando de ERR-31-04.
- `regla_violada`: aviso 8 del mensaje de apertura y ⚠️ del traspaso v31 («NO escribir en un encargo un comando que no se corrió antes»); SETTINGS §1.2.6, «ningún comando asume el entorno».
- `causa_raiz`: traté el bloque como instrucción corta y no como encargo, y no probé el comando pese a tener git disponible; leí la regla como propia de encargos formales.
- `salvaguarda_presente`: traspaso v31 (§12 y ERR-31-04), mensaje de apertura, SETTINGS.
- `patron`: PAT-03, sintaxis de una herramienta no probada; reincidencia literal de ERR-31-04.
- `gatillo_observable`: comando-entorno: un comando de verificación entregado a Claude Code sin haberse ejecutado antes en ningún entorno.
- `intentos_previos`: 0.
- `costo`: una verificación rehecha por el ejecutor en dos comandos; ninguno hacia fuera.

**ERR-32-03**
- `momento`: redacción de `encargo_traslado_trayectorias.md`, paso 3 de FASE 1 (esperado de D10).
- `disparador`: el ejecutor lo detectó (D10 dio 13 cifras distintas contra 3 esperadas; T1 congelada por la cláusula residual, R-14 BLOQUEA).
- `que_paso`: fijé como esperado el número exacto de cifras distintas del mockup («3») medido en mi entorno x86_64, cuando ese número depende de cómo la coma flotante resuelve empates en cada plataforma y orden de suma; lo que la meta afirma es «ninguna diferencia fuera de empates».
- `regla_violada`: ⚠️ del traspaso v31 (criterios como conteos) y encargo v1.6 §2.6 (criterio calibrado sobre la afirmación, no sobre un proxy).
- `causa_raiz`: vi que las 3 diferencias eran empates y no pregunté por qué había empates que la aritmética resolvía distinto; traté un síntoma del entorno como constante del dato.
- `salvaguarda_presente`: traspaso v31 §12, encargo v1.6 §2.6, regla 12 de `50_diseno_ramas_deteccion.md`.
- `patron`: PAT-13, criterio que mide un proxy (conteo de diferencias) y no el riesgo (diferencias fuera de empate).
- `gatillo_observable`: encargos-premisas: un esperado numérico derivado de una sola corrida en otra plataforma para una magnitud sensible al redondeo.
- `intentos_previos`: 0.
- `costo`: T1 congelada sin commit, una corrida completa del encargo y una decisión devuelta al titular.

**ERR-32-04**
- `momento`: entrega de los dos scripts con redondeo entero, después de depositar la adenda del traslado.
- `disparador`: el ejecutor lo detectó (`?? "Claude outputs/"` en FASE 0 de la adenda; regla 2, sesión detenida).
- `que_paso`: entregué en el chat dos archivos que ya estaban en la carpeta conectada, y la app de escritorio dejó sus copias en `Claude outputs/` dentro de la raíz del repositorio, 12 segundos después de fijar el estado de partida de la adenda.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»: el estado de partida de un encargo lo cambió una acción mía posterior a su medición; encargo v1.6 §2.2 regla 3 por analogía.
- `causa_raiz`: no medí el efecto de la entrega en el chat sobre la carpeta conectada; la traté como una acción sin efecto en el árbol y la hice después de medir el `git status` que la adenda declara.
- `salvaguarda_presente`: SETTINGS; ERR-31-07 (artefactos no versionados que cambian el estado supuesto).
- `patron`: PAT-03, efecto de una herramienta propia sobre el entorno del ejecutor no medido.
- `gatillo_observable`: comando-entorno: una entrega de archivos al chat con carpeta conectada, hecha después de medir el `git status` que un encargo declara como premisa.
- `intentos_previos`: 0.
- `costo`: una corrida de la adenda detenida en FASE 0 y un commit de log sin la meta cumplida.

**Reincidencia.** PAT-03 aparece dos veces en la sesión (ERR-32-02 y ERR-32-04) y por segunda sesión seguida en la forma «comando no probado» (ERR-31-04, ERR-32-02). Clasificación §2.2.16: omisión. La propuesta es un slot en la plantilla de instrucciones a Claude Code, «comando probado en: <entorno>», que se llena antes de enviar y hace visible la omisión.

### Fricciones

- `friccion: «lee log por tu cuenta», «log en el directorio», «lee el log también» → el asistente pedía el reporte de Claude Code en vez de leer los logs con el puente; desde entonces se leyeron directamente.`
- `friccion: «puede correr en contexto limpio?» (dos veces) → cada encargo declara ahora de forma explícita que no depende de la conversación.`
