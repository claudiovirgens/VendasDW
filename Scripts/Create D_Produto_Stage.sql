USE [VendasDS]
GO
CREATE TABLE [dbo].[D_Produto](
[Cod_Produto] [varchar](20) NOT NULL,
[Nome] [varchar](50) NOT NULL,
[Tamanho] [varchar](5) NOT NULL,
[Cor] [varchar](20) NOT NULL,
[Ativo] [char](1) NOT NULL,
[LinData] [date] NOT NULL,
[LinOrig] [varchar](50) NOT NULL
)
GO
create index IX_ProdutoNM on VendasDS..D_Produto (nome)
create index IX_ProdutoNM on VendasDW..D_Produto (nome)
create index IX_ProdutoCod on VendasDS..D_Produto (Cod_Produto)
create index IX_ProdutoCod on VendasDW..D_Produto (Cod_Produto)