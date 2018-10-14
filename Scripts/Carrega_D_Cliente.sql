use VendasDS
GO


Create procedure dbo.Carregar_D_Cliente as

begin try 
-- Apaga os dados da D_Cliente no Stage:
truncate table VendasDS..D_Cliente

--Insere os dados na tabela D_Cliente no Stage:
insert into dbo.D_Cliente
select Distinct 
CodCliente as Cod_Cliente,
NomeCliente as Nome,
EmailCliente as Email,
GetDate() as LinData,
'Arquivo de Vendas' as LinOrg
from VendasDS..TbImp_Vendas


--Carrega os dados no DW:

insert into VendasDW..D_Cliente
select
ds.Cod_Cliente,
ds.Nome, 
ds.Email,
ds.LinData, ds.LinOrig
from VendasDS..D_Cliente as ds left join VendasDW..D_Cliente as dw
on ds.Cod_Cliente = dw.Cod_Cliente where dw.Id_Cliente is null

--Faz o log do processo:

insert into dbo.Adm_Log values (NEWID(), GETDATE(), 'Importar Cliente','S','Carga de Cliente com Sucesso')

end try
begin catch 
-- Faz o Log do processo: 
insert into dbo.Adm_Log values (NEWID(), GETDATE(), 'Importar Cliente','F','Erro ao Carregar  D_Cliente.')
end catch
