use master 
GO

create login BI_User
with PASSWORD = 'P@ssw0rd',
Default_Language=[Portugu�s (Brasil)],Check_Expiration=OFF, Check_Policy=OFF
GO
master..sp_addsrvrolemember @loginame = N'BI_User', @rolename = N'sysadmin'
GO
