<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Title -->
    <title>seller</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/seller/public/img/favicon.ico"> <!-- 주소창 로고? -->
    <!-- DEMO CHARTS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/seller/public/demo/chartist.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/seller/public/demo/chartist-plugin-tooltip.css">
    <!-- Template -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/seller/public/graindashboard/css/graindashboard.css">
	
<style>
.modalDiv {
	padding: 10px;
}

.btn-secondary {
    color: #fff;
    background-color: #265df1;
    border-color: #265df1;
}
textarea {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border: solid 1px ;
	border-radius: 5px;
	font-size: 16px;
	resize: both;
		}
</style>	

<script>
$(function() {
	
	$("#btnAnswer").on('click', function() {
		var answer = $("#de_answer").val();
		var inquiry_no = $("#inquiry_no").text();

		$.ajax({
			url : '${pageContext.request.contextPath}/seller/updateAnswer',
			type : 'POST',
			data : { answer : answer, inquiry_no : inquiry_no},
			success : function (data) {
				alert("답변이 등록되었습니다.");
				$(location).attr('href','${pageContext.request.contextPath}/seller/inquiryList');
			}
		});
	});
})


</script>
	
	 
</head>
<body class="has-sidebar has-fixed-sidebar-and-header">

<header class="header bg-body">
    <nav class="navbar flex-nowrap p-0">
        <div class="navbar-brand-wrapper d-flex align-items-center col-auto">
            <!-- Logo For Mobile View -->
            <a class="navbar-brand navbar-brand-mobile" href="/">
                <img class="img-fluid w-100" src="${pageContext.request.contextPath}/seller/public/img/logo-mini.png" alt="Graindashboard">
            </a>
            <!-- End Logo For Mobile View -->

            <!-- Logo For Desktop View -->
            <a class="navbar-brand navbar-brand-desktop" href="${pageContext.request.contextPath}/seller/home">
                <img class="side-nav-show-on-closed" src="${pageContext.request.contextPath}/seller/public/img/logo-mini.png" alt="Graindashboard" style="width: auto; height: 33px;">
                <img class="side-nav-hide-on-closed" src="${pageContext.request.contextPath}/seller/public/img/logo-mini.png" alt="Graindashboard" style="width: auto; height: 33px;">
            </a>
            <!-- End Logo For Desktop View -->
        </div>

        <div class="header-content col px-md-3">
            <div class="d-flex align-items-center">
                <!-- Side Nav Toggle -->
                <a  class="js-side-nav header-invoker d-flex mr-md-2" href="#"
                    data-close-invoker="#sidebarClose"
                    data-target="#sidebar"
                    data-target-wrapper="body">
                    <i class="gd-align-left"></i>
                </a>
                <!-- End Side Nav Toggle -->

                <!-- User Notifications -->
                <div class="dropdown ml-auto">
                    <a id="notificationsInvoker" class="header-invoker" href="#" aria-controls="notifications" aria-haspopup="true" aria-expanded="false" data-unfold-event="click" data-unfold-target="#notifications" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                        <span class="indicator indicator-bordered indicator-top-right indicator-primary rounded-circle"></span>
                        <i class="gd-bell"></i>
                    </a>

                    <div id="notifications" class="dropdown-menu dropdown-menu-center py-0 mt-4 w-18_75rem w-md-22_5rem unfold-css-animation unfold-hidden" aria-labelledby="notificationsInvoker" style="animation-duration: 300ms;">
                        <div class="card">
                            <div class="card-header d-flex align-items-center border-bottom py-3">
                                <h5 class="mb-0">Notifications</h5>
                                <a class="link small ml-auto" href="#">Clear All</a>
                            </div>

                            <div class="card-body p-0">
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item list-group-item-action">
                                        <div class="d-flex align-items-center text-nowrap mb-2">
                                            <i class="gd-info-alt icon-text text-primary mr-2"></i>
                                            <h6 class="font-weight-semi-bold mb-0">New Update</h6>
                                            <span class="list-group-item-date text-muted ml-auto">just now</span>
                                        </div>
                                        <p class="mb-0">
                                            Order <strong>#10000</strong> has been updated.
                                        </p>
                                        <a class="list-group-item-closer text-muted" href="#"><i class="gd-close"></i></a>
                                    </div>
                                    <div class="list-group-item list-group-item-action">
                                        <div class="d-flex align-items-center text-nowrap mb-2">
                                            <i class="gd-info-alt icon-text text-primary mr-2"></i>
                                            <h6 class="font-weight-semi-bold mb-0">New Update</h6>
                                            <span class="list-group-item-date text-muted ml-auto">just now</span>
                                        </div>
                                        <p class="mb-0">
                                            Order <strong>#10001</strong> has been updated.
                                        </p>
                                        <a class="list-group-item-closer text-muted" href="#"><i class="gd-close"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End User Notifications -->
                <!-- User Avatar -->
                <div class="dropdown mx-3 dropdown ml-2">
                    <a id="profileMenuInvoker" class="header-complex-invoker" href="#" aria-controls="profileMenu" aria-haspopup="true" aria-expanded="false" data-unfold-event="click" data-unfold-target="#profileMenu" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                        <!--img class="avatar rounded-circle mr-md-2" src="#" alt="John Doe"-->
                        <span class="mr-md-2 avatar-placeholder">${fn:substring(sessionScope.seller.seller_id,0,1) } <br></span>
                        <span class="d-none d-md-block">${sessionScope.seller.nic_name}</span>
                        <i class="gd-angle-down d-none d-md-block ml-2"></i>
                    </a>

                    <ul id="profileMenu" class="unfold unfold-user unfold-light unfold-top unfold-centered position-absolute pt-2 pb-1 mt-4 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="profileMenuInvoker" style="animation-duration: 300ms;">
                        <li class="unfold-item">
                            <a class="unfold-link d-flex align-items-center text-nowrap" href="#">
                    			<span class="unfold-item-icon mr-3"><i class="gd-user"></i></span>
                                My Profile
                            </a>
                        </li>
                        <li class="unfold-item unfold-item-has-divider">
                            <a class="unfold-link d-flex align-items-center text-nowrap" href="${pageContext.request.contextPath}/logout">
                    			<span class="unfold-item-icon mr-3"><i class="gd-power-off"></i></span>
                                Sign Out
                            </a>
                        </li>
                    </ul>
                </div>
                <!-- End User Avatar -->
            </div>
        </div>
    </nav>
