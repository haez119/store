<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
 <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<style>
	z {
		color: red;
	}
</style>

<script>

function openDaumZipAddress(addr_no, addr) {
    new daum.Postcode({
       oncomplete:function(data) {
          $(addr_no).val(data.zonecode); 
          $(addr).val(data.address); // 주소
       }
    }).open();
 }
 
 
$(function() {
	$(".menu").children().removeClass('active');
	$("#order").addClass('active'); //메뉴 색 
	
	$("#orderCheck").on('click', function() {
		
		if( $('input:checkbox[name=orderCheck]').is(":checked") ) {
			$("#name").val( $("#m_name").val() );
			$("#phone").val( $("#m_phone").val() );
			$("#addr_no").val( $("#m_addr_no").val() );
			$("#addr").val( $("#m_addr").val() );
			$("#addr_d").val( $("#m_addr_d").val() );
			$("#m_name").attr('disabled', true);
			$("#m_phone").attr('disabled', true);
			$("#m_addr_no").attr('disabled', true);
			$("#m_addr").attr('disabled', true);
			$("#m_addr_d").attr('disabled', true);

		} else {
			$("#name").val("");
			$("#phone").val("");
			$("#addr_no").val("");
			$("#addr").val("");
			$("#addr_d").val("");
			$("#m_name").attr('disabled', false);
			$("#m_phone").attr('disabled', false);
			$("#m_addr_no").attr('disabled', false);
			$("#m_addr").attr('disabled', false);
			$("#m_addr_d").attr('disabled', false);
		}
	});
	
	//우편번호 검색
	$(".btnAddrNo1").on('click', function() {
		openDaumZipAddress($("#m_addr_no"), $("#m_addr"));
	});
	$(".btnAddrNo2").on('click', function() {
		openDaumZipAddress($("#addr_no"), $("#addr"));
	});
	
	
});
</script>

   <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>Order</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <span>Order</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <form action="#">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                           
                            <h6 class="checkout__title">기본 정보</h6>
                            <div class="checkout__input">
                                <p>이름<span>*</span></p>
                                <input type="text" value="${sessionScope.member.name}" id="m_name" >
                            </div>
                            <div class="checkout__input">
                                <p>전화번호<span>*</span></p>
                                <input type="text" value="${sessionScope.member.phone}" id="m_phone">
                            </div>
                            <div class="row">
                                <div class="col-lg-9">
                                    <div class="checkout__input">
                                        <p>우편번호<span>*</span></p>
                                        <input class="addr_no" type="text" readonly="readonly" value="${sessionScope.member.addr_no}" id="m_addr_no">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="checkout__input">
                                        <p><span> &nbsp; &nbsp;</span></p>
                                        <input type="button" value="검색" class="btnAddrNo1">
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>주소<span>*</span></p>
                                <input class="addr" type="text" readonly="readonly" value="${sessionScope.member.addr}" id="m_addr">
                            </div>
                            <div class="checkout__input">
                                <p>상세주소<span>*</span></p>
                                <input type="text" value="${sessionScope.member.addr_d}" id="m_addr_d">
                            </div>
						
						
						<div class="checkout__input__checkbox" style="padding-top: 50px;">
                            <label for="orderCheck">
                                	기본 정보와 일치
                                <input type="checkbox" id="orderCheck" name="orderCheck">
                                <span class="checkmark"></span>
                            </label>
                        </div>
                        
                        <!-- 주문자 정보 -->
						<h6 class="checkout__title" style="padding-top: 50px;">주문 정보</h6>
                            <div class="checkout__input">
                                <p>이름<span>*</span></p>
                                <input type="text" id="name" name="name">
                            </div>
                            <div class="checkout__input">
                                <p>전화번호<span>*</span></p>
                                <input type="text" id="phone" name="phone" >
                            </div>
                            <div class="row">
                                <div class="col-lg-9">
                                    <div class="checkout__input">
                                        <p>우편번호<span>*</span></p>
                                        <input type="text" readonly="readonly" id="addr_no" name="addr_no" >
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="checkout__input">
                                        <p><span> &nbsp; &nbsp;</span></p>
                                        <input type="button" value="검색" class="btnAddrNo2">
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>주소<span>*</span></p>
                                <input type="text" readonly="readonly" id="addr" name="addr" >
                            </div>
                            <div class="checkout__input">
                                <p>상세주소<span>*</span></p>
                                <input type="text" id="addr_d" name="addr_d" >
                            </div>
                            
                        </div> <!-- 정보창 끝 -->
                        <!-- 오른쪽 메뉴 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h6 class="order__title">Your order</h6>
                                <div class="checkout__order__products">Product <span>Total</span></div>
                                <ul class="checkout__total__products">
                                <c:forEach var="cart" items="${orderList}" >
                                    <li>${cart.title} &nbsp; <samp> &nbsp; ${cart.quantity} 개</samp> <span>${cart.total} 원</span></li>
								</c:forEach>
                                </ul>
                                <ul class="checkout__total__all">
                                	<c:set var = "sum" value = "0" />
		                        	<c:forEach var="cart" items="${orderList}" >
		                        		<c:set var= "sum" value="${sum + cart.total}"/>
		                        	</c:forEach>
		                            <li>Total <span>${sum} 원</span></li>
                                </ul>
                                <div class="checkout__input__checkbox">
                                    <label for="acc-or">
                                       	 아래 약관을 확인하였으며 결제에 동의합니다. 
                                        <input type="checkbox" id="acc-or">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <p>주문 상품의 상품명, 수량, 가격, 포인트 사용, 배송 정보를 확인하였으며, 구매 진행에 동의합니다.</p>
  
                                <button type="submit" class="site-btn">PLACE ORDER</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->