WITH source AS (
  SELECT
          id_simbolo
        , simbolo
        , nombre_empresa
        
        
  FROM {{ ref('stg_api_alpha__dimensiones_empresa') }} AS api_alpha

union all

  SELECT
        id_simbolo
        , simbolo
        , nombre_empresa
        
        

  FROM {{ ref('stg_syp500_snowflake__sp_500__dims') }} AS SP_500
)
SELECT distinct id_simbolo
  , simbolo
  , nombre_empresa
  
FROM source