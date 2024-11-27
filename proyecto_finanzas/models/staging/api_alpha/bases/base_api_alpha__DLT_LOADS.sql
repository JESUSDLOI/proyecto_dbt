WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', '_DLT_LOADS') }} AS _DLT_LOADS
), renamed AS (
  SELECT
    CAST(LOAD_ID AS INT) AS ID_CARGA, /* Identificador único de la carga */
    CAST(SCHEMA_NAME AS VARCHAR(255)) AS NOMBRE_ESQUEMA, /* Nombre del esquema */
    CAST(STATUS AS VARCHAR(255)) AS ESTADO, /* Estado de la carga */
    CAST(CONVERT_TIMEZONE('UTC', INSERTED_AT) AS TIMESTAMP) AS FECHA_INSERCION, /* Fecha y hora en que se insertó la carga en UTC */
    CAST(SCHEMA_VERSION_HASH AS VARCHAR(255)) AS HASH_VERSION_ESQUEMA /* Hash de la versión del esquema */
  FROM source
)
SELECT
  *
FROM renamed