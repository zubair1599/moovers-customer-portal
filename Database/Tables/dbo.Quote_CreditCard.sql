CREATE TABLE [dbo].[Quote_CreditCard]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_CreditCard_RelationshipID] DEFAULT (newid()),
[CreditCardID] [uniqueidentifier] NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_CreditCard] ADD CONSTRAINT [PK_Quote_CreditCard] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_CreditCard] ADD CONSTRAINT [FK_Quote_CreditCard_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
