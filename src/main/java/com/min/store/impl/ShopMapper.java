package com.min.store.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.min.store.vo.Buyer;
import com.min.store.vo.Buyer_d;
import com.min.store.vo.Cart;
import com.min.store.vo.Item;
import com.min.store.vo.Member;


public interface ShopMapper {

	public ArrayList<Item> itemAll(Item item);

	public ArrayList<Item> searchItem(Item item);//사용x
	
	public Item itemDetail(String no);
	public ArrayList<Item> itemSeller(String seller_id);
	
	public int cartCheck(Cart cart); 
	public void cartInsert(Cart cart);
	
	public ArrayList<Cart> cartList(String id);
	public void CartDel(String cart_no);
	public void updateCart(Cart cart);
	
	public ArrayList<Cart> orderCart(Cart cart);
	
	public void insertBuyer(Buyer buyer);
	public void insertBuyer_d(Buyer_d buyer_d);
	public void deleteCart(Cart cart);
	
	public ArrayList<Item> selectStock(Cart cart);
	public void updateStock(Item item);
	
	public List<HashMap<String,Object>> selectOrderList(Buyer buyer);
	public List<HashMap<String,Object>> OrderListDetail(String buy_no);
	
	//페이징 처리
	public int itemAllCnt(Item item);
	public int OrderListCnt(Buyer buyer);
	
	//찜하기
	public int selectWish(Member member);
	public void addWish(Member member);
	public void delWish(Member member);
	
	
	
	
}
