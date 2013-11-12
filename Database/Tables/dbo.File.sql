CREATE TABLE [dbo].[File]
(
[FileID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_File_FileID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ContentType] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Created] [datetime] NOT NULL,
[Content] [varbinary] (max) NULL,
[HtmlContent] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsInDirectory] [bit] NOT NULL CONSTRAINT [DF_File_IsInDirectory] DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[File] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Name] ON [dbo].[File] ([Name]) ON [PRIMARY]
GO
