USE [Civilization]
GO
/****** Object:  StoredProcedure [dbo].[prSaveUpdate]    Script Date: 10.02.2024 23:58:21 ******/
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

COMMIT