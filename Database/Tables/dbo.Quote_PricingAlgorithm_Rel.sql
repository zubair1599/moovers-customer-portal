CREATE TABLE [dbo].[Quote_PricingAlgorithm_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Quote_PricingAlgorithm_Rel_RelID] DEFAULT (newid()),
[PricingAlgorithmID] [uniqueidentifier] NOT NULL,
[QuoteID] [uniqueidentifier] NOT NULL,
[VariableList] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_PricingAlgorithm_Rel] ADD CONSTRAINT [PK_Quote_PricingAlgorithm_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QUoteIDAlgorithmID] ON [dbo].[Quote_PricingAlgorithm_Rel] ([PricingAlgorithmID], [QuoteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [QuoteID] ON [dbo].[Quote_PricingAlgorithm_Rel] ([QuoteID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Quote_PricingAlgorithm_Rel] ADD CONSTRAINT [FK_Quote_PricingAlgorithm_Rel_PricingAlgorithm] FOREIGN KEY ([PricingAlgorithmID]) REFERENCES [dbo].[PricingAlgorithm] ([AlgorithmID])
GO
ALTER TABLE [dbo].[Quote_PricingAlgorithm_Rel] ADD CONSTRAINT [FK_Quote_PricingAlgorithm_Rel_Quote] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[Quote] ([QuoteID])
GO
