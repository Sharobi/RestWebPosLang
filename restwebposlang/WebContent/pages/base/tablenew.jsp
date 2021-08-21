<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
div.postable .table-image {
	background: url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/table_empty.png') no-repeat center; height: 65px; width: 65px;
}

div.postable div.table-index {
	text-align: center; color: #242b31; margin: 20px auto 0;
}
</style>
</head>
<body>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>

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
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='N'}">

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
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='Y'}">
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

															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='N'}">
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
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='Y'}">
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
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='N'}">
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
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='Y'}">
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
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='N'}">
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
													<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='Y'}">
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

															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='N'}">
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
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='Y'}">
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
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='N'}">
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
															<c:if test="${tables.status=='Y' && tables.isBooked=='Y' && tables.ischildTable=='Y'}">
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
						<div style="padding: 8px; height: 500px;">
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
							<c:if test="${sessionScope.loggedinStore.parcelFlag=='Y'}">
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
							</div>
						</div>
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
			<!-- modal ends -->
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->


	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script src="${pageContext.request.contextPath}/assets/js/baseScript.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>

	<c:choose>
		<c:when test="${pageContext.response.locale == 'ar'}">
			<script src="${pageContext.request.contextPath}/assets/js/lang/baseScript_AR.js"></script>
		</c:when>

		<c:otherwise>
			<script src="${pageContext.request.contextPath}/assets/js/lang/baseScript_EN.js"></script>
		</c:otherwise>
	</c:choose>

	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
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
				ordersArray.push('${ord.seatNo}'+'-'+'${ord.id}');
				</c:forEach>
				}
		</c:forEach>
	       //alert('capa:'+capacity+':orders:'+ordersArray.length);
	      ordersArray.sort();
	       var seatline="";
	       var seatno="";
	       var orderid="";
	       for(var i=0;i<capacity;i++)
	    	   {
	    	   if(ordersArray.length>0)
	    	   	{
	    	   		for(var j=0;j<ordersArray.length;j++)
	    	   		{
	    	   			seatno=ordersArray[j].split('-')[0];
	    	   			orderid=ordersArray[j].split('-')[1];
	    	   			if(alphaArray[i]==seatno)break;
	    	   			//alert(seatno);
	    	   		}
	    	   	}
	    	   if(alphaArray[i]==seatno)
				{
	 				seatline+="<div onclick='javascript:clickOnTable(&quot;"+tabid+"&quot;,&quot;"+tabno+"&quot;,&quot;"+orderid+"&quot;,&quot;"+alphaArray[i]+"&quot;)' class='btn-order-taking' style='background:#4766d2;text-align:center;height:70px;width:30%;margin:2px;'><div>"+getBaseLang.sets+"&nbsp;&nbsp;"+alphaArray[i]+"</div><div style='font-size:11px;white-space:normal;'>"+getBaseLang.orderNO+"  "+orderid+"</div></div>";
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




</body>
</html>