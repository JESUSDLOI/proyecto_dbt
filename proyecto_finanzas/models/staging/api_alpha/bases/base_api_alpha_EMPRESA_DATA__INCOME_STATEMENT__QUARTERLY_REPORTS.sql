WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS') }} AS EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS
), renamed AS (
SELECT
    CAST(TRIM(CONVERT_TIMEZONE('UTC', fiscal_date_ending)) AS DATE) AS fecha_fiscal_final, /* Fecha en la que finaliza el período fiscal, convertida a la zona horaria UTC y luego a formato de fecha */
    CAST(TRIM(reported_currency) AS VARCHAR(255)) AS moneda, /* Moneda en la que se reportan los datos financieros */
    CAST(NULLIF(TRIM(gross_profit), 'None') AS NUMERIC(20, 2)) AS utilidad_bruta, /* Beneficio bruto obtenido antes de deducir los gastos operativos */
    CAST(NULLIF(TRIM(total_revenue), 'None') AS NUMERIC(20, 2)) AS ingresos_totales, /* Ingresos totales generados por la empresa */
    CAST(NULLIF(TRIM(cost_of_revenue), 'None') AS NUMERIC(20, 2)) AS costo_de_ingresos, /* Costos asociados directamente con la generación de ingresos */
    CAST(NULLIF(TRIM(costof_goods_and_services_sold), 'None') AS NUMERIC(20, 2)) AS costo_de_bienes_y_servicios_vendidos, /* Costos de los bienes y servicios vendidos */
    CAST(NULLIF(TRIM(operating_income), 'None') AS NUMERIC(20, 2)) AS ingreso_operativo, /* Ingreso generado por las operaciones principales de la empresa */
    CAST(NULLIF(TRIM(selling_general_and_administrative), 'None') AS NUMERIC(20, 2)) AS gastos_generales_y_administrativos, /* Gastos relacionados con la venta, administración y otros gastos generales */
    CAST(NULLIF(TRIM(research_and_development), 'None') AS NUMERIC(20, 2)) AS investigacion_y_desarrollo, /* Gastos en investigación y desarrollo */
    CAST(NULLIF(TRIM(operating_expenses), 'None') AS NUMERIC(20, 2)) AS gastos_operativos, /* Gastos totales incurridos en las operaciones de la empresa */
    CAST(NULLIF(TRIM(investment_income_net), 'None') AS NUMERIC(20, 2)) AS ingresos_por_inversion_netos, /* Ingresos netos obtenidos de inversiones */
    CAST(NULLIF(TRIM(net_interest_income), 'None') AS NUMERIC(20, 2)) AS ingresos_netos_por_intereses, /* Ingresos netos obtenidos por intereses */
    CAST(NULLIF(TRIM(interest_income), 'None') AS NUMERIC(20, 2)) AS ingresos_por_intereses, /* Ingresos obtenidos por intereses */
    CAST(NULLIF(TRIM(interest_expense), 'None') AS NUMERIC(20, 2)) AS gastos_por_intereses, /* Gastos incurridos por intereses */
    CAST(NULLIF(TRIM(non_interest_income), 'None') AS NUMERIC(20, 2)) AS ingresos_no_intereses, /* Ingresos obtenidos que no están relacionados con intereses */
    CAST(NULLIF(TRIM(other_non_operating_income), 'None') AS NUMERIC(20, 2)) AS otros_ingresos_no_operativos, /* Otros ingresos obtenidos que no están relacionados con las operaciones principales */
    CAST(NULLIF(TRIM(depreciation), 'None') AS NUMERIC(20, 2)) AS depreciacion, /* Gastos de depreciación de activos */
    CAST(NULLIF(TRIM(depreciation_and_amortization), 'None') AS NUMERIC(20, 2)) AS depreciacion_y_amortizacion, /* Gastos combinados de depreciación y amortización */
    CAST(NULLIF(TRIM(income_before_tax), 'None') AS NUMERIC(20, 2)) AS ingreso_antes_de_impuestos, /* Ingreso obtenido antes de deducir los impuestos */
    CAST(NULLIF(TRIM(income_tax_expense), 'None') AS NUMERIC(20, 2)) AS gastos_por_impuestos, /* Gastos incurridos por impuestos */
    CAST(NULLIF(TRIM(interest_and_debt_expense), 'None') AS NUMERIC(20, 2)) AS gastos_por_intereses_y_deudas, /* Gastos combinados por intereses y deudas */
    CAST(NULLIF(TRIM(net_income_from_continuing_operations), 'None') AS NUMERIC(20, 2)) AS ingreso_neto_de_operaciones_continuas, /* Ingreso neto obtenido de operaciones continuas */
    CAST(NULLIF(TRIM(comprehensive_income_net_of_tax), 'None') AS NUMERIC(20, 2)) AS ingreso_integral_neto_de_impuestos, /* Ingreso integral neto después de impuestos */
    CAST(NULLIF(TRIM(ebit), 'None') AS NUMERIC(20, 2)) AS ebit, /* Beneficio antes de intereses e impuestos */
    CAST(NULLIF(TRIM(ebitda), 'None') AS NUMERIC(20, 2)) AS ebitda, /* Beneficio antes de intereses, impuestos, depreciación y amortización */
    CAST(NULLIF(TRIM(net_income), 'None') AS NUMERIC(20, 2)) AS ingreso_neto, /* Ingreso neto total */
    CAST(TRIM(_dlt_root_id) AS VARCHAR(255)) AS id_raiz_dlt, /* Identificador raíz en el sistema DLT */
    CAST(TRIM(_dlt_parent_id) AS VARCHAR(255)) AS id_padre_dlt, /* Identificador del padre en el sistema DLT */
    CAST(TRIM(_dlt_list_idx) AS INT) AS indice_lista_dlt, /* Índice de lista en el sistema DLT */
    CAST(TRIM(_dlt_id) AS VARCHAR(255)) AS id_dlt /* Identificador único en el sistema DLT */

  FROM source
)
SELECT
  *
FROM renamed