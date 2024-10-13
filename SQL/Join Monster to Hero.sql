USE [Civilization]
GO

SELECT * FROM dbo.Monster m

  INNER JOIN Hero h ON m.HeroName = h.[Name];

GO


