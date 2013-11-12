CREATE TABLE [dbo].[Lead]
(
[LeadID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Lead_LeadID] DEFAULT (newid()),
[LeadJson] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MessageText] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Lead_IsArchived] DEFAULT ((0)),
[AddedDate] [datetime] NOT NULL,
[Source] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailsSent] [int] NOT NULL CONSTRAINT [DF_Lead_EmailsSent] DEFAULT ((0)),
[IsOptedOut] [bit] NOT NULL CONSTRAINT [DF_Lead_IsOptedOut] DEFAULT ((0)),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FranchiseID] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lead] ADD CONSTRAINT [PK_Lead] PRIMARY KEY CLUSTERED  ([LeadID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IsArchived] ON [dbo].[Lead] ([IsArchived]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [namefirst] ON [dbo].[Lead] ([Name]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lead] ADD CONSTRAINT [FK_Lead_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
