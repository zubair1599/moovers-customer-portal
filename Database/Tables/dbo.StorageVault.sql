CREATE TABLE [dbo].[StorageVault]
(
[StorageVaultID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageVault_StorageVaultID] DEFAULT (newid()),
[Lookup] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsRemoved] [bit] NOT NULL CONSTRAINT [DF_StorageVault_IsRemoved] DEFAULT ((0))
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[SetVaultLookup] 
   ON  [dbo].[StorageVault]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	INSERT INTO dbo.StorageVault([StorageVaultID]
      ,IsRemoved
      ,[Lookup]
	)
	SELECT [StorageVaultID]
      ,IsRemoved
	  ,(SELECT ISNULL(CAST(MAX(CAST(Lookup AS INT)) + 1 AS VARCHAR(10)), '1') FROM dbo.StorageVault)
	FROM inserted
END
GO
ALTER TABLE [dbo].[StorageVault] ADD CONSTRAINT [PK_StorageVault] PRIMARY KEY CLUSTERED  ([StorageVaultID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Lookup] ON [dbo].[StorageVault] ([Lookup]) ON [PRIMARY]
GO
