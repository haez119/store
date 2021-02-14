package com.min.store.impl;

import com.min.store.vo.Member;
import com.min.store.vo.Seller;


public interface LoginMapper {

	public Member loginMem(Member member);
	public Seller loginSeller(Seller seller);
	
	public int memIdCheck(String id);
	public int memMailCheck(String mail);
	public void memInsert(Member member);
	
	public int sellerIdCheck(String id);
	public int sellerNicCheck(String nic);
	public int sellerNoCheck(String no);
	public void sellerInsert(Seller seller);
	
	
}
