CREATE TABLE [dbo].[Account_CreditCard]
(
[CreditCardID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_CreditCard_CreditCardID] DEFAULT (newid()),
[AccountID] [uniqueidentifier] NOT NULL,
[CardHolder] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Card] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Expiration] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CardType] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsRemoved] [bit] NOT NULL CONSTRAINT [DF_Account_CreditCard_IsRemoved] DEFAULT ((0)),
[FranchiseID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_CreditCard] ADD CONSTRAINT [PK_Account_CreditCard] PRIMARY KEY CLUSTERED  ([CreditCardID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountID] ON [dbo].[Account_CreditCard] ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountIDIsRemoved] ON [dbo].[Account_CreditCard] ([AccountID], [IsRemoved]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_CreditCard] ADD CONSTRAINT [FK_Account_CreditCard_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
