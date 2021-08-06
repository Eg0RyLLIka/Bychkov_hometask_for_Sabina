use vk_new;

-- 1. ���������������� �������, ������� ����������� �� �������, ���������� ��������� ������������� �/��� ��������� (JOIN ���� �� ���������).

-- VSE OTLICHNO I PONYATNO!

-- 2. ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.

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

-- 3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.

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

-- 4. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

select COUNT(*) as '����� ������'
FROM likes 
WHERE media_id in (
	SELECT id FROM media where user_id in(select user_id from profiles where gender = 'm')
);

select COUNT(*) as '����� ������'
FROM likes 
WHERE media_id in (
	SELECT id FROM media where user_id in(select user_id from profiles where gender = 'f')
);

-- Women

-- 5. ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.


-- � �� ���� ��� ������� ��� ������, � �����������, ��� ���� ������ ����� ��������� ������� ������������, ����� ���� ����������� ������� ������������,
-- ����� ���� �������� � ������ ������� ������������. � ����������� ��� ��� ����� �  ������, ��� ����� ������ �����, ����� � ������� order by "�������� �������
-- ��� ����� ��������� ������������" asc limit 10 - ������ 10 ���������� �������������.

	SELECT initiator_user_id FROM friend_requests where (select target_user_id in (select id from users) from friend_requests) AND status='approved'
	union
	SELECT target_user_id FROM friend_requests WHERE (select initiator_user_id in (select id from users) from friend_requests) AND status='approved'
