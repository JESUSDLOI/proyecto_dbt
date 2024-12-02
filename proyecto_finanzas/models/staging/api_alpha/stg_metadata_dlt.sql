{{
    config(
        materialized='incremental',
        unique_key='id_carga_dlt',
        incremental_strategy='delete+insert',
        on_schema_change='fail'    
    )
}}

WITH source AS (
  SELECT

    data1.id_carga_dlt,
    data1.id_dlt,
    nombre_del_pipeline,
    fecha_de_creacion,
    fecha_insercion

  FROM {{ ref('base_api_alpha__DLT_PIPELINE_STATE') }} AS data1
    left join {{ ref('base_api_alpha__DLT_LOADS') }} AS data2
    on data1.id_carga_dlt = data2.id_carga_dlt
  
)
  SELECT
    *
  FROM source

{% if is_incremental() %}

  where fecha_insercion> (select max(fecha_insercion) from {{ this }})

{% endif %}