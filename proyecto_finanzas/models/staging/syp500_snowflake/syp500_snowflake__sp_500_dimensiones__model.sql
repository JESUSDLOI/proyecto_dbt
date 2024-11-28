WITH source AS (
  SELECT
    *
  FROM {{ ref('base_syp500_snowflake__sp_500') }} AS SP_500
), renamed AS (
  SELECT   
    id_info_dim /* Clave para obtener las dimensiones de la tabla*/ /* Ticker (identificador de la empresa) */
    {{ dbt_utils.generate_surrogate_key([ticker]) }} as id_ticker,
    nombre_empresa, /* Nombre de la empresa */
    dominio, /* Dominio correspondiente a las métricas */
    {{ dbt_utils.generate_surrogate_key([ticker]) }} as id_pais,
    fecha /* Fecha correspondiente al dato en UTC granularidad dia*/
    

    FROM source
)
SELECT
  *
FROM renamed