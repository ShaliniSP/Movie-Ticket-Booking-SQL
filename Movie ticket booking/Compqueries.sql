\c movies

/*--------------------QUERY 1-----------------------------------*/
drop view most_sales_made;
create view most_sales_made as
(select t.name_of_theatre as theatre_name,count(ticket_id) as ticket_sales
from theatre t,ticket tkt,show s,booking b, screen scr
where t.theatre_id=scr.theatre_id and s.screen_id=scr.screen_id and s.show_id=b.show_id 
and tkt.booking_id=b.booking_id and s.show_date='5/4/18'
group by t.name_of_theatre);

select theatre_name,ticket_sales
from most_sales_made
where ticket_sales=(select max(ticket_sales) from most_sales_made);

/*--------------------QUERY 2-----------------------------------*/
drop view blockbuster_movie;
create view blockbuster_movie as
(select (m.name) as name_of_movie,count(b.booking_id) as no_of_bookings
from booking b,show s,movie m
where s.show_id=b.show_id and m.movie_id=s.movie_id group by m.name);

select name_of_movie as blockbuster_movie_of_the_day
from blockbuster_movie 
where no_of_bookings=(select max(no_of_bookings) from blockbuster_movie);

/*--------------------QUERY 3-----------------------------------*/
drop view movie_nerd;
create view movie_nerd as
(select distinct w.first_name as firstname,w.last_name as lastname,count(b.booking_id) as no_of_bookings
from web_user w,booking b
where w.web_user_id=b.user_id group by w.first_name,w.last_name);
select firstname,lastname
from movie_nerd
where no_of_bookings=(select max(no_of_bookings) from movie_nerd);

/*--------------------QUERY 4-----------------------------------*/
drop view most_popular_theatre;
create view most_popular_theatre as
(select t.name_of_theatre as theatre_name,count(b.booking_id) as no_of_bookings_received
from theatre t,show s,booking b, screen scr
where t.theatre_id=scr.theatre_id and s.screen_id=scr.screen_id and s.show_id=b.show_id 
and b.show_id=s.show_id group by t.name_of_theatre);
select theatre_name
from most_popular_theatre 
where no_of_bookings_received=(select max(no_of_bookings_received) from most_popular_theatre);

/*--------------------QUERY 5-----------------------------------*/
drop table web_user_reward_point;
create table web_user_reward_point as
(select w.first_name,w.last_name,count(t.ticket_id) as no_of_tickets_bought
from web_user w,ticket t,booking b
where w.web_user_id=b.user_id and b.booking_id=t.booking_id
group by w.first_name,w.last_name);
alter table web_user_reward_point
add reward_points int;
update web_user_reward_point
set reward_points=no_of_tickets_bought;
delete from web_user_reward_point where no_of_tickets_bought<250;
select * from web_user_reward_point;

/*--------------------QUERY 6-----------------------------------*/
Create Table Genre(                                                                                                                                      
GenType varchar(15)
);
insert into Genre 
values('Drama'),('Comedy'),('Fantasy'),('Sci-Fi'),('Horror'),('Fantasy'),('Adventure'),('Romance'),('Action'),('Thriller'),('History');
;
select genre.gentype, count(genre.gentype) as number_of_tickets_booked 
from genre JOIN (select * from movie JOIN (select * from booking JOIN show on booking.show_id = show.show_id)p 
	on movie.movie_id = p.movie_id)q on  q.genre like '%' || genre.gentype || '%'  group by genre.gentype;

/*--------------------QUERY 7-----------------------------------*/
select movie.movie_id,movie.Name,sum(p.total_cost) 
from movie 
JOIN (select * from booking JOIN show on booking.show_id = show.show_id)p 
on movie.movie_id = p.movie_id group by movie.movie_id order by sum;

/*--------------------QUERY 8-----------------------------------*/
select language,sum(No_of_tickets) number_of_tickets_bought 
from movie JOIN (select * from booking JOIN show on booking.show_id = show.show_id)p 
on movie.movie_id = p.movie_id group by language;

/*--------------------QUERY 9-----------------------------------*/
select show_time,sum(No_of_tickets) number_of_tickets_bought 
from movie JOIN (select * from booking JOIN show on booking.show_id = show.show_id)p 
on movie.movie_id = p.movie_id group by show_time;


/*--------------------QUERY 10-----------------------------------*/
select web_user_id,first_name,last_name,sum 
from Web_user 
JOIN (select user_id,sum(total_cost)  
from booking group by user_id)cost on Web_User.web_User_id=cost.user_id 

/*--------------------QUERY 11-----------------------------------*/
select t.name_of_theatre,scr.screen_id,s.show_time,s.Seats_Remaining_Gold,s.Seats_Remaining_Silver
from movie m,show s,theatre t,screen scr
where m.name='Hichki' and s.show_date='5/4/18' and scr.theatre_id=t.theatre_id 
and s.screen_id=scr.screen_id;

/*--------------------QUERY 13-----------------------------------*/
select m.name as requires_parental_guidance
from movie m
where m.genre='Fantasy/Scifi' or m.genre='Drama/Comedy' or m.genre='Romance/Comedy'
or m.genre='Horror' ;

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

/*--------------------QUERY 19-----------------------------------*/
Select First_Name, Last_Name from Web_User 
where Web_User_ID IN 
	(Select distinct User_ID from Booking where No_of_Tickets > 10);

/*--------------------QUERY 20-----------------------------------*/
Select First_Name, Last_Name from Web_User 
where Web_User_ID IN 
	(Select distinct User_ID from Booking where No_of_Tickets = 1);

