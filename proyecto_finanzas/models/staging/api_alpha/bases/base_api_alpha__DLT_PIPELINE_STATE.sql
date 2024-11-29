WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', '_DLT_PIPELINE_STATE') }} AS _DLT_PIPELINE_STATE
), renamed AS (
  SELECT
    CAST(VERSION AS INT) AS VERSION, /* Versión del pipeline */
    CAST(ENGINE_VERSION AS VARCHAR(255)) AS VERSION_DEL_MOTOR, /* Versión del motor */
    CAST(PIPELINE_NAME AS VARCHAR(255)) AS NOMBRE_DEL_PIPELINE, /* Nombre del pipeline */
    CAST(STATE AS VARCHAR(255)) AS ESTADO, /* Estado del pipeline */
    CAST(CREATED_AT AS TIMESTAMP) AS FECHA_DE_CREACION, /* Fecha de creación */
    CAST(VERSION_HASH AS VARCHAR(255)) AS HASH_DE_LA_VERSION, /* Hash de la versión */
    CAST(_DLT_LOAD_ID AS INT) AS ID_DE_CARGA_DLT, /* ID de carga DLT */
    CAST(_DLT_ID AS INT) AS ID_DLT /* ID DLT */
  FROM source
)
SELECT
  *
FROM renamed