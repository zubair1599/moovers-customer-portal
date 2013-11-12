CREATE TABLE [dbo].[QuoteAccessLog]
(
[AccessLogID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_QuoteAccessLog_AccessLogID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[Date] [datetime] NOT NULL,
[UserID] [uniqueidentifier] NOT NULL,
[Action] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteAccessLog] ADD CONSTRAINT [PK_QuoteAccessLog] PRIMARY KEY CLUSTERED  ([AccessLogID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Date] ON [dbo].[QuoteAccessLog] ([Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[QuoteAccessLog] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteIDDate] ON [dbo].[QuoteAccessLog] ([QuoteID], [Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UserIDDate] ON [dbo].[QuoteAccessLog] ([UserID], [Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UserIDQuoteID] ON [dbo].[QuoteAccessLog] ([UserID], [QuoteID]) INCLUDE ([Date]) ON [PRIMARY]
GO
CREATE STATISTICS [_dta_stat_1163151189_2_4] ON [dbo].[QuoteAccessLog] ([QuoteID], [UserID])
GO
ALTER TABLE [dbo].[QuoteAccessLog] ADD CONSTRAINT [FK_QuoteAccessLog_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
ALTER TABLE [dbo].[QuoteAccessLog] ADD CONSTRAINT [FK_QuoteAccessLog_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
