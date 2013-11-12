CREATE TABLE [dbo].[NewInventoryItem]
(
[ItemID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_NewInventoryItem_ItemID] DEFAULT (newid()),
[Name] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PluralName] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CubicFeet] [decimal] (18, 2) NOT NULL,
[Weight] [decimal] (18, 2) NOT NULL CONSTRAINT [DF_NewInventoryItem_Weight] DEFAULT ((0)),
[IsBox] [bit] NOT NULL CONSTRAINT [DF_NewInventoryItem_IsBox] DEFAULT ((0)),
[MoversRequired] [int] NOT NULL,
[KeyCode] [int] NULL,
[AliasString] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomTime] [decimal] (18, 2) NULL,
[StdDev] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NewInventoryItem] ADD CONSTRAINT [PK_NewInventoryItem] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
