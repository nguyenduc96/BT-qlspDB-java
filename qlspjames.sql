create database QLBHDB;

use qlbhDB;

create table customers (
cId int auto_increment primary key,
cName varchar(50) not null,
cAge int not null,
constraint `Kiem tra tuoi` check (cAge between 16 and 70)
);

create table orders (
oId int auto_increment primary key,
cId int,
foreign key (cId) references customers(cId),
oDate date not null,
oTotalPrice double
);

create table products (
pId int auto_increment primary key,
pName varchar(50) not null,
pPrice double 
);

create table oderdetails (
oId int references orders(oId),
pId int references products(pId),
odQTY int not null,
constraint orderdetail_key primary key (oId, pId)
);

insert into customers(cName, cAge)
values ('Minh Quan', 20);

insert into customers(cName, cAge)
values ('Ngoc Anh', 40);

insert into customers(cName, cAge)
values ('Hong Ha', 30);

insert into orders(cId, odate)
values (1, 9/19/2021);

insert into orders(cId, odate)
values (2, 8/19/2021);

insert into orders(cId, odate)
values (1, 7/19/2021);

insert into products (pName, pPrice)
values ('May giat', 4000);

insert into products (pName, pPrice)
values ('Dieu hoa', 5000);

insert into products (pName, pPrice)
values ('Tu lanh', 3500);

insert into products (pName, pPrice)
values ('Ti vi', 3000);

insert into products (pName, pPrice)
values ('Lo vi song', 2000);

insert into products (pName, pPrice)
values ('Bep tu', 1000);

insert into oderdetails (oId, pId, odQTY)
values (1, 4, 5);

insert into oderdetails (oid, pid, odQTY)
values (1, 2, 8);

insert into oderdetails (oid, pid, odQTY)
values (1, 3, 7);

insert into oderdetails (oid, pid, odQTY)
values (2, 1, 2);

insert into oderdetails (oid, pid, odQTY)
values (2, 2, 6);

insert into oderdetails (oid, pid, odQTY)
values (2, 3, 2);

insert into oderdetails (oid, pid, odQTY)
values (3, 3, 3);

insert into oderdetails (oid, pid, odQTY)
values (3, 1, 4);

-- hiển thị thông tin bảng orders
select oId, odate, ototalprice
from orders;

-- hiển thị danh sách khách hàng đã mua hàng
select *
from orders
where cid = any (
select cid 
from oderdetails
);

-- danh sách sản phẩm đã được mua
select * 
from products
where pid = any (
select pid
from oderdetails
);

-- khách hàng chưa mua sp nào
select * 
from customers
where cid <> any (
select cid 
from oderdetails
);

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
select orders.oID,orders.oDate, sum(products.pPrice* oderdetails.odQTY) as totalpayment
	from orders
    left join oderdetails on orders.oID = oderdetails.oid
    left join products on oderdetails.pID = products.pId
    group by orders.oId;

