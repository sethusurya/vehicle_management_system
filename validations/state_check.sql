CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_STATE  AS 
      FUNCTION STATE_CHECK(
        vSTATE_NAME IN STATE.STATE_NAME%type
       ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_STATE(
        vSTATE_NAME IN STATE.STATE_NAME%type, 
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        );
END PCKG_STATE;

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_STATE AS
    
    FUNCTION STATE_CHECK(
        vSTATE_NAME IN STATE.STATE_NAME%type
       ) 
    RETURN VARCHAR2 AS
        DB_STATE_NAME NUMBER(38);
        
        INVALID_STATE_NAME EXCEPTION;
        DUPLICATE_STATE_NAME EXCEPTION;
        
    BEGIN
    
        select count(STATE_NAME) into DB_STATE_NAME from STATE where STATE_NAME = vSTATE_NAME;
        
        IF DB_STATE_NAME != 0 THEN
            raise DUPLICATE_STATE_NAME;
        END IF;
            
        if vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL then
            raise INVALID_STATE_NAME;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_STATE_NAME then
            dbms_output.put_line('Invalid state name !!!');
            RETURN 'NO';
        when DUPLICATE_STATE_NAME then
            dbms_output.put_line('STATE NAME ALREADY EXIST IN STATE TABLE !!!');
            RETURN 'NO';
    END;
    
    PROCEDURE INSERT_STATE(
        vSTATE_NAME IN STATE.STATE_NAME%type, 
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        INVALID_COUNTRY_NAME EXCEPTION;
        ex_COUNTRY_NAME_DOES_NOT_EXIST EXCEPTION;
        ex_COUNTRY_ID_NOT_FOUND EXCEPTION;
        
        DB_COUNTRY_NAME_EXIST NUMBER(38);
        gCOUNTRY_ID VARCHAR(500); 
        
    BEGIN
    
        BEGIN
        select count(COUNTRY_NAME) into DB_COUNTRY_NAME_EXIST from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DB_COUNTRY_NAME_EXIST := 0;
        END;
        
        IF DB_COUNTRY_NAME_EXIST != 0 THEN
        BEGIN
        select COUNTRY_ID into gCOUNTRY_ID from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            raise ex_COUNTRY_ID_NOT_FOUND;
        END;
        END IF;

        if vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL then
            raise ex_INVALID;
        end if;
        
        if vCOUNTRY_NAME is NULL or  LENGTH(vCOUNTRY_NAME) = 0 then
            raise INVALID_COUNTRY_NAME;
        end if;

        if DB_COUNTRY_NAME_EXIST != 0 AND STATE_CHECK(vSTATE_NAME) = 'YES' then
            INSERT INTO STATE(STATE_ID, STATE_NAME, COUNTRY_ID) VALUES (STATE_ID_SEQ.NEXTVAL, vSTATE_NAME, gCOUNTRY_ID);
        end if; 
        
        if DB_COUNTRY_NAME_EXIST = 0 then
            raise ex_COUNTRY_NAME_DOES_NOT_EXIST;
        end if; 
        
        EXCEPTION
            when ex_INVALID then
                dbms_output.put_line('INVALID STATE NAME !!!');
            when INVALID_COUNTRY_NAME then
                dbms_output.put_line('COUNTRY NAME  IS INVALID!!!');
            when ex_COUNTRY_NAME_DOES_NOT_EXIST then
                dbms_output.put_line('COUNTRY NAME DOES NOT EXIST!!!');
    END INSERT_STATE;

END PCKG_STATE;

EXECUTE PCKG_STATE.INSERT_STATE('', '');
SELECT * FROM STATE;
SELECT * FROM COUNTRY;

--DELETE FROM STATE WHERE STATE_ID = 5;