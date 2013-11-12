CREATE TABLE [dbo].[Employee_aspnet_User_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Employee_aspnet_User_Rel_RelID] DEFAULT (newid()),
[aspnet_UserID] [uniqueidentifier] NOT NULL,
[EmployeeID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee_aspnet_User_Rel] ADD CONSTRAINT [PK_Employee_aspnet_User_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UserID] ON [dbo].[Employee_aspnet_User_Rel] ([aspnet_UserID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EmployeeID] ON [dbo].[Employee_aspnet_User_Rel] ([EmployeeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee_aspnet_User_Rel] ADD CONSTRAINT [FK_Employee_aspnet_User_Rel_aspnet_Users] FOREIGN KEY ([aspnet_UserID]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[Employee_aspnet_User_Rel] ADD CONSTRAINT [FK_Employee_aspnet_User_Rel_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
