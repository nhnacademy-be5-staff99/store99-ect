drop table if exists `books`;
drop table if exists `users`;
drop table if exists `wrappers`;
drop table if exists `point_historys`;
drop table if exists `point_histories`;
drop table if exists `grades`;
drop table if exists `categories`;
drop table if exists `book_categories`;
drop table if exists `tags`;
drop table if exists `book_tag`;
drop table if exists `order_books`;
drop table if exists `orders`;
drop table if exists `addresses`;
drop table if exists `payments`;
drop table if exists `reviewes`;
drop table if exists `likes`;
drop table if exists `authors`;
drop table if exists `book_author`;
drop table if exists `user_coupons`;
drop table if exists `carts`;
drop table if exists `book_coupons`;
drop table if exists `consumer`;
drop table if exists `fixed_term_coupons`;
drop table if exists `category_coupons`;
drop table if exists `book_images`;
drop table if exists `wrapper_images`;
drop table if exists `review_images`;
drop table if exists `auth`;
drop table if exists `coupons`;
drop table if exists `files`;

CREATE TABLE if not exists `books` (
                         `book_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                         `book_isbn13`	VARCHAR(17)	NULL,
                         `book_isbn11`	VARCHAR(15)	NULL,
                         `book_title`	VARCHAR(255)	NOT NULL,
                         `book_contents`	VARCHAR(255)	NOT NULL,
                         `book_description`	TEXT	NOT NULL,
                         `book_publisher`	VARCHAR(255)	NOT NULL,
                         `book_date`	DATETIME	NOT NULL,
                         `book_price`	INT	NOT NULL,
                         `book_sale_price`	INT	NOT NULL,
                         `book_pack`	TINYINT	NOT NULL,
                         `book_thumbnail_url`	VARCHAR(255)	NULL,
                         `book_view_count`	INT	NOT NULL	DEFAULT 0,
                         `book_stock`	INT	NOT NULL	DEFAULT 0,
                         `book_cnt_of_review`	INT	NOT NULL	DEFAULT 0,
                         `book_avg_of_rate`	FLOAT	NOT NULL	DEFAULT 0,
                         `created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                         `updated_at`	DATETIME	NULL,
                         `deleted_at`	DATETIME	NULL

);

CREATE TABLE `users` (
                         `user_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                         `user_birthdate`	DATE	NOT NULL,
                         `grade_id`	BIGINT	NOT NULL,
                         `user_login_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                         `user_is_inactive`	TINYINT	NOT NULL	DEFAULT 0,
                         `created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                         `deleted_at`	DATETIME	NULL,
                         `auth_id`	BIGINT	NOT NULL,
                         `user_point`	INT	NOT NULL	DEFAULT 0,
                         `consumer_id`	BIGINT	NOT NULL
);

CREATE TABLE `wrappers` (
                            `wrapper_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                            `warpper_name`	VARCHAR(255)	NULL,
                            `warpper_cost`	INT	NULL
);

CREATE TABLE `point_histories` (
                                  `point_history_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                                  `point_history_value`	INT	NOT NULL,
                                  `point_history_desc`	VARCHAR(20)	NOT NULL	COMMENT 'purchase, cashback, refund, cancel, review',
                                  `created_at`	DATETIME	NOT NULL,
                                  `user_id`	BIGINT	NOT NULL
);

CREATE TABLE `grades` (
                          `grade_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                          `grade_name`	VARCHAR(10)	NOT NULL	COMMENT '등급 명(BASIC, ROYAL, GOLD, PLATINUM)',
                          `grade_start_cost`	INT	NOT NULL	COMMENT '시작 금액(이상)',
                          `grade_end_cost`	INT	NOT NULL	COMMENT '끝 금액(미만)',
                          `grade_ratio`	INT	NOT NULL	COMMENT '접립률, 순수금액 * 적립률% 포인트 적립'
);

CREATE TABLE `categories` (
                              `category_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                              `category_name`	VARCHAR(255)	NOT NULL,
                              `parent_category_id`	BIGINT	NULL,
                              `deleted_at`	DATETIME	NULL
);

CREATE TABLE `book_categories` (
                                  `book_category_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                                  `book_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                                  `category_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT'
);

CREATE TABLE `tags` (
                        `tag_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                        `tag_name`	VARCHAR(255)	NOT NULL,
                        `deleted_at`	DATETIME	NULL
);

CREATE TABLE `book_tag` (
                            `book_tag_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                            `book_id`	BIGINT	NOT NULL,
                            `tag_id`	BIGINT	NOT NULL
);

