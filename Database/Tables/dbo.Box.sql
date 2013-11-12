CREATE TABLE [dbo].[Box]
(
[BoxTypeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Box_BoxTypeID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Box] ADD CONSTRAINT [PK_Box] PRIMARY KEY CLUSTERED  ([BoxTypeID]) ON [PRIMARY]
GO
