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
import com.min.store.impl.BoardMapper;
import com.min.store.impl.MainMapper;
import com.min.store.impl.ShopMapper;
import com.min.store.service.ShopService;
import com.min.store.vo.Buyer;
import com.min.store.vo.Buyer_d;
import com.min.store.vo.Cart;
import com.min.store.vo.Inquiry;
import com.min.store.vo.Item;
import com.min.store.vo.Member;
import com.min.store.vo.Paging;
import com.min.store.vo.Review;



@Controller
public class ShopController {
	
	@Autowired ShopMapper dao;
	@Autowired ShopService service;
	@Autowired BoardMapper boDao;
	@Autowired MainMapper mainDao;
	
	ArrayList<Cart> orderList = new ArrayList<Cart>();
	String[] kw;
	
	@RequestMapping(value="/shopMain")
	public ModelAndView shopMain(ModelAndView mav , HttpServletRequest request, Item item) throws IOException{
		
		item.setType(request.getParameter("type"));
		item.setOrderby(request.getParameter("orderby"));
		
		String strp = request.getParameter("p");
		int p = 1;
		
		if(strp != null && !strp.equals("")) {
			p = Integer.parseInt(strp);
		}
		Paging paging = new Paging();
		paging.setPageUnit(12); // 12로 바꿀꺼야
		paging.setPageSize(2); // 페이지 번호 수 이전 123 다음 . 기본10
		paging.setPage(p); // 현재 페이지 지정
		
		item.setFirst(paging.getFirst());
		item.setLast(paging.getLast());
		
		paging.setTotalRecord(dao.itemAllCnt(item));
		
		String keyword = request.getParameter("keyword");
		
		if(keyword == null || keyword.equals("")) {
			mav.addObject("paging", paging);
			mav.addObject("itemList", dao.itemAll(item));
		} else {
			mav.addObject("itemList", mainDao.searchItem(keyword));
		}
		mav.addObject("type", request.getParameter("type"));
		mav.addObject("orderby", request.getParameter("orderby"));
		mav.setViewName("shop/shopMain");
		return mav; 
	}
	
	@RequestMapping(value="/shopDetail")
	public ModelAndView shopDetail(ModelAndView mav , HttpServletRequest request, HttpSession session) throws IOException{
		
		String no = request.getParameter("no"); //item_no
		Item item = dao.itemDetail(no);
		
		String seller_id = item.getSeller_id(); 
		String pic_d = item.getPic_d();
		String[] picD = pic_d.split(","); //콤마 단위로 잘라서
		
		// 리뷰
		Gson gson = new GsonBuilder().create();
		List<Review> reList = new ArrayList<Review>();
		Review review = new Review();
		review.setItem_no(no);
		reList =  boDao.reviewList(review);
		String reviewList = gson.toJson(reList);
		
		
		// 문의글 리스트
		Inquiry inquiry = new Inquiry();
		inquiry.setItem_no(no);
		List<Inquiry> inquirySt = new ArrayList<Inquiry>();
		inquirySt = boDao.inquiryList(inquiry);
		gson = new GsonBuilder().create();
		String inquiryList = gson.toJson(inquirySt);
		
		//찜하기 
		Member member = new Member();
		member = (Member) session.getAttribute("member");
		if (member != null) {
			member.setItem_no(no);
			int wish = dao.selectWish(member);
			mav.addObject("wish", wish);
		}
		 
		mav.addObject("inquiryList", inquiryList); //문의 리스트
		mav.addObject("avgStar", boDao.avgStar(no)); // 상품 평균 별점
		mav.addObject("picD", picD); // 상품 대표사진
		mav.addObject("item", item); // 상품정보
		mav.addObject("sellerList", dao.itemSeller(seller_id)); //판매자의 다른 상품
		mav.addObject("reList", reList);  // 리뷰 리스트
		mav.addObject("reviewList", reviewList);  // gson 리뷰 리스트
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
		
		String strp = request.getParameter("p");
		int p = 1;
		if(strp != null && !strp.equals("")) {
			p = Integer.parseInt(strp);
		}
		Paging paging = new Paging();
		
		paging.setPageUnit(3); // 5로 바꿀꺼야
		paging.setPageSize(3); // 페이지 번호 수 이전 123 다음 . 기본10
		paging.setPage(p); // 현재 페이지 지정
		
		buyer.setFirst(paging.getFirst());
		buyer.setLast(paging.getLast());

		if(buy_no == null || buy_no.equals("")) {
			buyer.setMem_id(member.getMem_id());
			paging.setTotalRecord(dao.OrderListCnt(buyer));
			mav.addObject("buyList", dao.selectOrderList(buyer));
			
		} else {
			buyer.setBuy_no(buy_no);
			paging.setTotalRecord(dao.OrderListCnt(buyer));
			mav.addObject("buyList", dao.selectOrderList(buyer));
		}
		
		mav.addObject("paging", paging);
		mav.setViewName("shop/buyList");
		return mav; 
	}
	
	
	@RequestMapping(value="/buyList_D")
	@ResponseBody
	public HashMap<String,Object> buyList_D (HttpServletRequest request, Cart cart) throws IOException{
		String buy_no = request.getParameter("buy_no");	
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		HashMap<String,Object> map = new HashMap<String,Object>();
		list = dao.OrderListDetail(buy_no);
		
		// 대표이미지 1개만 넣기
		for(int i=0; i < list.size(); i++) {
			String pic = (String) list.get(i).get("PIC");
			String[] pic_d = pic.split(",");
			list.get(i).put("PIC", pic_d[0]);
		}
		Review review = new Review();
		map.put("buyList", list);
		map.put("reviewList", boDao.reviewList(review));
		
		return map;
	}
	
	
	@RequestMapping(value="/wishUpdate/{wish}/{item_no}")
	@ResponseBody
	public void wishUpdate(@PathVariable String wish, @PathVariable String item_no, HttpSession session, HttpServletRequest request) throws IOException{
		
		Member member = (Member) session.getAttribute("member");
		member.setItem_no(item_no);
		if(wish.equals("insert")) {
			dao.addWish(member);
		} else {
			dao.delWish(member);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
