CREATE TABLE [dbo].[Posting_Employee_Rel]
(
[RelationshipID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Posting_Employee_Rel_RelationshipID] DEFAULT (newid()),
[PostingID] [uniqueidentifier] NOT NULL,
[EmployeeID] [uniqueidentifier] NOT NULL,
[Hours] [decimal] (18, 2) NOT NULL,
[Commission] [decimal] (18, 2) NOT NULL,
[Bonus] [decimal] (18, 2) NOT NULL,
[Tip] [decimal] (18, 2) NOT NULL,
[Wage] [decimal] (18, 2) NOT NULL,
[IsRemoved] [bit] NOT NULL,
[IsDriver] [bit] NOT NULL CONSTRAINT [DF_Posting_Employee_Rel_IsDriver] DEFAULT ((0)),
[ForceNoDriver] [bit] NOT NULL CONSTRAINT [DF_Posting_Employee_Rel_ForceNoDriver] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Posting_Employee_Rel] ADD CONSTRAINT [PK_Posting_Employee_Rel] PRIMARY KEY CLUSTERED  ([RelationshipID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EmployeeID] ON [dbo].[Posting_Employee_Rel] ([EmployeeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_Employee_Rel_8_859150106__K3_K9_K2_1_4_5_6_7_8_10_11] ON [dbo].[Posting_Employee_Rel] ([EmployeeID], [IsRemoved], [PostingID]) INCLUDE ([Bonus], [Commission], [ForceNoDriver], [Hours], [IsDriver], [RelationshipID], [Tip], [Wage]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IsRemoved] ON [dbo].[Posting_Employee_Rel] ([IsRemoved]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_Employee_Rel_8_859150106__K9_K2_7] ON [dbo].[Posting_Employee_Rel] ([IsRemoved], [PostingID]) INCLUDE ([Tip]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PostingID] ON [dbo].[Posting_Employee_Rel] ([PostingID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_Employee_Rel_8_859150106__K2_K5] ON [dbo].[Posting_Employee_Rel] ([PostingID], [Commission]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EmployeePosting] ON [dbo].[Posting_Employee_Rel] ([PostingID], [EmployeeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PostingIDEmployeeID] ON [dbo].[Posting_Employee_Rel] ([PostingID], [EmployeeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_Posting_Employee_Rel_8_859150106__K2_K1_K9_7] ON [dbo].[Posting_Employee_Rel] ([PostingID], [RelationshipID], [IsRemoved]) INCLUDE ([Tip]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Posting_Employee_Rel] ADD CONSTRAINT [FK_Posting_Employee_Rel_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Posting_Employee_Rel] ADD CONSTRAINT [FK_Posting_Employee_Rel_Posting] FOREIGN KEY ([PostingID]) REFERENCES [dbo].[Posting] ([PostingID])
GO
