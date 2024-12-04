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
    *
  FROM {{ source('api_alpha', '_DLT_PIPELINE_STATE') }} AS _DLT_PIPELINE_STATE
), renamed AS (
  SELECT
    CAST(VERSION AS INT) AS vers, /* versión del pipeline */
    CAST(ENGINE_VERSION AS VARCHAR(255)) AS version_del_motor, /* versión del motor */
    CAST(PIPELINE_NAME AS VARCHAR(255)) AS nombre_del_pipeline, /* nombre del pipeline */
    CAST(STATE AS VARCHAR(167778)) AS estado, /* estado del pipeline */
    CONVERT_TIMEZONE('UTC', CREATED_AT) AS fecha_de_creacion, /* fecha de creación */
    CAST(VERSION_HASH AS VARCHAR(167778)) AS hash_de_la_version, /* hash de la versión */
    CAST(_DLT_LOAD_ID AS VARCHAR(167778)) AS id_carga_dlt, /* ID de carga DLT */
    CAST(_DLT_ID AS VARCHAR(255)) AS id_dlt /* ID DLT */
  FROM source

)
SELECT
  *
FROM renamed

{% if is_incremental() %}

  where fecha_de_creacion> (select max(fecha_de_creacion) from {{ this }})

{% endif %}