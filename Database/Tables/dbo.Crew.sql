CREATE TABLE [dbo].[Crew]
(
[CrewID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Crew_CrewID] DEFAULT (newid()),
[Month] [int] NOT NULL,
[Day] [int] NOT NULL,
[Year] [int] NOT NULL,
[Lookup] [int] NOT NULL,
[StatusID] [int] NOT NULL CONSTRAINT [DF_Crew_StatusID] DEFAULT ((1)),
[FranchiseID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Crew] ADD CONSTRAINT [PK_Crew] PRIMARY KEY CLUSTERED  ([CrewID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MonthDayYearLooup] ON [dbo].[Crew] ([Month], [Day], [Year], [Lookup]) ON [PRIMARY]
GO
