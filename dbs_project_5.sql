create database lms;
use lms;
CREATE TABLE IF NOT EXISTS book (
  book_id int(11) NOT NULL AUTO_INCREMENT,
  book_title varchar(100) NOT NULL,
  category varchar(100) NOT NULL,
  author varchar(50) NOT NULL,
  publisher_name varchar(100) NOT NULL,
  copyright_year int(11) NOT NULL,
  date_added datetime NOT NULL,
  book_status boolean DEFAULT 0,
  PRIMARY KEY (book_id)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

CREATE TABLE IF NOT EXISTS borrower_user (
     user_id varchar(100) NOT NULL,
     first_name varchar(100) NOT NULL,
     last_name varchar(100) NOT NULL,
     phone_no int(11) NOT NULL,
     email_id varchar(100) NOT NULL,
     PRIMARY KEY (user_id)
     ) ;
     
	CREATE TABLE IF NOT EXISTS borrows (
    borrow_date datetime ,
    return_date datetime ,
	deadline datetime ,
    book_id int(11) NOT NULL,
    flag boolean DEFAULT 1,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
    );
    
    alter table borrows
    add fine int(11) DEFAULT 0;
    
   update borrows
   set deadline = TIMESTAMPADD(DAY,7,borrow_date);
   
   update borrows
   set fine = (DATEDIFF(deadline,return_date)*10) 
   where return_date > deadline ;
   
   
   
   CREATE TABLE IF NOT EXISTS room_reservation (
   room_no int(11) NOT NULL,
   user_id varchar(100) NOT NULL,
   booking_date datetime NOT NULL,
   duration int(11) NOT NULL,
   booking_status boolean DEFAULT 1,
   primary key (room_no),
   foreign key (user_id) references borrower_user(user_id)
   );
   
   CREATE TABLE IF NOT EXISTS room ( 
   room_no int(11) NOT NULL,
   capacity int(11) NOT NULL,
   room_type varchar(100) NOT NULL,
   booking_rate int(11) NOT NULL,
   availability boolean DEFAULT 0,
   primary key (room_no)
   );
   
   alter table room_reservation
   add cost int(11);
   
   update room_reservation, room
   set cost = booking_rate*duration
   where room_reservation.room_no = room.room_no;

   update book, borrows
   set book_status = 1 where flag = 1;
   
   update room, room_reservation
   set availability = 1 where booking_status = 1;
   
   INSERT into book(book_id, book_title, category, author, publisher_name, copyright_year,
date_added) VALUES 
(1, 'Natural Resources', 'book', 'Robin Kerrod', 'Marshall Cavendish Corporation', 1997, '2013-12-11 06:34:27'),
(2, 'Encyclopedia Americana', 'journal', 'Grolier', 'Grolier Incorporation',  1988, '2013-12-11 06:36:23'),
(3, 'Algebra 1', 'book', 'Carolyn Bradshaw, Michael Seals', 'Pearson Education, Inc',  2004, '2013-12-11 06:39:17'),
(4, 'The Philippine Daily Inquirer', 'magazine', 'Parth Garg', 'Caster Publications, New Delhi', 2013, '2013-12-11 06:41:53'),
(5, 'Science in our World', 'book', 'Brian Knapp', 'Regency Publishing Group', 1996, '2013-12-11 06:44:44'),
(6, 'Literature', 'book', 'Greg Glowka', 'Regency Publishing Group', 2001, '2013-12-11 06:47:44'),
(7, 'Lexicon Universal', 'journal', 'Lexicon', 'Lexicon Publication', 1993,'2013-12-11 06:49:53'),
(8, 'Science and Invention Encyclopedia', 'book', 'Clarke Donald, Dartford Mark', 'H.S. Stuttman inc. Publishing', 1992, '2013-12-11 06:52:58'),
(9, 'Integrated Science Textbook ', 'book', 'Merde C. Tan', 'Vibal Publishing House Inc.', 2009,  '2013-12-11 06:55:27'),
(10, 'Vanity Fair', 'magazine', 'Glencoe McGraw Hill', 'The McGrawHill Companies Inc.',  2008, '2013-12-11 06:57:35'),
(11, 'Wiki at Panitikan ', 'book', 'Lorenza P. Avera', 'JGM & S Corporation',  2000,  '2013-12-11 06:59:24'),
(12, 'Journal of Popular Culture', 'journal', 'Virginia Bermudez Ed. O. et al',  'SD Publications, Inc.', 2007, '2013-12-11 07:01:25');
   
   Select * from book;
   
   alter table borrower_user
   drop phone_no;
   
   alter table borrower_user
   add phone_no varchar(100) NOT NULL;
   
   INSERT into borrower_user(user_id, first_name, last_name, phone_no, email_id) VALUES 
('2019B2A80122P', 'Harshit', 'Gupta', '9599314824', 'f20190122@pilani.bits-pilani.ac.in'),
('2018B3A80123P', 'Paritosh', 'Khan', '953634624', 'f20180123@pilani.bits-pilani.ac.in'),
('2019A5PS0124P', 'Rick', 'James', '9599317464', 'f20190124@pilani.bits-pilani.ac.in'),
('2019B1A80125P', 'Prateek', 'Kuhad', '9322322824', 'f20190125@pilani.bits-pilani.ac.in'),
('2019B5A80126P', 'Kaushik', 'Ports', '9222222824', 'f20190126@pilani.bits-pilani.ac.in'),
('2019A8PS0127P', 'Sarthak', 'Nitin', '9242442824', 'f20190127@pilani.bits-pilani.ac.in'),
('2019A8PS0128P', 'Rahul', 'Bakshi', '9111111824', 'f20190128@pilani.bits-pilani.ac.in'),
('2019A8PS0129P', 'Rahul', 'Dua', '9111933824', 'f20190128@pilani.bits-pilani.ac.in');

select * from borrower_user;

INSERT into borrows(borrow_date, return_date, book_id) VALUES
    ('2022-04-01 01:11:27', NULL, 1),
	('2022-04-16 12:12:57', NULL, 6),
    ('2022-04-08 15:11:59', '2022-04-10 09:02:10', 6),
    ('2022-04-08 02:12:34', null, 12);
    
    select * from borrows;
    
    select * from book;
    
    INSERT into room(room_no, capacity, room_type, booking_rate) VALUES
   (1201, 40, 'classroom', 300),
   (6105, 80, 'classroom', 500),
   (1203, 40, 'classroom', 250),
   (5104, 200, 'lecture hall', 1500),
   (5105, 150, 'lecture hall', 1000),
   (1000, 500, 'auditorium', 5000),
   (6156, 300, 'auditorium', 2500);
   
   INSERT into room_reservation(room_no, user_id, booking_date, duration) VALUES
   (1203, '2019B2A80122P', '2022-04-01 01:11:27', 4),
   (6156, '2019A8PS0129P', '2022-04-10 10:30:20', 1),
   (5105, '2019B1A80125P', '2022-04-07 05:20:12', 3);
   
   Select * from borrower_user where first_name = 'Harshit';
   
   Select * from borrower_user where user_id = '2019A5PS0124P';
   
   update borrower_user
   set first_name = 'Rishi', last_name = 'Garg' where user_id = '2019B2A80122P';
   
   alter table borrows
   add user_id varchar (100);
   
   alter table borrows
   add foreign key (user_id) references borrower_user (user_id);
   
   delete from borrows;
   
   select * from borrows;
   
   INSERT into borrows(borrow_date, return_date, book_id, user_id) VALUES
    ('2022-04-01 01:11:27', NULL, 1, '2019B2A80122P' ),
	('2022-04-16 12:12:57', NULL, 6, '2018B3A80123P' ),
    ('2022-04-08 15:11:59', '2022-04-10 09:02:10', 6, '2019A5PS0124P'),
    ('2022-04-08 02:12:34', null, 12, '2019A8PS0128P' );
    
    select * from borrows;
    
    update borrows
    set deadline = DATEADD(DAYS, 7, borrow_date) where borrow_date != NULL;


Delimiter $$
CREATE TRIGGER new_deadline before INSERT ON borrows
FOR EACH ROW
BEGIN
set new.deadline = date_add(new.borrow_date, interval 7 day);
END $$

INSERT into borrows (borrow_date, return_date, deadline, book_id, user_id) VALUES
	('2022-04-16 12:12:57', NULL, 0, 6, '2018B3A80123P' );
INSERT into borrows (borrow_date, return_date, book_id, user_id) VALUES    
    ('2022-04-08 15:11:59', '2022-04-10 09:02:10', 6, '2019A5PS0124P'),
    ('2022-04-08 02:12:34', null, 12, '2019A8PS0128P' );

select borrow_date from borrows;
select * from borrows;


delete from borrows;

drop trigger new_deadline;

Delimiter $$
CREATE TRIGGER set_fine before INSERT ON borrows
FOR EACH ROW
BEGIN
if(datediff(new.return_date, new.borrow_date)>7)
then
set new.fine = (datediff(new.return_date, new.borrow_date)-7)*10;
END if;
end  $$

drop trigger set_fine;

delete from borrows;

INSERT into borrows (borrow_date, return_date, book_idd, user_id) VALUES    
    ('2022-04-08 15:11:59', '2022-04-17 09:02:10', 6, '2019A5PS0124P'),
    ('2022-04-08 02:12:34', '2022-04-10 02:12:34', 12, '2019A8PS0128P' ),
    ('2022-04-19 12:12:57', '2022-04-23 12:12:57', 6, '2018B3A80123P' );
    
    Delimiter $$
CREATE TRIGGER set_flag before INSERT ON borrows
FOR EACH ROW
BEGIN
if(new.return_date is not null)
then
set new.flag = 0;
END if;
end  $$

drop trigger set_flag;

 
delimiter $$
CREATE TRIGGER change_status
    AFTER INSERT ON borrows
    FOR EACH ROW
    BEGIN
    UPDATE book
    SET book.book_status = new.flag
    where book_id = new.book_idd;
END; $$
delimiter ;


drop trigger change_status;

select * from borrows;
select * from book;

select book_title from book where category = 'book';

alter table room_reservation
add end_date datetime;

select * from room_reservation;

Delimiter $$
CREATE TRIGGER room_deadline before INSERT ON room_reservation
FOR EACH ROW
BEGIN
set new.end_date = date_add(new.booking_date, interval new.duration day);
END $$

delete from room_reservation;

INSERT into room_reservation(room_no, user_id, booking_date, duration) VALUES
   (1203, '2019B2A80122P', '2022-04-01 01:11:27', 4),
   (6156, '2019A8PS0129P', '2022-04-10 10:30:20', 1),
   (5105, '2019B1A80125P', '2022-04-07 05:20:12', 3);
   
   select * from room_reservation;
   
   
CREATE TRIGGER set_room_cost before INSERT ON room_reservation
FOR EACH ROW
BEGIN
update room_reservation
set cost = (room.booking_rate)*new.duration
where room.room_no = new.room_num;
end;

delimiter &&
create procedure borrow_book ( IN borroww_date datetime, IN book_ids int(11))
BEGIN
start transaction;
insert into borrows(borrow_date, book_idd) values (borroww_date, book_ids);
update book
    set book_status = 1 where book_id = book_ids;
select book_status into @stat from book where book_id = book_ids;
if @stat = 0 then commit;
else
rollback;
end if;
end &&

select * from borrows;
call borrow_book('2018-04-17 07:34:35', 1);

select * from borrows;
delete from borrows;

drop procedure borrow_book;



   
alter table borrows
rename column book_id to book_idd;

alter table room_reservation
rename column room_no to room_num;

alter table room_reservation
add username varchar(100);

alter table room_reservation add constraint
foreign key (username) references borrower_user(user_id);

alter table room_reservation
add roomnumber int(11);

alter table room_reservation add constraint
foreign key (roomnumber) references room(room_no);

alter table room_reservation
drop column username;















    










    
    