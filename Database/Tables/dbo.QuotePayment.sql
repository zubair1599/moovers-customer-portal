CREATE TABLE [dbo].[QuotePayment]
(
[PaymentID] [uniqueidentifier] NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL,
[PaymentTypeID] [int] NOT NULL,
[CreditCardID] [uniqueidentifier] NULL,
[TransactionID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Amount] [decimal] (18, 2) NULL,
[Success] [bit] NULL,
[Date] [datetime] NULL,
[IsCancelled] [bit] NULL CONSTRAINT [DF_QuotePayment_IsCancelled] DEFAULT ((0)),
[CancellationReason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CheckNumber] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Memo] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AcceptedBy] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuotePayment] ADD CONSTRAINT [PK_QuotePayment] PRIMARY KEY CLUSTERED  ([PaymentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CCID] ON [dbo].[QuotePayment] ([CreditCardID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[QuotePayment] ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_QuotePayment_8_1003150619__K2_K1] ON [dbo].[QuotePayment] ([QuoteID], [PaymentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteIDSuccess] ON [dbo].[QuotePayment] ([QuoteID], [Success]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TransactionID] ON [dbo].[QuotePayment] ([TransactionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuotePayment] ADD CONSTRAINT [FK_Quote_Payment_Account_CreditCard] FOREIGN KEY ([CreditCardID]) REFERENCES [dbo].[Account_CreditCard] ([CreditCardID])
GO
ALTER TABLE [dbo].[QuotePayment] ADD CONSTRAINT [FK_QuotePayment_Payment] FOREIGN KEY ([PaymentID]) REFERENCES [dbo].[Payment] ([PaymentID])
GO
ALTER TABLE [dbo].[QuotePayment] ADD CONSTRAINT [FK_Quote_Payment_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
