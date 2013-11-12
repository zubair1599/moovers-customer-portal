CREATE TABLE [dbo].[Stop]
(
[StopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Stop_StopID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[AddressID] [uniqueidentifier] NOT NULL,
[Sort] [int] NOT NULL,
[AddressTypeID] [int] NOT NULL,
[ParkingTypeID] [int] NOT NULL,
[ElevatorTypeID] [int] NOT NULL,
[WalkDistance] [int] NOT NULL,
[OutsideStairsCount] [int] NOT NULL,
[OutsideStairsTypeID] [int] NOT NULL,
[InsideStairsCount] [int] NOT NULL,
[InsideStairsTypeID] [int] NOT NULL,
[Liftgate] [bit] NOT NULL,
[Dock] [bit] NOT NULL,
[Floor] [int] NOT NULL,
[AdditionalInfo] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ApartmentComplex] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ApartmentGateCode] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StorageDays] [int] NULL,
[CachedCostEstimate] [decimal] (18, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stop] ADD CONSTRAINT [PK_Stop] PRIMARY KEY CLUSTERED  ([StopID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AddressID] ON [dbo].[Stop] ([AddressID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [InstanceID] ON [dbo].[Stop] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Quote] ON [dbo].[Stop] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [InstanceincSortAddress] ON [dbo].[Stop] ([QuoteID]) INCLUDE ([AddressID], [Sort]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stop] ADD CONSTRAINT [FK_Stop_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID])
GO
ALTER TABLE [dbo].[Stop] ADD CONSTRAINT [FK_Stop_Stop] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
