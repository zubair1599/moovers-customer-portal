CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers]
(
[PathId] [uniqueidentifier] NOT NULL,
[PageSettings] [image] NOT NULL,
[LastUpdatedDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] ADD CONSTRAINT [PK__aspnet_P__CD67DC59108B795B] PRIMARY KEY CLUSTERED  ([PathId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] ADD CONSTRAINT [FK__aspnet_Pe__PathI__3A81B327] FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
