CREATE TABLE [dbo].[Address]
(
[AddressID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Address_AddressID] DEFAULT (newid()),
[Street1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Created] [datetime] NOT NULL,
[VerifiedLine1] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiedLastLine] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiedBarCode] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiedComponents] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiedAnalysis] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiedMetaData] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED  ([AddressID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Addressid-includecitystate] ON [dbo].[Address] ([AddressID]) INCLUDE ([City], [State]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ID-incState] ON [dbo].[Address] ([AddressID]) INCLUDE ([State]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [City] ON [dbo].[Address] ([City]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [State] ON [dbo].[Address] ([State]) ON [PRIMARY]
GO
