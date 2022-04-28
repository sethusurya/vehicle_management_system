
------------------------------------
--  audit_view
------------------------------------

create or replace view audit_view as
SELECT usr.USER_ID, usr.FIRST_NAME, usr.LAST_NAME,usr.EMAIL,
--au_adr.AUDIT_DATE,
au_book.AUDIT_DATE as Booking_Audit,
--au_cat.AUDIT_DATE,
--au_list.AUDIT_DATE,
--au_car.AUDIT_DATE,
--au_city.AUDIT_DATE,
--au_emp.AUDIT_DATE,
--au_park.AUDIT_DATE,
--au_st.AUDIT_DATE,
au_trans.AUDIT_DATE as Transaction_Audit,
au_usr.AUDIT_DATE as User_Audit
from USERS usr,
AUDIT_DATA_ADDRESS au_adr ,
AUDIT_DATA_BOOKING au_book,
AUDIT_DATA_CAR_CATEGORY au_cat,
AUDIT_DATA_CAR_LISTING au_list,
AUDIT_DATA_CAR_REGISTRATION au_car,
AUDIT_DATA_CITY au_city,
AUDIT_DATA_COUNTRY au_cty,
AUDIT_DATA_EMPLOYEE au_emp,
AUDIT_DATA_PARKING au_park,
AUDIT_DATA_STATE au_st,
AUDIT_DATA_TRANSACTION au_trans,
AUDIT_DATA_USER au_usr
WHERE au_usr.AUDIT_ID = au_trans.AUDIT_ID ;
