
------------------------------------
--  audit_view
------------------------------------

create or replace view audit_view as
select au_trans.USERNAME, au_trans.TABLE_NAME, au_trans.AUDIT_DATE,au_trans.ACTION from AUDIT_DATA_TRANSACTION au_trans;
select au_usr.USERNAME, au_usr.TABLE_NAME, au_usr.AUDIT_DATE, au_usr.ACTION from AUDIT_DATA_USER au_usr;
select au_adr.USERNAME, au_adr.TABLE_NAME, au_adr.AUDIT_DATE, au_adr.ACTION from AUDIT_DATA_ADDRESS au_adr;
select au_book.USERNAME, au_book.TABLE_NAME, au_book.AUDIT_DATE, au_book.ACTION from AUDIT_DATA_BOOKING au_book;
select au_carlist.USERNAME, au_carlist.TABLE_NAME, au_carlist.AUDIT_DATE, au_carlist.ACTION from AUDIT_DATA_CAR_LISTING au_carlist;
select au_car.USERNAME, au_car.TABLE_NAME, au_car.AUDIT_DATE, au_car.ACTION from AUDIT_DATA_CAR_REGISTRATION au_car;
select au_emp.USERNAME, au_emp.TABLE_NAME, au_emp.AUDIT_DATE, au_emp.ACTION from AUDIT_DATA_EMPLOYEE au_emp;
select au_role.USERNAME, au_role.TABLE_NAME, au_role.AUDIT_DATE, au_role.ACTION from AUDIT_DATA_ROLES au_role;
