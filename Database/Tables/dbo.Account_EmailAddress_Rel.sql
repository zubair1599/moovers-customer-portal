CREATE TABLE [dbo].[Account_EmailAddress_Rel]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_EmailAddress_Rel_RelationshipID] DEFAULT (newid()),
[EmailID] [uniqueidentifier] NOT NULL,
[AccountID] [uniqueidentifier] NOT NULL,
[Type] [int] NOT NULL,
[Sort] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_EmailAddress_Rel] ADD CONSTRAINT [PK_Account_EmailAddress_Rel] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountID] ON [dbo].[Account_EmailAddress_Rel] ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountEmail] ON [dbo].[Account_EmailAddress_Rel] ([AccountID], [EmailID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EmailID] ON [dbo].[Account_EmailAddress_Rel] ([EmailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_EmailAddress_Rel] ADD CONSTRAINT [FK_Account_EmailAddress_Rel_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Account_EmailAddress_Rel] ADD CONSTRAINT [FK_Account_EmailAddress_Rel_EmailAddress] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[EmailAddress] ([EmailAddressID])
GO
