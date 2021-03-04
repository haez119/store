<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
 
<script>
$(function() {
	$("#today").text(getToday());
	
	var today = ${today};
	if(today == null || today == '') {
		$("#todaySales").text("0");	
	} else {
		$("#todaySales").append("<span class='text-success'> + </span>" + today[0].SUM);
	}
	
	var chart = "<div class='js-area-chart chart chart--axis-x--nowrap chart--points-invisible position-relative mh-15_6 safari-overflow-hidden pt-4 pt-md-5 pb-1'"
		+ "data-series='[ ["
		+ "{\"meta\":\"6/01/2019 9:00 PM\",\"value\":\"1200\"},"
  		+ "{\"meta\":\"6/02/2019 9:00 PM\",\"value\":\"800\"},"
        + "{\"meta\":\"6/03/2019 9:00 PM\",\"value\":\"900\"},"
        + "{\"meta\":\"6/04/2019 9:00 PM\",\"value\":\"1600\"},"
        + "{\"meta\":\"6/05/2019 9:00 PM\",\"value\":\"1700\"},"
        + "{\"meta\":\"6/06/2019 9:00 PM\",\"value\":\"1400\"},"
        + "{\"meta\":\"6/07/2019 9:00 PM\",\"value\":\"1500\"},"
        + "{\"meta\":\"6/10/2019 9:00 PM\",\"value\":\"1500\"},"
        + "{\"meta\":\"6/17/2019 9:00 PM\",\"value\":\"1500\"},"
        + "{\"meta\":\"6/10/2019 9:00 PM\",\"value\":\"1500\"},"
        + "{\"meta\":\"6/27/2019 9:00 PM\",\"value\":\"1500\"},"
        + "{\"meta\":\"6/30/2019 9:00 PM\",\"value\":\"2300\"}]]'"
        + "data-labels='[ \"June 01\",\"June 02\",\"June 03\",\"June 04\",\"June 05\",\"June 06\",\"June 07\",\"June 08\",\"June 09\",\"June 10\",\"June 11\",\"June 12\",\"June 13\",\"June 14\",\"June 15\",\"June 16\",\"June 17,\"June 29\",\"June 30\"]'"
        + "data-labels-qty='3'"
        + "data-labels-start-from='1'"
        + "data-prefix='$'"
        + "data-height='250'"
        + "data-mobile-height='75'"
        + "data-high='3000'"
        + "data-low='500'"
        + "data-offset-x='30'"
        + "data-offset-y='60'"
        + "data-is-line-smooth='[false]'"
        + "data-line-width='[\"1px\"]'"
        + "data-line-colors='[\"#8069f2\"]'"
        + "data-fill-opacity=\"1\""
        + "data-fill-colors='[\"#ecebfa\"]'"
        + "data-text-size-x=\"14px\""
        + "data-text-color-x=\"#4a4e69\""
        + "data-text-offset-top-x=\"10\""
        + "data-text-align-axis-x=\"center\""
        + "data-text-size-y=\"14px\""
        + "data-text-color-y=\"#868e96\""
        + "data-is-show-tooltips=\"true\""
        + "data-is-tooltip-divided=\"true\""
        + "data-tooltip-custom-class=\"chart-tooltip--divided chart-tooltip__value--bg-black chart-tooltip__meta--bg-primary small text-white\""
        + "data-tooltip-currency=\"USD \""
        + "data-is-show-points=\"true\""
        + "data-point-custom-class='chart__point--donut chart__point--has-line-helper chart__point--border-xxs border-primary rounded-circle'"
        + "data-point-dimensions='{\"width\":8,\"height\":8}'>"
     	+ "</div>"
     	
     	
	//$("#chart").append(chart);
	console.log(chart)
	
});

function getToday(){
	    var now = new Date();
	    var year = now.getFullYear();
	    var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
	    var date = now.getDate();

	    month = month >=10 ? month : "0" + month;
	    date  = date  >= 10 ? date : "0" + date;
	    return today = ""+year + "-" + month + "-" + date; 
	}

