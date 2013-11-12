CREATE TABLE [dbo].[Crew_Schedule_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Crew_Schedule_Rel_RelID] DEFAULT (newid()),
[CrewID] [uniqueidentifier] NOT NULL,
[ScheduleID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Crew_Schedule_Rel] ADD CONSTRAINT [PK_Crew_Schedule_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CrewID] ON [dbo].[Crew_Schedule_Rel] ([CrewID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Crew_Schedule_Rel] ADD CONSTRAINT [FK_Crew_Schedule_Rel_Crew] FOREIGN KEY ([CrewID]) REFERENCES [dbo].[Crew] ([CrewID])
GO
ALTER TABLE [dbo].[Crew_Schedule_Rel] ADD CONSTRAINT [FK_Crew_Schedule_Rel_Schedule] FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID])
GO
