CREATE TABLE [dbo].[Posting_Vehicle_Rel]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Posting_Vehicle_Rel_RelationshipID] DEFAULT (newid()),
[PostingID] [uniqueidentifier] NOT NULL,
[VehicleID] [uniqueidentifier] NOT NULL,
[IsRemoved] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Posting_Vehicle_Rel] ADD CONSTRAINT [PK_Posting_Vehicle_Rel] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IsRemoved] ON [dbo].[Posting_Vehicle_Rel] ([IsRemoved]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Posting] ON [dbo].[Posting_Vehicle_Rel] ([PostingID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PostingIDVehicleID] ON [dbo].[Posting_Vehicle_Rel] ([PostingID], [VehicleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [VehicleID] ON [dbo].[Posting_Vehicle_Rel] ([VehicleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Posting_Vehicle_Rel] ADD CONSTRAINT [FK_Posting_Vehicle_Rel_Posting] FOREIGN KEY ([PostingID]) REFERENCES [dbo].[Posting] ([PostingID])
GO
ALTER TABLE [dbo].[Posting_Vehicle_Rel] ADD CONSTRAINT [FK_Posting_Vehicle_Rel_Vehicle] FOREIGN KEY ([VehicleID]) REFERENCES [dbo].[Vehicle] ([VehicleID])
GO
