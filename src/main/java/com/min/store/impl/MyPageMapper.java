package com.min.store.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.min.store.vo.Inquiry;
import com.min.store.vo.Item;
import com.min.store.vo.Member;
import com.min.store.vo.Review;

public interface MyPageMapper {
	public ArrayList<Item> myWishList(String mem_id);
	public void mypageUpdate(Member member);
	
	public List<HashMap<String, Object>> myReviewList(String mem_id);
	public Review myReview_d(String review_no);
	public List<HashMap<String, Object>> myInquiry(Inquiry inquiry);
	
	public void inquiryDel(String inquiry_no);
	public void myReviewDel(String review_no);
	
}
