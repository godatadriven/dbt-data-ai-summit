
SELECT
  beer,
  style,
  ounces,
  brewery,
  city,
  state,
  label,
  CAST(ibu AS double) ibu,
  CAST(abv AS double) abv
FROM {{ ref('beers') }}
