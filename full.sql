USE disney_dataset;

SELECT * FROM titles

SELECT * FROM credits

/* 1a)Content type on Disney+ */
SELECT type, COUNT(type) AS Content_type
FROM titles
WHERE type IS NOT NULL
GROUP BY type;

/* 1b) Content type in recent years */
SELECT release_year, type, COUNT(type) AS Conetnt_type
FROM titles
WHERE type IS NOT NULL
GROUP BY type, release_year
HAVING release_year >= 2000
ORDER BY release_year ASC;

/* 2) Different age certifications on Disney+ */
SELECT age_certification, type, COUNT(type) AS Conetnt_type
FROM titles
WHERE type IS NOT NULL
GROUP BY title, age_certification;

/* 3)Top 10 production countries on Disney+ */
SELECT production_countries, COUNT(production_countries) AS NumberOfProductions
FROM titles
WHERE production_countries IS NOT NULL ANND production_countries NOT IN ("[]")
GROUP BY production_countries
ORDER BY COUNT(production_countries) DESC
LIMIT 10;

?* 4) Content duration via types */
/* Movies */
SELECT runtime, count(runtime) AS number_of_movies
FROM
  (
  SELECT type, runtime
  FROM ttles
  WHERE type = 'Movie'
  ) AS Temptab1
GROUP BY runtime
ORDER BY runtime;

/* Shows */
SELECT seasons, count(seasons) AS number_of_series
FROM
  (
  SELECT type, seasons
  FROM ttles
  WHERE type = 'Show'
  ) AS Temptab2
GROUP BY seasons
ORDER BY seasons;

/* 5) Top movies and tv show genres on Disney+ */
SELECT genre1 as Genre, COUNT(genre1) as Number_of_genres
FROM TITLES
WHERE genre1 IS NOT NULL AND genre1 NOT IN ("[]")
GROUP BY genre1
ORDER BY COUNT(genre1) DESC;

/* 6)Top 10 famous actors for movies on Disney+ */
SELECT DISNTINCT name, COUNT(name) AS Number_of_Movies_acted
FROM
  (
  SELECT name
  FROM credits cr
  INNER JOIN titles ti
  ON cr.id = ti.id
  WHERE cr.role = "Actor" and ti.type = "Movie"
  ) AS Temptab3
GROUP BY name
PRDER BY count(name) DESC
LIMIT 10

/* 7) imdb ratings of Movies& Tv shows */
SELECT imdb_Range, count(imdb_Range) AS no_of_ratings
FROM
  (
  SELECT imdb_Range
  FROM
    (
    SELECT imdb_score,
    CASE
    WHEN (imdb_score) <= 1 THEN '0-1'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '1-2'
    WHEN (imdb_score) BETWEEN 2 AND 3 THEN '2-3'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '3-4'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '4-5'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '5-6'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '6-7'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '7-8'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '8-9'
    WHEN (imdb_score) BETWEEN 1 AND 2 THEN '9-10'
    END AS Imdb_range
    FROM titles
    WHERE imdb_score NOT IN (0)
    ) AS Temptab4
  )AS Temptab5
WHERE imdb_Range IS NOT NULL
GROUP BY Imdb_range
ORDER BY Imdb_range;

