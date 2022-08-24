-- SQL TEST QUERIES

use lms;

select * from borrows;

select book_title from book where category = 'book';

select * from book where book_id = 1;

select * from borrower_user where user_id = '2018B3A80123P';

select * from room;

select * from room where room_no = '1203';

select * from room where capacity = 40;

Select * from borrower_user where first_name = 'Harshit';

Select * from borrower_user where user_id = '2019A5PS0124P';

update borrower_user
   set first_name = 'Rishi', last_name = 'Garg' where user_id = '2019B2A80122P';
   
   select * from room_reservation;
   
   call borrow_book('2022-04-19 12:12:57', 7);   -- it takes the borrow date and book id as input from the user and tries to execute the transaction. If the book is available, transaction will be successful, else it will be rollbacked.
   
   call room_reserve('2018-04-17 07:34:35', 5104, 3, '2018B3A80123P');  -- it takes reservation date, the room to be booked and the duration of the reservation and the ID of the user to book a room. If the room is available, the procedure will commit the transaction, else it will rollback.