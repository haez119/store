<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>  


<style>
.pagination li {
	display: inline-block;
}

.pagination {
	display: inline-block;
}

.pagination a {
	color: #f08632;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #f08632;
	margin: 0 4px;
	border-radius: 70%;
}

.pagination a.active {
	background-color: #f08632 ;
	color: white;
	border: 1px solid #f08632 ;
}


</style>
<script>
	$(function() {
		$(".menu").children().removeClass('active');
		$("#shop").addClass('active'); //메뉴 색 
		
		var orderby = "${orderby}";
		var type = "${type}";

 		if(type != null && type != '') { $(".current").eq(0).text(type); }
		if(orderby == 'WISH') { $(".current").eq(1).text("인기순"); } 
		
		
		// 카테고리별 필터링
		$("#type").change(function() {
			var type = $("#type :selected").val();
			$(location).attr('href','${pageContext.request.contextPath}/shopMain?type=' + type);
		}); 
		$("#orderby").change(function() {  //이거 인기순 말고 평점순으로 해야겟당
			var orderby = $("#orderby :selected").val();
			$(location).attr('href','${pageContext.request.contextPath}/shopMain?orderby=' + orderby);
		});
		
		
		$(".addCart").on('click', function() {
			var id = "${sessionScope.member.mem_id}";
			var answer = confirm("카트에 담으시겠습니까?");
			if(answer) {
				if ( id == null || id == '') {
					alert("로그인 후에 이용할 수 있습니다.");
				} else {
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
			}
			
		});
		
	});
</script>




<section>
<!-- Breadcrumb Begin -->
    <div class="breadcrumb-option" > 
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>Shop</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div class="container" >
            <div class="shop__option" >
                <div class="row">
                
                    <div class="col-lg-12 col-md-12">
                        <!-- <div class="shop__option__search" > -->
                            <%-- <form action="${pageContext.request.contextPath}/shopMain"> --%>
                            <span style="float: left;"> 
                                <select id="type" name="type">
                                	<option value="">ALL</option>
                                    <option value="TOP">TOP</option>
                                    <option value="BOTTOM">BOTTOM</option>
                                    <option value="SHOES">SHOES</option>
                                    <option value="BAG">BAG</option>
                                    <option value="ETC">ETC</option>
                                </select>
                             </span>
                               <!--  <input type="text" placeholder="Search" name="keyword" id="keyword">
                                <button type="submit"><i class="fa fa-search"></i></button>
                            </form>
                        </div> -->
                        
                        <span style="float: right;">
		                   	<select id="orderby" name="orderby">
	                        	<option value="NEW" >최신순</option>
	                            <option value="WISH">인기순</option>
	                        </select>
                    	</span>
                    </div>
                    
                </div>
            </div>
            <div class="row" style="min-height: 300px;">
            <c:if test="${fn:length(itemList) eq 0}">
            	<h4 style="padding: 100px 0px 0px 500px;">상품이 없습니다.</h4>
            </c:if>
            <c:forEach  items="${itemList}" var="item" >
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
            
            <div class="shop__last__option">
                <div align="center">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="pagination" align="center">
							<script>
								function goPage(p) {
									location.href="shopMain?p="+p
								}
							</script>
							
							<my:paging paging="${paging}" jsfunc="goPage" /> 
						</div>
                    </div>
                </div>
            </div>
            
        </div>
    </section>
    <!-- Shop Section End -->
 </section>