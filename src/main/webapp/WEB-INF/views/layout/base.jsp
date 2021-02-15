<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="zxx">
<head>
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>


	
	<meta charset="UTF-8">
    <meta name="description" content="Cake Template">
    <meta name="keywords" content="Cake, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
    <title>storeFarm</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
    rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/flaticon.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/barfiller.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store/css/style.css" type="text/css">
<style>
	.myContent{
		padding: 100px 0px 150px 0px;
	}
</style>

<script>
$(function() {
	
	var id = "${sessionScope.member.mem_id}";
	if (id == null || id == '') {
		$(".my").on('click', function() {
			alert("로그인 후에 이용할 수 있습니다.");
		});
	} else {
		$("#idUL").addClass("dropdown").css('display', '');
		
		$(".my").on('click', function() {
			var name = $(this).text();
			if(name == 'Cart') {
				$(location).attr('href','${pageContext.request.contextPath}/cartMain');
			} else if (name == 'Order' ) {
				$(location).attr('href','${pageContext.request.contextPath}/buyList?buy_no=no');
			} else if (name == 'My Page') {
				//$(location).attr('href','${pageContext.request.contextPath}/cartMain');
			}
		});
	}

});
</script>

</head>
<body>
	<!-- 모바일 버전일 때 헤더  -->
    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__cart">
            <div class="offcanvas__cart__links">
                <a href="#" class="search-switch" ><img src="${pageContext.request.contextPath}/store/img/icon/search.png" alt=""></a>
                <a href="#"><img src="${pageContext.request.contextPath}/store/img/icon/heart.png" alt=""></a>
            </div>
            <div class="offcanvas__cart__item">
                <a href="${pageContext.request.contextPath}/cartMain"><img src="${pageContext.request.contextPath}/store/img/icon/cart.png" alt=""> <span>0</span></a>
                <div class="cart__price">Cart: <span>$0.00</span></div>
            </div>
        </div>
        <div class="offcanvas__logo">
            <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/store/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__option">
            <ul>
            	<c:if test="${sessionScope.member.mem_id eq null }" >
					<li><a href="${pageContext.request.contextPath}/loginForm">Sign in</a> <span class="arrow_carrot-down"></span>
	                	<ul>
	                        <li style="width: 100px;"><a href="${pageContext.request.contextPath}/loginForm" style="color: white;">Sign in</a></li>
	                        <li style="width: 100px;"><a href="${pageContext.request.contextPath}/registerForm" style="color: white;">Sign up</a></li>
	                    </ul>
	                </li>
                </c:if>
                <c:if test="${sessionScope.member.mem_id ne null }" >
                	<li><a href="${pageContext.request.contextPath}/logout">logout</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    
    
	 <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="header__top__inner">
                            <div class="header__top__left">
                                <ul>
                                	<c:if test="${sessionScope.member.mem_id eq null }" >
	 									<li><a href="${pageContext.request.contextPath}/loginForm">Sign in</a> <span class="arrow_carrot-down"></span>
	                                    	<ul>
	                                            <li style="width: 100px;"><a href="${pageContext.request.contextPath}/loginForm" style="color: white;">Sign in</a></li>
	                                            <li style="width: 100px;"><a href="${pageContext.request.contextPath}/registerForm" style="color: white;">Sign up</a></li>
	                                        </ul>
	                                    </li>
	                                </c:if>
	                                <c:if test="${sessionScope.member.mem_id ne null }" >
                                    	<li><a href="${pageContext.request.contextPath}/logout">logout</a></li>
                                    </c:if>
                                </ul>
                            </div>
                            <div class="header__logo">
                                <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/store/img/logo.png" alt=""></a>
                            </div>
                            <div class="header__top__right">
                                <div class="header__top__right__links">
                                    <a href="#" class="search-switch" ><img src="${pageContext.request.contextPath}/store/img/icon/search.png" alt=""></a>
                                    <a href="#"><img src="${pageContext.request.contextPath}/store/img/icon/heart.png" alt=""></a>
                                </div>
                                <div class="header__top__right__cart">
                                    <a href="${pageContext.request.contextPath}/cartMain"><img src="${pageContext.request.contextPath}/store/img/icon/cart.png" alt=""> <span>0</span></a>
                                    <div class="cart__price">Cart: <span>$0.00</span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="canvas__open"><i class="fa fa-bars"></i></div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <nav class="header__menu mobile-menu">
                        <ul class="menu">
                            <li class="active"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li id="shop"><a href="${pageContext.request.contextPath}/shopMain">Shop</a></li>
                            <li id="cart"><a class="my" href="#">Cart</a></li>
                            <li id="order"><a class="my" href="#">Order</a></li>
                            <li id="myPage"><a class="my" href="#">My Page</a>
                                <ul id="idUL" style="display: none;">
                                    <li><a href="#">정보수정</a></li>
                                    <li><a href="#">찜목록</a></li>
                                    <li><a href="#">내가 쓴 리뷰</a></li>
                                    <li><a href="#">문의 내역</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- Header Section End -->

	 <tiles:insertAttribute name="body"/>
	 
	  <!-- Footer Section Begin -->
    <footer class="footer set-bg" data-setbg="${pageContext.request.contextPath}/store/img/footer-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="footer__widget">
                        <h6>WORKING HOURS</h6>
                        <ul>
                            <li>Monday - Friday: 08:00 am – 08:30 pm</li>
                            <li>Saturday: 10:00 am – 16:30 pm</li>
                            <li>Sunday: 10:00 am – 16:30 pm</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="footer__about">
                        <div class="footer__logo">
                            <a href="#"><img src="${pageContext.request.contextPath}/store/img/footer-logo.png" alt=""></a>
                        </div>
                        <p>Lorem ipsum dolor amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                        labore dolore magna aliqua.</p>
                        <div class="footer__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="footer__newslatter">
                        <h6>Subscribe</h6>
                        <p>Get latest updates and offers.</p>
                        <form action="#">
                            <input type="text" placeholder="Email">
                            <button type="submit"><i class="fa fa-send-o"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <p class="copyright__text text-white"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                          Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                          <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                      </p>
                  </div>
                  <div class="col-lg-5">
                    <div class="copyright__widget">
                        <ul>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Terms & Conditions</a></li>
                            <li><a href="#">Site Map</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Footer Section End -->

<!-- Search Begin -->
<div class="search-model" id="searchModel">
    <div class="h-100 d-flex align-items-center justify-content-center">
        <div class="search-close-switch" >+</div>
        <form class="search-model-form">
            <input type="text" id="search-input" placeholder="Search here.....">
        </form>
    </div>
</div>
<!-- Search End -->



<!-- Js Plugins -->
<script src="${pageContext.request.contextPath}/store/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/store/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/store/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/store/js/jquery.barfiller.js"></script>
<script src="${pageContext.request.contextPath}/store/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/store/js/jquery.slicknav.js"></script>
<script src="${pageContext.request.contextPath}/store/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/store/js/jquery.nicescroll.min.js"></script>
<script src="${pageContext.request.contextPath}/store/js/main.js"></script>


</body>
</html>