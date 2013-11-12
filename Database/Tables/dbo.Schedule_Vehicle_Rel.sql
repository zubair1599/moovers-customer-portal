CREATE TABLE [dbo].[Schedule_Vehicle_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Schedule_Vehicle_Rel_RelID] DEFAULT (newid()),
[ScheduleID] [uniqueidentifier] NOT NULL,
[VehicleID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Schedule_Vehicle_Rel] ADD CONSTRAINT [PK_Schedule_Vehicle_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ScheduleID] ON [dbo].[Schedule_Vehicle_Rel] ([ScheduleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [VehicleID] ON [dbo].[Schedule_Vehicle_Rel] ([VehicleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Schedule_Vehicle_Rel] ADD CONSTRAINT [FK_Schedule_Vehicle_Rel_Schedule] FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule_Vehicle_Rel] ADD CONSTRAINT [FK_Schedule_Vehicle_Rel_Vehicle] FOREIGN KEY ([VehicleID]) REFERENCES [dbo].[Vehicle] ([VehicleID])
GO
