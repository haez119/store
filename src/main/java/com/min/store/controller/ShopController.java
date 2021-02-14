package com.min.store.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.ShopMapper;
import com.min.store.vo.Cart;
import com.min.store.vo.Item;
import com.min.store.vo.Member;



@Controller
public class ShopController {
	
	@Autowired ShopMapper dao;
	
	ArrayList<Cart> orderList = new ArrayList<Cart>();
	
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
		String[] kw = new String[test.length-1];
		
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
	
}
