
WITH source AS (
  SELECT
    *
  FROM {{ ref('core__metricas_historicas') }} AS metricas
  left join {{ ref('stg_core__dim_nombres') }} as empresa
      on metricas.id_simbolo = empresa.id_simbolo
), renamed as(
-- Margen Bruto
SELECT 
    simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    cast((utilidad_bruta / ingresos_totales)* 100 as decimal(20, 2)) AS margen_bruto_porc,

-- Margen Operativo
    cast((ingreso_operativo / ingresos_totales)* 100 as decimal(20, 2)) AS margen_operativo_porc,

-- Margen Neto
    cast((ingreso_neto / ingresos_totales)* 100 as decimal(20, 2)) AS margen_neto_porc

FROM source
    
)
SELECT
    *
FROM renamed