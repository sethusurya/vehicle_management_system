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

--select * from user_tables;

CREATE TABLE ADDRESS(
    ADDRESS_ID        VARCHAR2(255)    NOT NULL,
    ADDRESS_LINE_1    VARCHAR2(255)    NOT NULL,
    ADDRESS_LINE_2    VARCHAR2(255)    NOT NULL,
    ZIPCODE           VARCHAR2(40)     NOT NULL,
    ADDRESS_TYPE      VARCHAR2(255)    NOT NULL,
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
    CREATED_START_DATE    TIMESTAMP(6)     ,
    CREATED_END_DATE      TIMESTAMP(6)     ,
    ACTUAL_START_DATE     TIMESTAMP(6)     ,
    ACTUAL_END_DATE       TIMESTAMP(6)     ,
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
    AVAILABILITY       VARCHAR2(255)         NOT NULL,
    DATE_POSTED        DATE             NOT NULL,
    FEE_RATE           NUMBER(5,2)     NOT NULL,
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
    YEAR_OF_MANUFACTURE    NUMBER        NOT NULL,
    REGISTRATION_DATE      DATE             NOT NULL,
    FUEL_TYPE              VARCHAR2(60)     NOT NULL,
    TRANSMISSION_TYPE      VARCHAR2(60)     NOT NULL,
    NO_OF_SEATS            NUMBER        NOT NULL,
    CAR_CATEGORY_ID        VARCHAR2(255)    NOT NULL,
    EMPLOYEE_ID            VARCHAR2(255)    NOT NULL,
    ADDRESS_ID             VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY (CAR_REGISTER_ID)
)
;



-- 
-- TABLE: CITY
--

CREATE TABLE CITY(
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
    TOTAL_COST        NUMBER(5,2)     NOT NULL,
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
    BLACKLISTED        VARCHAR2(255)    NOT NULL,
    ADDRESS_ID         VARCHAR2(255)    NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY (USER_ID)
)
;



-- 
-- TABLE: ADDRESS 
--

ALTER TABLE ADDRESS ADD CONSTRAINT RefCity141 
    FOREIGN KEY (CITY_ID)
    REFERENCES CITY(CITY_ID)
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
-- TABLE: CITY
--

ALTER TABLE CITY ADD CONSTRAINT RefSTATE131 
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

--select * from user_tables;   



---------------------------------------------AUDIT----------------------------------------------

EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_BOOKING');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_COUNTRY');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_CITY');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_ADDRESS');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_EMPLOYEE');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_USER');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_CAR_LISTING');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_TRANSACTION');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_PARKING');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_CAR_CATEGORY');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_CAR_REGISTRATION');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_STATE');
EXECUTE CHECKANDREMOVETABLE('AUDIT_DATA_ROLES');

CREATE TABLE AUDIT_DATA_BOOKING (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_COUNTRY (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_CITY (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_ADDRESS (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_EMPLOYEE (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_USER (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_CAR_LISTING (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_TRANSACTION (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_PARKING (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_CAR_CATEGORY (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_CAR_REGISTRATION (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_STATE (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);

CREATE TABLE AUDIT_DATA_ROLES (
  AUDIT_ID NUMBER,
  USERNAME VARCHAR2(50),
  TABLE_NAME VARCHAR(50),
  AUDIT_DATE TIMESTAMP (6) DEFAULT systimestamp,
  ACTION VARCHAR2(25)
);


ALTER TABLE AUDIT_DATA_BOOKING MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_BOOKING MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_BOOKING ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_BOOKING MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_BOOKING MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_COUNTRY MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_COUNTRY MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_COUNTRY ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_COUNTRY MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_COUNTRY MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_CITY MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CITY MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CITY ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_CITY MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CITY MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_ADDRESS MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_ADDRESS MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_ADDRESS ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_ADDRESS MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_ADDRESS MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_EMPLOYEE MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_EMPLOYEE MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_EMPLOYEE ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_EMPLOYEE MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_EMPLOYEE MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_USER MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_USER MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_USER ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_USER MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_USER MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_CAR_LISTING MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_LISTING MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_LISTING ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_CAR_LISTING MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_LISTING MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_TRANSACTION MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_TRANSACTION MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_TRANSACTION ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_TRANSACTION MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_TRANSACTION MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_PARKING MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_PARKING MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_PARKING ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_PARKING MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_PARKING MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_CAR_CATEGORY MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_CATEGORY MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_CATEGORY ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_CAR_CATEGORY MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_CATEGORY MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_CAR_REGISTRATION MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_REGISTRATION MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_REGISTRATION ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_CAR_REGISTRATION MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_CAR_REGISTRATION MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_STATE MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_STATE MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_STATE ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_STATE MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_STATE MODIFY (TABLE_NAME NOT NULL ENABLE);

ALTER TABLE AUDIT_DATA_ROLES MODIFY (AUDIT_DATE NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_ROLES MODIFY (ACTION NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_ROLES ADD PRIMARY KEY (AUDIT_ID);
ALTER TABLE AUDIT_DATA_ROLES MODIFY (USERNAME NOT NULL ENABLE);
ALTER TABLE AUDIT_DATA_ROLES MODIFY (TABLE_NAME NOT NULL ENABLE);