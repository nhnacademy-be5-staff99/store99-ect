SET sql_safe_updates=0;
SET foreign_key_checks = 0;
DELETE FROM categories; -- commit 이전 rollback 가능함
SET foreign_key_checks = 1;

ALTER TABLE categories AUTO_INCREMENT = 1;

-- Root Category --
INSERT INTO categories (category_name, category_depth, parent_category_id) VALUES ('국내도서', 1, NULL);

-- Depth_2 --
INSERT INTO categories (category_name, category_depth, parent_category_id) VALUES 
('과학', 2, 1),
('컴퓨터/모바일', 2, 1),
('경제경영', 2, 1),
('대학교재/전문서적', 2, 1);

-- Depth_3 --
INSERT INTO categories (category_name, category_depth, parent_category_id) VALUES
('프로그래밍 개발/방법론', 3, 3),
('인공지능', 3, 3),
('컴퓨터 공학', 3, 3),
('프로그래밍 언어', 3, 3),
('기초과학/교양과학', 3, 2),
('기업 경영', 3, 4),
('OS/Networking', 3, 3),
('공학계열', 3, 5),
('트렌드/미래전망', 3, 4),
('활용능력', 3, 3);

-- Depth_4 --
INSERT INTO categories (category_name, category_depth, parent_category_id) VALUES
('소프트웨어 공학', 4, 8),
('경영전략/혁신', 4, 11),
('네트워크/데이터 통신', 4, 8),
('컴퓨터공학/전산학 개론', 4, 8),
('네트워크 구축', 4, 12),
('프로그래밍 기초/개발 방법론', 4, 6),
('컴퓨터공학', 4, 13),
('데이터베이스 개론', 4, 8),
('자료구조/알고리즘', 4, 8),
('데이터베이스 프로그래밍', 4, 6),
('게임 프로그래밍', 4, 6),
('컴퓨터공학/전산학 개론', 4, 8),
('전산수학(SPSS/MATLAB)', 4, 8),
('인공지능/빅데이터', 4, 14),
('프로그래밍 언어 기타', 4, 9),
('파이썬', 4, 9),
('신규 자격증/자격증 기타', 4, 15),
('네트워크/데이터 통신', 4, 6),
('웹 서비스/웹 프로그래밍', 4, 6),
('PHP', 4, 9),
('모바일/무선/임베디드 프로그래밍', 4, 6);

-- Depth_5 --
INSERT INTO categories (category_name, category_depth, parent_category_id) VALUES
('데이터베이스 개론', 5, 22),
('MySQL', 5, 25),
('운영체제/소프트웨어 공학', 5, 22),
('SQL', 5, 25),
('데이터베이스 구축', 5, 25);
