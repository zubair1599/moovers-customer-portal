CREATE TABLE [dbo].[Room_Box_Rel]
(
[RelID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Room_Box_Rel_RelID] DEFAULT (newid()),
[RoomID] [uniqueidentifier] NOT NULL,
[BoxTypeID] [uniqueidentifier] NOT NULL,
[Count] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room_Box_Rel] ADD CONSTRAINT [PK_Room_Box_Rel] PRIMARY KEY CLUSTERED  ([RelID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room_Box_Rel] ADD CONSTRAINT [FK_Room_Box_Rel_Box] FOREIGN KEY ([BoxTypeID]) REFERENCES [dbo].[Box] ([BoxTypeID])
GO
ALTER TABLE [dbo].[Room_Box_Rel] ADD CONSTRAINT [FK_Room_Box_Rel_Room] FOREIGN KEY ([RoomID]) REFERENCES [dbo].[Room] ([RoomID])
GO
