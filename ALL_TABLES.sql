--BEGIN
--  FOR rec IN
--    (
--      SELECT
--        table_name
--      FROM
--        user_tables
--    )
--  LOOP
--    EXECUTE immediate 'DROP TABLE  '||rec.table_name || ' CASCADE CONSTRAINTS';
--  END LOOP;
--END;
--/

set serveroutput on;

/*
    PROCEDURE FOR CHECKING AND DROPPING THE SEQUENCE IF IT EXISTS
*/
CREATE OR REPLACE PROCEDURE CHECKANDREMOVESEQEUENCE(SEQUENCENAME IN VARCHAR2) IS
  c Number;
BEGIN
  SELECT count(*) INTO c FROM USER_SEQUENCES WHERE SEQUENCE_NAME = SEQUENCENAME;
  IF c = 1 THEN
    EXECUTE IMMEDIATE ('DROP SEQUENCE '|| SEQUENCENAME);
  END IF;
END;
/

/*
    PROCEDURE FOR CHECKING AND DROPPING TABLE IF IT EXISTS
*/
CREATE OR REPLACE PROCEDURE CHECKANDREMOVETABLE(TABLENAME IN VARCHAR2) IS
  c Number;
BEGIN
  SELECT count(*) INTO c FROM USER_TABLES WHERE TABLE_NAME = TABLENAME;
  IF c = 1 THEN
    EXECUTE IMMEDIATE ('DROP TABLE '|| TABLENAME || ' CASCADE CONSTRAINTS');
  END IF;
END;
/


EXECUTE CHECKANDREMOVESEQEUENCE('COUNTRY_ID_SEQ');

CREATE SEQUENCE COUNTRY_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    ORDER;


-- 
-- TABLE: ADDRESS 
--
EXECUTE CHECKANDREMOVETABLE('ADDRESS');
EXECUTE CHECKANDREMOVETABLE('BOOKING');
EXECUTE CHECKANDREMOVETABLE('CAR_CATEGORY');
EXECUTE CHECKANDREMOVETABLE('CAR_LISTING');
EXECUTE CHECKANDREMOVETABLE('CAR_REGISTRATION');
EXECUTE CHECKANDREMOVETABLE('CITY');
EXECUTE CHECKANDREMOVETABLE('COUNTRY');
EXECUTE CHECKANDREMOVETABLE('EMPLOYEE');
EXECUTE CHECKANDREMOVETABLE('PARKING');
EXECUTE CHECKANDREMOVETABLE('ROLE');
EXECUTE CHECKANDREMOVETABLE('STATE');
EXECUTE CHECKANDREMOVETABLE('TRANSACTION');
EXECUTE CHECKANDREMOVETABLE('USERS');

select * from user_tables;

CREATE TABLE ADDRESS(
    ADDRESS_ID        VARCHAR2(255)    NOT NULL,
    ADDRESS_LINE_1    VARCHAR2(255)    NOT NULL,
    ADDRESS_LINE_2    VARCHAR2(255)    NOT NULL,
    ZIPCODE           VARCHAR2(40)     NOT NULL,
    CITY_ID           VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (ADDRESS_ID)
)
;



-- 
-- TABLE: BOOKING 
--

CREATE TABLE BOOKING(
    BOOKING_ID            VARCHAR2(255)    NOT NULL,
    BOOKING_STATUS        VARCHAR2(60)     NOT NULL,
    CREATED_START_DATE    TIMESTAMP(6)     NOT NULL,
    CREATED_END_DATE      TIMESTAMP(6)     NOT NULL,
    ACTUAL_START_DATE     TIMESTAMP(6)     NOT NULL,
    ACTUAL_END_DATE       TIMESTAMP(6)     NOT NULL,
    COMMENTS              VARCHAR2(255),
    USER_ID               VARCHAR2(255)    NOT NULL,
    TRANSACTION_ID        VARCHAR2(255),
    LISTING_ID            VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (BOOKING_ID)
)
;



-- 
-- TABLE: CAR_CATEGORY
--

CREATE TABLE CAR_CATEGORY(
    CAR_CATEGORY_ID     VARCHAR2(255) NOT NULL,
    CAR_CATEGORY_NAME   VARCHAR2(60)  NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY (CAR_CATEGORY_ID)
);



