- SEQUENCE FOR EMPLOYEE_ID
---------------------------------------------------------

    CREATE SEQUENCE EMPLOYEE _ID_SEQ
         START WITH 1
         INCREMENT BY 1
         ORDER;

--  DDL for Table EMPLOYEE
--------------------------------------------------------

  CREATE TABLE EMPLOYEE   
   (	  EMPLOYEE_ID   NUMBER(25,0), 
	  EMP_FIRST_NAME   VARCHAR2(60)  , 
	  EMP_LAST_NAME VARCHAR2(60)  , 
	  EMP_EMAIL  VARCHAR2(255)  ,
	  EMP_PASSWORD  VARCHAR2(255)  , 
	  DATE_OF_JOINING  DATE , 
	  ADDRESS_ID VARCHAR2(255),
	  ROLE_ID VARCHAR2(255) 
   )


--------------------------------------------------------
--  Constraints for Table EMPLOYEE
--------------------------------------------------------

	ALTER TABLE EMPLOYEE   MODIFY (  EMPLOYEE_ID   CONSTRAINT EMPLOYEE_ID_NOT_NULL  NOT NULL ENABLE);
	ALTER TABLE EMPLOYEE   ADD CONSTRAINT EMPLOYEE_ID_PK   PRIMARY KEY (  EMPLOYEE_ID  )
  	USING INDEX  ENABLE;
	ALTER TABLE EMPLOYEE   MODIFY (  EMP_FIRST_NAME   CONSTRAINT EMP_FIRST_NAME_NOT_NULL   NOT NULL ENABLE);
	ALTER TABLE EMPLOYEE   MODIFY (  EMP_LAST_NAME   CONSTRAINT EMP_LAST_NAME_NOT_NULL   NOT NULL ENABLE);
	ALTER TABLE EMPLOYEE   MODIFY (  DATE_OF_JOINING   CONSTRAINT DATE_OF_JOINING_NOT_NULL   NOT NULL ENABLE);
	ALTER TABLE EMPLOYEE   MODIFY (  EMP_EMAIL   CONSTRAINT EMP_EMAIL_NOT_NULL   NOT NULL ENABLE);
	ALTER TABLE EMPLOYEE   MODIFY (  EMP_PASSWORD   CONSTRAINT EMP_PASSWORD_NOT_NULL   NOT NULL ENABLE);
	ALTER TABLE EMPLOYEE   MODIFY (  ADDRESS_ID   CONSTRAINT ADDRESS_ID_NOT_NULL   NOT NULL ENABLE);
 	ALTER TABLE EMPLOYEE   MODIFY (  ROLE_ID   CONSTRAINT ROLE_ID_NOT_NULL   NOT NULL ENABLE);
 	
 	--ADDITION OF UNIQUE KEY CONSTRAINT TO EMAIL AND PASSWORD
 	ALTER TABLE EMPLOYEE  ADD CONSTRAINT EMP_EMAIL  UNIQUE (  EMP_EMAIL  )
  USING INDEX  ENABLE;
 
 
--------------------------------------------------------
--  DDL for Package PCKG_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_EMPLOYEE   AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */
    

    PROCEDURE INSERT_EMPLOYEE(
        vEMPLOYEE_ID IN EMPLOYEE.EMPLOYEE_ID%type,
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL %type,
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type,
        vDATE_OF_JOINING IN EMPLOYEE.DATE_OF_JOINING%type,
        vADDRESS_ID IN EMPLOYEE.ADDRESS_ID%type,
        vROLE_ID IN EMPLOYEE.ROLE_ID%type
    );
    
    PROCEDURE UPDATE_EMPLOYEE(
       vEMPLOYEE_ID IN EMPLOYEE.EMPLOYEE_ID%type,
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL %type,
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type,
        vDATE_OF_JOINING IN EMPLOYEE.DATE_OF_JOINING%type,
        vADDRESS_ID IN EMPLOYEE.ADDRESS_ID%type,
        vROLE_ID IN EMPLOYEE.ROLE_ID%type
    );
    
    
    PROCEDURE DELETE_EMPLOYEE (
        vEMPLOYEE_ID IN EMPLOYEE.EMPLOYEE_ID%type
    );
    
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




 
