CREATE TABLE [dbo].[EmailLog_File_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailLog_File_Rel_RelID] DEFAULT (newid()),
[FileID] [uniqueidentifier] NOT NULL,
[EmailLogID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailLog_File_Rel] ADD CONSTRAINT [PK_EmailLog_File_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EmailLog] ON [dbo].[EmailLog_File_Rel] ([EmailLogID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [File] ON [dbo].[EmailLog_File_Rel] ([FileID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailLog_File_Rel] ADD CONSTRAINT [FK_EmailLog_File_Rel_EmailLog] FOREIGN KEY ([EmailLogID]) REFERENCES [dbo].[EmailLog] ([EmailLogID])
GO
ALTER TABLE [dbo].[EmailLog_File_Rel] ADD CONSTRAINT [FK_EmailLog_File_Rel_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
