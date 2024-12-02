

WITH source AS (
  SELECT
    *,
    snowflake.cortex.translate(descripcion, 'en', 'es') AS traduccion,
    SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
      descripcion,
      'What are all the different businesses, services, or products the company offers? with one word separated by commas'
    )::string AS Respuesta_cortex
  /* Añade la función de cortex para traducir y extraer la respuesta */
  FROM {{ ref('snapshot__empresa_data') }} AS empresa_data
  where dbt_valid_to is null

), renamed AS (
  SELECT

  idx_CIK,
  direccion,
  descripcion,
  traduccion,
  REGEXP_SUBSTR(Respuesta_cortex, '\\\"[^\"]+\\\"', 1, 2) AS respuesta_extraida, /* Extrae la respuesta de cortex traducida*/
  id_simbolo,
  simbolo,
  nombre_empresa,
  id_web,
  sitio_web,
  tipo_activo,
  id_activo, /* Clave única para identificar los datos de la empresa */
  sector,
  id_sector, /* Clave única para identificar los datos del sector */
  industria,
  id_industria, /* Clave única para identificar los datos de la industria */
  bolsa,
  id_bolsa, /* Clave única para identificar los datos de la bolsa */
  moneda,
  id_moneda, /* Clave única para identificar los datos de la moneda */
  id_pais, /* Clave única para identificar los datos del país */
  pais,
  id_raiz_dlt,
  nombre_del_pipeline,
  fecha_de_creacion,
  fecha_insercion,
  CONVERT_TIMEZONE('UTC',dbt_updated_at) as updated_at,
  CONVERT_TIMEZONE('UTC', dbt_valid_from) as valid_from,
  CONVERT_TIMEZONE('UTC', dbt_valid_to) AS valid_to
  
  FROM source
)
SELECT
  idx_CIK,
  direccion,
  descripcion,
  traduccion,
  -- Extrae los sectores de la respuesta de cortex
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[0], ' ') AS ambito_neg1,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[1], ' ') AS ambito_neg2,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[2], ' ') AS ambito_neg3,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[3], ' ') AS ambito_neg4,
  TRIM(SPLIT(TRIM(respuesta_extraida, '"'), ',')[4], ' ') AS ambito_neg5,
  id_simbolo,
  simbolo,
  nombre_empresa,
  id_web,
  sitio_web,
  tipo_activo,
  id_activo, /* Clave única para identificar los datos de la empresa */
  sector,
  id_sector, /* Clave única para identificar los datos del sector */
  industria,
  id_industria, /* Clave única para identificar los datos de la industria */
  bolsa,
  id_bolsa, /* Clave única para identificar los datos de la bolsa */
  moneda,
  id_moneda, /* Clave única para identificar los datos de la moneda */
  id_pais, /* Clave única para identificar los datos del país */
  pais,
  id_raiz_dlt,
  nombre_del_pipeline,
  fecha_de_creacion,
  fecha_insercion,
  updated_at,
  valid_from,
  valid_to
  

FROM renamed


