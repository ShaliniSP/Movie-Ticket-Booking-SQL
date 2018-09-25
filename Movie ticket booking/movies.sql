
DROP DATABASE movies;
CREATE DATABASE movies;
\c movies;



CREATE Table Web_user(
Web_user_ID varchar(5),
FirstName varchar(15), 
LastName varchar(20),
Email_ID varchar(30),
Age int,
PhoneNumber varchar(10) NOT NULL, 
Primary Key(Web_user_ID));

Create Table Theatre(
Theatre_id varchar(5),
Name_of_Theatre varchar(30) NOT NULL,
No_of_Screens int,
Area varchar(30),
Primary Key(Theatre_id));


CREATE Table Booking(
Booking_ID varchar(5),
No_Of_Tickets int NOT NULL,
Total_cost int NOT NULL,                                           
CardNumber varchar(19),
Name_on_card varchar(21),
User_ID varchar(5),
Foreign key (User_ID) REFERENCES Web_user (Web_user_ID),
Primary Key(Booking_id));

CREATE Table Ticket(
Ticket_id varchar(8),Booking_ID varchar(10),
Class varchar(3) NOT NULL,
Price int NOT NULL,
Primary Key(Ticket_id),
Foreign Key(Booking_id) references Booking(Booking_id));

CREATE TABLE Screen(
Screen_id varchar(5),
No_of_seats_gold int NOT NULL,
No_of_seats_silver int NOT NULL,
Theatre_id varchar(5),
Primary key(screen_id),
Foreign key(Theatre_id) references Theatre(Theatre_id));

Create Table Movie(
Movie_id varchar(5), /*change to int?*/
MovieName varchar(30) NOT NULL,
Language varchar(10),
Genre varchar(20),
TargetAudience varchar(5),
primary key(movie_id));

CREATE Table Show(				
Show_Id varchar(10),
Showtime time NOT NULL,
Show_Date date NOT NULL,				
Seats_remaining_gold int NOT NULL,
Seats_remaining_silver int NOT NULL,
Class_cost_gold int NOT NULL,
Class_cost_silver int NOT NULL,
Screen_Id varchar(5) NOT NULL,
Movie_Id varchar(6) NOT NULL,
Primary key(Show_Id),
foreign key (Screen_Id) references Screen(Screen_Id),
foreign key (Movie_Id) references Movie(Movie_Id));
