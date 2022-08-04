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
