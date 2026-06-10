# POLITICA_PROYECTO.md

> **Versión 4 — vigente y definitiva.** Adjuntar este documento a cada proyecto nuevo. Es el contrato fundacional que define estructura, nombramiento, versionado, arrancadores, escaneo periódico, gobernanza de datos y migración de proyectos existentes. Aplica a Claude, Claude Code y cualquier agente que trabaje sobre el proyecto.
>
> **Cambios respecto a v3:** sección 2.2 reescrita. Ahora **todos** los archivos llevan prefijo numérico (no solo el archivo principal de cada carpeta). Dos modos según si la carpeta tiene orden de ejecución interno. Ver sección 2.2 para detalle.

---

## 0. Reglas de interacción del asistente (alta prioridad)

Estas reglas aplican a cualquier asistente (Claude, Claude Code, etc.) que trabaje sobre proyectos que sigan esta política.

### 0.1 Recomendación explícita al ofrecer alternativas

Cada vez que el asistente presente opciones, alternativas, caminos posibles o decisiones a tomar:

- **Debe declarar explícitamente cuál recomienda y por qué.**
- La recomendación va al final de la lista de alternativas, en una línea separada con el formato: `**Recomendación:** [opción] — [razón en una oración].`
- La razón debe ser concreta (no "es mejor"; sí "evita renombrar todo si insertas estaciones intermedias").
- No vale presentar alternativas neutras sin recomendar. El asistente conoce el contexto del proyecto y debe tomar postura.
- El usuario sigue siendo quien decide, pero recibe la opinión del asistente antes de elegir.

### 0.2 Cuando no recomendar

Excepciones donde no aplica la regla 0.1:

- Decisiones puramente personales (color preferido, nombre de un archivo cuando ambas opciones son equivalentes).
- Decisiones sobre las que el asistente no tiene base técnica para opinar.

En esos casos, declararlo: `Sin recomendación: ambas opciones son equivalentes en este contexto.`

### 0.3 Ofrecer escaneo de directorio cuando se pierde la referencia

Si el asistente no sabe dónde están archivos, qué carpetas existen o cómo está organizado el proyecto en el momento actual, **debe sugerir ejecutar el escáner antes de continuar** (sección 7). No debe deducir ni inventar rutas.

---

## 1. Estructura de carpetas y nomenclatura

Todo proyecto de desarrollo (R, Power BI, Python, etc.) sigue una estructura de carpetas numeradas según el **flujo de ejecución**. La numeración no es decorativa: refleja el orden real en que los componentes participan en el pipeline.

### 1.1 Estructura canónica

```
proyecto/
├── 00_<orquestador>.{R,py,...}     ← punto de entrada único (00_run_all.R)
├── 00_escanear_proyecto.R          ← escáner de estructura (raíz)
├── 10_utils/                       ← funciones compartidas (se cargan primero)
├── 20_insumos/                     ← datos crudos de entrada (read-only)
│   ├── auxiliares/                 ← archivos de apoyo (diccionarios, equivalencias)
│   ├── publico/                    ← (opcional, ver sección 6.2)
│   ├── privado/                    ← (opcional, ver sección 6.2)
│   └── <fuente>/                   ← subcarpetas por origen de datos
├── 30_procesamiento/               ← ETLs, motores, modelos, app
│   ├── 31_<sub_etapa>.R            ← sub-numeración interna por orden de ejecución
│   ├── 32_<sub_etapa>.R
│   └── ...
├── 40_salidas/                     ← outputs generados (parquet, csv, reportes)
│   ├── publico/                    ← (simetría con 20_insumos si aplica)
│   └── privado/                    ← (simetría con 20_insumos si aplica)
├── 50_documentacion/               ← documentación del proyecto
│   ├── activa/                     ← documentación vigente
│   ├── traspasos/                  ← handoffs entre sesiones
│   ├── andamios/                   ← scripts históricos de refactor (congelados)
│   └── estructura/                 ← snapshots del escáner (ver sección 7)
├── tests/                          ← suite de pruebas (sin numerar)
│   └── testthat/
└── _archivo/                       ← obsoletos no asociados a refactors documentados
    └── YYYYMMDD/                   ← snapshots de hitos importantes
```

### 1.2 Principios de la numeración

**Principio 1 — Decenas, no unidades.** Usar `10, 20, 30...` deja espacio para insertar carpetas intermedias sin renumerar todo. Si en `30_procesamiento/` hay varios scripts, numerarlos como `31_, 32_, 33_` dentro de la carpeta.

