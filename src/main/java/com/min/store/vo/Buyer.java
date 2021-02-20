package com.min.store.vo;

import lombok.Data;

@Data
public class Buyer {
	private String buy_no;
	private String mem_id;
	private String payment;
	private String pay_time;
	private String name;
	private String phone;
	private String addr_no;
	private String addr;
	private String addr_d;
	private String email;
	
	// 페이징 처리
	private int first; 
	private int last;
	
	
}
