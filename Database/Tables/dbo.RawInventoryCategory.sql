CREATE TABLE [dbo].[RawInventoryCategory]
(
[CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_RawInventoryCategory_CategoryID] DEFAULT (newid()),
[Name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawInventoryCategory] ADD CONSTRAINT [PK_RawInventoryCategory] PRIMARY KEY CLUSTERED  ([CategoryID]) ON [PRIMARY]
GO
