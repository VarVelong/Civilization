USE Civilization

CREATE TABLE dbo.Monster
(	[Name] [nvarchar](16) NOT NULL PRIMARY KEY,
	[Base Damage] [int] NOT NULL,
	[Base Defense] [int] NOT NULL,
	[Health] [int] NOT NULL,
	[Mana] [int] NOT NULL,
	[Strength] [int] NOT NULL,
	[Endurance] [int] NOT NULL,
	[Accuracy] [int] NOT NULL,
	[Speed] [int] NOT NULL,
	[Inteligance] [int] NOT NULL,
	[HeroName] [nvarchar](16) NOT NULL
);

ALTER TABLE [dbo].[Monster]  WITH CHECK ADD FOREIGN KEY([HeroName])
REFERENCES [dbo].[Hero] ([Name])

