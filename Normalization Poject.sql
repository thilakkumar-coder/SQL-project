create database college;
use college;

-- 1nf Normalization--------------

Create table student_before_1nf(student_id int,student_name varchar(40),age int,Courses varchar(30),faculty varchar(40),city varchar(30));
insert into student_before_1nf(student_id,student_name,age,courses,faculty,city)values
	(1,'Arunkumar',20,'DBMS,Java','Dr.Ravi,Dr,Meena','Chennai'),
	(2,'Priya Sharma',19,'Java','Dr,Meena','Coimbatore'),
	(3,'Rahul Raj','21','Python,Data Science','Dr.Suresh,Dr.Kumar','Madurai');

select * from student_before_1nf;

create table student_1nf(student_id int,student_name varchar(40),age int,courses varchar(30),faculty varchar(40),city varchar(30));
insert into student_1nf(student_id,student_name,age,courses,faculty,city)values
	(1,'Arun Kumar',20,'DBMS','Dr.Ravi','Chennai'),
	(1,'Arun Kumar',20,'Java','Dr.Meena','Chennai'),
	(2,'Priya Sharma',19,'Java','Dr.Meena','Coimbatore'),
	(3,'Rahul Raj',21,'Python','Dr,Suresh','Madurai'),
	(3,'Rahul Raj',21,'Data Science','Dr.Suresh','Madurai');

select * from student_1nf;

-- 2nf Normalization-------------

create table student_2nf(student_id int primary key,student_name varchar(40),age int,city varchar(30));
insert into student_2nf(student_id,student_name,age,city)values
	(1,'Arun Kumar',20,'Chennai'),
	(2,'Priya Sharma',19,'coimabatore'),
	(3,'Rahul Raj',21,'Madurai');

select * from student_2nf;

create table student_courses_2nf(student_id int,courses_name varchar(30),faculty varchar(40),
	primary key(student_id,courses_name), foreign key (student_id) references student_2nf(student_id));
insert into student_courses_2nf(student_id,courses_name,faculty)values
	(1,'DBMS','Dr.Ravi'),
	(1,'Java','Dr.Meena'),
	(2,'java','Dr.Meena'),
	(3,'Python','Dr,Suresh'),
	(3,'Data Science','Dr.Kumar');
    
select * from student_courses_2nf;

-- 3nf Normalization

create table student_3nf(student_id int primary key,student_name varchar(40),age int,city varchar(30));
insert into student_3nf(student_id,student_name,age,city)values
	(1,'Arun Kumar',20,'Chennai'),
	(2,'Priya Sharma',19,'coimabatore'),
	(3,'Rahul Raj',21,'Bangalore');

create table courses_3nf(courses_id int primary key,courses_name varchar(30),faculty varchar(40));
insert into courses_3nf(courses_id,courses_name,faculty)values
	(101,'DBMS','Dr,Ravi'),
    (102,'Java','Dr.Meena'),
    (103,'Python','Dr.Suresh'),
    (104,'Data Science','Dr.Kumar');
    
create table student_courses_3nf(student_id int,courses_id int,faculty varchar(30),primary key(student_id,courses_id),
	foreign key(student_id) references student_3nf(student_id),foreign key(courses_id) references courses_3nf(courses_id));
insert into student_courses_3nf(student_id,courses_id,faculty)values
	(1,101,'Dr.Ravi'),
    (1,102,'Dr.Meena'),
    (2,102,'Dr.Meena'),
    (3,103,'Dr.Suresh'),
    (3,104,'Dr.Kumar');
    
select * from student_courses_3nf;

select student_id,student_name,city
from student_3nf where student_id 
in(select student_id from student_courses_3nf where courses_id 
in(select courses_id from courses_3nf
where courses_name in('DBMS','Java')));

select s.student_id,s.student_name 
from student_3nf s
where exists(
	select 1 from student_courses_3nf nf
    join courses_3nf c 
    on nf.courses_id=c.courses_id
    where nf.student_id=s.student_id 
    in(c.courses_name 
    in('DBMS' or 'Java')));
    
select student_id,student_name,city, Case 
	when city='Chennai' then 'TamilNadu' 
	when city='coimabatore' then 'TamilNadu'    
	when city='Bangalore' then 'Karnataka'
    else 'Others' end as State from student_3nf;