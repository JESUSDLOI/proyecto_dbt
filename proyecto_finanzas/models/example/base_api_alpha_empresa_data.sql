with source as (
      select * from {{ source('api_alpha', 'empresa_data') }}
),
renamed as (
   SELECT

    OVERVIEW__SYMBOL VARCHAR(255) as simbolo,
    OVERVIEW__ASSET_TYPE VARCHAR(255) as tipo_activo,                                        --Tipo de activo (Equity, ETF, etc.)
    OVERVIEW__NAME VARCHAR(255) as nombre_empresa,
    OVERVIEW__DESCRIPTION VARCHAR(255) as descripcion,
    OVERVIEW__CIK VARCHAR(255) as idx_CIK,                                           --Indice de Clasificación de la Comisión de Bolsa y Valores
    OVERVIEW__EXCHANGE VARCHAR(255) as bolsa,                                    --Bolsa de valores                            
    OVERVIEW__CURRENCY VARCHAR(255) as moneda,
    OVERVIEW__COUNTRY VARCHAR(255) as pais,
    OVERVIEW__SECTOR VARCHAR(255) as sector,
    OVERVIEW__INDUSTRY VARCHAR(255) as industria,
    OVERVIEW__ADDRESS VARCHAR(255) as direccion,
    OVERVIEW__OFFICIAL_SITE VARCHAR(16777216) as sitio_web,
    OVERVIEW__FISCAL_YEAR_END DATE as fin_anyo_fiscal,
    OVERVIEW__LATEST_QUARTER as ultimo_trimestre,
    OVERVIEW__MARKET_CAPITALIZATION NUMERIC(20, 2) as capitalizacion_mercado,
    OVERVIEW__EBITDA NUMERIC(20, 2) as ebitda,                                      --Ganancias antes de intereses, impuestos, depreciación y amortización.
    OVERVIEW__PE_RATIO NUMERIC(10, 2) as ratio_precio_ganancia,                     --(OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM),
    OVERVIEW__PEG_RATIO NUMERIC(10, 2) as ratio_peg,                                -- Relación precio-ganancias ajustada al crecimiento.                          --(OVERVIEW__PE_RATIO / OVERVIEW__EPS),
    OVERVIEW__BOOK_VALUE NUMERIC(20, 2) as valor_contable,                        
    OVERVIEW__DIVIDEND_PER_SHARE NUMERIC(10, 2) as dividendo_por_accion,             
    OVERVIEW__DIVIDEND_YIELD NUMERIC(5, 2) as rend_div_accion_porc,                    --(OVERVIEW__DIVIDEND_PER_SHARE / OVERVIEW__MARKET_CAPITALIZATION)
    OVERVIEW__EPS NUMERIC(10, 2) as ganancia_por_accion,                               --(OVERVIEW__EPS),
    OVERVIEW__REVENUE_PER_SHARE_TTM NUMERIC(20, 2) as ingresos_por_accion,            --(OVERVIEW__REVENUE_TTM / OVERVIEW__SHARES_OUTSTANDING) (Ingresos por acción),
    OVERVIEW__PROFIT_MARGIN NUMERIC(5, 2) as margen_ganancia,                         --(OVERVIEW__NET_INCOME_TTM / OVERVIEW__REVENUE_TTM) (Margen de ganancia),
    OVERVIEW__OPERATING_MARGIN_TTM NUMERIC(5, 2) as margen_operativo,                 --(OVERVIEW__OPERATING_INCOME_TTM / OVERVIEW__REVENUE_TTM) (Margen operativo),
    OVERVIEW__RETURN_ON_ASSETS_TTM NUMERIC(5, 2) as retn_sobre_activos,            --(OVERVIEW__NET_INCOME_TTM / OVERVIEW__TOTAL_ASSETS) (Retorno sobre activos),
    OVERVIEW__RETURN_ON_EQUITY_TTM NUMERIC(5, 2) as retn_sobre_patri,         --(OVERVIEW__NET_INCOME_TTM / OVERVIEW__SHARES_OUTSTANDING) (Ganancia por acción),
    OVERVIEW__REVENUE_TTM NUMERIC(20, 2) as ingresos_acci_anyo,                           
    OVERVIEW__GROSS_PROFIT_TTM NUMERIC(20, 2) as beneficio_bruto,                          
    OVERVIEW__DILUTED_EPSTTM NUMERIC(10, 2) as eps_diluido,                            --Ganancias por acción diluidas el último año
    OVERVIEW__QUARTERLY_EARNINGS_GROWTH_YOY NUMERIC(5, 2) as crec_gana_trim ,             --Crecimiento de las ganancias trimestrales interanual
    OVERVIEW__QUARTERLY_REVENUE_GROWTH_YOY NUMERIC(5, 2) as crec_ingre_trim,            --Crecimiento de los ingresos trimestrales interanual
    OVERVIEW__ANALYST_TARGET_PRICE NUMERIC(10, 2) as precio_obj_anali,                  --Precio objetivo del analista
    OVERVIEW__TRAILING_PE NUMERIC(10, 2) as precio_ganan,                               --(OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM) (Precio/Ganancia)
    OVERVIEW__FORWARD_PE NUMERIC(10, 2) as precio_ganan_fut,                           --(OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__NET_INCOME_TTM) (Precio/Ganancia futuro)
    OVERVIEW__PRICE_TO_SALES_RATIO_TTM NUMERIC(10, 2) as rat_precio_venta,           --(OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__REVENUE_TTM) (Precio/Ventas)
    OVERVIEW__PRICE_TO_BOOK_RATIO NUMERIC(10, 2) as rat_precio_valor,                --(OVERVIEW__MARKET_CAPITALIZATION / OVERVIEW__BOOK_VALUE) (Precio/Valor)
    OVERVIEW__EV_TO_REVENUE NUMERIC(10, 2) as valor_ingresos,                         --(OVERVIEW__ENTERPRISE_VALUE / OVERVIEW__REVENUE_TTM) (Valor de la empresa/Ingresos)
    OVERVIEW__EV_TO_EBITDA NUMERIC(10, 2) as valor_ebitda,                            --(OVERVIEW__ENTERPRISE_VALUE / OVERVIEW__EBITDA) (Valor de la empresa/EBITDA)
    OVERVIEW__BETA NUMERIC(5, 2) as beta,                                              --Beta (coeficiente de riesgo)
    OVERVIEW___52_WEEK_HIGH NUMERIC(10, 2) as valor_max_sem_52,                              --Máximo de 52 semanas
    OVERVIEW___52_WEEK_LOW NUMERIC(10, 2) as valor_min_sem_52,                               --Mínimo de 52 semanas
    OVERVIEW___50_DAY_MOVING_AVERAGE NUMERIC(10, 2) as media_movil_50_dias,           --Media móvil de 50 días
    OVERVIEW___200_DAY_MOVING_AVERAGE NUMERIC(10, 2) as media_movil_200_dias,          --Media móvil de 200 días
    OVERVIEW__SHARES_OUTSTANDING NUMERIC(20, 0) as acciones_circulando,         --Número de acciones en circulación
    OVERVIEW__DIVIDEND_DATE DATE as fecha_divid,                                --Fecha en la que se paga el dividendo                 
    OVERVIEW__EX_DIVIDEND_DATE DATE as fecha_ex_divid,                          --Fecha en la que una acción se negocia sin el dividendo                
    _DLT_LOAD_ID VARCHAR(255) as id_carga,                                       --Id de la carga
    _DLT_ID VARCHAR(255) as id,                                                  --Id del registro



    from source
)
select * from renamed
  