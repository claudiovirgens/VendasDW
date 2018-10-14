USE VendasDS
GO

CREATE PROCEDURE dbo.Importar_Vendas AS 
DECLARE @STR AS nvarchar(1000)

-- Apagar os dados da TbImp_Vendas caso existam para uma nova carga;
TRUNCATE TABLE TbImp_Vendas 

-- Renomeioa arquivos existentes para um nome esperado:

SET @STR = 'Move C:\BI\Arquivos\*.rpt C:\BI\Arquivos\MassaDados.rpt'
	EXEC xp_cmdshell @STR 

-- importa os dados do arquivo para o SQL: 
BULK INSERT dbo.TBImp_Vendas FROM 'C:\BI\Arquivos\MassaDados.rpt' WITH 
(FIRSTROW = 3, FIELDTERMINATOR = '|', ROWTERMINATOR = '\n')

-- faz o log do processo.

INSERT INTO dbo.Adm_Log VALUES (NewId(), getDate(),'Importa MassaDados.rpt', 'S', 'Arquivo Importado com sucesso')

-- Copia o arquivo para a posta Historico, renomeando ele com a data de importacao

DECLARE @nomearquivo varchar(50)
SET @nomearquivo = (SELECT cast (year(GETDATE()) AS char(4)) + right('00' + cast(month(getdate()) as varchar(2)),2) + right('00'+ cast(day(getDate()) as varchar(2)),2) + '_Vendas.rpt')

SET @STR = 'Move C:\BI\Arquivos\MassaDados.rpt C:\BI\Historico\' + @nomearquivo

EXEC xp_cmdshell @STR 