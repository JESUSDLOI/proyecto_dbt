WITH source AS (
  SELECT *

        
  FROM {{ ref('stg_syp500_snowflake__sp_500__dims') }} AS api_alpha

)
SELECT distinct
  id_simbolo_hist
  ,  simbolo
  , nombre_empresa


FROM source