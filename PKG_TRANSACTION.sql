set serveroutput on;
CREATE OR REPLACE EDITIONABLE PACKAGE PKG_TRANSACTION   AS 
    PROCEDURE BODY_TRANSACTION_INSERT(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT);
    PROCEDURE BODY_TRANSACTION_INSERT_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT);
    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT);
    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2);
    PROCEDURE BODY_TRANSACTION(vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT, vTRANSACTION_ID OUT VARCHAR2);
    
    FUNCTION BODY_TRANSACTION_CHECK( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2;
    
    FUNCTION BODY_TRANSACTION_CALL( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2;
    
    FUNCTION BODY_TRANSACTION_ID_CHECK( 
        vTRANSACTION_ID IN TRANSACTION.TRANSACTION_ID%type
       ) 
    RETURN NUMBER;
    
    FUNCTION BODY_TRANSACTION_ID_GENERATE( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2;
END PKG_TRANSACTION;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PKG_TRANSACTION AS
    PROCEDURE BODY_TRANSACTION(vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT, vTRANSACTION_ID OUT VARCHAR2) AS
    BEGIN
        vTRANSACTION_ID:= BODY_TRANSACTION_ID_GENERATE(vSTATUS, vTOTAL_COST);
        BODY_TRANSACTION_INSERT(vTRANSACTION_ID, vSTATUS, vTOTAL_COST);
    END BODY_TRANSACTION;
    
    FUNCTION BODY_TRANSACTION_CALL( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2 AS
    vTRANSACTION_ID VARCHAR2(244);
    BEGIN
        vTRANSACTION_ID:= BODY_TRANSACTION_ID_GENERATE(vSTATUS, vTOTAL_COST);
        BODY_TRANSACTION_INSERT(vTRANSACTION_ID, vSTATUS, vTOTAL_COST);
        RETURN vTRANSACTION_ID;
    END BODY_TRANSACTION_CALL;
    
    PROCEDURE BODY_TRANSACTION_INSERT(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT) AS
    Conditions VARCHAR2(244);
    BEGIN
        Select BODY_TRANSACTION_CHECK(vSTATUS, vTOTAL_COST) INTO Conditions from dual;
        if Conditions = 'YES' THEN
             BODY_TRANSACTION_INSERT_TABLE(vTRANSACTION_ID, UPPER(vSTATUS), vTOTAL_COST);
             dbms_output.put_line('Data inserted successfully !!!');
        end if;
    END BODY_TRANSACTION_INSERT;
    
    PROCEDURE BODY_TRANSACTION_INSERT_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT) AS
    -- temp_trans_id TRANSACTION.TRANSACTION_ID%type;
    BEGIN
        -- select 'T_'|| TRANSACTION_ID_SEQ.nextval INTO temp_trans_id FROM dual;
        INSERT INTO TRANSACTION (TRANSACTION_ID, STATUS, TOTAL_COST) VALUES (vTRANSACTION_ID, vSTATUS, vTOTAL_COST);
    END BODY_TRANSACTION_INSERT_TABLE; 
    
    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2) AS
    temp_trans_id Number;
    BEGIN
        Select BODY_TRANSACTION_ID_CHECK(vTRANSACTION_ID) INTO temp_trans_id from dual;
        if temp_trans_id > 0 THEN
            UPDATE TRANSACTION SET STATUS = UPPER(vSTATUS) WHERE TRANSACTION_ID = vTRANSACTION_ID;
            dbms_output.put_line('Data updated successfully !!!');
        ELSE
            dbms_output.put_line('Invalid TRANSACTION ID !!!');
         end if;
    END BODY_TRANSACTION_UPDATE_TABLE_SUCCESS;

    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT) AS
    Conditions VARCHAR2(244);
    temp_trans_id Number;
    BEGIN
        Select BODY_TRANSACTION_ID_CHECK(vTRANSACTION_ID) INTO temp_trans_id from dual;
        
        Select BODY_TRANSACTION_CHECK(vSTATUS, vTOTAL_COST) INTO Conditions from dual;
        if Conditions = 'YES' and  temp_trans_id > 0 THEN
            UPDATE TRANSACTION SET STATUS = UPPER(vSTATUS),  TOTAL_COST = vTOTAL_COST WHERE TRANSACTION_ID = vTRANSACTION_ID;
            dbms_output.put_line('Data updated successfully !!!');
        ELSE
            dbms_output.put_line('Invalid TRANSACTION ID !!!');
         end if;
    END BODY_TRANSACTION_UPDATE_TABLE; 
    
    FUNCTION BODY_TRANSACTION_ID_CHECK( 
        vTRANSACTION_ID IN TRANSACTION.TRANSACTION_ID%type
       ) 
    RETURN NUMBER AS
    counts NUMBER;
    BEGIN

        begin
        select Count(*) into counts FROM TRANSACTION where TRANSACTION_ID = vTRANSACTION_ID;
        RETURN counts;
        exception 
            when NO_DATA_FOUND THEN 
                counts := 0;
        end;
    END BODY_TRANSACTION_ID_CHECK; 

    FUNCTION BODY_TRANSACTION_ID_GENERATE( 
         vSTATUS IN TRANSACTION.STATUS%type, 
         vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2 AS
    temp_trans_id TRANSACTION.TRANSACTION_ID%type;
    BEGIN
        select 'T_'|| TRANSACTION_ID_SEQ.nextval INTO temp_trans_id FROM dual;
        RETURN temp_trans_id;
    END BODY_TRANSACTION_ID_GENERATE; 
    
    FUNCTION BODY_TRANSACTION_CHECK(
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2 AS
        INVALID_STATUS EXCEPTION;
        INVALID_TOTAL_COST EXCEPTION;
        
    BEGIN      
        if vSTATUS is NULL or LENGTH(TRIM(vSTATUS)) is NULL then
            raise INVALID_STATUS;
        end if;
           
        if vTOTAL_COST is NULL or  LENGTH(vTOTAL_COST) = 0 then
            raise INVALID_TOTAL_COST;
        end if;
        
        if UPPER(vSTATUS) NOT IN ('INCOMPLETE', 'PENDING', 'FAIL', 'SUCCESS') then
            raise INVALID_STATUS;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_STATUS then
            dbms_output.put_line('Invalid STATUS !!!');
            RETURN 'NO';
        when INVALID_TOTAL_COST then
            dbms_output.put_line('Invalid total cost !!!');
            RETURN 'NO';
    END BODY_TRANSACTION_CHECK;
END PKG_TRANSACTION;