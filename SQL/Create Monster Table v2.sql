USE [Civilization]
GO

/****** Object:  Table [dbo].[Monster]    Script Date: 11.10.2024 17:50:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Monster](
	[Name] [nvarchar](16) NOT NULL,
	[Base Damage] [int] NOT NULL,
	[Base Defense] [int] NOT NULL,
	[Health] [int] NOT NULL,
	[HeroName] [nvarchar](16) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Monster]  WITH CHECK ADD FOREIGN KEY([HeroName])
REFERENCES [dbo].[Hero] ([Name])
GO


