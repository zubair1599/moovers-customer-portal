CREATE TABLE [dbo].[InventoryItemCategory]
(
[CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InventoryItemCategory_CategoryID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sort] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItemCategory] ADD CONSTRAINT [PK_InventoryItemCategory] PRIMARY KEY CLUSTERED  ([CategoryID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Sort] ON [dbo].[InventoryItemCategory] ([Sort]) ON [PRIMARY]
GO
