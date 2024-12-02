{{
    config(
        materialized='incremental',
        unique_key='id_carga_dlt',
        incremental_strategy='merge',
        on_schema_change='fail'    
    )
}}

WITH source AS (
  SELECT

    data1.id_carga_dlt,
    fecha_insercion

  FROM {{ ref('base_api_alpha__DLT_LOADS') }} AS data1

  
)
  SELECT
    *
  FROM source

