# Plan del spin-off — trayectoria de los SLEP tras el traspaso

> **Destino:** `50_documentacion/andamios/20260909_plan_spinoff_trayectoria_traspasos.md`
> **Origen:** sesión 30 de `slep_simce_adecuado` (2026-09-09), Fase C de una
> apertura NEW PROJECT anidada en una CONTINUATION.
> **Estado:** plan aprobado en sus tres decisiones bloqueantes; pendiente el
> nombre del repositorio y el visto bueno global del titular.

---

## 1. Comprensión del proyecto

- Un motor autocontenido que anima, año a año, la posición de los 36 SLEP del
  país en el plano `% Insuficiente` × `% Adecuado` de Simce, con el año de
  traspaso marcado sobre cada trayectoria.
- Cinco paneles por grupo socioeconómico más un panel consolidado ponderado por
  evaluados: la misma segmentación que la vista de comparación del padre, no una
  excepción a ella.
- El propósito es descriptivo y comparado, no causal: junto a los SLEP se dibuja
  un referente de establecimientos municipales no traspasados, para que un
  movimiento del sistema completo no se lea como efecto del traspaso.
- Reutiliza la capa de datos ya construida por `slep_simce_adecuado` y no
  reimplementa su normalización.

## 2. Supuestos que estoy haciendo

- **Rama A de la política §8.2 (proyecto 100% público).** El spin-off consume los
  mismos insumos que el padre: Simce agregado por RBD de la Agencia de Calidad,
  sin datos nominales. El padre declara `maneja_sensibles: false`
  (fuente: `50_documentacion/activa/ESTADO.md`, leído en esta sesión). Si algún
  insumo futuro trae resultados individuales, la rama cambia a B y el historial
  de Git ya no se limpia barato.
- **`cod_depe2 = 5` identifica al establecimiento ya traspasado y `1` al
  municipal.** El mismo RBD aparece con `1` antes de su traspaso y con `5`
  después: 596 RBD de SLEP figuran con `cod_depe2 = 1` y 1.581 con `cod_depe2 = 5`
  (fuente: conteo sobre `40_salidas/intermedios/simce_rbd.parquet` en esta sesión).
  La glosa oficial del código **no se leyó en esta sesión**
  (hipótesis, verificar con: `grep -n "depe" 50_documentacion/activa/referencia_glosas_simce.md`).
- **Los parquet intermedios del padre son insumo sellado, no dependencia viva.**
  Se copian al spin-off con su md5 y su procedencia declarada. Reconstruir la
  normalización sería duplicar `31_leer_normalizar.R` sin motivo.

## 3. Base medida (todo en esta sesión, sobre los parquet del padre)

| Hecho | Valor | Fuente |
|---|---|---|
| SLEP en el catálogo | 36, con 2.337 RBD | `sleps_chile.parquet` |
| Años Simce disponibles | 2014-2018 y 2022-2025 (nueve) | `simce_rbd.parquet` |
| Hueco sin medición | 2019, 2020, 2021 | idem |
| 2025 | marcado `preliminar = TRUE`; los ocho anteriores, `FALSE` | idem |
| Cohortes de traspaso | 2018 (4 SLEP), 2020 (3), 2021 (4), 2024 (4), 2025 (11), 2026 (10) | `sleps_chile.parquet` |
| SLEP con 4 o más años Simce posteriores a su traspaso | 11 de 36 | cruce de ambos |
| Filas con los tres niveles no nulos | 150.569 de 185.378 | `simce_rbd.parquet` |
| De esas, con suma fuera de [99, 101] | 8.216 (celdas suprimidas, suman 0) | idem |
| Municipales no traspasados (referente) | 2.699 RBD con `cod_depe2 = 1` | idem |

**Consecuencia de diseño.** Costa Central se traspasó en 2025 y tiene un solo año
Simce posterior, preliminar. El instrumento debe decirlo en la propia burbuja, no
en una nota al pie.

## 4. Ruta de trabajo propuesta

1. **Inicialización rama A** con `scaffold_proyecto.R` de `herramientas_dev`
   (`maneja_datos_sensibles = FALSE`), checklist §8.4 completo, incluida la guarda
   `asegurar_locale_utf8()` que el padre no tiene y arrastra como pendiente.
2. **Capa de datos en R.** Un solo script de agregación: SLEP × año × nivel ×
   prueba × GSE, más el consolidado y el referente municipal. Numeradores crudos
   acumulados y un único redondeo al final (A29-5 del padre). Supresión heredada:
   una fila con los tres porcentajes en 0 es celda suprimida, no un territorio con
   0% Adecuado, y sale del denominador.
3. **Motor autocontenido desde el día uno.** D3 vendorizado, sin React, sin Babel,
   sin CDN. El pendiente 1 del padre no se hereda: nace resuelto.
4. **Animación.** Eje temporal en años calendario; reproducción, pausa y barra de
   arrastre; el salto 2018 → 2022 se dibuja como discontinuidad declarada, jamás
   interpolada. El año de traspaso de cada SLEP marca su burbuja.
5. **Verificación.** Réplica del cálculo en Node sobre carga sintética (los tres
   niveles suman 100, N derivado en precisión completa, fila suprimida fuera del
   denominador) y control positivo de cada verificador de ausencia, según
   `50_diseno_ramas_deteccion.md` §3 reglas 4 y 5.
6. **Publicación** en GitHub Pages, con gate visual del titular antes de cada
   despliegue.

## 5. Decisiones de diseño ya tomadas

- **DS-1 — Eje en años calendario, con el traspaso marcado sobre la burbuja.**
  Descartado el tiempo-evento (`t` = años desde el traspaso): con Simce en
  2014-2018 y 2022-2025, la malla de `t` queda desigual por cohorte y el promedio
  entre cohortes mezclaría distancias distintas al evento.
- **DS-2 — Referente municipal no traspasado en el mismo plano.** Descartado el
  trazado solo de los SLEP: una subida de Adecuado que ocurre en todo Chile se
  leería como efecto del traspaso. Descartado también el grupo de control
  emparejado: eso es un estudio, no una visualización.
- **DS-3 — Los 36 SLEP, con marca de madurez.** Las cohortes 2024, 2025 y 2026 se
  dibujan declarando cuántos años de medición posterior tienen, incluido el cero.
  Es la regla A29-4 aplicada a la portada: el alcance del instrumento iguala el
  alcance de la afirmación.
- **DS-4 — Sin dependencias de red.** Consecuencia directa del pendiente 1 del
  padre, tomada antes de escribir la primera línea.

## 6. Decisiones que necesito de ti

1. **Nombre del repositorio.** Propongo `slep_trayectoria_traspasos`.
2. **Visto bueno global de esta ruta** antes de que redacte el encargo de
   inicialización.

## 7. Lo que este instrumento no puede afirmar

No mide el efecto del traspaso. Muestra trayectorias y un referente; la
atribución exigiría un contrafactual que estos datos no contienen. La frase
"mejoró tras el traspaso" es descriptiva de la serie, no causal, y así debe
escribirse en la portada del motor.
