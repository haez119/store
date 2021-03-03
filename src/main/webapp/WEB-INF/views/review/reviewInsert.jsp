<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

<style>
.starR{
	  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	  background-size: auto 100%;
	  width: 30px;
	  height: 30px;
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


</style>

<script>
var counter = 0;
var tag =[];

$(function() {
	
	$(".menu").children().removeClass('active');
	$("#myPage").addClass('active'); //메뉴 색 
	
	
	var star = 5;
	
	// update 일 경우
	var re_star = "${review.star}"; // 별 가져와서
	
	if(re_star != null && re_star != '' ) {
		$("#star").val("");
		$("#star").val(re_star);
		$(".starRev").children('span').removeClass('on'); 
		$("." + re_star).addClass('on').prevAll('span').addClass('on'); // 별 달아주고

		// 태그 가져와서
		var re_tag = "${review.tag}"
		
		if(re_tag != null && re_tag != '' ) {
			re_tag = re_tag.split(",");
			
			for(var i=0; i < re_tag.length; i++) { // 태그 달아주고
				$("#tag-list").append("<li class='tag-item'>"+re_tag[i]+"<span class='del-btn' idx='"+i+"'>x</span></li>");
				addTag (re_tag[i]);
			}
		}
	}
	
	
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  star = $(this).text()
		  $("#star").val("");
		  $("#star").val(star);
		  return false;
		});
	
	$("#tag").on("keypress", function (e) {
		var self = $(this);
		//특수문자 금지
		if(  (e.keyCode >= 123 && e.keyCode <= 130) || 
			 (e.keyCode >= 33 && e.keyCode <= 47) || 
			 (e.keyCode >= 58 && e.keyCode <= 64) || 
			 (e.keyCode >= 91 && e.keyCode <= 94) ||
			 (e.keyCode == 96) ){ 
			e.preventDefault(); 
		}
		// 엔터나 스페이스바 눌렀을 때
        if (e.key === "Enter" || e.keyCode == 32) {
            var tagValue = self.val(); // 값 가져오기
            
            if (tagValue !== "") { // null이 아닐 때
                
                var result = Object.values(tag).filter(function (word) {
                    return word === "#"+tagValue; //태그 중복검사
                })
            
                if (result.length == 0) { // 중복이 아닐 때
                	tagValue = "#"+tagValue;
                    $("#tag-list").append("<li class='tag-item'>"+tagValue+"<span class='del-btn' idx='"+counter+"'>x</span></li>");
                    addTag(tagValue);
                    self.val("");
                } else {
                    alert("이미 작성한 태그입니다.");
                }
            }
            e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
        }
	});
	
	// 태그 삭제하기
	 $("body").on("click", ".del-btn", function (e) {
         var index = $(this).attr("idx");
         console.log("삭제 기준되는 인덱스 " , index)
         tag.splice(index, 1);
         $(this).parent().remove();
         counter--;
     });
	
	$("#btnReview").on('click', function() {
		$("#tagNone").val(tag);
		
		if( $("#title").val() == null || $("#title").val() == '') {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			event.preventDefault();
		} else if( $("#summernote").val() == null || $("#summernote").val() == '' ) {
			alert("내용을 입력해주세요.");
			event.preventDefault();
		} else {
			alert("등록 되었습니다.");
			$("#frmInsert").attr('action','${pageContext.request.contextPath}/reviewInsert');
			$("#frmInsert").submit();
		}
		
	}); 
	
});

function addTag (value) {
    tag[counter] = value;
    counter++;
    $("#tagNone").val(tag); 
}

</script>
<section style="min-height: 300px;" class="shop spad">

<div class="container">
<div class="breadcrumb__text" style="padding: 50px 30px 20px 30px;">
    <h2>Review</h2>
</div>
<form id="frmInsert" method="post" accept-charset="utf-8">
	<div align="center" >
		<div class="starRev" style="padding-bottom: 40px;">
		  <span class="starR on 1">1</span>
		  <span class="starR on 2">2</span>
		  <span class="starR on 3">3</span>
		  <span class="starR on 4">4</span>
		  <span class="starR on 5">5</span>
		  <input id="star" name="star" value="5" style="display: none;"> 
		</div>
		<table>
			<tr>
				<td style="width: 150px; height: 150px;">
					<img src="${pageContext.request.contextPath}/images/item/${item.pic}">
				</td>
				<td style="width: 150px;" align="center">${item.title}</td>
				<td style="width: 150px;" align="center">${item.price} 원</td>
			</tr>
		</table>
		
	</div>
	<div class="checkout__input" align="center" > 
		<input type="text" id="title" name="title" placeholder="제목" value="${review.title}">
	</div>
	<div class="container" style="padding: 10px 0px 20px 0px;">
  		<textarea class="summernote" name="content" id="summernote">${review.content}</textarea>    
	</div>
	
	<div align="center" style="padding-bottom: 20px;">
		<div class="checkout__input" style="width: 300px; padding-bottom: 20px;" align="center" > 
			<input type="text" id="tag">
			<ul id="tag-list"></ul>
			<input name="tag" id="tagNone" style="display: none;">
		</div>
		<button class="btn primary-btn" id="btnReview">등록</button>
	</div>
</form>



	<script>
	$('.summernote').summernote({
		  // 에디터 높이
		  height: 300,
		  // 에디터 한글 설정
		  lang: "ko-KR",
		  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
		  focus : true,
		  toolbar: [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			    ['insert',['picture','link','video']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview','fullscreen', 'help']]
			  ],
			  // 추가한 글꼴
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			 // 추가한 폰트사이즈
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		});
		$('.dropdown-toggle').dropdown()

	</script>
</div>
</section>





