CREATE TABLE [dbo].[Quote_File_Rel]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_File_Rel_RelationshipID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[FileID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_File_Rel] ADD CONSTRAINT [PK_Quote_File_Rel] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [FileID] ON [dbo].[Quote_File_Rel] ([FileID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[Quote_File_Rel] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_File_Rel] ADD CONSTRAINT [FK_Quote_File_Rel_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[Quote_File_Rel] ADD CONSTRAINT [FK_Quote_File_Rel_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
