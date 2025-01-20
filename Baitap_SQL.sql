--Ví dụ 1: Liệt kê danh sách các lớp của khoa, 
--thông tin cần Malop, TenLop, MaKhoa

select * from lop

--Ví dụ 2: Lập danh sách sinh viên gồm: 
--MaSV, HoTen, HocBong
select masv, hoten, hocbong from sinhvien

--Ví dụ 3: Lập danh sách sinh viên có học bổng.
--Danh sách cần MaSV, GioiTinh, HocBong
select MaSV, GioiTinh, HocBong from sinhvien


--Ví dụ 4: Lập danh sách sinh viên nữ.
--Danh sách cần các thuộc tính của quan hệ sinhvien
Select * from sinhvien where GioiTinh='Nu'

--Ví dụ 5: Lập danh sách sinh viên có họ ‘Trần'
Select * from sinhvien where hoten like 'Tran%'


--Ví dụ 6: Lập danh sách sinh viên nữ có học bổng
select * from sinhvien where hocbong > 0 and gioitinh='Nu'

--Ví dụ 7: Lập danh sách sinh viên nữ hoặc danh sách sinh viên có học bổng
select * from sinhvien where hocbong > 0 or gioitinh='Nu'


--Ví dụ 8: Lập danh sách sinh viên có năm sinh từ 1978 đến 1985. 
--Danh sách cần các thuộc tính của quan hệ SinhVien
select * from sinhvien where ngaysinh between '1978-01-01' and '1985-12-31'

--Ví dụ 9: Liệt kê danh sách sinh viên được sắp xếp tăng dần theo MaSV
select * from sinhvien order by masv


--Ví dụ 10: Liệt kê danh sách sinh viên được sắp xếp giảm dần theo HocBong
select * from sinhvien order by HocBong


--Ví du11: Lập danh sách sinh viên có điểm thi môn CSDL>=8
Select sv.masv, sv.hoten, mh.tenmh, kq.diemthi from sinhvien sv
inner join ketqua kq on sv.masv = kq.masv
inner join monhoc mh on kq.mamh = mh.mamh 
where kq.diemthi >= 8 and mh.mamh='MH002'

--Ví du 12: Lập danh sách sinh viên có học bổng của khoa CNTT. 
--Thông tin cần: MaSV, HoTen, HocBong,TenLop
select sv.masv, sv.hoten, sv.hocbong, lop.tenlop, khoa.tenkhoa from sinhvien sv
inner join lop on lop.malop=sv.malop
inner join khoa on khoa.makhoa=lop.makhoa
where lower(khoa.tenkhoa)='công nghệ thông tin'


--Ví du 13: Lập danh sách sinh viên có học bổng của khoa CNTT.
--Thông tin cần: MaSV, HoTen, HocBong,TenLop, TenKhoa
select sv.masv, sv.hoten, sv.hocbong, lop.tenlop, khoa.tenkhoa from sinhvien sv
inner join lop on lop.malop=sv.malop
inner join khoa on khoa.makhoa=lop.makhoa
where lower(khoa.tenkhoa)='công nghệ thông tin' and sv.hocbong>0


--Ví dụ 14: Cho biết số sinh viên của mỗi lớp
select lop.tenlop, count(sv.masv) as soluongSV from lop
join sinhvien sv on sv.malop=lop.malop
group by lop.tenlop


--Ví dụ 15: Cho biết số lượng sinh viên của mỗi khoa.
select khoa.makhoa, khoa.tenkhoa , count(sv.masv) as soluongSVkhoa from khoa
join lop on lop.makhoa=khoa.makhoa
join sinhvien sv on lop.malop=sv.malop
group by khoa.makhoa, khoa.tenkhoa;


--Ví dụ 16: Cho biết số lượng sinh viên nữ của mỗi khoa.
select khoa.makhoa, khoa.tenkhoa, count(sinhvien.masv) as soluongSVkhoa from khoa
join lop on lop.makhoa=khoa.makhoa
join sinhvien  on lop.malop=sinhvien.malop
where lower(sinhvien.gioitinh)='nu'
group by khoa.makhoa, khoa.tenkhoa


--Ví dụ 17: Cho biết tổng tiền học bổng của mỗi lớp
select lop.malop, lop.tenlop, sum(sinhvien.hocbong) as tongHB from lop
join sinhvien on lop.malop=sinhvien.malop
where sinhvien.hocbong >0
group by lop.malop, lop.tenlop;


