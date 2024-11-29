WITH source AS (
  SELECT
         *
  FROM {{ ref('stg_api_alpha__dimensiones_empresa') }} AS api_alpha
), renamed AS (

  SELECT

        id_bolsa
        , bolsa
  
  FROM source

)
select distinct id_bolsa
    , bolsa
from renamed