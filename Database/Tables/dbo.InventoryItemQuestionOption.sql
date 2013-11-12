CREATE TABLE [dbo].[InventoryItemQuestionOption]
(
[OptionID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InventoryItemQuestionOption_OptionID] DEFAULT (newid()),
[QuestionID] [uniqueidentifier] NOT NULL,
[Option] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Weight] [decimal] (18, 2) NULL,
[CubicFeet] [decimal] (18, 2) NULL,
[Time] [decimal] (18, 2) NULL,
[Selected] [bit] NOT NULL CONSTRAINT [DF_InventoryItemQuestionOption_Selected] DEFAULT ((0)),
[Sort] [int] NOT NULL CONSTRAINT [DF_InventoryItemQuestionOption_Sort] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItemQuestionOption] ADD CONSTRAINT [PK_InventoryItemQuestionOption] PRIMARY KEY CLUSTERED  ([OptionID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuestionID] ON [dbo].[InventoryItemQuestionOption] ([QuestionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItemQuestionOption] ADD CONSTRAINT [FK_InventoryItemQuestionOption_InventoryItemQuestion] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[InventoryItemQuestion] ([QuestionID])
GO
