
USE VendasDS
GO

CREATE TABLE dbo.D_Data (
Data date PRIMARY KEY NOT NULL, 
Dia char(2) NOT NULL, 
Mes char(2) NOT NULL,
Ano char(4) NOT NULL 
)