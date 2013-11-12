CREATE TABLE [dbo].[Claim]
(
[ClaimID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Claim_ClaimID_1] DEFAULT (newid()),
[Inventroy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ClaimType] [int] NOT NULL,
[Remarks] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaseID] [uniqueidentifier] NOT NULL,
[Created] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Claim] ADD CONSTRAINT [PK_Claim] PRIMARY KEY CLUSTERED  ([ClaimID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Claim] ADD CONSTRAINT [FK_Claim_Case] FOREIGN KEY ([CaseID]) REFERENCES [dbo].[Case] ([CaseID])
GO
