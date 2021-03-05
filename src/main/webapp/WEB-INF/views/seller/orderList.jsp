<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
	$("#order").addClass('active'); //메뉴 색 
	
	
	$("#btnSearch").on('click', function() {
		var pay_time = $("#searchTime").val();
		$(location).attr('href','${pageContext.request.contextPath}/seller/orderList?pay_time=' + pay_time);

	});
});


</script>

<div class="content">
    <div class="py-4 px-3 px-md-4">
        <div class="card mb-3 mb-md-4">

            <div class="card-body">
                <nav class="d-none d-md-block" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="#">Order</a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Order List</li>
                    </ol>
                </nav>
                <!-- End Breadcrumb -->

                <div class="mb-3 mb-md-4 d-flex justify-content-between">
                    <span class="h3 mb-0" style="float: left;">Order</span>
                    <span class="h3 mb-0" style="float: right;">
                    </span>
                </div>


				<div style="padding: 20px 0px 20px 0px;">
					<input type="date" id="searchTime">
					<input type="button" value="검색" style="margin-left: 10px;" id="btnSearch">
				</div>
                <div class="table-responsive-xl">
                    <table class="table text-nowrap mb-0" style="min-height: 200px;">
                        <thead>
                        <tr>
                            <th class="font-weight-semi-bold border-top-0 py-2">#</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">주문일</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">분류</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">상품명</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">개수</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">결제금액</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">주문자</th>
                            <th class="font-weight-semi-bold border-top-0 py-2">연락처</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${orderList}">
                        <tr>
                            <td class="py-3">
                            	<div>${item.NO}</div>
                            </td>
                            <td class="py-3">${item.PAY_TIME}</td>
                            <td class="py-3">${item.TYPE}</td>
                            <td class="py-3">${item.TITLE}</td>
                            <td class="py-3">${item.QUANTITY}</td>
                            <td><fmt:formatNumber type="number" value="${item.PAYMENT}" pattern="##,###" /></td>
                            <td class="py-3">${item.NAME}</td>
                            <td class="py-3">${item.PHONE}</td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                	<c:if test="${fn:length(orderList) eq 0}">
		        		<div align="center" style="padding: 70px 0px 100px 0px;"><h2>주문 정보가 없습니다.</h2></div>
		            </c:if>
                    <div class="card-footer d-block d-md-flex align-items-center d-print-none">
                        <nav class="d-flex ml-md-auto d-print-none" aria-label="Pagination">
	                          <ul class="pagination justify-content-end font-weight-semi-bold mb-0">				
		                          <li class="page-item">				
		                          	<script>
										function goPage(p) {
											location.href="orderList?p="+p
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