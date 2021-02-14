<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<style>

</style>
<script>
var sum = 0;

$(function() {
	$(".menu").children().removeClass('active');
	$("#cart").addClass('active'); //메뉴 색 
	
	
	$("input[type=checkbox]").prop("checked",true); 
	
	
	$(".icon_close").on('click', function() {
		var cart_no = $(this).next().text();
		var cart = confirm("삭제 하시겠습니까??");
		if(cart) {
			$.ajax({
				  url: '${pageContext.request.contextPath}/cartDel/' + cart_no  ,
				  success: function(data) {
					  if (data) {
						  alert("장바구니에서 삭제 되었습니다.");
						  $(location).attr('href','${pageContext.request.contextPath}/cartMain');
					  } 
				}
			});
		} else {
			alert("취소 되었습니다.");
		}
	});
	
	// 체크박스 클릭 이벤트
	$("input:checkbox[name=cart_no]").on('click', function() {
		chkArray = new Array();
		sum = 0;
		chk();
		$("#Subtotal").text();
		$("#Subtotal").text(sum + ' 원');
		
		chkAll();
	});
	
	// 체크박스 all 이벤트
	$("#allCheck").click(function(){ 
		
		if($("#allCheck").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false); 
		} 
		
		chkArray = new Array();
		sum = 0;
		chk();
		$("#Subtotal").text();
		$("#Subtotal").text(sum + ' 원');
	});
	
	//장바구니 수정
	$("#updateCart").on('click', function() {
		var cart = confirm("수정 하시겠습니까??");
		if(cart) {
			var l = $("#length").text();
			var valu = null;
			
			for(var i=0 ; i < l ; i++) {
				valu = valu + "," + $(".cart_no").eq(i).val();
				valu = valu + "," + $(".qVal").eq(i).val();
			} 
			  $.ajax({
				  url: '${pageContext.request.contextPath}/updateCart' ,
				  data : {"list" : valu }, 
				  success: function(data) {
					  alert("수정 되었습니다.");
					  $(location).attr('href','${pageContext.request.contextPath}/cartMain');
				}
			}); 
		} else {
			alert("취소 되었습니다.");
		}
	});
	
	$(".order").on('click', function() {
		
		if($("input:checkbox[name='cart_no']:checked").length < 1) {
			alert("주문할 상품을 선택해 주세요.")
		} else {
			var cart_no = null;
			$("input:checkbox[name='cart_no']:checked").each(function() {
				var c = $(this).val();
				cart_no = cart_no + "," + c;
			});
			$.ajax({
				  url: '${pageContext.request.contextPath}/getOrder' ,
				  data : {"no" : cart_no }, 
				  success: function(data) {
					  $(location).attr('href','${pageContext.request.contextPath}/getOrderPage');
				}
			}); 
		}
		
	});
	
	
	
}); //ready 끝


// 체크된 값만 Subtotal에 저장
function chk() {
	$('input:checkbox[name=cart_no]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        chkArray.push(this.value); // 클릭된 장바구니 번호 저장
	
        var price = $(this).parent().next().next().next().text();
		var i = parseInt(price.substring(0, price.length - 1 ));
		sum = i + sum; // 클릭된 가격의 합계를 저장
	 });
}

// 체크박스 전체선택 이벤트
function chkAll() {
 	var ck = $('input:checkbox[name=cart_no]:checked').length;
	var all = $('input:checkbox[name=cart_no]').length;

	if(ck == all) {
		$("#allCheck").prop("checked", true)
	} else {
		$("#allCheck").prop("checked", false)
	}
	
} 
</script> 




<section>

<div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>Shopping cart</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <span>Shopping cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="shopping__cart__table" style="min-height: 300px;">
                        <table>
                            <thead>
                                <tr>
                                	<th  style="padding: 20px 40px 40px 20px;"><input type="checkbox" id="allCheck" /></th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </thead>
							<c:if test="${cartList ne null}">
                            <tbody>
                                <c:forEach var="cart" items="${cartList}" >
                                <tr>
                                	<td style="padding: 20px 40px 20px 20px;"><input type="checkbox" name="cart_no" class="cart_no" value="${cart.cart_no}" /></td>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic">
                                        	<c:set var="img" value="${fn:split(cart.pic,',')}"></c:set>
                                        	<c:forEach var="i" items="${img}" begin="0" end="0">
                                            	<img src="${pageContext.request.contextPath}/images/item/${i}" alt="" style="width: 90px; height: 90px;">
                                            </c:forEach>
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6>${cart.title}</h6>
                                            <h5>${cart.price} 원</h5>
                                        </div>
                                    </td>
                                    <td class="quantity__item">
                                        <div class="quantity">
                                            <div class="pro-qty">
                                                <input type="text" value="${cart.quantity}"  class="qVal">
                                            </div>
                                        </div>
                                    </td>
                                    <td class="cart__price" >${cart.total} 원</td>
                                    <td class="cart__close">
                                    	<span class="icon_close"></span>
                                    	<h1 style="display: none;" >${cart.cart_no}</h1>
                                    </td>
                                </tr>
                                </c:forEach>
                                
                            </tbody>
                            </c:if>
                        </table>
                        <a id="length" style="display: none;">${fn:length(cartList)}</a>
                        <c:if test="${fn:length(cartList) eq 0}">
                      		<h4 align="center" style="padding-top: 100px;">카트에 담긴 상품이 없습니다.</h4>
                      	</c:if>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn">
                                <a href="${pageContext.request.contextPath}/shopMain">Continue Shopping</a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn update__btn">
                                <a href="#" id="updateCart"><i class="fa fa-spinner"></i> Update cart</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cart__discount">
                        <h6>Discount codes</h6>
                        <form action="#">
                            <input type="text" placeholder="Coupon code">
                            <button type="submit">Apply</button>
                        </form>
                    </div>
                    <div class="cart__total">
                        <h6>Cart total</h6>
                        <ul>
                        	<c:set var = "sum" value = "0" />
                        	<c:forEach var="cart" items="${cartList}" >
                        		<c:set var= "sum" value="${sum + cart.total}"/>
                        	</c:forEach>
                            <li>Subtotal <span id="Subtotal">0 원</span></li>
                            <li>Total <span>${sum} 원</span></li>
                        </ul>
                        <div id="order" class="order">
                        	<a href="#" class="primary-btn" >결제하기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
    
    
</section>