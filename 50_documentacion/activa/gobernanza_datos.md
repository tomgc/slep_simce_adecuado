# Gobernanza de datos — slep_simce_adecuado

> Conforme a POLITICA_PROYECTO.md §10. Marco normativo: Ley 21.719 (protección de
> datos personales, vigente dic-2026) y Condiciones de Uso de la Agencia de Calidad
> de la Educación. Última auditoría: 2026-06-22 (ver
> `andamios/logs/20260622_auditoria_ley21719_log.md` y la decisión
> `decisiones/20260622_decision_cumplimiento_ley_21719.md`).

## 1. Qué datos maneja el proyecto

El proyecto compara resultados SIMCE por estándares de aprendizaje a nivel de
**establecimiento educacional**, comuna, SLEP, región y país, segmentados por grupo
socioeconómico (GSE). No trata datos por estudiante.

### 1.1 Insumos (en `20_insumos/`)

| Insumo | Origen | Datos | Clasificación |
|--------|--------|-------|---------------|
| `simce/{4b,2m}/*.xlsx` | Agencia de Calidad (público) | Resultados por establecimiento educacional × año × nivel × prueba × GSE (agregados, % por estándar, nº evaluados) | No personal (institucional) |
| `auxiliares/caracterizacion_establecimientos.xlsx` | Interno | RBD, nombre del establecimiento, comuna, macrozona, emplazamiento, IVE | No personal (institucional) |
| `auxiliares/listado_slep_2026.xlsx` | MINEDUC (público) | SLEP, comunas, región, fechas de traspaso | No personal (institucional) |
| `auxiliares/directorio_oficial_ee.csv` | MINEDUC (público) | Directorio nacional, 58 columnas. **Contiene MRUN** (RUN enmascarado de sostenedores persona natural, 946 filas) y RUT_SOSTENEDOR (14.819, todos persona jurídica) | **Mixto**: la mayoría institucional; **MRUN = dato personal** |

El directorio crudo **se de-versiona** (ver §4): su MRUN es dato personal que el
proyecto no utiliza.

### 1.2 Producto publicado (`docs/index.html`)

JSON embebido (comprimido). Por establecimiento educacional contiene únicamente:
`rbd`, `nom_rbd` (nombre del establecimiento), `cod_com_rbd`, `nom_com_rbd`,
`cod_depe2` (dependencia); más resultados SIMCE agregados por GSE, catálogos de
comunas/SLEP/regiones y metadatos. **Verificado por doble vía (trazado de código +
panel adversarial independiente): ninguna columna de dato personal de persona
natural cruza al producto.**

## 2. Categoría según Ley 21.719

- **No personal:** resultados SIMCE (agregados institucionales), RBD, nombre del
  establecimiento educacional, comuna, región, SLEP, dependencia, geo del local,
  RUT de sostenedor **persona jurídica**. Son datos de la institución, no de una
  persona natural.
- **Personal:** **MRUN** (RUN enmascarado de sostenedor persona natural) presente
  en el directorio crudo. No se utiliza ni se publica; se de-versiona.
- **Sensible:** ninguno. El proyecto no trata datos sensibles (salud, origen,
  etc.) ni datos por estudiante.

El nombre del establecimiento educacional (`nom_rbd`) **no** es dato personal: es
el nombre oficial público de la institución (ver D-nombres). La restricción de las
Condiciones de Uso de la Agencia aplica a las bases **por estudiante**, que este
proyecto no utiliza.

## 3. Base de licitud del tratamiento

Datos **públicos de fuente oficial**: Agencia de Calidad de la Educación (resultados
SIMCE por establecimiento, de descarga pública) y directorio oficial MINEDUC. El
tratamiento se limita a agregación estadística institucional con fines de análisis
educativo de interés público. No se recaba ni procesa dato personal de persona
natural en el producto.

## 4. Qué se publica y qué no

- **Se publica** (GitHub Pages, `docs/index.html`): el motor con datos agregados por
  establecimiento educacional / territorio, sin dato personal.
- **No se versiona** el directorio crudo MINEDUC (`directorio_oficial_ee.csv`) por
  contener MRUN (minimización; principio repo_publico). Permanece **solo en disco
  local**, regenerable desde MINEDUC.
- **No se versionan** los intermedios `.parquet` (regenerables) ni el HTML de
  `40_salidas/` (regenerable).

## 5. Dónde están los datos reales

- Insumos públicos versionados: `20_insumos/` (xlsx de la Agencia y auxiliares
  institucionales).
- Directorio crudo MINEDUC: **solo en disco local** del titular (no versionado);
  re-descargable desde el portal MINEDUC 1×/año. Para correr el pipeline en una
  máquina nueva hay que colocarlo en `20_insumos/auxiliares/directorio_oficial_ee.csv`.
- Intermedios y producto: `40_salidas/` (no versionados, regenerables con
  `00_build.R`).
- Copia publicada: `docs/index.html`.

## 6. Período de retención

Los datos son públicos y se conservan mientras el proyecto esté activo. El
directorio crudo local se reemplaza en cada actualización anual MINEDUC (no se
acumulan versiones históricas del crudo). Los intermedios se regeneran y
sobrescriben en cada corrida.

## 7. Procedimiento ante incidente de seguridad

1. **Detección/Contención:** si se detecta dato personal en el producto publicado o
   en un insumo versionado, despublicar (quitar `docs/` o pasar el repo a privado) y
   de-versionar el insumo afectado de inmediato.
2. **Evaluación:** identificar qué dato, en qué archivo, cuántas filas, y si está en
   el producto, en el historial, o ambos (un `git rm --cached` no purga el
   historial; la remoción histórica requiere `git filter-repo`/BFG + `push --force`).
3. **Remediación:** aplicar la mitigación (de-versionar / filtrar columnas /
   reescribir historial) y documentarla como decisión.
4. **Registro:** dejar log en `50_documentacion/andamios/logs/` y, si corresponde,
   evaluar notificación según la Ley 21.719.

## 8. Estado de cumplimiento (2026-06-22)

- Producto publicado: **sin dato personal** (verificado por doble vía).
- Insumo `directorio_oficial_ee.csv`: **de-versionado** going-forward (MRUN fuera
  del control de versiones).

### 8.1 Riesgo residual del historial (aceptado)

El archivo `directorio_oficial_ee.csv` **expuso 946 RUN de sostenedores persona
natural** (columna MRUN) en el **historial público** del repositorio, desde el
commit `61c3b9b` (cuando se agregó) hasta su de-versionado going-forward. El
`git rm --cached` corta la exposición en el *tip* a partir de este punto, pero **no
purga el historial**: el dato sigue siendo recuperable desde commits anteriores
(`git show 61c3b9b:…`).

**Decisión: se ACEPTA la exposición histórica como riesgo residual.** Fundamento:

- es un **dato de rol público** (sostenedor de un establecimiento educacional), no
  un dato privado de la esfera íntima;
- el directorio es de **descarga pública abierta en MINEDUC**; el MRUN histórico no
  fue originado por el proyecto ni es secreto;
- reescribir el historial de un repositorio **público con GitHub Pages activo**
  (force-push, reescritura de todos los hashes, impacto en clones/forks y en el
  despliegue) es **desproporcionado** frente al riesgo de un dato ya público.

**Esta decisión es revisable** si cambia la naturaleza del dato (p. ej. si MINEDUC
dejara de publicarlo o si se determinara que el MRUN es re-identificable de forma
directa): en ese caso se evaluaría la reescritura del historial. Registro de la
decisión: `decisiones/20260622_decision_cumplimiento_ley_21719.md` §6.
