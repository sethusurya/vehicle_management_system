CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_BOOKING_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_BOOKING values(AUDIT_BOOKING_ID_SEQ.nextval, user, 'BOOKING', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_BOOKING values(AUDIT_BOOKING_ID_SEQ.nextval, user, 'BOOKING', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_BOOKING values(AUDIT_BOOKING_ID_SEQ.nextval, user, 'BOOKING', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_COUNTRY_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_COUNTRY values(AUDIT_COUNTRY_ID_SEQ.nextval, user, 'COUNTRY', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_COUNTRY values(AUDIT_COUNTRY_ID_SEQ.nextval, user, 'COUNTRY', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_COUNTRY values(AUDIT_COUNTRY_ID_SEQ.nextval, user, 'COUNTRY', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_CITY_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_CITY values(AUDIT_CITY_ID_SEQ.nextval, user, 'CITY', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_CITY values(AUDIT_CITY_ID_SEQ.nextval, user, 'CITY', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_CITY values(AUDIT_CITY_ID_SEQ.nextval, user, 'CITY', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_EMPLOYEE_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_EMPLOYEE values(AUDIT_EMPLOYEE_ID_SEQ.nextval, user, 'EMPLOYEE', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_EMPLOYEE values(AUDIT_EMPLOYEE_ID_SEQ.nextval, user, 'EMPLOYEE', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_EMPLOYEE values(AUDIT_EMPLOYEE_ID_SEQ.nextval, user, 'EMPLOYEE', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_USER_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_USER values(AUDIT_USER_ID_SEQ.nextval, user, 'USERS', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_USER values(AUDIT_USER_ID_SEQ.nextval, user, 'USERS', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_USER values(AUDIT_USER_ID_SEQ.nextval, user, 'USERS', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_STATE_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_STATE values(AUDIT_STATE_ID_SEQ.nextval, user, 'STATE', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_STATE values(AUDIT_STATE_ID_SEQ.nextval, user, 'STATE', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_STATE values(AUDIT_STATE_ID_SEQ.nextval, user, 'STATE', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_LISTING_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_CAR_LISTING values(AUDIT_CAR_LISTING_ID_SEQ.nextval, user, 'CAR_LISTING', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_CAR_LISTING values(AUDIT_CAR_LISTING_ID_SEQ.nextval, user, 'CAR_LISTING', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_CAR_LISTING values(AUDIT_CAR_LISTING_ID_SEQ.nextval, user, 'CAR_LISTING', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_ADDRESS_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_ADDRESS values(AUDIT_ADDRESS_ID_SEQ.nextval, user, 'ADDRESS', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_ADDRESS values(AUDIT_ADDRESS_ID_SEQ.nextval, user, 'ADDRESS', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_ADDRESS values(AUDIT_ADDRESS_ID_SEQ.nextval, user, 'ADDRESS', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_ROLE_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_ROLES values(AUDIT_ROLE_ID_SEQ.nextval, user, 'ROLE', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_ROLES values(AUDIT_ROLE_ID_SEQ.nextval, user, 'ROLE', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_ROLES values(AUDIT_ROLE_ID_SEQ.nextval, user, 'ROLE', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_PARKING_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_PARKING values(AUDIT_PARKING_ID_SEQ.nextval, user, 'PARKING', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_PARKING values(AUDIT_PARKING_ID_SEQ.nextval, user, 'PARKING', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_PARKING values(AUDIT_PARKING_ID_SEQ.nextval, user, 'PARKING', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_CAR_CATEGORY_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_CAR_CATEGORY values(AUDIT_CAR_CATEGORY_ID_SEQ.nextval, user, 'CAR_CATEGORY', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_CAR_CATEGORY values(AUDIT_CAR_CATEGORY_ID_SEQ.nextval, user, 'CAR_CATEGORY', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_CAR_CATEGORY values(AUDIT_CAR_CATEGORY_ID_SEQ.nextval, user, 'CAR_CATEGORY', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_CAR_REG_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_CAR_REGISTRATION values(AUDIT_CAR_REGISTRATION_ID_SEQ.nextval, user, 'CAR_REGISTRATION', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_CAR_REGISTRATION values(AUDIT_CAR_REGISTRATION_ID_SEQ.nextval, user, 'CAR_REGISTRATION', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_CAR_REGISTRATION values(AUDIT_CAR_REGISTRATION_ID_SEQ.nextval, user, 'CAR_REGISTRATION', systimestamp, 'DELETE');
    END CASE;
END;
/

CREATE OR REPLACE EDITIONABLE TRIGGER AUDIT_TRANSACTION_TRGR   
    AFTER INSERT OR UPDATE OR DELETE
    ON BOOKING
    FOR EACH ROW
    BEGIN
    CASE
        WHEN INSERTING THEN
        INSERT INTO AUDIT_DATA_TRANSACTION values(AUDIT_TRANSACTION_ID_SEQ.nextval, user, 'TRANSACTION', systimestamp, 'INSERT');
        WHEN UPDATING THEN
        INSERT INTO AUDIT_DATA_TRANSACTION values(AUDIT_TRANSACTION_ID_SEQ.nextval, user, 'TRANSACTION', systimestamp, 'UPDATE');
        WHEN DELETING THEN
        INSERT INTO AUDIT_DATA_TRANSACTION values(AUDIT_TRANSACTION_ID_SEQ.nextval, user, 'TRANSACTION', systimestamp, 'DELETE');
    END CASE;
END;
/