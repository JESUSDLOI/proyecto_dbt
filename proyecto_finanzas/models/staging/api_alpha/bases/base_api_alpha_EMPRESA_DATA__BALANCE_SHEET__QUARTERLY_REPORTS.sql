WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__BALANCE_SHEET__QUARTERLY_REPORTS') }} AS EMPRESA_DATA__BALANCE_SHEET__QUARTERLY_REPORTS
), renamed AS (
  SELECT
    CAST(CONVERT_TIMEZONE('UTC', FISCAL_DATE_ENDING) AS DATE) AS fecha_fiscal, /* Fecha de finalización del período fiscal */
    CAST(REPORTED_CURRENCY AS VARCHAR(255)) AS moneda_reportada, /* Moneda reportada */
    CAST(NULLIF(TOTAL_ASSETS, 'None') AS DECIMAL(20, 2)) AS total_activos, /* Total de activos */
    CAST(NULLIF(TOTAL_CURRENT_ASSETS, 'None') AS DECIMAL(20, 2)) AS activos_corrientes, /* Activos corrientes */
    CAST(NULLIF(CASH_AND_CASH_EQUIVALENTS_AT_CARRYING_VALUE, 'None') AS DECIMAL(20, 2)) AS efectivo_equivalente, /* Efectivo y equivalentes de efectivo */
    CAST(NULLIF(CASH_AND_SHORT_TERM_INVESTMENTS, 'None') AS DECIMAL(20, 2)) AS efectivo_inversiones_corto_plazo, /* Inversiones a corto plazo */
    CAST(NULLIF(INVENTORY, 'None') AS DECIMAL(20, 2)) AS inventario, /* Inventario */
    CAST(NULLIF(CURRENT_NET_RECEIVABLES, 'None') AS DECIMAL(20, 2)) AS cuentas_por_cobrar, /* Cuentas por cobrar netas */
    CAST(NULLIF(TOTAL_NON_CURRENT_ASSETS, 'None') AS DECIMAL(20, 2)) AS activos_no_corrientes, /* Activos no corrientes */
    CAST(NULLIF(PROPERTY_PLANT_EQUIPMENT, 'None') AS DECIMAL(20, 2)) AS propiedades, /* Propiedades, planta y equipo */
    CAST(NULLIF(ACCUMULATED_DEPRECIATION_AMORTIZATION_PPE, 'None') AS DECIMAL(20, 2)) AS depreciacion_acumulada, /* Depreciación acumulada */
    CAST(NULLIF(INTANGIBLE_ASSETS, 'None') AS DECIMAL(20, 2)) AS activos_intangibles, /* Activos intangibles */
    CAST(NULLIF(INTANGIBLE_ASSETS_EXCLUDING_GOODWILL, 'None') AS DECIMAL(20, 2)) AS activos_intangibles_sin_plusvalia, /* Activos intangibles excluyendo plusvalía */
    CAST(NULLIF(GOODWILL, 'None') AS DECIMAL(20, 2)) AS plusvalia, /* Plusvalía */
    CAST(NULLIF(INVESTMENTS, 'None') AS DECIMAL(20, 2)) AS inversiones, /* Inversiones */
    CAST(NULLIF(LONG_TERM_INVESTMENTS, 'None') AS DECIMAL(20, 2)) AS inversiones_largo_plazo, /* Inversiones a largo plazo */
    CAST(NULLIF(SHORT_TERM_INVESTMENTS, 'None') AS DECIMAL(20, 2)) AS inversiones_corto_plazo, /* Inversiones a corto plazo */
    CAST(NULLIF(OTHER_CURRENT_ASSETS, 'None') AS DECIMAL(20, 2)) AS otros_activos_corrientes, /* Otros activos corrientes */
    CAST(NULLIF(OTHER_NON_CURRENT_ASSETS, 'None') AS DECIMAL(20, 2)) AS otros_activos_no_corrientes, /* Otros activos no corrientes */
    CAST(NULLIF(TOTAL_LIABILITIES, 'None') AS DECIMAL(20, 2)) AS total_pasivos, /* Total de pasivos */
    CAST(NULLIF(TOTAL_CURRENT_LIABILITIES, 'None') AS DECIMAL(20, 2)) AS pasivos_corrientes, /* Pasivos corrientes */
    CAST(NULLIF(CURRENT_ACCOUNTS_PAYABLE, 'None') AS DECIMAL(20, 2)) AS cuentas_por_pagar, /* Cuentas por pagar corrientes */
    CAST(NULLIF(DEFERRED_REVENUE, 'None') AS DECIMAL(20, 2)) AS ingresos_diferidos, /* Ingresos diferidos */
    CAST(NULLIF(CURRENT_DEBT, 'None') AS DECIMAL(20, 2)) AS deuda_corriente, /* Deuda corriente */
    CAST(NULLIF(SHORT_TERM_DEBT, 'None') AS DECIMAL(20, 2)) AS deuda_corto_plazo, /* Deuda a corto plazo */
    CAST(NULLIF(TOTAL_NON_CURRENT_LIABILITIES, 'None') AS DECIMAL(20, 2)) AS pasivos_no_corrientes, /* Pasivos no corrientes */
    CAST(NULLIF(CAPITAL_LEASE_OBLIGATIONS, 'None') AS DECIMAL(20, 2)) AS obligaciones_arrendamiento, /* Obligaciones de arrendamiento de capital */
    CAST(NULLIF(LONG_TERM_DEBT, 'None') AS DECIMAL(20, 2)) AS deuda_largo_plazo, /* Deuda a largo plazo */
    CAST(NULLIF(CURRENT_LONG_TERM_DEBT, 'None') AS DECIMAL(20, 2)) AS deuda_corriente_largo_plazo, /* Deuda corriente a largo plazo */
    CAST(NULLIF(LONG_TERM_DEBT_NONCURRENT, 'None') AS DECIMAL(20, 2)) AS deuda_no_corriente_largo_plazo, /* Deuda no corriente a largo plazo */
    CAST(NULLIF(SHORT_LONG_TERM_DEBT_TOTAL, 'None') AS DECIMAL(20, 2)) AS deuda_total, /* Deuda total a corto y largo plazo */
    CAST(NULLIF(OTHER_CURRENT_LIABILITIES, 'None') AS DECIMAL(20, 2)) AS otros_pasivos_corrientes, /* Otros pasivos corrientes */
    CAST(NULLIF(OTHER_NON_CURRENT_LIABILITIES, 'None') AS DECIMAL(20, 2)) AS otros_pasivos_no_corrientes, /* Otros pasivos no corrientes */
    CAST(NULLIF(TOTAL_SHAREHOLDER_EQUITY, 'None') AS DECIMAL(20, 2)) AS patrimonio_total, /* Patrimonio total de los accionistas */
    CAST(NULLIF(TREASURY_STOCK, 'None') AS DECIMAL(20, 2)) AS acciones_tesoreria, /* Acciones en tesorería */
    CAST(NULLIF(RETAINED_EARNINGS, 'None') AS DECIMAL(20, 2)) AS ganancias_retenidas, /* Ganancias retenidas */
    CAST(NULLIF(COMMON_STOCK, 'None') AS DECIMAL(20, 2)) AS acciones_comunes, /* Acciones comunes */
    CAST(NULLIF(COMMON_STOCK_SHARES_OUTSTANDING, 'None') AS DECIMAL(20, 2)) AS acciones_comunes_en_circulacion, /* Acciones comunes en circulación */
    CAST(_DLT_ROOT_ID AS VARCHAR(255)) AS id_raiz, /* ID raíz */
    CAST(_DLT_PARENT_ID AS VARCHAR(255)) AS id_padre, /* ID padre */
    CAST(NULLIF(_DLT_LIST_IDX, 'None') AS DECIMAL(20, 2)) AS indice_lista, /* Índice de lista */
    CAST(_DLT_ID AS VARCHAR(255)) AS id /* ID_dato dlt*/
  FROM source
)
SELECT
  *
FROM renamed