{{
    config(
        materialized='incremental',
        unique_key='id_simbolo',
        incremental_strategy='delete+insert',
        on_schema_change='fail'    
    )
}}

WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS') }} AS EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS

  {% if is_incremental() %}

    where fecha_carga > (select max(fecha_carga) from {{ this }})

  {% endif %}

), renamed AS (
SELECT

    CAST(TRIM(simbolo) AS VARCHAR(255)) AS simbolo, /* simbolo de la empresa */
    {{ dbt_utils.generate_surrogate_key(['simbolo']) }} AS id_simbolo, /* Clave única para identificar los datos de la empresa */
    CAST(TRIM(fecha_carga) AS VARCHAR(255)) AS fecha_carga, /* fecha de la carga */
    CAST(TRIM(FISCAL_DATE_ENDING) AS DATE) AS fecha_fiscal_final, /* Fecha en la que finaliza el período fiscal, convertida a la zona horaria UTC y luego a formato de fecha */
    CAST(REPORTED_CURRENCY AS VARCHAR(255)) AS moneda_reportada, /* Moneda en la que se reportan los datos financieros */
    CAST(NULLIF(GROSS_PROFIT, 'None') AS NUMERIC(20, 2)) AS utilidad_bruta, /* Beneficio bruto obtenido antes de deducir los gastos operativos */
    CAST(NULLIF(TOTAL_REVENUE, 'None') AS NUMERIC(20, 2)) AS ingresos_totales, /* Ingresos totales generados por la empresa */
    CAST(NULLIF(COST_OF_REVENUE, 'None') AS NUMERIC(20, 2)) AS costo_de_ingresos, /* Costos asociados directamente con la generación de ingresos */
    CAST(NULLIF(COSTOF_GOODS_AND_SERVICES_SOLD, 'None') AS NUMERIC(20, 2)) AS costo_de_bienes_y_servicios_vendidos, /* Costos de los bienes y servicios vendidos */
    CAST(NULLIF(OPERATING_INCOME, 'None') AS NUMERIC(20, 2)) AS ingreso_operativo, /* Ingreso generado por las operaciones principales de la empresa */
    CAST(NULLIF(SELLING_GENERAL_AND_ADMINISTRATIVE, 'None') AS NUMERIC(20, 2)) AS gastos_generales_y_administrativos, /* Gastos relacionados con la venta, administración y otros gastos generales */
    CAST(NULLIF(RESEARCH_AND_DEVELOPMENT, 'None') AS NUMERIC(20, 2)) AS investigacion_y_desarrollo, /* Gastos en investigación y desarrollo */
    CAST(NULLIF(OPERATING_EXPENSES, 'None') AS NUMERIC(20, 2)) AS gastos_operativos, /* Gastos totales incurridos en las operaciones de la empresa */
    CAST(NULLIF(INVESTMENT_INCOME_NET, 'None') AS NUMERIC(20, 2)) AS ingresos_por_inversion_netos, /* Ingresos netos obtenidos de inversiones */
    CAST(NULLIF(NET_INTEREST_INCOME, 'None') AS NUMERIC(20, 2)) AS ingresos_netos_por_intereses, /* Ingresos netos obtenidos por intereses */
    CAST(NULLIF(INTEREST_INCOME, 'None') AS NUMERIC(20, 2)) AS ingresos_por_intereses, /* Ingresos obtenidos por intereses */
    CAST(NULLIF(INTEREST_EXPENSE, 'None') AS NUMERIC(20, 2)) AS gastos_por_intereses, /* Gastos incurridos por intereses */
    CAST(NULLIF(NON_INTEREST_INCOME, 'None') AS NUMERIC(20, 2)) AS ingresos_no_intereses, /* Ingresos obtenidos que no están relacionados con intereses */
    CAST(NULLIF(OTHER_NON_OPERATING_INCOME, 'None') AS NUMERIC(20, 2)) AS otros_ingresos_no_operativos, /* Otros ingresos obtenidos que no están relacionados con las operaciones principales */
    CAST(NULLIF(DEPRECIATION, 'None') AS NUMERIC(20, 2)) AS depreciacion, /* Gastos de depreciación de activos */
    CAST(NULLIF(DEPRECIATION_AND_AMORTIZATION, 'None') AS NUMERIC(20, 2)) AS depreciacion_y_amortizacion, /* Gastos combinados de depreciación y amortización */
    CAST(NULLIF(INCOME_BEFORE_TAX, 'None') AS NUMERIC(20, 2)) AS ingreso_antes_de_impuestos, /* Ingreso obtenido antes de deducir los impuestos */
    CAST(NULLIF(INCOME_TAX_EXPENSE, 'None') AS NUMERIC(20, 2)) AS gastos_por_impuestos, /* Gastos incurridos por impuestos */
    CAST(NULLIF(INTEREST_AND_DEBT_EXPENSE, 'None') AS NUMERIC(20, 2)) AS gastos_por_intereses_y_deudas, /* Gastos combinados por intereses y deudas */
    CAST(NULLIF(NET_INCOME_FROM_CONTINUING_OPERATIONS, 'None') AS NUMERIC(20, 2)) AS ingreso_neto_de_operaciones_continuas, /* Ingreso neto obtenido de operaciones continuas */
    CAST(NULLIF(COMPREHENSIVE_INCOME_NET_OF_TAX, 'None') AS NUMERIC(20, 2)) AS ingreso_integral_neto_de_impuestos, /* Ingreso integral neto después de impuestos */
    CAST(NULLIF(EBIT, 'None') AS NUMERIC(20, 2)) AS ebit, /* Beneficio antes de intereses e impuestos */
    CAST(NULLIF(EBITDA, 'None') AS NUMERIC(20, 2)) AS ebitda, /* Beneficio antes de intereses, impuestos, depreciación y amortización */
    CAST(NULLIF(NET_INCOME, 'None') AS NUMERIC(20, 2)) AS ingreso_neto, /* Ingreso neto total */
    CAST(_DLT_PARENT_ID AS VARCHAR(255)) AS id_padre_dlt, /* Identificador del padre en el sistema DLT */
    CAST(_DLT_LIST_IDX AS INT) AS indice_lista_dlt, /* Índice de lista en el sistema DLT */
    CAST(_DLT_ID AS VARCHAR(255)) AS id_dlt /* Identificador único en el sistema DLT */

  FROM source
)
SELECT
  *
FROM renamed

