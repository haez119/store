<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

var mem_id_check;
var mempwChk;
var mem_mail_chk;
var seller_id_check;
var nic_check;
var sellerpwChk;
var b_license_no_chk;
var pattern_phone = /^\d{2,3}\d{3,4}\d{4}$/; //전화번호 정규식


// 사업자/개인 가입화면 처리
function selected(user) {
	if(user == 'member') {
		$("#seller").css('display', 'none');
		$("#member").css('display','');
	} else {
		$("#member").css('display','none');
		$("#seller").css('display', '');
	}
}

// 우편번호 검색
function openDaumZipAddress( ) {

    new daum.Postcode({

       oncomplete:function(data) {

          $("#addr_no").val(data.zonecode); 

          $("#addr").val(data.address); // 주소
       }

    }).open();
 }


$(function() {
	
	var userSel = $("#user :selected").val();
	selected(userSel);
	
	// 권한 별 화면 바꾸기
	$("#user").change(function() {
		userSel = $("#user :selected").val();
		selected(userSel);
	});
	
	//개인 아이디 중복확인
	$("#btnMemId").on('click', function() {
		var mem_id = $("#mem_id").val();
		
		 $.ajax({
			  url: '${pageContext.request.contextPath}/memId/' + mem_id ,
			  success: function(data) {
				  mem_id_check = data;
				  if(data) {
					  $("#memIdCheck").text("사용 가능한 아이디입니다.").css('color', 'green');
					  $("#mem_id").attr('readonly', true);
				  } else {
					  $("#memIdCheck").text("중복된 아이디입니다.").css('color', 'red');
				  }
			}
		});
		
	});
	
	//비밀번호 확인
	$("#memPw").keyup(function(){ //비밀번호 입력할때
		$("#memPwChk").text(""); //유효성검사창 초기화
		mempwChk=false;
	});
	$("#memPw2").keyup(function(){
		if( $("#memPw").val() != $("#memPw2").val() ){
			$("#memPwChk").text("비밀번호가 일치하지 않습니다.").css("color","red");
			mempwChk=false;
		}else{
			$("#memPwChk").text("비밀번호가 일치합니다.").css("color","green");
			mempwChk=true;
		}
	});
	

	// 메일 인증
	$("#btnMemEmail").on('click', function () {
		
		var mail = $("#memEmail").val();
		var regexPattern = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
		
		if (regexPattern.test(mail)) {
			$.ajax({
				  url: '${pageContext.request.contextPath}/memEmail/' + mail ,
				  success: function(data) {
					  mem_mail_chk = data;
					  if(data) {
						  alert("사용 가능한 메일입니다.");
						  $("#memEmail").attr("readonly", true);
						  // 메일인증 코드 전송예정
					  } else {
						  alert("중복된 메일입니다.");
						  $("#memEmail").focus();
					  }
				}
			});
		} else {
			alert("메일 형식이 올바르지 않습니다.");
			$("#memEmail").focus();
		}
	});
	
	// 우편번호 검색 
	$("#btnAddrNo").on('click', function() {
		openDaumZipAddress();
	});
	
	//개인 회원가입
	$("#btnMemUp").on('click', function() {

		var phoneCk = pattern_phone.test($("#memPhone").val());
		console.log(phoneCk);
		
		if( $("#mem_id").val() == null || $("#mem_id").val() == '') {
			alert("아이디를 입력하세요.");
			$("#mem_id").focus();
		} else if( $("#memPw").val() == null || $("#memPw").val() == '' ) {
			alert("비밀번호를 입력하세요.");
			$("#memPw").focus();
		} else if( $("#memName").val() == null || $("#memName").val() == '' ) {
			alert("이름을 입력하세요.");
			$("#memName").focus();
		} else if( $("#memEmail").val() == null || $("#memEmail").val() == '' ) {
			alert("메일을 입력하세요.");
			$("#memEmail").focus();
		} else if( $("#memPhone").val() == null || $("#memPhone").val() == '' ) {
			alert("전화번호를 입력하세요.");
			$("#memPhone").focus();
		} else if ( !phoneCk ) {
			alert("전화번호의 형식을 확인하세요.");
			$("#memPhone").focus();
		} else if(mem_id_check) {
			if(mempwChk) {
				if(mem_mail_chk) {
					$.ajax({
						  url: '${pageContext.request.contextPath}/registerMem' ,
						  data : $("#memFrm").serialize(), 
						  method : "post",
						  success: function() {
							  alert("가입 되었습니다.");
							  $(location).attr('href','${pageContext.request.contextPath}/loginForm');
						}
					});
				} else {
					alert("메일을 확인하세요");
					$("#memEmail").focus();
				}
			} else {
				alert("비밀번호를 확인하세요");
				$("#memPw2").focus();
			}
		} else {
			alert("아이디를 확인하세요.");
			$("#mem_id").focus();
		}
	});
	
	
	//판매자 아이디 중복확인
	$("#btnSellId").on('click', function() {
		var seller_id = $("#seller_id").val();
		
		 $.ajax({
			  url: '${pageContext.request.contextPath}/sellerId/' + seller_id ,
			  success: function(data) {
				  seller_id_check = data;
				  if(data) {
					  $("#sellIdCheck").text("사용 가능한 아이디입니다.").css('color', 'green');
					  $("#seller_id").attr('readonly', true);
				  } else {
					  $("#sellIdCheck").text("중복된 아이디입니다.").css('color', 'red');
				  }
			}
		});
	});
	
	// 닉네임 중복확인 nic_name
	$("#btnNic").on('click', function() {
		var nic = $("#nic_name").val();
		$.ajax({
			  url: '${pageContext.request.contextPath}/nicCheck/' + nic ,
			  success: function(data) {
				  nic_check = data;
				  if(data) {
					 alert("사용 가능한 이름입니다.");
					  $("#nic_name").attr('readonly', true);
				  } else {
					  alert("중복된 이름입니다.");
					  $("#nic_name").focus();
					  
				  }
			}
		});
		
	});
	
	
	//비밀번호 확인
	$("#sellPw").keyup(function(){ //비밀번호 입력할때
		$("#sellPwChk").text(""); //유효성검사창 초기화
		sellerpwChk=false;
	});
	$("#sellPw2").keyup(function(){
		if( $("#sellPw").val() != $("#sellPw2").val() ){
			$("#sellPwChk").text("비밀번호가 일치하지 않습니다.").css("color","red");
			sellerpwChk=false;
		}else{
			$("#sellPwChk").text("비밀번호가 일치합니다.").css("color","green");
			sellerpwChk=true;
		}
	});
	
	//사업자번호  중복확인(인증)
	$("#btnSellNo").on('click', function() {
		var license_no = /^\d{3}\d{2}\d{5}$/; // 개인 사업자번호는 10자리  3-2-5
		var b_license_no = $("#b_license_no").val();
		var noCk = pattern_phone.test(b_license_no);
		console.log("사업자번호 정규식 ", noCk)
		
		if ( noCk ) {
			 $.ajax({
				  url: '${pageContext.request.contextPath}/license/' + b_license_no ,
				  success: function(data) {
					  b_license_no_chk = data;
					  if(data) {
						  alert("인증되었습니다.");
						  $("#b_license_no").attr("readonly", true);
					  } else {
						  alert("사업자 번호가 올바르지 않습니다.");
						  $("#b_license_no").focus();
					  }
				}
			});
		} else {
			alert("사업자번호의 형식이 올바르지 않습니다.");
			$("#b_license_no").focus();
		}
	});
	
	//사업자 회원가입
	$("#btnSellUp").on('click', function() {
		
		var phoneCk = pattern_phone.test($("#sellPhone").val());
		
		if( $("#seller_id").val() == null || $("#seller_id").val() == '') {
			alert("아이디를 입력하세요.");
			$("#seller_id").focus();
		} else if( $("#sellPw").val() == null || $("#sellPw").val() == '' ) {
			alert("비밀번호를 입력하세요.");
			$("#sellPw").focus();
		} else if( $("#b_license_no").val() == null || $("#b_license_no").val() == '' ) {
			alert("사업자번호를 입력하세요.");
			$("#b_license_no").focus();
		} else if( $("#sellName").val() == null || $("#sellName").val() == '' ) {
			alert("이름을 입력하세요.");
			$("#sellName").focus();
		} else if( $("#sellPhone").val() == null || $("#sellPhone").val() == '' ) {
			alert("전화번호를 입력하세요.");
			$("#sellPhone").focus();
		} else if ( !phoneCk ) {
			alert("전화번호의 형식을 확인하세요.");
			$("#sellPhone").focus();
		}  else if(seller_id_check) {
			if(sellerpwChk) {
				if(b_license_no_chk) {
					if( nic_check ) {
						$.ajax({
							  url: '${pageContext.request.contextPath}/registerSeller' ,
							  data : $("#sellFrm").serialize(), 
							  method : "post",
							  success: function() {
								  alert("가입 되었습니다.");
								  $(location).attr('href','${pageContext.request.contextPath}/loginForm');
							}
						});
					}else {
						alert("스토어 이름을 확인하세요");
						$("#nic_name").focus();
					}
				} else {
					alert("사업자번호를 확인하세요");
					$("#b_license_no").focus();
				}
			} else {
				alert("비밀번호를 확인하세요");
				$("#sellPw2").focus();
			}
		} else {
			alert("아이디를 확인하세요.");
			$("#seller_id").focus();
		}
	});
	
	
	
	

	
});
</script>

