SET sql_safe_updates=0;
DELETE FROM addresses;
SET sql_safe_updates=1;
ALTER TABLE addresses AUTO_INCREMENT = 1;

SET sql_safe_updates=0;
DELETE FROM users;
SET sql_safe_updates=1;
ALTER TABLE users AUTO_INCREMENT = 1;

SET sql_safe_updates=0;
DELETE FROM consumers;
SET sql_safe_updates=1;
ALTER TABLE consumers AUTO_INCREMENT = 1;

SET sql_safe_updates=0;
DELETE FROM grades;
SET sql_safe_updates=1;
ALTER TABLE grades AUTO_INCREMENT = 1;

SET sql_safe_updates=0;
DELETE FROM auths;
SET sql_safe_updates=1;
ALTER TABLE auths AUTO_INCREMENT = 1;


-- auth
INSERT INTO auths(auth_name) VALUES("USER");
INSERT INTO auths(auth_name) VALUES("ADMIN");

-- grade
INSERT INTO grades(grade_name, grade_start_cost, grade_end_cost, grade_ratio) VALUES("BASIC", 0, 100000, 1);
INSERT INTO grades(grade_name, grade_start_cost, grade_end_cost, grade_ratio) VALUES("ROYAL", 100000, 200000, 2);
INSERT INTO grades(grade_name, grade_start_cost, grade_end_cost, grade_ratio) VALUES("GOLD", 200000, 300000, 3);
INSERT INTO grades(grade_name, grade_start_cost, grade_end_cost, grade_ratio) VALUES("PLATINUM", 300000, 0, 5);

-- user1
INSERT INTO consumers(consumer_name, consumer_email, consumer_phone, consumer_password) VALUES("user1", "user1@naver.com", "01012345678", "1234");
INSERT INTO users(user_id, user_birthdate, grade_id, user_login_at, user_is_inactive, created_at, auth_id, user_point) VAlUES(1, "2022-01-01", 1, "2022-01-01", 0, "2022-01-01", 1, 100000);

UPDATE consumers SET consumer_password = "$2a$12$rKbLkepB7hmeAnZKlk45gOUb7LHwpw6.7NMrCHMkuB.q1jHegXrki" WHERE consumer_id = 1;

INSERT INTO addresses(address_general, address_detail, address_alias, address_code, is_default_address, user_id) VALUES("대전광역시 유성구 대학로 99", "정보화본부 교육관(N2-1)", "학교", 34134, true, 1);
INSERT INTO addresses(address_general, address_detail, address_alias, address_code, is_default_address, user_id) VALUES("서울특별시 종로구 청와대로 1", "영빈관", "집", 03048, false, 1);

-- user2
INSERT INTO consumers(consumer_name, consumer_email, consumer_phone, consumer_password) VALUES("user2", "user2@naver.com", "01012345678", "1234");
INSERT INTO users(user_id, user_birthdate, grade_id, user_login_at, user_is_inactive, created_at, auth_id, user_point) VAlUES(2, "2022-01-01", 4, "2022-01-01", 0, "2022-01-01", 1, 500000);

UPDATE consumers SET consumer_password = "$2a$12$rKbLkepB7hmeAnZKlk45gOUb7LHwpw6.7NMrCHMkuB.q1jHegXrki" WHERE consumer_id = 2;

INSERT INTO addresses(address_general, address_detail, address_alias, address_code, is_default_address, user_id) VALUES("서울특별시 종로구 사직로 161", "경복궁 근정전", "집", 03045, true, 2);
INSERT INTO addresses(address_general, address_detail, address_alias, address_code, is_default_address, user_id) VALUES("경기도 성남시 분당구대왕판교로 645번길", "16 (삼평동 629)", "회사", 13487, false, 2);

-- admin
INSERT INTO consumers(consumer_name, consumer_email, consumer_phone, consumer_password) VALUES("admin", "admin@naver.com", "01012345678", "1234");
INSERT INTO users(user_id, user_birthdate, grade_id, user_login_at, user_is_inactive, created_at, auth_id, user_point) VAlUES(3, "2022-01-01", 1, "2022-01-01", 0, "2022-01-01", 2, 10000);

UPDATE consumers SET consumer_password = "$2a$12$rKbLkepB7hmeAnZKlk45gOUb7LHwpw6.7NMrCHMkuB.q1jHegXrki" WHERE consumer_id = 3;
