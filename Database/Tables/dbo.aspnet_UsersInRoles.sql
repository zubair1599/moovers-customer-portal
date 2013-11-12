CREATE TABLE [dbo].[aspnet_UsersInRoles]
(
[UserId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] ADD CONSTRAINT [PK__aspnet_U__AF2760AD276EDEB3] PRIMARY KEY CLUSTERED  ([UserId], [RoleId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index] ON [dbo].[aspnet_UsersInRoles] ([RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] ADD CONSTRAINT [FK__aspnet_Us__RoleI__412EB0B6] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] ADD CONSTRAINT [FK__aspnet_Us__UserI__403A8C7D] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
