create database portfolio;
use portfolio;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NOT NULL,
ADD PRIMARY KEY (emp_id);

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates =0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT hire_date FROM hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;

UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate <> ''; 

SET sql_mode = '';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR,birthdate,CURDATE());

SELECT 
	MIN(age) as Youngest,
    MAX(age) as Oldest
FROM hr;

SELECT COUNT(*) FROM hr
WHERE age <= 18;

DELETE FROM hr
WHERE age <= 18;
