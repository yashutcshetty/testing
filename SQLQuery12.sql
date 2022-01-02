alter table tblemployee with nocheck
add constraint CK_tblemployee_Email
check(Email like '%@%')