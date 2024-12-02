{% test max_tres_pala(model, column_name) %}
  SELECT *
  FROM {{ model }}
  WHERE array_length(split({{ column_name }}, ' ')) > 3
{% endtest %}