package com.min.store.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.ShopMapper;
import com.min.store.vo.Item;



@Controller
public class ShopController {
	
	@Autowired ShopMapper dao;
	
	@RequestMapping(value="/shopMain")
	public ModelAndView shopMain(ModelAndView mav , HttpServletRequest request) throws IOException{
		
		String type = request.getParameter("type");
		
		if (type == null || type.equals("")) {
			mav.addObject("itemList",dao.itemAll());
		} else {
			mav.addObject("itemList",dao.itemFiltering(type));
		}

		mav.setViewName("shop/shopMain");
		return mav; 
	}
	
	@RequestMapping(value="/shopDetail")
	public ModelAndView shopDetail(ModelAndView mav , HttpServletRequest request) throws IOException{
		
		String no = request.getParameter("no");
		Item item = dao.itemDetail(no);
		
		String seller_id = item.getSeller_id(); 
		String pic_d = item.getPic_d();
		String[] picD = pic_d.split(","); //콤마 단위로 잘라서
		
		mav.addObject("picD", picD); //forEach 돌려서 출력
		mav.addObject("item", item);
		mav.addObject("sellerList", dao.itemSeller(seller_id));
		mav.setViewName("shop/shopDetail");
		return mav; 
	}
	
	
	
}
