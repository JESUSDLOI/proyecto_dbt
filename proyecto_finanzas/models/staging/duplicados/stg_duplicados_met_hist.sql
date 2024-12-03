

WITH source AS (
  SELECT *
  from {{ ref('stg_metricas_historicas') }} AS empresa_data
    qualify row_number() over(partition by id_simbolo, fecha_carga order by fecha_carga desc) > 1

)


SELECT *
FROM source






