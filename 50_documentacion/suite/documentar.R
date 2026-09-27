# documentar.R — genera la suite de documentación de "slep_simce_adecuado"
# ----------------------------------------------------------------------------
#   source(here::here("50_documentacion", "suite", "documentar.R"))   # Positron
#
# Produce 4 HTML standalone en 50_documentacion/suite/ (copia además el tema:
# CSS, fonts y assets; git ignora fonts/ y assets/). Con standalone = TRUE el
# tema y los íconos van incrustados y los HTML enlazados intermedios se borran:
#   arquitectura_slep_simce_adecuado_standalone.html            (esquema técnico)
#   documentacion_proyecto_slep_simce_adecuado_standalone.html  (manual del proyecto)
#   arquitectura_general_slep_simce_adecuado_standalone.html    (línea de producción)
#   documentacion_general_slep_simce_adecuado_standalone.html   (guía sin tecnicismos)
#
# La cfg se construye desde cero (no parte de cfg_ejemplo()) para garantizar
# cero residuos. Se usa verificar = FALSE de forma permanente en este proyecto:
# el ejemplo de fábrica de suitedoc (también en 0.5.1) está basado en un
# proyecto Simce, así que el verificador marca como "residuo" términos
# legítimos y obligados de este proyecto (simce, nalu, palu_eda, adecuado,
# slep_simce_adecuado, motor_comparacion). No son residuos: son el contenido
# real.
#
# Versión: corre con suitedoc 0.5.1, el de la biblioteca de renv del proyecto
# (Rscript desde la raíz, o Positron con renv activo); fuera de renv se cargaría
# el 0.3.0 del sistema. suitedoc queda fuera de renv.lock (D35-18). Para los
# íconos, inlinar_suite() corre `npm pack lucide-static@1.21.0`: generar la
# suite requiere npm y red, pero los HTML que produce no cargan nada por red.
#
# Anclaje robusto de here (permite correr vía Rscript sin depender del cwd):
here::i_am("50_documentacion/suite/documentar.R")
#
# Convención del proyecto: paquetes prefijados, here::here() para rutas.
#

# REVISAR (decisión): las marcadas así infieren el "por_que" desde traspaso /
# README / política; confirma contra el archivo de decisión original.
# ----------------------------------------------------------------------------

