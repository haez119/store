<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>

<style>

.pagination li {
	display: inline-block; 
}
.pagination {
  display: inline-block;
}

.pagination a {
    min-width: 2.81rem;
    text-align: center;
    border-radius: .125rem;
    transition: all .15s linear;
    position: relative;
    display: block;
    padding: .63rem .5rem;
    margin-left: 6px;
    line-height: 1.25;
    background-color: #fff;
    border: 1px solid #265df1;
}

.pagination a.active {
    background-color: #265df1;
    color: #fff;
    border-color: #265df1;
}

.pagination a:hover:not(.active) {
	text-decoration: none;
}
</style>

<script>
$(function() {
	$(".side-nav-menu-item").removeClass('active');
	$("#itemMenu").removeClass("side-nav-menu-item side-nav-has-menu");
	$("#itemMenu").addClass("side-nav-menu-item side-nav-has-menu side-nav-opened");
	$("#subUsers").css("display", 'block');
	$("#inquiryLi").addClass('active');
	
	$("#tbody tr").on('click', function() {
		var inquiry_no = $(this).children().children().eq(0).text();
		var modal = $("#inq_Detail");
		modal.find('#inquiry_no').text(inquiry_no);
		
		$.ajax({
			url : '${pageContext.request.contextPath}/inquiryDetail?no=' + inquiry_no ,
			type : 'POST',
			data : { inquiry_no : inquiry_no},
			success : function (data) {
				 
				modal.find('#de_answer_date').text("");
				 modal.find('#de_answer').text("");
				 
				 modal.find('#d_type').text(data[0].type);
				 modal.find('#de_insert_date').text(data[0].insert_date);
				 modal.find('#de_title').text(data[0].title);
				 modal.find('#de_content').text(data[0].content);

				 modal.find('#de_answer_date').text(data[0].answer_date);
				 modal.find('#de_answer').text(data[0].answer);
				 modal.modal('show');

			}
		});
	});
	
	
});

</script>



<div class="content">
        <div class="py-4 px-3 px-md-4">
            <div class="card mb-3 mb-md-4">

                <div class="card-body">
                    <nav class="d-none d-md-block" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="#">Inquiry</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Inquiry List</li>
                        </ol>
                    </nav>
                    <!-- End Breadcrumb -->

                    <div class="mb-3 mb-md-4 d-flex justify-content-between">
                        <span class="h3 mb-0" style="float: left;">Inquiry</span>
                    </div>


                    <!-- Users -->
                    <div class="table-responsive-xl">
                        <table class="table text-nowrap mb-0">
                            <thead>
                            <tr>
                                <th class="font-weight-semi-bold border-top-0 py-2">#</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">분류</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">상품명</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">등록일</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">제목</th>
                                <th class="font-weight-semi-bold border-top-0 py-2">답변일</th>
                            </tr>
                            </thead>
                            <tbody id="tbody">
                            <c:forEach var="item" items="${inquiryList}">
                            <tr>
                                <td class="py-3">
                                	<div style="display: none;">${item.INQUIRY_NO}</div>
                                	<div>${item.NO}</div>
                                </td>
                                <td class="py-3">${item.TYPE}</td>
                                <td class="align-middle py-3">${item.ITEM_TITLE}</td>
                                <td class="py-3">${item.INSERT_DATE}</td>
                                <td class="py-3">${item.TITLE}</td>
                                <td class="py-3">${item.ANSWER_DATE}</td>
                                <td class="py-3">
                                    <div class="position-relative">
                                    	<span class="upset">
	                                        <a class="link-dark d-inline-block" href="#" ><i class="gd-pencil icon-text"></i></a>
	                                    </span>
	                                    <span class="del">
	                                        <a class="link-dark d-inline-block" href="#"><i class="gd-trash icon-text"></i></a>
	                                    </span>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                            
                            </tbody>
                        </table>
                        <div class="card-footer d-block d-md-flex align-items-center d-print-none">
                          <nav class="d-flex ml-md-auto d-print-none" aria-label="Pagination">
	                          <ul class="pagination justify-content-end font-weight-semi-bold mb-0">				
		                          <li class="page-item">				
		                          	<script>
										function goPage(p) {
											location.href="inquiryList?p="+p
										}
									</script>
									<my:paging paging="${paging}" jsfunc="goPage" /> 				
		                          </li>
	                          </ul>
                         </nav>
                        </div>
                    </div>
                    <!-- End Users -->
                </div>
            </div>
        </div>

</div>


