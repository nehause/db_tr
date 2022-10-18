use future;

select
	a.memberSeq
    ,a.name
    ,a.id
    ,b.transportDiv
    ,b.phone
    ,b.home
    ,b.zip
    ,b.address1
    ,b.address2
from member a
left join transport b on b.member_memberSeq = a.memberSeq
-- inner join transport b on b.member_memberSeq = a.memberSeq
-- join transport b on b.member_memberSeq = a.memberSeq
;

SELECT
	a.id
    ,a.name
    ,b.time
    ,b.grade
    ,b.comment
    
FROM member a
LEFT JOIN book_comment b on b.member_seq = a.memberSeq
-- INNER JOIN book_comment b on b.member_seq = a.memberSeq
-- JOIN book_comment b on b.member_seq = a.memberSeq
;

-- WHERE 1=1
-- ORDER
-- GROUP BY

-- UNION
select
	name
	,dob
    ,id
    ,pwd
	,gender
from member2
union
select
	name
    ,dob
    ,id
    ,password
    ,gender
from member
;


-- 실험용 쿼리
SELECT 
	DISTINCT
	a.*
	,(SELECT
		GROUP_CONCAT(c.name SEPARATOR ', ')
		FROM writer c
        JOIN book_writer b on b.writer_writerSeq = c.writerSeq
        where 1=1
			and  b.book_bookSeq = a.bookSeq 
            ) as writer
	
FROM
	book a
    JOIN book_writer b on b.book_bookSeq = a.bookSeq 
    
    ;
    
    select aa.* from (
    SELECT
			DISTINCT
			a.*
			,(SELECT
			GROUP_CONCAT(c.name SEPARATOR ', ')
			FROM writer c
	        JOIN book_writer b on b.writer_writerSeq = c.writerSeq
	        where 1=1
				and  b.book_bookSeq = a.bookSeq 
	            ) as writer
                FROM book a
	JOIN book_writer b on b.book_bookSeq = a.bookSeq 
	WHERE 1=1
    ORDER BY a.bookSeq DESC
    ) aa
		limit 100 offset 0
;
-- book_writer 실험용
SELECT
	DISTINCT
	a.*
	,(SELECT
	c.name,
	case when count(*)=1
	then max(name) + '외 1건'
	end as writer
	FROM writer c
	JOIN book_writer b on b.writer_writerSeq = c.writerSeq
	where 1=1
		and  b.book_bookSeq = a.bookSeq 
		) as writer
	FROM book a
	JOIN book_writer b on b.book_bookSeq = a.bookSeq 
	WHERE 1=1
	;
-- 책 할인가 까지 포함하는 쿼리

select
	a.*
    ,cost*(1-sale) as pay
From book a

;

select aa.* from ( SELECT DISTINCT a.* , cost*(1-sale) as price ,(SELECT case when count(c.name) 
= 1 then c.name when count(c.name) > 1 then concat(min(c.name) , ' 외 ' , cast(COUNT(name) as 
char)-1 , ' 명' ) end FROM writer c JOIN book_writer b on b.writer_writerSeq = c.writerSeq where 
1=1 and b.book_bookSeq = a.bookSeq ) as writer FROM book a WHERE 1=1	 ORDER 
BY a.bookSeq DESC ) aa limit 100 offset 0 
            
