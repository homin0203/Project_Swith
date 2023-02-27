/*테이블 생성 순서*/
--USER_INFO
--REPORT
--INFORM
--PROFILE
--PROFILE_IMG
--ATEA_CODE
--STUDY_CATEGORY
--STUDY
--STUDY_COMMENT
--STUDY_RESERVER
--STUDY_AUTH_INFO
--STUDY_PARTICIPANT
--CHATTING
--BOARD_CATEGORY
--BOARD
--SCHEDULE
--BOARD_ATTACHMENT
--BOARD_COMMENT
--PLACE_INFO
--PLACE_IMG
--STUDY_ROOM
--ROOM_IMG
--CARD_INFO
--RESERVE_INFO
--CANCEL_OfRESERVE_INFO

DROP TABLE "PENALTY_CANCEL";
DROP TABLE "PENALTY";
DROP TABLE "CANCEL_RESERVE_INFO";
DROP TABLE "RESERVE_INFO";
DROP TABLE "CARD_INFO";
DROP TABLE "ROOM_IMG";
DROP TABLE "STUDY_ROOM";
DROP TABLE "PLACE_IMG";
DROP TABLE "PLACE_INFO";
DROP TABLE "BOARD_COMMENT";
DROP TABLE "BOARD_ATTACHMENT";
DROP TABLE "SCHEDULE";
DROP TABLE "BOARD";
DROP TABLE "BOARD_CATEGORY";
DROP TABLE "CHATTING";
DROP TABLE "STUDY_PARTICIPANT";
DROP TABLE "STUDY_AUTH_INFO";
DROP TABLE "STUDY_RESERVER";
DROP TABLE "STUDY_COMMENT";
DROP TABLE "STUDY";
DROP TABLE "STUDY_CATEGORY";
DROP TABLE "AREA";
DROP TABLE "PROFILE_IMG";
DROP TABLE "PROFILE";
DROP TABLE "INFORM";
DROP TABLE "REPORT";
DROP TABLE "USER_INFO";

