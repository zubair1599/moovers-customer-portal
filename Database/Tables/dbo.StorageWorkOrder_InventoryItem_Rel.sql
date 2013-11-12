CREATE TABLE [dbo].[StorageWorkOrder_InventoryItem_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageWorkOrder_InventoryItem_Rel_RelID] DEFAULT (newid()),
[StorageWorkOrderID] [uniqueidentifier] NOT NULL,
[InventoryItemID] [uniqueidentifier] NOT NULL,
[Count] [int] NOT NULL,
[IsOverstuffed] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_InventoryItem_Rel_IsOverstuffed] DEFAULT ((0)),
[OverstuffZoneID] [uniqueidentifier] NULL,
[OverstuffID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OverstuffRow] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OverstuffShelf] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OverstuffDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsRemoved] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_InventoryItem_Rel_IsRemoved] DEFAULT ((0)),
[DateRemoved] [datetime] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].SetOSID 
   ON  dbo.StorageWorkOrder_InventoryItem_Rel
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO [StorageWorkOrder_InventoryItem_Rel]([RelID]
      ,[StorageWorkOrderID]
      ,[InventoryItemID]
      ,[Count]
      ,[IsOverstuffed]
      ,[OverstuffZoneID]
      ,[OverstuffRow]
      ,[OverstuffShelf]
      ,[OverstuffDescription]
      ,[IsRemoved]
      ,[DateRemoved]
      ,[OverstuffID]
	)
	SELECT [RelID]
      ,[StorageWorkOrderID]
      ,[InventoryItemID]
      ,[Count]
      ,[IsOverstuffed]
      ,[OverstuffZoneID]
      ,[OverstuffRow]
      ,[OverstuffShelf]
      ,[OverstuffDescription]
      ,[IsRemoved]
      ,[DateRemoved]
	  ,(SELECT ISNULL(CAST(MAX(CAST(OverstuffID AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.[StorageWorkOrder_InventoryItem_Rel])
	FROM inserted
END
GO
ALTER TABLE [dbo].[StorageWorkOrder_InventoryItem_Rel] ADD CONSTRAINT [PK_StorageWorkOrder_InventoryItem_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IsOverstuffedIsRemoved] ON [dbo].[StorageWorkOrder_InventoryItem_Rel] ([IsOverstuffed], [IsRemoved]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [OSID] ON [dbo].[StorageWorkOrder_InventoryItem_Rel] ([OverstuffID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WorkOrder] ON [dbo].[StorageWorkOrder_InventoryItem_Rel] ([StorageWorkOrderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageWorkOrder_InventoryItem_Rel] ADD CONSTRAINT [FK_StorageWorkOrder_InventoryItem_Rel_InventoryItem] FOREIGN KEY ([InventoryItemID]) REFERENCES [dbo].[InventoryItem] ([ItemID])
GO
ALTER TABLE [dbo].[StorageWorkOrder_InventoryItem_Rel] ADD CONSTRAINT [FK_StorageWorkOrder_InventoryItem_Rel_StorageZone] FOREIGN KEY ([OverstuffZoneID]) REFERENCES [dbo].[StorageZone] ([ZoneID])
GO
ALTER TABLE [dbo].[StorageWorkOrder_InventoryItem_Rel] ADD CONSTRAINT [FK_StorageWorkOrder_InventoryItem_Rel_StorageWorkOrder] FOREIGN KEY ([StorageWorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
