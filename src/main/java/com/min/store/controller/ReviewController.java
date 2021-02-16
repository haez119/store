package com.min.store.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.BoardMapper;
import com.min.store.impl.ShopMapper;
import com.min.store.vo.Item;
import com.min.store.vo.Member;
import com.min.store.vo.Review;



@Controller
public class ReviewController {
	
	private String BUYD_NO;
	private String ITEM_NO;

	@Autowired ShopMapper shopDao;
	@Autowired BoardMapper dao;
	
	
	@RequestMapping(value="/reviewInsertForm/{item_no}/{buyd_no}")
	public ModelAndView reviewInsertForm(@PathVariable String item_no, @PathVariable String buyd_no, ModelAndView mav, Item item) throws IOException{
		
		item = shopDao.itemDetail(item_no);
		ITEM_NO = item.getItem_no();
		BUYD_NO = buyd_no;
		String pics = item.getPic();
		String[] pic = pics.split(",");
		item.setPic(pic[0]);
		
		mav.addObject("item", item);
		mav.setViewName("review/reviewInsert");
		return mav;
	}
	
	
	@RequestMapping(value="/reviewInsert" , method=RequestMethod.POST)
	public ModelAndView reviewInsert(HttpSession session, Review review, Member member) throws IOException{
		member = (Member) session.getAttribute("member");
		
		review.setMem_id(member.getMem_id());
		review.setItem_no(ITEM_NO);
		review.setBuyd_no(BUYD_NO);
		System.out.println("필드값  === " + ITEM_NO + " = = = " + BUYD_NO);
		System.out.println("=====컨트롤러 들어옴   == " + review.getBuyd_no());
		
		System.out.println("===== 제목 == " + review.getTitle());
		System.out.println("===== 내용 == " + review.getContent());
		System.out.println("===== 태그 == " + review.getTag());
		
		dao.insertReview(review);
		
		return new ModelAndView("redirect:buyList");

	}

}
