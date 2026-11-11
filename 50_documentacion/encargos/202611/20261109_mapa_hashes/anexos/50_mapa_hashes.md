# Mapa de hashes de las reescrituras del historial

El historial de `main` se reescribió dos veces sin el mapa que exige `encargo_autonomo_claude_code_v1.md` §2.1 (v1.11); este archivo lo regulariza. Los documentos escritos antes de cada reescritura (traspasos, backlog, decisiones, logs de encargos) citan los hashes anteriores, y esos registros no se reescriben. Las tablas dan, para cada commit reescrito, su equivalente en `main`.

- **Uso:** un hash citado que `git cat-file -e <hash>` no resuelve se busca en la columna `hash_anterior` de las dos tablas; los hashes citados con más de 7 caracteres empiezan por el de la tabla.
- **Cómo se armó:** clon aparte del remoto, `git fetch` por SHA de los commits anteriores (GitHub los sigue sirviendo) y emparejamiento de las historias por fecha de autor y asunto, sin pares ambiguos.
- **Asuntos:** se transcriben como están en el historial; ningún asunto trae comillas invertidas.

## 1. Reescritura del 2026-11-04 (atribución a la herramienta)

Quitó de los mensajes las líneas de atribución (commit `d501236`, «commit_cierre tras quitar atribucion», que cambia `commit_cierre` de `dd01260` a `1db4d0a` en `ESTADO.md`). Conservó autor, fechas, asunto y contenido, y cambió el hash de cada commit desde el primero con atribución (2026-06-26) en adelante.

- La historia anterior se obtuvo desde `cf76515` (362 commits): 361 tienen par uno a uno en `main`, 84 con el mismo hash y 277 reescritos, que son las filas de esta tabla. Las 277 son exactamente los commits de `d9a485f^..12ddf5b`.
- **Sin par:** `cf76515` («docs(auditoria): auditoría integral del commit 7501446», 2026-10-02) vivía en otra rama; sus cuatro archivos de `auditorias/` no están en el árbol actual.
- **Sin hash anterior:** `a6c2eb0` («docs(encargos): migra el legado de encargos a historico», 2026-10-07) también se reescribió, pero su hash anterior no se pudo obtener.

