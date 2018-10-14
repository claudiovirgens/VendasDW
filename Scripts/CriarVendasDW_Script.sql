USE VendasDW;
GO

CREATE TABLE dbo.D_Cliente
(Id_Cliente  INT IDENTITY(1, 1) NOT NULL, 
 Cod_Cliente VARCHAR(10) NOT NULL, 
 Nome        VARCHAR(50) NOT NULL, 
 Email       VARCHAR(50) NOT NULL, 
 LinData    DATE NOT NULL, 
 LinOrig     VARCHAR(50) NOT NULL, 
 CONSTRAINT PK_D_Cliente PRIMARY KEY CLUSTERED(Id_Cliente ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.D_Data
(Data DATE NOT NULL, 
 Dia  CHAR(2) NOT NULL, 
 Mes  CHAR(2) NOT NULL, 
 Ano  CHAR(4) NOT NULL, 
 CONSTRAINT PK_D_DATA PRIMARY KEY CLUSTERED(Data ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.D_Funcionario
(Id_Funcionario INT IDENTITY(1, 1) NOT NULL, 
 Nome           VARCHAR(50) NOT NULL, 
 Login          VARCHAR(50) NOT NULL, 
 id_Chefe       INT NULL, 
 LinData       DATE NOT NULL, 
 LinOrig        VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_D_Funcionario PRIMARY KEY CLUSTERED(Id_Funcionario ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.D_GrupoGeografico
(Id_GrupoGeo INT IDENTITY(1, 1) NOT NULL, 
 Nome        VARCHAR(50) NOT NULL, 
 LinData    DATE NOT NULL, 
 LinOrig     VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_D_GrupoGeografico PRIMARY KEY CLUSTERED(Id_GrupoGeo ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.D_Pais
(Id_Pais     INT IDENTITY(1, 1) NOT NULL, 
 Id_GrupoGeo INT NOT NULL, 
 Sigla       CHAR(2) NOT NULL, 
 LinData    DATE NOT NULL, 
 LinOrig     VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_D_Pais PRIMARY KEY CLUSTERED(Id_Pais ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.D_Produto
(Id_Produto  INT IDENTITY(1, 1) NOT NULL, 
 Cod_Produto VARCHAR(50) NOT NULL, 
 Nome        VARCHAR(50) NOT NULL, 
 Tamanho     VARCHAR(5) NOT NULL, 
 Cor         VARCHAR(20) NOT NULL, 
 Ativo       CHAR(1) NOT NULL, 
 LinData    DATE NOT NULL, 
 LinOrig     VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_D_Produto PRIMARY KEY CLUSTERED(Id_Produto ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.D_RegiaoVendas
(Id_RegiaoVendas INT IDENTITY(1, 1) NOT NULL, 
 Id_Pais         INT NOT NULL, 
 Nome            VARCHAR(20) NOT NULL, 
 LinData        DATE NOT NULL, 
 LinOrig         VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_D_RegiaoVendas PRIMARY KEY CLUSTERED(Id_RegiaoVendas ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.F_Venda
(Data            DATE NOT NULL, 
 Nr_NF           INT NOT NULL, 
 Id_cliente      INT NOT NULL, 
 Id_Funcionario  INT NOT NULL, 
 Id_RegiaoVendas INT NOT NULL, 
 Vlr_Imposto     DECIMAL(18, 2) NOT NULL, 
 Vlr_Frete       DECIMAL(18, 2) NOT NULL, 
 LinData        DATE NOT NULL, 
 LinOrig         VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_F_Vendas PRIMARY KEY CLUSTERED(Data ASC, Nr_NF ASC, Id_cliente ASC, Id_Funcionario ASC, Id_RegiaoVendas ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE TABLE dbo.F_VendaDetalhe
(Data            DATE NOT NULL, 
 Nr_NF           INT NOT NULL, 
 Id_cliente      INT NOT NULL, 
 Id_Funcionario  INT NOT NULL, 
 Id_RegiaoVendas INT NOT NULL, 
 Id_Produto      INT NOT NULL, 
 Vlr_Unitario    DECIMAL(18, 2) NOT NULL, 
 Qtd_Vendida     INT NOT NULL, 
 LinData        DATE NOT NULL, 
 LinOrig         VARCHAR(50) NOT NULL, 
 CONSTRAINT Pk_F_VendasDetalhe PRIMARY KEY CLUSTERED(Data ASC, Nr_NF ASC, Id_cliente ASC, Id_Funcionario ASC, Id_RegiaoVendas ASC, Id_Produto ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Primary]
)
ON [Primary]
 GO
CREATE NONCLUSTERED INDEX IX_D_RegiaoVendas ON dbo.D_RegiaoVendas(Id_Pais ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	GO
ALTER TABLE dbo.D_Pais
WITH CHECK
ADD CONSTRAINT FK_D_Pais_D_GrupoGeografico FOREIGN KEY(Id_GrupoGeo) REFERENCES dbo.D_GrupoGeografico(Id_GrupoGeo)
GO
ALTER TABLE dbo.D_Pais CHECK CONSTRAINT FK_D_Pais_D_GrupoGeografico
GO
ALTER TABLE dbo.D_RegiaoVendas
WITH CHECK
ADD CONSTRAINT FK_D_RegiaoVendas_D_Pais FOREIGN KEY(Id_Pais) REFERENCES dbo.D_Pais(Id_Pais)
GO
ALTER TABLE dbo.D_RegiaoVendas CHECK CONSTRAINT FK_D_RegiaoVendas_D_Pais
GO
ALTER TABLE dbo.F_Venda
WITH CHECK
ADD CONSTRAINT FK_F_Venda_D_Cliente FOREIGN KEY(Id_Cliente) REFERENCES dbo.D_Cliente(Id_Cliente);
GO
ALTER TABLE dbo.F_Venda CHECK CONSTRAINT FK_F_Venda_D_Cliente;
GO
ALTER TABLE dbo.F_Venda
WITH CHECK
ADD CONSTRAINT FK_F_Venda_D_Data FOREIGN KEY(Data) REFERENCES dbo.D_Data(Data);
GO
ALTER TABLE dbo.F_Venda CHECK CONSTRAINT FK_F_Venda_D_Data; 
GO
ALTER TABLE dbo.F_Venda
WITH CHECK
ADD CONSTRAINT FK_F_Venda_D_Funcionario FOREIGN KEY(Id_Funcionario) REFERENCES dbo.D_Funcionario(Id_Funcionario); 
GO
ALTER TABLE dbo.F_Venda CHECK CONSTRAINT FK_F_Venda_D_Funcionario; 
GO
ALTER TABLE dbo.F_Venda
WITH CHECK
ADD CONSTRAINT FK_F_Venda_D_RegiaoVendas FOREIGN KEY(Id_RegiaoVendas) REFERENCES dbo.D_RegiaoVendas(Id_RegiaoVendas); 
GO
ALTER TABLE dbo.F_Venda CHECK CONSTRAINT FK_F_Venda_D_RegiaoVendas; 
GO
ALTER TABLE dbo.F_VendaDetalhe
WITH CHECK
ADD CONSTRAINT FK_F_VendaDetalhe_D_Produto FOREIGN KEY(Id_Produto) REFERENCES dbo.D_Produto(Id_Produto); 
GO
ALTER TABLE dbo.F_VendaDetalhe CHECK CONSTRAINT FK_F_VendaDetalhe_D_Produto; 
GO
ALTER TABLE dbo.F_VendaDetalhe
WITH CHECK
ADD CONSTRAINT FK_F_VendaDetalhe_F_Venda FOREIGN KEY(Data, Nr_NF, Id_Cliente, Id_Funcionario, Id_RegiaoVendas) REFERENCES dbo.F_Venda(Data, 
                                                                                                                                      Nr_NF, 
                                                                                                                                      Id_Cliente, 
                                                                                                                                      Id_Funcionario, 
                                                                                                                                      Id_RegiaoVendas); 
GO
ALTER TABLE dbo.F_VendaDetalhe CHECK CONSTRAINT FK_F_VendaDetalhe_F_Venda; 
GO