\c movies;

/*1. Number of screens in INOX Movies*/
Select No_of_Screens from Theatre where Name_of_Theatre = 'INOX Movies'; 
/*2. All the 9:00 am shows playing on 4th April*/
Select distinct MovieName from Show, Movie where Show.Movie_id = Movie.Movie_id and Show.Showtime = '09:00:00 AM' and Show_Date = '4/4/18';
/*3. Show Timings for Hichki*/
Select distinct (Showtime, Show_Date) from Show, Movie where Show.Movie_id = Movie.Movie_id and Movie.MovieName = 'Hichki';
/*4. Total seats in PVR Cinemas*/
Select Screen_id, No_of_seats_gold, No_of_seats_silver,  SUM(No_of_seats_gold + No_of_seats_silver) from Screen, Theatre where Screen.Theatre_id = Theatre.Theatre_id and Name_of_Theatre = 'PVR Cinemas' GROUP BY Screen_id;
/*5. All English movies*/
Select MovieName from Movie where Movie.Language = 'English';