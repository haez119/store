package com.min.store.impl;

import java.util.ArrayList;

import com.min.store.vo.Member;
import com.min.store.vo.Seller;
import com.min.store.vo.Item;


public interface ShopMapper {

	public ArrayList<Item> itemAll();
	public ArrayList<Item> itemFiltering(String type);
	public Item itemDetail(String no);
	public ArrayList<Item> itemSeller(String seller_id);
	
}
