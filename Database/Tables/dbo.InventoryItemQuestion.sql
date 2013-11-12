CREATE TABLE [dbo].[InventoryItemQuestion]
(
[QuestionID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InventoryItemQuestion_QuestionID] DEFAULT (newid()),
[QuestionText] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InventoryItemID] [uniqueidentifier] NOT NULL,
[Weight] [decimal] (18, 2) NULL,
[CubicFeet] [decimal] (18, 2) NULL,
[Time] [decimal] (18, 2) NULL,
[ShortName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sort] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItemQuestion] ADD CONSTRAINT [PK_InventoryItem_Question] PRIMARY KEY CLUSTERED  ([QuestionID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [InventoryItem] ON [dbo].[InventoryItemQuestion] ([InventoryItemID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItemQuestion] ADD CONSTRAINT [FK_InventoryItemQuestion_InventoryItem] FOREIGN KEY ([InventoryItemID]) REFERENCES [dbo].[InventoryItem] ([ItemID])
GO
