create database lights_shop;
use lights_shop;

create table customers(
	id int primary key auto_increment,
    name varchar(50),
    email varchar(20),
    phone varchar(10),
    city varchar(50)
);

create table orders(
	id int primary key auto_increment,
	order_date datetime,
    firm_name varchar(50),
    is_filled boolean,
    customer_id int,
    foreign key(customer_id) references customers(id)
);

create table models(
	id int primary key auto_increment,
    price double, 
    power int,
    name_light varchar(50),
    quantity_left int
);

create table ordered_product(
	id int primary key auto_increment,
    quantity int,
    model_id int,
    order_id int,
    foreign key(model_id) references models(id),
    foreign key(order_id) references orders(id) 
);

insert into models(price, power, name_light, quantity_left)
values(88.90, 6, "desk lamp", 100),
(20.00, 6, "ceiling lamp", 160),
(31.90, 12, "LED", 100),
(2.30, 9, "bulb", 1000),
(213.90, 40, "chandelier", 5);


select * from customers;

create event deliveryTrue
on schedule at current_timestamp() + interval 3 day
on completion preserve
do
update orders
set is_filled = true
where order_date = current_timestamp() - interval 3 day;


