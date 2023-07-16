USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellDelete]    Script Date: 16.07.2023 16:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellDelete]

@X int,
@Y int
as

BEGIN TRAN
	Delete FROM Civilization.dbo.Cell
	WHERE X = @X AND Y = @Y;

COMMIT