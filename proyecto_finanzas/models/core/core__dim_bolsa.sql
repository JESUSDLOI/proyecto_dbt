WITH source AS (
  SELECT
         *
  FROM {{ ref('stg_api_alpha__dims_empresas') }} AS api_alpha
), renamed AS (

SELECT distinct

        id_bolsa
        , bolsa
        , valid_from
        , valid_to

  FROM source

)
select *
from renamed