CREATE TABLE [dbo].[Employee_File_Rel]
(
[Employee_File_Rel] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Employee_File_Rel_Employee_File_Rel] DEFAULT (newid()),
[FileID] [uniqueidentifier] NOT NULL,
[EmployeeID] [uniqueidentifier] NOT NULL,
[Type] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee_File_Rel] ADD CONSTRAINT [PK_Employee_File_Rel] PRIMARY KEY CLUSTERED  ([Employee_File_Rel]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee_File_Rel] ADD CONSTRAINT [FK_Employee_File_Rel_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employee_File_Rel] ADD CONSTRAINT [FK_Employee_File_Rel_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
