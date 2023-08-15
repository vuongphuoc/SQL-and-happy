USE [master]

CREATE DATABASE [PTPM_FINALLY_JAVA_SOF306]
GO

USE [PTPM_FINALLY_JAVA_SOF306]
GO

CREATE TABLE HangKhachHang(
	MaHang			INT	
		IDENTITY(1,1) PRIMARY KEY,
	TenHang			NVARCHAR(50),
	MoTa			NVARCHAR(MAX),
	DiemToiThieu	INT NOT NULL,
	TrangThai		INT
)
GO

CREATE TABLE KhachHang(
	MaKhachHang		BIGINT	
		IDENTITY(1,1) PRIMARY KEY,
	TenKhachHang	NVARCHAR(50),
	SinhNhat		DATE,
	DiaChi			NVARCHAR(MAX),
	SoDienThoai		VARCHAR(15) ,
	Email			VARCHAR(50) ,
	GioiTinh		BIT,
	ChungMinhThu	VARCHAR(15)	,
	SoCanCuoc		VARCHAR(15)	,
	AnhDaiDien		VARCHAR(50), -- Link anh
	TrangThai		INT,
	DiemTichLuy		INT DEFAULT 0, --Mac dinh 0

	HangKhachHang	INT	
		REFERENCES HangKhachHang(MaHang),
	NguoiGioiThieu	BIGINT 
		REFERENCES KhachHang(MaKhachHang)
)
GO

CREATE TABLE TheThanhVien(
	MaThe			VARCHAR(50) PRIMARY KEY,
	MauThe			NVARCHAR(10),
	LoaiThe			NVARCHAR(10),
	NgayPhatHanh	DATE,
	NgayHuy			DATE,
	TrangThai		INT,

	NguoiSoHuu		BIGINT 
		REFERENCES KhachHang(MaKhachHang)
)
GO

CREATE TABLE PhieuGiamGia(
	MaPhieu			VARCHAR(10) PRIMARY KEY,
	TenPhieu		NVARCHAR(20),
	NgayBatDau		DATE,
	NgayKetThuc		DATE,
	GiaTriGiam		MONEY,
	GiaTriGiamToiDa	MONEY,
	HinhThucGiam	BIT, -- % hay gia tien
	TrangThai		INT,

	NguoiSoHuu		BIGINT 
		REFERENCES KhachHang(MaKhachHang)
)
GO

CREATE TABLE DiaChi (
	MaDiaChi		UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
	TenDiaChi		NVARCHAR(50),
	MoTaChiTiet		NVARCHAR(MAX),
	TinhThanhPho	NVARCHAR(50),
	QuanHuyen		NVARCHAR(50),
	PhuongXa		NVARCHAR(50),
	DuongPho		NVARCHAR(50),

	KhachHang		BIGINT	
		REFERENCES KhachHang(MaKhachHang),
)
GO

CREATE TABLE SanPham(
	MaSanPham	BIGINT	
		IDENTITY(1,1) PRIMARY KEY,
	TenSanPham	NVARCHAR(100),
	ChatLieu	NVARCHAR(100),
	GiaHienHanh	MONEY,
	SoLuongTon	INT,
	MoTa		NVARCHAR(MAX),
	LoaiSanPham	NVARCHAR(50),
	MauSac		NVARCHAR(20),
	NhaSanXuat	NVARCHAR(20),
	TrangThai	INT,
)
GO

CREATE TABLE HoaDon(
	MaHoaDon		BIGINT	IDENTITY(1,1) PRIMARY KEY,
	NgayLap			DATE,
	NguoiLap		NVARCHAR(50),
	GhiChu			NVARCHAR(MAX),
	NgayThanhToan	DATE,
	TrangThai		INT,

	NguoiMua		BIGINT	
		REFERENCES KhachHang(MaKhachHang),
)
GO

CREATE TABLE HoaDonChiTiet(
	MaHoaDon	BIGINT
		REFERENCES HoaDon(MaHoaDon),
	MaSanPham	BIGINT
		REFERENCES SanPham(MaSanPham),
	SoLuong		INT,
	DonGia		MONEY,

	GhiChu		NVARCHAR(MAX),
	TrangThai	INT,	
	
	PRIMARY KEY (MaHoaDon, MaSanPham)				
)
GO