**Principio 2 — El número refleja orden de ejecución.** `00` orquesta, `10` se carga primero (utils son prerrequisito), `20` se lee, `30` procesa, `40` escribe, `50` documenta. Si una carpeta no encaja en este flujo, probablemente no debería existir como decena propia.

**Principio 3 — Sin saltos.** Compactar `10, 20, 30, 40, 50` — no dejar huecos como `10, 30, 70, 90`. Los huecos son residuos de refactors previos, no reserva.

**Principio 4 — El nombre del archivo coincide con su carpeta.** Si la carpeta es `10_utils/`, el archivo es `10_utils.{ext}`, no `05_utils.{ext}`.

### 1.3 Principios de las carpetas

**Principio 5 — Separación input → procesamiento → output.** `20_insumos/` es read-only (datos crudos no se modifican). `40_salidas/` es write-only desde el pipeline (no se edita a mano). `30_procesamiento/` es la única capa que transforma.

**Principio 6 — Simetría entre input y output.** Si en `20_insumos/` existe `privado/` y `publico/`, en `40_salidas/` deben existir las mismas subcarpetas. Facilita la trazabilidad raw → procesado.

**Principio 7 — Documentación bifurcada: viva vs. congelada.**
- `50_documentacion/activa/`: lo vigente (arquitectura, doc técnica). Se actualiza in place.
- `50_documentacion/traspasos/`: handoffs históricos. Solo se agregan, nunca se editan.
- `50_documentacion/andamios/`: scripts de refactor ya ejecutados. Se preservan como registro histórico — **nunca se reescriben sus rutas internas** aunque la estructura cambie.
- `50_documentacion/estructura/`: snapshots del escáner del proyecto (ver sección 7).

**Principio 8 — `tests/` no se numera.** Sigue la convención del lenguaje (R: `tests/testthat/`; Python: `tests/`).

### 1.4 Sub-numeración interna en 30_procesamiento

Cuando el procesamiento tiene múltiples etapas (ETL → motor → app, etc.), se numeran internamente con orden de ejecución:

```
30_procesamiento/
├── 31_etl.R
├── 32_motor_calculo.R
├── 33_indicadores.R
└── 39_app.R           ← deja espacio para insertar entre 33 y 39 sin renumerar
```

Las sub-numeraciones también van de a 1 o de a varios según necesidad. Lo importante es que el orden alfabético en el árbol refleje el orden de ejecución del pipeline.

### 1.5 La carpeta `10_utils/`

Las funciones genéricas que usan múltiples scripts viven en `10_utils/`. Restricciones importantes:

- **Cero dependencias de paquetes cargados.** Usar `paquete::funcion()` con doble dos puntos cuando se necesite. Esto permite cargar utils antes que cualquier `library()`, lo que resuelve problemas de bootstrapping. Ejemplo: una función `instalar_si_falta()` que vive en utils y se invoca antes del primer `library()`.
- **Migrar a `10_utils/` solo cuando hay duplicación real** o riesgo claro de que aparezca. No es un cajón de sastre: cada función ahí justifica su lugar siendo (a) genérica y (b) usada en más de un script.
- Funciones específicas de una sub-etapa de procesamiento viven en esa sub-etapa, no en utils.

### 1.6 Carpeta `_archivo/` para historia local

Distinta de `50_documentacion/andamios/`:

- **`50_documentacion/andamios/`:** scripts de refactor que se ejecutaron sobre el proyecto. Quedan como registro histórico de cómo evolucionó la estructura. Sus rutas internas nunca se reescriben.
- **`_archivo/YYYYMMDD/`:** snapshots de archivos antes de cambios mayores, copias de respaldo locales, andamios no asociados a un refactor documentado.

Criterio para mover a `_archivo/`: si lo borraras hoy y no se rompe nada, va a `_archivo/` (no a la papelera). `_archivo/` se excluye de Git.

### 1.7 Filosofía de evolución

- **Las carpetas son contratos estables.** No las renombres reflejando refactors menores. Los scripts dentro pueden cambiar libremente, las carpetas no.
- **No anticipes todas las etapas.** Empieza con las que ya identifiques. La numeración con saltos de 10 te deja margen para insertar después sin renumerar.
- **Migración gradual de proyectos existentes.** Para migrar un proyecto a esta convención, usar el protocolo documentado en `prompt_migrar_estructura.md` con el motor `99_reorganizar_estructura_PLANTILLA.R`. Ver sección 8.

### 1.8 Anti-patrones a evitar

