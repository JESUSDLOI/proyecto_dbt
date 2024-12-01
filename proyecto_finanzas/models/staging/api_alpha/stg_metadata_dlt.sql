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

