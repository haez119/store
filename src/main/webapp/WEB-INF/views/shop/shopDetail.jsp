<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 데이터 테이블? -->
<!-- <link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/>  -->
<script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<script src = "http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer ></script>


<style>
ul.rews {
	margin: 0px;
	padding: 50px 20px 20px 20px;
	list-style: none;

}

ul.rews li {
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 25px;
	cursor: pointer;
	
}

ul.rews li.current {
	background: #f08632;
	color: white;
}

.rew-content {
	display: none;
	padding: 15px 0;

}

.rew-content.current {
	display: inherit;
}

.starR{
	  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	  background-size: auto 100%;
	  width: 20px;
	  height: 20px;
	  display: inline-block;
	  text-indent: -9999px;
	  cursor: pointer;
}
.starR.on{ 
	background-position:0 0;
}

ul li.tag-item {
    display: inline-block;
    margin: 0 5px;
    font-size: 14px;
    letter-spacing: -.5px;
    padding: 4px 8px;
    margin: 3px 3px;
    background-color: #f5f5f5;
    color: #000;
}

.reHr {
	border: solid 1px #f08632;
	background-color: #f08632;
}

textarea {
			width: 100%;
			height: 150px;
			padding: 10px;
			box-sizing: border-box;
			border: solid 2px #ced4da;
			border-radius: 5px;
			font-size: 16px;
			resize: both;
	}
	
.inqIcon {
	width: 20px; 
	height: 20px;
}

.paginate {
  display: ;
}

.paginate_button {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
}

span a.current {
  color: orange;
  /* background-color: orange; */
  
}

span a.current:hover {
	color: orange;
}


</style>



