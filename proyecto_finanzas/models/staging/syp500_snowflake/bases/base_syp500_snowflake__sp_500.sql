    
{{ config(materialized='table') }}

with source as (
      select * from {{ source('syp500_snowflake', 'SP_500') }}
),
renamed as (
   SELECT

    company_name::VARCHAR(255) AS nombre_empresa,                           -- Nombre de la empresa
    country::VARCHAR(255) AS pais,                                          -- País de origen del tráfico
    date::DATE AS fecha,                                                    -- Fecha correspondiente al dato
    desktop_avg_visit_duration::NUMERIC(10, 2) AS dura_prom_visi_escri,     -- Duración promedio de visita en escritorio (en segundos)
    desktop_bounce_rate::NUMERIC(5, 2) AS tasa_rebote_escri,                -- Tasa de rebote en escritorio
    desktop_pages_per_visit::NUMERIC(10, 2) AS pag_visi_escri,              -- Páginas por visita promedio en escritorio
    desktop_visits::NUMERIC(20, 0) AS visi_escritorio,                      -- Número estimado de visitas en escritorio
    domain::VARCHAR(255) AS dominio,                                        -- Dominio correspondiente a las métricas
    mobile_avg_visit_duration::NUMERIC(10, 2) AS dura_prom_visi_mvl,        -- Duración promedio de visita en móvil (en segundos)
    mobile_bounce_rate::NUMERIC(5, 2) AS tasa_rebote_mvl,                   -- Tasa de rebote en móvil
    mobile_pages_per_visit::NUMERIC(10, 2) AS pag_por_visi_mvl,             -- Páginas por visita promedio en móvil
    mobile_visits::NUMERIC(20, 0) AS visi_mvl,                              -- Número estimado de visitas en móvil
    ticker::VARCHAR(255) AS id_ticker,                                      -- Ticker (identificador de la empresa)
    total_avg_visit_duration::NUMERIC(10, 2) AS dura_prom_visi_totl,        -- Duración promedio de visita total (en segundos)
    total_bounce_rate::NUMERIC(5, 2) AS tasa_rebote_totl,                   -- Tasa de rebote total
    total_pages_per_visit::NUMERIC(10, 2) AS pag_por_visita_totl,           -- Páginas por visita promedio total
    total_visits::NUMERIC(20, 0) AS visi_totl                               -- Número estimado de visitas totales

    
    from source
)
select * from renamed