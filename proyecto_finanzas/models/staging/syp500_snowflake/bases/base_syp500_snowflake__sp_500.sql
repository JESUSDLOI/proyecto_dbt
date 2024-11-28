WITH source AS (
  SELECT
    *
  FROM {{ source('syp500_snowflake', 'SP_500') }} AS SP_500
), renamed AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['ticker']) }} AS id_ticker, /* Clave única para identificar los datos de la empresa */
    CAST(company_name AS VARCHAR(255)) AS nombre_empresa, /* Nombre de la empresa */
    CAST(country AS VARCHAR(255)) AS pais, /* País de origen del tráfico */
    CAST(CONVERT_TIMEZONE('UTC', date) AS DATE) AS fecha, /* Fecha correspondiente al dato en UTC granularidad dia*/
    CAST(desktop_avg_visit_duration AS DECIMAL(10, 2)) AS dura_prom_visi_escri, /* Duración promedio de visita en escritorio (en segundos) */
    CAST(desktop_bounce_rate AS DECIMAL(5, 2)) AS tasa_rebote_escri, /* Tasa de rebote en escritorio */
    CAST(desktop_pages_per_visit AS DECIMAL(10, 2)) AS pag_visi_escri, /* Páginas por visita promedio en escritorio */
    CAST(desktop_visits AS DECIMAL(20, 0)) AS visi_escritorio, /* Número estimado de visitas en escritorio */
    CAST(domain AS VARCHAR(255)) AS dominio, /* Dominio correspondiente a las métricas */
    {{ dbt_utils.generate_surrogate_key(['id_ticker', 'visi_escritorio', 'fecha']) }} AS datos_visitas_escritorio, /* Clave única para identificar los datos de visitas en escritorio */
    CAST(mobile_avg_visit_duration AS DECIMAL(10, 2)) AS dura_prom_visi_mvl, /* Duración promedio de visita en móvil (en segundos) */
    CAST(mobile_bounce_rate AS DECIMAL(5, 2)) AS tasa_rebote_mvl, /* Tasa de rebote en móvil */
    CAST(mobile_pages_per_visit AS DECIMAL(10, 2)) AS pag_por_visi_mvl, /* Páginas por visita promedio en móvil */
    CAST(mobile_visits AS DECIMAL(20, 0)) AS visi_mvl, /* Número estimado de visitas en móvil */
    {{ dbt_utils.generate_surrogate_key(['id_ticker', 'visi_mvl', 'fecha']) }} AS datos_visitas_movil, /* Clave única para identificar los datos de visitas en móvil */
    CAST(ticker AS VARCHAR(255)) AS ticker, /* Ticker (identificador de la empresa) */
    CAST(total_avg_visit_duration AS DECIMAL(10, 2)) AS dura_prom_visi_totl, /* Duración promedio de visita total (en segundos) */
    CAST(total_bounce_rate AS DECIMAL(5, 2)) AS tasa_rebote_totl, /* Tasa de rebote total */
    CAST(total_pages_per_visit AS DECIMAL(10, 2)) AS pag_por_visita_totl, /* Páginas por visita promedio total */
    CAST(total_visits AS DECIMAL(20, 0)) AS visi_totl, /* Número estimado de visitas totales */
    {{ dbt_utils.generate_surrogate_key(['id_ticker', 'visi_totl', 'fecha']) }} AS datos_visitas_totales /* Clave única para identificar los datos de visitas totales */
  FROM source
)
SELECT
  *
FROM renamed