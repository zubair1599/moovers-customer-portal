CREATE TABLE [dbo].[Franchise_aspnetUser]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aspnetUser_Franchise_RelationshipID] DEFAULT (newid()),
[UserID] [uniqueidentifier] NOT NULL,
[FranchiseID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Franchise_aspnetUser] ADD CONSTRAINT [PK_Franchise_aspnetUser] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UserID] ON [dbo].[Franchise_aspnetUser] ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Franchise_aspnetUser] ADD CONSTRAINT [FK_Franchise_aspnetUser_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
ALTER TABLE [dbo].[Franchise_aspnetUser] ADD CONSTRAINT [FK_Franchise_aspnetUser_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
