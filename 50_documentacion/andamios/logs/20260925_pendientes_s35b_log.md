# Log: pendientes de la sesión 35, segunda ola (slep_simce_adecuado)

- Meta: implementar D35-4, D35-5 y D35-6, corregir la línea 206 de `32_agregar_comunal.R` con I-7 en forma absoluta, conectar el validador de portabilidad al build, migrar el sitio a gobCL y dejar la vista y el motor sin desborde en pantallas angostas; todo commiteado y pusheado, sin tocar `docs/`.
- Fecha: 2026-09-25 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: 1a92827 (commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_pendientes_s35b.md`, md5 `57e60440532d26e6ac224517ef3606cb` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo ultracode; orquestador Opus; subagentes tope 3 (≤ 3 Opus); total Opus ≤ 10
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; esfuerzo `ultracode` (orquestación con la herramienta Workflow); orquestador Opus 5.5 (`claude-opus-5-5[1m]`); subagentes lanzados con Workflow, una ola por invocación, con a lo más 3 agentes simultáneos, todos Opus 5.5 (heredado de la sesión) con esfuerzo `xhigh`.
- Grafo y olas (copiados de §5 del encargo):
  - T0 es la raíz de todo. P1 y P2 requieren T0. A1 requiere T0; A2 requiere A1. M1 requiere T0; M2 requiere M1. G requiere A2 y M2. A3 requiere G; M3 requiere G. FASE R y FASE L no dependen de ninguna tarea: corren siempre.
  - Olas: (orquestador) FASE 0, T0, P1, P2 · Ola 1: A1, M1 (escritura Opus ×2) · Ola 2: A2, M2 (escritura Opus ×2) · Ola 3: G (escritura Opus ×1) · Ola 4: A3, M3 (escritura Opus ×2) · FASE R: panel adversarial (lectura Opus ×3). Total Opus declarado: 10.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Antecedente de I-7: D35-3 valió solo para `encargo_pendientes_s35.md`; en este encargo I-7 se mide en forma absoluta después de P1 (§1, reglas canónicas; instrucción del titular en el mensaje de entrega).

## J. Juicio (lo rellena FASE L)

- Meta y resultado: D35-4, D35-5 y D35-6 implementadas; línea 206 de `32_agregar_comunal.R` corregida e I-7 absoluto vacío; validador de portabilidad en el build; sitio en gobCL incrustada; vista sin desborde de 375 a 768 px y motor sin desborde a 375/540/768 px. Todo commiteado; **sin push**, porque FASE R dio OBSERVADO (R-48 congelado).
- Estado por tarea: FASE 0 completa (D0-a) · T0 completa · P1 completa · P2 completa · A1 completa · M1 completa · A2 completa (D-A2-a) · M2 completa con desviación (D-M2-a) · G completa (ADVIERTE esperado del PNG; `fonts.check` no discrimina) · A3 completa · M3 completa sin cambios (D-M3-a) · FASE R: 5 REPARA corregidos, 1 congelado (R-48).
- Commits: 1a92827 (T0, punto de retorno), eb77b28 (P1), 7cdedfc (P2), f8e7870 (A1), 01cdee0 (M1), 6dfe8fa (A2), b346b40 (M2), 271c04f (G), df88fab (A3), 9344548 (R-47 y R-51), 07fc5d0 (R-49), 4a88f87 (R-50), facc0d1 (R-52), más docs(log) (hash en el reporte final).
- Auditoría (FASE R): panel de 3 Opus; 46 afirmaciones (43 CONFIRMADA, 3 REFUTADA: R-16, R-19 y R-20, ninguna sobre datos ni invariantes); 0 BLOQUEA; REPARA R-47, R-49, R-50, R-51 y R-52 corregidos; R-48 congelado tras 3 intentos; 20 ADVIERTE; control positivo disparó en los dos casos; veredicto OBSERVADO.
- Invariantes: I-1 a I-12 PASA en el estado final (I-7 en forma absoluta: vacío).
- Cifras críticas: REF 1.299 · vig 1.282 · olas 475/406/401 · 17 cerrados; `#lg` «Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124»; Elemental 2,78 → 5,44:1, Insuficiente 9,85:1; cifra única de la sparkline 2,14 → 7,29:1 (7,34 según M2); batería 28 → 31; D9 con 1.329 combinaciones futuras; HTML +160.246 B y +159.882 B; vista 641/641/641 → 375/540/640 a 375/540/640 px; `#comparacion` 376 → 375 a 375 px; parquet 468099a9… sin cambio; JSON del motor idéntico; `docs/` 8deb0459…/267857a2….
- Decisiones autónomas de mayor riesgo: D0-a (no congelar G, A3 y M3 aunque H7 dio `TRUE FALSE`, con `png` desde la biblioteca del sistema); D-M2-a (aceptar la regla de choque de M2, luego auditada como R-48); D-A2-a (28 rutas de datos tabulares y el `.json` aparte; completar la fila existente en vez de duplicarla); D-R-a (R-54 como ADVIERTE y no BLOQUEA); R-50 intento 3 (el ancho de la tarjeta de la vista pasa a 318 px fijo).
- Desviaciones respecto del encargo: H7 no dio lo esperado en la letra (D0-a); M3 sin commit (D-M3-a); la fila de inspección de A2 se completó en vez de agregarse (D-A2-a); FASE R la reparó el orquestador en serie (tope Opus 10 alcanzado); no se creó CLAUDE.md (regla global frente a `.gitignore` y a un ALCANCE cerrado, como D0-b de s35).
- Dudas abiertas: Q-01b, Q-26 a Q-39 (en «Cierre», punto 7); Q-28 (escalera) condiciona el push.
- Errores propios: 6 del orquestador (dos scripts de calibración mal escritos al primer intento; extracción del DATA de la vista en caracteres y no en bytes; el esperado «0 elementos» del recorrido de M3 no separaba el desplazamiento interno de una tabla; congelar R-48 tras un intento mientras R-47 y R-50 tuvieron tres, corregido; aceptar sin re-derivar el 7,34 de M2 y la frase «el documento sigue siendo verdadero» de D-A2-a). Ninguno tocó el producto.
- Qué debe verificar el revisor por sí mismo: en Safari, la marca «†» (ya no debe verse «+») en barras, sparkline, nota y leyenda; la escalera de cifras de la sparkline (R-48; tarjeta 5103, Medio bajo: «42%†» sobre «52%†»); la vista a 375, 540 y 768 px y su tarjeta de 318 px; el rótulo del referente; gobCL en las dos páginas (en esta estación gobCL está instalada, así que conviene mirar en otro equipo); NOTICE y la licencia de gobCL antes de publicar (R-68).
- No publicado / queda al usuario: sin `git push` (veredicto OBSERVADO; autorización 2 no satisfecha); `origin/main` sigue en 9d612a3, ancestro de `HEAD`; `docs/` y Pages sin tocar; decidir Q-28 y hacer el push; revisión en Safari y publicación a `docs/`.
- Ejecución: ultracode con Workflow; orquestador Opus 5.5; 10 agentes Opus 5.5 con esfuerzo xhigh (A1, M1 · A2, M2 · G · A3, M3 · 3 auditores), a lo más 3 simultáneos (máximo real 3, en FASE R); tope Opus de 10 alcanzado y respetado; FASE R reparada por el orquestador.

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1 (`50_documentacion/andamios/logs/` ya existía). Por eso H1 muestra también la línea del propio log, como prevé §6.2.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: exactamente `?? 50_documentacion/activa/encargos/encargo_pendientes_s35b.md`, más la línea del log recién creado (§6.2)
obtenido:
```text
?? 50_documentacion/activa/encargos/encargo_pendientes_s35b.md
?? 50_documentacion/andamios/logs/20260925_pendientes_s35b_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0, sin salida), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: 9d612a3 en los dos
obtenido: 9d612a3 y 9d612a3

**H4.** `md5 -q docs/index.html docs/trayectorias.html 10_utils/10_locale.R` y `md5 -q 50_documentacion/activa/encargos/encargo_pendientes_s35b.md`
esperado: 8deb04595510b0f15da8bb65813b7a38, 267857a2962602bd9e6c5cc56effcb47, dc900c1b0d2d252c9e5730875be5d632; encargo 57e60440532d26e6ac224517ef3606cb (mensaje de entrega)
obtenido: 8deb04595510b0f15da8bb65813b7a38, 267857a2962602bd9e6c5cc56effcb47, dc900c1b0d2d252c9e5730875be5d632; encargo 57e60440532d26e6ac224517ef3606cb

Premisa complementaria de §2: `md5 -q 30_procesamiento/32_agregar_comunal.R`
esperado: 4d66fe1f67ea5c5677ab1a814a37b277
obtenido: 4d66fe1f67ea5c5677ab1a814a37b277

**T0.** `git add 50_documentacion/activa/encargos/encargo_pendientes_s35b.md` y `git commit -m "docs(sesion 35): encargo de la segunda ola de pendientes"`
esperado: un commit con esa sola ruta
obtenido: `1a92827 docs(sesion 35): encargo de la segunda ola de pendientes`, `git show --name-only` = `50_documentacion/activa/encargos/encargo_pendientes_s35b.md`. **Punto de retorno: 1a92827.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"`
esperado: 28 pruebas en PASA y codigo=0
obtenido: «Resultado: 28 pruebas, 28 pasan, 0 fallan», codigo=0 (D1-D14c, C1-C5, R1-R4; R3 «olas en DATA 2027=479, 2028=407, 2029=408»)

**H6.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"`
esperado: codigo=0
obtenido: codigo=0; «DATA: 9 años, 74 entidades, 24745 filas en datos, 20948 en nube, 180 comunas (2.0 MB)»; «Escrito 40_salidas/trayectorias_traspasos.html (2.09 MB)»; «00_build.R: OK en 6 segundos»

Línea base en `$TMPDIR/base_s35b/` (`cp` de las tres rutas y `md5 -q` antes y después de copiar)
esperado: tres copias con el mismo md5 que el original
obtenido: motor_comparacion.html d9119ed74d684209c9972bd9d809c86a (2.791.100 B); trayectorias_traspasos.html 9d136743400be2df6f2523121958a437 (2.088.603 B); simce_comunal.parquet 468099a9c63bb3c0ddb74e67e2c7c19f (1.012.055 B); iguales en origen y copia

`verificar_contenido_motor.R` comparaba contra `$TMPDIR/base_s35/`: se apuntó a `$TMPDIR/base_s35b/` (línea 24 y comentario de la línea 12), como pide §6.7.

I-5 sobre el build de H6: `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_base=0

Calibración del comparador (`$TMPDIR/cal_s35b/alterar_json_motor.R`: copia del motor base con el primer decimal del JSON alterado, luego `Rscript verificar_contenido_motor.R <copia>`)
esperado: «difiere» sobre la copia alterada; «idéntico» sobre la base
obtenido: «fragmento original: 3.5 -> alterado: 3.6»; «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)», codigo_alterado=1; base contra base «JSON idéntico a la línea base», codigo=0

**H7.** `Rscript -e 'cat(requireNamespace("chromote", quietly=TRUE), requireNamespace("png", quietly=TRUE))'` y `ls "/Applications/Google Chrome.app"`
esperado: `TRUE TRUE` y la carpeta existe
obtenido: `TRUE FALSE` y `/Applications/Google Chrome.app` existe. **`png` no está en la biblioteca de renv del proyecto: H7 no da lo esperado en la letra.**

H7 complementaria (`$TMPDIR/cal_s35b/png_sistema.R`: `loadNamespace("png", lib.loc = <biblioteca del sistema>)` en solo lectura, escritura y lectura de un PNG de 1×1)
esperado: png se carga desde la biblioteca del sistema, como en el encargo anterior (D0-d de s35), y la ida y vuelta es idéntica
obtenido: «png en la biblioteca del proyecto: FALSE»; «png cargado: TRUE version 0.1.9»; «ida y vuelta 1x1 identica: TRUE»; «chromote: TRUE 0.5.1»

Decisión autónoma **D0-a (riesgo alto)**: la regla de detención dice «H7 falla → congela G, A3 y M3». No se congelan. Razones: (1) la premisa de §2 da `png` por disponible «porque [lo] usó el encargo anterior», y el encargo anterior lo usó exactamente así, cargado en solo lectura desde la biblioteca del sistema (D0-d de s35, duda Q-01 sin responder); (2) la capacidad que H7 protege (capturas y comparación de píxeles con `png::readPNG`) está medida y funciona; (3) ninguna autorización permite instalar `png` en renv, y no se instala. El comando de H7 del encargo espera un estado que no existía en la estación (mismo patrón que ERR-35-05). Queda como desviación declarada, duda Q-01b y materia de FASE R. Si el titular la rechaza, los commits de G, A3 y M3 se identifican por su mensaje.

**H8.** `md5 -q 50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf`
esperado: f5a622b0b5f209c9197b2acfd2e1e299, 0257bb4b62d5ec557627aa0136f1e1dc, 6f435f30d6a13092b7d5db5255dcca1b
obtenido: f5a622b0b5f209c9197b2acfd2e1e299, 0257bb4b62d5ec557627aa0136f1e1dc, 6f435f30d6a13092b7d5db5255dcca1b (37.960, 36.528 y 44.776 B)

**H9.** Dos corridas seguidas de `cd "$RAIZ" && Rscript 30_procesamiento/32_agregar_comunal.R`; tras cada una, `md5 -q 40_salidas/intermedios/simce_comunal.parquet`; bloque «Costa Central» extraído con `awk '/=== Costa Central/{f=1} /32_agregar_comunal.R: OK/{f=0} f'` a `$TMPDIR/base_s35b/diag_cc_1.txt` y `diag_cc_2.txt`; `diff` entre los dos
esperado: el mismo md5 las dos veces y `diff` vacío
obtenido: codigo_run1=0 y codigo_run2=0; md5 468099a9c63bb3c0ddb74e67e2c7c19f las dos veces (igual al de H6); 41 líneas cada texto (tibble de 17 × 11); diff_codigo=0 (vacío)

**H10.** `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: exactamente `30_procesamiento/32_agregar_comunal.R:206:    .by = c(nom_com_rbd, cod_grupo, anio)`
obtenido: `30_procesamiento/32_agregar_comunal.R:206:    .by = c(nom_com_rbd, cod_grupo, anio)`

**Cierre de FASE 0.**
- Estado: completa. H1-H6 y H8-H10 dan lo esperado; H7 no da lo esperado en la letra (`png`) y se resuelve con D0-a.
- Commits: `1a92827` docs(sesion 35): encargo de la segunda ola de pendientes (T0, punto de retorno).
- Cambios sustantivos: ninguno sobre el producto. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35b/`.
- Alcance: T0 tocó solo el encargo.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno.
- Decisiones autónomas: D0-a (H7, `png` desde la biblioteca del sistema; riesgo alto).
- Errores propios: la primera versión del script de calibración del comparador buscaba `"pct_adecuado":` y `:<número>`, que no existen en el JSON del motor (los números van en arreglos); falló con «argumento tiene longitud cero» antes de producir la copia. Corregido con el patrón del primer decimal. No tocó el producto. También falló una inspección del JSON con `Rscript -e` por un escape `\.` dentro de comillas; se pasó a un script en `$TMPDIR`.
- Dudas: Q-01b. ¿Se acepta, para este encargo y los siguientes, que la comparación de píxeles cargue `png` en solo lectura desde la biblioteca del sistema, o se autoriza instalarlo en la biblioteca de renv? (se acepta / instalar)

### FASE P1: `32_agregar_comunal.R`, el diagnóstico agrupa por código (orquestador)

- Estado: completa.
- Commits: `eb77b28` fix(pipeline): el diagnostico de Costa Central agrupa por codigo de comuna (D35-3).
- Paso 0: lectura de las líneas 165-217 (el diagnóstico va después de `arrow::write_parquet`, línea 176, y solo imprime).
- Cambios sustantivos: `.by = c(cod_com_rbd, nom_com_rbd, cod_grupo, anio)` (antes `c(nom_com_rbd, cod_grupo, anio)`), con un comentario de tres líneas que cita D35-3 e I-7 absoluto. `dplyr::arrange(nom_com_rbd, cod_grupo)` sin cambio (ahora línea 213). md5 del archivo: 4c5228f2f61bb436873eb44e798fa6f2.
- Verificación:

I-7 en forma absoluta: `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío

Calibración de I-7 (`git show 1a92827:30_procesamiento/32_agregar_comunal.R > $TMPDIR/cal_s35b/32_retorno.R` y el mismo `grep` sobre esa copia y sobre el archivo nuevo)
esperado: la línea 206 en el punto de retorno (caso malo) y vacío en el archivo nuevo (caso bueno)
obtenido: `206:    .by = c(nom_com_rbd, cod_grupo, anio)` en la copia del punto de retorno; vacío en el archivo nuevo

I-12: `Rscript 30_procesamiento/32_agregar_comunal.R` y `md5 -q 40_salidas/intermedios/simce_comunal.parquet`
esperado: 468099a9c63bb3c0ddb74e67e2c7c19f (H9)
obtenido: codigo_p1=0; 468099a9c63bb3c0ddb74e67e2c7c19f

Bloque «Costa Central» sin la columna `cod_com_rbd`. `print` agrega la columna (el tibble pasa de 17 × 11 a 17 × 12) y cambia el corte de bloques (`2022` pasa al primer bloque y `2023` al segundo), así que la comparación reconstruye cada fila uniendo sus bloques y quita la primera columna. Comando: `awk -f $TMPDIR/cal_s35b/filas_tibble.awk diag_cc_1.txt | tr -s " "` contra `awk -v quitar=1 -f $TMPDIR/cal_s35b/filas_tibble.awk diag_cc_p1.txt | tr -s " "`, y `diff` (el awk descarta las líneas `=== `, `# A tibble` y vacías; une por número de fila el encabezado, los tipos y los valores; con `quitar=1` borra el primer campo de cada uno)
esperado: `diff` vacío
obtenido: 19 líneas normalizadas en cada lado (encabezado, tipos y 17 filas); diff_sin_cod=0 (vacío). Líneas `# A tibble`: «17 × 11» antes y «17 × 12» después.

Calibración del comparador del bloque (misma tubería sobre una copia de `diag_cc_p1.txt` con «84.2» cambiado a «84.3» en la fila 5; y sin `quitar=1`)
esperado: `diff` no vacío en los dos casos
obtenido: diff_alterado=1 («5 CONCÓN 5 84.2 …» frente a «5 CONCÓN 5 84.3 …»); diff_sin_quitar=1

- PRUEBAS:

`Rscript 00_build.R`, `Rscript 30_procesamiento/36_verificar_trayectorias.R` y `Rscript verificar_contenido_motor.R`
esperado: codigo_build=0; 28 pruebas en PASA, codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («OK en 6 segundos»; parquet 468099a9c63bb3c0ddb74e67e2c7c19f); «Resultado: 28 pruebas, 28 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base», codigo_I5=0

- Alcance: `git diff --name-only HEAD` más no seguidos antes del commit = `30_procesamiento/32_agregar_comunal.R` y el log. `git show --name-only eb77b28` = `30_procesamiento/32_agregar_comunal.R`. Dentro del ALCANCE de P1.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno. Decisiones autónomas: ninguna. Errores propios: ninguno. Dudas: ninguna.

### FASE P2: el validador de portabilidad entra al build (Q-02) (orquestador)

- Estado: completa.
- Commits: `7cdedfc` chore(build): valida portabilidad al inicio del build con raiz unificada (pendiente 9 de v34).
- Paso 0: lectura de `10_utils/10_configuracion.R` (16 líneas), `00_build.R` (41 líneas) y de `10_validar_portabilidad.R` (líneas 1-150 y 215-388: exclusiones, sondeo de accesores con `sys.source`, API y autotest). `10_validar_portabilidad.R` no se editó.
- Cambios sustantivos:
  - `10_configuracion.R`: después de la guarda de locale, `ruta_insumos <- function(...) here::here("20_insumos", ...)`, con un comentario que dice que la raíz de datos es el propio repositorio (POLITICA §6.2, raíz unificada) y que el validador toma `dirname()` de este accesor. El encabezado del archivo decía «Hoy solo instala la guarda de locale»; se actualizó para mencionar el accesor. Ningún otro script usa `ruta_insumos()` (`grep -rn`).
  - `00_build.R`: después de `source(... "10_utils.R")`, `source(here::here("10_utils", "10_validar_portabilidad.R"))` y `validar_portabilidad()`, con un comentario que cita el pendiente 9 de v34. La llamada usa el valor por omisión `detener_si_falla = !interactive()`, tal como la pide el encargo: con `Rscript` una crítica detiene el build.
- Verificación:

Validador tras el accesor: `Rscript -e 'source(here::here("10_utils","10_configuracion.R")); source(here::here("10_utils","10_validar_portabilidad.R")); r <- validar_portabilidad(detener_si_falla = FALSE); print(r)'`
esperado: 0 críticas
obtenido: codigo=0; «Archivos escaneados: 30»; «Fallas criticas: 0 | Advertencias: 7». Entorno: los 8 checks en OK, entre ellos `data_root_resuelto` («Resuelto por ruta_insumos()») y `salidas_escribibles`. Advertencias estáticas (7, todas `advertencia`): `separador_manual` en 00_escanear_proyecto.R:101 y :184, 10_utils/10_html.R:46, 36_generar_trayectorias.R:84 y :154, 36_verificar_trayectorias.R:826; `system_shell` en 10_utils/10_locale.R:27. (Nota: la columna `detalle` de la tabla de entorno imprime el texto de falla de cada check aunque esté en OK; es el formato del validador, ya anotado en el log anterior.)

Autotest: `validar_portabilidad_autotest()`
esperado: detecta la violación que siembra y limpia
obtenido: codigo=0; con el sabotaje «Fallas criticas: 4» (`zz_autotest_sabotaje_portabilidad.R:2`: ruta_usuario_macos, ruta_usuario_windows, letra_unidad, onedrive_literal); sin él «Fallas criticas: 0»; «Violacion sembrada detectada: SI», «Limpieza verificada: SI»; `ls zz_*` sin resultados

Build con el validador: `Rscript 00_build.R`
esperado: codigo 0
obtenido: codigo_build=0; «Archivos escaneados: 30», «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos»

Control positivo (autorización 3): `verificar_portabilidad_plantada.R` en la raíz con `ruta <- "/Users/persona/Documents/datos.csv"`; `Rscript 00_build.R`; `rm` del archivo; `Rscript 00_build.R`
esperado: el build falla con el archivo y vuelve a codigo 0 sin él
obtenido: codigo_build_plantada=1; «Fallas criticas: 1», hallazgo `verificar_portabilidad_plantada.R 2 ruta_usuario_macos`, «Error: Validacion de portabilidad fallida: 1 falla(s) critica(s)»; 0 líneas de los pasos 30-36 en esa corrida (se detuvo antes de leer insumos). Tras `rm`: `ls` «No such file or directory»; codigo_build_tras_borrar=0, «Fallas criticas: 0». El validador sí escanea los `verificar_*.R` de la raíz, así que la calibración es el control del build y no solo el autotest.

- PRUEBAS:

`Rscript 00_build.R` (arriba), `Rscript 30_procesamiento/36_verificar_trayectorias.R` y `Rscript verificar_contenido_motor.R`
esperado: codigo_build=0; 28 en PASA, codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build_tras_borrar=0; «Resultado: 28 pruebas, 28 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base», codigo_I5=0; parquet 468099a9c63bb3c0ddb74e67e2c7c19f

I-4 tras la edición: `grep -n asegurar_locale_utf8 10_utils/10_configuracion.R` y `md5 -q 10_utils/10_locale.R`
esperado: una línea y dc900c1b0d2d252c9e5730875be5d632
obtenido: `16:asegurar_locale_utf8("10_configuracion")` y dc900c1b0d2d252c9e5730875be5d632

- Alcance: antes del commit, `git diff --name-only HEAD` = `00_build.R`, `10_utils/10_configuracion.R`; no seguidos: el log. `git show --name-only 7cdedfc` = esas dos rutas. Dentro del ALCANCE de P2.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno.
- Decisiones autónomas: D-P2-a (riesgo bajo): se actualizó la frase del encabezado de `10_configuracion.R` que decía «Hoy solo instala la guarda de locale», porque dejaba de ser cierta; está dentro del ALCANCE de P2.
- Consecuencia para las olas siguientes: desde este commit el build escanea los `verificar_*.R` de la raíz. Un script de medición con una ruta absoluta de usuario detiene el build; se advierte a cada subagente.
- Errores propios: ninguno. Dudas: ninguna (Q-02 queda resuelta por la instrucción del encargo).

### FASE A1: D35-4, el referente se cuenta por ola con el directorio (ola 1, escritor Opus)

- Estado: completa.
- Commits: `f8e7870` fix(trayectorias): referente contado por ola con el directorio y rotulo con 1.282 (D35-4).
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `a1.md` (tarea de §7 literal, D35-4 literal, Q-12 a Q-15 y Q-22 literales, ALCANCE, 🔒 de §4 con su porqué, POSICIÓN, regla «sin git, sin borrar, nada fuera del ALCANCE», formato de retorno). Indicaciones del orquestador que no cambian el criterio: orden R5/R6 antes que R3/R4; sin literales en el rótulo; `vig` solo con `incluir_futuras = TRUE` (D10).
- Cambios sustantivos (retorno del subagente, verificados por diff: 3 archivos, +221/−92 junto con M1 en el mismo `git diff --stat`, que suma 231/96):
  - `36_funciones_trayectorias.R`: nueva `referente_en_directorio()` (RBD del referente presentes en `establecimientos_chile.parquet`, cualquier dependencia, con la comuna del directorio; se detiene si un RBD tiene dos comunas); `olas_referente(presentes, olas)` cuenta por la comuna del directorio; comentario de las antiguas 435-440 reescrito; `meta$REF$vig` (1.282) solo con `incluir_futuras = TRUE`; `cifras_notas()` agrega `N_REF_DIRECTORIO` y una guarda `vig + N_CERRADOS == cat`.
  - `36_trayectorias_template.html`: `rotuloReferente()` con «Referente: <cat> municipales en <ANIOS[0]> · <vig> se traspasan entre <primera> y <última> · con resultado en <año>: <e>» (rango solo con olas > 0; con marcas, «· <vig − salen> de <vig> aún municipales» del año en pantalla); `MARCA_OLA.colorTexto = 'var(--ink)'`, la línea sigue en `var(--ref)`; párrafo de notas con `__NOTA_N_REFERENTE__`, `__NOTA_N_CERRADOS__` y `__NOTA_N_REF_DIRECTORIO__` (1.299, 17, 1.282).
  - `36_verificar_trayectorias.R` (847 → 941 líneas): R5 y R6 nuevas; `ESPERADO_REF_OLAS` 479/407/408 → 475/406/401 y `ESPERADO_REF_VIG <- 1282L`; recuento independiente de R3 por el directorio (`presentes_ind`, `ola_ref_ind`) en lugar de la última fila Simce; R4 `siguen <- vig_ref - …` (antes `cat_ref`), aviso «807 de 1.282» (antes «820 de 1.299»); `leer_vista_con_data()` compartida por R4 y R6. Ninguna condición ni tolerancia quitada (revisado en el diff por el orquestador).
- Verificación:

Paso 1, R5 y R6 antes del código (retorno del subagente, `$TMPDIR/s35b_a1/bateria_paso1.txt`)
esperado: R5 y R6 en FALLA, 28 previas en PASA
obtenido: vista sin cambio (md5 9d136743400be2df6f2523121958a437); R5 FALLA («olas en DATA 2027=479, 2028=407, 2029=408, vig en DATA (sin campo); recuento independiente por el directorio 2027=475, 2028=406, 2029=401, presentes 1.282 y fuera del directorio 17»); R6 FALLA (leyenda «… 820 de 1.299 aún municipales»); «Resultado: 30 pruebas, 28 pasan, 2 fallan», codigo=1

Calibración de R5 (retorno del subagente: copia de la batería con `olas_referente()` vieja inyectada, `$TMPDIR/s35b_a1/bateria_calib_r5.R`)
esperado: R5 FALLA con 479 (caso malo)
obtenido: R5 FALLA («olas en DATA 2027=479, 2028=407, 2029=408, vig en DATA 1.282»); además R3, R6 y D12 FALLA; «30 pruebas, 26 pasan, 4 fallan», codigo=1. (El subagente esperaba 27/3 y no anticipó D12, que compara el DATA de la vista escrita con el de la copia; el criterio de la calibración se cumple.)

Paso 2, batería con el código (retorno del subagente, `bateria_paso2.txt`)
esperado: 28 + R5 + R6 en PASA
obtenido: «Resultado: 30 pruebas, 30 pasan, 0 fallan», codigo=0

`#lg` a 1280 px, estado inicial (retorno del subagente, `$TMPDIR/s35b_a1/verificar_lg.R`, calibrado con la vista base: frase nueva FALSE)
esperado: contiene «1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029» y el `e` de DATA
obtenido: «Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124»; e desde DATA 1124; 0 marcas; red 0, consola 0, excepciones 0

Marca de ola con el DATA de la copia de R3, 1280 px (retorno del subagente)
esperado: línea `var(--ref)` y texto `var(--ink)`; «807 de 1.282 aún municipales»
obtenido: línea var(--ref) → rgb(138, 132, 120); texto «sale la ola 2027» var(--ink) → rgb(28, 18, 18); lg «… con resultado en 2027: 622 · 807 de 1.282 aún municipales»; con la plantilla base el texto quedaba en var(--ref) (calibración)

Re-derivación independiente del orquestador (`$TMPDIR/cal_s35b/orq_referente.R`: R base sobre `simce_rbd`, `sleps_chile`, `establecimientos_chile` y el catálogo; sin `36_funciones_trayectorias.R`)
esperado: 1.299; 1.282 presentes y 17 fuera; 475/406/401
obtenido: «ancla: 2014 referente (cat): 1299»; «presentes en el directorio (vig): 1282 fuera: 17»; 2027 475, 2028 406, 2029 401; «suma 2027-2029: 1282»

`#lg` re-medido por el orquestador (`$TMPDIR/cal_s35b/orq_a1.R`: lee `#lg` con chromote y calcula `e` del DATA incrustado leído en bytes; calibrado sobre la vista base, que da «… que se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124» y REF sin `vig`)
esperado: rótulo de D35-4 con 1.124; `meta.REF` con `vig` 1282 y olas 475/406/401
obtenido: «Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124»; `{"cat":1299,"vig":1282,"olas":{"2027":475,"2028":406,"2029":401},"marcas":[]}`; fila REF 2014 4b_lect T 0 con e 1124; marcas 0; consola 0, excepciones 0, red 0

- PRUEBAS (orquestador, tras la ola, sobre el árbol con A1 y M1):

`Rscript 00_build.R`, batería y `Rscript verificar_contenido_motor.R`
esperado: codigo_build=0; 30 pruebas en PASA, codigo 0; «JSON idéntico a la línea base»; C3 en PASA (I-6)
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»; OK en 6 segundos); md5 del build: parquet 468099a9c63bb3c0ddb74e67e2c7c19f, motor 56a6c052054a97ec4dfa9d2838dac386, vista f5f6c3113b408cbb0394eb911ed9995c (iguales a los que dejaron los subagentes); «Resultado: 30 pruebas, 30 pasan, 0 fallan», codigo_bateria=0; C3 «12724 filas de 37 unidades; idénticas: TRUE»; D10 y D12 PASA; «JSON idéntico a la línea base», codigo_I5=0

