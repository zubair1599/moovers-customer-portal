CREATE TABLE [dbo].[GlobalSetting]
(
[SettingID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_GlobalSetting_SettingID] DEFAULT (newid()),
[Key] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Value] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FranchiseID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GlobalSetting] ADD CONSTRAINT [PK_GlobalSetting] PRIMARY KEY CLUSTERED  ([SettingID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GlobalSetting] ADD CONSTRAINT [FK_GlobalSetting_Franchise] FOREIGN KEY ([FranchiseID]) REFERENCES [dbo].[Franchise] ([FranchiseID])
GO
