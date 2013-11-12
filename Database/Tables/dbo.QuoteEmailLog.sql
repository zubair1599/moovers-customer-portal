CREATE TABLE [dbo].[QuoteEmailLog]
(
[EmailLogID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_EmailLog_EmailLogID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteEmailLog] ADD CONSTRAINT [PK_Quote_EmailLog] PRIMARY KEY CLUSTERED  ([EmailLogID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[QuoteEmailLog] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteEmailLog] ADD CONSTRAINT [FK_QuoteEmailLog_EmailLog] FOREIGN KEY ([EmailLogID]) REFERENCES [dbo].[EmailLog] ([EmailLogID])
GO
ALTER TABLE [dbo].[QuoteEmailLog] ADD CONSTRAINT [FK_Quote_EmailLog_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