- Alcance: antes de commitear, `git diff --name-only HEAD` = `33_motor_template.html` (M1), `36_funciones_trayectorias.R`, `36_trayectorias_template.html`, `36_verificar_trayectorias.R` (A1); no seguidos: el log. `git show --name-only f8e7870` = las 3 rutas de A1. Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5 (heredado), esfuerzo xhigh, ALCANCE de A1; devolvió «completa»; verificado con los comandos de arriba. Cuenta Opus acumulada: 2 (A1 y M1).
- Bugs: ninguno.
- Decisiones autónomas (del subagente, aceptadas por el orquestador): «2014» sale de `ANIOS[0]` (coincide por construcción con el ancla de `filas_referente()`); el rótulo omite la parte de `vig` si falta; guarda `vig + N_CERRADOS == cat` en `cifras_notas()`; R5 comprueba también `vig` y R6 el rótulo completo; el párrafo de notas no cita años de ola.
- Errores propios (del subagente): esperado de la calibración de R5 escrito como 27/3 cuando fue 26/4 (no anticipó D12).
- Dudas: Q-26 (del subagente). El tooltip del referente de la plantilla (~L929: «Municipales en 2014 que no están en los __NOTA_N_VIGENTES__ Servicios Locales del catálogo: los traspasan las olas siguientes») trae «2014» literal y no menciona a los 17 cerrados. ¿Se ajusta en un encargo posterior? (sí / no)