CREATE TABLE PhieuGiaoHang(
	MaPhieuGiao	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	
	NguoiNhan	NVARCHAR(50),
	SdtNhan		VARCHAR(20),

	NguoiGiao	NVARCHAR(50),
	SdtGiao		VARCHAR(20),
	NgayGiao	DATE,
	NgayNhan	DATE,

	NguoiTao	NVARCHAR(50),
	PhiGiaoHang	MONEY,

	HoaDonGiao	BIGINT 
		REFERENCES HoaDon(MaHoaDon),
	DiaChiGiao	UNIQUEIDENTIFIER
		REFERENCES DiaChi(MaDiaChi),

	GhiChu		NVARCHAR(MAX),
	TrangThai	INT,
)

CREATE TABLE GioHang(
	MaGioHang	UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
	NgayTao		DATE,
	NgayCapNhap	DATE,

	NguoiSoHuu	BIGINT 
		REFERENCES KhachHang(MaKhachHang),
	
	GhiChu		NVARCHAR(MAX),
	TrangThai	INT,
)
GO

CREATE TABLE GioHangChiTiet(
	MaGioHang	UNIQUEIDENTIFIER
		REFERENCES GioHang(MaGioHang),
	MaSanPham	BIGINT
		REFERENCES SanPham(MaSanPham),

	SoLuong		INT,

	GhiChu		NVARCHAR(MAX),
	TrangThai	INT,

	PRIMARY KEY (MaGioHang, MaSanPham)
)
GO

CREATE TABLE DanhSachYeuThich(	
	MaDanhSach	UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
	NgayTao		DATE,
	NgayCapNhap	DATE,

	NguoiSoHuu	BIGINT 
		REFERENCES KhachHang(MaKhachHang),
	
	GhiChu		NVARCHAR(MAX),
	TrangThai	INT,
)
GO

CREATE TABLE YeuThichChiTiet(
	MaDanhSach	UNIQUEIDENTIFIER
		REFERENCES DanhSachYeuThich(MaDanhSach),
	MaSanPham	BIGINT
		REFERENCES SanPham(MaSanPham),

	GhiChu		NVARCHAR(MAX),
	TrangThai	INT,

	PRIMARY KEY (MaDanhSach, MaSanPham)
)

INSERT INTO HangKhachHang (TenHang, MoTa, DiemToiThieu, TrangThai)
VALUES 
/*
	('Hàng 1', 'Mô t? hàng 1', 10, 1),
	('Hàng 2', 'Mô t? hàng 2', 20, 1),
	('Hàng 3', 'Mô t? hàng 3', 30, 0),
	('Hàng 4', 'Mô t? hàng 4', 40, 1),
	('Hàng 5', 'Mô t? hàng 5', 50, 0),
	('Hàng 6', 'Mô t? hàng 6', 60, 1),
	*/
	
	('Hàng 7', 'Mô t? hàng 7', 70, 1),
	('Hàng 8', 'Mô t? hàng 8', 80, 0),
	('Hàng 9', 'Mô t? hàng 9', 90, 1),
	('Hàng 10', 'Mô t? hàng 10', 100, 1);
	select * from HangKhachHang

	INSERT INTO KhachHang (TenKhachHang, SinhNhat, DiaChi, SoDienThoai, Email, GioiTinh, ChungMinhThu, SoCanCuoc, AnhDaiDien, TrangThai, DiemTichLuy, HangKhachHang, NguoiGioiThieu)
