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

import com.min.store.impl.ShopMapper;
import com.min.store.service.ShopService;
import com.min.store.vo.Buyer;
import com.min.store.vo.Buyer_d;
import com.min.store.vo.Cart;
import com.min.store.vo.Item;
import com.min.store.vo.Member;



@Controller
public class ShopController {
	
	@Autowired ShopMapper dao;
	@Autowired ShopService service;
	
	ArrayList<Cart> orderList = new ArrayList<Cart>();
	String[] kw;
	
	@RequestMapping(value="/shopMain")
	public ModelAndView shopMain(ModelAndView mav , HttpServletRequest request, Item item) throws IOException{
		String type = request.getParameter("type");
		type = (type == null || "".equals(type)) ? "no" : type; 
		item.setType(type);
		item.setNewmax(request.getParameter("newmax"));
		
		mav.addObject("itemList",dao.itemAll(item));
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
		buyer.setBuy_no(buy_no); // 주문번호 넣고
		cart.setList(kw); // 카트번호 리스트 넣고
		
		service.addOrder(orderList, buyer, cart);

		return buy_no;
	}
	
	
	
	@RequestMapping(value="/buyList")
	public ModelAndView orderList (ModelAndView mav , HttpServletRequest request, HttpSession session , Member member) throws IOException{
		
		String buy_no = request.getParameter("buy_no");
		member = (Member) session.getAttribute("member");
		Buyer buyer = new Buyer();

		if(buy_no.equals("no")) {
			buyer.setMem_id(member.getMem_id());
			mav.addObject("buyList", dao.selectOrderList(buyer));
			
		} else {
			buyer.setBuy_no(buy_no);
			mav.addObject("buyList", dao.selectOrderList(buyer));
		}
		mav.setViewName("shop/buyList");
		return mav; 
	}
	
	
	@RequestMapping(value="/buyList_D")
	@ResponseBody
	public List<HashMap<String,Object>> buyList_D (HttpServletRequest request, Cart cart) throws IOException{
		String buy_no = request.getParameter("buy_no");	
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		list = dao.OrderListDetail(buy_no);
		
		// 대표이미지 1개만 넣기
		for(int i=0; i < list.size(); i++) {
			String pic = (String) list.get(i).get("PIC");
			String[] pic_d = pic.split(",");
			list.get(i).put("PIC", pic_d[0]);
		}
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
