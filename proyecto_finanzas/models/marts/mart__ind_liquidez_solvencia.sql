
WITH source AS (
  SELECT
    *
  FROM {{ ref('core__metricas_historicas') }} AS metricas
  left join {{ ref('stg_core__dim_nombres') }} as empresa
      on metricas.id_simbolo = empresa.id_simbolo
), renamed as(

-- Razón Corriente
SELECT 
    simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    CASE WHEN pasivos_corrientes = 0 THEN NULL ELSE CAST(activos_corrientes / pasivos_corrientes AS DECIMAL(10, 2)) END AS razon_corriente,

-- Prueba Ácida
    CASE WHEN pasivos_corrientes = 0 THEN NULL ELSE CAST((activos_corrientes + cambio_efectivo_equivalentes + cambio_cuentas_por_cobrar) / pasivos_corrientes AS DECIMAL(10, 2)) END AS prueba_acida,

-- Relación Deuda-Capital 
    CASE WHEN patrimonio_total = 0 THEN NULL ELSE CAST(deuda_total / patrimonio_total AS DECIMAL(10, 2)) END AS relacion_deuda_capital,

-- Cobertura de Intereses
    CASE WHEN gastos_por_intereses = 0 THEN NULL ELSE CAST(ebit / gastos_por_intereses AS DECIMAL(10, 2)) END AS cobertura_intereses



FROM source
)

SELECT
    *
FROM renamed