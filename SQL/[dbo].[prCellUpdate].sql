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
@Man bit
as

BEGIN TRAN
	UPDATE Civilization.dbo.Cell
	SET X = @X, Y = @Y, Man = @Man;

COMMIT