CREATE TABLE "USER_INFO" (
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"MEMBER_PWD"	VARCHAR2(200)		NOT NULL,
	"MEMBER_NAME"	VARCHAR2(15)		NOT NULL,
	"EMAIL"	VARCHAR2(20)		NOT NULL,
	"HND_NO"	VARCHAR2(13)		NOT NULL,
	"POST_NO"	VARCHAR2(5)		NOT NULL,
	"ADD1"	VARCHAR2(100)		NOT NULL,
	"ADD2"	VARCHAR2(30)		NULL,
	"AGREE1"	VARCHAR2(1)		NOT NULL,
	"AGREE2"	VARCHAR2(1)		NOT NULL,
	"AGREE3"	VARCHAR2(1)		NOT NULL,
	"MEMBER_AUTH"	VARCHAR2(10)		NOT NULL,
    "ENABLED"	NUMBER		NOT NULL,
    "STATUS_DATE"	DATE	DEFAULT SYSDATE 	NOT NULL,
    "FAILURE_CNT"	NUMBER		NULL
);
ALTER TABLE "USER_INFO" ADD CONSTRAINT "PK_USER_INFO" PRIMARY KEY (
	"MEMBER_ID"
);
CREATE TABLE "REPORT" (
	"REPORT_NO"	NUMBER		NOT NULL,
	"REPORT_CONTENT"	VARCHAR2(500)		NOT NULL,
	"REPORT_CATEGORY"	NUMBER		NOT NULL,
	"REPORT_DATE"	DATE		NOT NULL,
	"REPORT_CATEGORY_NUMBER"	NUMBER		NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL
);
ALTER TABLE "REPORT" ADD CONSTRAINT "PK_REPORT" PRIMARY KEY (
	"REPORT_NO"
);
CREATE TABLE "INFORM" (
	"INFORM_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"INFORM_CONTENT"	VARCHAR2(500)		NOT NULL
);
ALTER TABLE "INFORM" ADD CONSTRAINT "PK_INFORM" PRIMARY KEY (
	"INFORM_NO",
	"MEMBER_ID"
);
CREATE TABLE "PROFILE" (
	"NICK_NAME"	VARCHAR2(50)		NOT NULL,
	"INTRO"	VARCHAR2(100)		NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL
);
ALTER TABLE "PROFILE" ADD CONSTRAINT "PK_PROFILE" PRIMARY KEY (
	"NICK_NAME"
);
CREATE TABLE "PROFILE_IMG" (
	"PROFILE_IMG_NO"	NUMBER		NOT NULL,
	"NICK_NAME"	VARCHAR2(50)		NOT NULL,
	"PROFILE_IMG_ORIGIN"	VARCHAR2(255)		NOT NULL,
	"PROFILE_IMG_SAVE"	VARCHAR2(255)		NOT NULL,
	"PROFILE_IMG_ROUTE"	VARCHAR2(200)		NOT NULL
);
ALTER TABLE "PROFILE_IMG" ADD CONSTRAINT "PK_PROFILE_IMG" PRIMARY KEY (
	"PROFILE_IMG_NO",
	"NICK_NAME"
);
CREATE TABLE "AREA" (
	"AREA_CODE"	VARCHAR2(5)		NOT NULL,
	"SIGUNGU_NAME"	VARCHAR2(21)		NOT NULL,
	"SIDO_NAME"	VARCHAR2(21)		NOT NULL
);
ALTER TABLE "AREA" ADD CONSTRAINT "PK_AREA" PRIMARY KEY (
	"AREA_CODE"
);
CREATE TABLE "STUDY_CATEGORY" (
	"STUDY_CATEGORY_CODE"	NUMBER		NOT NULL,
	"STUDY_CATEGORY_NAME"	VARCHAR2(50)		NOT NULL
     --STUDY_CATEGORY_CODE 1: it 2: 어학 3:취업 4:자격증 5: 고시/공무원 6: 취미/교양 7: 기타
);
ALTER TABLE "STUDY_CATEGORY" ADD CONSTRAINT "PK_STUDY_CATEGORY" PRIMARY KEY (
	"STUDY_CATEGORY_CODE"
);
CREATE TABLE "STUDY" (
	"STUDY_NO"	NUMBER	NOT NULL,
	"STUDY_NAME"	VARCHAR2(100)	NOT NULL,
	"STUDY_PLACE"	VARCHAR2(100)	NOT NULL,
	"STUDY_INFO"	VARCHAR2(1000)	NOT NULL,
    "STUDY_PEOPLE" NUMBER(2) NOT NULL, --회원 수
	"STUDY_DETAILINFO"	VARCHAR2(1000)	NOT NULL,
	"STUDY_CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"STUDY_START_DATE"	DATE	NOT NULL,
	"STUDY_END_DATE"	DATE	NULL,
	"STUDY_TAG"	VARCHAR2(150)	NULL,
	"STUDY_RECRUITMENT_CONDITION"	 NUMBER(1)	DEFAULT 1	 NOT NULL,
	"AREA_CODE"	VARCHAR2(5)	NOT NULL,
	"STUDY_CATEGORY_CODE"	NUMBER	NOT NULL
);
ALTER TABLE "STUDY" ADD CONSTRAINT "PK_STUDY" PRIMARY KEY (
	"STUDY_NO"
);

COMMENT ON COLUMN "STUDY"."STUDY_RECRUITMENT_CONDITION" IS '1:모집중,2:모집마감';

