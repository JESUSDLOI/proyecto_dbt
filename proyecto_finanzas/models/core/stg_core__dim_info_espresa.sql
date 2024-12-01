WITH source AS (
  SELECT *
    
        
  FROM {{ ref('stg_api_alpha__dims_empresas') }} AS api_alpha
), renamed AS (

SELECT distinct

  idx_CIK,
  direccion,
  descripcion,
  traduccion,
  ambito_neg1,
  ambito_neg2,
  ambito_neg3,
  ambito_neg4,
  ambito_neg5
  /*
  , CONVERT_TIMEZONE('UTC', dbt_updated_at) as updated_at
  , CONVERT_TIMEZONE('UTC', dbt_valid_from) as valid_from
  , CONVERT_TIMEZONE('UTC', dbt_valid_to) as valid_to
*/
  
  FROM source
)

SELECT *
FROM renamed