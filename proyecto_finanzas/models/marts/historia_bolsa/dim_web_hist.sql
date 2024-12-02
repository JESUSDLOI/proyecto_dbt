WITH source AS (
  SELECT *

        
  FROM {{ ref('stg_syp500_snowflake__sp_500__dims') }} AS api_alpha

)
SELECT distinct
  id_web_hist
  ,  sitio_web


FROM source