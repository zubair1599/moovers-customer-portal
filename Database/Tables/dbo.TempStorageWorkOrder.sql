CREATE TABLE [dbo].[TempStorageWorkOrder]
(
[WorkOrderID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageWorkOrder_WorkOrderID] DEFAULT (newid()),
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountID] [uniqueidentifier] NOT NULL,
[StartDate] [datetime] NOT NULL,
[CancellationDate] [datetime] NULL,
[MonthlyPayment] [decimal] (18, 2) NOT NULL
) ON [PRIMARY]
GO
