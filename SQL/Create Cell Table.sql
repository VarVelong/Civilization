
CREATE DATABASE Civilization

CREATE TABLE Civilization.dbo.Cell(
X int NOT NULL,
Y int NOT NULL,
Man bit NULL,
CONSTRAINT PK_Cell PRIMARY KEY (X,Y))