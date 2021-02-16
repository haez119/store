<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	$("#cart").addClass('active'); //메뉴 색 
	
	$("#orderCheck").on('click', function() {
		
		if( $('input:checkbox[name=orderCheck]').is(":checked") ) {
			$("#name").val( $("#m_name").val() );
			$("#phone").val( $("#m_phone").val() );
			$("#email").val( $("#m_email").val() );
			$("#addr_no").val( $("#m_addr_no").val() );
			$("#addr").val( $("#m_addr").val() );
			$("#addr_d").val( $("#m_addr_d").val() );

			$(".old").attr('disabled', true);

		} else {
			$(".new").val("");
			$(".old").attr('disabled', false);
		}
	});
	
	//우편번호 검색
	$(".btnAddrNo1").on('click', function() {
		openDaumZipAddress($("#m_addr_no"), $("#m_addr"));
	});
	$(".btnAddrNo2").on('click', function() {
		openDaumZipAddress($("#addr_no"), $("#addr"));
	});
	
	//결제하기 버튼
	$("#btnOrder").on('click', function() {
		
		var name = $("#name").val();
		var phone = $("#phone").val();
		var email = $("#email").val();
		var addr_no = $("#addr_no").val();
		var addr = $("#addr").val();
		var addr_d = $("#addr_d").val();
		var p = $("#sum").text().substring(0, $("#sum").text().length - 1 );
		
		if ( name == null || name == '') {
			alert("주문자 정보를 입력하세요");
			$("#name").focus();
		} else if( phone == null || phone == '' ) {
			alert("주문자 정보를 입력하세요");
			$("#phone").focus();
		} else if( email == null || email == '' ) {
			alert("주문자 정보를 입력하세요");
			$("#email").focus();
		} else if( addr_no == null || addr_no == '' ) {
			alert("주문자 정보를 입력하세요");
			$("#addr_no").focus();
		} else if( addr == null || addr == '' ) {
			alert("주문자 정보를 입력하세요");
			$("#addr").focus();
		} else if( addr_d == null || addr_d == '' ) {
			alert("주문자 정보를 입력하세요");
			$("#addr_d").focus();
		} else if ( !$("#acc-or").is(":checked")) {
			alert("약관을 확인해주세요.");
		} else {
			alert("결제가 진행됩니다.");
			var IMP = window.IMP; // 생략해도 괜찮습니다.
			IMP.init("imp87312437"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.

			// IMP.request_pay(param, callback) 호출
			  IMP.request_pay({ // param
			    pg: "html5_inicis", //html5_inicis >> KG이니시스?
			    pay_method: "card",
			    merchant_uid: 'merchant_' + new Date().getTime(),
			    name: "스토어팜",
			    amount: p,
			    buyer_email: email,
			    buyer_name: name,
			    buyer_tel: phone,
			    buyer_addr: addr + " " + addr_d,
			    buyer_postcode: addr_no
			  }, function (rsp) { // callback
			    if (rsp.success) {
			       alert("결제 성공");
			       
			       $.ajax({
						  url: '${pageContext.request.contextPath}/addOrder' ,
						  data : $("#frmOrder").serialize(), 
						  success: function(data) {
							 alert("주문내역 페이지로 이동합니다."); 
							 $(location).attr('href','${pageContext.request.contextPath}/buyList?buy_no=' + data);
						}
					}); 
			       
			    } else {
			        alert("결제 실패");
			        alert(rsp.error_msg)
			    }
			  }); // IMP 끝
		} // if 끝
});
	
	
}); // ready 끝
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
                <form id="frmOrder">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                           
                            <h6 class="checkout__title">기본 정보</h6>
                            <div class="checkout__input">
                                <p>이름<span>*</span></p>
                                <input type="text" value="${sessionScope.member.name}" id="m_name" class="old" >
                            </div>
                            <div class="checkout__input">
                                <p>전화번호<span>*</span></p>
                                <input type="text" value="${sessionScope.member.phone}" id="m_phone" class="old" placeholder="-없이 입력">
                            </div>
                            <div class="checkout__input">
                                <p>이메일<span>*</span></p>
                                <input type="text" value="${sessionScope.member.email}" id="m_email" class="old">
                            </div>
                            <div class="row">
                                <div class="col-lg-9">
                                    <div class="checkout__input">
                                        <p>우편번호<span>*</span></p>
                                        <input type="text" readonly="readonly" value="${sessionScope.member.addr_no}" id="m_addr_no" class="old">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="checkout__input">
                                        <p><span> &nbsp; &nbsp;</span></p>
                                        <input type="button" value="검색" class="btnAddrNo1" >
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>주소<span>*</span></p>
                                <input type="text" readonly="readonly" value="${sessionScope.member.addr}" id="m_addr" class="old">
                            </div>
                            <div class="checkout__input">
                                <p>상세주소<span>*</span></p>
                                <input type="text" value="${sessionScope.member.addr_d}" id="m_addr_d" class="old">
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
                                <input type="text" id="name" name="name" class="new">
                            </div>
                            <div class="checkout__input">
                                <p>전화번호<span>*</span></p>
                                <input type="text" id="phone" name="phone" class="new" placeholder="-없이 입력">
                            </div>
                            <div class="checkout__input">
                                <p>이메일<span>*</span></p>
                                <input type="text" id="email" name="email" class="new">
                            </div>
                            <div class="row">
                                <div class="col-lg-9">
                                    <div class="checkout__input">
                                        <p>우편번호<span>*</span></p>
                                        <input type="text" readonly="readonly" id="addr_no" name="addr_no" class="new">
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
                                <input type="text" readonly="readonly" id="addr" name="addr" class="new">
                            </div>
                            <div class="checkout__input">
                                <p>상세주소<span>*</span></p>
                                <input type="text" id="addr_d" name="addr_d" class="new">
                            </div>
                        </div> <!-- 정보창 끝 -->
                        
                        <!-- 주문 상품 상세내역은 장바구니 번호로 조회 다시 해야할 듯 -->
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
		                            <li >Total <span  id="sum">${sum} 원</span></li>
                                </ul>
                                <input id="payment" name="payment" style="display: none" value="${sum}">
                                <div class="checkout__input__checkbox">
                                    <label for="acc-or">
                                       	 아래 약관을 확인하였으며 결제에 동의합니다. 
                                        <input type="checkbox" id="acc-or">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <p>주문 상품의 상품명, 수량, 가격, 포인트 사용, 배송 정보를 확인하였으며, 구매 진행에 동의합니다.</p>
  
                                <button type="button" class="site-btn" id="btnOrder">PLACE ORDER</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->