CREATE TABLE [dbo].[Errors]
(
[ErrorLogID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Errors_ErrorLogID] DEFAULT (newid()),
[Message] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StackTrace] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ServerVariables] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[URL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Created] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Errors] ADD CONSTRAINT [PK_Errors] PRIMARY KEY CLUSTERED  ([ErrorLogID]) ON [PRIMARY]
GO
