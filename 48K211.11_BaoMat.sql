--Tạo user ChuTro1
CREATE USER ChuTro1
WITH PASSWORD = 'Dbnhom11chutro@'
 
--Tạo role ChuTro
CREATE ROLE ChuTro AUTHORIZATION [dbo]
GO
GRANT 
    DELETE, 
    INSERT, 
    SELECT, 
    UPDATE
ON SCHEMA::dbo
    TO ChuTro
GO

--Gán user ChuTro1 với role ChuTro
EXEC sp_addrolemember N'ChuTro', N'ChuTro1'



--Tạo user NguoiThue1
CREATE USER  NguoiThue1
WITH PASSWORD = 'Dbnhom11nguoithue@'

--Tạo role NguoiThue
CREATE ROLE NguoiThue AUTHORIZATION [dbo]
GO
	GRANT SELECT 
	ON dbo.DICHVU 
	TO NguoiThue 
	
	GRANT SELECT 
	ON dbo.HOADON 
	TO NguoiThue

	GRANT SELECT 
	ON dbo.HOADONCHITIET 
	TO NguoiThue

	GRANT SELECT 
	ON dbo.HOPDONG 
	TO NguoiThue

	GRANT SELECT 
	ON dbo.NGUOITHUETRO 
	TO NguoiThue

	GRANT SELECT 
	ON dbo.PHONG 
	TO NguoiThue
GO

--Gán user NguoiThue1 với role NguoiThue
EXEC sp_addrolemember N'NguoiThue', N'NguoiThue1'
