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
@SaveId int
as

BEGIN TRAN
	INSERT INTO Civilization.dbo.Cell (X, Y, Man, SaveId)
	VALUES (@X, @Y, @Man, @SaveId);

COMMIT