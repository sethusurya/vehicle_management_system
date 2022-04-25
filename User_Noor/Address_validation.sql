CREATE or REPLACE FUNCTION is_numeric(p_string IN VARCHAR2)
   RETURN boolean
IS
   v_new_num NUMBER;
BEGIN
   v_new_num := TO_NUMBER(p_string);
   RETURN TRUE;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN FALSE;
END ;

CREATE OR REPLACE FUNCTION ADDRESS_CHECK(
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type, 
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type, 
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type, 
        vCITY_ID IN ADDRESS.CITY_ID%type
       ) 
    RETURN VARCHAR2 AS
    
        INVALID_NAME EXCEPTION;
        INVALID_ZIPCODE EXCEPTION;
        INVALID_CITY_ID EXCEPTION;
        
    BEGIN
            
        -- check data is null, empty and appropriate
        if vADDRESS_LINE_1 is NULL or LENGTH(TRIM(vADDRESS_LINE_1)) is NULL or
        vADDRESS_LINE_2 is NULL or LENGTH(TRIM(vADDRESS_LINE_2)) is NULL then
            raise INVALID_NAME;
        end if;
        
        if vZIP_CODE is NULL or  LENGTH(vZIP_CODE) != 5 or is_numeric(vZIP_CODE)!= TRUE then
            raise INVALID_ZIPCODE;
        end if;
           
        if vCITY_ID is NULL or LENGTH(vCITY_ID) is NULL then
            raise INVALID_CITY_ID;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_NAME then
            dbms_output.put_line('Invalid Address !!!');
            RETURN 'NO';
        when INVALID_ZIPCODE then
            dbms_output.put_line('Invalid ZIPCODE !!!');
            RETURN 'NO';
        when INVALID_CITY_ID then
            dbms_output.put_line('Invalid CITY ID !!!');
            RETURN 'NO';
    END;

--FUNCTION CALL
SELECT ADDRESS_CHECK(1, '14 shepherd', 'apt 2', '02515', 12) FROM DUAL;