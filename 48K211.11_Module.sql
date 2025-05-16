create database ThueTro
use ThueTro

create table CHUTRO
(
	CCCD_CT char(12) not null primary key,
	Ten_CT nvarchar(50) not null,
	SDT_CT varchar(15) not null,
	DiaChi_CT nvarchar(150) not null,
	TenDN_CT varchar(50) not null,
	MatKhau_CT varchar(8) not null
)

create table TAIKHOAN_NT
(	
	TenDN_NT varchar(50) not null primary key,
	MatKhau_NT varchar(8) not null
)

create table NGUOITHUETRO
(
	CCCD_NT char(12) not null primary key,
	Ten_NT nvarchar(50) not null,
	SDT_NT varchar(15) not null,
	DiaChi_NT nvarchar(150) not null,
	Email varchar(100),
	TenDN_NT varchar(50) not null,
	foreign key (TenDN_NT) references TAIKHOAN_NT(TenDN_NT),
)

create table PHONG
(
	SoPhong char(3) not null primary key,
	LoaiPhong char(1) not null,
	GiaPhong decimal(10,2) not null,
	DienTichPhong decimal(5,2) not null
)

create table DICHVU
(
	MaDV char(4) not null primary key,
	TenDV nvarchar(50) not null,
	DonVi nvarchar(20),
	DonGia decimal(10,2) not null
)

create table HOPDONG
(
	MaHopDong char(5) not null primary key,
	CCCD_NT char(12) not null,
	SoPhong char(3) not null,
	NgayThueTro date not null,
	NgayHetHan date not null,
	foreign key (CCCD_NT) references NGUOITHUETRO(CCCD_NT),
	foreign key (SoPhong) references PHONG(SoPhong)
)

create table HOADON
(
	MaHoaDon char(6) not null primary key,
	CCCD_NT char(12) not null,
	SoPhong char(3) not null,
	NgayThanhToan date not null,
	TongCong decimal(10,2),
	foreign key (CCCD_NT) references NGUOITHUETRO(CCCD_NT),
	foreign key (SoPhong) references PHONG(SoPhong)
)

create table HOADONCHITIET
(
	MaHoaDon char(6) not null,
	MaDV char(4) not null,
	SoDung int not null,
	ThanhTien decimal(10,2),
	primary key(MaHoaDon, MaDV),
	foreign key (MaHoaDon) references HOADON(MaHoaDon),
	foreign key (MaDV) references DICHVU(MaDV)
)

--Module tạo dữ liệu
--CHỦ TRỌ
go
create or alter proc chenChuTro
as
begin
	declare @dem int = 1,
			@CCCD_CT char(12),
			@Ten_CT nvarchar(50),
			@SDT_CT varchar(15),
			@DiaChi_CT nvarchar(150),
			@TenDN_CT varchar(50),
			@MatKhau_CT varchar(8)

	while @dem <= 1000
	begin
		set @CCCD_CT = RIGHT('00111000000' + CAST(@dem as varchar), 12)
		set @Ten_CT = case (@dem % 10) + 1
							when 1 then N'Nguyễn Văn Anh'
							when 2 then N'Trần Lê Bảo'
							when 3 then N'Lê Thị Cương'
							when 4 then N'Phạm Thị Duyên'
							when 5 then N'Đặng Anh Huy'
							when 6 then N'Phan Phương Quỳnh'
							when 7 then N'Hồ Phạm An'
							when 8 then N'Đinh Hoàng'
							when 9 then N'Nguyễn Thị Tuyết Trinh'
							when 10 then N'Bùi Anh Tuấn'
						end
		set @SDT_CT = case (@dem % 5) + 1
							when 1 then '098' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 2 then '070' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 3 then '035' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 4 then '093' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 5 then '079' + RIGHT('000000' + CAST(@dem as varchar), 7)
						end
		set @DiaChi_CT = case (@dem % 10) + 1
							when 1 then N'Số 1, Đường A, Đà Nẵng'
							when 2 then N'Số 2, Đường B, Đà Nẵng'
							when 3 then N'Số 3, Đường C, Đà Nẵng'
							when 4 then N'Số 4, Đường D, Đà Nẵng'
							when 5 then N'Số 5, Đường E, Đà Nẵng'
							when 6 then N'Số 6, Đường F, Đà Nẵng'
							when 7 then N'Số 7, Đường G, Đà Nẵng'
							when 8 then N'Số 8, Đường H, Đà Nẵng'
							when 9 then N'Số 9, Đường I, Đà Nẵng'
							when 10 then N'Số 10, Đường J, Đà Nẵng'
						end
		set @TenDN_CT = 'chutro' + CAST(@dem as varchar)
		set @MatKhau_CT = 'pass' + CAST(@dem as varchar)

		insert into CHUTRO (CCCD_CT, Ten_CT, SDT_CT, DiaChi_CT, TenDN_CT, MatKhau_CT )
		values (@CCCD_CT, @Ten_CT, @SDT_CT, @DiaChi_CT,@TenDN_CT, @MatKhau_CT)

		set @dem = @dem + 1
	end
