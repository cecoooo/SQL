create database usersystem;
use usersystem;

create table users(
	id int primary key auto_increment,
    username varchar(20) not null unique
);

create table articles(
	id int primary key auto_increment,
    title varchar(160) not null,
    content text not null,
    dateOfPublishing date,
    author_id int not null, 
    moderator_id int,
    foreign key(author_id) references users(id),
    foreign key(moderator_id) references users(id)
);

insert into users(username)
values("Petar"), ("Ivan"), ("Maria"), ("Philip");

insert into articles(title, content, dateOfPublishing, author_id, moderator_id)
values("Article 1", "Content of article 1...", "2012-03-12", 2, NULL),
       ("Article 2", "Content of article 2...", "2012-03-28", 3, NULL),
       ("Article 3", "Content of article 3...", "2012-04-04", 3, NULL),
       ("Article 4", "Content of article 4...", "2012-02-27", 2, NULL),
       ("Article 5", "Content of article 5...", "2012-03-28", 3, 1),
       ("Article 6", "Content of article 6...", "2012-04-04", 3, 2),
       ("Article 7", "Content of article 7...", "2012-02-27", 2, 1),
       ("Article 8", "Content of article 8...", "2012-02-27", 1, 2),
       ("Article 9", "Content of article 9...", "2012-02-27", 1, NULL);

select * from articles
join users on articles.author_id = users.id
where users.username = 'Ivan' and articles.moderator_id is null;

select u.username, sum(if(a.moderator_id is not null, 1, 0)) as aproved, 
sum(if(a.moderator_id is null, 1, 0)) as unaproved
from users as u join articles as a on a.author_id = u.id
group by u.id;
