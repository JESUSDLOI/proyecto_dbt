{% macro test_fecha_inferior_actual(model, column_name) %}
  SELECT *
  FROM {{ model }}
  WHERE {{ column_name }} > CONVERT_TIMEZONE('UTC', CURRENT_TIMESTAMP)
{% endmacro %}