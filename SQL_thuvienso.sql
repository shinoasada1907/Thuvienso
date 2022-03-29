use master
go

if(exists(select name from master.sys.databases where name = 'thuvienso'))
drop database thuvienso
go

create database thuvienso
go

use thuvienso
go

create table giangvien(
	magv varchar(10) not null,
	hoten nvarchar(50) not null,
	khoa nvarchar(20) not null,
	constraint pk_giangvien primary key (magv))
	go

create table sinhvien(
	masinhvien varchar(10) not null,
	manganh varchar(10) not null,--khóa ngoại
	hoten nvarchar(50) not null,
	gioitinh nchar(5) not null,
	ngaysinh date not null,
	constraint pk_sinhvien primary key (masinhvien))
	go

create table nganhhoc(
	manganh varchar(10) not null,
	tennganh nvarchar(50) not null,
	tenkhoa int not null,
	chuyennganh nvarchar(30) not null,
	constraint pk_ngahghoc primary key (manganh))
	go

create table sach(
	masach varchar(10) not null,
	madanhmuc varchar(10) not null,--khóa ngoại
	manganh varchar(10) not null,--khóa ngoại
	magv varchar(10) not null,--khóa ngoại
	tacgia nvarchar(50) not null,
	tensach nvarchar(50) not null,
	namxb int not null,
	constraint pk_sach primary key (masach))
	go

create table danhmuc(
	madanhmuc varchar(10) not null,
	tendanhmuc nvarchar(50) not null,
	constraint pk_danhmuc primary key (madanhmuc))
	go

create table thongtintai(
	masach varchar(10) not null,--khóa ngoại
	masinhvien varchar(10),--khóa ngoại
	ngaytai date not null,
	constraint pk_thongtintai primary key (masach,masinhvien))
	go

create table thongtindang(
	masach varchar(10) not null,--khóa ngoại
	magv varchar(10) not null,--khóa ngoại
	ngaydang date not null,
	constraint pk_thongtindang primary key (masach,magv))
	go

create table taikhoan(
	username varchar(50) not null,
	passwords varchar(max) not null,
	masinhvien varchar(10) null,--khóa ngoại
	magv varchar(10) null,--khóa ngoại
	constraint pk_taikhoan primary key (username))
	go

--khoá ngoại bảng sách
alter table sach add constraint fk_danhmuc foreign key (madanhmuc) references danhmuc (madanhmuc)
go
alter table sach add constraint fk_nganhhoc foreign key (manganh) references nganhhoc (manganh)
go
alter table sach add constraint fk_giangvien foreign key (magv) references giangvien (magv)
go

--khóa ngoại bảng sinh viên
alter table sinhvien add constraint fk_sv_nganhhoc foreign key (manganh) references nganhhoc (manganh)
go

--khóa ngoại bảng thông tin tải về
alter table thongtintai add constraint fk_thongtin_sach foreign key (masach) references sach (masach)
go
alter table thongtintai add constraint fk_thongtin_sinhvien foreign key (masinhvien) references sinhvien(masinhvien)
go

--khóa ngoại bảng thông tin đăng
alter table thongtindang add constraint fk_dang_sach foreign key (masach) references sach (masach)
go
alter table thongtindang add constraint fk_dang_giangvien foreign key (magv) references giangvien (magv)
go

--khóa ngoại bảng tài khoản
alter table taikhoan add constraint fk_taikhoan_sinhvien foreign key (masinhvien) references sinhvien (masinhvien)
go
alter table taikhoan add constraint fk_taikhoan_giangvien foreign key (magv) references giangvien (magv)
go