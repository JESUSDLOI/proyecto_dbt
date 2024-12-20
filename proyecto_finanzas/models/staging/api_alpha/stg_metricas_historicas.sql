{{
    config(
        materialized='incremental',
        unique_key=['id_metrica'],
        incremental_strategy='merge',
        on_schema_change='fail'    
    )
}}


WITH source AS (
  SELECT
    a.id_simbolo,
    a.fecha_carga,
    cast(DATE_TRUNC('month',a.fecha_fiscal_final) as date) as fecha_fiscal_final,
    a.id_metrica,
    utilidad_bruta,
    ingresos_totales,
    costo_de_ingresos,
    costo_de_bienes_y_servicios_vendidos,
    ingreso_operativo,
    gastos_generales_y_administrativos,
    investigacion_y_desarrollo,
    gastos_operativos,
    ingresos_por_inversion_netos,
    ingresos_netos_por_intereses,
    ingresos_por_intereses,
    gastos_por_intereses,
    ingresos_no_intereses,
    otros_ingresos_no_operativos,
    depreciacion,
    depreciacion_y_amortizacion,
    ingreso_antes_de_impuestos,
    gastos_por_impuestos,
    gastos_por_intereses_y_deudas,
    ingreso_neto_de_operaciones_continuas,
    ingreso_integral_neto_de_impuestos,
    ebit,
    c.ebitda,
    b.ingreso_neto,
    a.id_padre_dlt,
    a.indice_lista_dlt,
    a.id_dlt,
    flujo_efectivo_operativo,
    pagos_actividades_operativas,
    ingresos_actividades_operativas,
    cambio_pasivos_operativos,
    cambio_activos_operativos,
    depreciacion_amortizacion,
    gastos_capital,
    cambio_cuentas_por_cobrar,
    cambio_inventario,
    ganancia_perdida,
    flujo_efectivo_inversion,
    flujo_efectivo_financiamiento,
    ingresos_reembolsos_deuda_corto_plazo,
    pagos_recompra_acciones_comunes,
    pagos_recompra_capital,
    pagos_recompra_acciones_preferentes,
    pago_dividendos,
    pago_dividendos_acciones_comunes,
    pago_dividendos_acciones_preferentes,
    ingresos_emision_acciones_comunes,
    ingresos_emision_deuda_largo_plazo,
    ingresos_emision_acciones_preferentes,
    ingresos_recompra_capital,
    ingresos_venta_acciones_tesoreria,
    cambio_efectivo_equivalentes,
    cambio_tipo_cambio,
    total_activos,
    activos_corrientes,
    efectivo_equivalente,
    efectivo_inversiones_corto_plazo,
    inventario,
    cuentas_por_cobrar,
    activos_no_corrientes,
    propiedades,
    depreciacion_acumulada,
    activos_intangibles,
    activos_intangibles_sin_plusvalia,
    plusvalia,
    inversiones,
    inversiones_largo_plazo,
    inversiones_corto_plazo,
    otros_activos_corrientes,
    otros_activos_no_corrientes,
    total_pasivos,
    pasivos_corrientes,
    cuentas_por_pagar,
    ingresos_diferidos,
    deuda_corriente,
    deuda_corto_plazo,
    pasivos_no_corrientes,
    obligaciones_arrendamiento,
    deuda_largo_plazo,
    deuda_corriente_largo_plazo,
    deuda_no_corriente_largo_plazo,
    deuda_total,
    otros_pasivos_corrientes,
    otros_pasivos_no_corrientes,
    patrimonio_total,
    acciones_tesoreria,
    ganancias_retenidas,
    acciones_comunes,
    acciones_comunes_en_circulacion
  FROM {{ ref('base_api_alpha_EMPRESA_DATA__BALANCE_SHEET__QUARTERLY_REPORTS') }} AS a
  inner join {{ ref('base_api_alpha_EMPRESA_DATA__CASH_FLOW__QUARTERLY_REPORTS') }} as b
      on a.id_padre_dlt = b.id_padre_dlt and a.fecha_fiscal_final = b.fecha_fiscal_final
  inner join {{ ref('base_api_alpha_EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS') }} as c
      on a.id_padre_dlt = c.id_padre_dlt and a.fecha_fiscal_final = c.fecha_fiscal_final

)


SELECT *
FROM source

{% if is_incremental() %}

  where fecha_carga > (select max(fecha_carga) from {{ this }})

{% endif %}