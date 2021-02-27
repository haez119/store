package com.min.store.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.min.store.impl.SellerMapper;
import com.min.store.vo.Item;
import com.min.store.vo.Seller;

@Controller
public class SellerHomeController {
	
	@Autowired SellerMapper dao;
	private String seller_id;
	private String item_no;
	private boolean update;
	
	@RequestMapping(value="/seller/home")
	public ModelAndView home(ModelAndView mav , HttpServletResponse response, HttpServletRequest request) throws IOException{
		mav.setViewName("sel/seller/home");
		return mav;
	}
	
	@RequestMapping(value="/seller/itemInsertForm")
	public ModelAndView itemInsertForm(ModelAndView mav ,HttpServletRequest request) throws IOException{
		
		item_no = request.getParameter("item_no");
		
		if(item_no == null || item_no.equals("")) {
			update = false;
			mav.setViewName("sel/seller/item/itemInsert");
		} else {
			update = true;
			mav.addObject("item", dao.upsetSel(item_no));
			mav.setViewName("sel/seller/item/itemInsert");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/seller/itemList")
	public ModelAndView itemList(ModelAndView mav , HttpSession session, Seller seller) throws IOException{
		seller = (Seller) session.getAttribute("seller");
		seller_id = seller.getSeller_id();
		
		List<Item> list = new ArrayList<Item>();
		list = dao.itemList(seller_id);
		
		for(int i=0; i<list.size(); i++) {
			String pics = list.get(i).getPic();
			String[] pic = pics.split(",");
			list.get(i).setPic(pic[0]);
		}
		mav.addObject("itemList", list);
		mav.setViewName("sel/seller/item/itemList");
		return mav;
	}
	
	@PostMapping(value="/seller/itemInsert")
	public ModelAndView itemInsert(ModelAndView mav , HttpServletRequest request, Item item) throws IOException{

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFile = multipartRequest.getFiles("pics");
		String imgname = "";
		for (int i = 0; i < multipartFile.size(); i++) {
			if (!multipartFile.get(i).isEmpty() && multipartFile.get(i).getSize() > 0) {
				String path = request.getSession().getServletContext().getRealPath("/images/item");
				multipartFile.get(i).transferTo(new File(path, multipartFile.get(i).getOriginalFilename()));
				imgname += multipartFile.get(i).getOriginalFilename() + ",";
			}
		}
		item.setPic(imgname);
		
		multipartRequest = (MultipartHttpServletRequest) request;
		multipartFile = multipartRequest.getFiles("pics_d");
		imgname = "";
		for (int i = 0; i < multipartFile.size(); i++) {
			if (!multipartFile.get(i).isEmpty() && multipartFile.get(i).getSize() > 0) {
				String path = request.getSession().getServletContext().getRealPath("/images/item");
				multipartFile.get(i).transferTo(new File(path, multipartFile.get(i).getOriginalFilename()));
				imgname += multipartFile.get(i).getOriginalFilename() + ",";
			}
		}
		item.setPic_d(imgname);
		
		item.setSeller_id(seller_id);
		item.setItem_no(item_no);
		
		if(update) {
			dao.itemUpdate(item);
		} else {
			dao.insertItem(item);
		}
		
		mav.setViewName("redirect:itemList");
		return mav;
	}
	

}