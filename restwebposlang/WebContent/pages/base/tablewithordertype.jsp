<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Table :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
   <!--  For event calendar-->
   <link href="${pageContext.request.contextPath}/assets/css/calendar/fullcalendar.min.css" rel="stylesheet"/>
   <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet"/>
   
   

<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
/* this class use for showing autocomplete data on modal */
 .ui-autocomplete {
    overflow-y: scroll; max-height: 250px; width: 300px; word-break: break-all; z-index: 2150000000 !important;
} 
 /* .modal:nth-of-type(even) {
    z-index: 1042 !important;
}
.modal-backdrop.in:nth-of-type(even) {
    z-index: 1041 !important;
} 
 */

div.postable .table-image {
	background: url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/table_empty.png') no-repeat center; height: 65px; width: 65px;
}

div.postable div.table-index {
	text-align: center; color: #242b31; margin: 20px auto 0;
}

#calendar{
 /* background:#B0C4DE; */
}
#tblorderdata td, th{
padding: 4px;
}
</style>
</head>
<body>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
     <c:set var="today" value="<%=new java.util.Date()%>" />
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-10 col-sm-10" style="background-image:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/wooden_bg.jpg');">
					<div style="height: 100%; width: 100%;">
						<div style="height: 500px; overflow-y: auto;">
							<c:if test="${empty tableList }">
								<spring:message code="admin.tablenew.jsp.noTabFound" text="No Table found!!!!" />
							</c:if>
							<c:if test="${!empty tableList }">
								<c:forEach items="${tableList}" var="tables">
									<c:if test="${sessionScope.loggedinStore.tableLayout=='Y'}">

										<c:choose>
											<c:when test="${sessionScope.loggedinStore.multiOrderTable=='N'}">
												<div class="table-holder1" style="position: absolute; top:${tables.yPos}px; left:${tables.xPos}px;">
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='N'}">

														<div class="postable booked" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
															<div class="postable table-image-booked">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>
																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																</div>
																<div class="table-subinfo">
																	<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div>

													</c:if>
													
													
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='N'}">

														<div class="postable booked" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
															<div class="postable table-image-billed">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">																
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																</div>
																<div class="table-subinfo">
																	${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div>

													</c:if>
													
													
													
													<c:if test="${tables.status=='Y' && tables.isBooked=='N' && tables.ischildTable=='N'}">
														<div class="postable enabled" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','0','0')">
															<div class="postable table-image">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>
																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo"></div>
																<div class="table-subinfo"></div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='Y'}">
														<div class="postable booked">
															<div class="postable table-image-booked">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																</div>
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													
													
													
												<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='Y'}">
														<div class="postable booked">
															<div class="postable table-image-billed">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																</div>
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													
													
												<c:if test="${tables.status=='N' && tables.isBooked=='N' && tables.ischildTable=='N'}">
														<div class="postable disabled">
															<div class="postable table-image-disabled">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.disableORbooked" text="Disabled Or Booked" />">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo"></div>
																<div class="table-subinfo"></div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
												</div>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${tables.multiOrder=='N'}">

														<div class="table-holder1" style="position: absolute; top:${tables.yPos}px; left:${tables.xPos}px;">

															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N'  && tables.ischildTable=='N'}">
																<div class="postable booked" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																		</div>
																		<div class="table-subinfo">
																			<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y'  && tables.ischildTable=='N'}">
																<div class="postable booked" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		
																		<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																		</div>
																		<div class="table-subinfo">
																			<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
													     	<c:if test="${tables.status=='Y' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable enabled" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','0','0')">
																	<div class="postable table-image">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																		</div>
																   </div>
														        	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo"></div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															<c:if test="${tables.status=='N' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable disabled">
																	<div class="postable table-image-disabled">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.disableORbooked" text="Disabled Or Booked" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo"></div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
														</div>
													</c:when>
													<c:otherwise>
														<div class="table-holder1" style="position: absolute; top:${tables.yPos}px; left:${tables.xPos}px;">
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='N'}">
																<div class="postable booked" onclick="javascript:showmultitableOrderModal('${tables.tableId}','${tables.tableNo}','${tables.noofOrder}',${tables.seatingCapacity})">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo">${tables.noofOrder}<spring:message code="admin.tablenew.jsp.orders" text="ORDERS" />
																		</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='N'}">
																<div class="postable booked" onclick="javascript:showmultitableOrderModal('${tables.tableId}','${tables.tableNo}','${tables.noofOrder}',${tables.seatingCapacity})">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo">${tables.noofOrder}<spring:message code="admin.tablenew.jsp.orders" text="ORDERS" />
																		</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable enabled" onclick="javascript:showmultitableOrderModal('${tables.tableId}','${tables.tableNo}','${tables.noofOrder}',${tables.seatingCapacity})">
																	<div class="postable table-image">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
														
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															
															<c:if test="${tables.status=='N' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable disabled">
																	<div class="postable table-image-disabled">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
														</div>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.tableLayout=='N'}">

										<c:choose>
											<c:when test="${sessionScope.loggedinStore.multiOrderTable=='N'}">
												<div class="table-holder2">
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='N'}">
														<div class="postable" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
															<div class="postable table-image-booked">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>
																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																</div>
																<div class="table-subinfo">
																	<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='N'}">
														<div class="postable" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
															<div class="postable table-image-billed">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																
																<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																</div>
																<div class="table-subinfo">
																	<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													
													
													
													<c:if test="${tables.status=='Y' && tables.isBooked=='N' && tables.ischildTable=='N'}">
														<div class="postable" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','0','0')">
															<div class="postable table-image">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>
																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo"></div>
																<div class="table-subinfo"></div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='Y'}">
														<div class="postable booked">
															<div class="postable table-image-booked">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" />,<spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																</div>
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
											
												
												<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='Y'}">
														<div class="postable booked">
															<div class="postable table-image-billed">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" />,<spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																</div>
																<div class="table-subinfo">
																	<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
													
													
													
													<c:if test="${tables.status=='N' && tables.isBooked=='N' && tables.ischildTable=='N'}">
														<div class="postable">
															<div class="postable table-image-disabled">
																<div class="table-index">
																	<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" />,<spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																</div>
															</div>
															<div class="table-info hide">
																<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																	<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																	<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																	</div>
																</c:if>
																<div class="table-subinfo"></div>
																<div class="table-subinfo"></div>
															</div>
															<br style="clear: both;">
														</div>
													</c:if>
												</div>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${tables.multiOrder=='N'}">

														<div class="table-holder2" style="background-color: none;">

															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='N'}">
																<div class="postable" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																		</div>
																		<div class="table-subinfo">
																			<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='N'}">
																<div class="postable" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','${tables.order.id}','0')">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		
																		<div class="table-subinfo">${tables.noofItem}<spring:message code="admin.tablenew.jsp.items" text="ITEMS" />
																		</div>
																		<div class="table-subinfo">
																			<%-- ${sessionScope.loggedinStore.currency} --%>${tables.orderAmt}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable" onclick="javascript:clickOnTable('${tables.tableId}','${tables.tableNo}','0','0')">
																	<div class="postable table-image">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="${tables.noofItem}-<spring:message code="admin.tablenew.jsp.items" text="Items" /> , <spring:message code="admin.tablenew.jsp.amount" text="Amount" />-${tables.orderAmt}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo"></div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															
															
															
															
															
															
															
															<c:if test="${tables.status=='N' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable">
																	<div class="postable table-image-disabled">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.disableORbooked" text="Disabled Or Booked" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo"></div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
														</div>
													</c:when>
													<c:otherwise>
														<div class="table-holder2">
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='N'}">
																<div class="postable" onclick="javascript:showmultitableOrderModal('${tables.tableId}','${tables.tableNo}','${tables.noofOrder}',${tables.seatingCapacity})">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo">${tables.noofOrder}<spring:message code="admin.tablenew.jsp.orders" text="ORDERS" />
																		</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='N'}">
																<div class="postable" onclick="javascript:showmultitableOrderModal('${tables.tableId}','${tables.tableNo}','${tables.noofOrder}',${tables.seatingCapacity})">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo">${tables.noofOrder}<spring:message code="admin.tablenew.jsp.orders" text="ORDERS" />
																		</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable" onclick="javascript:showmultitableOrderModal('${tables.tableId}','${tables.tableNo}','${tables.noofOrder}',${tables.seatingCapacity})">
																	<div class="postable table-image">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" /> ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='N' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-booked">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.isBilled=='Y' && tables.ischildTable=='Y'}">
																<div class="postable booked">
																	<div class="postable table-image-billed">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />,<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />${tables.parentTable}">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.mergewith" text="Merged with" />
																		</div>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.tableno" text="Table No" />${tables.parentTable}</div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
															
															
															
															
															
															<c:if test="${tables.status=='N' && tables.isBooked=='N' && tables.ischildTable=='N'}">
																<div class="postable">
																	<div class="postable table-image-disabled">
																		<div class="table-index">
																			<a href="#" style="color: black;" title="${tables.seatingCapacity} <spring:message code="admin.tablenew.jsp.seats" text="Seats!" />" data-toggle="popover" data-trigger="hover" data-content="<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />, <spring:message code="admin.tablenew.jsp.disableORbooked" text="Disabled Or Booked" />, ${tables.noofOrder}<spring:message code="admin.tablenew.jsp.order" text="ORDERS" />">${tables.tableNo}</a>
																		</div>
																	</div>
																	<div class="table-info hide">
																		<c:if test="${sessionScope.loggedinStore.id!=37 && sessionScope.loggedinStore.id!=38}">
																			<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>

																			<div class="table-subinfo">${tables.seatingCapacity}<spring:message code="admin.tablenew.jsp.seaters" text="SEATERS" />
																			</div>
																		</c:if>
																		<div class="table-subinfo">
																			<spring:message code="admin.tablenew.jsp.multiorder" text="Multiorder" />
																		</div>
																		<div class="table-subinfo"></div>
																	</div>
																	<br style="clear: both;">
																</div>
															</c:if>
														</div>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>

									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<%-- <form:form modelAttribute="table" action="#">
                		<div style="padding:8px;height: 500px;">
                    		<div class="item" style="margin-bottom:10px;">
                    			<form:select path="TableId" cssStyle="padding:5px 0 5px 0; width:100%; color:#222222;">
                    				<form:option value="0">Select Table</form:option>
									<form:options items="${tableList}" itemValue="tableId" itemLabel="tableNo"/>
                    			</form:select>
                				<select></select>
                        	</div>
                			<div class="item item-sub-child" style="background:#72bb4f;" >
                    			<a href="javascript:updatetableStatus(1)">ENABLED</a>
                    		</div>
                    		<div class="item item-sub-child" style="background-color:#e32b2b;">
                    			<a href="javascript:updatetableStatus(2)">DISABLED</a>
                    		</div>
                    		<div class="item item-sub-child" style="background-color:#ff7a41; margin-top:270px;">
                    			<a href="#">PARCEL</a>
                    		</div>
              			</div>
              			</form:form> --%>
						<div style="padding: 8px; height: 300px;">
							<div class="item" style="margin-bottom: 10px;">
								<select id="TableId" style="padding: 5px 0 5px 0; width: 100%; color: #222222;">
									<option value="0"><spring:message code="admin.tablenew.jsp.slctTab" text="Select Table" /></option>
									<c:forEach items="${tableList}" var="tablelist">
										<option value="${tablelist.tableId}">${tablelist.tableNo}</option>
									</c:forEach>
								</select>

							</div>
							<c:forEach items="${tableList}" var="tablelist">
								<input type="hidden" id="tabstatus${tablelist.tableId}" value="${tablelist.isBooked}" />
							</c:forEach>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:updatetableStatus(1)"><spring:message code="admin.tablenew.jsp.enabled" text="ENABLED" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #e32b2b;">
								<a href="javascript:updatetableStatus(2)"><spring:message code="admin.tablenew.jsp.disabled" text="DISABLED" /></a>
							</div>
							
							
							
							
							<c:forEach items="${menuCatDirectList}" var="catDlist" varStatus="itemStat">
								<c:if test="${catDlist.directCat=='Y'}">
									<div class="item item-sub-child menucathead${itemStat.index}">
										<a href="${pageContext.request.contextPath}/order/vieworders.htm?ono=0&tno=0&sno=0&itcno=${catDlist.id}&flg=N&ptype=">${catDlist.menuCategoryName}</a>
									</div>
								</c:if>
							</c:forEach>
							<%--  <c:if test="${sessionScope.loggedinStore.id==39}">
								<div class="item item-sub-child" style="background-color: #dcaf32; margin-top: 100px;">
									<a href="${pageContext.request.contextPath}/order/vieworders.htm?ono=0&tno=0&sno=0&itcno=683&flg=N&ptype=">SHOWARMA COUPON</a>
								</div>
								<div class="item item-sub-child" style="background-color: #1abb9c;">
									<a href="${pageContext.request.contextPath}/order/vieworders.htm?ono=0&tno=0&sno=0&itcno=694&flg=N&ptype=">FISH COUPON</a>
								</div>
								<div class="item item-sub-child" style="background-color: #da84cb;">
									<a href="${pageContext.request.contextPath}/order/vieworders.htm?ono=0&tno=0&sno=0&itcno=698&flg=N&ptype=">SOFT DRINKS COUPON</a>
								</div>
								<div class="item item-sub-child" style="background-color: #ff7a41;">
									<a href="${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0">PARCEL</a>
								</div>
							</c:if>  --%>
							
							<%-- <c:if test="${sessionScope.loggedinStore.parcelFlag=='Y'}">
								<div class="item item-sub-child" style="background-color: #ff7a41; margin-top: 50px; text-align: left;" >
									<a href="${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0" style="padding: 8px 20px;"><img src="${pageContext.request.contextPath }/assets/images/base/f/ic_parcel.png" > <spring:message code="admin.tablenew.jsp.parcel" text="PARCEL" /></a>
								</div>
							</c:if>
							<c:if test="${sessionScope.loggedinStore.homeDeliveryFlag=='Y'}">
								<div class="item item-sub-child" style="background-color: #da84cb; text-align: left;">
									<a href="${pageContext.request.contextPath}/order/vieworderHD.htm?ono=0&tno=0&sno=0&ot=h" style="padding: 8px 20px;"><img src="${pageContext.request.contextPath }/assets/images/base/f/ic_homeDelevery.png" > <spring:message code="admin.tablenew.jsp.homedelivery" text="HOME DEL" /></a>
								</div>
							</c:if>
							<div class="item item-sub-child" style="background-color: #F5861F;">
								<a href="${pageContext.request.contextPath}/order/vieworderSWIG.htm?ono=0&tno=0&sno=0&ot=s"><spring:message code="admin.table.jsp.swiggy" text="SWIGGY" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #CB202D;">
								<a href="${pageContext.request.contextPath}/order/vieworderZOM.htm?ono=0&tno=0&sno=0&ot=z"><spring:message code="admin.table.jsp.zomato" text="ZOMATO" /></a>
							</div> --%>
							
							<div id="order_type" class="col-md-12 col-sm-12"
						style="font-size: 20px; font-weight: bold; text-transform: uppercase;margin-top:50px; width: 100%;">
						<spring:message code="admin.tablenew.jsp.OrderType" text="Order Type" /> <select id="orderType" style="color: black;" onchange="javascript:selectOrderType()">
						 <option value="SELECT" style="text-align: center;font-size: 14px; font-weight: bold;"><spring:message code="admin.tablenew.jsp.Select" text="SELECT" /></option> 
							<c:forEach items="${orderTypeList}" var="typeList">
								<c:if test="${typeList.orderTypeName!='Dine In' }">
									<option value="${typeList.id}" style="text-align: center;font-size: 14px; font-weight: bold;">${typeList.orderTypeName}</option>
								</c:if>
                			</c:forEach>
						</select>
						</div>
					</div>
					
					    <!--New added for item add 5th Oct 2018 start  -->
					    <%-- <c:if test="${sessionScope.loggedinStore.is_additem == 'Y'}"> --%>
					    <c:if test="${sessionScope.loggedinStore.id==29 || sessionScope.loggedinStore.id==125}">
								
						<div class="item item-sub-child" style="background: #72bb4f;margin-top: 25px;">
						      <a href="javascript:shownmenuitemsaddModal()" >ADD ITEM</a>
						</div>
						</c:if>
						<%-- </c:if> --%>
						<!--New added for item add 5th Oct 2018 end  -->
						
					  	 <c:set var = "advorderno" scope = "session" value = "${noofpreorder}"/>
						<c:if test = "${advorderno > 0}">
 						<div class="item item-sub-child" style="margin-top:150px;background-color:lightblue;">
								<a href="javascript:openadvtblbooklistsearchmodal()"><font size="3" color="black" style="font-weight: bold;">${noofpreorder}&nbsp;<spring:message code="admin.admleftpanel.jsp.prebookingnotice" text="Advance Bookings" /></font></a>
						</div>
						</c:if>  
						
					</div>
					  
				</div>
			</div>

			<!-- modal starts -->
			<%-- <div class="modal fade" data-backdrop="static" id="selecttablealertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablenew.jsp.alert" text="Alert!" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;"><spring:message code="admin.tablenew.jsp.plSlctTable" text="Please select a table!" /></div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.tablenew.jsp.ok" text="OK" /></button>
						</div>
					</div>
				</div>
			</div> --%>

			<div class="modal fade" data-backdrop="static" id="bookedtablealertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.tablenew.jsp.alert" text="Alert!" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="admin.tablenew.jsp.tabBooked" text="This table is booked,cannot be disabled!" />
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.tablenew.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="confirmoperationtableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.tablenew.jsp.confrmtion" text="Confirmation!" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="admin.tablenew.jsp.areYouSure" text="Are you sure?" />
								<input type="hidden" value="" id="targettableId"> <input type="hidden" value="" id="targettableOpt">
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal">
								<spring:message code="admin.tablenew.jsp.cancel" text="CANCEL" />
							</button>
							<button type="button" onclick="javacsript:updateTableOperation()" style="background: #72BB4F; font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">
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
										 <!--  <input type="text" id="waiterName"
											style="width: 60%; color: #222222; margin-bottom: 5px;" />   -->
						                   <select id="waiterName" style="width: 60%; color: #222222; margin-bottom: 5px;">
									       <option value="0"><spring:message code="admin.tablenew.jsp.slctWaiter" text="Select Waiter" /></option>
									       <c:forEach items="${waiterlist}" var="waiter">
										       <option value="${waiter.name}">${waiter.name}</option>
									       </c:forEach>
								         </select> 
						
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
			
			

			
			<div class="modal fade" data-backdrop="static" id="multitableOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.tablenew.jsp.tablen" text="Table No:" />
								<span id="multitableOrderModaltabcontId">00</span> <span style="float: right;"><spring:message code="admin.tablenew.jsp.noOfOrder" text="NO OF ORDER:" /> <span id="multitableOrderModalnoofordercontId">0</span></span>

							</h4>

						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<input type="hidden" id="multiordermodhidtabId" value=""> <input type="hidden" id="multiordermodhidtabCapacity" value="">
								<div id="multiorderlistcontId"></div>

								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="multiorderModalalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="width: 30%; background: #F60; font-weight: bold;" class="btn btn-warning" data-dismiss="modal">
								<spring:message code="admin.tablenew.jsp.cancel" text="CANCEL" />
							</button>
							<!-- <button type="button" onclick="javascript:createNewMultiOrder(document.getElementById('multiordermodhidtabId').value,document.getElementById('multitableOrderModaltabcontId').innerHTML,document.getElementById('multiordermodhidtabCapacity').value)" style="width:35%; background: #72BB4F;font-weight: bold;" class="btn btn-success">CREATE NEW ORDER</button> -->
						</div>
					</div>
				</div>
			</div>
			
			
			
			<!-- Advance booking table details data model start -->
	<div class="modal fade" data-backdrop="static" id="advtblbooklistsearchModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog modal-lg" >
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.admleftpanel.jsp.prebookingheader" text="ADVANCE TABLE BOOKING" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<%-- <div class="row" style="text-align: center; font-size: 20px;">
							    <div class="col-lg-5 col-md-5">
								<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_inv_po_period.jsp.frmDate" text="From Date:" /></span>
								<input type="text" id="fromdateforpretblbook" style="color:black;" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />" >
								
								</div>
                                <div class="col-lg-5 col-md-5">								
								 <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_inv_po_period.jsp.toDate" text="To Date:" /></span>
								 <input type="text" id="todateforpretblbook" style="color:black;" size="10" > 
								 </div>
								 <div class="col-lg-2 col-md-2">
								     <a href="javascript:showdetailsofadvtablebooking(document.getElementById('fromdateforpretblbook').value,document.getElementById('todateforpretblbook').value)" class="btn btn-success" style="background:#0CF;margin-bottom: 3px;"><spring:message code="admin.rpt_inv_po_period.jsp.submit" text="SUBMIT" /></a>             									
								 </div>
								 
						      </div> --%>
						      <div id="tableprebookingdetaildata"></div>
						      <div id='calendar'></div>
						
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.tablenew.jsp.ok" text="OK" />
							</button>
						</div>
					
				</div>
			</div>
		</div>
			<!-- Advance booking table details data model end -->	
			
			<!--ADD Item Modal Start  -->
			<div class="modal fade" data-backdrop="static" id="menuitemAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menuitems.jsp.addMenuItem" text="Add Menu Item" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 18px;">
                                        		
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.catName" text="CATEGORY NAME" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="menucategoryId" onchange="javascript:selectCatValue(this.value)" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty menucatList}">
                                            					<c:forEach items="${menucatList}" var="menucat">
                                            						<option value="${menucat.id}~${menucat.menuCategoryName}">${menucat.menuCategoryName}</option>
                                            					</c:forEach>
                                            					</c:if>                                   
                                            				</select>
                                            				
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="menusubcategoryId" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty menusubcatList}">
                                            					   <c:forEach items="${menusubcatList}" var="menusubcat">
                                            						<option value="${menusubcat.id}">${menusubcat.menuCategoryName}</option>
                                            					  </c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.itemName" text="ITEM NAME" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsName" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.itemDesc" text="ITEM DESC" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<textarea id="modaddmenuitemsDesc" rows="2" style="margin-bottom: 2px;color: #222222;width: 95%;"></textarea>
                                            			<!-- <input type="text" id="modaddmenuitemsDesc" value="" style="margin-bottom: 3px;color: #222222;width: 95%;"/> -->
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.price" text="PRICE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPrice" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.vat" text="VAT(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsVat" value="${sessionScope.loggedinStore.vatAmt}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.serviceTax" text="SERVICE TAX(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsStax" value="${sessionScope.loggedinStore.serviceTaxAmt}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.itemType" text="ITEM TYPE" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemsVeg" name="modaddmenuitemsType" checked="checked" value="Y">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.veg" text="VEG" />&nbsp;
                                            			<input type="radio" id="modaddmenuitemsNonVeg" name="modaddmenuitemsType" value="N">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.nonVeg" text="NON VEG" />
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.spicy" text="SPICY" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemsspicyYes" name="modaddmenuitemsSpicy" value="Y">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddmenuitemsspicyNo" name="modaddmenuitemsSpicy" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.promo" text="PROMOTION" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemspromoYes" onchange="enablePromoFields()" name="modaddmenuitemsPromo" value="Y">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddmenuitemspromoNo" onchange="disablePromoFields()" name="modaddmenuitemsPromo" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.promotionDesc" text="PROMOTION DESC" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPromoDesc" disabled="disabled" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.promotionValue" text="PROMOTION VALUE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPromoValue" disabled="disabled" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.cookItem" text="COOKING TIME(MIN.)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsCookingTime"  value="10" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.itemUnit" text="ITEM UNIT" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modaddmenuitemsUnit" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty fmcgList}">
                                            					<c:forEach items="${fmcgList}" var="fmcg">
                                            						<option value="${fmcg.name}">${fmcg.name}</option>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menuitems.jsp.kotprint" text="KOT PRINT" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modaddmenuitemsKotPrint" style="margin-bottom: 2px;color: #222222;">
                                            					 <option value="Y">YES</option>
                                                                 <option value="N">NO</option>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		</table>
                                            	
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addmenuitemsalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menuitems.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addMenuItems()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menuitems.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
			
			<!--ADD Item Modal End  -->
			<!-- Add Item Alert Modal Start -->
			<div class="modal fade" data-backdrop="static" id="alertmenuitemdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menuitems.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                               
                                            <div id="menuitemdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="location.href='${pageContext.request.contextPath}/table/viewtable.htm'" style="background: #72BB4F;font-weight: bold;width: 25%"  data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menuitems.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div> 		
			<!-- Add Item Alert Modal End -->	
			<!-- Show Order Detail Modal Start -->
			
			<%-- <div class="modal fade" data-backdrop="static"
				id="orderDetailDataModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">
                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                    <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;text-align: center;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Order Details</h4>
                                        </div>
					<div class="modal-body" id="printDiv80"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
                                <div style="text-align: center; width: 230px; font-size: 20px; color: #000000">

							
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="cashOrdervalue80" style="font-weight:bold">00</span>
							</div>


							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
								 <b>Order Date :</b> <span  id="cashOrderdate80">00</span>
							</div>
							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
								 <b>Order Time :</b> <span  id="cashOrdertime80">00</span>
							</div>
							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
								 <b>Booking Date :</b> <span  id="cashBookingdate80">00</span>
							</div>
                            <div style="text-align: left; font-size: 11px; font-family: sans-serif;" id="showtableno80px">
								<b><span id="cashtableNoValue80">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId_80">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">

									<thead>
										<tr>
											<th style="text-align: center; font-size: 11px; font-family: sans-serif;"><spring:message
														code="order.jsp.Items" text="Items" /></th>
											<th
												style="text-align: center; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.Qty" text="Qty" /></th>
											<th
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.RATE" text="RATE" /></th>
											<th
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.TOTAL" text="TOTAL" /></th>
										</tr>
									</thead>

									<tbody style="color: #000000; padding: 1px;"
										id="itemDetailsPrint80"></tbody>

								</table>
							</div>

							<div style="text-align: center;">--------------------------------</div>

							<table style="height: 50px; width: 100%;" id="orderAmtDetails">

								<tr>
									<td><b><span style="font-weight: bold; font-size: 12px; font-family: sans-serif;">         <spring:message code="order.jsp.TotalAmount" text="NET TOTAL" /> :</span></b></td>
									<td style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashgrossAmount80">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td style="text-align: right; font-size: 11px; font-family: sans-serif;">
									       <b><span id="cashamoutPaid80">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td style="text-align: right; font-size: 11px; font-family: sans-serif;">
									       <b><span id="cashamoutToPay80">00</span></b></td>
								</tr>

								<tr>
									<td style="text-align: center;">----------------------------</td>
									<td></td>
								</tr>

								<tr id="custr80" style="display:none;">
									<td style="text-align: left;font-size: 15px; font-family: sans-serif;font-weight:bold;" >Customer Data</td>
								</tr>
						
                                 <tr id="cusnametr80" style="display:none;">
									<td style="text-align: left;font-size: 15px; font-family: sans-serif;" >Name:</td>
									<td id="cusname80" style="text-align: right;font-size: 15px; font-family: sans-serif;"></td>
								</tr>
								 <tr id="cusphnotr80" style="display:none;">
									<td style="text-align: left;font-size: 15px; font-family: sans-serif;" >Contact:</td>
									<td id="cusphno80" style="text-align: right;font-size: 15px; font-family: sans-serif;"></td>
								</tr>
                                  

							</table>
							<div style="text-align: center;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><span
										id="payType80"></span></font></b>
							</div>
							
						</div>
						<div class="modal-footer" id="cashRemovePrint80"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="closeOrderDetailsModal();"
								style="background: #72BB4F; font-weight: bold;"
								 class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
                 </div>

				</div>
			</div> --%>
			<div class="modal fade in" data-backdrop="static" id="orderDetailDataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           Order Details
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;" id="printDivshow">
                        <div style="text-align: left;font-size: 20px;">
                          
                           <table id="tblorderdata">
                              <tbody>
							   <tr>
                                 <td><spring:message code="order.jsp.OrderNoInvoice" text="Order No / Invoice" />:
                                 </td>
                                 <td style=" border-spacing:0 15px;">
								    <span id="cashOrdervalue80" style="font-weight:bold">00</span>
                                 </td>
								 </tr>
                                 <tr>
                                 <td>Order Date:
                                 </td>
                                 <td>
								  <span  id="cashOrderdate80">00</span>
                                 </td>
								 </tr>
                              	 <tr>
                                 <td>Order Time:
                                 </td>
                                 <td>
								 <span  id="cashOrdertime80">00</span>
                                 </td>
								 </tr>
                                 <tr>
                                 <td>Booking Date:
                                 </td>
                                 <td>
								  <span  id="cashBookingdate80">00</span>
                                 </td>
								 </tr>
                                 <tr>
                                 <td> Order Type:
                                 </td>
                                 <td>
								  <span id="cashtableNoValue80"></span>
                                 </td>
								 </tr>
                              </tbody>
							  </table>
							  <br>
							  <table id="custrshow" style="display:none;">
							  <tbody>
							  <tr>
							  <td colspan="2">
							    <span style= "text-decoration: underline;">Customer Details</span> 
							  </td>
							  </tr>
							   <tr id="cusnametr80" style="display:none;padding-bottom: 2px;padding-top: 3px;">
                                 <td> Name:&nbsp;&nbsp;</td>
                                 <td id="cusname80"></td>
                              </tr>
							  <tr id="cusphnotr80" style="display:none;">
                                 <td> Contact No: &nbsp;&nbsp;</td>
                                 <td id="cusphno80"></td>
                               </tr>
                              	</tbody>
							  </table>									
                             
                            <br>
                            <div style="height:100px;border:solid 1px white;overflow:scroll;overflow-x:hidden;overflow-y:scroll;" id="ordrDetailDiv">
							<table class="table table-striped table-bordered" style="color:#FFF; border:1px solid #222222;font-size:70%;" id="ordereditems">
							<thead>
							<tr>
							<th style="text-align:center;"><spring:message code="order.jsp.Items" text="Items" /></th>
							<th style="text-align:center;"><spring:message code="order.jsp.Qty" text="Qty" /></th>
							<th style="text-align:center;"><spring:message code="order.jsp.RATE" text="RATE" /></th>
							<th style="text-align:center;"><spring:message code="order.jsp.TOTAL" text="TOTAL" /></th>
							</tr>
							</thead>
							<tbody style="color:#fff; padding:1px; max-height: 10px;overflow-y: scroll;" id="itemDetailsPrint80">
							</tbody>
							</table>
						    </div> 
							<table  align="right" id="orderAmtDetails">
							<tr>
							<td><span style="color:#FFF;font-size:70%"><spring:message code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></td>
							<td><span id="cashgrossAmount80" style="color:#FFF;font-size:100%;text-align: right;">00</span></td>
							</tr>
							<tr>
							<td><span style="color:#FFF; font-size:70%"><spring:message code="order.jsp.PAIDAMT" text="PAID AMT" />:</span></td>
							<td><span id="cashamoutPaid80" style="color:#FFF;font-size:100%;text-align: right;">00</span></td>
							</tr>
							<tr>
							<td><span style="color:#FFF; font-size:70%"><spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></td>
							<td> <span id="cashamoutToPay80" style="color:#FFF;font-size:100%;text-align: right;">00</span></td>
							</tr>
							</table>
							</div>
                               
                          <br>
                        </div>
                  
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;text-align: center;">
                         <button type="button" onclick="closeOrderDetailsModal();"
								style="background: #72BB4F; font-weight: bold;margin-left: 100px;"
								 class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
                       
                     </div>
                        </div>
                  </div>
               </div>
			
			<!-- Show Order Detail Modal End -->
				
			<!-- modal ends -->
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->


	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script src="${pageContext.request.contextPath}/assets/js/baseScriptNew.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/advancebookingScript.js"></script>


	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script> 
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<c:choose>
		<c:when test="${pageContext.response.locale == 'ar'}">
			<script src="${pageContext.request.contextPath}/assets/js/lang/baseScript_AR.js"></script>
		</c:when>

		<c:otherwise>
			<script src="${pageContext.request.contextPath}/assets/js/lang/baseScript_EN.js"></script>
		</c:otherwise>
	</c:choose>
     <!-- For event calendar -->
     <script src="${pageContext.request.contextPath}/assets/js/calendar/moment.min.js"></script>
     <script src="${pageContext.request.contextPath}/assets/js/calendar/fullcalendar.min.js"></script>
     <%-- <script src="${pageContext.request.contextPath}/assets/js/calendar/jquery.min.js"></script> --%>
     
	<script type="text/javascript">

	var BASE_URL="${pageContext.request.contextPath}";
	var waiterNameFlag="${sessionScope.loggedinStore.waiterNameFlag}";
	var vatses='${sessionScope.loggedinStore.vatAmt}';
	var staxses='${sessionScope.loggedinStore.serviceTaxAmt}';
	var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
