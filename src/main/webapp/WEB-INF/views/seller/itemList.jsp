<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
                                <td class="py-3">${item.no}</td>
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
                           <!--  <div class="d-flex mb-2 mb-md-0">Showing 1 to 8 of 24 Entries</div> -->

                            <nav class="d-flex ml-md-auto d-print-none" aria-label="Pagination"><ul class="pagination justify-content-end font-weight-semi-bold mb-0">				<li class="page-item">				<a id="datatablePaginationPrev" class="page-link" href="#!" aria-label="Previous"><i class="gd-angle-left icon-text icon-text-xs d-inline-block"></i></a>				</li><li class="page-item d-none d-md-block"><a id="datatablePaginationPage0" class="page-link active" href="#!" data-dt-page-to="0">1</a></li><li class="page-item d-none d-md-block"><a id="datatablePagination1" class="page-link" href="#!" data-dt-page-to="1">2</a></li><li class="page-item d-none d-md-block"><a id="datatablePagination2" class="page-link" href="#!" data-dt-page-to="2">3</a></li><li class="page-item">				<a id="datatablePaginationNext" class="page-link" href="#!" aria-label="Next"><i class="gd-angle-right icon-text icon-text-xs d-inline-block"></i></a>				</li>				</ul></nav>
                        </div>
                    </div>
                    <!-- End Users -->
                </div>
            </div>
        </div>
    </div>