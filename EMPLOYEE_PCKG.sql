CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_EMPLOYEE AS
     PROCEDURE INSERT_EMPLOYEE(
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type,
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vROLE_ID IN ROLE.ROLE_ID%type
    );
END PCKG_EMPLOYEE;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_EMPLOYEE AS
    PROCEDURE INSERT_EMPLOYEE(
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type,
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vROLE_ID IN ROLE.ROLE_ID%type
    ) AS
    vCount NUMBER(5);
    vCount2 NUMBER(5);
    ex_INVALID_FIRST_NAME EXCEPTION;
    ex_INVALID_LAST_NAME EXCEPTION;
    INVALID_EMAIL EXCEPTION;
    ex_INVALID_PASSWORD EXCEPTION;
    ex_INVALID_ADDRESS EXCEPTION;
    ex_INVALID_ROLE EXCEPTION;
BEGIN

    if vEMP_FIRST_NAME is NULL or REGEXP_LIKE(TRIM(vEMP_FIRST_NAME) , '^[0-9]*$') is NULL then
        raise ex_INVALID_FIRST_NAME;
    end if;
    
    if vEMP_LAST_NAME is NULL or REGEXP_LIKE(TRIM(vEMP_LAST_NAME) , '^[0-9]*$') is NULL then
        raise ex_INVALID_LAST_NAME;
    end if;
    
    if vEMP_EMAIL is NULL or LENGTH(TRIM(vEMP_EMAIL)) is NULL or NOT (TRIM(vEMP_EMAIL)) LIKE '%@_%._%' then
        raise INVALID_EMAIL;
    end if;
    
    if vEMP_PASSWORD is NULL or LENGTH(TRIM(vEMP_PASSWORD)) is NULL then
        raise ex_INVALID_PASSWORD;
    end if;
    BEGIN
        SELECT count(*) INTO vCount FROM ADDRESS WHERE ADDRESS_TYPE='EMPLOYEE' and ADDRESS_ID= UPPER(TRIM(vADDRESS_ID));
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                vCount := 0;
    END;
    IF vCount < 1 THEN
        RAISE ex_INVALID_ADDRESS;
    END IF;
    BEGIN
        SELECT count(*) INTO vCount2 FROM ROLE WHERE ROLE_ID = UPPER(TRIM(vROLE_ID));
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                vCount2 := 0;
    END;
    IF vCount2 < 1 THEN
        RAISE ex_INVALID_ROLE;
    END IF;
    INSERT INTO EMPLOYEE(EMPLOYEE_ID, EMP_FIRST_NAME, EMP_LAST_NAME, EMP_EMAIL, EMP_PASSWORD, DATE_OF_JOINING, ADDRESS_ID, ROLE_ID)
    VALUES
    ('EMPLOYEE_'||EMPLOYEE_ID_SEQ.NEXTVAL, vEMP_FIRST_NAME,vEMP_LAST_NAME, vEMP_EMAIL, vEMP_PASSWORD, SYSDATE, vADDRESS_ID, vROLE_ID);

EXCEPTION
    when ex_INVALID_FIRST_NAME then
        dbms_output.put_line('First name is invalid !!!');
    when ex_INVALID_LAST_NAME then
        dbms_output.put_line('Last name is invalid !!!');
    when INVALID_EMAIL then
        dbms_output.put_line('Email is invalid !!!');
    when ex_INVALID_PASSWORD then
        dbms_output.put_line('password is invalid !!!');
--    when ex_INVALID_DATE_OF_JOINING then
--    dbms_output.put_line('DATE of joining is invalid !!!');
    when ex_INVALID_ADDRESS then
        dbms_output.put_line('ADDRESS DOES NOT EXIST !!!');
    when ex_INVALID_ROLE THEN
        dbms_output.put_line('INVALID ROLE');
    END INSERT_EMPLOYEE;
END PCKG_EMPLOYEE;
/


-- EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('Noordeep', 'Gill', 'noordeepgill@gmail.com', '12345', '1', '1');