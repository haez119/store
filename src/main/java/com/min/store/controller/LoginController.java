package com.min.store.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.LoginMapper;
import com.min.store.vo.Member;
import com.min.store.vo.Seller;

@Controller
public class LoginController {
	
	@Autowired LoginMapper dao;
	
	@RequestMapping(value="/loginForm") //로그인 화면
	public ModelAndView loginForm(HttpServletResponse response) throws IOException{
		return new ModelAndView("login/login");
	}
	
	@RequestMapping("/registerForm") //가입화면
	public ModelAndView registerForm(HttpServletResponse response) throws IOException{
		return new ModelAndView("login/register");
	}
	
	@RequestMapping("/logout") //로그아웃 처리
	public ModelAndView logout(HttpSession session) throws IOException{
		session.invalidate();
		return new ModelAndView("redirect:loginForm");
	}
	
	
	@RequestMapping("/login") //로그인 처리
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
	
	
	@RequestMapping("/memId/{id}") //개인 아이디 중복확인
	@ResponseBody
	public boolean memId(@PathVariable String id) throws IOException{
		
		if(dao.memIdCheck(id) == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/memEmail/{mail}") //개인 메일 중복확인
	@ResponseBody
	public boolean memEmail(@PathVariable String mail) throws IOException{
		
		if(dao.memMailCheck(mail) == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@PostMapping("/registerMem") //개인 회원가입
	@ResponseBody
	public void registerMem(Member member) throws IOException{
		dao.memInsert(member);
	}
	
	
	@RequestMapping("/sellerId/{id}") //사업자 아이디 중복확인 
	@ResponseBody
	public boolean sellerId(@PathVariable String id) throws IOException{
		
		if(dao.sellerIdCheck(id) == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/nicCheck/{nic}") //닉네임 중복확인 
	@ResponseBody
	public boolean nicCheck(@PathVariable String nic) throws IOException{
		
		if(dao.sellerNicCheck(nic) == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/license/{no}") //사업자번호 중복확인
	@ResponseBody
	public boolean license(@PathVariable String no) throws IOException{
		
		if(dao.sellerNoCheck(no) == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@PostMapping("/registerSeller") //판매자 회원가입
	@ResponseBody
	public void registerSeller(Seller seller) throws IOException{
		dao.sellerInsert(seller);
	}
	
}
