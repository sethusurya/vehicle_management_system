CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_COUNTRY   AS 
      FUNCTION CHECK_COUNTRY_EXISTS(
      vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type 
      ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_COUNTRY(
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        );
END PCKG_COUNTRY;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_COUNTRY AS
    
    FUNCTION CHECK_COUNTRY_EXISTS 
    (
      vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type 
    ) RETURN VARCHAR2 AS
    
        DB_COUNTRY_NAME NUMBER(38);
        
        NO_STATE_FOUND EXCEPTION;
    BEGIN
    
        select count(COUNTRY_NAME) into DB_COUNTRY_NAME from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
        
        if DB_COUNTRY_NAME = 0 then
            return 'NO';
        end if;
        
        return 'YES';
    END CHECK_COUNTRY_EXISTS;
    
    PROCEDURE INSERT_COUNTRY(
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        ex_DUPLICATE_COUNTRY EXCEPTION;
        
    BEGIN
        
        if vCOUNTRY_NAME is NULL or LENGTH(TRIM(vCOUNTRY_NAME)) is NULL then
            raise ex_INVALID;
        end if;
        
        IF CHECK_COUNTRY_EXISTS(vCOUNTRY_NAME) = 'NO' then 
            INSERT INTO COUNTRY(COUNTRY_ID, COUNTRY_NAME) VALUES (COUNTRY_ID_SEQ.NEXTVAL, vCOUNTRY_NAME);
        END IF; 
        
        IF CHECK_COUNTRY_EXISTS(vCOUNTRY_NAME) = 'YES' then
            raise ex_DUPLICATE_COUNTRY;
        END IF; 
        
        EXCEPTION
            when ex_INVALID then
                dbms_output.put_line('INVALID COUNTRY NAME !!!');
            when ex_DUPLICATE_COUNTRY then
                dbms_output.put_line('COUNTRY NAME  ALREADY EXISTS!!!');
    END INSERT_COUNTRY;
END PCKG_COUNTRY; 
/

EXECUTE PCKG_COUNTRY.INSERT_COUNTRY('');
SELECT * FROM COUNTRY;

