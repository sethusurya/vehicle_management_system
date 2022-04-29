select us.email,'USER vs BOOKING',count(b.user_id) from users us
left JOIN  BOOKING b
on b.USER_ID = us.USER_ID
GROUP BY us.email;