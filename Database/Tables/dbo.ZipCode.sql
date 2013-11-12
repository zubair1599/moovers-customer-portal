CREATE TABLE [dbo].[ZipCode]
(
[ZipCodeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ZipCodes_ZipCodeID] DEFAULT (newid()),
[ZipCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Latitude] [decimal] (18, 8) NOT NULL,
[Longitude] [decimal] (18, 8) NOT NULL,
[City] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZipCode] ADD CONSTRAINT [PK_ZipCodes] PRIMARY KEY CLUSTERED  ([ZipCodeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Zip] ON [dbo].[ZipCode] ([ZipCode]) ON [PRIMARY]
GO
