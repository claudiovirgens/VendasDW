USE [VendasDS]
GO

Create procedure [dbo].[Carregar_D_Funcionario]
as

begin try
-- Apaga os dados da D_Funcionario no Stage:
truncate table [VendasDS]..[D_Funcionario]
-- Insere os dados na D_Funcionario no Stage:
insert into [dbo].[D_Funcionario]
([Nome],[Login],[LinData],[LinOrig])
Select Distinct VendedorNome, VendedorLogin, Getdate() as LinData,
'Arquivo de Vendas' as LinOrig 
from [VendasDS]..[TbImp_Vendas]
-- Carrega os dados no DW:
insert into [VendasDW]..[D_Funcionario]
Select
ds.[Nome],
ds.[Login],
ds.[Id_Chefe],
ds.[LinData],
ds.[LinOrig]
from [VendasDS]..[D_Funcionario] as ds left join [VendasDW]..[D_Funcionario] as dw
on ds.[Login] = dw.[Login]
where dw.Id_Funcionario is null
-- Atualiza o Id_Chefe no DW:
declare @Id_funcionario int
declare @LoginFuncionario varchar(50)
declare @NomeFuncionario varchar(50)
declare @NomeChefe varchar(50)
declare @Id_Chefe int

declare cur_AtualizaChefe cursor for
Select Id_Funcionario, Login, Nome from VendasDW..D_Funcionario
Open cur_AtualizaChefe
fetch next from cur_AtualizaChefe into @Id_funcionario, @LoginFuncionario, @NomeFuncionario
while @@FETCH_STATUS = 0
Begin
-- determina o nome do Chefe:
Set @NomeChefe = (Select Distinct VendedorChefeNome
from [VendasDS]..[TbImp_Vendas] as b
where b.VendedorLogin = @LoginFuncionario
)
-- Determina o ID do Chefe:
Set @Id_Chefe = (Select Id_Funcionario
from [VendasDW]..[D_Funcionario]as b
where b.Nome = @NomeChefe
)
-- Determina o ID do Chefe:
If @NomeChefe != @NomeFuncionario -- A pessoa não é o proprio chefe (quem não tem chefe)
Begin
update [VendasDW]..[D_Funcionario]
Set Id_Chefe = @Id_Chefe
where Id_Funcionario = @Id_funcionario
End
fetch next from cur_AtualizaChefe into @Id_funcionario,@LoginFuncionario,@NomeFuncionario
end
close cur_AtualizaChefe
deallocate cur_AtualizaChefe
-- Faz o log do processo:
insert into [dbo].[Adm_Log] values (newid(), getdate(), 'Importa Funcionario','S', 'Carga de D_Funcionario com sucesso.')
end try
begin catch
-- Faz o log do processo:
insert into [dbo].[Adm_Log] values (newid(), getdate(), 'Importa Funcionario','F', 'Erro ao carregar D_Funcionario.')
end catch