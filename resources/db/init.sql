DROP DATABASE `ballerina_db`;

CREATE DATABASE `ballerina_db`;

USE `ballerina_db`;

DROP TABLE IF EXISTS `Post`;

DROP TABLE IF EXISTS `USER`;

DROP TABLE IF EXISTS `Sales`;

DROP TABLE IF EXISTS `Date`;

DROP TABLE IF EXISTS `Users`;

CREATE TABLE `Users` (
    `USERID` INT NOT NULL PRIMARY KEY,
    `USERNAME` CHAR(8) NOT NULL,
    `FIRSTNAME` VARCHAR(30) NOT NULL,
    `LASTNAME` VARCHAR(30) NOT NULL,
    `CITY` VARCHAR(30) NOT NULL,
    `STATE` CHAR(2) NOT NULL,
    `EMAIL` VARCHAR(100) NOT NULL,
    `PHONE` CHAR(14) NOT NULL
);

CREATE TABLE `Date` (
    `DATEID` SMALLINT NOT NULL PRIMARY KEY,
    `CALDATE` DATE NOT NULL,
    `DAY` CHAR(3) NOT NULL,
    `WEEK` SMALLINT NOT NULL,
    `MONTH` CHAR(3) NOT NULL,
    `QTR` CHAR(2) NOT NULL,
    `YEAR` SMALLINT NOT NULL,
    `HOLIDAY` TINYINT(1) NOT NULL
);

CREATE TABLE `Sales` (
    `SALESID` INT NOT NULL PRIMARY KEY,
    `SELLERID` INT NOT NULL ,
    `DATEID` SMALLINT NOT NULL,
    `QTYSOLD` SMALLINT NOT NULL,
    `PRICEPAID` DECIMAL(8, 2) NOT NULL,
    `COMMISSION` DECIMAL(8, 2) NOT NULL,
    `SALETIME` TIMESTAMP NOT NULL,
    FOREIGN KEY (SELLERID) REFERENCES Users(USERID),
    FOREIGN KEY (DATEID) REFERENCES Date(DATEID)
);

INSERT INTO
    `Users`
VALUES (
        1, 'johndoe1', 'John', 'Doe', 'New York', 'NY', 'john@example.com', '212-555-1212'
    );

INSERT INTO
    `Users`
VALUES (
        2, 'janedoe1', 'Jane', 'Doe', 'New York', 'NY', 'jane@example.com', '212-555-1213'
    );

INSERT INTO
    `Users`
VALUES (
        3, 'donnydoe', 'Donny', 'Doe', 'California', 'CL', 'donny@example.com', '213-555-1212'
    );

INSERT INTO
    `Date`
VALUES (
        1, '2016-01-01', 'Fri', 1, 'Jan', 'Q1', 2016, 1
    );

INSERT INTO
    `Date`
VALUES (
        2, '2016-01-02', 'Sat', 1, 'Jan', 'Q1', 2016, 0
    );

INSERT INTO
    `Date`
VALUES (
        3, '2016-01-03', 'Sun', 1, 'Jan', 'Q1', 2016, 1
    );

INSERT INTO
    `Date`
VALUES (
        4, '2016-01-04', 'Mon', 2, 'Jan', 'Q1', 2016, 0
    );

INSERT INTO
    `Date`
VALUES (
        5, '2016-01-05', 'Tue', 2, 'Jan', 'Q1', 2016, 0
    );

INSERT INTO
    `Date`
VALUES (
        6, '2016-01-06', 'Wed', 2, 'Jan', 'Q1', 2016, 0
    );

INSERT INTO
    `Date`
VALUES (
        7, '2016-01-07', 'Thu', 2, 'Jan', 'Q1', 2016, 0
    );

INSERT INTO
    `Date`
VALUES (
        8, '2016-01-08', 'Fri', 2, 'Jan', 'Q1', 2016, 0
    );

INSERT INTO
    `Sales`
VALUES (
        1, 1, 1, 1, 100.00, 10.00, '2016-01-01 12:00:00'
    );

INSERT INTO
    `Sales`
VALUES (
        2, 1, 2, 1, 100.00, 10.00, '2016-01-02 12:00:00'
    );

INSERT INTO
    `Sales`
VALUES (
        3, 1, 3, 1, 100.00, 10.00, '2016-01-03 12:00:00'
    );

INSERT INTO
    `Sales`
VALUES (
        4, 1, 4, 1, 100.00, 10.00, '2016-01-04 12:00:00'
    );

INSERT INTO
    `Sales`
VALUES (
        5, 1, 5, 1, 100.00, 10.00, '2016-01-05 12:00:00'
    );

INSERT INTO
    `Sales`
VALUES (
        6, 1, 6, 1, 100.00, 10.00, '2016-01-06 12:00:00'
    );