| hash_anterior | hash_nuevo | asunto |
|---|---|---|
| `4d647df` | `d9a485f` | feat(motor): estado por defecto = 4 comunas SLEP Costa Central con dependencia SLEP |
| `f87a3f7` | `5642670` | docs(readme): quitar 'comunal' del subtitulo (el motor compara entidades de todo nivel) |
| `4ffbf63` | `c3a7bf8` | docs(traspaso): cierre sesion 23 (estado por defecto motor + auditoria suite) + escaner sellado |
| `16d731e` | `fb3ff44` | docs(estructura): sellar escaner al cierre de s23 (poda a retencion 2) |
| `8944c2e` | `fa0860b` | docs(backlog): anexar delta sesion 23 (entradas 117-120), cobertura 1-23 |
| `d4051d0` | `2d6068d` | docs(resena): version final de la resena (espejo de data.js orden 3) |
| `ef2aded` | `1929dc2` | docs(suite): retirar marcas REVISAR (voz) de documentar.R |
| `572324a` | `3bd88bc` | docs(backlog): normalizar tags a taxonomia canonica (D20-3) |
| `80b81b8` | `c2199d1` | docs(traspaso): cierre sesion 24 |
| `12eabee` | `b70074b` | docs(estado): agregar ESTADO.md (Fase 2 PUSH) destilado de traspaso_cierre_v24 |
| `0c70db0` | `6dff47d` | style(motor): renombrar "entidad" a "territorio" en texto UI y comentarios |
| `98d489f` | `37a632b` | build(motor): regenerar HTML con "territorio" |
| `c9841d8` | `906f89d` | docs: versionar POLITICA_PROYECTO.md |
| `1bec332` | `50e2095` | docs(motor): encargo y log de renombrado entidad->territorio |
| `8e4ee61` | `8931586` | docs(estructura): rotar snapshots |
| `54197f5` | `584a880` | fix(backlog): reparar truncamiento de 572324a (117-120) y anexar 121-128 |
| `a2376e3` | `ed6ef65` | Revert "fix(backlog): reparar truncamiento de 572324a (117-120) y anexar 121-128" |
| `42c6e40` | `6baa581` | fix(backlog): reparar truncamiento de 572324a (117-120) y anexar 121-128 |
| `d890c48` | `6fb04ab` | docs(traspaso): cierre sesion 25 (traspaso v25) |
| `d327420` | `9592013` | docs: eliminar POLITICA_PROYECTO.md duplicado obsoleto en raiz (v6, jun-12). Vigente: 50_documentacion/activa/POLITICA_PROYECTO.md (v5.2, jul-01). Cierra A-s25-4. |
| `bd71a25` | `d6911cf` | docs: renombrar backlog_historico.md a backlog_acumulativo.md (nombre canonico POLITICA v5.2 §10). Cierra A-s25-3. |
| `0136e2d` | `ecead6d` | docs: actualizar referencia a backlog_acumulativo.md en README (A-s25-3) |
| `7c0d9ef` | `92cbd5c` | chore: rotacion snapshot escaner (poda 2 sellos, apertura s26) |
| `0d43f0b` | `1980abf` | feat: historico pct adecuado ponderado, Costa Central, 4b/2m x lect/mate (sidequest s26) |
| `5cea954` | `06971e2` | docs: actualizar ESTADO.md v24->v26 |
| `b73e221` | `801ffa9` | docs: cierre sesion 26, backlog 129-133, traspaso v26 |
| `19a3c40` | `062cfc8` | docs(gobernanza): politica v5.5 y settings v14 |
| `5b79513` | `eb06cb7` | Merge pull request #1 from tomgc/gobernanza/v14 |
| `5dde691` | `863706e` | docs(gobernanza): actualiza POLITICA a v5.6 y SETTINGS a v16 (#2) |
| `4c7104d` | `551bd42` | portabilidad: fase 2 — deposita verificador y actualiza resolver |
| `62db485` | `1b979e5` | portabilidad: fase 3 — corrige rutas de maquina y declara excepciones |
| `5eda844` | `22ecd00` | portabilidad: fase 5 — configuracion por proyecto |
| `9886a64` | `7948bb3` | portabilidad: fase 4 — renv obligatorio |
| `22e0ed9` | `02df17a` | portabilidad: f4-correccion re-snapshot post-hidratacion |
| `6f0fa3f` | `1ff66bc` | portabilidad: verificacion V5 — repropaga la plantilla del verificador |
| `a1a1c20` | `06a15d8` | docs(normativos): POLITICA v5.7, SETTINGS v31, CLAUDE.md v3 |
| `4a8a8cb` | `5ff15a9` | fix(gobernanza): los normativos no se versionan en repo publico |
| `640635a` | `d38f5e7` | portabilidad: remediacion R1 — repropaga el verificador con el gate cerrado |
| `efc5516` | `39865e7` | portabilidad: remediacion R4 — repropaga el verificador con el sondeo de accesores |
| `272fb8f` | `6227255` | docs(estado): declara ventana_insumos (I9, SETTINGS v33) |
| `65302c6` | `b075f58` | chore(gobernanza): los normativos dejan de versionarse; copia local via .gitignore |
| `d1d04f6` | `524376c` | style(<script>): migra escala tipografica a variables CSS, piso 12px (patron ade) |
| `0da6096` | `5835cef` | docs(traspaso): cierre sesion 27 |
| `6a1c8b6` | `665a3a3` | docs(suite): corrige terminologia entidad->territorio en documentar.R; rota snapshots de estructura |
| `31e35d7` | `1fb636e` | docs(backlog): anexa delta s27, entradas 134-138 |
| `1ccb4d9` | `b1c4418` | chore(estado): destila v27 e instala campos de candado; abre sesion 28 |
| `7826f8e` | `7f3663a` | style(motor): migra escala tipografica a variables CSS, restaura .app-title a 30px |
| `d2f75ee` | `3bd7c54` | fix(motor): elimina duplicacion de la dependencia en el nombre del territorio |
| `712a9e5` | `a05ac14` | style(motor): homogeneiza rotulos de seccion, etiquetas GSE y leyenda de graficos |
| `c69335c` | `b3a0f3e` | fix(motor): evita desborde del nombre en la tabla y en la exportacion SVG |
| `51ed157` | `0a8ae70` | feat(motor): permite comparar hasta 5 territorios |
| `bfc1b89` | `9717a2b` | fix(motor): corrige quiebre del enlace de establecimientos, alinea el color con el nombre y concuerda el contador |
| `0fbc775` | `2e0e609` | fix(motor): el ancho del modal lo gobierna la fila de pestanas, no un maximo fijo |
| `9e8ecdd` | `986fba7` | fix(motor): elimina celdas de relleno del supergrid, obsoletas con la grilla dinamica |
| `a433839` | `b403d0c` | deploy(pages): publica motor con 5 territorios y correcciones visuales de s28 |
| `06d6586` | `993a89d` | docs(encargos): versiona encargo de homogeneidad y quinto territorio con su log |
| `c79a6ea` | `75c5353` | docs(encargos): versiona encargo de entorno y suite con su log |
| `9d28b5d` | `fbc2790` | docs(log): apenda reanudacion detenida por origen no publicado de suitedoc |
| `df52516` | `161fb66` | refactor(motor): escala tipografica del SVG en constantes JS nombradas |
| `89d2ac9` | `8cd42b0` | chore(motor): elimina constante y variables tipograficas sin uso |
| `12b7434` | `47ff1d8` | docs(encargos): versiona encargo de tipografia SVG con su log |
| `0871488` | `6aa0ca4` | chore(estructura): renombra el prototipo sin espacios en el nombre |
| `ec101b7` | `264a877` | docs(gobernanza): constancias de ordenacion del repositorio y de locale UTF-8 |
| `a340758` | `70d0cb6` | chore(estructura): rota snapshot del escaner tras la ordenacion |
| `f1ace49` | `afc05c4` | docs(encargos): versiona encargo de ordenacion con su log |
| `41f7026` | `0283967` | docs(gobernanza): criterios de diseno de ramas de detencion en encargos autonomos |
| `dbd729b` | `025647e` | deploy(pages): publica motor con la escala tipografica del SVG en constantes |
| `8503745` | `1e4395d` | fix(motor): el enlace de establecimientos se recorta en vez de desbordar la tarjeta |
| `a8386e6` | `b521d07` | fix(motor): la exportacion PNG avisa al fallar y ante superficie excesiva |
| `72372b0` | `ebd634e` | chore(motor): declara y advierte el truncamiento de la siembra por defecto |
| `c71d2dc` | `e00588d` | docs(encargos): versiona encargo de correcciones D1-D3 con su log |
| `64bab61` | `21f43f8` | deploy(pages): publica correcciones de enlace, exportacion PNG y siembra por defecto |
| `2ecad9d` | `ad61c87` | docs(log): medicion de insumos para el panorama territorial |
| `c1ed238` | `5841865` | docs(log): apenda medicion de marca y agregacion por tipo de territorio |
| `c7fb2ee` | `a9efa2a` | docs(gobernanza): declara los datos publicos versionados autorizados (I8) |
| `a441c98` | `1d1dd63` | docs(backlog): normaliza la estructura a las cinco secciones de POLITICA 10 |
| `542088c` | `fd0b207` | docs(log): log de la normalizacion del backlog |
| `3ac607d` | `602f482` | docs(cierre): traspaso v28, backlog y estado de sesion |
| `5306df2` | `d3ff09c` | docs(cierre): log de cierre v28 |
| `90bd736` | `60d015b` | docs(encargos): reubica el encargo de normalizacion a activa/encargos |
| `6de714a` | `7e70604` | chore(estado): corrige commit_cierre a 5306df2 y abre sesion v29 en MacBook-Pro-de-Tomas |
| `b93e9eb` | `1fd5f21` | feat(motor): panorama territorial con GSE combinado y encabezado tipo IDPS |
| `cab5b47` | `e744799` | chore(motor): elimina el computo muerto de sembradas fuera del aviso |
| `b56f75e` | `d82f9e9` | style(motor): escribe los rotulos en su caja tipografica y elimina text-transform |
| `1793619` | `838e265` | deploy(docs): publica el motor con el panorama territorial |
| `2e75100` | `bbecf70` | docs(gobernanza): incorpora A-s28-6 al diseno de ramas de deteccion |
| `4f68d4b` | `dc71510` | docs(decisiones): declara el ID D-color-nivel y corrige el tope al valor medido |
| `6a706fe` | `134fc83` | docs(encargos): versiona el encargo de pendientes inmediatos con su log |
| `4e8f946` | `8fd751d` | docs(gobernanza): registra las reincidencias de la sesion 29 y anade las reglas 10 y 11 |
| `3b256e6` | `6d25c70` | fix(motor): rescata bajo el eje el porcentaje de las franjas delgadas del panorama |
| `abf98c6` | `e021bb8` | deploy(docs): publica el rescate de rotulos del panorama |
| `a668951` | `82a66ea` | docs(encargos): versiona los encargos de verificacion y rescate con sus logs |
| `04d9523` | `2c0537d` | fix(motor): incluye la composicion del territorio en las dependencias de los memos del panorama |
| `d4e3017` | `1d3615a` | fix(motor): corrige la seleccion unica, reordena el selector sobre el banner y elimina mayusculas sostenidas |
| `3b17b9b` | `bb9bfca` | deploy(docs): publica el reorden del selector, los nombres propios y la seleccion unica |
| `f4d7920` | `bbeff93` | docs(cierre): traspaso v29, backlog y estado de sesion |
| `f7279eb` | `d63b04a` | docs(cierre): log de cierre v29 |
| `b4902ab` | `de7c37b` | chore(sesion 30): trabajo de la sesion |
| `4cdfb0e` | `3b7593d` | docs(cierre): traspaso v30 y backlog de sesion |
| `6ba5bb2` | `ecdabca` | docs(cierre): aplica rotulo R3 (cobertura) omitido en el commit de documentacion v30 |
| `9c6671c` | `26ba468` | docs(cierre): log de cierre v30 |
| `24cff4e` | `c3dc1c5` | docs(cierre): estado de sesion v30 |
| `9908180` | `1e428cc` | chore(estado): abre sesion en MacBook-Pro-de-Tomas.local |
| `2ab9927` | `850a653` | docs(diseno): regla 12 y A29-4, el alcance del instrumento iguala el de la afirmación |
| `65e5e4a` | `e0aa709` | chore(vendor): React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 en 10_utils (s31) |
| `bb53c8c` | `c4114df` | docs(log): retiro de unpkg.com con transpilación en el build |
| `02daaf7` | `ae831eb` | feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31) |
| `cd061a6` | `748f8a8` | docs(log): cierre de T2 del retiro de unpkg.com |
| `005753c` | `6e6fb30` | docs(errores): ERR-31-06 del redactor |
| `232960c` | `a31639e` | deploy(docs): publica el motor sin dependencias de red (s31) |
| `9bad097` | `bb97bb8` | data(simce): bases 2025 finales (v22025) en lugar de las preliminares, archivadas fuera de git |
| `49185eb` | `e77a419` | docs(log): bases Simce 2025 finales |
| `44dfb07` | `88a44b0` | feat(motor): el año preliminar se deriva de los insumos; 2025 deja de marcarse (s31) |
| `6d715a5` | `ca8c135` | docs(errores): ERR-31-07 del redactor |
| `7e7b294` | `e7ec530` | deploy(docs): publica 2025 con la base final de la Agencia, sin marca de preliminar (s31) |
| `2a1debb` | `d9681af` | docs(errores): ERR-31-08 del redactor |
| `cdae5b8` | `9b3b6a5` | fix(motor): cifras de las barras recientes dentro de su franja solo si caben; si no, bajo el año (regla de slep_idps, s31) |
| `5608f9b` | `3d45668` | deploy(docs): publica el rotulado de barras con la regla de slep_idps (s31) |
| `88dc7af` | `c4d09d2` | fix(motor): la celda del SVG exportado cubre las barras y sus cifras rescatadas (s31) |
| `68f3f6d` | `5000a99` | chore(sesion 31): trabajo de la sesion |
| `47134bd` | `33216b0` | docs(cierre): traspaso v31 y backlog de sesion |
| `d6ea287` | `c659435` | docs(cierre): log de cierre v31 |
| `2b688d2` | `62e1d7c` | docs(cierre): estado de sesion v31 |
| `d510754` | `424c396` | chore(estado): abre sesion en MacBook-Pro-de-Tomas.local |
| `760ce01` | `109ea48` | docs(datos): autoriza contexto_simce.parquet de la rama feat/contrato-contexto (s32) |
| `801ce5e` | `73a73b2` | docs(log): traslado de la vista de trayectorias (s32) |
| `31d00b3` | `7f77628` | docs(log): adenda del traslado, redondeo entero (s32) |
| `7768383` | `9161a15` | feat(trayectorias): traslada la vista de trayectorias a 30_procesamiento, paso 36 (s32) |
| `4c5cc3a` | `0414480` | docs(log): reanudacion del traslado (s32) |
| `de739c3` | `5af81e1` | chore(sesion 32): trabajo de la sesion |
| `ab11c40` | `6ffbfba` | docs(cierre): traspaso v32 y backlog de sesion |
| `8fe8453` | `4d86b05` | docs(cierre): log de cierre v32 |
| `a71f443` | `2acef09` | docs(cierre): estado de sesion v32 |
| `562cfd8` | `ed30457` | chore(estado): abre sesion en MacBook-Pro-de-Tomas.local |
| `498981b` | `d74c6ab` | feat(trayectorias): regla de filas del motor y cifras de las notas desde los datos (s33) |
| `3de223d` | `1fd5d6e` | style(trayectorias): identidad visual del motor, encabezado y menu de vistas compartidos (s33) |
| `1d6c4ce` | `68aa078` | fix(trayectorias): diez defectos de forma de la vista y menus sin opciones vacias (s33) |
| `2098d65` | `97fd053` | chore(sesion 33): trabajo de la sesion |
| `d107f4d` | `d658403` | docs(cierre): traspaso v33 y backlog de sesion |
| `ce54db8` | `bb88d3e` | docs(cierre): log de cierre v33 |
| `e4dd005` | `16bd125` | docs(cierre): estado de sesion v33 |
| `8260a8a` | `a59486b` | chore(estado): abre sesion en MacBook-Pro-de-Tomas.local |
| `f47374c` | `2fa7e7b` | feat(motor): enlace a la vista de trayectorias y apertura del panorama con #panorama (D33-2, s34) |
| `cc7fd64` | `c5b748b` | deploy(docs): publica la vista de trayectorias y el menu con su enlace (s34) |
| `8b919df` | `f85e6c7` | feat(entorno): guarda de locale UTF-8 en 10_configuracion.R como punto de arranque comun (POLITICA 5.2bis, s34) |
| `a095a50` | `76a6fa5` | deploy(docs): motor y vista con el encabezado comun (s34) |
| `b919acf` | `d70e675` | refactor(sitio): encabezado y menu de vistas desde un fragmento comun insertado por los generadores 33 y 36 (s34) |
| `07b860c` | `0c891d1` | fix(motor): cifras de Elemental rescatadas bajo el año con tinta de 4,95:1 sobre blanco (pendiente 4, s34) |
| `50323ab` | `fe5c53d` | deploy(docs): motor con el contraste de las cifras rescatadas (s34) |
| `e629a8b` | `de241e1` | chore(sesion 34): trabajo de la sesion |
| `2c6d0e8` | `5c0e706` | docs(cierre): traspaso v34 y backlog de sesion |
| `880669f` | `ff188b0` | docs(cierre): log de cierre v34 |
| `4496d02` | `429f6e9` | docs(cierre): estado de sesion v34 |
| `b8c8e1a` | `dca74c8` | chore(estado): abre sesion en MacBook-Pro-de-Tomas.local |
| `f4bd59e` | `c23ee03` | docs(sesion 35): decisiones D35-1 y D35-2, contexto del referente, encargo y errores |
| `00a8cdd` | `69c1e17` | chore(repo): saca _archivo/ del índice (pendiente 11 de v34) |
| `34c6553` | `56cc4a8` | feat(trayectorias): cohortes futuras 2027-2029 con itinerario previo al traspaso (D35-2) |
| `5a0ec3f` | `f604d83` | fix(motor): un solo establecimiento se marca con asterisco y nota, sin atenuar (pendiente 2 de v34) |
| `6d7c757` | `ff15e28` | feat(insumos): catalogo de olas de traspaso desde slep_central_datos (D35-2) |
| `291093f` | `ef3a9e5` | feat(trayectorias): rotulo del referente y marca de ola (D35-1) |
| `5c0994b` | `61afcca` | fix(motor): notas metodologicas sin columna vacia (pendiente 5 de v34) |
| `84860ea` | `f01fc8f` | fix(motor): panorama sin desborde bajo 540 px (pendiente 6 de v34) |
| `dd7fe76` | `8a14e7f` | refactor(motor): quita CSS sin uso de la cabecera antigua |
| `f076470` | `2545457` | fix(auditoria): R-47 la vista no desborda entre 666 y 822 px con las cohortes futuras |
| `1150846` | `9c44209` | fix(auditoria): R-49 el comentario de la sparkline del motor dice que su cifra sigue atenuada |
| `9e83ecf` | `d7e31d7` | fix(auditoria): R-48 la nota de cohortes por traspasar se acota a las cohortes vigentes |
| `bfa40c9` | `495e069` | fix(auditoria): R-63 las cohortes por traspasar no dicen que administran sus establecimientos |
| `bd5fc58` | `3ab2c0b` | docs(log): pendientes de la sesion 35 |
| `9d612a3` | `f055d6e` | docs(sesion 35): D35-3 a D35-6 y correccion de cifras del referente; errores ERR-35-05 a ERR-35-11 |
| `1a92827` | `f2963fb` | docs(sesion 35): encargo de la segunda ola de pendientes |
| `eb77b28` | `f456ca5` | fix(pipeline): el diagnostico de Costa Central agrupa por codigo de comuna (D35-3) |
| `7cdedfc` | `14f99a9` | chore(build): valida portabilidad al inicio del build con raiz unificada (pendiente 9 de v34) |
| `01cdee0` | `80e24b6` | fix(motor): cifra dentro de la franja Elemental con tinta oscura (D35-5) |
| `f8e7870` | `3d2cbf1` | fix(trayectorias): referente contado por ola con el directorio y rotulo con 1.282 (D35-4) |
| `6dfe8fa` | `9d98cff` | test(trayectorias): recuento independiente de las unidades futuras; docs: 28 rutas autorizadas |
| `b346b40` | `cd69d61` | fix(motor): un solo establecimiento se marca con † en barras y sparkline (D35-6) |
| `271c04f` | `b1f268d` | feat(sitio): tipografia gobCL incrustada en motor y vista (D33-4) |
| `df88fab` | `863fcee` | fix(trayectorias): sin desborde horizontal bajo 680 px (pendiente 4 de v34) |
| `07fc5d0` | `3994892` | fix(auditoria): R-49 el comentario de P1 dice que la tabla impresa gana cod_com_rbd |
| `4a88f87` | `e21655f` | fix(auditoria): R-50 la vista vuelve a medir menu y tarjeta cuando carga gobCL |
| `9344548` | `95a557c` | fix(auditoria): R-47 la marca de un solo establecimiento se dibuja con la familia del sistema, y R-51 las cifras de la sparkline evitan el rotulo traspaso |
| `facc0d1` | `4d40acd` | fix(auditoria): R-52 el comentario del fragmento dice que solo el motor usa FONT_SVG |
| `5e65bd3` | `54b8439` | docs(log): pendientes de la sesion 35, segunda ola |
| `d1b6a43` | `f0c1cd0` | docs(sesion 35): decisiones D35-7 a D35-10, errores ERR-35-12 a ERR-35-15 y encargo de la tercera ola |
| `d900bb1` | `fb0d7f0` | docs(licencia): NOTICE declara la tipografia gobCL fuera de Apache 2.0 (D35-7) |
| `276a447` | `59beecb` | docs(gobernanza): datos autorizados precisa el alcance de sus globs (Q-36) |
| `41de233` | `ab02ba8` | feat(sitio): gobCL-sitio con Regular 400 y Bold 700; retira Light y Heavy (D35-9) |
| `674522d` | `4c7b2ad` | fix(motor): cifras de la sparkline ordenadas por valor, con ocultamiento de respaldo (D35-8, R-48) |
| `28caa7f` | `66a0843` | fix(trayectorias): tooltip del referente desde los datos (Q-26) |
| `86319b6` | `0208ecb` | fix(trayectorias): el plano no colapsa entre 680 y 800 px (Q-33) |
| `7273760` | `1f46907` | fix(auditoria): R-22 las cifras rescatadas de las barras apiladas no se tocan con gobCL-sitio |
| `e21038e` | `681ed59` | docs(log): pendientes de la sesion 35, tercera ola |
| `24a01a8` | `d3b4515` | docs(sesion 35): encargo de cierre de riesgos antes de publicar |
| `d16ef6e` | `958c760` | chore(repo): gobCL_Bold.otf sin modo ejecutable (Q-40) |
| `5e54b61` | `7b2aaae` | fix(motor): la sparkline vuelve a colocar sus cifras cuando carga gobCL-sitio (Q-48, R-46) |
| `b0f952d` | `d8abb99` | fix(motor): cifras rescatadas del panorama con paso medido (R-22) |
| `77017cd` | `a675053` | fix(trayectorias): el plano no colapsa en ventanas bajas (Q-44) |
| `7765547` | `48aa936` | fix(trayectorias): la tabla de las cohortes futuras cabe sin desplazarse (Q-46) |
| `f3c20cf` | `9d072b4` | fix(trayectorias): el año del ancla sale de los datos en las notas (Q-47, Q-45) |
| `b669874` | `6e43898` | docs(log): cierre de riesgos antes de publicar (s35d) |
| `41cd636` | `077dd0b` | deploy(docs): motor y vista de trayectorias de la sesion 35 |
| `c1e2047` | `dcf39aa` | docs(sesion 35): publicacion al dia y errores ERR-35-16 y ERR-35-17 |
| `476b1e1` | `e34f1d5` | fix(motor): el tooltip se ubica dentro de la ventana; encargo s35f y ERR-35-18 |
| `6f74d70` | `23164e2` | fix(motor): ajuste del tooltip tras la medicion (TT) |
| `fa89e7c` | `a5b121c` | fix(sitio): texto de los controles centrado opticamente con text-box (gobCL-sitio) |
| `2a719b1` | `fed876d` | deploy(docs): tooltip dentro de la ventana y centrado optico de los controles |
| `6c51362` | `bfe3ebd` | docs(log): tooltip y centrado optico (s35f) |
| `95469aa` | `79f3203` | docs(sesion 35): encargo de la septima ola (supports, cohortes, tooltip) |
| `50bb730` | `5486d35` | fix(sitio): el centrado optico solo aplica con soporte de text-box (Q-59) |
| `ba1b4be` | `ee5f840` | refactor(trayectorias): el texto de los botones de cohorte sale del generador (Q-58) |
| `c8964b6` | `5e68a3f` | fix(motor): a 375 px el tooltip no tapa el punto (Q-54) |
| `9ef4f2b` | `64cae97` | deploy(docs): centrado solo con text-box, cohortes desde R y tooltip angosto |
| `cefa729` | `ae47f96` | docs(log): supports, cohortes y tooltip angosto (s35g) |
| `b3cc432` | `bbf4a38` | docs(sesion 35): encargo de la octava ola y decisiones D35-11 a D35-13 |
| `df73a45` | `ef77194` | fix(motor): el modal de territorio cabe en pantallas angostas (Q-55) |
| `a653259` | `6d43461` | fix(motor): el supergrid se lee en pantallas angostas (Q-34, Q-43) |
| `52bab39` | `382b95e` | fix(motor): centrado optico de pestañas, campo, exportar y tooltip (Q-57) |
| `206cb3a` | `0b3607a` | fix(motor): el PNG exportado incrusta gobCL (Q-31) |
| `1458285` | `19888e1` | fix(trayectorias): la tarjeta se vuelve a medir al cambiar el ancho (Q-52) |
| `0f06bc8` | `7a1befe` | fix(trayectorias): una columna cuando la tarjeta deja el plano angosto (Q-51) |
| `78abd6b` | `f804dd2` | deploy(docs): pantallas angostas, centrado restante y PNG con gobCL |
| `000d31c` | `4e7f1e4` | docs(log): pantallas angostas, centrado restante y PNG (s35h) |
| `b150d57` | `2956b3d` | docs(log): P3 de s35h |
| `37737b5` | `ac8e3e3` | docs(sesion 35): encargo de la novena ola y decisiones D35-14 y D35-15 |
| `90542fb` | `5c1d1a5` | fix(build): la falla de portabilidad detiene el build tambien en modo interactivo (Q-39) |
| `14c9fb3` | `3001ecf` | test(trayectorias): la bateria cubre las cuatro familias de la auditoria de la sesion 30 (v30-5) |
| `0e4b544` | `73b1bc9` | fix(trayectorias): la tarjeta se mide igual sin importar la cohorte anterior (Q-65) |
| `0ec0d41` | `09eb288` | fix(motor): el supergrid usa su ancho minimo hasta que ningun nombre sale de su columna (Q-66) |
| `823e3d3` | `e9a609e` | deploy(docs): tarjeta por cohorte y corte del supergrid |
| `88070b3` | `be92e57` | fix(auditoria): R-32 FC1 cuenta el año y el total del conteo de la tarjeta |
| `9bae824` | `df6071b` | docs(log): bateria por familias, build, tarjeta y supergrid (s35i) |
| `40ac367` | `bd2f089` | docs(log): P3 de s35i |
| `c504ef8` | `7902ce7` | docs(sesion 35): encargo de la decima ola y decision D35-16 |
| `2db6266` | `aff0214` | docs(log): diagnostico de ramas y pendientes bloqueados (s35j) |
| `602ea3b` | `649b57f` | docs(sesion 35): encargo de la undecima ola y decisiones D35-17 a D35-19 |
| `1c1cd18` | `3c8e846` | docs(ramas): rescata el log del contrato y la suite standalone de gobernanza/v16 (D35-17) |
| `03c8c6a` | `a0bb264` | chore(renv): registra los paquetes de CRAN que faltaban y deja suitedoc fuera del lock (D35-18) |
| `184208a` | `ab8edaf` | refactor(pipeline): los anos y los rangos se derivan de los insumos (D35-19) |
| `4ac0433` | `33884cc` | docs(insumos): el manifiesto dice que los xlsx Simce se versionan (Q-72) |
| `10672ea` | `e12a129` | docs(log): ejecucion de las decisiones D35-17 a D35-19 (s35k) |
| `349f22d` | `fb3a756` | docs(log): verificaciones pendientes, bateria del motor y CLAUDE.md (s35l) |
| `b452b0a` | `8387c22` | docs(sesion 35): encargo de la duodecima ola y decision D35-20 |
| `29947ce` | `161c450` | fix(pipeline): la serie Simce debe empezar en ANIO_INICIO (Q-74) |
| `6efefc5` | `c2090f9` | refactor(config): años sin Simce en un solo lugar y textos sin rango fijo (Q-75) |
| `e41ee1e` | `d0a8611` | fix(trayectorias): el año inicial de la vista sale de los datos (R-41) |
| `611852a` | `06fe461` | test(motor): bateria versionada del motor con control positivo |
| `7ceccdb` | `719e92c` | fix(auditoria): R-42 la bateria del motor no suma una advertencia al validador |
| `0f419b4` | `a40d636` | docs(log): verificaciones pendientes, bateria del motor y CLAUDE.md (s35l, segunda emision) |
| `10512e4` | `f06c9b9` | docs(sesion 35): encargo de la decimotercera ola y decision D35-21 |
| `3cbb42c` | `f71c39d` | refactor(sitio): los años sin Simce de los textos visibles salen de ANIOS_SIN_SIMCE (Q-80) |
| `ed07558` | `c61c96e` | fix(auditoria): R-26 el encabezado del paso 33 nombra los años sin Simce |
| `9eb7e52` | `38fcaa9` | docs(log): textos de anos sin Simce desde la configuracion (s35m) |
| `9c38d5e` | `004024a` | docs(sesion 35): encargo de la decimocuarta ola y decisiones D35-22 y D35-23 |
| `f40bbfb` | `eb49621` | docs(suite): documentar.R describe el pipeline actual (Q-81) |
| `ba3671d` | `d2721cb` | docs(suite): regenera la suite con el pipeline actual |
| `9652cfc` | `ef41b43` | fix(auditoria): R-24 el manual nombra los cinco pasos que corre 00_build.R |
| `aa2a5f0` | `17674ef` | fix(auditoria): R-25 el insumo de 2 medio dice solo que la base 2025 es final |
| `88edc0f` | `48825ca` | fix(auditoria): R-26 los documentos generales no desbordan a 375 px |
| `a79242c` | `8e3cffc` | docs(log): suite de documentacion al dia (s35n) |
| `93f22ec` | `97aa5ed` | docs(sesion 35): encargo de la decimoquinta ola y decision D35-24 |
| `60ba5e2` | `4f67817` | docs(readme): README y comentarios al dia con el pipeline (Q-87) |
| `f8cadb2` | `3893c30` | docs(log): README y comentarios al dia (s35o) |
| `b80a6d5` | `9242979` | docs(sesion 35): encargo de la decimosexta ola y decision D35-25 |
| `9d8aa9e` | `3665d6d` | docs(readme): el bloque de portabilidad se mantiene a mano (Q-91) |
| `8dc85dc` | `acd5897` | docs(publicacion): regla del GSE acotada y las dos baterias antes de publicar (Q-92) |
| `00a1b4b` | `bc24b60` | docs(codigo): comentarios de 10_utils.R y del paso 30 al dia (Q-93) |
| `0836a50` | `4f5f7a8` | docs(activa): retira la documentacion de junio que reemplaza la suite (Q-94) |
| `8f10463` | `735db40` | docs(log): ultimos textos de documentacion al dia (s35p) |
| `f7e966a` | `c03e380` | docs(sesion 35): encargo de la decimoseptima ola y decision D35-26 |
| `d8ba99d` | `7c3bcdc` | docs(readme): quita los enlaces a la documentacion de junio archivada (Q-97) |
| `43aede2` | `95c44aa` | docs(entorno): .Renviron.example sin la raiz de datos que el proyecto no usa (Q-95) |
| `a238458` | `8a3df93` | fix(pipeline): el paso 30 valida la columna COD_DEPE del directorio (Q-98) |
| `6944cc7` | `c83d794` | docs(log): enlaces del README, Renviron y COD_DEPE (s35q) |
| `789ba3c` | `cd719ea` | docs(sesion 35): decision D35-27 |
| `3defff8` | `37f88a5` | docs(cierre): traspaso v35 y backlog de sesion |
| `dd01260` | `1db4d0a` | docs(cierre): log de cierre v35 |
| `7501446` | `12ddf5b` | docs(cierre): estado de sesion v35 |

