package com.min.store.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.MyPageMapper;
import com.min.store.vo.Member;



@Controller
public class MypageController {
	
	@Autowired MyPageMapper dao;
	
	@RequestMapping(value="/wishList")
	public ModelAndView wishList(ModelAndView mav , HttpSession session) throws IOException{
		
		Member member = (Member) session.getAttribute("member");
		if(member != null) {
			mav.addObject("wishList", dao.myWishList(member.getMem_id()));
		}
		mav.setViewName("mypage/wishList");
		return mav;
	}
	
	
	@RequestMapping(value="/mypage")
	public ModelAndView mypage(ModelAndView mav) throws IOException{

		mav.setViewName("mypage/mypage");
		return mav;
	}
	
	@RequestMapping(value="/mypageUpdate")
	public ModelAndView mypageUpdate(ModelAndView mav,  HttpSession session, Member member) throws IOException{
		
		
		
	    session.setAttribute("member", member); // 수정 후 정보 업데이트
		mav.setViewName("mypage/mypage");
		return mav;
	}
}
