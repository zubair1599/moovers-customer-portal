CREATE TABLE [dbo].[Account]
(
[AccountID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_AccountID] DEFAULT (newid()),
[Created] [datetime] NOT NULL,
[Lookup] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Account_IsArchived] DEFAULT ((0)),
[FranchiseID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[SetLookup] 
   ON  [dbo].[Account]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.Account(AccountID, Created, IsArchived, FranchiseID,Lookup)
	SELECT AccountID, Created, IsArchived, FranchiseID,
(SELECT 'A' + ISNULL(CAST( 
MAX( 
	CAST(
		SUBSTRING(Lookup, 2, LEN(Lookup)) AS INT
	)
) + 1 AS VARCHAR(10)), '000000') FROM dbo.Account)
	FROM inserted
END
GO
ALTER TABLE [dbo].[Account] ADD CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED  ([AccountID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD CONSTRAINT [UQ__Account__F091BCD87D0E9093] UNIQUE NONCLUSTERED  ([Lookup]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [franchiseid] ON [dbo].[Account] ([FranchiseID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [isarchived] ON [dbo].[Account] ([IsArchived]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD CONSTRAINT [FK_Account_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
