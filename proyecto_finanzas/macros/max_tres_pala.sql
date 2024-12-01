{% test no_more_than_four_words(model, column_name) %}
  SELECT *
  FROM {{ model }}
  WHERE array_length(split({{ column_name }}, ' ')) > 3
{% endtest %}