WITH source AS (
  SELECT
    *
  FROM {{ ref('base_syp500_snowflake__sp_500') }} AS SP_500
), renamed AS (
  SELECT   
        
    simbolo, /* Ticker (identificador de la empresa) */
    pais, /* País de origen del tráfico */
    id_pais_hist,
    id_simbolo_hist,
    nombre_empresa, /* Nombre de la empresa */
    id_web_hist,
    sitio_web, /* Dominio correspondiente a las métricas */
    fecha /* Fecha correspondiente al dato en UTC granularidad dia*/
  FROM source
)
SELECT
  *
FROM renamed