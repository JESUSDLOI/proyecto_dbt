WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'empresa_data') }} AS empresa_data
), renamed AS (
  SELECT
    
    CAST(TRIM(OVERVIEW__SYMBOL) AS VARCHAR(255)) AS simbolo,
    {{ dbt_utils.generate_surrogate_key(['simbolo']) }} AS id_simbolo, /* Clave única para identificar los datos de la empresa */
    CAST(TRIM(OVERVIEW__ASSET_TYPE) AS VARCHAR(255)) AS tipo_activo, /* Tipo de activo (Equity, ETF, etc.) */
    CAST(TRIM(OVERVIEW__NAME) AS VARCHAR(255)) AS nombre_empresa,
    CAST(TRIM(OVERVIEW__DESCRIPTION) AS VARCHAR(16777216)) AS descripcion,
    CAST(TRIM(OVERVIEW__CIK) AS VARCHAR(255)) AS idx_CIK, /* Indice de Clasificación de la Comisión de Bolsa y Valores */
    CAST(TRIM(OVERVIEW__EXCHANGE) AS VARCHAR(255)) AS bolsa, /* Bolsa de valores */
    CAST(TRIM(OVERVIEW__CURRENCY) AS VARCHAR(255)) AS moneda,
    CAST(TRIM(OVERVIEW__COUNTRY) AS VARCHAR(255)) AS pais,
    CAST(TRIM(OVERVIEW__SECTOR) AS VARCHAR(255)) AS sector,
    CAST(TRIM(OVERVIEW__INDUSTRY) AS VARCHAR(255)) AS industria,
    CAST(TRIM(OVERVIEW__ADDRESS) AS VARCHAR(255)) AS direccion,
    CAST(TRIM(OVERVIEW__OFFICIAL_SITE) AS VARCHAR(16777216)) AS sitio_web,
    CAST(TRIM(OVERVIEW__FISCAL_YEAR_END) AS VARCHAR(255)) AS fin_anyo_fiscal, /* Mes escrito */
    CONVERT_TIMEZONE('UTC', CAST(TRIM(OVERVIEW__LATEST_QUARTER) AS DATE)) AS ultimo_trimestre,
    CAST(NULLIF(TRIM(OVERVIEW__MARKET_CAPITALIZATION), 'None') AS DECIMAL(20, 2)) AS capitalizacion_mercado,
    CAST(NULLIF(TRIM(OVERVIEW__EBITDA), 'None') AS DECIMAL(20, 2)) AS ebitda, /* Ganancias antes de intereses, impuestos, depreciación y amortización. */
    CAST(NULLIF(TRIM(OVERVIEW__PE_RATIO), 'None') AS DECIMAL(10, 2)) AS ratio_precio_ganancia, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM), */
    CAST(NULLIF(TRIM(OVERVIEW__PEG_RATIO), 'None') AS DECIMAL(10, 2)) AS ratio_peg, /* Relación precio-ganancias ajustada al crecimiento.(OVERVIEW__PE_RATIO / OVERVIEW__EPS), */
    CAST(NULLIF(TRIM(OVERVIEW__BOOK_VALUE), 'None') AS DECIMAL(20, 2)) AS valor_contable,
    CAST(NULLIF(TRIM(OVERVIEW__DIVIDEND_PER_SHARE), 'None') AS DECIMAL(10, 2)) AS dividendo_por_accion,
    CAST(NULLIF(TRIM(OVERVIEW__DIVIDEND_YIELD), 'None') AS DECIMAL(5, 2)) AS rend_div_accion_porc, /* (OVERVIEW__DIVIDEND_PER_SHARE / OVERVIEW__MARKET_CAPITALIZATION) */
    CAST(NULLIF(TRIM(OVERVIEW__EPS), 'None') AS DECIMAL(10, 2)) AS ganancia_por_accion, /* (OVERVIEW__EPS), */
    CAST(NULLIF(TRIM(OVERVIEW__REVENUE_PER_SHARE_TTM), 'None') AS DECIMAL(20, 2)) AS ingresos_por_accion, /* (OVERVIEW__REVENUE_TTM / OVERVIEW__SHARES_OUTSTANDING) (Ingresos por acción), */
    CAST(NULLIF(TRIM(OVERVIEW__PROFIT_MARGIN), 'None') AS DECIMAL(5, 2)) AS margen_ganancia, /* (OVERVIEW__NET_INCOME_TTM / OVERVIEW__REVENUE_TTM) (Margen de ganancia), */
    CAST(NULLIF(TRIM(OVERVIEW__OPERATING_MARGIN_TTM), 'None') AS DECIMAL(5, 2)) AS margen_operativo, /* (OVERVIEW__OPERATING_INCOME_TTM / OVERVIEW__REVENUE_TTM) (Margen operativo), */
    CAST(NULLIF(TRIM(OVERVIEW__RETURN_ON_ASSETS_TTM), 'None') AS DECIMAL(5, 2)) AS retn_sobre_activos, /* (OVERVIEW__NET_INCOME_TTM / OVERVIEW__TOTAL_ASSETS) (Retorno sobre activos), */
    CAST(NULLIF(TRIM(OVERVIEW__RETURN_ON_EQUITY_TTM), 'None') AS DECIMAL(5, 2)) AS retn_sobre_patri, /* (OVERVIEW__NET_INCOME_TTM / OVERVIEW__SHARES_OUTSTANDING) (Ganancia por acción), */
    CAST(NULLIF(TRIM(OVERVIEW__REVENUE_TTM), 'None') AS DECIMAL(20, 2)) AS ingresos_acci_anyo,
    CAST(NULLIF(TRIM(OVERVIEW__GROSS_PROFIT_TTM), 'None') AS DECIMAL(20, 2)) AS beneficio_bruto,
    CAST(NULLIF(TRIM(OVERVIEW__DILUTED_EPSTTM), 'None') AS DECIMAL(10, 2)) AS eps_diluido, /* Ganancias por acción diluidas el último año */
    CAST(NULLIF(TRIM(OVERVIEW__QUARTERLY_EARNINGS_GROWTH_YOY), 'None') AS DECIMAL(5, 2)) AS crec_gana_trim, /* Crecimiento de las ganancias trimestrales interanual */
    CAST(NULLIF(TRIM(OVERVIEW__QUARTERLY_REVENUE_GROWTH_YOY), 'None') AS DECIMAL(5, 2)) AS crec_ingre_trim, /* Crecimiento de los ingresos trimestrales interanual */
    CAST(NULLIF(TRIM(OVERVIEW__ANALYST_TARGET_PRICE), 'None') AS DECIMAL(10, 2)) AS precio_obj_anali, /* Precio objetivo del analista */
    CAST(NULLIF(TRIM(OVERVIEW__TRAILING_PE), 'None') AS DECIMAL(10, 2)) AS precio_ganan, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM) (Precio/Ganancia) */
    CAST(NULLIF(TRIM(OVERVIEW__FORWARD_PE), 'None') AS DECIMAL(10, 2)) AS precio_ganan_fut, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM) (Precio/Ganancia futuro) */
    CAST(NULLIF(TRIM(OVERVIEW__PRICE_TO_SALES_RATIO_TTM), 'None') AS DECIMAL(10, 2)) AS rat_precio_venta, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__REVENUE_TTM) (Precio/Ventas) */
    CAST(NULLIF(TRIM(OVERVIEW__PRICE_TO_BOOK_RATIO), 'None') AS DECIMAL(10, 2)) AS rat_precio_valor, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__BOOK_VALUE) (Precio/Valor) */
    CAST(NULLIF(TRIM(OVERVIEW__EV_TO_REVENUE), 'None') AS DECIMAL(10, 2)) AS valor_ingresos, /* (OVERVIEW__ENTERPRISE_VALUE / OVERVIEW__REVENUE_TTM) (Valor de la empresa/Ingresos) */
    CAST(NULLIF(TRIM(OVERVIEW__EV_TO_EBITDA), 'None') AS DECIMAL(10, 2)) AS valor_ebitda, /* (OVERVIEW__ENTERPRISE_VALUE / OVERVIEW__EBITDA) (Valor de la empresa/EBITDA) */
    CAST(NULLIF(TRIM(OVERVIEW__BETA), 'None') AS DECIMAL(5, 2)) AS beta, /* Beta (coeficiente de riesgo) */
    CAST(NULLIF(TRIM(OVERVIEW___52_WEEK_HIGH), 'None') AS DECIMAL(10, 2)) AS valor_max_sem_52, /* Máximo de 52 semanas */
    CAST(NULLIF(TRIM(OVERVIEW___52_WEEK_LOW), 'None') AS DECIMAL(10, 2)) AS valor_min_sem_52, /* Mínimo de 52 semanas */
    CAST(NULLIF(TRIM(OVERVIEW___50_DAY_MOVING_AVERAGE), 'None') AS DECIMAL(10, 2)) AS media_movil_50_dias, /* Media móvil de 50 días */
    CAST(NULLIF(TRIM(OVERVIEW___200_DAY_MOVING_AVERAGE), 'None') AS DECIMAL(10, 2)) AS media_movil_200_dias, /* Media móvil de 200 días */
    CAST(NULLIF(TRIM(OVERVIEW__SHARES_OUTSTANDING), 'None') AS DECIMAL(20, 0)) AS acciones_circulando, /* Número de acciones en circulación */
    CONVERT_TIMEZONE('UTC', CAST(NULLIF(TRIM(OVERVIEW__DIVIDEND_DATE), 'None') AS DATE)) AS fecha_divid, /* Fecha en la que se paga el dividendo */
    CONVERT_TIMEZONE('UTC', CAST(NULLIF(TRIM(OVERVIEW__EX_DIVIDEND_DATE), 'None') AS DATE)) AS fecha_ex_divid, /* Fecha en la que una acción se negocia sin el dividendo */
    CAST(TRIM(_DLT_LOAD_ID) AS VARCHAR(255)) AS id_carga_dlt, /* Id de la carga */
    CAST(TRIM(_DLT_ID) AS VARCHAR(255)) AS id_raiz_dlt,/* Id del registro */
    {{ dbt_utils.generate_surrogate_key(['moneda']) }} AS id_moneda, /* Clave única para identificar los datos de la moneda */
    {{ dbt_utils.generate_surrogate_key(['pais']) }} AS id_pais, /* Clave única para identificar los datos del país */
    {{ dbt_utils.generate_surrogate_key(['bolsa']) }} AS id_bolsa, /* Clave única para identificar los datos de la bolsa */
    {{ dbt_utils.generate_surrogate_key(['sector']) }} AS id_sector, /* Clave única para identificar los datos del sector */
    {{ dbt_utils.generate_surrogate_key(['industria']) }} AS id_industria, /* Clave única para identificar los datos de la industria */
    {{ dbt_utils.generate_surrogate_key(['tipo_activo']) }} AS id_activo, /* Clave única para identificar los datos de la empresa */
    {{ dbt_utils.generate_surrogate_key(['sitio_web']) }} AS id_web /* Clave única para identificar los datos del sitio web */
  FROM source
)
SELECT
  *
FROM renamed