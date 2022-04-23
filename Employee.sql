- SEQUENCE FOR EMPLOYEE_ID
---------------------------------------------------------

    CREATE SEQUENCE EMPLOYEE _ID_SEQ
         START WITH 1
         INCREMENT BY 1
         ORDER;

--  DDL for Table EMPLOYEE
--------------------------------------------------------

  CREATE TABLE CAR   
   (	  EMPLOYEE_ID   NUMBER(25,0), 
	  EMP_FIRST_NAME   VARCHAR2(60)  , 
	  EMP_LAST_NAME VARCHAR2(60)  , 
	  EMP_EMAIL  VARCHAR2(255)  ,
	  EMP_PASSWORD  VARCHAR2(255)  , 
	  DATE_OF_JOINING  DATE , 
	  ADDRESS_ID VARCHAR2(255),
	  ROLE_ID VARCHAR2(255) 
   )
