USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellSelect]    Script Date: 02.06.2024 15:36:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellSelect]
@SaveId int
as

BEGIN TRAN
	SELECT ce.X,  ce.Y, ce.Man, ci.Name AS CityName
	FROM dbo.Cell ce
	LEFT JOIN dbo.City ci ON ce.CityId = ci.Id
	WHERE SaveId = @SaveId;


COMMIT
