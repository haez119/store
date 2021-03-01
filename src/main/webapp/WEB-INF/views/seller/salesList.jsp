<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(function() {
	
	$(".side-nav-menu-item").removeClass('active');
	$("#sales").addClass('active'); //메뉴 색 

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


				<!-- <div style="padding: 20px 0px 20px 0px;">
					<input type="date" id="searchTime">
					<input type="button" value="검색" style="margin-left: 10px;" id="btnSearch">
				</div> -->
                <div class="table-responsive-xl" style="padding-left: 30px;">
                    <table class="table text-nowrap mb-0" style="min-height: 200px;">
                        <thead>
                        <tr>
                            <th style="width: 15%">주문 일</th>
                            <th style="width: 15%">주문 건 수</th>
                            <th style="width: 70%">매출 액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${salesList}">
                        <tr>
                        	<c:if test="${item.PAY_TIME ne '#'}">
                        		<td>${item.PAY_TIME}</td>
                        	</c:if>
                            <c:if test="${item.PAY_TIME ne '#'}">
                        		<td>${item.CNT} 건</td>
                        	</c:if>
                        	<c:if test="${item.PAY_TIME ne '#'}">
                        		<td>${item.SUM} 원</td>
                        	</c:if>
                        	<c:if test="${item.PAY_TIME eq '#'}">
                        		<td style="color: red;"><b>Total</b></td>
                        		<td><b>${item.CNT} 건</b></td>
                        		<td><b>${item.SUM} 원</b></td>
                        	</c:if>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                	
                    <div class="card-footer d-block d-md-flex align-items-center d-print-none">
                        <nav class="d-flex ml-md-auto d-print-none" aria-label="Pagination"><ul class="pagination justify-content-end font-weight-semi-bold mb-0">				<li class="page-item">				<a id="datatablePaginationPrev" class="page-link" href="#!" aria-label="Previous"><i class="gd-angle-left icon-text icon-text-xs d-inline-block"></i></a>				</li><li class="page-item d-none d-md-block"><a id="datatablePaginationPage0" class="page-link active" href="#!" data-dt-page-to="0">1</a></li><li class="page-item d-none d-md-block"><a id="datatablePagination1" class="page-link" href="#!" data-dt-page-to="1">2</a></li><li class="page-item d-none d-md-block"><a id="datatablePagination2" class="page-link" href="#!" data-dt-page-to="2">3</a></li><li class="page-item">				<a id="datatablePaginationNext" class="page-link" href="#!" aria-label="Next"><i class="gd-angle-right icon-text icon-text-xs d-inline-block"></i></a>				</li>				</ul></nav>
                    </div>
                </div>
                <!-- End Users -->
            </div>
        </div>
    </div>
</div>