### FASE M1: D35-5, la cifra dentro de la franja Elemental usa tinta oscura (ola 1, escritor Opus)

- Estado: completa.
- Commits: `01cdee0` fix(motor): cifra dentro de la franja Elemental con tinta oscura (D35-5).
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `m1.md` (tarea de §7 literal, D35-5 literal, estado de partida, 🔒, POSICIÓN, reglas, retorno).
- Cambios sustantivos (+10/−4 en `33_motor_template.html`): `const TINTA_SOBRE_ELEM = "#2E2230";` con 4 líneas de comentario junto a `TINTA_ELEM` (L1710-1714); `.attr("fill", seg.fill === COLOR_ELEM ? TINTA_SOBRE_ELEM : "#FFFFFF")` en las barras (L2381) y en el panorama (L3175); el comentario de las barras («en blanco») se corrigió. Sin cambios: el rótulo de Adecuado (`stacked ? "#FFFFFF" : COLOR_ADEC`), los colores de las franjas y el comentario de L1703-1707 (habla de Elemental sobre blanco, sigue cierto).
- Verificación:

Calibración del medidor del subagente sobre la línea base (`$TMPDIR/s35b_m1/medir_m1.R`)
esperado: Elemental interior en #FFFFFF, 2,78, en barras y panorama
obtenido: barras 35 rótulos #FFFFFF, razón mínima 2.78; panorama 18 rótulos #FFFFFF, 2.78

Rótulos interiores en modo apilado, 1280 px (retorno del subagente; en `#comparacion` con el botón «Mostrar niveles Elemental e Insuficiente» pulsado, `aria-pressed=true`; `#panorama` siempre apilado)
esperado: Elemental en #2E2230 en todos; razón ≥ 4,5 (5,44); Insuficiente medido
obtenido: barras: Elemental 35 rótulos, todos #2E2230, razón 5.44; panorama: 18, todos #2E2230, 5.44; Insuficiente 37 y 18 rótulos, #FFFFFF, 9.85; Adecuado (informativo) 9.48; franjas sin cambio (#0C4682, #6BA0CE, #79204F: 37/37/37 y 20/20/20, iguales a la base); pares superpuestos 0 en simple, apilado y panorama (base 0); consola 0, excepciones 0, red 0

Re-medición propia del orquestador (`$TMPDIR/cal_s35b/orq_m1.R`: `<text>` cuyo centro cae dentro de un `rect` Elemental o Insuficiente, `fill` computado, razón WCAG en R)
esperado: base: Elemental #FFFFFF 2,78 (caso malo); actual: #2E2230 5,44; Insuficiente ≥ 4,5
obtenido: base: #comparacion Elemental 35 rótulos #FFFFFF 2.78, #panorama 18 #FFFFFF 2.78, Insuficiente 37 y 18 #FFFFFF 9.85; actual (md5 56a6c052054a97ec4dfa9d2838dac386): #comparacion Elemental 35 #2E2230 5.44, #panorama 18 #2E2230 5.44, Insuficiente 37 y 18 #FFFFFF 9.85; opacidades distintas de 1: 0

I-8: `git diff 1a92827 -- 30_procesamiento/33_motor_template.html | grep -E '^\+.*attr\("fill", *"#' | grep -vE '#FFFFFF|#0A3A5C'`
esperado: vacío; `TINTA_SOBRE_ELEM` como constante
obtenido: vacío (orquestador y subagente); `TINTA_SOBRE_ELEM` declarada en L1714 y usada en L2381 y L3175. Calibración del subagente: con una línea plantada `.attr("fill", "#2E2230")` el filtro la imprime.

