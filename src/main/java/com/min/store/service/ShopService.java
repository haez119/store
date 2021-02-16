package com.min.store.service;

import java.util.ArrayList;

import com.min.store.vo.Buyer;
import com.min.store.vo.Cart;

public interface ShopService {
	
	public void addOrder(ArrayList<Cart> orderList, Buyer buyer, Cart cart);

}