CREATE TABLE "STUDY_COMMENT" (
	"STUDY_COMMENT_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"STUDY_NO"	NUMBER		NOT NULL,
	"STUDY_COMMENT"	VARCHAR2(1000)		NOT NULL,
	"STUDY_COMMENT_DATE"	DATE		NOT NULL,
	"STUDY_COMMENT_ORIGIN"	NUMBER		NOT NULL,
	"STUDY_COMMENT_LEVEL"	NUMBER		NOT NULL,
	"STUDY_COMMENT_SEQ"	NUMBER		NOT NULL
);
ALTER TABLE "STUDY_COMMENT" ADD CONSTRAINT "PK_STUDY_COMMENT" PRIMARY KEY (
	"STUDY_COMMENT_NO",
	"MEMBER_ID",
	"STUDY_NO"
);
CREATE TABLE "STUDY_RESERVER" (
	"STUDY_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"REQ_DATE"	DATE		NOT NULL,
	"REQ_COMMENT"	VARCHAR2(200)		NULL,
    "REQ_CONDITION" NUMBER(1) DEFAULT 1 NOT NULL
    --REQ_CONDITION  1. 대기 2. 승인 3. 거절
);
ALTER TABLE "STUDY_RESERVER" ADD CONSTRAINT "PK_STUDY_RESERVER" PRIMARY KEY (
	"STUDY_NO",
	"MEMBER_ID"
);
CREATE TABLE "STUDY_AUTH_INFO" (
	"AUTH_CODE"	NUMBER		NOT NULL,
	"AUTH_NAME"	VARCHAR2(20)		NOT NULL
);
ALTER TABLE "STUDY_AUTH_INFO" ADD CONSTRAINT "PK_STUDY_AUTH_INFO" PRIMARY KEY (
	"AUTH_CODE"
);
CREATE TABLE "STUDY_PARTICIPANT" (
	"AGR_NUMBER"	NUMBER		NOT NULL,
	"REQ_DATE"	DATE		NOT NULL,
	"AGR_DATE"	DATE		NULL,
	"OUT_DATE"	DATE		NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"STUDY_NO"	NUMBER		NOT NULL,
	"AUTH_CODE"	NUMBER		NOT NULL
);
ALTER TABLE "STUDY_PARTICIPANT" ADD CONSTRAINT "PK_STUDY_PARTICIPANT" PRIMARY KEY (
	"AGR_NUMBER"
);
CREATE TABLE "CHATTING" (
	"AGR_NUMBER"	NUMBER		NOT NULL,
	"CHATTING_CONTENT"	VARCHAR2(200)		NOT NULL,
	"CHATTING_TIME"	DATE		NOT NULL
);
ALTER TABLE "CHATTING" ADD CONSTRAINT "PK_CHATTING" PRIMARY KEY (
	"AGR_NUMBER"
);
CREATE TABLE "BOARD_CATEGORY" (
	"CATEGORY_CODE"	NUMBER		NOT NULL,
	"CATEGORY_NAME"	VARCHAR2(20)		NOT NULL
);
ALTER TABLE "BOARD_CATEGORY" ADD CONSTRAINT "PK_BOARD_CATEGORY" PRIMARY KEY (
	"CATEGORY_CODE"
);
CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(200)		NOT NULL,
	"BOARD_CONTENTS"	VARCHAR2(1000)		NOT NULL,
	"BOARD_WRITE"	DATE		NOT NULL,
	"BOARD_STATUS"	NUMBER		NOT NULL,
	"CATEGORY_CODE"	NUMBER		NOT NULL,
	"STUDY_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL
);
ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);
CREATE TABLE "SCHEDULE" (
	"SCHEDULE_NO"	NUMBER		NOT NULL,
	"SCHEDULE_CONTENT"	VARCHAR2(150)		NOT NULL,
	"START_DATE"	DATE		NOT NULL,
	"END_DATE"	DATE		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"STUDY_NO"	NUMBER		NOT NULL
);
ALTER TABLE "SCHEDULE" ADD CONSTRAINT "PK_SCHEDULE" PRIMARY KEY (
	"SCHEDULE_NO"
);
CREATE TABLE "BOARD_ATTACHMENT" (
	"ATTACHMENT_NO"	NUMBER		NOT NULL,
	"ORIGIN_NAME"	VARCHAR2(255)		NOT NULL,
	"SAVE_NAME"	VARCHAR2(255)		NOT NULL,
	"SAVE_ROUTE"	VARCHAR2(200)		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);
