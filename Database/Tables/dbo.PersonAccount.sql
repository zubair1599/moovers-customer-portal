CREATE TABLE [dbo].[PersonAccount]
(
[AccountID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PersonalAccount_AccountID] DEFAULT (newid()),
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonAccount] ADD CONSTRAINT [PK_PersonAccount] PRIMARY KEY CLUSTERED  ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Firstname] ON [dbo].[PersonAccount] ([FirstName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [lastname] ON [dbo].[PersonAccount] ([LastName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonAccount] ADD CONSTRAINT [FK_PersonAccount_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
CREATE FULLTEXT INDEX ON [dbo].[PersonAccount] KEY INDEX [PK_PersonAccount] ON [idx_Name]
GO
ALTER FULLTEXT INDEX ON [dbo].[PersonAccount] ADD ([FirstName] LANGUAGE 1033)
GO
ALTER FULLTEXT INDEX ON [dbo].[PersonAccount] ADD ([LastName] LANGUAGE 1033)
GO
