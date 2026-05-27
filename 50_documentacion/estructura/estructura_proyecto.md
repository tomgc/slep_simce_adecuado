# Estructura del proyecto — slep_simce_adecuado

## Mapa de directorios

```
slep_simce_adecuado/
├── 00_build.R                   # Orquestador del pipeline
├── 00_escanear_proyecto.R       # Escáner canónico de estructura
├── 10_utils/
│   └── 10_utils.R               # agregar_ponderado(), json_motor()
├── 20_insumos/
│   ├── simce/
│   │   ├── 4b/                  # xlsx Agencia, 4° Básico, todos los años
│   │   └── 2m/                  # xlsx Agencia, 2° Medio, todos los años
│   └── auxiliares/
│       ├── sleps.csv            # cod_com → slep_nombre (manual)
│       └── comunas.parquet      # cod_com → nom_com (derivado)
├── 30_procesamiento/
│   ├── 31_leer_normalizar.R     # xlsx → parquet largo normalizado
│   ├── 32_agregar_comunal.R     # Agregación comuna × GSE × prueba × año
│   └── 33_generar_html.R        # JSON + HTML final
├── 40_salidas/
│   ├── intermedios/
│   │   ├── simce_rbd.parquet    # Establecimientos, todos los años/niveles
│   │   └── simce_comunal.parquet
│   └── motor_comparacion.html   # Producto final standalone
├── 50_documentacion/
│   ├── activa/                  # Documentación de sesión vigente
│   ├── traspasos/               # Handoffs entre sesiones
│   └── estructura/              # Este archivo
├── CLAUDE.md
├── POLITICA_PROYECTO.md
└── README.md
```

## Responsabilidades por archivo

### 00_build.R
Orquesta el pipeline completo. Carga `10_utils.R` y luego invoca los pasos
de `30_procesamiento/` en orden numérico.

### 00_escanear_proyecto.R
Audita la estructura del proyecto contra un manifiesto canónico.

### 10_utils/10_utils.R
- `agregar_ponderado(df, group_vars)`: aplica filtros MINEDUC y agrega el
  % adecuado ponderado por el número de evaluados.
- `json_motor(df, ...)`: construye la estructura JSON consumida por el HTML.

### 31_leer_normalizar.R
Lee los xlsx crudos por nivel/año, normaliza nombres de columnas, valida
columnas esperadas y emite `40_salidas/intermedios/simce_rbd.parquet` en
formato largo. Mantiene una fila por establecimiento × prueba × año × nivel.

### 32_agregar_comunal.R
Toma `simce_rbd.parquet` y agrega a `comuna × GSE × prueba × nivel × año`
con `agregar_ponderado()`. Salida: `simce_comunal.parquet`.

### 33_generar_html.R
Construye el JSON consolidado (datos + metadatos de comunas, SLEPs, GSE)
y lo embebe en una plantilla HTML para producir el motor final.

## Esquemas de datos

### simce_rbd.parquet (formato largo)

| Columna       | Tipo      | Notas                                |
|---------------|-----------|--------------------------------------|
| anio          | integer   | 2023, 2024, 2025                     |
| nivel         | character | "4b" o "2m"                          |
| prueba        | character | "lect" o "mate"                      |
| rbd           | character | ID establecimiento                   |
| cod_com_rbd   | character | Código comuna                        |
| nom_com_rbd   | character | Nombre comuna                        |
| cod_grupo     | character | "1".."5" (GSE)                       |
| nalu          | integer   | N° evaluados                         |
| palu_eda_ade  | double    | % en estándar adecuado               |
| marca         | character | Marca de supresión (NA si válido)    |

### simce_comunal.parquet

| Columna       | Tipo      | Notas                                |
|---------------|-----------|--------------------------------------|
| anio          | integer   |                                      |
| nivel         | character |                                      |
| prueba        | character |                                      |
| cod_com_rbd   | character |                                      |
| nom_com_rbd   | character |                                      |
| cod_grupo     | character |                                      |
| pct_adecuado  | double    | % ponderado agregado                 |
| n_total       | integer   | sum(nalu) tras filtros               |
| n_estab       | integer   | N° establecimientos en la agregación |
