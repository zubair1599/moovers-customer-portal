CREATE TABLE [dbo].[EmailTemplate]
(
[TemplateID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailTemplate_TemplateID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subject] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Text] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailTemplate] ADD CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED  ([TemplateID]) ON [PRIMARY]
GO
