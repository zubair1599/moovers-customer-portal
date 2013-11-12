CREATE TABLE [dbo].[Competitor]
(
[CompetitorID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Competitor_CompetitorID] DEFAULT (newid()),
[FranchiseID] [uniqueidentifier] NOT NULL,
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsOther] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Competitor] ADD CONSTRAINT [PK_Competitor] PRIMARY KEY CLUSTERED  ([CompetitorID]) ON [PRIMARY]
GO
