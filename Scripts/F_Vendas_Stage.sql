USE [VendasDS]
GO
CREATE TABLE [dbo].[F_Venda](
	[Data] [date] NOT NULL,
	[Nr_NF] [varchar](10) NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Id_Funcionario] [int] NOT NULL,
	[Id_RegiaoVendas] [int] NOT NULL,
	[Vlr_Imposto] [decimal](18, 2) NOT NULL,
	[Vlr_Frete] [decimal](18, 2) NOT NULL,
	[LinData] [date] NOT NULL,
	[LinOrig] [varchar](50) NOT NULL,
 CONSTRAINT [PK_F_Venda] PRIMARY KEY CLUSTERED 
		(
		[Data] ASC,
		[Nr_NF] ASC,
		[Id_Cliente] ASC,
		[Id_Funcionario] ASC,
		[Id_RegiaoVendas] ASC
		)
)