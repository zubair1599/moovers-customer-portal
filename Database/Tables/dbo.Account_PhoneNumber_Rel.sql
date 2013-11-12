CREATE TABLE [dbo].[Account_PhoneNumber_Rel]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_PhoneNumber_Rel_RelationshipID] DEFAULT (newid()),
[AccountID] [uniqueidentifier] NOT NULL,
[PhoneNumberID] [uniqueidentifier] NOT NULL,
[Sort] [int] NOT NULL,
[Type] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_PhoneNumber_Rel] ADD CONSTRAINT [PK_Account_PhoneNumber_Rel] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountID] ON [dbo].[Account_PhoneNumber_Rel] ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Account-incPhone] ON [dbo].[Account_PhoneNumber_Rel] ([AccountID]) INCLUDE ([PhoneNumberID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PhoneIDAccountID] ON [dbo].[Account_PhoneNumber_Rel] ([AccountID], [PhoneNumberID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountSort] ON [dbo].[Account_PhoneNumber_Rel] ([AccountID], [Sort]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PhoneNumberID] ON [dbo].[Account_PhoneNumber_Rel] ([PhoneNumberID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_PhoneNumber_Rel] ADD CONSTRAINT [FK_Account_PhoneNumber_Rel_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Account_PhoneNumber_Rel] ADD CONSTRAINT [FK_Account_PhoneNumber_Rel_PhoneNumber] FOREIGN KEY ([PhoneNumberID]) REFERENCES [dbo].[PhoneNumber] ([PhoneNumberID])
GO
