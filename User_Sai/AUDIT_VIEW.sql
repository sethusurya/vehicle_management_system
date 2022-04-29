
------------------------------------
--  audit_view
------------------------------------

create or replace view audit_view as
select au_trans.USERNAME, au_trans.TABLE_NAME, au_trans.AUDIT_DATE,au_trans.ACTION from AUDIT_DATA_TRANSACTION au_trans;
select au_usr.USERNAME, au_usr.TABLE_NAME, au_usr.AUDIT_DATE, au_usr.ACTION from AUDIT_DATA_USER au_usr;
