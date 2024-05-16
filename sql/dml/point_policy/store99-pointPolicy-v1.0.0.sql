TRUNCATE TABLE point_policies;
ALTER TABLE point_policies
    AUTO_INCREMENT = 1;

-- point policies
INSERT INTO point_policies(policy_type, saving_point)
VALUE
( 'REVIEW_TEXT', 500 ),
( 'REVIEW_PHOTO', 1000 ),
( 'WELCOME', 100000 );
