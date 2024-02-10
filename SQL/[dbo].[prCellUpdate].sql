USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 10.02.2024 23:58:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellUpdate]

@X int,
@Y int,
@Man bit,
@SaveId int,
@CityName nvarchar(32) = NULL
as

BEGIN TRAN
	--IF(@CityName IS NOT NULL)
	--BEGIN
	--	UPDATE dbo.City(Name)
	--	VALUES (@CityName);

	--	DECLARE @CityId INT = SCOPE_IDENTITY()

	--	INSERT INTO dbo.Cell (X, Y, Man, SaveId, CityId)
	--	VALUES (@X, @Y, @Man, @SaveId, @CityId);
	--END
	--ELSE
	--BEGIN
		UPDATE dbo.Cell 
		SET Man = @Man
		WHERE X = @X AND Y = @Y AND SaveId = @SaveId
	--END

COMMIT