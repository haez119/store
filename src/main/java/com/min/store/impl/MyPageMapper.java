package com.min.store.impl;

import java.util.ArrayList;

import com.min.store.vo.Item;

public interface MyPageMapper {
	public ArrayList<Item> myWishList(String mem_id);

}
