CREATE TABLE [dbo].[StorageStatement]
(
[StatementID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageStatement_StatementID] DEFAULT (newid()),
[WorkOrderID] [uniqueidentifier] NOT NULL,
[FileID] [uniqueidentifier] NOT NULL,
[Date] [datetime] NOT NULL,
[PrintedBy] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageStatement] ADD CONSTRAINT [PK_StorageStatement] PRIMARY KEY CLUSTERED  ([StatementID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageStatement] ADD CONSTRAINT [FK_StorageStatement_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[StorageStatement] ADD CONSTRAINT [FK_StorageStatement_aspnet_Users] FOREIGN KEY ([PrintedBy]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[StorageStatement] ADD CONSTRAINT [FK_StorageStatement_StorageWorkOrder] FOREIGN KEY ([WorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
