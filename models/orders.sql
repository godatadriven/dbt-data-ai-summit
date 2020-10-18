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

  SELECT
     {{ order_number }}         AS order_no,
     {% if order_number is divisibleby 2 %}
        -- Half of the records will be updated each run
        current_timestamp          AS changed_at
     {% else %}
       timestamp(
            '2020-01-20 12:22:19'
       )                           AS changed_at
     {% endif %}
  {% if not loop.last %}
    UNION ALL
  {% endif %}
{% endfor %}