## 2. Rebase del 2026-08-24 (commits del 2026-07-01)

Los siete commits del 2026-07-01 se rehicieron el 2026-08-24 (fecha de commit del 2026-08-24 sobre fecha de autor del 2026-07-01) y volvieron a cambiar de hash en la reescritura del 2026-11-04; la tabla da directamente el hash actual.

- **Sin par en `main`:** `6e00830` y `31befa2` (2026-07-11, `feat(contexto)`, rama `feat/contrato-contexto`, no integrada); `e86b0d2` («docs(gobernanza): actualiza POLITICA a v5.6 y SETTINGS a v16», 2026-08-01) entró por squash como `863706e` (PR #2).

| hash_anterior | hash_nuevo | asunto |
|---|---|---|
| `7ec8461` | `9592013` | docs: eliminar POLITICA_PROYECTO.md duplicado obsoleto en raiz (v6, jun-12). Vigente: 50_documentacion/activa/POLITICA_PROYECTO.md (v5.2, jul-01). Cierra A-s25-4. |
| `34d681d` | `d6911cf` | docs: renombrar backlog_historico.md a backlog_acumulativo.md (nombre canonico POLITICA v5.2 §10). Cierra A-s25-3. |
| `7af874c` | `ecead6d` | docs: actualizar referencia a backlog_acumulativo.md en README (A-s25-3) |
| `f9d8863` | `92cbd5c` | chore: rotacion snapshot escaner (poda 2 sellos, apertura s26) |
| `6a13f3e` | `1980abf` | feat: historico pct adecuado ponderado, Costa Central, 4b/2m x lect/mate (sidequest s26) |
| `98c3f6a` | `06971e2` | docs: actualizar ESTADO.md v24->v26 |
| `b9426c2` | `801ffa9` | docs: cierre sesion 26, backlog 129-133, traspaso v26 |
