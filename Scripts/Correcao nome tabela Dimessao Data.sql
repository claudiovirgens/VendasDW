-- Summary for the safe rename
-- Actions in Sequence:
-- Drop Foreign Key FK_F_Venda_D_Data from F_Venda
-- Rename table D_data to D_Data
-- Create Foreign Key FK_F_Venda_D_Data on F_Venda
-- Warnings:
-- None

-- Referencing Objects:
-- [dbo].[F_Venda]
-- [dbo].[F_VendaDetalhe]



BEGIN TRAN
GO

-- Drop Foreign Key FK_F_Venda_D_Data from F_Venda
ALTER TABLE [dbo].[F_Venda] DROP CONSTRAINT [FK_F_Venda_D_Data]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
EXEC sp_rename N'[dbo].[D_data]', N'D_Data'
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Foreign Key FK_F_Venda_D_Data on F_Venda
ALTER TABLE [dbo].[F_Venda]
	WITH CHECK
	ADD CONSTRAINT [FK_F_Venda_D_Data]
	FOREIGN KEY ([Data]) REFERENCES [dbo].[D_Data] ([Data])
ALTER TABLE [dbo].[F_Venda]
	CHECK CONSTRAINT [FK_F_Venda_D_Data]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

IF @@TRANCOUNT>0
	COMMIT

SET NOEXEC OFF
GO

