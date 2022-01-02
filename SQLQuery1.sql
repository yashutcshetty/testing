use PM10_2092

create table candidate2
(
CID int identity(1,1) Primary key Not null,
m_apply_c_list varchar(500),
nunique int
)

drop table candidate



select * from dbo.candidate

insert into candidate(m_apply_c_list,nunique) values ('FirstName~John~LastName~KIm~Address~India~Phone~9878987789~PIN~656765',1)

insert into candidate(m_apply_c_list,nunique) values ('FN~Park~LN~KIm~Address~China~Phone~9878987789~PIN~101011',2)

insert into candidate(m_apply_c_list,nunique) values ('FN~Park~LN~KIm~Address~China~Phone~9878987789~PIN~101011',3)
declare @nunique int = 1

declare @text varchar(100)
set @text = 'FirstName~John~LastName~KIm~Address~India~Phone~9878987789~PIN~656765'

select * from string_split(@text,'~')

go

SELECT c.CID,s.value,c.nunique
FROM Candidate c
CROSS APPLY STRING_SPLIT(m_apply_c_list, '~') s

select m_apply_c_list, CHARINDEX('~',m_apply_c_list)
from candidate


select m_apply_c_list,RIGHT( m_apply_c_list,LEN( m_apply_c_list)-Find("~", m_apply_c_list,1)) 
from candidate

select m_apply_c_list, Left(m_apply_c_list,CHARINDEX('~',m_apply_c_list)-1) as Val
from candidate

select * from candidate
go

SELECT
CASE WHEN m_apply_c_list LIKE '%~%' 
	THEN LEFT(m_apply_c_list, Charindex('~', m_apply_c_list) - 1)
    END,
CASE WHEN m_apply_c_list LIKE '%~%'
    THEN RIGHT(m_apply_c_list, Charindex('~', Reverse(m_apply_c_list)) - 1)
   END
FROM dbo.Candidate

SELECt 
	LEFT(m_apply_c_list, Charindex('~', m_apply_c_list) - 1) as field ,
	substring(m_apply_c_list,Charindex('~', m_apply_c_list) +1, Charindex('~', m_apply_c_list)-6) as value
FROM dbo.Candidate

select * from candidate 


select ROW_NUMBER() over(Partition by CID order by CID) as col,
c.CID,c.nunique, s.value
from Candidate c
cross apply STRING_SPLIT(m_apply_c_list, '~') s


select *
from (select ROW_NUMBER() over(Partition by CID order by CID) as col,
 s.value
from Candidate c
cross apply STRING_SPLIT(m_apply_c_list, '~') s) E


--------------------------------------------------
--changes done to practise















select ROW_NUMBER() over( order by CID) as col,
c.CID,c.nunique, s.value
from Candidate c
cross apply STRING_SPLIT(m_apply_c_list, '~') s


select *
from (select ROW_NUMBER() over(Partition by CID order by CID) as col,
c.CID,c.nunique
from Candidate c
cross apply STRING_SPLIT(m_apply_c_list, '~') s) E
ORDER BY
(CASE
    WHEN e.col%2=0 THEN s.value
	 WHEN e.col%2=1 THEN s.value
    ELSE 'invalid'
END);

select c.CID,c.nunique,Row_Number() OVER(ORDER BY c.CID) as RowNum,
CASE
    WHEN (Row_Number() OVER(ORDER BY c.CID) ) % 2 = 0 THEN 'even'
	 WHEN (Row_Number() OVER(ORDER BY c.CID) ) % 2 = 1 THEN 'odd'
    ELSE s.value
END
from Candidate c
cross apply STRING_SPLIT(m_apply_c_list, '~') s



SELECT *
FROM (
    SELECT Row_Number() OVER(ORDER BY CID) AS RowNumber,
    s.value
	from Candidate 
	cross apply STRING_SPLIT(m_apply_c_list, '~') s
) e
WHERE e.RowNumber % 2 = 0
--WHERE e.RowNumber % 2 = 1 


SELECT e.*
FROM (
    SELECT row_number() over (order by (select 1)) as sno,
    s.value
	from Candidate 
	cross apply STRING_SPLIT(m_apply_c_list, '~') s
) e
order by case when sno % 2 =1 then 1 
else 0  end, sno


select cid,m_apply_c_list =
case ROW_NUMBER() over( order by CID) 
 when col % 2=0 then 'even'
 when col % 2=0 then 'odd'
 else 'not'
 end,
 s.value
 from Candidate 
cross apply STRING_SPLIT(m_apply_c_list, '~') s
--------------------------
SELECT c.cid, j.odd, j.even,c.nunique,row_number() over (order by (select 1)) as [sno]
FROM (VALUES (1, 'FirstName~John~LastName~KIm~Address~India~Phone~9878987789~PIN~656765',1)) c (cid, apply_c_list,nunique)
CROSS APPLY (
   SELECT 
      MIN(CASE WHEN sno % 2 = 0 THEN [value] END) AS [odd],
      MIN(CASE WHEN sno % 2 = 1 THEN [value] END) AS [even]
   FROM string_split(c.apply_c_list,'~')
 
) j
  GROUP BY c.cid
-------------------------------------------------
select c.cid,c.nunique,c.m_apply_c_list
from candidate c
cross apply 
	(select value, Row_number() over(order by c.cid)-1  rn
	from string_split(c.m_apply_c_list,'~')
	) s
-----------------------------------------------

select c.cid,c.nunique,c.m_apply_c_list,
min(case when rn % 2 = 0 then [value] end) as [Field],
min(case when rn % 2 = 1 then [value] end) as [value]
		
from candidate c
cross apply 
	(select value, Row_number() over(order by c.cid)-1  rn
	from string_split(c.m_apply_c_list,'~')
	) s
group by c.CID,c.nunique,c.m_apply_c_list, s.rn/2


insert into candidate(m_apply_c_list,nunique) values ('FN~Park~LN~KIm~Address~China~Phone~9878987789~PIN~101011',2)
truncate table candidate

insert into candidate(m_apply_c_list,nunique) values ('FirstName~John~LastName~KIm~Address~India~Phone~9878987789~PIN~656765',1)


select * from field


INSERT INTO field (nunique,field,value)
VALUES ()