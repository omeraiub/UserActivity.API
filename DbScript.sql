-- Create database
CREATE DATABASE UserActivity;
go
-- Use the database
USE UserActivity;

-- Create tables
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(100) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE UserActivities (
    ActivityId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    ActivityType VARCHAR(20) NOT NULL,
    OccurredTime DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_UserActivities_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
Go

-- Create stored procedures
CREATE PROCEDURE usp_InsertUserActivity
    @UserId INT,
    @ActivityType VARCHAR(20),
    @OccurredTime DATETIME
AS
BEGIN
    INSERT INTO UserActivities (UserId, ActivityType, OccurredTime)
    VALUES (@UserId, @ActivityType, @OccurredTime);
END;
Go

CREATE PROCEDURE usp_GenerateReport
    @UserId    INT,
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        u.UserId,
        u.Username,
		ua.ActivityId,
        ua.ActivityType,
        ua.OccurredTime
    FROM 
        Users u
    INNER JOIN 
        UserActivities ua ON u.UserId = ua.UserId
    WHERE 
      u.UserId = @UserId AND  ua.OccurredTime >= @StartDate AND ua.OccurredTime <= @EndDate
    ORDER BY 
        u.UserId, ua.OccurredTime;
END;
Go
-- Insert test data
INSERT INTO Users (Username, Email, PasswordHash)
VALUES 
    ('user1', 'user1@example.com', 'password1'),
    ('user2', 'user2@example.com', 'password2'),
    ('user3', 'user3@example.com', 'password3');

INSERT INTO UserActivities (UserId, ActivityType, OccurredTime)
VALUES 
    (1, 'Form Loaded', '2023-01-01 10:00:00'),
    (1, 'Form Submitted', '2023-01-01 10:05:00'),
    (2, 'Form Loaded', '2023-01-02 11:00:00'),
    (2, 'Form Submitted', '2023-01-02 11:05:00'),
    (3, 'Form Loaded', '2023-01-03 12:00:00'),
    (3, 'Form Submitted', '2023-01-03 12:05:00');