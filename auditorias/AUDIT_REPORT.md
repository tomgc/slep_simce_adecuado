# Auditoría slep_simce_adecuado

## Fecha

2026-10-02 (inicio 19:07 UTC). Entorno, versiones y limitaciones: AUDIT_MANIFEST.md. Evidencia reproducible: AUDIT_EVIDENCE.md (secciones E1 a E15). Hallazgos en formato tabular: AUDIT_FINDINGS.csv.

## Commit auditado

`75014460eed610827bb2c9fdc8a29ee48945f80b` (rama `claude/nice-shannon-kmkdc7`, working tree limpio al inicio). Clon superficial de 50 commits.

## Objetivo

Responder si los dos HTML publicados (`docs/index.html`, `docs/trayectorias.html`) representan correctamente los resultados Simce según las reglas metodológicas declaradas, y si esa conclusión puede reproducirse desde los insumos y el código versionados.

## Alcance

- Pipeline completo (`00_build.R`, pasos 30, 31, 32, 33 y 36), utilidades de `10_utils/` y paso 34.
- Los 18 XLSX de la Agencia.
- JSON embebido y lógica JavaScript del motor y de la vista.
- Las dos baterías de verificación, el validador de portabilidad y `renv.lock`.
- Publicación en `docs/`, documentación activa, backlog y decisiones, gobernanza y privacidad (repositorio e historial público).

No se modificó código, datos, configuración, `renv.lock` ni `docs/`. La única escritura en el proyecto es esta carpeta `auditorias/`.

## Metodología de auditoría

1. Lectura del código y reconstrucción del contrato real del pipeline (E2).
2. Reconstrucción independiente del universo y de los indicadores:
   - lector distinto (openxlsx) y código propio, sin `agregar_ponderado()`;
   - cotejo contra el JSON publicado: 140.345 filas por establecimiento, 44.975 celdas comunales, `nac`, 36 SLEP y referente de la vista (E3 a E5).
3. Ejecución del motor publicado en Chromium sin red, con trazabilidad de 72 cifras hasta el XLSX (E11, E12).
4. Ejecución del pipeline en copias aisladas con un directorio oficial SUSTITUTO sin datos personales. El real no está versionado y el portal MINEDUC estaba bloqueado. Sobre esas copias:
   - reproducibilidad, idempotencia y baterías (E6);
   - 15 mutaciones adversariales (E10);
   - casos sintéticos de borde (E8);
   - portabilidad (E9).
5. Revisión documental. Un subagente de solo lectura la hizo; toda afirmación usada aquí se reverificó contra el código (E14).

Separación aplicada en cada componente: ¿ejecuta? / ¿calcula? / ¿calcula correctamente? / ¿usa el universo correcto? / ¿es reproducible? / ¿es interpretable? / ¿es verificable?

## Arquitectura reconstruida

```
20_insumos/simce/{2m,4b}/*.xlsx (18)        20_insumos/auxiliares/
        │                                     ├─ directorio_oficial_ee.csv  (NO versionado; requerido)
        │                                     ├─ listado_slep_2026.xlsx
        │                                     ├─ anexo_indicadores_simce.xlsx, caracterizacion_establecimientos.xlsx
        │                                     └─ dim_slep_comunas.csv (solo paso 36)
        ▼
[30] catálogos: comunas_chile, sleps_chile (COD_DEPE 6 o 1/2 según ANIO_DATOS_VIGENTE=2025L),
     establecimientos_chile, slep_cc_establecimientos (sin consumidor)
[31] lectura y normalización: formato largo rbd×prueba×nivel×año; A1 (hoy sin efecto), A3 (comuna desde el
     directorio), A4 (Ñuble), GSE texto→código, cod_depe2 = dependencia VIGENTE para todos los años
     → simce_rbd.parquet (185.378 filas, 14 columnas)
[32] cod_grupo no NA → agregar_ponderado() por año×nivel×prueba×comuna×GSE×depe2 → simce_comunal.parquet (44.975)
[33] JSON (meta, catálogos, datos comunales, simce_rbd filtrado = 140.345 filas) gzip+base64; JSX transpilado
     con Babel en V8; React, ReactDOM, D3, pako y gobCL incrustados → motor_comparacion.html
     JS en el navegador: comuna, región, nacional y dependencia repondera datos.pct×n_evaluados;
     SLEP y establecimiento ponderan simce_rbd por nalu; mkPunto redondea y normaliza Elemental/Insuficiente
[36] base_valida (tres niveles, suma 99-101, marca NA, nalu≥10) → agregación entera → DATA → trayectorias_traspasos.html
Publicación (manual): 40_salidas/*.html → docs/index.html, docs/trayectorias.html
Fuera del build: paso 34 (xlsx Costa Central, versionado), 33_verificar_motor.R, 36_verificar_trayectorias.R
```

