CREATE TABLE [dbo].[aspnet_Applications]
(
[ApplicationName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LoweredApplicationName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ApplicationId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Ap__Appli__2F10007B] DEFAULT (newid()),
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD CONSTRAINT [PK__aspnet_A__C93A4C980519C6AF] PRIMARY KEY NONCLUSTERED  ([ApplicationId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD CONSTRAINT [UQ__aspnet_A__30910331023D5A04] UNIQUE NONCLUSTERED  ([ApplicationName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD CONSTRAINT [UQ__aspnet_A__17477DE47F60ED59] UNIQUE NONCLUSTERED  ([LoweredApplicationName]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index] ON [dbo].[aspnet_Applications] ([LoweredApplicationName]) ON [PRIMARY]
GO
