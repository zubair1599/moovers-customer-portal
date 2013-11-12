CREATE TABLE [dbo].[Franchise]
(
[FranchiseID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Franchise_FranchiseID] DEFAULT (newid()),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AddressID] [uniqueidentifier] NOT NULL,
[PaymentGatewayID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PaymentPassword] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PhoneNumber] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FranchiseEmail] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasStorage] [bit] NOT NULL CONSTRAINT [DF_Franchise_HasStorage] DEFAULT ((0)),
[Icon] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Franchise] ADD CONSTRAINT [PK_Franchise] PRIMARY KEY CLUSTERED  ([FranchiseID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Franchise] ADD CONSTRAINT [FK_Franchise_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID])
GO
