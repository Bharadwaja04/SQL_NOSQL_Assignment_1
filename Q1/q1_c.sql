
DROP PROCEDURE IF EXISTS StudentPerformance;

DELIMITER //


CREATE PROCEDURE StudentPerformance(
	IN student_id varchar(50)	
)
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE stu_age INT;
    DECLARE stu_city varchar(50);
    DECLARE stu_gender varchar(50);
    DECLARE stu_status varchar(50);
    
    SELECT 
    Gender,Age,City,Status
    INTO stu_gender,stu_age,stu_city,stu_status
    FROM students 
    WHERE StudentID = student_id
    LIMIT 1;
    
    SELECT 
    Stage,
    stu_gender AS Student_Gender,
    stu_age AS Student_Age,
    stu_city AS Student_City,
    stu_status AS Student_Status,
    SUM(CASE WHEN Status = "Pass" AND Gender = stu_gender THEN 1 ELSE 0 END)/SUM(CASE WHEN Gender = stu_gender THEN 1 ELSE 0 END) AS Pass_Rate_Gender,
    SUM(CASE WHEN Status = "Pass" AND Age = stu_age THEN 1 ELSE 0 END)/SUM(CASE WHEN Age = stu_age THEN 1 ELSE 0 END) AS Pass_Rate_Age,
    SUM(CASE WHEN Status = "Pass" AND City = stu_city THEN 1 ELSE 0 END)/SUM(CASE WHEN City = stu_city THEN 1 ELSE 0 END) AS Pass_Rate_City,
    (
    SUM(CASE WHEN Status = "Pass" AND Gender = stu_gender THEN 1 ELSE 0 END)/SUM(CASE WHEN Gender = stu_gender THEN 1 ELSE 0 END) +
    SUM(CASE WHEN Status = "Pass" AND Age = stu_age THEN 1 ELSE 0 END)/SUM(CASE WHEN Age = stu_age THEN 1 ELSE 0 END) +
    SUM(CASE WHEN Status = "Pass" AND City = stu_city THEN 1 ELSE 0 END)/SUM(CASE WHEN City = stu_city THEN 1 ELSE 0 END)
    ) / 3 AS Mean_Pass_Rate
    FROM students
    GROUP BY Stage;
    
END //

DELIMITER ;


CALL StudentPerformance("S202500001");
	