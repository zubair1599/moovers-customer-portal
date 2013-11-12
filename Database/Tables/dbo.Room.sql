CREATE TABLE [dbo].[Room]
(
[RoomID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Room_RoomID] DEFAULT (newid()),
[StopID] [uniqueidentifier] NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Sort] [int] NOT NULL,
[Pack] [bit] NOT NULL CONSTRAINT [DF_Room_Pack] DEFAULT ((0)),
[IsUnassigned] [bit] NOT NULL CONSTRAINT [DF_Room_IsUnassigned] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room] ADD CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED  ([RoomID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stop] ON [dbo].[Room] ([StopID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room] ADD CONSTRAINT [FK_Room_Stop] FOREIGN KEY ([StopID]) REFERENCES [dbo].[Stop] ([StopID])
GO
