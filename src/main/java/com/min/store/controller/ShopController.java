package com.min.store.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.min.store.impl.ShopMapper;
import com.min.store.vo.Buyer;
import com.min.store.vo.Buyer_d;
import com.min.store.vo.Cart;
import com.min.store.vo.Item;
import com.min.store.vo.Member;



@Controller
public class ShopController {
	
	@Autowired ShopMapper dao;
	
	ArrayList<Cart> orderList = new ArrayList<Cart>();
	String[] kw;
	
	@RequestMapping(value="/shopMain")
	public ModelAndView shopMain(ModelAndView mav , HttpServletRequest request, Item item) throws IOException{
		
		String type = request.getParameter("type");
		
		if(item.getKeyword() == null || item.getKeyword().equals("") ) {
			if (type == null || type.equals("")) {
				mav.addObject("itemList",dao.itemAll());
			} else {
				mav.addObject("itemList",dao.itemFiltering(type));
			}
		} else {
			mav.addObject("itemList", dao.searchItem(item));
		}
		mav.setViewName("shop/shopMain");
		return mav; 
	}
	
	@RequestMapping(value="/shopDetail")
	public ModelAndView shopDetail(ModelAndView mav , HttpServletRequest request) throws IOException{
		
		String no = request.getParameter("no");
		Item item = dao.itemDetail(no);
		
		String seller_id = item.getSeller_id(); 
		String pic_d = item.getPic_d();
		String[] picD = pic_d.split(","); //콤마 단위로 잘라서
		
		mav.addObject("picD", picD); //forEach 돌려서 출력
		mav.addObject("item", item);
		mav.addObject("sellerList", dao.itemSeller(seller_id));
		mav.setViewName("shop/shopDetail");
		return mav; 
	}
	
	@RequestMapping(value="/addCart/{no}/{q}/{id}")
	@ResponseBody
	public boolean addCart(@PathVariable String no, @PathVariable String q, @PathVariable String id, HttpSession session, Cart cart) throws IOException{
		cart.setItem_no(no);
		cart.setQuantity(q);
		cart.setMem_id(id);
		
		if(dao.cartCheck(cart) == 0) {
			dao.cartInsert(cart);
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping(value="/cartMain")
	public ModelAndView cartMain(ModelAndView mav ,HttpSession session , Member member) throws IOException{
		member = (Member) session.getAttribute("member");
		mav.addObject("cartList", dao.cartList(member.getMem_id()));

		mav.setViewName("shop/cartMain");
		return mav; 
	}
	
	@RequestMapping(value="/cartDel/{no}")
	@ResponseBody
	public boolean addCart(@PathVariable String no , HttpSession session, Cart cart) throws IOException{
		dao.CartDel(no);
		return true; 
	}
	
	@RequestMapping(value="/updateCart")
	@ResponseBody
	public void updateCart( HttpServletRequest request, Cart cart) throws IOException{

		String list = request.getParameter("list");
		String[] kw = list.split(","); //콤마 단위로 잘라서
		for(int i=1; i < kw.length; i+=2 ) {
			cart = new Cart();
			cart.setCart_no(kw[i]);
			cart.setQuantity(kw[i+1]);
			dao.updateCart(cart);
		}
	}
	
	@RequestMapping(value="/getOrder")
	@ResponseBody
	public void getOrder (ModelAndView mav , HttpServletRequest request, Cart cart) throws IOException{
		String cart_no = request.getParameter("no");
		String[] test = cart_no.split(","); //콤마 단위로 잘라서
		kw = new String[test.length-1];
		
		for(int i=1; i < test.length ; i++) {
			kw[i-1] = test[i]; //null값 빼기
		}
		cart.setList(kw);
		orderList = dao.orderCart(cart); //forEach 돌려서 출력
	}
	
	@RequestMapping(value="/getOrderPage")
	public ModelAndView getOrderPage (ModelAndView mav , HttpServletRequest request) throws IOException{
		
		mav.addObject("orderList", orderList);
		mav.setViewName("shop/getOrder");
		return mav; 
	}
	
	// 구매자 정보 insert
	@RequestMapping(value="/addOrder")
	@ResponseBody
	public String addOrder (HttpSession session, HttpServletRequest request, Member member,  Buyer buyer, Buyer_d buyer_d, Cart cart, Item item) throws IOException{

		member = (Member) session.getAttribute("member");
		buyer.setMem_id(member.getMem_id()); // 세션에 id 넣고
		
		// 주문번호 만들어서 buy_no에 넣고
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String orderNo = "";
		
		for(int i = 1; i <= 6; i ++) {
			orderNo += (int)(Math.random() * 10);
		}
		String buy_no = ymd + "_" + orderNo;
		buyer.setBuy_no(buy_no);

		// buyer 테이블에 insert 하고
		dao.insertBuyer(buyer); 
		
		
		// 구매한 품목의 갯수만큼 insert 반복
		for(Cart c : orderList) { 
			buyer_d.setBuy_no(buy_no);
			buyer_d.setItem_no(c.getItem_no());
			buyer_d.setQuantity(c.getQuantity());
			dao.insertBuyer_d(buyer_d);
		}

		cart.setList(kw);

		// 재고 변경
		ArrayList<Item> list = new ArrayList<Item>();
		list = dao.selectStock(cart);
		for(int i=0; i < list.size(); i++ ) {
			String db = (String) list.get(i).getCart_no();
			String order = orderList.get(i).getCart_no();
			
			if(db.equals(order)) {
				int stock = Integer.parseInt(list.get(i).getStock()); //재고
				int orderStock = Integer.parseInt(orderList.get(i).getQuantity()); // 구매 수량
				item.setStock(Integer.toString(stock - orderStock));
				item.setItem_no(orderList.get(i).getItem_no());
				
				dao.updateStock(item);
			}
		}
		// 장바구니에서 삭제
		dao.deleteCart(cart);
		
		//매개값으로 넘길 거
		// orderList, kw 넣은 cart, buyer_no 넣은 buyer
		
		return buy_no;
	}
	
	
	
	@RequestMapping(value="/buyList")
	public ModelAndView orderList (ModelAndView mav , HttpServletRequest request, HttpSession session , Member member) throws IOException{
		
		String buy_no = request.getParameter("buy_no");
		member = (Member) session.getAttribute("member");
		Buyer buyer = new Buyer();

		if(buy_no.equals("no")) {
			buyer.setMem_id(member.getMem_id());
			System.out.println("아이디로 조회 " + buyer.getMem_id());
			
			mav.addObject("buyList", dao.selectOrderList(buyer));
			
		} else {
			buyer.setBuy_no(buy_no);
			System.out.println("번호로 조회 " + buyer.getBuy_no());
			
			mav.addObject("buyList", dao.selectOrderList(buyer));
			
		}
		mav.setViewName("shop/buyList");
		return mav; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
