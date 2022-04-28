-------------------------------------------CAR_LISTING_INDEX------------------------------------------------------------------------------
CREATE UNIQUE INDEX CAR_LISTING_INDEX   ON CAR_LISTING   (  FEE_RATE, PARKING_ID  );

ALTER TABLE CAR_LISTING_INDEX ON CAR_LISTING REBUILD;

-----------------------------------------------EMPLOYEE------------------------------------------------------------------------------------

CREATE UNIQUE INDEX EMPLOYEE_INDEX   ON EMPLOYEE   (  EMP_FIRST_NAME, EMP_LAST_NAME, EMP_EMAIL, ROLE_ID  );

ALTER TABLE EMPLOYEE_INDEX ON EMPLOYEE REBUILD;