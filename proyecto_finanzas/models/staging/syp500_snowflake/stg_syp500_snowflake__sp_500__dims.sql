WITH source AS (
  SELECT
    *
  FROM {{ ref('base_syp500_snowflake__sp_500') }} AS SP_500
), renamed AS (
  SELECT   
    id_info_dim, /* Clave para obtener las dimensiones de la tabla*/
    simbolo, /* Ticker (identificador de la empresa) */
    pais, /* País de origen del tráfico */
    {{ dbt_utils.generate_surrogate_key(['pais']) }} as id_pais,
    {{ dbt_utils.generate_surrogate_key(['simbolo']) }} as id_simbolo,
    nombre_empresa, /* Nombre de la empresa */
    sitio_web, /* Dominio correspondiente a las métricas */
    fecha /* Fecha correspondiente al dato en UTC granularidad dia*/
  FROM source
)
SELECT
  *
FROM renamed