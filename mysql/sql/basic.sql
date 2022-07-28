-- future database를 사용하겠다.
USE future;

-- 중요 **************************************
-- 테이블 수정 전에는 항상 무조건 반드시 ER부터 수정한다.
-- 중요 **************************************

-- * <= asteric = all 전체 다 가져온다. 근데 개발에서는 안쓴다.
-- 전체 컬럼 조회
SELECT * FROM member2;

-- 컬럼 추가
ALTER TABLE member2 ADD COLUMN username varchar(45);

-- 컬럼 추가시 위치 설정 (name 뒤에 생성할때의 예시)
ALTER TABLE member2 ADD COLUMN nameEng varchar(45) AFTER name;

-- 컬럼 타입 변경
-- 컬럼을 변경할때 데이터가 없을땐 괜찮지만 데이터가 있을때 컬럼을 변경하면 내용이 날아가서 곤란해진다.

ALTER TABLE member2 MODIFY COLUMN username varchar(100);

-- 컬럼 이름 변경
ALTER TABLE member2 CHANGE COLUMN username nickname varchar(45);