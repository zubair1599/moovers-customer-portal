CREATE TABLE [dbo].[QuoteSurvey]
(
[SurveyID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_QuoteSurvey_SurveyID] DEFAULT (newid()),
[Date] [datetime] NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL,
[Created] [datetime] NOT NULL,
[Notes] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsCancelled] [bit] NOT NULL CONSTRAINT [DF_QuoteSurvey_IsCancelled] DEFAULT ((0)),
[TimeStart] [time] NOT NULL,
[TimeEnd] [time] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteSurvey] ADD CONSTRAINT [PK_QuoteSurvey] PRIMARY KEY CLUSTERED  ([SurveyID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Date] ON [dbo].[QuoteSurvey] ([Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[QuoteSurvey] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteSurvey] ADD CONSTRAINT [FK_QuoteSurvey_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
