CREATE TABLE [dbo].[Quote]
(
[QuoteID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_QuoteID] DEFAULT (newid()),
[FranchiseID] [uniqueidentifier] NOT NULL,
[AccountID] [uniqueidentifier] NOT NULL,
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShippingAccountID] [uniqueidentifier] NOT NULL,
[MoveDate] [datetime] NOT NULL,
[StatusID] [int] NOT NULL,
[ReferralMethod] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PricingTypeID] [int] NOT NULL,
[AccountManagerID] [uniqueidentifier] NOT NULL,
[Created] [datetime] NOT NULL,
[Trucks] [int] NULL,
[CrewSize] [int] NULL,
[BasePrice] [decimal] (18, 2) NULL,
[TotalAdjustments] [decimal] (18, 2) NULL,
[GuaranteedPrice] [decimal] (18, 2) NULL,
[FirstHourPrice] [decimal] (18, 2) NULL,
[HourlyPrice] [decimal] (18, 2) NULL,
[CustomerTimeEstimate] [int] NULL,
[ActionReason] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreditCardID] [uniqueidentifier] NULL,
[DateScheduled] [datetime] NULL,
[PrintedComments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FinalPostedPrice] [decimal] (18, 2) NULL,
[CustomInventoryData] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StorageVaults] [int] NULL,
[TemporaryStorage] [decimal] (18, 2) NULL,
[ReplacementValuationCost] [decimal] (18, 2) NULL,
[ConfirmationEmailsSent] [int] NOT NULL CONSTRAINT [DF_Quote_ConfirmationEmailsSent] DEFAULT ((0)),
[ValuationTypeID] [uniqueidentifier] NULL,
[BookEmailsSent] [int] NOT NULL CONSTRAINT [DF_Quote_BookEmailsSent] DEFAULT ((0)),
[StorageDays] [int] NULL,
[CachedCubicFeet] [decimal] (18, 2) NULL,
[CachedWeight] [decimal] (18, 2) NULL,
[CachedDuration] [decimal] (18, 2) NULL,
[CachedOneWayMoveMiles] [decimal] (18, 2) NULL,
[HasOldStorage] [bit] NOT NULL CONSTRAINT [DF_Quote_HasOldStorage] DEFAULT ((0)),
[IsReadOnly] [bit] NOT NULL CONSTRAINT [DF_Quote_IsReadOnly] DEFAULT ((0)),
[ModifiedBy] [uniqueidentifier] NULL,
[DateModified] [datetime] NULL,
[CancellationDate] [datetime] NULL,
[ForcedStorageCost] [int] NULL,
[IsPackJob] [bit] NOT NULL CONSTRAINT [DF_Quote_IsPackJob] DEFAULT ((0)),
[MovepointInventory] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ForceFranchiseID] [uniqueidentifier] NULL,
[IsLostDebt] [bit] NOT NULL CONSTRAINT [DF_Quote_IsLostDebt] DEFAULT ((0)),
[CustomHourlyRate] [decimal] (18, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [dbo].[SetQuoteLookup] 
   ON  [dbo].[Quote]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.Quote([QuoteID]
      ,[FranchiseID]
      ,[AccountID]
      ,[ShippingAccountID]
      ,[MoveDate]
      ,[StatusID]
      ,[ReferralMethod]
      ,[PricingTypeID]
      ,[AccountManagerID]
      ,[DateModified]
      ,[Created]
      ,[Trucks]
      ,[CrewSize]
      ,[BasePrice]
      ,[TotalAdjustments]
      ,[GuaranteedPrice]
      ,[FirstHourPrice]
      ,[HourlyPrice]
      ,[CustomerTimeEstimate]
      ,[ActionReason]
      ,[CreditCardID]
      ,[DateScheduled]
      ,[PrintedComments]
      ,[FinalPostedPrice]
      ,[CustomInventoryData]
      ,[StorageVaults]
      ,[TemporaryStorage]
      ,[ReplacementValuationCost]
      ,[IsPackJob]
      ,[ForceFranchiseID]
      ,[Lookup]
	)
	SELECT [QuoteID]
      ,[FranchiseID]
      ,[AccountID]
      ,[ShippingAccountID]
      ,[MoveDate]
      ,[StatusID]
      ,[ReferralMethod]
      ,[PricingTypeID]
      ,[AccountManagerID]
      ,[DateModified]
      ,[Created]
      ,[Trucks]
      ,[CrewSize]
      ,[BasePrice]
      ,[TotalAdjustments]
      ,[GuaranteedPrice]
      ,[FirstHourPrice]
      ,[HourlyPrice]
      ,[CustomerTimeEstimate]
      ,[ActionReason]
      ,[CreditCardID]
      ,[DateScheduled]
      ,[PrintedComments]
      ,[FinalPostedPrice]
      ,[CustomInventoryData]
      ,[StorageVaults]
      ,[TemporaryStorage]
      ,[ReplacementValuationCost]
      ,[IsPackJob]
      ,[ForceFranchiseID]
	  ,(SELECT ISNULL(CAST(MAX(CAST(Lookup AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.Quote)
	FROM inserted
END
GO
ALTER TABLE [dbo].[Quote] ADD CONSTRAINT [PK_Quote] PRIMARY KEY CLUSTERED  ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BillingAccount] ON [dbo].[Quote] ([AccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ShippingAccountBillingAccount] ON [dbo].[Quote] ([AccountID], [ShippingAccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AccountManager] ON [dbo].[Quote] ([AccountManagerID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Quote_8_256719967__K10_K7_K2_1] ON [dbo].[Quote] ([AccountManagerID], [StatusID], [FranchiseID]) INCLUDE ([QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MoveMiles] ON [dbo].[Quote] ([CachedOneWayMoveMiles]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Created] ON [dbo].[Quote] ([Created]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Franchise] ON [dbo].[Quote] ([FranchiseID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Quote_8_256719967__K2_K7_4] ON [dbo].[Quote] ([FranchiseID], [StatusID]) INCLUDE ([Lookup]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Quote_8_256719967__K2_K7_K1_9_17_18_19_20_25] ON [dbo].[Quote] ([FranchiseID], [StatusID], [QuoteID]) INCLUDE ([CustomerTimeEstimate], [FinalPostedPrice], [FirstHourPrice], [GuaranteedPrice], [HourlyPrice], [PricingTypeID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Lookup] ON [dbo].[Quote] ([Lookup]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PricingType] ON [dbo].[Quote] ([PricingTypeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Quote_8_256719967__K1_25] ON [dbo].[Quote] ([QuoteID]) INCLUDE ([FinalPostedPrice]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ShippingAccount] ON [dbo].[Quote] ([ShippingAccountID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [status] ON [dbo].[Quote] ([StatusID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Quote_8_256719967__K7_K6_K1_K2] ON [dbo].[Quote] ([StatusID], [MoveDate], [QuoteID], [FranchiseID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote] ADD CONSTRAINT [FK_Quote_Account] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Quote] ADD CONSTRAINT [FK_Quote_Account_CreditCard] FOREIGN KEY ([CreditCardID]) REFERENCES [dbo].[Account_CreditCard] ([CreditCardID])
GO
ALTER TABLE [dbo].[Quote] ADD CONSTRAINT [FK_Quote_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
ALTER TABLE [dbo].[Quote] ADD CONSTRAINT [FK_Quote_Account1] FOREIGN KEY ([ShippingAccountID]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Quote] ADD CONSTRAINT [FK_Quote_ReplacementValuation] FOREIGN KEY ([ValuationTypeID]) REFERENCES [dbo].[ReplacementValuation] ([ValuationTypeID])
GO
