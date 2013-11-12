CREATE TABLE [dbo].[FranchiseTerritory]
(
[TerritoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_FranchiseTerritory_TerritoryID] DEFAULT (newid()),
[FranchiseID] [uniqueidentifier] NOT NULL,
[ZipCode] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FranchiseTerritory] ADD CONSTRAINT [PK_FranchiseTerritory] PRIMARY KEY CLUSTERED  ([TerritoryID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [FranchiseID] ON [dbo].[FranchiseTerritory] ([FranchiseID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Zip] ON [dbo].[FranchiseTerritory] ([ZipCode]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FranchiseTerritory] ADD CONSTRAINT [FK_FranchiseTerritory_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
