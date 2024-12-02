
WITH source AS (
  SELECT
    *
  FROM {{ ref('core__metricas_historicas') }} AS metricas
  left join {{ ref('stg_core__dim_nombres') }} as empresa
      on metricas.id_simbolo = empresa.id_simbolo
), renamed as(

-- Relación de Costos
SELECT 
    simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    (costo_de_ingresos / ingresos_totales) * 100 AS porcentaje_costo_ingresos,
    (gastos_generales_y_administrativos / ingresos_totales) * 100 AS porcentaje_gastos_generales,

-- Rotación de Activos
    ingresos_totales / total_activos AS rotacion_activos,

-- Rotación de Inventarios
    costo_de_bienes_y_servicios_vendidos / inventario AS rotacion_inventarios 
    
FROM source
)

SELECT
    *
FROM renamed