CREATE TABLE [dbo].[EmailAddress]
(
[EmailAddressID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailAddress_EmailAddressID] DEFAULT (newid()),
[Email] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Created] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailAddress] ADD CONSTRAINT [PK_EmailAddress] PRIMARY KEY CLUSTERED  ([EmailAddressID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Email] ON [dbo].[EmailAddress] ([Email]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EmailID] ON [dbo].[EmailAddress] ([EmailAddressID], [Email]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CreatedEmailID] ON [dbo].[EmailAddress] ([EmailAddressID], [Email], [Created]) ON [PRIMARY]
GO
