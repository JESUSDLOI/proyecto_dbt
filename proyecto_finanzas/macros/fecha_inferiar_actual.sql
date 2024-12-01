{% macro check_insertion_date(model, column_name) %}
  SELECT *
  FROM {{ model }}
  WHERE {{ column_name }} >= CURRENT_TIMESTAMP
{% endmacro %}