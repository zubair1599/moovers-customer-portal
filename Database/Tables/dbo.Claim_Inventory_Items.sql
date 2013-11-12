CREATE TABLE [dbo].[Claim_Inventory_Items]
(
[ClaimInventoryId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Claim_Inventory_Items_ClaimInventoryId] DEFAULT (newid()),
[ClaimID] [uniqueidentifier] NOT NULL,
[ClaimInventoryImage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Created] [datetime] NULL,
[updated] [datetime] NULL,
[ImageOrignalName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileUploadControllerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Claim_Inventory_Items] ADD CONSTRAINT [PK_Claim_Inventory_Items] PRIMARY KEY CLUSTERED  ([ClaimInventoryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Claim_Inventory_Items] ADD CONSTRAINT [FK_Claim_Inventory_Items_Claim] FOREIGN KEY ([ClaimID]) REFERENCES [dbo].[Claim] ([ClaimID]) ON DELETE CASCADE
GO
