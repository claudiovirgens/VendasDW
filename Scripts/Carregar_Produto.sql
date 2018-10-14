USE [VendasDS]
GO

Create procedure [dbo].[Carregar_D_Produto]
as

begin try
	-- Apaga os dados da D_Produto no Stage:
	truncate table [VendasDS]..[D_Produto]

	-- Insere os dados na D_Produto no Stage:
	insert into [dbo].[D_Produto]
	Select Distinct 
	Cod_Produto	 as [Cod_Produto],
	Produto		 as [Nome],
	Tamanho		 as [Tamanho],
	Cor			 as [Cor],
	Ativo		= 1,
	Getdate() as [LinData],
	'Arquivo de Vendas' as [LinOrig]
	from [VendasDS]..[TbImp_Vendas]

	-- Carrega os dados no DW com os novos produtos (novo COD_PRODUTO):
	insert into VendasDW..D_Produto
	Select 
	ds.Cod_Produto,
	ds.Nome,
	ds.Tamanho,
	ds.Cor,
	ds.Ativo,
	ds.LinData,
	ds.LinOrig
	from [VendasDS]..[D_Produto] as ds left join [VendasDW]..[D_Produto] as dw
	on ds.Cod_Produto = dw.Cod_Produto
	where dw.Cod_Produto is null

	-- Atualiza os Produtos que vieram com nome diferente (mas que possuem o mesmo COD_PRODUTO):
	declare @CodProduto varchar(20)
	declare @NomeProduto varchar(50)
	declare @Tamanho varchar(5)
	declare @Cor varchar(20)
	declare @LinData date
	declare @LinOrigem Varchar(50)
	declare cur_AtualizaProduto cursor for
		Select ds.Cod_Produto, ds.Nome, ds.tamanho, ds.cor, ds.LinData, ds.LinOrig 
		from VendasDS..D_Produto as ds left join VendasDW..D_Produto as dw
		on ds.Cod_Produto = dw.Cod_produto
		where ds.Nome != dw.Nome
		  and dw.Ativo = 1	
	Open cur_AtualizaProduto
	fetch next from cur_AtualizaProduto into @CodProduto, @NomeProduto, @Tamanho, @Cor, @LinData, @LinOrigem
	while @@FETCH_STATUS = 0
		Begin
			-- Inativa o Produto com nome antigo:
			update VendasDW..D_Produto
			set Ativo = 0
			where Cod_Produto = @CodProduto

			-- insere o registro com os novos dados:
			insert into VendasDW..D_Produto values (@CodProduto,@NomeProduto,@Tamanho,@Cor,1,@LinData, @LinOrigem)  

		fetch next from cur_AtualizaProduto into @CodProduto, @NomeProduto, @Tamanho, @Cor, @LinData, @LinOrigem
		end
	close cur_AtualizaProduto
	deallocate cur_AtualizaProduto

	-- Faz o log do processo:
	insert into [dbo].[Adm_Log] values (newid(), getdate(), 'Importa Produto','S', 'Carga de D_Produto com sucesso.')

end try
begin catch
-- Faz o log do processo:
	insert into [dbo].[Adm_Log] values (newid(), getdate(), 'Importa Produto','F', 'Erro ao carregar D_Produto.')
end catch