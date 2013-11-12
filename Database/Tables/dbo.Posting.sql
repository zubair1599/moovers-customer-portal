CREATE TABLE [dbo].[Posting]
(
[PostingID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Posting_PostingID] DEFAULT (newid()),
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL,
[ScheduleID] [uniqueidentifier] NOT NULL,
[IsComplete] [bit] NOT NULL,
[DateCompleted] [datetime] NULL,
[CompletedBy] [uniqueidentifier] NULL,
[PostingDate] [datetime] NULL,
[PostingHours] [decimal] (18, 2) NULL,
[PostingPrice] [decimal] (18, 2) NULL,
[PostingRate] [decimal] (18, 2) NULL,
[PostingFirstHourRate] [decimal] (18, 2) NULL,
[DriveHours] [decimal] (18, 2) NULL,
[CrewCount] [int] NULL
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
CREATE TRIGGER [dbo].SetPostingLookup 
   ON  [dbo].Posting
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.Posting(
[PostingID]
      ,[QuoteID]
      ,[ScheduleID]
      ,[IsComplete]
      ,[Lookup]      
	)
	SELECT 
	[PostingID]
      ,[QuoteID]
      ,[ScheduleID]
      ,[IsComplete]
	  ,(SELECT ISNULL(CAST(MAX(CAST(Lookup AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.Posting)
	FROM inserted
END
GO
ALTER TABLE [dbo].[Posting] ADD CONSTRAINT [PK_Posting] PRIMARY KEY CLUSTERED  ([PostingID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Date] ON [dbo].[Posting] ([DateCompleted]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Lookup] ON [dbo].[Posting] ([Lookup]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PostQuoteSchedule] ON [dbo].[Posting] ([PostingID], [QuoteID], [ScheduleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PostingIDScheduleID] ON [dbo].[Posting] ([PostingID], [ScheduleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_8_795149878__K1_K4_K5] ON [dbo].[Posting] ([PostingID], [ScheduleID], [IsComplete]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[Posting] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteIDIsCompletePostingIDScheduleID] ON [dbo].[Posting] ([QuoteID], [IsComplete], [PostingID], [ScheduleID]) INCLUDE ([CompletedBy], [CrewCount], [DateCompleted], [DriveHours], [Lookup], [PostingDate], [PostingFirstHourRate], [PostingHours], [PostingPrice], [PostingRate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_8_795149878__K3_K5_K4] ON [dbo].[Posting] ([QuoteID], [IsComplete], [ScheduleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ScheduleID] ON [dbo].[Posting] ([ScheduleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_8_795149878__K4_K5_K1] ON [dbo].[Posting] ([ScheduleID], [IsComplete], [PostingID]) ON [PRIMARY]
GO
CREATE STATISTICS [_dta_stat_795149878_5_4_3] ON [dbo].[Posting] ([IsComplete], [ScheduleID], [QuoteID])
GO
CREATE STATISTICS [_dta_stat_795149878_1_5_4_3] ON [dbo].[Posting] ([PostingID], [IsComplete], [ScheduleID], [QuoteID])
GO
CREATE STATISTICS [_dta_stat_795149878_3_1_5] ON [dbo].[Posting] ([QuoteID], [PostingID], [IsComplete])
GO
CREATE STATISTICS [_dta_stat_795149878_4_3] ON [dbo].[Posting] ([ScheduleID], [QuoteID])
GO
ALTER TABLE [dbo].[Posting] ADD CONSTRAINT [FK_Posting_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
ALTER TABLE [dbo].[Posting] ADD CONSTRAINT [FK_Posting_Schedule] FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID])
GO