end

exec chenChuTro
select * from CHUTRO

--TÀI KHOẢN NGƯỜI THUÊ TRỌ
go
create or alter proc chenTaiKhoan_NT
as
begin
declare @dem int = 1,
		@TenDN_NT varchar(50),
		@MatKhau_NT varchar(8)
    
	while @dem <= 1000
	begin
		set @TenDN_NT = 'nguoithue' + CAST(@dem as varchar)
		set @MatKhau_NT = 'pass' + CAST(@dem as varchar)

		insert into TAIKHOAN_NT (TenDN_NT, MatKhau_NT)
		values (@TenDN_NT, @MatKhau_NT)

		set @dem = @dem + 1
	end
end

exec chenTaiKhoan_NT
select * from TAIKHOAN_NT

--NGƯỜI THUÊ TRỌ
go
create or alter proc chenNguoiThueTro
as
begin
	declare @dem int = 1,
			@CCCD_NT char(12),
			@Ten_NT nvarchar(50),
			@SDT_NT varchar(15),
			@DiaChi_NT nvarchar(150),
			@Email varchar(100),
			@TenDN_NT varchar(50)

	while @dem <= 1000
	begin
		set @CCCD_NT = RIGHT('000000000000' + CAST(@dem as varchar), 12)
		set @Ten_NT = case (@dem % 10) + 1
							when 1 then N'Nguyễn Văn An'
							when 2 then N'Trần Thị Bình'
							when 3 then N'Lê Văn Cường'
							when 4 then N'Phạm Thị Dung'
							when 5 then N'Đặng Văn Huy'
							when 6 then N'Phan Như Quỳnh'
							when 7 then N'Hồ Thị Giang'
							when 8 then N'Đinh Văn Hoàng'
							when 9 then N'Nguyễn Thị Tuyết Trinh'
							when 10 then N'Bùi Văn Tuấn'
						end
		set @SDT_NT = case (@dem % 5) + 1
							when 1 then '098' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 2 then '070' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 3 then '035' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 4 then '093' + RIGHT('000000' + CAST(@dem as varchar), 7)
							when 5 then '079' + RIGHT('000000' + CAST(@dem as varchar), 7)
						end
		set @DiaChi_NT = case (@dem % 10) + 1
							when 1 then N'Số 1, Đường A, TP.HCM'
							when 2 then N'Số 2, Đường B, TP.HCM'
							when 3 then N'Số 3, Đường C, TP.HCM'
							when 4 then N'Số 4, Đường D, Hà Nội'
							when 5 then N'Số 5, Đường E, Đà Nẵng'
							when 6 then N'Số 6, Đường F, TP.HCM'
							when 7 then N'Số 7, Đường G, TP.HCM'
							when 8 then N'Số 8, Đường H, TP.HCM'
							when 9 then N'Số 9, Đường I, TP.HCM'
							when 10 then N'Số 10, Đường J, Huế'
						end
		set @Email = 'nguoithue' + CAST(@dem as varchar) + '@gmail.com'
		set @TenDN_NT = 'nguoithue' + CAST(@dem as varchar)

		insert into NGUOITHUETRO (CCCD_NT, Ten_NT, SDT_NT, DiaChi_NT, Email, TenDN_NT)
		values (@CCCD_NT, @Ten_NT, @SDT_NT, @DiaChi_NT, @Email, @TenDN_NT)

		set @dem = @dem + 1
	end
