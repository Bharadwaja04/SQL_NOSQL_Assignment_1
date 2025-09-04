SELECT
Stage,
"Gender" AS Category,
"Male" AS Sub_Category,
SUM(CASE WHEN Status = "Pass" AND Gender = "Male" THEN 1 ELSE 0 END)/SUM(CASE WHEN Gender = "Male" THEN 1 ELSE 0 END) AS Pass_Rate_Male
FROM students
GROUP BY Stage

UNION ALL

SELECT
Stage,
"Gender" AS Category,
"Female" AS Sub_Category,
SUM(CASE WHEN Status = "Pass" AND Gender = "Female" THEN 1 ELSE 0 END)/SUM(CASE WHEN Gender = "Female" THEN 1 ELSE 0 END) AS Pass_Rate_Male
FROM students
GROUP BY Stage


UNION ALL

SELECT
Stage,
"Age-band" AS Category,
"18-20" AS Sub_Category,
SUM(CASE WHEN Status = "Pass" AND Age BETWEEN 18 AND 20 THEN 1 ELSE 0 END)/SUM(CASE WHEN Age BETWEEN 18 AND 20 THEN 1 ELSE 0 END) AS Pass_Rate_18_20
FROM students
GROUP BY Stage

UNION ALL

SELECT
Stage,
"Age-band" AS Category,
"21-23" AS Sub_Category,
SUM(CASE WHEN Status = "Pass" AND Age BETWEEN 21 AND 23 THEN 1 ELSE 0 END)/SUM(CASE WHEN Age BETWEEN 21 AND 23 THEN 1 ELSE 0 END) AS Pass_Rate_18_20
FROM students
GROUP BY Stage

UNION ALL

SELECT
Stage,
"Age-band" AS Category,
"24-25" AS Sub_Category,
SUM(CASE WHEN Status = "Pass" AND Age BETWEEN 24 AND 25 THEN 1 ELSE 0 END)/SUM(CASE WHEN Age BETWEEN 24 AND 25 THEN 1 ELSE 0 END) AS Pass_Rate_18_20
FROM students
GROUP BY Stage

UNION ALL

SELECT 
Stage,
"City" AS Category,
City AS Sub_Category,
SUM(CASE WHEN Status = "Pass" THEN 1 ELSE 0 END)/COUNT(*) AS Pass_Rate_City
FROM students
GROUP BY Stage, City
