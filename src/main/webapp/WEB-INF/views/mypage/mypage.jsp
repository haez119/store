<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>

$(function() {
	
	$(".menu").children().removeClass('active');
	$("#myPage").addClass('active'); //메뉴 색 
	
	var pwCk = false;
	var mailCk = true;
	var pattern_phone = /^\d{2,3}\d{3,4}\d{4}$/; //전화번호 정규식
	
	//비밀번호 확인
	$("#password").keyup(function(){ //비밀번호 입력할때
		$("#PwCheck").text(""); //유효성검사창 초기화
		pwCk=false;
	});
	$("#password2").keyup(function(){
		if( $("#password").val() != $("#password2").val() ){
			$("#PwCheck").text("비밀번호가 일치하지 않습니다.").css("color","red");
			pwCk=false;
		}else{
			$("#PwCheck").text("비밀번호가 일치합니다.").css("color","green");
			pwCk=true;
		}
	});
	
	$("#email").keyup(function(){
		mailCk = false;
	});
	
	// 메일 중복확인
	$("#btnEmail").on('click', function () {
		
		var mail = $("#email").val();
		var regexPattern = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
		
		if (regexPattern.test(mail)) {
			$.ajax({
				  url: '${pageContext.request.contextPath}/memEmail/' + mail ,
				  success: function(data) {
					  mailCk = data;
					  if(data) {
						  alert("사용 가능한 메일입니다.");
						  $("#email").attr("readonly", true);
					  } else {
						  alert("중복된 메일입니다.");
						  $("#email").focus();
					  }
				}
			});
		} else {
			alert("메일 형식이 올바르지 않습니다.");
			$("#email").focus();
			mailCk = false;
		}
	});
	
	$("#btnAddrNo").on('click', function() {
		openDaumZipAddress();
	});
	
	$("#btnUpdate").on('click', function() {

		var phoneCk = pattern_phone.test($("#phone").val());
		
		if( $("#password").val() == null || $("#password").val() == '' ) {
			alert("비밀번호를 입력하세요.");
			$("#password").focus();
		} else if( $("#name").val() == null || $("#name").val() == '' ) {
			alert("이름을 입력하세요.");
			$("#name").focus();
		} else if( $("#email").val() == null || $("#email").val() == '' ) {
			alert("메일을 입력하세요.");
			$("#email").focus();
		} else if( $("#phone").val() == null || $("#phone").val() == '' ) {
			alert("전화번호를 입력하세요.");
			$("#phone").focus();
		} else if ( !phoneCk ) {
			alert("전화번호의 형식을 확인하세요.");
			$("#phone").focus();
		} else {
			if(pwCk) {
				if(mailCk) {
					$.ajax({
						  url: '${pageContext.request.contextPath}/mypageUpdate' ,
						  data : $("#memFrm").serialize(), 
						  method : "post",
						  success: function() {
							  alert("수정 되었습니다.");
						}
					});
				} else {
					alert("메일을 확인하세요");
					$("#email").focus();
				}
			} else {
				alert("비밀번호를 확인하세요");
				$("#password2").focus();
			}
		}
	});
	
	
});


function openDaumZipAddress( ) {
    new daum.Postcode({
       oncomplete:function(data) {
          $("#addr_no").val(data.zonecode); 
          $("#addr").val(data.address); // 주소
       }
    }).open();
 }



</script>
    
    
    
    
    
    
    
    
    
    
    
    
    
    

<section>
<div class="myContent" align="center">
	<div class="col-lg-8 col-md-10">
	    <div class="class__sidebar">
	        <h5>MyPage</h5>
	        
	   	<div style="padding-top: 50px;">
            	<form id="memFrm" method="post" >
            		<table style="width: 100%">
            			<tr>
            				<td>비밀번호</td>
            				<td><input type="password" id="password" name="password" value="${sessionScope.member.password}"></td>
            			</tr>
            			<tr>
            				<td>비밀번호 확인</td>
            				<td><input type="password" id="password2" name="password2" ></td>
            			</tr>
            			<tr>
            				<td></td>
            				<td id="PwCheck" style="padding-bottom: 10px;"></td>
            			</tr>
            			<tr>
            				<td>이름</td>
            				<td><input type="text" id="name" name="name" value="${sessionScope.member.name}"></td>
            			</tr>
            			<tr>
            				<td>이메일</td>
            				<td><input type="email" id="email" name="email" value="${sessionScope.member.email}"></td>
            				<td><input type="button" id="btnEmail" value="중복확인" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            				
            			</tr>
            			<tr>
            				<td>전화번호</td>
            				<td><input type="text" id="phone" name="phone" placeholder="-없이 입력" value="${sessionScope.member.phone}"></td>
            			</tr>
            			<tr>
            				<td>우편번호</td>
            				<td><input type="text" id="addr_no" name="addr_no" readonly="readonly" value="${sessionScope.member.addr_no}"></td>
            				<td><input type="button" id="btnAddrNo" value="검색" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            			</tr>
            			<tr>
            				<td>주소</td>
            				<td><input type="text" id="addr" name="addr" value="${sessionScope.member.addr}"></td>
            			</tr>
            			<tr>
            				<td>상세주소</td>
            				<td><input type="text" id="addr_d" name="addr_d" value="${sessionScope.member.addr_d}"></td>
            			</tr>
            			<tr>
            			<td></td>
            			<td><button type="button" class="site-btn" id="btnUpdate">변경</button></td>
            			</tr>
            		</table>
            	</form>
            </div> 
	    </div>
	</div>
</div>


</section>
    

    
    