VALUES 
/*
	('Khách hàng 1', '1990-01-01', '??a ch? 1', '123456789', 'email1@example.com', 1, 'CMND 1', 'CCCD 1', 'anh1.jpg', 1, 100, 1, 1),
	('Khách hàng 2', '1995-02-02', '??a ch? 2', '987654321', 'email2@example.com', 0, 'CMND 2', 'CCCD 2', 'anh2.jpg', 1, 200, 2, 2),
	('Khách hàng 3', '1988-03-03', '??a ch? 3', '555555555', 'email3@example.com', 1, 'CMND 3', 'CCCD 3', 'anh3.jpg', 1, 300, 3, 3),
	('Khách hàng 4', '1992-04-04', '??a ch? 4', '666666666', 'email4@example.com', 0, 'CMND 4', 'CCCD 4', 'anh4.jpg', 1, 400, 4, 4),
	('Khách hàng 5', '1997-05-05', '??a ch? 5', '777777777', 'email5@example.com', 1, 'CMND 5', 'CCCD 5', 'anh5.jpg', 1, 500, 5, 5),
	('Khách hàng 6', '1994-06-06', '??a ch? 6', '888888888', 'email6@example.com', 0, 'CMND 6', 'CCCD 6', 'anh6.jpg', 1, 600, 6, 6);
	*/
	('Khách hàng 7', '1994-07-06', '??a ch? 7', '223213333', 'email7@example.com', 0, 'CMND 7', 'CCCD 7', 'anh7.jpg', 1, 700, 7, 7),
	('Khách hàng 8', '1994-08-06', '??a ch? 8', '888888888', 'email8@example.com', 1, 'CMND 8', 'CCCD 8', 'anh8.jpg', 1, 800, 8, 8),
	('Khách hàng 9', '1994-09-06', '??a ch? 9', '999999999', 'email9@example.com', 1, 'CMND 9', 'CCCD 9', 'anh9.jpg', 1, 900, 9, 9),
	('Khách hàng 10', '1994-10-06', '??a ch? 10', '023213123', 'email10@example.com', 0, 'CMND 10', 'CCCD 10', 'anh10.jpg', 1, 1000,10 , 10);

	select * from KhachHang

	INSERT INTO TheThanhVien (MaThe, MauThe, LoaiThe, NgayPhatHanh, NgayHuy, TrangThai, NguoiSoHuu)
VALUES 
/*
	('The 1', 'Màu 1', 'Lo?i 1', '2023-01-01', '2023-01-01', 1, 1),
	('The 2', 'Màu 2', 'Lo?i 2', '2023-02-02', '2023-01-02', 1, 2),
	('The 3', 'Màu 3', 'Lo?i 1', '2023-03-03', '2023-01-03', 1, 3),
	('The 4', 'Màu 2', 'Lo?i 2', '2023-04-04', '2023-01-04', 1, 4),
	('The 5', 'Màu 1', 'Lo?i 1', '2023-05-05', '2023-01-05', 1, 5),
	('The 6', 'Màu 3', 'Lo?i 2', '2023-06-06', '2023-01-06', 1, 6);
	*/
	('The 7', 'Màu 4', 'Lo?i 2', '2023-07-07', '2023-01-07', 1, 7),
	('The 8', 'Màu 5', 'Lo?i 1', '2023-08-08', '2023-01-08', 1, 8),
	('The 9', 'Màu 6', 'Lo?i 2', '2023-09-09', '2023-01-09', 1, 9),
	('The 10', 'Màu 7', 'Lo?i 1', '2023-10-10', '2023-01-10', 1, 10);
	select * from TheThanhVien


	INSERT INTO PhieuGiamGia (MaPhieu, TenPhieu, NgayBatDau, NgayKetThuc, GiaTriGiam, GiaTriGiamToiDa, HinhThucGiam, TrangThai, NguoiSoHuu)
VALUES 
/*
	('PGG 1', 'Phi?u gi?m giá 1', '2023-01-01', '2023-01-31', 10000, 50000, 0, 1, 1),
	('PGG 2', 'Phi?u gi?m giá 2', '2023-02-01', '2023-02-28', 20000, 100000, 1, 1, 2),
	('PGG 3', 'Phi?u gi?m giá 3', '2023-03-01', '2023-03-31', 30000, 150000, 0, 1, 3),
	('PGG 4', 'Phi?u gi?m giá 4', '2023-04-01', '2023-04-30', 40000, 200000, 1, 1, 4),
	('PGG 5', 'Phi?u gi?m giá 5', '2023-05-01', '2023-05-31', 50000, 250000, 0, 1, 5),
	('PGG 6', 'Phi?u gi?m giá 6', '2023-06-01', '2023-06-30', 60000, 300000, 1, 1, 6);
	*/
	('PGG 7', 'Phi?u gi?m giá 7', '2023-07-01', '2023-07-30', 70000, 400000, 1, 1, 7),
	('PGG 8', 'Phi?u gi?m giá 8', '2023-08-01', '2023-08-30', 80000, 500000, 0, 1, 8),
	('PGG 9', 'Phi?u gi?m giá 9', '2023-09-01', '2023-09-30', 90000, 600000, 1, 1, 9),
	('PGG 10', 'Phi?u gi?m giá 10', '2023-10-01', '2023-10-30', 100000, 700000, 1, 1, 10);




	INSERT INTO DiaChi (TenDiaChi, MoTaChiTiet, TinhThanhPho, QuanHuyen, PhuongXa, DuongPho, KhachHang)
