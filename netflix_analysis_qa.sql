CREATE DATABASE NETFLIX ; 
USE NETFLIX;

SELECT * FROM NETFLIX_DATA LIMIT 20 ; 

DESC NETFLIX_DATA; 

# 1. What is the total number of 'Movies' and 'TV Shows' on Netflix?
SELECT TYPE, COUNT(*) AS TOTAL_COUNT
FROM NETFLIX_DATA
GROUP BY TYPE;

#2 Which country has produced the most content (Movies + TV Shows) on
# Netflix? List the top 5 countries.
SELECT COUNTRY , COUNT(*) AS TOTAL_CONTENT
FROM NETFLIX_DATA
GROUP BY COUNTRY
ORDER BY TOTAL_CONTENT DESC 
LIMIT 5 

#3. Retrieve a list of all movies and TV shows released in the year 2020.
SELECT TITLE,TYPE FROM NETFLIX_DATA
WHERE release_year=2020
LIMIT 10; 

#4. What are the titles of all movies directed by 'Kirsten Johnson'?
SELECT TITLE 
FROM NETFLIX_DATA
WHERE TYPE='MOVIE' AND DIRECTOR='Kirsten Johnson';

#5. Which content rating is the most common on Netflix? (Count of titles by rating).
SELECT RATING , COUNT(*) AS TOTAL_TITLES
FROM NETFLIX_DATA
GROUP BY RATING
ORDER BY TOTAL_TITLES DESC ; 

#6. Find the list of all 'TV Shows' that have 5 or more seasons.
SELECT TITLE , DURATION 
FROM NETFLIX_DATA
WHERE TYPE='TV SHOW' AND DURATION>='5 SEASON'

#7. List all the movies produced in 'India' that belong to the 'Comedies' category.
SELECT TITLE , LISTED_IN FROM 
NETFLIX_DATA
WHERE TYPE='MOVIE' AND COUNTRY='INDIA' AND LISTED_IN LIKE '%Comedies%'

# 8. How many new shows/movies were released each year? Sort the results in
#descending order of the release year.
SELECT RELEASE_YEAR , COUNT(*) AS TOTAL_RELEASES 
FROM NETFLIX_DATA
GROUP BY RELEASE_YEAR
ORDER BY RELEASE_YEAR DESC 
LIMIT 5 ; 

# 9. Who are the top 5 directors with the highest number of directed movies
# (excluding 'Not Given')?
SELECT DIRECTOR , COUNT(*) AS  TOTAL_MOVIES
FROM NETFLIX_DATA
WHERE TYPE='MOVIE' AND DIRECTOR !=''
GROUP BY DIRECTOR 
ORDER BY TOTAL_MOVIES DESC 
LIMIT 5 ; 

#10. In which year did Netflix add the highest amount of content to its platform?
SELECT RIGHT(DATE_ADDED,4) AS YEAR_ADDED,COUNT(*) AS TOTAL_CONTENT
FROM NETFLIX_DATA
GROUP BY RIGHT(DATE_ADDED,4)
ORDER BY TOTAL_CONTENT DESC 
LIMIT 1 ; 

#11. Which are the 5 oldest movies released in India on Netflix?
SELECT TITLE , RELEASE_YEAR
FROM NETFLIX_DATA
WHERE COUNTRY ='INDIA' AND TYPE='MOVIE' 
ORDER BY RELEASE_YEAR ASC 
LIMIT 5 ; 

#12. Find the titles of all movies listed as 'Documentaries' that were released
# after the year 2015.
SELECT TITLE , RELEASE_YEAR , LISTED_IN
FROM NETFLIX_DATA
WHERE LISTED_IN LIKE '%Documentaries%' AND TYPE='MOVIE' AND  RELEASE_YEAR >=2015

#13. Which movie has the longest duration in minutes on Netflix?
SELECT TITLE , CAST(SUBSTRING_INDEX(DURATION,' ',1) AS UNSIGNED ) AS DURATION_MINUTE
FROM NETFLIX_DATA
WHERE TYPE='MOVIE'
ORDER BY DURATION_MINUTE DESC 
LIMIT 1; 

#14. What is the most recently released movie for each country?
WITH RANKED_MOVIE AS (
SELECT TITLE , COUNTRY , RELEASE_YEAR,
row_number() OVER (PARTITION BY COUNTRY ORDER BY RELEASE_YEAR DESC ) AS RNK
FROM NETFLIX_DATA
WHERE TYPE='MOVIE' AND COUNTRY !='')
SELECT COUNTRY , TITLE AS LATEST_MOVIES , RELEASE_YEAR 
FROM  RANKED_MOVIE
WHERE RNK=1; 

#15. Identify the release years in which more than 50 movies from India were released.
SELECT RELEASE_YEAR , COUNT(*) AS TOTAL_MOVIES
FROM NETFLIX_DATA
WHERE TYPE='MOVIE' AND COUNTRY='INDIA' 
GROUP BY RELEASE_YEAR
HAVING TOTAL_MOVIES>50 
ORDER BY RELEASE_YEAR DESC 