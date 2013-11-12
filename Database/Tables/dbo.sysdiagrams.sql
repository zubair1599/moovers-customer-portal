CREATE TABLE [dbo].[sysdiagrams]
(
[name] [sys].[sysname] NOT NULL,
[principal_id] [int] NOT NULL,
[diagram_id] [int] NOT NULL IDENTITY(1, 1),
[version] [int] NULL,
[definition] [varbinary] (max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[sysdiagrams] ADD CONSTRAINT [PK__sysdiagr__C2B05B6113F1F5EB] PRIMARY KEY CLUSTERED  ([diagram_id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sysdiagrams] ADD CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED  ([name], [principal_id]) ON [PRIMARY]
GO