end

exec chenNguoiThueTro
select * from NGUOITHUETRO

--PHÒNG
go
create or alter proc chenPhong
as
begin
	declare @dem int = 1,
			@SoPhong char(3),
			@LoaiPhong nvarchar(20),
			@GiaPhong decimal(10,2),
			@DienTichPhong decimal(5,2)

	while @dem <= 1000
	begin
		set @SoPhong = RIGHT('000' + CAST(@dem as varchar), 3)
		set @LoaiPhong = case (@dem % 2) + 1
							when 1 then '1' --Phòng đơn
							when 2 then '2' --Phòng đôi
						end
		set @GiaPhong = case 
							when @LoaiPhong = '1' then 2000000 
							when @LoaiPhong = '2' then 2500000
						end
		set @DienTichPhong = case 
							when @LoaiPhong = '1' then 14.5
							when @LoaiPhong = '2' then 20
						end
		insert into PHONG (SoPhong, LoaiPhong, GiaPhong, DienTichPhong)
		values (@SoPhong, @LoaiPhong, @GiaPhong, @DienTichPhong)

		set @dem = @dem + 1
	end
end

exec chenPhong
select * from PHONG

--DỊCH VỤ
go
create or alter proc chenDichVu
as
begin
	declare @dem int = 1,
			@MaDV char(4),
			@TenDV nvarchar(50),
			@DonVi nvarchar(20),
			@DonGia decimal(10,2)
	while @dem <= 1000
	begin
		set @MaDV = RIGHT('0000' + CAST(@dem as varchar), 4)
		set @TenDV = case (@dem % 4) + 1
						when 1 then N'Điện'
						when 2 then N'Nước'
						when 3 then N'Wifi'
						when 4 then N'Rác'
					end
		set @DonVi = case
						when @TenDV = N'Điện' then N'kW '
						when @TenDV = N'Nước' then N'm3'
						when @TenDV = N'Wifi' then N'tháng'
						when @TenDV = N'Rác' then N'tháng'
					end
		set @DonGia = case 
						when @TenDV = N'Điện' then 4000
						when @TenDV = N'Nước' then 7000
						when @TenDV = N'Rác' then 30000
						when @TenDV = N'Wifi' then 15000
					end

		insert into DICHVU (MaDV, TenDV, DonVi, DonGia)
		values (@MaDV, @TenDV, @DonVi, @DonGia)

		set @dem = @dem + 1
	end
end 

exec chenDichVu
select * from DICHVU

--HỢP ĐỒNG
go
create or alter proc chenHopDong
as
begin
	declare @dem int = 1,
			@MaHopDong char(5),
			@CCCD_NT char(12),
			@SoPhong char(3),
			@NgayThueTro date,
			@NgayHetHan date

	while @dem <= 1000
	begin
		set @MaHopDong = RIGHT('00000' + CAST(@dem as varchar), 5)
		set @CCCD_NT = RIGHT('000000000000' + CAST(@dem as varchar), 12)
		set @SoPhong = RIGHT('000' + CAST(@dem as varchar), 3)
		set @NgayThueTro = DATEADD(DAY, ROUND(RAND() * 365, 0), '2022-01-01')
		set @NgayHetHan = DATEADD(DAY, ROUND(RAND() * 365, 0), '2024-01-01')

		insert into HOPDONG (MaHopDong, CCCD_NT, SoPhong, NgayThueTro, NgayHetHan)
		VALUES (@MaHopDong, @CCCD_NT, @SoPhong, @NgayThueTro, @NgayHetHan)
		set @dem = @dem + 1
	end
end

exec chenHopDong
select * from HOPDONG

-- HÓA ĐƠN
go
create or alter proc chenHoaDon
as
begin
	declare @dem int = 1,
			@MaHoaDon char(6),
			@CCCD_NT char(12),
			@SoPhong char(3),
			@NgayThanhToan date

	while @dem <= 1000
	begin
		set @MaHoaDon = RIGHT('000000' + CAST(@dem as varchar), 6)
		set @CCCD_NT = RIGHT('000000000000' + CAST(@dem as varchar), 12)
		set @SoPhong = RIGHT('000' + CAST(@dem as varchar), 3)
		set @NgayThanhToan = DATEADD(DAY, ROUND(RAND() * 365,0), '2023-01-01')

		insert into HOADON (MaHoaDon, CCCD_NT, SoPhong, NgayThanhToan)
		values (@MaHoaDon, @CCCD_NT, @SoPhong, @NgayThanhToan)

		set @dem = @dem + 1
	end
