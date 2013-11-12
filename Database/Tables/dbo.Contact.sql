CREATE TABLE [dbo].[Contact]
(
[ContactID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_Contact_RelationshipID] DEFAULT (newid()),
[RoleName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountID1] [uniqueidentifier] NOT NULL,
[AccountID2] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [PK_Account_Contact] PRIMARY KEY CLUSTERED  ([ContactID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [FK_Contact_Account] FOREIGN KEY ([AccountID1]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [FK_Contact_Account1] FOREIGN KEY ([AccountID2]) REFERENCES [dbo].[Account] ([AccountID])
GO
