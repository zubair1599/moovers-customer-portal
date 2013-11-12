CREATE TABLE [dbo].[FrontPageMessage]
(
[MessageID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_FrontPageMessage_MessageID] DEFAULT (newid()),
[UserID] [uniqueidentifier] NOT NULL,
[Date] [datetime] NOT NULL,
[Message] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[FrontPageMessage] ADD CONSTRAINT [PK_FrontPageMessage] PRIMARY KEY CLUSTERED  ([MessageID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Date] ON [dbo].[FrontPageMessage] ([Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UserID] ON [dbo].[FrontPageMessage] ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FrontPageMessage] ADD CONSTRAINT [FK_FrontPageMessage_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
