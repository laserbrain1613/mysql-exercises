# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first

SELECT Name, Population
FROM city
WHERE name LIKE "ping%"
ORDER BY Population ASC;

# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first

SELECT Name, Population
FROM city
WHERE name LIKE "ran%"
ORDER BY Population DESC;

# 3: Count all cities

SELECT COUNT(id)
FROM city;

# 4: Get the average population of all cities

SELECT AVG(Population) AS Average_Population
FROM city;

# 5: Get the biggest population found in any of the cities

SELECT MAX(Population)
FROM city;

# 6: Get the smallest population found in any of the cities

SELECT MIN(Population)
FROM city;

# 7: Sum the population of all cities with a population below 10000

SELECT SUM(Population)
FROM city
WHERE Population < 10000;

# 8: Count the cities with the countrycodes MOZ and VNM

SELECT COUNT(id)
FROM city
WHERE CountryCode IN ("MOZ", "VNM");

# 9: Get individual count of cities for the countrycodes MOZ and VNM

SELECT COUNT(id), CountryCode
FROM city
WHERE CountryCode IN ("MOZ", "VNM")
GROUP BY CountryCode;

# 10: Get average population of cities in MOZ and VNM

SELECT AVG(Population), CountryCode
FROM city
WHERE CountryCode IN ("MOZ", "VNM")
GROUP BY CountryCode;

# 11: Get the countrycodes with more than 200 cities

SELECT CountryCode, COUNT(name) AS Cities
FROM city
GROUP BY CountryCode
HAVING Cities > 200;

# 12: Get the countrycodes with more than 200 cities ordered by city count

SELECT CountryCode, COUNT(name) AS Cities
FROM city
GROUP BY CountryCode
HAVING Cities > 200
ORDER BY Cities ASC;

# 13: What language(s) is spoken in the city with a population between 400 and 500 ?

SELECT name, Language, Population
FROM city
INNER JOIN countrylanguage
	ON city.CountryCode = countrylanguage.CountryCode
WHERE Population BETWEEN 400 AND 500;

# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT name, language
FROM city
INNER JOIN countrylanguage
	ON city.CountryCode = countrylanguage.CountryCode
WHERE Population BETWEEN 500 AND 600;

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT name, CountryCode, Population
FROM city
WHERE CountryCode = (
    SELECT CountryCode
    FROM city
    WHERE Population = 122199);

# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT name, CountryCode, Population
FROM city
WHERE CountryCode = (SELECT CountryCode from city WHERE Population = 122199)
AND Population != 122199;

# 17: What are the city names in the country where Luanda is capital?

SELECT city.name 
FROM city 
INNER JOIN country 
	ON city.CountryCode = country.Code 
WHERE country.Capital = (SELECT ID from city WHERE name = 'Luanda');
    
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT city.name
FROM city
INNER JOIN country
    ON city.CountryCode = country.Code
WHERE region = (
    SELECT region
    FROM city
    INNER JOIN country
        ON city.CountryCode = country.Code
    WHERE city.name = "Yaren")
AND capital = id;

# 19: What unique languages are spoken in the countries in the same region as the city named Riga
 
SELECT DISTINCT language
FROM countrylanguage
INNER JOIN country
    ON countrylanguage.CountryCode = country.Code
WHERE region = (
    SELECT region
    FROM city
    INNER JOIN country
        ON city.CountryCode = country.Code
    WHERE city.name = "Riga");
  
# 20: Get the name of the most populous city

SELECT name
FROM city
ORDER BY Population DESC
LIMIT 1;