- **Carpetas planas con todos los scripts juntos** (típico `scripts/01_etl.R 02_motor.R 03_app.R`). Funciona para proyectos chicos, no escala. La numeración por carpeta da más aire.
- **Una carpeta `output/` ambigua** que mezcla salidas intermedias del pipeline con salidas finales para el usuario. Usar subcarpetas explícitas dentro de `40_salidas/` si la separación importa.
- **`10_utils/` que importa medio tidyverse en cabecera.** Rompe el bootstrapping. Las funciones de utils usan `paquete::funcion()` explícito.
- **Numeración decimal o de un solo dígito** (`1_etl.R 2_motor.R`). Cuando aparece la quinta etapa intermedia entre 2 y 3, te vas a arrepentir. Empieza siempre con saltos de 10.
- **Huecos en la numeración** (`10, 30, 70, 90`). Indica residuos de refactors no completados. Compactar a `10, 20, 30, 40`.
- **Renombrar carpetas reflejando refactors menores.** Las carpetas son contratos estables; los scripts dentro pueden cambiar libremente.
- **Saltarse el orquestador y correr scripts individuales como flujo habitual.** Llamar a scripts sueltos queda reservado para debug de una etapa específica. El método canónico de ejecución es `00_*`.
- **Mezclar funciones genéricas con específicas en `10_utils/`.** Si una función la usa una sola sub-etapa, vive en esa sub-etapa, no en utils.
- **Reescribir rutas en `50_documentacion/andamios/`.** Falsifica el registro histórico de refactors pasados.
- **Borrar en lugar de archivar.** Si dudas si algo todavía sirve, va a `_archivo/`. La papelera es para basura inequívoca.

### 1.9 Qué decide cada proyecto

La convención no fija lo siguiente; cada proyecto lo resuelve:

1. Qué sub-etapas concretas componen su `30_procesamiento/` (cuántos números 31/32/33/... y qué hace cada uno).
2. Si necesita la separación `publico/privado` en `20_insumos/` y `40_salidas/` (depende de si maneja datos personales; ver sección 6).
3. Qué funciones merecen estar en `10_utils/` desde el día uno (típicamente: instalación condicional de paquetes, escritura atómica de archivos, resolución de raíz del proyecto, logging).
4. Cuál es su archivo principal de presentación (app Shiny, reporte Quarto, dashboard, paquete publicado), dentro de `30_procesamiento/`.
5. Si usa tests y qué cobertura inicial (las funciones de `10_utils/` son el punto natural de partida).

---

## 2. Nombramiento de archivos

### 2.1 Orquestadores en raíz

- Prefijo `00_` para arrancadores: `00_run_all.R`, `00_escanear_proyecto.R`.
- Puede haber múltiples archivos `00_*` en raíz cuando son orquestadores u operaciones de meta-nivel.

### 2.2 Numeración de archivos dentro de carpetas

**Todos los archivos llevan prefijo numérico que indica su ubicación en la estructura.** No hay archivos sin prefijo dentro de carpetas numeradas: el prefijo es la señal visual que permite saber dónde va el archivo aunque se lo lea fuera de contexto.

Dos modos según si la carpeta tiene orden de ejecución interno:

**Modo A — Carpeta sin orden interno.** Típico de `10_utils/` y de las subcarpetas de `50_documentacion/`. Todos los archivos usan el número de la carpeta como prefijo:

```
10_utils/10_utils.R                       ← archivo principal de la carpeta
10_utils/10_configuracion.R               ← otro módulo de utils
10_utils/10_validaciones.R                ← otro módulo de utils
```

El nombre del archivo principal (`10_utils.R` dentro de `10_utils/`) sigue coincidiendo con su carpeta por convención, pero ya no es el único que lleva prefijo.

**Modo B — Carpeta con orden de ejecución interno.** Típico de `30_procesamiento/`. Los archivos ejecutables llevan numeración correlativa que refleja el orden dentro del rango de la decena:

```
30_procesamiento/31_etl.R                 ← primera sub-etapa
30_procesamiento/32_motor_calculo.R       ← segunda sub-etapa
30_procesamiento/33_indicadores.R         ← tercera sub-etapa
30_procesamiento/39_app.R                 ← presentación (deja espacio entre 33 y 39)
```

Si una sub-etapa con orden propio tiene archivos auxiliares que no se ejecutan directamente (típicamente funciones locales que solo se cargan desde el ejecutable de la misma sub-etapa), los auxiliares toman el número del archivo principal que los emplea:

