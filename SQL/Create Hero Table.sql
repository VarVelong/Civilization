USE Civilization

CREATE TABLE dbo.Hero
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
);