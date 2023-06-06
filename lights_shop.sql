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







