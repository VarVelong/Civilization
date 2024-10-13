USE [Civilization]
GO

/****** Object:  Table [dbo].[Hero]    Script Date: 11.10.2024 17:49:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Hero](
	[Name] [nvarchar](16) NOT NULL,
	[Base Damage] [int] NOT NULL,
	[Base Defense] [int] NOT NULL,
	[Health] [int] NOT NULL,
	[Mana] [int] NOT NULL,
	[Strength] [int] NOT NULL,
	[Endurance] [int] NOT NULL,
	[Accuracy] [int] NOT NULL,
	[Speed] [int] NOT NULL,
	[Inteligance] [int] NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


