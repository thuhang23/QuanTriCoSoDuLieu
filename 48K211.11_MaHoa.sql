--CHUTRO
--Thay đổi kiểu dữ liệu cột MatKhau_CT
alter table CHUTRO alter column MatKhau_CT varchar(64);

--Mã hóa MatKhau_CT
update CHUTRO
set MatKhau_CT = CONVERT(varchar(64), HASHBYTES('SHA2_256', MatKhau_CT), 2)

select * from CHUTRO

--Trigger mã hóa mật khẩu khi thêm dữ liệu vào bảng CHUTRO
go
create or alter trigger tMaHoaMatKhauChuTro
on CHUTRO
after insert, update
as
begin
    update CHUTRO
    set MatKhau_CT = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', inserted.MatKhau_CT), 2)
    from CHUTRO inner join inserted on CHUTRO.CCCD_CT = inserted.CCCD_CT
end

insert into CHUTRO (CCCD_CT, Ten_CT, SDT_CT, DiaChi_CT, TenDN_CT, MatKhau_CT)
values ('123456789102', N'Nguyễn Thanh Thảo', '0376526048', N'Số 10 đường Lê Đình Lý', 'chutro1001', 'pass12345')

select * from CHUTRO

--Kiểm tra đăng nhập chủ trọ
go
create or alter proc spKiemTraDangNhapChuTro(@TenDN_CT varchar(50), 
											@MatKhau_CT varchar(64),
											@ret int output) 
as
begin
    declare @MatKhauHash VARBINARY(32);

    -- Hash mật khẩu với SHA2_256
    set @MatKhauHash = HASHBYTES('SHA2_256', @MatKhau_CT)

    -- Kiểm tra thông tin đăng nhập
    if exists (select 1 from CHUTRO 
				where TenDN_CT = @TenDN_CT and MatKhau_CT = CONVERT(VARCHAR(64), @MatKhauHash, 2)) 
    begin
        set @ret=1
    end
    else
    begin
        set @ret=0
    end
end

go
declare @ret int
exec spKiemTraDangNhapChuTro 'chutro10', 'pass10', @ret output
print @ret





--NGUOITHUETRO
--Thay đổi kiểu dữ liệu cột MatKhau_NT
alter table TAIKHOAN_NT alter column MatKhau_NT varchar(64)

--Mã hóa MatKhau_NT
update TAIKHOAN_NT
set MatKhau_NT = CONVERT(varchar(64), HASHBYTES('SHA2_256', MatKhau_NT), 2)

select * from TAIKHOAN_NT

--Trigger mã hóa mật khẩu khi thêm dữ liệu vào bảng TAIKHOAN_NT
go
create or alter trigger tMaHoaMatKhauNguoiThue
on TAIKHOAN_NT
after insert, update
as
begin
    update TAIKHOAN_NT
    set MatKhau_NT = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', inserted.MatKhau_NT), 2)
    from TAIKHOAN_NT inner join inserted on TAIKHOAN_NT.TenDN_NT = inserted.TenDN_NT
end

insert into TAIKHOAN_NT (TenDN_NT, MatKhau_NT)
values ('nguoithue1001', 'pass12345')

select * from TAIKHOAN_NT

--Kiểm tra đăng nhập người thuê trọ
go
create or alter proc spKiemTraDangNhapNguoiThue (@TenDN_NT VARCHAR(50), 
												@MatKhau_NT VARCHAR(64),
												@ret int output) 
as
begin
    declare @MatKhauHash VARBINARY(32)

    -- Hash mật khẩu với SHA2_256
    set @MatKhauHash = HASHBYTES('SHA2_256', @MatKhau_NT)

    -- Kiểm tra thông tin đăng nhập
    if exists (select 1 from TAIKHOAN_NT 
				where TenDN_NT = @TenDN_NT AND MatKhau_NT = CONVERT(VARCHAR(64), @MatKhauHash, 2))

    begin
        set @ret=1
    end
    else
    begin
        set @ret=0
    end
end

go
declare @ret int
exec spKiemTraDangNhapNguoiThue 'nguoithue1', 'pass1', @ret output
print @ret

