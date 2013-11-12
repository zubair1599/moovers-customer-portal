CREATE TABLE [dbo].[MarketingEmailLog]
(
[MarketingEmailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_LeadEmailLog_LeadEmailID] DEFAULT (newid()),
[LeadID] [uniqueidentifier] NULL,
[DateSent] [datetime] NOT NULL,
[Content] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subject] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MailTo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MailFrom] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WasUnsubscribed] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[MarketingEmailLog] ADD CONSTRAINT [PK_MarketingEmailLog] PRIMARY KEY CLUSTERED  ([MarketingEmailID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [leadid] ON [dbo].[MarketingEmailLog] ([LeadID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MarketingEmailLog] ADD CONSTRAINT [FK_MarketingEmailLog_Lead] FOREIGN KEY ([LeadID]) REFERENCES [dbo].[Lead] ([LeadID])
GO