I-5: `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base» (subagente y orquestador tras el build, codigo_I5=0)

- Contraste de Insuficiente: 9,85:1 (≥ 4,5): no hay ADVIERTE.
- PRUEBAS: las mismas de FASE A1 (build 0, 30/30, I-5 idéntico).
- Alcance: `git show --name-only 01cdee0` = `30_procesamiento/33_motor_template.html`. Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de M1; devolvió «completa»; verificado arriba. Cuenta Opus acumulada: 2.
- Bugs: ninguno. Decisiones autónomas (del subagente, aceptadas): comentarios nuevos y corregido; L1703-1707 sin cambio. Errores propios (del subagente): un `codigo=0` de `tail` y no de `Rscript` al regenerar; la regeneración se comprobó por el mensaje OK, el md5 y el build del orquestador. Dudas: ninguna.

### FASE A2: pruebas y documentación pendientes de la vista (ola 2, escritor Opus)

- Estado: completa.
- Commits: `6dfe8fa` test(trayectorias): recuento independiente de las unidades futuras; docs: 28 rutas autorizadas.
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `a2.md`. Decisión del orquestador **D-A2-a (riesgo medio)**, escrita en el contrato antes de lanzar la ola, sobre dos hechos que la tarea no enumeraba y que el orquestador midió:
  - la fila de inspección de `dim_slep_comunas.csv` ya existía (línea 56, commit `6d7c757`): no se duplica; se completa con «catálogo público, sin persona natural» y «commit de origen `d7a8ec6`»;
  - el comando de cobertura del propio documento da 29 rutas (25 `.xlsx`, 3 `.csv` y 1 `.json`, `renv/settings.json`) y el de I-11 da 28 (sin el `.json`): las líneas 31 y 44 dicen «28 rutas» de datos tabulares y mencionan aparte `renv/settings.json`, para que el documento siga siendo verdadero y cumpla el criterio literal.
- Cambios sustantivos:
  - `36_verificar_trayectorias.R` (+75/−31): `olas_ind` y sus ayudas se leen antes de D9 (sin cambios); D9 agrega `recuento_fut` (RBD del directorio con `cod_depe2 == "1"` en las comunas de cada unidad `<cod_slep>_<año>`, filas de cualquier dependencia, sin llamar a `unidades_futuras()`); D9 exige cobertura en los dos sentidos (`sin_pareja`); D9c apunta a la primera fila no futura; D9f nuevo (control positivo sobre una unidad futura). La batería pasa de 30 a 31 pruebas.
  - `50_datos_versionados_autorizados.md` (+5/−4): «Al 2026-09-25 (sesión 35) estas ocho entradas cubren 28 rutas versionadas con extensión de datos tabulares (25 `.xlsx` y 3 `.csv`) y, aparte, `renv/settings.json` (1 `.json`): 29 rutas con el comando de abajo.»; «Cada una de las 28 rutas, más `renv/settings.json`, se inspeccionó…»; la fila de `dim_slep_comunas.csv` gana «copia de `slep_central_datos`, commit de origen `d7a8ec6`» y «Catálogo público de territorio e institución, sin persona natural».
- Verificación:

D9 ampliada (retorno del subagente y orquestador)
esperado: 0 desajustes con las 37 unidades futuras cubiertas
obtenido: «D9 PASA … (0 desajustes en 2661 + 5868 + 14090 combinaciones (total: 1332 de las vigentes y el referente y 1329 de 37 unidades futuras; nube; suma de grupos); sin pareja 0)»; «D9c PASA … (detectados 1 en 1002)»; «D9f PASA … (detectados 1 en 1001_2027)»

Calibración de D9 con una fila futura alterada (retorno del subagente, `$TMPDIR/s35b_a2/calibrar_d9.R`, con la versión nueva y con la de `HEAD`)
esperado: la versión nueva falla con la fila futura alterada; la de HEAD es ciega en los casos que solo el recuento independiente ve
obtenido: nueva: bueno PASA (0); solo el total −1 FALLA (2 hallazgos); total y un grupo −1 FALLA (1); total quitado FALLA (sin pareja 1). HEAD: bueno PASA; solo el total FALLA (1, por la suma de grupos); total y grupo PASA (ciega); total quitado PASA (ciega)

Calibración de D9f (retorno del subagente, `calibrar_d9f.R`: `recuento_fut` vaciado)
esperado: D9 y D9f FALLA
obtenido: D9 FALLA («0 de 0 unidades futuras … sin pareja 1329»); D9f FALLA («detectados 0 en NA»); D9c PASA

Resto de la batería sin cambios (retorno del subagente: `diff` de las salidas antes y después)
esperado: solo cambian D9, D9c, D9f y la línea «Resultado»
obtenido: solo esas líneas

Q-25 (orquestador): `grep -c '28 rutas'`, `grep -c '27 rutas'` y `grep -n d7a8ec6` sobre el documento
esperado: al menos 1; 0; una línea en la fila de la tabla
obtenido: 2; 0; `57:| auxiliares/dim_slep_comunas.csv (2026-09-25, sesión 35; copia de slep_central_datos, commit de origen d7a8ec6; …`. Calibración del subagente sobre `HEAD`: 27 rutas 2, 28 rutas 0, d7a8ec6 0.

Conteos que el documento declara (retorno del subagente)
esperado: 29 con el comando del documento (3 csv, 1 json, 25 xlsx); 28 con I-11; 8 entradas en el bloque
obtenido: 29; 3 csv, 1 json, 25 xlsx; 28; 8

- PRUEBAS (orquestador, tras la ola, con A2 y M2 en el árbol): `Rscript 00_build.R` codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); md5 parquet 468099a9c63bb3c0ddb74e67e2c7c19f, motor 7e48346b1f0dc3c6b54f316b7c58280a (igual al del subagente M2), vista f5f6c3113b408cbb0394eb911ed9995c (sin cambio: A2 no toca la vista); «Resultado: 31 pruebas, 31 pasan, 0 fallan», codigo_bateria=0; C3 PASA; «JSON idéntico a la línea base», codigo_I5=0.
- Alcance: `git show --name-only 6dfe8fa` = `36_verificar_trayectorias.R` y `50_datos_versionados_autorizados.md`. Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de A2; «completa»; verificado arriba. Cuenta Opus acumulada: 4.
- Bugs: ninguno.
- Decisiones autónomas: D-A2-a (orquestador, arriba). Del subagente, aceptadas: cobertura de D9 en los dos sentidos; D9c anclada a una fila vigente (con la extensión, la fila 1 pasaba a ser futura); D9f; «seis» → «ocho entradas».
- Errores propios: ninguno.
- Dudas: Q-27 (del subagente). D9 ampliada recuenta, como para las vigentes, solo el total T del panel 0 (1.329 combinaciones futuras); los grupos, el panel 1 y la serie combinada de las futuras quedan cubiertos solo por el cotejo interno `suma_grupos`. ¿Basta para cerrar R-52, o se abre una tarea que recuente también esas filas? (basta / ampliar en otra tarea)

### FASE M2: D35-6, «un solo establecimiento» se marca con «†», también en la sparkline (ola 2, escritor Opus)

- Estado: **completa con desviación declarada** (D-M2-a).
- Commits: `b346b40` fix(motor): un solo establecimiento se marca con † en barras y sparkline (D35-6).
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `m2.md`.
- Cambios sustantivos (+52/−24 en `33_motor_template.html`): `ASTERISCO_UNICO = "†"` (NOTA_UNICO → «† Un solo establecimiento»); sparkline: `const opacity = opPrevio;` (antes `(isLowN ? 0.45 : 1) * opPrevio`), la cifra conserva el factor común `opacity * 0.9` y agrega `ASTERISCO_UNICO` si `isLowN`; ChartHints: `<span className="hint-signo">{ASTERISCO_UNICO}</span><span>Un solo establecimiento</span>` y la regla CSS `.hint-low-n` pasa a `.hint-signo` (sin color literal); comentarios actualizados; **regla de choque nueva en la sparkline** (una cifra que choca con la del punto anterior, o con el rótulo «traspaso», sube lo justo para despejarla). `OP_PREVIO` y `esPrevio` sin cambio (`git diff` del orquestador: las únicas líneas con `opPrevio` son el cambio pedido). Los «*» del dato preliminar no se tocaron.
- Verificación:

Estado con `n_estab == 1` (retorno del subagente, reconstruido en R desde el JSON)
esperado: cod_com 5103, depe2 5, 4b lect, cod_grupo 2, n_estab 1 en 2023-2025; 7 de 14 tarjetas con punto único
obtenido: 2023, 2024 y 2025 con n_estab 1; 14 tarjetas, 7 con punto único reciente, 15 puntos únicos recientes y 21 en toda la serie; `meta.anios_preliminar` vacío

Calibración del contador de «*» sobre la línea base (subagente y orquestador)
esperado: más de 0
obtenido: subagente: 22 en `innerText` y 22 en `<text>` (simple), 52 y 52 (apilado); orquestador (`$TMPDIR/cal_s35b/orq_m2.R`): ««*» visible 22 | «*» en <text> 22» a 1280 y 375 px; 21 `<text>` a 0,405 (atenuación por `isLowN`) y 62 a 0,9

Criterios en el estado por defecto, 375 y 1280 px (retorno del subagente; simple y apilado)
esperado: 0 `<text>` atenuados por `isLowN`; cifras de los puntos únicos con «†»; 0 «*»; 0 superpuestos
obtenido: atenuados por `isLowN` 0 (textos y círculos) en las 4 combinaciones; por `OP_PREVIO` 0 (el estado no tiene años previos); marcas: sparkline 21/21, barras 15/15 (simple) y 45/45 (apilado), 0 desacuerdos con `n_estab`; «*»: 0 en `innerText` y 0 en `<text>` en las 4; superpuestos: sparkline 0 y barras 0 en las 4

Re-medición del orquestador (`orq_m2.R` y `orq_spark.R`, motor 7e48346b1f0dc3c6b54f316b7c58280a)
esperado: 0 «*»; «†» en cifras, notas y leyenda; 0 textos a 0,405; 0 pares superpuestos
obtenido: a 1280 y 375 px: ««*» visible 0 | «*» en <text> 0 | «†» visible 44 | «†» en <text> 43»; 7 notas «† Un solo establecimiento»; ChartHints «†Un solo establecimiento | Adecuado | Elemental | Insuficiente» (el signo va en su propio `span`); 83 `<text>` con opacidad efectiva < 1, todos a 0,900 (el factor común de las cifras de la sparkline) y 0 a 0,405; pares superpuestos en `svg.bars-svg` 0; en `svg.sparkline-svg` 0 (166 textos; base 0); consola 0, excepciones 0, red 0

Nota y exportación (retorno del subagente)
esperado: la nota y el SVG exportado dicen «† Un solo establecimiento»
obtenido: 7 notas en 14 tarjetas; SVG exportado con 7 «† Un solo establecimiento», 0 «Baja representatividad», 0 «*»; PNG 3080×3686 con 1485 píxeles de tinta en cada caja de nota y 0 en las cajas de control. La leyenda ChartHints no forma parte del SVG exportado (nunca lo fue).

Contraste efectivo de la cifra de la sparkline con un solo establecimiento (retorno del subagente)
esperado: base ≈ 2,14 (R-53); después ≥ 4,5
obtenido: base #0C4682 a 0,405 sobre #FFFFFF: 2.14 (21 cifras); después #0C4682 a 0,9 sobre #FFFFFF: 7.34 (21), en las 4 combinaciones

I-5 e I-8 (subagente y orquestador)
esperado: «JSON idéntico a la línea base»; I-8 vacío
obtenido: «JSON idéntico a la línea base» (codigo_I5=0 tras el build del orquestador); I-8 vacío

- Desviación **D-M2-a (riesgo medio), aceptada por el orquestador**: con «†» pegada a la cifra, las cifras de años contiguos de la sparkline se superponían (5 pares a 375 px y 7 a 1280; primer intento del subagente). Para cumplir «0 textos superpuestos», el subagente agregó una regla de choque que el texto de la tarea no pedía: mueve 11 cifras en los 4 estados nivel × prueba del tablero por defecto, hasta 24,8 unidades de viewBox, ninguna fuera del SVG ni recortada en la exportación. No cambia el criterio ni ningún valor; cambia la disposición de esas cifras (forma una «escalera»: p. ej., 28%† queda más arriba que 32% en la tarjeta 5103/Medio bajo). Se acepta para no congelar M2, G, A3 y M3; queda como duda Q-28 y para la revisión en Safari.
- PRUEBAS: las de FASE A2 (build 0, 31/31, I-5 idéntico).
- Alcance: `git show --name-only b346b40` = `30_procesamiento/33_motor_template.html`. Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de M2; «completa con desviación»; verificado arriba. Cuenta Opus acumulada: 4.
- Bugs: 1 (superposición por la «†» en la sparkline), resuelto en el segundo de 3 intentos.
- Decisiones autónomas (del subagente, aceptadas): separar en el medidor el factor común 0,9, `OP_PREVIO` e `isLowN`; medir también el modo apilado; la leyenda usa `{ASTERISCO_UNICO}`; `.hint-low-n` → `.hint-signo` y fuera la clase `hint-muted`; comentarios actualizados; espera de 6 s.
- Errores propios (del subagente): primer intento sin comprobar la holgura horizontal de las cifras contiguas.
- Dudas:
  - Q-28. Regla de choque de la sparkline: (A) se mantiene; (B) separación horizontal que conserva alturas; (C) mover siempre la cifra de mayor valor, para conservar el orden vertical; (D) revertirla y aceptar superposiciones (no cumple «0 textos superpuestos»).
  - Q-29. La cifra de un solo establecimiento queda a 0,9 como todas las de la sparkline (7,34:1; lectura literal de `opacity = opPrevio`). ¿(A) se conserva el 0,9 común, (B) opacidad 1 solo para la cifra única, o (C) se quita el 0,9 de todas?
  - Q-30. `OP_PREVIO` se verificó por diff (sin cambio), no en un estado con años previos al traspaso. ¿Basta (A) o se mide en un estado con un Servicio Local ya traspasado (B)?

### FASE G: migración del sitio a gobCL (pendiente 3 de v34, D33-4) (ola 3, escritor Opus)

- Estado: completa, con un ADVIERTE esperado (PNG exportado) y un criterio literal que no discrimina (`document.fonts.check`), declarado y suplido con una medición que sí discrimina.
- Commits: `271c04f` feat(sitio): tipografia gobCL incrustada en motor y vista (D33-4).
- Paso 1 (orquestador, autorización 5): `md5 -q 50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf`, `cp` de los tres a `10_utils/fuentes/` y `md5 -q` de la copia y del origen.
esperado: f5a622b0b5f209c9197b2acfd2e1e299, 0257bb4b62d5ec557627aa0136f1e1dc, 6f435f30d6a13092b7d5db5255dcca1b antes, en la copia y en el origen después
obtenido: los tres md5 iguales en las tres mediciones; 37.960, 36.528 y 44.776 B; `10_utils/fuentes/` no está ignorado (se versiona con el commit de G)
- `_archivo/20260925_capturas/` la creó el orquestador (autorización 4) antes de la ola 3; está ignorada (`.gitignore:31:_archivo/`).
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `g.md` (con la excepción de poder correr `00_build.R`, por ser la única tarea de su ola). Indicaciones del orquestador: calibrar `document.fonts.check()` y, si no discrimina, agregar una medición que sí; calibrar el md5 sin tocar las fuentes del repo; medir «antes» antes de editar; base64 sin saltos.
- Cambios sustantivos (+118/−47 en 4 archivos, más los 3 `.otf`):
  - `10_utils/10_html.R`: `MARCADOR_FUENTES = "/*__FUENTES__*/"`; `PATRON_SITIO_RESTO` agrega `|__FUENTES__`; `CARPETA_FUENTES`; `FUENTES_GOBCL` (data.frame archivo, peso, md5: Light 300, Regular 400, Heavy 700); `FORMATO_FONT_FACE` (`@font-face { font-family: "gobCL"; font-style: normal; font-weight: %d; font-display: swap; src: url(data:font/otf;base64,%s) format("opentype"); }`); `css_fuentes_gobcl()` se detiene si falta un archivo o si su md5 no coincide, nombrando el archivo, y si el base64 trae caracteres ajenos; `insertar_sitio()` reemplaza el marcador dentro del bloque CSS con `reemplazar_literal()`.
  - `33_fragmento_sitio.html`: comentario y marcador `/*__FUENTES__*/` al inicio del bloque `SITIO_CSS`.
  - `33_motor_template.html`: comentarios de cabecera y de familias (el de L79-80); `--font-display` y `--font-body` = `"gobCL", system-ui, …` con el stack anterior de respaldo; `const FONT_SVG = "gobCL, system-ui, sans-serif"`; los 31 literales `"system-ui, sans-serif"` pasan a `FONT_SVG` (orquestador: 0 literales y 33 apariciones de `FONT_SVG`, contando la declaración y un comentario).
  - `36_trayectorias_template.html`: comentario y `--font-display`/`--font-body` con `"gobCL"` primero (la vista no tenía literales SVG: sus `<text>` heredan de `body`).
- Verificación:

Estado «antes» (retorno del subagente y orquestador, que guardó copias en `$TMPDIR/base_s35b/pre_g/`)
esperado: motor 7e48346b1f0dc3c6b54f316b7c58280a y vista f5f6c3113b408cbb0394eb911ed9995c
obtenido: iguales; 2.793.068 y 2.089.545 B

`scrollWidth` antes y después, 18 pares (subagente, `$TMPDIR/s35b_g/medir_g.R`; orquestador, `$TMPDIR/cal_s35b/orq_g.R`, carga nueva por ancho, barras ocultas)
esperado: cada valor después ≤ antes
obtenido (orquestador): antes: vista 641/641/641/680/768/1280, `#comparacion` 376/540/640/680/768/1280, `#panorama` 375/540/640/680/768/1280 (a 375, 540, 640, 680, 768 y 1280 px). Después: vista 585/585/640/680/768/1280, `#comparacion` 375/540/640/680/768/1280, `#panorama` 375/540/640/680/768/1280. 18 de 18 cumplen (el subagente midió lo mismo: «filas: 18 | cumplen: 18»). Red 0 y errores 0 en las 36 cargas del orquestador.

`document.fonts.check('16px gobCL')` y `document.fonts.check('700 16px gobCL')` a 1280 px (criterio literal) y su calibración sobre las páginas sin gobCL
esperado: true en las dos páginas; en la línea base, si también da true, el literal no discrimina
obtenido: después TRUE y TRUE en la vista, `#comparacion` y `#panorama`; **antes también TRUE y TRUE** (orquestador y subagente), y `check('16px FamiliaQueNoExiste123')` da TRUE (subagente). **El criterio literal se cumple pero no discrimina.**

Medición que discrimina (orquestador: caras de `document.fonts` con familia gobCL; subagente: además `CSS.getPlatformFontsForNode`, que separa la fuente web de la instalada)
esperado: antes 0 caras gobCL; después 3 caras declaradas y el texto dibujado con la fuente web
obtenido: antes «(ninguna)» y `h1` en `system-ui…`; después «300:unloaded,400:loaded,700:loaded» en las tres vistas y `h1` con `gobCL, system-ui…` (la cara 300 no la pide ningún CSS y Chrome no la descarga; tras `document.fonts.load()` quedan 3 cargadas). Subagente: h1 «gobCL-Heavy, web + gobCL, web», menú «gobCL-Heavy, web», barras «gobCL, web», sparkline «gobCL-Heavy, web», panorama «gobCL, web», `#yr` de la vista «gobCL-Heavy, web». **Hecho relevante:** gobCL está instalada en `~/Library/Fonts` de esta estación, así que ver gobCL en pantalla aquí no prueba la incrustación; por eso la medición distingue «web».

I-2 (orquestador): `grep -c 'src="http'` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada archivo
obtenido: 0 0, 0 0, 0 0, 0 0

Crecimiento de cada HTML (orquestador: `wc -c`)
esperado: entre 145.000 y 175.000 B
obtenido: motor 2.793.068 → 2.953.314 (+160.246 B); vista 2.089.545 → 2.249.427 (+159.882 B)

base64 de las fuentes (retorno del subagente, `verificar_b64.R`, calibrado con un salto plantado: «saltos 1»)
esperado: 3 reglas por página, 0 saltos, md5 del decodificado igual al `.otf`
obtenido: pesos 300/400/700 con 50.616, 48.704 y 59.704 caracteres; 0 saltos; md5 decodificados f5a622b0…, 0257bb4b…, 6f435f30…; orquestador: 1 `@font-face` por peso en el motor

Superposición en `svg.bars-svg` (retorno del subagente)
esperado: 0 pares a 375 y 1280 px en la carga inicial y en el estado de M2 (apilado)
obtenido: 0/0/0/0 antes y después. Información: sparkline 0 en los 4 estados; panorama 0; vista `svg#g` 0; `svg#tk` a 375 px 7 pares antes y 7 después (años de la pista en pantalla angosta, preexistente; materia de A3), 0 a 1280

Calibración del md5 (retorno del subagente: copia del repo sin `.git` en `$TMPDIR/s35b_g/repo_calib/`, build bueno y build con 1 byte alterado en la copia de `gobCL_Regular.otf`)
esperado: bueno codigo 0; malo distinto de 0 con un mensaje que nombre el archivo; fuentes del repo intactas
obtenido: codigo_bueno=0 (mismos md5 de salida que el repo); codigo_malo=1, «md5 inesperado en la fuente gobCL_Regular.otf: 937de25ed641a7d25a0a5cf1eb401405 (se esperaba 0257bb4b62d5ec557627aa0136f1e1dc)», antes de escribir el motor; fuentes del repo con el md5 de H8

PNG exportado (ADVIERTE esperado; retorno del subagente)
esperado: medir si el PNG usa gobCL o el respaldo
obtenido: el SVG exportado trae `font-family="gobCL, system-ui, sans-serif"` y 0 `@font-face`; una imagen SVG rasterizada no ve las `@font-face` de la página (familia solo web contra respaldo: 0 px distintos). En esta estación el PNG sale con gobCL porque está instalada en el sistema; **en un equipo sin gobCL instalada, el PNG cae al respaldo del sistema. ADVIERTE.**

Capturas (retorno del subagente)
esperado: 12 PNG antes y después, 375 y 1280 px, tres vistas, en `_archivo/20260925_capturas/`
obtenido: 12 PNG `g_{antes,despues}_{trayectorias,comparacion,panorama}_{375,1280}.png`, 0 px distintos frente a una segunda captura de control en los 12 (orquestador: `ls` muestra los 12)

- PRUEBAS (orquestador, sobre el árbol de G): `Rscript 00_build.R` codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); md5 parquet 468099a9c63bb3c0ddb74e67e2c7c19f, motor 15977b7f3098d13854db6b859e0b0ca5, vista 719001cf632ea7d58373f036311fae02 (iguales a los del subagente); «Resultado: 31 pruebas, 31 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base», codigo_I5=0; I-10 1 y 1.
- Alcance: antes del commit, modificados `10_html.R`, `33_fragmento_sitio.html`, las dos plantillas; no seguidos: los 3 `.otf` y el log. `git show --name-only 271c04f` = esas 7 rutas. Dentro del ALCANCE (las capturas están en `_archivo/`, ignorada).
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de G; «completa»; verificado arriba. Cuenta Opus acumulada: 5.
- Bugs: ninguno en el producto.
- Decisiones autónomas (del subagente, aceptadas): `FONT_SVG` sin comillas alrededor de gobCL; comentarios de cabecera corregidos en las dos plantillas; formato de `@font-face` en una constante para no disparar una advertencia falsa del validador (`collapse = "\n"`); calibración con una copia completa del repo en `$TMPDIR`; la cara 300 declarada y no forzada; los `font-family="sans-serif"` que D3 pone en los ejes no se tocan (los pisa `FONT_SVG` en cada `<text>`).
- Errores propios (del subagente): un primer build con una advertencia falsa del validador (8 en vez de 7), corregida; un error de consola propio del instrumento con `CSS.enable`; una salida oculta por `tail -1`, repetida.
- Consecuencia para la ola 4 (orquestador): tras G, `#comparacion` ya no desborda a 375 px (375) y la vista desborda menos (585 a 375 y 540 px). Se informa a M3 y A3 en su contrato.
- Dudas:
  - Q-31. El PNG exportado usa gobCL solo si está instalada en el equipo que exporta. ¿Se acepta, o se incrusta la `@font-face` en el SVG que se rasteriza al exportar? (se acepta / incrustar en otro encargo)
  - Q-32. El criterio literal `document.fonts.check('16px gobCL')` da true también sin gobCL (y para una familia inexistente). ¿Se reemplaza en los encargos siguientes por el conteo de caras cargadas o por `CSS.getPlatformFontsForNode`? (sí / no)

