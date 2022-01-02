alter table tblemployee 
add constraint CK_tblemployee_Email
check(Email like '%@.%')