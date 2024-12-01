WITH source AS (
  SELECT

    empresa.simbolo as simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    fecha_trimestre,
    ingresos_totales,
    ingreso_neto,
    dura_prom_visi_escri_qurtr,
    tasa_rebote_escri_qurtr,
    pag_visi_escri_qurtr,
    visi_escritorio_qurtr,
    dura_prom_visi_mvl_qurtr,
    tasa_rebote_mvl_qurtr,
    pag_por_visi_mvl_qurtr,
    visi_mvl_qurtr,
    dura_prom_visi_totl_qurtr,
    tasa_rebote_totl_qurtr,
    pag_por_visita_totl_qurtr,
    visi_totl_qurtr

  FROM {{ ref('stg_api_alpha__metricas_historicas') }} AS metricas
  left join {{ ref('stg_core__dim_nombres') }} as empresa
      on metricas.id_simbolo = empresa.id_simbolo
    left join {{ ref('int_visitas_web_trimestre') }} as visitas
      on  metricas.id_simbolo = visitas.id_simbolo_hist and metricas.fecha_fiscal_final = visitas.fecha_trimestre

), renamed as(

SELECT 
    simbolo,
    nombre_empresa,
    fecha_fiscal_final,
    fecha_trimestre,
    visi_totl_qurtr,
    ingresos_totales,
    ingreso_neto,
    ingresos_totales / visi_totl_qurtr AS ingresos_por_visi,
    ingreso_neto / visi_totl_qurtr AS utilidad_por_visi,
    (visi_totl_qurtr - LAG(visi_totl_qurtr) OVER (PARTITION BY simbolo, fecha_fiscal_final ORDER BY fecha_fiscal_final)) / 
    LAG(visi_totl_qurtr) OVER (PARTITION BY simbolo ORDER BY fecha_fiscal_final) * 100 AS crecimiento_visitas,
    (ingresos_totales - LAG(ingresos_totales) OVER (PARTITION BY simbolo, fecha_fiscal_final ORDER BY fecha_fiscal_final)) / 
    LAG(ingresos_totales) OVER (PARTITION BY simbolo ORDER BY fecha_fiscal_final) * 100 AS crecimiento_ingresos

FROM source
where fecha_trimestre is not null

ORDER BY simbolo, fecha_fiscal_final
)
SELECT
    *
FROM renamed
