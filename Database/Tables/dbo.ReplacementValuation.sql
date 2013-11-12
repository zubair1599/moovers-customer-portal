CREATE TABLE [dbo].[ReplacementValuation]
(
[ValuationTypeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ReplacementValuation_ValuationTypeID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MaximumValue] [int] NULL,
[PerPound] [decimal] (18, 2) NOT NULL,
[Cost] [decimal] (18, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReplacementValuation] ADD CONSTRAINT [PK_ReplacementValuation] PRIMARY KEY CLUSTERED  ([ValuationTypeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ValueWeight] ON [dbo].[ReplacementValuation] ([MaximumValue], [PerPound]) ON [PRIMARY]
GO
