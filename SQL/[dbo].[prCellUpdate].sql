USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellUpdate]    Script Date: 11.02.2024 20:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellUpdate]

@X int,
@Y int,
@Man bit,
@SaveId int,
@CityId int,
@CityName nvarchar(32) = NULL
as

BEGIN TRAN

	IF(@CityId IS NOT NULL) --City existed and exists
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
	ELSE --City was removed
	BEGIN
		DECLARE @OldCityId int;
		SELECT @OldCityId = CityId FROM dbo.Cell WHERE SaveId = @SaveId AND X = @X AND Y = @Y;

		DELETE FROM dbo.City
		WHERE Id = @OldCityId;
	END

	UPDATE dbo.Cell 
	SET Man = @Man
	WHERE X = @X AND Y = @Y AND SaveId = @SaveId

COMMIT