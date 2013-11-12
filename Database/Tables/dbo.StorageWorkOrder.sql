CREATE TABLE [dbo].[StorageWorkOrder]
(
[WorkOrderID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageWorkOrder_WorkOrderID_1] DEFAULT (newid()),
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountID] [uniqueidentifier] NOT NULL,
[StartDate] [datetime] NOT NULL,
[CancellationDate] [datetime] NULL,
[MonthlyPayment] [decimal] (18, 2) NOT NULL,
[NextInvoiceDate] [datetime] NULL,
[InvoicePeriodID] [int] NOT NULL CONSTRAINT [DF_StorageWorkOrder_InvoiceType] DEFAULT ((0)),
[CancelledBy] [uniqueidentifier] NULL,
[CreditCardID] [uniqueidentifier] NULL,
[HasPaymentError] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_HasPaymentError] DEFAULT ((0)),
[LastPaymentError] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobNotes] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsAutomaticBilling] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_IsAutomaticBilling] DEFAULT ((0)),
[EmailInvoices] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_EmailInvoices] DEFAULT ((0)),
[EmailReceipts] [bit] NOT NULL CONSTRAINT [DF_StorageWorkOrder_EmailReceipts] DEFAULT ((0)),
[LastAutomaticBillingDate] [datetime] NULL,
[FailedAutomaticBillingAttempts] [int] NOT NULL CONSTRAINT [DF_StorageWorkOrder_FailedAutomaticBillingAttempts] DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[SetStorageLookup]
   ON  dbo.StorageWorkOrder
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	INSERT INTO dbo.StorageWorkOrder(
		[WorkOrderID]
      ,[AccountID]
      ,[StartDate]
      ,[CancellationDate]
      ,[MonthlyPayment]
      ,[NextInvoiceDate]
      ,[InvoicePeriodID]
      ,CancelledBy
      ,HasPaymentError
      ,LastPaymentError     
      ,[Lookup]
		) 
	SELECT 
		[WorkOrderID]
      ,[AccountID]
      ,[StartDate]
      ,[CancellationDate]
      ,[MonthlyPayment]
      ,[NextInvoiceDate]
      ,[InvoicePeriodID]
      ,CancelledBy
		,HasPaymentError
      ,LastPaymentError     
		,(SELECT ISNULL(CAST(MAX(CAST(Lookup AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.StorageWorkOrder)
	FROM inserted		
END
GO
ALTER TABLE [dbo].[StorageWorkOrder] ADD CONSTRAINT [PK_StorageWorkOrder] PRIMARY KEY CLUSTERED  ([WorkOrderID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PaymentErrorAUtomagicBilling] ON [dbo].[StorageWorkOrder] ([HasPaymentError], [IsAutomaticBilling]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [lookup] ON [dbo].[StorageWorkOrder] ([Lookup]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageWorkOrder] ADD CONSTRAINT [FK_StorageWorkOrder_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StorageWorkOrder] ADD CONSTRAINT [FK_StorageWorkOrder_Account_CreditCard] FOREIGN KEY ([CreditCardID]) REFERENCES [dbo].[Account_CreditCard] ([CreditCardID])
GO