<script>
	$(function() {
		
		$(".menu").children().removeClass('active');
		$("#shop").addClass('active'); //메뉴 색 
		
		$("#addCart").on('click', function() {
			var q = $("#quantity").val();
			var id = "${sessionScope.member.mem_id}";
			var no = $(this).next().next().text();

 			var answer = confirm("카트에 담으시겠습니까?");
			if(answer) {
				if ( id == null || id == '') {
					alert("로그인 후에 이용할 수 있습니다.");
				} else {
					 $.ajax({
						  url: '${pageContext.request.contextPath}/addCart/' + no + '/'+ q +'/' + id ,
						  success: function(data) {
							  if (data) {
								  alert("카트에 담겼습니다.");
								  var cart = confirm("카트로 이동하시겠습니까?");
								  if(cart) {
									  $(location).attr('href','${pageContext.request.contextPath}/cartMain');
								  } 
							  } else {
								  alert("동일한 상품이 이미 담겨있습니다.");
							  }
						}
					});
				}
			} 
		});
		
		$('ul.rews li').click(function() { // 포토리뷰/전체리뷰
			
			var tab_id = $(this).attr('data-tab');
			$('ul.rews li').removeClass('current');
			$('.rew-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
			
		});
		
		var reviewList = ${reviewList};
		
		if(reviewList.length == 0) {
			$("#noneRe").css('display', '');
			$("#nonePhoto").css('display', '');
		}
		
		for(var i=0; i < reviewList.length; i++) {
			//포토리뷰 이미지만 찾기 
			var content = reviewList[i].content;
			var start = content.indexOf('src="'); // src=" s의 인덱스 번호 리턴
			
			var re_tag = reviewList[i].tag
			if(re_tag != null && re_tag != '') {
				re_tag = re_tag.split(",");
				
				for(var j=0; j < re_tag.length; j++) { // 태그 달아주고
					$("#tag-all-" + reviewList[i].review_no ).append("<li class='tag-item'>"+re_tag[j]+"<span class='del-btn' idx='"+j+"'></span><span style='display: none;'>"+ re_tag[j] +"</span></li>");
				}
			}
			
			var re_star = parseInt(reviewList[i].star)
			
			
			// 사진이 있을 때
			if(start != -1) {
				$("#nonePhoto").css('display', 'none');
				$("#for-" + reviewList[i].review_no).css('display', ''); //포토 리뷰만 화면에 띄우기
				
				var end = content.indexOf('"', start + 5); // "를 찾음 start+5부터 
				var list = content.substring(start + 5, end);
				$("#imgDiv").append("<img src='" + list + "' style='width: 120px; height: 120px; margin: 20px;'>");
				
				// 별달기
				if(re_star != null && re_star != '' ) {
					$("#"+reviewList[i].buyd_no).children('span').removeClass('on'); //별 지우고
					$("#"+reviewList[i].buyd_no).children('span').eq(re_star-1).addClass('on').prevAll('span').addClass('on');
				}
				
				//태그 달기
				for(var j=0; j < re_tag.length; j++) { // 태그 달아주고
					$("#tag-list-" + reviewList[i].review_no ).append("<li class='tag-item'>"+re_tag[j]+"<span class='del-btn' idx='"+j+"'></span><span style='display: none;'>"+ re_tag[j] +"</span></li>");
				}
			}
			
			//전체보기
			if(re_star != null && re_star != '' ) {
				$("#all-"+reviewList[i].buyd_no).children('span').removeClass('on'); //별 지우고
				$("#all-"+reviewList[i].buyd_no).children('span').eq(re_star-1).addClass('on').prevAll('span').addClass('on');
			}
			
			

		}// for end
		
		
		// 해시태그 클릭
		$(".tag-item").on('click', function() {
			var tag = $(this).children().next().text();
			console.log(tag);
			
			// 태그로 검색할꺼야
		});
		
		var avgStar = "${avgStar}";
		
		if(avgStar != 0 ) {
			avgStar = Math.round(avgStar);
			$("#avgStar").children('span').removeClass('on'); //별 지우고
			$("#avgStar").children('span').eq(avgStar-1).addClass('on').prevAll('span').addClass('on');
		}
		
		//문의 리스트
		inquiryList();
		
		
		// 문의 상세확인
		$(".inqTr").on('click', function() {
			var secret = $(this).children().eq(5).children().children().html();
			var mem_id = $(this).children().eq(0).children().eq(0).text();
			var inquiry_no = $(this).children().eq(0).children().eq(1).text();
			var s_mem_id = "${sessionScope.member.mem_id}";
			
			if(secret == undefined) {
				inquiryModal(inquiry_no);
			} else {
				if(mem_id == s_mem_id) {
					inquiryModal(inquiry_no);
				} else {
					alert("등록한 회원만 확인할 수 있습니다.");
				}
			}
		});
		
		
		// 문의글 등록
		$("#btnInquiry").on('click', function() {
			
			var item_no = "${item.item_no}";
			
			if( $("#type option:selected").val() == null || $("#type option:selected").val() == '') {
				alert("문의 분류를 선택하세요.");
				
			} else if( $("#title").val() == null || $("#title").val() == '' ) {
				alert("제목을 입력하세요.");
				$("#title").focus();
			}  else if( $("#content").val() == null || $("#content").val() == '' ) {
				alert("내용을 입력하세요.");
				$("#content").focus();
			}else {
				$.ajax({
					url : '${pageContext.request.contextPath}/inquiryInsert',
					type : 'POST' ,
					data : $("#frmInquiry").serialize(), 
					success : function (data) {
						alert("문의가 등록되었습니다.");
						$(location).attr('href','${pageContext.request.contextPath}/shopDetail?no=' + item_no);
						}, error : function(xhr, status){
							alert("실패! status: " + status);
					}
				}); 
			}
			
		});
		
	});
	
	function inquiryList() {
		var inquiry = ${inquiryList};
		
		console.log(inquiry[0])
		
		if(inquiry.length == 0) {
			$("#inqTable").html("<div align= center><h4>등록된 문의가 없습니다.</h4><div>")
		}

		for(var i=0; i < inquiry.length; i++) {
			console.log(inquiry[i])
			
			var secret = (inquiry[i].secret == 1) ? "<img src='${pageContext.request.contextPath}/images/etc/secret.png' class='inqIcon'>" : " ";
			var answer = (inquiry[i].answer == null) ? 0 : 1
			
			$("#inqTbody").append("<tr class='inqTr'>"
					+ "<td style='display: none;'><a>"+ inquiry[i].mem_id +"</a><a>"+ inquiry[i].inquiry_no +"</a></td>"
					+ "<td><a style='display: none;'>"+ inquiry[i].mem_id +"</a><div align='center'>" + inquiry[i].no + "</div></td>"
					+ "<td><div align='center'>" + inquiry[i].type + "</div></td>"
					+ "<td><div align='center'>" + inquiry[i].title + "</div></td>"
					+ "<td><div align='center'>" + inquiry[i].insert_date + "</div></td>"
					+ "<td><div align='center'>"+ secret +"</div>"
					+ "<td><div align='center'><img src='${pageContext.request.contextPath}/images/etc/answer.png' class='inqIcon'> &nbsp; (" + answer + ")</div></td>"        
					);

		}
		
		 $('#foo-table').DataTable({
			// 표시 건수기능 숨기기
				"language": {
		        "emptyTable": "데이터가 없어요.",
		        "lengthMenu": "Show _MENU_",
		        "infoEmpty": "데이터가 없습니다.",
		        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
		        "search": "검색: ",
		        "zeroRecords": "일치하는 데이터가 없습니다.",
		        "loadingRecords": "로딩중...",
		        "processing":     "잠시만 기다려 주세요...",
		        "paginate": {
		            "next": ">",
		            "previous": "<"
		        }
		    	},
				lengthChange: true, //t-보이기 , f-숨기기
				searching: false,
				// ordering: true,
				order: [ [ 1, "asc" ] ],
				info: false,
				paging: true,
				lengthMenu: [ 5, 10, 15, 20 ],
				displayLength: 5 
		  	});
		 
		 
	}
	
	function inquiryModal(inquiry_no) {
		
		var modal = $("#inq_Detail");
		
		$.ajax({
			  url: '${pageContext.request.contextPath}/inquiryDetail?no=' + inquiry_no ,
			  success: function(data) {
				  
				 $("#answerDiv").css('display', 'none');
				 modal.find('#de_answer_date').text("");
				 modal.find('#de_answer').text("");
				  
				 modal.find('#d_type').text(data[0].type);
				 modal.find('#de_insert_date').text(data[0].insert_date);
				 modal.find('#de_title').text(data[0].title);
				 modal.find('#de_content').text(data[0].content);
				
				 if(data[0].answer != null && data[0].answer != '') {
					 $("#answerDiv").css('display', '');
					 modal.find('#de_answer_date').text(data[0].answer_date);
					 modal.find('#de_answer').text(data[0].answer);
				 }
				 modal.modal('show');
			  },
	  });
	}
	
</script>


<section>
<!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>Product detail</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <a href="${pageContext.request.contextPath}/shopMain">Shop</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="product__details__img">
                    <c:set var="img" value="${fn:split(item.pic,',')}"></c:set>
                    <c:forEach var="i" items="${img}" begin="0" end="0">
   						 <div class="product__details__big__img">
                            <img class="big_img" src="${pageContext.request.contextPath}/images/item/${i}" alt="">
                        </div>
					</c:forEach>
					<div class="product__details__thumb">
	                    <c:forEach var="i" items="${img}"  >
                            <div class="pt__item active">
                                <img data-imgbigurl="${pageContext.request.contextPath}/images/item/${i}"
                                src="${pageContext.request.contextPath}/images/item/${i}" alt="">
                            </div>
	                    </c:forEach>
                    </div>
 
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product__details__text">
                        <div class="product__label">${item.nic_name}</div>
                        <h4>  ${item.title} &nbsp; &nbsp;
                        	<span class="starRev" style="padding-bottom: 0px;" id="avgStar">
								  <span class="starR 1">&nbsp;</span>
								  <span class="starR 2">&nbsp;</span>
								  <span class="starR 3">&nbsp;</span>
								  <span class="starR 4">&nbsp;</span>
								  <span class="starR 5">&nbsp;</span>
							</span>
                        
                        </h4>
                       	
                        <h5>${item.price} 원</h5>
                        <p>${item.content}</p>
                        <ul>
                            <li>SKU: <span>${item.stock}</span></li>
                            <li>Category: <span>${item.type}</span></li>
                            <li>Star: <span>${avgStar}</span></li>
                        </ul>
                        <div class="product__details__option">
                            <div class="quantity">
                                <div class="pro-qty">
                                    <input type="text" value="1" id="quantity">
                                </div>
                            </div>
                            <a href="#" id="addCart" class="primary-btn">Add to cart</a>
                            <a href="#" class="heart__btn"><span class="icon_heart_alt"></span></a>
                            <a style="display: none;">${item.item_no}</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product__details__tab">
                <div class="col-lg-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">상품소개</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">후기글</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">문의글</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabs-1" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                	<%-- <c:set var="content" value="${fn:split(item.content_d,'/')}"></c:set>
                                	<c:forEach var="c" items="${content}">
										<p>${c}</p>
		                        	</c:forEach> --%>
		                        	${item.content_d}
                                   
                                </div>
                                <c:forEach  items="${picD}" var="pic" >
                                	 <img src="${pageContext.request.contextPath}/images/item/${pic}" alt="">
                                </c:forEach>
                            </div>
                        </div>
                        
                        <div class="tab-pane" id="tabs-2" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                <div style="text-align: center;">
                                
									<div align="center">
										<ul class="rews" >
											<li class="rew-link current" data-tab="photo" >포토 리뷰</li>
											<li class="rew-link" data-tab="all" >전체 리뷰</li>
										</ul>
									</div>
		
	                                <div id="photo" class="rew-content current" style="text-align: center;">
	                                	<div id="imgDiv"></div>
	                                	<div>
		                                	<div style="height: 300px; display: none;" align="center" id="nonePhoto">
		                                		<h2 style="padding-top: 150px;">등록된 포토 리뷰가 없습니다.</h2>
		                                	</div>
		                                
	                                		<c:forEach var="review" items="${reList}">
		                                		<div id="for-${review.review_no}" style="display: none;">
		                                			<hr class="reHr">
		                                			<div align="center" style="padding-top: 20px;"> 
		                                				<span style="float: left">${review.mem_id}</span>
		                                				<span style="float: right;">${review.insert_date}</span>
		                                			</div><br>
		                                			
		                                			<div align="center" style="padding-top: 30px;">
			                                			<div align="right" class="starRev" style="padding-bottom: 0px;" id="${review.buyd_no}" >
															  <span class="starR 1">&nbsp;</span>
															  <span class="starR 2">&nbsp;</span>
															  <span class="starR 3">&nbsp;</span>
															  <span class="starR 4">&nbsp;</span>
															  <span class="starR 5">&nbsp;</span>
														</div>
														<hr>
				                                    	<h5><b>${review.title}</b></h5>
				                                    	<hr>
				                                    	<div style="width: 70%; margin: 5px; font-size: 13px;">${review.content}</div>
				                                    	<ul id="tag-list-${review.review_no}" style="padding-top: 10px;"></ul>
			                                    	</div>
			                                    </div>
		                                    </c:forEach>
	                                	</div> 
	                                </div>
	                                
	                                <div id="all" class="rew-content" style="text-align: center;">
	                                
	                                <div style="height: 300px; display: none;" align="center" id="noneRe">
                                		<h2 style="padding-top: 150px;">등록된 리뷰가 없습니다.</h2>
                                	</div>
                                	
		                                <c:forEach var="review" items="${reList}">
		                               		<div>
		                               			<hr class="reHr">
		                               			<div align="center" style="padding-top: 20px;"> 
		                               				<span style="float: left">작성자 : ${review.mem_id}</span>
		                               				<span style="float: right;">등록일 : ${review.insert_date}</span>
		                               			</div><br>
		                               			
		                               			<div align="center" style="padding-top: 30px;">
		                                			<div align="right" class="starRev" style="padding-bottom: 0px;" id="all-${review.buyd_no}" >
														  <span class="starR 1">&nbsp;</span>
														  <span class="starR 2">&nbsp;</span>
														  <span class="starR 3">&nbsp;</span>
														  <span class="starR 4">&nbsp;</span>
														  <span class="starR 5">&nbsp;</span>
													</div>
													<hr>
			                                    	<h5><b>${review.title}</b></h5>
			                                    	<hr>
			                                    	<div style="width: 70%; margin: 5px; font-size: 13px;">${review.content}</div>
			                                    	<ul id="tag-all-${review.review_no}" style="padding-top: 10px;"></ul>
		                                    	</div>
		                                    </div>
	                                    </c:forEach>
	  
	                                </div>
  		
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="tab-pane" id="tabs-3" role="tabpanel">
                    	<c:if test="${sessionScope.member.mem_id ne null }">
	                       	<div align="right" style="padding-top: 20px;" class="continue__btn">
	                       		<a data-toggle="modal" href="#insertInquiry" class="">문의 하기</a>
	                       	</div>
	                    </c:if>
                       		
                       <div class="row d-flex justify-content-center" >
                       		
                       	   <div class="col-lg-10" align="center"><h2 style="padding-top: 50px;">상품 문의</h2></div>
                           <div class="col-lg-10" style="min-height: 300px;">
                           <div style="padding-top: 80px;" id="inqTable" align="center">
                               <table  class="table table-hover" id="foo-table" style="width: 100%;">
                               	<thead>
                               		<tr>
                               			<th style="display: none;"></th>
                               			<th style="width: 3%"><div align="center">No</div></th>
                               			<th style="width: 20%"><div align="center">분류</div></th>
                               			<th style="width: 30%"><div align="center">제목</div></th>
                               			<th style="width: 20%"><div align="center">등록일</div></th>
                               			<th style="width: 7%"></th>
                               			<th style="width: 20%"></th>
                               		</tr>
                               	</thead>
                               	<tbody id="inqTbody"></tbody>
                               </table>
                             </div>
                           </div>
                       </div>
                   </div>
                   
                   
                </div>
            </div>
        </div>
        </div>
    </section>
    <!-- Shop Details Section End -->

    <!-- Related Products Section Begin -->
    <!-- 해당 물품 올린 판매자의 품목만 보이도록 왜 4개가 보일까-->
    <section class="related-products spad" style="padding-top: 30px;">
    <hr>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="section-title">
                        <h2>Related Products</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="related__products__slider owl-carousel">
                <c:forEach  items="${sellerList}" var="s" >
                    <div class="col-lg-3">
                        <div class="product__item">
                        <c:set var="type" value="${s.type}"></c:set>
                    	<c:set var="img" value="${fn:split(s.pic,',')}"></c:set>
                    	<c:forEach var="i" items="${img}" begin="0" end="0">
                            <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath}/images/item/${i}">
                                <div class="product__label">
                                    <span>${type}</span>
                                </div>
                            </div>
                        </c:forEach>
                            <div class="product__item__text">
                                <h6><a href="${pageContext.request.contextPath}/shopDetail?no=${s.item_no}">${s.title}</a></h6>
                                <div class="product__item__price">${s.price} 원</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
				
                </div>
            </div>
        </div>
    </section>