ALTER TABLE "BOARD_ATTACHMENT" ADD CONSTRAINT "PK_BOARD_ATTACHMENT" PRIMARY KEY (
	"ATTACHMENT_NO"
);
CREATE TABLE "BOARD_COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT"	VARCHAR2(1000)		NOT NULL,
	"COMMEMT_DATE"	DATE		NOT NULL,
	"COMMENT_ORIGIN"	NUMBER		NOT NULL,
	"COMMENT_LEVEL"	NUMBER		NOT NULL,
	"COMMENT_SEQ"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL
);
ALTER TABLE "BOARD_COMMENT" ADD CONSTRAINT "PK_BOARD_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);
CREATE TABLE "PLACE_INFO" (
	"P_NO"	NUMBER		NOT NULL,
	"P_NAME"	VARCHAR2(200)		NOT NULL,
	"P_ADDRESS"	VARCHAR2(200)		NOT NULL,
	"P_INFO"	VARCHAR2(500)		NULL,
    "P_PHONE" VARCHAR2(14) NOT NULL,
    "P_X" NUMBER(17,13) NOT NULL,
    "P_Y" NUMBER(17,13) NOT NULL,
	"AREA_CODE"	VARCHAR2(5)		NOT NULL
);
ALTER TABLE "PLACE_INFO" ADD CONSTRAINT "PK_PLACE_INFO" PRIMARY KEY (
	"P_NO"
);
CREATE TABLE "PLACE_IMG" (
	"P_IMG_NO"	NUMBER		NOT NULL,
	"P_IMG_ORIGIN"	VARCHAR2(255)		NOT NULL,
	"P_IMG_SAVE"	VARCHAR2(255)		NOT NULL,
	"P_IMG_ROUTE"	VARCHAR2(200)		NOT NULL
);
ALTER TABLE "PLACE_IMG" ADD CONSTRAINT "PK_PLACE_IMG" PRIMARY KEY (
	"P_IMG_NO"
);
CREATE TABLE "STUDY_ROOM" (
	"ROOM_NO"	NUMBER		NOT NULL,
	"ROOM_NAME"	VARCHAR2(20)		NOT NULL,
	"ROOM_PRICE"	NUMBER		NOT NULL,
	"ROOM_START_TIME"	NUMBER(2)		NOT NULL,
	"ROOM_END_TIME"	NUMBER(2)		NOT NULL,
	"ROOM_PEOPLE"	NUMBER		NOT NULL,
	"P_NO"	NUMBER		NOT NULL
);
ALTER TABLE "STUDY_ROOM" ADD CONSTRAINT "PK_STUDY_ROOM" PRIMARY KEY (
	"ROOM_NO"
);
CREATE TABLE "ROOM_IMG" (
	"ROOM_IMG_NO"	NUMBER		NOT NULL,
	"ROOM_IMG_ORIGIN"	VARCHAR2(255)		NOT NULL,
	"ROOM_IMG_SAVE"	VARCHAR2(255)		NOT NULL,
	"ROOM_IMG_ROUTE"	VARCHAR2(200)		NOT NULL
);
ALTER TABLE "ROOM_IMG" ADD CONSTRAINT "PK_ROOM_IMG" PRIMARY KEY (
	"ROOM_IMG_NO"
);
CREATE TABLE "CARD_INFO" (
	"TID"	VARCHAR2(20)		NOT NULL,
	"BIN"	VARCHAR2(6),		
	"CARD_TYPE"	VARCHAR2(10)	,	
	"KKP_PUR_CORP"	VARCHAR2(12)	,	
	"KKP_PUR_CORP_CODE"	VARCHAR2(3)	,	
	"KKP_ISS_CORP"	VARCHAR2(12)		,
	"KKP_ISS_CORP_CODE"	VARCHAR2(3)		
);
ALTER TABLE "CARD_INFO" ADD CONSTRAINT "PK_CARD_INFO" PRIMARY KEY (
	"TID"
);
CREATE TABLE "RESERVE_INFO" (
	"RESERVE_NO"	VARCHAR2(14)		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"ROOM_NO"	NUMBER		NOT NULL,
	"RESERVE_PRICE"	VARCHAR2(20)		NOT NULL,
	"RESERVE_NAME"	VARCHAR2(20)		NOT NULL,
	"RESERVE_EMAIL"	VARCHAR2(20)		NOT NULL,
	"RESERVE_PHONE"	VARCHAR2(11)		NULL,
	"RESERVE_START_TIME"	NUMBER(2)		NOT NULL,
	"RESERVE_END_TIME"	 NUMBER(2)		NOT NULL,
	"RESERVE_DATE"	DATE	NOT NULL,
	"PAYMENT_METHOD_TYPE" VARCHAR2(5)	NOT NULL,
	"RESERVE_PAY"	DATE		NOT NULL,
	"TID"	VARCHAR2(20)	NOT NULL
);
ALTER TABLE "RESERVE_INFO" ADD CONSTRAINT "PK_RESERVE_INFO" PRIMARY KEY (
	"RESERVE_NO",
	"MEMBER_ID",
	"ROOM_NO"
);
CREATE TABLE "CANCEL_RESERVE_INFO" (
	"RESERVE_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"ROOM_NO"	NUMBER		NOT NULL,
	"RESERVE_PRICE"	VARCHAR2(20)		NOT NULL,
	"RESERVE_NAME"	VARCHAR2(20)		NOT NULL,
	"RESERVE_EMAIL"	VARCHAR2(20)		NOT NULL,
	"RESERVE_PHONE"	VARCHAR2(11)		NULL,
	"RESERVE_START_TIME"	NUMBER(2)		NOT NULL,
	"RESERVE_END_TIME"	 NUMBER(2)		NOT NULL,
	"RESERVE_DATE"	DATE		NOT NULL,
	"PAYMENT_METHOD_TYPE" VARCHAR2(5)	NOT NULL,
	"RESERVE_PAY" DATE		NOT NULL,
	"TID"	VARCHAR2(20)	NOT NULL
);
ALTER TABLE "CANCEL_RESERVE_INFO" ADD CONSTRAINT "PK_CANCEL_RESERVE_INFO" PRIMARY KEY (
	"RESERVE_NO"
);

