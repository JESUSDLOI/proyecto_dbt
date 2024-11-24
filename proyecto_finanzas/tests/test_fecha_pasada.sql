{% test date_in_past(model, column_name) %}
WITH validation AS (
    SELECT
        {{ column_name }} AS date_field
        CURRENT_DATE AS today
    FROM {{ model }}
    WHERE date_field > today
)
SELECT COUNT(*) AS errors FROM validation
{% endtest %}
