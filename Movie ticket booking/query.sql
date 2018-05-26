

\c movies;


select w.first_name,w.last_name,count(b.booking_id)
from  web_user w,booking b, show s, screen scr, theatre t
where t.theatre_id=s.theatre_id and scr.screen_id=s.screen_id
and b.show_id=s.show_id and b.user_id=w.web_user_id 
t.name_of_theatre='INOX Movies' group by w.first_name,w.last_name; 