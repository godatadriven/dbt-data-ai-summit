{{
  config(
    materialized='incremental',
    file_format='delta',
    incremental_strategy='merge',
    unique_key='order_no',
    post_hook=[
        'ANALYZE TABLE {{ this }} COMPUTE STATISTICS'
    ]
  )
}}

SELECT /*+ BROADCAST(orders) */
  orders.order_no                               order_no,
  SUM(order_lines.price * order_lines.quantity) revenue,
  MAX(orders.changed_at)                        changed_at
FROM {{ ref('orders') }} orders
JOIN {{ ref('order_lines') }} order_lines USING (order_no)

{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  WHERE changed_at > (SELECT MAX(changed_at) FROM {{ this }})
{% endif %}

GROUP BY order_no