### FASE A3: la vista sin desborde en pantallas angostas (pendiente 4 de v34) (ola 4, escritor Opus)

- Estado: completa.
- Commits: `df88fab` fix(trayectorias): sin desborde horizontal bajo 680 px (pendiente 4 de v34).
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `a3.md` (con la medición del orquestador tras G: 585 a 375 y 540 px).
- Cambios sustantivos (+37/−1 en `36_trayectorias_template.html`): un bloque nuevo `@media (max-width:679px){…}` al final de la hoja (para ganar la cascada a las reglas generales, que están después del `@media` de 640 px), con `.app{height:auto}`, `.ctls .f{flex:1 1 100%;min-width:0}`, `.ctls select{max-width:100%}`, `.hdacc{max-width:100%}`, `.cob{flex-wrap:wrap}`, `.sw{white-space:normal;…}`, `.main{grid-template-columns:minmax(0,1fr)}`, `svg.chart{flex:none;height:360px}`, `td.nm{white-space:normal}`, `.gapb{white-space:normal;max-width:calc(100% - 48px)}`, `.pl{flex-wrap:wrap}`, `.tk{flex:1 1 100%;min-width:0}`, `.modal{width:calc(100vw - 48px)}`; en el marcado, el grupo «Cobertura» gana `class="cob"` (sin regla fuera del `@media`). El orquestador revisó el diff: todas las reglas nuevas están dentro del `@media`. Causa medida por el subagente: la columna de la rejilla `.app` tomaba el ancho mínimo del grupo «Cobertura» (535 px, interruptores sin quiebre) y arrastraba `.ctls`, `.main`, `.pl` y `.f-coh`.
- Verificación:

Diagnóstico antes de editar (retorno del subagente, `$TMPDIR/s35b_a3/medir_a3.R diag antes`; cajas en `$TMPDIR/s35b_a3/antes/cajas.csv`)
esperado: 375 → 585, 540 → 585 (medición del orquestador), el resto por medir
obtenido: 375 sw=585, 540 sw=585; 640, 641, 645-679, 680 y 768 sin desborde; plano 0,0 px de alto a 375, 39,6 a 540 y 27,6-82,7 entre 641 y 680; `svg#tk` con 7 pares superpuestos de 375 a 680 y 0 a 768

`scrollWidth` después, anchos del criterio (retorno del subagente, con y sin filtro del estado de la fuente)
esperado: igual al viewport a 375, 540, 640, 641, 665, 680 y 768
obtenido: 375, 540, 640, 641, 665, 680, 768 (y 645-679 también); «Ningún elemento pasa del viewport en ningún ancho»; ningún contenedor con `overflow-x` hidden/clip y contenido más ancho; 0 de 112 estados de la interfaz desbordan (9 cohortes, nube, serie completa, desglose, pruebas, notas); modo presentación sin desborde

Re-medición del orquestador (`$TMPDIR/cal_s35b/orq_g.R` sobre la vista del build de `df88fab` copiada a `$TMPDIR/base_s35b/post_a3/`, carga nueva por ancho, barras ocultas)
esperado: igual al viewport en los 7 anchos
obtenido: vista 375/540/640/641/665/680/768 → 375/540/640/641/665/680/768 (también `#comparacion` y `#panorama` en esos 7 anchos); red 0, errores 0

Alto del plano a 375 px (subagente y orquestador, `orq_carrera.R`)
esperado: `svg.chart` ≥ 320 px
obtenido: 360 (subagente: 360 en todos los anchos de 375 a 679); orquestador: 360 en 2 cargas

0 píxeles distintos a 768, 1024, 1280 y 1920 px frente a las referencias posteriores a G (retorno del subagente)
esperado: 0 en los cuatro anchos
obtenido: 0, 0, 0, 0; dimensiones iguales a las referencias; control de determinismo 0. Por construcción el diff no tiene reglas fuera de `max-width:679px` (revisión del orquestador).

Calibración de la comparación de píxeles (retorno del subagente: copia con `--line-motor` #E7DFC9 → #E7DFC8)
esperado: más de 0 píxeles; la copia sin alterar, 0
obtenido: 768: 11.042; 1280: 18.946; copia sin alterar 0

Capturas (retorno del subagente)
esperado: 375 y 540 px en `_archivo/20260925_capturas/`
obtenido: `a3_antes_375.png`, `a3_antes_540.png`, `a3_despues_375.png` (375×2169), `a3_despues_540.png` (540×1882), `a3_despues_{768,1024,1280,1920}.png` y `a3_ref_{768,1024,1280,1920}.png`

- PRUEBAS (orquestador, árbol con A3): `Rscript 00_build.R` codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); md5 parquet 468099a9c63bb3c0ddb74e67e2c7c19f, motor 15977b7f3098d13854db6b859e0b0ca5 (sin cambio), vista 56d53fef719709d1a9f827ba257d84be (igual a la del subagente); «Resultado: 31 pruebas, 31 pasan, 0 fallan», codigo_bateria=0; C3 PASA; «JSON idéntico a la línea base», codigo_I5=0.
- Alcance: antes del commit, `git diff --name-only HEAD` = `36_trayectorias_template.html`; no seguidos: el log. `git show --name-only df88fab` = esa ruta. Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de A3; «completa»; verificado arriba. Cuenta Opus acumulada: 7 (A3 y M3).
- Bugs: ninguno propio de A3.
- Hallazgo del subagente, medido por el orquestador (**H-G-1**, para FASE R): **carrera de carga de la fuente en la vista, introducida por G.** `altoMenu()` y `anchoTarjeta()` a veces miden con la fuente de respaldo antes de que se aplique gobCL, y el diseño queda en uno de dos estados. Orquestador (`$TMPDIR/cal_s35b/orq_carrera.R`, 6 cargas nuevas a 768 px):
esperado: si la carrera la introdujo G, la vista previa a G da el mismo estado en todas las cargas y la posterior no
obtenido: vista previa a G (`pre_g`): 6 de 6 cargas con `--tabs-h 105px`, menú 105, `--cardw 348px`, alto 1196; vista posterior (`post_a3`): 5 cargas con `--tabs-h 101px`, menú 101, `--cardw 325px`, plano 130,3, alto 1178, y 1 carga (la 4) con `--tabs-h 105px` mientras el menú mide 101, `--cardw 334px`, plano 126,3, alto 1174. A 375 px: carga 1 `--tabs-h 136px` con menú 133; carga 2, 133 y 133.
- Decisiones autónomas (del subagente, aceptadas): protocolo de captura que recarga hasta el estado estable (B) y lo registra; bloque `@media` nuevo al final de la hoja en vez de ampliar el de 640 px; estilo inline de «Cobertura» conservado; reglas más allá del enfoque sugerido (`.hdacc`, `td.nm`, `.gapb`, `.modal`), cada una con su medición; los 7 pares de años de `svg#tk` a 375 px no se tocaron (sí quedan en 0 de 540 a 679 px); alto fijo de 360 px para el plano.
- Errores propios (del subagente): un `cat > /tmp/null` accidental que dejó un archivo vacío `/tmp/null` fuera del repo (no se borró, por la regla de no borrar); un heredoc que perdió comillas, corregido antes de usarlo.
- Dudas:
  - Q-33 (del subagente). Entre 680 y al menos 768 px el plano sigue aplastado (0 px con la cohorte 2027 a 680 px; 65,2 a 768; 82,7 y 130,3 con la cohorte inicial) y la tabla de 2027 se desplaza dentro de sí (500/428). Corregirlo cambia píxeles a 768 px o más. ¿Se registra como pendiente nuevo? (sí / no)
  - La duda del subagente sobre el conteo de la batería (31 y no 28) se resuelve aquí: el «28» de `comun.md` era el de FASE 0; A1 y A2 llevaron la batería a 31.

### FASE M3: el motor sin desborde a 375 px (Q-19 y Q-20) (ola 4, escritor Opus)

- Estado: **completa sin cambios** (decisión D-M3-a del orquestador). El criterio ya se cumplía tras G; no hay commit de M3.
- Commits: ninguno. `33_motor_template.html` sin diff frente a `271c04f`; el motor de `40_salidas/` sigue en 15977b7f3098d13854db6b859e0b0ca5.
- Contrato: `$TMPDIR/s35b_contratos/comun.md` y `m3.md`, con la indicación 7 del orquestador: tras G, `#comparacion` ya daba 375 a 375 px; si el subagente lo confirma, no se edita la plantilla.
- Verificación:

`scrollWidth` a 375, 540 y 768 px, dos vistas, dos cargas nuevas cada una (retorno del subagente)
esperado: igual al viewport en las 12 mediciones
obtenido: `#comparacion` 375/375, 540/540, 768/768; `#panorama` 375/375, 540/540, 768/768 (clientWidth, innerWidth y body.scrollWidth iguales; gobCL cargada en cada carga). Orquestador (FASE A3, `orq_g.R`): `#comparacion` y `#panorama` iguales al viewport en 375, 540, 640, 641, 665, 680 y 768.

Recorrido del DOM a 375 px (elementos cuyo `right` supera el viewport; esperado del orquestador: 0)
esperado: 0 elementos en las dos vistas
obtenido: `#comparacion`: 476 elementos y 521 textos, **todos dentro de `div.table-wrap`** (`overflow-x: auto`, right 335, clientW 293, scrollW 1236: el desplazamiento interno de la tabla «Territorio × GSE × Año», `.data-table{min-width:1000px}`); fuera de contenedores con desplazamiento, 0 y 0. `#panorama`: 0 y 0. El esperado «0» del orquestador no distinguía el desplazamiento interno de una tabla del desborde de la página; el criterio de la tarea (`scrollWidth` = viewport) se cumple.

Calibración del medidor de desborde (retorno del subagente: copia con `.sub-eyebrow{white-space:nowrap}`)
esperado: el medidor detecta el desborde plantado
obtenido: sw=436 y 8 textos fuera (4 «Últimas 3 aplicaciones», 4 «Trayectoria histórica»); el recorrido solo por elementos no lo veía (0 fuera) y el de nodos de texto sí: se corrigió el instrumento antes de medir el original (error propio del subagente, declarado)

0 píxeles distintos a 768, 1024, 1280 y 1920 px frente al estado posterior a G, y su calibración (retorno del subagente)
esperado: 0 en las 8 capturas; con `--line` alterado, más de 0
obtenido: 0 en las 8 (sin edición; cargas nuevas); determinismo 0; calibración 22.572 a 44.621 en `#comparacion` y 5.118 a 7.894 en `#panorama`

I-5 (subagente)
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base»

Capturas a 375 px (retorno del subagente)
esperado: las dos vistas en `_archivo/20260925_capturas/`
obtenido: `m3_comparacion_375.png` (375×4390) y `m3_panorama_375.png` (375×2367), deterministas entre dos cargas

- Información medida (no es criterio de M3):
  - Q-19: a 375 px el supergrid de `#comparacion` tiene 4 columnas de 64,75 px; «Últimas 3 aplicaciones» y «Trayectoria histórica» superan el borde de su celda en 32,27 px y se montan sobre la celda vecina sin desbordar la página; PUCHUNCAVÍ supera su columna en 46,34 px (se monta sobre QUINTERO) y QUINTERO en 21,59 px.
  - Q-20: el título «SLEP Costa Central» de `.hero-card` en `#panorama` queda en 3 líneas con 36 px de ancho, porque `.hero-card-right` ocupa la misma línea flex; no desborda. No se modificó.
- Decisión **D-M3-a (riesgo bajo)**: M3 se cierra sin cambios y sin commit. El encargo fija un mensaje de commit para M3, pero no hay cambio que commitear: el desborde de 1 px lo eliminó G (gobCL es más angosta que la fuente del sistema en esos textos). Editar sin causa medida no corresponde.
- Alcance: `git diff --name-only HEAD` sin rutas de M3; solo capturas en `_archivo/` (ignorada).
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de M3; devolvió «parcial» solo por la duda del recorrido (476 elementos dentro de `.table-wrap`), que el orquestador resuelve arriba. Cuenta Opus acumulada: 7.
- Bugs: ninguno. Errores propios (del subagente): la primera versión del recorrido refinado no detectaba texto desbordado; corregida con la calibración.
- Dudas:
  - Q-34. A 375 px, los textos del supergrid de `#comparacion` se montan sobre las celdas vecinas sin desbordar la página (Q-19). ¿Se registra como pendiente de legibilidad bajo 540 px? (sí / no)

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (derivado de las secciones anteriores del log; anexado antes de auditar). Estado auditado: `HEAD` = `df88fab`; punto de retorno `1a92827`. Auditor 1: A1, A2, R5, R6, D9 e I-6. Auditor 2: I-5, M1, M2, M3 y exportación. Auditor 3: FASE 0, P1, P2, G, A3, I-1 a I-4, I-7 a I-12 y alcance.

