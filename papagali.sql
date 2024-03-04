create database papagali;
use papagali;

create table Roles(
	id int primary key,
    type varchar(50) not null
);

create table Users(
	id int primary key,
    address varchar(200) not null,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
	phone varchar(10) not null,
    role_id int not null,
    foreign key(role_id) references Roles(id)
);

create table User_Logins(
	id int primary key,
    ip varchar(50) not null,
    date datetime not null,
    user_id int not null,
    foreign key(user_id) references Users(id)
);

create table Products(
	id int primary key,
    name varchar(100) not null,
    description varchar(1000) not null
);

create table Images(
	id int primary key,
    URL varchar(200) not null,
    product_id int not null,
    foreign key(product_id) references Products(id)
);

create table Articles(
	id int primary key,
    title varchar(200) not null,
    price decimal(9,2) not null,
    publish_date datetime not null,
    product_id int not null,
    foreign key(product_id) references Products(id)
);

create table Comments(
	id int primary key,
    content varchar(1000) not null,
    rating decimal(3,2),
    publish_date datetime not null,
    user_id int not null,
    article_id int not null,
    foreign key(user_id) references Users(id),
    foreign key(article_id) references Articles(id)
);

create table Paymanent_methods(
	id int primary key,
    type varchar(50) not null
);

create table Deliverers(
	id int primary key,
    name varchar(200) not null,
    price_to_deliver_in_Bulgaria decimal not null,
    price_to_deliver_in_EU decimal not null,
    price_to_deliver_outside_EU decimal not null,
    increase_price_to_deliver_over_30kg decimal not null
);

create table Orders(
	id int primary key,
    purchase_date datetime not null,
    paymanent_method_id int not null,
    deliverer_id int not null,
    total_sum decimal not null,
    foreign key(paymanent_method_id) references Paymanent_methods(id),
    foreign key(deliverer_id) references Deliverers(id)
);

create table Article_Orders(
    article_id int not null,
    order_id int not null,
    primary key(article_id, order_id)
);

create table Turgs(
	id int primary key,
    start_date datetime not null,
    end_date datetime not null,
    start_bid decimal not null,
    last_bid decimal not null,
    user_id int not null,
    foreign key(user_id) references Users(id)
);