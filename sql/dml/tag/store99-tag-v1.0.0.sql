SET sql_safe_updates=0;
DELETE FROM tags;
SET sql_safe_updates=1;
ALTER TABLE tags AUTO_INCREMENT = 1;

INSERT INTO tags (tag_name) VALUES 
('#분철'),
('#업무능력향상'),
('#컴공'),
('#개발자'),
('#코딩'),
('#자바'),
('#파이썬'),
('#성장하는개발자'),
('#AI'),
('#ChatGPT'),
('#개발자자기계발');
