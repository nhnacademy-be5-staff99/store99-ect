SET sql_safe_updates=0;
DELETE FROM point_histories;
SET sql_safe_updates=1;
ALTER TABLE point_histories AUTO_INCREMENT = 1;

INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (100000, "WELCOME", 2024-05-07 09:59:05, 1);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (10, "PURCHASE", 2024-05-08 13:00:05, 1);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (-10, "REFUND", 2024-05-08 15:19:05, 1);

INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (100000, "WELCOME", 2024-05-06 08:59:05, 2);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (5, "REVIEW", 2024-05-07 09:59:05, 2);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (10, "PURCHASE", 2024-05-08 10:06:05, 2);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (-5, "CANCEL", 2024-05-08 11:30:05, 2);
