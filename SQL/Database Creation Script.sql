USE [Civilization]
GO
/****** Object:  Table [dbo].[Cell]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cell](
	[X] [int] NOT NULL,
	[Y] [int] NOT NULL,
	[Man] [bit] NULL,
	[SaveId] [int] NOT NULL,
	[CityId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SaveId] ASC,
	[X] ASC,
	[Y] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[City]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](16) NOT NULL,
	[CityHall] [bit] NOT NULL,
	[MagicTower] [bit] NOT NULL,
	[Tavern] [bit] NOT NULL,
	[Market] [bit] NOT NULL,
	[UnknownOne] [bit] NOT NULL,
	[UnknownTwo] [bit] NOT NULL,
	[BarracksOne] [bit] NOT NULL,
	[BarracksTwo] [bit] NOT NULL,
	[BarracksThree] [bit] NOT NULL,
	[BarracksFour] [bit] NOT NULL,
	[BarracksFive] [bit] NOT NULL,
	[BarracksSix] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Save]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Save](
	[Id] [int] NOT NULL,
	[SavedOn] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((1)) FOR [CityHall]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [MagicTower]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [Tavern]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [Market]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [UnknownOne]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [UnknownTwo]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [BarracksOne]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [BarracksTwo]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [BarracksThree]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [BarracksFour]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [BarracksFive]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((0)) FOR [BarracksSix]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD FOREIGN KEY([SaveId])
REFERENCES [dbo].[Save] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[prCellDelete]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellDelete]

@X int,
@Y int
as

BEGIN TRAN
	Delete FROM dbo.Cell
	WHERE X = @X AND Y = @Y;

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellInsert]

@X int,
@Y int,
@Man bit,
@SaveId int,
@CityName nvarchar(32) = NULL
as

BEGIN TRAN
	IF(@CityName IS NOT NULL)
	BEGIN
		INSERT INTO dbo.City(Name)
		VALUES (@CityName);

		DECLARE @CityId INT = SCOPE_IDENTITY()

		INSERT INTO dbo.Cell (X, Y, Man, SaveId, CityId)
		VALUES (@X, @Y, @Man, @SaveId, @CityId);
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Cell (X, Y, Man, SaveId)
		VALUES (@X, @Y, @Man, @SaveId);
	END

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[prCellSelect]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellSelect]
@SaveId int
as

BEGIN TRAN
	SELECT ce.X,  ce.Y, ce.Man, ci.Name AS CityName
	FROM dbo.Cell ce
	LEFT JOIN dbo.City ci ON ce.CityId = ci.Id
	WHERE SaveId = 1;


COMMIT
GO
/****** Object:  StoredProcedure [dbo].[prCellUpdate]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCellUpdate]

@X int,
@Y int,
@Man bit,
@SaveId int,
@CityId int,
@CityName nvarchar(32) = NULL
as

BEGIN TRAN

	IF(@CityId IS NOT NULL) --City existed and exists
	BEGIN
		UPDATE dbo.City
		SET [Name] = @CityName
		WHERE Id = @CityId;
	END
	ELSE IF (@CityName IS NOT NULL) --City did not exist
	BEGIN
		INSERT INTO dbo.City(Name)
		VALUES (@CityName);

		SET @CityId = SCOPE_IDENTITY();
	END
	ELSE --City was removed
	BEGIN
		DECLARE @OldCityId int;
		SELECT @OldCityId = CityId FROM dbo.Cell WHERE SaveId = @SaveId AND X = @X AND Y = @Y;

		DELETE FROM dbo.City
		WHERE Id = @OldCityId;
	END

	UPDATE dbo.Cell 
	SET Man = @Man
	WHERE X = @X AND Y = @Y AND SaveId = @SaveId

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[prCityUpdate]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prCityUpdate]

@Id int,
@CityHall bit = 0, 
@MagicTower bit = 0,
@Tavern bit = 0,
@Market bit = 0,
@UnknownOne bit = 0,
@UnknownTwo bit = 0,
@BarracksOne bit = 0,
@BarracksTwo bit = 0,
@BarracksThree bit = 0,
@BarracksFour bit = 0,
@BarracksFive bit = 0,
@BarracksSix bit = 0
as

BEGIN TRAN

	UPDATE dbo.City 
	SET CityHall = @CityHall,
		MagicTower = @MagicTower,
		Tavern = @Tavern,
		Market = @Market, 
		UnknownOne	= @UnknownOne,
		UnknownTwo	= @UnknownTwo,
		BarracksOne = @BarracksOne,
		BarracksTwo = @BarracksTwo,
		BarracksThree = @BarracksThree,
		BarracksFour = @BarracksFour,
		BarracksFive = @BarracksFive,
		BarracksSix	= @BarracksSix

	WHERE Id = @Id

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[prSaveDelete]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prSaveDelete]

@id int
AS

BEGIN TRAN
	DELETE FROM Civilization.dbo.[Save]
	WHERE id = @id;

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[prSaveInsert]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prSaveInsert]

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
GO
/****** Object:  StoredProcedure [dbo].[prSaveSelect]    Script Date: 26.05.2024 19:55:27 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[prSaveUpdate]    Script Date: 26.05.2024 19:55:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prSaveUpdate]

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
GO
