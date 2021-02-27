package com.min.store.impl;

import java.util.List;
import com.min.store.vo.Item;


public interface SellerMapper {
	public List<Item> itemList(String seller_id);
	public void insertItem(Item item);
	
	public Item upsetSel(String item_no);
	public void itemUpdate(Item item);
	
}