CREATE TABLE `order_books` (
                               `order_book_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                               `order_book_price`	INT	NOT NULL,
                               `order_book_quantity`	INT	NOT NULL,
                               `order_book_wrapper_cost`	INT	NULL,
                               `wrapper_id`	BIGINT	NULL,
                               `book_id`	BIGINT	NOT NULL,
                               `order_id`	VARCHAR(36)	NOT NULL	COMMENT 'UUID'
);

CREATE TABLE `orders` (
                          `order_id`	VARCHAR(36)	NOT NULL	COMMENT 'UUID',
                          `order_type`	VARCHAR(10)	NOT NULL	COMMENT 'USER, NON_USER',
                          `order_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                          `order_transit_at`	DATE	NOT NULL,
                          `order_reciever_name`	VARCHAR(50)	NOT NULL,
                          `order_reciever_number`	VARCHAR(11)	NOT NULL,
                          `order_address`	VARCHAR(255)	NOT NULL,
                          `order_address_detail`	VARCHAR(255)	NOT NULL,
                          `order_address_code`	INT	NOT NULL,
                          `order_delivery_cost`	INT	NOT NULL	DEFAULT 5000,
                          `order_total_cost`	INT	NOT NULL,
                          `order_state`	VARCHAR(20)	NOT NULL	DEFAULT 'PENDING'	COMMENT 'PENDING, TRANSIT, COMPLETED, RETURNED, CANCELLED',
                          `order_release_at`	DATETIME	NULL,
                          `coupon_id`	BIGINT	NULL,
                          `consumer_id`	BIGINT	NOT NULL
);

CREATE TABLE `addresses` (
                             `address_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                             `address`	VARCHAR(255)	NOT NULL,
                             `address_detail`	VARCHAR(255)	NOT NULL,
                             `address_alias`	VARCHAR(50)	NULL,
                             `address_code`	INT	NOT NULL,
                             `user_id`	BIGINT	NOT NULL
);

CREATE TABLE `payments` (
                            `payment_key`	VARCHAR(200)	NOT NULL,
                            `order_id`	VARCHAR(36)	NOT NULL	COMMENT 'UUID'
);

CREATE TABLE `reviewes` (
                            `review_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                            `user_id`	BIGINT	NOT NULL,
                            `book_id`	BIGINT	NOT NULL,
                            `review_description`	VARCHAR(255)	NULL,
                            `review_rate`	INT	NULL	COMMENT '1~5'
);


CREATE TABLE `likes` (
                         `like_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                         `created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                         `user_id`	BIGINT	NOT NULL,
                         `book_id`	BIGINT	NOT NULL
);

CREATE TABLE `authors` (
                           `author_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                           `author_name`	VARCHAR(255)	NULL
);

CREATE TABLE `book_author` (
                               `book_author_id`	BIGINT	NOT NULL	COMMENT 'AUTO-INCREMENT',
                               `author_id`	BIGINT	NOT NULL,
                               `book_id`	BIGINT	NOT NULL
);

CREATE TABLE `user_coupons` (
                                `user_coupon_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                                `user_id`	BIGINT	NOT NULL,
                                `user_coupon_use_date`	DATETIME	NULL,
                                `user_coupon_issue_date`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                                `coupon_id`	BIGINT	NOT NULL
);

CREATE TABLE `carts` (
                         `cart_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                         `cart_amount`	INT	NOT NULL,
                         `user_id`	BIGINT	NOT NULL,
                         `book_id`	BIGINT	NOT NULL
);

CREATE TABLE `book_coupons` (
                                `coupon_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                                `book_id`	BIGINT	NOT NULL
);

CREATE TABLE `consumer` (
                            `consumer_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                            `consumer_name`	VARCHAR(50)	NOT NULL,
                            `consumer_email`	VARCHAR(320)	NOT NULL,
                            `consumer_phone`	VARCHAR(64)	NOT NULL,
                            `consumer_password`	VARCHAR(11)	NOT NULL
);

CREATE TABLE `fixed_term_coupons` (
                                      `coupon_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT'
);

CREATE TABLE `category_coupons` (
                                    `coupon_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                                    `category_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT'
);

CREATE TABLE `files` (
                         `file_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                         `file_name`	VARCHAR(255)	NOT NULL	COMMENT '확장자 포함',
                         `file_url`	VARCHAR(255)	NOT NULL,
                         `file_type`	VARCHAR(10)	NOT NULL	COMMENT 'REVIEW, WRAPPER, BOOK'
);

CREATE TABLE `book_images` (
                               `file_id`	BIGINT	NOT NULL,
                               `book_id`	BIGINT	NOT NULL
);

CREATE TABLE `wrapper_images` (
                                  `file_id`	BIGINT	NOT NULL,
                                  `wrapper_id`	BIGINT	NOT NULL
);

CREATE TABLE `review_images` (
                                 `file_id`	BIGINT	NOT NULL,
                                 `review_id`	BIGINT	NOT NULL
);

CREATE TABLE `auth` (
                        `auth_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                        `auth_name`	VARCHAR(50)	NOT NULL
);

CREATE TABLE `coupons` (
                           `coupon_id`	BIGINT	NOT NULL	COMMENT 'AUTO_INCREMENT',
                           `coupon_name`	VARCHAR(255)	NOT NULL,
                           `coupon_type`	VARCHAR(10)	NOT NULL	COMMENT 'WELCOME, BOOK, CATEGORY, BIRTH',
                           `coupon_discount_type`	VARCHAR(255)	NOT NULL	COMMENT 'FIX, FLEXIBLE',
                           `coupon_minimal_order_price`	BIGINT	NOT NULL,
                           `coupon_maximum_discount_price`	BIGINT	NOT NULL,
                           `coupon_discount_price`	BIGINT	NOT NULL,
                           `coupon_start_date`	DATE	NOT NULL,
                           `coupon_end_date`	DATE	NOT NULL
);

