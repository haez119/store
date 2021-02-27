<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function() {

		$(".menu").children().removeClass('active');
		$("#myPage").addClass('active'); //메뉴 색 
		
		$(".addCart").on('click', function() {
			var answer = confirm("카트에 담으시겠습니까?");
			if(answer) {
				var id = "${sessionScope.member.mem_id}";
				var no = $(this).next().text();
				var stock = $(this).parent().prev().text();
				if(stock > 0) {
					$.ajax({
						  url: '${pageContext.request.contextPath}/addCart/' + no + '/1/' + id ,
						  success: function(data) {
							  if (data) {
								  alert("카트에 담겼습니다.");
							  } else {
								  alert("동일한 상품이 이미 담겨있습니다.");
							  }
						}
					});
				} else {
					alert("품절된 상품입니다.");
				}				
					 
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
                        <h2>Wish</h2>
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
            <c:if test="${fn:length(wishList) eq 0}">
            	<h4 style="padding: 100px 0px 0px 500px;">찜한 상품이 없습니다.</h4>
            </c:if>
            <c:forEach  items="${wishList}" var="item" >
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="product__item">
                    <c:set var="type" value="${item.type}"></c:set>
                    <c:set var="img" value="${fn:split(item.pic,',')}"></c:set>
                    <c:forEach var="i" items="${img}" begin="0" end="0">
   						 <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath}/images/item/${i}">
                            <div class="product__label">
                                <span>${type}</span>
                            </div>
                        </div>
					</c:forEach>
                        <div class="product__item__text">
                            <h6>
                            	<a href="${pageContext.request.contextPath}/shopDetail?no=${item.item_no}" class="title">${item.title}</a>
                            </h6>
                            
                            <c:if test="${item.stock ne 0}">
                            	<div class="product__item__price">${item.price} 원 </div>
                            	<div style="display: none;">${item.stock}</div>
                            </c:if>
                            <c:if test="${item.stock eq 0}">
                            	<div class="product__item__price" style="color: red;">품 절 </div>
                            	<div style="display: none;">${item.stock}</div>
                            </c:if>
                            
                            <div class="cart_add">
                                <a class="addCart" href="#">Add to cart</a>
                                <a class="addNo" style="display: none;">${item.item_no}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach > 
           </div>
            
            
        </div>
    </section>
    <!-- Shop Section End -->
 </section>