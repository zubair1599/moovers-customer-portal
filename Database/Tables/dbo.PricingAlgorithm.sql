CREATE TABLE [dbo].[PricingAlgorithm]
(
[AlgorithmID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PricingAlgorithm_AlgorithmID] DEFAULT (newid()),
[Text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateAdded] [datetime] NOT NULL,
[VariableList] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AlgorithmType] [int] NOT NULL,
[IsCurrent] [bit] NOT NULL,
[FranchiseID] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PricingAlgorithm] ADD CONSTRAINT [PK_PricingAlgorithm] PRIMARY KEY CLUSTERED  ([AlgorithmID]) ON [PRIMARY]
GO
