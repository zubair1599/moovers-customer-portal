CREATE TABLE [dbo].[StorageComment]
(
[StorageCommentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StorageComment_StorageCommentID] DEFAULT (newid()),
[WorkOrderID] [uniqueidentifier] NOT NULL,
[Date] [datetime] NOT NULL,
[UserID] [uniqueidentifier] NOT NULL,
[Text] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageComment] ADD CONSTRAINT [PK_StorageComment] PRIMARY KEY CLUSTERED  ([StorageCommentID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StorageComment] ADD CONSTRAINT [FK_StorageComment_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[StorageComment] ADD CONSTRAINT [FK_StorageComment_StorageWorkOrder] FOREIGN KEY ([WorkOrderID]) REFERENCES [dbo].[StorageWorkOrder] ([WorkOrderID])
GO
