<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function() {
		var re = "${login}";
		if(re) { alert("로그인 되었습니다."); }
		
		var mainList = ${mainList};

		for(var i=0; i < 6; i++) {
			if(i%3 == 0) {
				var img = "<div class='col-lg-4 col-md-4 col-sm-4 col-6' ><div class='instagram__pic'><img src='${pageContext.request.contextPath}/images/item/" + mainList[i].PIC + "' ></div></div>"
				$("#imgDiv").append(img)
			} else {
				var img = "<div class='col-lg-4 col-md-4 col-sm-4 col-6' ><div class='instagram__pic middle__pic'><img src='${pageContext.request.contextPath}/images/item/" + mainList[i].PIC + "' ></div></div>"
				$("#imgDiv").append(img)
			}
			
		}
		
		
		
		
	});
</script>

 <!-- Instagram Section Begin -->
    <section class="instagram spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 p-0">
                    <div class="instagram__text">
                        <div class="section-title">
                            <span>store farm</span>
                            <h2>Popular item</h2>
                        </div>
                        <h5><i class="fa fa-instagram"></i> @storeFarm</h5>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="row" id="imgDiv">
                        
                       
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Instagram Section End -->
