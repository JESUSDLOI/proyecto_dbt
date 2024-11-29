WITH source AS (
  SELECT
    *
  FROM {{ ref('base_syp500_snowflake__sp_500') }} AS SP_500
), renamed AS (
  SELECT
    id_info_dim,
    dura_prom_visi_escri,
    tasa_rebote_escri,
    pag_visi_escri,
    visi_escritorio,
    dura_prom_visi_mvl,
    tasa_rebote_mvl,
    pag_por_visi_mvl,
    visi_mvl,
    dura_prom_visi_totl,
    tasa_rebote_totl,
    pag_por_visita_totl,
    visi_totl
  FROM source
)
SELECT
  *
FROM renamed