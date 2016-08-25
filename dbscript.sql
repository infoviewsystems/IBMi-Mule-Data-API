--*CRT: RUNSQLSTM COMMIT(*NONE) ERRLVL(30)                      :*
create schema muledemos;
set schema muledemos;

drop view productpricev1;
drop view inventoryv1;
drop table inventory;
drop table productprice;
drop table product;

-- Product Master
create table WTF400DEV/PRODUCT  (
  id          bigint not null generated always as identity primary key,
  name        char(30) not null unique,
  active      char(1) check (active in ('Y','N')) not null);

-- Product Price
create table WTF400DEV/PRODUCTPRICE (
  id          bigint not null generated always as identity
              primary key,
  productid   bigint not null,

  pricegroup char(10) not null,
  price       decimal(11, 5) not null default 0,
  constraint uk_product_price unique (productid, pricegroup),
  constraint fk_product_price foreign key (productid)
     references product (id) on delete cascade);

 create view productpricev1 as
   (select prc.productid, p.name as productName,
    prc.pricegroup, prc.price from
    product p join productprice prc on p.id = prc.productid);

-- Perpetual Inventory
create table WTF400DEV/INVENTORY  (
  id          bigint not null generated always as identity
              primary key,
  productid   bigint not null,
  storewhsid  bigint not null,
  locationid  bigint not null,
  bucket      char(20) not null,
  quantity    decimal(7, 0) not null,
  constraint uk_inventory unique (productid, storewhsid, locationid, bucket),
  constraint fk_product_inv   foreign key (productid)
     references product (id) on delete cascade);

create view inventoryv1    as
  (select inv.productid,  p.name as productName,
   inv.storewhsid, inv.locationid, inv.bucket, inv.quantity
   from product p join inventory inv on p.id = inv.productid);

-- Populate test data
 insert into product (name, active) values('TABLE', 'Y');
 insert into product (name, active) values('CHAIR', 'Y');
 insert into product (name, active) values('TV'   , 'Y');

 insert into productprice (productid, pricegroup, price)
 values (1, 'REGULAR', 100.00);
 insert into productprice (productid, pricegroup, price)
 values (1, 'SALE'   ,  80.00);
 insert into productprice (productid, pricegroup, price)
 values (2, 'REGULAR',  50.00);
 insert into productprice (productid, pricegroup, price)
 values (2, 'SALE'   ,  40.00);
 insert into productprice (productid, pricegroup, price)
 values (3, 'REGULAR', 500.00);
 insert into productprice (productid, pricegroup, price)
 values (3, 'SALE'   , 450.00);

 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 1, 1, 'ON HAND',10) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 1, 1, 'DISPLAY',1)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 1, 1, 'DAMAGED',2)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 1, 1, 'RESERVED',2) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 2, 1, 'ON HAND',20) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 2, 1, 'DISPLAY',2)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 2, 1, 'DAMAGED',3)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(1, 2, 1, 'RESERVED',3) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 1, 1, 'ON HAND',10) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 1, 1, 'DISPLAY',1)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 1, 1, 'DAMAGED',2)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 1, 1, 'RESERVED',2) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 2, 1, 'ON HAND',20) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 2, 1, 'DISPLAY',2)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 2, 1, 'DAMAGED',3)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(2, 2, 1, 'RESERVED',3) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 1, 1, 'ON HAND',10) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 1, 1, 'DISPLAY',1)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 1, 1, 'DAMAGED',2)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 1, 1, 'RESERVED',2) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 2, 1, 'ON HAND',20) ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 2, 1, 'DISPLAY',2)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 2, 1, 'DAMAGED',3)  ;
 insert into inventory (productid, storewhsid, locationid, bucket,
 quantity) values(3, 2, 1, 'RESERVED',3) ;
