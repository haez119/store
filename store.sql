
/* Drop Tables */

DROP TABLE black CASCADE CONSTRAINTS;
DROP TABLE buyer CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE inquiry CASCADE CONSTRAINTS;
DROP TABLE rereply CASCADE CONSTRAINTS;
DROP TABLE reply CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE seller CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE black
(
	black_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	seller_id varchar2(30) NOT NULL,
	cnt number,
	PRIMARY KEY (black_no)
);


CREATE TABLE buyer
(
	buy_no number NOT NULL,
	item_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	quantity number NOT NULL,
	payment number NOT NULL,
	pay_time date NOT NULL,
	name varchar2(50) NOT NULL,
	phone varchar2(50) NOT NULL,
	addr_no number NOT NULL,
	addr varchar2(100) NOT NULL,
	addr_d varchar2(100) NOT NULL,
	PRIMARY KEY (buy_no)
);


CREATE TABLE cart
(
	cart_no number NOT NULL,
	item_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	quantity number NOT NULL,
	PRIMARY KEY (cart_no)
);


CREATE TABLE inquiry
(
	inquiry_no number NOT NULL,
	item_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	type varchar2(30) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(500) NOT NULL,
	secret number NOT NULL,
	answer varchar2(500),
	PRIMARY KEY (inquiry_no)
);


CREATE TABLE item
(
	item_no number NOT NULL,
	seller_id varchar2(30) NOT NULL,
	type varchar2(30) NOT NULL,
	-- 
	-- 
	add_time date NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(300) NOT NULL,
	price number NOT NULL,
	stock number NOT NULL,
	poc varchar2(100) NOT NULL,
	pic_d varchar2(500) NOT NULL,
	PRIMARY KEY (item_no)
);


CREATE TABLE member
(
	mem_id varchar2(30) NOT NULL,
	password varchar2(100) NOT NULL,
	name varchar2(50) NOT NULL,
	email varchar2(50) NOT NULL,
	phone varchar2(30) NOT NULL,
	addr_no number,
	addr varchar2(100),
	addr_d varchar2(100),
	PRIMARY KEY (mem_id)
);


CREATE TABLE reply
(
	re_no number NOT NULL,
	review_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	content varchar2(500),
	PRIMARY KEY (re_no)
);


CREATE TABLE rereply
(
	rere_no number NOT NULL,
	content varchar2(500),
	re_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	PRIMARY KEY (rere_no)
);


CREATE TABLE review
(
	review_no number NOT NULL,
	item_no number NOT NULL,
	mem_id varchar2(30) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(500) NOT NULL,
	pic varchar2(500),
	star number NOT NULL,
	tag varchar2(100),
	PRIMARY KEY (review_no)
);


CREATE TABLE seller
(
	seller_id varchar2(30) NOT NULL,
	password varchar2(100) NOT NULL,
	name varchar2(50) NOT NULL,
	phone varchar2(30) NOT NULL,
	b_license_no varchar2(50) NOT NULL,
	PRIMARY KEY (seller_id)
);



/* Create Foreign Keys */

ALTER TABLE buyer
	ADD FOREIGN KEY (item_no)
	REFERENCES item (item_no)
;


ALTER TABLE cart
	ADD FOREIGN KEY (item_no)
	REFERENCES item (item_no)
;


ALTER TABLE inquiry
	ADD FOREIGN KEY (item_no)
	REFERENCES item (item_no)
;


ALTER TABLE review
	ADD FOREIGN KEY (item_no)
	REFERENCES item (item_no)
;


ALTER TABLE black
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE buyer
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE cart
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE inquiry
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE reply
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE rereply
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE review
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE rereply
	ADD FOREIGN KEY (re_no)
	REFERENCES reply (re_no)
;


ALTER TABLE reply
	ADD FOREIGN KEY (review_no)
	REFERENCES review (review_no)
;


ALTER TABLE black
	ADD FOREIGN KEY (seller_id)
	REFERENCES seller (seller_id)
;


ALTER TABLE item
	ADD FOREIGN KEY (seller_id)
	REFERENCES seller (seller_id)
;



/* Comments */

COMMENT ON COLUMN item.add_time IS '
';



