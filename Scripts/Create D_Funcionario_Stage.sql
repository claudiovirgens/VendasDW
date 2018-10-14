USE [VendasDS]
GO
CREATE TABLE [dbo].[D_Funcionario](
[Nome] [varchar](50) NOT NULL,
[Login] [varchar](50) NOT NULL,
[Id_Chefe] [int] NULL,
[LinData] [date] NOT NULL,
[LinOrig] [varchar](50) NOT NULL
)
create index IX_FuncionarioLogin on [VendasDS]..[D_Funcionario]([Login]
)
create index IX_FuncionarioLogin on [VendasDW]..[D_Funcionario]([Login])