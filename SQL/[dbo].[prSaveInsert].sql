USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prSaveInsert]    Script Date: 16.02.2024 18:48:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[prSaveInsert]

@Id int,
@SavedOn datetime2
as

BEGIN TRAN
	INSERT INTO Civilization.dbo.[save] (Id, SavedOn)
	VALUES (@Id, @SavedOn);

	SELECT Id, SavedOn
	FROM Civilization.dbo.[save]
	WHERE Id = @Id;
COMMIT