--Delete duplicate Users 
DELETE users 
WHERE user_id NOT IN (SELECT min(user_id) FROM users GROUP BY old_id, state, created_date, last_login, role, active)