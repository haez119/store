package com.min.store.vo;

import lombok.Data;

@Data
public class Item {
	private String item_no;
	private String seller_id;
	private String type;
	private String add_time;
	private String title;
	private String content;
	private String price;
	private String stock; //재고
	private String pic; //대표사진
	private String pic_d; //디테일 사진
	private String content_d; //0213 추가
	
	private String nic_name; //조인 용
	
	private String keyword; // 검색용

}
