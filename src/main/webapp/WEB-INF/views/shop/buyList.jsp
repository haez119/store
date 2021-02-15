<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>

</style>

<script>
	$(function() {
		
		$(".menu").children().removeClass('active');
		$("#order").addClass('active'); //메뉴 색 
		
		$(".pay_time").on('click', function() {
			var t = $(this).parent().next().children().children(".buy_no").text();
			//.children(".buy_no");
			console.log(t)
		});
		
		
		
	});
	
	
</script>
    
<!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>Order List</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <span>Order List</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->
	<hr>
    <!-- Wishlist Section Begin -->
    <section class="wishlist spad" style="padding-top: 0px;">
        <div class="container" >
            <div class="row">
                <div class="col-lg-12">
                    <div class="wishlist__cart__table" style="min-height: 200px;">
                    <c:if test="${fn:length(buyList) eq 0}">
                  		<h4 align="center" style="padding-top: 100px;">주문하신 상품이 없습니다.</h4>
                     </c:if>
                    <c:forEach var="buyer" items="${buyList}">
                        <table>
                            <tbody>
                                <tr>
                                    <td class="product__cart__item" style="padding-top: 0px;">
                                       <div class="product__cart__item__pic" >
                                           <div style="padding-top: 80%" align="center" class="pay_time">
	                                           ${fn:substring(buyer.PAY_TIME,0,10) } <br>
	                                           ${fn:substring(buyer.PAY_TIME,11,19) } <br>
                                           </div>
                                       </div>
                                       <div class="product__cart__item__text">
                                       	   <h6 style="color: #fd7e14;">주문번호 &nbsp; &nbsp; &nbsp;<span class="buy_no">${buyer.BUY_NO}</span></h6>
                                           <h6>결제금액 &nbsp; &nbsp; &nbsp;<span>${buyer.PAYMENT} 원</span></h6>
                                           <h6>수  &nbsp;령  &nbsp;인 &nbsp; &nbsp; <span>${buyer.NAME} </span></h6>
                                           <h6>연  &nbsp;락  &nbsp;처 &nbsp; &nbsp; <span>${buyer.PHONE} </span></h6>
                                           <h6>주  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;소 &nbsp; &nbsp;<span>(${buyer.ADDR_NO}) &nbsp; ${buyer.ADDR}</span></h6>
                                       </div>
                                    </td>
                                    <td class="cart__btn">
                                    	<a href="#" class="primary-btn"  data-no="${buyer.BUY_NO}" data-toggle="modal" data-target="#exampleModal" >상세보기</a>
                                    	<!-- <a href="#" class="primary-btn" >후기 작성</a> 상세보기 모달에 넣어야지-->
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <hr style="padding-bottom: 50px;">
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 모달창 -->
			<div class="row">
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" ">
				   <div class="modal-dialog" role="document">
				      <div class="modal-content">
				         <div class="modal-header">
				            <h5 class="modal-title" id="exampleModalLabel" style="text-align: center;"></h5>
				         </div>
				         <div class="modal-body" style="height: 430px;">
				            <div class="form-group">
				               
				               
							<table class="tblmodal">
								<thead>
									<tr>
										<th style="width: 168px; text-align: center;">주문번호</th>
										<th style="width: 800px;" class="gb_no" colspan="5"></th>
									</tr>
								</thead>
								
								<tbody class="modalbody">
									<tr>
										<td rowspan="2" style="text-align: center; border-bottom: 3px solid #ebebeb; border-right: 1px solid #ebebeb;">
											사진
										</td>
										<td style="letter-spacing: 7px;"><b>상품명</b></td>
										<td colspan="3">${gbuy.go_name}</td>
										<td rowspan="2" style="width: 168px; text-align: center; border-bottom: 3px solid #ebebeb; border-left: 1px solid #ebebeb;">
											<button type="button" class="btn primary-btn">재구매</button>
										</td>
									</tr>
									<tr>
										<td style="border-bottom: 3px solid #ebebeb;"><b>구매수량</b></td>
										<td style="border-bottom: 3px solid #ebebeb;">${gbuy.cart_qty} 개</td>
										<td style="border-bottom: 3px solid #ebebeb;"><b>구매금액</b></td>
										<td style="border-bottom: 3px solid #ebebeb;">${gbuy.go_price} 원</td>
									</tr>
								</tbody>

								<tfoot>
									<tr>
										<td colspan="4"></td>
										<td><b>결제 합계 금액</b></td>
										<td class="pay" style="text-align: right;"></td>
									</tr>
								</tfoot>
							</table>
							           
				               
				               
				            </div>
				         </div>
				         <div class="modal-footer">
				            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				         </div>
				      </div>
				   </div>
				</div>
			</div>
        
        
    </section>
    <!-- Wishlist Section End -->