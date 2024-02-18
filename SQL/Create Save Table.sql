USE [master]
GO
/****** Object:  Database [Civilization]    Script Date: 18.02.2024 23:54:15 ******/
CREATE DATABASE [Civilization]
GO
ALTER DATABASE [Civilization] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Civilization].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Civilization] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Civilization] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Civilization] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Civilization] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Civilization] SET ARITHABORT OFF 
GO
ALTER DATABASE [Civilization] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Civilization] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Civilization] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Civilization] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Civilization] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Civilization] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Civilization] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Civilization] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Civilization] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Civilization] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Civilization] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Civilization] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Civilization] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Civilization] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Civilization] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Civilization] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Civilization] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Civilization] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Civilization] SET  MULTI_USER 
GO
ALTER DATABASE [Civilization] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Civilization] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Civilization] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Civilization] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Civilization] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Civilization] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Civilization] SET QUERY_STORE = OFF
GO
USE [Civilization]
GO
/****** Object:  Table [dbo].[Cell]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  Table [dbo].[City]    Script Date: 18.02.2024 23:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](16) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Save]    Script Date: 18.02.2024 23:54:15 ******/
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
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD FOREIGN KEY([SaveId])
REFERENCES [dbo].[Save] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[prCellDelete]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prCellInsert]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prCellSelect]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prCellUpdate]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prSaveDelete]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prSaveInsert]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prSaveSelect]    Script Date: 18.02.2024 23:54:15 ******/
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
/****** Object:  StoredProcedure [dbo].[prSaveUpdate]    Script Date: 18.02.2024 23:54:15 ******/
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
USE [master]
GO
ALTER DATABASE [Civilization] SET  READ_WRITE 
GO
