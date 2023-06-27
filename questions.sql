#GENDER BREAKDOWN OF EMPLOYEES IN THE COMPANY
SELECT gender, COUNT(*) AS count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY gender; 

#RACE/ETHINICITY BREAKDOWN OF EMPLOYEES IN THE COMPANY
SELECT race, COUNT(*) AS count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY race
ORDER BY count DESC; 

#AGE DISTRIBUTION OF EMPLOYEES IN THE COMPANY
SELECT 
	MIN(age) as Youngest,
    MAX(age) as Oldest
FROM hr
WHERE termdate = '0000-00-00';

SELECT
	CASE
		WHEN age >=18 AND age <=24 THEN '18-24'
        WHEN age >=25 AND age <=34 THEN '25-34'
        WHEN age >=35 AND age <=44 THEN '35-44'
        WHEN age >=45 AND age <=54 THEN '35-44'
        WHEN age >=55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    COUNT(*) AS count
FROM HR
WHERE termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT
	CASE
		WHEN age >=18 AND age <=24 THEN '18-24'
        WHEN age >=25 AND age <=34 THEN '25-34'
        WHEN age >=35 AND age <=44 THEN '35-44'
        WHEN age >=45 AND age <=54 THEN '35-44'
        WHEN age >=55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
    COUNT(*) AS count
FROM HR
WHERE termdate = '0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group, gender;

#EMPLOYEES WORK AT HEADQUARTERS VS REMOTE LOCATION 
SELECT location, COUNT(*) AS count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY location
ORDER BY count DESC; 

#AVG LENGTH OF EMPLOYMENT WHO HAVE BREEN TERMINATED
SELECT 
	ROUND(AVG(DATEDIFF(termdate,hire_date))/ 365 ,0) AS avg_len_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE();

#HOW DOES GENDER DISTRIBUTION VARY ACROSS DEPARTMENT AND JOB TITLE?
SELECT department, gender , COUNT(*) AS count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

#DISTRIBUTION OF JOB TITLE ACROSS THE COMPANY
SELECT jobtitle , COUNT(*) AS count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY count DESC;

#WHICH DEPARTMENT HAS THE HIGHEST TURNOVER RATE?
SELECT department, total_count, terminated_count, 
		terminated_count/total_count AS termination_rate
FROM (
	SELECT department, COUNT(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    GROUP BY department
	) AS subquery
ORDER BY termination_rate DESC;

#DISTRIBUTION OF EMPLOYEES ACROSS LOCATIONS BY CITY AND STATE
SELECT 
	location_city, COUNT(*) AS city_count,
    location_state, COUNT(*) AS state_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY location_city, location_state
ORDER BY city_count DESC,state_count DESC;

#HOW HAS THE COMPANY'S EMPLOYEE COUNT CHANGED OVER TIME BASED ON HIRE AND TERM DATES?
SELECT 
	year,
    hires,
    terminations,
    hires - terminations AS net_change,
    (hires - terminations) / hires AS net_change_perc
FROM (
	SELECT YEAR(hire_date) AS year,
    COUNT(*) AS hires,
	SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM hr
    GROUP BY year
    ) AS subquery
ORDER BY year;

#WHAT IS THE TENURE  DISTRIBUTION FOR EACH DEPARTMENT
SELECT 
	department,
	ROUND(AVG(DATEDIFF(termdate,hire_date))/ 365 ,0) AS avg_tenure
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE()
GROUP BY department;