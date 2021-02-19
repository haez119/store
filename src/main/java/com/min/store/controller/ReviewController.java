package com.min.store.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.BoardMapper;
import com.min.store.impl.ShopMapper;
import com.min.store.vo.Cart;
import com.min.store.vo.Inquiry;
import com.min.store.vo.Item;
import com.min.store.vo.Member;
import com.min.store.vo.Review;



@Controller
public class ReviewController {
	
	private String BUYD_NO;
	private String ITEM_NO;
	private String UPDATE;

	@Autowired ShopMapper shopDao;
	@Autowired BoardMapper dao;
	
	
	@RequestMapping(value="/reviewInsertForm/{item_no}/{buyd_no}")
	public ModelAndView reviewInsertForm(@PathVariable String item_no, @PathVariable String buyd_no, HttpServletRequest request, ModelAndView mav, Item item) throws IOException{
		
		UPDATE = request.getParameter("update");

		item = shopDao.itemDetail(item_no);
		ITEM_NO = item.getItem_no();
		BUYD_NO = buyd_no;
		String pics = item.getPic();
		String[] pic = pics.split(",");
		item.setPic(pic[0]);
		mav.addObject("item", item);
		
		if(UPDATE.equals("true")) {
			List<Review> list = new ArrayList<Review>();
			Review review = new Review();
			review.setBuyd_no(BUYD_NO);
			list = dao.reviewList(review); // 다건 조회도 같이 해서 리턴값이 list 임
			mav.addObject("review", list.get(0)); //update면 작성했던 내용 전달
		}
		
		mav.setViewName("review/reviewInsert");
		return mav;
	}
	
	
	@RequestMapping(value="/reviewInsert" , method=RequestMethod.POST)
	public ModelAndView reviewInsert(HttpSession session, Review review, Member member) throws IOException{
		member = (Member) session.getAttribute("member");
		review.setMem_id(member.getMem_id());
		review.setItem_no(ITEM_NO);
		review.setBuyd_no(BUYD_NO);
		
		if(UPDATE.equals("true")) {
			dao.updateReview(review);
		} else {
			dao.insertReview(review);
		}

		return new ModelAndView("redirect:buyList");
	}
	
	// 문의글 상세 조회
	@RequestMapping(value="/inquiryDetail" )
	@ResponseBody
	public List<Inquiry> inquiryDetail (HttpServletRequest request, HttpSession session) throws IOException{
		
		String inquiry_no = request.getParameter("no");
		Inquiry inquiry = new Inquiry();
		inquiry.setInquiry_no(inquiry_no);
		
		return dao.inquiryList(inquiry);
	}
	
	
	// 문의글 등록
	@RequestMapping(value="/inquiryInsert" , method=RequestMethod.POST)
	@ResponseBody
	public boolean inquiryInsert (HttpServletRequest request, HttpSession session ,Inquiry inquiry) throws IOException{
		
		Member member = (Member) session.getAttribute("member");
		inquiry.setMem_id(member.getMem_id());
		
		String secret = inquiry.getSecret();
		secret = (secret == null || secret.equals("") ? "0" : "1");
		
		inquiry.setSecret(secret);
		
		dao.insertIquiry(inquiry);
		return true;
	}

}
