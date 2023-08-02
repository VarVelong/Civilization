USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prSaveInsert]    Script Date: 02.08.2023 19:49:39 ******/
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