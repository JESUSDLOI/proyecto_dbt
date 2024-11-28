WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__CASH_FLOW__QUARTERLY_REPORTS') }} AS EMPRESA_DATA__CASH_FLOW__QUARTERLY_REPORTS
), renamed AS (
SELECT
    CAST(TRIM(CONVERT_TIMEZONE('UTC', FISCAL_DATE_ENDING)) AS DATE) AS fecha_fiscal_final, /* Fecha de finalización del período fiscal en formato de fecha */
    CAST(TRIM(REPORTED_CURRENCY) AS VARCHAR(255)) AS moneda, /* Moneda en la que se reportan los datos financieros */
    CAST(NULLIF(TRIM(OPERATING_CASHFLOW), 'None') AS NUMERIC(20, 2)) AS flujo_efectivo_operativo, /* Flujo de efectivo generado por las actividades operativas */
    CAST(NULLIF(TRIM(PAYMENTS_FOR_OPERATING_ACTIVITIES), 'None') AS NUMERIC(20, 2)) AS pagos_actividades_operativas, /* Pagos realizados por actividades operativas */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_OPERATING_ACTIVITIES), 'None') AS NUMERIC(20, 2)) AS ingresos_actividades_operativas, /* Ingresos obtenidos de actividades operativas */
    CAST(NULLIF(TRIM(CHANGE_IN_OPERATING_LIABILITIES), 'None') AS NUMERIC(20, 2)) AS cambio_pasivos_operativos, /* Cambio en los pasivos operativos durante el período */
    CAST(NULLIF(TRIM(CHANGE_IN_OPERATING_ASSETS), 'None') AS NUMERIC(20, 2)) AS cambio_activos_operativos, /* Cambio en los activos operativos durante el período */
    CAST(NULLIF(TRIM(DEPRECIATION_DEPLETION_AND_AMORTIZATION), 'None') AS NUMERIC(20, 2)) AS depreciacion_amortizacion, /* Gastos de depreciación, agotamiento y amortización */
    CAST(NULLIF(TRIM(CAPITAL_EXPENDITURES), 'None') AS NUMERIC(20, 2)) AS gastos_capital, /* Gastos de capital realizados durante el período */
    CAST(NULLIF(TRIM(CHANGE_IN_RECEIVABLES), 'None') AS NUMERIC(20, 2)) AS cambio_cuentas_por_cobrar, /* Cambio en las cuentas por cobrar */
    CAST(NULLIF(TRIM(CHANGE_IN_INVENTORY), 'None') AS NUMERIC(20, 2)) AS cambio_inventario, /* Cambio en el inventario */
    CAST(NULLIF(TRIM(PROFIT_LOSS), 'None') AS NUMERIC(20, 2)) AS ganancia_perdida, /* Ganancia o pérdida neta del período */
    CAST(NULLIF(TRIM(CASHFLOW_FROM_INVESTMENT), 'None') AS NUMERIC(20, 2)) AS flujo_efectivo_inversion, /* Flujo de efectivo generado por actividades de inversión */
    CAST(NULLIF(TRIM(CASHFLOW_FROM_FINANCING), 'None') AS NUMERIC(20, 2)) AS flujo_efectivo_financiamiento, /* Flujo de efectivo generado por actividades de financiamiento */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_REPAYMENTS_OF_SHORT_TERM_DEBT), 'None') AS NUMERIC(20, 2)) AS ingresos_reembolsos_deuda_corto_plazo, /* Ingresos por reembolsos de deuda a corto plazo */
    CAST(NULLIF(TRIM(PAYMENTS_FOR_REPURCHASE_OF_COMMON_STOCK), 'None') AS NUMERIC(20, 2)) AS pagos_recompra_acciones_comunes, /* Pagos realizados para la recompra de acciones comunes */
    CAST(NULLIF(TRIM(PAYMENTS_FOR_REPURCHASE_OF_EQUITY), 'None') AS NUMERIC(20, 2)) AS pagos_recompra_capital, /* Pagos realizados para la recompra de capital */
    CAST(NULLIF(TRIM(PAYMENTS_FOR_REPURCHASE_OF_PREFERRED_STOCK), 'None') AS NUMERIC(20, 2)) AS pagos_recompra_acciones_preferentes, /* Pagos realizados para la recompra de acciones preferentes */
    CAST(NULLIF(TRIM(DIVIDEND_PAYOUT), 'None') AS NUMERIC(20, 2)) AS pago_dividendos, /* Pago total de dividendos */
    CAST(NULLIF(TRIM(DIVIDEND_PAYOUT_COMMON_STOCK), 'None') AS NUMERIC(20, 2)) AS pago_dividendos_acciones_comunes, /* Pago de dividendos de acciones comunes */
    CAST(NULLIF(TRIM(DIVIDEND_PAYOUT_PREFERRED_STOCK), 'None') AS NUMERIC(20, 2)) AS pago_dividendos_acciones_preferentes, /* Pago de dividendos de acciones preferentes */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_ISSUANCE_OF_COMMON_STOCK), 'None') AS NUMERIC(20, 2)) AS ingresos_emision_acciones_comunes, /* Ingresos por emisión de acciones comunes */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_ISSUANCE_OF_LONG_TERM_DEBT_AND_CAPITAL_SECURITIES_NET), 'None') AS NUMERIC(20, 2)) AS ingresos_emision_deuda_largo_plazo, /* Ingresos netos por emisión de deuda a largo plazo y valores de capital */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_ISSUANCE_OF_PREFERRED_STOCK), 'None') AS NUMERIC(20, 2)) AS ingresos_emision_acciones_preferentes, /* Ingresos por emisión de acciones preferentes */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_REPURCHASE_OF_EQUITY), 'None') AS NUMERIC(20, 2)) AS ingresos_recompra_capital, /* Ingresos por recompra de capital */
    CAST(NULLIF(TRIM(PROCEEDS_FROM_SALE_OF_TREASURY_STOCK), 'None') AS NUMERIC(20, 2)) AS ingresos_venta_acciones_tesoreria, /* Ingresos por venta de acciones de tesorería */
    CAST(NULLIF(TRIM(CHANGE_IN_CASH_AND_CASH_EQUIVALENTS), 'None') AS NUMERIC(20, 2)) AS cambio_efectivo_equivalentes, /* Cambio en efectivo y equivalentes de efectivo */
    CAST(NULLIF(TRIM(CHANGE_IN_EXCHANGE_RATE), 'None') AS NUMERIC(20, 2)) AS cambio_tipo_cambio, /* Cambio en el tipo de cambio */
    CAST(NULLIF(TRIM(NET_INCOME), 'None') AS NUMERIC(20, 2)) AS ingreso_neto, /* Ingreso neto del período */
    CAST(TRIM(_DLT_ROOT_ID) AS VARCHAR(255)) AS id_raiz_dlt, /* Identificador raíz DLT */
    CAST(TRIM(_DLT_PARENT_ID) AS VARCHAR(255)) AS id_padre_dlt, /* Identificador padre DLT */
    CAST(TRIM(_DLT_LIST_IDX) AS INTEGER) AS indice_lista_dlt, /* Índice de lista DLT */
    CAST(TRIM(_DLT_ID) AS VARCHAR(255)) AS id_dlt /* Identificador DLT */
  FROM source
)
SELECT
  *
FROM renamed