Diferencias entre el pipeline declarado y el efectivo:
- El build no corre desde el repositorio sin el directorio no versionado (AUD-002).
- El paso 34 y las baterías no forman parte del build.
- La salida local de la vista se llama `trayectorias_traspasos.html`, pero el menú enlaza `trayectorias.html` (AUD-022).
- No hay objetos ocultos del Global Environment que un paso necesite de otro: cada paso relee sus insumos desde disco (E2).

## GATE A: Universo

Resultado: **VERIFICADO para el universo de filas; NO VERIFICADO para la clasificación (dependencia, SLEP, comuna A3) contra su fuente. Sin hallazgo crítico.**

Evidencia:
- Filas: la reconstrucción independiente desde los XLSX con el filtro MINEDUC da exactamente las mismas 140.345 filas que el JSON publicado. Hay 0 diferencias en clave, nalu, Adecuado, Elemental, Insuficiente y GSE (E5).
- Cascada de exclusiones, trazable (E4): 185.378 filas; menos 1.524 con nalu NA; menos 41.501 con nalu < 10 (8.216 de ellas son celdas suprimidas con los tres niveles en 0); menos 2.008 con marca. Quedan 140.345.
- Filtros: `nalu = 9` sale, `nalu = 10` entra, `marca NA` entra, marca con valor sale (E8 B2, B3, B9). El filtro se aplica antes de agregar, igual para los tres niveles y en ambas vistas.
- Duplicados: clave `anio×nivel×prueba×rbd` única en XLSX, JSON y parquet. 0 RBD duplicados dentro de un archivo. Catálogo SLEP sin RBD repetidos (E3, E4).
- Bordes del universo: 256 RBD con resultado ya no operativos; 2.639 operativos sin Simce; 338 de 345 comunas con datos.
- Clasificación: una sola `cod_depe2` vigente por RBD en toda la serie, conforme a lo declarado (AUD-029). Pero el directorio que la define no está versionado ni tiene huella registrada (AUD-002). El catálogo SLEP y la comuna de los años A3 tampoco pueden reproducirse desde el repositorio.
- Riesgos de robustez del universo:
  - el filtro de marca depende de que readxl convierta celdas vacías en NA (AUD-008);
  - las validaciones de duplicados y rangos son advertencias, no detenciones (AUD-009).

## GATE B: Cálculo

Resultado: **VERIFICADO para las cifras publicadas. Dos defectos latentes sin efecto actual.**

Evidencia:
- La fórmula `sum(nalu × palu / 100) / sum(nalu) × 100` está implementada así en R y en JS. Es ponderada, no promedio simple: el caso 10 evaluados con 20% y 90 con 80% da 74 (E7, E8 B1).
- No hay doble ponderación: reponderar `datos.pct` por `n_evaluados` equivale a ponderar por nalu (E7).
- Agregación comunal: 44.975 de 44.975 celdas coinciden en clave, `n_evaluados` y `n_estab`. 78 % difieren en 0,005 por empates de redondeo (E5).
- Motor publicado ejecutado: 72 de 72 cifras coinciden en % Adecuado, n y establecimientos (E11):
  - casos: SLEP, comuna, región, nacional, dependencia SLEP y GSE combinado de comuna, SLEP y país;
  - el GSE combinado es una agregación ponderada de los cinco grupos, no un promedio de porcentajes.
