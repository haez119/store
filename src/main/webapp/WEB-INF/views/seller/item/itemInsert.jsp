<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

<style>
.stars {
	color: red;
}

select { 
	width: 200px; /* 원하는 너비설정 */ 
	padding: .5em .5em; /* 여백으로 높이 설정 */ 
	font-family: inherit; /* 폰트 상속 */ 
	background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%; /* 네이티브 화살표 대체 */ 
	border: 1px solid #999; 
	border-radius: 10px; /* iOS 둥근모서리 제거 */ 
	-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
	-moz-appearance: none; 
	appearance: none; 
}

</style>


<script>
	$(function() {
		
		var item_type = "${item.type}";
		if(item_type != null && item_type != '') {
			$("#btnItemAdd").text("수정");
			$("#type").val(item_type).prop("selected", true);
		}
		
		$("#pics").change(function(){
			var fileList = $(this)[0].files;
			var nameList = '';
			for(var i=0; i<fileList.length; i++) {
				nameList += fileList[i].name + ",";
			}
			$("#pics_name").text(nameList);
		});
		
		$("#pics_d").change(function(){
			var fileList = $(this)[0].files;
			var nameList = '';
			for(var i=0; i<fileList.length; i++) {
				nameList += fileList[i].name + ",";
			}
			$("#pics_d_name").text(nameList);
		});
		
		
		$("#btnItemAdd").on('click', function(event) {
			
			if( $("#type option:selected").val() == null || $("#type option:selected").val() == '') {
				alert("상품 분류를 선택하세요.");
				event.preventDefault();
			} else if( $("#price").val() == null || $("#price").val() == '' ) {
				alert("가격을 입력하세요.");
				$("#price").focus();
				event.preventDefault();
			}  else if( $("#stock").val() == null || $("#stock").val() == '' ) {
				alert("재고를 입력하세요.");
				$("#stock").focus();
				event.preventDefault();
			}  else if( $("#title").val() == null || $("#title").val() == '' ) {
				alert("상품명 입력하세요.");
				$("#title").focus();
				event.preventDefault();
			}  else if( $("#content").val() == null || $("#content").val() == '' ) {
				alert("상품 소개 입력하세요.");
				$("#content").focus();
				event.preventDefault();
			} else if( $("#pics_name").text() == null || $("#pics_name").text() == '' ) {
				alert("대표 사진을 1개 이상 등록하세요.");
				event.preventDefault();
			} else if( $("#pics_d_name").text() == null || $("#pics_d_name").text() == '' ) {
				alert("상세 사진을 1개 이상 들록하세요.");
				event.preventDefault();
			} 
		});
		
		
		
	});

</script>

<div class="content">
        <div class="py-4 px-3 px-md-4">
            <div class="card mb-3 mb-md-4">

                <div class="card-body">
                    <!-- Breadcrumb -->
                    <nav class="d-none d-md-block" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="#">Item</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Item Add</li>
                        </ol>
                    </nav>
                    <!-- End Breadcrumb -->

                    <div class="mb-3 mb-md-4 d-flex justify-content-between">
                        <div class="h3 mb-0">상품 등록</div>
                    </div>


                    <!-- Form -->
                    <div>
                        <form method="post" encType="multipart/form-data" id="frmInsert" action="${pageContext.request.contextPath}/seller/itemInsert">
                            <div class="form-row">
                                <div class="form-group col-12 col-md-6">
                                     <select id="type" name="type">
	                                	<option value="">선택</option>
	                                    <option value="TOP">TOP</option>
	                                    <option value="BOTTOM">BOTTOM</option>
	                                    <option value="SHOES">SHOES</option>
	                                    <option value="BAG">BAG</option>
	                                    <option value="ETC">ETC</option>
	                                </select>
                                </div>
                              </div>
                           	  <div class="form-row">
                                <div class="form-group col-12 col-md-6">
                                    <label for="price">가격<z class="stars">*</z></label>
                                    <input type="text" class="form-control" id="price" name="price" placeholder="숫자만 입력" value="${item.price}">
                                </div>
                                <div class="form-group col-12 col-md-6">
                                    <label for="stock">재고<z class="stars">*</z></label>
                                    <input type="text" class="form-control" id="stock" name="stock" placeholder="숫자만 입력" value="${item.stock}">
                                </div>
                              </div>
                              <div class="form-row">
                                <div class="form-group col-12 col-md-12">
                                    <label for="title">상품명<z class="stars">*</z></label>
                                    <input type="text" class="form-control" id="title" name="title" value="${item.title}">
                                </div>
                              </div>
                              <div class="form-row">
                                <div class="form-group col-12 col-md-12">
                                    <label for="content">상품 소개<z class="stars">*</z></label>
                                    <textarea rows="4" cols="10" class="form-control" id="content" name="content">${item.content}</textarea>
                                </div>
                              </div>
                              
							  <div class="form-row">
                                <div class="form-group col-12 col-md-12">
                                    <label for="content">상품 상세</label>
                                    <textarea class="summernote" name="content_d" id="summernote">${item.content_d}</textarea>    
                                </div>
                              </div>
                              <div class="form-row">
                                <div class="form-group col-12 col-md-12">
                                    <label for="content">대표 사진<z class="stars">*</z></label><br>
                                    <input type="file" name="pics" id="pics" multiple="multiple"/><br>
                                    <p id="pics_name" style="padding-top: 8px;">${item.pic}</p>
                                </div>
                              </div>
                              
                              <div class="form-row">
                                <div class="form-group col-12 col-md-12">
                                    <label for="content">상세 사진<z class="stars">*</z></label><br>
                                    <input type="file" name="pics_d" id="pics_d" multiple="multiple"/><br>
                                    <p id="pics_d_name" style="padding-top: 8px;">${item.pic_d}</p>
                                </div>
                              </div>
                              
                            <button type="submit" class="btn btn-primary float-right" id="btnItemAdd">등록</button>
                        </form>
                    </div>
                    <!-- End Form -->
                </div>
            </div>
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
 </div>

