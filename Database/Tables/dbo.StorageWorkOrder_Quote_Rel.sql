CREATE TABLE [dbo].[StorageWorkOrder_Quote_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageWorkOrder_Quote_Rel_RelID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[StorageWorkOrderID] [uniqueidentifier] NOT NULL,
[StorageQuoteTypeID] [int] NOT NULL CONSTRAINT [DF_StorageWorkOrder_Quote_Rel_StorageQuoteTypeID] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageWorkOrder_Quote_Rel] ADD CONSTRAINT [PK_StorageWorkOrder_Quote_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Quote] ON [dbo].[StorageWorkOrder_Quote_Rel] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WorkOrder] ON [dbo].[StorageWorkOrder_Quote_Rel] ([StorageWorkOrderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageWorkOrder_Quote_Rel] ADD CONSTRAINT [FK_StorageWorkOrder_Quote_Rel_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
ALTER TABLE [dbo].[StorageWorkOrder_Quote_Rel] ADD CONSTRAINT [FK_StorageWorkOrder_Quote_Rel_StorageWorkOrder] FOREIGN KEY ([StorageWorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
