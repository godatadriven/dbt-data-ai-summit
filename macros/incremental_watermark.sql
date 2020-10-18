{% macro incremental_watermark(column_name='changed_at') %}
    -- We use this to only incrementally load changes,
    -- based on the watermark
    WHERE {{ column_name }} > (SELECT MAX({{ column_name }}) FROM {{ this }})
{% endmacro %}
