USE [Civilization]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prSaveSelect]
as

BEGIN TRAN
	SELECT Id, SavedOn
	FROM dbo.[Save];

COMMIT