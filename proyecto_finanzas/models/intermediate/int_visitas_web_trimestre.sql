
WITH source AS (
    SELECT
        *,
        {{ trunc_ultimo_dia_trimes('fecha') }} AS fecha_trimestre
        
    FROM {{ ref('stg_syp500_snowflake__sp_500__hechos_web') }} as visitas
), renamed AS (
    SELECT 
        id_simbolo_hist,
        fecha_trimestre,
        SUM(dura_prom_visi_escri) AS dura_prom_visi_escri_qurtr,
        SUM(tasa_rebote_escri) AS tasa_rebote_escri_qurtr,
        SUM(pag_visi_escri) AS pag_visi_escri_qurtr,
        SUM(visi_escritorio) AS visi_escritorio_qurtr,
        SUM(dura_prom_visi_mvl) AS dura_prom_visi_mvl_qurtr,
        SUM(tasa_rebote_mvl) AS tasa_rebote_mvl_qurtr,
        SUM(pag_por_visi_mvl) AS pag_por_visi_mvl_qurtr,
        SUM(visi_mvl) AS visi_mvl_qurtr,
        SUM(dura_prom_visi_totl) AS dura_prom_visi_totl_qurtr,
        SUM(tasa_rebote_totl) AS tasa_rebote_totl_qurtr,
        SUM(pag_por_visita_totl) AS pag_por_visita_totl_qurtr,
        SUM(visi_totl) AS visi_totl_qurtr
    FROM source
    GROUP BY id_simbolo_hist, fecha_trimestre
    ORDER BY id_simbolo_hist, fecha_trimestre
)

SELECT
    *
FROM renamed