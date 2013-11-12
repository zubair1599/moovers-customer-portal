CREATE TABLE [dbo].[Payment]
(
[PaymentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Payment_PaymentID] DEFAULT (newid()),
[FranchiseID] [uniqueidentifier] NOT NULL,
[PaymentTypeID] [int] NOT NULL,
[CreditCardID] [uniqueidentifier] NULL,
[TransactionID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Amount] [decimal] (18, 2) NOT NULL,
[Success] [bit] NOT NULL,
[Date] [datetime] NOT NULL,
[IsCancelled] [bit] NOT NULL,
[CancellationReason] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CheckNumber] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Memo] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AcceptedBy] [uniqueidentifier] NULL,
[IsDeposited] [bit] NOT NULL CONSTRAINT [DF_Payment_IsDeposited] DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED  ([PaymentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CreditCardID] ON [dbo].[Payment] ([CreditCardID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Date] ON [dbo].[Payment] ([Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IsCancelled] ON [dbo].[Payment] ([IsCancelled]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Success] ON [dbo].[Payment] ([Success]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CancelledSuccess] ON [dbo].[Payment] ([Success], [IsCancelled]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Payment_8_19531153__K6_K8_K1_5] ON [dbo].[Payment] ([Success], [IsCancelled], [PaymentID]) INCLUDE ([Amount]) ON [PRIMARY]
GO
