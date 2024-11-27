WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__CASH_FLOW__QUARTERLY_REPORTS') }} AS EMPRESA_DATA__CASH_FLOW__QUARTERLY_REPORTS
), renamed AS (
SELECT
    CAST(CONVERT_TIMEZONE('UTC', FISCAL_DATE_ENDING) AS DATE) AS fecha_fin_fiscal, /* Fecha de finalización del período fiscal en formato de fecha */
    CAST(REPORTED_CURRENCY AS VARCHAR(255)) AS moneda_reportada, /* Moneda en la que se reportan los datos financieros */
    CAST(OPERATING_CASHFLOW AS NUMERIC(20, 2)) AS flujo_efectivo_operativo, /* Flujo de efectivo generado por las actividades operativas */
    CAST(PAYMENTS_FOR_OPERATING_ACTIVITIES AS NUMERIC(20, 2)) AS pagos_actividades_operativas, /* Pagos realizados por actividades operativas */
    CAST(PROCEEDS_FROM_OPERATING_ACTIVITIES AS NUMERIC(20, 2)) AS ingresos_actividades_operativas, /* Ingresos obtenidos de actividades operativas */
    CAST(CHANGE_IN_OPERATING_LIABILITIES AS NUMERIC(20, 2)) AS cambio_pasivos_operativos, /* Cambio en los pasivos operativos durante el período */
    CAST(CHANGE_IN_OPERATING_ASSETS AS NUMERIC(20, 2)) AS cambio_activos_operativos, /* Cambio en los activos operativos durante el período */
    CAST(DEPRECIATION_DEPLETION_AND_AMORTIZATION AS NUMERIC(20, 2)) AS depreciacion_amortizacion, /* Gastos de depreciación, agotamiento y amortización */
    CAST(CAPITAL_EXPENDITURES AS NUMERIC(20, 2)) AS gastos_capital, /* Gastos de capital realizados durante el período */
    CAST(CHANGE_IN_RECEIVABLES AS NUMERIC(20, 2)) AS cambio_cuentas_por_cobrar, /* Cambio en las cuentas por cobrar */
    CAST(CHANGE_IN_INVENTORY AS NUMERIC(20, 2)) AS cambio_inventario, /* Cambio en el inventario */
    CAST(PROFIT_LOSS AS NUMERIC(20, 2)) AS ganancia_perdida, /* Ganancia o pérdida neta del período */
    CAST(CASHFLOW_FROM_INVESTMENT AS NUMERIC(20, 2)) AS flujo_efectivo_inversion, /* Flujo de efectivo generado por actividades de inversión */
    CAST(CASHFLOW_FROM_FINANCING AS NUMERIC(20, 2)) AS flujo_efectivo_financiamiento, /* Flujo de efectivo generado por actividades de financiamiento */
    CAST(PROCEEDS_FROM_REPAYMENTS_OF_SHORT_TERM_DEBT AS NUMERIC(20, 2)) AS ingresos_reembolsos_deuda_corto_plazo, /* Ingresos por reembolsos de deuda a corto plazo */
    CAST(PAYMENTS_FOR_REPURCHASE_OF_COMMON_STOCK AS NUMERIC(20, 2)) AS pagos_recompra_acciones_comunes, /* Pagos realizados para la recompra de acciones comunes */
    CAST(PAYMENTS_FOR_REPURCHASE_OF_EQUITY AS NUMERIC(20, 2)) AS pagos_recompra_capital, /* Pagos realizados para la recompra de capital */
    CAST(PAYMENTS_FOR_REPURCHASE_OF_PREFERRED_STOCK AS NUMERIC(20, 2)) AS pagos_recompra_acciones_preferentes, /* Pagos realizados para la recompra de acciones preferentes */
    CAST(DIVIDEND_PAYOUT AS NUMERIC(20, 2)) AS pago_dividendos, /* Pago total de dividendos */
    CAST(DIVIDEND_PAYOUT_COMMON_STOCK AS NUMERIC(20, 2)) AS pago_dividendos_acciones_comunes, /* Pago de dividendos de acciones comunes */
    CAST(DIVIDEND_PAYOUT_PREFERRED_STOCK AS NUMERIC(20, 2)) AS pago_dividendos_acciones_preferentes, /* Pago de dividendos de acciones preferentes */
    CAST(PROCEEDS_FROM_ISSUANCE_OF_COMMON_STOCK AS NUMERIC(20, 2)) AS ingresos_emision_acciones_comunes, /* Ingresos por emisión de acciones comunes */
    CAST(PROCEEDS_FROM_ISSUANCE_OF_LONG_TERM_DEBT_AND_CAPITAL_SECURITIES_NET AS NUMERIC(20, 2)) AS ingresos_emision_deuda_largo_plazo, /* Ingresos netos por emisión de deuda a largo plazo y valores de capital */
    CAST(PROCEEDS_FROM_ISSUANCE_OF_PREFERRED_STOCK AS NUMERIC(20, 2)) AS ingresos_emision_acciones_preferentes, /* Ingresos por emisión de acciones preferentes */
    CAST(PROCEEDS_FROM_REPURCHASE_OF_EQUITY AS NUMERIC(20, 2)) AS ingresos_recompra_capital, /* Ingresos por recompra de capital */
    CAST(PROCEEDS_FROM_SALE_OF_TREASURY_STOCK AS NUMERIC(20, 2)) AS ingresos_venta_acciones_tesoreria, /* Ingresos por venta de acciones de tesorería */
    CAST(CHANGE_IN_CASH_AND_CASH_EQUIVALENTS AS NUMERIC(20, 2)) AS cambio_efectivo_equivalentes, /* Cambio en efectivo y equivalentes de efectivo */
    CAST(CHANGE_IN_EXCHANGE_RATE AS NUMERIC(20, 2)) AS cambio_tipo_cambio, /* Cambio en el tipo de cambio */
    CAST(NET_INCOME AS NUMERIC(20, 2)) AS ingreso_neto, /* Ingreso neto del período */
    CAST(_DLT_ROOT_ID AS VARCHAR(255)) AS id_raiz_dlt, /* Identificador raíz DLT */
    CAST(_DLT_PARENT_ID AS VARCHAR(255)) AS id_padre_dlt, /* Identificador padre DLT */
    CAST(_DLT_LIST_IDX AS INTEGER) AS indice_lista_dlt, /* Índice de lista DLT */
    CAST(_DLT_ID AS VARCHAR(255)) AS id_dlt /* Identificador DLT */
  FROM source
SELECT
  *
FROM renamed