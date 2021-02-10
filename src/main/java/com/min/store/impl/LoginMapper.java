package com.min.store.impl;

import com.min.store.vo.Member;
import com.min.store.vo.Seller;


public interface LoginMapper {

	public Member loginMem(Member member);
	public Seller loginSeller(Seller seller);
	
}
