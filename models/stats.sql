{{
  config(
    materialized='table',
    file_format='parquet',
    pre_hook=[
        """
        CREATE OR REPLACE FUNCTION LogMetric AS 'com.godatadriven.LogMetric'
            USING JAR 'dbfs:/mnt/libs/azure-dbt-logger-assembly-0.1.jar';
        """
    ]
  )
}}

SELECT
    LogMetric('seconds_since_last_order', (

        SELECT unix_timestamp() - unix_timestamp(max(changed_at))
        FROM {{ ref('revenue') }}

    )) AS seconds_since_last_order,


    LogMetric('count_orders', (

        SELECT count(1)
        FROM {{ ref('revenue') }}

    )) AS orders_count
