WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS') }} AS EMPRESA_DATA__INCOME_STATEMENT__QUARTERLY_REPORTS
), renamed AS (
SELECT
    CAST(CONVERT_TIMEZONE('UTC', FISCAL_DATE_ENDING) AS DATE) AS FECHA_FISCAL_FINAL, /* Fecha en la que finaliza el período fiscal, convertida a la zona horaria UTC y luego a formato de fecha */
    CAST(REPORTED_CURRENCY AS VARCHAR(255)) AS MONEDA_REPORTADA, /* Moneda en la que se reportan los datos financieros */
    CAST(GROSS_PROFIT AS NUMERIC(20, 2)) AS UTILIDAD_BRUTA, /* Beneficio bruto obtenido antes de deducir los gastos operativos */
    CAST(TOTAL_REVENUE AS NUMERIC(20, 2)) AS INGRESOS_TOTALES, /* Ingresos totales generados por la empresa */
    CAST(COST_OF_REVENUE AS NUMERIC(20, 2)) AS COSTO_DE_INGRESOS, /* Costos asociados directamente con la generación de ingresos */
    CAST(COSTOF_GOODS_AND_SERVICES_SOLD AS NUMERIC(20, 2)) AS COSTO_DE_BIENES_Y_SERVICIOS_VENDIDOS, /* Costos de los bienes y servicios vendidos */
    CAST(OPERATING_INCOME AS NUMERIC(20, 2)) AS INGRESO_OPERATIVO, /* Ingreso generado por las operaciones principales de la empresa */
    CAST(SELLING_GENERAL_AND_ADMINISTRATIVE AS NUMERIC(20, 2)) AS GASTOS_GENERALES_Y_ADMINISTRATIVOS, /* Gastos relacionados con la venta, administración y otros gastos generales */
    CAST(RESEARCH_AND_DEVELOPMENT AS NUMERIC(20, 2)) AS INVESTIGACION_Y_DESARROLLO, /* Gastos en investigación y desarrollo */
    CAST(OPERATING_EXPENSES AS NUMERIC(20, 2)) AS GASTOS_OPERATIVOS, /* Gastos totales incurridos en las operaciones de la empresa */
    CAST(INVESTMENT_INCOME_NET AS NUMERIC(20, 2)) AS INGRESOS_POR_INVERSION_NETOS, /* Ingresos netos obtenidos de inversiones */
    CAST(NET_INTEREST_INCOME AS NUMERIC(20, 2)) AS INGRESOS_NETOS_POR_INTERESES, /* Ingresos netos obtenidos por intereses */
    CAST(INTEREST_INCOME AS NUMERIC(20, 2)) AS INGRESOS_POR_INTERESES, /* Ingresos obtenidos por intereses */
    CAST(INTEREST_EXPENSE AS NUMERIC(20, 2)) AS GASTOS_POR_INTERESES, /* Gastos incurridos por intereses */
    CAST(NON_INTEREST_INCOME AS NUMERIC(20, 2)) AS INGRESOS_NO_INTERESES, /* Ingresos obtenidos que no están relacionados con intereses */
    CAST(OTHER_NON_OPERATING_INCOME AS NUMERIC(20, 2)) AS OTROS_INGRESOS_NO_OPERATIVOS, /* Otros ingresos obtenidos que no están relacionados con las operaciones principales */
    CAST(DEPRECIATION AS NUMERIC(20, 2)) AS DEPRECIACION, /* Gastos de depreciación de activos */
    CAST(DEPRECIATION_AND_AMORTIZATION AS NUMERIC(20, 2)) AS DEPRECIACION_Y_AMORTIZACION, /* Gastos combinados de depreciación y amortización */
    CAST(INCOME_BEFORE_TAX AS NUMERIC(20, 2)) AS INGRESO_ANTES_DE_IMPUESTOS, /* Ingreso obtenido antes de deducir los impuestos */
    CAST(INCOME_TAX_EXPENSE AS NUMERIC(20, 2)) AS GASTOS_POR_IMPUESTOS, /* Gastos incurridos por impuestos */
    CAST(INTEREST_AND_DEBT_EXPENSE AS NUMERIC(20, 2)) AS GASTOS_POR_INTERESES_Y_DEUDAS, /* Gastos combinados por intereses y deudas */
    CAST(NET_INCOME_FROM_CONTINUING_OPERATIONS AS NUMERIC(20, 2)) AS INGRESO_NETO_DE_OPERACIONES_CONTINUAS, /* Ingreso neto obtenido de operaciones continuas */
    CAST(COMPREHENSIVE_INCOME_NET_OF_TAX AS NUMERIC(20, 2)) AS INGRESO_INTEGRAL_NETO_DE_IMPUESTOS, /* Ingreso integral neto después de impuestos */
    CAST(EBIT AS NUMERIC(20, 2)) AS EBIT, /* Beneficio antes de intereses e impuestos */
    CAST(EBITDA AS NUMERIC(20, 2)) AS EBITDA, /* Beneficio antes de intereses, impuestos, depreciación y amortización */
    CAST(NET_INCOME AS NUMERIC(20, 2)) AS INGRESO_NETO, /* Ingreso neto total */
    CAST(_DLT_ROOT_ID AS VARCHAR(255)) AS _DLT_ID_RAIZ, /* Identificador raíz en el sistema DLT */
    CAST(_DLT_PARENT_ID AS VARCHAR(255)) AS _DLT_ID_PADRE, /* Identificador del padre en el sistema DLT */
    CAST(_DLT_LIST_IDX AS INT) AS _DLT_INDICE_LISTA, /* Índice de lista en el sistema DLT */
    CAST(_DLT_ID AS VARCHAR(255)) AS _DLT_ID /* Identificador único en el sistema DLT */

  FROM source
)
SELECT
  *
FROM renamed