```
30_procesamiento/32_motor_calculo.R       ← script ejecutable
30_procesamiento/32_funciones_motor.R     ← auxiliar cargado desde 32_motor_calculo.R
30_procesamiento/32_validaciones_motor.R  ← auxiliar cargado desde 32_motor_calculo.R
```

Esto permite reconocer de un vistazo qué auxiliares pertenecen a qué sub-etapa.

**Excepción declarada — Datos heredados de fuentes externas.** Los archivos crudos en `20_insumos/` que llegan desde fuentes externas (descargas oficiales, archivos institucionales, exports de sistemas de terceros) conservan su nombre original y no se renumeran. La numeración aplica solo a los archivos generados o gestionados por el proyecto. Documentar esta excepción en el README cuando aplique.

### 2.3 Convenciones generales de nombres

- Snake_case en minúsculas.
- Sin tildes, sin ñ, sin espacios.
- Nombre descriptivo del verbo o sustantivo principal: `etl_parquet`, `motor_cruce`, `generar_graficos`.
- Sin sufijos de versión (`_v3`, `_final`, `_nuevo`). Ver sección 3.

### 2.4 Datos

- Crudos en `20_insumos/`: prefijo de fecha `YYYYMMDD_` cuando el dato tiene versión temporal (descargas oficiales, datasets actualizables).
- Procesados en `40_salidas/`: nombre descriptivo sin fecha, porque la fecha vive en `_archivo/YYYYMMDD/` cuando se hace snapshot.
- Formatos por defecto: `.parquet` para datos masivos, `.xlsx` solo para entregables a usuario final, `.csv` solo cuando el destino lo exige.

### 2.5 Documentos

- Traspasos: `traspaso_cierre_vNN.md` (N correlativo, dos dígitos) en `50_documentacion/traspasos/`.
- Documentación técnica: `documentacion_tecnica_vN.md` en `50_documentacion/activa/`.
- Decisiones: `YYYYMMDD_decision_<tema>.md` en `50_documentacion/activa/decisiones/`.
- Andamios de refactor: el propio script ejecutado, archivado en `50_documentacion/andamios/`.

---

## 3. Política de versionado

Dos sistemas complementarios: **Git** para historial granular, **`_archivo/YYYYMMDD/`** para snapshots de hitos.

### 3.1 Git (obligatorio desde el primer commit)

- Inicializar Git al crear el proyecto.
- `.gitignore` debe excluir desde el primer commit (ver sección 6.3 para versión completa cuando hay datos sensibles):
  - `_archivo/` (snapshots no van a Git; son histórico local).
  - `.Rproj.user/`, `.Rhistory`, `.RData`.
  - `*.bak` (backups temporales generados por scripts de migración).
  - Credenciales (`.env`, `.Renviron`, `*credentials*`, `*secret*`, `*token*`).
- Commits frecuentes con mensajes descriptivos en español: `Agregar sub-etapa de cruce escuelas-jardines`.
- Branches solo cuando hay experimentación paralela. La rama principal vive en `main`.

### 3.2 Snapshots por fecha (para hitos)

**Regla:** el script vivo nunca lleva sufijo de versión.

- Los reemplazos van a `_archivo/YYYYMMDD/` conservando su ruta relativa original.
- Ejemplo: si `30_procesamiento/31_etl.R` cambia profundamente, el actual se mueve a `_archivo/20260522/30_procesamiento/31_etl.R` y el nuevo ocupa la ruta limpia.
- Las rutas activas son estables: nunca hay que actualizar `source()` ni referencias por cambios de versión.

### 3.3 Cuándo usar cada uno

**Git (commits):**
- Cambios incrementales, correcciones, mejoras cotidianas.
- Cada vez que termines una unidad de trabajo coherente.
- **Obligatorio:** commit limpio antes de ejecutar cualquier migración estructural en modo real (sección 8).

**Snapshot `_archivo/YYYYMMDD/`:**
- Antes de un refactor mayor.
- Al cerrar una versión grande del proyecto.
- Antes de aplicar cambios irreversibles a estructura.
- Al final de una sesión que cambió múltiples archivos críticos.

### 3.4 Numeración de traspasos

Los traspasos llevan correlativo `vNN` global del proyecto, no del año o de la rama. Crece monotónicamente: v01, v02, ..., v19, v20. Viven en `50_documentacion/traspasos/`.

---

## 4. Política del arrancador `00_*`

### 4.1 Responsabilidad

Orquestar el pipeline de principio a fin. Solo orquesta; **no contiene lógica de negocio**.

Es el método canónico de ejecución del proyecto. Llamar a los scripts individualmente queda reservado para debug de una etapa específica.

