CREATE TABLE [dbo].[TransactionLog]
(
[TransactionLogID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CardTransactionLog_TransactionLogID] DEFAULT (newid()),
[ReferenceNum] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomerNum] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChargeType] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TransactionStore] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TransactionLog] ADD CONSTRAINT [PK_CardTransactionLog] PRIMARY KEY CLUSTERED  ([TransactionLogID]) ON [PRIMARY]
GO
