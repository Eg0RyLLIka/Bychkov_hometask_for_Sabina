-- БАЗА ДАННЫХ YOUTUBE, создание профилей, творческой студии и многое другое.

DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube;
USE youtube;

DROP TABLE IF EXISTS users;
CREATE TABLE users(

	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Second name',
    email VARCHAR(120) UNIQUE,
    birthday DATE,
    gender ENUM('male','female'),
 	password_hash VARCHAR(100), -- 123456 => e10adc3949ba59abbe56e057f20f883e
	phone BIGINT UNSIGNED UNIQUE, 
	
    INDEX users_firstname_lastname_idx(firstname, lastname)
    
) COMMENT 'Users';


DROP TABLE IF EXISTS youtube_profiles;
CREATE TABLE youtube_profiles(

	user_profile_id BIGINT UNSIGNED NOT NULL UNIQUE,
	photo_profile_id BIGINT UNSIGNED NULL,
	banner_of_profile_id BIGINT unsigned null,
	logo_of_profile_id BIGINT unsigned null,
	describe_chanel VARCHAR(1000),
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
    
	-- contact_info = users.email

);

ALTER TABLE youtube_profiles ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_profile_id) REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;


DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions(

	id SERIAL,
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
    
);


DROP TABLE IF EXISTS subscibers;
CREATE TABLE subscibers(

	id SERIAL,
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
    
);

update subscibers
set target_user_id = (select id from users where id != target_user_id order by rand() limit 1)
where initiator_user_id = target_user_id;


DROP TABLE IF EXISTS comments;
CREATE TABLE comments(

	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
    
);


DROP TABLE IF EXISTS likes;
CREATE TABLE likes(

	id SERIAL,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    video_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
    
);


DROP TABLE IF EXISTS studio;
CREATE TABLE studio(

	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    video_id BIGINT UNSIGNED NOT NULL,
    history_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    
);


DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(

	id SERIAL,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
    
);

-- INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'post', '1973-05-16 08:33:11', '1974-09-14 18:03:27');
-- INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'video', '1987-03-19 17:30:12', '1997-03-31 09:35:39');
-- INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'history', '2017-06-04 20:05:48', '1997-06-15 00:35:42');


DROP TABLE IF EXISTS media;
CREATE TABLE media(

	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255), 	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
    
);


DROP TABLE IF EXISTS video;
CREATE TABLE video(

	id SERIAL,
	`name` varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,
    media_id BIGINT unsigned NOT NULL,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
  	
);


DROP TABLE IF EXISTS post;
CREATE TABLE post(

	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	created_at DATETIME DEFAULT NOW()
	
);


DROP TABLE IF exists history;
CREATE TABLE history(

	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW()
	
);

-- cделать так, чтобы история удалялась после 24 часов
