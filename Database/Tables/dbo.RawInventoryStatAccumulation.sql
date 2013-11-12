CREATE TABLE [dbo].[RawInventoryStatAccumulation]
(
[StatID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_RawInventoryStatAccumulation_StatID] DEFAULT (newid()),
[Name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CategoryName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Average] [decimal] (18, 2) NOT NULL,
[StdDev] [decimal] (18, 2) NOT NULL,
[Min] [decimal] (18, 2) NULL,
[Max] [decimal] (18, 2) NULL,
[Measurements] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawInventoryStatAccumulation] ADD CONSTRAINT [PK_RawInventoryStatAccumulation] PRIMARY KEY CLUSTERED  ([StatID]) ON [PRIMARY]
GO
