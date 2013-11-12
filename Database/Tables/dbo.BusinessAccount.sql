CREATE TABLE [dbo].[BusinessAccount]
(
[AccountID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BusinessAccount_AccountID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BusinessType] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BusinessAccount] ADD CONSTRAINT [PK_BusinessAccount] PRIMARY KEY CLUSTERED  ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [name'] ON [dbo].[BusinessAccount] ([Name]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BusinessAccount] ADD CONSTRAINT [FK_BusinessAccount_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
