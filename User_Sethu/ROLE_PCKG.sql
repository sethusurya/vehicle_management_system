CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_ROLE  AS 
    PROCEDURE INSERT_ROLE(
        vROLE_NAME IN ROLE.ROLE_NAME%type
        );

    PROCEDURE REMOVE_ROLE(
        vROLE_NAME IN ROLE.ROLE_NAME%type
    );
END PCKG_ROLE;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_ROLE  AS 
    PROCEDURE INSERT_ROLE(
        vROLE_NAME IN ROLE.ROLE_NAME%type
        ) AS     
        
        ex_INVALID_ROLE_NAME EXCEPTION; 
        DB_ROLE_NAME NUMBER(38);
    
    BEGIN
        
        BEGIN
        select COUNT(ROLE_NAME) INTO DB_ROLE_NAME FROM ROLE WHERE ROLE_NAME = vROLE_NAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DB_ROLE_NAME := 0;
        END;
        
        if vROLE_NAME is NULL or LENGTH(TRIM(vROLE_NAME)) IS NULL then
            raise ex_INVALID_ROLE_NAME;
        end if;
        
        IF DB_ROLE_NAME = 0 AND UPPER(vROLE_NAME) in ('APP_OWNER','DEVELOPER','TESTER', 'ANALYST') THEN
            INSERT INTO ROLE(ROLE_ID, ROLE_NAME) VALUES ('ROLE_'||ROLE_ID_SEQ.NEXTVAL, vROLE_NAME);
        END IF; 
        
        EXCEPTION
            when ex_INVALID_ROLE_NAME then
                dbms_output.put_line('Role name is invalid !!!');
    END INSERT_ROLE;

    PROCEDURE REMOVE_ROLE(
        vROLE_NAME IN ROLE.ROLE_NAME%type
    ) AS
    vCOUNT_EMPLOYEE NUMBER(5) DEFAULT 0;
    ex_EMPLOYEE_EXIST EXCEPTION;
    BEGIN
        -- check if any employees exist with role name's role id
        -- if exists, raise error
        -- if not, remove the role
        SELECT COUNT(*) INTO vCOUNT_EMPLOYEE FROM EMPLOYEE WHERE UPPER(ROLE_NAME) = UPPER(vROLE_NAME);
        IF vCOUNT_EMPLOYEE > 0 THEN
            RAISE ex_EMPLOYEE_EXIST;
        END IF;
        DELETE FROM ROLE WHERE UPPER(ROLE_NAME) = UPPER(vROLE_NAME);
        EXCEPTION
            WHEN ex_EMPLOYEE_EXIST THEN
                dbms_output.put_line('EMPLOYEE EXISTS FOR THIS ROLE, PLEASE REMOVE THEM AND RUN THIS COMMAND TO REMOVE ROLE!!!');
    END REMOVE_ROLE;

END PCKG_ROLE; 
/