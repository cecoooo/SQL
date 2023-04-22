create database forum;
use forum;

create table users(
	id int primary key auto_increment,
    username varchar(30) not null unique,
    pass varchar(30) not null,
    is_admin boolean default false
)auto_increment = 1;

create table articles(
	id int primary key auto_increment,
    title varchar(160) not null,
	content text not null,
    time_of_pub datetime
)auto_increment = 1;

create table comments(
	id int primary key auto_increment,
    content text not null,
    time_of_pub datetime,
    user_id int not null,
    article_id int not null,
    foreign key(user_id) references users(id),
    foreign key(article_id) references articles(id)
)auto_increment = 1;

create table admins_articles(
	admin_id int not null,
    article_id int not null,
    foreign key(admin_id) references users(id),
    foreign key(article_id) references articles(id),
    primary key(admin_id, article_id)
);

delimiter $
create trigger before_insert_article
before insert
on articles for each row
begin 
    set new.time_of_pub = current_timestamp();
end $
delimiter ;

delimiter $
create trigger before_insert_comments
before insert
on comments for each row
begin 
    set new.time_of_pub = current_timestamp;
end $
delimiter ;

delimiter $
create trigger before_insert_users
before insert
on users for each row
begin
	if(length(new.username) < 4) then call create_error('name');
    elseif(length(new.pass) < 6) then call create_error('pass');
    end if;
end $
delimiter ;

delimiter $
create procedure create_error(arg varchar(4))
begin
	set @mess = '';
	if(arg = 'name') then
		set @mess = 'Username must be at least 4 symbols long.';
	elseif(arg = 'pass') then
		set @mess = 'Password must be at least 6 symbols long.';
	elseif(arg = 'adm') then
		set @mess = 'User has no admin rights to create articles.';
	end if;
    signal sqlstate '45000' set message_text = @mess;
end $
delimiter ;

delimiter $
create trigger before_insert_admins_articles
before insert
on admins_articles for each row
begin
    if((select is_admin from users where id = new.admin_id) = false) then
		call create_error('adm');
	end if;
end $
delimiter ;

insert into users(username, pass, is_admin)
values('gosho69', 'qfwfwe42533', true),
('ivan68', 'fwerf-09t24', true),
('niki67', 'vregr054', false),
('razbiva4anajenskisurca', 'f3r34342', false),
('cocaineking', 'fee423', true),
('lookatmynudes', 'gwer32432', true);

insert into articles(title , content)
values('What is Lorem Ipsum?', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
('Where does it come from?', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'),
('Why do we use it?', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using "Content here, content here", making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for "lorem ipsum" will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'),
('Where can I get some?', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which do not look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there is not anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'),
('The standard Lorem Ipsum passage, used since the 1500s', '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."');

insert into admins_articles()
values(1, 1),
(1, 2),
(2, 2),
(1, 3),
(5, 5), 
(6, 5), 
(1, 5),
(2, 4);

insert into comments(content, user_id, article_id)
values('mnoo dubra statiq!', 3, 4),
('Ok', 4, 5),
('ni sam suglasna, molq vi sa kakvi sa teq raboti deto pishete', 2, 5),
('Po komunisti4esko vreme be6e po-dobre', 5, 1),
('Ne vi li e sram! Sasipaha q taq darjava!', 5, 2),
('Horata komentira6ti nad mene sa idioti', 6, 3);

delimiter $
create procedure show_comments_by_user(usname varchar(30), pass varchar(30))
begin
	select c.content from comments as c
	join users as u on u.id = c.user_id
    where u.username = usname and u.pass = pass
    order by time_of_pub;
end $
delimiter ;

call show_comments_by_user('cocaineking', 'fee423');