--Ví dụ 18: Cho biết tổng số tiền học bổng của mỗi khoa
select khoa.makhoa, khoa.tenkhoa, sum(sinhvien.hocbong) as tongHB from khoa
join lop on lop.makhoa = khoa.makhoa
join sinhvien on sinhvien.malop=lop.malop
where sinhvien.hocbong>0
group by khoa.makhoa, khoa.tenkhoa;


--Ví dụ 19: Lập danh sánh những khoa có nhiều hơn 1 sinh viên.
--Danh sách cần: MaKhoa, TenKhoa, Soluong
select khoa.makhoa, khoa.tenkhoa, count(sinhvien.masv) as soluongSV from khoa
join lop on lop.makhoa=khoa.makhoa
join sinhvien on sinhvien.malop=lop.malop
group by khoa.makhoa, khoa.tenkhoa
having count(sinhvien.masv) > 1

--Ví dụ 20: Lập danh sánh những khoa có nhiều hơn 1 sinh viên nữ.
--Danh sách cần: MaKhoa, TenKhoa, Soluong
select khoa.makhoa, khoa.tenkhoa, sinhvien.gioitinh, count(sinhvien.masv) as soluongSV from khoa
join lop on lop.makhoa=khoa.makhoa
join sinhvien on sinhvien.malop=lop.malop
where lower(sinhvien.gioitinh)='nu' 
group by khoa.makhoa, khoa.tenkhoa, sinhvien.gioitinh
having count(sinhvien.masv) > 1 

--Ví dụ 21: Lập danh sách những khoa có tổng tiền học bổng >=2000.
select khoa.makhoa, khoa.tenkhoa, sum(sinhvien.hocbong) as tongHB from khoa
inner join lop on lop.makhoa=khoa.makhoa
join sinhvien on sinhvien.malop=lop.malop
group by khoa.makhoa, khoa.tenkhoa
having sum(sinhvien.hocbong) >2000

--Ví dụ22: Lập danh sách sinh viên có học bổng cao nhất
select masv, hoten, hocbong from sinhvien where hocbong = (select max(hocbong) from sinhvien)

--Ví dụ 23: Lập danh sách sinh viên có điểm thi môn CSDL cao nhất
select sv.masv, sv.hoten, mh.tenmh from sinhvien sv 
join ketqua kq on kq.masv=sv.masv
join monhoc mh on mh.mamh=kq.mamh
where lower(mh.tenmh) = 'cơ sở dữ liệu' and kq.diemthi = (select max(ketqua.diemthi) from ketqua 
join monhoc on ketqua.mamh=monhoc.mamh and lower(monhoc.tenmh)='cơ sở dữ liệu')
group by sv.masv, sv.hoten, mh.tenmh;

select * from ketqua
--Ví dụ 24: Lập danh sách những sinh viên không có điểm thi môn CSDL
select sv.masv, sv.hoten, mh.tenmh from sinhvien sv 
join ketqua kq on kq.masv=sv.masv
join monhoc mh on mh.mamh=kq.mamh
where lower(mh.tenmh) = 'cơ sở dữ liệu' and kq.diemthi=0


--Ví dụ 25: Cho biết những khoa nào có nhiều sinh viên nhất
select khoa.makhoa, khoa.tenkhoa, count(sv.masv) as soluongSV from khoa
join lop on lop.makhoa=khoa.makhoa
join sinhvien sv on sv.malop=lop.malop
group by khoa.makhoa, khoa.tenkhoa
order by soluongSV DESC LIMIT 1


--Ví dụ 25: Cho biết những khoa nào có nhiều sinh viên nhất
select khoa.makhoa, khoa.tenkhoa, count(sinhvien.masv) as soluongSV from sinhvien
join lop on lop.malop=sinhvien.malop
join khoa on khoa.makhoa=lop.makhoa
group by khoa.makhoa, khoa.tenkhoa
having count(sinhvien.masv)= (select max(subquery.soluongSV) from (select count(sinhvien.masv) as soluongSV
from sinhvien
join lop on lop.malop=sinhvien.malop
join khoa on khoa.makhoa=lop.makhoa
group by khoa.makhoa) as subquery)


