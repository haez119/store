package com.min.store.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.min.store.impl.MainMapper;
import com.min.store.vo.Item;
import com.min.store.vo.Member;



@Controller
public class HomeController {
	@Autowired MainMapper dao;

	@RequestMapping(value="/")
	public ModelAndView test(HttpServletResponse response) throws IOException{
		return new ModelAndView("redirect:home");
	}
	
	@RequestMapping(value="/home")
	public ModelAndView home(ModelAndView mav ,HttpServletRequest request, HttpSession session) throws IOException{
		
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		list = dao.mainList();
		
		for(int i=0; i < list.size(); i++) {
			String pic = (String) list.get(i).get("PIC");
			String[] pic_d = pic.split(",");
			list.get(i).put("PIC", pic_d[0]);
		}
		
		Gson gson = new GsonBuilder().create();
		String mainList = gson.toJson(list);
		
		Member member = (Member) session.getAttribute("member");
		
		if(member != null) {
			session.setAttribute("mainCart", dao.mainCart(member.getMem_id()));
		}
		
		
		mav.addObject("mainList", mainList);
		mav.addObject("login", request.getParameter("login"));
		mav.setViewName("home");
		return mav;
	}
	
	@RequestMapping(value="/search")
	public ModelAndView search(ModelAndView mav, HttpServletResponse response, Item item) throws IOException{
		
		mav.addObject("keyword", item.getSearch());
		mav.setViewName("redirect:shopMain");
		return mav;
	}
	
	
	
}
