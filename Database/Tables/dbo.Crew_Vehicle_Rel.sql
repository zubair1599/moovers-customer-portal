CREATE TABLE [dbo].[Crew_Vehicle_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Crew_Vehicle_Rel_RelID] DEFAULT (newid()),
[CrewID] [uniqueidentifier] NOT NULL,
[VehicleID] [uniqueidentifier] NOT NULL,
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Crew_Vehicle_Rel_IsArchived] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Crew_Vehicle_Rel] ADD CONSTRAINT [PK_Crew_Vehicle_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [VehicleID] ON [dbo].[Crew_Vehicle_Rel] ([VehicleID]) ON [PRIMARY]
GO
