WITH source AS (
  SELECT
    *,
    snowflake.cortex.translate(descripcion, 'en', 'es') AS traduccion,
    SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
      descripcion,
      'What are all the different businesses, services, or products the company offers? with one word separated by commas'
    )::string AS Respuesta_cortex
  /* Añade la función de cortex para traducir y extraer la respuesta */
  FROM {{ ref('base_api_alpha_empresa_data') }} AS empresa_data
), renamed AS (
  SELECT
    simbolo,
    id_ticker,
    tipo_activo,
    nombre_empresa,
    descripcion,
    traduccion,
    REGEXP_SUBSTR(Respuesta_cortex, '\\\"[^\"]+\\\"', 1, 2) AS respuesta_extraida, /* Extrae la respuesta de cortex traducida*/
    idx_CIK,
    bolsa,
    moneda,
    pais,
    sector,
    industria,
    direccion,
    sitio_web,
    id_carga,
    id
  FROM source
)
SELECT
  id_ticker,
  simbolo,
  tipo_activo,
  nombre_empresa,
  descripcion,
  traduccion,
  respuesta_extraida,
  -- Extrae los sectores de la respuesta de cortex
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[0], ' ') AS sector1,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[1], ' ') AS sector2,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[2], ' ') AS sector3,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[3], ' ') AS sector4,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[4], ' ') AS sector5,
  idx_CIK,
  bolsa,
  moneda,
  pais,
  sector,
  industria,
  direccion,
  sitio_web,
  id_carga,
  id
FROM renamed