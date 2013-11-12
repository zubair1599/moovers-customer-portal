CREATE TABLE [dbo].[QuoteHistory]
(
[AccountID] [uniqueidentifier] NOT NULL,
[QuoteHistoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_QuoteHistory_QuoteHistoryID] DEFAULT (newid()),
[QuoteID] [uniqueidentifier] NOT NULL,
[ShippingAccountID] [uniqueidentifier] NOT NULL,
[MoveDate] [datetime] NOT NULL,
[StatusID] [int] NOT NULL,
[ReferralMethod] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PricingTypeID] [int] NOT NULL,
[AccountManagerID] [uniqueidentifier] NOT NULL,
[DateModified] [datetime] NOT NULL,
[StopJson] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemJson] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [int] NOT NULL,
[ModifiedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteHistory] ADD CONSTRAINT [PK_QuoteHistory] PRIMARY KEY CLUSTERED  ([QuoteHistoryID]) ON [PRIMARY]
GO
