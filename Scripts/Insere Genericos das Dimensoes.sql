Use VendasDW
GO

Insert into D_Cliente		  values ('999999','N�o Aplica', 'N�o Aplica', Getdate(), 'Registro padr�o inserido manualmente');
Insert into D_Data			  values ('1900/01/01', '01','01','1900');
Insert into D_Funcionario	  values ('N�o Aplica','N�o Aplica',null, Getdate(), 'Registro padr�o inserido manualmente');
Insert into D_GrupoGeografico values ('N�o Aplica', Getdate(), 'Registro padr�o inserido manualmente');
Insert into D_Pais			  values ((select Id_GrupoGeo from D_GrupoGeografico where Nome = 'N�o Aplica'), 'XX', Getdate(), 'Registro padr�o inserido manualmente');
Insert into D_RegiaoVendas    values ((select Id_Pais from D_Pais where Sigla = 'XX'), 'N�o Aplica', Getdate(), 'Registro padr�o inserido manualmente');
Insert into D_Produto		  values ('999999','N�o Aplica','NA','NA','1', Getdate(), 'Registro padr�o inserido manualmente');
