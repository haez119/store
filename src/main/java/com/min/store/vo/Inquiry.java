package com.min.store.vo;

import lombok.Data;

@Data
public class Inquiry {
	
	private String no;
	private String inquiry_no;
	private String item_no;
	private String mem_id;
	private String type;
	private String title;
	private String content;
	private String secret;
	//private boolean secret;
	private String answer;
	private String insert_date;
	private String answer_date;
	
	

}
