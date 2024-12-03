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
  FROM {{ source('api_alpha', '_DLT_LOADS') }} AS _DLT_LOADS
), renamed AS (

  SELECT
    CAST(LOAD_ID AS VARCHAR(167778)) AS id_carga_dlt, /* Identificador único de la carga */
    CAST(SCHEMA_NAME AS VARCHAR(167778)) AS nombre_esquema, /* Nombre del esquema */
    CAST(STATUS AS VARCHAR(167778)) AS estado, /* Estado de la carga */
    CONVERT_TIMEZONE('UTC', CAST(INSERTED_AT AS TIMESTAMP)) AS fecha_insercion, /* Fecha y hora en que se insertó la carga en UTC */
    CAST(SCHEMA_VERSION_HASH AS VARCHAR(255)) AS hash_version_esquema /* Hash de la versión del esquema */
  FROM source
)

SELECT
  *
FROM renamed

{% if is_incremental() %}

  where fecha_insercion> (select max(fecha_insercion) from {{ this }})

{% endif %}