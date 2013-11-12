CREATE TABLE [dbo].[QuoteService]
(
[ServiceID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_QuoteService_ServiceID] DEFAULT (newid()),
[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Type] [int] NOT NULL,
[Price] [decimal] (18, 2) NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteService] ADD CONSTRAINT [PK_QuoteService] PRIMARY KEY CLUSTERED  ([ServiceID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[QuoteService] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QuoteService] ADD CONSTRAINT [FK_QuoteService_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
