﻿/*
Deployment script for TheMobileShopDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TheMobileShopDB"
:setvar DefaultFilePrefix "TheMobileShopDB"
:setvar DefaultDataPath "C:\Users\Kate\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Kate\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Categories]...';


GO
CREATE TABLE [dbo].[Categories] (
    [CategoryId]   INT           IDENTITY (1, 1) NOT NULL,
    [CategoryCode] NVARCHAR (10) NOT NULL,
    [CategoryName] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CategoryId] ASC),
    UNIQUE NONCLUSTERED ([CategoryCode] ASC)
);


GO
PRINT N'Creating [dbo].[Employees]...';


GO
CREATE TABLE [dbo].[Employees] (
    [EmployeeId]   INT           IDENTITY (1, 1) NOT NULL,
    [EmployeeCode] NVARCHAR (7)  NOT NULL,
    [FirstName]    NVARCHAR (50) NOT NULL,
    [LastName]     NVARCHAR (50) NOT NULL,
    [PhoneNumber]  NVARCHAR (15) NULL,
    [Email]        NVARCHAR (50) NULL,
    [IsAdmin]      INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([EmployeeId] ASC)
);


GO
PRINT N'Creating [dbo].[Inventory]...';


GO
CREATE TABLE [dbo].[Inventory] (
    [ProductId]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (250) NULL,
    [Quantity]    INT            NOT NULL,
    [CategoryId]  INT            NOT NULL,
    [Brand]       NVARCHAR (50)  NULL,
    [Cost]        REAL           NOT NULL,
    [Price]       REAL           NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductId] ASC)
);


GO
PRINT N'Creating [dbo].[TransactionProducts]...';


GO
CREATE TABLE [dbo].[TransactionProducts] (
    [TransactionId] INT  NOT NULL,
    [ProductId]     INT  NOT NULL,
    [Quantity]      INT  NOT NULL,
    [Discount]      REAL NULL,
    CONSTRAINT [PK_TransactionProducts] PRIMARY KEY CLUSTERED ([TransactionId] ASC, [ProductId] ASC)
);


GO
PRINT N'Creating [dbo].[Transactions]...';


GO
CREATE TABLE [dbo].[Transactions] (
    [TransactionId] INT           IDENTITY (1, 1) NOT NULL,
    [Date]          DATE          NOT NULL,
    [Time]          TIME (7)      NOT NULL,
    [PaymentMethod] NVARCHAR (20) NULL,
    [TotalCost]     REAL          NOT NULL,
    [TaxAmount]     REAL          NOT NULL,
    [TotalDiscount] REAL          NULL,
    [TotalPrice]    REAL          NOT NULL,
    [EmployeeId]    INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([TransactionId] ASC)
);


GO
PRINT N'Creating [dbo].[FK_Inventory_Categories_CategoryId]...';


GO
ALTER TABLE [dbo].[Inventory]
    ADD CONSTRAINT [FK_Inventory_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]);


GO
PRINT N'Creating [dbo].[FK_TransactionProducts_Inventory_ProductId]...';


GO
ALTER TABLE [dbo].[TransactionProducts]
    ADD CONSTRAINT [FK_TransactionProducts_Inventory_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Inventory] ([ProductId]);


GO
PRINT N'Creating [dbo].[FK_TransactionProducts_Transactions_TransactionId]...';


GO
ALTER TABLE [dbo].[TransactionProducts]
    ADD CONSTRAINT [FK_TransactionProducts_Transactions_TransactionId] FOREIGN KEY ([TransactionId]) REFERENCES [dbo].[Transactions] ([TransactionId]);


GO
PRINT N'Creating [dbo].[FK_Transactions_Employees_EmployeeId]...';


GO
ALTER TABLE [dbo].[Transactions]
    ADD CONSTRAINT [FK_Transactions_Employees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employees] ([EmployeeId]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '545252f1-db4f-404f-a3b9-bb9cba511edf')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('545252f1-db4f-404f-a3b9-bb9cba511edf')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '481a062e-89a2-4614-b9e0-340edbf8606c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('481a062e-89a2-4614-b9e0-340edbf8606c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f284f761-b14c-4f81-a381-fa2677d7f54c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f284f761-b14c-4f81-a381-fa2677d7f54c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c0e7c323-0c2e-44aa-89e5-f642ae2c2461')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c0e7c323-0c2e-44aa-89e5-f642ae2c2461')

GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
USE[TheMobileShopDB]
GO

SET IDENTITY_INSERT [dbo].[Employees] ON
INSERT INTO [dbo].[Employees] ([EmployeeId], [EmployeeCode], [FirstName], [LastName], [PhoneNumber], [Email], [IsAdmin]) VALUES (1,'ADM-001','Kate','Obertas','2362868281','kate@gmail.ca',1) 
INSERT INTO [dbo].[Employees] ([EmployeeId], [EmployeeCode], [FirstName], [LastName], [PhoneNumber], [Email], [IsAdmin]) VALUES (2,'ADM-002','Indu Priya','Addepalli','1234567891','indupriyaaddepalli@student.douglas.ca',1);
INSERT INTO [dbo].[Employees] ([EmployeeId], [EmployeeCode], [FirstName], [LastName], [PhoneNumber], [Email], [IsAdmin]) VALUES (3,'ADM-003','Naga Sudheer','Bolla','1234567892','sudheerbolla@student.douglas.ca',1);
INSERT INTO [dbo].[Employees] ([EmployeeId], [EmployeeCode], [FirstName], [LastName], [PhoneNumber], [Email], [IsAdmin]) VALUES (4,'EMP-001','Paul','Allen','7784567893','pallen@outlook.com',0);
INSERT INTO [dbo].[Employees] ([EmployeeId], [EmployeeCode], [FirstName], [LastName], [PhoneNumber], [Email], [IsAdmin]) VALUES (5,'EMP-002','Linus','Torvalds','6721233467','linux@yahoo.com',0);
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO

SET IDENTITY_INSERT [dbo].[Categories] ON
INSERT INTO [dbo].[Categories] ([CategoryId],[CategoryCode],[CategoryName]) VALUES ('1','SP','Smartphone');
INSERT INTO [dbo].[Categories] ([CategoryId],[CategoryCode],[CategoryName]) VALUES ('2','TA','Tablet');
INSERT INTO [dbo].[Categories] ([CategoryId],[CategoryCode],[CategoryName]) VALUES ('3','AC','Accessory');
INSERT INTO [dbo].[Categories] ([CategoryId],[CategoryCode],[CategoryName]) VALUES ('4','CP','Cell Phone');
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO

SET IDENTITY_INSERT [dbo].[Inventory] ON
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('1','Galaxy A11 32GB','Samsung Galaxy A11 smartphone. Its 6.4\" Infinity-O display with large HD+ screen. The triple-camera setup. Its long-lasting lithium-ion battery allows you to use your phone for extended hours without needing to recharge.','15','1','Samsung','184.55','409.99');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('2','iPhone 12 Pro Max','5.8-inch Super Retina XDR OLED display Water and dust resistant (4 meters for up to 30 minutes, IP68) Triple-camera system with 12MP Ultra Wide, Wide, and Telephoto cameras; Night mode, Portrait mode, and 4K video up to 60fp','10','1','Apple','1000.00','1599.99');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('3','Pixel 5','Dimensions 6in (H) x 2.77in (W) x 0.31in (D) Weight 5.33 ounces Operating System Android Display and User Interface: Display Size 6 Display Technology N/A Pixel Density 432 PPI','8','1','Google','800.00','1399.99');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('4','Nokia 3310 2G','Nokia 3310 2G Feature Phone Dual SIM 2.4inch Color Screen BT 1500mAh 64MB 2MP Camera FM MP3 With LED Flashlight GSM Cell Phone','10','4','Nokia','10.00','25.66');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('5','Galaxy Tab A 8\" 32GB','Samsung Galaxy Tab A 8\" 32GB Android Tablet with Quad-Core Processor - Black','5','2','Samsung','80.00','199.99');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('6','iPad Pro (12.9-inch, Wi-Fi, 128GB)','Apple iPad Pro (12.9-inch, Wi-Fi, 128GB) - Space Grey 12.9-inch edge-to-edge Liquid Retina display with ProMotion, True Tone and P3 wide colour','6','2','Apple','900.00','1299.98');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('7','Leather Cover for Galaxy S20','Give your phone an elegant look and feel with this premium European leather cover. Its refined aluminum buttons add style and a distinct sense of luxury. With a soft grip and slim design, you will enjoy the balance of convenience and luxury every time you pick up your phone.','3','3','Samsung','10.00','35.00');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('8','5W USB Power Adapter','Featuring an ultracompact design, this power adapter offers fast, efficient charging at home, in the office or on the go. It works with any Apple Watch, iPhone or iPod model.','30','3','Apple','5.00','23.98');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('9','TUNE 120TWS Headphones','Truly Wireless Headphones. They are powerful in sound thanks to a 5.8mm driver featuring JBL Pure Bass sound and colorful in design. ','3','3','JBL','40.00','99.98');
INSERT INTO [dbo].[Inventory] ([ProductId],[Name],[Description],[Quantity],[CategoryId],[Brand],[Cost],[Price]) VALUES ('10','Moto G8 Power Lite XT2055-2 64GB 4GB','Motorola Moto G8 Power Lite XT2055-2 64GB 4GB - Dual Sim - Brand New Unlocked - Arctic Blue','5','4','Motorola','100.00','249.99');
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO

SET IDENTITY_INSERT [dbo].[Transactions] ON
INSERT INTO [dbo].[Transactions] ([TransactionId],[Date],[Time],[PaymentMethod],[TotalCost],[TaxAmount],[TotalDiscount],[TotalPrice],[EmployeeId]) VALUES ('1','2021-04-03','13:10','Cash','2300.00','480.12','20.00','4000.50','1');
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO

INSERT INTO [dbo].[TransactionProducts] ([TransactionId],[ProductId],[Quantity],[Discount]) VALUES ('1','1','1','NULL');
INSERT INTO [dbo].[TransactionProducts] ([TransactionId],[ProductId],[Quantity],[Discount]) VALUES ('1','2','2','20.00');
INSERT INTO [dbo].[TransactionProducts] ([TransactionId],[ProductId],[Quantity],[Discount]) VALUES ('1','3','1','NULL');
GO



GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
