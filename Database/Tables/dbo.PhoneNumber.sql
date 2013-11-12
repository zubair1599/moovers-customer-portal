CREATE TABLE [dbo].[PhoneNumber]
(
[PhoneNumberID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PhoneNumber_PhoneNumberID] DEFAULT (newid()),
[CountryCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Number] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Extension] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Created] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PhoneNumber] ADD CONSTRAINT [PK_PhoneNumber] PRIMARY KEY CLUSTERED  ([PhoneNumberID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Number] ON [dbo].[PhoneNumber] ([Number]) ON [PRIMARY]
GO