<style>
	z {
		color: red;
	}
</style>

    
<section>
	
<div class="myContent" align="center">
	<div class="col-lg-8 col-md-10">
	    <div class="class__sidebar">
	        <h5>SIGN UP</h5>
	        <div>
	        	<select id="user" name="user">
	                <option value="member" selected="selected">일반 회원</option>
	                <option value="seller">판매자 회원</option>
	            </select>
	        </div>
	        
	        <div style="padding-top: 50px;">
            <div id="member" style="display: none;">
            	<form id="memFrm">
            	<div align="left">
            		<table style="width: 100%">
            			<tr>
            				<td style="width: 15%">아이디<z>*</z></td>
            				<td style="width: 75%">
            					<input type="text" id="mem_id" name="mem_id" >
            				</td>
            				<td style="width: 10%"><input type="button" id="btnMemId" value="중복확인" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            			</tr>
            			<tr>
            				<td></td>
            				<td><a id="memIdCheck"></a></td>
            			</tr>
            			<tr>
            				<td>비밀번호<z>*</z></td>
            				<td><input type="password" id="memPw" name="password"></td>
            			</tr>
            			<tr>
            				<td>비밀번호 확인<z>*</z></td>
            				<td><input type="password" id="memPw2" name="password2" ></td>
            			</tr>
            			<tr>
            				<td></td>
            				<td id="memPwChk" style="padding-bottom: 10px;"></td>
            			</tr>
            			<tr>
            				<td>이름<z>*</z></td>
            				<td><input type="text" id="memName" name="name" ></td>
            			</tr>
            			<tr>
            				<td>이메일<z>*</z></td>
            				<td><input type="email" id="memEmail" name="email" ></td>
            				<td><input type="button" id="btnMemEmail" value="인증" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            				
            			</tr>
            			<tr>
            				<td>전화번호<z>*</z></td>
            				<td><input type="text" id="memPhone" name="phone" placeholder="-없이 입력"></td>
            			</tr>
            			<tr>
            				<td>우편번호</td>
            				<td><input type="text" id="addr_no" name="addr_no" readonly="readonly"></td>
            				<td><input type="button" id="btnAddrNo" value="검색" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            			</tr>
            			<tr>
            				<td>주소</td>
            				<td><input type="text" id="addr" name="addr" ></td>
            			</tr>
            			<tr>
            				<td>상세주소</td>
            				<td><input type="text" id="addr_d" name="addr_d" ></td>
            			</tr>
            			<tr>
            			<td></td>
            			<td><button type="button" class="site-btn" id="btnMemUp">UP</button></td>
            			</tr>
            		</table>
            	</div>
            	</form>
            </div>
	            
            <div id="seller" style="display: none;">
            	<form id="sellFrm">
            	<div align="left">
            		<table style="width: 100%">
            			<tr>
            				<td style="width: 15%">아이디<z>*</z></td>
            				<td style="width: 75%">
            					<input type="text" id="seller_id" name="seller_id" >
            				</td>
            				<td style="width: 10%"><input type="button" id="btnSellId" value="중복확인" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            			</tr>
            			<tr>
            				<td></td>
            				<td><a id="sellIdCheck"></a></td>
            			</tr>
            			<tr>
            				<td>비밀번호<z>*</z></td>
            				<td><input type="password" id="sellPw" name="password"></td>
            			</tr>
            			<tr>
            				<td>비밀번호 확인<z>*</z></td>
            				<td><input type="password" id="sellPw2" name="password2" ></td>
            			</tr>
            			<tr>
            				<td></td>
            				<td id="sellPwChk" style="padding-bottom: 10px;"></td>
            			</tr>
            			<tr>
            				<td>사업자번호<z>*</z></td>
            				<td><input type="text" id="b_license_no" name="b_license_no" placeholder="-없이 입력"></td>
            				<td><input type="button" id="btnSellNo" value="인증" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            			</tr>
            			<tr>
            				<td>이름<z>*</z></td>
            				<td><input type="text" id="sellName" name="name" ></td>
            			</tr>
            			<tr>
            				<td>스토어 이름<z>*</z></td>
            				<td><input type="text" id="nic_name" name="nic_name" ></td>
            				<td><input type="button" id="btnNic" value="중복확인" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            			</tr>
            			<tr>
            				<td>전화번호<z>*</z></td>
            				<td><input type="text" id="sellPhone" name="phone" placeholder="-없이 입력"></td>
            			</tr>
            			<tr>
            			<td></td>
            			<td><button type="button" class="site-btn" id="btnSellUp">UP</button></td>
            			</tr>
            		</table>
            	</div>
            	</form>
            </div>
            
	        </div>   
	        
	    </div>
	</div>
</div>


</section>