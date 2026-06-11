# Encargo de auditoría — slep_simce_adecuado

> **Para la próxima sesión (tipo: ONE-OFF extendida / auditoría dedicada).**
> Modelo recomendado: el más potente disponible.
> Entorno: interfaz web. El asistente genera scripts de validación en R;
> el usuario los corre localmente (Positron) y pega la salida.
> **Antes de empezar:** leer `POLITICA_PROYECTO.md` y
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md` de la knowledge base, más el
> `traspaso_cierre_v12.md` y el escáner actual.

---

## 0. Contexto y meta del proyecto

`slep_simce_adecuado` produce un motor HTML standalone (React + D3, datos
embebidos comprimidos con gzip) que compara la **proporción ponderada de
estudiantes en nivel Adecuado** de los Estándares de Aprendizaje SIMCE, entre
entidades (establecimiento, comuna, SLEP, región, grupo, nacional), **siempre
segmentado por Grupo Socioeconómico (GSE)**. Pipeline:
`xlsx (Agencia) → R → parquet → JSON gzip+base64 → HTML único`.

El motor **se va a lanzar públicamente.** Esta auditoría es la compuerta previa.
No basta con "parece que funciona": cada cifra publicada debe ser defendible
ante la Agencia de Calidad y ante los propios SLEP que la usarán para
diagnóstico. Un número incorrecto en producción es un costo reputacional real.

## 1. Invariantes del dominio (lo que NUNCA debe romperse)

Estas son las reglas que la auditoría debe **probar**, no asumir:

1. **Segmentación GSE inviolable.** Todo resultado se reporta por GSE
   (Bajo / Medio bajo / Medio / Medio alto / Alto). Jamás se colapsa ni se
   promedia entre GSE.
2. **Agregación ponderada por `nalu`.** Todo % agregado se pondera por número
   de evaluados por establecimiento × prueba × nivel:
   `% = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100`. Nunca promedio
   simple de porcentajes.
3. **Pruebas y niveles no se mezclan.** Lectura/Matemática y 4°Básico/2°Medio
   jamás se agregan juntos en una misma cifra.
4. **Supresión de la Agencia.** Establecimientos con muy pocos evaluados tienen
   `palu_eda_ade = NA` (resultado suprimido por confidencialidad), aunque
   `nalu > 0`. Esos registros NO deben listarse en popups ni aportar al cálculo.
   (Bug corregido en sesión 12; verificar que la corrección es completa.)
5. **Filtros MINEDUC.** Establecimientos con `nalu < 10` se excluyen; marca de
   supresión (`marca` no-NA) se excluye.
6. **Identificadores como `character`.** RBD, códigos de comuna, GSE: siempre
   `character`, nunca numérico (un join con tipos mezclados falla en silencio).
7. **2025 es preliminar.** Debe marcarse visualmente como tal en todo el motor.
8. **Brecha 2019–2021 sin SIMCE.** Debe ser visualmente explícita.
9. **SLEP de traspaso prospectivo (2026).** Incluidos con sus RBDs municipales;
   sus resultados son de administración municipal previa, marcados con badge.
   (Feature de sesión 12; verificar que el universo de RBDs es exacto.)
10. **`SimceData.getSeriesForEntity()`** es la única función de selección de
    series. No debe haber ternarios por `kind` paralelos en componentes.

## 2. Las tres dimensiones de la auditoría

### A. CORRECCIÓN (máxima prioridad)

El objetivo: **probar que toda cifra publicada es exacta**, por dos caminos
independientes (el principio de auditoría del proyecto: caché vs. recálculo).

Casos de prueba a construir como scripts R (cada uno con criterio de éxito
explícito ANTES de correr):

- **A1. Reagregación comunal desde RBD.** Recalcular `simce_comunal.parquet`
  desde `simce_rbd.parquet` de forma independiente y comparar fila a fila.
  Criterio: diferencia cero en el % ponderado para las 44.975 filas.
  (Ya se hizo en sesión 6 con diferencia cero, pero el pipeline cambió en s12;
  **rehacer** para confirmar que sigue cuadrando.)
- **A2. Consistencia popup vs. cálculo.** Para una muestra de celdas
  (entidad × GSE × nivel × prueba × año), verificar que el conjunto de RBDs
  listados en el popup es exactamente el conjunto que aporta al % mostrado.
  Criterio: para toda celda, `RBDs_listados == RBDs_con_palu_no_NA`.
  (Este es el bug recién corregido; probar que NO quedan casos residuales en
  ningún SLEP / comuna / región, no solo Petorca.)
- **A3. Equivalencia de agregación SLEP.** Para cada SLEP, el % por GSE debe dar
  idéntico (a) agregando por su lista `rbds` desde `simce_rbd`, y (b) el que
  muestra el motor. Criterio: diferencia < 0.05 puntos porcentuales en todas
  las combinaciones SLEP × GSE × nivel × prueba × año con dato.
  Cubrir explícitamente los 10 SLEP prospectivos 2026 y Costa Central.
- **A4. Universo de RBDs por SLEP.** Verificar que `entity.rbds` de cada SLEP
  contiene exactamente los establecimientos que le corresponden:
  - SLEP ya traspasados: RBDs con `COD_DEPE == 6` en sus comunas.
  - SLEP prospectivos 2026: RBDs municipales (`COD_DEPE ∈ {1,2}`) en sus comunas.
  - Ningún RBD de otro SLEP, ningún particular subvencionado/pagado.
  Criterio: para cada SLEP, el set de RBDs del motor == set esperado desde el
  directorio + listado SLEP.
- **A5. Checksum de datos comprimidos.** Confirmar que el JSON descomprimido en
  cliente (gzip+base64+pako) es byte-idéntico al JSON original.
  Criterio: hash del JSON pre-compresión == hash del JSON post-descompresión.
- **A6. Verificación contra fuente oficial.** Tomar 5–10 establecimientos al
  azar (incluyendo rurales pequeños y urbanos grandes), y comparar el % Adecuado
  del motor contra el sitio de la Agencia de Calidad. Criterio: coincidencia
  exacta, incluyendo los casos de supresión (que el motor no invente un número
  donde la Agencia muestra "-").
- **A7. Reproducibilidad del pipeline.** Correr `00_build.R` dos veces desde
  cero y comparar los parquets y el HTML. Criterio: salida idéntica
  (idempotencia, principio del proyecto).

### B. SEGURIDAD (crítica por ser lanzamiento público)

El motor será público en GitHub Pages. Auditar:

- **B1. Cero datos personales en el output.** Ningún RUT, nombre de estudiante,
  ni dato individual identificable en el JSON embebido ni en el HTML. Script que
  busque patrones RUT y campos sospechosos en el HTML final.
- **B2. Nombres de establecimiento.** La Agencia prohíbe identificar
  establecimientos por nombre en outputs. **Verificar si el motor muestra
  `nom_rbd`** (los popups SÍ muestran nombres de escuela). Evaluar si esto
  cumple las Condiciones de Uso de la Agencia o si requiere ajuste antes del
  lanzamiento. **Decisión de gobernanza para el usuario, no técnica.**
- **B3. Repo y Pages.** Confirmar que no se publican insumos crudos sensibles,
  solo el HTML final y datos públicos agregados.
- **B4. Dependencias externas.** El motor carga React/Babel desde CDN (unpkg).
  Evaluar riesgo de disponibilidad/integridad para un sitio público
  (¿inline también? ¿SRI hashes?).

### C. OPTIMIZACIÓN (mejora, no bloqueante)

- **C1. Código muerto.** Tras los cambios de s12, buscar funciones/CSS/estado
  sin uso (ej. se removió `depe2CodesParaSlep`; verificar que no quedó nada más
  huérfano). Babel/parser para AST si ayuda.
- **C2. Rendimiento del cliente.** El motor descomprime ~14 MB y construye
  estructuras en cada carga. Medir tiempo de arranque; evaluar si
  `DATA.sleps.find()` en bucles (O(n²) potencial en `generateSeriesByRbd`
  cuando se llamaba por RBD) sigue presente en algún camino caliente.
- **C3. Consistencia de patrones.** Confirmar que `getSeriesForEntity` es
  realmente el único punto de selección de series (invariante 10), sin
  ternarios por `kind` paralelos que hayan quedado de refactors.
- **C4. Tamaño.** El HTML quedó en ~1.8 MB. Confirmar que no hay duplicación de
  datos en el JSON (ej. `rbd_gse` derivable de `simce_rbd`; evaluar si vale la
  pena, recordando que en s11 se decidió que comprimido no rinde — revisar si
  sigue siendo válido).

## 3. Método sugerido para la sesión

1. Abrir con clasificación y lectura de protocolo + traspaso v12 + escáner.
2. **No** intentar "leer todo el código linealmente." Priorizar por riesgo:
   empezar por CORRECCIÓN (A1–A7), que es donde un error es más caro.
3. Por cada caso de prueba: definir criterio de éxito, generar script R
   autocontenido, el usuario lo corre y pega salida, interpretar, documentar
   hallazgo. Un caso por intervención.
4. Los hallazgos de SEGURIDAD que sean de gobernanza (B2 sobre todo) se elevan
   al usuario como decisión, no se "arreglan" en silencio.
5. OPTIMIZACIÓN al final, solo si CORRECCIÓN y SEGURIDAD quedaron limpias.
6. Cerrar con un informe de auditoría: qué se probó, qué pasó, qué falló, qué
   se corrigió, qué queda como pendiente o como decisión del usuario.

## 4. Archivos que la sesión necesitará adjuntos

- Todos los `.R` de `30_procesamiento/` (30, 31, 32, 33) y `10_utils/10_utils.R`.
- `00_build.R`.
- `33_motor_template.html` (el grande, pero imprescindible).
- `estructura_actual.md` (escáner reciente).
- `traspaso_cierre_v12.md`.
- Los parquets NO se adjuntan (el usuario corre los scripts localmente).
- Insumos de referencia para A4/A6: `directorio_oficial_ee.csv`,
  `202602_Listado_SLEP_2026_vf.xlsx` (ya usados en s12).

## 5. Definición de "listo para lanzar"

El motor está listo para producción pública cuando:
- A1–A7 pasan con sus criterios (cifras exactas y reproducibles).
- B1, B3, B4 limpios; B2 resuelto como decisión explícita del usuario.
- No hay invariante del punto 1 violado.
- Los hallazgos de optimización están documentados (corregidos o diferidos con
  justificación).

Mientras A o B tengan un fallo abierto, **no se lanza.**
