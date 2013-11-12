CREATE TABLE [dbo].[aspnet_Users_Profile]
(
[AccountManagerID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aspnet_Users_MetaData_AccountManagerID] DEFAULT (newid()),
[UserID] [uniqueidentifier] NOT NULL,
[FirstName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Phone] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Title] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PictureUrl] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShowInSearch] [bit] NOT NULL CONSTRAINT [DF_aspnet_Users_Profile_ShowInSearch] DEFAULT ((0)),
[UserTYpe] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_Users_Profile] ADD CONSTRAINT [PK_aspnet_Users_MetaData] PRIMARY KEY CLUSTERED  ([AccountManagerID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_Users_Profile] ADD CONSTRAINT [FK_aspnet_Users_Profile_aspnet_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
