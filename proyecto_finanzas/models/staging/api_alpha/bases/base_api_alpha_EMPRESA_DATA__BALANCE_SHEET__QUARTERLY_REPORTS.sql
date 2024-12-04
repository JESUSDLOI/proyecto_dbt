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
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__BALANCE_SHEET__QUARTERLY_REPORTS') }} AS a


), renamed AS (
  SELECT

    CAST(TRIM(simbolo) AS VARCHAR(255)) AS simbolo, /* simbolo de la empresa */
    {{ dbt_utils.generate_surrogate_key(['simbolo']) }} AS id_simbolo, /* Clave única para identificar los datos de la empresa */
    CONVERT_TIMEZONE('Europe/Paris', 'UTC', TRIM(fecha_carga)) AS fecha_carga, /* fecha de la carga */
    CAST(TRIM(FISCAL_DATE_ENDING) AS DATE) AS fecha_fiscal_final, /* Fecha de finalización del período fiscal */
    CAST(TRIM(REPORTED_CURRENCY) AS VARCHAR(255)) AS moneda, /* Moneda reportada */
    CAST(NULLIF(TRIM(TOTAL_ASSETS), 'None') AS numeric(20, 2)) AS total_activos, /* Total de activos */
    CAST(NULLIF(TRIM(TOTAL_CURRENT_ASSETS), 'None') AS numeric(20, 2)) AS activos_corrientes, /* Activos corrientes */
    CAST(NULLIF(TRIM(CASH_AND_CASH_EQUIVALENTS_AT_CARRYING_VALUE), 'None') AS numeric(20, 2)) AS efectivo_equivalente, /* Efectivo y equivalentes de efectivo */
    CAST(NULLIF(TRIM(CASH_AND_SHORT_TERM_INVESTMENTS), 'None') AS numeric(20, 2)) AS efectivo_inversiones_corto_plazo, /* Inversiones a corto plazo */
    CAST(NULLIF(TRIM(INVENTORY), 'None') AS numeric(20, 2)) AS inventario, /* Inventario */
    CAST(NULLIF(TRIM(CURRENT_NET_RECEIVABLES), 'None') AS numeric(20, 2)) AS cuentas_por_cobrar, /* Cuentas por cobrar netas */
    CAST(NULLIF(TRIM(TOTAL_NON_CURRENT_ASSETS), 'None') AS numeric(20, 2)) AS activos_no_corrientes, /* Activos no corrientes */
    CAST(NULLIF(TRIM(PROPERTY_PLANT_EQUIPMENT), 'None') AS numeric(20, 2)) AS propiedades, /* Propiedades, planta y equipo */
    CAST(NULLIF(TRIM(ACCUMULATED_DEPRECIATION_AMORTIZATION_PPE), 'None') AS numeric(20, 2)) AS depreciacion_acumulada, /* Depreciación acumulada */
    CAST(NULLIF(TRIM(INTANGIBLE_ASSETS), 'None') AS numeric(20, 2)) AS activos_intangibles, /* Activos intangibles */
    CAST(NULLIF(TRIM(INTANGIBLE_ASSETS_EXCLUDING_GOODWILL), 'None') AS numeric(20, 2)) AS activos_intangibles_sin_plusvalia, /* Activos intangibles excluyendo plusvalía */
    CAST(NULLIF(TRIM(GOODWILL), 'None') AS numeric(20, 2)) AS plusvalia, /* Plusvalía */
    CAST(NULLIF(TRIM(INVESTMENTS), 'None') AS numeric(20, 2)) AS inversiones, /* Inversiones */
    CAST(NULLIF(TRIM(LONG_TERM_INVESTMENTS), 'None') AS numeric(20, 2)) AS inversiones_largo_plazo, /* Inversiones a largo plazo */
    CAST(NULLIF(TRIM(SHORT_TERM_INVESTMENTS), 'None') AS numeric(20, 2)) AS inversiones_corto_plazo, /* Inversiones a corto plazo */
    CAST(NULLIF(TRIM(OTHER_CURRENT_ASSETS), 'None') AS numeric(20, 2)) AS otros_activos_corrientes, /* Otros activos corrientes */
    CAST(NULLIF(TRIM(OTHER_NON_CURRENT_ASSETS), 'None') AS numeric(20, 2)) AS otros_activos_no_corrientes, /* Otros activos no corrientes */
    CAST(NULLIF(TRIM(TOTAL_LIABILITIES), 'None') AS numeric(20, 2)) AS total_pasivos, /* Total de pasivos */
    CAST(NULLIF(TRIM(TOTAL_CURRENT_LIABILITIES), 'None') AS numeric(20, 2)) AS pasivos_corrientes, /* Pasivos corrientes */
    CAST(NULLIF(TRIM(CURRENT_ACCOUNTS_PAYABLE), 'None') AS numeric(20, 2)) AS cuentas_por_pagar, /* Cuentas por pagar corrientes */
    CAST(NULLIF(TRIM(DEFERRED_REVENUE), 'None') AS numeric(20, 2)) AS ingresos_diferidos, /* Ingresos diferidos */
    CAST(NULLIF(TRIM(CURRENT_DEBT), 'None') AS numeric(20, 2)) AS deuda_corriente, /* Deuda corriente */
    CAST(NULLIF(TRIM(SHORT_TERM_DEBT), 'None') AS numeric(20, 2)) AS deuda_corto_plazo, /* Deuda a corto plazo */
    CAST(NULLIF(TRIM(TOTAL_NON_CURRENT_LIABILITIES), 'None') AS numeric(20, 2)) AS pasivos_no_corrientes, /* Pasivos no corrientes */
    CAST(NULLIF(TRIM(CAPITAL_LEASE_OBLIGATIONS), 'None') AS numeric(20, 2)) AS obligaciones_arrendamiento, /* Obligaciones de arrendamiento de capital */
    CAST(NULLIF(TRIM(LONG_TERM_DEBT), 'None') AS numeric(20, 2)) AS deuda_largo_plazo, /* Deuda a largo plazo */
    CAST(NULLIF(TRIM(CURRENT_LONG_TERM_DEBT), 'None') AS numeric(20, 2)) AS deuda_corriente_largo_plazo, /* Deuda corriente a largo plazo */
    CAST(NULLIF(TRIM(LONG_TERM_DEBT_NONCURRENT), 'None') AS numeric(20, 2)) AS deuda_no_corriente_largo_plazo, /* Deuda no corriente a largo plazo */
    CAST(NULLIF(TRIM(SHORT_LONG_TERM_DEBT_TOTAL), 'None') AS numeric(20, 2)) AS deuda_total, /* Deuda total a corto y largo plazo */
    CAST(NULLIF(TRIM(OTHER_CURRENT_LIABILITIES), 'None') AS numeric(20, 2)) AS otros_pasivos_corrientes, /* Otros pasivos corrientes */
    CAST(NULLIF(TRIM(OTHER_NON_CURRENT_LIABILITIES), 'None') AS numeric(20, 2)) AS otros_pasivos_no_corrientes, /* Otros pasivos no corrientes */
    CAST(NULLIF(TRIM(TOTAL_SHAREHOLDER_EQUITY), 'None') AS numeric(20, 2)) AS patrimonio_total, /* Patrimonio total de los accionistas */
    CAST(NULLIF(TRIM(TREASURY_STOCK), 'None') AS numeric(20, 2)) AS acciones_tesoreria, /* Acciones en tesorería */
    CAST(NULLIF(TRIM(RETAINED_EARNINGS), 'None') AS numeric(20, 2)) AS ganancias_retenidas, /* Ganancias retenidas */
    CAST(NULLIF(TRIM(COMMON_STOCK), 'None') AS numeric(20, 2)) AS acciones_comunes, /* Acciones comunes */
    CAST(NULLIF(TRIM(COMMON_STOCK_SHARES_OUTSTANDING), 'None') AS numeric(20, 2)) AS acciones_comunes_en_circulacion, /* Acciones comunes en circulación */
    CAST(TRIM(_DLT_PARENT_ID) AS VARCHAR(255)) AS id_padre_dlt, /* ID padre */
    CAST(NULLIF(TRIM(_DLT_LIST_IDX), 'None') AS numeric(20, 2)) AS indice_lista_dlt, /* Índice de lista */
    CAST(TRIM(_DLT_ID) AS VARCHAR(255)) AS id_dlt, /* ID_dato dlt */
    {{ dbt_utils.generate_surrogate_key(['id_simbolo', 'fecha_fiscal_final']) }} as id_metrica /* Clave única para identificar las metricas de la empresa */
  FROM source
  
)
SELECT
  *
FROM renamed


  {% if is_incremental() %}

    where fecha_carga > (select max(fecha_carga) from {{ this }})

  {% endif %}
