﻿CREATE TABLE [dbo].[Employees]
(
[EmployeeId] INT NOT NULL PRIMARY KEY IDENTITY,
[EmployeeCode] NVARCHAR(20) NOT NULL,
[FirstName] NVARCHAR(50) NOT NULL,
[LastName] NVARCHAR(50) NOT NULL,
[PhoneNumber] INT,
[Email] NVARCHAR(50)
)
