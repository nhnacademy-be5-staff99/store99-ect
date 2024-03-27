USE staff99_coupon;

DROP TABLE IF EXISTS `category_coupons`;
DROP TABLE IF EXISTS `fixed_term_coupons`;
DROP TABLE IF EXISTS `book_coupons`;
DROP TABLE IF EXISTS `user_coupons`;
DROP TABLE IF EXISTS `coupons`;

CREATE TABLE `coupons`
(
    `coupon_id`                     BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `coupon_name`                   VARCHAR(255) NOT NULL,
    `coupon_type`                   VARCHAR(10)  NOT NULL CHECK (`coupon_type` IN ('WELCOME', 'BOOK', 'CATEGORY', 'BIRTH')),
    `coupon_discount_type`          VARCHAR(255) NOT NULL CHECK (`coupon_discount_type` IN ('FIX', 'FLEXIBLE')),
    `coupon_minimal_order_price`    BIGINT       NOT NULL,
    `coupon_maximum_discount_price` BIGINT       NOT NULL,
    `coupon_discount_price`         BIGINT       NOT NULL,
    `coupon_start_date`             DATE         NOT NULL,
    `coupon_end_date`               DATE         NOT NULL
);

CREATE TABLE `user_coupons`
(
    `user_coupon_id`         BIGINT   NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`                BIGINT   NOT NULL,
    `user_coupon_use_date`   DATETIME NULL,
    `user_coupon_issue_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `coupon_id`              BIGINT   NOT NULL,

    FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`)
);

CREATE TABLE `book_coupons`
(
    `coupon_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `book_id`   BIGINT NOT NULL,

    FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`)
);

CREATE TABLE `fixed_term_coupons`
(
    `coupon_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,

    FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`)
);

CREATE TABLE `category_coupons`
(
    `coupon_id`   BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_id` BIGINT NOT NULL,

    FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`)
);