CREATE TABLE [dbo].[Account_Address_Rel]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_Address_Rel_RelationshipID] DEFAULT (newid()),
[AccountID] [uniqueidentifier] NOT NULL,
[AddressID] [uniqueidentifier] NOT NULL,
[Sort] [int] NOT NULL,
[Type] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_Address_Rel] ADD CONSTRAINT [PK_Account_Address_Rel] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Account] ON [dbo].[Account_Address_Rel] ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Account-incRelAddressType] ON [dbo].[Account_Address_Rel] ([AccountID]) INCLUDE ([AddressID], [RelationshipID], [Type]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountIDAddressID] ON [dbo].[Account_Address_Rel] ([AccountID], [AddressID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountSort] ON [dbo].[Account_Address_Rel] ([AccountID], [Sort]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountID_Type] ON [dbo].[Account_Address_Rel] ([AccountID], [Type]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AddressID] ON [dbo].[Account_Address_Rel] ([AddressID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RelationshipAddressType] ON [dbo].[Account_Address_Rel] ([RelationshipID], [AddressID], [Type]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_Address_Rel] ADD CONSTRAINT [FK_Account_Address_Rel_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Account_Address_Rel] ADD CONSTRAINT [FK_Account_Address_Rel_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID])
GO
