<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<section>
	
<div class="myContent" align="center">
	<div class="col-lg-8 col-md-10">
	    <div class="class__sidebar">
	        <h5>MyPage</h5>
	        
	   	<div style="padding-top: 50px;">
            <div id="member">
            	<form id="memFrm">
            		<table style="width: 100%">
            			<tr>
            				<td>비밀번호</td>
            				<td><input type="password" id="password" name="password" ${sessionScope.member.password}></td>
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
            				<td><input type="button" id="btnMemEmail" value="인증" style="padding: 2px 7px;font-size:15px;cursor:pointer;"></td>
            				
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
            			<td><button type="button" class="site-btn" id="btnMemUp">변경</button></td>
            			</tr>
            		</table>
            	</form>
            </div>
	        </div>   
	        
	    </div>
	</div>
</div>


</section>
    

    
    