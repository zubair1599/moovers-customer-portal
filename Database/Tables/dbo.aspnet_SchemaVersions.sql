CREATE TABLE [dbo].[aspnet_SchemaVersions]
(
[Feature] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CompatibleSchemaVersion] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsCurrentVersion] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_SchemaVersions] ADD CONSTRAINT [PK__aspnet_S__5A1E6BC11FCDBCEB] PRIMARY KEY CLUSTERED  ([Feature], [CompatibleSchemaVersion]) ON [PRIMARY]
GO
