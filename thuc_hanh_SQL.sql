CREATE TABLE Khoa (
    MaKhoa SERIAL PRIMARY KEY,
    TenKhoa VARCHAR(100) NOT NULL
);

-- Tạo bảng Lop
CREATE TABLE Lop (
    MaLop SERIAL PRIMARY KEY,
    TenLop VARCHAR(100) NOT NULL,
    MaKhoa INT NOT NULL,
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa) ON DELETE CASCADE
);

-- Tạo bảng SinhVien
CREATE TABLE SinhVien (
    MaSV SERIAL PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    GioiTinh VARCHAR(10) CHECK (GioiTinh IN ('Nam', 'Nữ')),
    NgaySinh DATE NOT NULL,
    MaLop INT NOT NULL,
    HocBong NUMERIC(10,0) DEFAULT 0,
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop) ON DELETE CASCADE
);

-- Tạo bảng MonHoc
CREATE TABLE MonHoc (
    MaMH SERIAL PRIMARY KEY,
    TenMH VARCHAR(100) NOT NULL,
    SoTiet INT CHECK (SoTiet > 0)
);

-- Tạo bảng KetQua
CREATE TABLE KetQua (
    MaSV INT NOT NULL,
    MaMH INT NOT NULL,
    DiemThi NUMERIC(4,2) CHECK (DiemThi BETWEEN 0 AND 10),
    PRIMARY KEY (MaSV, MaMH),
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV) ON DELETE CASCADE,
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH) ON DELETE CASCADE
);


--  Liệt kê danh sách sinh viên (MaSV, HoTen, TenLop, TenKhoa) thuộc về từng khoa.
select MaSV, HoTen, TenLop, TenKhoa from SinhVien
join Lop on Lop.Malop = SinhVien.Malop
join Khoa on Khoa.makhoa = lop.makhoa

--  Tìm các sinh viên có điểm thi lớn hơn 8 ở bất kỳ môn học nào.
select ketqua.masv, HoTen, ketqua.MaMH, TenMH, DiemThi from KetQua
join SinhVien on SinhVien.masv= ketqua.masv
join monhoc on monhoc.mamh = ketqua.mamh
where DiemThi > 8

--  Liệt kê danh sách sinh viên cùng với số lượng môn học mà họ đã tham gia.
select KetQua.MaSV, HoTen , count(KetQua.MaMH) from KetQua
join sinhvien on sinhvien.MaSV = KetQua.MaSV
group by KetQua.MaSV, HoTen 

--  Tìm danh sách các lớp và số lượng sinh viên trong từng lớp.
select TenLop, count(MaSV) as SLSV from lop
join SinhVien on SinhVien.malop=lop.malop
group by TenLop

--  Liệt kê danh sách sinh viên cùng với tổng số tiết học của các môn mà họ đã đăng ký.
select HoTen, TenMH, SoTiet from sinhvien
join ketqua on ketqua.masv = sinhvien.masv
join monhoc on  monhoc.mamh = ketqua.mamh

-- Liệt kê danh sách khoa và tổng số sinh viên của từng khoa.
select tenkhoa , count(MaSV) as "So luong SV" from khoa
join lop on lop.makhoa = khoa.makhoa
join sinhvien on sinhvien.malop = lop.malop
group by tenkhoa

--  Tìm những sinh viên chưa tham gia thi môn nào.
select masv, hoten from sinhvien
where masv not in (select masv from ketqua)

--  Liệt kê các sinh viên có điểm trung bình lớn hơn 5 và sắp xếp theo thứ tự tăng dần.
select hoten, avg(diemthi) from sinhvien
join ketqua on sinhvien.masv=ketqua.masv
group by hoten
having avg(diemthi) > 5
order by avg(diemthi) asc

--  Tìm sinh viên có học bổng cao nhất trong từng lớp.
select hoten, hocbong from sinhvien order by hocbong desc limit 1

--  Tìm sinh viên có điểm cao nhất trong từng môn học.
select hoten, diemthi, tenmh from ketqua as kq
join sinhvien on sinhvien.masv = kq.masv
join monhoc on monhoc.mamh=kq.mamh
where diemthi = ( select max(diemthi) from ketqua as kq2 where kq2.mamh=kq.mamh)

--  Tìm môn học có số tiết nhiều nhất.
select tenmh, sotiet from monhoc order by sotiet desc limit 1

--  Liệt kê sinh viên cùng với tổng số môn đã học và tổng điểm trung bình.
select hoten, count(mamh), avg(diemthi) from ketqua
join sinhvien on sinhvien.masv=ketqua.masv
group by hoten

--  Tìm những môn học mà tất cả sinh viên trong một lớp đều đã thi.
select monhoc.tenmh, lop.tenlop from monhoc
join ketqua on ketqua.mamh = monhoc.mamh
join sinhvien on sinhvien.masv=ketqua.masv
join lop on lop.malop=sinhvien.malop
group by monhoc.tenmh, lop.tenlop, lop.malop, diemthi
having count(distinct ketqua.masv) = (select count(sv2.masv) from sinhvien as sv2 where sv2.malop = lop.malop and diemthi>0);

--  Liệt kê các sinh viên có cùng điểm số trong một môn học cụ thể.
select hoten, tenmh, diemthi from monhoc
join ketqua on ketqua.mamh = monhoc.mamh
join sinhvien on sinhvien.masv = ketqua.masv 
where lower(tenmh)= 'Cơ sở dữ liệu' and ketqua.diemthi in (select diemthi from ketqua where )

--  Tìm danh sách sinh viên theo khoa, kèm theo tổng điểm thi trung bình của họ.
select hoten, tenkhoa, avg(DiemThi) from ketqua
join sinhvien on sinhvien.masv=ketqua.masv
join lop on lop.malop = sinhvien.malop
join khoa on khoa.makhoa=lop.makhoa
group by hoten, tenkhoa

--  Liệt kê danh sách các khoa mà có ít nhất 2 lớp.
select tenkhoa, count(lop.MaKhoa) from khoa
join lop on lop.makhoa = khoa.makhoa
group by tenkhoa
having count(lop.MaKhoa) >=2

-- Tìm danh sách sinh viên có điểm thi cao nhất trong toàn bộ hệ thống.
select hoten, diemthi from ketqua
join sinhvien on sinhvien.masv=ketqua.masv
where 

