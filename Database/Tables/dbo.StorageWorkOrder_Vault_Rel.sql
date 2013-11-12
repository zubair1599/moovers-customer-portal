CREATE TABLE [dbo].[StorageWorkOrder_Vault_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageWorkOrder_Vault_Rel_RelID] DEFAULT (newid()),
[StorageVaultID] [uniqueidentifier] NOT NULL,
[StorageWorkOrderID] [uniqueidentifier] NOT NULL,
[IsRemoved] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_Vault_Rel_IsRemoved] DEFAULT ((0)),
[DateRemoved] [datetime] NULL,
[Row] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Shelf] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ZoneID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageWorkOrder_Vault_Rel] ADD CONSTRAINT [PK_Storage_WorkOrderVault_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WorkOrder] ON [dbo].[StorageWorkOrder_Vault_Rel] ([StorageWorkOrderID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Zone] ON [dbo].[StorageWorkOrder_Vault_Rel] ([ZoneID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageWorkOrder_Vault_Rel] ADD CONSTRAINT [FK_Storage_WorkOrderVault_Rel_StorageVault] FOREIGN KEY ([StorageVaultID]) REFERENCES [dbo].[StorageVault] ([StorageVaultID])
GO
ALTER TABLE [dbo].[StorageWorkOrder_Vault_Rel] ADD CONSTRAINT [FK_Storage_WorkOrderVault_Rel_StorageWorkOrder] FOREIGN KEY ([StorageWorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
ALTER TABLE [dbo].[StorageWorkOrder_Vault_Rel] ADD CONSTRAINT [FK_StorageWorkOrder_Vault_Rel_StorageZone] FOREIGN KEY ([ZoneID]) REFERENCES [dbo].[StorageZone] ([ZoneID])
GO
