USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 16.07.2023 16:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellSelect]
@SaveId int
as

BEGIN TRAN
	SELECT X,  Y, Man
	FROM dbo.Cell
	WHERE SaveId = @SaveId;

COMMIT