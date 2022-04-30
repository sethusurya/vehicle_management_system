
------------------------------------
--  audit_view
------------------------------------

create or replace view audit_view as
select 
au_usr.USERNAME, au_usr.TABLE_NAME as AUDIT_USER_TABLE, au_usr.AUDIT_DATE as USER_AUDIT_DATE, au_usr.ACTION as USER_ACTION,
au_trans.TABLE_NAME as AUDIT_TRANSACTION_TABLE, au_trans.AUDIT_DATE as TRANSACTION_AUDIT,au_trans.ACTION as TRANSACTION_TABLE_ACTION
from vms_employee.AUDIT_DATA_TRANSACTION au_trans
join vms_employee.AUDIT_DATA_USER au_usr on au_usr.AUDIT_ID = au_trans.AUDIT_ID;
