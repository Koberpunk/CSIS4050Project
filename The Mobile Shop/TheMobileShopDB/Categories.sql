﻿CREATE TABLE [dbo].[Categories]
(
[CategoryId] INT NOT NULL PRIMARY KEY IDENTITY,
[CategoryCode] NVARCHAR (10) NOT NULL UNIQUE,
[CategoryName] NVARCHAR(50)
)
