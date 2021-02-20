<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
	
	$(function() {
		var login = "${login}";
		if(login) {
			alert("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		$("#btnLogin").on('click', function(event) {
			if ( $("#mem_id").val() == null ||  $("#mem_id").val() == '' ) {
				alert("아이디를 입력해주세요.");
				$("#mem_id").focus();
				event.preventDefault();
			} else if ( $("#password").val() == null ||  $("#password").val() == '' )  {
				alert("비밀번호를 입력해주세요.");
				$("#password").focus();
				event.preventDefault();
			} else {
				$("#frmLogin").attr('action', '${pageContext.request.contextPath}/login');
			}
		})
		
		// action="${pageContext.request.contextPath}/login" 
		
		
		
		
	
	});
</script>

<section>
	
<div class="myContent" align="center">
	<div class="col-lg-4 col-md-5">
	    <div class="class__sidebar">
	        <h5>SIGN IN</h5>
	        <form id="frmLogin" method="post">
	            <input type="text" id="mem_id" name="mem_id" placeholder="ID">
	            <input type="password" id="password" name="password" placeholder="PASSWORD">
	            <select id="user" name="user">
	                <option value="member" selected="selected">일반 회원</option>
	                <option value="seller">판매자 회원</option>
	            </select>
	            <div align="right" style="padding-bottom: 15px;"><a href="${pageContext.request.contextPath}/registerForm" style="color: #f08632">SIGN UP</a></div>
	            <button type="submit" class="site-btn" id="btnLogin" >IN</button>
	        </form>
	    </div>
	</div>
</div>


</section>



