CREATE TABLE [dbo].[SmartyStreetsCache]
(
[CacheID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SmartyStreetsCache_CacheID] DEFAULT (newid()),
[Street] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ZipCode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateAdded] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SmartyStreetsCache] ADD CONSTRAINT [PK_SmartyStreetsCache] PRIMARY KEY CLUSTERED  ([CacheID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [street] ON [dbo].[SmartyStreetsCache] ([Street]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [street/city/state/zip] ON [dbo].[SmartyStreetsCache] ([Street], [City], [State], [ZipCode]) ON [PRIMARY]
GO
