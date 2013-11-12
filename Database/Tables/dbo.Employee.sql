CREATE TABLE [dbo].[Employee]
(
[EmployeeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Employee_EmployeeID] DEFAULT (newid()),
[NameFirst] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NameLast] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FranchiseID] [uniqueidentifier] NOT NULL,
[PrimaryPhoneString] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SecondaryPhoneString] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailString] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryPhoneExtension] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SecondaryPhoneExtensionString] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Wage] [decimal] (18, 2) NULL,
[IsDriver] [bit] NOT NULL CONSTRAINT [DF_Employee_IsDriver] DEFAULT ((0)),
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Employee_IsArchived] DEFAULT ((0)),
[PreviousMoveCount] [int] NOT NULL CONSTRAINT [DF_Employee_PreviousMoveCount] DEFAULT ((0)),
[AddressID] [uniqueidentifier] NULL,
[HireDate] [datetime] NULL,
[TerminationDate] [datetime] NULL,
[BirthDate] [datetime] NULL,
[EncryptedSSN] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DriverLicense] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GenderID] [int] NULL,
[PrimaryPhoneAcceptText] [bit] NOT NULL CONSTRAINT [DF_Employee_PrimaryPhoneAcceptText] DEFAULT ((0)),
[SecondaryPhoneAcceptText] [bit] NOT NULL CONSTRAINT [DF_Employee_SecondaryPhoneAcceptText] DEFAULT ((0)),
[PayTypeID] [int] NULL,
[Allowance] [int] NULL,
[FilingStatusID] [int] NULL,
[PositionTypeID] [int] NOT NULL CONSTRAINT [DF_Employee_PositionTypeID] DEFAULT ((1)),
[DriverLicenseExpirationMonth] [int] NULL,
[DriverLicenseExpirationYear] [int] NULL,
[TerminationReason] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerminationType] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[SetEmployeeLookup] 
   ON  [dbo].[Employee]
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.Employee([EmployeeID]
      ,[NameFirst]
      ,[NameLast]
      ,[FranchiseID]
      ,[PrimaryPhoneString]
      ,[SecondaryPhoneString]
      ,[EmailString]
      ,[PrimaryPhoneExtension]
      ,[SecondaryPhoneExtensionString]
      ,[Wage]
      ,[IsDriver]
      ,[IsArchived]
      ,[PreviousMoveCount]
      ,[AddressID]
      ,[HireDate]
      ,[TerminationDate]
      ,[BirthDate]
      ,[EncryptedSSN]
      ,[DriverLicense]
      ,[GenderID]
      ,[PrimaryPhoneAcceptText]
      ,[SecondaryPhoneAcceptText]
      ,[PayTypeID]
      ,[Allowance]
      ,[FilingStatusID]
      ,[PositionTypeID]
      ,[DriverLicenseExpirationMonth]
      ,[DriverLicenseExpirationYear]
      ,[Lookup]
	)
	SELECT [EmployeeID]
      ,[NameFirst]
      ,[NameLast]
      ,[FranchiseID]
      ,[PrimaryPhoneString]
      ,[SecondaryPhoneString]
      ,[EmailString]
      ,[PrimaryPhoneExtension]
      ,[SecondaryPhoneExtensionString]
      ,[Wage]
      ,[IsDriver]
      ,[IsArchived]
      ,[PreviousMoveCount]
      ,[AddressID]
      ,[HireDate]
      ,[TerminationDate]
      ,[BirthDate]
      ,[EncryptedSSN]
      ,[DriverLicense]
      ,[GenderID]
      ,[PrimaryPhoneAcceptText]
      ,[SecondaryPhoneAcceptText]
      ,[PayTypeID]
      ,[Allowance]
      ,[FilingStatusID]
      ,[PositionTypeID]
      ,[DriverLicenseExpirationMonth]
      ,[DriverLicenseExpirationYear]
	  ,(SELECT ISNULL(CAST(MAX(CAST(Lookup AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.Employee)
	FROM inserted
END
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED  ([EmployeeID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Lookup] ON [dbo].[Employee] ([Lookup]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
