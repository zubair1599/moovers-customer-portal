CREATE TABLE [dbo].[Case]
(
[CaseID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Case_CaseID] DEFAULT (newid()),
[Status] [int] NOT NULL,
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Coverage] [int] NULL,
[DaysOpen] [int] NULL,
[Priority] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Updated] [datetime] NOT NULL,
[Created] [datetime] NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL,
[Remarks] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaseOpenDate] [datetime] NULL,
[CaseCloseDate] [datetime] NULL,
[CaseReOpenDate] [datetime] NULL,
[CaseSubmitStatus] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
Create TRIGGER [dbo].[SetCaseLookup] 
   ON  [dbo].[Case]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.[Case](CaseID, [Status], Coverage, DaysOpen, Priority, Updated , Created, QuoteID,Remarks, CaseOpenDate, CaseCloseDate , CaseReOpenDate, Lookup)
	SELECT CaseID, [Status], Coverage, DaysOpen, Priority, Updated , Created, QuoteID,Remarks, CaseOpenDate, CaseCloseDate , CaseReOpenDate,
(SELECT 'A' + ISNULL(CAST( 
MAX( 
	CAST(
		SUBSTRING(Lookup, 2, LEN(Lookup)) AS INT
	)
) + 1 AS VARCHAR(10)), '000000') FROM dbo.[Case])
	FROM inserted
END
GO
ALTER TABLE [dbo].[Case] ADD CONSTRAINT [PK_Case] PRIMARY KEY CLUSTERED  ([CaseID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Case] ADD CONSTRAINT [FK_Case_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
