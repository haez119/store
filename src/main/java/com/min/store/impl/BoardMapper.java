package com.min.store.impl;

import java.util.List;

import com.min.store.vo.Review;


public interface BoardMapper {

	public void insertReview(Review review);
	public void updateReview(Review review);
	
	public List<Review> reviewList(Review review);
	
}
