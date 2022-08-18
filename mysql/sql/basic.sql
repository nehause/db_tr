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

-- 컬럼 삭제 (보통 삭제하기전에 통채로 백업을 시켜놓는다)
ALTER TABLE member2 DROP COLUMN nickname;

-- row 삭제 (delete 구문을 쓸때는 테이블 이름을 쓰기 전에 where 구문을 미리 쓰고 테이블 이름을 넣는다. 테이블 drop 방지)
-- Seq의 이름이 memberSeq 같은거면 그거에 맞춰야한다. 검색이람 같음 ex) member WHERE memberSeq =11;
DELETE FROM member2 WHERE Seq = 11;

-- commit / rollback

-- 데이터 수정 (delete 구문을 쓸때와 같이 where 구문을 쓰고 테이블 이름을 넣어서 쓴다.)
UPDATE member2 SET
	name = "진휘재"
	,nameEng ="Jinhwijae"
	where seq = 1;

-- 문자열 비교 like 

SELECT * FROM member
WHERE 1=1
-- AND name like '공%'
-- AND name like '%석'
-- AND name like '%소%'
-- AND email like '%naver%'
-- AND email like '%gmail%'
-- AND address1 like '%송파구%'
-- AND dob like '199%'
-- 08 날짜에 08을 넣는다면 08년, 08월 08일까지 검색되어 월을 검색하고싶다면 %-08-%를 하면 된다.
AND dob like '%08%'

;

-- 숫자 비교 (between은 숫자 ~ 숫자)
SELECT * FROM member
WHERE 1=1
-- AND privacy = 1
-- AND privacy > 2
-- AND privacy >= 2
-- AND privacy between 3 and 4 
AND dob between '1980-01-01' and '1999-12-31'
;

SELECT * FROM member2
WHERE 1=1
AND pwd is null
-- AND nameEng = null -- 틀린 표현이다.
-- ""은 빈칸을 검색하는거지 null을 검색하는게 아니다
-- AND pwd is = ''
;

CREATE TABLE IF NOT EXISTS `future`.`CCG` (
  `CGseq` INT NOT NULL AUTO_INCREMENT,
  `CGName` VARCHAR(45) NULL,
  `CGUseNy` VARCHAR(45) NULL,
  `CGorder` VARCHAR(45) NULL,
  PRIMARY KEY (`CGseq`))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS `future`.`CG` (
  `Cseq` INT NOT NULL AUTO_INCREMENT,
  `CName` VARCHAR(45) NULL,
  `CUseNy` VARCHAR(45) NULL,
  `Corder` VARCHAR(45) NULL,
  `CCG_CGseq` INT NOT NULL,
  PRIMARY KEY (`Cseq`),
  INDEX `fk_CG_CCG1_idx` (`CCG_CGseq` ASC) VISIBLE,
  CONSTRAINT `fk_CG_CCG1`
    FOREIGN KEY (`CCG_CGseq`)
    REFERENCES `future`.`CCG` (`CGseq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS `future`.`bookUploaded` (
  `bookUSeq` INT NOT NULL AUTO_INCREMENT,
  `type` TINYINT NULL,
  `defaultNy` TINYINT NULL,
  `sort` TINYINT NULL,
  `originalName` VARCHAR(45) NULL,
  `uuidName` VARCHAR(45) NULL,
  `ext` VARCHAR(45) NULL,
  `size` BIGINT NULL,
  `delNy` TINYINT NULL,
  `pSeq` BIGINT NULL,
  PRIMARY KEY (`bookUSeq`))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS `future`.`writerUploaded` (
  `writerUSeq` INT NOT NULL AUTO_INCREMENT,
  `type` TINYINT NULL,
  `defaultNy` TINYINT NULL,
  `sort` TINYINT NULL,
  `originalName` VARCHAR(45) NULL,
  `uuidName` VARCHAR(45) NULL,
  `ext` VARCHAR(45) NULL,
  `size` BIGINT NULL,
  `delNy` TINYINT NULL,
  `pSeq` BIGINT NULL,
  PRIMARY KEY (`writerUSeq`))
ENGINE = InnoDB
;

