USE [VendasDS]
GO
Create procedure [dbo].[Carrega_D_Geografia]
as
begin try
-- Apaga os dados das tabelas no Stage:
truncate table [VendasDS]..[D_GrupoGeografico]
truncate table [VendasDS]..[D_Pais]
truncate table [VendasDS]..[D_RegiaoVendas]

--------------------
-- Insere os dados na D_GrupoGeografico no Stage:
insert into [dbo].[D_GrupoGeografico]
Select Distinct GrupoGeografico,
Getdate() as [LinData],
'Arquivo de Vendas' as [LinOrig]
from [VendasDS]..[TbImp_Vendas]
-- Carrega os dados no DW:
insert into [VendasDW]..[D_GrupoGeografico]
Select Distinct
ds.Nome,
ds.LinData,
ds.LinOrig
from [VendasDS]..[D_GrupoGeografico] as ds left join VendasDW..D_GrupoGeografico as dw
on ds.[Nome] =dw.[Nome]
Where dw.[Id_GrupoGeo] is null
--------------------
-- Insere os dados na D_Pais do Stage:
insert into [dbo].[D_Pais]
Select Distinct
dw.Id_GrupoGeo,
ds.Pais,
Getdate() as [LinData],
'Arquivo de Vendas' as [LinOrig]
from [VendasDS]..[TbImp_Vendas] as ds inner join VendasDW..[D_GrupoGeografico] as dw
on ds.GrupoGeografico = dw.Nome
-- Carrega os dados no DW:
insert into [VendasDW]..[D_Pais]
select
ds.[Id_GrupoGeo],
ds.[Sigla],
ds.[LinData],
ds.[LinOrig]
from [VendasDS]..[D_Pais] as ds left join [VendasDW]..[D_Pais] as dw
on ds.Id_GrupoGeo = dw.Id_GrupoGeo
and ds.Sigla = dw.Sigla
Where dw.Id_Pais is null
-------------------------------------------------------------
-- Insere os dados na D_RegiaoVendas do Stage:
insert into [dbo].[D_RegiaoVendas]
select Distinct
dw.Id_Pais,
ds.RegiaoVendas,
Getdate() as [LinData],
'Arquivo de Vendas' as [LinOrig]
from [VendasDS]..[TbImp_Vendas] as ds inner join [VendasDW]..[D_Pais] as
dw
on ds.Pais = dw.[Sigla]
-- Carrega os dados no DW
insert into [VendasDW]..[D_RegiaoVendas]
Select ds.[Id_Pais],
ds.[Nome],ds.[LinData],
ds.[LinOrig]
from [VendasDS]..[D_RegiaoVendas] as ds left join [VendasDW]..[D_RegiaoVendas] as dw
on ds.Id_Pais = dw.Id_Pais
and ds.Nome = dw.Nome
where dw.Id_RegiaoVendas is null

-- Faz o log do processo:
insert into [dbo].[Adm_Log] values (newid(), getdate(), '
Importa Geografia','S', 'Carga das tabelas de Geografia com suces
so.')
end try
begin catch
-- Faz o log do processo:
insert into [dbo].[Adm_Log] values (newid(), getdate(), 'Impo
rta Geografia','F', 'Erro ao carregar tabelas de Geografia.')
end catch