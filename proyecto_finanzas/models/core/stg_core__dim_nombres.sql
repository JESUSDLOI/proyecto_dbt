WITH source AS (
  SELECT
        *
      
  FROM {{ ref('stg_api_alpha__dims_empresas') }} AS api_alpha

)
SELECT distinct id_simbolo
  , simbolo
  , nombre_empresa
  /*
  , CONVERT_TIMEZONE('UTC', dbt_updated_at) as updated_at
  , CONVERT_TIMEZONE('UTC', dbt_valid_from) as valid_from
  , CONVERT_TIMEZONE('UTC', dbt_valid_to) as valid_to
*/
FROM source