package com.min.store.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.min.store.impl.LoginMapper;
import com.min.store.impl.MyPageMapper;
import com.min.store.vo.Inquiry;
import com.min.store.vo.Member;
import com.min.store.vo.Review;



@Controller
public class MypageController {
	
	@Autowired MyPageMapper dao;
	@Autowired LoginMapper loginDao;
	
	private String mem_id;
	
	@RequestMapping(value="/wishList")
	public ModelAndView wishList(ModelAndView mav , HttpSession session) throws IOException{
		
		Member member = (Member) session.getAttribute("member");
		if(member != null) {
			mav.addObject("wishList", dao.myWishList(member.getMem_id()));
		}
		mav.setViewName("mypage/wishList");
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/pwCheck" ,method=RequestMethod.POST) 
	public boolean pwCheck(HttpSession session, HttpServletRequest request, Member member) throws IOException{
		
		member = (Member) session.getAttribute("member");
		mem_id = member.getMem_id();
		
		Member mem = new Member();
		mem.setMem_id(mem_id);
		mem.setPassword(request.getParameter("pw"));
		
		mem = loginDao.loginMem(mem);
		
		if(mem == null) {
			return false;
		} else {
			return true;
		}
	}
	
	@RequestMapping(value="/mypage")
	public ModelAndView mypage(ModelAndView mav) throws IOException{
		mav.setViewName("mypage/mypage");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/mypageUpdate" ,method=RequestMethod.POST)
	public void mypageUpdate(HttpSession session, Member member) throws IOException{
		member.setMem_id(mem_id); //아이디 넣고
		dao.mypageUpdate(member); // 디비 업데이트
	    session.setAttribute("member", member); // 세션 업데이트
	}
	
	// 나의 리뷰 리스트
	@RequestMapping(value="/myReviewList")
	public ModelAndView myReviewList(ModelAndView mav, HttpSession session, Member member) throws IOException{
		member = (Member) session.getAttribute("member");
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		list = dao.myReviewList(member.getMem_id());
		
		Gson gson = new GsonBuilder().create();
		gson = new GsonBuilder().create();
		String star = gson.toJson(list);
		
		
		mav.addObject("starList", star);
		mav.addObject("myReviewList", list);
		mav.setViewName("mypage/myReview");
		return mav;
	}
	
	// 리뷰 상세
	@ResponseBody
	@RequestMapping(value="/myReview_d")
	public Review myReview_d(HttpServletRequest request, Member member) throws IOException{
		return dao.myReview_d(request.getParameter("review_no"));
	}
	
	// 리뷰 삭제
	@ResponseBody
	@RequestMapping(value="/myReviewDel")
	public void myReviewDel(HttpServletRequest request, Member member) throws IOException{
		dao.myReviewDel(request.getParameter("review_no"));
	}
		
	
	// 나의 문의
	@RequestMapping(value="/myInquiry")
	public ModelAndView myInquiry(ModelAndView mav, HttpSession session, Member member) throws IOException{
		
		member = (Member) session.getAttribute("member");
		
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		Inquiry inquiry = new Inquiry();
		inquiry.setMem_id(member.getMem_id());
		list = dao.myInquiry(inquiry);
		
		Gson gson = new GsonBuilder().create();
		gson = new GsonBuilder().create();
		String myInquiry = gson.toJson(list);
		
		mav.addObject("myInquiryList", myInquiry);
		mav.setViewName("mypage/myInquiry");
		return mav;
	}
	
	// 문의 상세
	@ResponseBody
	@RequestMapping(value="/myInquiry_d")
	public List<HashMap<String, Object>> myInquiry_d(HttpServletRequest request, Member member) throws IOException{
		
		Inquiry inquiry = new Inquiry();
		inquiry.setInquiry_no(request.getParameter("inquiry_no"));
		
		return dao.myInquiry(inquiry);
	}
	
	// 문의 삭제
	@ResponseBody
	@RequestMapping(value="/myInquiryDel")
	public void myInquiryDel(HttpServletRequest request, Member member) throws IOException{
		dao.inquiryDel(request.getParameter("inquiry_no"));

	}
}