VALUES 
/*
	('??a ch? 1', 'Mô t? chi ti?t 1', 'T?nh/Thành ph? 1', 'Qu?n/Huy?n 1', 'Ph??ng/Xã 1', '???ng/Ph? 1', 1),
	('??a ch? 2', 'Mô t? chi ti?t 2', 'T?nh/Thành ph? 2', 'Qu?n/Huy?n 2', 'Ph??ng/Xã 2', '???ng/Ph? 2', 2),
	('??a ch? 3', 'Mô t? chi ti?t 3', 'T?nh/Thành ph? 3', 'Qu?n/Huy?n 3', 'Ph??ng/Xã 3', '???ng/Ph? 3', 3),
	('??a ch? 4', 'Mô t? chi ti?t 4', 'T?nh/Thành ph? 4', 'Qu?n/Huy?n 4', 'Ph??ng/Xã 4', '???ng/Ph? 4', 4),
	('??a ch? 5', 'Mô t? chi ti?t 5', 'T?nh/Thành ph? 5', 'Qu?n/Huy?n 5', 'Ph??ng/Xã 5', '???ng/Ph? 5', 5),
	('??a ch? 6', 'Mô t? chi ti?t 6', 'T?nh/Thành ph? 6', 'Qu?n/Huy?n 6', 'Ph??ng/Xã 6', '???ng/Ph? 6', 6);
	*/
	('??a ch? 7', 'Mô t? chi ti?t 7', 'T?nh/Thành ph? 7', 'Qu?n/Huy?n 7', 'Ph??ng/Xã 7', '???ng/Ph? 7', 7),
	('??a ch? 8', 'Mô t? chi ti?t 8', 'T?nh/Thành ph? 8', 'Qu?n/Huy?n 8', 'Ph??ng/Xã 8', '???ng/Ph? 8', 8),
	('??a ch? 9', 'Mô t? chi ti?t 9', 'T?nh/Thành ph? 9', 'Qu?n/Huy?n 9', 'Ph??ng/Xã 9', '???ng/Ph? 9', 9),
	('??a ch? 10', 'Mô t? chi ti?t 10', 'T?nh/Thành ph? 10', 'Qu?n/Huy?n 10', 'Ph??ng/Xã 10', '???ng/Ph? 10', 10);

	select * from DiaChi

	INSERT INTO SanPham (TenSanPham, ChatLieu, GiaHienHanh, SoLuongTon, MoTa, LoaiSanPham, MauSac, NhaSanXuat, TrangThai)
VALUES 
/*
	('S?n ph?m 1', 'Ch?t li?u 1', 100000, 50, 'Mô t? s?n ph?m 1', 'Lo?i 1', 'Màu s?c 1', 'Nhà s?n xu?t 1', 1),
	('S?n ph?m 2', 'Ch?t li?u 2', 200000, 60, 'Mô t? s?n ph?m 2', 'Lo?i 1', 'Màu s?c 2', 'Nhà s?n xu?t 2', 1),
	('S?n ph?m 3', 'Ch?t li?u 3', 300000, 70, 'Mô t? s?n ph?m 3', 'Lo?i 2', 'Màu s?c 3', 'Nhà s?n xu?t 3', 1),
	('S?n ph?m 4', 'Ch?t li?u 4', 400000, 80, 'Mô t? s?n ph?m 4', 'Lo?i 2', 'Màu s?c 4', 'Nhà s?n xu?t 4', 1),
	('S?n ph?m 5', 'Ch?t li?u 5', 500000, 90, 'Mô t? s?n ph?m 5', 'Lo?i 1', 'Màu s?c 5', 'Nhà s?n xu?t 5', 1),
	('S?n ph?m 6', 'Ch?t li?u 6', 600000, 100, 'Mô t? s?n ph?m 6', 'Lo?i 2', 'Màu s?c 6', 'Nhà s?n xu?t 6', 1);
	*/
	('S?n ph?m 7', 'Ch?t li?u 7', 700000, 200, 'Mô t? s?n ph?m 7', 'Lo?i 2', 'Màu s?c 7', 'Nhà s?n xu?t 7', 1),
	('S?n ph?m 8', 'Ch?t li?u 8', 800000, 300, 'Mô t? s?n ph?m 8', 'Lo?i 1', 'Màu s?c 8', 'Nhà s?n xu?t 8', 1),
	('S?n ph?m 9', 'Ch?t li?u 9', 900000, 500, 'Mô t? s?n ph?m 9', 'Lo?i 1', 'Màu s?c 9', 'Nhà s?n xu?t 9', 1),
	('S?n ph?m 10', 'Ch?t li?u 10', 1000000, 600, 'Mô t? s?n ph?m 10', 'Lo?i 2', 'Màu s?c 10', 'Nhà s?n xu?t 10', 1);

	select * from SanPham


	INSERT INTO HoaDon (NgayLap, NguoiLap, GhiChu, NgayThanhToan, TrangThai, NguoiMua)
