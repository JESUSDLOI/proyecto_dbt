{% snapshot snapshot__empresa_data %}

{{
    config(
      target_schema='snapshots',
      unique_key='id_simbolo',
      strategy='timestamp',
      updated_at='fecha_insercion',
      invalid_hard_delete=True 
    )
}}



WITH source AS (
  SELECT *
  from {{ ref('base_api_alpha__empresa_data') }} AS empresa_data
),renamed as(
    SELECT
        simbolo,
        id_simbolo,
        tipo_activo,
        nombre_empresa,
        descripcion,
        idx_CIK,
        bolsa,
        moneda,
        pais,
        sector,
        industria,
        direccion,
        sitio_web,
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
        b.id_carga_dlt,
        id_raiz_dlt,
        id_moneda,
        id_pais,
        id_bolsa,
        id_sector,
        id_industria,
        id_activo,
        id_empresa,
        fecha_insercion
    FROM source
    left join {{ ref('stg_metadata_dlt') }} AS b
      on source.id_carga_dlt = b.id_carga_dlt
)
SELECT * from renamed

{% endsnapshot %}