end

exec chenHoaDon
select * from HOADON

--HÓA ĐƠN CHI TIẾT
go
create or alter proc chenHoaDonChiTiet
as
begin
	declare @dem int = 1,
			@MaHoaDon char(6),
			@MaDV char(4),
			@SoDung int

	while @dem <= 1000
	begin
		set @MaHoaDon = RIGHT('000000' + CAST(@dem as varchar), 6)
		set @MaDV = RIGHT('0000' + CAST(@dem as varchar), 4)
		set @SoDung = ROUND(RAND() * 50, 0)

		insert into HOADONCHITIET (MaHoaDon, MaDV, SoDung)
		values (@MaHoaDon, @MaDV, @SoDung)

		set @dem = @dem + 1
	end
end

exec chenHoaDonChiTiet
select * from HOADONCHITIET

--Module xử lí dữ liệu
--Thủ tục tính thành tiền bảng HOADONCHITIET
go
create or alter proc spTinhThanhTien
as
begin
	update HOADONCHITIET
	set HOADONCHITIET.ThanhTien = HOADONCHITIET.SoDung * DICHVU.DonGia
	from HOADONCHITIET join DICHVU on HOADONCHITIET.MaDV = DICHVU.MaDV
	print N'Đã tính thành tiền'
end

exec spTinhThanhTien
select * from HOADONCHITIET

--Thủ tục tính tổng cộng bảng HOADON
go
create or alter proc spTinhTongCong
as
begin
	update HOADON
	set TongCong = (select SUM(HOADONCHITIET.ThanhTien) 
					from HOADONCHITIET 
					where HOADONCHITIET.MaHoaDon = HOADON.MaHoaDon) + 
					(select PHONG.GiaPhong 
					from PHONG 
					where PHONG.SoPhong = HOADON.SoPhong)
	from HOADON 
	print N'Đã tính tổng cộng'
end

exec spTinhTongCong
select * from HOADON

--Trigger tính thành tiền bảng HOADONCHITIET khi thêm mới, cập nhật dữ liệu trong bảng HOADONCHITIET
go
create or alter trigger tTinhThanhTien
on HOADONCHITIET
after insert, update
as
begin
	update HOADONCHITIET
	set HOADONCHITIET.ThanhTien = HOADONCHITIET.SoDung * DICHVU.DonGia
	from HOADONCHITIET join DICHVU on HOADONCHITIET.MaDV = DICHVU.MaDV
	where HOADONCHITIET.MaHoaDon in (select MaHoaDon from inserted)
end

insert into HOADONCHITIET (MaHoaDon, MaDV, SoDung)
values('000001','0002',10)
select * from HOADONCHITIET 

-- Trigger tính thành tiền bảng HOADONCHITIET khi thêm mới, cập nhật lại đơn giá bảng DICHVU
go
create or alter trigger tTinhThanhTienKhiCapNhatDonGia
on DICHVU
after insert, update
as
begin
	update HOADONCHITIET
	set HOADONCHITIET.ThanhTien = HOADONCHITIET.SoDung * DICHVU.DonGia
	from HOADONCHITIET join DICHVU on HOADONCHITIET.MaDV = DICHVU.MaDV
	where DICHVU.MaDV in (select MaDV from inserted)
end

update DICHVU
set DonGia=13000
where MaDV='0002'
select * from HOADONCHITIET

--Trigger tính tổng cộng bảng HOADON khi thêm mới, cập nhật dữ liệu trong bảng HOADONCHITIET
go
create or alter trigger tTinhTongCong
on HOADONCHITIET
after insert, update
as
begin
	update HOADON
	set TongCong = (select SUM(HOADONCHITIET.ThanhTien) 
					from HOADONCHITIET 
					where HOADONCHITIET.MaHoaDon = HOADON.MaHoaDon) + 
					(select PHONG.GiaPhong 
					from PHONG 
					where PHONG.SoPhong = HOADON.SoPhong)
	from HOADON
	where MaHoaDon in (select MaHoaDon from inserted)
