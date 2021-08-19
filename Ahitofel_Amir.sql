/*
Deployment script for Ahitofel_Amir

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Ahitofel_Amir"
:setvar DefaultFilePrefix "Ahitofel_Amir"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\"

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
USE [$(DatabaseName)];


GO
PRINT N'Creating Schema [History]...';


GO
CREATE SCHEMA [History]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating Table [History].[Teams]...';


GO
CREATE TABLE [History].[Teams] (
    [TeamID]       TINYINT       NOT NULL,
    [Team]         VARCHAR (30)  NULL,
    [TeamManager]  NCHAR (20)    NULL,
    [SysStartTime] DATETIME2 (7) NOT NULL,
    [SysEndTime]   DATETIME2 (7) NOT NULL
);


GO
PRINT N'Creating Index [History].[Teams].[ix_Teams]...';


GO
CREATE CLUSTERED INDEX [ix_Teams]
    ON [History].[Teams]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating Table [History].[Projects]...';


GO
CREATE TABLE [History].[Projects] (
    [ProjNum]              NCHAR (6)     NOT NULL,
    [ProjName]             VARCHAR (50)  NULL,
    [CustID]               NCHAR (5)     NOT NULL,
    [IDCustProjectManager] NCHAR (9)     NOT NULL,
    [SeniorProjectManager] NCHAR (9)     NULL,
    [SysStartTime]         DATETIME2 (7) NOT NULL,
    [SysEndTime]           DATETIME2 (7) NOT NULL
);


GO
PRINT N'Creating Index [History].[Projects].[ix_Projects]...';


GO
CREATE CLUSTERED INDEX [ix_Projects]
    ON [History].[Projects]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating Table [History].[CustomerContacts]...';


GO
CREATE TABLE [History].[CustomerContacts] (
    [ContactIDNumber] NCHAR (9)     NOT NULL,
    [CustID]          NCHAR (5)     NOT NULL,
    [FirstName]       VARCHAR (30)  NOT NULL,
    [LastName]        VARCHAR (30)  NOT NULL,
    [Position]        TINYINT       NOT NULL,
    [Address]         VARCHAR (100) NULL,
    [BirthDate]       DATE          NULL,
    [FavorCake]       VARCHAR (50)  NULL,
    [SpouseFirstName] VARCHAR (30)  NULL,
    [SpouseLastName]  VARCHAR (30)  NULL,
    [SpouseIDNumber]  VARCHAR (50)  NULL,
    [SpouseAddress]   VARCHAR (100) NULL,
    [SpouseBirthDate] DATE          NULL,
    [FavorCakeSpouse] VARCHAR (50)  NULL,
    [SysStartTime]    DATETIME2 (7) NOT NULL,
    [SysEndTime]      DATETIME2 (7) NOT NULL
);


GO
PRINT N'Creating Index [History].[CustomerContacts].[ix_CustomerContacts]...';


GO
CREATE CLUSTERED INDEX [ix_CustomerContacts]
    ON [History].[CustomerContacts]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating Table [History].[Customers]...';


GO
CREATE TABLE [History].[Customers] (
    [CustName]     VARCHAR (30)  NOT NULL,
    [CustID]       NCHAR (5)     NOT NULL,
    [CompanySize]  TINYINT       NULL,
    [NoVat?]       BIT           NOT NULL,
    [TeamID]       TINYINT       NOT NULL,
    [SysStartTime] DATETIME2 (7) NOT NULL,
    [SysEndTime]   DATETIME2 (7) NOT NULL
);


GO
PRINT N'Creating Index [History].[Customers].[ix_Customers]...';


GO
CREATE CLUSTERED INDEX [ix_Customers]
    ON [History].[Customers]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating Table [History].[Consults]...';


GO
CREATE TABLE [History].[Consults] (
    [EmpID]               NCHAR (6)     NOT NULL,
    [FirstName]           VARCHAR (30)  NOT NULL,
    [LastName]            VARCHAR (30)  NOT NULL,
    [IDNumber]            NCHAR (9)     NOT NULL,
    [MainAddress]         VARCHAR (100) NULL,
    [SecondAddress]       VARCHAR (100) NULL,
    [FamilyStatus]        TINYINT       NOT NULL,
    [NoOfChildrenUnder18] TINYINT       NULL,
    [Gender]              TINYINT       NOT NULL,
    [Position]            TINYINT       NULL,
    [Team]                TINYINT       NULL,
    [SpouseIDNumber]      NCHAR (9)     NULL,
    [SpouseFirstName]     VARCHAR (30)  NULL,
    [SpouseLastName]      VARCHAR (30)  NULL,
    [SpouseAddress]       VARCHAR (100) NULL,
    [SpouseGender]        TINYINT       NULL,
    [StartDate]           DATE          NULL,
    [EndDate]             DATE          NULL,
    [Fired?]              BIT           NULL,
    [SysStartTime]        DATETIME2 (7) NOT NULL,
    [SysEndTime]          DATETIME2 (7) NOT NULL
);


GO
PRINT N'Creating Index [History].[Consults].[ix_Consults]...';


GO
CREATE CLUSTERED INDEX [ix_Consults]
    ON [History].[Consults]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating Table [dbo].[BlackList]...';


GO
CREATE TABLE [dbo].[BlackList] (
    [CustID]    NCHAR (5) NOT NULL,
    [ProjNum]   NCHAR (6) NOT NULL,
    [StartDate] DATE      NOT NULL,
    [EndDate]   DATE      NOT NULL,
    CONSTRAINT [PK_BlackList] PRIMARY KEY CLUSTERED ([CustID] ASC)
);


GO
PRINT N'Creating Index [dbo].[BlackList].[NonClusteredIndex-20210817-143639]...';


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210817-143639]
    ON [dbo].[BlackList]([ProjNum] ASC);


GO
PRINT N'Creating Table [dbo].[CompanySize]...';


GO
CREATE TABLE [dbo].[CompanySize] (
    [ID]       TINYINT      NOT NULL,
    [SizeDesc] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_CompanySize] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[ConsultentsChildren]...';


GO
CREATE TABLE [dbo].[ConsultentsChildren] (
    [FirstName] VARCHAR (30)  NOT NULL,
    [LastName]  VARCHAR (30)  NOT NULL,
    [Birthdate] DATE          NULL,
    [IDNumber]  NCHAR (9)     NOT NULL,
    [Address]   VARCHAR (100) NULL,
    [EmpID]     NCHAR (6)     NOT NULL,
    CONSTRAINT [PK_ConsultentsChildren] PRIMARY KEY CLUSTERED ([IDNumber] ASC)
);


GO
PRINT N'Creating Index [dbo].[ConsultentsChildren].[NonClusteredIndex-20210817-144132]...';


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210817-144132]
    ON [dbo].[ConsultentsChildren]([IDNumber] ASC);


GO
PRINT N'Creating Table [dbo].[Consults]...';


GO
CREATE TABLE [dbo].[Consults] (
    [EmpID]               NCHAR (6)                                          NOT NULL,
    [FirstName]           VARCHAR (30)                                       NOT NULL,
    [LastName]            VARCHAR (30)                                       NOT NULL,
    [IDNumber]            NCHAR (9)                                          NOT NULL,
    [MainAddress]         VARCHAR (100)                                      NULL,
    [SecondAddress]       VARCHAR (100)                                      NULL,
    [FamilyStatus]        TINYINT                                            NOT NULL,
    [NoOfChildrenUnder18] TINYINT                                            NULL,
    [Gender]              TINYINT                                            NOT NULL,
    [Position]            TINYINT                                            NULL,
    [Team]                TINYINT                                            NULL,
    [SpouseIDNumber]      NCHAR (9)                                          NULL,
    [SpouseFirstName]     VARCHAR (30)                                       NULL,
    [SpouseLastName]      VARCHAR (30)                                       NULL,
    [SpouseAddress]       VARCHAR (100)                                      NULL,
    [SpouseGender]        TINYINT                                            NULL,
    [StartDate]           DATE                                               NULL,
    [EndDate]             DATE                                               NULL,
    [Fired?]              BIT                                                NULL,
    [SysStartTime]        DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    [SysEndTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   NOT NULL,
    CONSTRAINT [PK_Consults] PRIMARY KEY CLUSTERED ([EmpID] ASC),
    UNIQUE NONCLUSTERED ([IDNumber] ASC),
    UNIQUE NONCLUSTERED ([IDNumber] ASC),
    UNIQUE NONCLUSTERED ([SpouseIDNumber] ASC),
    UNIQUE NONCLUSTERED ([SpouseIDNumber] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[Consults], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating Table [dbo].[ConsultsMonthlySalary]...';


GO
CREATE TABLE [dbo].[ConsultsMonthlySalary] (
    [EmpID]               NCHAR (6)      NOT NULL,
    [MonthId]             TINYINT        NOT NULL,
    [MonthlyHoursPlanned] DECIMAL (6, 2) NOT NULL,
    [MonthlyHoursActual]  DECIMAL (6, 2) NOT NULL,
    [ExtraHours]          DECIMAL (6, 2) NULL,
    [DayOffDeduction]     DECIMAL (6, 2) NULL,
    [Salary]              DECIMAL (5, 2) NULL,
    [SocialProv]          DECIMAL (4, 2) NULL,
    [SalaryIncrease]      REAL           NULL,
    [ExtraHoursILS]       DECIMAL (5, 2) NULL,
    [ManagementSupp]      DECIMAL (4, 2) NULL,
    CONSTRAINT [PK_ConsultsMonthlySalary] PRIMARY KEY CLUSTERED ([EmpID] ASC)
);


GO
PRINT N'Creating Table [dbo].[ConsultsSalary]...';


GO
CREATE TABLE [dbo].[ConsultsSalary] (
    [EmpID]          NCHAR (6)      NOT NULL,
    [Position]       TINYINT        NOT NULL,
    [StartDate]      DATE           NOT NULL,
    [EndDate]        DATE           NULL,
    [IsManager?]     BIT            NOT NULL,
    [Salary]         INT            NOT NULL,
    [SocialProv]     DECIMAL (4, 2) NOT NULL,
    [SalaryIncrease] REAL           NULL,
    CONSTRAINT [PK_ConsultsSalary] PRIMARY KEY CLUSTERED ([EmpID] ASC)
);


GO
PRINT N'Creating Table [dbo].[ContactsChildren]...';


GO
CREATE TABLE [dbo].[ContactsChildren] (
    [ContactIDNumber] NCHAR (9)     NOT NULL,
    [ChildIDNumber]   NCHAR (9)     NOT NULL,
    [FirstName]       VARCHAR (30)  NOT NULL,
    [LastName]        VARCHAR (30)  NOT NULL,
    [Address]         VARCHAR (100) NULL,
    [BirthDate]       DATE          NULL,
    [FavorCake]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_ContactsChildren] PRIMARY KEY CLUSTERED ([ChildIDNumber] ASC),
    UNIQUE NONCLUSTERED ([ContactIDNumber] ASC)
);


GO
PRINT N'Creating Index [dbo].[ContactsChildren].[NonClusteredIndex-20210817-144905]...';


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210817-144905]
    ON [dbo].[ContactsChildren]([ContactIDNumber] ASC);


GO
PRINT N'Creating Table [dbo].[ConversationsResults]...';


GO
CREATE TABLE [dbo].[ConversationsResults] (
    [ID]         INT          IDENTITY (1, 1) NOT NULL,
    [ResultDesc] VARCHAR (20) NULL,
    CONSTRAINT [PK_ConversationsResults] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[ConversationsType]...';


GO
CREATE TABLE [dbo].[ConversationsType] (
    [ID]       INT          IDENTITY (1, 1) NOT NULL,
    [CallDesc] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_ConversationsType] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[CustomerContacts]...';


GO
CREATE TABLE [dbo].[CustomerContacts] (
    [ContactIDNumber] NCHAR (9)                                          NOT NULL,
    [CustID]          NCHAR (5)                                          NOT NULL,
    [FirstName]       VARCHAR (30)                                       NOT NULL,
    [LastName]        VARCHAR (30)                                       NOT NULL,
    [Position]        TINYINT                                            NOT NULL,
    [Address]         VARCHAR (100)                                      NULL,
    [BirthDate]       DATE                                               NULL,
    [FavorCake]       VARCHAR (50)                                       NULL,
    [SpouseFirstName] VARCHAR (30)                                       NULL,
    [SpouseLastName]  VARCHAR (30)                                       NULL,
    [SpouseIDNumber]  VARCHAR (50)                                       NULL,
    [SpouseAddress]   VARCHAR (100)                                      NULL,
    [SpouseBirthDate] DATE                                               NULL,
    [FavorCakeSpouse] VARCHAR (50)                                       NULL,
    [SysStartTime]    DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    [SysEndTime]      DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   NOT NULL,
    CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED ([ContactIDNumber] ASC),
    UNIQUE NONCLUSTERED ([SpouseIDNumber] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[CustomerContacts], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating Table [dbo].[Customers]...';


GO
CREATE TABLE [dbo].[Customers] (
    [CustName]     VARCHAR (30)                                       NOT NULL,
    [CustID]       NCHAR (5)                                          NOT NULL,
    [CompanySize]  TINYINT                                            NULL,
    [NoVat?]       BIT                                                NOT NULL,
    [TeamID]       TINYINT                                            NOT NULL,
    [SysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    [SysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   NOT NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[Customers], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating Table [dbo].[EmployeeProjects]...';


GO
CREATE TABLE [dbo].[EmployeeProjects] (
    [ProjNum]    NCHAR (6)      NOT NULL,
    [EmpID]      NCHAR (6)      NOT NULL,
    [CustRate]   DECIMAL (6, 2) NOT NULL,
    [StartHour]  DATE           NOT NULL,
    [EndHour]    DATE           NOT NULL,
    [CurrencyID] INT            NOT NULL,
    CONSTRAINT [PK_EmployeeProjects] PRIMARY KEY CLUSTERED ([ProjNum] ASC)
);


GO
PRINT N'Creating Index [dbo].[EmployeeProjects].[EmpID]...';


GO
CREATE NONCLUSTERED INDEX [EmpID]
    ON [dbo].[EmployeeProjects]([EmpID] ASC);


GO
PRINT N'Creating Table [dbo].[ExchangeRates]...';


GO
CREATE TABLE [dbo].[ExchangeRates] (
    [Date]         DATE           NOT NULL,
    [CurrencyID]   TINYINT        NOT NULL,
    [CurrencyName] VARCHAR (10)   NOT NULL,
    [ILSRate]      DECIMAL (4, 2) NOT NULL,
    CONSTRAINT [PK_ExchangeRates] PRIMARY KEY CLUSTERED ([CurrencyID] ASC)
);


GO
PRINT N'Creating Table [dbo].[Genders]...';


GO
CREATE TABLE [dbo].[Genders] (
    [Id]     TINYINT      NOT NULL,
    [Gender] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Holidays]...';


GO
CREATE TABLE [dbo].[Holidays] (
    [Date]       DATETIME NOT NULL,
    [IsWeekend?] BIT      NOT NULL,
    [IsHoliday?] BIT      NOT NULL,
    CONSTRAINT [PK_Holidays] PRIMARY KEY CLUSTERED ([Date] ASC)
);


GO
PRINT N'Creating Table [dbo].[Invoices]...';


GO
CREATE TABLE [dbo].[Invoices] (
    [Id_new]          INT       IDENTITY (1, 1) NOT NULL,
    [Month]           TINYINT   NOT NULL,
    [CustID]          NCHAR (5) NOT NULL,
    [InvoiceDate]     DATE      NOT NULL,
    [ProjNum]         NCHAR (6) NOT NULL,
    [EmpID]           NCHAR (6) NOT NULL,
    [OfficeID]        NCHAR (2) NOT NULL,
    [TotHours]        INT       NULL,
    [CarHours]        REAL      NULL,
    [DrivingCost]     INT       NULL,
    [PricePerHour]    REAL      NULL,
    [BlackListFee]    REAL      NULL,
    [SpecialDatesFee] REAL      NULL,
    [TotalPayment]    INT       NULL
);


GO
PRINT N'Creating Table [dbo].[ManagementSupplements]...';


GO
CREATE TABLE [dbo].[ManagementSupplements] (
    [StartDate]      DATE           NOT NULL,
    [EndDate]        DATE           NULL,
    [ManagementSupp] DECIMAL (4, 2) NOT NULL,
    CONSTRAINT [PK_ManagementSupplements] PRIMARY KEY CLUSTERED ([StartDate] ASC)
);


GO
PRINT N'Creating Table [dbo].[ManagersConversations]...';


GO
CREATE TABLE [dbo].[ManagersConversations] (
    [CallID]           INT       NOT NULL,
    [EmpID]            NCHAR (6) NOT NULL,
    [ProjNum]          NCHAR (6) NOT NULL,
    [ReportDate]       DATE      NOT NULL,
    [ConversationDate] DATE      NOT NULL,
    [MeetId]           INT       NOT NULL,
    CONSTRAINT [PK_ManagersConversations] PRIMARY KEY CLUSTERED ([CallID] ASC)
);


GO
PRINT N'Creating Index [dbo].[ManagersConversations].[ProjNum]...';


GO
CREATE NONCLUSTERED INDEX [ProjNum]
    ON [dbo].[ManagersConversations]([ProjNum] ASC);


GO
PRINT N'Creating Index [dbo].[ManagersConversations].[EmpID]...';


GO
CREATE NONCLUSTERED INDEX [EmpID]
    ON [dbo].[ManagersConversations]([EmpID] ASC);


GO
PRINT N'Creating Table [dbo].[MaritalStatus]...';


GO
CREATE TABLE [dbo].[MaritalStatus] (
    [ID]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_MaritalStatus] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[Offices]...';


GO
CREATE TABLE [dbo].[Offices] (
    [CustID]          NCHAR (5)      NOT NULL,
    [OfficeID]        NCHAR (2)      NOT NULL,
    [OfficeName]      VARCHAR (50)   NOT NULL,
    [Address]         VARCHAR (50)   NULL,
    [OfficeDistHours] DECIMAL (4, 2) NOT NULL,
    CONSTRAINT [PK_Offices] PRIMARY KEY CLUSTERED ([OfficeID] ASC)
);


GO
PRINT N'Creating Table [dbo].[Parameters]...';


GO
CREATE TABLE [dbo].[Parameters] (
    [ID]        INT           IDENTITY (1, 1) NOT NULL,
    [ValueDesc] VARCHAR (100) NOT NULL,
    [Value]     INT           NOT NULL,
    CONSTRAINT [PK_Parameters] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[Positions]...';


GO
CREATE TABLE [dbo].[Positions] (
    [ID]           TINYINT      IDENTITY (1, 1) NOT NULL,
    [PositionDesc] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[ProjectReports]...';


GO
CREATE TABLE [dbo].[ProjectReports] (
    [EmpID]       NCHAR (6)      NOT NULL,
    [ReportDate]  DATE           NOT NULL,
    [StartTime]   DATETIME       NOT NULL,
    [EndTime]     DATETIME       NOT NULL,
    [BillHours]   DECIMAL (5, 2) NOT NULL,
    [IsCanceled?] BIT            NULL,
    [CustID]      NCHAR (5)      NOT NULL,
    [ProjNum]     NCHAR (6)      NOT NULL,
    [OfficeId]    NCHAR (2)      NOT NULL,
    [PaymentDate] DATE           NULL,
    CONSTRAINT [PK_ProjectReports_1] PRIMARY KEY CLUSTERED ([EmpID] ASC, [StartTime] ASC, [ProjNum] ASC)
);


GO
PRINT N'Creating Index [dbo].[ProjectReports].[CustID]...';


GO
CREATE NONCLUSTERED INDEX [CustID]
    ON [dbo].[ProjectReports]([CustID] ASC);


GO
PRINT N'Creating Table [dbo].[Projects]...';


GO
CREATE TABLE [dbo].[Projects] (
    [ProjNum]              NCHAR (6)                                          NOT NULL,
    [ProjName]             VARCHAR (50)                                       NULL,
    [CustID]               NCHAR (5)                                          NOT NULL,
    [IDCustProjectManager] NCHAR (9)                                          NOT NULL,
    [SeniorProjectManager] NCHAR (9)                                          NULL,
    [SysStartTime]         DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    [SysEndTime]           DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   NOT NULL,
    CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED ([ProjNum] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[Projects], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating Table [dbo].[SpecialRates]...';


GO
CREATE TABLE [dbo].[SpecialRates] (
    [DateTypeID]   TINYINT      NOT NULL,
    [DateTypeDesc] VARCHAR (10) NOT NULL,
    [ExtraRate]    REAL         NOT NULL,
    CONSTRAINT [PK_SpecialRates] PRIMARY KEY CLUSTERED ([DateTypeID] ASC)
);


GO
PRINT N'Creating Table [dbo].[TaxPoints]...';


GO
CREATE TABLE [dbo].[TaxPoints] (
    [StartDate]                 DATE           NOT NULL,
    [EndDate]                   DATE           NULL,
    [TaxCreditPointsMan]        DECIMAL (4, 2) NOT NULL,
    [TaxCreditPointsWoman]      DECIMAL (4, 2) NOT NULL,
    [TaxCreditPointsManChild]   DECIMAL (4, 2) NOT NULL,
    [TaxCreditPointsWomanChild] DECIMAL (4, 2) NOT NULL,
    CONSTRAINT [PK_TaxPoint] PRIMARY KEY CLUSTERED ([StartDate] ASC)
);


GO
PRINT N'Creating Table [dbo].[Teams]...';


GO
CREATE TABLE [dbo].[Teams] (
    [TeamID]       TINYINT                                            NOT NULL,
    [Team]         VARCHAR (30)                                       NULL,
    [TeamManager]  NCHAR (20)                                         NULL,
    [SysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    [SysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   NOT NULL,
    CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED ([TeamID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[Teams], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating Table [dbo].[VatRates]...';


GO
CREATE TABLE [dbo].[VatRates] (
    [ID]        INT            IDENTITY (1, 1) NOT NULL,
    [StartDate] DATE           NOT NULL,
    [EndDate]   DATE           NULL,
    [VatRate]   DECIMAL (5, 2) NOT NULL,
    CONSTRAINT [PK_VatRates] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[WorkDays]...';


GO
CREATE TABLE [dbo].[WorkDays] (
    [MonthID]       TINYINT        NOT NULL,
    [MonthWorkDays] TINYINT        NULL,
    [MonthlyHours]  DECIMAL (6, 2) NULL,
    CONSTRAINT [PK_WorkDays] PRIMARY KEY CLUSTERED ([MonthID] ASC)
);


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysStartConsult]...';


GO
ALTER TABLE [dbo].[Consults]
    ADD CONSTRAINT [DF_SysStartConsult] DEFAULT (sysutcdatetime()) FOR [SysStartTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysEndConsult]...';


GO
ALTER TABLE [dbo].[Consults]
    ADD CONSTRAINT [DF_SysEndConsult] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [SysEndTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysStartCustomerContacts]...';


GO
ALTER TABLE [dbo].[CustomerContacts]
    ADD CONSTRAINT [DF_SysStartCustomerContacts] DEFAULT (sysutcdatetime()) FOR [SysStartTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysEndCustomerContacts]...';


GO
ALTER TABLE [dbo].[CustomerContacts]
    ADD CONSTRAINT [DF_SysEndCustomerContacts] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [SysEndTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysStartCustomers]...';


GO
ALTER TABLE [dbo].[Customers]
    ADD CONSTRAINT [DF_SysStartCustomers] DEFAULT (sysutcdatetime()) FOR [SysStartTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysEndCustmoers]...';


GO
ALTER TABLE [dbo].[Customers]
    ADD CONSTRAINT [DF_SysEndCustmoers] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [SysEndTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysStartProjects]...';


GO
ALTER TABLE [dbo].[Projects]
    ADD CONSTRAINT [DF_SysStartProjects] DEFAULT (sysutcdatetime()) FOR [SysStartTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysEndProjects]...';


GO
ALTER TABLE [dbo].[Projects]
    ADD CONSTRAINT [DF_SysEndProjects] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [SysEndTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysStart]...';


GO
ALTER TABLE [dbo].[Teams]
    ADD CONSTRAINT [DF_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime];


GO
PRINT N'Creating Default Constraint [dbo].[DF_SysEnd]...';


GO
ALTER TABLE [dbo].[Teams]
    ADD CONSTRAINT [DF_SysEnd] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [SysEndTime];


GO
PRINT N'Creating Foreign Key [dbo].[FK_BlackList_Customers]...';


GO
ALTER TABLE [dbo].[BlackList] WITH NOCHECK
    ADD CONSTRAINT [FK_BlackList_Customers] FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customers] ([CustID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_BlackList_Projects]...';


GO
ALTER TABLE [dbo].[BlackList] WITH NOCHECK
    ADD CONSTRAINT [FK_BlackList_Projects] FOREIGN KEY ([ProjNum]) REFERENCES [dbo].[Projects] ([ProjNum]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ConsultEmpID]...';


GO
ALTER TABLE [dbo].[ConsultentsChildren] WITH NOCHECK
    ADD CONSTRAINT [FK_ConsultEmpID] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Consults_Genders]...';


GO
ALTER TABLE [dbo].[Consults] WITH NOCHECK
    ADD CONSTRAINT [FK_Consults_Genders] FOREIGN KEY ([Gender]) REFERENCES [dbo].[Genders] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Consults_MaritalStatus]...';


GO
ALTER TABLE [dbo].[Consults] WITH NOCHECK
    ADD CONSTRAINT [FK_Consults_MaritalStatus] FOREIGN KEY ([FamilyStatus]) REFERENCES [dbo].[MaritalStatus] ([ID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ConsultsMonthlySalary_Consults]...';


GO
ALTER TABLE [dbo].[ConsultsMonthlySalary] WITH NOCHECK
    ADD CONSTRAINT [FK_ConsultsMonthlySalary_Consults] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ConsultsMonthlySalary_WorkDays]...';


GO
ALTER TABLE [dbo].[ConsultsMonthlySalary] WITH NOCHECK
    ADD CONSTRAINT [FK_ConsultsMonthlySalary_WorkDays] FOREIGN KEY ([MonthId]) REFERENCES [dbo].[WorkDays] ([MonthID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ConsultsSalary_Consults]...';


GO
ALTER TABLE [dbo].[ConsultsSalary] WITH NOCHECK
    ADD CONSTRAINT [FK_ConsultsSalary_Consults] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ConsultsSalary_Positions]...';


GO
ALTER TABLE [dbo].[ConsultsSalary] WITH NOCHECK
    ADD CONSTRAINT [FK_ConsultsSalary_Positions] FOREIGN KEY ([Position]) REFERENCES [dbo].[Positions] ([ID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_CustomerContacts_Customers]...';


GO
ALTER TABLE [dbo].[CustomerContacts] WITH NOCHECK
    ADD CONSTRAINT [FK_CustomerContacts_Customers] FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customers] ([CustID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_CustomerContacts_Positions]...';


GO
ALTER TABLE [dbo].[CustomerContacts] WITH NOCHECK
    ADD CONSTRAINT [FK_CustomerContacts_Positions] FOREIGN KEY ([Position]) REFERENCES [dbo].[Positions] ([ID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Customers_CompanySize]...';


GO
ALTER TABLE [dbo].[Customers] WITH NOCHECK
    ADD CONSTRAINT [FK_Customers_CompanySize] FOREIGN KEY ([CompanySize]) REFERENCES [dbo].[CompanySize] ([ID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Customers_Teams]...';


GO
ALTER TABLE [dbo].[Customers] WITH NOCHECK
    ADD CONSTRAINT [FK_Customers_Teams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[Teams] ([TeamID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_EmployeeProjects_Consults]...';


GO
ALTER TABLE [dbo].[EmployeeProjects] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeProjects_Consults] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_EmployeeProjects_Projects]...';


GO
ALTER TABLE [dbo].[EmployeeProjects] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeProjects_Projects] FOREIGN KEY ([ProjNum]) REFERENCES [dbo].[Projects] ([ProjNum]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invoices_Consults]...';


GO
ALTER TABLE [dbo].[Invoices] WITH NOCHECK
    ADD CONSTRAINT [FK_Invoices_Consults] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invoices_Customers]...';


GO
ALTER TABLE [dbo].[Invoices] WITH NOCHECK
    ADD CONSTRAINT [FK_Invoices_Customers] FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customers] ([CustID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invoices_Offices]...';


GO
ALTER TABLE [dbo].[Invoices] WITH NOCHECK
    ADD CONSTRAINT [FK_Invoices_Offices] FOREIGN KEY ([OfficeID]) REFERENCES [dbo].[Offices] ([OfficeID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invoices_Projects]...';


GO
ALTER TABLE [dbo].[Invoices] WITH NOCHECK
    ADD CONSTRAINT [FK_Invoices_Projects] FOREIGN KEY ([ProjNum]) REFERENCES [dbo].[Projects] ([ProjNum]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invoices_WorkDays]...';


GO
ALTER TABLE [dbo].[Invoices] WITH NOCHECK
    ADD CONSTRAINT [FK_Invoices_WorkDays] FOREIGN KEY ([Month]) REFERENCES [dbo].[WorkDays] ([MonthID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ManagersConversations_Consults]...';


GO
ALTER TABLE [dbo].[ManagersConversations] WITH NOCHECK
    ADD CONSTRAINT [FK_ManagersConversations_Consults] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ManagersConversations_ConversationsResults]...';


GO
ALTER TABLE [dbo].[ManagersConversations] WITH NOCHECK
    ADD CONSTRAINT [FK_ManagersConversations_ConversationsResults] FOREIGN KEY ([MeetId]) REFERENCES [dbo].[ConversationsResults] ([ID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ManagersConversations_ConversationsType]...';


GO
ALTER TABLE [dbo].[ManagersConversations] WITH NOCHECK
    ADD CONSTRAINT [FK_ManagersConversations_ConversationsType] FOREIGN KEY ([CallID]) REFERENCES [dbo].[ConversationsType] ([ID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ManagersConversations_Projects]...';


GO
ALTER TABLE [dbo].[ManagersConversations] WITH NOCHECK
    ADD CONSTRAINT [FK_ManagersConversations_Projects] FOREIGN KEY ([ProjNum]) REFERENCES [dbo].[Projects] ([ProjNum]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Offices_Customers]...';


GO
ALTER TABLE [dbo].[Offices] WITH NOCHECK
    ADD CONSTRAINT [FK_Offices_Customers] FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customers] ([CustID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ProjectReports_Consults]...';


GO
ALTER TABLE [dbo].[ProjectReports] WITH NOCHECK
    ADD CONSTRAINT [FK_ProjectReports_Consults] FOREIGN KEY ([EmpID]) REFERENCES [dbo].[Consults] ([EmpID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ProjectReports_Customers]...';


GO
ALTER TABLE [dbo].[ProjectReports] WITH NOCHECK
    ADD CONSTRAINT [FK_ProjectReports_Customers] FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customers] ([CustID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ProjectReports_Holidays]...';


GO
ALTER TABLE [dbo].[ProjectReports] WITH NOCHECK
    ADD CONSTRAINT [FK_ProjectReports_Holidays] FOREIGN KEY ([StartTime]) REFERENCES [dbo].[Holidays] ([Date]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ProjectReports_Offices]...';


GO
ALTER TABLE [dbo].[ProjectReports] WITH NOCHECK
    ADD CONSTRAINT [FK_ProjectReports_Offices] FOREIGN KEY ([OfficeId]) REFERENCES [dbo].[Offices] ([OfficeID]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_ProjectReports_Projects]...';


GO
ALTER TABLE [dbo].[ProjectReports] WITH NOCHECK
    ADD CONSTRAINT [FK_ProjectReports_Projects] FOREIGN KEY ([ProjNum]) REFERENCES [dbo].[Projects] ([ProjNum]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[BlackList] WITH CHECK CHECK CONSTRAINT [FK_BlackList_Customers];

ALTER TABLE [dbo].[BlackList] WITH CHECK CHECK CONSTRAINT [FK_BlackList_Projects];

ALTER TABLE [dbo].[ConsultentsChildren] WITH CHECK CHECK CONSTRAINT [FK_ConsultEmpID];

ALTER TABLE [dbo].[Consults] WITH CHECK CHECK CONSTRAINT [FK_Consults_Genders];

ALTER TABLE [dbo].[Consults] WITH CHECK CHECK CONSTRAINT [FK_Consults_MaritalStatus];

ALTER TABLE [dbo].[ConsultsMonthlySalary] WITH CHECK CHECK CONSTRAINT [FK_ConsultsMonthlySalary_Consults];

ALTER TABLE [dbo].[ConsultsMonthlySalary] WITH CHECK CHECK CONSTRAINT [FK_ConsultsMonthlySalary_WorkDays];

ALTER TABLE [dbo].[ConsultsSalary] WITH CHECK CHECK CONSTRAINT [FK_ConsultsSalary_Consults];

ALTER TABLE [dbo].[ConsultsSalary] WITH CHECK CHECK CONSTRAINT [FK_ConsultsSalary_Positions];

ALTER TABLE [dbo].[CustomerContacts] WITH CHECK CHECK CONSTRAINT [FK_CustomerContacts_Customers];

ALTER TABLE [dbo].[CustomerContacts] WITH CHECK CHECK CONSTRAINT [FK_CustomerContacts_Positions];

ALTER TABLE [dbo].[Customers] WITH CHECK CHECK CONSTRAINT [FK_Customers_CompanySize];

ALTER TABLE [dbo].[Customers] WITH CHECK CHECK CONSTRAINT [FK_Customers_Teams];

ALTER TABLE [dbo].[EmployeeProjects] WITH CHECK CHECK CONSTRAINT [FK_EmployeeProjects_Consults];

ALTER TABLE [dbo].[EmployeeProjects] WITH CHECK CHECK CONSTRAINT [FK_EmployeeProjects_Projects];

ALTER TABLE [dbo].[Invoices] WITH CHECK CHECK CONSTRAINT [FK_Invoices_Consults];

ALTER TABLE [dbo].[Invoices] WITH CHECK CHECK CONSTRAINT [FK_Invoices_Customers];

ALTER TABLE [dbo].[Invoices] WITH CHECK CHECK CONSTRAINT [FK_Invoices_Offices];

ALTER TABLE [dbo].[Invoices] WITH CHECK CHECK CONSTRAINT [FK_Invoices_Projects];

ALTER TABLE [dbo].[Invoices] WITH CHECK CHECK CONSTRAINT [FK_Invoices_WorkDays];

ALTER TABLE [dbo].[ManagersConversations] WITH CHECK CHECK CONSTRAINT [FK_ManagersConversations_Consults];

ALTER TABLE [dbo].[ManagersConversations] WITH CHECK CHECK CONSTRAINT [FK_ManagersConversations_ConversationsResults];

ALTER TABLE [dbo].[ManagersConversations] WITH CHECK CHECK CONSTRAINT [FK_ManagersConversations_ConversationsType];

ALTER TABLE [dbo].[ManagersConversations] WITH CHECK CHECK CONSTRAINT [FK_ManagersConversations_Projects];

ALTER TABLE [dbo].[Offices] WITH CHECK CHECK CONSTRAINT [FK_Offices_Customers];

ALTER TABLE [dbo].[ProjectReports] WITH CHECK CHECK CONSTRAINT [FK_ProjectReports_Consults];

ALTER TABLE [dbo].[ProjectReports] WITH CHECK CHECK CONSTRAINT [FK_ProjectReports_Customers];

ALTER TABLE [dbo].[ProjectReports] WITH CHECK CHECK CONSTRAINT [FK_ProjectReports_Holidays];

ALTER TABLE [dbo].[ProjectReports] WITH CHECK CHECK CONSTRAINT [FK_ProjectReports_Offices];

ALTER TABLE [dbo].[ProjectReports] WITH CHECK CHECK CONSTRAINT [FK_ProjectReports_Projects];


GO
PRINT N'Update complete.';


GO
