Use VendasDW
GO

Insert into D_Cliente		  values ('999999','Não Aplica', 'Não Aplica', Getdate(), 'Registro padrão inserido manualmente');
Insert into D_Data			  values ('1900/01/01', '01','01','1900');
Insert into D_Funcionario	  values ('Não Aplica','Não Aplica',null, Getdate(), 'Registro padrão inserido manualmente');
Insert into D_GrupoGeografico values ('Não Aplica', Getdate(), 'Registro padrão inserido manualmente');
Insert into D_Pais			  values ((select Id_GrupoGeo from D_GrupoGeografico where Nome = 'Não Aplica'), 'XX', Getdate(), 'Registro padrão inserido manualmente');
Insert into D_RegiaoVendas    values ((select Id_Pais from D_Pais where Sigla = 'XX'), 'Não Aplica', Getdate(), 'Registro padrão inserido manualmente');
Insert into D_Produto		  values ('999999','Não Aplica','NA','NA','1', Getdate(), 'Registro padrão inserido manualmente');
