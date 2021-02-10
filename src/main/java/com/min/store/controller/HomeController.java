package com.min.store.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class HomeController {

	@RequestMapping(value="/")
	public ModelAndView test(HttpServletResponse response) throws IOException{
		return new ModelAndView("redirect:home");
	}
	
	@RequestMapping(value="/home")
	public ModelAndView home(ModelAndView mav , HttpServletResponse response, HttpServletRequest request) throws IOException{
		mav.addObject("login", request.getParameter("login"));
		mav.setViewName("home");
		return mav;
	}
}
