<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
 
<script>
$(function() {
	$("#today").text(getToday());
	
	var today = ${today};
	if(today == null || today == '') {
		$("#todaySales").text("0");	
	} else {
		$("#todaySales").text(today[0].SUM);
		$("#todayIcon").append('<i class="gd-arrow-up icon-text d-flex text-danger ml-auto"></i>');
		$("#totalIcon").append('<i class="gd-arrow-up icon-text d-flex text-danger ml-auto"></i>');
	}

	
});

function getToday(){
	    var now = new Date();
	    var year = now.getFullYear();
	    var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
	    var date = now.getDate();

	    month = month >=10 ? month : "0" + month;
	    date  = date  >= 10 ? date : "0" + date;
	    return today = ""+year + "-" + month + "-" + date; 
	}

</script>  
    
 <div class="content">
 		<div class="py-4 px-3 px-md-4">

            <div class="mb-3 mb-md-4 d-flex justify-content-between">
                <div class="h3 mb-0">Dashboard</div>
            </div>

            <div class="row">

                <div class="col-md-6 col-xl-6 mb-6 mb-xl-6">
                    <div class="card flex-row align-items-center p-3 p-md-4" id="totalIcon">
                        <div class="icon icon-lg bg-soft-warning rounded-circle mr-3">
                            <a href="${pageContext.request.contextPath}/seller/salesList"><i class="gd-money icon-text d-inline-block text-warning"></i></a>
                        </div>
                        <div>
                            <h4 class="lh-1 mb-1" > 
                            	<fmt:formatNumber type="number" value="${total}" pattern="##,###" /> 원 
                            </h4>
                            <h6 class="mb-0">Total Sales</h6>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-xl-6 mb-6 mb-xl-6">
                    <div class="card flex-row align-items-center p-3 p-md-4" id="todayIcon">
                         <div class="icon icon-lg bg-soft-secondary rounded-circle mr-3">
                            <i class="gd-money icon-text d-inline-block text-secondary"></i>
                        </div>
                        <div>
                            <h4 class="lh-1 mb-1" id="todaySales"> 
                            	
                            </h4>
                            <h6 class="mb-0">Today Sales</h6>
                        </div>
                        
                    </div>
				</div>

            </div>

			<!-- 주문 목록 -->
            <div class="row">
                <div class="col-12">
                    <div class="card mb-3 mb-md-4" style="min-height: 200px;">
                        <div class="card-header">
                            <span style="float: left;"><h5 class="font-weight-semi-bold mb-0">Recent Orders</h5></span>
                            <span style="float: right;"><b class="text-muted ml-auto" id="today"></b></span>
                        </div>

                        <div class="card-body pt-0">
                            <div class="table-responsive-xl">
                                <table class="table text-nowrap mb-0" >
                                    <thead>
                                    <tr>
                                        <th class="font-weight-semi-bold border-top-0 py-2">#</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">주문일</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">분류</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">상품명</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">개수</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">결제금액</th>
                                    </tr>
                                    </thead>
                                    <tbody >
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
				                        </tr>
				                     </c:forEach>
                                    </tbody>
                                </table>
                                 <c:if test="${fn:length(orderList) eq 0}">
                                	<div align="center" style="padding: 50px 0px 20px 0px;"><h4>주문 내역이 없습니다.</h4></div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
 
 
 
 </div>