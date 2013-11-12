CREATE TABLE [dbo].[InventoryItem_Box_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InventoryItem_Box_Rel_RelID] DEFAULT (newid()),
[BoxTypeID] [uniqueidentifier] NOT NULL,
[InventoryItemID] [uniqueidentifier] NOT NULL,
[Count] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItem_Box_Rel] ADD CONSTRAINT [PK_InventoryItem_Box_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItem_Box_Rel] ADD CONSTRAINT [FK_InventoryItem_Box_Rel_Box] FOREIGN KEY ([BoxTypeID]) REFERENCES [dbo].[Box] ([BoxTypeID])
GO
ALTER TABLE [dbo].[InventoryItem_Box_Rel] ADD CONSTRAINT [FK_InventoryItem_Box_Rel_InventoryItem] FOREIGN KEY ([InventoryItemID]) REFERENCES [dbo].[InventoryItem] ([ItemID])
GO
