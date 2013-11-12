CREATE TABLE [dbo].[InventoryItem]
(
[ItemID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_InventoryItem_ItemID] DEFAULT (newid()),
[CategoryID] [uniqueidentifier] NULL CONSTRAINT [DF_InventoryItem_CategoryID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PluralName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sort] [int] NOT NULL,
[CubicFeet] [decimal] (18, 2) NOT NULL CONSTRAINT [DF_InventoryItem_CubicFeet] DEFAULT ((0)),
[Weight] [decimal] (18, 2) NOT NULL CONSTRAINT [DF_InventoryItem_Weight] DEFAULT ((0)),
[IsBox] [bit] NOT NULL CONSTRAINT [DF_InventoryItem_IsBox] DEFAULT ((0)),
[KeyCode] [int] NOT NULL,
[IsCustom] [bit] NOT NULL CONSTRAINT [DF_InventoryItem_IsCustom] DEFAULT ((0)),
[AliasString] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_InventoryItem_IsArchived] DEFAULT ((0)),
[NewRevisionItemID] [uniqueidentifier] NULL,
[CustomTime] [decimal] (18, 2) NULL,
[LiabilityCost] [decimal] (18, 2) NULL,
[MoversRequired] [int] NOT NULL,
[AdditionalNotes] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MovepointKeycode] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[SetSort] 
   ON  dbo.InventoryItem
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.InventoryItem(
[ItemID]
      ,[CategoryID]
      ,[Name]
      ,[PluralName]
      ,[CubicFeet]
      ,[Weight]
      ,[IsBox]
      ,[KeyCode]
      ,[IsCustom]
      ,[AliasString]
      ,[IsArchived]
      ,[NewRevisionItemID]
      ,[CustomTime]
      ,[MoversRequired]
      ,[Sort]
    )
	SELECT 
[ItemID]
      ,[CategoryID]
      ,[Name]
      ,[PluralName]
      ,[CubicFeet]
      ,[Weight]
      ,[IsBox]
      ,[KeyCode]
      ,[IsCustom]
      ,[AliasString]
      ,[IsArchived]
      ,[NewRevisionItemID]
      ,[CustomTime]
      ,[MoversRequired]
      ,(SELECT MAX(Sort) + 1 FROM InventoryItem)
	FROM inserted
END
GO
ALTER TABLE [dbo].[InventoryItem] ADD CONSTRAINT [PK_InventoryItem] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CategoryID] ON [dbo].[InventoryItem] ([CategoryID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [KeyCode] ON [dbo].[InventoryItem] ([KeyCode]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MovepointKeycode] ON [dbo].[InventoryItem] ([MovepointKeycode]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Name] ON [dbo].[InventoryItem] ([Name]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Sort] ON [dbo].[InventoryItem] ([Sort]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryItem] ADD CONSTRAINT [FK_InventoryItem_InventoryItem1] FOREIGN KEY ([NewRevisionItemID]) REFERENCES [dbo].[InventoryItem] ([ItemID])
GO
