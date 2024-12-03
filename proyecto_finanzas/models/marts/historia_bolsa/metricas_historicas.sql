{{
    config(
        materialized='incremental',
        unique_key=['id_metrica'],
        incremental_strategy='merge',
        on_schema_change='fail'    
    )
}}


WITH source AS (
  SELECT *
  from {{ ref('stg_metricas_historicas') }} AS empresa_data


)
, deduplicate_cte AS ( 
  {{ dbt_utils.deduplicate(
    relation='source',
    partition_by='id_metrica',
    order_by='fecha_carga desc',
   )
}}
)

SELECT *
FROM deduplicate_cte

{% if is_incremental() %}

  where fecha_carga > (select max(fecha_carga) from {{ this }})

{% endif %}
