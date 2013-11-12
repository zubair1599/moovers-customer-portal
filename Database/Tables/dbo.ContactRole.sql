CREATE TABLE [dbo].[ContactRole]
(
[RoleID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ContactRole_RoleID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sort] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactRole] ADD CONSTRAINT [PK_ContactRole] PRIMARY KEY CLUSTERED  ([RoleID]) ON [PRIMARY]
GO
