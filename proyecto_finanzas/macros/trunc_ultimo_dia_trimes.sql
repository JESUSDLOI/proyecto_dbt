{% macro trunc_ultimo_dia_trimes(date_column) %}
    DATEADD(
        'day',
        -1,
        DATEADD(
            'quarter',
            1,
            DATE_TRUNC('quarter', {{ date_column }})
        )
    )
{% endmacro %}