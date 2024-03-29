use future;


-- CCG |  CCG : CC | CC NAME
select
	a.CGseq
	,a.CGName
    ,b.Corder
    ,b.CName
from CCG a
left join CG b on b.CCG_CGseq = a.CGSeq
;

-- 로그인
SELECT 
	id
    ,password
FROM member 
WHERE 1=1 
	AND id = "share" 
    AND password = "1234"

;

-- 메인 페이지 메인책 목록
-- 메인책의 기준을 잡아야한다. 랜덤으로 나오게 하는가 아니면 판매량으로 나오게 하느냐.


-- 메인 베스트셀러 목록
-- 판매량이 높은 상품을 기준으로 4권을 보여준다. (sign, name, cost*(1-sale)as price, cost)


select
	bookSeq
	,sign
    ,name
    ,cost*(1-sale) as price
    ,cost
from book
	ORDER BY amount desc
    limit 4
;

-- 메인 화제의 신간 목록
-- 출간일 혹은 도서 등록일이 가장 최근인 것을 기준으로 가장 최근 도서 4권을 보여준다. (sign, name, cost*(1-sale)as price, cost)

select
	bookSeq
	,sign
    ,name
    ,cost*(1-sale) as price
    ,cost
from book
	ORDER BY dor desc
    limit 4    
;

-- 도서 목록

SELECT 
	sign
    ,name
    ,cost*(1-sale) as price
	,cost
FROM book
;

-- 도서 상세 (작가 뭉치기)
SELECT
	a.sign
	,a.name
    ,a.subname
    ,GROUP_CONCAT(c.name SEPARATOR ', ') as writer
    ,a.publisher
    ,a.dop
    ,a.cost
    ,a.cost*(1-a.sale) as price
    ,a.cost*a.accmulate as accmulate
    ,a.isbn
    ,a.page
    ,a.size
    ,a.introduce
    ,a.image
    ,c.image
    ,c.name
    ,c.introduce
    ,a.list
    ,a.content
    ,a.rop
FROM book a
JOIN book_writer b on b.book_bookSeq = a.bookSeq
JOIN writer c on c.writerSeq = b.book_writerSeq
GROUP BY bookSeq
;

-- 회원 정보 (이름, 포인트)
SELECT
	name
    ,accmulate
FROM member
;

-- 관심상품 (책 선호에서 받아온 책 번호의 표지, 이름, 가격(정가*할인율), 포인트(정가*적립율))
SELECT
    c.sign
    ,c.name
    ,c.cost*(1-c.sale) as price
    ,c.cost*c.accmluate as accmulate
    
FROM member a
JOIN favorite b on b.member_memberSeq = a.memberSeq
JOIN book c on c.bookSeq = b.book_bookSeq
WHERE 1=1
	and a.memberSeq = "10"
;

-- 전체 코멘트 목록
-- 책의 번호(책의 이름으로 대체 가능한가) 이름 아이디 이름 시간 점수 코멘트
SELECT
	c.name
	,a.id
    ,a.name
    ,b.time
    ,b.grade
    ,b.comment
    
FROM member a
JOIN book_comment b on b.member_seq = a.memberSeq
JOIN book c on c.bookSeq = b.book_bookSeq
WHERE 1=1
	and c.name like "역행자"
-- AND b.comment like "역행자"
-- INNER JOIN book_comment b on b.member_seq = a.memberSeq
-- JOIN book_comment b on b.member_seq = a.memberSeq
;



-- 주문 내역 (주문번호, 상품금액, 상품정보, 수량, 주문상태) b를 제외하여 만든다.
SELECT 
	a.*
    -- 책 총 가격 : sum
    ,sum(b.price) as priceSum
    -- 책 이름을 문자열로 가로로 붙여서 나오게 : 책이름 1개만 나오고 외 2권 : 책 카운트 계산이 필요
	,(
		select 
			GROUP_CONCAT(c.name SEPARATOR ', ')
            -- 여기에 책이름으로 GROUP_CONCAT
		from purchase_book b
			-- 여기에 조인문 작성 
            join book c on c.bookSeq = b.book_bookSeq 
			join purchase_book a on b.purchase_purchaseSeq = a.purchaseSeq 
			
	) as productNametransport
	,sum(b.count) as quantity
    ,a.purchaseStatus
