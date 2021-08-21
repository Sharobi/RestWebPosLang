<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.sharobi.webpos.base.model.Customer"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="dd" uri="/WEB-INF/taglib/ddformatter.tld"%>

<!DOCTYPE html>

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
        
<title>:. POS :: Search / Reserve Rooms :.</title>

<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />

<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/customstyle.css"
	rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
.ui-autocomplete {
	max-height: 300px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden;
	z-index:2147483647; 
	/* add padding to account for vertical scrollbar */
	/*             padding-right: 20px; */
}
 div.postable .table-image{
	   background:
		 url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/room_blank.png') 
		/*url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/changeImg.png')*/
		no-repeat center;
	   height: 70px;
	   width: 130px;
	   border-radius:32px
} 

.bdbgimg {
     background-image: url("${pageContext.request.contextPath }/assets/images/admin/tablelayout/bg.jpg");
		
		
}
.bdbg{
 background-color:#bdbdbd;
}
div.postable .room-image-booked{
	
	 background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/room_booked.png') no-repeat center; 
	/*background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/roombooked.png') no-repeat center;*/
	height:70px;
	width:120px;
	 border-radius:32px
	
}

div.postable .room-image-disabled{

	 background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/room_inactive.png') no-repeat center;
	/*background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/roomclosed.png') no-repeat center;*/
	height:70px;
	width:130px;
	 border-radius:32px
	
}

div.postable .room-image-booked-checked{
background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/room_checkedin.png') no-repeat center; 
/*background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/roomcheckedin.png') no-repeat center;*/
	height:70px;
	width:130px;
	 border-radius:32px
}

.upcomingroomcheckout{
background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/upcoming_checkout.png') no-repeat center; 
/*background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/roomcheckedin.png') no-repeat center;*/
	height:70px;
	width:130px;
	 border-radius:32px
}


