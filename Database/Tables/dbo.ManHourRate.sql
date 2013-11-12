CREATE TABLE [dbo].[ManHourRate]
(
[StatID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ManHourRate_StatID] DEFAULT (newid()),
[Json] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Added] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ManHourRate] ADD CONSTRAINT [PK_ManHourRate] PRIMARY KEY CLUSTERED  ([StatID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Added] ON [dbo].[ManHourRate] ([Added]) ON [PRIMARY]
GO
