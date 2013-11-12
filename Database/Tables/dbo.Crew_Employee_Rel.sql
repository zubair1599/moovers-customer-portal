CREATE TABLE [dbo].[Crew_Employee_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Crew_Employee_Rel_RelID] DEFAULT (newid()),
[CrewID] [uniqueidentifier] NOT NULL,
[EmployeeID] [uniqueidentifier] NOT NULL,
[IsDriver] [bit] NOT NULL CONSTRAINT [DF_Crew_Employee_Rel_IsDriver] DEFAULT ((0)),
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Crew_Employee_Rel_IsArchived] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Crew_Employee_Rel] ADD CONSTRAINT [PK_Crew_Employee_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CrewID] ON [dbo].[Crew_Employee_Rel] ([CrewID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Crew_Employee_Rel] ADD CONSTRAINT [FK_Crew_Employee_Rel_Crew] FOREIGN KEY ([CrewID]) REFERENCES [dbo].[Crew] ([CrewID])
GO
ALTER TABLE [dbo].[Crew_Employee_Rel] ADD CONSTRAINT [FK_Crew_Employee_Rel_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
