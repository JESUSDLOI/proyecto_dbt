WITH source AS (
  SELECT
    *
  FROM {{ ref('base_api_alpha_empresa_data') }} AS empresa_data
),
renamed AS (
select
id,
id_ticker,
fin_anyo_fiscal,
ultimo_trimestre,
capitalizacion_mercado,
ebitda,
ratio_precio_ganancia,
ratio_peg,
valor_contable,
dividendo_por_accion,
rend_div_accion_porc,
ganancia_por_accion,
ingresos_por_accion,
margen_ganancia,
margen_operativo
valor_ingresos,
valor_ebitda,
acciones_circulando,
id_carga

  FROM source
)
SELECT
  *
FROM renamed