<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
ul.rews {
	margin: 0px;
	padding: 50px 20px 20px 20px;
	list-style: none;

}

ul.rews li {
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 25px;
	cursor: pointer;
	
}

ul.rews li.current {
	background: #f08632;
	color: white;
}

.rew-content {
	display: none;
	padding: 15px 0;

}

.rew-content.current {
	display: inherit;
}

.starR{
	  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	  background-size: auto 100%;
	  width: 25px;
	  height: 25spx;
	  display: inline-block;
	  text-indent: -9999px;
	  cursor: pointer;
}
.starR.on{ 
	background-position:0 0;
}

ul li.tag-item {
    display: inline-block;
    margin: 0 5px;
    font-size: 14px;
    letter-spacing: -.5px;
    padding: 4px 8px;
    margin: 3px 3px;
    background-color: #f5f5f5;
    color: #000;
}
</style>


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
		
		$('ul.rews li').click(function() { // 포토리뷰/전체리뷰
			
			var tab_id = $(this).attr('data-tab');
			console.log(tab_id);
			$('ul.rews li').removeClass('current');
			$('.rew-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
			
		});
		
		var reviewList = ${reviewList};
		
		for(var i=0; i < reviewList.length; i++) {
			//포토리뷰 이미지만 찾기 
			var content = reviewList[i].content;
			var start = content.indexOf('src="'); // src=" s의 인덱스 번호 리턴
			
			var re_tag = reviewList[i].tag
			re_tag = re_tag.split(",");
			
			var re_star = parseInt(reviewList[i].star)
			
			// 사진이 있을 때
			if(start != -1) {
				
				$("#for-" + reviewList[i].review_no).css('display', ''); //포토 리뷰만 화면에 띄우기
				
				var end = content.indexOf('"', start + 5); // "를 찾음 start+5부터 
				var list = content.substring(start + 5, end);
				$("#imgDiv").append("<img src='" + list + "' style='width: 120px; height: 120px; margin: 20px;'>");
				
				// 별달기
				if(re_star != null && re_star != '' ) {
					$("#"+reviewList[i].buyd_no).children('span').removeClass('on'); //별 지우고
					$("#"+reviewList[i].buyd_no).children('span').eq(re_star-1).addClass('on').prevAll('span').addClass('on');
				}
				
				//태그 달기
				for(var j=0; j < re_tag.length; j++) { // 태그 달아주고
					$("#tag-list-" + reviewList[i].review_no ).append("<li class='tag-item'>"+re_tag[j]+"<span class='del-btn' idx='"+j+"'></span><span style='display: none;'>"+ re_tag[j] +"</span></li>");
				}
			} // if end
			
			//전체보기
			
			if(re_star != null && re_star != '' ) {
				$("#all-"+reviewList[i].buyd_no).children('span').removeClass('on'); //별 지우고
				$("#all-"+reviewList[i].buyd_no).children('span').eq(re_star-1).addClass('on').prevAll('span').addClass('on');
			}
			for(var j=0; j < re_tag.length; j++) { // 태그 달아주고
				$("#tag-all-" + reviewList[i].review_no ).append("<li class='tag-item'>"+re_tag[j]+"<span class='del-btn' idx='"+j+"'></span><span style='display: none;'>"+ re_tag[j] +"</span></li>");
			}

		}// for end
		
		
		// 해시태그 클릭
		$(".tag-item").on('click', function() {
			var tag = $(this).children().next().text();
			console.log(tag);
			
			// 태그로 검색할꺼야
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
                                <div style="text-align: center;">
                                
									<div align="center">
										<ul class="rews" >
											<li class="rew-link current" data-tab="photo" >포토 리뷰</li>
											<li class="rew-link" data-tab="all" >전체 리뷰</li>
										</ul>
									</div>
		
	                                <div id="photo" class="rew-content current" style="text-align: center;">
	                                	<div id="imgDiv"></div>
	                                	<div>
	                                		<c:forEach var="review" items="${reList}">
	                                		<div id="for-${review.review_no}" style="display: none;">
	                                			<hr>
	                                			<div align="center"> 
	                                				<span style="float: left">작성자 : ${review.mem_id}</span>
	                                				<span style="float: right;">등록일 : ${review.insert_date}</span>
	                                			</div><br>
	                                			
	                                			<div align="center" style="padding-top: 30px;">
		                                			<div align="right" class="starRev" style="padding-bottom: 40px;" id="${review.buyd_no}" >
														  <span class="starR on 1">&nbsp;</span>
														  <span class="starR on 2">&nbsp;</span>
														  <span class="starR on 3">&nbsp;</span>
														  <span class="starR on 4">&nbsp;</span>
														  <span class="starR on 5">&nbsp;</span>
													</div>
			                                    	<h5><b>${review.title}</b></h5>
			                                    	<div style="width: 70%; margin: 5px; font-size: 13px;">${review.content}</div>
			                                    	<ul id="tag-list-${review.review_no}" style="padding-top: 10px;"></ul>
		                                    	</div>
		                                    </div>
		                                    </c:forEach>
	                                	</div> 
	                                </div>
	                                
	                                <div id="all" class="rew-content" style="text-align: center;">
	                                
		                                <c:forEach var="review" items="${reList}">
		                               		<div>
		                               			<hr>
		                               			<div align="center"> 
		                               				<span style="float: left">작성자 : ${review.mem_id}</span>
		                               				<span style="float: right;">등록일 : ${review.insert_date}</span>
		                               			</div><br>
		                               			
		                               			<div align="center" style="padding-top: 30px;">
		                                			<div align="right" class="starRev" style="padding-bottom: 40px;" id="all-${review.buyd_no}" >
														  <span class="starR on 1">&nbsp;</span>
														  <span class="starR on 2">&nbsp;</span>
														  <span class="starR on 3">&nbsp;</span>
														  <span class="starR on 4">&nbsp;</span>
														  <span class="starR on 5">&nbsp;</span>
													</div>
			                                    	<h5><b>${review.title}</b></h5>
			                                    	<div style="width: 70%; margin: 5px; font-size: 13px;">${review.content}</div>
			                                    	<ul id="tag-all-${review.review_no}" style="padding-top: 10px;"></ul>
		                                    	</div>
		                                    </div>
	                                    </c:forEach>
	  
	                                </div>
  		
                                </div>
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