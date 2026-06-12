# Decisión: licencia Apache 2.0 para el código (desviación de política §10)

- **Fecha:** 2026-06-11
- **Sesión:** 16
- **Estado:** vigente
- **Componente afectado:** licenciamiento del repositorio completo
- **Referencia:** `POLITICA_PROYECTO.md` §10 (sugiere MIT)

## Contexto

La política del proyecto (§10) sugiere licencia MIT para el código, con
cláusula explícita de que no aplica a los datos. Al evaluar el licenciamiento
de cara a una eventual publicación y difusión amplia (replicación por otros
SLEP o servicios del Estado), se revisó si MIT es la opción óptima o si conviene
otra licencia permisiva.

## Decisión

Licenciar el código bajo **Apache License 2.0** (SPDX: `Apache-2.0`), en lugar
de MIT. Es una desviación deliberada y documentada de la política §10.

Artefactos asociados:
- `LICENSE` — texto canónico Apache 2.0 (201 líneas) con aviso de copyright.
- `NOTICE` — aviso de copyright, cláusula de alcance (solo código, no datos) y
  componentes de terceros.
- Encabezado de licencia en los scripts fuente principales.

## Alternativas consideradas

- **MIT (statu quo de la política §10):** permisiva, mínima, garantiza crédito.
  Carece de concesión expresa de patentes. Descartada por el punto siguiente.
- **Apache 2.0 (elegida):** permisividad equivalente a MIT, más una concesión
  expresa de patentes y mayor aceptación en entornos institucionales y
  corporativos.
- **GPL v3 (copyleft):** descartada. Obliga a abrir derivados, lo que bloquea
  adopción por terceros que integren el código en software propietario;
  contraproducente para un proyecto que busca difusión y reutilización amplia.

## Justificación

1. **Protección de patentes.** Apache 2.0 concede explícitamente una licencia
   de patentes de cada contribuyente, que MIT no contempla. Relevante si el
   proyecto recibe contribuciones externas o es adoptado institucionalmente.
2. **Adopción institucional.** Apache 2.0 es la licencia permisiva preferida en
   entornos públicos y corporativos con oficinas de cumplimiento de open source;
   reduce fricción legal para que otros servicios del Estado lo reutilicen.
3. **Sin sacrificio de permisividad.** Igual que MIT, permite uso, modificación,
   distribución y uso comercial conservando el aviso de copyright.
4. **Compatibilidad.** Apache 2.0 es compatible con GPLv3 (el resultado combinado
   queda bajo GPLv3), suficiente para los escenarios de reutilización previstos.

El único costo frente a MIT es un archivo de licencia más extenso y la
convención de mantener un `NOTICE`. Se asume conscientemente.

## Implicancia

- La licencia cubre **solo el código**. Los datos SIMCE siguen bajo las
  Condiciones de Uso de la Agencia de Calidad (`POLITICA_PROYECTO.md` §6.4);
  el `NOTICE` lo declara explícitamente.
- **Irreversibilidad parcial:** el cambio de licencia rige hacia adelante; no
  revoca derechos de quien ya haya obtenido el código bajo otra licencia. Por
  eso se fija antes del primer release público difundido.
- Próxima actualización de `POLITICA_PROYECTO.md`: considerar enmendar §10 para
  reflejar Apache 2.0 como opción equivalente a MIT, o registrar esta decisión
  como excepción permanente del proyecto.
