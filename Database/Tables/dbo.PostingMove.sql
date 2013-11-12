CREATE TABLE [dbo].[PostingMove]
(
[PostingMove] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PostingMove_PostingMove] DEFAULT (newid()),
[Date] [datetime] NOT NULL,
[Hours] [decimal] (18, 2) NOT NULL,
[Price] [decimal] (18, 2) NOT NULL,
[PostingID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PostingMove] ADD CONSTRAINT [PK_PostingMove] PRIMARY KEY CLUSTERED  ([PostingMove]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PostingMove] ADD CONSTRAINT [FK_PostingMove_Posting] FOREIGN KEY ([PostingID]) REFERENCES [dbo].[Posting] ([PostingID])
GO