ALTER TABLE `books` ADD CONSTRAINT `PK_books` PRIMARY KEY (`book_id`);

ALTER TABLE `users` ADD CONSTRAINT `PK_users` PRIMARY KEY (`user_id`);

ALTER TABLE `wrappers` ADD CONSTRAINT `PK_wrappers` PRIMARY KEY (`wrapper_id`);

ALTER TABLE `point_histories` ADD CONSTRAINT `PK_point_history` PRIMARY KEY (`point_history_id`);

ALTER TABLE `grades` ADD CONSTRAINT `PK_grades` PRIMARY KEY (`grade_id`);

ALTER TABLE `categories` ADD CONSTRAINT `PK_categories` PRIMARY KEY (`category_id`);

ALTER TABLE `book_categories` ADD CONSTRAINT `PK_book_category` PRIMARY KEY (`book_category_id`);

ALTER TABLE `tags` ADD CONSTRAINT `PK_tags` PRIMARY KEY (`tag_id`);

ALTER TABLE `book_tag` ADD CONSTRAINT `PK_book_tag` PRIMARY KEY (`book_tag_id`);

ALTER TABLE `order_books` ADD CONSTRAINT `PK_order_books` PRIMARY KEY (`order_book_id`);

ALTER TABLE `orders` ADD CONSTRAINT `PK_orders` PRIMARY KEY (`order_id`);

ALTER TABLE `addresses` ADD CONSTRAINT `PK_addresses` PRIMARY KEY (`address_id`);

-- ALTER TABLE `payments` ADD CONSTRAINT `PK_payments` PRIMARY KEY (`payment_id`);

ALTER TABLE `reviewes` ADD CONSTRAINT `PK_reviews` PRIMARY KEY (`review_id`);

ALTER TABLE `coupons` ADD CONSTRAINT `PK_coupons` PRIMARY KEY (`coupon_id`);

ALTER TABLE `likes` ADD CONSTRAINT `PK_likes` PRIMARY KEY (`like_id`);

ALTER TABLE `authors` ADD CONSTRAINT `PK_authors` PRIMARY KEY (`author_id`);

ALTER TABLE `book_author` ADD CONSTRAINT `PK_book_author` PRIMARY KEY (`book_author_id`);

ALTER TABLE `user_coupons` ADD CONSTRAINT `PK_user_coupons` PRIMARY KEY (`user_coupon_id`);

ALTER TABLE `carts` ADD CONSTRAINT `PK_carts` PRIMARY KEY (`cart_id`);

ALTER TABLE `book_coupons` ADD CONSTRAINT `PK_book_coupons` PRIMARY KEY (`coupon_id`);

ALTER TABLE `consumer` ADD CONSTRAINT `PK_consumer` PRIMARY KEY (`consumer_id`);

ALTER TABLE `fixed_term_coupons` ADD CONSTRAINT `PK_fixed_term_coupons` PRIMARY KEY (`coupon_id`);

ALTER TABLE `category_coupons` ADD CONSTRAINT `PK_category_coupons` PRIMARY KEY (`coupon_id`);

ALTER TABLE `files` ADD CONSTRAINT `PK_files` PRIMARY KEY (`file_id`);

ALTER TABLE `book_images` ADD CONSTRAINT `PK_book_images` PRIMARY KEY (`file_id`);

ALTER TABLE `wrapper_images` ADD CONSTRAINT `PK_wrapper_images` PRIMARY KEY (`file_id`);

ALTER TABLE `review_images` ADD CONSTRAINT `PK_review_images` PRIMARY KEY (`file_id`);

ALTER TABLE `auth` ADD CONSTRAINT `PK_auth` PRIMARY KEY (`auth_id`);

ALTER TABLE `book_coupons` ADD CONSTRAINT `FK_book_coupons_TO_coupons` FOREIGN KEY (`coupon_id`)
    REFERENCES `coupons` (`coupon_id`);

ALTER TABLE `fixed_term_coupons` ADD CONSTRAINT `FK_fixed_term_coupons_TO_coupons` FOREIGN KEY (`coupon_id`)
    REFERENCES `coupons` (`coupon_id`);

ALTER TABLE `category_coupons` ADD CONSTRAINT `FK_coupons_TO_category_coupons_1` FOREIGN KEY (`coupon_id`)
    REFERENCES `coupons` (`coupon_id`);

ALTER TABLE `book_images` ADD CONSTRAINT `FK_files_TO_book_images_1` FOREIGN KEY (`file_id`)
    REFERENCES `files` (`file_id`);

ALTER TABLE `wrapper_images` ADD CONSTRAINT `FK_files_TO_wrapper_images_1` FOREIGN KEY (`file_id`)
    REFERENCES `files` (`file_id`);

ALTER TABLE `review_images` ADD CONSTRAINT `FK_files_TO_review_images_1` FOREIGN KEY (`file_id`)
    REFERENCES `files` (`file_id`);
