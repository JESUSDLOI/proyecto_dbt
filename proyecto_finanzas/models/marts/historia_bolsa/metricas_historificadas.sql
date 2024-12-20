{{
    config(
        materialized='table'   
    )
}}



WITH source AS (
  SELECT
    *
  FROM {{ ref('snapshot__empresa_data') }} AS empresa_data
  where dbt_valid_to is not null
),
renamed AS (
SELECT
  {{ dbt_utils.generate_surrogate_key(['id_simbolo', 'id_carga_dlt']) }} as id_metrica_his,
  id_simbolo,
  id_activo,
  id_bolsa,
  id_industria,
  id_sector,
  idx_CIK, 
  id_moneda,
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
  margen_operativo,
  retn_sobre_activos,
  retn_sobre_patri,
  ingresos_acci_anyo,
  beneficio_bruto,
  eps_diluido,
  crec_gana_trim,
  crec_ingre_trim,
  precio_obj_anali,
  precio_ganan,
  precio_ganan_fut,
  rat_precio_venta,
  rat_precio_valor,
  valor_ingresos,
  valor_ebitda,
  beta,
  valor_max_sem_52,
  valor_min_sem_52,
  media_movil_50_dias,
  media_movil_200_dias,
  acciones_circulando,
  fecha_divid,
  fecha_ex_divid,
  id_carga_dlt,
  id_raiz_dlt,
  id_empresa,
  CONVERT_TIMEZONE('UTC', dbt_valid_from) as valid_from,
  CONVERT_TIMEZONE('UTC', dbt_valid_to) AS valid_to

FROM source

)
SELECT
  *
FROM renamed