### 4.2 Requisitos estándar

- Vive en la raíz del proyecto, típicamente como `00_run_all.R`.
- Ancla el root vía `rprojroot::find_root()` con criterios `.here`, `.Rproj`, `is_rstudio_project`, `is_git_root`.
- Carga primero `10_utils/10_utils.R` antes de cualquier `library()` que dependa de paquetes potencialmente faltantes (permite el bootstrapping descrito en 1.5).
- Define lista ordenada `PASOS` donde cada paso es una lista con `id` (entero), `etiqueta` (string legible) y `ruta` (relativa al root, típicamente apuntando a archivos dentro de `30_procesamiento/`).
- Encapsula la ejecución en función `run_all()` con argumentos estándar (siempre presentes, mismo nombre en todos los proyectos):
  - `from = NULL`: ejecutar desde el paso N.
  - `to = NULL`: ejecutar hasta el paso N inclusive.
  - `only = NULL`: vector de IDs a ejecutar.
  - `skip = NULL`: vector de IDs a saltar.
  - Combinaciones razonables deben funcionar.

### 4.3 Argumentos opcionales según necesidad del proyecto

Cuando el proyecto lo amerite, `run_all()` puede aceptar argumentos adicionales más allá de los estándar. Casos típicos:

- `refrescar = TRUE/FALSE`: decide si reejecutar las transformaciones costosas (ETL, motores de cómputo) o solo levantar la capa de presentación. Útil cuando el desarrollo iterativo se concentra en la app o el reporte y los datos procesados no cambian.
- `verbose = TRUE/FALSE`: controla el nivel de log.

Estos argumentos son **opcionales** y específicos del proyecto. El nombre `run_all()` y los cuatro argumentos estándar (`from/to/only/skip`) deben mantenerse siempre, para que la experiencia de usar el arrancador sea consistente entre proyectos.

### 4.4 Comportamiento

- Antes de cada paso: encabezado con separador, ID, etiqueta, ruta.
- Mide y reporta duración por paso.
- Si un paso falla: detiene con `stop()` y mensaje claro. No continúa.
- Al final: resumen con pasos ejecutados, saltados, duración total.
- Scripts `.R` se ejecutan con `source(ruta, echo = FALSE, chdir = TRUE)`.
- Documentos `.qmd` se ejecutan con `quarto::quarto_render()`.
- Verifica al inicio que todas las rutas declaradas en `PASOS` existan en disco.

### 4.5 Logging

- Función `log_msg()` con timestamp, vive en `10_utils/10_utils.R`.
- Formato: `[YYYY-MM-DD HH:MM:SS] [00_run_all] [NIVEL] mensaje`.
- Niveles: INFO, WARN, ERROR.
- Sin paquetes externos pesados: `cat()` y `sprintf()` bastan; opcionalmente `cli` para scripts de meta-nivel como migraciones.

### 4.6 Lo prohibido

- No agregar caché automático por timestamp. Saltar pasos es responsabilidad explícita del usuario (vía `skip`/`only`) o vía argumento opcional documentado (como `refrescar`).
- No modificar scripts de procesamiento desde el arrancador.
- No mezclar lógica de negocio.

---

## 5. Convenciones de código

Esta sección **no reemplaza** `principios_desarrollo_vN.md`. Lo complementa con reglas de forma:

### 5.1 R

- Tidyverse, native pipe `|>`.
- `janitor::clean_names()` antes de cualquier análisis.
- `here::here()` para paths en scripts `.R`.
- **Excepción:** dentro de `.qmd`, los `source()` y `readRDS()` usan paths relativos al `.qmd`, no `here()`.
- Quarto sobre RMarkdown.
- `gt` o `reactable` para tablas; `flextable` para tablas exportadas a Word.

### 5.2 Auto-instalación de paquetes

Todos los scripts ejecutables incluyen al inicio el bloque:

```r
paquetes_requeridos <- c("dplyr", "readr", "fs")
paquetes_faltantes <- paquetes_requeridos[
  !sapply(paquetes_requeridos, requireNamespace, quietly = TRUE)
]
if (length(paquetes_faltantes) > 0) install.packages(paquetes_faltantes)
```

### 5.3 Header banner de scripts

Todos los scripts del pipeline llevan header con formato banner:

```r
# =============================================================================
# 31_etl.R
# -----------------------------------------------------------------------------
# Propósito: ETL de datos privados de asistencia mensual a parquet.
# Insumos:   20_insumos/privado/asistencia_cem/{anio}/*.xlsx
# Salidas:   40_salidas/privado/escuelas.parquet
# Autor:     Tomás G. Casanova
# Creado:    YYYY-MM-DD
# =============================================================================
```

