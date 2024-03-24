USE [Civilization]
GO

ALTER TABLE [dbo].[City]
	ADD CityHall bit NOT NULL DEFAULT (1),
		MagicTower bit NOT NULL DEFAULT (0),
		Tavern bit NOT NULL DEFAULT (0),
		Market bit NOT NULL DEFAULT (0),
		UnknownOne bit NOT NULL DEFAULT (0),
		UnknownTwo bit NOT NULL DEFAULT (0),
		BarracksOne bit NOT NULL DEFAULT (0),
		BarracksTwo bit NOT NULL DEFAULT (0),
		BarracksThree bit NOT NULL DEFAULT (0),
		BarracksFour bit NOT NULL DEFAULT (0),
		BarracksFive bit NOT NULL DEFAULT (0),
		BarracksSix bit NOT NULL DEFAULT (0);


