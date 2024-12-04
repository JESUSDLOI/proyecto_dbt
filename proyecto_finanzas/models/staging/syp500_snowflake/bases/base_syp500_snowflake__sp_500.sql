WITH source AS (
  SELECT
    *
  FROM {{ source('syp500_snowflake', 'SP_500') }} AS SP_500
), renamed AS (
  SELECT
    
    CAST(TRIM(ticker) AS VARCHAR(255)) AS simbolo, /* Ticker (identificador de la empresa) */
    {{ dbt_utils.generate_surrogate_key(['simbolo']) }} as id_simbolo_hist, 
    CAST(TRIM(company_name) AS VARCHAR(255)) AS nombre_empresa, /* Nombre de la empresa */
    CAST(TRIM(country) AS VARCHAR(255)) AS pais, /* País de origen del tráfico */
    {{ dbt_utils.generate_surrogate_key(['pais']) }} as id_pais_hist,
    CAST(TRIM(domain) AS VARCHAR(255)) AS sitio_web, /* Dominio correspondiente a las métricas */
    {{ dbt_utils.generate_surrogate_key(['sitio_web']) }} as id_web_hist,
    CONVERT_TIMEZONE('UTC', date) AS fecha, /* Fecha correspondiente al dato en UTC granularidad dia*/
    CAST(NULLIF(trim(desktop_avg_visit_duration), 'None') AS numeric(10, 2)) AS dura_prom_visi_escri, /* Duración promedio de visita en escritorio (en segundos) */
    CAST(NULLIF(trim(desktop_bounce_rate), 'None') AS numeric(5, 2)) AS tasa_rebote_escri, /* Tasa de rebote en escritorio */
    CAST(NULLIF(trim(desktop_pages_per_visit), 'None') AS numeric(10, 2)) AS pag_visi_escri, /* Páginas por visita promedio en escritorio */
    CAST(NULLIF(trim(desktop_visits), 'None') AS numeric(20, 0)) AS visi_escritorio, /* Número estimado de visitas en escritorio */
    CAST(NULLIF(trim(mobile_avg_visit_duration), 'None') AS numeric(10, 2)) AS dura_prom_visi_mvl, /* Duración promedio de visita en móvil (en segundos) */
    CAST(NULLIF(trim(mobile_bounce_rate), 'None') AS numeric(5, 2)) AS tasa_rebote_mvl, /* Tasa de rebote en móvil */
    CAST(NULLIF(trim(mobile_pages_per_visit), 'None') AS numeric(10, 2)) AS pag_por_visi_mvl, /* Páginas por visita promedio en móvil */
    CAST(NULLIF(trim(mobile_visits), 'None') AS numeric(20, 0)) AS visi_mvl, /* Número estimado de visitas en móvil */
    CAST(NULLIF(trim(total_avg_visit_duration), 'None') AS numeric(10, 2)) AS dura_prom_visi_totl, /* Duración promedio de visita total (en segundos) */
    CAST(NULLIF(trim(total_bounce_rate), 'None') AS numeric(5, 2)) AS tasa_rebote_totl, /* Tasa de rebote total */
    CAST(NULLIF(trim(total_pages_per_visit), 'None') AS numeric(10, 2)) AS pag_por_visita_totl, /* Páginas por visita promedio total */
    CAST(NULLIF(trim(total_visits), 'None') AS numeric(20, 0)) AS visi_totl /* Número estimado de visitas totales */
  FROM source
)
SELECT
  *
FROM renamed