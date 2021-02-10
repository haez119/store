<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.content{
		padding: 100px 0px 150px 0px;
	}
</style>
<script>
	$(function() {
		var re = ${login}
		if(re) {
			alert("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
	});
</script>

<section>
	
<div class="content" align="center">
	<div class="col-lg-4">
	    <div class="class__sidebar">
	        <h5>SIGN IN</h5>
	        <form action="${pageContext.request.contextPath}/login">
	            <input type="text" id="mem_id" name="mem_id" placeholder="ID">
	            <input type="text" id="password" name="password" placeholder="PASSWORD">
	            <select id="user" name="user">
	                <option value="member" selected="selected">일반 회원</option>
	                <option value="seller">사업자 회원</option>
	            </select>
	            <div align="right" style="padding-bottom: 15px;"><a href="#" style="color: #f08632">SIGN UP</a></div>
	            <button type="submit" class="site-btn">IN</button>
	        </form>
	    </div>
	</div>
</div>


</section>

















