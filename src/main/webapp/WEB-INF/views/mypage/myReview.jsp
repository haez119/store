<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.starR{
	  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	  background-size: auto 100%;
	  width: 15px;
	  height: 15px;
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
		$("#myPage").addClass('active'); //메뉴 색 
		
		var review_no;
		
 		var star = ${starList}
		
		for(var i=0; i < star.length; i++) {
			var re_star = star[i].STAR;
			$("#"+star[i].REVIEW_NO).children('span').removeClass('on'); //별 지우고
			$("#"+star[i].REVIEW_NO).children('span').eq(re_star-1).addClass('on').prevAll('span').addClass('on');
		} 
		
		$(".btnModal").on('click', function() {
			
			var modal = $("#reviewDetail");
			review_no = $(this).next().text();
			$.ajax({
				  url: '${pageContext.request.contextPath}/myReview_d?review_no=' + review_no ,
				  success: function(data) {
					$(".tag-item").remove();
					
					modal.find('#insert_date').text(data.insert_date);
					modal.find('#title').text(data.title);
					modal.find('#content').html(data.content);

					var tag = data.tag;
					
					if(tag != null && tag != '') {
						tag = tag.split(",");
						
						for(var j=0; j < tag.length; j++) { // 태그 달아주고
							$("#tag-list").append("<li class='tag-item'>"+tag[j]+"<span class='del-btn' idx='"+j+"'></span><span style='display: none;'>"+ tag[j] +"</span></li>");
						}
					}
					modal.modal('show');
					
					$("#btnUpdate").on('click', function() {
						$(location).attr('href','${pageContext.request.contextPath}/reviewInsertForm/'+data.item_no+'/'+data.buyd_no+'?update=true');
					});
				  },
		  });

		});
		
		$("#btnDel").on('click', function() {
			var del = confirm("삭제 하시겠습니까??");
			if(del) {
				$.ajax({
					  url: '${pageContext.request.contextPath}/myReviewDel?review_no=' + review_no ,
					  success: function() {
						alert("삭제 되었습니다.");
						$(location).attr('href','${pageContext.request.contextPath}/myReviewList');
					  },
			  });
			} 
		});
		
	});
	
</script>
	
    
<section>
    <div class="breadcrumb-option" > 
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>My Review</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <span>My Page</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div class="container" >

            <div class="row" style="min-height: 300px;">
            <c:if test="${fn:length(myReviewList) eq 0}">
            	<h4 style="padding: 100px 0px 0px 500px;">등록한 리뷰가 없습니다.</h4>
            </c:if>
            <c:forEach  items="${myReviewList}" var="item" >
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="product__item">
                    <c:set var="type" value="${item.TYPE}"></c:set>
                    <c:set var="img" value="${fn:split(item.PIC,',')}"></c:set>
                    <c:forEach var="i" items="${img}" begin="0" end="0">
   						 <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath}/images/item/${i}">
                            <div class="product__label">
                                <span>${type}</span>
                            </div>
                        </div>
					</c:forEach>
                        <div class="product__item__text">
                            <h6>
                            	<a href="${pageContext.request.contextPath}/shopDetail?no=${item.ITEM_NO}" class="title">${item.ITEM_TITLE}</a>
                            </h6>
                            <div class="product__item__price">${item.PRICE} 원 </div>
                            <div class="cart_add">
                                <a class="btnModal" >리뷰 확인</a>
                                <a class="addNo" style="display: none;">${item.REVIEW_NO}</a>
                            </div>
                        </div>
                        <div style="padding-top: 30px;" align="center">
                           	<div class="starRev" id="${item.REVIEW_NO}">
							  <span class="starR 1">1</span>
							  <span class="starR 2">2</span>
							  <span class="starR 3">3</span>
							  <span class="starR 4">4</span>
							  <span class="starR 5">5</span>
							  <input id="star" name="star" value="5" style="display: none;"> 
							</div>
                       </div>
                    </div>
                </div>
            </c:forEach > 
           </div>
        </div>
    </section>
	
	
<div class="modal fade" id="reviewDetail" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="max-width: 100%; width: auto; display: table;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">리뷰 확인</h5>
      </div>
      <div class="modal-body">
		   <div>
		   		<span id="insert_date"></span>
		   </div>
		   <div>
		   		<hr>
		   		<h5 align="center"><b id="title"></b></h5>
		   		<hr>
		   		<div align="center" id="content" style="width: 450px; height: auto; min-height: 250px;"></div>
		   		<div align="center"><ul id="tag-list" class="tag-list" style="padding-top: 10px;"></ul></div>
		   		
		   </div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary" id="btnUpdate">수정</button>
      	<button type="button" class="btn btn-secondary" id="btnDel">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div><!-- modal end -->
	
	
 </section>