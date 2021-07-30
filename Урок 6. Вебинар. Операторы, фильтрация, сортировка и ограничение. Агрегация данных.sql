use vk_new;

-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).

-- VSE OTLICHNO I PONYATNO!

-- 2. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- PUST' ZADAN POL'ZOVATEL 501

select from_user_id from messages
	where to_user_id = 501 and from_user_id in
	(
		SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 501) AND status='approved'
  		union
  		SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 501) AND status='approved'
	)
	order by from_user_id desc;

select * from users
	where id = 864;

-- VMESTE S in , no ya ne znau kak

	select * from users where id in
		(
			select from_user_id from messages
				where to_user_id = 501 and from_user_id in
			(
				SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 501) AND status='approved'
  				union
  				SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 501) AND status='approved'
			)
		order by from_user_id desc
		)
	;

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

select user_id from profiles order by birthday desc limit 10;

-- user_id: 822 544 578 748 821 508 840 677 843 632

select COUNT(*) as 'all', media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 822
)

union 

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 544
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 578
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 748
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 821
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 508
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 840
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 677
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 843
)

union

select COUNT(*), media_id
FROM likes 
WHERE media_id in (
	SELECT id FROM media WHERE user_id = 632
)
order by media_id desc
;

-- POLUCHIM 35 LIKOV

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

select COUNT(*) as 'лайки мужчин'
FROM likes 
WHERE media_id in (
	SELECT id FROM media where user_id in(select user_id from profiles where gender = 'm')
);

select COUNT(*) as 'лайки женщин'
FROM likes 
WHERE media_id in (
	SELECT id FROM media where user_id in(select user_id from profiles where gender = 'f')
);

-- Women

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.


-- Я не знаю как сделать эту задачу, я предполагаю, что надо узнать сумму сообщений каждого пользователя, сумму всех медиафайлов каждого пользователя,
-- сумму всех запросов в друзья каждого пользователя. И СУММИРОВАТЬ все жти суммы и  узнать, где вышло больше число, потом с помощью order by "название столбца
-- где будет храниться СУММИРОВАНИЕ" asc limit 10 - узнаем 10 неактивных пользователей.

	SELECT initiator_user_id FROM friend_requests where (select target_user_id in (select id from users) from friend_requests) AND status='approved'
	union
	SELECT target_user_id FROM friend_requests WHERE (select initiator_user_id in (select id from users) from friend_requests) AND status='approved'
