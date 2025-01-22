create table account(
id_acc serial primary key,
username VARCHAR(50),
password VARCHAR(50),
fullname VARCHAR(50),
phone VARCHAR(10),
address VARCHAR(100),
role VARCHAR(10),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table categories (
id_categories serial primary key,
name_category VARCHAR(100),
description VARCHAR(1000),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table products (
id_products serial primary key,
id_categories INTEGER,
name_products VARCHAR(100),
price DECIMAL(10 ,3),
quantity INTEGER,
description CHAR(1000),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
foreign key (id_categories) references categories(id_categories)
);

create table carts (
id_carts serial primary key,
id_acc INTEGER,
id_products INTEGER,
quantity INTEGER,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
foreign key (id_acc) references account(id_acc),
foreign key (id_products) references products(id_products)
);

create table transport (
id_transports serial primary key,
name_transports VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table payments (
id_payments serial primary key,
namepayments VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table oders (
oders_id serial primary key,
serial_number VARCHAR(100) unique,
id_carts INTEGER,
id_payments INTEGER,
order_quantity INTEGER,
price DECIMAL(10 ,3),
total DECIMAL(10 ,3),
status VARCHAR(50),
note VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
received_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
foreign key (id_carts) references carts(id_carts),
foreign key (id_payments) references payments(id_payments)
);

create table oder_details (
id_details serial primary key,
oders_id INTEGER,
id_products INTEGER,
name_products VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
foreign key (oders_id) references oders(oders_id),
foreign key (id_products) references products(id_products)
);


--insert dữ liệu mới
select * from account
insert into account (id_acc, username, password, fullname, phone, address, role)
values
(1, 'user1', '123456', 'user1', '0953418752', 'address1', 'user'),
(2, 'user2', '123456', 'user2', '0568235627', 'address2', 'user'),
(3, 'user3', '123456', 'user3', '0537253725', 'address3', 'user'),
(4, 'admin', '123456', 'admin', '0953418752', 'address1', 'admin')

select * from products

insert table products (id_products, id_categories, name_products, price, quantity, description)
values
(1, 1, 'ao 1', 12000, 100, ''),
(2, 1, 'ao 2', 22222, 100, ''),
(3, 1, 'ao 3', 99999, 100, '')

select * from carts

insert table carts (id_carts, id_acc, id_products, quantity)
values
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3)

select * from categories
insert table categories (id_categories, name_category, description)
values 
(1, 'áo phông', ''),
(2, 'quần jean', '')

select * from transport
drop table if exists transport;
insert into transport (id_transports, name_transports)
values
(1, 'GHTK'),
(2, 'GHN')

select * from oders
insert into oders (oders_id, serial_number, id_carts, id_payments, order_quantity, price, total, status, note)
values
(1, 'DH01', 1,1,1,12000, 12000, 'đang xét duyệt', ''),
(2, 'DH02', 2, 2,2, 22222, 22222, 'hoàn thành', '')

drop table if exists oders;

select * from oder_details

insert into oder_details (id_details, oders_id, id_products, name_products)
values
(1, 1, 1, 'áo phông 1'),
(2, 2, 2, 'áo phông 2')


drop table if exists oder_details

insert table payments (id_payments, namepayments)

-- Thực hiện yêu cầu sql


--1, Lấy danh sách tất cả các tài khoản trong bảng account.
select * from account

--2, Tìm các tài khoản có vai trò là "admin".
select * from account where role='admin'

--3, Đếm số lượng tài khoản đã được tạo.
select count(id_acc) as "tài khoản đc tạo" from account 

--4, Lấy thông tin các sản phẩm có giá lớn hơn 1000.
select * from products where price > 1000

--5, Tìm sản phẩm có giá cao nhất trong bảng products.
select * from products where price = (select max(price) from products)

--6, Tìm số lượng sản phẩm thuộc từng danh mục trong bảng products.
select c.name_category, count(id_products) from products p 
join categories c on c.id_categories = p.id_categories
group by c.name_category

--8, Lấy danh sách các đơn hàng đã được tạo trong bảng oders.
select * from oders

--9, Tìm danh sách các sản phẩm trong giỏ hàng của tài khoản có id_acc = 1.
select * from carts where id_acc = 1

--10, Tìm các danh mục (categories) có nhiều hơn 2 sản phẩm.
select c.id_categories, c.name_category, count(id_categories) from categories cc
join products p on p.id_categories = c.id_categories 

