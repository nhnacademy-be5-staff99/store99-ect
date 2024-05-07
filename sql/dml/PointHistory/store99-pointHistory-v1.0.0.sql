SET sql_safe_updates=0;
DELETE FROM point_histories;
SET sql_safe_updates=1;
ALTER TABLE point_histories AUTO_INCREMENT = 1;

INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (100000, "WELCOME", now(), 1);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (10, "PURCHASE", now(), 1);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (-10, "REFUND", now(), 1);

INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (100000, "WELCOME", now(), 2);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (5, "REVIEW", now(), 2);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (10, "PURCHASE", now(), 2);
INSERT INTO point_histories(point_history_value, point_history_type, created_at, user_id) VALUES (-5, "CANCEL", now(), 2);
