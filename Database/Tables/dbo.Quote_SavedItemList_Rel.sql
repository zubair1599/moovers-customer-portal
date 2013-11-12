CREATE TABLE [dbo].[Quote_SavedItemList_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_SavedItemList_Rel_RelID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[ItemList] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Updated] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_SavedItemList_Rel] ADD CONSTRAINT [PK_Quote_SavedItemList_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[Quote_SavedItemList_Rel] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_SavedItemList_Rel] ADD CONSTRAINT [FK_Quote_SavedItemList_Rel_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
