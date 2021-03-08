package com.min.store.impl;

import java.util.HashMap;
import java.util.List;

import com.min.store.vo.Buyer;
import com.min.store.vo.Inquiry;
import com.min.store.vo.Item;
import com.min.store.vo.Review;


public interface MainMapper {
	public List<HashMap<String,Object>> mainList();
	public HashMap<String,Object> mainCart(String mem_id);
	public List<Item> searchItem(String keyword);
}
