USE VendasDS
GO

CREATE TABLE dbo.TbImp_Vendas (
NrNf varchar  (50) null,
DataVenda varchar (50) null,
CodCliente varchar(50) null,
NomeCliente varchar(50) null,
EmailCliente varchar(50) null,
RegiaoVendas varchar(50) null,
Pais varchar(50) null,
GrupoGeografico varchar(50) null,
VendedorLogin varchar(50) null,
VendedorNome varchar(50) null,
VendedorChefeNome varchar(50) null,
Cod_Produto varchar(50) null,
Produto varchar(50) null,
Tamanho varchar(50) null,
Linha varchar(50) null,
Cor varchar(50) null,
SubTotal varchar(50) null,
ImpTotal varchar(50) null,
Frete varchar(50) null,
PrecoUnitario varchar(50) null,
Qtd varchar(50) NULL
) on [Primary]