### 5.4 Comentarios

- En español.
- Explicar el "por qué", no el "qué".
- Bloques temáticos separados por divisores: `# ---- Nombre del bloque ----`.

### 5.5 Idioma

- Carpetas raíz en inglés cuando sean convencionales (`tests/`, `_archivo/` es excepción).
- Carpetas numeradas del pipeline en español sin tildes ni ñ (`insumos`, `procesamiento`, `salidas`, `documentacion`).
- Comentarios y mensajes de log en español neutro.

---

## 6. Gobernanza de datos

### 6.1 Principio rector

Cuando el proyecto maneja datos personales, estos **nunca** salen del proyecto local. La estructura del repositorio refleja esta separación con subcarpetas `publico/` y `privado/`.

### 6.2 Separación física (cuando aplica)

**Aplicar cuando** el proyecto maneja datos personales (RUT, nombres, datos individuales identificables). **Omitir cuando** todos los datos del proyecto son públicos o sintéticos.

- `20_insumos/publico/`: datos públicos descargados de portales oficiales. Pueden versionarse en Git si su tamaño lo permite.
- `20_insumos/privado/`: datos con información personal. Excluidos de Git por `.gitignore`.
- `40_salidas/publico/`: outputs agregados sin información identificable. Pueden versionarse o subirse a servidores.
- `40_salidas/privado/`: outputs con datos individuales. Excluidos de Git, almacenados solo localmente.

La simetría entre `20_insumos/` y `40_salidas/` no es opcional cuando la separación aplica (Principio 6).

### 6.3 `.gitignore` obligatorio cuando hay datos sensibles

```
# Datos privados
20_insumos/privado/
40_salidas/privado/
*.csv
*.xlsx
*.parquet
*.rds
*.sqlite
*.db

# Excepciones para datos sintéticos y de ejemplo
!20_insumos/publico/ejemplos/

# Credenciales
.env
.Renviron
*credentials*
*secret*
*token*
*password*

# Sistema
.Rproj.user/
.Rhistory
.RData
.DS_Store
Thumbs.db

# Snapshots y backups locales
_archivo/
*.bak

# Outputs temporales
*_freeze/
.quarto/
```

### 6.4 Marco normativo

El proyecto opera bajo:

- **Chile:** Ley 19.628, Ley 21.719 (vigente desde diciembre 2026), Ley 21.663 (Ciberseguridad), Ley 21.180 (Transformación Digital), Ley 21.658 (Secretaría de Gobierno Digital), Estrategia de Datos del Estado.
- **Internacional:** GDPR como referencia de buenas prácticas, principios OCDE.

Decisiones técnicas con implicancia normativa (logs de acceso, retención, transferencia internacional) deben documentarse en `50_documentacion/activa/decisiones/`.

---

## 7. Escaneo periódico de estructura

### 7.1 Propósito

El proyecto evoluciona. Las carpetas se agregan, los scripts se mueven, los datos crecen. El escáner es el mecanismo para que cualquier agente (humano o asistente) sepa **dónde está parado en el momento actual**, sin deducir ni inventar.

### 7.2 Disparadores obligatorios

Ejecutar `00_escanear_proyecto.R` en estos cuatro momentos:

1. **Al abrir una sesión nueva** sobre un proyecto en curso. Adjuntar el output al chat para anclar el contexto.
2. **Después de reorganizar estructura**, renombrar carpetas o mover scripts (incluido después de una migración con `99_reorganizar_estructura_PLANTILLA.R`).
3. **Antes de cerrar sesión**: el escaneo se referencia en el traspaso de cierre.
4. **Cuando un asistente pierde referencia**: si el agente no sabe dónde están los archivos, debe pedir un escaneo antes de continuar (regla 0.3).

### 7.3 Output

El escáner genera dos archivos en paralelo en `50_documentacion/estructura/`:

- `YYYYMMDD_HHMMSS_estructura.txt`: snapshot con fecha. Histórico navegable.
- `YYYYMMDD_HHMMSS_estructura.md`: misma información en Markdown, optimizada para adjuntar a sesiones de chat.

Adicionalmente, mantiene dos aliases que siempre apuntan al escaneo más reciente:

- `50_documentacion/estructura/estructura_actual.txt`
- `50_documentacion/estructura/estructura_actual.md`

### 7.4 Contenido del escaneo

