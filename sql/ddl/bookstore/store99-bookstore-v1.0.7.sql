USE staff99_bookstore;

DROP TABLE IF EXISTS `review_images`;
DROP TABLE IF EXISTS `wrapper_images`;
DROP TABLE IF EXISTS `book_images`;
DROP TABLE IF EXISTS `files`;
DROP TABLE IF EXISTS `carts`;
DROP TABLE IF EXISTS `book_author`;
DROP TABLE IF EXISTS `authors`;
DROP TABLE IF EXISTS `likes`;
DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `payments`;
DROP TABLE IF EXISTS `addresses`;
DROP TABLE IF EXISTS `order_book`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `book_tag`;
DROP TABLE IF EXISTS `tags`;
DROP TABLE IF EXISTS `book_category`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `point_histories`;
DROP TABLE IF EXISTS `wrappers`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `auths`;
DROP TABLE IF EXISTS `consumers`;
DROP TABLE IF EXISTS `grades`;
DROP TABLE IF EXISTS `books`;

CREATE TABLE IF NOT EXISTS `books`
(
    `book_id`            BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `book_isbn13`        VARCHAR(13)  NULL,
    `book_isbn10`        VARCHAR(10)  NULL,
    `book_title`         VARCHAR(255) NOT NULL,
    `book_contents`      LONGTEXT     NOT NULL,
    `book_description`   LONGTEXT     NOT NULL,
    `book_publisher`     VARCHAR(255) NOT NULL,
    `book_date`          DATETIME     NOT NULL,
    `book_price`         INT          NOT NULL,
    `book_sale_price`    INT          NOT NULL,
    `book_is_packed`     TINYINT(1)   NOT NULL,
    `book_thumbnail_url` VARCHAR(255) NULL,
    `book_view_count`    INT          NOT NULL DEFAULT 0,
    `book_stock`         INT          NOT NULL DEFAULT 0,
    `book_cnt_of_review` INT          NOT NULL DEFAULT 0,
    `book_avg_of_rate`   DOUBLE       NOT NULL DEFAULT 0.0,
    `created_at`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`         DATETIME     NULL,
    `deleted_at`         DATETIME     NULL
);

CREATE TABLE `grades`
(
    `grade_id`         BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `grade_name`       VARCHAR(10) NOT NULL COMMENT 'BASIC, ROYAL, GOLD, PLATINUM',
    `grade_start_cost` INT         NOT NULL COMMENT '시작 금액(이상)',
    `grade_end_cost`   INT         NOT NULL COMMENT '끝 금액(미만)',
    `grade_ratio`      INT         NOT NULL COMMENT '접립률, 순수금액 * 적립률% 포인트 적립'
);

CREATE TABLE `consumers`
(
    `consumer_id`       BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `consumer_name`     VARCHAR(50)  NOT NULL,
    `consumer_email`    VARCHAR(320) NOT NULL UNIQUE,
    `consumer_phone`    VARCHAR(11)  NOT NULL,
    `consumer_password` VARCHAR(64)  NOT NULL
);

CREATE TABLE `auths`
(
    `auth_id`   BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `auth_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `users`
(
    `user_id`          BIGINT     NOT NULL PRIMARY KEY,
    `user_birthdate`   DATE       NOT NULL,
    `grade_id`         BIGINT     NOT NULL,
    `user_login_at`    DATETIME   NULL,
    `user_is_inactive` TINYINT(1) NOT NULL DEFAULT 0,
    `created_at`       DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `deleted_at`       DATETIME   NULL,
    `auth_id`          BIGINT     NOT NULL,
    `user_point`       INT        NOT NULL DEFAULT 0,

    FOREIGN KEY (`grade_id`) REFERENCES `grades` (`grade_id`),
    FOREIGN KEY (`auth_id`) REFERENCES `auths` (`auth_id`),
    FOREIGN KEY (`user_id`) REFERENCES `consumers` (`consumer_id`)
);

CREATE TABLE `wrappers`
(
    `wrapper_id`   BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `wrapper_name` VARCHAR(255) NOT NULL,
    `wrapper_cost` INT          NOT NULL
);

CREATE TABLE `point_histories`
(
    `point_history_id`    BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `point_history_value` INT         NOT NULL,
    `point_history_type`  VARCHAR(20) NOT NULL CHECK (`point_history_type` IN
                                                      ('PURCHASE', 'CASHBACK', 'REFUND', 'CANCEL', 'REVIEW')),
    `created_at`          DATETIME    NOT NULL,
    `user_id`             BIGINT      NOT NULL
);

CREATE TABLE `categories`
(
    `category_id`        BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_name`      VARCHAR(255) NOT NULL,
    `category_depth`     INT          NOT NULL DEFAULT 1,
    `parent_category_id` BIGINT       NULL,
    `deleted_at`         DATETIME     NULL,

    FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`category_id`)
);

CREATE TABLE `book_category`
(
    `book_category_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `book_id`          BIGINT NOT NULL,
    `category_id`      BIGINT NOT NULL,

    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
);

CREATE TABLE `tags`
(
    `tag_id`     BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `tag_name`   VARCHAR(255) NOT NULL,
    `deleted_at` DATETIME     NULL
);

CREATE TABLE `book_tag`
(
    `book_tag_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `book_id`     BIGINT NOT NULL,
    `tag_id`      BIGINT NOT NULL,

    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
    FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
);

CREATE TABLE `orders`
(
    `order_id`              VARCHAR(36)  NOT NULL COMMENT 'UUID' PRIMARY KEY,
    `order_type`            VARCHAR(10)  NOT NULL CHECK (`order_type` IN ('USER', 'NON_USER')),
    `order_at`              DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `order_transit_at`      DATE         NOT NULL,
    `order_receiver_name`   VARCHAR(50)  NOT NULL,
    `order_receiver_number` VARCHAR(11)  NOT NULL,
    `order_address`         VARCHAR(255) NOT NULL,
    `order_address_detail`  VARCHAR(255) NOT NULL,
    `order_address_code`    INT          NOT NULL,
    `order_delivery_cost`   INT          NOT NULL DEFAULT 5000,
    `order_total_cost`      INT          NOT NULL,
    `order_state`           VARCHAR(20)  NOT NULL DEFAULT 'PENDING' CHECK (`order_state` IN
                                                                           ('PENDING', 'TRANSIT', 'COMPLETED',
                                                                            'RETURNED', 'CANCELLED')),
    `order_release_at`      DATETIME     NULL,
    `coupon_id`             BIGINT       NULL,
    `consumer_id`           BIGINT       NOT NULL
);


CREATE TABLE `order_book`
(
    `order_book_id`           BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_book_price`        INT         NOT NULL,
    `order_book_quantity`     INT         NOT NULL,
    `order_book_wrapper_cost` INT         NULL,
    `wrapper_id`              BIGINT      NULL,
    `book_id`                 BIGINT      NOT NULL,
    `order_id`                VARCHAR(36) NOT NULL,

    FOREIGN KEY (`wrapper_id`) REFERENCES `wrappers` (`wrapper_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
);

CREATE TABLE `addresses`
(
    `address_id`     BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `address`        VARCHAR(255) NOT NULL,
    `address_detail` VARCHAR(255) NOT NULL,
    `address_alias`  VARCHAR(50)  NULL,
    `address_code`   INT          NOT NULL,
    `user_id`        BIGINT       NOT NULL,

    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
);

CREATE TABLE `payments`
(
    `payment_key` VARCHAR(200) NOT NULL PRIMARY KEY,
    `order_id`    VARCHAR(36)  NOT NULL,

    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
);

CREATE TABLE `reviews`
(
    `review_id`          BIGINT        NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`            BIGINT        NOT NULL,
    `book_id`            BIGINT        NOT NULL,
    `review_description` VARCHAR(3000) NULL,
    `review_rate`        INT           NULL CHECK (`review_rate` BETWEEN 1 AND 5),

    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
);

CREATE TABLE `likes`
(
    `like_id`    BIGINT   NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `user_id`    BIGINT   NOT NULL,
    `book_id`    BIGINT   NOT NULL,

    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
);

CREATE TABLE `authors`
(
    `author_id`   BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `author_name` VARCHAR(255) NULL
);

CREATE TABLE `book_author`
(
    `book_author_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `author_id`      BIGINT NOT NULL,
    `book_id`        BIGINT NOT NULL,

    FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
);

CREATE TABLE `carts`
(
    `cart_id`         BIGINT     NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cart_amount`     INT        NOT NULL,
    `user_id`         BIGINT     NOT NULL,
    `book_id`         BIGINT     NOT NULL,
    `cart_is_checked` TINYINT(1) NOT NULL DEFAULT 0,

    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
);

CREATE TABLE `files`
(
    `file_id`    BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `file_name`  VARCHAR(255) NOT NULL COMMENT '확장자 포함',
    `file_url`   VARCHAR(255) NOT NULL,
    `file_type`  VARCHAR(10)  NOT NULL CHECK (`file_type` IN ('REVIEW', 'WRAPPER', 'BOOK')),
    `created_at` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `deleted_at` DATETIME     NULL
);

CREATE TABLE `book_images`
(
    `file_id` BIGINT NOT NULL PRIMARY KEY,
    `book_id` BIGINT NOT NULL,
    `book_image_type` VARCHAR(10) NOT NULL CHECK (`book_image_type` IN ('THUMBNAIL', 'DETAIL')),

    FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
);

CREATE TABLE `wrapper_images`
(
    `file_id`    BIGINT NOT NULL PRIMARY KEY,
    `wrapper_id` BIGINT NOT NULL,

    FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`),
    FOREIGN KEY (`wrapper_id`) REFERENCES `wrappers` (`wrapper_id`)
);


CREATE TABLE `review_images`
(
    `file_id`   BIGINT NOT NULL PRIMARY KEY,
    `review_id` BIGINT NOT NULL,

    FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`),
    FOREIGN KEY (`review_id`) REFERENCES `reviews` (`review_id`)
);