FROM 
	purchase a
	JOIN purchase_book b on b.purchase_purchaseSeq = a.purchaseSeq
WHERE 1=1
GROUP BY a.purchaseSeq
;

select
	*
from purchase_book
where 1=1
	and purchase_purchaseSeq ="8"
;

-- 아이디 찾기

SELECT 
	id
FROM member 
WHERE 1=1 
	and name = "nameValue" 
    and phone = "00000000000" 
;

-- 비밀번호 찾기
SELECT 
	password
FROM member 
WHERE 1=1
	and id = "idValue"
    and name = "nameValue"
    and phone = "00000000000" 
;

-- 비밀번호 재확인 (테이블 비밀번호의 값이 input 값과 같으면 인증)

select
	password
From member 
WHERE 1=1
	and memberSeq = ""
;

-- 아이디 중복 확인

SELECT id FROM member 
WHERE 1=1
	and id="idValue"
;

-- 닉네임 중복 확인

select userName FROM member 
WHERE 1=1
	and userName="UserNameValue"
;

select 
	count(CSeq) as CodeCount
FROM CG
WHERE 1=1
	and CCG_CGSeq = 1
;

SELECT
	a.*
	,(select 
		count(b.CSeq)
	FROM CG b
	WHERE 1=1
		and CCG_CGSeq = a.CGseq
	) as CodeCount
FROM CCG a
WHERE 1=1
	AND CGDelNy = 0
;

