WITH NextStage AS (
    SELECT 
        s1.StudentID,
        s1.Stage AS currentStage,
        s1.ExamDateTime AS currentExam,
        s1.Status,
        s2.Stage AS NextStage,
        s2.ExamDateTime AS NextExam
    FROM students s1
    JOIN students s2
        ON s1.StudentID = s2.StudentID
       AND s2.ExamDateTime > s1.ExamDateTime
),
TurnAroundTime AS (
    SELECT 
        n.StudentID,
        n.currentStage,
        n.NextStage,
        TIMESTAMPDIFF(DAY, n.currentExam, MIN(n.NextExam)) AS TurnAround_DAYS
    FROM NextStage n
    WHERE n.Status = 'Pass'
    GROUP BY n.StudentID, n.currentStage, n.NextStage, n.currentExam
),
STU_COUNT AS (
    SELECT 
        Stage,
        COUNT(*) AS TOTAL_COUNT,
        SUM(CASE WHEN Status = 'Pass' THEN 1 ELSE 0 END) AS ADVANCE,
        SUM(CASE WHEN Status = 'Fail' THEN 1 ELSE 0 END) AS DROP_OUT 
    FROM students
    GROUP BY Stage
)
SELECT
    s.Stage,
    s.TOTAL_COUNT,
    s.ADVANCE,
    s.DROP_OUT,
    AVG(t.TurnAround_DAYS) AS AVG_TurnAround
FROM STU_COUNT AS s
LEFT JOIN TurnAroundTime AS t
    ON s.Stage = t.currentStage
GROUP BY s.Stage;
