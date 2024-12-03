

WITH source AS (
  SELECT *
  from {{ ref('stg_metricas_historicas') }} AS empresa_data
    qualify row_number() over(partition by id_metrica, fecha_carga order by fecha_carga desc) > 1

),
renamed AS (

SELECT *
FROM source
left join {{ ref('stg_metricas_historicas') }} as b
    on source.id_metrica = b.id_metrica and source.fecha_carga = b.fecha_carga

)

select * from renamed