<!-- 등록하는 모달 -->
<div class="modal fade" id="insertInquiry" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="max-width: 100%; width: auto; display: table;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">문의 등록</h5>
      </div>
      <div class="modal-body">
      	
			<form id="frmInquiry" method="post">
				<div class="form-group row">
					<div class="col-md-6 mb-6 mb-lg-6">
						<select id="type" name="type">
                        	<option value="">선택</option>
                            <option value="배송">배송</option>
                            <option value="사이즈">사이즈</option>
                            <option value="입고">입고</option>
                            <option value="환불 및 교환">환불 및 교환</option>
                            <option value="기타">기타</option>
                        </select>
					</div>
				</div>
			
				<div class="form-group row">
					<div class="col-md-12 mb-12 mb-lg-12">
						<input type="text" class="form-control" placeholder="제목" id="title" name="title">
						<input type="text" id="item_no" name="item_no" value="${item.item_no}" style="display: none;">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-12 mb-12 mb-lg-12">
						<textarea rows="20" cols="70" id="content" name="content"></textarea>
					</div>
				</div>
				 <div class="checkout__input__checkbox" style="padding-top: 10px;">
                    <label for="secret">
                        	비밀글
                        <input type="checkbox" id="secret" name="secret">
                        <span class="checkmark"></span>
                    </label>
                </div>
			</form>  	
      	
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary" id="btnInquiry" >등록하기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div><!-- modal end -->

