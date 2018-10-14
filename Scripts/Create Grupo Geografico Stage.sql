USE [VendasDS]
GO
CREATE TABLE [dbo].[D_GrupoGeografico]
(
[Nome] [varchar](50) NOT NULL,
[LinData] [date] NOT NULL,
[LinOrig] [varchar](50) NOT NULL
)
GO
create index IX_D_GrupoGeografico_nome on VendasDS..D_GrupoGeografico (
[Nome])
create index IX_D_GrupoGeografico_nome on VendasDW..D_GrupoGeografico (
[Nome])
GO
CREATE TABLE [dbo].[D_Pais]
(
[Id_GrupoGeo] [int] NOT NULL,
[Sigla] [char](2) NOT NULL,
[LinData] [date] NOT NULL,
[LinOrig] [varchar](50) NOT NULL
)
GO
create index IX_D_PaisIdGrupo on VendasDS..D_Pais ([Id_GrupoGeo])
create index IX_D_PaisSigla on VendasDS..D_Pais ([Sigla])
create index IX_D_PaisSigla on VendasDW..D_Pais ([Sigla])
GO
CREATE TABLE [dbo].[D_RegiaoVendas]
(
[Id_Pais] [int] NOT NULL,
[Nome] [varchar](20) NOT NULL,
[LinData] [date] NOT NULL,
[LinOrig] [varchar](50) NOT NULL
)
GO
create index IX_D_RegiaoIdPais on VendasDS..D_RegiaoVendas ([Id_Pais])
create index IX_D_RegiaoNome on VendasDS..D_RegiaoVendas ([Nome])
create index IX_D_RegiaoNome on VendasDW..D_RegiaoVendas ([Nome])
GO