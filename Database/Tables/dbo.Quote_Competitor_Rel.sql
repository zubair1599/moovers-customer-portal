CREATE TABLE [dbo].[Quote_Competitor_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_Competitor_Rel_RelID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[CompetitorID] [uniqueidentifier] NOT NULL,
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_Competitor_Rel] ADD CONSTRAINT [PK_Quote_Competitor_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CompetitorID] ON [dbo].[Quote_Competitor_Rel] ([CompetitorID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[Quote_Competitor_Rel] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_Competitor_Rel] ADD CONSTRAINT [FK_Quote_Competitor_Rel_Competitor] FOREIGN KEY ([CompetitorID]) REFERENCES [dbo].[Competitor] ([CompetitorID])
GO
ALTER TABLE [dbo].[Quote_Competitor_Rel] ADD CONSTRAINT [FK_Quote_Competitor_Rel_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
