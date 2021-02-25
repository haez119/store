package com.min.store.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SellerHomeController {
	
	@RequestMapping(value="/seller/home")
	public ModelAndView home(ModelAndView mav , HttpServletResponse response, HttpServletRequest request) throws IOException{
		mav.setViewName("seller/seller/home");
		return mav;
	}
	

}
