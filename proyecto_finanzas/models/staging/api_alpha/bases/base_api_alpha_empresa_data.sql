WITH source AS (
  SELECT
    *
  FROM {{ source('api_alpha', 'empresa_data') }} AS empresa_data
), renamed AS (
  SELECT
    
    CAST(OVERVIEW__SYMBOL AS VARCHAR(255)) AS simbolo,
    {{ dbt_utils.generate_surrogate_key(['simbolo']) }} AS id_ticker, /* Clave única para identificar los datos de la empresa */
    CAST(OVERVIEW__ASSET_TYPE AS VARCHAR(255)) AS tipo_activo, /* Tipo de activo (Equity, ETF, etc.) */
    CAST(OVERVIEW__NAME AS VARCHAR(255)) AS nombre_empresa,
    CAST(OVERVIEW__DESCRIPTION AS VARCHAR(16777216)) AS descripcion,
    CAST(OVERVIEW__CIK AS VARCHAR(255)) AS idx_CIK, /* Indice de Clasificación de la Comisión de Bolsa y Valores */
    CAST(OVERVIEW__EXCHANGE AS VARCHAR(255)) AS bolsa, /* Bolsa de valores                            */
    CAST(OVERVIEW__CURRENCY AS VARCHAR(255)) AS moneda,
    CAST(OVERVIEW__COUNTRY AS VARCHAR(255)) AS pais,
    CAST(OVERVIEW__SECTOR AS VARCHAR(255)) AS sector,
    CAST(OVERVIEW__INDUSTRY AS VARCHAR(255)) AS industria,
    CAST(OVERVIEW__ADDRESS AS VARCHAR(255)) AS direccion,
    CAST(OVERVIEW__OFFICIAL_SITE AS VARCHAR(16777216)) AS sitio_web,
    CAST(OVERVIEW__FISCAL_YEAR_END AS VARCHAR(255)) AS fin_anyo_fiscal, /* Mes escrito */
    CONVERT_TIMEZONE('UTC', CAST(OVERVIEW__LATEST_QUARTER AS DATE)) AS ultimo_trimestre,
    CAST(OVERVIEW__MARKET_CAPITALIZATION AS DECIMAL(20, 2)) AS capitalizacion_mercado,
    CAST(OVERVIEW__EBITDA AS DECIMAL(20, 2)) AS ebitda, /* Ganancias antes de intereses, impuestos, depreciación y amortización. */
    CAST(OVERVIEW__PE_RATIO AS DECIMAL(10, 2)) AS ratio_precio_ganancia, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM), */
    CAST(OVERVIEW__PEG_RATIO AS DECIMAL(10, 2)) AS ratio_peg, /* Relación precio-ganancias ajustada al crecimiento.(OVERVIEW__PE_RATIO / OVERVIEW__EPS), */
    CAST(OVERVIEW__BOOK_VALUE AS DECIMAL(20, 2)) AS valor_contable,
    CAST(NULLIF(OVERVIEW__DIVIDEND_PER_SHARE, 'None') AS DECIMAL(10, 2)) AS dividendo_por_accion,
    CAST(NULLIF(OVERVIEW__DIVIDEND_YIELD, 'None') AS DECIMAL(5, 2)) AS rend_div_accion_porc, /* (OVERVIEW__DIVIDEND_PER_SHARE / OVERVIEW__MARKET_CAPITALIZATION) */
    CAST(OVERVIEW__EPS AS DECIMAL(10, 2)) AS ganancia_por_accion, /* (OVERVIEW__EPS), */
    CAST(OVERVIEW__REVENUE_PER_SHARE_TTM AS DECIMAL(20, 2)) AS ingresos_por_accion, /* (OVERVIEW__REVENUE_TTM / OVERVIEW__SHARES_OUTSTANDING) (Ingresos por acción), */
    CAST(OVERVIEW__PROFIT_MARGIN AS DECIMAL(5, 2)) AS margen_ganancia, /* (OVERVIEW__NET_INCOME_TTM / OVERVIEW__REVENUE_TTM) (Margen de ganancia), */
    CAST(OVERVIEW__OPERATING_MARGIN_TTM AS DECIMAL(5, 2)) AS margen_operativo, /* (OVERVIEW__OPERATING_INCOME_TTM / OVERVIEW__REVENUE_TTM) (Margen operativo), */
    CAST(OVERVIEW__RETURN_ON_ASSETS_TTM AS DECIMAL(5, 2)) AS retn_sobre_activos, /* (OVERVIEW__NET_INCOME_TTM / OVERVIEW__TOTAL_ASSETS) (Retorno sobre activos), */
    CAST(OVERVIEW__RETURN_ON_EQUITY_TTM AS DECIMAL(5, 2)) AS retn_sobre_patri, /* (OVERVIEW__NET_INCOME_TTM / OVERVIEW__SHARES_OUTSTANDING) (Ganancia por acción), */
    CAST(OVERVIEW__REVENUE_TTM AS DECIMAL(20, 2)) AS ingresos_acci_anyo,
    CAST(OVERVIEW__GROSS_PROFIT_TTM AS DECIMAL(20, 2)) AS beneficio_bruto,
    CAST(OVERVIEW__DILUTED_EPSTTM AS DECIMAL(10, 2)) AS eps_diluido, /* Ganancias por acción diluidas el último año */
    CAST(OVERVIEW__QUARTERLY_EARNINGS_GROWTH_YOY AS DECIMAL(5, 2)) AS crec_gana_trim, /* Crecimiento de las ganancias trimestrales interanual */
    CAST(OVERVIEW__QUARTERLY_REVENUE_GROWTH_YOY AS DECIMAL(5, 2)) AS crec_ingre_trim, /* Crecimiento de los ingresos trimestrales interanual */
    CAST(OVERVIEW__ANALYST_TARGET_PRICE AS DECIMAL(10, 2)) AS precio_obj_anali, /* Precio objetivo del analista */
    CAST(OVERVIEW__TRAILING_PE AS DECIMAL(10, 2)) AS precio_ganan, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM) (Precio/Ganancia) */
    CAST(OVERVIEW__FORWARD_PE AS DECIMAL(10, 2)) AS precio_ganan_fut, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM) (Precio/Ganancia futuro) */
    CAST(OVERVIEW__PRICE_TO_SALES_RATIO_TTM AS DECIMAL(10, 2)) AS rat_precio_venta, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__REVENUE_TTM) (Precio/Ventas) */
    CAST(OVERVIEW__PRICE_TO_BOOK_RATIO AS DECIMAL(10, 2)) AS rat_precio_valor, /* (OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__BOOK_VALUE) (Precio/Valor) */
    CAST(OVERVIEW__EV_TO_REVENUE AS DECIMAL(10, 2)) AS valor_ingresos, /* (OVERVIEW__ENTERPRISE_VALUE / OVERVIEW__REVENUE_TTM) (Valor de la empresa/Ingresos) */
    CAST(OVERVIEW__EV_TO_EBITDA AS DECIMAL(10, 2)) AS valor_ebitda, /* (OVERVIEW__ENTERPRISE_VALUE / OVERVIEW__EBITDA) (Valor de la empresa/EBITDA) */
    CAST(OVERVIEW__BETA AS DECIMAL(5, 2)) AS beta, /* Beta (coeficiente de riesgo) */
    CAST(OVERVIEW___52_WEEK_HIGH AS DECIMAL(10, 2)) AS valor_max_sem_52, /* Máximo de 52 semanas */
    CAST(OVERVIEW___52_WEEK_LOW AS DECIMAL(10, 2)) AS valor_min_sem_52, /* Mínimo de 52 semanas */
    CAST(OVERVIEW___50_DAY_MOVING_AVERAGE AS DECIMAL(10, 2)) AS media_movil_50_dias, /* Media móvil de 50 días */
    CAST(OVERVIEW___200_DAY_MOVING_AVERAGE AS DECIMAL(10, 2)) AS media_movil_200_dias, /* Media móvil de 200 días */
    CAST(OVERVIEW__SHARES_OUTSTANDING AS DECIMAL(20, 0)) AS acciones_circulando, /* Número de acciones en circulación */
    CONVERT_TIMEZONE('UTC', CAST(NULLIF(OVERVIEW__DIVIDEND_DATE, 'None') AS DATE)) AS fecha_divid, /* Fecha en la que se paga el dividendo                 */
    CONVERT_TIMEZONE('UTC', CAST(NULLIF(OVERVIEW__EX_DIVIDEND_DATE, 'None') AS DATE)) AS fecha_ex_divid, /* Fecha en la que una acción se negocia sin el dividendo                */
    CAST(_DLT_LOAD_ID AS VARCHAR(255)) AS id_carga_dlt, /* Id de la carga */
    CAST(_DLT_ID AS VARCHAR(255)) AS id_dlt /* Id del registro */
  FROM source
)
SELECT
  *
FROM renamed