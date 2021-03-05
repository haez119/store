<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>  
<style>
.wishlist__cart__table table tbody tr td {
    padding-top: 10px;
}

.pic {
	text-align: center;
	border-bottom: 3px solid #ebebeb !important;
	border-right: 1px solid #ebebeb;
}
.modal-dialog {
	width: 1000px;
	margin-left:20%;
}
.modal-content{
	overflow-y: initial !important;
}
.modal-body{
	height: 250px;
	overflow-y: auto;
}
.tblmodal tbody tr td{
	border-bottom: 1px solid #ebebeb;
	padding: 10px 25px 10px 25px; 
}
.tblmodal thead tr th {
	padding: 10px 25px 10px 25px; 
	border-bottom: 3px solid #ebebeb;
}
.tblmodal tfoot tr td {
	padding: 10px 25px 10px 25px; 
}

.review {
	background-color: #fdf3ea;
	color: #f08632;
}

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
		$("#order").addClass('active'); //메뉴 색 
		
		var buy_no = 0;
		
		$('#exampleModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget); 
			buy_no = button.data('no'); 
			var modal = $(this);
			
			modal.find('.modal-title').text('주문 상세 내역');
			modal.find('thead tr .buy_no').text(buy_no);
			
			$.ajax({
				url : '${pageContext.request.contextPath}/buyList_D',
				type : 'POST',
				data : { buy_no : buy_no },
				success : function (data) {
					review = data.reviewList
					buy = data.buyList
					console.log(review)
					// if 태그 달아서 상품후기 / 후기 수정  이런식으로 되게 해야겟네
					$('.modalbody').empty();
					for(var i=0; i<buy.length; i++){
						var btn = null;
						
						for(var j=0; j < review.length; j++) {
							
							if(buy[i].BUYD_NO == review[j].buyd_no) {
								btn = '<a type="button" class="btn primary-btn review" href="${pageContext.request.contextPath}/reviewInsertForm/'+buy[i].ITEM_NO+'/'+buy[i].BUYD_NO+'?update=true">후기 수정</button></td>';
								break;
							} else {
								btn = '<a type="button" class="btn primary-btn" href="${pageContext.request.contextPath}/reviewInsertForm/'+buy[i].ITEM_NO+'/'+buy[i].BUYD_NO+'?update=false">상품 후기</button></td>';
							}
						}

						$('.modalbody').append('<tr class="tr1">'
											 + '<td class="pic" rowspan="2"><img style="height: 80px;" src="${pageContext.request.contextPath}/images/item/'+buy[i].PIC+'"></td>'
											 + '<td class="name"><b>상품명</b></td>'
											 + '<td class="name2" colspan="3">'+buy[i].TITLE+'</td>'
											 + '<td class="reorder" rowspan="2">'
											 + btn
											 + '</tr>'
											 + '<tr class="tr2">'
											 + '<td style="border-bottom: 3px solid #ebebeb;"><b>구매수량</b></td>'
											 + '<td style="border-bottom: 3px solid #ebebeb; text-align: right;">'+buy[i].QUANTITY+'개</td>'
											 + '<td style="border-bottom: 3px solid #ebebeb;"><b>구매금액</b></td>'
											 + '<td style="border-bottom: 3px solid #ebebeb; text-align: right;">'+buy[i].PRICE+'원</td>'
											 + '</tr>');
						
					}				
					modal.find('.pay').text(buy[0].PAYMENT + '원');
						
					}, error : function(xhr, status){
					alert(buy_no + ', ' + "실패! status: " + status);
				}
			});
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
											<table>
												<tr>
													<td><h6 style="color: #fd7e14; letter-spacing: 1px;">주문번호</h6></td>
													<td><h6 style="color: #fd7e14;">${buyer.BUY_NO}</h6></td>
													<td></td><td></td>
												</tr>
												<tr>
													<td><h6 style="letter-spacing: 1px;">결제금액</h6></td>
													<td><h6>${buyer.PAYMENT} 원</h6></td>
													<td></td><td></td>
												</tr>
												<tr>
													<td><h6 style="letter-spacing: 8px; width:100px;">수령인</h6></td>
													<td><h6>${buyer.NAME}</h6></td>
													<td><h6 style="letter-spacing: 8px;">연락처</h6></td>
													<td style="width: 200px;">
														<h6>
															${fn:substring(buyer.PHONE,0,3) } -
															${fn:substring(buyer.PHONE,3, fn:length(buyer.PHONE)-4) } - 
															${fn:substring(buyer.PHONE,fn:length(buyer.PHONE)-4, fn:length(buyer.PHONE)) } 
														</h6>
													</td>
												</tr>
												<tr>
													<td><h6 style="letter-spacing: 30px;">주소</h6></td>
													<td><h6>(${buyer.ADDR_NO}) &nbsp; ${buyer.ADDR}</h6></td>
												</tr>
											</table>                                       	  
                                       </div>
                                    </td>
                                    <td class="cart__btn" align="right">
                                    	<button class="primary-btn"  data-no="${buyer.BUY_NO}" data-toggle="modal" data-target="#exampleModal" type="button">상세보기</button>
                                    	<!-- <a href="#" class="primary-btn" >후기 작성</a> 상세보기 모달에 넣어야지-->
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <hr style="padding-bottom: 30px;">
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div align="center">
                 <div class="pagination" align="center">
					<script>
						function goPage(p) {
							location.href="buyList?p="+p
						}
					</script>
					<my:paging paging="${paging}" jsfunc="goPage" /> 
				</div>
           </div>
                
                
        </div>
        
        <!-- 모달창 -->
			<div class="row">
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
				   <div class="modal-dialog" role="document">
				      <div class="modal-content" style="width: 1000px;">
				         <div class="modal-header">
				            <h5 class="modal-title" id="exampleModalLabel" style="text-align: center;"></h5>
				         </div>
				         <div class="modal-body" style="height: 430px;">
				            <div class="form-group">
							<table class="tblmodal">
								<thead>
									<tr>
										<th style="width: 168px; text-align: center;">주문번호</th>
										<th style="width: 800px;" class="buy_no" colspan="5"></th>
									</tr>
								</thead>
								<tbody class="modalbody">
									<tr>
										<td rowspan="2" style="text-align: center; border-bottom: 3px solid #ebebeb; border-right: 1px solid #ebebeb;">
											사진
										</td>
										<td style="letter-spacing: 7px;"><b>상품명</b></td>
										<td colspan="3"></td>
										<td rowspan="2" style="width: 168px; text-align: center; border-bottom: 3px solid #ebebeb; border-left: 1px solid #ebebeb;">
											<button type="button" class="btn primary-btn">상품후기</button>
										</td>
									</tr>
									<tr>
										<td style="border-bottom: 3px solid #ebebeb;"><b>구매수량</b></td>
										<td style="border-bottom: 3px solid #ebebeb;">개</td>
										<td style="border-bottom: 3px solid #ebebeb;"><b>구매금액</b></td>
										<td style="border-bottom: 3px solid #ebebeb;"> 원</td>
									</tr>
								</tbody>
								<tfoot >
									<tr >
										<td></td><td></td>
										<td></td>
										<td style="padding-top: 20px;"><b>합계금액</b></td>
										<td class="pay" style="text-align: right; padding-top: 20px;"></td>
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