</header>
<!-- End Header -->


<main class="main">
    <!-- Sidebar Nav -->
    <aside id="sidebar" class="js-custom-scroll side-nav">
        <ul id="sideNav" class="side-nav-menu side-nav-menu-top-level mb-0">
            <!-- Title -->
            <li class="sidebar-heading h6">Dashboard</li>
            <!-- End Title -->

            <!-- Dashboard -->
            <li class="side-nav-menu-item" id="order">
                <a class="side-nav-menu-link media align-items-center" href="${pageContext.request.contextPath}/seller/orderList">
              <span class="side-nav-menu-icon d-flex mr-3">
                <i class="gd-file"></i>
              </span>
                    <span class="side-nav-fadeout-on-closed media-body">주문정보</span>
                </a>
            </li>
            <!-- End Dashboard -->

            <!-- Documentation -->
            <li class="side-nav-menu-item" id="sales">
                <a class="side-nav-menu-link media align-items-center" href="${pageContext.request.contextPath}/seller/salesList">
              <span class="side-nav-menu-icon d-flex mr-3">
                <i class="gd-file"></i>
              </span>
                    <span class="side-nav-fadeout-on-closed media-body">매출정보</span>
                </a>
            </li>
            <!-- End Documentation -->

            <!-- Title -->
            <li class="sidebar-heading h6">Examples</li>
            <!-- End Title -->

            <!-- Users -->
            <li class="side-nav-menu-item side-nav-has-menu" id="itemMenu">
                <a class="side-nav-menu-link media align-items-center" href="#"
                   data-target="#subUsers">
                  <span class="side-nav-menu-icon d-flex mr-3">
                    <i class="gd-user"></i>
                  </span>
                    <span class="side-nav-fadeout-on-closed media-body">스토어 관리</span>
                    <span class="side-nav-control-icon d-flex">
                <i class="gd-angle-right side-nav-fadeout-on-closed"></i>
              </span>
                    <span class="side-nav__indicator side-nav-fadeout-on-closed"></span>
                </a>

                <!-- Users: subUsers -->
                <ul id="subUsers" class="side-nav-menu side-nav-menu-second-level mb-0">
                    <li class="side-nav-menu-item" id="itemLi">
                        <a class="side-nav-menu-link" href="${pageContext.request.contextPath}/seller/itemList">상품 관리</a>
                    </li>
                    <li class="side-nav-menu-item" id="inquiryLi">
                        <a class="side-nav-menu-link" href="${pageContext.request.contextPath}/seller/inquiryList">문의 관리</a>
                    </li>
                </ul>
                <!-- End Users: subUsers -->
            </li>
            <!-- End Users -->

        </ul>
    </aside>
    <!-- End Sidebar Nav -->
    
    <div class="content">
    
     <tiles:insertAttribute name="body"/>
     
        <!-- Footer -->
        <footer class="small p-3 px-md-4 mt-auto">
            <div class="row justify-content-between">
                <div class="col-lg text-center text-lg-left mb-3 mb-lg-0">
                    <ul class="list-dot list-inline mb-0">
                        <li class="list-dot-item list-dot-item-not list-inline-item mr-lg-2"><a class="link-dark" href="#">FAQ</a></li>
                        <li class="list-dot-item list-inline-item mr-lg-2"><a class="link-dark" href="#">Support</a></li>
                        <li class="list-dot-item list-inline-item mr-lg-2"><a class="link-dark" href="#">Contact us</a></li>
                    </ul>
                </div>

                <div class="col-lg text-center mb-3 mb-lg-0">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item mx-2"><a class="link-muted" href="#"><i class="gd-twitter-alt"></i></a></li>
                        <li class="list-inline-item mx-2"><a class="link-muted" href="#"><i class="gd-facebook"></i></a></li>
                        <li class="list-inline-item mx-2"><a class="link-muted" href="#"><i class="gd-github"></i></a></li>
                    </ul>
                </div>

                <div class="col-lg text-center text-lg-right">
                    &copy; 2019 Graindashboard. All Rights Reserved.
                </div>
            </div>
        </footer>
        <!-- End Footer -->
    </div>
