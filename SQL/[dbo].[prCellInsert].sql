USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 23.07.2023 17:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellInsert]

@X int,
@Y int,
@Man bit,
@SaveId int,
@CityName nvarchar(32) = NULL
as

BEGIN TRAN
	IF(@CityName IS NOT NULL)
	BEGIN
		INSERT INTO dbo.City(Name)
		VALUES (@CityName);

		DECLARE @CityId INT = SCOPE_IDENTITY()

		INSERT INTO dbo.Cell (X, Y, Man, SaveId, CityId)
		VALUES (@X, @Y, @Man, @SaveId, @CityId);
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Cell (X, Y, Man, SaveId)
		VALUES (@X, @Y, @Man, @SaveId);
	END

COMMIT