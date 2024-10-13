USE [Civilization]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[prHeroSelect]
as

BEGIN TRAN
	SELECT [Name], [Base Damage], [Base Defense], [Health], [Mana], [Strength], [Endurance], [Accuracy], [Speed], [Inteligance], [Type]
	FROM dbo.[Hero];

COMMIT