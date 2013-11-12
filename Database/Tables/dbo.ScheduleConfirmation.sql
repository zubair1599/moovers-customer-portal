CREATE TABLE [dbo].[ScheduleConfirmation]
(
[ConfirmationID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ScheduleConfirmation_ConfirmationID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[Key] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScheduleConfirmation] ADD CONSTRAINT [PK_ScheduleConfirmation] PRIMARY KEY CLUSTERED  ([ConfirmationID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[ScheduleConfirmation] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScheduleConfirmation] ADD CONSTRAINT [FK_ScheduleConfirmation_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