//	alert(waiterNameFlag);
			
			
 
  

   
   
   

	function showselectTablealertModal()
	{
		$('#selecttablealertModal').modal('show');
	}
	function showbookedTablealertModal()
	{
		$('#bookedtablealertModal').modal('show');
	}
	function showconfirmTablealertModal(tableid,opt)
	{
		document.getElementById('targettableId').value=tableid;
		document.getElementById('targettableOpt').value=opt;
		$('#confirmoperationtableModal').modal('show');
	}
	
	function showmultitableOrderModal(tabid,tabno,nooforder,capacity)
	{
		//alert('tabid:'+tabid+':tabno:'+tabno+':orders:'+orders+':nooforders:'+nooforder+':capacity:'+capacity);
		document.getElementById('multiorderModalalertMsg').innerHTML='';
		document.getElementById('multitableOrderModaltabcontId').innerHTML=tabno;
		document.getElementById('multitableOrderModalnoofordercontId').innerHTML=nooforder;
		document.getElementById('multiordermodhidtabId').value=tabid;
		document.getElementById('multiordermodhidtabCapacity').value=capacity;
		var ordersArray=[];
		
		var alphaArray=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
		<c:forEach items="${tableList}" var="fmcg" varStatus="loop">
			if(tabid=='${fmcg.tableId}')
				{
				<c:forEach items="${fmcg.multiOrders}" var="ord" varStatus="loop">
				//ordersArray.push({'${ord.seatNo}':'${ord.id}'});//{id:'${ord.id}',seat:'${ord.seatNo}'};
				ordersArray.push('${ord.seatNo}'+'-'+'${ord.id}'+'-'+'${ord.billPrintcount}'+'-'+'${ord.orderNo}');
				</c:forEach>
				}
		</c:forEach>
	       //alert('capa:'+capacity+':orders:'+ordersArray.length);
	      ordersArray.sort();
	       var seatline="";
	       var seatno="";
	       var orderid="";
	       var billprint="";
	       var orderNumber="";
	       for(var i=0;i<capacity;i++)
	    	   {
	    	   if(ordersArray.length>0)
	    	   	{
	    	   		for(var j=0;j<ordersArray.length;j++)
	    	   		{
	    	   			seatno=ordersArray[j].split('-')[0];
	    	   			orderid=ordersArray[j].split('-')[1];
	    	   			billprint=ordersArray[j].split('-')[2];
	    	   			orderNumber=ordersArray[j].split('-')[3];
	    	   			if(alphaArray[i]==seatno)break;
	    	   			//alert(seatno);
	    	   		}
	    	   	}
	    	   if(alphaArray[i]==seatno && billprint==0)
				{
	 				seatline+="<div onclick='javascript:clickOnTable(&quot;"+tabid+"&quot;,&quot;"+tabno+"&quot;,&quot;"+orderid+"&quot;,&quot;"+alphaArray[i]+"&quot;)' class='btn-order-taking' style='background:#4766d2;text-align:center;height:70px;width:30%;margin:2px;'><div>"+getBaseLang.sets+"&nbsp;&nbsp;"+alphaArray[i]+"</div><div style='font-size:11px;white-space:normal;'>"+getBaseLang.orderNO+"  "+orderNumber+"</div></div>";
				}
	    	   
	    	   else if(alphaArray[i]==seatno && billprint>0){
	    		   seatline+="<div onclick='javascript:clickOnTable(&quot;"+tabid+"&quot;,&quot;"+tabno+"&quot;,&quot;"+orderid+"&quot;,&quot;"+alphaArray[i]+"&quot;)' class='btn-order-taking' style='background:#47d1ac;text-align:center;height:70px;width:30%;margin:2px;'><div>"+getBaseLang.sets+"&nbsp;&nbsp;"+alphaArray[i]+"</div><div style='font-size:11px;white-space:normal;'>"+getBaseLang.orderNO+"  "+orderNumber+"</div></div>"; 
	    		   
	    	   }
	    	   else
	    	   	{
	    	  	 	seatline+="<div onclick='javascript:clickOnTable(&quot;"+tabid+"&quot;,&quot;"+tabno+"&quot;,&quot;0&quot;,&quot;"+alphaArray[i]+"&quot;)' class='btn-order-taking' style='text-align:center;height:70px;width:30%;margin:2px;'><div>"+getBaseLang.sets+"&nbsp;&nbsp;"+alphaArray[i]+"</div><div style='font-size:11px;white-space:normal;'>'"+getBaseLang.noOrdPlcd+"'</div></div>";
	    	   	}
	    	   }
	       document.getElementById('multiorderlistcontId').innerHTML=seatline;
		$('#multitableOrderModal').modal('show');
	}
	function createNewMultiOrder(tableid,tableno,capacity)
	{
		//var nooforder=document.getElementById('multitableOrderModalnoofordercontId').innerHTML;
		//alert('nooforder:'+nooforder+':capa:'+capacity);
		clickOnTable(tableid,tableno,'0');
		/* if(parseInt(nooforder)>=parseInt(capacity))
			{
			document.getElementById('multiorderModalalertMsg').innerHTML='No of Order cant be greater than seting capacity!';
			}
		else
			{
			clickOnTable(tableid,tableno,'0');
			} */
	}
	
	 $(document).ready(function(){
	    $('[data-toggle="popover"]').popover();
	}); 
	</script>
<script type="text/javascript">
$(function() {
    $("#waiterName")
            .autocomplete(
                    {
                 	   
                        source : function(request, response) {
                            $.ajax({
                                        url : "${pageContext.request.contextPath}/table/autocompletewaiterdata.htm",
                                        type : "GET",
                                        data : {
                                            tagName : request.term
                                        },

                                        dataType : "json",

                                        success : function(data) {
                                            response($
                                                    .map(
                                                            data,
                                                            function(v) {
                                                            	   
                                                         	      return {
	                                                                	   label : v.name,   
	                                                                       itemCode : v.id,                                                                   
	                                                                       items:v,
	                                                                   }; 
                                                         	   
                                                                

                                                            }));
                                        },
                                        error : function(error) {
                                            alert('error: ' + error);
                                        }
                                    });
                        },
                        select : function(e, ui) {

                          
                          
                           
                     	   
                        }
                    });
});	

</script>


<script type="text/javascript">
	$('#advtblbooklistsearchModal').on('show.bs.modal', function() {
		setTimeout(function(){
		$('#calendar').fullCalendar('render');
		},300);
		})

	</script>
</body>
</html>