CREATE TABLE "PENALTY" (
	"PENALTY_NO"	 NUMBER		NOT NULL,
	"AGR_NUMBER"	NUMBER		NOT NULL,
	"PENALTY_POINT"	NUMBER(1)		NOT NULL,
	"PENALTY_REASON"	VARCHAR2(100)		NOT NULL,
	"PENALTY_TIME"	DATE	DEFAULT SYSDATE	NOT NULL
);

ALTER TABLE "PENALTY" ADD CONSTRAINT "PK_PENALTY" PRIMARY KEY (
	"PENALTY_NO",
	"AGR_NUMBER"
);

CREATE TABLE "PENALTY_CANCEL" (
	"PENALTY_NO"	NUMBER		NOT NULL,
	"AGR_NUMBER"	NUMBER		NOT NULL,
	"PENALTY_CANCEL_REASON"	VARCHAR2(200)	NOT NULL,
	"PENALTY_CANCEL_TIME"	DATE	DEFAULT SYSDATE	NOT NULL
);

ALTER TABLE "PENALTY_CANCEL" ADD CONSTRAINT "PK_PENALTY_CANCEL" PRIMARY KEY (
	"PENALTY_NO",
	"AGR_NUMBER"
);






/* FK */

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_USER_INFO_TO_REPORT_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "INFORM" ADD CONSTRAINT "FK_USER_INFO_TO_INFORM_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "PROFILE" ADD CONSTRAINT "FK_USER_INFO_TO_PROFILE_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "PROFILE_IMG" ADD CONSTRAINT "FK_PROFILE_TO_PROFILE_IMG_1" FOREIGN KEY (
	"NICK_NAME"
)
REFERENCES "PROFILE" (
	"NICK_NAME"
);

ALTER TABLE "STUDY" ADD CONSTRAINT "FK_AREA_TO_STUDY_1" FOREIGN KEY (
	"AREA_CODE"
)
REFERENCES "AREA" (
	"AREA_CODE"
);

ALTER TABLE "STUDY" ADD CONSTRAINT "FK_STUDY_CATEGORY_TO_STUDY_1" FOREIGN KEY (
	"STUDY_CATEGORY_CODE"
)
REFERENCES "STUDY_CATEGORY" (
	"STUDY_CATEGORY_CODE"
);

ALTER TABLE "STUDY_COMMENT" ADD CONSTRAINT "FK_U_INFO_TO_S_COMMENT_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "STUDY_COMMENT" ADD CONSTRAINT "FK_STUDY_TO_STUDY_COMMENT_1" FOREIGN KEY (
	"STUDY_NO"
)
REFERENCES "STUDY" (
	"STUDY_NO"
);

ALTER TABLE "STUDY_RESERVER" ADD CONSTRAINT "FK_STUDY_TO_STUDY_RESERVER_1" FOREIGN KEY (
	"STUDY_NO"
)
REFERENCES "STUDY" (
	"STUDY_NO"
);

ALTER TABLE "STUDY_RESERVER" ADD CONSTRAINT "FK_U_INFO_TO_S_RESERVER_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "STUDY_PARTICIPANT" ADD CONSTRAINT "FK_U_INFO_TO_S_PARTICIPANT_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "STUDY_PARTICIPANT" ADD CONSTRAINT "FK_STUDY_TO_S_PARTICIPANT_1" FOREIGN KEY (
	"STUDY_NO"
)
REFERENCES "STUDY" (
	"STUDY_NO"
);

ALTER TABLE "STUDY_PARTICIPANT" ADD CONSTRAINT "FK_S_AUTH_INFO_TO_S_PART_1" FOREIGN KEY (
	"AUTH_CODE"
)
REFERENCES "STUDY_AUTH_INFO" (
	"AUTH_CODE"
);