VALUES /*
	('2023-01-01', 'Ng??i l?p 1', 'Ghi chú 1', '2023-01-02',  1, 1),
	('2023-02-02', 'Ng??i l?p 2', 'Ghi chú 2', '2023-02-03',  1, 2),
	('2023-03-03', 'Ng??i l?p 3', 'Ghi chú 3', '2023-03-04',  1, 3),
	('2023-04-04', 'Ng??i l?p 4', 'Ghi chú 4', '2023-04-05',  1, 4),
	('2023-05-05', 'Ng??i l?p 5', 'Ghi chú 5', '2023-05-06',  1, 5),
	('2023-06-06', 'Ng??i l?p 6', 'Ghi chú 6', '2023-06-07',  1, 6);
	*/
	('2023-07-07', 'Ng??i l?p 7', 'Ghi chú 7', '2023-07-08',  1, 7),
	('2023-08-08', 'Ng??i l?p 8', 'Ghi chú 8', '2023-08-09',  1, 8),
	('2023-09-09', 'Ng??i l?p 9', 'Ghi chú 9', '2023-09-10',  1, 9),
	('2023-10-10', 'Ng??i l?p 10', 'Ghi chú 10', '2023-10-11',  1, 10);

	select * from HoaDon

	INSERT INTO HoaDonChiTiet (MaHoaDon, MaSanPham, SoLuong, DonGia, GhiChu, TrangThai)
VALUES /*
	(1, 1, 2, 50000, 'Ghi chú chi ti?t 1', 1),
	(2, 2, 3, 60000, 'Ghi chú chi ti?t 2', 1),
	(3, 3, 1, 70000, 'Ghi chú chi ti?t 3', 1),
	(4, 4, 2, 80000, 'Ghi chú chi ti?t 4', 1),
	(5, 5, 4, 90000, 'Ghi chú chi ti?t 5', 1),
	(6, 6, 5, 100000, 'Ghi chú chi ti?t 6', 1);
	*/
	(7, 7, 6, 200000, 'Ghi chú chi ti?t 7', 1),
	(8, 8, 7, 300000, 'Ghi chú chi ti?t 8', 1),
	(9, 9, 8, 400000, 'Ghi chú chi ti?t 9', 1),
	(10, 10, 9, 500000, 'Ghi chú chi ti?t 10', 1);


	INSERT INTO PhieuGiaoHang ( NguoiNhan, SdtNhan, NguoiGiao, SdtGiao, NgayGiao, NgayNhan, NguoiTao, PhiGiaoHang, HoaDonGiao, DiaChiGiao, GhiChu, TrangThai)
