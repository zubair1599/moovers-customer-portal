CREATE TABLE [dbo].[temptable]
(
[testcol] [int] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[temptable] ADD CONSTRAINT [PK_temptable] PRIMARY KEY CLUSTERED  ([testcol]) ON [PRIMARY]
GO
