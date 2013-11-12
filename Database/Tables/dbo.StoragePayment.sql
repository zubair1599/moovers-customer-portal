CREATE TABLE [dbo].[StoragePayment]
(
[PaymentID] [uniqueidentifier] NOT NULL,
[WorkOrderID] [uniqueidentifier] NOT NULL,
[Timestamp] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StoragePayment] ADD CONSTRAINT [PK_StoragePayment] PRIMARY KEY CLUSTERED  ([PaymentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WorKorder] ON [dbo].[StoragePayment] ([WorkOrderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StoragePayment] ADD CONSTRAINT [FK_StoragePayment_Payment] FOREIGN KEY ([PaymentID]) REFERENCES [dbo].[Payment] ([PaymentID])
GO
ALTER TABLE [dbo].[StoragePayment] ADD CONSTRAINT [FK_StoragePayment_StorageWorkOrder] FOREIGN KEY ([WorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
