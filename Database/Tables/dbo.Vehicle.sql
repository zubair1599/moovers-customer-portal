CREATE TABLE [dbo].[Vehicle]
(
[VehicleID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Vehicle_VehicleID] DEFAULT (newid()),
[FranchiseID] [uniqueidentifier] NOT NULL,
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Vehicle_IsArchived] DEFAULT ((0)),
[CubicFeet] [int] NULL,
[Length] [decimal] (18, 2) NULL,
[Make] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Model] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Year] [int] NULL,
[Type] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Vehicle] ADD CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED  ([VehicleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Vehicle] ADD CONSTRAINT [FK_Vehicle_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
