CREATE TABLE [dbo].[Storage_File_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Storage_File_Rel_RelID] DEFAULT (newid()),
[FileID] [uniqueidentifier] NOT NULL,
[WorkOrderID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Storage_File_Rel] ADD CONSTRAINT [PK_Storage_File_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Fileid] ON [dbo].[Storage_File_Rel] ([FileID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [workorderi] ON [dbo].[Storage_File_Rel] ([WorkOrderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Storage_File_Rel] ADD CONSTRAINT [FK_Storage_File_Rel_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[Storage_File_Rel] ADD CONSTRAINT [FK_Storage_File_Rel_StorageWorkOrder] FOREIGN KEY ([WorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
