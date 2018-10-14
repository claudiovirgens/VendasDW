use VendasDS
GO

create table dbo.D_Cliente(
Cod_Cliente varchar(10) not null,
Nome varchar(50) not null,
Email varchar(50) not null, 
LinData date not null,
LinOrig varchar(50) not null
)
GO
create index IX_Cod_Cliente on VendasDS..D_Cliente(Cod_Cliente)
GO
create index IX_Cod_Cliente on VendasDW..D_Cliente(Cod_Cliente)