</script>  
    
 <div class="content">
 		<div class="py-4 px-3 px-md-4">

            <div class="mb-3 mb-md-4 d-flex justify-content-between">
                <div class="h3 mb-0">Dashboard</div>
            </div>

            <div class="row">

                <div class="col-md-6 col-xl-4 mb-3 mb-xl-4">
                    <!-- Widget -->
                    <div class="card flex-row align-items-center p-3 p-md-4">
                        <div class="icon icon-lg bg-soft-secondary rounded-circle mr-3">
                            <i class="gd-wallet icon-text d-inline-block text-secondary"></i>
                        </div>
                        <div>
                            <h4 class="lh-1 mb-1"> 
                            	<fmt:formatNumber type="number" value="${total}" pattern="##,###" /> 원 
                            </h4>
                            <h6 class="mb-0">Total Sales</h6> <!-- 총 매출 -->
                        </div>
                        <i class="gd-arrow-up icon-text d-flex text-danger ml-auto"></i>
                    </div>
                    <!-- End Widget -->
                </div>


            </div>

            <div class="row">
                <div class="col-12"> <!-- 일별 매출 -->
                    <!-- Card -->
                    <div class="card mb-3 mb-md-4">
                        <div class="card-header border-bottom p-0">
                            <ul id="wallets" class="nav nav-v2 nav-primary nav-justified d-block d-xl-flex w-100" role="tablist">
                                <li class="nav-item border-bottom border-xl-bottom-0">
                                    <a class="nav-link d-flex align-items-center py-2 px-3 p-xl-4 active" href="#bitcoin" role="tab" aria-selected="true"
                                       data-toggle="tab">
                                        <span>Daily sales</span>
                                        <b class="text-muted ml-auto" id="today"></b>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div id="walletsContent" class="card-body tab-content">
                            <div class="tab-pane fade show active" id="bitcoin" role="tabpanel">
                                <div class="row text-center">
                                    <div class="col-6 col-md-6 mb-6 mb-md-0">
                                        <div class="h3 mb-0"><fmt:formatNumber type="number" value="${total}" pattern="##,###" /></div>
                                        <small class="text-muted">Total Sales</small>
                                    </div>

                                    <div class="col-6 col-md-6 mb-6 mb-md-0 border-left">
                                        <div class="h3 mb-0" id="todaySales"></div>
                                        <small class="text-muted">Today Sales</small>
                                    </div>
                                </div>

                                <div id="chart" class="js-area-chart chart chart--axis-x--nowrap chart--points-invisible position-relative mh-15_6 safari-overflow-hidden pt-4 pt-md-5 pb-1"
                                     data-series='[
                           [
                             {"meta":"6/01/2019 9:00 PM","value":"1200"},
                             {"meta":"6/02/2019 9:00 PM","value":"800"},
                             {"meta":"6/03/2019 9:00 PM","value":"900"},
                             {"meta":"6/04/2019 9:00 PM","value":"1600"},
                             {"meta":"6/05/2019 9:00 PM","value":"1700"},
                             {"meta":"6/06/2019 9:00 PM","value":"1400"},
                             {"meta":"6/07/2019 9:00 PM","value":"1500"},
                             {"meta":"6/08/2019 9:00 PM","value":"1350"},
                             {"meta":"6/09/2019 9:00 PM","value":"1200"},
                             {"meta":"6/10/2019 9:00 PM","value":"1100"},
                             {"meta":"6/11/2019 9:00 PM","value":"700"},
                             {"meta":"6/12/2019 9:00 PM","value":"800"},
                             {"meta":"6/13/2019 9:00 PM","value":"2100"},
                             {"meta":"6/14/2019 9:00 PM","value":"1900"},
                             {"meta":"6/15/2019 9:00 PM","value":"1800"},
                             {"meta":"6/16/2019 9:00 PM","value":"2100"},
                             {"meta":"6/17/2019 9:00 PM","value":"1800"},
                             {"meta":"6/18/2019 9:00 PM","value":"1600"},
                             {"meta":"6/19/2019 9:00 PM","value":"1200"},
                             {"meta":"6/20/2019 9:00 PM","value":"1400"},
                             {"meta":"6/21/2019 9:00 PM","value":"1500"},
                             {"meta":"6/22/2019 9:00 PM","value":"1700"},
                             {"meta":"6/23/2019 9:00 PM","value":"1600"},
                             {"meta":"6/24/2019 9:00 PM","value":"1800"},
                             {"meta":"6/25/2019 9:00 PM","value":"1850"},
                             {"meta":"6/26/2019 9:00 PM","value":"1900"},
                             {"meta":"6/27/2019 9:00 PM","value":"1950"},
                             {"meta":"6/28/2019 9:00 PM","value":"2100"},
                             {"meta":"6/29/2019 9:00 PM","value":"2200"},
                             {"meta":"6/30/2019 9:00 PM","value":"2300"}
                           ]
                         ]'
                                     data-labels='[
                                     	"June 01","June 02","June 03","June 04","June 05","June 06","June 07","June 08","June 09","June 10","June 11","June 12","June 13","June 14","June 15","June 16","June 17","June 18","June 19","June 20","June 21","June 22","June 23","June 24","June 25","June 26","June 27","June 28","June 29","June 30"
                                     	
                                     	]'
                                     data-labels-qty="3"
                                     data-labels-start-from="1"
                                     data-prefix="$"
                                     data-height="250"
                                     data-mobile-height="75"
                                     data-high="3000"
                                     data-low="500"
                                     data-offset-x="30"
                                     data-offset-y="60"
                                     data-is-line-smooth='[false]'
                                     data-line-width='["1px"]'
                                     data-line-colors='["#8069f2"]'
                                     data-fill-opacity="1"
                                     data-fill-colors='["#ecebfa"]'
                                     data-text-size-x="14px"
                                     data-text-color-x="#4a4e69"
                                     data-text-offset-top-x="10"
                                     data-text-align-axis-x="center"
                                     data-text-size-y="14px"
                                     data-text-color-y="#868e96"
                                     data-is-show-tooltips="true"
                                     data-is-tooltip-divided="true"
                                     data-tooltip-custom-class="chart-tooltip--divided chart-tooltip__value--bg-black chart-tooltip__meta--bg-primary small text-white"
                                     data-tooltip-currency="USD "
                                     data-is-show-points="true"
                                     data-point-custom-class='chart__point--donut chart__point--has-line-helper chart__point--border-xxs border-primary rounded-circle'
                                     data-point-dimensions='{"width":8,"height":8}'>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <!-- End Card -->
                </div>
            </div>

            
			<!-- 주문 목록 -->
            <div class="row">
                <div class="col-12">
                    <div class="card mb-3 mb-md-4">
                        <div class="card-header">
                            <h5 class="font-weight-semi-bold mb-0">Recent Orders</h5>
                        </div>

                        <div class="card-body pt-0">
                            <div class="table-responsive-xl">
                                <table class="table text-nowrap mb-0">
                                    <thead>
                                    <tr>
                                        <th class="font-weight-semi-bold border-top-0 py-2">#</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">주문일</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">분류</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">상품명</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">개수</th>
                                        <th class="font-weight-semi-bold border-top-0 py-2">결제금액</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-warning">Pending</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown16Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown16" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown16" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown16" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown16Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-success">Fulfilled</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown15Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown15" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown15" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown15" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown15Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-warning">Pending</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown14Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown14" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown14" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown14" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown14Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-danger">Cancelled</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown13Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown13" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown13" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown13" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown13Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-success">Fulfilled</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown12Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown12" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown12" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown12" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown12Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-light">Draft</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown11Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown11" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown11" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown11" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown11Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-3">149531</td>
                                        <td class="py-3">
                                            <div>John Doe</div>
                                            <div class="text-muted">Acme Inc.</div>
                                        </td>
                                        <td class="py-3">(000) 111-1234</td>
                                        <td class="py-3">$1,230.00</td>
                                        <td class="py-3">
                                            <span class="badge badge-pill badge-success">Fulfilled</span>
                                        </td>
                                        <td class="py-3">
                                            <div class="position-relative">
                                                <a id="dropDown10Invoker" class="link-dark d-flex" href="#" aria-controls="dropDown10" aria-haspopup="true" aria-expanded="false" data-unfold-target="#dropDown10" data-unfold-event="click" data-unfold-type="css-animation" data-unfold-duration="300" data-unfold-animation-in="fadeIn" data-unfold-animation-out="fadeOut">
                                                    <i class="gd-more-alt icon-text"></i>
                                                </a>

                                                <ul id="dropDown10" class="unfold unfold-light unfold-top unfold-right position-absolute py-3 mt-1 unfold-css-animation unfold-hidden fadeOut" aria-labelledby="dropDown10Invoker" style="min-width: 150px; animation-duration: 300ms; right: 0px;">
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-pencil unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Edit</span>
                                                        </a>
                                                    </li>
                                                    <li class="unfold-item">
                                                        <a class="unfold-link media align-items-center text-nowrap" href="#">
                                                            <i class="gd-close unfold-item-icon mr-3"></i>
                                                            <span class="media-body">Delete</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
 
 
 
 </div>