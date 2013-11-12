CREATE TABLE [dbo].[Room_InventoryItem_Option]
(
[AdditionalInfoID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Room_InventoryItem_Option_AdditionalInfoID] DEFAULT (newid()),
[QuestionID] [uniqueidentifier] NOT NULL,
[RelationshipID] [uniqueidentifier] NOT NULL,
[Option] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room_InventoryItem_Option] ADD CONSTRAINT [PK_Room_InventoryItem_Option] PRIMARY KEY CLUSTERED  ([AdditionalInfoID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuestionID] ON [dbo].[Room_InventoryItem_Option] ([QuestionID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RelationshipID] ON [dbo].[Room_InventoryItem_Option] ([RelationshipID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room_InventoryItem_Option] ADD CONSTRAINT [FK_Room_InventoryItem_Option_InventoryItemQuestionOption] FOREIGN KEY ([Option]) REFERENCES [dbo].[InventoryItemQuestionOption] ([OptionID])
GO
ALTER TABLE [dbo].[Room_InventoryItem_Option] ADD CONSTRAINT [FK_Room_InventoryItem_Option_InventoryItemQuestion] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[InventoryItemQuestion] ([QuestionID])
GO
ALTER TABLE [dbo].[Room_InventoryItem_Option] ADD CONSTRAINT [FK_Room_InventoryItem_Option_Room_InventoryItem] FOREIGN KEY ([RelationshipID]) REFERENCES [dbo].[Room_InventoryItem] ([RelationshipID]) ON DELETE CASCADE
GO
