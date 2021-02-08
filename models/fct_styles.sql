
SELECT
  style         style,
  count(1)      num_beers,
  AVG(ibu)      avg_ibu,
  AVG(abv)      avg_abv
FROM {{ ref('stg_beers') }}
GROUP BY style
