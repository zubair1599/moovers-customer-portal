CREATE TABLE [dbo].[PasswordReset]
(
[ResetID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PasswordReset_ResetID] DEFAULT (newid()),
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ResetKey] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateRequested] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PasswordReset] ADD CONSTRAINT [PK_PasswordReset] PRIMARY KEY CLUSTERED  ([ResetID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ResetKey] ON [dbo].[PasswordReset] ([ResetKey]) ON [PRIMARY]
GO
