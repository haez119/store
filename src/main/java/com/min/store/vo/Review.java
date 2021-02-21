package com.min.store.vo;

import lombok.Data;

@Data
public class Review {
	private String review_no;
	private String item_no;
	private String mem_id;
	private String title;
	private String content;
	private String star;
	private String tag;
	
	private String buyd_no;
	private String insert_date;
	
	private int first;
	private int last;
	
	
}
