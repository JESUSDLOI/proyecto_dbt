WITH source AS (
  SELECT
    *
  FROM {{ ref('snapshot__empresa_data') }} AS empresa_data
  where dbt_valid_to is null
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
  acciones_circulando,
  fecha_divid,
  fecha_ex_divid,
  id_carga_dlt,
  id_raiz_dlt,
  CONVERT_TIMEZONE('UTC', dbt_valid_from) as valid_from,
  CONVERT_TIMEZONE('UTC', dbt_valid_to) AS valid_to

FROM source
qualify row_number() over(partition by id_simbolo order by valid_from desc) > 1

), select_duplicados as (

SELECT 
  renamed.id_simbolo,
   renamed.id_activo,
   renamed.id_bolsa,
   renamed.id_industria,
   renamed.id_sector,
   renamed.idx_CIK, /*id de la informacion de la empresa*/
   renamed.id_web,
   renamed.id_moneda,
   renamed.fin_anyo_fiscal,
   renamed.ultimo_trimestre,
   renamed.capitalizacion_mercado,
   renamed.ebitda,
   renamed.ratio_precio_ganancia,
   renamed.ratio_peg,
   renamed.valor_contable,
   renamed.dividendo_por_accion,
   renamed.rend_div_accion_porc,
   renamed.ganancia_por_accion,
   renamed.ingresos_por_accion,
   renamed.margen_ganancia,
   renamed.margen_operativo,
   renamed.retn_sobre_activos,
   renamed.retn_sobre_patri,
   renamed.ingresos_acci_anyo,
   renamed.beneficio_bruto,
   renamed.eps_diluido,
   renamed.crec_gana_trim,
   renamed.crec_ingre_trim,
   renamed.precio_obj_anali,
   renamed.precio_ganan,
   renamed.precio_ganan_fut,
   renamed.rat_precio_venta,
   renamed.rat_precio_valor,
   renamed.valor_ingresos,
   renamed.valor_ebitda,
   renamed.beta,
   renamed.valor_max_sem_52,
   renamed.valor_min_sem_52,
   renamed.media_movil_50_dias,
   renamed.media_movil_200_dias,
   renamed.acciones_circulando,
   renamed.fecha_divid,
   renamed.fecha_ex_divid,
   renamed.id_carga_dlt,
   renamed.id_raiz_dlt,
   renamed.valid_from,
   renamed.valid_to
FROM renamed
left join source as b
    on renamed.id_simbolo = b.id_simbolo and renamed.id_carga_dlt = b.id_carga_dlt

)

select * from select_duplicados