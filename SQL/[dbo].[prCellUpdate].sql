USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellUpdate]    Script Date: 02.06.2024 15:41:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellUpdate]

@X int,
@Y int,
@Man bit = NULL,
@SaveId int,
@CityId int = NULL,
@CityName nvarchar(32) = NULL
as

BEGIN TRAN
	DECLARE @OldCityId int;
	SELECT @OldCityId = CityId FROM dbo.Cell WHERE SaveId = @SaveId AND X = @X AND Y = @Y;

	IF(@CityId IS NOT NULL AND @OldCityId IS NOT NULL) --City existed and exists
	BEGIN
		UPDATE dbo.City
		SET [Name] = @CityName
		WHERE Id = @CityId;
	END

	ELSE IF (@CityName IS NOT NULL) --City did not exist
	BEGIN
		INSERT INTO dbo.City(Name)
		VALUES (@CityName);
		SET @CityId = SCOPE_IDENTITY();
	END

	UPDATE dbo.Cell 
	SET Man = @Man, CityId = @CityId
	WHERE X = @X AND Y = @Y AND SaveId = @SaveId

	IF (@OldCityId IS NOT NULL AND @CityId IS NULL AND s EXISTS(SELECT CityId FROM Cell WHERE CityId = @OldCityId AND SaveId != @SaveId)) --City was removed
	BEGIN
		DELETE FROM dbo.City
		WHERE Id = @OldCityId;
	END

COMMIT
