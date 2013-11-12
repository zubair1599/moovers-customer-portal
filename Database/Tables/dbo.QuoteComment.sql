CREATE TABLE [dbo].[QuoteComment]
(
[QuoteCommentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_QuoteComment_QuoteCommentID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[UserID] [uniqueidentifier] NOT NULL,
[Date] [datetime] NOT NULL,
[Text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteComment] ADD CONSTRAINT [PK_QuoteComment] PRIMARY KEY CLUSTERED  ([QuoteCommentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [quoteid] ON [dbo].[QuoteComment] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteComment] ADD CONSTRAINT [FK_QuoteComment_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
ALTER TABLE [dbo].[QuoteComment] ADD CONSTRAINT [FK_QuoteComment_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
