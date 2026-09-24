# Decisión: universo y redondeo de la vista de trayectorias (paso 36)

**Fecha:** 2026-09-24 (sesión 32). **Decide:** el titular, sobre la propuesta del asistente.
**Código:** `30_procesamiento/36_funciones_trayectorias.R` (commit `7768383`).

## D32-2. El referente y la nube conservan el ancla de 2014

**Contexto.** El traspaso v31 diagnosticó (B31-4) que el mockup de la sesión 30 excluía el grupo
socioeconómico alto del total `T` de la nube y del referente, y fijó como criterio que Las Condes,
4° básico Lectura 2023, diera 344 evaluados. Al reconstruir la capa de datos en R, la sesión 32 midió que
el mockup nunca filtró el grupo 5: el referente y la nube toman los establecimientos municipales, fuera del
catálogo de Servicios Locales, **con resultado en 2014** (la regla que declaran las notas de la vista, «los
1.333 establecimientos que en 2014 eran municipales»). El único establecimiento municipal fuera de los
Servicios Locales con grupo alto en todo el parquet (6 filas, 2022-2024) no tiene resultado en 2014. Con el
ancla, Las Condes suma 271; solo sin ancla llega a 344.

**Decisión.** Se mantiene el ancla (opción A). B31-4 se cierra como diagnóstico errado.

**Alternativa descartada.** Quitar el ancla (opción B): el referente pasaba a 1.612 establecimientos y la
nube a 181 comunas, y el referente cambiaba de composición año a año, que es justo lo que la vista promete
controlar.

**Verificación.** D9 de `36_verificar_trayectorias.R`: el `n` del total iguala la suma de todos los grupos
del parquet dentro del universo anclado, con control positivo.

## D32-3. Los porcentajes se redondean en aritmética entera, con los empates hacia arriba

**Contexto.** El mockup y la primera versión del generador redondeaban en coma flotante. De 68.840 cifras,
655 son empates exactos (el porcentaje × 10 termina en ,5), y la coma flotante los resolvía distinto según la
plataforma y el orden de las filas: en la estación macOS (aarch64) salían 13 cifras distintas del mockup; en
el entorno del asistente (x86_64), 3.

**Decisión.** Opción (b): numerador `nalu × porcentaje × 10` y denominador `nalu`, ambos enteros, y
redondeo `(2·num + den) %/% (2·den)`, con los empates hacia arriba, como REDONDEAR de Excel.

**Consecuencias.** El HTML es idéntico byte a byte en las dos plataformas medidas (md5
`8b0a586bf9577e5164d7f10e2fadd835`); 316 cifras quedan un décimo arriba del mockup, todas empates exactos;
D13 comprueba que el orden de las filas no cambia el resultado. Ningún criterio fija cuántas cifras difieren
del mockup: esa magnitud depende del entorno que construyó el mockup (ERR-32-03).

**Alternativa descartada.** Opción (a): conservar la coma flotante y aceptar un resultado que cambia con la
máquina, contra POLITICA §5.2 (reproducibilidad).
