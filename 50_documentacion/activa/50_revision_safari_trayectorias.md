# Revisión en Safari sin red — vista de trayectorias

**Para qué:** cerrar la duda 1 de la compuerta v32 (D33-5). La vista se revisó en
Chromium; falta Safari de macOS, el navegador del equipo, antes de publicar (D33-2).
**Versión revisada:** commit `1d6c4ce`; HTML generado con md5
`ebee5acf417f9aebaa46366c167588d7`.
**Cómo se usa:** marca cada punto con `sí` o `no` en la columna «Resultado». Si un
punto falla, anota en «Observación» qué viste (y, si puedes, una captura con
Cmd+Mayús+4). El resultado entra al mensaje de apertura de la próxima sesión.

## Preparación (una vez)

1. En la Terminal:
   `cd /Users/tomgc/Projects/slep_simce_adecuado && Rscript 30_procesamiento/36_generar_trayectorias.R`
2. Comprueba que es la versión revisada:
   `md5 -q 40_salidas/trayectorias_traspasos.html` debe dar
   `ebee5acf417f9aebaa46366c167588d7`. Si da otro valor, detente y anótalo.
3. **Apaga el wifi** (y desconecta el cable de red si lo hay).
4. Abre el archivo en Safari:
   `open -a Safari 40_salidas/trayectorias_traspasos.html`
5. Deja la ventana a pantalla completa en el monitor que usas para presentar.

## Lista de revisión

| # | Estado a preparar | Qué debe verse | Resultado | Observación |
|---|---|---|---|---|
| 1 | Recién abierta | Encabezado azul del motor, menú con «Trayectorias de los Servicios Locales» subrayado en coral, fondo crema. Ningún recuadro vacío ni ícono roto (señal de algo que se intentó cargar por red) | sí | |
| 2 | Recién abierta, desplázate hacia abajo | El menú de vistas queda fijo arriba y la vista ocupa la pantalla bajo él, con la línea de tiempo visible abajo sin desplazarse más | sí | |
| 3 | Cohorte 2018, sin tocar nada | Texto de contexto «5 mediciones desde el traspaso» (sin tilde en «mediciones») | sí | |
| 4 | Pasa el cursor sobre la burbuja 1 | Tooltip con coma decimal: «Adecuado 21,8%» | sí | |
| 5 | Abre el menú «Grupo socioeconómico» | «Solo grupo alto (sin datos)» aparece desactivado (gris, no se puede elegir) | sí | |
| 6 | Cohorte 2021 y activa «Solo establecimientos con serie completa»; abre «Nivel y asignatura» | Las opciones sin datos aparecen desactivadas con «(sin datos)»; el plano nunca queda vacío | sí | |
| 7 | Cohorte 2025 | Los números de las 11 burbujas se leen sin encimarse; ninguna burbuja invade los números del eje vertical | sí | |
| 8 | Cohorte 2018; haz clic en cada año de la línea de tiempo y pasa el cursor sobre el círculo gris punteado | En los nueve años aparece el tooltip «Referente municipal» | sí | |
| 9 | Compara el tamaño del texto de los ejes con el de la leyenda | Ejes y leyenda de tamaño parecido; nada diminuto | sí | |
| 10 | Cohorte 2025, tabla lateral | Se ven todos los Servicios Locales, o se nota con una sombra al pie que hay más filas y la tabla se desplaza | sí | |
| 11 | Botón «Notas metodológicas»; baja hasta el final, cierra y vuelve a abrir | Ningún título queda solo al pie de una columna; al reabrir, el texto parte arriba | sí | |
| 12 | Botón ▶ (reproducir) | La animación recorre de 2014 a 2025; en 2019 a 2021 aparece el recuadro «2019, 2020 y 2021 no tienen medición Simce» y las burbujas se atenúan | sí | |
| 13 | Botón de pantalla completa (las cuatro esquinas); luego tecla Esc | Se ocultan el encabezado, el menú y los controles; con Esc todo vuelve | sí | |
| 14 | Activa «Sostenedores municipales» | Aparece la nube de puntos grises; la leyenda dice «Sostenedores municipales (180 comunas)» y «Referente: municipales por traspasar» | sí | |

## Resultado global

- Puntos que pasan: 14 de 14 (aprobado por el titular, 2026-09-24).
- Puntos que fallan: ninguno.
- Versión de Safari (menú Safari → Acerca de Safari): no informada.
- Fecha de la revisión: 2026-09-24, sin red, sobre el HTML de md5 `ebee5acf417f9aebaa46366c167588d7`.

Los enlaces «Comparación entre territorios» y «Panorama territorial» abiertos desde
`40_salidas/` dan «archivo no encontrado»: es lo esperado, porque apuntan a
`index.html`, que solo existe en GitHub Pages (D33-2). No cuenta como falla.
