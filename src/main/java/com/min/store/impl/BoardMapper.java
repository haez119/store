package com.min.store.impl;

import java.util.List;

import com.min.store.vo.Inquiry;
import com.min.store.vo.Review;


public interface BoardMapper {

	public void insertReview(Review review);
	public void updateReview(Review review);
	
	public List<Review> reviewList(Review review);
	
	public String avgStar(String no);
	
	public void insertIquiry(Inquiry inquiry);
	public List<Inquiry> inquiryList(Inquiry inquiry);
	
}
