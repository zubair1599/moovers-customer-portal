CREATE TABLE [dbo].[StorageInvoice_Payment_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageInvoice_Payment_Rel_RelID] DEFAULT (newid()),
[StoragePaymentID] [uniqueidentifier] NOT NULL,
[InvoiceID] [uniqueidentifier] NOT NULL,
[Amount] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageInvoice_Payment_Rel] ADD CONSTRAINT [PK_StorageInvoice_Payment_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Invoice] ON [dbo].[StorageInvoice_Payment_Rel] ([InvoiceID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Payment] ON [dbo].[StorageInvoice_Payment_Rel] ([StoragePaymentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PaymentInvoie] ON [dbo].[StorageInvoice_Payment_Rel] ([StoragePaymentID], [InvoiceID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageInvoice_Payment_Rel] ADD CONSTRAINT [FK_StorageInvoice_Payment_Rel_StorageInvoice] FOREIGN KEY ([InvoiceID]) REFERENCES [dbo].[StorageInvoice] ([InvoiceID])
GO
ALTER TABLE [dbo].[StorageInvoice_Payment_Rel] ADD CONSTRAINT [FK_StorageInvoice_Payment_Rel_StoragePayment] FOREIGN KEY ([StoragePaymentID]) REFERENCES [dbo].[StoragePayment] ([PaymentID])
GO