- Desglose:
  - Adecuado es idéntico con o sin desglose (E8 B5).
  - Elemental e Insuficiente mostrados están normalizados a 100 − Adecuado (`mkPunto`) y se apartan del ponderado crudo en 0,07 pp como máximo. Está documentado en el código, no en la interfaz.
  - Defecto latente: el denominador de Elemental e Insuficiente incluye filas sin ese nivel (AUD-010; 0 filas afectadas hoy).
- Trayectorias: 270 celdas nacionales, 6.323 filas de los 36 SLEP y 225 del referente coinciden exactamente con el recálculo (E5). La regla de tres niveles y suma 99-101 se aplica como está documentada (E8 B8). Hoy no excluye ninguna fila adicional respecto del motor.
- Valores imposibles: no existen en los insumos (E3), pero el pipeline no los detendría (palu 150, −10 e Inf aceptados; AUD-009).

## GATE C: Producto

Resultado: **HALLAZGO ALTO (baterías incapaces de detectar errores de cálculo). Contenido, autocontención y publicación VERIFICADOS.**

Evidencia:
- HTML con datos correctos: E5 y E11.
- JSON = Parquet: el rebuild en `work_A` reproduce el JSON publicado. Todas las tablas son idénticas; `meta` difiere solo en `fecha_generacion`; 26 celdas de `datos` difieren en 0,01 por redondeo entre entornos (E6, AUD-017).
- `docs/` = salida del commit:
  - `trayectorias.html` es idéntico byte a byte a la salida reconstruida;
  - `index.html` es idéntico fuera del bloque JSON (E6).
- Offline: ambas páginas renderizan con la red cortada, con 0 solicitudes no locales y 0 errores JS. React 18.3.1, ReactDOM 18.3.1, D3 7.9.0, pako 2.1.0 y gobCL están incrustados. Babel 7.29.0 no viaja: solo transpila en el build (E12, manifiesto).
- Baterías:
  - 8/8 y 35/35 PASA sobre la salida reconstruida.
  - Fallan con exit 1 si el navegador no arranca, así que no dan falso PASS.
  - Pero 7 de 15 mutaciones (promedio simple, umbral 9, +5 pp, etiquetas GSE invertidas, GSE eliminado, CDN inyectado, JS vendorizado alterado) pasan ambas baterías (E10; AUD-003, AUD-004, AUD-005, AUD-006).

## Hallazgos críticos

**Ninguno.** No se encontró ninguna cifra, universo, clasificación o filtro publicado que difiera de lo que producen los XLSX con las reglas declaradas. Esta conclusión se sostiene en las comparaciones exhaustivas de E5 y en la muestra de 72 cifras de E11.

No cubre la exactitud de la clasificación de dependencia y SLEP respecto del directorio real de MINEDUC, que no pudo evaluarse (AUD-002).

## Hallazgos altos

- **AUD-001** (PRIVACY): el directorio con MRUN, según la propia decisión del proyecto 946 MRUN, sigue en el historial público del repositorio (commit `61c3b9b`, verificado por la API de GitHub). El riesgo está aceptado en `decisiones/20260622_decision_cumplimiento_ley_21719.md` §6. E13.
- **AUD-002** (REPRODUCIBILITY): el build depende de `directorio_oficial_ee.csv`, que no está versionado y no tiene fuente, fecha de corte ni hash registrados. Ese archivo determina la dependencia de toda la serie, el catálogo SLEP, la comuna de 2015 y 2017 (A3) y el referente. E1, E2, E6.
- **AUD-003** (TESTING): la batería del motor (M1-M8) no tiene ninguna prueba de datos. Las mutaciones ADV01, 02, 07, 08 y 10 pasan 8/8. E10.

