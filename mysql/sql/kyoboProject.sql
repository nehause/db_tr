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

-- 메인 베스트셀러 목록

-- 메인 화제의 신간 목록

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
    ,a.cost*a.accmluate as accmluate
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
	a.purchaseSeq
    -- 책 총 가격 : sum
    ,(select sum(price) from purchase_book where purchase_purchaseSeq = "3") as priceSum
    -- 책 이름을 문자열로 가로로 붙여서 나오게 : 책이름 1개만 나오고 외 2권 : 책 카운트 계산이 필요
	-- ,(select book_bookSeq from purchase_book where purchase_bookSeq = a.purchaseSeq = "1" ) as aaa
	,(select GROUP_CONCAT(book_bookSeq SEPARATOR ', ') from purchase_book where purchase_purchaseSeq = "3") as productName
	,(select sum(count) from purchase_book where purchase_purchaseSeq = "3") as quantity
    ,a.purchaseStatus
FROM purchase a
JOIN purchase_book b on b.purchase_purchaseSeq = a.purchaseSeq
JOIN book c on c.bookSeq = b.book_bookSeq
WHERE 1=1
AND a.purchaseSeq = "3"
GROUP BY a.purchaseSeq
;

select
	*
from purchase_book
where purchase_purchaseSeq ="8"
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