cfg <- list(

  # ---- 1.1 Identidad del proyecto -------------------------------------------
  slug        = "slep_simce_adecuado",
  institucion = "SLEP Costa Central",
  area        = "Área de Monitoreo y Seguimiento",
  fuente      = "Datos públicos de la Agencia de Calidad de la Educación",

  salida_dir  = ".",
  css_href    = "suite_estilos.css",
  logo_href   = "assets/logo-white-stacked.png",

  # Las cuatro comunas del SLEP Costa Central.
  comunas = list(
    list(nombre = "Concón",      bg = "var(--mk-red)"),
    list(nombre = "Puchuncaví",  bg = "var(--mk-yellow)", fg = "var(--ink)"),
    list(nombre = "Quintero",    bg = "var(--mk-green)"),
    list(nombre = "Viña del Mar",bg = "var(--mk-blue)")
  ),

  # ---- 1.2 Textos de cabecera por documento ---------------------------------
  cab = list(
    arq_tec = list(
      eyebrow = "Esquema de arquitectura · Versión técnica",
      h1      = "Arquitectura del proyecto",
      mono    = "slep_simce_adecuado",
      tagline = "Motor de comparación comunal de resultados Simce por estándares de aprendizaje, con foco en el <strong>% ponderado de estudiantes en nivel Adecuado</strong> (con desglose opcional Adecuado · Elemental · Insuficiente). Agregación <strong>ponderada por número de evaluados</strong>, siempre <strong>segmentada por grupo socioeconómico (GSE)</strong>, separando 4° básico y 2° medio, y Lectura de Matemática. Pipeline R (Positron) &rarr; dos HTML autocontenidos y sin red, el motor (React + D3) y la vista de trayectorias de los Servicios Locales · datos públicos de la Agencia de Calidad · publicados en GitHub Pages.",
      metas   = list(
        list(c="var(--ocean)", k="Lenguaje", v="R"),
        list(c="var(--coral)", k="Salida",   v="dos HTML autocontenidos"),
        list(c="var(--olive)", k="Cobertura",v="desde 2014 (sin 2019–2021) hasta el último año cargado"),
        list(c="var(--sand)",  k="Niveles",  v="4° básico · 2° medio")
      )
    ),
    doc_tec = list(
      eyebrow = "Documentación del proyecto · Versión técnica completa",
      h1      = "Manual del proyecto",
      mono    = "slep_simce_adecuado",
      tagline = "Presentación de punta a punta: qué problema resuelve, qué conceptos usa, cómo se construye y qué decisiones metodológicas lo gobiernan. Pensado para que cualquier persona del equipo —o una sesión de IA— entienda el proyecto en su totalidad.",
      metas   = list(
        list(c="var(--ocean)", k="Área",   v="Monitoreo y Seguimiento"),
        list(c="var(--olive)", k="Datos",  v="Agencia de Calidad (públicos)"),
        list(c="var(--coral)", k="Salida", v="motor_comparacion.html · trayectorias_traspasos.html")
      )
    ),
    arq_gen = list(
      eyebrow = "Esquema de arquitectura · Visión general",
      h1      = "Cómo se construye la herramienta",
      mono    = NULL,
      tagline = "De las planillas dispersas de la Agencia de Calidad a un tablero que se abre en el navegador, explicado como una línea de producción. Sin nombres de programas ni tecnicismos: solo qué entra, qué pasa en cada paso y qué sale.",
      metas   = list(
        list(c="var(--coral)", k="Para",            v="directivos, equipos y comunidad"),
        list(c="var(--olive)", k="Versión técnica", v="arquitectura_slep_simce_adecuado_standalone.html")
      )
    ),
    doc_gen = list(
      eyebrow = "Documentación del proyecto · Guía general",
      h1      = "Qué es la herramienta y cómo leerla",
      mono    = NULL,
      tagline = "Una guía breve y sin tecnicismos para entender qué muestra el comparador de resultados Simce por estándares de aprendizaje, qué se puede ver en él y en qué conviene fijarse al interpretarlo.",
      metas   = list(
        list(c="var(--coral)", k="Para",            v="directivos, docentes, apoderados y comunidad"),
        list(c="var(--olive)", k="Detalle técnico", v="documentacion_proyecto_slep_simce_adecuado_standalone.html")
      )
    )
  ),

  # ---- 1.3 Diagrama técnico: insumos, auxiliares, etapas ---------------------
  insumos = list(
    list(t='Simce · 4° básico', badge='9 xlsx',
         d='Resultados por establecimiento y año · desde 2014, sin 2019–2021, hasta el último año cargado<br><span class="code-sm">simce4bAAAA_rbd_(final|preliminar).xlsx</span><br>Lectura y Matemática · estándares Adecuado · Elemental · Insuficiente'),
    list(t='Simce · 2° medio', badge='9 xlsx',
         d='Resultados por establecimiento y año · desde 2014, sin 2019–2021, hasta el último año cargado<br><span class="code-sm">simce2mAAAA_rbd_(final|preliminar).xlsx</span><br>Mismo esquema que 4° básico · todos los años, 2025 incluido, son base final')
  ),
  auxiliares = list(
    list(t='directorio_oficial_ee.csv', badge='csv',
         d='Directorio oficial MINEDUC por RBD<br>comuna · región · dependencia (cod_depe2) · matrícula · estado<br><strong>Insumo externo, no versionado</strong> (se descarga de MINEDUC, D21-1); el pipeline usa solo columnas institucionales, nunca MRUN / RUT de persona natural / geo'),
    list(t='listado_slep_2026.xlsx', badge='xlsx',
         d='Listado oficial de SLEP por comuna<br>código · nombre · año de traspaso'),
    list(t='caracterizacion_establecimientos.xlsx', badge='xlsx',
         d='Caracterización de los establecimientos de Costa Central<br>nombre · IVE · emplazamiento · flag rinde_simce'),
    list(t='anexo_indicadores_simce.xlsx', badge='xlsx',
         d='Hoja <span class="code-sm">00_RBDs_no_SIMCE</span><br>RBDs que no rinden Simce (excluidos del flag)'),
    list(t='dim_slep_comunas.csv', badge='csv',
         d='Catálogo público de comunas por Servicio Local y año de traspaso (olas)<br>Copia versionada; origen, md5 y fecha en <span class="code-sm">manifiesto_insumos.md</span><br>Arma las cohortes por traspasar de la vista de trayectorias')
  ),
  aux_uses = c(
    '↘ <code>30_construir_auxiliares.R</code> catálogos territoriales y de establecimientos',
    '↘ <code>31_leer_normalizar.R</code> recuperación de comuna y dependencia por RBD',
    '↘ <code>establecimientos_chile.parquet</code> resolución de nombre, comuna y dependencia',
    '↘ <code>36_generar_trayectorias.R</code> cohortes por traspasar desde <code>dim_slep_comunas.csv</code> y el directorio'
  ),

  etapas = list(
    list(n=2, titulo='Construcción de auxiliares', sub='30_procesamiento/',
         head='<span class="code">30_construir_auxiliares.R</span> <span class="bg bg--r">R</span>',
         d='Lee el directorio oficial, el listado de SLEP y la caracterización de establecimientos<br>Construye los catálogos: <strong>comuna · SLEP · establecimiento</strong><br>Genera <span class="code-sm">comunas_chile.parquet</span> · <span class="code-sm">sleps_chile.parquet</span> · <span class="code-sm">establecimientos_chile.parquet</span> · <span class="code-sm">slep_cc_establecimientos.parquet</span><br>IDs (RBD, códigos de comuna) como <strong>character</strong> (preserva ceros a la izquierda)',
         flags=c('SLEP prospectivo (traspaso el año siguiente): RBDs aún municipales, incluidos y marcados','Solo establecimientos operativos con matrícula'),
         norm=list()),
    list(n=3, titulo='Lectura y normalización', sub='30_procesamiento/',
         head='<span class="code">31_leer_normalizar.R</span> <span class="bg bg--r">R</span>',
         d='Lee los xlsx de <span class="code-sm">20_insumos/simce/{4b,2m}/</span> (hoy 18, 9 años por nivel) por <strong>header</strong>, jamás por posición<br>Los años salen de los nombres de archivo y se validan contra <span class="code-sm">ANIO_INICIO</span> y <span class="code-sm">ANIOS_SIN_SIMCE</span> (<span class="code-sm">10_configuracion.R</span>): un año repetido, de más o faltante, distinto entre niveles o una serie que no empieza en <span class="code-sm">ANIO_INICIO</span> detienen el build<br>Normaliza el GSE de literales (<span class="code-sm">Bajo…Alto</span>) a códigos <span class="code-sm">1…5</span><br>Lleva a formato largo: una fila por <span class="code-sm">rbd × prueba × año × nivel</span><br>Recupera comuna y dependencia (<span class="code-sm">cod_depe2</span>) por RBD desde el directorio<br>Marca como <span class="code-sm">preliminar</span> los años leídos de un <span class="code-sm">*_preliminar.xlsx</span><br>Escribe &rarr; <strong>simce_rbd.parquet</strong>',
         flags=c('4° básico y 2° medio nunca se mezclan','Lectura y Matemática nunca se mezclan','Lectura por header, nunca por posición','Dependencia vigente del directorio aplicada a toda la serie'),
         norm=list(
           list(id='A1', tx='<strong>Sufijos de columna cruzados en 2018/4° básico:</strong> <span class="code-sm">simce4b2018</span> trae los sufijos como <span class="code-sm">_2m_</span> en lugar de <span class="code-sm">_4b_</span>. Se reescriben antes de la normalización general; la lectura por nombre hace el resto.'),
           list(id='A2', tx='<strong>Marca de supresión de la fuente:</strong> la columna <span class="code-sm">marca_&lt;prueba&gt;&lt;nivel&gt;_rbd</span> señala resultados suprimidos por la Agencia. Se conserva como <span class="code-sm">marca</span> y gobierna la exclusión de filas junto con el umbral de evaluados.'),
           list(id='A3', tx='<strong>cod_com_rbd con formato no canónico:</strong> en 2015/2° medio, 2015/4° básico y 2017/4° básico la columna trae códigos de 1 o 2 dígitos en vez de los 4 o 5 canónicos. Se detecta por archivo (más de la mitad de los códigos con menos de 4 dígitos) y se recupera el código correcto por RBD desde el directorio oficial (snapshot 2025).'),
           list(id='A4', tx='<strong>Códigos pre-Ñuble (Ley 21.033):</strong> antes de 2018 las comunas de la actual Región de Ñuble tenían códigos del Biobío (8401–8421). Los xlsx 2014, 2016 y 2017 los traen. Se retroaplican los códigos nuevos (16101–16207) en todos los años para preservar las series históricas sin saltos.')
         )),
    list(n=4, titulo='Agregación comunal', sub='30_procesamiento/',
         head='<span class="code">32_agregar_comunal.R</span> <span class="bg bg--r">R</span>',
         d='Agrega <span class="code-sm">simce_rbd</span> a <span class="code-sm">comuna × dependencia × GSE × prueba × nivel × año</span><br>Agregación <strong>ponderada por número de evaluados</strong> (jamás conteo simple de establecimientos)<br>Aplica el umbral MINEDUC y la marca de supresión antes de ponderar<br>Une nombre de comuna y región<br>Escribe &rarr; <strong>simce_comunal.parquet</strong>',
         flags=c('Ponderación por evaluados (nunca por establecimiento ni matrícula total)','GSE como dimensión inviolable de toda agregación','Establecimientos sin GSE clasificado: excluidos de la agregación'),
         norm=list()),
    list(n=5, titulo='Generación del motor', sub='30_procesamiento/',
         head='<span class="code">33_generar_html.R</span> <span class="bg bg--r">R</span> + <span class="code">33_motor_template.html</span> <span class="bg bg--html">HTML</span>',
         d='Serializa <span class="code-sm">simce_comunal</span> + <span class="code-sm">simce_rbd</span> + catálogos a <strong>JSON</strong> embebido (gzip + base64, descomprimido en cliente con pako)<br>Embebe <em>inline</em> <strong>D3 v7</strong>, <strong>pako</strong>, <strong>React 18.3.1</strong> y <strong>ReactDOM 18.3.1</strong>; los cuatro y <strong>Babel 7.29.0</strong> van vendorizados en <span class="code-sm">10_utils/</span>, y el build verifica el sha384 de React, ReactDOM y Babel<br>Transpila el JSX de la app <strong>en el build</strong>, con Babel dentro de <strong>V8</strong>: Babel no viaja y el HTML no carga nada por red<br>Encabezado, menú de vistas y tipografía gobCL incrustada (los .otf de <span class="code-sm">10_utils/fuentes/</span>) desde la fuente única del sitio (<span class="code-sm">33_fragmento_sitio.html</span>, compartida con la vista); los años del encabezado y de las notas salen de los datos y de <span class="code-sm">ANIOS_SIN_SIMCE</span><br>Escribe el HTML autocontenido &rarr; <strong>motor_comparacion.html</strong>',
         flags=c('JSON embebido y comprimido (portabilidad total)','Sin carga por red: bibliotecas inline y Babel solo en el build','El deploy a docs/index.html es manual: el pipeline no toca docs/'),
         norm=list()),
    list(n=6, titulo='Generación de la vista de trayectorias', sub='30_procesamiento/',
         head='<span class="code">36_generar_trayectorias.R</span> <span class="bg bg--r">R</span> + <span class="code">36_funciones_trayectorias.R</span> <span class="bg bg--r">R</span> + <span class="code">36_trayectorias_template.html</span> <span class="bg bg--html">HTML</span>',
         d='Lee <span class="code-sm">simce_rbd</span>, <span class="code-sm">sleps_chile</span>, <span class="code-sm">comunas_chile</span> y <span class="code-sm">establecimientos_chile</span>, más el catálogo de olas <span class="code-sm">dim_slep_comunas.csv</span><br>Muestra, por <strong>cohorte de traspaso</strong>, el itinerario anual de cada Servicio Local en un plano de <strong>% Adecuado</strong> (eje horizontal) y <strong>% Insuficiente</strong> (eje vertical), antes y después de su traspaso; describe trayectorias, no mide el efecto del traspaso<br><strong>Referente municipal</strong> anclado en 2014, el primer año de la serie: los establecimientos que ese año eran municipales y no figuran en el catálogo de Servicios Locales; una marca de ola señala el año en que una ola sale del grupo (D35-1)<br><strong>Cohortes 2027 a 2029</strong>: una unidad por Servicio Local y año de traspaso del catálogo de olas, con los establecimientos que el directorio registra como municipales en sus comunas; todo su itinerario es previo al traspaso (D35-2)<br>Misma regla de filas que el motor (sin marca de la Agencia y al menos 10 evaluados); las cifras de las notas metodológicas salen de los datos<br>Escritura atómica &rarr; <strong>trayectorias_traspasos.html</strong>',
         flags=c('Sin carga por red: el build se detiene si el HTML trae src o href a http','Mismo encabezado, menú y tipografía gobCL que el motor','Las cohortes por traspasar no tocan sleps_chile.parquet ni el motor'),
         norm=list())
  ),

  intermedios = list(
    list(t='simce_rbd.parquet',      d='Formato largo: una fila por<br><span class="code-sm">rbd × prueba × año × nivel</span><br>+ GSE, dependencia, evaluados y % por estándar'),
    list(t='simce_comunal.parquet',  d='Agregación ponderada<br><span class="code-sm">comuna × dependencia × GSE × prueba × nivel × año</span><br>con <span class="code-sm">pct_adecuado</span> y <span class="code-sm">n_estab</span>'),
    list(t='comunas / sleps / establecimientos', d='Catálogos territoriales<br><span class="code-sm">comunas_chile</span> · <span class="code-sm">sleps_chile</span> · <span class="code-sm">establecimientos_chile</span>')
  ),

  # ---- 1.4 Diccionario de datos ---------------------------------------------
  dic_crudos = list(
    list(campo='rbd', tipo='character', d='Rol Base de Datos: identificador único del establecimiento a nivel nacional.'),
    list(campo='cod_grupo', tipo='character', d='Grupo socioeconómico (GSE) del establecimiento, "1".."5" (Bajo a Alto). Años antiguos lo traen como literal; se normaliza a código.'),
    list(campo='cod_com_rbd', tipo='character', d='Código de comuna del establecimiento. Recuperado desde el directorio cuando el crudo trae formato no canónico (A3) o códigos pre-Ñuble (A4).'),
    list(campo='nalu_&lt;prueba&gt;&lt;nivel&gt;_rbd', tipo='integer', d='Número de estudiantes evaluados en esa prueba y nivel. Pondera la agregación.'),
    list(campo='palu_eda_ade / ele / ins', tipo='double', d='% de estudiantes del establecimiento en estándar Adecuado / Elemental / Insuficiente.'),
    list(campo='marca_&lt;prueba&gt;&lt;nivel&gt;_rbd', tipo='character', d='Marca de supresión de la Agencia (NA si el resultado es publicable).'),
    list(campo='cod_depe2', tipo='character', d='Dependencia agrupada (1..5), recuperada por RBD desde el directorio oficial. Es la dependencia vigente, aplicada a toda la serie.')
  ),
  dic_intermedios = list(
    list(campo='simce_rbd.parquet', tipo='parquet', d='Una fila por rbd × prueba × año × nivel, con GSE normalizado, dependencia recuperada, evaluados y % por estándar. Marca de supresión preservada para el filtrado aguas abajo.'),
    list(campo='simce_comunal.parquet', tipo='parquet', d='Agregación ponderada por evaluados a nivel comuna × dependencia (<code>cod_depe2</code>) × GSE × prueba × nivel × año, con <code>pct_adecuado/elemental/insuficiente</code>, <code>n_evaluados</code> y <code>n_estab</code>.'),
    list(campo='comunas_chile.parquet', tipo='parquet', d='Catálogo de comunas con su código, nombre y región (nombres de región canónicos).'),
    list(campo='sleps_chile.parquet', tipo='parquet', d='Catálogo de SLEP con sus comunas y RBDs, año de traspaso, e inclusión prospectiva (RBDs aún municipales del SLEP cuyo traspaso es el año siguiente).'),
    list(campo='establecimientos_chile.parquet', tipo='parquet', d='Directorio por RBD con nombre, comuna y dependencia (snapshot 2025). Fuente del popup "ver establecimientos" del motor y, en la vista de trayectorias, de las cohortes por traspasar y del conteo del referente.'),
    list(campo='slep_cc_establecimientos.parquet', tipo='parquet', d='Caracterización de los establecimientos de Costa Central (nombre, IVE, emplazamiento, flag rinde_simce).')
  ),

  # ---- 1.5 Decisiones metodológicas -----------------------------------------
  decisiones = list(
    list(id='', titulo='Agregación ponderada por número de evaluados',
         cuerpo='<p>El % de un territorio <strong>pondera por la cantidad de estudiantes evaluados</strong> de cada establecimiento; no es un conteo de establecimientos ni un promedio simple de porcentajes.</p><pre>% nivel = sum(nalu * palu_eda_&lt;nivel&gt; / 100) / sum(nalu) * 100</pre>',
         por_que='<strong>Por qué.</strong> El dato de cada establecimiento es una <em>proporción de estudiantes</em> en un estándar, calculada sobre su propio número de evaluados. La pregunta del proyecto es qué porcentaje de los <em>estudiantes</em> de un territorio alcanza el nivel Adecuado; promediar porcentajes sin ponderar daría el mismo peso a un establecimiento de 12 evaluados y a uno de 300, distorsionando la cifra. Ponderar por evaluados es la operación correcta para ese dato.'),
    list(id='', titulo='Segmentación por GSE inviolable',
         cuerpo='<p>Todo resultado se reporta <strong>por grupo socioeconómico (GSE)</strong>: Bajo · Medio bajo · Medio · Medio alto · Alto. No existe una cifra "sin GSE".</p>',
         por_que='<strong>Por qué.</strong> El Simce por estándares de aprendizaje <strong>no</strong> ajusta por el contexto socioeconómico del establecimiento. Comparar resultados en bruto entre territorios con composición socioeconómica distinta llevaría a conclusiones erróneas. Fijar el GSE como dimensión obligatoria garantiza que toda comparación sea entre establecimientos de contexto comparable.'),
    list(id='', titulo='Niveles y pruebas nunca se mezclan',
         cuerpo='<p>4° básico y 2° medio se cuentan y se muestran siempre por separado; Lectura y Matemática también.</p>',
         por_que='<strong>Por qué.</strong> Son universos de evaluación distintos (poblaciones, pruebas y escalas distintas). Combinarlos en una sola cifra produce un número sin interpretación posible. Cada nivel se grafica por los años realmente disponibles.'),
    list(id='', titulo='% Adecuado como indicador principal; desglose opcional',
         cuerpo='<p>El indicador rector es el <strong>% en nivel Adecuado</strong>. El motor permite desglosar la barra en los tres estándares (Adecuado · Elemental · Insuficiente); los tres se normalizan a 100 en el apilado.</p>',
         por_que='<strong>Por qué.</strong> El % Adecuado es el foco de seguimiento del área. El desglose se calcula con la misma ponderación, de modo que el % Adecuado es <strong>idéntico</strong> exista o no el desglose; Elemental e Insuficiente se reescalan solo para absorber el ±0,1 de redondeo de la fuente y que el apilado sume exactamente 100.'),
    list(id='', titulo='Filtros MINEDUC aplicados una sola vez, en R',
         cuerpo='<p>Se excluyen los establecimientos con <span class="inl">nalu &lt; 10</span> (umbral MINEDUC) y los que traen marca de supresión (<span class="inl">marca</span> no NA). El filtro se aplica en R, antes de serializar.</p>',
         por_que='<strong>Por qué.</strong> El motor consume el JSON sin poder reaplicar el umbral ni la marca (la marca no viaja al JSON). Si filas suprimidas o bajo el umbral llegaran al cliente, los porcentajes divergirían del resto del motor. Aplicar el filtro una sola vez, en la fuente, mantiene la coherencia de todas las vistas.'),
    list(id='', titulo='Dependencia vigente aplicada a toda la serie (SLEP)',
         cuerpo='<p>La dependencia de cada establecimiento es la <strong>actual</strong> (directorio oficial) y se aplica a toda su serie histórica. Un SLEP agrupa a sus establecimientos también en los años previos a su traspaso.</p>',
         por_que='<strong>Por qué.</strong> Permite leer la trayectoria de un territorio bajo su gestión actual de forma continua. Como las cifras previas al traspaso corresponden a la gestión municipal, <strong>no</strong> son atribuibles al SLEP: el motor lo advierte con un disclaimer cada vez que se selecciona dependencia SLEP, y los SLEP con traspaso el año siguiente se incluyen marcados como prospectivos.'),
    list(id='D-nombres', titulo='Establecimientos identificados por nombre (agregados públicos)',
         cuerpo='<p>El motor lista cada establecimiento con su <strong>nombre</strong> (<span class="inl">nom_rbd</span>), no solo su RBD.</p>',
         por_que='<strong>Por qué.</strong> Las bases por establecimiento, comuna y región de la Agencia de Calidad son de <strong>libre descarga pública</strong> y la propia Agencia difunde resultados por establecimiento de forma nominal en su buscador. La restricción de las Condiciones de Uso protege las bases <em>por estudiante</em> (datos enmascarados), que este proyecto no utiliza. Decisión documentada en 50_documentacion/activa/decisiones/20260611_decision_nombres_establecimientos.md.'),
    list(id='D-color-nivel', titulo='Color fijo por estándar; el corte de traspaso modula estilo',
         cuerpo='<p>Cada estándar (Adecuado · Elemental · Insuficiente) tiene un <strong>color fijo</strong> en todas las vistas, idéntico para todas las entidades. La identidad del territorio se sostiene por <strong>nombre, swatch y borde de ficha</strong>, no por el color del trazo. La segmentación por año de traspaso modula <strong>opacidad y estilo de trazo</strong>, nunca el color.</p>',
         por_que='<strong>Por qué.</strong> Mantener el color asociado al estándar (y no a la entidad) evita que el lector deba memorizar leyendas distintas entre vistas: el azul de Adecuado es siempre el mismo. El corte de traspaso es una dimensión visual separada (atenúa el tramo previo a la gestión SLEP) que no compite con la codificación de color del estándar.'),
    list(id='D-licencia-apache', titulo='Licencia Apache 2.0 para el código',
         cuerpo='<p>El código se licencia bajo <strong>Apache License 2.0</strong> (no MIT; desviación deliberada de la política §10). Cubre <strong>solo el código</strong>; los datos Simce siguen bajo las Condiciones de Uso de la Agencia de Calidad, declarado en el archivo <span class="inl">NOTICE</span>.</p>',
         por_que='<strong>Por qué.</strong> Apache 2.0 concede expresamente una licencia de patentes que MIT no contempla, es la licencia permisiva preferida en entornos públicos e institucionales y reduce la fricción legal para que otros servicios del Estado reutilicen el código, sin sacrificar permisividad. Documentada en 20260611_decision_licencia_apache.md.'),
    list(id='D-repo-publico', titulo='Repositorio público (B3)',
         cuerpo='<p>El repositorio se mantiene <strong>público</strong>. Con repo público, todo lo versionado es visible —no solo <span class="inl">docs/</span>—, por lo que rige una regla operativa: <strong>nada se versiona si no es publicable</strong>.</p>',
         por_que='<strong>Por qué.</strong> GitHub Pages en plan Free exige repositorio público y el motor se publica por Pages (<span class="inl">docs/index.html</span>). La excepción a la regla de visibilidad privada queda justificada y documentada; los insumos versionados son bases públicas o de creación interna sin datos privados. Documentada en 20260611_decision_repo_publico.md.'),
    list(id='D-celda-unico-establecimiento', titulo='Celdas con un único establecimiento educacional no se suprimen',
         cuerpo='<p>No se implementa supresión de celdas por <span class="inl">n_estab</span>. Mostrar resultados de un <strong>establecimiento educacional</strong> individual es deliberado y transversal en el motor: cualquier punto con <span class="inl">n_estab = 1</span> ya expone el RBD (tooltip) y el nombre (popup), en cualquier nivel.</p>',
         por_que='<strong>Por qué.</strong> Corolario de D-nombres: la restricción de §6.4 (no identificar por nombre) aplica a las bases <em>por estudiante</em> (microdatos enmascarados), que el proyecto no usa, no a las bases <em>por establecimiento</em>, que son públicas y que la Agencia difunde nominalmente. Suprimir por <span class="inl">n_estab</span> contradiría D-nombres, sería incoherente y degradaría utilidad sin reducir ningún riesgo real. Documentada en 20260620_decision_celda_unico_establecimiento.md.'),
    list(id='D-ley-21719', titulo='Cumplimiento Ley 21.719: de-versionado del directorio crudo',
         cuerpo='<p>El producto publicado <strong>no contiene dato personal</strong> de persona natural (verificado por dos caminos independientes). El insumo <span class="inl">directorio_oficial_ee.csv</span> contenía la columna <span class="inl">MRUN</span> (RUN enmascarado de 946 sostenedores persona natural) que el pipeline no usa; se <strong>de-versionó</strong> (<span class="inl">git rm --cached</span> + <span class="inl">.gitignore</span>) y se descarga de MINEDUC.</p>',
         por_que='<strong>Por qué.</strong> Minimización (Ley 21.719): no versionar en un repo público un dato personal que el pipeline no utiliza. La exposición histórica del insumo se acepta como <strong>riesgo residual documentado</strong> —es un dato de rol público ya difundido por MINEDUC y reescribir el historial de un repo público con Pages activo sería desproporcionado—, revisable si cambia la naturaleza del dato. Documentada en 20260622_decision_cumplimiento_ley_21719.md y gobernanza_datos.md.')
  ),

  # ---- 1.6 Anomalías de origen ----------------------------------------------
  anomalias = list(
    list(id='A1',
         largo='<strong>Sufijos de columna cruzados en 2018/4° básico.</strong> El archivo <span class="inl">simce4b2018</span> trae los sufijos de columna como <span class="inl">_2m_</span> en lugar de <span class="inl">_4b_</span>. Se reescriben antes de la normalización general; luego la lectura por nombre opera normalmente.',
         corto='Un archivo (2018, 4° básico) trae los sufijos de columna del otro nivel. Se corrigen antes de leer.'),
    list(id='A2',
         largo='<strong>Marca de supresión de la fuente.</strong> La Agencia suprime ciertos resultados mediante una columna de marca. Se conserva como <span class="inl">marca</span> y gobierna la exclusión de filas (junto con el umbral de evaluados) antes de cualquier agregación.',
         corto='La fuente marca resultados suprimidos. Esas filas se excluyen del cálculo.'),
    list(id='A3',
         largo='<strong>cod_com_rbd con formato no canónico.</strong> En 2015/2° medio, 2015/4° básico y 2017/4° básico la columna de comuna trae códigos de 1 o 2 dígitos en lugar de los 4 o 5 canónicos. El pipeline lo detecta por archivo (más de la mitad de los códigos con menos de 4 dígitos) y recupera el código correcto por RBD desde el directorio oficial (snapshot 2025).',
         corto='Tres archivos traen el código de comuna mal formado. Se recupera por RBD desde el directorio.'),
    list(id='A4',
         largo='<strong>Códigos pre-Ñuble (Ley 21.033).</strong> Antes de 2018, las comunas de la actual Región de Ñuble tenían códigos del Biobío (8401–8421). Los xlsx 2014, 2016 y 2017 los traen así. Se retroaplican los códigos nuevos (16101–16207) en todos los años para que las series territoriales no tengan saltos.',
         corto='Comunas de Ñuble traían el código antiguo del Biobío. Se homologan al código actual en toda la serie.')
  ),

  # ---- 1.7 Glosarios --------------------------------------------------------
  glosario_tec = c(
    '<strong>RBD</strong> — Rol Base de Datos. Identificador único de cada establecimiento.',
    '<strong>Estándar de aprendizaje</strong> — Clasificación del Simce en tres niveles: Insuficiente, Elemental, Adecuado.',
    '<strong>% Adecuado</strong> — Porcentaje ponderado de estudiantes en el estándar Adecuado; indicador principal del proyecto.',
    '<strong>GSE / cod_grupo</strong> — Grupo socioeconómico del establecimiento, "1".."5" (Bajo a Alto). Dimensión obligatoria de toda agregación.',
    '<strong>nalu</strong> — Número de estudiantes evaluados. Pondera la agregación.',
    '<strong>palu_eda_ade / ele / ins</strong> — % de estudiantes en estándar Adecuado / Elemental / Insuficiente.',
    '<strong>marca</strong> — Marca de supresión de la Agencia; las filas con marca se excluyen del cálculo.',
    '<strong>cod_depe2</strong> — Dependencia administrativa agrupada (1..5), recuperada del directorio oficial.',
    '<strong>SLEP</strong> — Servicio Local de Educación Pública; sostenedor estatal que reemplaza la gestión municipal.',
    '<strong>parquet</strong> — Formato columnar comprimido para datos intermedios.',
    '<strong>Escritura atómica</strong> — Escribir a un archivo temporal y renombrar al final, para no dejar salidas a medias.',
    '<strong>Preliminar</strong>: marca de un año cuya base la Agencia aún publica como preliminar (archivo <code>*_preliminar.xlsx</code>). El motor lo señala con un asterisco, y la marca desaparece sola cuando llega la base final.'
  ),
  glosario_doc = c(
    '<strong>Simce</strong> — la evaluación nacional cuyos resultados, por estándar de aprendizaje, resume esta herramienta.',
    '<strong>Estándar de aprendizaje</strong> — el nivel que alcanza un grupo de estudiantes: Adecuado, Elemental o Insuficiente.',
    '<strong>% Adecuado</strong> — qué porcentaje de los estudiantes evaluados alcanza el nivel Adecuado.',
    '<strong>Grupo socioeconómico (GSE)</strong> — una agrupación de los establecimientos por contexto, para comparar entre realidades parecidas.',
    '<strong>RBD</strong> — identificador único de establecimiento.',
    '<strong>SLEP</strong> — Servicio Local de Educación Pública.',
    '<strong>4° básico / 2° medio</strong> — los dos niveles evaluados, que siempre se muestran por separado.',
    '<strong>Pipeline</strong> — la secuencia de pasos automatizados que transforma las planillas crudas en el motor navegable.'
  ),

  # ---- 1.8 Entidades comparables --------------------------------------------
  entidades_tec = list(
    list(ct='Comuna', cd='Todos los establecimientos de una comuna, ponderados por evaluados, dentro de un GSE.'),
    list(ct='SLEP', cd='Agrupación de las comunas y establecimientos de un Servicio Local.'),
    list(ct='Región', cd='Agrupación de todas las comunas de una región.'),
    list(ct='Nacional ("Chile")', cd='El total país.'),
    list(ct='Establecimiento', cd='Un RBD individual, con su serie histórica.')
  ),
  entidades_gen = list(
    list(ct='Una comuna', cd='Todos sus establecimientos educacionales juntos.'),
    list(ct='Un Servicio Local', cd='Las comunas y establecimientos de un SLEP.'),
    list(ct='Una región', cd='Todas las comunas de la región.'),
    list(ct='Todo el país', cd='El total nacional, "Chile".'),
    list(ct='Un establecimiento educacional', cd='Un establecimiento en particular, con su historia de resultados.')
  ),

  # ---- 1.9 Línea de producción ----------------------------------------------

  estaciones = list(
    list(icon='boxes', color='var(--ocean)', paso='Paso 1 · Insumo', titulo='Llegan las materias primas',
         parrafos=c('Cada año, la Agencia de Calidad de la Educación publica los resultados <strong>Simce por estándares de aprendizaje</strong> de cada establecimiento: qué porcentaje de sus estudiantes quedó en nivel Adecuado, Elemental o Insuficiente, en Lectura y Matemática, para 4° básico y 2° medio. Son datos <strong>públicos</strong>.',
                    'El problema es que llegan en <strong>planillas separadas</strong> por año y por nivel, y el formato cambia de un año a otro: una misma columna aparece con otro nombre, un código de comuna viene mal formado, el grupo socioeconómico a veces es un número y a veces una palabra. Tal cual llegan, no se pueden comparar.'),
         chip_in=list(ico='download', tx='Entra: planillas Simce desde 2014'), chip_out=NULL),
    list(icon='shield-check', color='var(--olive)', paso='Paso 2 · Preparación', titulo='Control de calidad y limpieza',
         parrafos=c('Antes de calcular nada, cada planilla pasa por revisión. Se leen siempre por el nombre de la columna y nunca por su posición, se homologa el grupo socioeconómico a una escala común, se corrigen los códigos de comuna mal formados y se actualizan los códigos de las comunas de Ñuble a su forma actual.',
                    'A cada establecimiento educacional se le recupera además su <strong>comuna y su dependencia</strong>, cruzando por su identificador contra el directorio oficial.'),
         chip_in=list(ico='file-warning', tx='Datos crudos, con diferencias entre años'),
         chip_out=list(ico='check', tx='Resultados homologados por establecimiento educacional')),
    list(icon='layers', color='var(--coral)', paso='Paso 3 · Preparación', titulo='Ensamblaje y cálculo',
         parrafos=c('Con todo limpio, los establecimientos educacionales se <strong>agrupan por territorio y por grupo socioeconómico</strong>: por comuna, por Servicio Local, por región y a nivel país. En cada grupo se calcula el <strong>porcentaje de estudiantes en nivel Adecuado</strong>.',
                    'El cálculo <strong>pondera por el número de estudiantes evaluados</strong>: un establecimiento con más estudiantes pesa más que uno pequeño, porque la pregunta es qué porcentaje de los estudiantes del territorio alcanza el nivel, no qué porcentaje de los establecimientos.'),
         chip_in=list(ico='check', tx='Resultados por establecimiento educacional'),
         chip_out=list(ico='percent', tx='% Adecuado ponderado por territorio y GSE')),
    list(icon='bar-chart-3', color='var(--plum-80)', paso='Paso 4 · Producto', titulo='Empaque: se arma el tablero',
         parrafos=c('Los porcentajes ya calculados se empaquetan dentro de una <strong>interfaz interactiva</strong>: las barras por grupo socioeconómico, las series año a año, el buscador y los controles para elegir qué comparar. Todo queda dentro de un solo archivo.',
                    'Lo importante: ese archivo <strong>lleva los datos adentro</strong>. No necesita conexión permanente ni programas especiales para funcionar.',
                    'Con los mismos datos limpios se arma una segunda página, la <strong>vista de trayectorias de los Servicios Locales</strong>, que también lleva sus datos adentro.'),
         chip_in=list(ico='percent', tx='Porcentajes calculados'),
         chip_out=list(ico='file-code-2', tx='Dos archivos navegables')),
    list(icon='monitor', color='var(--plum)', paso='Paso 5 · Producto terminado', titulo='La herramienta lista para usar',
         parrafos=c('El resultado es un <strong>tablero que se abre en cualquier navegador</strong>. Permite elegir una comuna, un Servicio Local, una región o un establecimiento educacional y ver el % Adecuado por grupo socioeconómico, su evolución y, si se quiere, el desglose en los tres estándares.',
                    'La vista de trayectorias responde otra pregunta: <strong>cómo se ha movido cada Servicio Local, año a año</strong>, en el porcentaje de estudiantes en nivel Adecuado y en nivel Insuficiente, antes y después de recibir sus establecimientos, junto a un grupo de referencia: los establecimientos que en 2014 eran municipales y que todavía no pasan a un Servicio Local. Muestra trayectorias; no mide el efecto del traspaso. Se abre en <a href="https://tomgc.github.io/slep_simce_adecuado/trayectorias.html">tomgc.github.io/slep_simce_adecuado/trayectorias.html</a> y desde el menú del tablero.',
                    'Las dos páginas están publicadas en línea para consulta, y se actualizan cada vez que llega un año nuevo: basta con repetir la línea de producción completa.'),
         chip_in=NULL, chip_out=list(ico='globe', tx='Tablero publicado y consultable'))
  ),

  # ---- 1.10 Garantías -------------------------------------------------------

  garantias = list(
    list(icon='users', titulo='Cada estudiante pesa lo que corresponde', d='Al juntar establecimientos no se promedian porcentajes a la ligera: se pondera por el número de estudiantes evaluados. Así, el porcentaje de un territorio refleja a sus estudiantes, no a sus establecimientos en abstracto.'),
    list(icon='scale', titulo='Siempre comparamos dentro del mismo grupo socioeconómico', d='Todo resultado se muestra por grupo socioeconómico (GSE). El Simce por estándares no ajusta por contexto, así que comparar en bruto entre realidades distintas sería injusto: por eso el GSE nunca se omite.'),
    list(icon='shapes', titulo='No mezclamos niveles ni pruebas', d='4° básico y 2° medio, Lectura y Matemática, se cuentan y se muestran siempre por separado. Mezclarlos daría una cifra sin sentido.'),
    list(icon='shield-check', titulo='Respetamos las reglas de la fuente', d='Se excluyen los resultados que la Agencia suprime y los grupos con muy pocos estudiantes evaluados, igual que en las publicaciones oficiales.'),
    list(icon='git-commit', titulo='Mostramos la trayectoria completa', d='Para cada territorio y establecimiento educacional se ve la evolución año a año, no solo el último resultado. Así se distingue una mejora sostenida de un dato puntual.'),
    list(icon='info', titulo='Solo años con datos reales', d='Se muestran únicamente los años efectivamente publicados (desde 2014, sin 2019 a 2021, hasta el último año cargado). No hay Simce 2019–2021; esos años no se inventan ni se imputan. Si la Agencia todavía no publica la versión final de un año, ese año se marca como preliminar.'),
    list(icon='settings', titulo='Antes de producir, se revisa el equipo', d='Antes de leer una sola planilla, la línea de producción comprueba que el computador maneje bien las tildes y la ñ, y que el proyecto esté bien instalado. Si algo falla, se detiene sin producir nada.'),
    list(icon='list-checks', titulo='Se prueba antes de publicar', d='Antes de publicar una versión nueva, dos baterías de pruebas revisan el tablero y la vista de trayectorias. Solo se publica si las dos pasan.')
  ),

  # ---- 1.11 "En qué fijarte" ------------------------------------------------

  notas = list(
    list(icon='palette', tx='<strong>El color indica el estándar; el nombre y el borde indican el territorio.</strong> Cada estándar tiene siempre el mismo color en todas las vistas, así que no hay que memorizar leyendas distintas.'),
    list(icon='percent', tx='<strong>Lo que ves es un porcentaje ponderado por estudiantes, no un promedio de establecimientos.</strong> Un establecimiento educacional grande influye más que uno pequeño, porque la pregunta es por los estudiantes.'),
    list(icon='scale', tx='<strong>Siempre verás el grupo socioeconómico.</strong> No es un detalle: comparar resultados Simce sin fijar el grupo socioeconómico puede llevar a conclusiones equivocadas.'),
    list(icon='shapes', tx='<strong>4° básico y 2° medio se ven por separado, y también Lectura y Matemática.</strong> Son universos distintos; el motor nunca los suma en una sola cifra.'),
    list(icon='git-commit', tx='<strong>Mira la trayectoria, no solo el último año.</strong> La serie muestra la evolución; ahí se lee si un territorio mejoró, se mantuvo o retrocedió. Recuerda que en una dependencia SLEP los años previos al traspaso corresponden a la gestión municipal.')
  ),

  # ---- 1.12 Preguntas frecuentes --------------------------------------------

  faq = list(
    list(q='¿Qué muestra esta herramienta?', a='El porcentaje de estudiantes en nivel Adecuado según el Simce por estándares de aprendizaje, por comuna, Servicio Local, región, establecimiento o a nivel país, siempre separado por grupo socioeconómico, nivel (4° básico o 2° medio) y prueba (Lectura o Matemática).', abierta=TRUE),
    list(q='¿Por qué se pondera por número de estudiantes y no se cuentan establecimientos?', a='Porque el dato de cada establecimiento es una proporción de estudiantes, no una etiqueta. Para saber qué porcentaje de los estudiantes de un territorio alcanza el nivel Adecuado, hay que dar a cada establecimiento el peso de sus estudiantes evaluados; promediar porcentajes sin ponderar trataría igual a uno grande y a uno pequeño.', abierta=FALSE),
    list(q='¿Por qué siempre se separa por grupo socioeconómico?', a='Porque el Simce por estándares no ajusta por el contexto socioeconómico del establecimiento. Comparar resultados en bruto entre territorios con composición distinta puede ser engañoso. Fijar el grupo socioeconómico asegura que la comparación sea entre realidades parecidas.', abierta=FALSE),
    list(q='¿Qué años cubre?', a='Desde 2014, sin 2019, 2020 ni 2021 (años sin Simce), hasta el último año cargado en 20_insumos/simce/. Si la base de un año todavía es preliminar, ese año se marca con un asterisco hasta que la Agencia publica la base final.', abierta=FALSE),
    list(q='¿Por qué un SLEP muestra años anteriores a su creación?', a='Porque la herramienta agrupa los establecimientos por su dependencia actual a lo largo de toda su historia. Los años previos al traspaso corresponden a la gestión municipal de esos establecimientos, no al SLEP; la herramienta lo advierte cuando seleccionas una dependencia SLEP.', abierta=FALSE),
    list(q='¿Qué es la vista de trayectorias?', a='Una segunda página, publicada junto a esta herramienta, que responde otra pregunta: cómo se ha movido cada Servicio Local, año a año, en el porcentaje de estudiantes en nivel Adecuado y en nivel Insuficiente, antes y después de recibir sus establecimientos, junto a un grupo de referencia (los establecimientos que en 2014 eran municipales y que todavía no pasan a un Servicio Local). Muestra trayectorias; no mide el efecto del traspaso. Se abre en <a href="https://tomgc.github.io/slep_simce_adecuado/trayectorias.html">tomgc.github.io/slep_simce_adecuado/trayectorias.html</a> o desde el menú de la herramienta.', abierta=FALSE),
    list(q='¿Necesito instalar algo para usarla?', a='No. Es un archivo que se abre en cualquier navegador. También está publicada en línea para consultarla directamente.', abierta=FALSE)
  ),

  # ---- 1.13 Prosa de los documentos de lectura ------------------------------
  prosa = list(
    doc_que = c(
      '<code class="inl">slep_simce_adecuado</code> es una herramienta de análisis interno que permite <strong>comparar los resultados Simce por estándares de aprendizaje</strong> —con foco en el porcentaje de estudiantes en nivel Adecuado— entre comunas, Servicios Locales, regiones, establecimientos y el nivel nacional, siempre por grupo socioeconómico y separando 4° básico de 2° medio y Lectura de Matemática.',
      'El problema que resuelve es concreto: los resultados se publican por establecimiento, año, nivel y prueba, en planillas dispersas y con formatos que cambian de un año a otro. Responder algo tan simple como “¿cómo evolucionó el % Adecuado de mi comuna en cada grupo socioeconómico?” exige consolidar varios años de planillas, homologar etiquetas y códigos que cambiaron, y recuperar el territorio de cada establecimiento educacional. Esta herramienta hace ese trabajo y entrega el resultado en un único archivo navegable.',
      'El producto final son <strong>dos archivos HTML autónomos</strong>: el motor de comparación (<code class="inl">motor_comparacion.html</code>), que permite explorar el % Adecuado por grupo socioeconómico y la trayectoria de cada territorio o establecimiento, y la vista de trayectorias de los Servicios Locales (<code class="inl">trayectorias_traspasos.html</code>), que sigue año a año a cada Servicio Local por cohorte de traspaso. Los dos se abren en cualquier navegador y están publicados para consulta en línea (<code class="inl">docs/index.html</code> y <code class="inl">docs/trayectorias.html</code>).'
    ),
    doc_pipeline = c(
      'Detrás de los archivos navegables hay un <strong>pipeline en R</strong> de cinco etapas, orquestado por un único script (<code class="inl">00_build.R</code>). Antes de leer insumos, el script instala la guarda de locale UTF-8 (<code class="inl">10_configuracion.R</code>, que aborta si no puede corregirla) y valida la portabilidad del entorno; una falla crítica detiene el build. Cada etapa escribe su resultado y las siguientes lo leen, de modo que el proceso completo es reproducible de principio a fin. Las dos salidas son HTML autocontenidos que no cargan nada por red: el motor embebe <em>inline</em> D3 v7, pako, React 18.3.1 y ReactDOM 18.3.1 (vendorizados en <code class="inl">10_utils/</code>, junto con Babel 7.29.0), y su JSX se transpila en el build con Babel dentro de V8, así que Babel no viaja; la vista de trayectorias usa JavaScript propio, sin bibliotecas. Dos baterías versionadas (<code class="inl">33_verificar_motor.R</code> y <code class="inl">36_verificar_trayectorias.R</code>) se corren a mano y deben quedar en PASA antes de cada copia a <code class="inl">docs/</code>. En prosa, las etapas son:'
    ),
    gen_porque = c(
      'Los resultados Simce se publican cada año en planillas separadas por nivel y prueba, con formatos que cambian y códigos que no siempre calzan entre un año y otro. Responder algo tan simple como <em>“¿cómo evolucionó el porcentaje de estudiantes en nivel Adecuado de mi comuna, en cada grupo socioeconómico?”</em> normalmente exige horas de trabajo y conocimiento técnico.',
      'Esta herramienta hace ese trabajo una sola vez, con reglas claras, y entrega la respuesta lista para mirar. El objetivo es que la conversación sea sobre <strong>qué dicen los datos</strong>, no sobre cómo armarlos.'
    ),
    etapas_pipeline = '<h3>1 · Construir el mapa del territorio</h3><p>Se arman los catálogos que traducen un establecimiento (RBD) a su comuna, su SLEP y su dependencia, y se prepara la caracterización de Costa Central.</p><h3>2 · Leer y limpiar las planillas</h3><p>Se leen las planillas Simce de cada año y nivel (hoy 18) por nombre de columna, se homologa el grupo socioeconómico, se corrigen códigos de comuna mal formados y pre-Ñuble, y se recupera el territorio y la dependencia de cada establecimiento educacional.</p><h3>3 · Agregar por territorio y GSE</h3><p>En cada comuna, SLEP, región y a nivel país se calcula el % Adecuado <strong>ponderando por número de estudiantes evaluados</strong>, siempre dentro de cada grupo socioeconómico.</p><h3>4 · Generar el motor navegable</h3><p>Los porcentajes se empaquetan dentro de un archivo HTML autónomo, que no carga nada por red.</p><h3>5 · Generar la vista de trayectorias</h3><p>Con los resultados por establecimiento, el catálogo de Servicios Locales y el de olas de traspaso se arma una segunda página, también autónoma: sigue a cada Servicio Local, año a año y por cohorte de traspaso, junto al referente municipal anclado en 2014 y a las cohortes que se traspasan de 2027 a 2029. La publicación de las dos páginas en <code class="inl">docs/</code> es un paso manual posterior, con las dos baterías de verificación en PASA.</p>'
  ),

  # ---- 1.14 Gobernanza ------------------------------------------------------
  gobernanza = "El producto publicado contiene solo datos institucionales (resultados Simce agregados por establecimiento educacional, comuna, SLEP y región, segmentados por GSE); no incluye dato personal de persona natural, verificado por doble vía (trazado de código y panel adversarial independiente). Base de licitud: datos públicos de fuente oficial (Agencia de Calidad de la Educación y directorio MINEDUC). El insumo directorio_oficial_ee.csv contenía la columna MRUN (RUN enmascarado de sostenedores persona natural) que el pipeline no usa; se de-versionó going-forward (D21-1, Ley 21.719) y se descarga de MINEDUC, conservando solo columnas institucionales. La exposición histórica de ese insumo se acepta como riesgo residual documentado y revisable. Retención: los datos públicos se conservan mientras el proyecto esté activo; el directorio crudo local se reemplaza en cada actualización anual de MINEDUC. Marco: Ley 21.719 (minimización) y la decisión D-nombres sobre la legitimidad de exhibir establecimientos educacionales por nombre desde bases públicas por establecimiento. Detalle en 50_documentacion/activa/gobernanza_datos.md.",

  # ---- 1.15 Rótulos del diagrama técnico ------------------------------------
  rotulos = list(
    lbl_fuentes     = 'Fuentes de datos <span class="sub">20_insumos/simce/</span>',
    lbl_auxiliares  = 'Tablas auxiliares <span class="sub">20_insumos/auxiliares/</span>',
    lbl_intermedios = 'Datos intermedios <span class="sub">40_salidas/intermedios/</span>',
    norm_titulo     = 'Anomalías de origen resueltas (datos crudos Agencia de Calidad)',
    exec = '<span class="cm"># Ejecución canónica del pipeline completo:</span><br><span class="fn">source</span>(<span class="str">"00_build.R"</span>)<br><br><span class="cm"># Antes de leer insumos: guarda de locale UTF-8 (10_configuracion.R) y</span><br><span class="cm"># validación de portabilidad; una falla crítica detiene el build.</span><br><br><span class="cm"># Baterías versionadas (manuales), las dos en PASA antes de copiar a docs/:</span><br><span class="cm"># Rscript 30_procesamiento/33_verificar_motor.R</span><br><span class="cm"># Rscript 30_procesamiento/36_verificar_trayectorias.R</span><br><br><span class="cm"># El deploy a GitHub Pages es manual (el pipeline no toca docs/): copia íntegra de</span><br><span class="cm"># 40_salidas/motor_comparacion.html a docs/index.html y de</span><br><span class="cm"># 40_salidas/trayectorias_traspasos.html a docs/trayectorias.html, y git push.</span>'
  ),

  # ---- 1.16 Leyenda del diagrama técnico ------------------------------------
  leyenda = list(
    list(color="var(--ocean)", texto="Pipeline R"),
    list(color="var(--plum)",  texto="Auxiliares / Motor"),
    list(color="var(--sand)",  texto="Datos intermedios"),
    list(color="var(--amber)", texto="Decisión metodológica"),
    list(color="var(--olive)", texto="Anomalía de origen resuelta (A1–A4)")
  ),

  # ---- 1.17 Reglas de cálculo -----------------------------------------------
  reglas_calculo = list(
    list(titulo='% Adecuado ponderado por evaluados',
         cuerpo='<pre>% nivel(territorio, GSE) = sum(nalu * palu_eda_&lt;nivel&gt; / 100) / sum(nalu) * 100</pre><p>El porcentaje de un territorio pondera por el número de estudiantes evaluados de cada establecimiento; nunca promedia porcentajes sin ponderar ni cuenta establecimientos.</p>'),
    list(titulo='Desglose en tres estándares, normalizado a 100',
         cuerpo='<p>El % Adecuado es el indicador rector. El desglose Adecuado · Elemental · Insuficiente usa la misma ponderación; el % Adecuado es idéntico exista o no el desglose, y Elemental e Insuficiente se reescalan solo para absorber el ±0,1 de redondeo de la fuente.</p>'),
    list(titulo='Filtros de exclusión (umbral MINEDUC)',
         cuerpo='<p>Se excluyen los establecimientos con <span class="inl">nalu &lt; 10</span> y los que traen marca de supresión (<span class="inl">marca</span> no NA). Gobiernan por igual el cálculo de los tres estándares.</p>'),
    list(titulo='Niveles, pruebas y GSE',
         cuerpo='<p>4° básico y 2° medio nunca se mezclan; Lectura y Matemática tampoco. Todo resultado se reporta por grupo socioeconómico.</p>')
  ),

  # ---- 1.18 Pie por documento -----------------------------------------------
  pie_extra = list(
    arq_tec = "Anomalías A1 a A4 documentadas en 50_documentacion/activa/referencia_glosas_simce.md. Runtime del motor: D3 v7, pako, React 18.3.1 y ReactDOM 18.3.1 inline, vendorizados en 10_utils/ (el build verifica el sha384 de React, ReactDOM y Babel); el JSX se transpila en el build con Babel 7.29.0 dentro de V8. La vista de trayectorias usa JavaScript propio, sin bibliotecas. Ninguna de las dos páginas carga nada por red. El deploy a docs/ es manual (el pipeline no lo realiza) y exige las dos baterías en PASA.",
    doc_tec = "",
    arq_gen = "¿Necesitas el detalle técnico? Abre arquitectura_slep_simce_adecuado_standalone.html",
    doc_gen = ""
  ),

  # ---- 1.19 Textos de sección y hero-notes ----------------------------------
  textos = list(
    ref_intro        = 'El diagrama de arriba muestra <strong>cómo fluyen los datos</strong>. Las secciones siguientes documentan el proyecto al detalle, de modo que cualquier persona técnica (o una sesión de IA) pueda reconstruir el contexto completo sin material adicional.',
    dic_crudos_titulo= 'Datos crudos (xlsx por año, nivel y prueba)',
    dic_interm_titulo= 'Datos intermedios producidos',
    reglas_titulo    = 'Reglas de cálculo',
    anom_titulo      = 'Anomalías de origen A1–A4 (detalle)',
    anom_intro       = 'Particularidades de las planillas crudas que el pipeline resuelve de forma trazable <strong>antes</strong> de cualquier cálculo. No son errores del proyecto.',
    doc_s2_intro     = 'El motor permite comparar el % Adecuado por grupo socioeconómico entre distintos <strong>territorios</strong>:',
    doc_s2_cierre    = 'Para cualquier territorio se muestra el <strong>% Adecuado por grupo socioeconómico</strong>, su evolución año a año y, si se desea, el desglose en los tres estándares. Todo dentro de un nivel fijo (4° básico o 2° medio) y una prueba fija (Lectura o Matemática).',
    doc_dec_intro    = 'Reglas que gobiernan todo cálculo del proyecto. Cada una corrige una forma específica de leer mal los datos.',
    doc_s5_intro     = 'Todos los datos provienen de la <strong>Agencia de Calidad de la Educación</strong> y son <strong>públicos</strong>. Las planillas crudas traen particularidades de origen que el pipeline normaliza antes de cualquier cálculo:',
    gen_hero         = 'Piensa en este proyecto como una <strong>pequeña fábrica de datos</strong>. Llegan materias primas —las planillas Simce por estándares—, pasan por una línea de producción que las limpia, las agrupa por territorio y grupo socioeconómico y calcula el porcentaje de estudiantes en nivel Adecuado, y al final sale un <strong>producto terminado</strong>: una herramienta que cualquier persona puede abrir para comparar resultados.',
    gen_linea_titulo = 'La línea de producción',
    gen_guards_titulo= 'Las garantías de calidad de la fábrica',
    gen_guards_intro = 'Toda fábrica seria tiene reglas que nunca se saltan. Estas existen para que las comparaciones sean <strong>justas y honestas</strong>:',
    gen_frase_titulo = 'En una frase',
    gen_frase        = 'Una línea de producción que toma varios años de planillas Simce dispersas, las limpia, las agrupa por territorio y grupo socioeconómico ponderando por estudiantes, y las convierte en un <strong>tablero navegable</strong> para mirar el % Adecuado de los establecimientos educacionales de Costa Central.',
    doc_gen_hero          = 'Es una herramienta para <strong>ver qué porcentaje de estudiantes alcanza el nivel Adecuado</strong> en el Simce por estándares, por comuna, por Servicio Local, por región, por establecimiento educacional o a nivel país, siempre dentro de un mismo grupo socioeconómico.',
    doc_gen_porque_titulo = 'Por qué existe',
    doc_gen_hacer_titulo  = 'Qué puedes hacer con ella',
    doc_gen_hacer_intro   = 'Eliges <strong>qué quieres mirar</strong> y la herramienta te muestra el % Adecuado de sus estudiantes, por grupo socioeconómico:',
    doc_gen_hacer_cierre  = 'Para lo que elijas, verás el <strong>% Adecuado por grupo socioeconómico</strong> y, si quieres, el desglose en los tres estándares y la trayectoria año a año.',
    doc_gen_fijarte_titulo= 'En qué fijarte al leerla',
    doc_gen_fijarte_intro = 'Cinco claves para interpretar la herramienta sin malentendidos:',
    doc_gen_datos_titulo  = 'De dónde vienen los datos',
    doc_gen_datos_cuerpo  = 'Todos los datos provienen de la <strong>Agencia de Calidad de la Educación</strong> y son <strong>públicos</strong>. La herramienta no contiene información de estudiantes individuales: trabaja con resultados agregados por establecimiento, que la propia Agencia difunde.',
    doc_gen_faq_titulo    = 'Preguntas frecuentes'
  )
)

# ---- Generación de los 4 HTML ---------------------------------------------
# verificar = FALSE (ver el encabezado): la lista de residuos de suitedoc marca
# términos legítimos de este proyecto.
suitedoc::generar_suite(
  cfg,
  salida_dir  = here::here("50_documentacion", "suite"),
  copiar_tema = TRUE,
  verificar   = FALSE,
  standalone  = TRUE,
  verbose     = TRUE
)
