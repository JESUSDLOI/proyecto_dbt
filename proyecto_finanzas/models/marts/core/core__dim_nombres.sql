WITH source AS (
  SELECT
        *
      
  FROM {{ ref('stg_api_alpha__dims_empresas') }} AS api_alpha

)
SELECT distinct id_simbolo
  , simbolo
  , nombre_empresa
  --, valid_from
  --, valid_to

FROM source