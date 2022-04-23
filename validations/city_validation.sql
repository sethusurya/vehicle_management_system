CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CITY  AS 
      FUNCTION CITY_CHECK(
        vCITY_NAME IN CITY.CITY_NAME%type
       ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_CITY(
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_NAME IN STATE.STATE_NAME%type
        );
END PCKG_CITY;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_CITY AS
    
    FUNCTION CITY_CHECK(
        vCITY_NAME IN CITY.CITY_NAME%type
       ) 
    RETURN VARCHAR2 AS
        DB_CITY_NAME NUMBER(38);
        
        INVALID_CITY_NAME EXCEPTION;
        DUPLICATE_CITY_NAME EXCEPTION;
        
    BEGIN
    
        select count(CITY_NAME) into DB_CITY_NAME from CITY where CITY_NAME = vCITY_NAME;
        
        IF DB_CITY_NAME != 0 THEN
            raise DUPLICATE_CITY_NAME;
        END IF;
            
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
            raise INVALID_CITY_NAME;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_CITY_NAME then
            dbms_output.put_line('Invalid CITY name !!!');
            RETURN 'NO';
        when DUPLICATE_CITY_NAME then
            dbms_output.put_line('CITY NAME ALREADY EXIST IN STATE TABLE !!!');
            RETURN 'NO';
    END;
    
    PROCEDURE INSERT_CITY(
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_NAME IN STATE.STATE_NAME%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        INVALID_STATE_NAME EXCEPTION;
        ex_STATE_NAME_DOES_NOT_EXIST EXCEPTION;
        
        DB_STATE_NAME_EXIST NUMBER(38);
        gSTATE_ID VARCHAR(500); 
        
    BEGIN
        
        BEGIN
        select count(STATE_NAME) into DB_STATE_NAME_EXIST from STATE where STATE_NAME = vSTATE_NAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DB_STATE_NAME_EXIST := 0;
        END;
        
        BEGIN
        select STATE_ID into gSTATE_ID from STATE where STATE_NAME = vSTATE_NAME;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            gSTATE_ID := NULL;
        END;
        
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
            raise ex_INVALID;
        end if;
        
        if vSTATE_NAME is NULL or  LENGTH(vSTATE_NAME) = 0 then
            raise INVALID_STATE_NAME;
        end if;
        
        if DB_STATE_NAME_EXIST = 0 then
            raise ex_STATE_NAME_DOES_NOT_EXIST;
        end if; 

        if DB_STATE_NAME_EXIST != 0 AND CITY_CHECK(vCITY_NAME) = 'YES' AND gSTATE_ID IS NOT NULL then
            INSERT INTO CITY(CITY_ID, CITY_NAME, STATE_ID) VALUES (CITY_ID_SEQ.NEXTVAL, vCITY_NAME, gSTATE_ID);
        end if; 
        
        EXCEPTION
            when ex_INVALID then
                dbms_output.put_line('INVALID STATE NAME !!!');
            when INVALID_STATE_NAME then
                dbms_output.put_line('STATE NAME  IS INVALID!!!');
            when ex_STATE_NAME_DOES_NOT_EXIST then
                dbms_output.put_line('STATE NAME DOES NOT EXIST!!!');
    END INSERT_CITY;

END PCKG_CITY;
/

EXECUTE PCKG_CITY.INSERT_CITY('ASD', 'ASDASD');
SELECT * FROM CITY;
SELECT * FROM STATE;