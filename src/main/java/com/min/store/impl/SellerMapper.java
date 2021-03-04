package com.min.store.impl;

import java.util.HashMap;
import java.util.List;

import com.min.store.vo.Buyer;
import com.min.store.vo.Inquiry;
import com.min.store.vo.Item;


public interface SellerMapper {
	public List<Item> itemList(Item item);
	public int itemCnt(String seller_id);
	public void insertItem(Item item);
	
	public List<HashMap<String, Object>> inquiryList(Item item);
	public int inquiryCnt(String seller_id);
	public Item upsetSel(String item_no);
	public void itemUpdate(Item item);
	
	public List<HashMap<String, Object>> orderList(Buyer buyer);
	public int orderCnt(Buyer buyer);
	
	public List<HashMap<String, Object>> salesList(Buyer buyer);
	
	
	public void updateAnswer(Inquiry inquiry);
	
	
}
