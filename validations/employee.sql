CREATE OR REPLACE PROCEDURE INSERT_EMPLOYEE(
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type, 
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type, 
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type, 
        vDATE_OF_JOINING IN EMPLOYEE.DATE_OF_JOINING%type, 
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vROLE_ID IN ROLE.ROLE_ID%type
        ) AS     
        
        ex_INVALID_FIRST_NAME EXCEPTION;
        ex_INVALID_LAST_NAME EXCEPTION;
        INVALID_EMAIL EXCEPTION;
        ex_INVALID_PASSWORD EXCEPTION;
        ex_INVALID_DATE_OF_JOINING EXCEPTION;
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
        
        if vDATE_OF_JOINING is NULL then
            raise ex_INVALID_DATE_OF_JOINING;
        end if;
        
        INSERT INTO EMPLOYEE(EMPLOYEE_ID, EMP_FIRST_NAME, EMP_LAST_NAME, EMP_EMAIL, EMP_PASSWORD, DATE_OF_JOINING, ADDRESS_ID, ROLE_ID)
        VALUES
        (EMPLOYEES_SEQ.NEXTVAL, vEMP_FIRST_NAME,vEMP_LAST_NAME, vEMP_EMAIL, vEMP_PASSWORD, vDATE_OF_JOINING, vADDRESS_ID, vROLE_ID);
        
        EXCEPTION
            when ex_INVALID_FIRST_NAME then
                dbms_output.put_line('First name is invalid !!!');
            when ex_INVALID_LAST_NAME then
                dbms_output.put_line('Last name is invalid !!!');
            when INVALID_EMAIL then
                dbms_output.put_line('Email is invalid !!!');
            when ex_INVALID_PASSWORD then
                dbms_output.put_line('password is invalid !!!');
            when ex_INVALID_DATE_OF_JOINING then
                dbms_output.put_line('DATE of joining is invalid !!!');
       
    END INSERT_EMPLOYEE;

EXECUTE INSERT_EMPLOYEE('Noordeep', 'Gill', 'noordeepgill@gmail.com', '12345', '12/12/2022', '1', '1');