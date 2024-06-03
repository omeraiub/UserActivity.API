CREATE PROCEDURE usp_SignUpReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    WITH CTE AS (
        SELECT 
            ua.UserId,
            CAST(ua.OccurredTime AS DATE) AS Date,
            ua.ActivityType,
            DATEDIFF(MINUTE, 
                (SELECT TOP 1 ua2.OccurredTime FROM UserActivities ua2 WHERE ua2.UserId = ua.UserId AND ua2.ActivityType = 'Form Loaded' ORDER BY ua2.OccurredTime DESC), 
                ua.OccurredTime) AS TimeSpent
        FROM 
            UserActivities ua
        WHERE 
            ua.OccurredTime >= @StartDate AND ua.OccurredTime <= @EndDate
    )
    SELECT 
        Date,
        COUNT(DISTINCT CASE WHEN ActivityType = 'Form Loaded' THEN UserId END) AS VisitorsEntered,
        COUNT(DISTINCT CASE WHEN ActivityType = 'Form Submitted' THEN UserId END) AS VisitorsCompleted,
        AVG(CASE WHEN ActivityType = 'Form Submitted' THEN TimeSpent END) AS AvgTimeSpent,
        (COUNT(DISTINCT CASE WHEN ActivityType = 'Form Loaded' THEN UserId END) - COUNT(DISTINCT CASE WHEN ActivityType = 'Form Submitted' THEN UserId END)) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN ActivityType = 'Form Loaded' THEN UserId END), 0) AS PercentageNotCompleted
    FROM 
        CTE
    GROUP BY 
        Date
    ORDER BY 
        Date;
END;
Go


INSERT INTO Users (Username, Email, PasswordHash)
VALUES 
    ('user1', 'user1@example.com', 'password1'),
    ('user2', 'user2@example.com', 'password2'),
    ('user3', 'user3@example.com', 'password3'),
    ('user4', 'user4@example.com', 'password4'),
    ('user5', 'user5@example.com', 'password5'),
    ('user6', 'user6@example.com', 'password6'),
    ('user7', 'user7@example.com', 'password7'),
    ('user8', 'user8@example.com', 'password8'),
    ('user9', 'user9@example.com', 'password9'),
    ('user10', 'user10@example.com', 'password10'),
    ('user11', 'user11@example.com', 'password11'),
    ('user12', 'user12@example.com', 'password12'),
    ('user13', 'user13@example.com', 'password13'),
    ('user14', 'user14@example.com', 'password14'),
    ('user15', 'user15@example.com', 'password15'),
    ('user16', 'user16@example.com', 'password16'),
    ('user17', 'user17@example.com', 'password17'),
    ('user18', 'user18@example.com', 'password18'),
    ('user19', 'user19@example.com', 'password19'),
    ('user20', 'user20@example.com', 'password20');

-- Insert activities
DECLARE @i INT = 1;
WHILE @i <= 20
BEGIN
   IF @i % 2 = 0
   BEGIN
    INSERT INTO UserActivities (UserId, ActivityType, OccurredTime)
    VALUES 
        (@i, 'Form Loaded', DATEADD(DAY, @i % 5, '2024-01-01 10:00:00')),
        (@i, 'Form Submitted', DATEADD(MINUTE, @i, DATEADD(DAY, @i % 5, '2024-01-01 10:00:00')));
   END
   ELSE
   BEGIN
      INSERT INTO UserActivities (UserId, ActivityType, OccurredTime)
       VALUES 
        (@i, 'Form Loaded', DATEADD(DAY, @i % 5, '2024-01-01 10:00:00'))
   END
SET @i = @i + 1;
     
END;