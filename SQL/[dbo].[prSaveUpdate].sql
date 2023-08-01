USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 16.07.2023 16:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prCellUpdate]

@Id int,
@SavedOn datetime2
as

BEGIN TRAN
	UPDATE Civilization.dbo.[Save]
	SET @SavedOn = @SavedOn
	WHERE Id = @Id;

COMMIT