end

insert into HOADONCHITIET (MaHoaDon, MaDV, SoDung)
values('000001','0003',20)
select * from HOADON

--Trigger tính tổng cộng bảng HOADON khi thêm mới, cập nhật dữ liệu trong bảng PHONG
go
create or alter trigger tTinhTongCongKhiCapNhatGiaPhong
on PHONG
after update
as
begin
    update HOADON
    set TongCong = (select SUM(HOADONCHITIET.ThanhTien) 
					from HOADONCHITIET 
					where HOADONCHITIET.MaHoaDon = HOADON.MaHoaDon) + 
					(select PHONG.GiaPhong 
					from PHONG 
					where PHONG.SoPhong = HOADON.SoPhong)
    from HOADON
	where MaHoaDon in (select MaHoaDon from inserted)
end

update PHONG
set GiaPhong=1600000
where SoPhong='001'

select * from HOADON

--Trigger khi xóa dữ liệu trong bảng NGUOITHUETRO, hãy thực hiện thao tác cập nhật Ten_NT là ‘không thuê’ thay vì xóa.
go
create or alter trigger tXoaNguoiThueTro
on NGUOITHUETRO
instead of delete
as
begin
	update NGUOITHUETRO
	set Ten_NT=N'Không thuê'
	where CCCD_NT in (select CCCD_NT from deleted)
end

delete NGUOITHUETRO where CCCD_NT='000000000002'
select * from NGUOITHUETRO

--Hàm kiểm tra thông tin người thuê trọ đã tồn tại trong hệ thống hay chưa nếu biết họ tên và số điện thoại. Tồn tại trả về 1, không tồn tại trả về 0
go
create or alter function fKiemTraThongTinKhachHang(@Ten_NT nvarchar(50), @SDT_NT varchar(15))
returns char(1)
as
begin
	declare @ret char(1)
	if @Ten_NT in (select Ten_NT from NGUOITHUETRO) and @SDT_NT in (select SDT_NT from NGUOITHUETRO)
	begin 
		set @ret=1
	end
	else
	begin 
		set @ret=0
	end
	return @ret
end

select dbo.fKiemTraThongTinKhachHang(N'Phạm Thị Dung','0930070003')

--Thủ tục kiểm tra khách hàng đang sử dụng loại phòng nào khi biết CCCD_NT
go
create or alter proc spKiemTraKhachHang(@CCCD_NT char(12), @ret nvarchar(20) output)
as
begin
	declare @LoaiPhong char(1)
	select @LoaiPhong=LoaiPhong
	from PHONG join HOPDONG on PHONG.SoPhong=HOPDONG.SoPhong
				join NGUOITHUETRO on NGUOITHUETRO.CCCD_NT=HOPDONG.CCCD_NT
	where NGUOITHUETRO.CCCD_NT=@CCCD_NT
	set @ret = case when @LoaiPhong=1 then N'Phòng đơn'
					when  @LoaiPhong=2 then N'Phòng đôi'
				end
end

declare @r nvarchar(20)
exec spkiemTraKhachHang '000000000001', @r output
print @r

--Thủ tục kiểm tra hợp đồng cho thuê của người thuê trọ đã hết hạn chưa khi biết CCCD_NT, nếu có thì cập nhật tên người thuê trọ là 'Hết hạn hợp đồng'
go
create or alter proc spKiemTraHopDong (@CCCD_NT char(12))
as
begin
	declare @NgayHetHan date
	select @NgayHetHan=NgayHetHan
	from HOPDONG
	where CCCD_NT=@CCCD_NT
	if @NgayHetHan<getdate()
	begin
		update NGUOITHUETRO
		set Ten_NT=N'Hết hạn hợp đồng'
		where CCCD_NT=@CCCD_NT
		print N'Hợp đồng đã hết hạn'
	end
	else
	begin
		print N'Hợp đồng vẫn còn hạn'
	end
end

exec spKiemTraHopDong '000000000001'
select * from NGUOITHUETRO
select * from HOPDONG

