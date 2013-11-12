CREATE TABLE [dbo].[CachedMapResponse]
(
[ResponseID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CachedMapResponse_ResponseID] DEFAULT (newid()),
[Coordinate1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Coordinate2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[CachedMapResponse] ADD CONSTRAINT [PK_CachedMapResponse] PRIMARY KEY CLUSTERED  ([ResponseID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Coordinates] ON [dbo].[CachedMapResponse] ([Coordinate1], [Coordinate2]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [C1C2incResponse] ON [dbo].[CachedMapResponse] ([Coordinate1], [Coordinate2]) INCLUDE ([Response], [ResponseID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_CachedMapResponse_9_1908201848__K3_K2_K5D_1_4] ON [dbo].[CachedMapResponse] ([Coordinate2], [Coordinate1], [Date] DESC) INCLUDE ([Response], [ResponseID]) ON [PRIMARY]
GO