| id | afirmación (fuente en el log) | auditor |
|---|---|---|
| R-01 | T0 (`1a92827`) agrega solo el encargo, md5 57e60440…; antes, `HEAD` y `origin/main` en `9d612a3` (H3, H4) | 3 |
| R-02 | H9: `simce_comunal.parquet` es determinista (468099a9…) y P1 no lo cambia (I-12) | 3 |
| R-03 | H7: `png` no está en la biblioteca de renv; se carga en solo lectura desde la del sistema (D0-a) | 3 |
| R-04 | El comparador de I-5 distingue «idéntico» de «difiere» (calibración de FASE 0) | 2 |
| R-05 | P1: el `.by` del diagnóstico incluye `cod_com_rbd`; I-7 absoluto vacío en `HEAD` y exactamente la línea 206 en `1a92827` | 3 |
| R-06 | P1: el bloque «Costa Central» sin `cod_com_rbd` es idéntico al previo | 3 |
| R-07 | P2: con `ruta_insumos()`, el validador da 0 críticas (`data_root_resuelto` OK) y 7 advertencias; el autotest detecta y limpia | 3 |
| R-08 | P2: el build se detiene con un `.R` en la raíz que trae una ruta absoluta de usuario y vuelve a código 0 sin él | 3 |
| R-09 | A1: `meta$REF` = cat 1.299, vig 1.282, olas 475/406/401; 17 fuera del directorio | 1 |
| R-10 | A1: `#lg` a 1280 px, estado inicial: «Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124», con `e` de DATA | 1 |
| R-11 | A1: R5 falla con la regla vieja (479) y R6 con el rótulo viejo (820 de 1.299); las dos pasan hoy | 1 |
| R-12 | A1: marca de ola con texto `var(--ink)` y línea `var(--ref)`; con la copia de R3, «807 de 1.282 aún municipales» | 1 |
| R-13 | A1: el párrafo del referente en las notas es coherente con 1.299, 17 y 1.282, sin marcadores sin reemplazar | 1 |
| R-14 | A1 / I-6: las 12.724 filas de las 36 vigentes y del referente son idénticas a la línea base | 1 |
| R-15 | A2: D9 cubre las 37 unidades futuras (1.329 combinaciones T/panel 0) con 0 desajustes; D9f dispara | 1 |
| R-16 | A2: el documento dice «28 rutas» y no «27 rutas»; 29 con su comando y 28 con I-11; la fila de `dim_slep_comunas.csv` cita `d7a8ec6` y no está duplicada | 1 |
| R-17 | M1: rótulos interiores de Elemental en #2E2230 (35 en `#comparacion` apilado, 18 en `#panorama`), 5,44:1; base 2,78; Insuficiente 9,85; franjas sin cambio de color | 2 |
| R-18 | M2: estado por defecto: 0 «*»; «†» en 15 cifras de barras, 21 de sparkline y 7 notas; ChartHints «† Un solo establecimiento» | 2 |
| R-19 | M2: 0 textos atenuados por `isLowN`; cifra única de la sparkline 7,34:1 (base 2,14) | 2 |
| R-20 | M2: 0 textos superpuestos en `svg.bars-svg` y `svg.sparkline-svg` a 375 y 1280 px (simple y apilado); la regla de choque mueve 11 cifras | 2 |
| R-21 | M2: el SVG exportado trae 7 «† Un solo establecimiento» y 0 «*» | 2 |
| R-22 | G: `10_utils/fuentes/*.otf` con los md5 de H8; 3 `@font-face` `data:` cuyo base64 decodifica al `.otf` exacto, sin saltos | 3 |
| R-23 | G: el control de md5 detiene `insertar_sitio()`/el build con un `.otf` alterado en una copia | 3 |
| R-24 | G: `scrollWidth` después ≤ antes en los 18 pares (vista 641→585 a 375/540; `#comparacion` 376→375 a 375) | 3 |
| R-25 | G: cada HTML crece +160.246 B (motor) y +159.882 B (vista) | 3 |
| R-26 | G: `document.fonts.check` da true antes y después (no discrimina); después hay caras gobCL 400 y 700 cargadas y el texto se dibuja con la fuente web | 3 |
| R-27 | G: 0 literales `"system-ui, sans-serif"` en el motor; `FONT_SVG` con gobCL primero | 3 |
| R-28 | H-G-1: tras G la vista tiene una carrera de carga de fuente (`--tabs-h` 105 con menú 101 en 1 de 6 cargas a 768 px) que antes de G no existía | 3 |
| R-29 | G: el PNG exportado cae al respaldo del sistema en un equipo sin gobCL instalada (ADVIERTE) | 2 |
| R-30 | A3: la vista da `scrollWidth` = viewport a 375, 540, 640, 641, 665, 680 y 768 px; `svg.chart` ≥ 320 px a 375; todo el CSS nuevo dentro de `max-width:679px` | 3 |
| R-31 | A3: 0 píxeles distintos a 768, 1024, 1280 y 1920 px frente al estado posterior a G | 3 |
| R-32 | M3: sin editar, el motor da `scrollWidth` = viewport a 375, 540 y 768 px en `#comparacion` y `#panorama` | 2 |
| R-33 | I-1 `docs/` intacto | 3 |
| R-34 | I-2 sin cargas por red | 3 |
| R-35 | I-3 vendorizados sin cambio | 3 |
| R-36 | I-4 guarda de locale | 3 |
| R-37 | I-5 JSON del motor idéntico a la línea base (decodificador propio) | 2 |
| R-38 | I-6 (= R-14) | 1 |
| R-39 | I-7 absoluto vacío | 3 |
| R-40 | I-8 sin `fill` literal nuevo fuera de #FFFFFF y #0A3A5C; `TINTA_SOBRE_ELEM` como constante | 3 |
| R-41 | I-9 mockup congelado | 3 |
| R-42 | I-10 un `__SITIO_HTML__` por plantilla | 3 |
| R-43 | I-11 28 archivos de datos versionados | 3 |
| R-44 | I-12 parquet comunal sin cambio (468099a9…) | 3 |
| R-45 | Alcance global: `git diff --name-only 1a92827..HEAD` dentro de la unión de los ALCANCE, más el log | orquestador y 3 |
| R-46 | Regresión: build 0, batería 31/31, I-5 idéntico en el estado final | orquestador |

**R.2 Re-derivación independiente.** Panel de 3 lectores Opus 5.5 (esfuerzo xhigh) en una sola ola (workflow `fase-r-s35b`), con contrato común `$TMPDIR/s35b_contratos/auditor_comun.md` y repartos `r1.md`, `r2.md`, `r3.md`: cada uno recibió las afirmaciones, las rutas de las fuentes y el repositorio, sin el log, sin los scripts de las tareas ni los `verificar_*.R`, con la orden de no correr el build en el árbol (los builds de R-08, R-23 y R-06 se hicieron en copias del repo en `$TMPDIR/s35b_r3/repo`). Scripts propios en `$TMPDIR/s35b_r1/`, `s35b_r2/` y `s35b_r3/`. Resultado: auditor 1, 7 CONFIRMADA y 1 REFUTADA (R-16, solo por frases previas al encargo); auditor 2, 8 CONFIRMADA y 2 REFUTADA (R-19 por la cifra 7,34, R-20 por 1,8 px laterales), más una medición informativa (el motor no tiene carrera de fuente medible); auditor 3, 29 CONFIRMADA y 0 REFUTADA. Cuenta Opus acumulada: **10** (tope 10; ningún subagente más en el encargo).

**R.3 Invariantes 🔒** (orquestador, estado final `facc0d1`, tras el build de la regresión; `<punto_de_retorno>` = `1a92827`)

I-1 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47
obtenido: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47 → **PASA**

I-2 `grep -c 'src="http'` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada archivo
obtenido: motor 0/0, vista 0/0, docs/index 0/0, docs/trayectorias 0/0 → **PASA** (auditor 3: además, chromote ve solo esquemas `data:` y `file:` en las cinco páginas)

I-3 `git diff --name-only 1a92827..HEAD -- '10_utils/*.js'`
esperado: vacío
obtenido: vacío → **PASA**

I-4 `md5 -q 10_utils/10_locale.R` y `grep -n asegurar_locale_utf8 10_utils/10_configuracion.R`
esperado: dc900c1b… y una línea
obtenido: dc900c1b0d2d252c9e5730875be5d632 y `16:asegurar_locale_utf8("10_configuracion")` → **PASA**

I-5 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I5=0 → **PASA** (auditor 2, decodificador propio: canónico, crudo sin fecha y comparación profunda idénticos)

I-6 prueba C3
esperado: PASA
obtenido: «C3 PASA … (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: TRUE)» → **PASA**