--Trả về mã hóa đơn mới. Mã hóa đơn tiếp theo được tính như sau: MAX(mã hóa đơn đang có) + 1. Hãy đảm bảo số lượng kí tự luôn đúng với quy định về mã hóa đơn (Thủ tục)
go
create or alter proc spMaHoaDonMoi(@MaHoaDonMoi char(6) output)
as
begin
	declare @MaHoaDonLonNhat varchar(10)
	select @MaHoaDonLonNhat = max(MaHoaDon)
	from HOADON
	set @MaHoaDonMoi=RIGHT('000000' + convert(varchar, convert(int, @MaHoaDonLonNhat)+1),6)
end

declare @a varchar(10)
exec spMaHoaDonMoi @a output
print @a

--Trả về mã hợp đồng mới. Mã hợp đồng tiếp theo được tính như sau: MAX(mã hợp đồng đang có) + 1. Hãy đảm bảo số lượng kí tự luôn đúng với quy định về mã hợp đồng (Hàm)
go
create or alter function fMaHopDongMoi()
returns char(5)
as
begin
	declare @mahopdonglonnhat varchar(10), @mahopdongmoi varchar(10)
	select @mahopdonglonnhat = max(MaHopDong)
	from HOPDONG
	set @mahopdongmoi=RIGHT('00000' + convert(varchar, convert(int, @mahopdonglonnhat)+1),5)
	return @mahopdongmoi
end

select dbo.fMaHopDongMoi()

/*
Thêm mới một hợp đồng nếu biết: CCCD_NT, SoPhong, NgayThueTro, NgayHetHan. Bao gồm những công việc sau:
1.Kiểm tra CCCD_NT đã tồn tại trong bảng NGUOITHUETRO chưa? Nếu chưa, ngừng xử lý
2.Kiểm tra SoPhong đã tồn tại trong bảng PHONG chưa? Nếu chưa, ngừng xử lý
3.Kiểm tra ngày thuê trọ có hợp lệ không. Nếu không, ngừng xử lý (hợp lệ không lớn hơn ngày và thời gian hiện tại)
4.Kiểm tra ngày hết hạn có hợp lệ không. Nếu không, ngừng xử lý (hợp tính từ ngày thuê đến ngày hết hạn ít nhất 3 tháng)
5.Tính mã hợp đồng mới
6.Thêm mới bản ghi vào bảng HOPDONG với dữ liệu đã có
*/
go
create or alter proc spThemMoiHopDong (@CCCD_NT char(12), @SoPhong char(3), @NgayThueTro date, @NgayHetHan date, @ret varchar(50) output)
as
begin
	declare @MaHopDongMoi varchar(10)
	--cau 1
	if @CCCD_NT not in (select CCCD_NT from NGUOITHUETRO)
	begin
		set @ret = 0 
		print N'CCCD_NT chưa tồn tại trong bảng NGUOITHUETRO'
		return
	end
	--cau 2
	if @SoPhong not in (select SoPhong from Phong)
	begin
		set @ret = 0 
		print N'Số phòng chưa tồn tại trong bảng PHONG'
		return
	end
	--cau 3
	if @NgayThueTro > getdate()
	begin
		set @ret = 0
		print N'Ngày thuê trọ không hợp lệ'
		return
	end
	--cau 4
	if DATEDIFF(Month, @NgayThueTro, @NgayHetHan) < 3
	begin
		set @ret = 0
		print N'Ngày hết hạn không hợp lệ'
		return
	end
	--cau 5
	set @MaHopDongMoi = dbo.fMaHopDongMoi()
	--cau 6
	insert into HOPDONG values (@MaHopDongMoi, @CCCD_NT, @SoPhong, @NgayThueTro, @NgayHetHan)
	if @@ROWCOUNT <= 0
	begin
		set @ret = 0
		print N'Thêm mới không thành công'
		return
	end
	else
	begin
		set @ret = 1
		print N'Thêm mới thành công'
	end
end

declare @a varchar(50)
exec spThemMoiHopDong '000000000001', '001', '2022-10-10','2024-06-30', @a output
print @a

declare @a varchar(50)
exec spThemMoiHopDong '000000000001', '001', '2024-11-10','2024-12-30', @a output
print @a
select * from HOPDONG

