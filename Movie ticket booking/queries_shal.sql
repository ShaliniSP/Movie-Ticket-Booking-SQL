/*--------------------QUERY 20-----------------------------------*/
Select First_Name, Last_Name from Web_User 
where Web_User_ID IN 
	(Select distinct User_ID from Booking where No_of_Tickets = 1);

/*--------------------QUERY 19-----------------------------------*/
Select First_Name, Last_Name from Web_User 
where Web_User_ID IN 
	(Select distinct User_ID from Booking where No_of_Tickets > 10);


/*--------------------QUERY 15-----------------------------------*/
drop view gold;
create view gold as select count(Class) as gold, booking_id from ticket where class = 'GLD' group by booking_id;
drop view silver;
create view silver as select count(Class) as silver, booking_id from ticket where class = 'SLV' group by booking_id;
drop view gold_silver;
create view gold_silver as Select * from gold natural join silver;
drop view user_booking;
create view user_booking as select booking_id, user_id from booking;
drop view gs_users;
create view gs_users as Select * from gold_silver natural join user_booking;
Select user_id from gs_users group by user_id having sum(gold) > sum(silver);

/*--------------------QUERY 16-----------------------------------*/
drop view total;
create view total as select (no_of_seats_gold + no_of_seats_silver) as total_seats, show_id 
from screen, show where show.screen_id = screen.screen_id;
drop view booked;
create view booked as select (seats_remaining_gold + seats_remaining_silver) as total_remaining, show_id from show;
select * from total natural join booked where total_remaining < 0.1 * total_seats;

/*--------------------QUERY 17-----------------------------------*/
drop view total;
create view total as select (no_of_seats_gold + no_of_seats_silver) as total_seats, show_id 
from screen, show where show.screen_id = screen.screen_id;
drop view booked;
create view booked as select (seats_remaining_gold + seats_remaining_silver) as total_remaining, show_id from show;
select * from total natural join booked where total_remaining > 0.3 * total_seats;

/*--------------------QUERY 18-----------------------------------*/
select language,sum(No_of_tickets) number_of_tickets_bought 
from movie JOIN (select * from booking JOIN show on booking.show_id = show.show_id)p 
on movie.movie_id = p.movie_id group by language;