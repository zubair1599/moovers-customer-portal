CREATE TABLE [dbo].[CustomCrewCount]
(
[CustomCrewID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomCrewCount_CustomCrewID] DEFAULT (newid()),
[Count] [int] NOT NULL,
[Day] [int] NOT NULL,
[Month] [int] NOT NULL,
[Year] [int] NOT NULL,
[FranchiseID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomCrewCount] ADD CONSTRAINT [PK_CustomCrewCount] PRIMARY KEY CLUSTERED  ([CustomCrewID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MDY] ON [dbo].[CustomCrewCount] ([Day], [Month], [Year]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MonthDayYearFranchise] ON [dbo].[CustomCrewCount] ([Day], [Month], [Year], [FranchiseID]) ON [PRIMARY]
GO
