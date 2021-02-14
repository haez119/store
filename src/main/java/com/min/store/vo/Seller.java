package com.min.store.vo;

import lombok.Data;

@Data
public class Seller {
	private String seller_id;
	private String password;
	
	private String name;
	private String phone;
	private String b_license_no;
	
	private String nic_name; // 0213 추가 스토어 이름
}
