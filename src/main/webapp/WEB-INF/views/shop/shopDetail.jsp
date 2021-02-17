<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
	$(function() {
		$(".menu").children().removeClass('active');
		$("#shop").addClass('active'); //메뉴 색 
		
		$("#addCart").on('click', function() {
			var q = $("#quantity").val();
			var id = "${sessionScope.member.mem_id}";
			var no = $(this).next().next().text();

 			var answer = confirm("카트에 담으시겠습니까?");
			if(answer) {
				if ( id == null || id == '') {
					alert("로그인 후에 이용할 수 있습니다.");
				} else {
					 $.ajax({
						  url: '${pageContext.request.contextPath}/addCart/' + no + '/'+ q +'/' + id ,
						  success: function(data) {
							  if (data) {
								  alert("카트에 담겼습니다.");
								  var cart = confirm("카트로 이동하시겠습니까?");
								  if(cart) {
									  $(location).attr('href','${pageContext.request.contextPath}/cartMain');
								  } 
							  } else {
								  alert("동일한 상품이 이미 담겨있습니다.");
							  }
						}
					});
				}
			} 
			
		});
	});
</script>


<section>
<!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>Product detail</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <a href="${pageContext.request.contextPath}/shopMain">Shop</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="product__details__img">
                    <c:set var="img" value="${fn:split(item.pic,',')}"></c:set>
                    <c:forEach var="i" items="${img}" begin="0" end="0">
   						 <div class="product__details__big__img">
                            <img class="big_img" src="${pageContext.request.contextPath}/images/item/${i}" alt="">
                        </div>
					</c:forEach>
					<div class="product__details__thumb">
	                    <c:forEach var="i" items="${img}"  >
                            <div class="pt__item active">
                                <img data-imgbigurl="${pageContext.request.contextPath}/images/item/${i}"
                                src="${pageContext.request.contextPath}/images/item/${i}" alt="">
                            </div>
	                    </c:forEach>
                    </div>
 
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product__details__text">
                        <div class="product__label">${item.nic_name}</div>
                        <h4>${item.title}</h4>
                        <h5>${item.price} 원</h5>
                        <p>${item.content}</p>
                        <ul>
                            <li>SKU: <span>${item.stock}</span></li>
                            <li>Category: <span>${item.type}</span></li>
                        </ul>
                        <div class="product__details__option">
                            <div class="quantity">
                                <div class="pro-qty">
                                    <input type="text" value="1" id="quantity">
                                </div>
                            </div>
                            <a href="#" id="addCart" class="primary-btn">Add to cart</a>
                            <a href="#" class="heart__btn"><span class="icon_heart_alt"></span></a>
                            <a style="display: none;">${item.item_no}</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product__details__tab">
                <div class="col-lg-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">상품소개</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">후기글</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">문의글</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabs-1" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                	<%-- <c:set var="content" value="${fn:split(item.content_d,'/')}"></c:set>
                                	<c:forEach var="c" items="${content}">
										<p>${c}</p>
		                        	</c:forEach> --%>
		                        	${item.content_d}
                                   
                                </div>
                                <c:forEach  items="${picD}" var="pic" >
                                	 <img src="${pageContext.request.contextPath}/images/item/${pic}" alt="">
                                </c:forEach>
                            </div>
                        </div>
                        <div class="tab-pane" id="tabs-2" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                	<p>텝으로 나눠서 포토리뷰만 보기 / 전체보기 </p>
                                	<p>포토리뷰만 보기 -> 사진만 뜨고 사진 클릭시 내용 뜸</p>
                                	<p>전체보기 -> 제목 / 별점  / 해시태그..?</p>
                                    <c:forEach var="review" items="${reviewList}">
                                    	<p>${review.title} , ${review.star} </p>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tabs-3" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <p> 문의글 최신순 5~10개</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Details Section End -->

    <!-- Related Products Section Begin -->
    <!-- 해당 물품 올린 판매자의 품목만 보이도록 왜 4개가 보일까-->
    <section class="related-products spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="section-title">
                        <h2>Related Products</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="related__products__slider owl-carousel">
                <c:forEach  items="${sellerList}" var="s" >
                    <div class="col-lg-3">
                        <div class="product__item">
                        <c:set var="type" value="${s.type}"></c:set>
                    	<c:set var="img" value="${fn:split(s.pic,',')}"></c:set>
                    	<c:forEach var="i" items="${img}" begin="0" end="0">
                            <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath}/images/item/${i}">
                                <div class="product__label">
                                    <span>${type}</span>
                                </div>
                            </div>
                        </c:forEach>
                            <div class="product__item__text">
                                <h6><a href="${pageContext.request.contextPath}/shopDetail?no=${s.item_no}">${s.title}</a></h6>
                                <div class="product__item__price">${s.price} 원</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
				
                </div>
            </div>
        </div>
    </section>
    
    
    
</section>
    <!-- Related Products Section End -->