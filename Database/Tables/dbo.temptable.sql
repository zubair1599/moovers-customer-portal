CREATE TABLE [dbo].[temptable]
(
[testcol] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[temptable] ADD CONSTRAINT [PK_temptable] PRIMARY KEY CLUSTERED  ([testcol]) ON [PRIMARY]
GO