<!-- 확인하는 모달 -->
<div class="modal fade" id="inq_Detail" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="max-width: 100%; width: auto; display: table;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">문의 확인</h5>
      </div>
      <div class="modal-body">
		<div class="form-group row">
			<div class="col-md-6 mb-6 mb-lg-6">
				<div><b id="d_type" style="color: #f08632; font-size: 20px;"></b></div>
			</div>
		</div>
	
		<div class="form-group row">
			<div class="col-md-12 mb-12 mb-lg-12">
				<span style="float: left" id="de_title"></span>
				<span style="float: right" id="de_insert_date"></span>
			</div>
		</div>
		<div class="form-group row">
			<div class="col-md-12 mb-12 mb-lg-12">
				<textarea rows="20" cols="70" id="de_content" readonly="readonly"></textarea>
			</div>
		</div>
		<div id="answerDiv" style="display: none;">
			<div class="form-group row">
				<div class="col-md-12 mb-12 mb-lg-12">
					<span style="float: left">답변</span>
					<span style="float: right" id="de_answer_date"></span>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-md-12 mb-12 mb-lg-12">
					<textarea rows="20" cols="70" id="de_answer" readonly="readonly"></textarea>
				</div>
			</div>
		</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div><!-- modal end -->

</section>
    <!-- Related Products Section End -->

    
    
    
    
    
    