</main>

<div class="modal fade" id="inq_Detail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: 700px;">
  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">문의 확인</h5>
      </div>
      <div class="modal-body" style="height: 450px;">
			<div class="modalDiv">
				<div>
					<b id="d_type" style="color: #f08632; font-size: 20px;"></b>
					<b id="inquiry_no" style="display: none;"></b>
				</div>
			</div>
			<div class="modalDiv" style="height: 30px;">
				<span style="float: left" id="de_title"></span>
				<span style="float: right" id="de_insert_date"></span>
			</div>
			<div class="modalDiv">
				<textarea rows="5" cols="70" id="de_content" readonly="readonly"></textarea>
			</div>
		
		<div id="answerDiv">
			<div class="modalDiv">
				<span style="float: left">답변</span>
				<span style="float: right" id="de_answer_date"></span>
			</div>
			<div class="modalDiv">
				<textarea rows="5" cols="70" id="de_answer"></textarea>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="btnAnswer">답변 등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<script src="${pageContext.request.contextPath}/seller/public/graindashboard/js/graindashboard.js"></script>
<script src="${pageContext.request.contextPath}/seller/public/graindashboard/js/graindashboard.vendor.js"></script>

<!-- DEMO CHARTS -->
<script src="${pageContext.request.contextPath}/seller/public/demo/resizeSensor.js"></script>
<script src="${pageContext.request.contextPath}/seller/public/demo/chartist.js"></script>
<script src="${pageContext.request.contextPath}/seller/public/demo/chartist-plugin-tooltip.js"></script>
<script src="${pageContext.request.contextPath}/seller/public/demo/gd.chartist-area.js"></script>
<script src="${pageContext.request.contextPath}/seller/public/demo/gd.chartist-bar.js"></script>
<script src="${pageContext.request.contextPath}/seller/public/demo/gd.chartist-donut.js"></script>
<script>
    $.GDCore.components.GDChartistArea.init('.js-area-chart');
    $.GDCore.components.GDChartistBar.init('.js-bar-chart');
    $.GDCore.components.GDChartistDonut.init('.js-donut-chart');
</script>


</body>
</html>