## Hallazgos medios

- **AUD-004**: la batería de trayectorias toma el parquet como verdad. Sus detecciones dependen del mockup congelado (D10) y de conteos fijos. E10.
- **AUD-005**: M1 no reconoce `<link href>`, `fetch`, `XMLHttpRequest` ni `import()`, y el paso 33 no tiene autocontrol de red. ADV06 no se detecta. E10, E12.
- **AUD-006**: D3 y pako se incrustan sin verificar su hash. ADV11 no se detecta. E10.
- **AUD-007**: la prueba R3 valida un comportamiento del referente que el pipeline no produce. Con datos de la ola 2027, el referente se reescribiría hacia atrás. E14.
- **AUD-008**: el filtro de marca depende de que readxl lea como NA 14.517 celdas vacías; 14.253 filas válidas están en juego. E3, E8.
- **AUD-009**: las validaciones de los pasos 31 y 32 son `warning()` y no hay control de rango. ADV05 y ADV15 pasan el build. E8, E10.
- **AUD-010**: denominador de Elemental e Insuficiente con filas sin ese nivel. Latente. E8 B4.
- **AUD-011**: la advertencia de no atribución al SLEP no está visible por defecto (motor: modal y panorama; vista: modal de notas). El corte pre/post traspaso solo se marca en la sparkline. E11, E12.
- **AUD-012**: la actualización anual exige editar constantes, literales y esperados de la batería, contra lo que afirma `manifiesto_insumos.md:93`. Un año falso entra sin aviso (ADV12). E2, E10.
- **AUD-013**: el paso 34 (xlsx versionado) cuenta celdas suprimidas como 0% Adecuado, hasta 2,2 pp de diferencia en 2023-2024. E14.
- **AUD-014**: para una entidad establecimiento, el CSV del motor trae 5 series idénticas rotuladas con 5 GSE, y el conteo de establecimientos cuenta toda la comuna. Lectura de código. E14.
- **AUD-016**: la vista de trayectorias no conoce ni marca años preliminares. Latente. E14.

## Hallazgos bajos

- **AUD-015**: el tooltip de trayectorias puede mostrar valores interpolados con rótulo de año. E14.
- **AUD-017**: el motor no es comparable por hash entre días (`fecha_generacion`) y difiere en ±0,01 entre entornos. E6.
- **AUD-018**: «misma fórmula y mismos filtros» entre vistas no es literal (tres niveles, `cod_grupo` NA, redondeo). Hoy los universos son idénticos. E5.
- **AUD-019**: el GSE combinado usa dos universos según el tipo de territorio. Latente. E5.
- **AUD-020**: el validador de portabilidad no escanea HTML y JS, no detecta `normalizePath`, y su columna `detalle` es engañosa. Cross-OS no ejecutado. E9.
- **AUD-022**: la publicación es manual, sin control que exija las baterías ni compare `docs/` con `40_salidas/`. Navegación local rota en `40_salidas/`. E6.
- **AUD-023**: documentación obsoleta: 2025 descrito como preliminar, A2 como pendiente, NOTICE sin Babel, gobernanza solo con `index.html`, directorio descrito como versionado, comentario «1.333». E14.
- **AUD-024**: Q-98 solo valida la presencia de columnas del directorio, no su año ni sus valores. E14.

Informacionales:
- **AUD-021**: `renv::restore()` no evaluable (CRAN bloqueado); el arranque intenta red.
- **AUD-025**: rama A1 sin efecto.
- **AUD-026**: `marca_eda_*` de 2014 sin efecto.
- **AUD-027**: `slep_cc_establecimientos.parquet` sin consumidor.
- **AUD-028**: correo nominativo en el pie.
- **AUD-029**: dependencia vigente retroactiva, verificada conforme a lo declarado.
- **AUD-030**: efectos laterales del escáner y esperados fijos de las baterías.

