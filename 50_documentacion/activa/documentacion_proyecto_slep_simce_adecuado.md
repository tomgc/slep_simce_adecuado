# Presentación del proyecto — slep_simce_adecuado

> **Qué es este documento.** Una presentación conceptual del proyecto: qué
> problema resuelve, qué conceptos usa y qué decisiones metodológicas lo
> gobiernan. Está pensado para cualquier persona del equipo, con independencia
> de cuánto maneje SIMCE.
>
> **Documentos complementarios:**
> - `arquitectura_slep_simce_adecuado.html` — diagrama visual del flujo de
>   datos (etapa por etapa). Este documento explica el *qué y el porqué*;
>   el diagrama muestra el *cómo fluye*. Se leen juntos.
> - `README.md` — instrucciones de ejecución (cómo correr el pipeline).
> - `referencia_glosas_simce.md` — detalle técnico de las anomalías de datos.

---

## 1. Qué es y para qué

`slep_simce_adecuado` es una herramienta de análisis interno que permite
**comparar el desempeño SIMCE de distintos territorios y establecimientos** a
lo largo del tiempo, midiendo qué porcentaje de estudiantes alcanza el nivel
**Adecuado** de aprendizaje.

El problema que resuelve es concreto: los resultados SIMCE se publican por
establecimiento, año, prueba y nivel, en planillas dispersas y con formatos que
cambian de un año a otro. Responder una pregunta aparentemente simple —"¿cómo
le va a las comunas de Costa Central en 4° básico Lectura comparadas con el
resto de la región, controlando por nivel socioeconómico?"— exige consolidar
casi una década de planillas, homologar códigos que cambiaron en el tiempo y
agregar correctamente. Esta herramienta hace ese trabajo y entrega el resultado
en un único archivo navegable.

El producto final es un **archivo HTML autónomo** (`motor_comparacion.html`):
se abre en cualquier navegador, sin instalar nada, y permite explorar las
comparaciones de forma interactiva. Está publicado para consulta en línea.

---

## 2. Conceptos SIMCE

> **Esta sección es saltable.** Si ya manejas SIMCE, estándares de aprendizaje
> y GSE, pasa directamente a la sección 3.

**SIMCE** (Sistema de Medición de la Calidad de la Educación) es la evaluación
estandarizada nacional que aplica la Agencia de Calidad de la Educación. Mide
aprendizajes en pruebas como Lectura y Matemática, en distintos niveles
escolares. Este proyecto trabaja con dos niveles: **4° básico (4b)** y
**2° medio (2m)**.

**Estándares de aprendizaje.** Más allá del puntaje, la Agencia clasifica a
cada estudiante en uno de tres estándares según lo que demuestra saber:

- **Insuficiente** — no logra los aprendizajes mínimos del nivel.
- **Elemental** — logra los aprendizajes de forma parcial.
- **Adecuado** — logra los aprendizajes esperados para el nivel.

Esta herramienta se concentra en el **% de estudiantes en estándar Adecuado**:
es el indicador más exigente y el más informativo sobre cuántos estudiantes
realmente alcanzan lo esperado.

**GSE (Grupo Socioeconómico).** La Agencia clasifica cada establecimiento en
uno de cinco grupos socioeconómicos —Bajo, Medio bajo, Medio, Medio alto,
Alto— según las características de las familias que atiende. El GSE es decisivo
para interpretar resultados con justicia: comparar el % Adecuado de un colegio
de GSE Alto con uno de GSE Bajo, sin separarlos, mezcla el efecto de la escuela
con el efecto del contexto socioeconómico. Por eso, en este proyecto, **todo
resultado se reporta segmentado por GSE** (ver decisión metodológica en 4.2).

---

## 3. Qué hace la herramienta

El motor permite comparar el % de estudiantes en estándar Adecuado entre
distintas **entidades**:

- **Comuna** — todos los establecimientos de una comuna.
- **SLEP** — agrupación de las comunas de un Servicio Local.
- **Región** — agrupación de todas las comunas de una región.
- **Establecimiento** — un RBD individual.
- **Nacional ("Chile")** — el total país.
- **Grupos personalizados** — conjuntos de establecimientos definidos a medida.

Para cualquier entidad seleccionada, la herramienta muestra:

- La **serie temporal** del % Adecuado a lo largo de los años disponibles.
- El resultado **segmentado por GSE**, nunca como un único número global.
- Una **tabla** detallada con el conteo de estudiantes evaluados por celda.

