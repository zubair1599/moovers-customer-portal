CREATE TABLE [dbo].[PostingService]
(
[ServiceID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PostingService_ServiceID] DEFAULT (newid()),
[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Type] [int] NOT NULL,
[Price] [decimal] (18, 2) NOT NULL,
[Tax] [bit] NOT NULL,
[TaxAmount] [decimal] (18, 2) NULL,
[PostingID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PostingService] ADD CONSTRAINT [PK_PostingService] PRIMARY KEY CLUSTERED  ([ServiceID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PostingService] ADD CONSTRAINT [FK_PostingService_Posting] FOREIGN KEY ([PostingID]) REFERENCES [dbo].[Posting] ([PostingID])
GO
