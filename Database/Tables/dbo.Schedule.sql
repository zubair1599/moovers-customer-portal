CREATE TABLE [dbo].[Schedule]
(
[ScheduleID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Schedule_ScheduleID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[Date] [datetime] NOT NULL,
[Movers] [int] NOT NULL,
[StartTime] [int] NOT NULL,
[EndTime] [int] NOT NULL,
[Note] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Minutes] [int] NOT NULL,
[IsCancelled] [bit] NOT NULL,
[DateCancelled] [datetime] NULL,
[CancelledBy] [uniqueidentifier] NULL,
[IsConfirmed] [bit] NOT NULL CONSTRAINT [DF_Schedule_IsConfirmed] DEFAULT ((0)),
[DateConfirmed] [datetime] NULL,
[ConfirmedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ConfirmedIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ConfirmedUserAgent] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ConfirmEmailSent] [bit] NOT NULL CONSTRAINT [DF_Schedule_ConfirmEmailSent] DEFAULT ((0)),
[ConfirmEmailDate] [datetime] NULL,
[DateCreated] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Schedule] ADD CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED  ([ScheduleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Date] ON [dbo].[Schedule] ([Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DateIsCancelled] ON [dbo].[Schedule] ([Date], [IsCancelled]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Quote] ON [dbo].[Schedule] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteIsCancelled] ON [dbo].[Schedule] ([QuoteID], [IsCancelled]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Schedule_8_64719283__K2_K1_K3_K9] ON [dbo].[Schedule] ([QuoteID], [ScheduleID], [Date], [IsCancelled]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [schedulequotedate] ON [dbo].[Schedule] ([ScheduleID], [QuoteID], [Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Schedule_8_64719283__K1_K2_K9_K3] ON [dbo].[Schedule] ([ScheduleID], [QuoteID], [IsCancelled], [Date]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
