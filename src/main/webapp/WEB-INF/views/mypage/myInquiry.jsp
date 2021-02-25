<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<script src = "http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer ></script>

<style>

.inqIcon {
	width: 20px; 
	height: 20px;
}

.paginate_button {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
}

span a.current {
  color: orange;
  /* background-color: orange; */
  
}

span a.current:hover {
	color: orange;
}

</style>

<script>

$(function() {
	
	$(".menu").children().removeClass('active');
	$("#myPage").addClass('active'); //메뉴 색 
	
	
	var inquiry = ${myInquiryList};
	
	if(inquiry.length == 0) {
		$("#inqTable").html("<div align= center><h4>등록된 문의가 없습니다.</h4><div>")
	}

	for(var i=0; i < inquiry.length; i++) {
		
		var secret = (inquiry[i].SECRET == 1) ? "<img src='${pageContext.request.contextPath}/images/etc/secret.png' class='inqIcon'>" : " ";
		var answer = (inquiry[i].ANSWER == null) ? 0 : 1
		
		$("#inqTbody").append("<tr class='inqTr'>"
				+ "<td style='display: none;'><a>"+ inquiry[i].INQUIRY_NO +"</a></td>"
				+ "<td><div align='center'>" + inquiry[i].NO + "</div><a style='display: none;'>"+ inquiry[i].MEM_ID +"</a></td>"
				+ "<td><div align='left'> [ " + inquiry[i].I_TYPE + " ] "+ inquiry[i].I_TITLE +"</div></td>"
				+ "<td><div align='center'>" + inquiry[i].Q_TYPE + "</div></td>"
				+ "<td><div align='center'>" + inquiry[i].Q_TITLE + "</div></td>"
				+ "<td><div align='center'>" + inquiry[i].INSERT_DATE + "</div></td>"
				+ "<td><div align='center'>"+ secret +"</div>"
				+ "<td><div align='center'><img src='${pageContext.request.contextPath}/images/etc/answer.png' class='inqIcon'> &nbsp; (" + answer + ")</div></td>"        
				);

	}
	
	 $('#foo-table').DataTable({
		// 표시 건수기능 숨기기
			"language": {
	        "emptyTable": "데이터가 없어요.",
	        "lengthMenu": "Show _MENU_",
	        "infoEmpty": "데이터가 없습니다.",
	        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
	        "search": "검색: ",
	        "zeroRecords": "일치하는 데이터가 없습니다.",
	        "loadingRecords": "로딩중...",
	        "processing":     "잠시만 기다려 주세요...",
	        "paginate": {
	            "next": ">",
	            "previous": "<"
	        }
	    	},
			lengthChange: true, //t-보이기 , f-숨기기
			searching: false,
			order: [ [ 1, 'asc'] ],
			ordering: true,
			info: false,
			paging: true,
			lengthMenu: [ 5, 10, 15, 20 ],
			displayLength: 5 
	  	});
	 
	 	var inquiry_no;
	 	
		// 문의 상세확인
		$(".inqTr").on('click', function() {
			inquiry_no = $(this).children().eq(0).children().text();
			var modal = $("#inq_Detail");
			
			$.ajax({
				  url: '${pageContext.request.contextPath}/myInquiry_d?inquiry_no=' + inquiry_no ,
				  success: function(data) {
					  
					 $("#answerDiv").css('display', 'none');
					 modal.find('#de_answer_date').text("");
					 modal.find('#de_answer').text("");
					  
					 modal.find('#d_type').text(data[0].Q_TYPE);
					 modal.find('#de_insert_date').text(data[0].INSERT_DATE);
					 modal.find('#de_title').text(data[0].Q_TITLE);
					 modal.find('#de_content').text(data[0].CONTENT);
					
					 if(data[0].ANSWER != null && data[0].ANSWER != '') {
						 $("#answerDiv").css('display', '');
						 modal.find('#de_answer_date').text(data[0].ANSWER_DATE);
						 modal.find('#de_answer').text(data[0].ANSWER);
					 }
					 modal.modal('show');
				  },
		  });
		});
	 
		$("#btnDel").on('click', function() {
			var del = confirm("삭제 하시겠습니까??");
			if(del) {
				$.ajax({
					  url: '${pageContext.request.contextPath}/myInquiryDel?inquiry_no=' + inquiry_no ,
					  success: function() {
							alert("삭제 되었습니다.");
							$(location).attr('href','${pageContext.request.contextPath}/myInquiry');
					  },
			  });
			}
		});
	
	
});


</script>
    
<section>
 	<div class="breadcrumb-option" > 
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__text">
                        <h2>My Inquiry</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <span>My Page</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
 
<section class="shop spad">
     <div class="container" >
        <div style="padding-top: 80px;" id="inqTable" align="center">
            <table  class="table table-hover" id="foo-table" style="width: 100%;">
            	<thead>
            		<tr>
            			<th style="display: none;"></th>
            			<th style="width: 3%"><div align="center">No</div></th>
            			<th style="width: 20%"><div align="center">상품</div></th>
            			<th style="width: 15%"><div align="center">분류</div></th>
            			<th style="width: 25%"><div align="center">제목</div></th>
            			<th style="width: 15%"><div align="center">등록일</div></th>
            			<th style="width: 7%"></th>
            			<th style="width: 15%"></th>
            		</tr>
            	</thead>
            	<tbody id="inqTbody"></tbody>
            </table>
          </div>
	</div>
</section>

<div class="modal fade" id="inq_Detail" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="max-width: 100%; width: auto; display: table;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">문의 확인</h5>
      </div>
      <div class="modal-body">
		<div class="form-group row">
			<div class="col-md-6 mb-6 mb-lg-6">
				<div><b id="d_type" style="color: #f08632; font-size: 20px;"></b></div>
			</div>
		</div>
	
		<div class="form-group row">
			<div class="col-md-12 mb-12 mb-lg-12">
				<span style="float: left" id="de_title"></span>
				<span style="float: right" id="de_insert_date"></span>
			</div>
		</div>
		<hr>
		<div class="form-group row">
			<div class="col-md-12 mb-12 mb-lg-12">
				<div id="de_content" style="width: 400px; height: 200px;"></div>
			</div>
		</div>
		
		<div id="answerDiv" style="display: none;">
		<hr>
			<div class="form-group row">
				<div class="col-md-12 mb-12 mb-lg-12">
					<span style="float: left">답변</span>
					<span style="float: right" id="de_answer_date"></span>
				</div>
			</div>
			<hr>
			<div class="form-group row">
				<div class="col-md-12 mb-12 mb-lg-12">
					<div id="de_answer" style="width: 400px; height: 200px;"></div>
				</div>
			</div>
		</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="btnDel">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div><!-- modal end -->





</section>