- Header con raíz, fecha y totales (carpetas, archivos).
- Árbol completo del proyecto excluyendo `.git/`, `renv/`, `.Rproj.user/`, `_archivo/` (este último es opcional excluirlo o incluirlo según preferencia del proyecto).
- Tamaños por archivo.
- Conteo por extensión al final.

---

## 8. Migración de proyectos existentes

Para migrar un proyecto con estructura desordenada (`raw/`, `data/`, `docs/`, carpetas con guiones bajos, huecos en numeración, decenas que no encajan en esta convención) a la estructura canónica, **no improvisar**. Usar el protocolo y motor ya probados:

### 8.1 Archivos de referencia

- **`prompt_migrar_estructura.md`:** protocolo paso a paso para que el asistente guíe la migración. Define el orden exacto: leer regla, escanear, diagnosticar referencias, proponer mapeo, adaptar plantilla, ciclo DRY_RUN, validar.
- **`99_reorganizar_estructura_PLANTILLA.R`:** motor probado de migración. Plantilla con bloques de configuración a llenar según el proyecto.

### 8.2 Reglas no negociables del protocolo

Independiente de quién ejecute la migración (tú, Claude, Claude Code), estas reglas no se pueden saltar:

1. **Diagnóstico de referencias antes del mapeo.** Antes de proponer renombres, buscar todas las referencias literales a las carpetas actuales en archivos de código (no solo `here::here()`, también `file.path()`, `test_path()`, paths en comentarios y tests). Sin este diagnóstico, los regex de reescritura fallan silenciosamente.
2. **DRY_RUN obligatorio antes del modo real.** El motor `99_reorganizar_estructura_PLANTILLA.R` arranca con `DRY_RUN <- TRUE`. Solo se cambia a `FALSE` después de validar que el plan se ve correcto.
3. **Commit limpio en Git antes del modo real.** Permite rollback si algo sale mal.
4. **Backups `.bak` se preservan** hasta validar end-to-end (tests + pipeline + verificación visual).
5. **No reescribir rutas en `50_documentacion/andamios/`.** Falsifica el registro histórico de refactors pasados. Este es el error más común.
6. **No combinar fases.** Renombrar carpetas, renombrar archivos, y reescribir código son tres operaciones distintas con tres puntos de validación distintos.
7. **No borrar carpetas históricas sin verificar primero** que su contenido se copió íntegro al destino.

### 8.3 Validación obligatoria post-migración

Después de ejecutar la migración en modo real, antes de borrar los `.bak`:

1. Reiniciar sesión de R.
2. Correr tests si existen (`devtools::test()` o equivalente).
3. Correr el orquestador (`00_run_all.R`) end-to-end.
4. Verificación visual si hay app/reporte.

Solo después de los 4 pasos de validación se borran los `.bak`.

### 8.4 Cuándo migrar

Migrar un proyecto existente cuando:

- La estructura actual te confunde o ralentiza el trabajo.
- Vas a trabajar en él de forma sostenida en próximas semanas/meses.
- Otros van a colaborar y la convención les ahorrará tiempo.

**No migrar** cuando:

- El proyecto está cerrado y solo se consulta esporádicamente.
- El proyecto va a ser archivado o reemplazado pronto.
- No hay tiempo para hacer la migración completa con sus validaciones.

Una migración a medias es peor que no migrar.

---

## 9. Workflow de evolución del proyecto

### 9.1 Agregar una sub-etapa nueva en 30_procesamiento

1. Decidir en qué número va dentro de `30_procesamiento/`. Si encaja entre dos existentes (entre `32` y `33`), usar un número intermedio o reorganizar.
2. Crear el script `30_procesamiento/3N_<nombre>.R`.
3. Agregar el paso a `PASOS` en `00_run_all.R` en el orden de dependencia correcto.
4. Ejecutar escáner para confirmar nueva estructura.
5. Commit en Git.

### 9.2 Agregar una decena nueva al pipeline

Si el proyecto crece y requiere una decena nueva (raro, dado que el procesamiento se consolida en `30_*`):

1. Verificar que no es solución a un problema que se resolvería con sub-numeración en `30_procesamiento/`.
2. Si realmente se justifica, usar `99_reorganizar_estructura_PLANTILLA.R` para introducirla.
3. Actualizar todas las referencias en código.
4. Documentar la decisión en `50_documentacion/activa/decisiones/`.

### 9.3 Renombrar o mover archivos

- Usar `fs::file_move()` desde script controlado.
- Buscar y reemplazar referencias (`source()`, `here()`, `file.path()`) en todos los scripts.
- Verificar que no queden referencias al nombre antiguo antes de commit.
- Ejecutar escáner antes y después.

