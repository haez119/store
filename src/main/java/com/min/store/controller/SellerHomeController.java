package com.min.store.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.min.store.impl.BoardMapper;
import com.min.store.impl.SellerMapper;
import com.min.store.vo.Buyer;
import com.min.store.vo.Inquiry;
import com.min.store.vo.Item;
import com.min.store.vo.Paging;
import com.min.store.vo.Review;
import com.min.store.vo.Seller;

@Controller
public class SellerHomeController {
	
	@Autowired SellerMapper dao;
	@Autowired BoardMapper boDao;
	//private String seller_id;
	private String item_no;
	private boolean update;
	
	@RequestMapping(value="/seller/home")
	public ModelAndView home(ModelAndView mav ,  HttpSession session, HttpServletRequest request) throws IOException{
		
		Seller seller = new Seller();
		seller = (Seller) session.getAttribute("seller");
		Buyer buyer = new Buyer();
		buyer.setSeller_id(seller.getSeller_id());
		List<HashMap<String, Object>> list = dao.salesList(buyer);
		
		mav.addObject("total", list.get(list.size()-1).get("SUM"));
		mav.addObject("salesList", list);
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
		Date time = new Date();
		buyer.setPay_time(format1.format(time)); // 오늘날짜

		list = dao.salesList(buyer);
		Gson gson = new GsonBuilder().create();
		String todayList = gson.toJson(list);
		
		buyer.setLast(dao.orderCnt(buyer));
		buyer.setFirst(1);
		
		mav.addObject("today", todayList);
		mav.addObject("orderList", dao.orderList(buyer));

		mav.setViewName("sel/seller/home");
		return mav;
	}
	
