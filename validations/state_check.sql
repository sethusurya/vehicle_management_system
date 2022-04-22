CREATE OR REPLACE FUNCTION STATE_CHECK(
        vSTATE_ID IN STATE.STATE_ID%type, 
        vSTATE_NAME IN STATE.STATE_NAME%type, 
        vCOUNTRY_ID IN STATE.COUNTRY_ID%type
       ) 
    RETURN VARCHAR2 AS
    
        INVALID_STATE_NAME EXCEPTION;
        INVALID_COUNTRY_ID EXCEPTION;
        
    BEGIN
            
        if vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL then
            raise INVALID_STATE_NAME;
        end if;
        
        if vCOUNTRY_ID is NULL or  LENGTH(vCOUNTRY_ID) = 0 then
            raise INVALID_COUNTRY_ID;
        end if;
           
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_STATE_NAME then
            dbms_output.put_line('Invalid state name !!!');
            RETURN 'NO';
        when INVALID_COUNTRY_ID then
            dbms_output.put_line('Invalid country id !!!');
            RETURN 'NO';
    END;

--FUNCTION CALL
SELECT STATE_CHECK(1, 'asd', 10) FROM DUAL;