ALTER TABLE "CHATTING" ADD CONSTRAINT "FK_S_PARTICIPANT_TO_CHATTING_1" FOREIGN KEY (
	"AGR_NUMBER"
)
REFERENCES "STUDY_PARTICIPANT" (
	"AGR_NUMBER"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOARD_CATEGORY_TO_BOARD_1" FOREIGN KEY (
	"CATEGORY_CODE"
)
REFERENCES "BOARD_CATEGORY" (
	"CATEGORY_CODE"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_STUDY_TO_BOARD_1" FOREIGN KEY (
	"STUDY_NO"
)
REFERENCES "STUDY" (
	"STUDY_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_USER_INFO_TO_BOARD_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "SCHEDULE" ADD CONSTRAINT "FK_USER_INFO_TO_SCHEDULE_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "SCHEDULE" ADD CONSTRAINT "FK_STUDY_TO_SCHEDULE_1" FOREIGN KEY (
	"STUDY_NO"
)
REFERENCES "STUDY" (
	"STUDY_NO"
);

ALTER TABLE "BOARD_ATTACHMENT" ADD CONSTRAINT "FK_BOARD_TO_BOARD_ATTACHMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_COMMENT" ADD CONSTRAINT "FK_BOARD_TO_BOARD_COMMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_COMMENT" ADD CONSTRAINT "FK_U_INFO_TO_B_COMMENT_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "PLACE_INFO" ADD CONSTRAINT "FK_AREA_TO_PLACE_INFO_1" FOREIGN KEY (
	"AREA_CODE"
)
REFERENCES "AREA" (
	"AREA_CODE"
);

ALTER TABLE "PLACE_IMG" ADD CONSTRAINT "FK_PLACE_INFO_TO_PLACE_IMG_1" FOREIGN KEY (
	"P_IMG_NO"
)
REFERENCES "PLACE_INFO" (
	"P_NO"
);

ALTER TABLE "STUDY_ROOM" ADD CONSTRAINT "FK_PLACE_INFO_TO_STUDY_ROOM_1" FOREIGN KEY (
	"P_NO"
)
REFERENCES "PLACE_INFO" (
	"P_NO"
);

ALTER TABLE "ROOM_IMG" ADD CONSTRAINT "FK_STUDY_ROOM_TO_ROOM_IMG_1" FOREIGN KEY (
	"ROOM_IMG_NO"
)
REFERENCES "STUDY_ROOM" (
	"ROOM_NO"
);

ALTER TABLE "RESERVE_INFO" ADD CONSTRAINT "FK_USER_INFO_TO_RESERVE_INFO_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "USER_INFO" (
	"MEMBER_ID"
);

ALTER TABLE "RESERVE_INFO" ADD CONSTRAINT "FK_S_ROOM_TO_RESERVE_INFO_1" FOREIGN KEY (
	"ROOM_NO"
)
REFERENCES "STUDY_ROOM" (
	"ROOM_NO"
);

ALTER TABLE "RESERVE_INFO" ADD CONSTRAINT "FK_CARD_INFO_TO_RESERVE_INFO_1" FOREIGN KEY (
	"TID"
)
REFERENCES "CARD_INFO" (
	"TID"
);

ALTER TABLE "PENALTY" ADD CONSTRAINT "FK_SP_TO_PENALTY_1" FOREIGN KEY (
	"AGR_NUMBER"
)
REFERENCES "STUDY_PARTICIPANT" (
	"AGR_NUMBER"
);

ALTER TABLE "PENALTY_CANCEL" ADD CONSTRAINT "FK_PENALTY_TO_PC_1" FOREIGN KEY (
	"PENALTY_NO",
	"AGR_NUMBER"
)
REFERENCES "PENALTY" (
	"PENALTY_NO",
	"AGR_NUMBER"
);



--place_info,study_room 크롤링 데이터 이후 pk용 sequence 
drop sequence place_seq;
drop sequence room_seq;

create SEQUENCE place_seq start with 1055 INCREMENT BY 1;
create SEQUENCE room_seq start with 5200 INCREMENT BY 1;

--study study_no , category_code 시퀀스 적용
drop sequence study_seq;
create SEQUENCE study_seq start with 1 INCREMENT BY 1;

drop sequence sp_seq;
create SEQUENCE sp_seq start with 1 INCREMENT BY 1;



