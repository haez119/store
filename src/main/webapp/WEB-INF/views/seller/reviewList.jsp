<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>

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

img {
	max-width: 500px;
}

</style>

<script>
$(function() {
	$(".side-nav-menu-item").removeClass('active');
	$("#itemMenu").removeClass("side-nav-menu-item side-nav-has-menu");
	$("#itemMenu").addClass("side-nav-menu-item side-nav-has-menu side-nav-opened");
	$("#subUsers").css("display", 'block');
	$("#itemLi").addClass('active');
	
	var reviewList = ${reviewList};
	
	for(var i=0; i < reviewList.length; i++) {
		
		var re_star = parseInt(reviewList[i].star);
		var re_tag = reviewList[i].tag;
		
		// 별달기
		if(re_star != null && re_star != '' ) {
			$("#"+reviewList[i].buyd_no).children('span').removeClass('on'); //별 지우고
			$("#"+reviewList[i].buyd_no).children('span').eq(re_star-1).addClass('on').prevAll('span').addClass('on');
		}
	
		//태그 달기
		if(re_tag != null && re_tag != '') {
			re_tag = re_tag.split(",");
			for(var j=0; j < re_tag.length; j++) { // 태그 달아주고
				$(".tag-list-" + reviewList[i].review_no ).append("<li class='tag-item'>"+re_tag[j]+"<span class='del-btn' idx='"+j+"'></span><span style='display: none;'>"+ re_tag[j] +"</span></li>");
			}
		}
		
	}// for end
	
	

});

</script>

<div class="content">
    <div class="py-4 px-3 px-md-4">
    
    	<nav class="d-none d-md-block" aria-label="breadcrumb">
             <ol class="breadcrumb">
                 <li class="breadcrumb-item">
                     <a href="#">Review</a>
                 </li>
                 <li class="breadcrumb-item active" aria-current="page">Review</li>
             </ol>
         </nav>
         <!-- End Breadcrumb -->

         <div class="mb-3 mb-md-4 d-flex justify-content-between">
             <span class="h3 mb-0" style="float: left;">Review</span>
             <span class="h3 mb-0" style="float: right;">
             </span>
         </div>
         
         <div class="card mb-3 mb-md-4" style="max-width: 1000px;">
        
			<div style="padding: 50px;">
              	 <div class="rew_content">
               	
           		 <c:forEach var="review" items="${reList}">
            		<div>
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
	                       	<ul class="tag-list-${review.review_no}" style="padding-top: 10px;"></ul>
                      	</div>
                      </div>
                    </c:forEach>
             </div> 
                    	
     	</div>

        </div>
    </div>
</div>