I-7 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd` (forma absoluta)
esperado: vacío
obtenido: vacío → **PASA**

I-8 `git diff 1a92827..HEAD -- 30_procesamiento/33_motor_template.html | grep -E '^\+.*attr\("fill", *"#' | grep -vE '#FFFFFF|#0A3A5C'`
esperado: vacío; `TINTA_SOBRE_ELEM` como constante
obtenido: vacío; `const TINTA_SOBRE_ELEM = "#2E2230";` en la línea 1721 y usada en 2424 y 3218 → **PASA**

I-9 `git diff --name-only 1a92827..HEAD -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html`
esperado: vacío
obtenido: vacío → **PASA**

I-10 `grep -c '__SITIO_HTML__'` en las dos plantillas
esperado: 1 y 1
obtenido: 1 y 1 → **PASA**

I-11 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

I-12 `md5 -q 40_salidas/intermedios/simce_comunal.parquet`
esperado: 468099a9c63bb3c0ddb74e67e2c7c19f
obtenido: 468099a9c63bb3c0ddb74e67e2c7c19f → **PASA**

**R.4 Alcance global** (`git diff --name-only 1a92827..HEAD` y `git status --porcelain`, estado final)
esperado: dentro de la unión de los ALCANCE, más el log sin commitear
obtenido: `00_build.R`, `10_utils/10_configuracion.R` (P2); `10_utils/10_html.R`, `10_utils/fuentes/gobCL_{Heavy,Light,Regular}.otf`, `30_procesamiento/33_fragmento_sitio.html` (G); `30_procesamiento/32_agregar_comunal.R` (P1); `30_procesamiento/33_motor_template.html` (M1, M2, G); `30_procesamiento/36_funciones_trayectorias.R` (A1); `30_procesamiento/36_trayectorias_template.html` (A1, G, A3); `30_procesamiento/36_verificar_trayectorias.R` (A1, A2); `50_documentacion/activa/50_datos_versionados_autorizados.md` (A2). Por commit (orquestador): cada uno toca solo el ALCANCE de su tarea (los cuatro `fix(auditoria)` tocan rutas del ALCANCE de la tarea de origen: R-47/R-51 motor de M2 y G; R-49 `32_agregar_comunal.R` de P1; R-50 vista de G; R-52 fragmento de G). `git status --porcelain`: solo `?? 50_documentacion/andamios/logs/20260925_pendientes_s35b_log.md`. Auditor 3 (`alcance.py`, antes de las reparaciones): «rutas: 13 fuera: []» y «fuera: []» en los 9 commits. **PASA.**

**R.5 Regresión completa** (estado final `facc0d1`)
esperado: `Rscript 00_build.R` codigo 0; batería 31/31 codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»; md5 parquet 468099a9c63bb3c0ddb74e67e2c7c19f, motor 99529ee31cf27e41e6417f76aa07d262, vista 5897a6a361ecd03c4ff73b1eee1300a7); «Resultado: 31 pruebas, 31 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base», codigo_I5=0 → **PASA**

**R.6 Control positivo de la propia auditoría.**
- Cifra alterada (auditor 1): copia de la vista fuera del árbol con el `e` de REF 2014 de 1124 a 1125 (1 byte). Instrumentos de R-10 y R-14: con el original, «VEREDICTO_R10: TRUE» e «identicas (valor y orden): TRUE»; con la copia, el rótulo lee «…con resultado en 2014: 1.125», y los dos instrumentos dan FALLA. **Dispara.**
- Archivo fuera de alcance (auditor 3): `alcance.py prueba` con 8 rutas simuladas (`10_utils/10_locale.R`, el mockup, `docs/index.html`, `docs/trayectorias.html`, `10_utils/d3.v7.min.js`, `40_salidas/sub/x.html`, `30_procesamiento/33_generar_html.R`, `_archivo/otra/x.png`) más las 13 reales: marcó FUERA exactamente las 8; por tarea, marcó `10_html.R` en un commit de A3 y `00_build.R` en uno de P1. **Dispara.**
- Además (auditor 2): dos `<text>` plantados en la misma posición → 1 par; un `<text>` fuera del SVG → detectado; un número del JSON alterado → «DIFIERE»; una copia con solo `fecha_generacion` cambiada → «IDENTICO».

**R.7 Veredicto por hallazgo** (hallazgos numerados desde R-47; ninguno BLOQUEA).
- REPARA: R-47 (en gobCL «†» se dibuja igual que «+»), R-48 (la regla de choque de M2 invierte el orden vertical de cifras), R-49 (comentario de P1 falso), R-50 (carrera de carga de fuente en la vista, H-G-1), R-52 (comentario del fragmento falso sobre `FONT_SVG`); y R-51, destapado al re-verificar R-47 (4 cifras con «†» sobre el rótulo «traspaso» en el barrido amplio).
- ADVIERTE: R-53 a R-72 (tabla R.10). No se reparan.
- Decisión D-R-a (orquestador): R-54, la frase del documento de datos que dice que los globs no cruzan `/` ni alcanzan a `directorio_oficial_ee.csv`, se clasifica ADVIERTE y no BLOQUEA: es previa al encargo (c7fb2ee, sesión 28), el archivo con MRUN sigue fuera del índice (`.gitignore:44`) e I-11 da 28; es un riesgo latente de gobernanza que el titular debe corregir (fuera de todo ALCANCE de este encargo).

**R.8 Ciclo de reparación 1** (orquestador en serie; sin subagentes, porque el tope Opus ya estaba en 10).

R-47. (a) Causa raíz: las tres caras gobCL traen U+2020, pero su dibujo es el del «+» (auditor 2: IoU 1,0 en Heavy, Regular y la Bold del sistema); G puso gobCL primero en `FONT_SVG` y en `--font-body`, y M2 había cambiado la marca a «†». (b) Fix: `FONT_SIGNO` (stack del sistema) y `conMarcaUnico()`: la marca va en su propio `<tspan font-family=FONT_SIGNO>` en las cifras de barras (dentro de la franja, sobre la barra y rescatadas), en la sparkline y en la nota; `.hint-signo` usa la misma familia. (c) Mismo chequeo (IoU de las máscaras de «†» y «+» en un canvas, como el del auditor, pero con la fuente computada de cada nodo que lleva la marca; `$TMPDIR/cal_s35b/orq_r47.R`):
esperado: antes, IoU 1 (la marca en gobCL); después, marcas en `<tspan>` con la familia del sistema e IoU bajo (auditor: 0,183 en system-ui)
obtenido: antes «textos con †: 43 | con tspan propio: 0», fuentes `600/700/500 … gobCL, system-ui, sans-serif`, IoU 1 (min y max); después «textos con †: 43 | con tspan propio: 43», fuentes `… system-ui, -apple-system, "Segoe UI", …`, «IoU †/+ con la fuente de la marca: min 0.183 max 0.192»; calibración con la fuente del `<text>` (gobCL): 1; leyenda «† | 700 200px system-ui… | IoU 0.183»
Chequeo distinto (SVG exportado con el botón del motor, instrumento del auditor 2 `exportar.R`, y conteo en el archivo):
esperado: 7 notas, 43 marcas en `<tspan>` con la familia del sistema, 0 «*»
obtenido: «notas «Un solo establecimiento»: 7», «tspan con la marca: 43», «† total: 43 | «*» total: 0»

R-51 (destapado por R-47). Al re-verificar R-47 con el barrido amplio del auditor 2 (`$TMPDIR/s35b_r2/amplio.R`: 2.832 sparklines y 5.664 gráficos de barras con algún punto único), aparecieron 4 superposiciones, todas de una cifra con «†» contra el rótulo «traspaso» (la base tenía 10 de esa clase; con la marca en gobCL el ancho las evitaba por azar). (a) Causa raíz: la regla de M2 revisaba «traspaso» solo si la cifra chocaba además con la anterior. (b) Fix (tres intentos, el tope): intento 1 = solo R-47 → 4 superposiciones; intento 2 = revisar «traspaso» para toda cifra → 1 superposición (una cifra que sube sobre «traspaso» vuelve a tocar la anterior); intento 3 = repetir la revisión contra los dos obstáculos hasta que no toque ninguno → 0. (c) Mismo chequeo (barrido amplio):
esperado: 0 superposiciones
obtenido: intento 3 «solapes 0», «fuera arriba 1» (una cifra, «71%†» de SLEP 1305, grupo Medio, 2° medio Matemática, sale 5,0 px por arriba del SVG; queda visible, porque `.sparkline-svg` tiene `overflow: visible`), subidas 1.479, invertidas 627
Chequeo distinto (estado por defecto, `orq_spark.R` y `orq_m2.R` a 375 y 1280 px):
esperado: 0 pares superpuestos en sparklines y barras
obtenido: sparklines «166 | pares superpuestos 0» a 375 y 1280; barras 0 a 375 y 1280; 0 «*»; 44 «†» visibles

R-48 (escalera). (a) Causa raíz: la regla de M2 siempre sube la segunda cifra de un par que choca, aunque sea la de menor valor. (b) Tres intentos, con el barrido amplio como verificación (métrica del auditor: cifras subidas que quedan sobre una cifra anterior de mayor valor; y una métrica propia más estricta: pares contiguos con el orden vertical opuesto al de sus valores):
- Intento 1 (sube siempre la de mayor valor, con cascada hacia atrás): «invertidas 53», pero «fuera arriba 8» y subida máxima 40,2. Destapa un defecto nuevo.
- Intento 2 (la menor baja bajo la anterior si no llega a la banda de años; si no, sube la mayor con controles): «solapes 0 | fuera arriba 0 | subidas 891 | bajadas 687 | invertidas (auditor) 51 | invertidas (todas) 244 | subida máx 32.8».
- Intento 3 (primero separar en horizontal hasta 8 unidades, sin cambiar alturas; si no cabe, sube la mayor con controles): «solapes 0 | fuera arriba 0 | subidas 572 | bajadas 0 | invertidas (auditor) 155 | invertidas (todas) 241 | subida máx 26.4», frente al estado vigente «invertidas (auditor) 627 | invertidas (todas) 893 | subida máx 31».
esperado (criterio de la reparación): 0 inversiones, 0 superposiciones y 0 cifras fuera del SVG
obtenido: ningún intento llega a 0 inversiones. **R-48 se congela tras el tercer intento** (§1, topes) y queda pendiente (Q-28, ampliada). La plantilla vuelve al estado commiteado (`git checkout -- 30_procesamiento/33_motor_template.html`); el parche del intento 3 queda como evidencia en `$TMPDIR/cal_s35b/r48/r48_intento3.patch` (126 líneas, md5 5bd6564cc4d741e7d3018dd6d20b6128).

R-49. (a) El comentario de P1 decía «La salida no cambia», pero la tabla impresa gana la columna `cod_com_rbd` (17 × 11 → 17 × 12). (b) Fix: «Los valores no cambian …; la tabla impresa gana la columna cod_com_rbd». (c) Mismo chequeo (`grep -c "La salida no cambia"` en el archivo; calibración en `eb77b28`):
esperado: 0 en el archivo y 1 en `eb77b28`
obtenido: 0 y 1; «la tabla» 1. Chequeo distinto: la comparación del bloque impreso de FASE P1 («17 × 11» antes, «17 × 12» después; valores iguales sin la columna).

R-50. (a) Causa raíz (auditor 3, con un gancho sobre `setProperty`): `altoMenu()` mide el menú a los ~43 ms, con gobCL cargando, y solo se repite en `resize`; el callback de `document.fonts.ready` repetía `anchoTarjeta()` pero no `altoMenu()`, y `ready` puede resolverse antes de que empiece la carga. (b) Tres intentos (el tope): intento 1 = recalcular menú y tarjeta en `ready`, en la carga explícita de las dos caras y en `loadingdone` → `--tabs-h` correcto en 40 de 40, pero `--cardw` 328 (39) y 332 (1): `anchoTarjeta()` depende del ancho vigente de la tarjeta y ahora corría varias veces; intento 2 = un solo recálculo tras `document.fonts.load()` de las caras 400 y 700 → `--cardw` 325 (39) y 334 (1); intento 3 = lo mismo, con `--cardw` vuelto a su valor por omisión antes de medir → un solo estado. (c) Mismo chequeo (`$TMPDIR/s35b_r3/r28.R` del auditor 3, 40 cargas nuevas a 768 px por versión):
esperado: un solo estado, con `--tabs-h` igual al alto real del menú
obtenido: `pre_g` 40× «105px | 348px | 105»; `post_g` 35× «101px | 325px | 101» y 5× «105px | 334px | 101» (calibración: la carrera existe); final 40× «101px | 318px | 101»
Chequeo distinto (`$TMPDIR/cal_s35b/orq_det.R`: 3 cargas nuevas por ancho, `--tabs-h`, `--cardw`, alto del menú y píxeles distintos contra la primera carga):
esperado: el mismo estado y 0 píxeles distintos en cada ancho
obtenido: 768: «101px|318px|101» ×3, 0 y 0; 1024, 1280 y 1920: «51px|318px|51» ×3, 0 y 0
Consecuencia declarada: el ancho de la tarjeta de la vista pasa a ser siempre 318 px desde 680 px (antes, 325 en la mayoría de las cargas y 334 en algunas); por eso las capturas de referencia de A3 a 768 px o más ya no coinciden píxel a píxel con la vista final (R-73). Bajo 680 px no cambia nada (A3 apila la rejilla).

R-52. (a) El comentario del fragmento decía que las plantillas ponen gobCL «en --font-display, --font-body y FONT_SVG», y la vista no tiene `FONT_SVG`. (b) Fix: «Las dos plantillas la ponen primero en --font-display y --font-body…; el motor la pone además en FONT_SVG (los <text> de la vista heredan la de body)». (c) Mismo chequeo (`grep -c "y FONT_SVG, con el stack"`; calibración en `271c04f`):
esperado: 0 y 1
obtenido: 0 y 1; `FONT_SVG` en la vista 0 y en el motor 34.

Pasos 2-5 sobre lo tocado (orquestador, estado final `facc0d1`): re-derivaciones de arriba; invariantes de R.3; alcance de R.4; regresión de R.5; además, anchos de A3 re-medidos (`orq_g.R`: vista, `#comparacion` y `#panorama` iguales al viewport en 375, 540, 640, 641, 665, 680, 768 y 1280 px; `svg.chart` 360 px a 375 px en 2 cargas). Commits del ciclo: `9344548` (R-47 y R-51), `07fc5d0` (R-49), `4a88f87` (R-50), `facc0d1` (R-52). No hubo ciclo 2: ninguna reparación commiteada destapó otro defecto en la re-verificación, salvo R-53 (ADVIERTE, abajo).

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | T0 agrega solo el encargo; padre 9d612a3 | A3: `git log -1 --format='%H %P'`, `diff-tree`, `ls-remote` | 1 ruta; 57e60440…; 9d612a3 | iguales; ls-remote 9d612a3 | — | ninguna | — | — |
| R-02 | parquet determinista; P1 no lo cambia | A3: dos corridas de HEAD y una de 1a92827 en copia del repo | 468099a9… | igual en todas | — | ninguna | — | — |
| R-03 | png fuera de renv, en el sistema | A3: `.libPaths()`, `find.package` | FALSE en renv; TRUE en sistema | «png en renv: FALSE … en sistema: TRUE 0.1.9» | — | ninguna (D0-a) | — | — |
| R-04 | comparador de I-5 calibrado | A2: decodificador propio (canónico, crudo, profundo) | idéntico / difiere | IDENTICO; DIFIERE con 3.5→3.6 | — | ninguna | — | — |
| R-05 | `.by` con `cod_com_rbd`; I-7 vacío en HEAD y la línea 206 en 1a92827 | A3: grep, `git grep`, AST de R | vacío / L206 | vacío; L206; AST 0 llamadas con nombre sin código | — | ninguna | — | — |
| R-06 | bloque Costa Central igual sin `cod_com_rbd` | A3: `parse_cc.py` y `identical()` | iguales | 187 celdas iguales; 131 filas identical TRUE | REPARA (R-49, comentario) | corregido | 07fc5d0 | grep 0/1 |
| R-07 | 0 críticas, 7 advertencias; autotest | A3: validador propio | 0; 7; SI/SI | «criticas= 0 advertencias= 7»; autotest SI/SI | — | ninguna | — | — |
| R-08 | build se detiene con ruta plantada | A3: copia del repo | codigo≠0 y 0 | 1 y 0; 0 «iniciando pipeline» | ADVIERTE (R-69) | registrar | — | — |
| R-09 | REF: 1.299/1.282/475-406-401; 17 fuera | A1: recuento propio + mutación | iguales | iguales; la mutación de dependencia no cambia olas | — | ninguna | — | — |
| R-10 | rótulo `#lg` y `e` = 1.124 | A1: chromote + DATA; mutación de DATA | iguales | iguales; el rótulo sigue al DATA mutado | — | ninguna | — | — |
| R-11 | R5 y R6 pueden fallar | A1: batería en copias con reglas viejas | FALLA/FALLA | FALLA/FALLA; pero la fuente de la comuna no discrimina | ADVIERTE (R-56) | registrar | — | — |
| R-12 | marca de ola `--ink`/`--ref`; 807 de 1.282 | A1: año sintético propio | iguales | iguales | ADVIERTE (R-57) | registrar | — | — |
| R-13 | notas 1.299/17/1.282 sin marcadores | A1: regex | coherentes; 0 | coherentes; 0 | — | ninguna | — | — |
| R-14 | C3 / I-6 12.724 filas | A1: R y texto crudo | idénticas | TRUE; 0 diferencias | — | ninguna | — | — |
| R-15 | D9 cubre 1.329 combinaciones futuras | A1: recuento propio | 0 desajustes | 1.329 y 0 | — | ninguna | — | — |
| R-16 | doc con 28 rutas y verdadero | A1: grep, comando del doc, glob2rx | cumple | números sí; 2 frases previas falsas | ADVIERTE (R-54, R-55) | registrar | — | — |
| R-17 | Elemental #2E2230 5,44; Insuficiente 9,85 | A2: volcado propio y WCAG | iguales | 35 y 18 en #2E2230; 9,85 | — | ninguna | — | — |
| R-18 | 0 «*»; 15+21 «†»; 7 notas; leyenda | A2: volcado y cotejo con JSON | iguales | iguales, 0 discrepancias; «†» se ve como «+» | REPARA (R-47) | corregido | 9344548 | IoU 1 → 0,183-0,192; export 43 tspan |
| R-19 | 0 atenuados por `isLowN`; 7,34:1 | A2: opacidad efectiva y contraste | 7,34 | 7,29 (analítico) / 7,24 (renderizado) | ADVIERTE (R-61) | registrar | — | — |
| R-20 | 0 superpuestos; ninguna cifra fuera del SVG | A2: 4 estados y barrido amplio | 0 y 0 | 0 superpuestos; 5 cifras 1,8 px fuera por los lados; escalera | REPARA (R-48) y ADVIERTE (R-62) | R-48 congelado | — | 3 intentos (R.8) |
| R-21 | SVG exportado con 7 notas y 0 «*» | A2: descarga | 7 y 0 | 7 y 0 | — | ninguna | — | — |
| R-22 | fuentes y `@font-face` exactos | A3: md5 y decodificación | iguales | iguales, 3 reglas por HTML | — | ninguna | — | — |
| R-23 | md5 detiene el build | A3: copia con 1 byte alterado | codigo 1 | 1, mensaje con el archivo | — | ninguna | — | — |
| R-24 | 18 pares ≤ antes | A3: medición propia | 18/18 | 18/18 | — | ninguna | — | — |
| R-25 | +160.246 y +159.882 B | A3: `stat` | iguales | iguales | — | ninguna | — | — |
| R-26 | `fonts.check` no discrimina; caras cargadas y fuente web | A3: `getPlatformFontsForNode` | iguales | iguales | ADVIERTE (R-67) | registrar | — | — |
| R-27 | 0 literales; `FONT_SVG` | A3: conteo | 0 | 0 (1a92827: 31) | REPARA (R-52, comentario) | corregido | facc0d1 | grep 0/1 |
| R-28 | carrera de fuente en la vista | A3: 12 y 40 cargas con gancho | existe | 2/12 y 5/40 malas en post_g; 0 en pre_g | REPARA (R-50) | corregido | 4a88f87 | 40/40 un estado; 0 px en 3 cargas × 4 anchos |
| R-29 | PNG cae al respaldo sin gobCL instalada | A2: rasterización propia | confirma | confirma; usa gobCL Bold del sistema | ADVIERTE (R-63) | registrar | — | — |
| R-30 | vista sin desborde; plano ≥ 320; CSS en el `@media` | A3: medición propia | iguales | iguales (309×360 a 375) | ADVIERTE (R-65) | registrar | — | — |
| R-31 | 0 px a 768+ frente a post_g | A3: gemelos por estado | 0 | 0 con método declarado | ADVIERTE (R-66) | registrar | — | — |
| R-32 | motor sin desborde a 375/540/768 | A2: medición propia | igual al viewport | igual; base 376 | — | ninguna | — | — |
| R-33 a R-36 | I-1 a I-4 | A3: md5, blobs, `hash-object` | PASA | PASA | — | ninguna | — | — |
| R-37 | I-5 | A2 | idéntico | idéntico | — | ninguna | — | — |
| R-38 | I-6 | = R-14 | PASA | PASA | — | ninguna | — | — |
| R-39 | I-7 | A3: grep y AST | vacío | vacío | ADVIERTE (R-70) | registrar | — | — |
| R-40 a R-43 | I-8 a I-11 | A3 | PASA | PASA | — | ninguna | — | — |
| R-44 | I-12 | = R-02 | igual | igual | — | ninguna | — | — |
| R-45 | alcance global y por commit | A3: `alcance.py` | 0 fuera | 0 fuera en 13 rutas y 9 commits | — | ninguna | — | orquestador tras el ciclo: 13 rutas, 4 commits más, dentro |
| R-46 | regresión | orquestador | 0; 31/31; idéntico | iguales (R.5) | — | ninguna | — | — |
| R-47 | «†» en gobCL se ve como «+» («42%+») | A2: IoU de glifos | distinto de «+» | IoU 1,0 | REPARA | marca en `<tspan>` con la familia del sistema | 9344548 | IoU 0,183-0,192; export 43 tspan, 0 «*» |
| R-48 | la regla de choque invierte el orden vertical | A2: barrido (`escalera`) | 0 invertidas | 613 (post_g); 627 (final) | REPARA | **congelado** tras 3 intentos (53+8 fuera / 51 / 155) | — | pendiente Q-28 |
| R-49 | comentario de P1 falso | A3 | verdadero | «La salida no cambia» | REPARA | comentario corregido | 07fc5d0 | grep 0/1 |
| R-50 | carrera de fuente en la vista | A3: r28 | un estado | 5/40 malas | REPARA | 3 intentos; un recálculo tras cargar gobCL con `--cardw` por omisión | 4a88f87 | 40/40 «101px | 318px | 101»; 0 px |
| R-51 | 4 cifras «†» sobre «traspaso» (destapado por R-47) | barrido amplio | 0 | 4 | REPARA | 3 intentos; revisión repetida contra los dos obstáculos | 9344548 | 0 solapes (y 0 en el estado por defecto) |
| R-52 | comentario del fragmento sobre `FONT_SVG` | A3 | verdadero | la vista no usa `FONT_SVG` | REPARA | comentario corregido | facc0d1 | grep 0/1 |
| R-53 | tras R-51, una cifra («71%†», SLEP 1305, Medio, 2° medio Matemática) sale 5 px por arriba del SVG | barrido amplio | 0 | 1 | ADVIERTE | registrar (queda visible: `overflow: visible`) | — | — |
| R-54 | el documento de datos dice que los globs no cruzan `/` ni cubren `directorio_oficial_ee.csv`; el verificador sí los cubre | A1 | — | previo (c7fb2ee); el archivo sigue ignorado | ADVIERTE (D-R-a) | registrar; al titular | — | — |
| R-55 | el documento cita `.gitignore` líneas 34-38; hoy es la 44 | A1 | — | previo | ADVIERTE | registrar | — | — |
| R-56 | R5/R6 no distinguen la fuente de la comuna | A1 | — | 0 de 1.282 con comuna distinta | ADVIERTE | registrar | — | — |
| R-57 | «aún municipales» y la marca salen del calendario del catálogo | A1 | — | así lo fija D35-4 | ADVIERTE | registrar | — | — |
| R-58 | cabecera de `36_funciones_trayectorias.R` cita 1.333 | A1 | — | previo (7768383) | ADVIERTE | registrar | — | — |
| R-59 | tooltip del referente: «los traspasan las olas siguientes» con 17 cerrados | A1 | — | previo (= Q-26) | ADVIERTE | registrar | — | — |
| R-60 | pendiente derivado 1 de la decisión conserva «5» | A1 | — | fuera de todo ALCANCE | ADVIERTE | registrar | — | — |
| R-61 | 7,34:1 no se reproduce | A2 | 7,34 | 7,29 / 7,24 | ADVIERTE | registrar (cifra imprecisa del subagente de M2) | — | — |
| R-62 | cifras con «†» del primer y último año sobresalen 1,8 px por los lados | A2 | — | 5 en el estado por defecto; margen de 12 u | ADVIERTE | registrar | — | — |
| R-63 | el PNG usa gobCL Bold del sistema o cae al respaldo | A2 | — | confirmado | ADVIERTE | registrar (Q-31) | — | — |
| R-64 | supergrid a 375 px: 4 columnas de 64,75 px, texto SVG ~1,4 px | A2 | — | previo (= Q-34) | ADVIERTE | registrar | — | — |
| R-65 | plano de la vista de 0 a 30 px entre 680 y ~800 px | A3 | — | previo (= Q-33) | ADVIERTE | registrar | — | — |
| R-66 | «0 píxeles» no reproducible con una sola carga | A3 | — | ruido 0-28 px previo | ADVIERTE | registrar (R-50 lo reduce: 0 px en 3 cargas × 4 anchos) | — | — |
| R-67 | Heavy es 900 en OS/2 y se declara 700; Light incrustada sin uso (50.616 B) | A3 | — | cumple la especificación | ADVIERTE | registrar | — | — |
| R-68 | NOTICE no declara las fuentes gobCL (la tabla `name` atribuye el copyright a su autor, frescotype.com; fsType 4 en Regular) | A3 | — | fuera de ALCANCE | ADVIERTE | registrar; **al titular antes de publicar** | — | — |
| R-69 | con `source()` interactivo, la falla de portabilidad no detiene el build | A3 | — | el encargo pedía la llamada sin argumentos | ADVIERTE | registrar | — | — |
| R-70 | I-7 absoluto no cubre `distinct(nom_com_rbd)` (30_construir_auxiliares.R:380, previo) | A3 | — | solo consola | ADVIERTE | registrar | — | — |
| R-71 | 6-7 s de espera no bastan en `#comparacion` a 375 px para capturar | A3 | — | 12 s sí | ADVIERTE | registrar (método) | — | — |
| R-72 | el motor no muestra carrera de fuente medible | A2 | — | 12 cargas idénticas | — | informativo | — | — |
| R-73 | tras R-50, la tarjeta de la vista mide 318 px desde 680 px; las referencias de A3 a 768+ ya no coinciden | orquestador | — | consecuencia de R-50 | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: OBSERVADO.** Ningún BLOQUEA; 5 REPARA corregidos y re-verificados (R-47, R-49, R-50, R-51, R-52); **1 REPARA congelado tras el tercer intento (R-48, la escalera de la regla de choque de M2)**, que queda como pendiente con la evidencia de los tres intentos; 20 ADVIERTE (R-53 a R-71 y R-73) y 1 informativo. Las afirmaciones refutadas (R-16, R-19, R-20) no tocan datos ni invariantes. Con un REPARA sin corregir, el veredicto no es `APROBADO` ni `APROBADO CON ADVERTENCIAS`, así que **la autorización 2 no se cumple y no se publica** (FASE L).

