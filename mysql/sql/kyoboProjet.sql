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
SELECT * FROM member WHERE id = "share" and password = "passwordValue"

;

-- 아이디 비밀번호 찾기
SELECT * FROM member WHERE id = "idValue" and phone = "000-0000-0000" 
;


-- 관심상품
-- 책 선호에서 받아온 책 번호의 표지, 이름, 가격(정가*할인율), 포인트(정가*적립율)

-- 전체 코멘트 목록
-- 책의 번호(책의 이름으로 대체 가능한가) 이름 아이디 이름 시간 점수 코멘트
SELECT
	b.book_bookSeq
	,a.id
    ,a.name
    ,b.time
    ,b.grade
    ,b.comment
    
FROM member a
LEFT JOIN book_comment b on b.member_seq = a.memberSeq
-- INNER JOIN book_comment b on b.member_seq = a.memberSeq
-- JOIN book_comment b on b.member_seq = a.memberSeq
;


-- 도서 목록

--