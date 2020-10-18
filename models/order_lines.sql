{{
  config(
    materialized='table',
    file_format='parquet'
  )
}}


-- Usually this would be an external table or so, that will read the data
-- from some landing zone that is, for example being fed by CDC

-- Right now just make up some data :)

{% for order_number in range(100) %}

  {% for order_line in range(5) %}
    SELECT {{ order_number }}                AS order_no,
           {{ order_line }}            AS order_line,
           {{ range(1, 5) | random }}  AS quantity,
           {{ range(1, 51) | random }} AS price

    {% if not loop.last %}
      UNION ALL
    {% endif %}
  {% endfor %}

  {% if not loop.last %}
    UNION ALL
  {% endif %}
{% endfor %}