/*
Thêm mới một hóa đơn nếu biết: CCCD_NT, SoPhong, NgayThanhToan. Bao gồm những công việc sau:
1.Kiểm tra CCCD_NT đã tồn tại trong bảng NGUOITHUETRO chưa? Nếu chưa, ngừng xử lý
2.Kiểm tra SoPhong đã tồn tại trong bảng PHONG chưa? Nếu chưa, ngừng xử lý
3.Kiểm tra NgayThanhToan có hợp lệ không. Nếu không, ngừng xử lý (hợp lệ không lớn hơn ngày và thời gian hiện tại)
4.Tính mã hóa đơn mới
5.Thêm mới bản ghi vào bảng HOADON với dữ liệu đã có
*/
go
create or alter proc spThemMoiHoaDon (@CCCD_NT char(12), @SoPhong char(3), @NgayThanhToan date,  @ret nvarchar(50) output)
as
begin
	declare @MaHoaDonMoi varchar(10)
	--cau 1
	if @CCCD_NT not in (select CCCD_NT from NGUOITHUETRO)
	begin
		set @ret = 0 
		print N'CCCD_NT chưa tồn tại trong bảng NGUOITHUETRO'
		return
	end
	--cau 2
	if @SoPhong not in (select SoPhong from Phong)
	begin
		set @ret = 0 
		print N'Số phòng chưa tồn tại trong bảng PHONG'
		return
	end
	-- cau 3
	if @NgayThanhToan > getdate()
	begin
		set @ret = 0
		print N'Ngày thanh toán không hợp lệ'
		return
	end
	--cau 4
	exec spMaHoaDonMoi @MaHoaDonMoi output
	--cau 5
	insert into HOADON (MaHoaDon, CCCD_NT, SoPhong, NgayThanhToan)
	values (@MaHoaDonMoi, @CCCD_NT, @SoPhong, @NgayThanhToan)
	if @@ROWCOUNT <= 0
	begin
		set @ret = 0
		print N'Thêm mới không thành công'
		return
	end
	else
	begin
		set @ret = 1
		print N'Thêm mới thành công'
	end
end
	
declare @a varchar(50)
exec spThemMoiHoaDon '000000000001','001','2023-06-23', @a output
print @a

declare @a varchar(50)
exec spThemMoiHoaDon '000010000001','001','2023-06-23', @a output
print @a

select * from HOADON

/*
Thêm mới một hóa đơn chi tiết nếu biết: MaHoaDon, MaDV, SoDung. Bao gồm những công việc sau:
1.Kiểm tra MaHoaDon đã tồn tại trong bảng HOADON chưa? Nếu chưa, ngừng xử lý
2.Kiểm tra MaDV đã tồn tại trong bảng DICHVU chưa? Nếu chưa, ngừng xử lý
3.Kiểm tra SoDung có hợp lệ không. Nếu không, ngừng xử lý (không thể <0)
4.Thêm mới bản ghi vào bảng HOADONCHITIET với dữ liệu đã có
*/
go
create or alter proc spThemMoiHoaDonChiTiet (@MaHoaDon char(6), @MaDV char(4), @SoDung int, @ret nvarchar(50) output)
as
begin
	--cau 1
	if @MaHoaDon not in (select MaHoaDon from HOADON)
	begin
		set @ret = 0 
		print N'Mã hóa đơn chưa tồn tại trong bảng HOADON'
		return
	end
	--cau 2
	if @MaDV not in (select MaDV from DICHVU)
	begin
		set @ret = 0 
		print N'Mã dịch vụ chưa tồn tại trong bảng DICHVU'
		return
	end
	-- cau 3
	if @SoDung < 0
	begin
		set @ret = 0
		print N'Số dùng không hợp lệ'
		return
	end
	--cau 4
	insert into HOADONCHITIET (MaHoaDon, MaDV, SoDung)
	values(@MaHoaDon, @MaDV, @SoDung)
	if @@ROWCOUNT <= 0
	begin
		set @ret = 0
		print N'Thêm mới không thành công'
		return
	end
	else
	begin
		set @ret = 1
		print N'Thêm mới thành công'
	end
end

declare @a varchar(50)
exec spThemMoiHoaDonChiTiet '000002', '0001', 15, @a output
print @a

declare @a varchar(50)
exec spThemMoiHoaDonChiTiet '001001', '0001', -7, @a output
print @a

select * from HOADONCHITIET

