# Log: batería por familias, build que se detiene, tarjeta por cohorte y corte del supergrid (s35i) (slep_simce_adecuado)

- Meta: que el build se detenga ante una falla de portabilidad en cualquier modo, que la batería cubra las cuatro familias de la auditoría de la sesión 30, que la tarjeta mida lo mismo sin importar la cohorte anterior, y que ningún nombre salga de su columna del supergrid con 5 territorios; todo publicado en Pages.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: (se completa en H4, commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_bateria_familias_s35i.md`, md5 `9ce88735b3c244099a353f2518ec008d` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); el harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow; todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, E1, B1, V3, M5, PUB, FASE R, FASE L con el push, P3 y su commit (autorización 8).
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpeta de trabajo: `$TMPDIR/cal_s35i/` (instrumentos y salidas); base de H6 en `$TMPDIR/base_s35i/`.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: el build se detiene ante una falla de portabilidad también con `source()` interactivo (copia con ruta plantada: se detiene antes de «iniciando pipeline»; antes llegaba a «OK»); la batería cubre las cuatro familias de la auditoría de la sesión 30 (A 25, B 4, C 2, D 4; FC1 y FC2 nuevas; 35/35); la tarjeta mide lo mismo sin importar la cohorte anterior (144/144 pares iguales a la carga nueva; antes 30/144); ningún nombre sale de su columna del supergrid con los 5 territorios de FASE 0 de 375 a 760 px (antes, de 641 a 666; corte nuevo en 670). Todo copiado a `docs/` (PUB). El push y lo que sirve Pages van en la sección FASE P3.
- Estado por tarea: FASE 0 completa · T0 completa · E1 completa (intento 1) · B1 completa (intento 2; defecto R-32 reparado en FASE R) · V3 completa (intento 1) · M5 completa (intento 1) · PUB completa · FASE R: 0 BLOQUEA, 1 REPARA (R-32, corregido en el ciclo 1), 8 ADVIERTE.
- Commits: 37737b5 (T0, punto de retorno), 90542fb (E1), 14c9fb3 (B1), 0e4b544 (V3), 0ec0d41 (M5), 823e3d3 (PUB), 88070b3 (fix(auditoria), R-32), más docs(log) y docs(log): P3 de s35i (hashes en FASE P3 y en el reporte final).
- Auditoría (FASE R): sin subagentes. El orquestador re-derivó las 32 afirmaciones con instrumentos distintos: terminal simulada con `script` y otra ruta, Python, lienzo, `scrollWidth` de celdas, caminos de varios clics, `hash-object`, md5 de PNG, prueba unitaria por `parse()`. Resultado: 31 CONFIRMADA y 1 REFUTADA (R-32: FC1 no sumaba el total del conteo de la tarjeta por la precedencia de `!`), reparada en 88070b3; los controles positivos dispararon; R-33 a R-40 ADVIERTE; veredicto APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-9 PASA en el estado final (823e3d3 para el producto; I-6 e I-7 otra vez tras 88070b3).
- Cifras críticas: E1, copia con ruta plantada en modo interactivo: «OK en 7 segundos» → «Error: Validacion de portabilidad fallida» sin «iniciando pipeline»; B1: 33 → 35 pruebas, familia C 0 → 2; V3: pares distintos de la carga nueva 57/72 y 57/72 → 0/72 y 0/72 (2027 → 2018: 403 → 317), referencia de 7 cohortes 5 a 8 px más angosta; M5: `W_FUERA` 666, corte 670, anchos con un texto fuera 26 → 0 de 386, holgura mínima 0,94 px a 671; `docs/` de fe30d56f…/69357a69… → 42ab9300…/883f76bc…; JSON sha256 7967dfa07a99ef11 sin cambio.
- Decisiones autónomas de mayor riesgo: D0-a (corte en 670 con el medidor de M2, no en ~690 como estimaba D35-15; Q-67); D0-d (R2, R6 y R7 en la familia B; Q-68); D-B1-b (calibración de B1 con la batería completa contra vistas saboteadas, además de los controles internos); registrar R-34 como ADVIERTE en vez de subir `--supergrid-col-min` (Q-69).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE. El corte (670) se aparta de la estimación de D35-15 («del orden de 690 px») porque el paso 8 fija el medidor (D0-a). R-32 se reparó con un commit `fix(auditoria)` sobre la batería, como prevé FASE R. CLAUDE.md sin crear (§11, D2).
- Dudas abiertas: Q-67 (corte del supergrid: 670 o 690), Q-68 (R2, R6 y R7 en B o en D), Q-69 (13 comunas y 1 región con nombres más anchos que la columna de 112 px).
- Errores propios: en el producto (la batería), el selector del nombre de FC1 y FC2 (intento 1 de B1, antes del commit) y la precedencia de `!` en FC1 (tras el commit; R-32, reparada). En instrumentos, `$?` leído tras `$(basename …)`, `rd_nombres.R` desde el modal, `unitaria.R` sin `is.name()` y un fragmento inexistente, todos corregidos antes de registrar resultados. Ninguno tocó lo publicado.
- Qué debe verificar el revisor por sí mismo: en su consola, `source("00_build.R")` con una ruta plantada (debe detenerse); en Safari o en un teléfono, el supergrid con 5 territorios de 641 a 690 px (sobre todo de 671 a 675) y la vista al ir de la cohorte 2027 a la 2018; las capturas de `_archivo/20260926_capturas_s35i/`.
- No publicado / queda al usuario: la revisión en Safari y en un teléfono real; Q-67 a Q-69. El push y P3, en la sección FASE P3.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite aunque el harness tenía «ultracode» activo); medición en Chrome 153.0.8010.53 sin cabeza, R 4.5.2; modo interactivo con `R --interactive` (tareas) y con una terminal simulada (`script`, FASE R); sin WebKit ni Firefox en la sesión.

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1. Por eso H1 muestra también la línea del propio log.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: exactamente ` M …/20260924_decision_referente_traspasos.md`, ` M …/20260924_sesion35_errores_asistente.md` y `?? …/encargo_bateria_familias_s35i.md`, más el log
obtenido:
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_bateria_familias_s35i.md
?? 50_documentacion/andamios/logs/20260926_bateria_familias_s35i_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: b150d57 y b150d57
obtenido: b150d57 y b150d57

**H4.** `md5 -q` del encargo y de `docs/`; además `md5 -q` de `40_salidas/`, de `10_utils/fuentes/*.otf` y el conteo de I-7
esperado: encargo 9ce88735b3c244099a353f2518ec008d (mensaje de entrega); `docs/` fe30d56f… y 69357a69…; fuentes a7407ed6… y 0257bb4b…; 28
obtenido: 9ce88735b3c244099a353f2518ec008d; `docs/index.html` fe30d56f866d082501bd8937a24f752e, `docs/trayectorias.html` 69357a69dc04db6186e75d3245c6b873 (iguales en `40_salidas/` antes de H6); a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; 28

**T0.** `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la novena ola y decisiones D35-14 y D35-15"`
esperado: un commit con el encargo, el archivo de decisiones y el log de errores
obtenido: `37737b5 docs(sesion 35): encargo de la novena ola y decisiones D35-14 y D35-15`, padre `b150d57`; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_bateria_familias_s35i.md`, `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log. **Punto de retorno: 37737b5.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R` (salida en `$TMPDIR/cal_s35i/h5.txt`; código leído sin tubería)
esperado: 33 en PASA, código 0
obtenido: codigo_bateria=0; «Resultado: 33 pruebas, 33 pasan, 0 fallan»

**H6.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35i/h6.txt`)
esperado: código 0; la vista con md5 igual a `docs/trayectorias.html`; el motor idéntico a `docs/index.html` fuera de `meta$fecha_generacion`
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos». Vista 69357a69dc04db6186e75d3245c6b873 (= `docs/`). Motor fe30d56f866d082501bd8937a24f752e (= `docs/`: el build y lo publicado son del mismo día). `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f. `git status --porcelain` = solo este log.

Comparación del motor sin la fecha (`$TMPDIR/cal_s35i/h6_diff.R`, copia del de s35h: el HTML sin el bloque de datos, byte a byte, y el JSON decodificado)
esperado: fuera del bloque idéntico; JSON sin `fecha_generacion` idéntico
obtenido: «fuera del bloque de datos, idéntico: TRUE | largo 837184 837184»; «fecha_generacion hoy: 2026-09-26 | docs: 2026-09-26»; «JSON sin fecha_generacion, identical: TRUE»; «texto JSON: largo 13597248 13597248 | caracteres distintos: 0». **Cumple** (sin la salvedad de s35h: aquí coinciden también los md5).

Las dos salidas se copiaron a `$TMPDIR/base_s35i/` (md5 fe30d56f… y 69357a69…): es la base de H6. `verificar_contenido_motor.R` (raíz, ignorado) apuntaba a `$TMPDIR/base_s35h/`: se apuntó a `$TMPDIR/base_s35i/` (línea 24 y comentarios de las líneas 3 y 12). El comparador de I-4 se copió a `$TMPDIR/cal_s35i/i4_data_vista.R`, con la base en `$TMPDIR/base_s35i/`.

Calibración de I-3 e I-4 (`alterar_json_motor.R` e `i4_data_vista.R --alterar` sobre la base de H6)
esperado: «idéntico» sobre el build, la base y `docs/`; «difiere» con un número alterado
obtenido: motor «fragmento original: 3.5 -> alterado: 3.6»; build codigo_actual=0 «JSON idéntico a la línea base»; base codigo_base=0 «idéntico»; `docs/index.html` codigo_docs=0 «idéntico»; copia codigo_alterado=1 «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)». Vista «fragmento original: 23.9 -> alterado: 23.8»; build «identical: TRUE» (codigo 0); `docs/trayectorias.html` «identical: TRUE» (codigo 0); copia «identical: FALSE» (codigo 1). **Disparan.**

Capturas de I-9 (`$TMPDIR/cal_s35i/capturas.R`, copia del de s35h, modo `inicial`: las tres vistas en su estado inicial a 1280 × 900 y 1440 × 900, página completa a DSF 1 y ventana de arriba a DSF 2; barras superpuestas; espera de 3 s tras `document.fonts.ready`), dos cargas independientes (`$TMPDIR/base_s35i/cap_a/` y `cap_b/`), comparadas con `$TMPDIR/cal_s35i/comparar.R`
esperado: 0 píxeles distintos entre las dos cargas
obtenido: 12 capturas por carga; `cap_a` contra `cap_b`: 0 píxeles distintos en las 12 (páginas de 3.601, 1.289 y 1.119 de alto a 1280; 3.708, 1.339 y 1.119 a 1440). **Base determinista.**

**Paso 8. Mediciones de partida.**

*E1* (copia del repositorio en `$TMPDIR/cal_s35i/e1/repo`: `rsync -a` del árbol sin `.git`, `_archivo`, `.claude` ni `.DS_Store`, con enlaces simbólicos a `renv/library` y a `20_insumos/auxiliares/directorio_oficial_ee.csv`, que trae MRUN y no se copia; en su raíz, `verificar_portabilidad_plantada.R` con `ruta <- "/Users/persona/Documents/datos.csv"`, la misma ruta que plantó s35b; `00_build.R` de la copia con el md5 del árbol, 399f53c3…). Modo interactivo: `cd <copia> && R --interactive --no-save --no-restore -q < entrada.R`, con `entrada.R` = `cat("interactive() al abrir la sesion:", interactive(), "\n")`, `source("00_build.R")` y `cat("interactive() tras source():", interactive(), "| la sesion sigue\n")`. `--interactive` hace que R trate la entrada como interactiva aunque no venga de una terminal: un error de primer nivel no cierra la sesión, igual que en la consola (salida en `e1/interactivo_antes.txt`). Después, `cd <copia> && Rscript 00_build.R` (`e1/rscript_antes.txt`).
esperado: en modo interactivo, el build **no** se detiene (R-69 de s35b); con `Rscript`, se detiene
obtenido: modo interactivo: «interactive() al abrir la sesion: TRUE»; «here() starts at …/cal_s35i/e1/repo»; «Fallas criticas: 1 | Advertencias: 7», hallazgo «verificar_portabilidad_plantada.R 2 ruta_usuario_macos»; luego «=== 00_build.R: iniciando pipeline ===» y «=== 00_build.R: OK en 7 segundos ===»; «interactive() tras source(): TRUE | la sesion sigue»; codigo_R=0. Las salidas se escribieron en la copia (`40_salidas/` del árbol sin cambios: fe30d56f… y 69357a69…, `git status` solo con este log). `Rscript`: codigo_rscript=1; «Fallas criticas: 1», el mismo hallazgo y «Error: Validacion de portabilidad fallida: 1 falla(s) critica(s). Revisar el reporte anterior.»; 0 líneas «iniciando pipeline». **Dispara** (Q-39 reproducida).

*B1* (lectura de las 33 llamadas a `comprobar(` de `30_procesamiento/36_verificar_trayectorias.R` en `37737b5` y de `traspaso_cierre_v30.md` §4.16). Definiciones usadas (una línea cada una):
- **A, capa de datos:** el DATA que construye el generador, y los insumos que lo alimentan, es correcto: agregados, conteos, reglas de filas, fidelidad y determinismo.
- **B, invariantes del motor de la vista:** lo que el JavaScript de la vista dibuja o escribe desde DATA según el estado en pantalla (marcas, rótulos, tooltip, burbujas) cumple su regla.
- **C, coherencia entre tabla y gráfico:** la tabla de la tarjeta lateral y el plano muestran lo mismo para el mismo estado (unidades, año y cifras).
- **D, presentación:** el HTML escrito como pieza entregada: su marcado, los textos de las notas, la independencia de la red y la disposición.

| prueba | familia | justificación (lo que mide) |
|---|---|---|
| D1 | A | la frontera Adecuado + Insuficiente ≤ 100 de los agregados recalculados sobre el parquet |
| D2 | A | el consolidado recalculado equivale a los cinco grupos ponderados |
| D3 | A | los evaluados del consolidado igualan la suma por grupo |
| D4 | A | un solo grupo socioeconómico por escuela dentro de nivel y prueba, en la base |
| D5 | A | el conteo de escuelas que cambian de grupo entre niveles, sobre la base |
| D6 | A | el panel de serie completa nunca tiene más establecimientos que el total |
| D7 | A | toda combinación del panel de serie completa existe en el total |
| D8 | A | control positivo de D2: una cifra alterada en 0,5 puntos dispara un hallazgo |
| D9 | A | el `n` del total T del DATA iguala la suma de grupos del parquet |
| D9c | A | control positivo de D9 en una unidad vigente |
| D9f | A | control positivo de D9 en una unidad futura |
| D10 | A | el DATA del generador es fiel al del mockup de la sesión 30 (solo empates) |
| D10c | A | control positivo de D10 |
| D11 | D | las notas del HTML escrito declaran las cifras que traen los datos (texto presentado) |
| D12 | D | el HTML escrito no carga nada por red y trae incrustado el DATA del generador (pieza entregada) |
| D12c | D | control positivo del patrón de red de D12 |
| D13 | A | el DATA no depende del orden de las filas del parquet |
| D13c | A | control positivo de D13 |
| D14 | A | la base aplica la regla de filas del motor (marca y 10 evaluados) |
| D14c | A | control positivo de D14 |
| C1 | A | las 37 unidades futuras del `meta` y su reparto por ola |
| C2 | A | los identificadores futuros no chocan con los vigentes |
| C3 | A | agregar las unidades futuras no cambia las filas de las vigentes ni del referente |
| C4 | A | `post` = 0 en toda unidad futura |
| C5 | A | la suma de establecimientos de las unidades futuras (2.564) |
| C6 | D | el marcado de los botones de cohorte en el HTML escrito (un `span.tx` con el año) |
| R1 | A | el tamaño del referente en `meta` (1.299) |
| R2 | B | la leyenda que la vista escribe desde DATA para el año, la prueba, el grupo y la cobertura en pantalla |
| R3 | A | con un año sintético, el DATA del referente pierde exactamente esos establecimientos |
| R4 | B | las marcas de ola que la vista dibuja: ninguna con los datos actuales, una por ola alcanzada con el DATA de la copia de R3 |
| R5 | A | el conteo del referente por ola en `meta` (475, 406 y 401) |
| R6 | B | la leyenda que la vista escribe con el DATA de la copia de R3 en su último año |
| R7 | B | el tooltip del referente que la vista arma desde DATA al pasar el cursor |

esperado: se registra; si todas las familias tienen dos o más pruebas, B1 se reduce a escribir la asignación
obtenido: A 25 (D1-D10c, D13-D14c, C1-C5, R1, R3, R5), B 4 (R2, R4, R6, R7), **C 0**, D 4 (D11, D12, D12c, C6); total 33. La familia C no tiene pruebas: ninguna compara la tabla de la tarjeta con el plano. B1 agrega dos pruebas a la familia C. Las demás tienen dos o más.

*V3* (`$TMPDIR/cal_s35i/v3_medir.R`, base de H6; `v3/base.txt` y `v3/base.rds`). A 1280 × 900 y 900 × 900, las 9 cohortes de `#c-coh` (2018, la inicial, 2020, 2021, 2024, 2025, 2026, 2027, 2028 y 2029). Referencia por cohorte X: carga nueva y, si X no es la inicial, un clic en X (la inicial, sin clic). Par A → B (72 pares ordenados por ancho): carga nueva; si A no es la inicial, un clic en A; luego un clic en B. Se leen `--cardw`, la clase `una-col` de `#app`, la cohorte activa y el `offsetWidth` de `.card`.
esperado: al menos un par distinto de la referencia (2027 → 2018: 403 contra 317, Q-65)
obtenido: referencia igual en los dos anchos: 2018 317, 2020 321, 2021 305, 2024 324, 2025 322, 2026 322, 2027 522, 2028 323, 2029 329 px (`una-col` solo en la 2027 a 900 px). Cohorte activa = destino en 72/72 por ancho. **1280 px: 57 de 72 pares distintos** (todos por `--cardw`; `una-col` 0); **900 px: 57 de 72 distintos** (`--cardw` 57; `una-col` 8: los ocho que salen de la 2027 quedan en una columna). **2027 → 2018: 403 contra 317** en los dos anchos; desde la 2027, 396 a 407 contra 305 a 329; entre las demás, de −5 a +9 px (p. ej., 2029 → 2018: 328 contra 317; 2021 → 2020: 316 contra 321). Los 15 iguales por ancho son los 8 que parten de la inicial y los 7 que llegan a la 2027. **Dispara.**

*M5* (`$TMPDIR/cal_s35i/m5_medir.R`, base de H6; `m5/base_barrido.txt`). Cinco territorios: los cuatro del estado inicial (CONCÓN, PUCHUNCAVÍ, QUINTERO y VIÑA DEL MAR) más el primero habilitado de la pestaña «SLEP» del modal, **SLEP Aconcagua** (el mismo camino que `m2_medir.R` de s35h). Medidor: el `JS_MEDIR` de M2 de s35h, sin cambios en la regla (nodos de texto HTML del supergrid, fuera de los SVG, con alguna caja de línea que pasa el borde derecho o izquierdo de su celda, con tolerancia de 0,01 px). Modo barrido: una carga a 641 px, se fijan los 5 territorios y se cambia el ancho de la ventana de 1 en 1 px hasta 760, con 0,6 s de espera tras cada cambio.
esperado: `W_FUERA` entre 641 y 700 (R-40 de s35h dice ~686)
obtenido: 120 anchos, 5 territorios en 120/120, 82 textos por ancho; con algún texto fuera, **641 a 666** (26 anchos), siempre uno solo, PUCHUNCAVÍ (`.sg-ent-name`): +5,06 px a 641, +3,25 a 650, +1,25 a 660, +0,06 a 666, −0,14 a 667 (dentro). Pista mínima 102,59 px a 641 y 107,59 a 666 (crece 0,2 px por px); `--supergrid-col-min` = 0px en los 120; `scrollWidth` del documento = ancho en 120/120. **`W_FUERA` = 666**, dentro del rango esperado. Corte que resulta (§7, M5, paso 1: el primer múltiplo de 10 mayor que `W_FUERA`): **670 px**.

Validación del barrido con cargas nuevas (`m5_medir.R … carga`, una carga y los 5 territorios por ancho, en 641, 650, 660, 665, 666, 667, 668, 670, 686, 687, 690, 700 y 760; `m5/base_carga.txt`)
esperado: los mismos valores que el barrido
obtenido: iguales en los 13 anchos (pista, textos fuera y sobra: 641 +5,06; 666 +0,06; 667 −0,14; 686 −3,94; 760 −9,83); `W_FUERA` = 666. El barrido no depende del camino.

Información (otro método, `m5_celdas.R`: por celda del supergrid, `scrollWidth > clientWidth + 0,5`, el método de `rd_m2.R` de s35h con el que se escribió R-40; `m5/base_celdas.txt`): 1 celda con desborde de 641 a 665 (la cabecera de PUCHUNCAVÍ), 0 desde 666; `scrollWidth` del documento = ancho en 120/120. El «~686» de R-40 no es un desborde medido: es el ancho en que la pista llega a 111,66 px, el nombre (103,66) más el relleno de su celda a los dos lados (4 + 4), el mismo cálculo que fijó 112 px en s35h (pista de 111,59 a 686 y 111,80 a 687); y los «~9 px» son lo que le falta a la pista a 641 (111,66 − 102,59 = 9,07). Entre 667 y 686 px el nombre ocupa parte del relleno derecho de su celda sin salir de ella. Ver D0-a y Q-67.

**Compuerta de dudas previa al acto público** (SETTINGS §2.1, gatillo 2). Dudas abiertas antes de publicar y la tarea que mide cada una: ¿el build se detiene en modo interactivo? → E1; ¿cada prueba tiene familia y cada familia dos o más? → B1; ¿`--cardw` no depende de la cohorte anterior? → V3; ¿ningún nombre sale de su columna con 5 territorios? → M5; ¿lo publicado es idéntico a lo construido? → PUB; ¿Pages lo sirve? → P3.

**Cierre de FASE 0.**
- Estado: completa. H1 a H6 dan lo esperado; las cuatro calibraciones disparan o se registran como pide el encargo.
- Commits: `37737b5` docs(sesion 35): encargo de la novena ola y decisiones D35-14 y D35-15 (T0, punto de retorno).
- Cambios sustantivos: ninguno en el producto. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35i/`.
- Alcance: T0 tocó solo sus tres rutas.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno (el encargo no los admite).
- Bugs: ninguno.
- Decisiones autónomas:
  - D0-a (riesgo medio): `W_FUERA` se mide con el medidor de M2 de s35h, como pide el paso 8 (borde de la celda), y da 666; el corte es 670, no el «del orden de 690 px» de D35-15, que venía de la estimación de R-40 (el ancho en que la pista llega a los 112 px de `--supergrid-col-min`). Con 670, ningún nombre sale de su celda; de 671 a 686 px, PUCHUNCAVÍ ocupa hasta 4 px del relleno derecho de su celda. Queda como duda Q-67.
  - D0-b (riesgo bajo): el modo interactivo de E1 se logra con `R --interactive` y la entrada desde un archivo: `interactive()` da TRUE en la misma sesión (antes y después del `source()`), y un error de primer nivel no cierra la sesión, como en la consola.
  - D0-c (riesgo bajo): en V3 la referencia de la cohorte inicial es la carga nueva sin clic (como en s35h); los 8 pares que parten de la inicial coinciden por construcción con el camino de la referencia y se cuentan igual.
  - D0-d (riesgo medio): en la asignación de B1, R2, R6 y R7 van a B (texto que la vista calcula desde DATA para el estado en pantalla, no texto fijo del HTML), y D11, D12 y D12c a D (el HTML escrito como pieza entregada). Con otra lectura, R2, R6 y R7 serían de D y B quedaría con una prueba (R4); la familia C queda en 0 con cualquiera de las dos.
  - D0-e (riesgo bajo): el barrido de M5 (una carga y cambios de ancho) se validó contra cargas nuevas en 13 anchos: valores idénticos.
- Errores propios: ninguno.
- Dudas: Q-67 (corte del supergrid: 670 contra 690), en el cierre.

### FASE E1: el build se detiene ante una falla de portabilidad en cualquier modo (Q-39)

- Estado: completa, en el primer intento.
- Commits: `90542fb` fix(build): la falla de portabilidad detiene el build tambien en modo interactivo (Q-39).

**Cambio** (`00_build.R`): la llamada pasa de `validar_portabilidad()` a `validar_portabilidad(detener_si_falla = TRUE)`, y el comentario de arriba dice que una falla crítica detiene el build con Rscript y también con `source()` interactivo (Q-39, D35-13), porque el valor por omisión del validador (`!interactive()`) solo lo detenía con Rscript. El validador (`10_utils/10_validar_portabilidad.R`, plantilla canónica que no se edita por proyecto) no cambia.

**Criterio: en la copia con la ruta plantada, en modo interactivo, el build se detiene antes de «iniciando pipeline»** (la misma copia y el mismo modo de FASE 0, con `00_build.R` del árbol copiado encima, md5 2fe67986… en los dos; `e1/interactivo_despues.txt`)
esperado: se detiene antes de «iniciando pipeline», con un error que nombra la falla
obtenido: «interactive() al abrir la sesion: TRUE»; «Fallas criticas: 1 | Advertencias: 7», hallazgo «verificar_portabilidad_plantada.R 2 ruta_usuario_macos»; «Error: Validacion de portabilidad fallida: 1 falla(s) critica(s). Revisar el reporte anterior.»; `grep -c "iniciando pipeline"` = 0; «interactive() tras source(): TRUE | la sesion sigue». Las salidas de la copia no se reescribieron (siguen con la hora de FASE 0, 09:54). Antes (FASE 0): llegaba a «OK en 7 segundos». **Cumple.**

**Criterio: con `Rscript` también se detiene** (`cd <copia> && Rscript 00_build.R`; `e1/rscript_despues.txt`)
esperado: código distinto de 0
obtenido: codigo_rscript=1; «Fallas criticas: 1», el mismo hallazgo y el mismo «Error: Validacion de portabilidad fallida…»; 0 líneas «iniciando pipeline». **Cumple.**

**Criterio: sobre el árbol real, sin ruta plantada, el build da código 0 y las salidas de H6** (`cd "$RAIZ" && Rscript 00_build.R`; `$TMPDIR/cal_s35i/e1_build.txt`)
esperado: código 0; salidas iguales a las de H6 (el motor, fuera de `meta$fecha_generacion`)
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «iniciando pipeline» y «OK en 6 segundos»; motor fe30d56f866d082501bd8937a24f752e y vista 69357a69dc04db6186e75d3245c6b873, iguales byte a byte a la base de H6 (la fecha también coincide); I-3 codigo_I3=0 «JSON idéntico a la línea base»; I-4 codigo_I4=0 «identical: TRUE» (códigos leídos sin tubería). **Cumple.**

Comprobación adicional (no es criterio): en la copia **sin** la ruta plantada (el archivo se apartó con `mv` y se devolvió después), en modo interactivo: «Fallas criticas: 0 | Advertencias: 7», «iniciando pipeline», «OK en 6 segundos» e «interactive() tras source(): TRUE» (`e1/interactivo_sin_plantar.txt`). Con 0 fallas, el build interactivo no se detiene.

- PRUEBAS: build codigo 0; la batería corre en B1 (E1 no cambia las salidas).
- Alcance: `git show --numstat 90542fb` = `00_build.R` (+7/−5). Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno. Decisiones autónomas: ninguna. Errores propios: ninguno. Dudas: ninguna.

### FASE B1: la batería cubre las cuatro familias de la auditoría de la sesión 30 (v30-5)

- Estado: completa, en el segundo de 3 intentos (con un defecto de FC1 hallado después del commit, para FASE R: ver Bugs).
- Commits: `14c9fb3` test(trayectorias): la bateria cubre las cuatro familias de la auditoria de la sesion 30 (v30-5).

**Cambios** (`30_procesamiento/36_verificar_trayectorias.R`):
- Encabezado: la frase que presenta FC1 y FC2; la lista de familias con la referencia a `traspaso_cierre_v30.md` §4.16, la definición de cada familia en una línea y la asignación de cada prueba (A: D1-D8, D9, D9c, D9f, D10, D10c, D13, D13c, D14, D14c, C1-C5, R1, R3, R5; B: R2, R4, R6, R7; C: FC1, FC2; D: D11, D12, D12c, C6), la de FASE 0; y FC1 y FC2 en «Requiere» y en «Salida».
- Dos pruebas nuevas de la familia C, después de R7, con ids **FC1** y **FC2** (prefijo «F» de familia más la letra; no chocan con D*, C1-C6 ni R1-R7), y dos funciones comunes: `leer_vista_con_cambio()` (escribe en `tempdir()` la vista con un fragmento del script cambiado, exige que aparezca una sola vez, la lee en Chrome y la borra) y las lecturas `JS_FILAS`, `JS_TABLA` y `JS_BURBUJAS`.
  - **FC1** (tabla ↔ DATA en el año del plano): en tres estados (inicial; último año de la pista; última cohorte), la tabla trae exactamente las unidades de la cohorte en pantalla y cada fila, la `e` de DATA para su unidad en el año de `#yr`, con la prueba, el grupo y la cobertura en pantalla (0 y fila `sd` si DATA no la trae); el conteo de la tarjeta nombra ese año y suma esas cifras. Control dentro de la prueba: la vista de control cuya tabla lee el año siguiente al del plano (`var yr=anioAct(),L=ids()` → el año siguiente).
  - **FC2** (tabla ↔ plano): en el estado inicial y tras desmarcar la primera fila con dato, toda burbuja visible es de una fila marcada y lleva su número; ninguna unidad tiene dos; toda fila marcada con dato en el año tiene su burbuja con el dato de ese año (`data-real` 1 y `data-yr` = `#yr`), y la de una fila sin dato no dice tenerlo; la fila desmarcada pierde su burbuja. Los números se leen solo de la capa de cifras, emparejados con su burbuja por `data-cx` y `data-cy`. Controles dentro de la prueba: la vista que deja en el plano la burbuja de una fila desmarcada (`visible()` sin `S.ocultos`) y la que numera las filas con uno de más (`nt.textContent=NUM[id]+1;`).
  - Defectos de prueba de la sesión 30: FC2 no cuenta los rótulos de los ejes como números de burbuja (B3): de los 22 textos con contenido de `svg#g` en el estado inicial, lee solo los 4 con `data-cx`; los 18 restantes son los rótulos de los ejes (0 a 80) y el título del eje X (`$TMPDIR/cal_s35i/b1/textos_plano.R`). Ninguna de las dos mide tamaños tipográficos (D3).

Intento 1 (parche en `$TMPDIR/cal_s35i/b1/intentos/B1_intento1.patch`, 212 líneas, md5 1fd5c9b84fb32618aced72592a970279): la batería dio «35 pruebas, 33 pasan, 2 fallan», con 16 desajustes en 4 filas en FC1 y 8 en FC2. Causa (`b1/depurar.R`): el selector del nombre, `td.nm .rw span:last-child`, tomaba primero el `span.tx` del número (también es el último hijo de su padre), así que el «nombre» leído era el número. Intento 2: `td.nm .rw > span:last-child`.

**Criterio: batería en PASA, con código 0 y más de 33 pruebas** (`cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R`; `b1/bateria_i2.txt`)
esperado: código 0, más de 33 en PASA
obtenido: codigo_bateria=0; «Resultado: 35 pruebas, 35 pasan, 0 fallan». Líneas literales:
```text
FC1    PASA  Cada fila de la tabla trae las unidades de la cohorte y los establecimientos que DATA da para el año del plano (inicial: cohorte 2018, 4b_lect, T, año 2014, 4 filas, 0 desajustes; ultimo_anio: cohorte 2018, 4b_lect, T, año 2025, 4 filas, 0 desajustes; ultima_cohorte: cohorte 2029, 4b_lect, T, año 2014, 13 filas, 0 desajustes; control con la tabla en el año siguiente al del plano (2014): 4 desajustes, detectado: TRUE)
FC2    PASA  La tabla y el plano muestran las mismas unidades: una burbuja por fila marcada, con su número y el año del plano (inicial (año 2014): 4 filas, 4 burbujas, 0 desajustes; tras desmarcar la primera fila: 1 desmarcada, su burbuja sale: TRUE, 3 burbujas, 0 desajustes; control con la burbuja de la fila desmarcada en el plano: 1 desajustes, detectado: TRUE; control con las filas numeradas con uno de más: 4 desajustes, detectado: TRUE)
```
**Cumple.**

**Criterio: cada prueba tiene familia y cada familia dos o más** (`$TMPDIR/cal_s35i/b1/familias.R`: lee la lista del encabezado y los ids que imprime la batería)
esperado: 35 ids con una sola familia, los mismos de la salida; A, B, C y D con dos o más
obtenido: «ids en el encabezado: 35 | distintos: 35 | ids en la salida: 35»; «por familia: A=25, B=4, C=2, D=4»; sin ids de la salida sin familia, sin ids del encabezado que la batería no imprima y sin ids con dos familias; «cada prueba con una familia y cada familia con dos o más: TRUE», codigo_familias=0. Control: con FC2 quitado de una copia del encabezado, «C=1», «ids de la salida sin familia: FC2», «… TRUE» → FALSE, codigo 1 (leído sin tubería). **Cumple.**

**Calibración: cada prueba nueva da FALLA sobre un valor plantado.** Una copia de la batería en `$TMPDIR/cal_s35i/b1/bateria_calib.R` que solo cambia `RUTA_HTML` por `Sys.getenv("VISTA_CALIB")` (`diff`: una línea), contra dos vistas saboteadas en `$TMPDIR` con un defecto distinto de los que plantan los controles internos:
- `vista_fc1_e_mas_uno.html`: la tabla muestra un establecimiento de más en cada fila con dato (`ce.textContent=d?d.e:'0';` → `d.e+1`);
- `vista_fc2_sin_repintar.html`: al desmarcar una fila, se redibuja la tabla pero no el plano (`…S.ocultos[id]=!ck.checked;render();` → `tarjeta();`).

esperado: FC1 da FALLA con la primera y FC2 con la segunda
obtenido (literal; «Resultado: 35 pruebas, 34 pasan, 1 fallan» y código 1 en las dos corridas; en cada una, la otra prueba nueva y D11, D12 y C6 pasan):
```text
FC1    FALLA Cada fila de la tabla trae las unidades de la cohorte y los establecimientos que DATA da para el año del plano (inicial: cohorte 2018, 4b_lect, T, año 2014, 4 filas, 4 desajustes; ultimo_anio: cohorte 2018, 4b_lect, T, año 2025, 4 filas, 4 desajustes; ultima_cohorte: cohorte 2029, 4b_lect, T, año 2014, 13 filas, 13 desajustes; control con la tabla en el año siguiente al del plano (2014): 4 desajustes, detectado: TRUE)
FC2    FALLA La tabla y el plano muestran las mismas unidades: una burbuja por fila marcada, con su número y el año del plano (inicial (año 2014): 4 filas, 4 burbujas, 0 desajustes; tras desmarcar la primera fila: 1 desmarcada, su burbuja sale: FALSE, 4 burbujas, 1 desajustes; control con la burbuja de la fila desmarcada en el plano: 1 desajustes, detectado: TRUE; control con las filas numeradas con uno de más: 4 desajustes, detectado: TRUE)
```
Además, los controles internos de la corrida real detectan: FC1, 4 desajustes con la tabla en el año siguiente; FC2, 1 con la burbuja de la fila desmarcada y 4 con las filas numeradas con uno de más. **Dispara.**

**Criterio: el producto no cambia** (`git diff --name-only` antes del commit; build de B1 en `$TMPDIR/cal_s35i/b1/build.txt`)
esperado: solo la batería; salidas iguales a las de H6
obtenido: `30_procesamiento/36_verificar_trayectorias.R`; codigo_build=0, «Fallas criticas: 0 | Advertencias: 7»; motor fe30d56f… y vista 69357a69… (iguales a la base de H6), copiadas a `$TMPDIR/cal_s35i/b1/salidas/` (el «build de B1» de V3). **Cumple.**

- PRUEBAS: batería 35/35, código 0; build código 0.
- Alcance: `git show --numstat 14c9fb3` = `30_procesamiento/36_verificar_trayectorias.R` (+180/−5). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs:
  - intento 1: el selector del nombre (corregido en el intento 2, antes del commit);
  - **después del commit**, al revisar la salida de la calibración: en `desajustes_fc1()`, `… + !grepl(<año del conteo>) + !identical(<total del conteo>)`. En R el `!` unario tiene menor precedencia que `+`, así que se evalúa como `!(grepl(…) + !identical(…))`: si el año y el total del conteo fallan a la vez, los dos quedan ocultos (con la vista de +1, 4 desajustes y no 5, porque el total del conteo no se sumó). Las filas sí se cuentan, y el criterio y la calibración de B1 se cumplen, pero la comprobación del conteo no hace lo que dice su comentario. Es un defecto del propio trabajo, dentro del ALCANCE de B1 y sin tocar un 🔒: se registra para FASE R (REPARA, commit `fix(auditoria)`), sin rehacer el commit de B1.
- Decisiones autónomas:
  - D-B1-a (riesgo bajo): ids FC1 y FC2 (familia C). La letra sola chocaría en lo conceptual con C1-C6 (cohortes).
  - D-B1-b (riesgo bajo): la calibración «da FALLA sobre el valor plantado» se hizo con la prueba completa corriendo contra vistas con un defecto plantado (la salida literal de arriba), además de los controles dentro de cada prueba. Los defectos plantados son distintos de los fragmentos que cambian los controles internos, para que la prueba falle por su comparación y no porque un control no encuentre su fragmento.
- Errores propios: el selector del intento 1 y la precedencia de `!` (arriba).
- Dudas: ninguna nueva (la lectura de R2, R6 y R7 como B va en D0-d y Q-68, en el cierre).

### FASE V3: la tarjeta se mide igual sin importar la cohorte anterior (Q-65)

- Estado: completa, en el primer intento.
- Commits: `0e4b544` fix(trayectorias): la tarjeta se mide igual sin importar la cohorte anterior (Q-65).

**Cambio** (vista): en `rebuild()`, después de `tarjeta()` y antes de `anchoTarjeta()`, `document.documentElement.style.removeProperty('--cardw')`, como en el manejador de `resize` y en `trasFuentes()`, con un comentario que cita Q-65 y D35-15. `rebuild()` corre al cambiar de cohorte, de prueba, de grupo o de cobertura.

Build (`$TMPDIR/cal_s35i/v3/build_i1.txt`; salidas en `v3/i1/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor fe30d56f… (sin cambio), vista 883f76bcefc89d93f2d1e753fc4d75c3

**Criterio: `--cardw` y `una-col` al llegar a una cohorte = carga nueva, en todos los pares** (`v3_medir.R` sobre el build, un proceso por ancho; `v3/i1_1280.txt` y `v3/i1_900.txt`)
esperado: en los 72 pares ordenados de FASE 0, a 1280 × 900 y 900 × 900, `--cardw` igual al de llegar a esa cohorte desde la inicial en una carga nueva, y la clase `una-col` igual
obtenido: «v3_1280 a 1280 px: 72 pares | iguales a la referencia 72 | distintos 0 (--cardw 0, una-col 0) | cohorte activa = destino 72/72»; «v3_900 a 900 px: 72 pares | iguales a la referencia 72 | distintos 0 (--cardw 0, una-col 0) | cohorte activa = destino 72/72» (FASE 0: 57 distintos en cada ancho). **Cumple.**

La referencia (carga nueva) cambia en 7 de las 9 cohortes, lo que s35h anticipó en Q-65 y el titular aceptó en D35-15: 2018 317 = 317; 2020 321 → 314; 2021 305 → 297; 2024 324 → 317; 2025 322 → 316; 2026 322 → 315; 2027 522 = 522; 2028 323 → 317; 2029 329 → 323 px (iguales a 1280 y a 900; `una-col` solo en la 2027 a 900, como antes). Antes, el clic desde la inicial medía desde los 317 px de la inicial; ahora, desde el valor por omisión, como la carga de la inicial. Información (`v3/lineas.txt`, 1280 px, cada cohorte con un clic desde la inicial): en la base y en V3, 0 nombres de la tabla en dos líneas en las 9 cohortes y el mismo alto de tabla (104,5 a 350,5 px): la tarjeta pierde aire sobrante, no parte nombres.

**Criterio: en la carga inicial, 0 píxeles contra el build de B1** (`capturas.R` modo `inicial` con `CAP_VISTAS=vista`, a 375, 768, 1024 y 1280 px: página completa a DSF 1 y ventana de arriba a DSF 2; build de B1 en `b1/cap/`, build de V3 en `v3/cap/`)
esperado: 0 píxeles distintos
obtenido: 0 en las 8 capturas (páginas de 2.133, 1.652, 1.230 y 1.119 px de alto). **Cumple.**

Comprobaciones adicionales:
- Batería sobre el build: codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan».
- I-4: codigo_I4=0, «identical: TRUE».
- Capturas del build de V3 para M5 (`v3/cap/`): `#comparacion` en su estado inicial a 375, 414, 768, 1024 y 1280 px, y el modal en sus 6 pestañas a 375 y 414 px (el motor de V3 es el de la base, fe30d56f…).

- PRUEBAS: build codigo 0; batería 35/35.
- Alcance: `git show --numstat 0e4b544` = `30_procesamiento/36_trayectorias_template.html` (+7/−1). Las capturas van en `$TMPDIR` (no se guardaron capturas para el titular: la vista inicial no cambia y el cambio es de 5 a 8 px de aire en la tarjeta tras un clic). Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno.
- Decisiones autónomas: D-V3-a (riesgo bajo): el reinicio va después de `tarjeta()`, justo antes de `anchoTarjeta()`, como en el manejador de `resize`; también vale para los cambios de prueba, grupo y cobertura, que pasan por `rebuild()`.
- Errores propios: ninguno. Dudas: ninguna.

### FASE M5: ningún nombre sale de su columna del supergrid con 5 territorios (Q-66)

- Estado: completa, en el primer intento.
- Commits: `0ec0d41` fix(motor): el supergrid usa su ancho minimo hasta que ningun nombre sale de su columna (Q-66).

**Cambios** (motor):
- `:root { --supergrid-col-min: 112px; }` y `.supergrid { overflow-x: auto; }` salen del `@media (max-width: 640px)`, que conserva sin cambios las reglas del panorama y del modal, y pasan a un `@media (max-width: 670px)` propio, justo después, con su comentario (el de s35h más el origen del corte: con 5 territorios y el corte en 640 px, PUCHUNCAVÍ salía de su celda hasta 666 px, `W_FUERA` medido de 641 a 760 px; el corte es el primer múltiplo de 10 mayor que `W_FUERA`; va como literal porque las variables CSS no valen en la condición de un `@media`).
- El comentario de `--supergrid-col-min` en `:root` dice ahora «bajo 670 px lo fija la regla del supergrid del final de la hoja, en su propio @media (encargo s35i, Q-66)».
- Corte: **670 px** (`W_FUERA` = 666 en FASE 0; D0-a).

Build (`$TMPDIR/cal_s35i/m5/build_i1.txt`; salidas en `m5/i1/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 42ab93003e722f9bb6c725fec2d348bd, vista 883f76bc… (sin cambio)

**Criterio: con los 5 territorios de FASE 0, de 375 a 760 px en pasos de 1 px, 0 textos fuera de su celda** (`m5_medir.R … 375:760 barrido` sobre el build; `m5/i1_barrido.txt`)
esperado: 0 textos fuera en los 386 anchos
obtenido: «386 anchos de 375 a 760 | con algún texto fuera: 0 | W_FUERA (el mayor con algún texto fuera): ninguno | … | doc scrollWidth = ancho en 386/386 | 5 territorios en 386/386»; territorios CONCÓN, PUCHUNCAVÍ, QUINTERO, VIÑA DEL MAR y SLEP Aconcagua. Hasta 670 px, columnas de 112 px, sobra máxima −4,34 px (PUCHUNCAVÍ con 4,34 px de holgura) y el supergrid se desplaza en sí mismo (608/590 a 670, `overflow-x: auto`); desde 671, sin mínimo (pista de 108,59 px a 671, sobra −0,94, la menor holgura del barrido; 111,59 a 686; 126,39 a 760) y sin desplazamiento. Base (FASE 0): 26 anchos con un texto fuera, de 641 a 666. Validación con cargas nuevas en 375, 414, 540, 640, 641, 660, 666, 670, 671, 690 y 760 (`m5/i1_carga.txt`): los mismos valores, 0 fuera en los 11. **Cumple.**

**Criterio: I-8 en esos anchos, más 641, 660 y 690** (`scrollWidth` del documento de `#comparacion` con 5 territorios en el barrido de 375 a 760; y `$TMPDIR/cal_s35i/i8.R` sobre el build, las tres vistas en su estado inicial a 375, 414, 540, 641, 660, 690, 768, 1024 y 1280 px; `m5/i8.txt`)
esperado: `scrollWidth` = viewport
obtenido: barrido, 386/386; `i8.R`, «m5_i1 : I-8 PASA» (27 de 27). **Cumple.**

**Criterio: sobre el corte nuevo, 0 píxeles contra el build de V3 en `#comparacion` a 768, 1024 y 1280 px; bajo 641 px, 0 píxeles en `#comparacion` y en el modal abierto a 375 y 414 px** (`capturas.R` modo `inicial` con `CAP_VISTAS=comparacion`, página completa a DSF 1 y ventana de arriba a DSF 2, y modo `modal`, las 6 pestañas; build de V3 en `v3/cap/`, build de M5 en `m5/cap/`; `comparar.R`)
esperado: 0 píxeles distintos
obtenido: 0 en las 22 capturas: `#comparacion` a 375, 414, 768, 1024 y 1280 px (10) y el modal a 375 y 414 px en sus 6 pestañas (12). **Cumple.**

Información (no es criterio): dentro del tramo nuevo, a 660 px, `#comparacion` en su estado inicial (4 territorios) da 0 píxeles distintos contra el build de V3 (página completa y ventana de arriba): con 4 territorios las columnas ya miden más de 112 px y el contenedor con desplazamiento no cambió el rasterizado.

Comprobaciones adicionales:
- I-3: codigo_I3=0, «JSON idéntico a la línea base».

Capturas para el titular en `_archivo/20260926_capturas_s35i/` (ignorada; `$TMPDIR/cal_s35i/capturas_titular.R`):
- `s35i_m5_supergrid_660_5terr_{antes,despues}.png` (660 px, 5 territorios, recortadas al supergrid). Revisión visual: antes, PUCHUNCAVÍ toca el borde derecho de su columna; después, columnas de 112 px y la quinta cortada en el borde, que indica que el supergrid sigue hacia el lado.
- `s35i_v3_vista_1280_2027a2018_{antes,despues}.png` (vista a 1280 × 900 tras ir de la 2027 a la 2018; de la tarea V3): antes, `--cardw` 403 px; después, 317.

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --numstat 0ec0d41` = `30_procesamiento/33_motor_template.html` (+14/−8), más las capturas en `_archivo/20260926_capturas_s35i/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno.
- Decisiones autónomas:
  - D-M5-a (riesgo bajo): el `@media` nuevo va inmediatamente después del de 640 px, para que el orden de la hoja no cambie qué regla gana bajo 641 px.
  - D-M5-b (riesgo bajo): las dos capturas de V3 para el titular se tomaron aquí, junto con las de M5 (la carpeta está en el ALCANCE de las dos tareas).
- Errores propios: ninguno. Dudas: Q-67 (el corte: 670 contra 690; FASE 0, D0-a).

### FASE PUB: copia a `docs/`

- Estado: completa (E1, B1, V3 y M5 completas antes de copiar; ninguna congelada. El defecto de FC1 hallado tras el commit de B1 no cambia el producto: queda para FASE R).
- Commits: `823e3d3` deploy(docs): tarjeta por cohorte y corte del supergrid.

`md5 -q docs/index.html docs/trayectorias.html` antes de la copia
esperado: fe30d56f866d082501bd8937a24f752e y 69357a69dc04db6186e75d3245c6b873 (H4)
obtenido: fe30d56f866d082501bd8937a24f752e y 69357a69dc04db6186e75d3245c6b873

**Paso 1.** `Rscript 00_build.R` y la batería (salidas en `$TMPDIR/cal_s35i/pub/`)
esperado: código 0 y 33 pruebas o más en PASA
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 7 segundos»); codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3, iguales a los de M5 y V3 (build reproducible)

**Paso 2.** `cp 40_salidas/motor_comparacion.html docs/index.html` y `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html` (autorización 2)

**Paso 3. Verificación.**

md5 de `docs/` contra `40_salidas/`
esperado: iguales
obtenido: `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd = motor; `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3 = vista

I-2 (`grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'`)
esperado: 0 en cada uno
obtenido: `40_salidas/motor_comparacion.html` 0 0; `40_salidas/trayectorias_traspasos.html` 0 0; `docs/index.html` 0 0; `docs/trayectorias.html` 0 0

I-3 (`Rscript verificar_contenido_motor.R docs/index.html`) e I-4 (`i4_data_vista.R docs/trayectorias.html`), códigos leídos sin tubería
esperado: «JSON idéntico a la línea base»; `identical: TRUE`
obtenido: codigo_I3=0, «JSON idéntico a la línea base»; codigo_I4=0, «DATA de la vista: … identical: TRUE»

`git status --porcelain` antes del commit
esperado: solo los dos archivos de `docs/` (más este log, sin seguimiento)
obtenido: ` M docs/index.html`, ` M docs/trayectorias.html`, `?? 50_documentacion/andamios/logs/20260926_bateria_familias_s35i_log.md`

- Alcance: `git show --numstat 823e3d3` = `docs/index.html` (+14/−8) y `docs/trayectorias.html` (+7/−1). Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno. Decisiones autónomas: ninguna. Errores propios: ninguno. Dudas: ninguna.

### FASE R: auditoría y reparación

Sin subagentes: el orquestador re-deriva cada afirmación con un comando distinto del que la produjo. Scripts y salidas en `$TMPDIR/cal_s35i/r/`. Estado auditado: `HEAD` = `823e3d3`; punto de retorno `37737b5`.

**R.1 Inventario de afirmaciones auditables** (armado desde este log, antes de auditar):

| id | afirmación | fase |
|---|---|---|
| R-01 | H1-H4: tres rutas y el log sin commit; 0 stash; `HEAD` y `origin/main` en b150d57; md5 del encargo 9ce88735…; `docs/` fe30d56f… y 69357a69…; fuentes a7407ed6… y 0257bb4b…; 28 | FASE 0 |
| R-02 | T0 = `37737b5`, solo sus tres rutas, hijo de b150d57 | FASE 0 |
| R-03 | H5 33/33; H6 código 0, con las dos salidas iguales a `docs/` (md5, HTML fuera del bloque y JSON sin la fecha) | FASE 0 |
| R-04 | los comparadores de I-3 e I-4 disparan con un número alterado | FASE 0 |
| R-05 | capturas de la base deterministas (12 de 12) | FASE 0 |
| R-06 | E1, calibración: en modo interactivo, con la ruta plantada, el build no se detiene; con `Rscript`, sí | FASE 0 |
| R-07 | B1, calibración: asignación de las 33 pruebas (A 25, B 4, C 0, D 4) | FASE 0 |
| R-08 | V3, calibración: 57 de 72 pares distintos de la carga nueva en cada ancho; 2027 → 2018: 403 contra 317 | FASE 0 |
| R-09 | M5, calibración: `W_FUERA` = 666 (PUCHUNCAVÍ fuera de 641 a 666), igual con cargas nuevas; corte 670; el «~686» de R-40 es el ancho en que la pista llega a 111,66 px | FASE 0 |
| R-10 | E1: en la copia con la ruta, el build interactivo se detiene antes de «iniciando pipeline» con el error que nombra la falla; `Rscript` código 1; el árbol real da código 0 y las salidas de H6 | E1 |
| R-11 | `90542fb` toca solo `00_build.R` | E1 |
| R-12 | B1: batería 35/35 con código 0; cada prueba con una familia y cada familia con dos o más; FC1 y FC2 dan FALLA con una vista saboteada cada una; el producto no cambia | B1 |
| R-13 | `14c9fb3` toca solo la batería | B1 |
| R-14 | V3: 72/72 pares iguales a la carga nueva a 1280 y 900 px; carga inicial con 0 píxeles distintos a 375, 768, 1024 y 1280 px; ningún nombre en dos líneas | V3 |
| R-15 | `0e4b544` toca solo la vista | V3 |
| R-16 | M5: con los 5 territorios, 0 textos fuera de su celda de 375 a 760 px; I-8; 0 píxeles sobre el corte y bajo 641 px (`#comparacion` y modal) | M5 |
| R-17 | `0ec0d41` toca solo el motor | M5 |
| R-18 | `docs/` = `40_salidas/` (42ab9300…, 883f76bc…); I-2 en 0; JSON y DATA idénticos; build reproducible | PUB |
| R-19 | `823e3d3` toca solo los dos `docs/` | PUB |
| R-20 a R-28 | I-1 a I-9 | §4 |
| R-29 | alcance global dentro de la unión de los ALCANCE, más el log | global |
| R-30 | regresión: build 0, batería ≥ 33 en PASA, JSON idéntico | global |
| R-31 | toda medida nueva va en una constante nombrada (el corte de M5, literal en el `@media` con su comentario, como pide el encargo) | B1, V3, M5 |
| R-32 | FC1 suma los desajustes del conteo de la tarjeta (año y total), como dice su comentario | B1 |

**R.2 Re-derivación independiente** (orquestador; scripts y salidas en `$TMPDIR/cal_s35i/r/`)

R-01, R-02, R-11, R-13, R-15, R-17, R-19 (`git fetch` y `rev-parse` completos, `git stash list`, `git diff-tree --numstat` de cada commit con su padre, `git show b150d57:…` y `git show 37737b5:…` a `md5`, `git ls-tree` de las fuentes, `git ls-files` con patrones)
esperado: `origin/main` = b150d57; 0 stash; cada commit toca solo su ALCANCE y es hijo del anterior; los blobs de b150d57 dan los md5 de H4
obtenido: fetch=0; `origin/main` b150d57d5d149fc243a807823e8e79aa00ca29e3; `HEAD` 823e3d36111e…; stash 0. `37737b5` (padre b150d57) 12/0 decisiones, 454/0 encargo, 33/0 log de errores; `90542fb` 7/5 `00_build.R`; `14c9fb3` 180/5 batería; `0e4b544` 7/1 vista; `0ec0d41` 14/8 motor; `823e3d3` 14/8 `docs/index.html` y 7/1 `docs/trayectorias.html`, cada uno hijo del anterior. Blobs de b150d57: `docs/` fe30d56f… y 69357a69…; encargo en 37737b5 9ce88735…; fuentes ccbdbdc6… (Bold) y b78fd5c5… (Regular); 28 archivos de datos → CONFIRMADAS

R-03 y R-18 (datos) por otra vía (`rd_inv.py`, Python: JSON del motor con zlib, sha256 canónico sin `meta.fecha_generacion`; HTML sin el bloque de datos; bloque `DATA` de la vista byte a byte; ahora contra b150d57)
esperado: el motor de H6 igual al publicado en b150d57; `docs/` con los datos de la base
obtenido: sha256 sin fecha 7967dfa07a99ef11 en `docs/`, `40_salidas/`, la base de H6 y `b150d57:docs/index.html` (el mismo de s35g y s35h); fecha 2026-09-26 en los cuatro; «claves de meta distintas: [] | JSON sin fecha igual: True | HTML fuera del bloque igual byte a byte: True»; «I-4 bloque DATA (docs contra base) idéntico byte a byte: True | largo 2018084 | igual al parsear: True» → CONFIRMADAS

R-04: control positivo de R.6 (R, Python y `hash-object`) → CONFIRMADA

R-05 (md5 de cada PNG, identidad de bytes y no el comparador de píxeles)
esperado: `cap_a` = `cap_b`
obtenido: 12 de 12 con el mismo md5 → CONFIRMADA

R-06 y R-10 (E1) con otro modo interactivo y otra ruta (`r/e1/`): una copia nueva del árbol (mismo `rsync` y enlaces), con `30_procesamiento/zz_plantada_fase_r.R` = `ruta <- "C:/Users/persona/Documents/datos.csv"` (otra carpeta, ruta de Windows); R en una terminal simulada con `script -q /dev/null R --no-save -q`, sin `--interactive` (`(cat entrada.R; sleep N) | script …`; la entrada termina en `q("no")`), con el `00_build.R` de `37737b5` (anterior a E1, md5 399f53c3…) y con el actual (2fe67986…); además, `Rscript` sobre la copia con el actual
esperado: con el anterior, el build interactivo no se detiene; con el actual, se detiene antes de «iniciando pipeline», y `Rscript` da código distinto de 0
obtenido: antes: «interactive() en la terminal simulada: TRUE»; «Fallas criticas: 3 | Advertencias: 7» (`ruta_usuario_macos`, `ruta_usuario_windows` y `letra_unidad` en la línea 2 del archivo plantado); «iniciando pipeline» 1 vez y «OK en 7 segundos». Actual: «interactive() en la terminal simulada: TRUE»; «Fallas criticas: 3»; «Error: Validacion de portabilidad fallida: 3 falla(s) critica(s). Revisar el reporte anterior.»; «iniciando pipeline» 0 veces; «tras source(), interactive(): TRUE». `Rscript`: codigo_rscript=1, 0 «iniciando pipeline», el mismo error → CONFIRMADAS

R-07 y R-12 (B1: familias) por otra vía (`rd_familias.py`, Python: ids de las llamadas a `comprobar(` en el **código** de la batería, no en su salida, contra la lista del encabezado y contra la tabla de FASE 0 de este log más FC1 y FC2 en C)
esperado: 35 ids con una familia; el encabezado igual a la tabla de FASE 0; cuatro familias con dos o más
obtenido: «ids en el código: 35 | distintos: 35 | en el encabezado: 35 | en la tabla de FASE 0 + FC: 35»; «por familia (encabezado): A 25, B 4, C 2, D 4»; sin ids sin familia, sin ids sin código, sin ids con dos familias; «encabezado distinto de la tabla de FASE 0: {}»; «B1 re-derivada: True», codigo 0. Control: la copia del encabezado sin FC2 da «{'FC2': (None, 'C')}» y codigo 1 → CONFIRMADAS

R-12 (B1: detección) con otros defectos plantados sobre la vista final (`docs/trayectorias.html`; la copia de la batería `r/bateria_calib.R` regenerada desde `HEAD`, que solo cambia `RUTA_HTML`):
- `vista_yr_mas_uno.html`: el año grande del plano (`#yr`) con uno de más, mientras la tabla y las burbujas siguen en el año real;
- `vista_total_mas_uno.html`: el total del conteo de la tarjeta con uno de más (`fmt(tot)` → `fmt(tot+1)`), con las filas intactas.

esperado: FC1 y FC2 dan FALLA con la primera; FC1 da FALLA con la segunda (su comentario dice que el conteo de la tarjeta «suma esas cifras»)
obtenido:
- primera: «FC1 FALLA … inicial: … año 2015, 4 filas, 4 desajustes; ultimo_anio: … año 2026, 4 filas, 9 desajustes; ultima_cohorte: … año 2015, 13 filas, 12 …»; «FC2 FALLA … inicial (año 2015): 4 filas, 4 burbujas, 4 desajustes; tras desmarcar …: 3 desajustes …»; «Resultado: 35 pruebas, 30 pasan, 5 fallan» (fallan también R2, R4 y R6, que leen `#yr`). → CONFIRMADA
- segunda: **«FC1 PASA … inicial: … año 2014, 4 filas, 0 desajustes; …»**; «Resultado: 35 pruebas, 35 pasan, 0 fallan». La comprobación del total del conteo no suma nunca. Causa, demostrada en R (`quote(a + !b + !c)` se lee `a + !(b + !c)`; `TRUE + !TRUE + !FALSE` da 1 y no 2): el defecto de precedencia registrado en B1. Con el año bien, el término vale `!(1 + x)` = 0 siempre; con el año mal, vale 1 solo si el total coincide. → **R-32 REFUTADA** (REPARA, R.8). El patrón `+ !` aparece solo en esas dos líneas de la batería (`grep -nE "^\s*!|\+\s*!"`: los demás `!` están en argumentos de `filter()` o en cadenas con `&&`, donde la precedencia es la esperada).

R-08 y R-14 (V3) con otros caminos, anchos, altos e indicadores (`rd_v3.R`: 8 caminos de uno a tres clics, entre ellos el clic sobre la cohorte activa y 2027 → 2027; 1440 × 900, 1100 × 700 y 823 × 1000; `--cardw`, `offsetWidth` de `.card` y número de pistas de `.main`, contra la carga nueva con un clic desde la inicial)
esperado: la base, dependiente del camino; `docs/`, igual a la carga nueva en todos
obtenido: base «24 caminos | iguales a la carga nueva: 0 | distintos: 24» (en los tres tamaños: ini > 2027 > 2018 403 contra 317; ini > 2018, re-clic sobre la activa, 323 contra 317; ini > 2021 > 2021 299 contra 305; ini > 2027 > 2027 527 contra 522; ini > 2020 > 2027 > 2025 404 contra 322); `docs/` «24 caminos | iguales a la carga nueva (--cardw, ancho de la tarjeta y pistas): 24 | distintos: 0» → CONFIRMADAS

R-09 y R-16 (M5) con dos instrumentos distintos del medidor de M2:
- `rd_m5.R` (lienzo, sin cajas de texto del DOM): por ancho, la pista de cada columna (`gridTemplateColumns` calculado) contra el relleno izquierdo de la cabecera más la palabra más ancha del nombre medida con `measureText` en la fuente calculada de `.sg-ent-name` (con su `letter-spacing`); barrido de 375 a 760 px con los 5 territorios de FASE 0;
- `m5_celdas.R` sobre `docs/`: por celda, `scrollWidth > clientWidth + 0,5`, de 375 a 760 px.

esperado: la base con un nombre que no cabe de 641 a 666 px; `docs/`, ninguno de 375 a 760
obtenido: lienzo, base «386 anchos | con algún nombre que no cabe: 26 | el mayor: 666» (PUCHUNCAVÍ, +5,05 a 641, +0,24 a 665; 0 bajo 641, donde la pista es de 112); lienzo, `docs/` «386 anchos | … : 0 | el mayor: ninguno»; celdas, `docs/` «386 anchos | con alguna celda con desborde: 0»; `scrollWidth` del documento = ancho en 386/386 en las tres corridas → CONFIRMADAS

R-18 y R-20 (identidad de lo publicado) con `git hash-object` y `git ls-tree HEAD docs/`
esperado: blobs iguales en `docs/`, `40_salidas/` y `HEAD`
obtenido: 2554f9a2f564… en `docs/index.html`, `40_salidas/motor_comparacion.html` y `HEAD:docs/index.html`; 7cbbdb7592da… en `docs/trayectorias.html`, `40_salidas/trayectorias_traspasos.html` y `HEAD` → CONFIRMADA

R-18 (red) con un segundo patrón (`rd_inv.py`: `src` con o sin comillas, `url(`, `<link href>`, `@import`, `fetch(`; cada `http` clasificado por dominio; `grep -c 'http'`)
esperado: 0 cargas; los aciertos de `http`, sin carga
obtenido: 0 cargas en los cuatro HTML. Motor: 26 URL (23 `http://www.w3.org`, `https://reactjs.org`, `https://d3js.org` y `https://github.com`), 17 líneas con `http`; vista: 2 (`www.w3.org`). Revisadas a mano: espacios de nombres SVG, el decodificador de errores de React y las licencias de D3 y pako; ninguna es una carga; son las mismas de s35h → CONFIRMADA

R-31 (`git diff 37737b5..HEAD` de las cuatro rutas del producto y la batería, líneas agregadas con cifras, sin comentarios; revisión a mano)
esperado: cifras nuevas del producto solo en constantes con nombre, salvo el corte de M5, literal con su comentario
obtenido: `00_build.R` sin cifras nuevas; la vista, cifras solo en el comentario de Q-65; el motor, `@media (max-width: 670px)` (el literal que pide el encargo, con su origen en el comentario) y cifras en comentarios; la batería, cifras estructurales (`1L`, `[1]`, `0`, `-1L`) y, dentro de la constante `JS_BURBUJAS`, el umbral de opacidad `>.3` para «burbuja visible», el mismo modismo y valor que `JS_HOVER_REF` de R7 y que `acomodaCifras()` de la vista → CONFIRMADA

**R.3 Invariantes 🔒** (estado `823e3d3`, tras el build de PUB)

I-1 `md5 -q docs/*.html` tras PUB
esperado: iguales a `40_salidas/`
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 en `docs/` y en `40_salidas/` → **PASA**

I-2 `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada uno
obtenido: 0 0 en los cuatro → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I3=0 → **PASA**

I-4 el `DATA` decodificado de la vista contra la base de H6 con `identical()` (`i4_data_vista.R`)
esperado: `TRUE`
obtenido: «DATA de la vista: claves anios,meta,nac,datos,nube,comunas | identical: TRUE», codigo_I4=0 → **PASA**

I-5 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… (Bold) y 0257bb4b… (Regular)
obtenido: a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc → **PASA**

I-6 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío (0 líneas) → **PASA**

I-7 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 (y 28 con `git ls-files -- '*.csv' '*.xlsx' '*.parquet' '*.rds' | wc -l`) → **PASA**

I-8 `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 414, 540, 641, 660, 690, 768, 1024 y 1280 px (`i8.R` sobre `docs/`, copiado a `r/docs_final/` con los nombres de `40_salidas/`)
esperado: igual al viewport
obtenido: «docs_final : I-8 PASA» (27 de 27); por otra vía (`rd_i8.R`, los 9 anchos: `scrollX` tras `scrollTo(100000, 0)` y `body.scrollWidth`): «I-8 (otra vía): PASA» → **PASA**

I-9 capturas de las tres vistas a 1280 × 900 y 1440 × 900, estado inicial, de `docs/` contra la base de H6 (`capturas.R` modo `inicial` sobre `r/docs_final/`, contra `base_s35i/cap_a/`)
esperado: 0 píxeles distintos
obtenido: 0 en las 12 con el comparador; además, 12 de 12 con el mismo md5 → **PASA**

**R.4 Alcance global** (`git diff --name-only 37737b5..HEAD` y `37737b5^..HEAD`, con `rd_alcance.R`; `git status --porcelain`)
esperado: 0 rutas fuera de la unión de los ALCANCE (más el log); el árbol solo con el log
obtenido: «rutas: 6 | fuera: (ninguna)» en el rango del encargo (`00_build.R`, las dos plantillas, la batería y los dos `docs/`) y «rutas: 9 | fuera: (ninguna)» con T0; `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260926_bateria_familias_s35i_log.md`; las capturas van en `_archivo/20260926_capturas_s35i/` (ignorada, 4 archivos) → **PASA**

**R.6 Control positivo de la propia auditoría**
- Cifra alterada en copias fuera del árbol (`r/ctl/`, sobre `docs/`): motor 3.5 → 3.6 y vista 23.9 → 23.8.
  - `verificar_contenido_motor.R`: «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)», codigo=1;
  - `i4_data_vista.R`: «identical: FALSE», codigo=1;
  - Python: «sha256 control aec5b073d08b11db | docs 7967dfa07a99ef11» y «bloque DATA idéntico: False»;
  - `git hash-object`: 9392ec7c… contra 2554f9a2… (motor) y f579b627… contra 7cbbdb75… (vista).

  **Dispara.**
- Archivo fuera de alcance en un diff simulado: `rd_alcance.R` sobre 8 rutas da «fuera: 30_procesamiento/32_agregar_comunal.R, 10_utils/fuentes/gobCL_Bold.otf, 40_salidas/intermedios/simce_rbd.parquet, _archivo/20260925_capturas_s35h/x.png, verificar_navegador.R, 10_utils/10_validar_portabilidad.R», codigo 1 (acepta la plantilla del motor y `docs/index.html`). **Dispara.**
- Además, los instrumentos nuevos dispararon sobre la base o sobre copias: la terminal simulada, con el `00_build.R` anterior (no se detiene); `rd_familias.py`, con FC2 quitado; `rd_v3.R`, 24 de 24 caminos distintos en la base; `rd_m5.R`, 26 anchos en la base; y la batería, con las vistas saboteadas (FC1 y FC2 en FALLA; y R-32).

Riesgo medido fuera del criterio de M5 (`rd_nombres.R`: nombres del JSON del motor, con la fuente de `.sg-ent-name` a 375 px, 800 18px gobCL-sitio, `letter-spacing` −0,09 px, sin `text-transform`; relleno de la cabecera 8 px; cabe una palabra de 104 px en una columna de 112): de 345 comunas, 36 Servicios Locales y 16 regiones, **13 comunas y 1 región** tienen una palabra que no cabe: INDEPENDENCIA 128,66 px, CHIMBARONGO 120,35, CONSTITUCIÓN 117,32, CURANILAHUE 111,62, «Metropolitana» 111,17, CHIGUAYANTE 110,34, ANTOFAGASTA 109,89, COMBARBALÁ 108,97, COBQUECURA 107,12, HUECHURABA 107,01, PROVIDENCIA 106,60, TALCAHUANO 104,76, CASABLANCA 104,49 y CURARREHUE 104,38 (PUCHUNCAVÍ, 103,64). Los Servicios Locales caben. De los 10.223 nombres de establecimientos, 1.500 tienen alguna palabra que no cabe (la mayor, 236,45 px; sin nombres en este log). Ver R-34. Instrumento: la primera versión leía los nombres del modal y mezclaba el nombre con su subtítulo; se descartó antes de registrar y se leyó el JSON.

**R.5 Regresión completa** (estado final, con la reparación de R.8; salidas en `$TMPDIR/cal_s35i/r/r32/`)
esperado: `Rscript 00_build.R` código 0; batería ≥ 33 en PASA y código 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»; «OK en 8 segundos»), motor 42ab9300… y vista 883f76bc… (iguales a PUB y a `docs/`); codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; codigo_I3=0, «JSON idéntico a la línea base» → **PASA**

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: R-32 (FC1 no sumaba el total del conteo de la tarjeta y ocultaba el año cuando el total también fallaba). Defecto del propio trabajo, dentro del ALCANCE de B1, sin tocar un 🔒, con una verificación calibrada (la vista con el total +1). Se corrige en R.8.
- ADVIERTE: R-33 a R-40 (tabla R.10). No se corrigen.

**R.8 Ciclo de reparación** (ciclo 1 de 2; no hubo ciclo 2)

R-32.
- (a) Causa raíz: en R el `!` unario tiene menor precedencia que el `+` binario. La suma de `desajustes_fc1()` terminaba en `… + !grepl(<año>) + !identical(<total>)`, que R lee `… + !(grepl(<año>) + !identical(<total>))`: con el año bien, el término vale 0 siempre (el total no se suma nunca); con el año mal, vale 1 solo si el total coincide.
- (b) Fix quirúrgico (`30_procesamiento/36_verificar_trayectorias.R`, ALCANCE de B1): el año y el total del conteo pasan a `anio_cnt_ok` y `total_cnt_ok`, y se suman como `(!anio_cnt_ok) + (!total_cnt_ok)`, con un comentario que explica la precedencia y cita R-32. No cambia el criterio, la tolerancia ni el valor esperado: la prueba mide ahora lo que su comentario ya decía.
- (c) Re-verificación:
  - mismo chequeo (la batería reparada, en una copia que solo cambia `RUTA_HTML`, `r/r32/bateria_calib.R`): con la vista del total +1, «FC1 FALLA … inicial: … 1 desajustes; ultimo_anio: … 1 desajustes; ultima_cohorte: … 1 desajustes …», «Resultado: 35 pruebas, 34 pasan, 1 fallan», codigo 1 (antes: FC1 PASA, 35/35); con la vista de B1 con las filas +1, inicial 5 desajustes (antes 4), codigo 1;
  - chequeo distinto (`r/r32/unitaria.R`: `desajustes_fc1()` tomada por `parse()` del archivo, con cinco casos sintéticos): versión reparada «casos correctos: 5 de 5» (todo bien 0; año del conteo mal 1; total mal 1; los dos mal 2; una fila mal 2), codigo 0; versión de `HEAD` antes de reparar «2 de 5» (total mal 0; los dos mal 0; una fila mal 1), codigo 1.
- (d) Regresión: R.5 (build 0; batería 35/35; JSON idéntico); `rd_familias.py` sigue en «B1 re-derivada: True».
- (e) Commit: `88070b3` fix(auditoria): R-32 FC1 cuenta el año y el total del conteo de la tarjeta (`git diff-tree --numstat`: 6/3 en la batería).
- (f) Fila R-32 en R.10.

Pasos 2 a 5 sobre lo tocado: la re-derivación de arriba; I-6 (0 líneas) e I-7 (28) otra vez, porque la batería es un `.R` de `30_procesamiento/`; `docs/` y `40_salidas/` sin cambio (42ab9300… y 883f76bc…); alcance de `37737b5..HEAD` con el commit nuevo, «rutas: 6 | fuera: (ninguna)»; `git status --porcelain` = solo este log; R.5. La reparación no destapó otro defecto.

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado ni ALCANCE, y no se tocó ningún 🔒. No se editó evidencia ya escrita: cada sección se anexó después de la anterior. No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1-H4 | `fetch`, `rev-parse` completo, `stash list`, blobs de b150d57 | §2 | iguales | — | ninguna | — | — |
| R-02 | T0 `37737b5` | `diff-tree --numstat`, padre | 3 rutas; padre b150d57 | así | — | ninguna | — | — |
| R-03 | H5, H6 | `rd_inv.py` (Python) contra b150d57; R.5 | salidas = `docs/`; 33 | sha256 igual; HTML igual | — | ninguna | — | — |
| R-04 | comparadores de I-3 e I-4 | R.6 (R, Python, `hash-object`) | disparan | disparan | — | ninguna | — | — |
| R-05 | capturas deterministas | md5 de PNG | iguales | 12/12 | — | ninguna | — | — |
| R-06 | calibración de E1 | terminal simulada con `script`, otra ruta, `00_build.R` de 37737b5 | no se detiene | «OK en 7 segundos» | — | ninguna | — | — |
| R-07 | calibración de B1 | `rd_familias.py` (código, no salida) | C sin pruebas antes de B1 | la tabla de FASE 0 = encabezado (con FC en C) | ADVIERTE (R-35) | registrar (Q-68) | — | — |
| R-08 | calibración de V3 | `rd_v3.R` sobre la base (otros caminos, tamaños, `offsetWidth`) | dependiente del camino | 24/24 distintos | — | ninguna | — | — |
| R-09 | calibración de M5 | `rd_m5.R` (lienzo) sobre la base | `W_FUERA` 666 | 666 | ADVIERTE (R-33) | registrar (Q-67) | — | — |
| R-10 | E1 | terminal simulada y `Rscript` con el `00_build.R` actual | se detiene | 0 «iniciando pipeline»; código 1 | — | ninguna | — | — |
| R-11 | alcance de `90542fb` | `diff-tree --numstat` | `00_build.R` | 7/5 | — | ninguna | — | — |
| R-12 | B1 | `rd_familias.py`; vistas con `#yr` +1 y total +1 | familias; FC1 y FC2 fallan | familias iguales; FC1 y FC2 fallan con `#yr`; FC1 pasaba con el total | REPARA (R-32) | corregido | 88070b3 | unitaria 5/5; total +1 → FALLA |
| R-13 | alcance de `14c9fb3` | `diff-tree --numstat` | la batería | 180/5 | — | ninguna | — | — |
| R-14 | V3 | `rd_v3.R` sobre `docs/` | igual a la carga nueva | 24/24 | ADVIERTE (R-36) | registrar | — | — |
| R-15 | alcance de `0e4b544` | `diff-tree --numstat` | la vista | 7/1 | — | ninguna | — | — |
| R-16 | M5 | `rd_m5.R` (lienzo) y `m5_celdas.R` sobre `docs/`, 375-760 | 0 fuera | 0 y 0; `scrollWidth` 386/386 | ADVIERTE (R-34, R-37) | registrar (Q-69) | — | — |
| R-17 | alcance de `0ec0d41` | `diff-tree --numstat` | el motor | 14/8 | — | ninguna | — | — |
| R-18 | `docs/` = `40_salidas/`; red; datos | `hash-object`, `ls-tree`; `rd_inv.py` | iguales; 0; idénticos | iguales; 0; idénticos | — | ninguna | — | — |
| R-19 | alcance de `823e3d3` | `diff-tree --numstat` | 2 rutas | 2 | — | ninguna | — | — |
| R-20 a R-28 | I-1 a I-9 | R.3 y re-derivaciones (`hash-object`, Python, `rd_i8.R`, md5 de PNG) | PASA | PASA | — | ninguna | — | — |
| R-29 | alcance global | `rd_alcance.R` y `status` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-30 | regresión | R.5 | 0; ≥ 33; idéntico | 0; 35/35; idéntico | — | ninguna | — | — |
| R-31 | medidas nuevas con nombre | `git diff` de producto y batería, revisión a mano | constantes; el corte literal con comentario | así (`>.3` dentro de `JS_BURBUJAS`, como R7) | — | ninguna | — | — |
| R-32 | FC1 suma el año y el total del conteo | vista con el total +1; unitaria de `desajustes_fc1()` | FALLA con el total +1 | PASA (el total no se sumaba); unitaria 2/5 | REPARA | fix de precedencia | 88070b3 | total +1 → FALLA (codigo 1); unitaria 5/5; batería 35/35 |
| R-33 | con el medidor de M2, `W_FUERA` = 666 y el corte 670, no el «del orden de 690 px» de D35-15, que venía de R-40 (el ancho en que la pista llega a 111,66 px); de 671 a 686 px, PUCHUNCAVÍ ocupa hasta 4 px del relleno derecho de su celda sin salir de ella (D0-a) | `m5_medir.R`, `m5_celdas.R`, `rd_m5.R` | — | 666 con los tres | ADVIERTE | registrar (Q-67) | — | — |
| R-34 | 13 comunas y 1 región tienen una palabra más ancha que la columna de 112 px (INDEPENDENCIA 128,66 px; PUCHUNCAVÍ 103,64): con una de ellas entre los territorios, su nombre sale de su columna bajo 670 px y sobre el corte mientras la pista no alcance su palabra más el relleno. También 1.500 de 10.223 nombres de establecimientos. Previo al encargo: s35h fijó 112 px con los nombres del estado inicial; el criterio de M5 fija los 5 territorios de FASE 0 | `rd_nombres.R` (JSON del motor y lienzo) | — | 14 territorios | ADVIERTE | registrar (Q-69) | — | — |
| R-35 | R2, R6 y R7 se asignaron a B (texto que la vista calcula desde DATA para el estado en pantalla); con otra lectura serían de D y B quedaría con R4 sola (D0-d) | `rd_familias.py` | — | B 4 | ADVIERTE | registrar (Q-68) | — | — |
| R-36 | V3 cambia el ancho de la tarjeta tras un clic en 7 de 9 cohortes (−5 a −8 px: 2021 305 → 297; 2029 329 → 323), lo que s35h anticipó en Q-65 y el titular aceptó en D35-15; ningún nombre pasa a dos líneas | `v3/lineas.txt`, `rd_v3.R` | — | así | ADVIERTE | registrar | — | — |
| R-37 | la holgura mínima del supergrid con 5 territorios es 0,94 px a 671 px, justo sobre el corte: un motor de texto que dibuje PUCHUNCAVÍ un píxel más ancho lo sacaría de su celda de 671 a unos 675 px; no medible en la sesión (solo Chrome 153) | barrido de M5 | — | 0,94 px | ADVIERTE | registrar (revisión del titular) | — | — |
| R-38 | todo se midió en Chrome 153 sin cabeza; sin Safari, Firefox ni un teléfono real | — | — | no medible | ADVIERTE | registrar (revisión del titular) | — | — |
| R-39 | errores propios, todos corregidos antes de registrar resultados, salvo R-32 (tras el commit de B1, reparado): el selector del nombre en FC1 y FC2 (intento 1); `$?` leído después de `$(basename …)` en una corrida de R.8 (repetida); `rd_nombres.R` leía el modal (descartado); `unitaria.R` sin `is.name()`; el fragmento `'<b>'+fmt(tot)` no existía (se usó `fmt(tot)`) | — | — | corregidos | ADVIERTE | registrar | — | — |
| R-40 | no se creó CLAUDE.md (regla global frente al ALCANCE cerrado y a §11, que excluye D2), como en s35 a s35h | — | — | D2 | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA. Un REPARA (R-32), corregido en el ciclo 1 y re-verificado con el mismo chequeo y con uno distinto. Las demás afirmaciones del inventario quedan CONFIRMADAS con instrumentos distintos, y los controles positivos dispararon. Hay 8 ADVIERTE (R-33 a R-40), ninguno sobre datos ni invariantes; los prioritarios para el titular son R-34 (nombres que no caben en 112 px, Q-69), R-33 (corte en 670, Q-67) y R-37 y R-38 (revisión en Safari y en un teléfono).

## Cierre

### 1. Resumen

Cuatro arreglos, todos publicados en `docs/`:
- **E1 (Q-39).** `00_build.R` llama a `validar_portabilidad(detener_si_falla = TRUE)`. En una copia del árbol con una ruta absoluta plantada, el build con `source()` en una sesión interactiva ahora se detiene antes de «iniciando pipeline», con «Error: Validacion de portabilidad fallida…» (antes llegaba a «OK»); con `Rscript` también se detiene; sin la ruta, el build interactivo y el de `Rscript` terminan bien y las salidas no cambian.
- **B1 (v30-5).** La batería asigna cada prueba a una de las cuatro familias de la auditoría de la sesión 30 (`traspaso_cierre_v30.md` §4.16) y suma dos pruebas de la familia C, que no tenía ninguna: FC1 (cada fila de la tabla dice lo que DATA da para el año del plano) y FC2 (la tabla y el plano muestran las mismas unidades, con su número). Quedan A 25, B 4, C 2 y D 4; la batería pasa 35/35, y cada prueba nueva falla con una vista saboteada. FASE R halló y reparó un defecto de FC1 (R-32: la precedencia de `!` ocultaba el total del conteo).
- **V3 (Q-65).** `rebuild()` vuelve `--cardw` a su valor por omisión antes de medir la tarjeta. En los 144 pares ordenados de cohortes (1280 y 900 px), la tarjeta mide lo mismo que en una carga nueva (antes, 114 de 144 distintos; 2027 → 2018: 403 → 317). La carga inicial no cambia (0 píxeles); tras un clic, 7 cohortes tienen la tarjeta 5 a 8 px más angosta, como aceptó D35-15.
- **M5 (Q-66).** Las dos reglas del supergrid pasan a un `@media (max-width: 670px)` propio: 670 es el primer múltiplo de 10 mayor que `W_FUERA` = 666, el último ancho en que, con 5 territorios, PUCHUNCAVÍ salía de su celda. De 375 a 760 px, 0 textos fuera (antes, 26 anchos de 641 a 666); sobre el corte y bajo 641 px, 0 píxeles distintos.

FASE R re-derivó las afirmaciones con instrumentos distintos, reparó R-32 y registró 8 advertencias. Veredicto: APROBADO CON ADVERTENCIAS.

### 2. Inventario de commits (`git log --oneline 37737b5^..HEAD`, que incluye T0)

```text
88070b3 fix(auditoria): R-32 FC1 cuenta el año y el total del conteo de la tarjeta
823e3d3 deploy(docs): tarjeta por cohorte y corte del supergrid
0ec0d41 fix(motor): el supergrid usa su ancho minimo hasta que ningun nombre sale de su columna (Q-66)
0e4b544 fix(trayectorias): la tarjeta se mide igual sin importar la cohorte anterior (Q-65)
14c9fb3 test(trayectorias): la bateria cubre las cuatro familias de la auditoria de la sesion 30 (v30-5)
90542fb fix(build): la falla de portabilidad detiene el build tambien en modo interactivo (Q-39)
37737b5 docs(sesion 35): encargo de la novena ola y decisiones D35-14 y D35-15
```

Más el commit de este log (`docs(log): bateria por familias, build, tarjeta y supergrid (s35i)`) y, después de P3, el de `docs(log): P3 de s35i`; sus hashes van en la sección FASE P3 y en el reporte final.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-40).

### 4. Invariantes

I-1 a I-9 en PASA en el estado final (FASE R, R.3; I-6 e I-7 otra vez tras `88070b3`), con re-derivaciones por otra vía (R.2). En ningún cierre de tarea un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (9ce88735b3c244099a353f2518ec008d, verificado).
- En el encargo: D35-13 a D35-15 (D35-14 y D35-15 commiteadas en T0) y el cierre de v30-5 por familias.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión con Rscript y chromote, Chrome 153.0.8010.53, R 4.5.2)

- E1, copia con ruta plantada, `source()` interactivo: «iniciando pipeline» y «OK en 7 segundos» → «Error: Validacion de portabilidad fallida: 1 falla(s) critica(s)» y 0 «iniciando pipeline»; `Rscript`: código 1 antes y después; árbol real: código 0, 0 críticas y 7 advertencias.
- B1: 33 → 35 pruebas; por familia A 25, B 4, C 0 → 2, D 4; batería 35/35.
- V3: pares distintos de la carga nueva 57/72 (1280) y 57/72 (900) → 0/72 y 0/72; 2027 → 2018: 403 → 317; referencia tras un clic: 2020 321 → 314, 2021 305 → 297, 2024 324 → 317, 2025 322 → 316, 2026 322 → 315, 2028 323 → 317, 2029 329 → 323; 2018 (317) y 2027 (522) sin cambio.
- M5: `W_FUERA` = 666 (PUCHUNCAVÍ +5,06 px a 641); corte 670; textos fuera con 5 territorios de 375 a 760 px: 26 anchos → 0; holgura mínima 0,94 px a 671.
- Salidas finales: motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3, iguales en `docs/` (blobs 2554f9a2… y 7cbbdb75…). JSON del motor y `DATA` de la vista idénticos a la base (sha256 7967dfa07a99ef11). Validador del build: 0 críticas y 7 advertencias.
- `docs/` antes: fe30d56f… y 69357a69…; después: 42ab9300… y 883f76bc….

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas nuevas, con pregunta cerrada:
- Q-67 (R-33, D0-a). Con el medidor de M2 que fija el encargo (borde de la celda), el último ancho con un nombre fuera es 666 px y el corte quedó en 670, no en el «del orden de 690 px» de D35-15, que venía de estimar cuándo la pista llega a 112 px (nombre más relleno a los dos lados). De 671 a 686 px, PUCHUNCAVÍ ocupa hasta 4 px del relleno derecho de su celda, sin salir de ella. ¿Se deja el corte en 670, o se sube a 690 para que la columna nunca mida menos que `--supergrid-col-min`? (670 / 690)
- Q-68 (R-35, D0-d). R2, R6 y R7 (leyenda y tooltip del referente, calculados por la vista desde DATA) se asignaron a la familia B. Con otra lectura serían de D, y B quedaría con R4 sola. ¿Se confirma B, o pasan a D y se agrega una prueba de B (por ejemplo, cada burbuja dibujada corresponde a una unidad del DATA de la cohorte elegida)? (B / D con una prueba más)
- Q-69 (R-34). Trece comunas (INDEPENDENCIA, 128,66 px; CHIMBARONGO; CONSTITUCIÓN; CURANILAHUE; CHIGUAYANTE; ANTOFAGASTA; COMBARBALÁ; COBQUECURA; HUECHURABA; PROVIDENCIA; TALCAHUANO; CASABLANCA; CURARREHUE) y la región Metropolitana tienen una palabra más ancha que la columna de 112 px: elegidas como territorio, su nombre sale de la columna del supergrid. ¿Se sube `--supergrid-col-min` al nombre más ancho del catálogo (INDEPENDENCIA: 128,66 + 8 → 137 px) o se deja así? (subir / dejar)

Revisión pendiente del titular (R-37, R-38): el supergrid con 5 territorios entre 641 y 690 px y la vista al cambiar de cohorte, en Safari y en un teléfono real.

Pendientes fuera del encargo (§11): Museo Sans en la suite, los pendientes 8, 10, 12 y 13 de v34, CLAUDE.md (D2; no se creó), el tope de 5 territorios y `ANCHO_PLANO_MIN` = 384 (D35-14), y lo cerrado o aceptado en D35-11 y D35-12. Ninguna tarea los tocó.

`# REVISAR` nuevos: ninguno (`git diff 37737b5..HEAD | grep -c "^+.*REVISAR"` = 0, medido en FASE L).

### 8. Errores propios consolidados

- Producto (la batería): el selector del nombre de FC1 y FC2 tomaba el número (intento 1 de B1, corregido antes del commit); la precedencia de `!` en FC1 ocultaba el total del conteo (hallado tras el commit de B1, reparado en FASE R como R-32, `88070b3`).
- Instrumentos, corregidos antes de registrar resultados: `$?` leído después de `$(basename …)` en una corrida de R.8 (repetida con el código guardado antes); `rd_nombres.R` leía los nombres del modal, que mezcla nombre y subtítulo (se leyó el JSON); `unitaria.R` tomaba asignaciones con un lado izquierdo compuesto (se exigió `is.name()`); un fragmento que no existía en la vista (`'<b>'+fmt(tot)`; se usó `fmt(tot)`).
- Ninguno tocó lo publicado.

### 9. Notas para el revisor

- En tu consola de R, con una ruta absoluta plantada en un `.R` del proyecto (por ejemplo, un `verificar_x.R` en la raíz con `ruta <- "/Users/persona/datos.csv"`), `source("00_build.R")` debe detenerse con «Validacion de portabilidad fallida» antes de «iniciando pipeline». Borra el archivo después.
- En un teléfono o en Safari, con 5 territorios (los 4 del inicio más «SLEP Aconcagua»), el supergrid entre 641 y 690 px: ningún nombre fuera de su columna, sobre todo de 671 a 675 px (holgura de 1 px en Chrome, R-37). Referencia: `_archivo/20260926_capturas_s35i/s35i_m5_supergrid_660_5terr_{antes,despues}.png`.
- La vista de trayectorias: de la cohorte 2027 a la 2018, la tarjeta debe quedar como en la carga inicial (`s35i_v3_vista_1280_2027a2018_{antes,despues}.png`).
- La batería lista sus pruebas por familia en su encabezado; FC1 y FC2 leen la vista en Chrome, como R2, R4, R6 y R7.
- Q-67 a Q-69.

### 10. Estado de cierre

- **Commiteado:** 7 commits del encargo (T0, E1, B1, V3, M5, PUB y el `fix(auditoria)` de R-32) más el de este log, en `main`.
- **Condiciones de publicación medidas antes del commit de este log** (autorización 4):
  - veredicto de FASE R `APROBADO CON ADVERTENCIAS`;
  - `git fetch origin` fetch_codigo=0 (FASE R); `origin/main` = `b150d57`;
  - `git merge-base --is-ancestor origin/main HEAD`: se mide justo antes del push;
  - md5 de `docs/` = 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3, iguales a los de PUB;
  - `git status --porcelain` = solo este log, que queda vacío con su commit.

  El `git push origin main` se corre después de este commit, con `status`, `fetch` y `merge-base` medidos otra vez. Su resultado, P3 (lo que sirve Pages) y el hash de este commit se anexan en la sección FASE P3 (autorización 8), sin reescribir esta. Un archivo no puede llevar el hash de su propio commit.
- **Queda al titular:** la revisión en Safari y en un teléfono real (§9) y las dudas Q-67 a Q-69.
- **Verificación del archivo** (antes del commit):
  - `grep -c '^### FASE'` = 7 (FASE 0, E1, B1, V3, M5, PUB y R; FASE L es este «Cierre» y P3 se anexa después);
  - `grep -c '^esperado:'` = 57 y `grep -c '^obtenido:'` = 56: una línea de resultado empieza con «obtenido (literal; …):», en la calibración de B1, así que `grep -c '^obtenido'` da 57. No se reescribió: se declara;
  - `grep -c '^## J'` = 1, con el bloque relleno;
  - privacidad: el `grep` del patrón de RUT no halla coincidencias. Tampoco hay nombres de establecimientos (`liceo|escuela|colegio|instituto` solo aparece como «escuelas», en la tabla de B1) ni de personas; los nombres que aparecen son de comunas, regiones y Servicios Locales.

### FASE P3: lo que sirve Pages (tras el push de FASE L; autorización 8)

- Commit de este log antes de P3: `9bae824` docs(log): bateria por familias, build, tarjeta y supergrid (s35i).

Push de FASE L. Condiciones medidas después del commit del log, en el mismo turno:
- `git status --porcelain` vacío;
- `git fetch origin` fetch_codigo=0; `origin/main` = b150d57d5d149fc243a807823e8e79aa00ca29e3;
- `git merge-base --is-ancestor origin/main HEAD` ancestro_codigo=0, con 8 commits por publicar;
- md5 de `docs/` = 42ab9300… y 883f76bc…, los de PUB.

Luego `git push origin main`
esperado: push aceptado
obtenido: «b150d57..9bae824  main -> main», push_codigo=0

**P3.** `$TMPDIR/cal_s35i/p3.sh` (copia del de s35h): cada 60 s, hasta 10 minutos, `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5 -q` y `curl -s https://tomgc.github.io/slep_simce_adecuado/trayectorias.html | md5 -q`, contra `md5 -q docs/*.html` (salida en `$TMPDIR/cal_s35i/p3.txt`)
esperado: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3
obtenido: intento 1 (11:17:27): fe30d56f… y 69357a69…, la versión anterior; intento 2 (11:18:28): **42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3**, «COINCIDE en el intento 2». `curl -sI`: HTTP/2 200, `last-modified: Sat, 26 Sep 2026 14:17:56 GMT` en las dos páginas (etag «6ab7d414-2cc6b9» y «6ab7d414-21c47d»).

Cierre con la autorización 8: se agrega esta sección; `git add` del log; `git commit -m "docs(log): P3 de s35i"`; y `git push origin main`, solo si `git diff --name-only HEAD~1..HEAD` muestra únicamente el log y si `fetch` y `merge-base --is-ancestor origin/main HEAD` dan código 0. El hash de ese commit va en el reporte final: un archivo no puede llevar el hash de su propio commit.