## Auditoría de insumos

- 18 XLSX finales: 2014-2018 y 2022-2025, los dos niveles y las dos pruebas.
- Esquemas de 38 a 62 columnas, todos con las 14 que se usan. Hojas extra vacías.
- Anomalías:
  - A3 (100% de códigos cortos en 2m/2015, 4b/2015 y 4b/2017) y A4 (81 a 317 códigos pre-Ñuble por archivo) están presentes y tratadas.
  - A1 ya no existe en el insumo versionado (AUD-025).
  - A2: la marca usada es la de puntaje, coherente con la decisión «opción a»; `marca_eda_*` de 2014 no cambiaría filas (AUD-026).
- Supresión: las 8.216 celdas con los tres niveles en 0 tienen todas nalu < 10. El umbral las elimina en el motor y en la vista, pero no en el paso 34 (AUD-013).
- No hay transformaciones silenciosas en el paso 31: valores idénticos al XLSX (E5).

## Auditoría metodológica

Ver GATE B. El % Adecuado está correctamente ponderado en R, en el JSON y en el JS publicado. El desglose usa la misma ponderación. Lo que se muestra de Elemental e Insuficiente está normalizado a 100 − Adecuado, con efecto de 0,07 pp como máximo.

## Auditoría de dependencia y SLEP

- La clasificación vigente se aplica retroactivamente, como declara el README: una dependencia por RBD; 64.937 filas tienen otra dependencia en el XLSX de su año (AUD-029).
- 36 SLEP: 26 traspasados hasta 2025 y 10 prospectivos 2026, con RBD municipales.
- Ningún RBD ni comuna está en más de un SLEP.
- El SLEP aparece en años previos a su traspaso.
- Comunicación:
  - en el motor, el chip dice «Incluye periodo de gestión municipal previo al traspaso» (visible en la vista por defecto);
  - el texto «no son atribuibles a la gestión del SLEP» está en el modal y en el panorama;
  - en trayectorias, «no mide el efecto del traspaso» está solo en el modal de notas, y las burbujas huecas o llenas distinguen antes y después del traspaso.
- Contextos de interpretación errónea posible: tabla, barras, CSV, el filtro Municipal retroactivo y la vista de trayectorias sin abrir las notas (AUD-011).
- No se pudo verificar el catálogo contra el directorio real (AUD-002).

## Auditoría de trayectorias

Cohortes, referente y olas:
- Referente: 1.299 RBD, anclado en 2014, municipales vigentes y fuera del catálogo.
- 37 unidades futuras: 13, 11 y 13 por ola 2027-2029, con 2.564 establecimientos.
- Conteo del referente por ola: 475, 406 y 401.
- Con el directorio sustituto se reproducen todos estos números (C1, C5, R1, R5 PASA). Las cifras de `datos` coinciden con el recálculo independiente (E5).
- Universo idéntico al del motor (140.345 filas); misma fórmula; redondeo entero (D32-3).

Riesgos:
- La semántica del referente frente a olas futuras (AUD-007).
- Sin marca de preliminar (AUD-016).
- Tooltip interpolado (AUD-015).
- `dim_slep_comunas.csv`: md5 `fdb3015da12264d370a9d670c6886c0b`, igual al registrado en `manifiesto_insumos.md:79` (medido con `md5sum` en esta sesión). El paso 36 lo validó al leerlo (346 filas).

## Auditoría temporal

- Años presentes: 2014-2018 y 2022-2025, sin 2019-2021. Coinciden con los nombres de archivo y con `ANIO_INICIO` y `ANIOS_SIN_SIMCE`; M3 PASA.
- El paso 31 detiene el build ante huecos, años repetidos o inicio distinto de 2014 (código 31:161-218).
- No hay preliminares: el motor los marcaría y la vista no (AUD-016).
- Literales de año en lógica:
  - motor 2644-2645 y vista 1028-1030 (laguna 2018/2022);
  - `ANIO_DATOS_VIGENTE` = 2025L;
  - `OLAS_FUTURAS`;
  - nombre `listado_slep_2026.xlsx`;
  - «nueve años»;
  - esperados de la batería.
