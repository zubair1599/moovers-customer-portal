CREATE TABLE [dbo].[StorageInvoice]
(
[InvoiceID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageInvoice_InvoiceID] DEFAULT (newid()),
[WorkOrderID] [uniqueidentifier] NOT NULL,
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Amount] [decimal] (18, 2) NOT NULL,
[IsRemoved] [bit] NOT NULL,
[Date] [datetime] NOT NULL,
[ForDate] [datetime] NOT NULL,
[IsCancelled] [bit] NOT NULL CONSTRAINT [DF_StorageInvoice_IsCancelled] DEFAULT ((0)),
[IsPrinted] [bit] NOT NULL CONSTRAINT [DF_StorageInvoice_HasBeenPrinted] DEFAULT ((0))
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[SetStorageInvoiceLookup]
   ON  [dbo].[StorageInvoice]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	INSERT INTO dbo.StorageInvoice(
		[InvoiceID]
      ,[WorkOrderID]
      ,[Amount]
      ,[IsRemoved]
      ,[Date]
      ,ForDate
      ,[Lookup]
		) 
	SELECT 
		[InvoiceID]
      ,[WorkOrderID]
      ,[Amount]
      ,[IsRemoved]
      ,[Date]
      ,ForDate
		,(SELECT ISNULL(CAST(MAX(CAST(Lookup AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.StorageInvoice)
	FROM inserted		
END
GO
ALTER TABLE [dbo].[StorageInvoice] ADD CONSTRAINT [PK_StorageInvoice] PRIMARY KEY CLUSTERED  ([InvoiceID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IsPrinted] ON [dbo].[StorageInvoice] ([IsPrinted]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Lookup] ON [dbo].[StorageInvoice] ([Lookup]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WorkOrder] ON [dbo].[StorageInvoice] ([WorkOrderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageInvoice] ADD CONSTRAINT [FK_StorageInvoice_StorageWorkOrder] FOREIGN KEY ([WorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
