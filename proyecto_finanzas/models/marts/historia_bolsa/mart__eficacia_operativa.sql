
WITH source AS (
  SELECT
    *
  FROM {{ ref('metricas_historicas') }} AS metricas
  left join {{ ref('core__dim_nombres') }} as empresa
      on metricas.id_simbolo = empresa.id_simbolo
), renamed as(

-- Relación de Costos
SELECT 
    simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    CASE WHEN ingresos_totales = 0 THEN NULL ELSE (costo_de_ingresos / ingresos_totales) * 100 END AS porcentaje_costo_ingresos,
    CASE WHEN ingresos_totales = 0 THEN NULL ELSE (gastos_generales_y_administrativos / ingresos_totales) * 100 END AS porcentaje_gastos_generales,

-- Rotación de Activos
    CASE WHEN total_activos = 0 THEN NULL ELSE ingresos_totales / total_activos END AS rotacion_activos,

-- Rotación de Inventarios
    CASE WHEN inventario = 0 THEN NULL ELSE costo_de_bienes_y_servicios_vendidos / inventario END AS rotacion_inventarios 
    
FROM source
)

SELECT
    *
FROM renamed