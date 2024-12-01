WITH source AS (
  SELECT
    *
  FROM {{ ref('stg_api_alpha__metricas_historicas') }} AS metricas
  left join {{ ref('stg_core__dim_nombres') }} as empresa
      on metricas.id_simbolo = empresa.id_simbolo
), renamed as(

-- Crecimiento de Ingresos
SELECT 
    simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    (ingresos_totales - LAG(ingresos_totales) OVER (PARTITION BY simbolo ORDER BY fecha_fiscal_final)) / 
    LAG(ingresos_totales) OVER (PARTITION BY simbolo ORDER BY simbolo, fecha_fiscal_final) * 100 AS crecimiento_ingresos_porc,


-- Crecimiento de Utilidad Neta
    (ingreso_neto - LAG(ingreso_neto) OVER (PARTITION BY simbolo ORDER BY fecha_fiscal_final)) / 
    LAG(ingreso_neto) OVER (PARTITION BY simbolo ORDER BY simbolo, fecha_fiscal_final) * 100 AS crecimiento_utilidad_neta_porc
FROM source
)

SELECT
    *
FROM renamed
