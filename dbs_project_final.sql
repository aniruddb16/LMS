CREATE TABLE IF NOT EXISTS book (
  book_id int(11) NOT NULL AUTO_INCREMENT,
  book_title varchar(100) NOT NULL,
  category varchar(50) NOT NULL,
  author varchar(50) NOT NULL,
  publisher_name varchar(100) NOT NULL,
  copyright_year int(11) NOT NULL,
  date_added datetime NOT NULL,
  book_status boolean DEFAULT 0,
  PRIMARY KEY (book_id),
  foreign key (book_status) references borrows (flag)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

INSERT into book(book_id, book_title, category, author, publisher_name, copyright_year,
date_added, book_status) VALUES 
(1, 'Natural Resources', 'book', 'Robin Kerrod', 'Marshall Cavendish Corporation', 1997, '2013-12-11 06:34:27', 0),
(2, 'Encyclopedia Americana', 'journal', 'Grolier', 'Grolier Incorporation',  1988, '2013-12-11 06:36:23', 0),
(3, 'Algebra 1', 'book', 'Carolyn Bradshaw, Michael Seals', 'Pearson Education, Inc',  2004, '2013-12-11 06:39:17', 0),
(4, 'The Philippine Daily Inquirer', 'magazine', 'Parth Garg', 'Caster Publications, New Delhi', 2013, '2013-12-11 06:41:53', 0),
(5, 'Science in our World', 'book', 'Brian Knapp', 'Regency Publishing Group', 1996, '2013-12-11 06:44:44', 0),
(6, 'Literature', 'book', 'Greg Glowka', 'Regency Publishing Group', 2001, '2013-12-11 06:47:44', 0),
(7, 'Lexicon Universal', 'journal', 'Lexicon', 'Lexicon Publication', 1993,'2013-12-11 06:49:53', 0),
(8, 'Science and Invention Encyclopedia', 'book', 'Clarke Donald, Dartford Mark', 'H.S. Stuttman inc. Publishing', 1992, '2013-12-11 06:52:58', 0),
(9, 'Integrated Science Textbook ', 'book', 'Merde C. Tan', 'Vibal Publishing House Inc.', 2009,  '2013-12-11 06:55:27', 0),
(10, 'Vanity Fair', 'magazine', 'Glencoe McGraw Hill', 'The McGrawHill Companies Inc.',  2008, '2013-12-11 06:57:35', 0),
(11, 'Wiki at Panitikan ', 'book', 'Lorenza P. Avera', 'JGM & S Corporation',  2000, '', '2013-12-11 06:59:24', 0),
(12, 'Journal of Popular Culture', 'journal', 'Virginia Bermudez Ed. O. et al',  'SD Publications, Inc.', 2007, '2013-12-11 07:01:25', 0);

CREATE TABLE IF NOT EXISTS borrower_user (
     user_id varchar(100) NOT NULL,
     first_name varchar(100) NOT NULL,
     last_name varchar(100) NOT NULL,
     phone_no int(11) NOT NULL,
     email_id varchar(100) NOT NULL,
     PRIMARY KEY (user_id)
     ) ;
 INSERT into borrower_user(user_id, first_name, last_name, phone_no, email_id) VALUES 
('2019B2A80122P', 'Harshit', 'Gupta', 9599314824, 'f20190122@pilani.bits-pilani.ac.in'),
('2018B3A80123P', 'Paritosh', 'Khan', 953634624, 'f20180123@pilani.bits-pilani.ac.in'),
('2019A5PS0124P', 'Rick', 'James', 9599317464, 'f20190124@pilani.bits-pilani.ac.in'),
('2019B1A80125P', 'Prateek', 'Kuhad', 9322322824, 'f20190125@pilani.bits-pilani.ac.in'),
('2019B5A80126P', 'Kaushik', 'Ports', 9222222824, 'f20190126@pilani.bits-pilani.ac.in'),
('2019A8PS0127P', 'Sarthak', 'Nitin', 9242442824, 'f20190127@pilani.bits-pilani.ac.in'),
('2019A8PS0128P', 'Rahul', 'Bakshi', 9111111824, 'f20190128@pilani.bits-pilani.ac.in'),
('2019A8PS0129P', 'Rahul', 'Dua', 9111933824, 'f20190128@pilani.bits-pilani.ac.in');
 
	CREATE TABLE IF NOT EXISTS borrows (
    borrow_date datetime ,
    return_date datetime ,
	deadline datetime ,
    book_id int(11) NOT NULL,
    flag boolean DEFAULT 1,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
    );
    
    INSERT into borrows(borrow_date, return_date, book_id) VALUES
    ('2022-04-01 01:11:27', NULL, 1),
	('2022-04-16 12:12:57', NULL, 6),
    ('2022-04-08 15:11:59', '2022-04-10 09:02:10', 6),
    ('2022-04-08 02:12:34', null, 12);
    

    
    
    alter table borrows
    add fine int(11) DEFAULT 0;
    
   update borrows
   set deadline = TIMESTAMPADD(DAY,7,borrow_date);
   
   update borrows
   set fine = (DATEDIFF(deadline,return_date)*10) 
   where return_date > deadline ;
   
   CREATE TABLE IF NOT EXISTS room ( 
   room_no int(11) NOT NULL,
   capacity int(11) NOT NULL,
   room_type varchar(100) NOT NULL,
   booking_rate int(11) NOT NULL,
   availability boolean DEFAULT 0,
   primary key (room_no),
   foreign key (availability) references room_reservation(booking_status)
   );
   
   INSERT into room(room_no, capacity, room_type, booking_rate) VALUES
   (1201, 40, 'classroom', 300),
   (6105, 80, 'classroom', 500),
   (1203, 40, 'classroom', 250),
   (5104, 200, 'lecture hall', 1500),
   (5105, 150, 'lecture hall', 1000),
   (1000, 500, 'auditorium', 5000),
   (6156, 300, 'auditorium', 2500);
   
   CREATE TABLE IF NOT EXISTS room_reservation (
   room_no int(11) NOT NULL,
   user_id varchar(100) NOT NULL,
   booking_date datetime NOT NULL,
   duration int(11) NOT NULL,
   booking_status boolean DEFAULT 1,
   primary key (room_no),
   foreign key (user_id) references borrower_user(user_id)
   );
   
   INSERT into room_reservation(room_no, user_id, booking_date, duration) VALUES
   (1203, '2019B2A80122P', '2022-04-01 01:11:27', 4),
   (6156, '2019A8PS0129P', '2022-04-10 10:30:20', 1),
   (5105, '2019B1A80125P', '2022-04-07 05:20:12', 3);
   
   

   
   
   
   
   
    
    
    