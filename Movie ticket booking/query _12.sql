
select w.first_name,w.last_name
from movie m,web_user w, booking b
where b.user_id=w.web_user_id and m.language='English' and m.language!='Kannada' and m.language!='Hindi';