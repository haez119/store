package com.min.store.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.LoginMapper;
import com.min.store.vo.Member;
import com.min.store.vo.Seller;

@Controller
public class LoginController {
	
	@Autowired LoginMapper dao;
	
	@RequestMapping(value="/loginForm")
	public ModelAndView loginForm(HttpServletResponse response) throws IOException{
		return new ModelAndView("login/login");
	}
	
	@RequestMapping(value="/registerForm")
	public ModelAndView registerForm(HttpServletResponse response) throws IOException{
		return new ModelAndView("login/register");
	}
	
	@RequestMapping(value="/logout")
	public ModelAndView logout(HttpSession session) throws IOException{
		session.invalidate();
		return new ModelAndView("redirect:loginForm");
	}
	
	
	@RequestMapping(value="/login")
	public ModelAndView login(HttpServletResponse response, Member member, Seller seller , ModelAndView mav , HttpSession session ) throws IOException{
		
		// 일반회원 로그인
		if (member.getUser().equals("member"))  {
			member = dao.loginMem(member);
			if(member == null) {
				mav.addObject("login",true);
				mav.setViewName("login/login");
			} else {
				mav.addObject("login",true);
				session.setAttribute("member", member);
				mav.setViewName("redirect:home");
			}
		} else {
			// 사업자 회원 로그인
			seller.setSeller_id(member.getMem_id());
			seller.setPassword(member.getPassword());
			
			seller = dao.loginSeller(seller);
			if(seller == null) {
				mav.addObject("login", true);
				mav.setViewName("login/login");
			} else {
				mav.addObject("login", true);
				session.setAttribute("seller", seller);
				mav.setViewName("redirect:home"); //나중에 사업자 메인화면으로 이동할꺼야
			}
		}
		
		return mav;
	}
	
}