Todo dentro de una combinación fija de **prueba** (Lectura o Matemática) y
**nivel** (4° básico o 2° medio): el motor nunca mezcla pruebas ni niveles
entre sí (ver 4.3).

---

## 4. Decisiones metodológicas y su porqué

Estas son las reglas que gobiernan todo cálculo del proyecto. No son
preferencias de estilo: cada una corrige una forma específica de leer mal los
datos.

### 4.1 Ponderación por número de evaluados (nunca promedio simple)

El % Adecuado de un territorio **no** es el promedio de los porcentajes de sus
establecimientos. Es el porcentaje ponderado por cuántos estudiantes evaluó
cada uno:

```
% adecuado = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100
```

**Por qué.** Un promedio simple le daría el mismo peso a un colegio de 15
estudiantes que a uno de 400, distorsionando el resultado. La ponderación por
`nalu` (número de alumnos evaluados) hace que cada estudiante cuente igual,
que es lo correcto cuando se habla de "qué porcentaje de estudiantes alcanza
Adecuado".

### 4.2 Segmentación por GSE inviolable

Ningún resultado se muestra sin separar por GSE. **Por qué:** ver sección 2.
Un número agregado sin GSE invita a comparaciones injustas entre territorios
con composición socioeconómica distinta. La segmentación es una salvaguarda
metodológica, no una opción de visualización.

### 4.3 No mezclar pruebas ni niveles

Lectura y Matemática, 4° básico y 2° medio, se analizan siempre por separado.
**Por qué.** Son mediciones de cosas distintas, en poblaciones distintas;
combinarlas produce un número sin interpretación posible.

### 4.4 El SLEP se compara contra el "resto", excluyéndose a sí mismo

Cuando se compara un SLEP con su región, los establecimientos del propio SLEP
se **excluyen** del grupo de referencia. **Por qué.** Si el SLEP quedara
incluido en el "resto de la región", se estaría comparando en parte consigo
mismo, diluyendo cualquier diferencia real. Excluirlo deja la comparación
limpia: SLEP versus todo lo demás.

### 4.5 Vacíos y datos preliminares explícitos

Entre **2019 y 2021 no hubo SIMCE** (estallido social y pandemia). Los datos de
**2025 son preliminares**. Ambas situaciones se marcan visualmente en el motor.
**Por qué.** Un vacío que se dibuja como continuidad, o un dato preliminar que
se presenta como definitivo, inducen a leer tendencias que no existen.

---

## 5. De dónde salen los datos

Todos los datos provienen de la **Agencia de Calidad de la Educación** y son
**públicos**. Se descargan del portal de información estadística y se versionan
junto al código en el repositorio (no hay datos individuales de estudiantes;
solo agregados por establecimiento).

Los datos crudos traen particularidades de origen que el pipeline normaliza
antes de cualquier cálculo. Son cuatro, documentadas en detalle en
`referencia_glosas_simce.md`:

- **A1** — En 2018/4° básico, ciertas columnas venían mal etiquetadas. Se
  corrigen al leer.
- **A2** — Una marca de validez que solo existe en 2014. Se homologa a todos
  los años.
- **A3** — Códigos de comuna corruptos en algunos años. Se reconstruyen
  cruzando con el directorio oficial de establecimientos.
- **A4** — Comunas de Ñuble con códigos anteriores a la creación de esa región
  (2017). Se remapean a los códigos actuales, para coherencia geográfica.

Estas correcciones **no son errores del proyecto**: son ajustes a
inconsistencias de las planillas de origen, resueltos de forma trazable. El
diagrama de arquitectura las muestra en su etapa correspondiente.

---

## 6. Cómo se relaciona con el resto de la documentación

Esta presentación es la puerta de entrada conceptual. Desde aquí:

- Para **entender el flujo de datos** etapa por etapa (qué script produce qué,
  en qué orden) → abre el diagrama `arquitectura_slep_simce_adecuado.html`.
- Para **correr el pipeline** en tu propia máquina → sigue `README.md`.
- Para el **detalle técnico de las anomalías A1–A4** y las reglas de cálculo →
  consulta `referencia_glosas_simce.md`.
- Para **convenciones de código y estado del proyecto** → `CLAUDE.md`.

---

*slep_simce_adecuado · Área de Monitoreo y Seguimiento · SLEP Costa Central ·
Datos públicos de la Agencia de Calidad de la Educación.*
