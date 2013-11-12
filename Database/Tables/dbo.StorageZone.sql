CREATE TABLE [dbo].[StorageZone]
(
[ZoneID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageZone_ZoneID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsEmpty] [bit] NOT NULL CONSTRAINT [DF_StorageZone_IsEmpty] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageZone] ADD CONSTRAINT [PK_StorageZone] PRIMARY KEY CLUSTERED  ([ZoneID]) ON [PRIMARY]
GO
