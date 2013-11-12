CREATE TABLE [dbo].[EmailUnsubscribe]
(
[UnsubscribeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailUnsubscribe_UnsubscribeID] DEFAULT (newid()),
[Email] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateUnsubscribed] [datetime] NOT NULL,
[UnsubscribeIP] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailUnsubscribe] ADD CONSTRAINT [PK_EmailUnsubscribe] PRIMARY KEY CLUSTERED  ([UnsubscribeID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [email] ON [dbo].[EmailUnsubscribe] ([Email]) ON [PRIMARY]
GO