-- orderList 작성
SELECT
	a.*
   ,b.name
   ,(select
   GROUP_CONCAT(d.name SEPARATOR ', ') 
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseBook
   ,(select
   GROUP_CONCAT(c.count SEPARATOR ', ') 
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseBook
   ,sum(c.price) as priceSum
FROM purchase a
JOIN member b on a.member_memberSeq = b.memberSeq
join purchase_book c on purchase_purchaseSeq = purchaseSeq
where 1=1
group by purchaseSeq
;

-- 외 몇건으로 변환

SELECT
	a.*
   ,b.name
   ,(select
   case
   when count(d.name) = 1 then d.name
   when count(d.name) > 1 then concat(min(d.name) , ' 외 ' , cast(COUNT(name) as char)-1 , ' 건' )
   end
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseBook
   ,(select
	case	
	when count(c.count) = 1 then concat(c.count, '권')
    when count(c.count) > 1 then concat(max(c.count) , '권 외 ' , cast(COUNT(name) as char)-1 , ' 건' )
	end
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseCount
   ,sum(c.price) as priceSum
FROM purchase a
JOIN member b on a.member_memberSeq = b.memberSeq
join purchase_book c on purchase_purchaseSeq = purchaseSeq
where 1=1
group by purchaseSeq
;

-- 검색 최적화

SELECT
	a.*
   ,b.name
   ,(select
   case
   when count(d.name) = 1 then d.name
   when count(d.name) > 1 then concat(min(d.name) , ' 외 ' , cast(COUNT(name) as char)-1 , ' 건' )
   end
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseBook
   ,(select
	case	
	when count(c.count) = 1 then concat(c.count, '권')
    when count(c.count) > 1 then concat(max(c.count) , '권 외 ' , cast(COUNT(name) as char)-1 , ' 건' )
	end
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseCount
   ,(select
   sum(c.price)
   from purchase_book c
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   group by purchaseSeq
   ) as priceSum
-- join문을 줄이고 group by를 서브쿼리로 옮긴다.   
FROM purchase a
JOIN member b on a.member_memberSeq = b.memberSeq
where 1=1
;

-- myroom 에서 쓸 쿼리
SELECT
	a.*
   ,b.name
   ,(select
   case
   when count(d.name) = 1 then d.name
   when count(d.name) > 1 then concat(min(d.name) , ' 외 ' , cast(COUNT(name) as char)-1 , ' 건' )
   end
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseBook
   ,(select
	case	
	when count(c.count) = 1 then concat(c.count, '권')
    when count(c.count) > 1 then concat(max(c.count) , '권 외 ' , cast(COUNT(name) as char)-1 , ' 건' )
	end
   FROM purchase_book c
   JOIN book d on d.bookSeq = c.book_bookSeq
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   )as purchaseCount
   ,(select
   sum(c.price)
   from purchase_book c
   where 1=1
	and purchase_purchaseSeq = purchaseSeq
   group by purchaseSeq
   ) as priceSum
-- join문을 줄이고 group by를 서브쿼리로 옮긴다.   
FROM purchase a
JOIN member b on a.member_memberSeq = b.memberSeq
where 1=1
	and member_memberSeq = 1 -- #{sessSeq}가 들어갈곳
;

-- myroom 관심상품
select
	b.sign
    ,b.name
    ,b.cost * (1-b.sale) as price
    ,b.cost
From favorite a
join book b on a.book_bookSeq = b.bookSeq
where 1=1
	and member_memberSeq = 1 -- #{sessSeq}가 들어갈곳
;

-- 메인 화면에 띄울거
select
	bookSeq
    ,sign
    ,topic
    ,left(introduce , 30) as shortIntro
from book
    where 1=1
    order by amount desc
    limit 2
;


-- book mapper selectWriter
SELECT
	a.book_bookSeq
	,a.writer_writerSeq
FROM book_writer a
JOIN book b on a.book_bookSeq = b.bookSeq
WHERE 1=1
	AND bookSeq = 1
;
use future;
SELECT
	DISTINCT
	a.*
	, cost*(1-sale) as price
	,(SELECT
	case
	when count(c.writerName) = 1 then c.writerName
	when count(c.writerName) > 1 then concat(min(c.writerName) , ' 외 ' , cast(COUNT(writerName) as char)-1 , ' 명' )
	end
	FROM writer c
	JOIN book_writer b on b.writer_writerSeq = c.writerSeq
	where 1=1
		and  b.book_bookSeq = a.bookSeq 
		) as writer
FROM book a
	WHERE 1=1
;

-- auto increment 초기화

-- ALTER TABLE {테이블 이름} AUTO_INCREMENT = {사용할 번호};


select aa.* from (      
SELECT    
	a.*    
    ,cost*(1-sale) as price    
    ,seq    
    ,type    
    ,defaultNy    
    ,sort    
    ,path    
    ,originalName    
    ,uuidName   
    FROM book a   
    join bookUploaded b on a.bookSeq = b.pSeq   
    WHERE 1=1 
    and type=1    
    ORDER BY type, sort, bookSeq desc        
    ) aa   limit 100 offset 0
;
select
		a.*
		,b.*
        ,c.*
	from writer a
	join book_writer b on a.writerSeq = b.writer_writerSeq
	left join writerUploaded c on a.writerSeq = c.pSeq
	where 1=1
    and book_bookSeq = 1
	order by type, sort
;

select
		a.*
	from writer a
	join book_writer b on a.writerSeq = b.writer_writerSeq
	where 1=1
	and book_bookSeq = 7
;

show index from member2;



alter table member2 drop index abc;

create index abc on member2 (dob, gender)
;
create view bookV
as
select
	a.*
    ,b.*
from book a
join bookUploaded b 
	on a.bookDelNy = 0 
    and b.delNy = 0 
    and a.bookSeq = b.pSeq
    order by a.bookSeq
    desc limit 100
-- function 현재 작동 못함 (아마존 건드려야함)
DELIMITER $$
CREATE FUNCTION getMemberName (
seq bigint
) 
RETURNS varchar(100)
BEGIN
	
    declare rtName varchar(100);

	select
		name into rtName
	from
		Member2 a
	where 1=1
		and a.seq = seq
	;

	RETURN rtName;
END$$
DELIMITER ;

set global log_bin_trust_function_creators = 1;

select
		b.bookSeq as bookSeq
		,b.sign as bookSign
	    ,b.name as bookName
	    ,b.cost * (1-b.sale) as bookPrice
	    ,b.cost as bookCost
	    ,seq
		,type
		,defaultNy
		,sort
		,path
		,originalName
		,uuidName
	From favorite a
	join book b on a.book_bookSeq = b.bookSeq
	join bookUploaded c on b.bookSeq = c.pSeq
	where 1=1
		and type = 1
		and a.member_memberSeq = 1
        ;
	
    select
	bookSeq
	,name
	,sign
	,cost*(1-sale) as price
	,stock
    ,seq
	,type
	,defaultNy
	,sort
	,path
	,originalName
	,uuidName
from book a
join bookUploaded b on a.bookSeq = b.pSeq and type = 1
where 1=1
	and bookSeq = 1
    or bookSeq = 2
    or bookSeq = 3
    ;
    
    