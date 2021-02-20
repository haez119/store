<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="paging" type="com.min.store.vo.Paging" %> 
<!-- 패키지 바꿔줘야 함!! -->
<%@ attribute name="jsfunc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination">
<ul>

<c:if test="${paging.startPage>1}"> <!-- 스타트페이지가 1보다 크면 이전버튼 생성 -->
	<li><a href="javascript:${jsfunc}(${paging.startPage-1})">...</a>
</c:if>

<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i">
	<c:if test="${i != paging.page}">
		<li><a href="javascript:${jsfunc}(${i})">${i}</a>
	</c:if>
	
	<c:if test="${i == paging.page}">
		<li><a class="active">${i}</a></li>
		<!-- a태그에 class="active" 줘야 스타일이 적용됨 -->
	</c:if>
	
</c:forEach>

<c:if test="${paging.endPage<paging.totalPageCount}">
	<li><a href="javascript:${jsfunc}(${paging.endPage+1})">...</a>
</c:if>

</ul>
</div>