- Los demás literales son texto, comentarios o mapeos históricos legítimos (Ñuble).
- No hay copias divergentes de `ANIO_INICIO` ni de `ANIOS_SIN_SIMCE` en el código R (grep, E2).

## Auditoría de reproducibilidad

- Mismo entorno: A1 = A2 = A3 = B1 byte a byte, incluidos los parquet. El build es idempotente y no acumula archivos (E6).
- Entre entornos: la vista es idéntica a la publicada; el motor difiere en la fecha y en 26 × 0,01 (AUD-017).
- Desde el repositorio solo: NO reproducible sin el directorio (AUD-002). `renv::restore()` no evaluable (AUD-021).

Performance medida en el contenedor:

| Medida | Valor |
|---|---|
| Build completo | 17-18 s |
| Batería del motor | 81 s |
| Batería de trayectorias | 37 s |
| JSON del motor | 13,6 MB plano, 2,1 MB en base64 |
| `index.html` | 2,93 MB |
| `trayectorias.html` | 2,21 MB |
| Render offline | 2,7 s (motor) y 2,2 s (vista) |
| Parquet | 1,68 MB `simce_rbd`, 1,01 MB `simce_comunal` |

No hay un problema de rendimiento medido. Un año adicional agregó 0,23 MB a la vista (ADV12: 2,44 MB).

## Auditoría de portabilidad

- `here` es el ancla: hay `.Rproj` y `ruta_insumos()` resuelve dentro del repositorio.
- Sin rutas de usuario, `setwd` ni OneDrive en el código R (validador: 0 críticas).
- La guarda de locale funciona: corrigió C → C.UTF-8. El propio incidente de la auditoría (E14) muestra su necesidad.
- Autotest del validador: SI.
- Cobertura incompleta del validador (AUD-020).
- No se ejecutó en macOS ni en Windows: NO EVALUABLE.

## Auditoría de seguridad y privacidad

- El directorio está ignorado y no está en `git ls-files`.
- No aparece en outputs, JSON, HTML ni en esta carpeta. El sustituto se generó solo en el scratchpad y no tiene MRUN.
- Sí está en el historial público (AUD-001).
- Dependencias JS:
  - React, ReactDOM y Babel tienen SRI verificado contra sha384 (openssl coincide);
  - D3 y pako no lo tienen (AUD-006);
  - V8 solo ejecuta el Babel cuyo hash verificó el build.
- Correo nominativo en el pie (AUD-028).

## Auditoría de tests

Cobertura real:

| Ámbito | Motor (M1-M8) | Trayectorias (35) |
|---|---|---|
| Carga y render | sí (M4-M8 abren la página) | sí (R2, R4, R6, R7, FC1, FC2) |
| Red | parcial (AUD-005) | parcial (patrón `(src\|href)="https?:`) |
| Años | M3 | D11, C4 |
| Cálculos y cifras | **no** | sí respecto del parquet (D1-D9, D13, D14) y del mockup congelado (D10) |
| Filtros | **no** | D14 |
| Insumos (XLSX → parquet) | **no** | **no** |
| UI y responsive | M4-M7 | C6, FC1, FC2 |
| Exportación | M8 (fuente del PNG) | no aplica |
| Enlaces y publicación (`docs/`) | **no** | **no** |

- Las pruebas usan controles positivos, pero varios controlan el comparador y no el dato: D8 altera una tabla ya calculada.
- Las dos baterías leen la salida recién generada en `40_salidas/`, no `docs/`.
- Exit code distinto de cero ante falla: verificado.

## Auditoría adversarial

15 mutaciones (E10).

