package com.min.store.vo;

import lombok.Data;

@Data
public class Cart {
	private String cart_no;
	private String item_no;
	private String mem_id;
	private String quantity; //수량
	
	private int total; //조인용
	private String title;
	private String price;
	private String pic;
	
	private String[] list; //장바구니 번호 리스트
	
}
