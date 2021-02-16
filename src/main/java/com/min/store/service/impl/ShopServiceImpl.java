package com.min.store.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.store.impl.ShopMapper;
import com.min.store.service.ShopService;
import com.min.store.vo.Buyer;
import com.min.store.vo.Buyer_d;
import com.min.store.vo.Cart;
import com.min.store.vo.Item;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired ShopMapper dao;
	
	@Transactional
	public void addOrder(ArrayList<Cart> orderList, Buyer buyer, Cart cart) {

		dao.insertBuyer(buyer); //구매자정보 insert

		Buyer_d buyer_d = new Buyer_d();
		for(Cart c : orderList) {
			buyer_d.setBuy_no(buyer.getBuy_no());
			buyer_d.setItem_no(c.getItem_no());
			buyer_d.setQuantity(c.getQuantity());
			dao.insertBuyer_d(buyer_d); //구매자 상세정보에 insert
		}
		
		// 재고변경
		ArrayList<Item> list = new ArrayList<Item>();
		list = dao.selectStock(cart); // 재고 먼저 가져와서
		Item item = new Item();
		
		for(int i=0; i < list.size(); i++ ) {
			String db = (String) list.get(i).getCart_no();
			String order = orderList.get(i).getCart_no();
			
			if(db.equals(order)) {
				int stock = Integer.parseInt(list.get(i).getStock()); //재고
				int orderStock = Integer.parseInt(orderList.get(i).getQuantity()); // 구매 수량
				item.setStock(Integer.toString(stock - orderStock)); // 재고 - 구매수량
				item.setItem_no(orderList.get(i).getItem_no());
				dao.updateStock(item); //변경
			}
		}
		dao.deleteCart(cart); // 카트 삭제
	}

}