No detectadas por ninguna batería (7): ADV01 promedio simple, ADV02 umbral 9, ADV06 CDN, ADV07 +5 pp, ADV08 etiquetas GSE invertidas, ADV10 sin GSE Alto, ADV11 JS vendorizado alterado.

ADV15 (catálogo SLEP duplicado) tampoco se detecta, pero no altera cifras.

Detectadas solo en trayectorias, vía mockup o conteos fijos: ADV03, ADV04, ADV05, ADV13. Detectadas de forma incidental (render vacío o geometría): ADV09 y ADV14. ADV12 (año falso): solo D10.

Conclusión: un error metodológico en el motor puede llegar a producción con ambas baterías en verde.

## Auditoría de publicación

- `docs/index.html` y `docs/trayectorias.html` corresponden al commit auditado (E6).
- El procedimiento (`publicacion_github_pages.md`) es manual: build, baterías, copia, grep de red, commit. Nada lo impone (AUD-022).
- Lo que sirve GitHub Pages no se verificó: sin acceso de red.

## Elementos no evaluables

- Exactitud de la clasificación de dependencia y del catálogo SLEP frente al directorio real de MINEDUC (sin archivo ni acceso al portal).
- `renv::restore()` con las versiones exactas del lock.
- Ejecución en macOS y Windows.
- Historial git completo (clon superficial); solo se consultó el commit `61c3b9b`.
- Contenido servido por GitHub Pages.
- AUD-014 y AUD-015 se sostienen en lectura de código; no se ejecutaron en navegador.

## Riesgos pendientes

1. Publicar un error de cálculo o de filtro del motor con baterías en verde (AUD-003).
2. Cambiar en silencio la clasificación SLEP o de dependencia al renovar el directorio (AUD-002, AUD-024).
3. Reescritura retroactiva del referente al entrar la ola 2027 (AUD-007).
4. Actualización anual con pasos manuales no documentados (AUD-012).
5. Exposición de MRUN en el historial público (AUD-001).

## Conclusión técnica

Quedó verificado lo siguiente:
- Las cifras de los dos HTML publicados coinciden con las que se obtienen recalculando desde los 18 XLSX con las reglas declaradas (umbral de 10 evaluados, exclusión por marca, ponderación por evaluados, GSE por año, dependencia vigente).
- La verificación es exhaustiva para el nivel establecimiento, el nivel comunal y la vista de trayectorias, y por muestra de 72 cifras para el JS del motor.
- `docs/` corresponde al código del commit auditado.
- Ambas páginas funcionan sin red.
- El build es idempotente.

No quedó verificado:
- que la dependencia y el catálogo SLEP correspondan al directorio de MINEDUC;
- que otra persona pueda reproducir el build solo con el repositorio;
- el contrato macOS/Windows.

El sistema de control no protege el cálculo del motor.

## Criterio final

| Pregunta | Respuesta |
|---|---|
| Integridad de datos | Universo de filas conocido, reproducido y consistente (140.345). Clasificación dependiente de un archivo no versionado. |
| Metodología | Sí: % Adecuado correctamente ponderado (R, JSON y JS). |
| Desglose | Sí, con la misma ponderación. Lo mostrado se normaliza a 100 − Adecuado (≤ 0,07 pp). Defecto latente en el denominador (AUD-010). |
| Filtros | Sí, en ambas vistas y en los bordes. Dependen de readxl para las celdas vacías (AUD-008). |
| Dependencia | La regla vigente retroactiva está implementada como se declara. La comunicación no está visible por defecto en todos los contextos (AUD-011). Su fuente no es reproducible (AUD-002). |
| Trayectorias | Universo y fórmula coherentes con el motor (hoy, universos idénticos). Riesgo futuro en el referente (AUD-007). |
| Temporalidad | Años correctos y validados. Literales y vista sin preliminares (AUD-012, AUD-016). |
| Agregación | Sin duplicaciones, joins incorrectos ni doble ponderación (E5, E7, ADV15). |
| Trazabilidad | Sí: cifra JS → JSON → parquet → agregación → fila XLSX, completa en 8 casos × 9 años; eslabón de clasificación parcial. |
| Producto | Sí: standalone y sin red, verificado en Chromium offline. |
| Tests | Verifican sobre todo presencia, render y maquetación. Errores reales de cálculo del motor no se detectan. |
| Reproducibilidad | Sí en el mismo entorno (byte a byte). Entre entornos: diferencias de 0,01 y fecha. No desde el repositorio solo. |
| Portabilidad | Linux verificado. macOS/Windows NO EVALUABLE. |
| Seguridad | Excluido del repositorio y del producto actuales; presente en el historial público (AUD-001). |
| Publicación | Sí: `docs/` corresponde a las salidas del commit auditado. |
| Sostenibilidad | No solo con la documentación: el procedimiento anual y la obtención del directorio no están documentados de forma suficiente (AUD-002, AUD-012). |

