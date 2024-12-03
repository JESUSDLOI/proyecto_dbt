

WITH source AS (
  SELECT *
  from {{ ref('stg_metricas_historicas') }} AS empresa_data
    qualify row_number() over(partition by id_metrica, fecha_carga order by fecha_carga desc) > 1

),
renamed AS (

SELECT 

    source.id_simbolo,
    source.fecha_carga,
    source.fecha_fiscal_final,
    source.id_metrica,
    source.utilidad_bruta,
    source.ingresos_totales,
    source.costo_de_ingresos,
    source.costo_de_bienes_y_servicios_vendidos,
    source.ingreso_operativo,
    source.gastos_generales_y_administrativos,
    source.investigacion_y_desarrollo,
    source.gastos_operativos,
    source.ingresos_por_inversion_netos,
    source.ingresos_netos_por_intereses,
    source.ingresos_por_intereses,
    source.gastos_por_intereses,
    source.ingresos_no_intereses,
    source.otros_ingresos_no_operativos,
    source.depreciacion,
    source.depreciacion_y_amortizacion,
    source.ingreso_antes_de_impuestos,
    source.gastos_por_impuestos,
    source.gastos_por_intereses_y_deudas,
    source.ingreso_neto_de_operaciones_continuas,
    source.ingreso_integral_neto_de_impuestos,
    source.ebit,
    source.ebitda,
    source.ingreso_neto,
    source.id_padre_dlt,
    source.indice_lista_dlt,
    source.id_dlt,
    source.flujo_efectivo_operativo,
    source.pagos_actividades_operativas,
    source.ingresos_actividades_operativas,
    source.cambio_pasivos_operativos,
    source.cambio_activos_operativos,
    source.depreciacion_amortizacion,
    source.gastos_capital,
    source.cambio_cuentas_por_cobrar,
    source.cambio_inventario,
    source.ganancia_perdida,
    source.flujo_efectivo_inversion,
    source.flujo_efectivo_financiamiento,
    source.ingresos_reembolsos_deuda_corto_plazo,
    source.pagos_recompra_acciones_comunes,
    source.pagos_recompra_capital,
    source.pagos_recompra_acciones_preferentes,
    source.pago_dividendos,
    source.pago_dividendos_acciones_comunes,
    source.pago_dividendos_acciones_preferentes,
    source.ingresos_emision_acciones_comunes,
    source.ingresos_emision_deuda_largo_plazo,
    source.ingresos_emision_acciones_preferentes,
    source.ingresos_recompra_capital,
    source.ingresos_venta_acciones_tesoreria,
    source.cambio_efectivo_equivalentes,
    source.cambio_tipo_cambio,
    source.total_activos,
    source.activos_corrientes,
    source.efectivo_equivalente,
    source.efectivo_inversiones_corto_plazo,
    source.inventario,
    source.cuentas_por_cobrar,
    source.activos_no_corrientes,
    source.propiedades,
    source.depreciacion_acumulada,
    source.activos_intangibles,
    source.activos_intangibles_sin_plusvalia,
    source.plusvalia,
    source.inversiones,
    source.inversiones_largo_plazo,
    source.inversiones_corto_plazo,
    source.otros_activos_corrientes,
    source.otros_activos_no_corrientes,
    source.total_pasivos,
    source.pasivos_corrientes,
    source.cuentas_por_pagar,
    source.ingresos_diferidos,
    source.deuda_corriente,
    source.deuda_corto_plazo,
    source.pasivos_no_corrientes,
    source.obligaciones_arrendamiento,
    source.deuda_largo_plazo,
    source.deuda_corriente_largo_plazo,
    source.deuda_no_corriente_largo_plazo,
    source.deuda_total,
    source.otros_pasivos_corrientes,
    source.otros_pasivos_no_corrientes,
    source.patrimonio_total,
    source.acciones_tesoreria,
    source.ganancias_retenidas,
    source.acciones_comunes,
    source.acciones_comunes_en_circulacion
FROM source
left join {{ ref('stg_metricas_historicas') }} as b
    on source.id_metrica = b.id_metrica and source.fecha_carga = b.fecha_carga

)

select * from renamed






