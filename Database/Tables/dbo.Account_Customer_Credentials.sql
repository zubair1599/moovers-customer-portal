CREATE TABLE [dbo].[Account_Customer_Credentials]
(
[CustomerID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Account_Customer_Credentials_CustomerID] DEFAULT (newid()),
[UserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [uniqueidentifier] NOT NULL,
[AccountId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_Customer_Credentials] ADD CONSTRAINT [PK_Account_Customer_Credentials] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_Customer_Credentials] ADD CONSTRAINT [FK_Account_Customer_Credentials_Account] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Account_Customer_Credentials] ADD CONSTRAINT [FK_Account_Customer_Credentials_Account_Customer_Credentials] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
