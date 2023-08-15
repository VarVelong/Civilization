USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellSelect]    Script Date: 15.08.2023 21:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellSelect]
@SaveId int
as

BEGIN TRAN
	SELECT ce.X,  ce.Y, ce.Man, ci.Id, ci.Name
	FROM dbo.Cell ce
	LEFT JOIN dbo.City ci ON ce.CityId = ci.Id
	WHERE SaveId = @SaveId;


COMMIT