### 9.4 Versionar un cambio mayor

- Antes de aplicar: snapshot a `_archivo/YYYYMMDD/`.
- Aplicar cambio.
- Ejecutar escáner.
- Commit en Git con mensaje descriptivo.
- Si la sesión termina aquí, generar traspaso de cierre referenciando el snapshot.

---

## 10. Documentación mínima del proyecto

Todo proyecto debe tener desde el inicio:

### 10.1 `README.md` en raíz

- Qué hace el proyecto.
- Cómo correr el pipeline (`Rscript 00_run_all.R` o equivalente).
- Estructura de carpetas (referencia a esta política).
- Dónde obtener los datos crudos (sin incluirlos).
- Aviso explícito de gobernanza si maneja datos personales.

### 10.2 `50_documentacion/activa/documentacion_tecnica_vN.md`

- Decisiones arquitectónicas vigentes.
- Diagrama de flujo de datos (opcional pero recomendado).
- Constantes y configuraciones del proyecto.
- Convenciones específicas del proyecto que no estén en esta política.

### 10.3 `50_documentacion/traspasos/`

Traspasos de cierre `traspaso_cierre_vNN.md` generados al cerrar cada sesión de desarrollo (ver `prompt-cierre-sesion.md`).

### 10.4 `50_documentacion/activa/decisiones/`

Decisiones puntuales con fecha: `YYYYMMDD_decision_<tema>.md`. Una decisión por archivo, autocontenida, con alternativas consideradas y justificación.

### 10.5 `50_documentacion/andamios/`

Scripts de refactor ya ejecutados sobre este proyecto (típicamente versiones llenas de `99_reorganizar_estructura_PLANTILLA.R`). Se preservan congelados como registro histórico. **Sus rutas internas no se reescriben jamás**, aunque la estructura del proyecto cambie después.

---

## 11. Checklist de inicio de proyecto

Al crear un proyecto nuevo, verificar:

- [ ] Estructura de carpetas creada: `10_utils/`, `20_insumos/`, `30_procesamiento/`, `40_salidas/`, `50_documentacion/{activa,traspasos,andamios,estructura}/`, `tests/`, `_archivo/`.
- [ ] `00_run_all.R` con stub funcional.
- [ ] `00_escanear_proyecto.R` instalado en raíz.
- [ ] `10_utils/10_utils.R` con funciones de bootstrapping (`instalar_si_falta`, `log_msg`, etc.).
- [ ] Git inicializado y primer commit hecho.
- [ ] `.gitignore` con exclusiones de la sección 3.1 (o sección 6.3 si maneja datos sensibles).
- [ ] `README.md` con descripción mínima.
- [ ] `POLITICA_PROYECTO.md` (este documento) adjunto en `50_documentacion/activa/`.
- [ ] `principios_desarrollo_vN.md` adjunto en `50_documentacion/activa/`.
- [ ] `regla_estructura_proyectos.md` adjunto en `50_documentacion/activa/`.
- [ ] Primer escaneo ejecutado y guardado en `50_documentacion/estructura/`.

---

## 12. Glosario rápido

- **Decena:** rango de 10 enteros (00-09, 10-19, etc.) asignado a un tipo de entidad o etapa del flujo de ejecución.
- **Sub-etapa:** división interna de `30_procesamiento/` con numeración secundaria (`31`, `32`, `33`, ...).
- **Orquestador:** script en raíz que ejecuta el pipeline completo (`00_run_all.R`).
- **Snapshot:** copia con fecha de un archivo o conjunto de archivos en `_archivo/YYYYMMDD/`.
- **Script vivo:** la versión actual de un script, sin sufijos de versión, en su ruta canónica.
- **Traspaso:** documento de cierre de sesión que permite retomar el trabajo en sesión futura. Vive en `50_documentacion/traspasos/`.
- **Andamio:** script de refactor ya ejecutado que se preserva como registro histórico en `50_documentacion/andamios/`. No se reescribe nunca.
- **Escáner:** `00_escanear_proyecto.R`, herramienta para conocer el estado actual del proyecto.
- **Bootstrapping:** carga inicial del proyecto antes de que se invoque cualquier `library()`. Las funciones de `10_utils/` deben funcionar en esta fase, por eso no pueden depender de paquetes cargados.
- **DRY_RUN:** modo de simulación de un script de migración. Lista cambios planeados sin ejecutarlos. Es siempre el modo de arranque obligatorio de cualquier reorganización estructural.
