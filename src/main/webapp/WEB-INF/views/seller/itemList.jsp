<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>

<style>

.pagination li {
	display: inline-block; 
}
.pagination {
  display: inline-block;
}

.pagination a {
    min-width: 2.81rem;
    text-align: center;
    border-radius: .125rem;
    transition: all .15s linear;
    position: relative;
    display: block;
    padding: .63rem .5rem;
    margin-left: 6px;
    line-height: 1.25;
    background-color: #fff;
    border: 1px solid #265df1;
}

.pagination a.active {
    background-color: #265df1;
    color: #fff;
    border-color: #265df1;
}

.pagination a:hover:not(.active) {
	text-decoration: none;
}
</style>

<script>
$(function() {
	$(".side-nav-menu-item").removeClass('active');
	$("#itemMenu").removeClass("side-nav-menu-item side-nav-has-menu");
	$("#itemMenu").addClass("side-nav-menu-item side-nav-has-menu side-nav-opened");
	$("#subUsers").css("display", 'block');
	$("#itemLi").addClass('active');
	
	$(".upset").on('click', function() {
		var item_no = $(this).parent().parent().parent().children().eq(0).children().eq(1).text();
		$(location).attr('href','${pageContext.request.contextPath}/seller/itemInsertForm?item_no=' + item_no);
	});
	
/* 	$(".goShop").on('click', function() {
		var item_no = $(this).parent().parent().parent().parent().children().children().next().text();
		window.open("${pageContext.request.contextPath}/shopDetail?no=" + item_no);
		//$(location).attr('href','${pageContext.request.contextPath}/shopDetail?no=' + item_no);
		
	}) */
	
});

</script>

<div class="content">
        <div class="py-4 px-3 px-md-4">
            <div class="card mb-3 mb-md-4">

                <div class="card-body">
                    <nav class="d-none d-md-block" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="#">Item</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Item List</li>
                        </ol>
                    </nav>
                    <!-- End Breadcrumb -->

                    <div class="mb-3 mb-md-4 d-flex justify-content-between">
                        <span class="h3 mb-0" style="float: left;">Items</span>
                        <span class="h3 mb-0" style="float: right;">
							<button type="button" class="btn btn-primary float-right" onClick="location.href='${pageContext.request.contextPath}/seller/itemInsertForm'">등록</button>
                        </span>
                    </div>


                    <!-- Users -->
                    <div class="table-responsive-xl">
                        <table class="table text-nowrap mb-0">
                            <thead>
                            <tr>
                                <th class="font-weight-semi-bold border-top-0 py-2">#</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">분류</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">상품명</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">등록일</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">가격</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">재고</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">리뷰</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${itemList}">
                            <tr>
                                <td class="py-3">
                                	<div>${item.no}</div>
                                	<div style="display: none;">${item.item_no}</div>
                                </td>
                                <td class="py-3">${item.type}</td>
                                <td class="align-middle py-3">
                                    <div class="d-flex align-items-center">
                                        <div class="position-relative mr-2">
                                           	<a href="${pageContext.request.contextPath}/shopDetail?no=${item.item_no}" target="_blank">
                                           		<img class="avatar rounded-circle" src="${pageContext.request.contextPath}/images/item/${item.pic}" />
                                           	</a>
                                        </div>
                                        ${item.title}
                                    </div>
                                </td>
                                <td class="py-3">${item.add_time}</td>
                                <td class="py-3">${item.price}</td>
                                <td class="py-3">${item.stock} 개</td>
                                <td class="py-3">
                                	<c:if test="${item.cnt ne 0}">
                                		<a href="${pageContext.request.contextPath}/seller/reviewList?item_no=${item.item_no}">${item.cnt} 건</a>
                                	</c:if>
                                	<c:if test="${item.cnt eq 0}">
                                		${item.cnt} 건
                                	</c:if>
                                </td>
                                <td class="py-3">
                                    <div class="position-relative">
                                    	<span class="upset">
	                                        <a class="link-dark d-inline-block" href="#" ><i class="gd-pencil icon-text"></i></a>
	                                    </span>
	                                    <span class="del">
	                                        <a class="link-dark d-inline-block" href="#"><i class="gd-trash icon-text"></i></a>
	                                    </span>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                            
                            </tbody>
                        </table>
                        <div class="card-footer d-block d-md-flex align-items-center d-print-none">

                         <nav class="d-flex ml-md-auto d-print-none" aria-label="Pagination">
	                          <ul class="pagination justify-content-end font-weight-semi-bold mb-0">				
		                          <li class="page-item">				
		                          	<script>
										function goPage(p) {
											location.href="itemList?p="+p
										}
									</script>
									<my:paging paging="${paging}" jsfunc="goPage" /> 				
		                          </li>
	                          </ul>
                         </nav>
                        </div>
                    </div>
                    <!-- End Users -->
                </div>
            </div>
        </div>
    </div>