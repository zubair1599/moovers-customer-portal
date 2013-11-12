CREATE TABLE [dbo].[RawInventoryItem]
(
[RawInventoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_RawInventoryItem_RawInventoryID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CategoryID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawInventoryItem] ADD CONSTRAINT [PK_RawInventoryItem] PRIMARY KEY CLUSTERED  ([RawInventoryID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawInventoryItem] ADD CONSTRAINT [FK_RawInventoryItem_RawInventoryCategory] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[RawInventoryCategory] ([CategoryID])
GO