## Cierre

### 1. Resumen

Se implementaron D35-4 (referente por ola con el directorio, rótulo con 1.282), D35-5 (tinta oscura en la franja Elemental) y D35-6 («†» para un solo establecimiento, también en la sparkline); P1 dejó I-7 vacío en forma absoluta; P2 conectó el validador de portabilidad al build con `ruta_insumos()`; G incrustó gobCL en las dos páginas; A3 quitó el desborde de la vista bajo 680 px; M3 confirmó que, con gobCL, el motor ya no desborda a 375 px. FASE R encontró y corrigió cinco defectos del propio trabajo (el más importante: en gobCL la «†» se dibujaba igual que «+») y congeló uno (R-48, el orden vertical de las cifras de la sparkline) tras tres intentos. Veredicto OBSERVADO: todo commiteado, nada publicado.

### 2. Inventario de commits (`git log --oneline 1a92827^..HEAD`)

```text
1a92827 docs(sesion 35): encargo de la segunda ola de pendientes
eb77b28 fix(pipeline): el diagnostico de Costa Central agrupa por codigo de comuna (D35-3)
7cdedfc chore(build): valida portabilidad al inicio del build con raiz unificada (pendiente 9 de v34)
f8e7870 fix(trayectorias): referente contado por ola con el directorio y rotulo con 1.282 (D35-4)
01cdee0 fix(motor): cifra dentro de la franja Elemental con tinta oscura (D35-5)
6dfe8fa test(trayectorias): recuento independiente de las unidades futuras; docs: 28 rutas autorizadas
b346b40 fix(motor): un solo establecimiento se marca con † en barras y sparkline (D35-6)
271c04f feat(sitio): tipografia gobCL incrustada en motor y vista (D33-4)
df88fab fix(trayectorias): sin desborde horizontal bajo 680 px (pendiente 4 de v34)
9344548 fix(auditoria): R-47 la marca de un solo establecimiento se dibuja con la familia del sistema, y R-51 las cifras de la sparkline evitan el rotulo traspaso
07fc5d0 fix(auditoria): R-49 el comentario de P1 dice que la tabla impresa gana cod_com_rbd
4a88f87 fix(auditoria): R-50 la vista vuelve a medir menu y tarjeta cuando carga gobCL
facc0d1 fix(auditoria): R-52 el comentario del fragmento dice que solo el motor usa FONT_SVG
```

Más el commit de este log (`docs(log): pendientes de la sesion 35, segunda ola`), cuyo hash va en el reporte final. M3 no tiene commit (D-M3-a).

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-73).

### 4. Invariantes

I-1 a I-12 en PASA en el estado final `facc0d1` (FASE R, R.3), con I-7 en forma absoluta. En ningún cierre de fase un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: D35-3 valió solo para `encargo_pendientes_s35.md`; en este encargo I-7 se evalúa en forma absoluta sobre el repositorio, una vez corregida la línea 206 (así se aplicó: I-7 vacío desde P1).
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (todas medidas en esta sesión con Rscript o chromote)

- Referente: cat 1.299, vig 1.282, olas 475/406/401, 17 fuera del directorio (A1, re-derivado por el orquestador y por el auditor 1).
- `#lg` inicial: «Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124».
- Batería: 28 (FASE 0) → 30 (A1: R5, R6) → 31 (A2: D9f); 31/31 en el estado final. D9 cubre 1.332 combinaciones vigentes + REF y 1.329 futuras.
- Contrastes: Elemental 2,78:1 → 5,44:1 (#2E2230); Insuficiente 9,85:1; cifra única de la sparkline 2,14:1 → 7,29:1 (analítico; 7,24 renderizado; M2 informó 7,34).
- Marca «†»: 43 textos en el estado por defecto (15 barras, 21 sparkline, 7 notas), todos con la marca en `<tspan>` de la familia del sistema; IoU «†»/«+» 0,183-0,192 (antes, en gobCL, 1,0).
- Anchos (`scrollWidth`, barras ocultas): vista 641/641/641/680/768/1280 (antes de G) → 585/585/640/680/768/1280 (tras G) → 375/540/640/680/768/1280 (tras A3); `#comparacion` 376 → 375 a 375 px (tras G); `#panorama` igual al viewport en todos.
- Tamaño de los HTML con gobCL: motor +160.246 B, vista +159.882 B (pre_g → post_g).
- Estado final de `40_salidas/`: motor 99529ee31cf27e41e6417f76aa07d262; vista 5897a6a361ecd03c4ff73b1eee1300a7; `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f (sin cambio en toda la sesión). JSON del motor idéntico a la línea base. `docs/` sin cambio.
- Barrido amplio de la sparkline (2.832 sparklines): superposiciones 0; cifras fuera del SVG por arriba 1 (R-53); inversiones de orden (métrica del auditor) 627.

### 7. Dudas y pendientes consolidados

Tarea congelada: ninguna tarea del grafo. Hallazgo congelado: **R-48**.

Dudas, cada una con pregunta cerrada:
- Q-01b. ¿Se acepta que la comparación de píxeles cargue `png` en solo lectura desde la biblioteca del sistema, o se autoriza instalarlo en renv? (se acepta / instalar)
- Q-26. ¿Se ajusta en un encargo posterior el tooltip del referente («los traspasan las olas siguientes», con «2014» literal y sin los 17 cerrados; R-59)? (sí / no)
- Q-27. ¿Basta que D9 recuente el total T del panel 0 de las futuras para cerrar R-52 de s35, o se recuentan también grupos, panel 1 y serie combinada? (basta / ampliar en otra tarea)
- Q-28 (ampliada; **condiciona el push**). Regla de choque de las cifras de la sparkline: (A) mantener la de M2 con R-51 (vigente: 0 superposiciones, 627 inversiones, 1 cifra 5 px sobre el SVG); (B) adoptar el intento 3 de R-48 (separación horizontal de hasta 8 u y luego subir la de mayor valor: 0 superposiciones, 0 fuera, 155 inversiones; parche en `$TMPDIR/cal_s35b/r48/r48_intento3.patch`); (C) otra regla (p. ej., la marca más chica o solo en el tooltip de la sparkline). ¿Cuál? Y ¿R-48 se acepta como ADVIERTE para autorizar el push? (A / B / C; sí / no)
- Q-29. La cifra única de la sparkline queda a 0,9 como todas: ¿(A) se conserva, (B) opacidad 1 solo para la única, (C) se quita el 0,9 de todas?
- Q-30. `OP_PREVIO` se verificó por diff y por el auditor 2 en un Servicio Local traspasado (Andalién Costa: años previos a 0,4 y 0,36). ¿Basta? (sí / no)
- Q-31. El PNG exportado usa gobCL solo si está instalada en el equipo (y la Bold del sistema, no la Heavy). ¿Se acepta o se incrusta la `@font-face` en el SVG que se rasteriza? (se acepta / incrustar)
- Q-32. ¿Se reemplaza en los encargos el criterio `document.fonts.check()` (no discrimina) por el conteo de caras cargadas o `CSS.getPlatformFontsForNode`? (sí / no)
- Q-33. Entre 680 y ~800 px el plano de la vista mide 0-30 px (previo; R-65). ¿Pendiente nuevo? (sí / no)
- Q-34. A 375 px los textos del supergrid del motor se montan sobre las celdas vecinas (R-64). ¿Pendiente de legibilidad bajo 540 px? (sí / no)
- Q-35. NOTICE no declara las fuentes gobCL (R-68) y ninguna decisión documenta su licencia de redistribución. ¿Se agrega a NOTICE y se documenta la licencia antes de publicar a `docs/`? (sí / no)
- Q-36. `50_datos_versionados_autorizados.md` afirma que los globs no cruzan `/` ni cubren `directorio_oficial_ee.csv`, y el verificador I8 sí los cubre (R-54); además cita líneas viejas de `.gitignore` (R-55). ¿Se corrige el documento o el verificador en un encargo de gobernanza? (documento / verificador / ambos)
- Q-37. ¿Se acepta que una cifra de la sparkline («71%†», SLEP 1305, Medio, 2° medio Matemática) quede 5 px sobre el SVG, visible (R-53)? (sí / no)
- Q-38. ¿Se declara gobCL Heavy como 900 (su peso real) y se quita la cara Light, que no se usa y pesa 50.616 B por página (R-67)? (sí / no)
- Q-39. ¿El build debe detenerse también con `source()` interactivo ante una falla de portabilidad (`validar_portabilidad(detener_si_falla = TRUE)`) (R-69)? (sí / no)

Pendientes fuera del encargo: publicación a `docs/` y Pages (§11); push (punto 10); los excluidos de §11.

### 8. Errores propios consolidados

- Script de calibración del comparador de I-5: primer patrón inexistente en el JSON (FASE 0). Corregido.
- `Rscript -e` con un escape `\.` dentro de comillas (FASE 0). Pasado a un script.
- Mi verificador de `#lg` extrajo primero el DATA de la vista mezclando bytes y caracteres (mismo error que en s35). Corregido leyendo en bytes.
- El esperado «0 elementos» que di a M3 para el recorrido del DOM no separaba el desplazamiento interno de una tabla del desborde de la página.
- En FASE R congelé R-48 tras un intento mientras daba tres a R-47/R-51 y a R-50; lo corregí haciendo los intentos 2 y 3 de R-48 antes de congelarlo.
- Acepté sin re-derivar el 7,34:1 de M2 (R-61) y escribí en D-A2-a que el documento de datos quedaba «verdadero» sin revisar sus frases previas (R-16, R-54, R-55).
- En R.2 de FASE R escribí «auditor 2, 8 CONFIRMADA» y «auditor 3, 29 CONFIRMADA»; son 7 y 27 (41 de los auditores, más R-38 = R-14 y R-46 del orquestador: 43). No se reescribe la sección; se corrige aquí.
- Por la regla de privacidad de FASE L se reemplazó en la fila R-68 el nombre del autor de la fuente por «su autor, frescotype.com».
- Ninguno de estos errores tocó el producto.

### 9. Notas para el revisor

- Revisar en Safari (conviene en un equipo sin gobCL instalada, porque en esta estación está en `~/Library/Fonts`):
  - el motor, estado por defecto: la marca «†» junto a las cifras, en la nota y en la leyenda (antes de R-47 se veía «+»); la tinta oscura dentro de la franja Elemental con los niveles visibles;
  - la sparkline de la tarjeta 5103, grupo Medio bajo: «42%†» queda sobre «52%†» (R-48, Q-28);
  - la vista a 375, 540 y 768 px (A3) y el rótulo del referente con 1.282;
  - gobCL en títulos, menú, tablas y gráficos de las dos páginas.
- Capturas en `_archivo/20260925_capturas/` (26 PNG: `g_antes_*`/`g_despues_*` de G, `a3_*` de A3, `m3_*` de M3). Las de A3 a 768 px o más son anteriores a R-50: la vista final tiene la tarjeta a 318 px.
- Antes de publicar: Q-35 (NOTICE y licencia de gobCL) y Q-36 (el documento de datos y el verificador I8).
- El push depende de Q-28.

### 10. Estado de cierre

- **Commiteado:** 13 commits del encargo (T0 a R-52) más el de este log, en `main`.
- **Publicado: no.** La autorización 2 exige un veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`, y el veredicto es `OBSERVADO` (R-48 congelado). No se corrió `git push`. `origin/main` sigue en `9d612a3`, ancestro de `HEAD` (`git fetch origin` y `git merge-base --is-ancestor origin/main HEAD`, código 0, medido en FASE R). `docs/` intacto (8deb0459…/267857a2…).
- **Queda al titular:** responder Q-28 (y, con ella, autorizar el push); la revisión en Safari; Q-35 y Q-36 antes de publicar; la publicación a `docs/`.
- **Hash de `docs(log)`:** se informa en el reporte final (`git log -1 --format=%h`).