## Clasificación final por componente

| Componente | Clasificación | Base |
|---|---|---|
| Universo | VERIFICADO (filas) / NO VERIFICADO (clasificación) | E4, E5; AUD-002 |
| Insumos | VERIFICADO | E3, E5 |
| Filtros | VERIFICADO (con hallazgo de robustez) | E4, E8; AUD-008 |
| Cálculo | VERIFICADO (con defecto latente) | E5, E7, E8, E11; AUD-010 |
| GSE | VERIFICADO (con hallazgo latente) | E5, E11; AUD-019 |
| Dependencia | HALLAZGO | AUD-002, AUD-029 |
| SLEP | HALLAZGO | AUD-011, AUD-002 |
| Trayectorias | VERIFICADO (cifras) / HALLAZGO (diseño futuro) | E5; AUD-007, AUD-016 |
| Temporalidad | HALLAZGO | AUD-012, AUD-016 |
| Agregaciones | VERIFICADO | E5, E7, E11 |
| JSON | VERIFICADO | E5, E6 |
| HTML | VERIFICADO (con hallazgo de control) | E12; AUD-005, AUD-006 |
| Tests | HALLAZGO | AUD-003, AUD-004 |
| Reproducibilidad | HALLAZGO | AUD-002, AUD-017 |
| Idempotencia | VERIFICADO | E6 |
| Portabilidad | NO EVALUABLE (macOS/Windows) / HALLAZGO (validador) | E9; AUD-020 |
| Privacidad | HALLAZGO | AUD-001 |
| Publicación | VERIFICADO (contenido) / HALLAZGO (procedimiento) | E6; AUD-022 |
| Documentación | HALLAZGO | AUD-018, AUD-023 |
| Sostenibilidad | HALLAZGO | AUD-012, AUD-030 |

¿Qué tan confiable es hoy el proyecto para producir y publicar comparaciones Simce? Las cifras publicadas al 2026-10-02 son confiables: se reconstruyeron de forma independiente desde los XLSX, sin discrepancias más allá de empates de redondeo de 0,005. La confiabilidad del proceso para futuras publicaciones es menor, por tres razones:
- la clasificación depende de un archivo sin huella registrada;
- las baterías no detectan errores de cálculo del motor;
- la actualización anual requiere pasos manuales no documentados.

---

Verificación de consistencia entre artefactos (ejecutada al cierre; resultado en AUDIT_EVIDENCE.md §E15):

```r
csv <- readr::read_delim("auditorias/AUDIT_FINDINGS.csv", delim = ";", show_col_types = FALSE)
rep <- readLines("auditorias/AUDIT_REPORT.md", encoding = "UTF-8")
ids_rep <- unique(regmatches(rep, gregexpr("AUD-[0-9]{3}", rep)) |> unlist())
stopifnot(!anyDuplicated(csv$id), setequal(csv$id, ids_rep))
```
