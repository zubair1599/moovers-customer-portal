CREATE TABLE [dbo].[RawInventoryItemMeasurement]
(
[MeasurementID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_RawInventoryItemMeasurement_MeasurementID] DEFAULT (newid()),
[ItemID] [uniqueidentifier] NOT NULL,
[BaseHeight] [decimal] (18, 2) NULL,
[BaseDepth] [decimal] (18, 2) NULL,
[BaseLength] [decimal] (18, 2) NULL,
[BackHeight] [decimal] (18, 2) NULL,
[BackDepth] [decimal] (18, 2) NULL,
[BackLength] [decimal] (18, 2) NULL,
[RawBaseHeight] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawBaseDepth] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawBaseLength] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawBackHeight] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawBackDepth] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawBackLength] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawInventoryItemMeasurement] ADD CONSTRAINT [PK_RawInventoryItemMeasurement] PRIMARY KEY CLUSTERED  ([MeasurementID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawInventoryItemMeasurement] ADD CONSTRAINT [FK_RawInventoryItemMeasurement_RawInventoryItem] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[RawInventoryItem] ([RawInventoryID])
GO
