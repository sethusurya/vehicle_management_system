/*CREATE OR REPLACE FUNCTION CHECK_STATE_ID_EXISTS 
    (
      vCITY_ID IN CITY.CITY_ID%type 
    ) RETURN BOOLEAN AS
    
        DB_CITY_ID CITY.CITY_ID%type;
        NO_STATE_FOUND EXCEPTION;
    BEGIN
    
        select CITY_ID into DB_CITY_ID from CITY where CITY_ID = vCITY_ID;
        if DB_CITY_ID IS NOT NULL then
            return TRUE;
        end if;
        
        RETURN FALSE;
END CHECK_STATE_ID_EXISTS;*/


CREATE OR REPLACE PROCEDURE INSERT_CITY(
        vCITY_ID IN CITY.CITY_ID%type,
        vCITY_NAME IN CITY.CITY_NAME%type,
        vSTATE_ID IN CITY.STATE_ID%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        ex_DUPLICATE_CITY EXCEPTION;

BEGIN
        /*
        if CITY_CHECK(trim(vCITY_ID),trim(vCITY_NAME),trim(vSTATE_ID)) = 'NO' then
            raise ex_INVALID;
        end if;
         */
        insert into CITY values (
           vCITY_ID,
           trim(vCITY_NAME),
           trim(vSTATE_ID)
        );
        EXCEPTION
        when ex_INVALID then
            dbms_output.put_line('INVALID INSERT INPUT !!!');

END INSERT_CITY;


CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CITY   AS 
    FUNCTION CITY_CHECK(
        vCITY_ID IN CITY.CITY_ID%type, 
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_ID IN CITY.STATE_ID%type
       ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_CITY(
        vCITY_ID IN CITY.CITY_ID%type,
        vCITY_NAME IN CITY.CITY_NAME%type,
        vSTATE_ID IN CITY.STATE_ID%type
        );
END PCKG_CITY;

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_CITY AS

    FUNCTION CITY_CHECK(
        vCITY_ID IN CITY.CITY_ID%type, 
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_ID IN CITY.STATE_ID%type
       ) 
    RETURN VARCHAR2 AS
    
        INVALID_CITY_NAME EXCEPTION;
        INVALID_STATE_ID EXCEPTION;
        
    BEGIN
            
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
            raise INVALID_CITY_NAME;
        end if;
        
        if vSTATE_ID is NULL or LENGTH(vSTATE_ID) = 0 then
            raise INVALID_STATE_ID;
        end if;
           
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_CITY_NAME then
            dbms_output.put_line('Invalid city name !!!');
            RETURN 'NO';
        when INVALID_STATE_ID then
            dbms_output.put_line('Invalid State id !!!');
            RETURN 'NO';
    END CITY_CHECK;
    
    PROCEDURE INSERT_CITY(
        vCITY_ID IN CITY.CITY_ID%type,
        vCITY_NAME IN CITY.CITY_NAME%type,
        vSTATE_ID IN CITY.STATE_ID%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        ex_DUPLICATE_CITY EXCEPTION;

        BEGIN
        
        if CITY_CHECK(trim(vCITY_ID),trim(vCITY_NAME),trim(vSTATE_ID)) = 'NO' then
            raise ex_INVALID;
        end if;
         
        insert into CITY(CITY_ID, CITY_NAME, STATE_ID) values (
           vCITY_ID,
           trim(vCITY_NAME),
           vSTATE_ID
        );
        EXCEPTION
        when ex_INVALID then
            dbms_output.put_line('INVALID INSERT INPUT !!!');

    END INSERT_CITY;
END PCKG_CITY;

CREATE OR REPLACE FUNCTION CITY_CHECK(
        vCITY_ID IN CITY.CITY_ID%type, 
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_ID IN CITY.STATE_ID%type
       ) 
    RETURN VARCHAR2 AS
    
        INVALID_CITY_NAME EXCEPTION;
        INVALID_STATE_ID EXCEPTION;
        
    BEGIN
            
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
            raise INVALID_CITY_NAME;
        end if;
        
        if vSTATE_ID is NULL or LENGTH(vSTATE_ID) = 0 then
            raise INVALID_STATE_ID;
        end if;
           
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_CITY_NAME then
            dbms_output.put_line('Invalid city name !!!');
            RETURN 'NO';
        when INVALID_STATE_ID then
            dbms_output.put_line('Invalid State id !!!');
            RETURN 'NO';
    END;

--FUNCTION CALL
SELECT PCKG_CITY.CITY_CHECK(1, 'asd', 10) FROM DUAL;
SELECT CHECK_STATE_ID_EXISTS(1) FROM DUAL;
select PCKG_CITY.INSERT_CITY('1', 'Boston', '1') FROM DUAL;

insert into CITY(CITY_ID, CITY_NAME, STATE_ID) values (
           1,
           trim('Noordeep'),
           1
        );
        
    
select * from city;
INSERT INTO COUNTRY(COUNTRY_ID, COUNTRY_NAME) VALUES (COUNTRY_ID_SEQ.NEXTVAL, 'USA');

 CREATE OR REPLACE FUNCTION CHECK_COUNTRY(
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        ) RETURN VARCHAR2 AS     
        
        ex_INVALID EXCEPTION;
    
        CK_COUNTRY_ID VARCHAR2(500);
        BEGIN
         
        SELECT COUNTRY_ID INTO CK_COUNTRY_ID FROM COUNTRY WHERE COUNTRY_NAME = vCOUNTRY_NAME; 
        
        IF CK_COUNTRY_ID IS NULL THEN 
            RETURN 'NO'; 
        END IF; 
        
        IF CK_COUNTRY_ID IS NOT NULL THEN 
            RETURN 'YES'; 
        END IF; 

        RETURN 'YES';
        /*
        IF CK_COUNTRY_ID IS NULL THEN 
         RAISE ex_INVALID; 
        END IF; 
        
        RETURN CK_COUNTRY_ID;
        */
        /*
        EXCEPTION
        when ex_INVALID then
            dbms_output.put_line('DOES NOT EXIST !!!');
            RETURN FALSE; 
        */
    END CHECK_COUNTRY;
--INSERT INTO STATE(STATE_ID, STATE_NAME, COUNTRY_ID) VALUES (STATE_ID_SEQ.NEXTVAL, 'MA', );
SELECT CHECK_COUNTRY('Ss') FROM DUAL; 

SELECT COUNTRY_ID FROM COUNTRY WHERE COUNTRY_NAME = 'USA';

