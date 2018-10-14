USE VendasDS
GO
CREATE PROCEDURE dbo.Carregar_D_Data AS 

BEGIN TRY 
-- Apaga os dados da D_Data no Stage:

TRUNCATE TABLE VendasDS..D_Data

-- Insere os dados da D_Data no Stage:
INSERT INTO dbo.D_Data 
SELECT DISTINCT Cast(DataVenda AS date) AS Data,
right('00' + cast(Day(DataVenda) AS varchar(2)),2) AS Dia,
right('00' + cast(Month(DataVenda)as varchar(2)),2) as Mes,
Year(DataVenda) as Ano 
from VendasDS..TbImp_Vendas

--Carrega dados no DW:

insert into VendasDW..D_Data
select ds.data,ds.dia,ds.Mes,ds.Ano from VendasDS..D_Data as ds left join VendasDW..D_Data as dw on ds.Data = dw.Data 
where dw.Data is null

--Faz o log do processo:

insert into dbo.Adm_Log values (NEWID(), GETDATE(), 'Importa Data','S','Carga de Data com Sucesso')

end try
begin catch 
-- Faz o Log do processo: 
insert into dbo.Adm_Log values (NEWID(), GETDATE(), 'Importa Data','F','Erro ao Carregar  D_Data.')
end catch
