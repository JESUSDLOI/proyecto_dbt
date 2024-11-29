WITH source AS (
  SELECT *
    
        
  FROM {{ ref('stg_api_alpha__dimensiones_empresa') }} AS api_alpha
), renamed AS (
  SELECT
  idx_CIK,
  direccion,
  descripcion,
  traduccion,
  ambito_neg1,
  ambito_neg2,
  ambito_neg3,
  ambito_neg4,
  ambito_neg5
  
  FROM source
)

SELECT *
FROM renamed