--netflix project
drop table if exists netflix;
CREATE TABLE netflix
(
  show_id 	VARCHAR(6),
  type  VARCHAR(10),
  title	VARCHAR(150),
  director	VARCHAR(210),
  casts	VARCHAR(1000),
  country	VARCHAR(150),
  date_added  VARCHAR(50),
  release_year	INT,
  rating	VARCHAR(10),
  duration	VARCHAR(15),
  listed_in	VARCHAR(100),
  description VARCHAR(250)
);

select * from netflix;

select count(*) as total_content from netflix;

select distinct type from netflix;

select * from netflix;

-- PROBLEMS

-- 1. Count the number of Movies vs TV Shows
SELECT type,count(*) as total_content from netflix
group by type;

--2.List all movies released in a specific year (e.g:2020)
SELECT * FROM netflix
WHERE type='Movie' AND release_year=2020

--3.Identify the longest movie?
SELECT * FROM netflix
WHERE type='Movie' AND duration=(SELECT MAX(duration) FROM netflix);

--4.Find content added in the last 5 years
SELECT * FROM netflix
WHERE TO_DATE(date_added,'Month DD, YYYY')>=CURRENT_DATE- INTERVAL '5 years';

--5.Find all the movie/TV shows by director 'Rajiv Chilaka'?
SELECT * FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

--6.List all Tv shows with more than 5 Seasons
SELECT * FROM netflix
WHERE type='TV Show' AND
SPLIT_PART(duration,' ',1)::numeric > 5;

--7.Count the number of content items in each genre
SELECT UNNEST(STRING_TO_ARRAY(listed_in,',')) as genre,
COUNT(show_id) as total_content
FROM netflix
GROUP BY 1;

--8.List all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in ILIKE '%documentaries%'

--9.Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL

--10.Find how many movies actor 'Salmon Khan' appeared in last 10 years?
SELECT * FROM netflix
WHERE casts ILIKE '%Salman Khan%'
AND release_year > EXTRACT(YEAR FROM CURRENT_DATE)-10;

--11.Categorise the content based on the presence of the keywords 'Kill' and 'violence' in the description field.
--Label content containing these keywords as 'Bad' and all other content as 'Good'.
--count how many items fall into each category.
WITH new_table
AS
(
SELECT *, CASE
WHEN description ILIKE '%kills%' OR
description ILIKE '%violences%' THEN 'Bad_content'
ELSE 'Good_content'
END category
FROM netflix
)
SELECT category,COUNT(*) AS total_content
FROM new_table
GROUP BY 1;



