CREATE TABLE [dbo].[EmailLog]
(
[EmailLogID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailLog_EmailLogID] DEFAULT (newid()),
[MailTo] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MailFrom] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MailCC] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MailBCC] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Subject] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Message] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateSent] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailLog] ADD CONSTRAINT [PK_EmailLog] PRIMARY KEY CLUSTERED  ([EmailLogID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [date] ON [dbo].[EmailLog] ([DateSent]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [from] ON [dbo].[EmailLog] ([MailFrom]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [to] ON [dbo].[EmailLog] ([MailTo]) ON [PRIMARY]
GO