VALUES /*
	( 'Ng??i nh?n 1', '0123456789', 'Ng??i giao 1', '0987654321', '2023-01-01', '2023-01-02', 'Ng??i t?o 1', 50000, 1, '8FACEBA8-58C4-4F96-9FD3-07D46A12955E', 'Ghi chú giao hàng 1', 1),
	( 'Ng??i nh?n 2', '0123456789', 'Ng??i giao 2', '0987654321', '2023-02-02', '2023-02-03', 'Ng??i t?o 2', 60000, 2, '994C64AE-22D1-4451-8A87-09462A307B80', 'Ghi chú giao hàng 2', 1),
	( 'Ng??i nh?n 3', '0123456789', 'Ng??i giao 3', '0987654321', '2023-03-03', '2023-03-04', 'Ng??i t?o 3', 70000, 3, 'B24684B2-4013-4FD2-B8A7-842FC58A427D', 'Ghi chú giao hàng 3', 1),
	( 'Ng??i nh?n 4', '0123456789', 'Ng??i giao 4', '0987654321', '2023-04-04', '2023-04-05', 'Ng??i t?o 4', 80000, 4, '58ABCBED-DDD4-40C1-A57B-D0CE205396B5', 'Ghi chú giao hàng 4', 1),
	( 'Ng??i nh?n 5', '0123456789', 'Ng??i giao 5', '0987654321', '2023-05-05', '2023-05-06', 'Ng??i t?o 5', 90000, 5, '232F4D14-7BDF-464E-98C9-F261F65C032A', 'Ghi chú giao hàng 5', 1),
	( 'Ng??i nh?n 6', '0123456789', 'Ng??i giao 6', '0987654321', '2023-06-06', '2023-06-07', 'Ng??i t?o 6', 100000, 6, 'EA27793D-AD58-4A7E-8FFA-FAAAF1BEE6DB', 'Ghi chú giao hàng 6', 1);
	*/
	( 'Ng??i nh?n 7', '0333232333', 'Ng??i giao 7', '0987654421', '2023-07-07', '2023-07-08', 'Ng??i t?o 7', 200000, 6, '58ABCBED-DDD4-40C1-A57B-D0CE205396B5', 'Ghi chú giao hàng 7', 1),
	( 'Ng??i nh?n 8', '0444434333', 'Ng??i giao 8', '0987654721', '2023-08-08', '2023-08-09', 'Ng??i t?o 8', 300000, 6, '8ECB0C4C-F003-4B53-B748-D7A15062370C', 'Ghi chú giao hàng 8', 1),
	( 'Ng??i nh?n 9', '0553434343', 'Ng??i giao 9', '0987654821', '2023-09-09', '2023-09-10', 'Ng??i t?o 9', 400000, 6, '232F4D14-7BDF-464E-98C9-F261F65C032A', 'Ghi chú giao hàng 9', 1),
	( 'Ng??i nh?n 10', '0188989999', 'Ng??i giao 10', '0987694321', '2023-10-10', '2023-10-11', 'Ng??i t?o 10', 500000, 6, 'EA27793D-AD58-4A7E-8FFA-FAAAF1BEE6DB', 'Ghi chú giao hàng 10', 1);



	INSERT INTO GioHang ( NgayTao, NgayCapNhap, NguoiSoHuu, GhiChu, TrangThai)
VALUES /*
	( '2023-01-01', '2023-01-02', 1, 'Ghi chú gi? hàng 1', 1),
	( '2023-02-02', '2023-02-03', 2, 'Ghi chú gi? hàng 2', 1),
	( '2023-03-03', '2023-03-04', 3, 'Ghi chú gi? hàng 3', 1),
	( '2023-04-04', '2023-04-05', 4, 'Ghi chú gi? hàng 4', 1),
	( '2023-05-05', '2023-05-06', 5, 'Ghi chú gi? hàng 5', 1),
	( '2023-06-06', '2023-06-07', 6, 'Ghi chú gi? hàng 6', 1);
	*/
	( '2023-07-07', '2023-07-08', 7, 'Ghi chú gi? hàng 7', 1),
	( '2023-08-08', '2023-08-09', 8, 'Ghi chú gi? hàng 8', 1),
	( '2023-09-09', '2023-09-10', 9, 'Ghi chú gi? hàng 9', 1),
	( '2023-10-10', '2023-10-11', 10, 'Ghi chú gi? hàng 10', 1);

	select * from GioHang

	INSERT INTO GioHangChiTiet (MaGioHang, MaSanPham, SoLuong, GhiChu, TrangThai)
