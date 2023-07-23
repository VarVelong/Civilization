USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 16.07.2023 16:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellUpdate]

@X int,
@Y int,
@Man bit,
@SaveId int
as

BEGIN TRAN
	UPDATE Civilization.dbo.Cell
	SET Man = @Man
	WHERE SaveId = @SaveId AND X = @X AND Y = @Y;

COMMIT