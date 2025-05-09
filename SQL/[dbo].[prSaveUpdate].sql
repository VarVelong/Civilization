USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prSaveUpdate]    Script Date: 16.02.2024 18:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prSaveUpdate]

@Id int,
@SavedOn datetime2
as

BEGIN TRAN
	UPDATE Civilization.dbo.[Save]
	SET @SavedOn = @SavedOn
	WHERE Id = @Id;

	SELECT Id, SavedOn
	FROM Civilization.dbo.[save]
	WHERE Id = @Id;
COMMIT