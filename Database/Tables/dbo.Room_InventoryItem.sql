CREATE TABLE [dbo].[Room_InventoryItem]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Room_InventoryItem_RelationshipID] DEFAULT (newid()),
[RoomID] [uniqueidentifier] NOT NULL,
[InventoryItemID] [uniqueidentifier] NOT NULL,
[Count] [int] NOT NULL CONSTRAINT [DF_Room_InventoryItem_Count] DEFAULT ((1)),
[StorageCount] [int] NOT NULL CONSTRAINT [DF_Room_InventoryItem_StorageCount] DEFAULT ((0)),
[Sort] [int] NOT NULL,
[AddedAfter] [bit] NOT NULL CONSTRAINT [DF_Room_InventoryItem_AddedAfter] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room_InventoryItem] ADD CONSTRAINT [PK_Room_InventoryItem] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [InventoryItem] ON [dbo].[Room_InventoryItem] ([InventoryItemID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [InventoryItemID] ON [dbo].[Room_InventoryItem] ([InventoryItemID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RoomID] ON [dbo].[Room_InventoryItem] ([RoomID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RoomCountStorage] ON [dbo].[Room_InventoryItem] ([RoomID], [Count], [StorageCount]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room_InventoryItem] ADD CONSTRAINT [FK_Room_InventoryItem_InventoryItem] FOREIGN KEY ([InventoryItemID]) REFERENCES [dbo].[InventoryItem] ([ItemID])
GO
ALTER TABLE [dbo].[Room_InventoryItem] ADD CONSTRAINT [FK_Room_InventoryItem_Room] FOREIGN KEY ([RoomID]) REFERENCES [dbo].[Room] ([RoomID])
GO
