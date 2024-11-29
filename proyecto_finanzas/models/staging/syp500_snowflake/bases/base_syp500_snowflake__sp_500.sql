WITH source AS (
  SELECT
    *
  FROM {{ source('syp500_snowflake', 'SP_500') }} AS SP_500
), renamed AS (
  SELECT
    
    CAST(TRIM(ticker) AS VARCHAR(255)) AS simbolo, /* Ticker (identificador de la empresa) */
    CAST(TRIM(company_name) AS VARCHAR(255)) AS nombre_empresa, /* Nombre de la empresa */
    CAST(TRIM(country) AS VARCHAR(255)) AS pais, /* País de origen del tráfico */
    CAST(TRIM(domain) AS VARCHAR(255)) AS sitio_web, /* Dominio correspondiente a las métricas */
    CAST(CONVERT_TIMEZONE('UTC', date) AS DATE) AS fecha, /* Fecha correspondiente al dato en UTC granularidad dia*/
    {{ dbt_utils.generate_surrogate_key(['simbolo', 'fecha', 'sitio_web']) }} AS id_info_dim, /* Clave para obtener las dimensiones de la tabla*/
    NULLIF(CAST(trim(desktop_avg_visit_duration) AS numeric(10, 2)), 'None') AS dura_prom_visi_escri, /* Duración promedio de visita en escritorio (en segundos) */
    NULLIF(CAST(trim(desktop_bounce_rate) AS numeric(5, 2)), 'None') AS tasa_rebote_escri, /* Tasa de rebote en escritorio */
    NULLIF(CAST(trim(desktop_pages_per_visit) AS numeric(10, 2)), 'None') AS pag_visi_escri, /* Páginas por visita promedio en escritorio */
    NULLIF(CAST(trim(desktop_visits) AS numeric(20, 0)), 'None') AS visi_escritorio, /* Número estimado de visitas en escritorio */
    NULLIF(CAST(trim(mobile_avg_visit_duration) AS numeric(10, 2)), 'None') AS dura_prom_visi_mvl, /* Duración promedio de visita en móvil (en segundos) */
    NULLIF(CAST(trim(mobile_bounce_rate) AS numeric(5, 2)), 'None') AS tasa_rebote_mvl, /* Tasa de rebote en móvil */
    NULLIF(CAST(trim(mobile_pages_per_visit) AS numeric(10, 2)), 'None') AS pag_por_visi_mvl, /* Páginas por visita promedio en móvil */
    NULLIF(CAST(trim(mobile_visits) AS numeric(20, 0)), 'None') AS visi_mvl, /* Número estimado de visitas en móvil */
    NULLIF(CAST(trim(total_avg_visit_duration) AS numeric(10, 2)), 'None') AS dura_prom_visi_totl, /* Duración promedio de visita total (en segundos) */
    NULLIF(CAST(trim(total_bounce_rate) AS numeric(5, 2)), 'None') AS tasa_rebote_totl, /* Tasa de rebote total */
    NULLIF(CAST(trim(total_pages_per_visit) AS numeric(10, 2)), 'None') AS pag_por_visita_totl, /* Páginas por visita promedio total */
    NULLIF(CAST(trim(total_visits) AS numeric(20, 0)), 'None') AS visi_totl /* Número estimado de visitas totales */
  FROM source
)
SELECT
  *
FROM renamed