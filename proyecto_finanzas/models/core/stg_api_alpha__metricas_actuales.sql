WITH source AS (
  SELECT
    *
  FROM {{ ref('stg_api_alpha__empresa_data') }} AS empresa_data
),
renamed AS (
SELECT
  id_simbolo,
  id_activo,
  id_bolsa,
  id_industria,
  id_sector,
  idx_CIK, /*id de la informacion de la empresa*/
  id_web,
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
  fecha_divid,
  fecha_ex_divid,
  id_carga_dlt,
  id_raiz_dlt

FROM source

)
SELECT
  *
FROM renamed