.onoffswitch {
    position: relative; width: 90px;
    -webkit-user-select:none; -moz-user-select:none; -ms-user-select: none;
}
.onoffswitch-checkbox {
    display: none;
}
.onoffswitch-label {
    display: block; overflow: hidden; cursor: pointer;
    border: 2px solid #999999; border-radius: 20px;
}
.onoffswitch-inner {
    display: block; width: 200%; margin-left: -100%;
    transition: margin 0.3s ease-in 0s;
}
.onoffswitch-inner:before, .onoffswitch-inner:after {
    display: block; float: left; width: 50%; height: 30px; padding: 0; line-height: 30px;
    font-size: 14px; color: white; font-family: Trebuchet, Arial, sans-serif; font-weight: bold;
    box-sizing: border-box;
}
.onoffswitch-inner:before {
    content: "ON";
    padding-left: 10px;
    background-color: #34A7C1; color: #FFFFFF;
}
.onoffswitch-inner:after {
    content: "OFF";
    padding-right: 10px;
    background-color: #EEEEEE; color: #999999;
    text-align: right;
}
.onoffswitch-switch {
    display: block; width: 18px; margin: 6px;
    background: #FFFFFF;
    position: absolute; top: 0; bottom: 0;
    right: 56px;
    border: 2px solid #999999; border-radius: 20px;
    transition: all 0.3s ease-in 0s; 
}
.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-inner {
    margin-left: 0;
}
.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-switch {
    right: 0px; 
}
</style>
</head>
<body class="bdbgimg">
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<c:set var="tomorrow" value="<%=new java.util.Date(new java.util.Date().getTime() + 60*60*24*1000)%>" />
	<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" var="formattedtodaydate" />
	<c:set var="todaycheck" value='${formattedtodaydate}' />
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	
	<input type="hidden" class="form-control" id="msgAc"  value="<spring:message code='rb.roombooking.roomsearch.ac' text='AC' />" />
	<input type="hidden" class="form-control" id="msgCap"  value="<spring:message code='rb.roombooking.roomsearch.capacity' text='Cap' />" />
	<input type="hidden" class="form-control" id="msgGuest"  value="<spring:message code='rb.roombooking.roomsearch.customer' text='Guest' />" />
	<input type="hidden" class="form-control" id="msgForm"  value="<spring:message code='rb.roombooking.roomsearch.from' text='Frm' />" />
	<input type="hidden" class="form-control" id="msgTo"  value="<spring:message code='rb.roombooking.roomsearch.to' text='To' />" />
	<input type="hidden" class="form-control" id="msgAdvPay"  value="<spring:message code='rb.roombooking.roomsearch.advancepayment' text='Adv Pay' />" />
	<input type="hidden" class="form-control" id="msgBookDate"  value="<spring:message code='rb.roombooking.roomsearch.bookingdate' text='Book date' />" />
	<input type="hidden" class="form-control" id="todayhiddendate" value="${todaycheck}">
							
	

	<div class="content-wrapper">
		<div class="container-fluid">
			 <div class=" form-group" style="height:100px;">
			     <div class="row" style="margin-top:15px;" align="center">
					<span style="color:#FFF; font-size:18px; font-weight:bold;"><spring:message code="base.room.jsp.Reservation" text="ROOMS RESERVATION / DIRECT BOOKING" /></span>
				</div>
			    <div style="margin-top:15px;" class="row" > 
 			       <div class="col-xs-1 col-sm-1 col-md-2 col-lg-2"></div>
			      
			       
			        <c:if test="${!empty fromdate}">
					   <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
						  <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.frmDate" text="From Date:" /></span>
							 <input type="text" class="form-control" id="fromdateroomsearch"  value="${fromdate}"  style="height: 30px;  margin-bottom: 2px;color: #222222;"/>
							   
							  	<c:set var="fromSpecificDate" value="${fromdate}" />
							  	
                    		
                    	</div>		
                    			
						</c:if> 
			       
						 <c:if test="${!empty todate}">
						  <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2" >
							<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.toDate" text="To Date:" /></span>
                    		 	<input type="text" class="form-control" id="todateroomsearch"  value="${todate}" style="height: 30px;  margin-bottom: 2px;color: #222222;"/>
                    		      
                                 <c:set var="toSpecificDate" value="${todate}" />
                    	 </div>
						</c:if> 
                        <c:if test="${empty fromdate}">
						 <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2"  >
						 <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.frmDate" text="From Date:" /></span>
						    <%-- <input type="text" class="form-control" id="fromdateroomsearch" readonly="readonly"  style="height: 30px; margin-bottom: 2px;color: #222222;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"> --%>
							<input type="text" class="form-control" id="fromdateroomsearch"  readonly="readonly" style="height: 30px; margin-bottom: 2px;color: #222222;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
							<c:set var="fromSpecificDate" value="${today}" />
							
							</div>
							 <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2" >
							 <span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
									code="base.room.jsp.toDate" text="To Date :" /></span>
							 <input type="text" class="form-control" id="todateroomsearch" readonly="readonly" style="height: 30px; margin-bottom: 2px;color: #222222;"  value="<fmt:formatDate pattern="yyyy-MM-dd" value="${tomorrow}"/>"> <!-- change here value today to tomorrow -->
							<c:set var="toSpecificDate" value="${today}" />
							</div>
							
							
							
							
						</c:if>
			            <input type="hidden" id="hiddateroomsearch"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
			      
			      
			      
			      
			      
			    
			       <div style="display:block;" onchange="javascript:selectPAX()" id ="paxroomCatsearchDiv">
			       <div class="col-xs-2 col-sm-2 col-md-1 col-lg-1">
			       <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.pax" text="PAX:" /></span>
			         <select  class="form-control" id="paxroomsearch" style="margin-bottom: 2px;color: #222222;height: 30px;">
                       <c:forEach begin="1" end="30" varStatus="loop">
                             <option value="${loop.index}">${loop.index}</option>
                       </c:forEach>
                    </select>
			       
			       </div>
			       <div class="col-xs-3 col-sm-2 col-md-2 col-lg-2">
			        <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.roomCategory" text="Room Category:" /></span>                 
                    <select class="form-control" id="roomtypesearch" onchange="javascript:selectRoomCategory()" style="height: 30px; margin-bottom: 2px;color: #222222;">
                            <option value="0">All</option>
                           <c:if test="${! empty roomtypeList}">
                               <c:forEach items="${roomtypeList}" var="roomtypeList">
                                     <option value="${roomtypeList.id}">${roomtypeList.roomType}</option>
                                </c:forEach>
                           </c:if>
                  	</select>
			       
			       
			       
			       
			       </div>
			       <div class="col-xs-1 col-sm-2 col-md-1 col-lg-1"  style="text-align:right">
			       <br>
			       <a href="javascript:searchRoomAvailability(document.getElementById('fromdateroomsearch').value,document.getElementById('todateroomsearch').value,${sessionScope.loggedinUser.storeId})" class="btn btn-primary" style="margin-bottom: 3px;height:32px;width: 100px;"><spring:message code="base.room.jsp.search" text="SEARCH" /></a>
			       </div>
			       </div>
			       <div class="col-xs-1 col-sm-1 col-md-2 col-lg-2" ></div>
			    
			    </div>		 
			</div>
			 
			
			
			<div class="row">
			<div class="col-md-1 col-sm-1 col-lg-1"></div>
			<div class="col-md-10 col-sm-10 col-lg-10 bdbg">
			
					<div style="height: 100%; width: 100%;">
						<div style="height: 500px; overflow-y: auto;" id="roomlayoutid">
							<c:if test="${empty floorList }">
								<spring:message code="admin.room.jsp.noRoomFound" text="No Rooms found!!!!" />
							</c:if>
							<c:if test="${!empty floorList }">

								<c:forEach items="${floorList}" var="floor" varStatus="stat">

									<div class="col-md-10 col-sm-10" style="margin-top: 15px;margin-bottom: 8px;color:#FFF;height:100px;">
										
										<h4 class="panel-title" style="width: inherit;">  
										
										<c:choose>
											<c:when test="${floor.floor==0}">
												<a style="display: block; width: inherit; font:14px;color:black;"> Ground Floor </a>
											</c:when>
											<c:otherwise>
												<a style="display: block; width: inherit; font:14px;color:black;">Floor No.-  <b>${floor.floor}</b></a>
											</c:otherwise>
										</c:choose>
										</h4> 
										
										<div   class="panel-body" style="overflow-y: auto;"> 
											<c:forEach items="${floorList[stat.index].room}" var="rooms" varStatus="loop"> 
												<div class="table-holder1" style="position: absolute; left:${loop.index*150+1}px;">
													<c:if test="${rooms.isStatus=='Y' && rooms.isBooked=='Y' && rooms.isCheckIn=='N'}">
														 <div class="postable booked" onclick="javascript:clickOnBookedRoom('${rooms.id}','${rooms.roomNo}','0')">
															<div class="postable room-image-booked">
																<div class="table-index" style="text-align: left;margin:0px;">
																	 <a href="#" style="color: black;font-size: 15px;"
																	    title="${rooms.roomTypeId.roomType},<spring:message code="rb.roombooking.roomsearch.ac" text=" AC" />:${rooms.roomCategory},
																	    <spring:message code="rb.roombooking.roomsearch.capacity" text="Cap" />:${rooms.roomCapacity}" data-toggle="popover" data-trigger="hover"
																		data-content="<spring:message code="rb.roombooking.roomsearch.customer" text="Guest" />:${rooms.custName} <spring:message code="rb.roombooking.roomsearch.from" text="Frm" />:${rooms.fromDate} - <spring:message code="rb.roombooking.roomsearch.to" text="To" />:${rooms.toDate} <spring:message code="rb.roombooking.roomsearch.advancepayment" text="Adv Pay" />:${rooms.advPayment}<spring:message code="rb.roombooking.roomsearch.bookingdate" text="Book date" />:${rooms.bookingDate}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${rooms.roomNo}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;${rooms.roomCapacity}</a>
																 </div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<div class="table-subinfo">${rooms.roomCapacity}<spring:message code="admin.tablenew.jsp.persons" text="PERSONS" /></div>
																</c:if>
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" /></div>
																<div class="table-subinfo">${sessionScope.loggedinStore.currency}${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div> 
													</c:if>
													<c:if test="${rooms.isStatus=='Y' && rooms.isBooked=='Y' && rooms.isCheckIn=='Y'}">										
													   <c:choose>
													    <c:when test="${rooms.toDate==todaycheck}">
													    <div class="postable booked" onclick="javascript:clickOnBookedRoom('${rooms.id}','${rooms.roomNo}','0')">
															<div class="upcomingroomcheckout">
																<div class="table-index" style="text-align: left;margin:0px;">
																	<a href="#" style="color: black;font-size: 15px;" title="${rooms.roomTypeId.roomType},<spring:message code="rb.roombooking.roomsearch.ac" text=" AC" />:${rooms.roomCategory},<spring:message code="rb.roombooking.roomsearch.capacity" text="Cap" />:${rooms.roomCapacity}" data-toggle="popover" data-trigger="hover"
																		data-content="<spring:message code="rb.roombooking.roomsearch.customer" text="Guest" />:${rooms.custName} <spring:message code="rb.roombooking.roomsearch.from" text="Frm" />:${rooms.fromDate} - <spring:message code="rb.roombooking.roomsearch.to" text="To" />:${rooms.toDate} <spring:message code="rb.roombooking.roomsearch.advancepayment" text="Adv Pay" />:${rooms.advPayment}<spring:message code="rb.roombooking.roomsearch.bookingdate" text="Book date" />:${rooms.bookingDate}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${rooms.roomNo}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;${rooms.roomCapacity}</a>
																</div>
															</div>
															</div>
													    
													    </c:when>
													    <c:otherwise>
													    <div class="postable booked" onclick="javascript:clickOnBookedRoom('${rooms.id}','${rooms.roomNo}','0')">
															<div class="postable room-image-booked-checked">
																<div class="table-index" style="text-align: left;margin:0px;">
																	<a href="#" style="color: black;font-size: 15px;" title="${rooms.roomTypeId.roomType},<spring:message code="rb.roombooking.roomsearch.ac" text=" AC" />:${rooms.roomCategory},<spring:message code="rb.roombooking.roomsearch.capacity" text="Cap" />:${rooms.roomCapacity}" data-toggle="popover" data-trigger="hover"
																		data-content="<spring:message code="rb.roombooking.roomsearch.customer" text="Guest" />:${rooms.custName} <spring:message code="rb.roombooking.roomsearch.from" text="Frm" />:${rooms.fromDate} - <spring:message code="rb.roombooking.roomsearch.to" text="To" />:${rooms.toDate} <spring:message code="rb.roombooking.roomsearch.advancepayment" text="Adv Pay" />:${rooms.advPayment}<spring:message code="rb.roombooking.roomsearch.bookingdate" text="Book date" />:${rooms.bookingDate}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${rooms.roomNo}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;${rooms.roomCapacity}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<div class="table-subinfo">${rooms.roomCapacity}<spring:message code="admin.tablenew.jsp.persons" text="PERSONS" /></div>
																</c:if>
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" /></div>
																<div class="table-subinfo">${sessionScope.loggedinStore.currency}${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div> 
													    
													    
													    </c:otherwise>
													          
													         
													    </c:choose>
													
														<%--  <div class="postable booked" onclick="javascript:clickOnBookedRoom('${rooms.id}','${rooms.roomNo}','0')">
															<div class="postable room-image-booked-checked">
																<div class="table-index" style="text-align: left">
																	<a href="#" style="color: black;font-size: 15px;" title="${rooms.roomTypeId.roomType},<spring:message code="rb.roombooking.roomsearch.ac" text=" AC" />:${rooms.roomCategory},<spring:message code="rb.roombooking.roomsearch.capacity" text="Cap" />:${rooms.roomCapacity}" data-toggle="popover" data-trigger="hover"
																		data-content="<spring:message code="rb.roombooking.roomsearch.customer" text="Guest" />:${rooms.custName} <spring:message code="rb.roombooking.roomsearch.from" text="Frm" />:${rooms.fromDate} - <spring:message code="rb.roombooking.roomsearch.to" text="To" />:${rooms.toDate} <spring:message code="rb.roombooking.roomsearch.advancepayment" text="Adv Pay" />:${rooms.advPayment}<spring:message code="rb.roombooking.roomsearch.bookingdate" text="Book date" />:${rooms.bookingDate}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${rooms.roomNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<div class="table-subinfo">${rooms.roomCapacity}<spring:message code="admin.tablenew.jsp.persons" text="PERSONS" /></div>
																</c:if>
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" /></div>
																<div class="table-subinfo">${sessionScope.loggedinStore.currency}${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div>  --%>
													 </c:if>		 			
													<c:if test="${(rooms.isStatus=='Y' && rooms.isBooked=='N' && rooms.isCheckIn=='N')}">
														<div class="postable enabled" onclick="javascript:clickOnRoom('${rooms.id}','${rooms.roomNo}','${rooms.roomTypeId.id}')">
															<div class="postable table-image room" name="rooms" id="${rooms.id}">
																<div class="table-index" style="text-align: left;margin:0px;">
																	<a href="#" style="color: black;font-size:15px;" title="${rooms.roomTypeId.roomType},<spring:message code="rb.roombooking.roomsearch.ac" text=" AC" />:${rooms.roomCategory},<spring:message code="rb.roombooking.roomsearch.capacity" text="Cap" />:${rooms.roomCapacity}"
																		data-toggle="popover" data-trigger="hover" data-content="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;${rooms.roomNo}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;${rooms.roomCapacity}</a>
																</div>
															</div>
															 <div class="table-info hide">																																			
																<div class="table-subinfo">${rooms.roomCapacity}<spring:message code="admin.roombooking.jsp.persons" text="PERSONS" /></div>
																	<div class="table-subinfo"></div>
																		<div class="table-subinfo"></div>
															</div> 
															<br style="clear: both;">
														</div>
													</c:if>
																		
													<c:if test="${rooms.isStatus=='N' && rooms.isBooked=='N'  && rooms.isCheckIn=='N'}">
														<div class="postable disabled">
															<div class="postable room-image-disabled">
																<div class="table-index" style="text-align: left;margin:0px;">
																	<a href="#" style="color: black;font-size: 15px;" title="${rooms.roomTypeId.roomType},<spring:message code="rb.roombooking.roomsearch.ac" text=" AC" />:${rooms.roomCategory},<spring:message code="rb.roombooking.roomsearch.capacity" text="Cap" />:${rooms.roomCapacity}"
																		data-toggle="popover" data-trigger="hover" data-content="">&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;${rooms.roomNo}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;${rooms.roomCapacity}</a>
																</div>
																 </div>
																 <div class="table-info hide">																					
																<div class="table-subinfo">${rooms.roomCapacity}<spring:message code="admin.tablenew.jsp.persons" text="PERSONS" />
																</div>																	
																<div class="table-subinfo"></div>
																<div class="table-subinfo"></div>
															</div>
															<br style="clear: both;">
															</div>								
													</c:if>	
													<div style='color: white;font-size:12px;width:70px;display:none'> Capacity : ${rooms.roomCapacity}</div>																	
												</div>
											</c:forEach> 
											
										</div>
									 </div>
								</c:forEach>
							</c:if>							
						</div>
					</div>
			
		      </div>
			<div class="col-md-1 col-sm-1 col-lg-1"></div>
			
			</div>
			<br>
			
			 	
			
	</div>
</div>
			<!-- modal starts -->

			<div class="modal fade" data-backdrop="static"
				id="bookedtablealertModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.tablenew.jsp.alert" text="Alert!" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="admin.tablenew.jsp.tabBooked"
									text="This table is booked,cannot be disabled!" />
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.tablenew.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="alertsearchroomModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.rpt_inv_po_period.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <spring:message code="admin.rpt_inv_po_period.jsp.cont_one" text="Given date is greater than today's date!" />
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.rpt_inv_po_period.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
           <div class="modal fade" data-backdrop="static" id="alertsearchroomgreaterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.rpt_inv_po_period.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <spring:message code="admin.rpt_inv_po_period.jsp.cont_two" text="From Date is greater than To Date!" />
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"   onclick="javascript:resetSearch()" style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.rpt_inv_po_period.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
			<div class="modal fade" data-backdrop="static"
				id="confirmoperationtableModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.tablenew.jsp.confrmtion"
									text="Confirmation!" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="admin.tablenew.jsp.areYouSure"
									text="Are you sure?" />
								<input type="hidden" value="" id="targettableId"> <input
									type="hidden" value="" id="targettableOpt">
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold; width: 25%;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="admin.tablenew.jsp.cancel" text="CANCEL" />
							</button>
							<button type="button" onclick="javacsript:updateTableOperation()"
								style="background: #72BB4F; font-weight: bold; width: 25%;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.tablenew.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>



			<div class="modal fade" data-backdrop="static" id="waiterNameModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!--   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.WaiterName" text="Waiter Name" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<!-- <div style="max-height: 300px; overflow-y: auto;">
								<div style="font-size: 20px;" id="spnoteitemlistContId"></div>
							</div> data-dismiss="modal"-->
							<div style="font-size: 20px;" id="specialAlert"></div>

							<spring:message code="order.jsp.WaiterName" text="Waiter Name :" />
							<input type="text" id="waiterName"
								style="width: 60%; color: #222222; margin-bottom: 5px;" />


							<div id="waiternamereq" class="hide" style="color: red;"
								align="center">Waiter Name Required.</div>
						</div>

						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelWaiterName()"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:saveWaiterName()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.SUBMIT" text="SUBMIT" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- booking options modal start -->
			<div class="modal fade" data-backdrop="static" id="processSelectionModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!--   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.selection" text="Select Process" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						
							<a href="javascript:openReservation()"
									class="btn-order-taking"
									style="text-align: center; width: 96%; margin-top: 2px;">&nbsp;										
											<spring:message code="order.jsp.Reservation"
												text="RESERVATION"/>
									</a>									
									
									<a href="javascript:openDirectBooking()"
										class="btn-order-taking"
										style="text-align: center; width: 96%; margin-top: 2px;">&nbsp;
											<spring:message code="order.jsp.booking"
												text="DIRECT BOOKING" />
									</a>									
									
						</div>

						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							
							<button type="button" onclick="javascript:rateChageModalOpen()" style="background: #F60; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="rb.roombooking.selectroom.ratechange" text="CHANGE RATE" />
							</button>
							
							
							<button type="button" onclick="javascript:cancelReserve()" style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>
			<!-- booking options modal end -->
			
		<div class="modal fade" data-backdrop="static"
				id="alertRoomReserveDataopModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.menumgnt.jsp.alert" text="Alert!" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div id="roomreservealertopmassagecont"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								onclick="javascript:failReserve()"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static"
				id="successRoomReserveDataopModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.menumgnt.jsp.success" text="Success!" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div id="roomreservedataopmassagecont"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								onclick="javascript:successReserve()"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			
			<!-- room reservation modal start (it contain customer phone no name and email only.it is a by phone reservation) -->
			<div class="modal fade" data-backdrop="static"
				id="modRoomReserveCustDetailsModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto; width: 50%;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.CustomerDetails"
									text="Customer Details" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
			
									<div style="text-align: left; font-size: 18px;">
									       <input type="hidden" id="modroomreservecustIdhidden" value=""/>
										<table align="center">
                                                  <tr>
													<td><spring:message code="order.jsp.PHONENO"
															text="PHONE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modroomreservecustPhone"
														maxlength="10" value="${orders.customerContact}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														autofocus="autofocus"
														onkeypress='return isNumberKey(event)' /></td>							
												</tr>
												<tr>
													<td><spring:message code="order.jsp.CUSTOMERNAME"
															text="CUSTOMER NAME" /></td>
													<td>:</td>
													<td><input type="text" id="modroomreservecustName"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														onkeypress='return lettersOnly(event)' /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.email"
															text="EMAIL-ID" /></td>
													<td>:</td>
													<td><input type="text" id="modroomreservecustEmail"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
											<%--	<tr>
													<td><spring:message code="order.jsp.location"
															text="LOCATION" /></td>
													<td>:</td>
													<td><input type="text" id="modroomreservecustLocation"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
											 	<tr>
													<td><spring:message code="order.jsp.ADDRESS"
															text="ADDRESS" /></td>
													<td>:</td>
													<td><textarea id="modparcelcustAddress" rows="2"
															style="margin-bottom: 2px; color: #222222; width: 95%;">${orders.deliveryAddress}</textarea>
													</td>
												</tr>
												<tr>
													<td><spring:message
															code="order.jsp.DELIVERYPERSONNAME"
															text="DELIVERY PERSON NAME" /></td>
													<td>:</td>
													<td><input type="text"
														id="modparceldeliveryPersonName"
														value="${orders.deliveryPersonName}"
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.houseno"
															text="HOUSE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcusthouseno"
														value="${orders.houseNo}"
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.streetno"
															text="STREET NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcuststreet"
														value="${orders.street}"
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td>STATE</td>
													<td>:</td>
													<td><input type="text" id="modparcelcuststate"
														value="${orders.state}"
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td>Cust VAT/CST:</td>
													<td>:</td>
													<td><input type="text" id="modparcelcustvatorcst"
														value="${orders.custVatRegNo}"
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.custDOB"
															text="DATE OF BIRTH" /></td>
													</td>
													<td>:</td>

													<td><input type="text" id="modparcelcustdob" size="10"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														value=""></td>
												</tr>

												<tr>
													<td><spring:message code="order.jsp.custAnniversary"
															text="ANNIVERSARY DATE" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustanniversary"
														size="10"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														value=""></td>
												</tr> --%>

										</table>
										<div
											style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
											id="modroomreserveCustalertMsg"></div>
									</div>
						</div>
						
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelReserve()"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="reserveBtn" onclick="javascript:reserveRoom()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								 class="btn btn-success">
								<spring:message code="m.jsp.RESERVE" text="RESERVE" />
							</button>
						</div>
					</div>
				</div>
			</div>
<!-- room reservation modal end (it contain customer phone no name and email only.it is a by phone reservation) -->
			
			<!--Room rate change modal start  -->
			
			<div class="modal fade" data-backdrop="static"
				id="roomRateChageModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="rb.roombooking.selectroom.ratechange" text="CHANGE RATE" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div id="roomratechagecontent"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								onclick="javascript:changeRoomRate()"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
							<button type="button"  style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<!--Room rate change modal end  -->
			
			
			<!-- New modals added 16.7.2019  -->
             <div class="modal fade" data-backdrop="static"
				id="roomBookingForm" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto; width: 50%;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393; min-height:48.428571px;">
							<div class="col-md-8">
								<h4 class="modal-title"
									style="font-size: 18px; font-weight: bold;" id="myModalLabel">
									<spring:message code="rb.rpt.roombooking"
										text="ROOM BOOKING" />
								</h4>
							</div>
							<div class="col-md-4">
							     <div class="col-md-6">
							  	  <span style="font-size: 18px; font-weight: bold; float:right;" >Check In:</span>
							  	  </div>
							  	  <div class="col-md-6">
								  <div class="onoffswitch" style="position:relative;margin-top:-6px;">
								    <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" onchange="setCheckIn();">
								    <label class="onoffswitch-label" for="myonoffswitch">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
								</div>
							</div>
							
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
			
									<input type="hidden" id="modroombookreserveIdhidden" value="">
									<div style="text-align: left; font-size: 18px;">
									<input type="hidden" id="modroombookcustIdhidden" value="">
										<table align="center" width="90%">
										<tr>
													<td><spring:message code="rb.admin.roombooking.bookingtype"
															text="BOOKING TYPE" /></td>
													<td>:</td>
													<td> <select  id="modroombookingType"  style="margin-bottom: 2px; color: #222222; width: 95%;">
                                                    <c:if test="${! empty roombookingtypeList}">
                                                        <c:forEach items="${roombookingtypeList}" var="bookingTypeList">
                                                            <option value="${bookingTypeList.id}">${bookingTypeList.name}</option>
                                                        </c:forEach>
                                                    </c:if>
                  	                            </select></td>
                  	                            
												</tr>
												<tr>
												<td>REFERENCE NUMBER</td>
												<td>:</td>
												<td><input type="text" id="modroombookrefNo" class="roombookingmodalcustominputtag" /></td>
												</tr>
												<tr>
												<%-- <td><spring:message code="admin.invitemmgnt.jsp.refundRemarks"
															text="REMARKS" /></td> --%>
												<td>REMARKS</td>
												<td>:</td>
												<td><input type="text" id="modroombookremarks" class="roombookingmodalcustominputtag" /></td>
												</tr>
                                              <tr>
													<td><spring:message code="order.jsp.PHONENO"
															text="PHONE NO" /></td>
													<td>:</td>
													<td>
													<input type="text" id="modroombookcustId"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														class="hide" />
													    <input type="text" id="modroombookcustPhone"
														maxlength="10" value="${orders.customerContact}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														autofocus="autofocus"
														onkeypress='return isNumberKey(event)' />
														
														</td>
														<td width="15%"><button type="button" class="btn btn-primary  btn-sm" id="newcustomerbtn" style="display:none;" onclick="openNewCustomerData();">New Customer</button><!-- <a href="#" onclick="openNewCustomerData();"> Add New</a> --></td>							
												</tr>
												<tr>
													<td><spring:message code="order.jsp.CUSTOMERNAME"
															text="CUSTOMER NAME" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcustName"
														class="roombookingmodalcustominputtag"
														onkeypress='return lettersOnly(event)' /></td>
												</tr>
												
												<tr id="gendertr">
                                            			<td><spring:message code="order.jsp.CUSTOMERGENDER" text="GENDER" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modroombookcustGender" class="roombookingmodalcustominputtag" disabled>
                                            				    <option value="S">Select</option>
																<option value="M">Male</option>
																<option value="F">Female</option>
                                            				</select>
                                            			</td>
                                            	</tr>
												<tr>
													<td><spring:message code="order.jsp.email"
															text="EMAIL-ID" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcustEmail"
														value=""
														class="roombookingmodalcustominputtag" disabled/></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.custDOB"
															text="DATE OF BIRTH" /></td>
													<td>:</td>

													<td><input type="text" id="modroombookcustdob"  size="10"
														class="roombookingmodalcustominputtag"
														value="" disabled></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.location"
															text="LOCATION" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcustLocation"
														value=""
														class="roombookingmodalcustominputtag" disabled/></td>
												</tr>
											 	<tr>
													<td><spring:message code="order.jsp.ADDRESS"
															text="ADDRESS" /></td>
													<td>:</td>
													<td><textarea id="modroombookcustAddress" rows="2" class="roombookingmodalcustominputtag" disabled></textarea>
													</td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.houseno"
															text="HOUSE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcusthouseno"
														value=""
														class="roombookingmodalcustominputtag" disabled/></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.streetno"
															text="STREET NO" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcuststreet"
														value=""
														class="roombookingmodalcustominputtag" disabled/></td>
												</tr>
												<tr>
													<td>STATE</td>
													<td>:</td>
													<td><input type="text" id="modroombookcuststate"
														value="${orders.state}"
														class="roombookingmodalcustominputtag" disabled/></td>
												</tr> 
												<tr>
													<td><spring:message code="rb.roombooking.roomsearch.GSTNO"
															text="GSTNO" /></td>
													<td>:</td>
													<td><input type="text" id="gstno"
														value="${orders.custVatRegNo}"
														class="roombookingmodalcustominputtag" disabled/></td>
												</tr> 
                                                <tr id="idtypetr" class="hide">
                                                <td>ID TYPE</td>
                                                <td>:</td>
                                                <td>
                                                <select  id="modroombookuniqueIdType"  class="roombookingmodalcustominputtag">
                                                    <option value="0">Select</option>
                                                    <c:if test="${! empty uniqueIdTypeList}">
                                                        <c:forEach items="${uniqueIdTypeList}" var="idTypeList">
                                                            <option value="${idTypeList.id}">${idTypeList.name}</option>
                                                        </c:forEach>
                                                    </c:if>
                  	                            </select>
                                                </td>
                                                </tr>
                                                <tr id="idnotr" class="hide">
                                                <td>ID NUMBER</td>
                                                <td>:</td>
                                                <td><input type="text" id="modroombookuniqueId" value="" class="roombookingmodalcustominputtag" /></td>
                                                </tr>
					                        <!-- <tr> 
					                  			<td>IDENTITY PROOF</td>
					                  			<td>:</td>
					                  			<td><input type="file" name="fileUpload" id="fileUpload" /></td> 
                  		
                  	
									           </tr> -->
                                      <%-- </form:form> --%>
										</table>
										<div
											style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
											id="modroombookCustalertMsg"></div>
										<div id="roomdetails"></div>
									</div>
						</div>
						
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelReserve()"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="checkIn" onclick="javascript:bookRoom()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								 class="btn btn-success">
								<spring:message code="rb.base.bookroom" text="BOOK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			
			
			<!-- modal ends -->
	<!-- 	</div>
	</div> -->
	<!-- CONTENT-WRAPPER SECTION END-->


	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/hotelBaseScript.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	 <script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script> 
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
		<%-- <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script> --%>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>	
	<c:choose>
		<c:when test="${pageContext.response.locale == 'ar'}">
			<script
				src="${pageContext.request.contextPath}/assets/js/lang/baseScript_AR.js"></script>
		</c:when>

		<c:otherwise>
			<script
				src="${pageContext.request.contextPath}/assets/js/lang/baseScript_EN.js"></script>
		</c:otherwise>
	</c:choose>

	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";
		var waiterNameFlag = "${sessionScope.loggedinStore.waiterNameFlag}";
		var fromdate="${fromSpecificDate}";
		var todate="${toSpecificDate}";
		var storeID="${sessionScope.loggedinStore.id}";
		var currency = "${sessionScope.loggedinStore.currency}";
		var now = new Date();
		var currentday=moment(now, "YYYY-MM-DD").format("YYYY-MM-DD");
		var previousday=moment(now, "YYYY-MM-DD").subtract('days',1).format("YYYY-MM-DD");
		//	alert(waiterNameFlag);
		function showselectTablealertModal() {
			$('#selecttablealertModal').modal('show');
		}
		function showbookedTablealertModal() {
			$('#bookedtablealertModal').modal('show');
		}
		function showconfirmTablealertModal(tableid, opt) {
			document.getElementById('targettableId').value = tableid;
			document.getElementById('targettableOpt').value = opt;
			$('#confirmoperationtableModal').modal('show');
		}

		$(document).ready(function() {
			 $('[data-toggle="popover"]').popover(); 
						
				 $('#fromdateroomsearch').datepicker({
					beforeShow : function() {
						document.getElementById('paxroomCatsearchDiv').style.display = 'none';
						
				      },
					format : "yyyy-mm-dd",
					autoclose : true,
					startDate : '0',
					endDate : '+4m',
				}); 
				
				 /* $('#fromdateroomsearch').datepicker({
						format : "yyyy-mm-dd",
						autoclose : true,
						beforeShowDay: function(date){ 
							           var tempdate=moment(date, "YYYY-MM-DD").format("YYYY-MM-DD");
							          if(tempdate==previousday  ||tempdate>=currentday   ){
			 			                 return true;
			 		                  }else{
			 			             return false;
			 		                   } 
	 		                                }
						
					}); */

				$('#todateroomsearch').datepicker({
					beforeShow : function() {
						document.getElementById('paxroomCatsearchDiv').style.display = 'none';
				      },
					format : "yyyy-mm-dd",
					autoclose : true,
					startDate : '0',
					endDate : '+4m'
				});
				
				$('#modroombookcustdob').datepicker({
					format : "yyyy-mm-dd",
					autoclose : true,
					endDate: '0'
				});

		});
		
	/* 	function clickDate() {
			
			console.log('worked');
			document.getElementById('paxroomCatsearchDiv').style.display = 'none';
		} */
		
		 function showalertsearchRoomModal()
			{
			  	$('#alertsearchroomModal').modal('show');
			}
		   function showalertsearchRoomGreaterModal()
			{
			  	$('#alertsearchroomgreaterModal').modal('show');
			}
		   
		   function showRoomReserveModal()
			{
			  	$('#modRoomReserveCustDetailsModal').modal('show');
			}
		   
		   function showRoomBookingAlertModal()
			{
			  	$('#processSelectionModal').modal('show');
			}
		   function showsuccessreserveopModal()
			{
			  	$('#successRoomReserveDataopModal').modal('show');
			}
		   function alertRoomReserveDataopModal()
			{
			  	$('#alertRoomReserveDataopModal').modal('show');
			}
		   
		   function isNumberKey(evt){
			    var charCode = (evt.which) ? evt.which : evt.keyCode;
		
			    if (charCode > 31 && (charCode < 48 || charCode > 57))
			        return false;
			    return true;
			}
			
			function lettersOnly(evt) {
			       evt = (evt) ? evt : event;
			       var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
			          ((evt.which) ? evt.which : 0));
			 
			       if (charCode > 31 && charCode != 32 && (charCode < 65 || charCode > 90) &&
			          (charCode < 97 || charCode > 122)) {
			         // alert("Enter letters only.");
			          return false;
			       }
			       return true;
			     }
		   
	</script>

<script type="text/javascript">
var storeID="${sessionScope.loggedinStore.id}";
/* $(function() {
	        $("#modroomreservecustPhone")
	                .autocomplete(
	                        {
	                            source : function(request, response) {
	                                $.ajax({
	                                            url : "${pageContext.request.contextPath}/customer/searchrmcustbyphone.htm",
	                                            type : "GET",
	                                            data : {
	                                             term : request.term
	                                            },

	                                            dataType : "json",

	                                            success : function(data) {
	                                                 custcontactno=JSON.parse(data);
	                                                 console.log(custcontactno);
	                                                 if(custcontactno==null){
	                                                	// alert("if null");
	                                                	 $("#modroomreservecustIdhidden").val('');
	                                                	 $("#modroomreservecustName").val('');
	         	                                         $("#modroomreservecustEmail").val('');
	                                                	
	                                                     }
	                                              else{
	                                            	  //alert("if else");
	                                            	  
	                                            	  $("#modroomreservecustIdhidden").val(custcontactno.id);
	                                            	  $("#modroomreservecustName").val(custcontactno.name);
         	                                          $("#modroomreservecustPhone").val(custcontactno.phone); 	                                
         	                        	              $("#modroomreservecustEmail").val(custcontactno.email);
                                                     }
	                                             },
	                                            error : function(error) {
	                                                console.log('error: ' + error);
	                                            }
	                                        }); 
	                            },
	                        
	                            select : function(e, ui) {
                                 }
	                          	                            
	                        })
	       
	    });  */
 

var custname;
 $(function() {
     $("#modroombookcustName")
             .autocomplete(
                     {
                         source : function(request, response) {
                        	if (request.term.length >= 3) { 
                        		var searchterm=request.term;
                        		var is_phone=false;
                        		var res=getCustomerDetailsByPhoneOrName(storeID,searchterm,is_phone);
                        		if(res!=null && res!=""){
                        			 response($.map(
                                    		   res,
                                                          function(v) {
                                                              return {
                                                            	   label : v.name,
                                                                  phno:v.contactNo,
                                                                  addr:v.address,
                                                                  custId:v.id,
                                                                  items:v,
                                                                  
                                                              };

                                                          }));
                        		}else{
                         			$('#newcustomerbtn').css("display", "block");
                         		}
                           
                        	}
                         },
                       
                         select : function(e, ui) {
                        	 //alert("REFERENCE NUMBER IS:"+ui.item.items.refNo);
                     	    //alert("REMARKS  IS:"+ui.item.items.remarks);
                        	console.log("UI ITEM OBJECT IS:",ui.item);
                        	$('#newcustomerbtn').hide();
                        	var temp_dob=ui.item.items.dob;
                        	var dob=moment(temp_dob).format("YYYY-MM-DD");
                        	$("#modroombookcustId").val(ui.item.items.id);
                     	    $("#modroombookcustName").val(ui.item.items.name);
                     	    $("#modroombookcustPhone").val(ui.item.items.contactNo);
                     	    $("#modroombookcustGender").val(ui.item.items.gender);
                     		$("#modroombookcustEmail").val(ui.item.items.emailId);
                     		$("#modroombookcustdob").val(dob);
                     		$("#modroombookcustLocation").val(ui.item.items.location);
                     		$("#modroombookcustAddress").val(ui.item.items.address);
                     		$("#modroombookcusthouseno").val(ui.item.items.house_no);
                     		$("#modroombookcuststreet").val(ui.item.items.street);
                     		$("#modroombookcuststate").val(ui.item.items.state);
                     		$("#modroombookuniqueIdType").val(ui.item.items.uniqueidType);
                     		$("#modroombookuniqueId").val(ui.item.items.uniqueidNo);
                     		$("#gstno").val(ui.item.items.cust_vat_reg_no);
                     		//$("#modroombookrefNo").val(ui.item.items.refNo);
                     		//$("#modroombookremarks").val(ui.item.items.remarks);                     		           
                     		//$("#gstno").prop("disabled",true);
                          }

                     })
   
 });
 $(function() {
     $("#modroombookcustPhone")
             .autocomplete(
                     {
                         source : function(request, response) {
                         if (request.term.length >= 3) { 
                        	 var searchterm=request.term;
                     		var is_phone=true;
                     		var res=getCustomerDetailsByPhoneOrName(storeID,searchterm,is_phone);
                     		//alert("ENTERS HERE AUTOCOMPLETE PHONE");
                     		if(res!=null && res!=""){
                     			//alert("ENTERS HERE")
                     			/*  if (res.length>2) {
                           		 $('#newcustomerbtn').css("display", "none");
                           	     } else {
        							$('#newcustomerbtn').css("display", "block");
        						 }  */
                     			response($.map(
                             		   res,
                                                   function(v) {
                                                       return {
                                                     	  label :v.contactNo,
                                                           phno:v.contactNo,
                                                           addr:v.address,
                                                           custId:v.id,
                                                           items:v,
                                                           
                                                       };

                                                   }));
                     			
                     		}else{
                     			$('#newcustomerbtn').css("display", "block");
                     		}
                            /*  $.ajax({
                            			url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
                                 		type : "GET",
                                         data : {
                                          term : request.term
                                         },

                                         dataType : "json",

                                         success : function(data) {
                                        	 if (data.length >2) {
                                        		 $('#newcustomerbtn').css("display", "none");
                                        	 } else {
                     							$('#newcustomerbtn').css("display", "block");
                     						 }
                                           custname=JSON.parse(data);
                                            console.log(custname);
                                          
                                           if(data==null){ }
                                           else{
                                           console.log("in else");
                                           response($.map(
                                        		   custname,
                                                              function(v) {
                                                                  return {
                                                                	  label : v.contactNo,
                                                                      phno:v.contactNo,
                                                                      addr:v.address,
                                                                      custId:v.id,
                                                                      items:v,
                                                                      
                                                                  };

                                                              }));
                                          }
                                      


                                         },
                                         error : function(error) {
                                             console.log('error: ' + error);
                                         }
                                     }); */
                             }
                         },
                       
                         select : function(e, ui) {
                        		//console.log("UI ITEM OBJECT IS:",ui.item);
                        		$('#newcustomerbtn').hide();
                        	    var temp_dob=ui.item.items.dob;
                        	    /* alert("REFERENCE NUMBER IS:"+ui.item.items.refNo);
                        	    alert("REMARKS  IS:"+ui.item.items.remarks); */
                         	    var dob=moment(temp_dob).format("YYYY-MM-DD");
                        	    $("#modroombookcustId").val(ui.item.items.id);
                        	    $("#modroombookcustName").val(ui.item.items.name);
                        	    $("#modroombookcustPhone").val(ui.item.items.contactNo);
                        	    $("#modroombookcustGender").val(ui.item.items.gender);
                        		$("#modroombookcustEmail").val(ui.item.items.emailId);
                        		$("#modroombookcustdob").val(dob);
                        		$("#modroombookcustLocation").val(ui.item.items.location);
                        		$("#modroombookcustAddress").val(ui.item.items.address);
                        		$("#modroombookcusthouseno").val(ui.item.items.house_no);
                        		$("#modroombookcuststreet").val(ui.item.items.street);
                        		$("#modroombookcuststate").val(ui.item.items.state);
                        		$("#modroombookuniqueIdType").val(ui.item.items.uniqueidType);
                         		$("#modroombookuniqueId").val(ui.item.items.uniqueidNo);
                         		$("#gstno").val(ui.item.items.cust_vat_reg_no);
                         		//$("#modroombookrefNo").val(ui.item.items.refNo);
                         		//$("#modroombookremarks").val(ui.item.items.remarks);  
                         		//$("#gstno").prop("disabled",true);
                          }

                     })
   
 });
</script>


</body>
</html>