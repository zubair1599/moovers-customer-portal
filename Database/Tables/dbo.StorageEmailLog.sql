CREATE TABLE [dbo].[StorageEmailLog]
(
[EmailLogID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageEmailLog_EmailLogID] DEFAULT (newid()),
[StorageID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageEmailLog] ADD CONSTRAINT [PK_StorageEmailLog] PRIMARY KEY CLUSTERED  ([EmailLogID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [storageid] ON [dbo].[StorageEmailLog] ([StorageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageEmailLog] ADD CONSTRAINT [FK_StorageEmailLog_EmailLog] FOREIGN KEY ([EmailLogID]) REFERENCES [dbo].[EmailLog] ([EmailLogID])
GO
ALTER TABLE [dbo].[StorageEmailLog] ADD CONSTRAINT [FK_StorageEmailLog_StorageWorkOrder] FOREIGN KEY ([StorageID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
