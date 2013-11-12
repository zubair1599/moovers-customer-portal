CREATE TABLE [dbo].[ScheduleNote]
(
[NoteID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ScheduleNote_NoteID] DEFAULT (newid()),
[Day] [int] NOT NULL,
[Month] [int] NOT NULL,
[Year] [int] NOT NULL,
[Message] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScheduleNote] ADD CONSTRAINT [PK_ScheduleNote] PRIMARY KEY CLUSTERED  ([NoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [monthdayyear] ON [dbo].[ScheduleNote] ([Day], [Month], [Year]) ON [PRIMARY]
GO
