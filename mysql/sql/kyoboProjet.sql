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
SELECT * FROM member WHERE id = "iii" and password = "jjj"
;

-- 아이디 비밀번호 찾기
SELECT * FROM member WHERE id = "iii" and phone = "000-0000-0000" 
;


-- 관심상품
-- 책 선호에서 받아온 책 번호의 표지, 이름, 가격(정가*할인율), 포인트(정가*적립율)

-- 코멘트 목록

-- 도서 목록

--