VALUES /*
	('8C242ABF-DC0E-4C3A-AABF-124D5A75B7ED', 1, 2, 'Ghi chú chi ti?t gi? hàng 1', 1),
	('6E3D38D4-2217-4F75-B534-1C7E923A182B', 2, 3, 'Ghi chú chi ti?t gi? hàng 2', 1),
	('CF9E5809-4E44-4267-B931-2B8A7FD2671E', 3, 1, 'Ghi chú chi ti?t gi? hàng 3', 1),
	('3DA207E2-9396-4A32-BE86-2D3B210C40EA', 4, 2, 'Ghi chú chi ti?t gi? hàng 4', 1),
	('8100BB92-6EF3-40EE-BF53-3606C8ADFAB1', 5, 4, 'Ghi chú chi ti?t gi? hàng 5', 1),
	('61E3D427-573D-4A8E-A074-580EBEF76FA6', 6, 5, 'Ghi chú chi ti?t gi? hàng 6', 1);
	*/
	('DE8ADC87-7B09-4F96-960D-E7709DB962E6', 7, 6, 'Ghi chú chi ti?t gi? hàng 7', 1),
	('DF0138BB-78A3-4490-A95E-C9F029CA1BB5', 8, 7, 'Ghi chú chi ti?t gi? hàng 8', 1),
	('DF0138BB-78A3-4490-A95E-C9F029CA1BB5', 9, 8, 'Ghi chú chi ti?t gi? hàng 9', 1),
	('DE584686-3F3E-4DFF-A46F-F0C8773082B3',10, 9, 'Ghi chú chi ti?t gi? hàng 10', 1);


	INSERT INTO DanhSachYeuThich ( NgayTao, NgayCapNhap, NguoiSoHuu, GhiChu, TrangThai)
VALUES /*
	( '2023-01-01', '2023-01-02', 1, 'Ghi chú danh sách yêu thích 1', 1),
	( '2023-02-02', '2023-02-03', 2, 'Ghi chú danh sách yêu thích 2', 1),
	( '2023-03-03', '2023-03-04', 3, 'Ghi chú danh sách yêu thích 3', 1),
	( '2023-04-04', '2023-04-05', 4, 'Ghi chú danh sách yêu thích 4', 1),
	( '2023-05-05', '2023-05-06', 5, 'Ghi chú danh sách yêu thích 5', 1),
	( '2023-06-06', '2023-06-07', 6, 'Ghi chú danh sách yêu thích 6', 1);
	*/
	( '2023-07-07', '2023-07-08', 7, 'Ghi chú danh sách yêu thích 7', 1),
	( '2023-08-08', '2023-08-09', 8, 'Ghi chú danh sách yêu thích 8', 1),
	( '2023-09-09', '2023-09-10', 9, 'Ghi chú danh sách yêu thích 9', 1),
	( '2023-10-10', '2023-10-11', 10, 'Ghi chú danh sách yêu thích 10', 1);

	select * from DanhSachYeuThich

	INSERT INTO YeuThichChiTiet (MaDanhSach, MaSanPham, GhiChu, TrangThai)
VALUES /*
	('A1EB0B45-DDC2-45E8-9C5D-04CBA5D0AEC0', 1, 'Ghi chú chi ti?t danh sách yêu thích 1', 1),
	('3786B32B-76ED-4410-949B-288F2674098A', 2, 'Ghi chú chi ti?t danh sách yêu thích 2', 1),
	('77689E9D-526C-41BE-BB28-3F24A4094CE8', 3, 'Ghi chú chi ti?t danh sách yêu thích 3', 1),
	('97029D1C-DC3B-4D0D-98FF-5F9BD0A587FF', 4, 'Ghi chú chi ti?t danh sách yêu thích 4', 1),
	('FFCD1425-B398-48E0-ABF3-854EA2F308F3', 5, 'Ghi chú chi ti?t danh sách yêu thích 5', 1),
	('B8799344-8B16-4A3A-BFAC-D608D4E00E9F', 6, 'Ghi chú chi ti?t danh sách yêu thích 6', 1);
	*/
	('7BB26BD0-03E5-4586-80FF-34BFF0DBFD71', 7, 'Ghi chú chi ti?t danh sách yêu thích 7', 1),
	('1659F52E-FB5C-4DCC-B4BD-52EB87E39B02', 8, 'Ghi chú chi ti?t danh sách yêu thích 8', 1),
	('420904B7-93E7-442E-A8EA-C55454A99E87', 9, 'Ghi chú chi ti?t danh sách yêu thích 9', 1),
	('0C0A55C6-6F89-4C95-A9CF-F3EB90E5A10E', 10, 'Ghi chú chi ti?t danh sách yêu thích 10', 1);