	@RequestMapping(value="/seller/itemInsertForm")
	public ModelAndView itemInsertForm(ModelAndView mav ,HttpServletRequest request) throws IOException{
		
		item_no = request.getParameter("item_no");
		
		if(item_no == null || item_no.equals("")) {
			update = false;
			mav.setViewName("sel/seller/itemInsert");
		} else {
			update = true;
			mav.addObject("item", dao.upsetSel(item_no));
			mav.setViewName("sel/seller/itemInsert");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/seller/itemList")
	public ModelAndView itemList(ModelAndView mav , HttpSession session, HttpServletRequest request, Seller seller, Item item) throws IOException{
		seller = (Seller) session.getAttribute("seller");
		
		String strp = request.getParameter("p");
		int p = 1;
		if(strp != null && !strp.equals("")) {
			p = Integer.parseInt(strp);
		}
		Paging paging = new Paging();
		
		paging.setPageUnit(5);
		paging.setPageSize(5); 
		paging.setPage(p);
		
		item.setFirst(paging.getFirst());
		item.setLast(paging.getLast());
		item.setSeller_id(seller.getSeller_id());
		
		paging.setTotalRecord(dao.itemCnt(seller.getSeller_id()));

		List<Item> list = new ArrayList<Item>();
		list = dao.itemList(item);
		
		for(int i=0; i<list.size(); i++) {
			String pics = list.get(i).getPic();
			String[] pic = pics.split(",");
			list.get(i).setPic(pic[0]);
		}
		mav.addObject("paging", paging);
		mav.addObject("itemList", list);
		mav.setViewName("sel/seller/itemList");
		return mav;
	}
	
	// 아이템 등록 및 수정
	@PostMapping(value="/seller/itemInsert")
	public ModelAndView itemInsert(ModelAndView mav , HttpServletRequest request, Item item,  HttpSession session) throws IOException{
		
		Seller seller = new Seller();
		seller = (Seller) session.getAttribute("seller");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFile = multipartRequest.getFiles("pics");
		String imgname = "";
		for (int i = 0; i < multipartFile.size(); i++) {
			if (!multipartFile.get(i).isEmpty() && multipartFile.get(i).getSize() > 0) {
				String path = request.getSession().getServletContext().getRealPath("/images/item");
				multipartFile.get(i).transferTo(new File(path, multipartFile.get(i).getOriginalFilename()));
				imgname += multipartFile.get(i).getOriginalFilename() + ",";
			}
		}
		item.setPic(imgname);
		
		multipartRequest = (MultipartHttpServletRequest) request;
		multipartFile = multipartRequest.getFiles("pics_d");
		imgname = "";
		for (int i = 0; i < multipartFile.size(); i++) {
			if (!multipartFile.get(i).isEmpty() && multipartFile.get(i).getSize() > 0) {
				String path = request.getSession().getServletContext().getRealPath("/images/item");
				multipartFile.get(i).transferTo(new File(path, multipartFile.get(i).getOriginalFilename()));
				imgname += multipartFile.get(i).getOriginalFilename() + ",";
			}
		}
		
		item.setPic_d(imgname);
		item.setSeller_id(seller.getSeller_id());
		item.setItem_no(item_no);
		
		if(update) { 
			dao.itemUpdate(item); // 수정
		} else {
			dao.insertItem(item); // 등록
		}
		
		mav.setViewName("redirect:itemList");
		return mav;
	}
	
	@RequestMapping(value="/seller/orderList")
	public ModelAndView orderList(ModelAndView mav , HttpServletRequest request,  HttpSession session, Seller seller, Buyer buyer) throws IOException{
		seller = (Seller) session.getAttribute("seller");
		String pay_time = request.getParameter("pay_time");
		String strp = request.getParameter("p");
		
		int p = 1;
		if(strp != null && !strp.equals("")) {
			p = Integer.parseInt(strp);
		}
		Paging paging = new Paging();
		
		paging.setPageUnit(5);
		paging.setPageSize(5); 
		paging.setPage(p);
		
		buyer.setFirst(paging.getFirst());
		buyer.setLast(paging.getLast());
		buyer.setSeller_id(seller.getSeller_id());
		buyer.setPay_time(pay_time);
		
		paging.setTotalRecord(dao.orderCnt(buyer));
		
		mav.addObject("paging", paging);
		mav.addObject("orderList", dao.orderList(buyer));
		mav.setViewName("sel/seller/orderList");
		return mav;
	}
	
	@RequestMapping(value="/seller/salesList")
	public ModelAndView salesList(ModelAndView mav , HttpServletRequest request,  HttpSession session, Seller seller, Buyer buyer) throws IOException{
		seller = (Seller) session.getAttribute("seller");

		buyer.setSeller_id(seller.getSeller_id());
		mav.addObject("salesList",dao.salesList(buyer));
		mav.setViewName("sel/seller/salesList");
		return mav;
	}
	
	@RequestMapping(value="/seller/inquiryList")
	public ModelAndView inquiryList(ModelAndView mav , HttpServletRequest request,  HttpSession session, Seller seller, Item item) throws IOException{
		seller = (Seller) session.getAttribute("seller");
		
		String strp = request.getParameter("p");
		int p = 1;
		if(strp != null && !strp.equals("")) {
			p = Integer.parseInt(strp);
		}
		Paging paging = new Paging();
		
		paging.setPageUnit(5);
		paging.setPageSize(5); 
		paging.setPage(p);
		
		item.setFirst(paging.getFirst());
		item.setLast(paging.getLast());
		item.setSeller_id(seller.getSeller_id());
		
		paging.setTotalRecord(dao.inquiryCnt(seller.getSeller_id()));
		
		mav.addObject("paging", paging);
		mav.addObject("inquiryList", dao.inquiryList(item));
		mav.setViewName("sel/seller/inquiryList");
		return mav;
	}
	
	@RequestMapping(value="/seller/updateAnswer", method = RequestMethod.POST)
	@ResponseBody
	public void addCart(HttpServletRequest request, Inquiry inquiry) throws IOException{
		inquiry.setAnswer(request.getParameter("answer"));
		inquiry.setInquiry_no(request.getParameter("inquiry_no"));
		
		dao.updateAnswer(inquiry);
	}
	
	
	@RequestMapping(value="/seller/reviewList")
	public ModelAndView reviewList(ModelAndView mav , HttpServletRequest request, Review review) throws IOException{
		
		Gson gson = new GsonBuilder().create();
		List<Review> reList = new ArrayList<Review>();
		
		review.setItem_no(request.getParameter("item_no"));
		reList =  boDao.reviewList(review);
		String reviewList = gson.toJson(reList);
		
		
		
		mav.addObject("reviewList", reviewList);
		mav.addObject("reList", reList);
		mav.setViewName("sel/seller/reviewList");
		return mav;
	}

}