-- 
-- TABLE: CAR_LISTING 
--

CREATE TABLE CAR_LISTING(
    LISTING_ID         VARCHAR2(255)    NOT NULL,
    AVAILABILITY       RAW(10)          NOT NULL,
    DATE_POSTED        DATE             NOT NULL,
    FEE_RATE           BINARY_FLOAT     NOT NULL,
    CAR_REGISTER_ID    VARCHAR2(255),
    PARKING_ID         VARCHAR2(255),
    CONSTRAINT PK9 PRIMARY KEY (LISTING_ID)
)
;



-- 
-- TABLE: CAR_REGISTRATION 
--

CREATE TABLE CAR_REGISTRATION(
    CAR_REGISTER_ID        VARCHAR2(255)    NOT NULL,
    CAR_NAME               VARCHAR2(60)     NOT NULL,
    CAR_COLOR              VARCHAR2(60)     NOT NULL,
    CAR_COMPANY            VARCHAR2(60)     NOT NULL,
    YEAR_OF_MANUFACTURE    DATE             NOT NULL,
    REGISTRATION_DATE      DATE             NOT NULL,
    FUEL_TYPE              VARCHAR2(60)     NOT NULL,
    TRANSMISSION_TYPE      VARCHAR2(60)     NOT NULL,
    NO_OF_SEATS            NUMBER(38, 0)    NOT NULL,
    CAR_CATEGORY_ID           VARCHAR2(255)    NOT NULL,
    EMPLOYEE_ID            VARCHAR2(255)    NOT NULL,
    ADDRESS_ID             VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY (CAR_REGISTER_ID)
)
;



-- 
-- TABLE: City 
--

CREATE TABLE City(
    CITY_ID      VARCHAR2(255)    NOT NULL,
    CITY_NAME    VARCHAR2(60)     NOT NULL,
    STATE_ID     VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (CITY_ID)
)
;



-- 
-- TABLE: COUNTRY 
--

CREATE TABLE COUNTRY(
    COUNTRY_ID      VARCHAR2(255)    NOT NULL,
    COUNTRY_NAME    VARCHAR2(60)     NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (COUNTRY_ID)
)
;



-- 
-- TABLE: EMPLOYEE 
--

CREATE TABLE EMPLOYEE(
    EMPLOYEE_ID        VARCHAR2(255)    NOT NULL,
    EMP_FIRST_NAME     VARCHAR2(60)     NOT NULL,
    EMP_LAST_NAME      VARCHAR2(60)     NOT NULL,
    EMP_EMAIL          VARCHAR2(255)    NOT NULL,
    EMP_PASSWORD       VARCHAR2(255)    NOT NULL,
    DATE_OF_JOINING    DATE,
    ADDRESS_ID         VARCHAR2(255)    NOT NULL,
    ROLE_ID            VARCHAR2(255),
    CONSTRAINT PK5 PRIMARY KEY (EMPLOYEE_ID)
)
;



-- 
-- TABLE: PARKING 
--

CREATE TABLE PARKING(
    PARKING_ID    VARCHAR2(255)    NOT NULL,
    ADDRESS_ID    VARCHAR2(255),
    CONSTRAINT PK11 PRIMARY KEY (PARKING_ID)
)
;



-- 
-- TABLE: ROLE 
--

CREATE TABLE ROLE(
    ROLE_ID      VARCHAR2(255)    NOT NULL,
    ROLE_NAME    VARCHAR2(60)     NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (ROLE_ID)
)
;



-- 
-- TABLE: STATE 
--

CREATE TABLE STATE(
    STATE_ID      VARCHAR2(255)    NOT NULL,
    STATE_NAME    VARCHAR2(60)     NOT NULL,
    COUNTRY_ID    VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (STATE_ID)
)
;



-- 
-- TABLE: TRANSACTION 
--

CREATE TABLE TRANSACTION(
    TRANSACTION_ID    VARCHAR2(255)    NOT NULL,
    STATUS            VARCHAR2(60),
    TOTAL_COST        BINARY_FLOAT     NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY (TRANSACTION_ID)
)
;



-- 
-- TABLE: USER 
--

