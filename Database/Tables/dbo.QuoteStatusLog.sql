CREATE TABLE [dbo].[QuoteStatusLog]
(
[StatusID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_QuoteStatusLog_StatusID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[Status] [int] NULL,
[Date] [datetime] NOT NULL,
[Reason] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserID] [uniqueidentifier] NOT NULL,
[Message] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteStatusLog] ADD CONSTRAINT [PK_QuoteStatusLog] PRIMARY KEY CLUSTERED  ([StatusID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteStatusLog] ADD CONSTRAINT [FK_QuoteStatusLog_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
ALTER TABLE [dbo].[QuoteStatusLog] ADD CONSTRAINT [FK_QuoteStatusLog_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