CREATE TABLE USERS(
    USER_ID            VARCHAR2(255)    NOT NULL,
    PASSWORD           VARCHAR2(255),
    USER_NAME          VARCHAR2(60)     NOT NULL,
    EMAIL              VARCHAR2(255)    NOT NULL,
    PHONE_NO           VARCHAR2(60)     NOT NULL,
    FIRST_NAME         VARCHAR2(60)     NOT NULL,
    LAST_NAME          VARCHAR2(60)     NOT NULL,
    DATE_OF_JOINING    DATE             NOT NULL,
    DRIVER_LICENSE     VARCHAR2(255)    NOT NULL,
    PASSPORT           VARCHAR2(255),
    BLACKLISTED        RAW(10)          NOT NULL,
    ADDRESS_ID         VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY (USER_ID)
)
;



-- 
-- TABLE: ADDRESS 
--

ALTER TABLE ADDRESS ADD CONSTRAINT RefCity141 
    FOREIGN KEY (CITY_ID)
    REFERENCES City(CITY_ID)
;


-- 
-- TABLE: BOOKING 
--

ALTER TABLE BOOKING ADD CONSTRAINT RefUSER31 
    FOREIGN KEY (USER_ID)
    REFERENCES USERS(USER_ID)
;

ALTER TABLE BOOKING ADD CONSTRAINT RefTRANSACTION41 
    FOREIGN KEY (TRANSACTION_ID)
    REFERENCES TRANSACTION(TRANSACTION_ID)
;

ALTER TABLE BOOKING ADD CONSTRAINT RefCAR_LISTING51 
    FOREIGN KEY (LISTING_ID)
    REFERENCES CAR_LISTING(LISTING_ID)
;


-- 
-- TABLE: CAR_LISTING 
--

ALTER TABLE CAR_LISTING ADD CONSTRAINT RefCAR_REGISTRATION91 
    FOREIGN KEY (CAR_REGISTER_ID)
    REFERENCES CAR_REGISTRATION(CAR_REGISTER_ID)
;

ALTER TABLE CAR_LISTING ADD CONSTRAINT RefPARKING101 
    FOREIGN KEY (PARKING_ID)
    REFERENCES PARKING(PARKING_ID)
;


-- 
-- TABLE: CAR_REGISTRATION 
--

ALTER TABLE CAR_REGISTRATION ADD CONSTRAINT RefADDRESS151 
    FOREIGN KEY (ADDRESS_ID)
    REFERENCES ADDRESS(ADDRESS_ID)
;

ALTER TABLE CAR_REGISTRATION ADD CONSTRAINT RefCAR_CATEGORY161 
    FOREIGN KEY (CAR_CATEGORY_ID)
    REFERENCES CAR_CATEGORY(CAR_CATEGORY_ID)
;

ALTER TABLE CAR_REGISTRATION ADD CONSTRAINT RefEMPLOYEE81 
    FOREIGN KEY (EMPLOYEE_ID)
    REFERENCES EMPLOYEE(EMPLOYEE_ID)
;


-- 
-- TABLE: City 
--

ALTER TABLE City ADD CONSTRAINT RefSTATE131 
    FOREIGN KEY (STATE_ID)
    REFERENCES STATE(STATE_ID)
;


-- 
-- TABLE: EMPLOYEE 
--

ALTER TABLE EMPLOYEE ADD CONSTRAINT RefADDRESS11 
    FOREIGN KEY (ADDRESS_ID)
    REFERENCES ADDRESS(ADDRESS_ID)
;

ALTER TABLE EMPLOYEE ADD CONSTRAINT RefROLE111 
    FOREIGN KEY (ROLE_ID)
    REFERENCES ROLE(ROLE_ID)
;


-- 
-- TABLE: PARKING 
--

ALTER TABLE PARKING ADD CONSTRAINT RefADDRESS61 
    FOREIGN KEY (ADDRESS_ID)
    REFERENCES ADDRESS(ADDRESS_ID)
;


-- 
-- TABLE: STATE 
--

ALTER TABLE STATE ADD CONSTRAINT RefCOUNTRY121 
    FOREIGN KEY (COUNTRY_ID)
    REFERENCES COUNTRY(COUNTRY_ID)
;


-- 
-- TABLE: USER 
--

ALTER TABLE USERS ADD CONSTRAINT RefADDRESS21 
    FOREIGN KEY (ADDRESS_ID)
    REFERENCES ADDRESS(ADDRESS_ID)
;

select * from user_tables;   