<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="dd" uri="/WEB-INF/taglib/ddformatter.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Order Taking :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />

<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<!-- for saravana numeric keypad -->
<script
	src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/numerickey.js"></script>
<!-- <script src="//console.re/connector.js" data-channel="880b-3d02-1815"
	id="consolerescript"></script -->
<!-- end for saravana numeric keypad -->
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<script>
	function rowClicked(){
		//alert("Table row clicked");
	}
	</script>
<style>
.ui-autocomplete {
	max-height: 300px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden;
	/* add padding to account for vertical scrollbar */
	/*             padding-right: 20px; */
}

li {
	padding: 0px;
	important;
}

.nav-tabs {
	display: flex;
}

.nav-tabs li {
	display: flex;
	flex: 1;
}

.nav-tabs li  a {
	flex: 1;
	text-align: center;
}

li.active {
	padding: 0px;
	important;
}

li.disabled {
	background-color: #000;
}

li>a {
	color: #fff; important;
	height: 100%;
	text-align: center;
	text-decoration: none;
	vertical-align: middle;
	important;
}

li.active>a {
	color: #000; important;
	height: 100%;
	text-align: center;
	text-decoration: none;
	vertical-align: middle;
	important;
}

.nav>li.disabled>a:focus {
	pointer-events: none;
}

span.disable-links>a:focus {
	pointer-events: none;
}

span.enable-links>a:focus {
	pointer-events: auto;
}

#n_keypad_man {
	display: block !important;
}

#enterQtyAlert {
	color: #f60;
	font-size: 12px;
	font-weight: bold;
	text-align: center;
}
.table tr {
    cursor: pointer;
}

</style>

<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body
	onload="showtablebookingData(),directOrderCheck(document.getElementById('directordertakingContId').value),instantPaymentOpenModal()">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<c:set var="today" value="<%=new java.util.Date()%>" />

	<div class="content-wrapper">
		<div class="container-fluid">

			<div class="row">
				<div class="col-md-4 col-sm-4">
					<div style="background: #404040;">

						<div>
							<input type="hidden" id="directordertakingContId"
								value="${directorderTaking}" /> <input type="hidden"
								id="hidinstantPaymentFlag" value="${flag}" /> <input
								type="hidden" id="hidinstantPaymentType" value="${ptype}" />

							<%-- <c:if test="${currentTable=='0'}"> --%>
								<div
									style="background: #404040; width: 99%; font-size: 12px; font-weight: bold;">
									<input type="text" id="itemNameSearch"
										value="${orders.customerName}"
										style="color: #222222; margin-left: 1%; width: 30%;"
										placeholder="CUSTOMER NAME"
										>   <!--  onkeypress='return lettersOnly(event)' -->

									 <input
										type="text" id="itemContactSearch"
										value="${orders.customerContact}"
										style="color: #222222; margin-left: 1%; width: 30%;"
										placeholder="CONTACT NO." maxlength="10"
										onkeypress='return isNumberKey(event)'> <span
										class="disable-links" id='selectCustSpan'> <a
										href="javascript:selectCustDetails()" class="btn-order-taking"
										style="width: 15%; height: 10%; font-size: 12px; margin-left: 1%; text-align: center;">DETAILS
									</a>
									</span> <span class="enable-links" id='addCustSpan'> <a
										href="javascript:addCustDetails()" class="btn-order-taking"
										style="width: 15%; height: 10%; font-size: 12px; margin-left: 1%; text-align: center;">ADD
									</a></span>
									
									<input type="text" id="orderRmks" value="${orders.remarks}" style="display:none;"> 
									
								</div>
							<%-- </c:if> --%>

							<table style="width: 99%">
								<tr>
									<td><a href="javascript:selectAllRow()"
										class="btn-order-taking" style="width: 97%;margin:2px;"><span
											class="fa fa-check"></span> &nbsp;<spring:message
												code="order.jsp.ALL" text="ALL" /></a></td>
									<td><a href="javascript:deleteRows()"
										class="btn-order-taking" style="width: 97%;margin:2px;"><span
											class="fa fa-trash"></span>  <spring:message
												code="order.jsp.DEL" text="DEL" /> </a></td>
									
									 <td><a href="javascript:openRemarksModal()"
										class="btn-order-taking" style="width: 97%;margin:2px;"><span
											class="fa fa-info"></span> <spring:message
												code="order.jsp.RMK" text="RMK" /></a></td> 
												
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.billSplit, 'Y') }">
										<td><a
											href="javascript:openSplitBill(${sessionScope.loggedinStore.id})"
											class="btn-order-taking" style="width: 98%;margin:2px;"><span
												class="fa fa-copy"></span>&nbsp;<spring:message
													code="order.jsp.SPLIT" text="SPLIT" /></a></td>
									</c:if>
									<td><a href="javascript:openpecialNoteModal()"
										class="btn-order-taking" style="width: 98%;margin:2px;"><span
											class="fa fa-pencil"><input type="hidden"
												id="hidstorespltype"
												value="${sessionScope.loggedinStore.specialNoteType}"></span>
											&nbsp;<spring:message code="order.jsp.NOTE" text="NOTE" /></a></td>
									<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.isPax, 'Y') }">
										<td>
										<c:if test="${empty orders}">
										<a href="javascript:openPaxModal()"
											class="btn-order-taking" style="width: 98%;margin:2px;" id="paxbtn"><span
												class="fa fa-users"></span>&nbsp;PAX <span id="noofPaxId">
													
											</span>
										 </a>
										</c:if>
										<c:if test="${!empty orders && orders.table_no=='0' }">
										<a href="javascript:openPaxModal()"
											class="btn-order-taking" style="width: 99%;margin:2px;" id="paxbtn"><span
												class="fa fa-users"></span>&nbsp;PAX <span id="noofPaxId">
													
											</span>
										 </a>
										</c:if>
										<c:if test="${!empty orders && orders.table_no!='0' }">
										<a href="javascript:openPaxModal()"
											class="btn-order-taking" style="width:85%;margin:2px;" id="paxbtn"><span
												class="fa fa-users"></span>&nbsp;PAX <span id="noofPaxId">
													 ${orders.noOfPersons}
                				                   
											</span>
										 </a>
										</c:if>
										
										</td>
									</c:if>
								</tr>
								
							</table>
							<!--<c:choose>
             	<c:when test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
             	<a href="javascript:selectAllRow()"  class="btn-order-taking" style="width: 17%;"><span class="fa fa-check"></span>&nbsp;ALL </a>
                <a href="javascript:deleteRows()" class="btn-order-taking" style="width: 17%;"><span class="fa fa-trash"></span>&nbsp;DEL </a>
                <a href="javascript:openSplitBill(${sessionScope.loggedinStore.id})" class="btn-order-taking" style="width: 18%;"><span class="fa fa-copy"></span>&nbsp;SPLIT </a>
                <a href="javascript:openpecialNoteModal()" class="btn-order-taking" style="width: 18%;"><span class="fa fa-pencil"></span>&nbsp;NOTE </a>
                <a href="javascript:openPaxModal()" class="btn-order-taking" style="width: 20%;"><span class="fa fa-users"></span>&nbsp;PAX
                <span id="noofPaxId">
                <c:if test="${orders.table_no!='0' }">
                ${orders.noOfPersons}
                </c:if>
                </span>
                </a>
             	</c:when>
             	<c:otherwise>
             	<a href="javascript:selectAllRow()"  class="btn-order-taking" style="width: 31%;"><span class="fa fa-check"></span> &nbsp;ALL </a>
                <a href="javascript:deleteRows()" class="btn-order-taking" style="width: 31%;"><span class="fa fa-trash"></span> &nbsp;DELETE </a>

                <a href="javascript:openpecialNoteModal()" class="btn-order-taking" style="width: 31%;"><span class="fa fa-pencil"></span> &nbsp;NOTE </a>
             	</c:otherwise>
             	</c:choose>!-->
							<c:if test="${! empty orders}">
								<input type="hidden" id="hidnoofPax"
									value="${orders.noOfPersons}" />
						<input type="hidden" id="hidnOrderTypeData"
									value="${orders.ordertype.orderTypeName}" />

							</c:if>
							<c:if test="${empty orders}">
								<input type="hidden" id="hidnoofPax" value="1" />
								<c:set var="savedOrderItemCount" value="0"></c:set>
							</c:if>

						</div>
						<div style="background: #404040; overflow-y: auto; padding: 2px;">
							<div class="panel panel-default">
								<div class="panel-body"
									style="height: 285px; background: #404040;">
									<div class="table-responsive" id="orderitemContId">

										<table class="table table-striped table-bordered"
											style="color: #FFF; border: 1px solid #222222;">
											<c:if test="${! empty orders}">

											    <thead>
													<th><spring:message code="order.jsp.SL" text="SL" /></th>
													<th><spring:message code="order.jsp.NAME" text="NAME" /></th>
													<th style="text-align: center;"><spring:message
															code="order.jsp.QUANTITY" text="QUANTITY" /></th>
													<th><spring:message code="order.jsp.RATE" text="RATE" /></th>
													<th><spring:message code="order.jsp.TOTAL"
															text="TOTAL" /></th>
												</thead>

												<tbody style="color: #fff; padding: 1px;">
													<c:forEach items="${orders.orderitem }" var="orderitems"
														varStatus="stat">
														<c:set var="bgCol" value="#2E2E2E"></c:set>

														<c:if
															test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
															<c:set var="bgCol" value="#1c91bc"></c:set>

														</c:if>
														<c:set var="savedOrderItemCount" value="${stat.index+1}"></c:set>
														<tr style="background:${bgCol}; padding:2px;">
															<td style="padding: 1px; text-align: center;">
																${stat.index+1}</td>
															<td
																style="padding: 1px; max-width: 250px !important; word-wrap: break-word;">
																<%-- <c:choose>
																	<c:when test="${orderitems.ordertype==2}">
                                		${orderitems.item.name}(P)
                                	</c:when>
																	<c:otherwise> --%>
                                	${orderitems.item.name}
                                	<%-- </c:otherwise>
																</c:choose> --%>
															</td>
															<td valign="middle" align="center" style="padding: 3px;">
																${orderitems.quantityOfItem}</td>

															<td style="padding: 1px; text-align: center;"><fmt:formatNumber
																	type="number" maxFractionDigits="2"
																	minFractionDigits="2" value="${orderitems.item.price}"></fmt:formatNumber>
															</td>



															<td style="padding: 1px; text-align: center;"><c:if
																	test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
																	<fmt:formatNumber type="number" maxFractionDigits="2"
																		minFractionDigits="2"
																		value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
																</c:if> <c:if
																	test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
																	<fmt:formatNumber type="number" maxFractionDigits="2"
																		minFractionDigits="2"
																		value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
																</c:if></td>



														</tr>

													</c:forEach>

												</tbody>
											</c:if>
											<c:if test="${empty orders}">
											    <thead>
													<th></th>
													<th><spring:message code="order.jsp.NAME" text="NAME" /></th>
													<th style="text-align: center;"><spring:message
															code="order.jsp.QUANTITY" text="QUANTITY" /></th>
															<th><spring:message code="order.jsp.RATE" text="RATE" /></th>
													<th><spring:message code="order.jsp.TOTAL" text="TOTAL" /></th>
													</thead>
												<tbody style="color: #fff; padding: 1px;">
												</tbody>
											</c:if>
										</table>

									</div>
								</div>
							</div>
						</div>
						
						<c:set var="staticVat" value="14.5"></c:set>
						<c:set var="staticST" value="5.6"></c:set>
						<c:set var="netPrice" value="0.00"></c:set>
						<c:set var="paidAmount" value="0.00"></c:set>
						<c:set var="custDisc" value="0.00"></c:set>
						<c:set var="custDiscPerc" value="0.00"></c:set>
						<c:set var="totDisc" value="0.00"></c:set>
						<c:set var="totVat" value="0.00"></c:set>
						<c:set var="totST" value="0.00"></c:set>
						<c:set var="totRate" value="0.00"></c:set>

						<c:set var="subtotalWithOutTax" value="0.00"></c:set>
						<c:set var="subtotalWithTax" value="0.00"></c:set>
						<c:set var="orderVat" value="${sessionScope.loggedinStore.vatAmt}"></c:set>
						<c:set var="orderSTax" value="${sessionScope.loggedinStore.serviceTaxAmt}"></c:set>

						<c:set var="totPrice" value="0.00"></c:set>
						<c:set var="netTotal" value="0.00"></c:set>
						<c:set var="totnonspotDiscAmt" value="0.00"></c:set>
						<c:set var="schrg" value="0.00"></c:set>

						<c:set var="custDiscPerc1" value="0.00"></c:set>
						<c:set var="schargerate" value="0.00"></c:set>
						<c:set var="custDisc1" value="0.00"></c:set>
						<c:set var="schrg1" value="0.00"></c:set>

						<c:if test="${! empty orders}">


							<c:if test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'Y') }">
								<c:set var="custDiscPerc1"
									value="${orders.orderBill.discountPercentage}"></c:set>
							</c:if>


						<!-- /* Item Wise Calculation start */ -->
							<c:forEach items="${orders.orderitem}" var="orditems">
								<c:set var="totDisc1" value="0.00"></c:set>
								<c:set var="totVat1" value="0.00"></c:set>
								<c:set var="totST1" value="0.00"></c:set>
								<c:set var="totnonspotDiscAmt1" value="0.00"></c:set>
								<c:set var="totcustdisc1" value="0.00"></c:set>
								<c:set var="totscharge1" value="0.00"></c:set>
								<c:set var="totRate1" value="0.00"></c:set>
								<c:set var="totalItemRate" value="0.00"></c:set> 
								<c:if test="${fn:containsIgnoreCase(orditems.item.promotionFlag, 'Y') }">
									<c:set var="totDisc1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${orditems.quantityOfItem*(orditems.item.price*orditems.item.promotionValue/100)}" />
									</c:set>
								</c:if>
								<c:set var="totRate">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${totRate+orditems.quantityOfItem*orditems.item.price-totDisc1}" />
								</c:set>
								<c:set var="totRate1">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${orditems.quantityOfItem*orditems.item.price-totDisc1}" />
								</c:set>
								<c:set var="totcustdisc1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totRate1*custDiscPerc1/100}" />
									</c:set>

								<c:set var="totscharge1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${(totRate1-totcustdisc1) * orders.orderBill.serviceChargeRate/100}" />
									</c:set>

								<c:if
									test="${fn:containsIgnoreCase(orditems.item.spotDiscount, 'N') }">
									<c:set var="totnonspotDiscAmt1"> ${totnonspotDiscAmt1+(orditems.quantityOfItem*orditems.item.price)}</c:set>
								</c:if>

								<c:set var="totVat1">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${(totRate1-totcustdisc1+totscharge1)*orditems.item.vat/100}" />
								</c:set>
								<c:set var="totST1">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${(totRate1-totcustdisc1+totscharge1)*orditems.item.serviceTax/100}" />
								</c:set>
								<c:if
									test="${sessionScope.loggedinStore.id==35 && currentTable!='0' && orditems.item.vat==0.00}">
									<c:set var="totVat1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totVat1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*staticVat/100}" />
									</c:set>
								</c:if>
								<c:if
									test="${sessionScope.loggedinStore.id==35 && currentTable!='0' && orditems.item.serviceTax==0.00}">
									<c:set var="totST1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totST1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*staticST/100}" />
									</c:set>
								</c:if>

								<c:set var="totDisc">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${totDisc+totDisc1}" />
								</c:set>

								<c:if
									test="${orditems.item.vat==0.00 && orditems.item.serviceTax==0.00}">
									<c:set var="subtotalWithOutTax">${subtotalWithOutTax+((orditems.quantityOfItem*orditems.item.price)-totDisc1)}</c:set>
								</c:if>
	 							<c:if
									test="${orditems.item.vat!=0.00 || orditems.item.serviceTax!=0.00}">
									<c:set var="orderVat">${orditems.item.vat}</c:set>
									<c:set var="orderSTax">${orditems.item.serviceTax}</c:set>
									<c:set var="subtotalWithTax">${subtotalWithTax+((orditems.quantityOfItem*orditems.item.price)-totDisc1)}</c:set>
								</c:if>

								<c:set var="totVat">${totVat+totVat1}</c:set>
								<c:set var="totST">${totST+totST1}</c:set>
								<c:set var="totnonspotDiscAmt">${totnonspotDiscAmt+totnonspotDiscAmt1}</c:set>
							</c:forEach>
							<!-- /* Item Wise Calculation end */ -->


							<c:if
								test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'Y') }">
								<c:set var="custDisc"
									value="${custDisc+orders.orderBill.customerDiscount}"></c:set>
							</c:if>
							<c:if test="${subtotalWithOutTax>custDisc}">

							<c:set var="subtotalWithTax">${totRate-subtotalWithOutTax}</c:set>
							</c:if>
						<c:if test="${subtotalWithOutTax<=custDisc}">

						<c:set var="subtotalWithTax">${totRate-custDisc}</c:set>
						</c:if>
                               
                               <!--new added for total item price to show in bill 28.9.2018 start  -->
                              <c:set var="totalItemRate1">
								<fmt:formatNumber type="number" groupingUsed="false"
									maxFractionDigits="2" value="${totRate}" />
							</c:set>
							 <!--new added for total item price to show in bill 28.9.2018 end  -->
                                 
							<c:set var="totRate">
								<fmt:formatNumber type="number" groupingUsed="false"
									maxFractionDigits="2" value="${totRate-custDisc}" />
							</c:set>


							<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
								<c:if test="${ordertypeList.serviceChargeValue!=0.0 }">
									<c:set var="schrg">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totRate * orders.orderBill.serviceChargeRate/100}" />
									</c:set>
									<%-- <c:set var="totVat">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totVat+totVat * orderTypeList.serviceChargeValue/100}" />
									</c:set>
									<c:set var="totST">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totST+totST * orderTypeList.serviceChargeValue/100}" />
									</c:set> --%>
								</c:if>
							</c:if>


							<c:set var="totnonspotDiscAmt">
								<fmt:formatNumber type="number" groupingUsed="false"
									minFractionDigits="2" maxFractionDigits="2"
									value="${totnonspotDiscAmt}" />
							</c:set>

							<c:if
								test="${currentTable=='0' && sessionScope.loggedinStore.parcelServiceTax=='N'}">
								<c:set var="totST" value="0.00"></c:set>
							</c:if>

							<c:if
								test="${totRate==0.00}">
								<c:set var="totVat" value="0.00"></c:set>
								<c:set var="totST" value="0.00"></c:set>
								<c:set var="schrg" value="0.00"></c:set>

							</c:if>


							<c:if
								test="${currentTable=='0' && sessionScope.loggedinStore.parcelVat=='N'}">
								<c:set var="totVat" value="0.00"></c:set>
							</c:if>

							<c:set var="paidAmount" value="${paidAmount+orders.paidAmt}"></c:set>

							<c:set var="totPrice" value="${totRate+schrg+totVat+totST}"></c:set>

							<c:set var="netPrice" value="${totPrice-(paidAmount)}"></c:set>
							<c:set var="netTotal" value="${totPrice}"></c:set>
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
								<c:set var="netTotal">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${netTotal +0.5 - ((netTotal+0.5) % 1) }" />
								</c:set>
							</c:if>
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.doubleRoundOff, 'Y') }">

								<c:set var="netTotal">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${netTotal}" />
								</c:set>
								<c:set var="netTotal">
									<dd:ddformatter place="1" number="${netTotal}"></dd:ddformatter>
								</c:set>
								<c:set var="netTotal">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${netTotal}" />
								</c:set>
							</c:if>
						</c:if>
						<input type="hidden" id="hidstoreroundoffFlag"
							value="${sessionScope.loggedinStore.roundOffTotalAmtStatus}">
						<input type="hidden" id="hidstoredoubleroundoffFlag"
							value="${sessionScope.loggedinStore.doubleRoundOff}"> <input
							type="hidden" id="hidserviceTaxTextVal"
							value="${sessionScope.loggedinStore.serviceTaxText}"> <input
							type="hidden" id="hidvatTaxTextVal"
							value="${sessionScope.loggedinStore.vatTaxText}"> <input
							type="hidden" id="hidserviceTaxVal"
							value="${sessionScope.loggedinStore.serviceTaxAmt}"> <input
							type="hidden" id="hidvatTaxVal"
							value="${sessionScope.loggedinStore.vatAmt}"> <input
							type="hidden" id="hidpaidAmtVal" value="${paidAmount}"> <input
							type="hidden" id="hidcustDiscVal" value="${custDisc}"> <input
							type="hidden" id="hidnetTotal" value="${netTotal}"> <input
							type="hidden" id="hidparcelST"
							value="${sessionScope.loggedinStore.parcelServiceTax}"> <input
							type="hidden" id="hidparcelVat"
							value="${sessionScope.loggedinStore.parcelVat}"> <input
							type="hidden" id="mobPrintVal"
							value="${sessionScope.loggedinStore.mobBillPrint}"> <input
							type="hidden" id="kotPrintVal"
							value="${sessionScope.loggedinStore.kitchenPrintBt}"> <input
							type="hidden" id="printbillpapersize"
							value="${sessionScope.loggedinStore.printBillPaperSize}">



						<c:if test="${empty orders}">
						<c:if test="${sessionScope.loggedinStore.serviceChargeFlag!='Y'}">
							<input type="hidden" id="serviceChargeRate" value="0">
						  </c:if>
						   <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
							<input type="hidden" id="serviceChargeRate"
								value="${orderTypeList.serviceChargeValue}">
						  </c:if>
						</c:if>
						<c:if test="${!empty orders}">
						<c:if test="${sessionScope.loggedinStore.serviceChargeFlag!='Y'}">
							<input type="hidden" id="serviceChargeRate" value="0">
						  </c:if>
						   <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
							<input type="hidden" id="serviceChargeRate"
								value="${orders.orderBill.serviceChargeRate}">
						  </c:if>
						</c:if>




						<input type="hidden" id="hidserviceChargeTextNew"
							value="${sessionScope.loggedinStore.serviceChargeFlag}">
						<input type="hidden" id="hidserviceChargeText" value="S.Charge">
						<%-- <input type="hidden" id="storeName" value="${sessionScope.loggedinStore.storeName}"> --%>
						<input type="hidden" id="hidtotnonspotDiscAmt"
							value="${totnonspotDiscAmt}">
							<!-- <input type="hidden" id="hidendiscountpercentage"
							value=""> -->

   				 <input type="hidden" id="dueties_and_tax_accf" value="<spring:message code="accgroup.jsp.duties_code" text="DT"/>">
				 <input type="hidden" id="saleaccunt_group_codef" value="<spring:message code="accgroup.jsp.saleac_code" text="SA"/>">
				 <input type="hidden" id="roundoff_group_codef" value="<spring:message code="accgroup.jsp.roun_code" text="ROD"/>">
				 <input type="hidden" id="debitor_group_codef" value="<spring:message code="accgroup.jsp.deb_code" text="SDE"/>">
				 <input type="hidden" id="dicount_codef" value="<spring:message code="accgroup.jsp.disc_code" text="DIS" />">
				 <input type="hidden" id="cash_codef" value="<spring:message code="accgroup.jsp.cash_code" text="CIH" />">
				 <input type="hidden" id="card_codef" value="<spring:message code="accgroup.jsp.card_code" text="CAB" />">
                <input type="hidden" id="service_charge_codef" value="<spring:message code="accgroup.jsp.service_charge" text="SC" />">


				 <input type="hidden"  id="duties_ledger_idf" value="0">
				 <input type="hidden"  id="round_ledger_idf" value="0">
				 <input type="hidden"  id="sales_ledger_idf" value="0">
				 <input type="hidden"  id="debitor_ledger_idf" value="0">
				 <input type="hidden"  id="discount_ledger_idf" value="0">
				 <input type="hidden"  id="debitor_cahs_ledger_idf" value="0">
				 <input type="hidden" id="card_ledger_idf" value="0">
				 <input type="hidden" id="service_charge_ledger_idf" value="0">


						<div class="col-md-12 col-sm-12"
							style="background-color: #ccc; color: #000;">
							<div class="col-md-6 col-sm-6" style="margin-top: 5px;">

							     <span class="enable-links" id='addCashSpan' style="">
								   <a id='anchorCashSpan' href="javascript:openCashModal()" class="btn-order-taking"
									style="text-align: center; width: 29%; padding: 8px 7px;"><span
									class="fa fa-usd"></span>&nbsp;<spring:message
									code="order.jsp.CASH" text="CASH" /> </a>
								</span>

								 <span class="enable-links" id='addCardSpan' style="">
								   <a id='anchorCardSpan'
									href="javascript:openCardModal()" class="btn-order-taking"
									style="text-align: center; width: 29%; padding: 8px 3px;"><span
									class="fa fa-credit-card"></span>&nbsp;<spring:message
									code="order.jsp.CARD" text="CARD" /></a>
								</span>

								 <span class="enable-links" id='addOnlineSpan' style="">
								   <a id='anchorOnlineSpan'
									href="javascript:openOnlineModal()" class="btn-order-taking"
									style="text-align: center; width: 29%; padding: 8px 7px;"><spring:message
									code="order.jsp.online" text="ONLINE" /> </a>
								</span>

								   <a href="javascript:printBillWithReason()"
									class="btn-order-taking"
									style="text-align: center; width: 46%; margin-top: 2px;"><span
									class="fa fa-print"></span>&nbsp;<spring:message
									code="order.jsp.PRINT" text="PRINT" /> </a>

									<span class="enable-links" id='addSaveSpan' style="">
									   <a id='anchorSaveSpan'
									   href="javascript:showDelOptModal()" class="btn-order-taking"
									   style="background: #F60; text-align: center; width: 46%; margin-top: 2px;"><i
									   class="fa fa-save"></i>&nbsp;<spring:message
									    code="order.jsp.SAVE" text="SAVE" /> </a>
									</span>

										<%-- <c:if test="${sessionScope.loggedinStore.deliveryBoyFlag!='Y' && currentTable!='0'}">
										<c:set var="widthVal" value="96%"></c:set>
										<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
									<a href="javascript:openCreditSaleModal()"
										class="btn-order-taking"
										style="text-align: center; width:96%; margin-top: 2px;">&nbsp;
										<c:if test="${sessionScope.loggedinStore.id !=87}">
											<spring:message code="order.jsp.CREDITSALE"
												text="CREDIT SALE " />
										</c:if> <c:if test="${sessionScope.loggedinStore.id ==87}">
											<spring:message code="order.jsp.STAFFFOOD" text="STAFF FOOD " />
										</c:if>
									</a>
								</c:if>
										</c:if> --%>


										<%--  <c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y' && currentTable=='0'}"> --%>
									<%-- 	<c:set var="widthVal" value="46%"></c:set> --%>

								<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
									<a href="javascript:openCreditSaleModal()"
										class="btn-order-taking"
										style="text-align: center; width:46%; margin-top: 2px;">
										<c:if test="${sessionScope.loggedinStore.id !=87}">
											<spring:message code="order.jsp.CREDITSALE"
												text="CREDIT SALE " />
										</c:if> <c:if test="${sessionScope.loggedinStore.id ==87}">
											<spring:message code="order.jsp.STAFFFOOD" text="STAFF FOOD " />
										</c:if>
									</a>
								</c:if>


										 <%-- </c:if>  --%>
								<%-- <c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
									<a href="javascript:openCreditSaleModal()"
										class="btn-order-taking"
										style="text-align: center; width:${widthVal}; margin-top: 2px;">&nbsp;
										<c:if test="${sessionScope.loggedinStore.id !=87}">
											<spring:message code="order.jsp.CREDITSALE"
												text="CREDIT SALE " />
										</c:if> <c:if test="${sessionScope.loggedinStore.id ==87}">
											<spring:message code="order.jsp.STAFFFOOD" text="STAFF FOOD " />
										</c:if>
									</a>
								</c:if> --%>
								<c:if test="${sessionScope.loggedinStore.creditSale!='Y'}">
									<%-- 	<c:set var="widthVal" value="96%"></c:set> --%>
										<c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y' && currentTable=='0'}">
									<a href="javascript:openAssignDelBoyModal()"
										class="btn-order-taking"
										style="text-align: center; width:auto; margin-top: 2px;">
											<spring:message code="order.jsp.bill.DELIVERYBOY"
												text="DELIVERY BOY" />
									</a>
								</c:if>
										</c:if>
										<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
									<%-- 	<c:set var="widthVal" value="46%"></c:set> --%>
										<c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y' && currentTable=='0'}">
									<a href="javascript:openAssignDelBoyModal()"
										class="btn-order-taking"
										style="text-align: center; width:46%; margin-top: 2px;padding: 10px 0px 10px 0px;">
											<spring:message code="order.jsp.bill.DELIVERYBOY"
												text="DELIVERY BOY" />
									</a>
								     </c:if>
										</c:if>

								<c:if
									test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
									<a href="javascript:printKotCheckList()"
										class="btn-order-taking"
										style="text-align: center; width: 46%; margin-top: 2px; padding: 6px 0px;">&nbsp;<spring:message
											code="order.jsp.KOT" text="KOT" />
									</a>
									<a href="javascript:openSplitPaymentCashModal()"
										class="btn-order-taking"
										style="text-align: center; width: 46%; margin-top: 2px; padding: 6px;"><spring:message
											code="order.jsp.SPLITPAY" text="SPLITPAY" /> </a>
								</c:if>
							</div>

							<div class="col-md-6 col-sm-6">
								<div class="order-summery">
									<c:if test="${!empty orders}">
										<c:if
											test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'Y') }">
											<c:if test="${orders.orderBill.discountPercentage==0.00}">
											<input type="hidden" id="hidendiscountpercentage" value="0.0">

												<div id="discPerContId" class="col-md-6 col-sm-3">
													<spring:message code="order.jsp.Discount" text="Disc" />
													in ${sessionScope.loggedinStore.currency}
												</div>
											</c:if>
											<c:if test="${orders.orderBill.discountPercentage!=0.00}">
												<div id="discPerContId" class="col-md-6 col-sm-3">
												<input type="hidden" id="hidendiscountpercentage" value="${orders.orderBill.discountPercentage}">
													<spring:message code="order.jsp.Discount" text="Disc" />
													${orders.orderBill.discountPercentage}
													<c:set var="custDiscPerc"
														value="${orders.orderBill.discountPercentage}"></c:set>
												</div>
											</c:if>
											<div id="discBtnContId" style="float: right; height: 20px;">
												<fmt:formatNumber type="number" groupingUsed="false"
													minFractionDigits="2" maxFractionDigits="2"
													value="${orders.orderBill.customerDiscount}" />
											</div>
										</c:if>
										<c:if
											test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'N') }">
											<div id="discPerContId" class="col-md-6 col-sm-3">
											<input type="hidden" id="hidendiscountpercentage" value="0.0">
												<spring:message code="order.jsp.Discount" text="Disc" />
											</div>
											<div id="discBtnContId"
												style="float: right; height: 20px; width: 30%">
												<input type="button" onclick="javascript:openAddDiscount()"
													class="btn btn-success btn btn-xs" style="width: 100%"
													value="<spring:message code="order.jsp.ADD" text="ADD"/>">
												<%-- <input type="text" id="discAmtCont" size="4" value="${totDisc}" style="text-align:right;line-height:1px;"> --%>
											</div>
										</c:if>
									</c:if>
									<c:if test="${empty orders}">
									    <input type="hidden" id="hidendiscountpercentage" value="0.0">
										<div id="discPerContId" class="col-md-6 col-sm-3">
											<spring:message code="order.jsp.Discount" text="Discount" />
										</div>
										<div id="discBtnContId"
											style="float: right; height: 20px; width: 30%">
											<input type="button" onclick="javascript:openAddDiscount()"
												class="btn btn-success btn btn-xs" style="width: 100%"
												value="<spring:message code="order.jsp.ADD" text="ADD"/>">
											<%-- <input type="text" id="discAmtCont" size="4" value="${totDisc}" style="text-align:right;line-height:1px;"> --%>
										</div>
									</c:if>
									<%-- <div id="discPerContId" class="col-md-6 col-sm-3">-Discount:</div>
                			<div id="discBtnContId" style="float:right;height: 20px;width: 30%">
                			<input type="button" onclick="javascript:openAddDiscount()" class="btn btn-success btn btn-xs" style="width: 100%" value="ADD">
                				<input type="text" id="discAmtCont" size="4" value="${totDisc}" style="text-align:right;line-height:1px;">
                			</div> --%>
									<br />
									<div class="col-md-4 col-sm-6">
										<spring:message code="order.jsp.SubTotal" text="SubTotal:" />
									</div>
									<div id="subtotalcontId"
										style="float: right; font-weight: bold;">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totRate}" />
									</div>
									
									<!--new added for show total item price in unpaid bill 28.9.2018 start  -->
									<div id="totalratecontId" style="display:none;" >
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totalItemRate1}" />
									</div>
									<!--new added for show total item price in unpaid bill 28.9.2018 end  -->
									
									<br />
									<%-- 	<c:out value="${orderTypeList.serviceChargeValue}"/> --%>
									<%-- <c:out value=" ${totRate * orderTypeList.serviceChargeValue/100}"></c:out> --%>

									<c:if test="${empty orders}">
									<c:if
										test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
									<div id="hiddenschrgId" style="display: none;">${orderTypeList.serviceChargeValue}</div>
									</c:if>
									<c:if
										test="${sessionScope.loggedinStore.serviceChargeFlag!='Y'}">
										<div id="hiddenschrgId" style="display: none;">0</div>
									</c:if>
									</c:if>
									<c:if test="${!empty orders}">
									<c:if
										test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
									<div id="hiddenschrgId" style="display: none;">${orders.orderBill.serviceChargeRate}</div>
									</c:if>
									<c:if
										test="${sessionScope.loggedinStore.serviceChargeFlag!='Y'}">
										<div id="hiddenschrgId" style="display: none;">0</div>
									</c:if>

									</c:if>





										<div id="hiddenschrgFlag" style="display: none;">${sessionScope.loggedinStore.serviceChargeFlag}</div>
										<c:if
										test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">

										<c:if test="${orderTypeList.serviceChargeValue!=0.0}">


											<div class="col-md-6 col-sm-6">
												${sessionScope.loggedinStore.serviceChargeText}
												  <c:if test="${empty orders}">
												      <c:if test="${orderTypeList.serviceChargeValue!=0.0}">
                			                              (${orderTypeList.serviceChargeValue}%)
                			                          </c:if>
                			                      </c:if>
                			                      <c:if test="${!empty orders}">
                			                       (${orders.orderBill.serviceChargeRate}%)

                			                      </c:if>

												:
											</div>


											<div id="schrgId" style="float: right; font-weight: bold;">
												<a href="#" id="servicechrgId" onclick="openAddServiceCharge();"><fmt:formatNumber type="number" groupingUsed="false"
													minFractionDigits="2" maxFractionDigits="2"
													value="${schrg}" /></a>
											</div>
											<br />
										</c:if>
									</c:if>



									<c:if
										test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
										<div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.vatTaxText}
											<c:if
												test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
												<c:if test="${sessionScope.loggedinStore.vatAmt!=0.0}">
                			    (${sessionScope.loggedinStore.vatAmt}%)
                			    </c:if>:
                			 </c:if>
										</div>
										<div id="vatcontId" style="float: right; font-weight: bold;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totVat}" />
										</div>
										<br />
									</c:if>
									<c:if
										test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
										<div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.serviceTaxText}
											<c:if
												test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
												<c:if
													test="${sessionScope.loggedinStore.serviceTaxAmt!=0.0}">
                			     (${sessionScope.loggedinStore.serviceTaxAmt}%)
                			    </c:if>:
                			  </c:if>
										</div>
										<div id="servicetaxcontId"
											style="float: right; font-weight: bold;"><fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totST}" /></div>
										<br />
									</c:if>
									<div class="col-md-6 col-sm-3">
										<strong><spring:message code="order.jsp.TOTAL"
												text="TOTAL" />(${sessionScope.loggedinStore.currency}):</strong>
									</div>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
										<div id="grandtotalcontId"
											style="float: right; font-weight: bold;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totPrice +0.5 - ((totPrice+0.5) % 1) }" />
										</div>
									</c:if>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
										<div id="grandtotalcontId"
											style="float: right; font-weight: bold;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totPrice}" />
										</div>
									</c:if>
									<br />
									<div class="col-md-6 col-sm-6">
										<strong><spring:message code="order.jsp.AMOUNTTOPAY"
												text="AMOUNT TO PAY" />:</strong>
									</div>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">

								<!-- New added 25.5.2018 for solve problem of showing paid amt of adv booked table start -->
										<div id="amttopaycontId"
											style="float: right; font-weight: bold; background: #fff;">
										      <%-- <fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${netPrice +0.5 - ((netPrice+0.5) % 1) }" />  --%>


											   <c:if test="${empty orders.orderitem}">
												<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${netPrice}"/>
												</c:if>
												<c:if test="${!empty orders.orderitem}">
												<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${netPrice +0.5 - ((netPrice+0.5) % 1) }" />
												</c:if>
										</div>
								<!-- New added 25.5.2018 for solve problem of showing paid amt of adv booked table end -->
									</c:if>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
										<c:choose>
											<c:when
												test="${fn:containsIgnoreCase(sessionScope.loggedinStore.doubleRoundOff, 'Y') }">
												<%-- <div id="amttopaycontId" style="float:right; font-weight:bold;background: #fff;"><fmt:formatNumber type="number" groupingUsed="false"  minFractionDigits="2"   maxFractionDigits="2" value="${netPrice +0.05 - ((netPrice+0.05) % .1) }"/></div> --%>
												<c:set var="netPrice">
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</c:set>
												<c:set var="netPrice">
													<dd:ddformatter place="1" number="${netPrice}"></dd:ddformatter>
												</c:set>
												<c:set var="netPrice">
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</c:set>
												<div id="amttopaycontId"
													style="float: right; font-weight: bold; background: #fff;">${netPrice}</div>
											</c:when>
											<c:otherwise>
												<div id="amttopaycontId"
													style="float: right; font-weight: bold; background: #fff;">
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</div>
											</c:otherwise>
										</c:choose>
									</c:if>
									<br />

								</div>
							</div>
						</div>
					</div>

    <input type="hidden" id="hidtotscharge" value="${schrg}">
    <input type="hidden" id="hidtotstax" value="${totST}">
    <input type="hidden" id="hidtotvattax" value="${totVat}">

              </div>
				<c:choose>
					<c:when
						test="${fn:containsIgnoreCase(sessionScope.loggedinStore.menuCollapsable, 'Y') }">
						<div class="col-md-5 col-sm-5">
							<%-- 						<c:if test="${sessionScope.loggedinStore.displayCurrentStockMenu =='N'}"> --%>
							<div class="col-md-12 col-sm-12">
								<div class="col-md-6 col-sm-6"
									style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
									&nbsp;
									<spring:message code="order.jsp.NAME" text="NAME" />
									&nbsp;&nbsp;<input type="text" id="itemCodeSearch"
										style="color: #222222;"
										placeholder="<spring:message code="order.jsp.pllItemName" text="Item name....."/>">
								</div>
								<%-- <div class="col-md-6 col-sm-6"
									style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
									&nbsp;
									<spring:message code="order.jsp.CODE" text="CODE" />
									&nbsp;&nbsp;<input type="text" id="itemSearchByCode"
										style="color: #222222;"
										placeholder="<spring:message code="order.jsp.pllItemCode" text="Item Code....."/>">
								</div> --%>
								<c:if test="${sessionScope.loggedinStore.isBarcode =='Y'}">
									<div class="col-md-6 col-sm-6"
										style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
										&nbsp;
										<spring:message code="order.jsp.code" text="CODE" />
										&nbsp;&nbsp;<input type="text" id="itemBarCodeSearch"
											style="color: #222222;width: 50%"
											placeholder="<spring:message code="order.jsp.pllBrCCd" text="Code..."/>">
										<button type="button" style="padding: 2px 5px 2px 5px;"
											onclick="javascript:addBarcodeItem(document.getElementById('itemBarCodeSearch').value)"
											class="btn btn-default">
											<span class="fa fa-plus"></span>
										</button>

									</div>
								</c:if>
							</div>
							<%-- 						</c:if> --%>
							<div style="height: 470px; width: 100%; overflow-y: auto;">
								<div id="menu_items_container"></div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-6 col-sm-6">
							<%-- 						<c:if test="${sessionScope.loggedinStore.displayCurrentStockMenu =='N'}"> --%>
							<div class="col-md-12 col-sm-12">
								<div class="col-md-6 col-sm-6"
									style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
									&nbsp;
									<spring:message code="order.jsp.NAME" text="NAME" />
									&nbsp;&nbsp;<input type="text" id="itemCodeSearch"
										style="color: #222222;"
										placeholder="<spring:message code="order.jsp.pllItemName" text="Item name....."/>">
								</div>
								<c:if test="${sessionScope.loggedinStore.isBarcode =='Y'}">
									<div class="col-md-6 col-sm-6"
										style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
										&nbsp;
										<spring:message code="order.jsp.code" text="CODE" />
										&nbsp;&nbsp;<input type="text" id="itemBarCodeSearch"
											style="color: #222222;width: 50%"
											placeholder="<spring:message code="order.jsp.pllBrCCd" text="Code..."/>">
										<button type="button" style="padding: 2px 5px 2px 5px;"
											onclick="javascript:addBarcodeItem(document.getElementById('itemBarCodeSearch').value)"
											class="btn btn-default">
											<span class="fa fa-plus"></span>
										</button>

									</div>
								</c:if>
							</div>
							<%-- 						</c:if> --%>
							<div style="height: 470px; width: 100%; overflow-y: auto;">
								<div id="menu_items_container"></div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when
						test="${fn:containsIgnoreCase(sessionScope.loggedinStore.menuCollapsable, 'Y') }">
						<div class="col-md-3 col-sm-3">
							<div class="menu-category"
								style="height: 100%; font-size: 12px; font-weight: bold;">
								<div style="overflow-y: auto; height: 470px;">
									<div id="accord" style="padding: 5px;">
										<div class="list-group panel"
											style="background: #404040; text-align: center; text-transform: uppercase;">
											<c:if test="${empty allmenu }">
												<spring:message code="order.jsp.NoMenufound"
													text="No Menu found!!!!" />
											</c:if>
											<c:if test="${!empty allmenu }">
												<c:forEach items="${allmenu.menucategory}" var="item"
													varStatus="itemStat">
													<%-- <a href="#${item.id}" class="list-group-item menucathead${itemStat.index}" data-toggle="collapse" data-parent="#accord">${item.menuCategoryName}</a>
            							<div class="collapse" id="${item.id}"> --%>
													<c:forEach items="${item.menucategory }" var="itemSub">
														<a
															href="javascript:clickonSubmenu(${itemSub.id}, ${itemStat.index})"
															style="display: inline; margin-bottom: 5px; margin-top: -1px; padding: 5px; position: relative; color: #fff; width: 47%; float: left; margin-right: 5px; height: 45px;"
															class="menucathead${itemStat.index}">${itemSub.menuCategoryName}</a>
													</c:forEach>
													<!-- </div> -->
												</c:forEach>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-2 col-sm-2">
							<div class="menu-category" style="height: 100%;">
								<div style="overflow-y: auto; height: 470px;">
									<div id="accord" style="padding: 5px;">
										<div class="list-group panel"
											style="background: #404040; text-align: center; text-transform: uppercase;">
											<c:if test="${empty allmenu }">
												<spring:message code="order.jsp.NoMenufound"
													text="No Menu found!!!!" />
											</c:if>
											<c:if test="${!empty allmenu }">
												<c:forEach items="${allmenu.menucategory}" var="item"
													varStatus="itemStat">
													<a href="#${item.id}"
														class="list-group-item menucathead${itemStat.index}"
														data-toggle="collapse" data-parent="#accord">${item.menuCategoryName}</a>
													<div class="collapse" id="${item.id}">
														<c:forEach items="${item.menucategory }" var="itemSub">
															<a
																href="javascript:clickonSubmenu(${itemSub.id}, ${itemStat.index})"
																class="list-group-item item_sub_child">${itemSub.menuCategoryName}</a>
														</c:forEach>
													</div>
												</c:forEach>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>


			</div>

			<!-- modal start -->
			<div class="modal fade" data-backdrop="static" id="delOptModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.DeliveryOption"
									text="Delivery Option" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="radio" id="deliveryOptionDine"
									name="deliveryOption" value="dineIn">&nbsp;&nbsp;
								<spring:message code="order.jsp.DineIn" text="Dine In" />
								&nbsp;&nbsp; <input type="radio" id="deliveryOptionParcel"
									name="deliveryOption" value="parcel">&nbsp;&nbsp;
								<spring:message code="order.jsp.Parcel" text="Parcel" />
								<!-- for saravanaa -->
								<div style="display: none;">
									<input type="radio" id="deliveryOptionHomedel"
										name="deliveryOption" value="homeDel">&nbsp;&nbsp;
									<spring:message code="order.jsp.HomeDelivery"
										text="Home Delivery" />
								</div>
								<!-- end for saravanaa -->
								<div style="display: none;">
									<input type="radio" id="deliveryOptionswiggy"
										name="deliveryOption" value="swiggy">&nbsp;&nbsp;
									<spring:message code="order.jsp.Swiggy" text="Swiggy" />
								</div>
								<div style="display: none;">
									<input type="radio" id="deliveryOptionZomato"
										name="deliveryOption" value="zomato">&nbsp;&nbsp;
									<spring:message code="order.jsp.Zomato" text="Zomato" />
								</div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:createOrder()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.DONE" text="DONE" />
							</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" data-backdrop="static" id="ParceldelOptModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.DeliveryOption"
									text="Delivery Option" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="radio" id="PdeliveryOptionDine"
									name="deliveryOptionParcel" value="dineIn">&nbsp;&nbsp;
								<spring:message code="order.jsp.DineIn" text="Dine In" />
								&nbsp;&nbsp; <input type="radio" id="PdeliveryOptionParcel"
									name="deliveryOptionParcel" value="parcel">&nbsp;&nbsp;
								<spring:message code="order.jsp.Parcel" text="Parcel" />

							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:showCustDetailsModal()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.DONE" text="DONE" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="orderModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.SUCCESS" text="SUCCESS" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="text-align: left; font-size: 20px;">
								<spring:message code="table.jsp.TABLENO" text="TABLE NO:" />
								<span id="modTabCont">00</span>&nbsp;&nbsp;
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO:" />
								<span id="modOrderCont" class="hide">00</span>
								<span id="modOrderSuccessStoreBasedOrderCont">00</span> <br></br>
								<table>
									<tr>
										<td><spring:message code="order.jsp.ORDERAMOUNT"
												text="ORDER AMOUNT" />&nbsp;&nbsp;</td>
										<td>:</td>
										<td align="right">&nbsp;&nbsp;<span id="modAmtCont">0.00</span></td>
										<td>&nbsp;&nbsp;${sessionScope.loggedinStore.currency}</td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.ITEMDISCOUNT"
												text="ITEM DISCOUNT" />&nbsp;&nbsp;</td>
										<td>:</td>
										<td align="right">&nbsp;&nbsp;<span id="modDiscCont">0.00</span></td>
										<td>&nbsp;&nbsp;${sessionScope.loggedinStore.currency}</td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.TOTALAMT"
												text="TOTAL AMT" />&nbsp;&nbsp;</td>
										<td>:</td>
										<td>&nbsp;&nbsp;<span id="modtotAmtCont">0.00</span></td>
										<td>&nbsp;&nbsp;${sessionScope.loggedinStore.currency}</td>
									</tr>

								</table>
								<br>
								<spring:message code="order.jsp.TaxeschargeExtra"
									text="(Taxes charge Extra)" />
							</div>
							<br>
							<div id="instantPaycontId" align="center"
								style="text-align: left; font-size: 20px;"></div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<div id="parcelInstantPrintBillContId" style="float: left;"></div>
							<button type="button" onclick="javascript:orderSuccessOK()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="cashModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO:" />
								<span id="cashmodOrderCont" class="hide">00</span> 
								<span id="cashmodStoreBasedOrderCont" >00</span> <span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO:" /><span
									id="cashmodTabCont">00</span></span>

							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<div class="hide" style="padding: 5px;">
									<spring:message code="order.jsp.TOTALAMOUNT"
										text="TOTAL AMOUNT" />
									:&nbsp;&nbsp;&nbsp;<span id="cashtotamtcontId">0.00</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.AMOUNTTOPAY"
										text="AMOUNT TO PAY" />
									:&nbsp;&nbsp;&nbsp;<span id="cashamttopaycontId">0.00</span>
								</div>
								<div id="cashpaidamtdivId" class="hide" style="padding: 5px;">
									<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
									:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
										id="cashpaidamtcontId">0.00</span>
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.TENDERAMOUNT"
										text="TENDER AMOUNT" />
									:&nbsp;<input type="text"
										onkeyup="javascript:getChangeAmt(this.value)" value=""
										id="cashtenderAmt" style="text-align: center; color: #222222"
										size="4" />
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.CHANGEAMOUNT"
										text="CHANGE AMOUNT" />
									:&nbsp;<span id="cashchangeamtcontId">0.00</span>
								</div>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="paycashalertMsg"></div>
							</div>

							<div align="center" style="font-size: 20px;">
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
									<div style="padding: 5px;">
										<input type="checkbox" id="chkprintBillCash"
											style="transform: scale(2.5); -webkit-transform: scale(2.5);"  />&nbsp;&nbsp;&nbsp;
										<spring:message code="order.jsp.PRINT" text="PRINT" />
										PAID BILL
									</div>
									<br />
								</c:if>
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">

									<table class="ui-bar-a" id="n_keypad"
										style="-khtml-user-select: none;">

										  <c:choose>
                                                   <c:when test="${sessionScope.loggedinStore.currency == 'AED' || sessionScope.loggedinStore.currency == 'aed' || sessionScope.loggedinStore.currency == 'DHS' || sessionScope.loggedinStore.currency == 'dhs'}">

										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero200">
												     <img src="${pageContext.request.contextPath}/assets/images/base/payment/200dh.png" />
												 </a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero7">7</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero8">8</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero9">9</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-danger btn-lg" id="del">x</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero100">
												     <img src="${pageContext.request.contextPath}/assets/images/base/payment/100dh.png" />

                                                </a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero4">4</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero5">5</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero6">6</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-warning btn-lg" id="clear">c</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero50">
												      <img src="${pageContext.request.contextPath}/assets/images/base/payment/50dm.png" />

													</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero1">1</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero2">2</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero3">3</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numerodot">&nbsp;.</a></td>
										</tr>
										<tr>
										    <td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero20">
												  <img src="${pageContext.request.contextPath}/assets/images/base/payment/20dh.png" />
	                                               </a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero10">
												     <img src="${pageContext.request.contextPath}/assets/images/base/payment/10_dh.png" />

													</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numerorm5">
												        <img src="${pageContext.request.contextPath}/assets/images/base/payment/5dh.png" />

													</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="zero">0</a></td>
											<td><a data-role="button"
												style="border: 2px solid #404040;height: 50px; width: 92px; text-align: center;"
												data-theme="done" class="btn btn-success btn-lg; padding: 0 0;" id="done"><spring:message code="order.jsp.EXACTAMTFORDHS" text="EXT AMT" /></a></td>
										</tr>

                                                  </c:when>
                                                     <c:otherwise>

										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero100">
												     <img src="${pageContext.request.contextPath}/assets/images/base/payment/rm100.png" />

                                                </a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero7">7</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero8">8</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero9">9</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-danger btn-lg" id="del">x</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero50">
												      <img src="${pageContext.request.contextPath}/assets/images/base/payment/rm50.png" />

													</a>
													</td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero4">4</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero5">5</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero6">6</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-warning btn-lg" id="clear">c</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero20">
												  <img src="${pageContext.request.contextPath}/assets/images/base/payment/rm20.png" />

													</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero1">1</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero2">2</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero3">3</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numerodot">&nbsp;.</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numero10">
												     <img src="${pageContext.request.contextPath}/assets/images/base/payment/rm10.png" />

													</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040; padding: 0 0;"
												class="btn btn-primary btn-lg" id="numerorm5">
												        <img src="${pageContext.request.contextPath}/assets/images/base/payment/rm5.png" />

													</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="zero">0</a></td>
											<td colspan="4"><a data-role="button"
												style="border: 2px solid #404040; width: 184px;"
												data-theme="done" class="btn btn-success btn-lg" id="done"><spring:message
														code="order.jsp.EXACTAMT" text="EXACT AMT" /></a></td>
										</tr>
												 </c:otherwise>
                                                </c:choose>

										</table>
								</c:if>
							</div>

						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="paybycashbtn"
								onclick="javascript:payByCash(document.getElementById('cashtenderAmt').value)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.PAY" text="PAY" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="cashSplitPaymentModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
								: <span id="cashmodSplitPaymentOrderCont">00</span> <span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO" />: <span
									id="cashmodSplitPaymentTabCont">00</span></span>

							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<div id="cashmodSplitPaymentBody"></div>

								<div id="cashmodSplitPaymentBodyAmountDetails"></div>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="splitpaycashalertMsg"></div>
							</div>

						</div>
						<div class="alert alert-danger">
							<strong>*</strong>
							<spring:message
								code="order.jsp.Pleaseclosethewindowafterpayingallbillamountotherwiseyourdatamaybelost"
								text="Please close the window after paying all bill amount otherwise your data may be lost." />
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="splitPaymentBtn"
								onclick="javascript:paySplitAmtByCash(document.getElementById('splitpaymentamttopaycontId').value)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success disabled">
								<spring:message code="order.jsp.PAY" text="PAY" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="cardModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
								<span id="cardmodStoreBasedOrderCont">00</span> 
								<span id="cardmodOrderCont" class="hide">00</span><span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO :" /><span
									id="cardmodTabCont">00</span></span>

							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<div class="hide" style="padding: 5px;">
									<spring:message code="order.jsp.TOTALAMOUNT"
										text="TOTAL AMOUNT" />
									&nbsp;&nbsp;&nbsp;<span id="cardtotamtcontId">0.00</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.AMOUNTTOPAY"
										text="AMOUNT TO PAY" />
									:&nbsp;&nbsp;&nbsp;<span id="cardamttopaycontId">0.00</span>
								</div>
								<div id="cardpaidamtdivId" class="hide" style="padding: 5px;">
									<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
									:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
										id="cardpaidamtcontId">0.00</span>
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.TENDERAMOUNT"
										text="TENDER AMOUNT" />
									   :&nbsp;<input type="text" id="cardtenderAmt"
										style="text-align: center; color: #222222" size="4" />
								</div>
								<c:if
									test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
									<div>
										<spring:message code="order.jsp.CARDTYPE" text="CARD TYPE" />
										: <input type="radio" id="cardTypeVisa" name="cardType"
											value="Visa" onclick="javascript:checkCardType(this.value)">
										<img
											src="${pageContext.request.contextPath}/assets/images/base/payment/visa_card.png" />&nbsp;&nbsp;
										<input type="radio" id="cardTypeMaster" name="cardType"
											value="Master" onclick="javascript:checkCardType(this.value)">
										<img
											src="${pageContext.request.contextPath}/assets/images/base/payment/master_card.png" />&nbsp;&nbsp;
										<input type="radio" id="cardTypeOther" name="cardType"
											value="Other" onclick="javascript:checkCardType(this.value)">
										<img
											src="${pageContext.request.contextPath}/assets/images/base/payment/other_card.png" />
									</div>
								</c:if>
								<div style="padding: 5px; display: none;" id="cardTypeNameDiv">
									<spring:message code="order.jsp.CARDTYPENAME"
										text="CARD TYPE NAME" />
									:&nbsp;&nbsp;&nbsp; <input type="text" id="cardTypeName"
										value="card" style="text-align: center; color: #222222"
										size="12" />
								</div>


								 <c:if
									test="${sessionScope.loggedinStore.id==157}">

									<div style="padding: 5px;">
									<spring:message code="order.jsp.TIPS"
										text="TIPS AMOUNT" />
									:&nbsp;<input type="text" id="tipsamt"
										style="text-align: center; color: #222222" size="4"
										maxlength="4" />
								   </div>
                                </c:if>

								<c:if test="${sessionScope.loggedinStore.id==157 || sessionScope.loggedinStore.id==161 || sessionScope.loggedinStore.id==128 || sessionScope.loggedinStore.id==29}">

									<div style="padding: 5px;">
									<spring:message code="order.jsp.CARDLAST4DIGIT"
										text="CARD LAST 4 DIGIT" />
									:&nbsp;<input type="text" id="cardlastfourDigit"
										style="text-align: center; color: #222222" size="4"
										maxlength="4" />
								   </div>
                              </c:if>






								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="paycardalertMsg"></div>
							</div>

							<div align="center" style="font-size: 20px;">
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
									<div style="padding: 5px;">
										<input type="checkbox" id="chkprintBillCard"
											style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;
										<spring:message code="order.jsp.PRINT" text="PRINT" />
										<spring:message code="order.jsp.PAIDBILL" text="PAID BILL" />
									</div>
									<br />
								</c:if>
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
									<table class="ui-bar-a" id="n_keypad_cr"
										style="display: none;-khtml-user-select: none;">
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero7_cr">7</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero8_cr">8</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero9_cr">9</a></td>

										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero4_cr">4</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero5_cr">5</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero6_cr">6</a></td>

										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero1_cr">1</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero2_cr">2</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero3_cr">3</a></td>
											<!-- <td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numerodot_cr">&nbsp;.</a></td> -->
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="zero_cr">0</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-danger btn-lg" id="del_cr">x</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-warning btn-lg" id="clear_cr">c</a></td>
											<!-- <td colspan="4"><a data-role="button" style="border: 2px solid #404040;width: 184px;" data-theme="done" class="btn btn-success btn-lg" id="done_cr">DONE</a></td> -->
										</tr>
									</table>
								</c:if>
							</div>
							<div align="center" style="font-size: 20px;">
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
									<table class="ui-bar-a" id="n_keypad_cr1"
										style="display: none; -khtml-user-select: none;">
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero7_cr1">7</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero8_cr1">8</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero9_cr1">9</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-danger btn-lg" id="del_cr1">x</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero4_cr1">4</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero5_cr1">5</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero6_cr1">6</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-warning btn-lg" id="clear_cr1">c</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero1_cr1">1</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero2_cr1">2</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero3_cr1">3</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numerodot_cr1">&nbsp;.</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="zero_cr1">0</a></td>
											<td colspan="4"><a data-role="button"
												style="border: 2px solid #404040; width: 184px;"
												data-theme="done" class="btn btn-success btn-lg"
												id="done_cr1"><spring:message code="order.jsp.DONE"
														text="DONE" /></a></td>
										</tr>
									</table>
								</c:if>
							</div>

							<div align="center" style="font-size: 20px;">
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
									<table class="ui-bar-a" id="n_keypad_cr2"
										style="display: none; -khtml-user-select: none;">
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero7_cr2">7</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero8_cr2">8</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero9_cr2">9</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-danger btn-lg" id="del_cr2">x</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero4_cr2">4</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero5_cr2">5</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero6_cr2">6</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-warning btn-lg" id="clear_cr2">c</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero1_cr2">1</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero2_cr2">2</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero3_cr2">3</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numerodot_cr2">&nbsp;.</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="zero_cr2">0</a></td>
											<td colspan="4"><a data-role="button"
												style="border: 2px solid #404040; width: 184px;"
												data-theme="done" class="btn btn-success btn-lg"
												id="done_cr2"><spring:message code="order.jsp.DONE"
														text="DONE" /></a></td>
										</tr>
									</table>
								</c:if>
							</div>


						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="paybycardbtn"
								onclick="javascript:payByCard(document.getElementById('cardtenderAmt').value)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.PAY" text="PAY" />
							</button>

							
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="onlineModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
								: <span id="onlinemodOrderCont" class="hide">00</span> 
								<span id="onlinemodStoreBasedOrderCont">00</span><span class="hide"
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO :" /> <span
									id="onlinemodTabCont">00</span></span>

							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<div style="padding: 5px;">
									<spring:message code="order.jsp.paymentmode"
										text="PAYMENT MODE" />
									:&nbsp;&nbsp;&nbsp;<span id="onlineselpaymenttype">paytm</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.TOTALAMOUNT"
										text="TOTAL AMOUNT" />
									:&nbsp;&nbsp;&nbsp;<span id="onlinetotamtcontId">0.00</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
									:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
										id="onlinepaidamtcontId">0.00</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.AMOUNTTOPAY"
										text="AMOUNT TO PAY" />
									:&nbsp;&nbsp;&nbsp;<span id="onlineamttopaycontId">0.00</span>
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.TENDERAMOUNT"
										text="TENDER AMOUNT" />
									&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text"
										id="onlinetenderAmt"
										style="text-align: center; color: #222222" size="4" />
								</div>
                                  <c:if test="${sessionScope.loggedinStore.id==161}">
                                 <div style="padding: 3px;"><spring:message code="admin.storecustmgnt.jsp.crpayremarkcap" text="REMARK" /> :&nbsp;
                                 <input  type="text" id="onlinepayremark" name="Onlinepayremark" value="" style="color:black;"/>
                                 </div>
                                </c:if> 
                                 
                                 
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="payonlinealertMsg"></div>
								<input type="hidden" id="selpaymentmode" value="">
							</div>

							<div align="center" style="font-size: 20px;">
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
									<div style="padding: 5px;">
										<input type="checkbox" id="chkprintBillonline"
											style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;PRINT
										PAID BILL
									</div>
									<br />
								</c:if>

							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" id="paybyonlinebtn"
								onclick="javascript:payByOnline(document.getElementById('onlinetenderAmt').value)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">PAY</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="paymodeselectionModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.paymentmode" text="PAYMENT MODE" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;"
								id="paymodeselectiondiv"></div>
							<div style="text-align: center; font-size: 20px;"
								id="paymodeselectiontext"></div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" onclick="getpaymod()">OK</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="notavailableonlinepaymentModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="order.jsp.noonlinepaymentmode"
									text="No online payment mode available." />
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" data-backdrop="static" id="directOrderModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="order.jsp.selecttablefirstandtakeorder"
									text="Please select table first and take order!" />
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="location.href='${pageContext.request.contextPath}/table/viewtable.htm'"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="specialnoteModal"
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
								<spring:message code="order.jsp.SpecialNote" text="Special Note" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="max-height: 300px; overflow-y: auto;">
								<div style="font-size: 20px;" id="spnoteitemlistContId"></div>
							</div>
							<div style="font-size: 20px;" id="specialAlert"></div>
						</div>

						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelSpecialNote()"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:savespecialNote()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.SUBMIT" text="SUBMIT" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="alertselectItemModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="order.jsp.Pleaseaddanyitems"
									text="Please add any items!" />
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="alertsaveOrderModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="order.jsp.Pleasesavetheorderfirst"
									text="Please save the order first" />
								!
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="confirmdeleteorderitemModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Confirmation"
									text="Confirmation" />
								!
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="order.jsp.Areyousure" text="Are you sure" />
								?
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold; width: 25%;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javacsript:deleteorderItemRow()"
								style="background: #72BB4F; font-weight: bold; width: 25%;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="parcelpayOptModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Doyouwanttopay"
									text="Do you want to pay" />
								?
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="radio" id="parcelpayOptionCash" checked="checked"
									name="parcelpayOption" value="cash">&nbsp;&nbsp;
								<spring:message code="order.jsp.Cash" text="Cash" />
								&nbsp;&nbsp; <input type="radio" id="parcelpayOptionCard"
									name="parcelpayOption" value="card">&nbsp;&nbsp;
								<spring:message code="order.jsp.Card" text="Card" />

							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:parcelPayment()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.PAY" text="PAY" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="discountModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.AddDiscount" text="Add Discount" />
								<span style="margin-left: 50%;"><input type="checkbox"
									id="ncbill"
									style="transform: scale(1.7); -webkit-transform: scale(1.7);">
									Nonchargeable</span>
							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div>
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
								<span id="discmodOrderCont" class="hide">00</span> 
								<span id="discmodStoreBaseOrderCont">00</span><span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO :" /><span
									id="discmodTabCont">00</span></span>
							</div>
							<div align="center" style="font-size: 20px;">
								<input type="hidden" id="discmodstorediscFlagcontId"
									value="${sessionScope.loggedinStore.discountPercentage}">
								<input type="hidden" id="discmodstorecurrencycontId"
									value="${sessionScope.loggedinStore.currency}">
								<table>
									<tr>
										<td><spring:message code="order.jsp.TOTALAMOUNT"
												text="TOTAL AMOUNT" /></td>
										<td>:</td>
										<td id="discmodtotamtcontId"></td>
									</tr>
									<tr class="hide" id="totdiscountableAmtrowId">
										<td><spring:message code="order.jsp.DISCOUNTABLEAMOUNT"
												text="DISCOUNTABLE AMOUNT" /></td>
										<td>:</td>
										<td id="discmoddiscountableamtcontId"></td>
									</tr>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'Y') }">
										<tr id="trdiscperc">
											<td><spring:message code="order.jsp.DISCPERCENTAGE"
													text="DISC PERCENTAGE" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscPer" value="" onkeydown="javascript:numcheck(event)"
												onkeyup="javascript:calculateDiscAmt(this.value)" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr id="trdiscamt">
											<td><spring:message code="order.jsp.DISCAMOUNT"
													text="DISC  AMOUNT" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscAmt"
												disabled="disabled" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>
									</c:if>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'N') }">
										<tr id="trdiscperc">
											<td><spring:message code="order.jsp.DISCPERCENTAGE"
													text="DISC PERCENTAGE" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscPer"
												disabled="disabled" value="0.00" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr id="trdiscamt">
											<td><spring:message code="order.jsp.DISCAMOUNT"
													text="DISC  AMOUNT" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscAmt" size="4" onkeydown="javascript:numcheck(event)" onkeyup="javascript:calculateDiscPercentage(this.value)"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>
									</c:if>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'M') }">
										<tr id="trdiscperc">
											<td><spring:message code="order.jsp.DISCPERCENTAGE"
													text="DISC PERCENTAGE" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscPer" value="" onkeydown="javascript:numcheck(event)"
												onkeyup="javascript:calculateDiscAmt(this.value)" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr id="trdiscamt">
											<td><spring:message code="order.jsp.DISCAMOUNT"
													text="DISC  AMOUNT" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscAmt" size="4" onkeydown="javascript:numcheck(event)" onkeyup="javascript:calculateDiscPercentage(this.value)"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>
									</c:if>
									<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.isProvideReason, 'Y') }">
									<tr>
										<td><spring:message code="order.jsp.reason" text="REASON" /></td>
										<td>:</td>
										<td><input type="text" id="discreason"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									</c:if>
								</table>
								<!-- <div style="padding: 5px;">TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="discmodtotamtcontId">0.00</span></div>
                                           		<div style="padding: 3px;">DISC PERCENTAGE :&nbsp;<input type="text"   value="" id="discModdiscPer" style="text-align:center; color: #222222" size="4"/> % </div>
                                           		<div style="padding: 5px;">DISC AMOUNT :&nbsp;<input type="text"   value="" id="discModdiscAmt" style="text-align:center; color: #222222" size="4"/></div> -->
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="discAddalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:AddDiscount()"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.ADD" text="ADD" />
							</button>
						</div>
					</div>
				</div>
			</div>
         <!-- Add Service Charge Modal Start -->

            <div class="modal fade" data-backdrop="static" id="serviceChargeModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Update" text="Update" /> ${sessionScope.loggedinStore.serviceChargeText}
							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div>
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
								<span id="servicechargemodOrderCont" class="hide">00</span>
								<span id="servicechargemodStoreBaseOrderCont">00</span> <span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO :" /><span
									id="servicechargemodTabCont">00</span></span>
							</div>
							<div align="center" style="font-size: 20px;">
								<%-- <input type="hidden" id="servicechargemodstorediscFlagcontId"
									value="${sessionScope.loggedinStore.discountPercentage}"> --%>
								<input type="hidden" id="servicechargemodstorecurrencycontId"
									value="${sessionScope.loggedinStore.currency}">
								<table>
									<tr>
										<td><spring:message code="order.jsp.TOTALAMOUNT"
												text="TOTAL AMOUNT" /></td>
										<td>:</td>
										<td id="servicechargemodtotamtcontId"></td>
									</tr>

									<tr id="trservicechargeperc">
											<td>${sessionScope.loggedinStore.serviceChargeText}(%)</td>
											<td>:</td>
											<td><input type="text" id="servicechargeModPer" value="" onkeydown="javascript:numcheck(event)"
												onkeyup="javascript:calculateservicechargeAmt(this.value)" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr id="trservicechargeamt">
											<td>${sessionScope.loggedinStore.serviceChargeText}<spring:message code="order.jsp.AMOUNT"
													text="Amount" /></td>
											<td>:</td>
											<td><input type="text" disabled id="servicechargeModAmt" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>


								</table>

								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="servicechargeAddalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:AddServiceCharge()"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.ADD" text="ADD" />
							</button>
						</div>
					</div>
				</div>
			</div>


             <div class="modal fade" data-backdrop="static"
				id="alertupdateServiceChargeModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">${sessionScope.loggedinStore.serviceChargeText}&nbsp;
								<spring:message code="order.jsp.updateservicechargealert"
									text="Is Not Changeable After Adding Discount" />

							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>









     <!-- Update Service Charge Modals End -->



			<div class="modal fade" data-backdrop="static"
				id="alerteditOrderquantityModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="hidden" id="hiddmanualeditItemId" value="">
								<spring:message code="order.jsp.Pleaseenteravalidnumber"
									text="Please enter a valid number" />
								!
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="javascript:setOrderItemManualQty()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="parcelCustDetailsModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto; width: 50%;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.CustomerDetails"
									text="Customer Details" />
								<span style="float: right;"> Order Type : <span
									id="modOrderType">N/A</span>
								</span>
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff; width: 100%; padding: 5px;">
							<ul class="nav st-nav-tabs nav-tabs nav-justified"
								id="customerdetails" style="background: #404040; color: #fff;">
								<li class="active"><a data-toggle="tab" href="#home">Home</a></li>
								<li class="disabled"><a data-toggle="tab"
									href="#transactionsummarydiv"
									onclick="javascript:gotransactionsummary()">Transaction
										Summary</a></li>
								<li class="disabled"><a data-toggle="tab"
									href="#transactionhistorydiv"
									onclick="javascript:gotransactionhistory()">Transaction
										History</a></li>
								<li class="disabled"><a data-toggle="tab"
									href="#paymentsummarydiv"
									onclick="javascript:gopaymentsummary()">Payment Summary</a></li>
							</ul>
							<div class="tab-content"
								style="background: #404040; border-top: 10px solid #404040;">
								<div id="home" class="tab-pane fade in active"
									style="background: #404040;">
									<!-- <div class="modal-category" style="background: #404040;color: #fff;"> -->
									<div style="text-align: left; font-size: 18px;">
										<table align="center">

											<input type="hidden" id="modparcelcustIdhidden" value="">
											<c:if test="${!empty orders}">
												<%-- <tr>
													<td><spring:message code="order.jsp.PHONENO"
															text="PHONE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustPhone"
														value="${orders.customerContact}" autocomplete="off"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														autofocus="autofocus" readonly /></td>
												</tr> --%>
												<tr>
													<td><spring:message code="order.jsp.PHONENO"
															text="PHONE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustPhone"
														maxlength="10" value="${orders.customerContact}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														autofocus="autofocus"
														onkeypress='return isNumberKey(event)' /></td>
													<%-- 	<td><button type="button"
															onclick="javascript:searchCustomer()"
															class="btn btn-success"
															style="margin-bottom: 2px; background: #72BB4F; font-weight: bold;">
															<spring:message code="order.jsp.SEARCH" text="SEARCH" />
														</button></td> --%>
													<%--
														<td style="display: none;"><button type="button"
															onclick="javascript:editCustomerNameContact()"
															class="btn btn-success"
															style="margin-bottom: 2px; background: #72BB4F; font-weight: bold;">
															<spring:message code="order.jsp.EDITNAMECONTACT" text="EDIT CUSTOMER NAME & CONTACT" />
														</button></td>  --%>

												</tr>
												<tr>
													<td><spring:message code="order.jsp.CUSTOMERNAME"
															text="CUSTOMER NAME" /></td>
													<td>:</td>
													<%-- <td><input type="text" id="modparcelcustName"
														value="${orders.customerName}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														onkeypress='return lettersOnly(event)' /></td> --%>
														<td><input type="text" id="modparcelcustName"
														value="${orders.customerName}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"/></td>

												</tr>
												<tr>
													<td><spring:message code="order.jsp.location"
															text="LOCATION" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustlocation"
														value="${orders.location}"
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
													<%-- <fmt:formatDate pattern="yyyy-MM-dd" value="${orders.dob}"/> --%>
												</tr>

												<tr>
													<td><spring:message code="order.jsp.custAnniversary"
															text="ANNIVERSARY DATE" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustanniversary"
														size="10"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														value=""></td>
												</tr>
											</c:if>
											<c:if test="${empty orders}">
												<tr>
													<td><spring:message code="order.jsp.PHONENO"
															text="PHONE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustPhone"
														maxlength="10"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														autofocus="autofocus"
														onkeypress='return isNumberKey(event)' /></td>
													<%-- <td><button type="button"
															onclick="javascript:searchCustomer()"
															class="btn btn-success"
															style="margin-bottom: 2px; background: #72BB4F; font-weight: bold;">
															<spring:message code="order.jsp.SEARCH" text="SEARCH" />
														</button></td> --%>


												</tr>
												<tr>
													<td><spring:message code="order.jsp.CUSTOMERNAME"
															text="CUSTOMER NAME" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustName" value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														 /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.location"
															text="LOCATION" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcustlocation"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.ADDRESS"
															text="ADDRESS" /></td>
													<td>:</td>
													<td><textarea id="modparcelcustAddress" rows="2"
															style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea>
													</td>
												</tr>
												<tr>
													<td><spring:message
															code="order.jsp.DELIVERYPERSONNAME"
															text="DELIVERY PERSON NAME" /></td>
													<td>:</td>
													<td><input type="text"
														id="modparceldeliveryPersonName" value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.houseno"
															text="HOUSE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcusthouseno"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.streetno"
															text="STREET NO" /></td>
													<td>:</td>
													<td><input type="text" id="modparcelcuststreet"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td>STATE</td>
													<td>:</td>
													<td><input type="text" id="modparcelcuststate"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>

												<tr>
													<td>Cust. VAT/CST:</td>
													<td>:</td>
													<td><input type="text" id="modparcelcustvatorcst"
														value=""
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
												</tr>
											</c:if>
										</table>

										<div
											style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
											id="parcelCustModalalertMsg"></div>
									</div>
								</div>
								<!-- </div> -->
								<div id="transactionsummarydiv" class="tab-pane fade"
									style="background: #404040; border-top: 1px solid #404040; color: #fff;">
									<div style="text-align: left; font-size: 18px;">
										<table align="center">
											<tr>
												<td><spring:message code="order.jsp.TOTALTRANSACTION"
														text="TOTAL AMOUNT SPENT" /></td>
												<td width="5%">:</td>
												<td id="modtotaltransaction"></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.LASTVISITDATE"
														text="LAST VISIT DATE" /></td>
												<td width="5%">:</td>
												<td id="modlastvisitdate"></td>
											</tr>

										</table>
										<br> <br>
										<div
											style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
											Most Purchased Items By Customer --</div>
										<br> <br>
										<table align="center"
											style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed; max-height: 100px; overflow-y: auto;">
											<thead>
												<tr style="border-bottom: 1px dashed;">
													<th width="5%;" style="padding-left: 6%; font-size: 20px;"><spring:message
															code="reprintcash.jsp.invno" text="SNo" /></th>
													<th width="20%;"
														style="padding-left: 25%; font-size: 20px;"><spring:message
															code="item.jsp.name" text="Item Name" /></th>
													<th width="6%;" style="padding-left: 7%; font-size: 20px;"><spring:message
															code="purinvdet.jsp.expdt" text="Qty" /></th>
											</thead>
											<tbody style="color: #000000; padding: 1px;"
												id="modmostpurchaseitems">
											</tbody>
										</table>
									</div>
								</div>
								<div id="transactionhistorydiv" class="tab-pane fade"
									style="background: #404040; border-top: 1px solid #404040; color: #fff;">
									<div style="text-align: left; font-size: 18px;">
										<br> <br>
										<div
											style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
											Previous Transaction History Of Customer --</div>
										<br> <br>
										<table align="center"
											style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed; max-height: 100px; overflow-y: auto;">
											<thead>
												<tr style="border-bottom: 1px dashed;">
													<%-- <th width="5%;"><spring:message code="reprintcash.jsp.invno" text="SNo" /></th> --%>
													<th
														style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
															code="reprintcash.jsp.invno" text="Order No" /></th>
													<th
														style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
															code="purinvdet.jsp.orderdate" text="Order Date" /></th>
													<th
														style="padding-left: 20px; padding-right: 20px; font-size: 20px;"><spring:message
															code="item.jsp.name" text="Amount" /></th>
													<!-- width="6%;" width="15%;" width="6%;" width="6%;"-->
													<th
														style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
															code="purinvdet.jsp.paidamt" text="Paid Amt" /></th>
													<th
														style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
															code="purinvdet.jsp.amttopay" text="Amt to Pay" /></th>
											</thead>
											<tbody style="color: #000000; padding: 1px;"
												id="modcusttransactionsummary">
											</tbody>
										</table>


									</div>
								</div>
								<div id="paymentsummarydiv" class="tab-pane fade"
									style="background: #404040; border-top: 1px solid #404040; color: #fff;">
									<div style="text-align: left; font-size: 18px; display: none;"
										id="previouspaymenthistorydiv">
										<br>
										<div
											style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
											Previous Payment Summary Of Customer --</div>
										<br> <br>
										<table align="center">
											<tr>
												<td><spring:message code="order.jsp.TOTALPAIDAMT"
														text="TOTAL PAID AMOUNT" /></td>
												<td width="5%">:</td>
												<td id="modtotalpaidamt"></td>
											</tr>

											<tr>
												<td><spring:message code="order.jsp.LASTORDERDATE"
														text="LAST ORDER DATE" /></td>
												<td width="5%">:</td>
												<td id="modlastorderdate"></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.LASTORDERPAIDAMT"
														text="LAST ORDER PAID AMOUNT" /></td>
												<td width="5%">:</td>
												<td id="modlastorderpaidamt"></td>
											</tr>
										</table>
									</div>
									<div style="text-align: left; font-size: 18px; display: none;"
										id="nopreviouspaymenthistorydiv">
										<br>
										<div
											style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
											Previous Payment Summary Not Available --</div>
										<br> <br>
									</div>
								</div>

								<!-- <div id="menu3" class="tab-pane fade" style="background: #404040;border-top: 1px solid #404040;color: #fff; important!">
            								<p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
    									</div> -->
							</div>
						</div>
						<%-- <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 18px;">
                           						<table>
                           						<c:if test="${!empty orders}">
                           						<tr>
                                            			<td><spring:message code="order.jsp.PHONENO" text="PHONE NO"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustPhone" value="${orders.customerContact}" autocomplete="off" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.CUSTOMERNAME" text="CUSTOMER NAME"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustName" value="${orders.customerName}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.location" text="LOCATION"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustlocation" value="${orders.location}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>

                                            		<tr>
                                            			<td><spring:message code="order.jsp.ADDRESS" text="ADDRESS"/></td>
                                            			<td>:</td>
                                            			<td>
                                            			<textarea id="modparcelcustAddress" rows="2" style="margin-bottom: 2px;color: #222222;width: 95%;">${orders.deliveryAddress}</textarea>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.DELIVERYPERSONNAME" text="DELIVERY PERSON NAME"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparceldeliveryPersonName" value="${orders.deliveryPersonName}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.houseno" text="HOUSE NO"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcusthouseno" value="${orders.houseNo}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.streetno" text="STREET NO"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcuststreet" value="${orders.street}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td>Cust VAT/CST:</td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustvatorcst" value="${orders.custVatRegNo}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		</c:if>
                                            		<c:if test="${empty orders}">
                                            		<tr>
                                            			<td><spring:message code="order.jsp.PHONENO" text="PHONE NO"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustPhone" value="" style="margin-bottom: 2px;color: #222222;width: 95%;" autofocus="autofocus"/></td>
                                            			<td><button type="button" onclick="javascript:searchCustomer()" class="btn btn-success" style="margin-bottom: 2px;background: #72BB4F;font-weight: bold;"><spring:message code="order.jsp.SEARCH" text="SEARCH"/></button></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.CUSTOMERNAME" text="CUSTOMER NAME"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustName" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>

                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.location" text="LOCATION"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustlocation" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.ADDRESS" text="ADDRESS"/></td>
                                            			<td>:</td>
                                            			<td>
                                            			<textarea id="modparcelcustAddress" rows="2" style="margin-bottom: 2px;color: #222222;width: 95%;"></textarea>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.DELIVERYPERSONNAME" text="DELIVERY PERSON NAME"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparceldeliveryPersonName" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.houseno" text="HOUSE NO"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcusthouseno" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="order.jsp.streetno" text="STREET NO"/></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcuststreet" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td>Cust. VAT/CST:</td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modparcelcustvatorcst" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		</c:if>
                                            	</table>

                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="parcelCustModalalertMsg"></div>
                                            </div>
                                        </div> --%>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<%-- <button type="button" onclick="javascript:cancelCustomer()"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button> --%>
							<button type="button" onclick="javascript:setCustomer()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="m.jsp.DONE" text="DONE" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="billPrintSuccessModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Success" text="Success" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="hidden" id="hiddmanualeditItemId" value="">
								<spring:message code="order.jsp.Billhasbeensuccessfullyprinted"
									text="Bill has been successfully printed" />
								!
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="javascript:showDirectPaymentforPacel()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="helloPrintModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 200px; height: auto;">


					<div class="modal-body" id="localPrint"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; height: auto; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">


							<b><font
								style="font-size: 12px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
							<b><font
								style="font-size: 10px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

							<div style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email" /> :</b>
								${sessionScope.loggedinStore.emailId}
							</div>
							<div style="font-size: 11px; font-family: sans-serif;">
								<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
							</div>

							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="ordervalue" style="font-weight:bold">00</span>
							</div>
							<div
										style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<%--  <fmt:setLocale value="en_us"/> --%>
										 <%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" />  --%>
										<b>Date :</b> <span  id="orderdate80">${orders.orderTime}<%-- <fmt:formatDate
												pattern="yyyy-MM-dd" value="${orders.orderDate}" />  --%></span>
									</div>

							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno">
								<b><spring:message code="order.jsp.TableNo"
										text="Table No :" /></b> <span id="tableNoValue">00</span>
							</div>
							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<%-- <spring:message code="order.jsp.TableNo"
										text="Table No :" /> --%>
										 <b><span id="unpaidtableNoValue">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId">

								<table
									style="color: #000000; border: none; height: 50px; width: 130px;">
									<c:if test="${! empty orders}">
										<thead>

											<th style="font-size: 10px; width: 30px;"><span
												style="float: left; font-family: sans-serif;"><spring:message
														code="order.jsp.Items" text="Items" /></span></th>
											<th
												style="text-align: center; font-size: 10px; font-family: sans-serif;"><spring:message
													code="order.jsp.Qty" text="Qty" /></th>
											<th
												style="text-align: right; font-size: 10px; font-family: sans-serif;"><spring:message
													code="order.jsp.Rate" text="Rate" /></th>
											<th
												style="text-align: right; font-size: 10px; font-family: sans-serif;"><spring:message
													code="order.jsp.Total" text="Total" /></th>

										</thead>

										<tbody style="color: #000000; padding: 1px;">
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<c:set var="bgCol" value="#ffffff"></c:set>
												<c:if
													test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
													<c:set var="bgCol" value="#1c91bc"></c:set>

												</c:if>
												<tr style="padding: 1px;">
													<%-- <td style="padding: 1px; text-align: center;">
																${stat.index+1}</td> --%>
													<td
														style="padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px; font-family: sans-serif;">
														<%-- <c:choose>
															<c:when test="${orderitems.ordertype==2}"> --%>

																<%--   ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
															        <%-- ${orderitems.item.name}(P) --%>
                                							<%-- </c:when>
															<c:otherwise> --%>
																<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                                										  ${orderitems.item.name}
                                							<%-- </c:otherwise>
														</c:choose> --%>
													</td>
													<td valign="middle" align="center"
														style="padding: 1px; font-size: 10px; font-family: sans-serif;">
														${orderitems.quantityOfItem}</td>
													<td
														style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 10px"><fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>
													<td
														style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 10px"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>



												</tr>

											</c:forEach>

										</tbody>
									</c:if>
									<c:if test="${empty orders}">
										<thead>

											<th><spring:message code="order.jsp.DELIVERYPERSONNAME"
													text="DELIVERY PERSON NAME" /></th>
											<th style="text-align: center;"><spring:message
													code="order.jsp.QUANTITY" text="QUANTITY" /></th>
											<th><spring:message code="order.jsp.RATE" text="RATE" /></th>
											<th><spring:message code="order.jsp.TOTAL" text="TOTAL" /></th>

										</thead>
										<tbody style="color: #fff; padding: 1px;">
										</tbody>
									</c:if>
								</table>

							</div>

							<div style="text-align: right; width: 150px;">--------------------</div>

							<table style="height: 50px; width: 150px;">

								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message
											code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="totalamt">00</span></td>
								</tr>
								<tr id="totalServiceChrg">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}:
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servChrg">00</span></td>
								</tr>

								<tr id="totalServiceTax">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total ${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servTax">00</span></td>
								</tr>

								<tr id="totalVatTax">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total ${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="vatTax">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="grossAmount">00</span></b></td>
								</tr>
								<tr id="showDiscount">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
										id="discountTxt">00</span>:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="discountValue">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="amoutToPay">00</span></b></td>
								</tr>
								<tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr>
							</table>

							<div style="text-align: left; width: 150px;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.ThankYouVisitAgain"
										text="**Thank You. Visit Again" /></font>
							</div>
						</div>
					</div>
					<div class="modal-footer" id="removePrint"
						style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
						<button type="button" onclick="javascript:localPrint()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success" id="printBtn">
							<spring:message code="order.jsp.PRINT" text="PRINT" />
						</button>
						<button type="button" onclick="return false"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">
							<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						</button>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="helloPrintModal80px" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">


					<div class="modal-body" id="localPrint80px"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
							</div> --%>

						<div
							style="text-align: center; width: 230px; font-size: 20px; color: #000000">


							<b><font
								style="font-size: 18px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>

							<c:if test="${sessionScope.loggedinStore.id==126}">
								<b><font
									style="font-size: 10px; font-style: normal; font-family: sans-serif;">A
										UNIT OF SAPPHIRE CAFE LLP</font></b>
							</c:if>
							<!-- <br> --> <b><font
								style="font-size: 10px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email" /> :</b>
								${sessionScope.loggedinStore.emailId}
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Web" text="Website" /> :</b>
								${sessionScope.loggedinStore.url}
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}
							</div>

							<div id="gstdata" style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">

							</div>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="ordervalue80px" style="font-weight:bold">00</span>
							</div>
							<div
										style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<%--  <fmt:setLocale value="en_us"/> --%>
										 <%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" />  --%>
										<b>Date :</b> <span  id="orderdate80">${orders.orderTime}<%-- <fmt:formatDate
												pattern="yyyy-MM-dd" value="${orders.orderDate}" />  --%></span>
									</div>

							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno80px">
								<b><spring:message code="order.jsp.TableNo" text="Table No" />
									:</b> <span id="tableNoValue80px">00</span>
							</div>

							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<%-- <spring:message code="order.jsp.TableNo"
										text="Table No :" /> --%>
										 <b><span id="unpaidtableNoValue80">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId">
								<table
									style="color: #000000; border: none; height: 50px; width: 230px;">
									<c:if test="${! empty orders}">
										<thead>
											<th style="font-size: 11px; width: 102px;"><span
												style="float: left; font-family: sans-serif;"><spring:message
														code="order.jsp.Items" text="Items" /></span></th>
											<th
												style="text-align: center; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.Qty" text="Qty" /></th>
											<th
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.RATE" text="RATE" /></th>
											<th
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.TOTAL" text="TOTAL" /></th>
										</thead>
										<tbody style="color: #000000; padding: 1px;">
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<c:set var="bgCol" value="#ffffff"></c:set>
												<c:if
													test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
													<c:set var="bgCol" value="#1c91bc"></c:set>

												</c:if>
												<tr style="padding: 2px;">
													<%-- <td style="padding: 1px; text-align: center;">
																${stat.index+1}</td> --%>
													<td
														style="padding: 1px; max-width: 102px !important; word-wrap: break-word; font-size: 11px; font-family: sans-serif;">
														<%--<c:choose>
															<c:when test="${orderitems.ordertype==2}">--%>

																<%--   ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
															       <%--  ${orderitems.item.name}(P)
                                							 </c:when>
															<c:otherwise>--%>
																<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                                										  ${orderitems.item.name}
                                							<%--</c:otherwise>
														</c:choose>--%>
													</td>
													<td valign="middle" align="center"
														style="padding: 3px; font-size: 11px; font-family: sans-serif;">
														${orderitems.quantityOfItem}</td>
													<td
														style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 11px"><fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>

													<td
														style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 11px"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
									<c:if test="${empty orders}">
										<thead>

											<th><spring:message code="order.jsp.NAME" text="NAME" /></th>
											<th style="text-align: center;"><spring:message
													code="order.jsp.QUANTITY" text="QUANTITY" /></th>
											<th><spring:message code="order.jsp.RATE" text="RATE" /></th>
											<th><spring:message code="order.jsp.TOTAL" text="TOTAL" /></th>

										</thead>
										<tbody style="color: #fff; padding: 1px;">
										</tbody>
									</c:if>
								</table>
							</div>
							<div style="text-align: right; width: 230px;">-----------------------</div>

							<table style="height: 50px; width: 230px;">

								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message
											code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="totalamt80px">00</span></td>
								</tr>
								<tr id="showDiscount80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
										id="discountTxt80px">00</span>:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="discountValue80px">00</span></td>
								</tr>
								
								
								
								<c:if
									test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">

									<c:if test="${orderTypeList.serviceChargeValue!=0.0}">
										<tr id="totalServiceCharge80px" class="hide">
											<td
												style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
												<%-- <spring:message code="order.jsp.ServiceCharge"
													text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}(${orders.orderBill.serviceChargeRate}%):
											</td>
											<td
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
												id="servChrg80px">00</span></td>
										</tr>
									</c:if>
								</c:if>

								<tr id="totalServiceTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total ${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servTax80px">00</span></td>
								</tr>

								<tr id="totalVatTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total ${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="vatTax80px">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" /> :</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="grossAmount80px">00</span></b></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="amoutToPay80px">00</span></b></td>
								</tr>
								<tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr>
                             <!-- <tr id="cusnametrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Name:</td>
									<td id="cusnameup80" style="text-align: right;"></td>
								</tr>
								 <tr id="cusphnotrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Ph No:</td>
									<td id="cusphnoup80" style="text-align: right;"></td>
								</tr>
                                  <tr id="cusaddresstrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Address::</td>
									<td id="cusaddressup80" style="text-align: right;"></td>
								</tr>
                                   <tr id="cuslocationtrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Location:</td>
									<td id="cuslocationup80" style="text-align: right;"></td>
								</tr>
                                  <tr id="cusstreettrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Street:</td>
									<td id="cusstreetup80" style="text-align: right;"></td>
								</tr>
                                   <tr id="cushousenotrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >House No:</td>
									<td id="cushousenoup80" style="text-align: right;"></td>
								</tr>

                                   <tr id="deliveryboytrup80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Dlv By:</td>
									<td id="deliveryboyup80" style="text-align: right;"></td>
								</tr>  -->

							</table>
                             <table style="width:60%;" id="unpaidcustomerdetailstab" style="display:none">
						<c:if test="${! empty orders.customerName}">
							<tr id="showcustomerNameDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showcustomerNameTxt80px">Name: </span></td>
								<td style="font-size: 11px; font-weight: bold;font-family: sans-serif;"><span
									id="showcustomerNameValue80px">${orders.customerName}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.customerContact}">
							<tr id="showcustomerContactDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showcustomerContactTxt80px">Ph No: </span></td>
								<td style="font-size: 11px; font-weight: bold;font-family: sans-serif;"><span
									id="showcustomerContactValue80px">${orders.customerContact}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryAddress}">
							<tr id="showdeliveryAddressDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryAddressTxt80px">Address: </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryAddressValue80px">${orders.deliveryAddress}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.location}">
							<tr id="showdeliveryAddressDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryLocationTxt80px">Location: </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryLocationValue80px">${orders.location}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.street}">
							<tr id="showdeliveryStreetDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryStreetTxt80px">Street: </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryStreetValue80px">${orders.street}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.houseNo}">
							<tr id="showdeliveryHouseNoDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryHouseNoTxt80px">House No: </span></td>
								<td style="font-size: 11px; font-weight: bold;font-family: sans-serif;"><span
									id="showdeliveryHouseNoalue80px">${orders.houseNo}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryPersonName}">
							<tr id="showdeliveryPersonNameDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryPersonNameTxt80px">Dlv By: </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryPersonNameValue80px">${orders.deliveryPersonName}</span></td>
							</tr>
						</c:if>
						<tr>
							<td style="visibility: hidden;">---------------------------</td>
							<td></td>
						</tr>

					</table>





							<div style="text-align: center; width: 230px;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.**Thank You. Visit Again"
										text="**Thank You. Visit Again" />**</font>
							</div>
						</div>
						<div class="modal-footer" id="removePrint80px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint80px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">
								<spring:message code="order.jsp.PRINT" text="PRINT" />
							</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="printingkot"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" style="width: 205px; height: 'auto';">
					<div class="modal-body" id="kotPrint"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 2px !important;">
						<div
							style="text-align: center; width: 205px; font-size: 20px; color: #000000">
							<div
								style="text-align: center; font-family: sans-serif; font-size: 20px">
								<spring:message code="order.jsp.KOT" text="KOT" />
							</div>
							<font
								style="font-size: 18px; font-family: sans-serif; text-align: center;">${sessionScope.loggedinStore.storeName}</font><br>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<span id="dateTimeValue">00</span>&nbsp;(${sessionScope.loggedinUser.contactNo})
							</div>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="ordValue" style="font-weight:bold">00</span>
							</div>
							<div id="kottable"
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.TableNo" text="Table No" />
									:</b> <span id="tblValue">00</span>
							</div>
							<div id="kothdorpercel" class="hide"
								style="text-align: left; font-size: 12px; font-family: sans-serif;">
								<b> <span id="hdorpercelValue"></span></b>
							</div>
							<div id="kothdorremarks"   style="text-align: left; font-size: 12px; font-family: sans-serif;">
								<b> <span id="hdorRemarksValue"></span></b>
								
							</div>
							<div style="visibility: hidden;">----------</div>

							<table
								style="color: #000000; border: none; height: auto; width: 186px;">
								<thead>
									<th style="font-size: 11px; width: 102px;"><span
										style="float: left; font-family: sans-serif;">ITEM NAME</span></th>
									<th
										style="text-align: center; font-family: sans-serif; font-size: 11px">QTY</th>
								</thead>
								<tbody
									style="color: #000000; padding: 1px; font-family: sans-serif; font-size: 11px;"
									id="kotitems"></tbody>
							</table>
						</div>
						<div class="modal-footer" id="removeKotPrint"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:kotPrint()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">
								<spring:message code="order.jsp.PRINT" text="PRINT" />
							</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="printingkot58"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" style="width: 200px; height: 'auto';">
					<div class="modal-body" id="kotPrint58"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 2px !important;">
						<div
							style="font-size: 20px; color: #000000 word-wrap: break-word; width: 170px;">
							<div
								style="text-align: center; font-family: sans-serif; font-size: 20px">
								<spring:message code="order.jsp.KOT" text="KOT" />
							</div>
							<font style="font-size: 18px; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font><br>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<span id="dateTimeValue58">00</span>&nbsp;(${sessionScope.loggedinUser.contactNo})
							</div>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="ordValue58" style="font-weight:bold">00</span>
							</div>
							<div id="kottable58"
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.TableNo" text="Table No" />
									:</b> <span id="tblValue58">00</span>
							</div>


							<div id="kothdorpercel58" class="hide"
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b> <span id="hdorpercelValue58"></span></b>
							</div>
							<div id="kothdorremarks58"   style="text-align: left; font-size: 12px; font-family: sans-serif;">
								<b> <span id="hdorRemarksValue58"></span></b>
								
							</div>
							<div style="visibility: hidden;">----------</div>
							<table
								style="color: #000000; border: none; height: 50px; width: 130px;">
								<thead>
									<th style="font-size: 11px; width: 100px;"><span
										style="float: left; font-family: sans-serif;">ITEM NAME</span></th>
									<th
										style="text-align: center; font-family: sans-serif; font-size: 11px">QTY</th>
								</thead>
								<tbody
									style="color: #000000; padding: 1px; font-family: sans-serif; font-size: 11px;"
									id="kotitems58"></tbody>
							</table>
						</div>
						<div class="modal-footer" id="removeKotPrint58"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:kotPrint58()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn58">
								<spring:message code="order.jsp.PRINT" text="PRINT" />
							</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>


			<%-- 			<div class="modal fade" data-backdrop="static"
				id="cashhelloPrintModal2100" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">


					<div class="modal-body" id="printDiv2100_GST"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<div
							style="text-align: center; width: auto; font-size: 20px; color: #000000">

							<b><font
								style="font-size: 19px; font-style: inherit; font-family: sans-serif;"><div
										id="storeName2100"></div></font></b> <b><font
								style="font-size: 17px; font-style: normal; font-family: sans-serif;"><div
										id="storeAddr2100"></div></font></b> <font
								style="font-size: 15px; text-align: center; width: auto; font-style: inherit; font-family: sans-serif;"><div
									id="storeEmail2100"></div></font> <font
								style="font-size: 15px; text-align: center; width: auto; font-style: normal; font-family: sans-serif;"><div
									id="storePhNo2100"></div></font><br>

							<!-- <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No:</b> <span id="cashOrdervalue2100">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;" id="showtableno2100px">
								<b>Table No:</b> <span id="cashtableNoValue2100">00</span>
							</div> -->
							<div>
								<div style="float: left;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>${sessionScope.loggedinStore.gstText} :</b> <span
											id="ordervalue_2100px">${sessionScope.loggedinStore.gstRegNo}</span>
									</div>
									<br>
									<br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Details of Receiver</b>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Name :</b><span id="showcustomerNameValue_2100px"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b><span id="showdeliveryAddressValue_2100px"></span>
									</div>
									<!-- <div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b>
									</div> -->
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span
											id="showbillingCustomerVatRegNo_2100px"></span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="ordervalue_2100px_gst">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<fmt:parseDate value="${today}" var="parsedInvDate" pattern="yyyy-MM-dd" /> <fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />
										<b>Date :</b> <span id="showbillingCustomerDate_2100px"></span>
									</div>
								</div>
							</div>
							<!-- <div style="text-align: left;">-------------------------------------------------------------------------------------------------------</div> -->

							<div class="table-responsive" id="orderitemContId_2100">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;">
									<!-- color: #000000; border: none; height: 50px; width: 100%; -->

									<thead>

										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="30%;"><spring:message code="item.jsp.name"
													text="Item Name" /></th>
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
											<th><spring:message code="purinvdet.jsp.batch"
													text="SAC" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Qty" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Unit" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.pqty" text="Rate" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.lqty" text="Total" /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Disc" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Taxable Value" /></th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
											</th>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
										</tr>
										<!-- <tr>
											<th style="font-size: 15px; width: 102px;"><span style="float: left;font-family: sans-serif;">Item</th>
											<th style="width:110px; float:right;padding-right:120px;text-align: center; font-size: 15px;font-family: sans-serif;">Qty</th>
											<th style="width:110px; padding-right:110px; text-align: center; font-size: 15px;font-family: sans-serif;">Rate</th>
											<th style="width:110px; text-align: center; font-size: 15px;font-family: sans-serif;">Amt</th>
										</tr> -->
									</thead>


									<tbody style="color: #000000; padding: 1px;"
										id="itemDetailsPrint2100"></tbody>

								</table>
							</div>


							<!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

							<table style="height: 50px; width: 100%;">

								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">TOTAL
										AMOUNT:</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashtotalamt2100">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										Service Charge:</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<span id="cashservChrg2100">00</span>
									</td>
								</tr>

								<tr id="cashtotalServiceTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										CGST(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashservTax2100">00</span></td>
								</tr>

								<tr id="cashtotalVatTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										SGST(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashvatTax2100px">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashgrossAmount2100">00</span></b></td>
								</tr>

								<tr id="cashshowDiscount2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										TOTAL DISCOUNT:</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashdiscountValue2100">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">AMOUNT
												TO PAY:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashamoutToPay2100">00</span></b></td>
								</tr>
							</table>

							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<table style="height: 50px; width: 100%;">

								<tr>
									<td id="paid_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount2100">00</span></b></td>
								</tr>

								<tr>
									<td id="tender_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Tender
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="tenderAmount2100">00</span></b></td>
								</tr>

								<tr>
									<td id="refund_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b>
											<span id="refundAmount2100"><fmt:formatNumber
													type="number" value="${invPurchaseOrderItem.oldStock}"
													maxFractionDigits="2" />00</span>
									</b></td>
								</tr>



							</table>

							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<div style="text-align: center;">
								<b><font style="font-size: 15px; font-family: sans-serif;"><span
										id="payType2100"></span></font></b>
							</div>
							<div style="text-align: center;">
								<font style="font-size: 16px; font-family: sans-serif;">****Thank
									You. Visit us Again****</font>
							</div>
						</div>
						<div class="modal-footer" id="cashRemovePrint2100"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button"
								onclick="javascript:printCashOrCardLocal2100()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="printBtn_80">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div>
					</div>

				</div>
			</div>
 --%>





			<!-- PRINT IN PRINT BUTTON 2100 ( for GST) -->

			<div class="modal fade" data-backdrop="static"
				id="helloPrintModal_2100px_GST" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="localPrint_2100px_GST"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">


							<b><font
								style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
							<b><font
								style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Email :</b> ${sessionScope.loggedinStore.emailId}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Tax Invoice </b>
							</div>
							<div>
								<div style="float: left;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>${sessionScope.loggedinStore.gstText} :</b> <span
											id="ordervalue_2100px">${sessionScope.loggedinStore.gstRegNo}</span>
									</div>
									<br> <br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Details of Receiver</b>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Name :</b><span id="showcustomerNameValue_2100px">${orders.customerName}</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b><span id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b><span id="showdeliveryStateValue_2100px">${orders.state}</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Contact No:</b><span id="showcustomerContactNoValue_2100px">${orders.customerContact}</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span>${orders.custVatRegNo}</span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="ordervalue_2100px_gst">00</span>
									</div>
									 <div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" /> --%>
										<b>Date :</b> <span>${orders.orderTime}<%-- <fmt:formatDate
												pattern="yyyy-MM-dd" value="${parsedInvDate}" /> --%></span>
									</div>
									<div style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<%-- <spring:message code="order.jsp.TableNo"
										text="Table No :" /> --%>
										 <b><span id="unpaidtableNoValue2100">00</span></b>
							</div>



								</div>
							</div>
							<!-- <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No / Invoice :</b> <span id="ordervalue_2100px">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;" id="showtableno_2100px">
								<b>Table No :</b> <span id="tableNoValue_2100px">00</span>
							</div> -->

							<!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

							<div style="float: left; margin-bottom: 5%;" id="orderitemContId">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"
									id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="30%;"><spring:message code="item.jsp.name"
													text="Item Name" /></th>
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
											<th><spring:message code="purinvdet.jsp.batch"
													text="SAC" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Qty" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Unit" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.pqty" text="Rate" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.lqty" text="Total" /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Disc" /></th>
											
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}"> 
											<th width="5%;">${sessionScope.loggedinStore.serviceChargeText}</th> 
											</c:if>
											
													
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Taxable Value" /></th>
													
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
											</th>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											 
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
											<td></td> 
											</c:if>
											
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${!empty orders.orderitem }">
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<tr>
													<td width="5%;">${stat.index+1}</td>
													<td width="30%;">
													<%--<c:choose>
															<c:when test="${orderitems.ordertype==2}">--%>
																<%-- ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
												        <%--${orderitems.item.name}(P)
                             					</c:when>
															<c:otherwise>--%>
																<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                             										  ${orderitems.item.name}
                             					<%--</c:otherwise>
														</c:choose>--%>
														</td>
													<td>${orderitems.item.code}</td>
													<td></td>
													<td width="6%;">${orderitems.quantityOfItem}</td>
													<td width="6%;">${orderitems.item.unit}</td>
													<td width="5%;"><fmt:formatNumber type="number"
															maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>
													<td width="5%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>
													<%-- <td width="5%;" id="tbl_orderItemDisc">${orderitems.discount}</td> --%>
													<td width="5%;" id="tbl_orderItemDisc">
													  <c:if test="${fn:containsIgnoreCase(orderitems.item.spotDiscount, 'Y') }">
												       <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
														<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${(((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100}"></fmt:formatNumber>
													 </c:if> 
													 <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
														<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100}"></fmt:formatNumber>
													  </c:if>
											        </c:if>
													 <c:if test="${fn:containsIgnoreCase(orderitems.item.spotDiscount, 'N') }">
													     0.00
													   </c:if>
													</td>
													<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
													 <td width="5%;" id="tbl_orderItemSChargeAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100))*orders.orderBill.serviceChargeRate)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)) * orders.orderBill.serviceChargeRate)/100 }"></fmt:formatNumber>
														</c:if>
													</td> 
													</c:if>
													
													
													<%-- <td width="10%;" id="tbl_orderItemTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)}"></fmt:formatNumber>
														</c:if>
													</td> --%>
													<td width="10%;" id="tbl_orderItemTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100) + (((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100))*orders.orderBill.serviceChargeRate)/100)}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100) + ((((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)) * orders.orderBill.serviceChargeRate)/100)}"></fmt:formatNumber>
														</c:if>
													</td> 
													
													
													<td width="5%;">${orderitems.vat}</td>
													<%-- <td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if></td> --%>
													<td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)+(((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100))*orders.orderBill.serviceChargeRate)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100) + ((((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)) * orders.orderBill.serviceChargeRate)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if>
													</td>	
													<td width="5%;">${orderitems.serviceTax}</td>
													<%-- <td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if></td> --%>
														<td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100) + (((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100))*orders.orderBill.serviceChargeRate)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100) + ((((orderitems.quantityOfItem*orderitems.item.price) - (((orderitems.quantityOfItem*orderitems.item.price)*orders.orderBill.discountPercentage)/100)) * orders.orderBill.serviceChargeRate)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if>
													   </td>
													<%-- <td width="5%;">${orderitems.vat + orderitems.serviceTax}</td> --%>
													<td width="5%;"></td>
													<td width="10%;">
														<%-- <c:if
												test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
												<fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2"
													value="${(((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.vat)/100) + (((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
											</c:if> <c:if
												test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
												<fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2"
													value="${((((orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount) * orderitems.vat)/100) + ((((orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
											</c:if> --%>
													</td>
												</tr>

											</c:forEach>
										</c:if>
										<tr style="border-top: 1px dashed;">
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td><b>Total:</b></td>
											<td><span id="totalamt_2100px_gst">00</span></td>
											<td><span id="discountValue_2100px_gst">00</span></td>
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
											<td><span id="schargeValue_2100px_gst">00</span></td>
											</c:if>
											<td><span id="taxableAmount_2100px_gst">00</span></td>
											<td></td>
											<td><span id="vatTax_2100px_gst">00</span></td>
											<td></td>
											<td><span id="servTax_2100px_gst">00</span></td>
											<td></td>
											<td><span id="igst_2100px_gst"></span></td>
										</tr>
									</tbody>
								</table>
							</div>

							<%--
					<div class="table-responsive" id="orderitemContId">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">
									<c:if test="${! empty orders}">
										<thead>
											<th style="font-size: 15px; width: 102px;"><span
												style="float: left;font-family: sans-serif;">Items</span></th>
											<th style="width:110px; float:right;padding-right:120px;text-align: center; font-size: 15px;font-family: sans-serif;">QTY</th>
											<th style="width:110px; padding-right:110px; text-align: center; font-size: 15px;font-family: sans-serif;">RATE</th>
											<th style="width:110px; text-align: center; font-size: 15px;font-family: sans-serif;">TOTAL</th>

										</thead>

										<tbody style="color: #000000; padding: 1px;">
					<!-- <tr>
					<td style="width: 100% !important">1--------------------------------------------------------------------------------------------------------------</td>
					<td></td>
					</tr> -->
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<c:set var="bgCol" value="#ffffff"></c:set>
												<c:if
													test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
													<c:set var="bgCol" value="#1c91bc"></c:set>

												</c:if>
												<tr style="padding: 2px;">
													<td style="padding: 1px; text-align: center;">
																${stat.index+1}</td>
													<td
														style="padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px;font-family: sans-serif;">
														<c:choose>
															<c:when test="${orderitems.ordertype==2}">

																  ${fn:substring(orderitems.item.name,0,18)}(P)...
															        ${orderitems.item.name}(P)
                                							</c:when>
															<c:otherwise>
																${fn:substring(orderitems.item.name,0,18)}...
                                										  ${orderitems.item.name}
                                							</c:otherwise>
														</c:choose>
													</td>
													<td valign="middle" style="float:right;font-size: 14px;font-family: sans-serif;padding-right:170px;text-align:center">
														${orderitems.quantityOfItem}</td>
													<td
														style="font-size: 14px;font-family: sans-serif;padding-right:110px;text-align:center"><fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>
													<td
														style="padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
									<c:if test="${empty orders}">
										<thead>

											<th>NAME</th>
											<th style="text-align: center;">QUANTITY</th>
											<th>RATE</th>
											<th>TOTAL</th>

										</thead>
										<tbody style="color: #fff; padding: 1px;">
										</tbody>
									</c:if>
								</table>
							</div> --%>
							<!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

							<%-- 		<table style="height: 50px; width: 100%;">
								<tr id="showDiscount_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="discountTxt_2100px">00</span></td>
									<td
										style="text-align: right; font-size: 14px; font-family: sans-serif;"><span
										id="discountValue_2100px">00</span></td>
								</tr>
								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Amount :</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="totalamt_2100px">00</span></td>
								</tr>

								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Service Tax :</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="servTax_2100px">00</span></td>
								</tr>

								<tr id="totalVatTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Vat :</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="vatTax_2100px">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
												Amount :</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="grossAmount_2100px">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 14px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_2100px">00</span></b></td>
								</tr>
								<!-- <tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr> -->

							</table>
 <c:if test="${! empty orders.customerName}">
<div style="">-------------------------------------------------------------------------------------------------------</div>
</c:if>				 --%>
							<%-- <table style="height: 50px; width: 100%;">
							  <c:if test="${! empty orders.customerName}">
								<tr id="showcustomerNameDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showcustomerNameTxt_2100px">Cust Name : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showcustomerNameValue_2100px">${orders.customerName}</span></td>
								 </tr>
								</c:if>
								<c:if test="${! empty orders.customerContact}">
								<tr id="showcustomerContactDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showcustomerContactTxt_2100px">Cust Ph : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showcustomerContactValue_2100px">${orders.customerContact}</span></td>
								</tr>
								</c:if>
								<c:if test="${! empty orders.deliveryAddress}">
								<tr id="showdeliveryAddressDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showdeliveryAddressTxt_2100px">Address : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span></td>
								</tr>
								</c:if>
								<c:if test="${! empty orders.deliveryPersonName}">
								<tr id="showdeliveryPersonNameDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showdeliveryPersonNameTxt_2100px">Del Person Name : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showdeliveryPersonNameValue_2100px">${orders.deliveryPersonName}</span></td>
								</tr>
								</c:if>


							</table>
<div style="">-------------------------------------------------------------------------------------------------------</div> --%>


						</div>

						<div>
							<table style="height: 50px; width: 100%;">
								<tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In figure) :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="totgrossAmount_2100px_gst">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In Words):</span></b></td>
									<td width="100%"
										style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
										id="grossAmount_2100px_word_gst"></span></td>
								</tr>
								 <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
								<tr id="totalServiceCharge_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										${sessionScope.loggedinStore.serviceChargeText}(${orders.orderBill.serviceChargeRate }%):</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="totserviceCharge_2100px_gst">
										<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orders.orderBill.serviceChargeAmt }"></fmt:formatNumber>
										</span></b>
									</td>
								</tr>
								</c:if>
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;display:none;">
									    <span style="padding-left: 52%" id="totvatTax_2100px_gst">00</span>
										<span style="padding-left: 16%" id="totservTax_2100px_gst">00</span>
										<span style="padding-left: 5%" id="totigst_2100px_gst"></span>
									</td>
										<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="totalTaxAmount_2100px_gst">00</span></b>
									</td>

								</tr>
								
                              
								<!-- new added 10.5.2018 start -->
								 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount_2100px">00</span></b></td>
								 </tr>


								 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_2100px">00</span></b></td>
								 </tr>
								<!-- new added 10.5.2018 end -->




							</table>
						</div>

						<div style="text-align: center; margin-top: 30px;">
							<font
								style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
								You. Visit us Again*****</font>
						</div>
						<!-- <div class="modal-footer" id="removePrint_2100px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint_2100px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div> -->
					</div>
				</div>
			</div>










			<%-- <div class="modal fade" data-backdrop="static"
				id="helloPrintModal_2100px_GST" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="localPrint_2100px_GST"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">


							<b><font
								style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
							<b><font
								style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Email :</b> ${sessionScope.loggedinStore.emailId}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Tax Invoice </b>
							</div>
							<div>
								<div style="float: left;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>${sessionScope.loggedinStore.gstText} :</b> <span
											id="ordervalue_2100px">${sessionScope.loggedinStore.gstRegNo}</span>
									</div>
									<br>
									<br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Details of Receiver</b>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Name :</b><span id="showcustomerNameValue_2100px">${orders.customerName}</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b><span id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span>${orders.custVatRegNo}</span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="ordervalue_2100px_gst">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="MMM dd, yyyy" />
										<b>Date :</b> <span><fmt:formatDate
												pattern="yyyy-MM-dd" value="${parsedInvDate}" /></span>
									</div>
								</div>
							</div>
							<!-- <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No / Invoice :</b> <span id="ordervalue_2100px">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;" id="showtableno_2100px">
								<b>Table No :</b> <span id="tableNoValue_2100px">00</span>
							</div> -->

							<!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

							<div style="float: left; margin-bottom: 5%;" id="orderitemContId">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"
									id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="30%;"><spring:message code="item.jsp.name"
													text="Item Name" /></th>
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
											<th><spring:message code="purinvdet.jsp.batch"
													text="SAC" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Qty" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Unit" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.pqty" text="Rate" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.lqty" text="Total" /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Disc" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Taxable Value" /></th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
											</th>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${!empty orders.orderitem }">
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<tr>
													<td width="5%;">${stat.index+1}</td>
													<td width="30%;"><c:choose>
															<c:when test="${orderitems.ordertype==2}">
													  ${fn:substring(orderitems.item.name,0,18)}(P)...
												        ${orderitems.item.name}(P)
                             					</c:when>
															<c:otherwise>
													${fn:substring(orderitems.item.name,0,18)}...
                             										  ${orderitems.item.name}
                             					</c:otherwise>
														</c:choose></td>
													<td>${orderitems.item.code}</td>
													<td></td>
													<td width="6%;">${orderitems.quantityOfItem}</td>
													<td width="6%;">${orderitems.item.unit}</td>
													<td width="5%;"><fmt:formatNumber type="number"
															maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>
													<td width="5%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>
													<td width="5%;" id="tbl_orderItemDisc">${orderitems.discount}</td>
													<td width="10%;" id="tbl_orderItemTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount}"></fmt:formatNumber>
														</c:if></td>
													<td width="5%;">${orderitems.vat}</td>
													<td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if></td>
													<td width="5%;">${orderitems.serviceTax}</td>
													<td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if></td>
													<td width="5%;">${orderitems.vat + orderitems.serviceTax}</td>
													<td width="10%;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.vat)/100) + (((((orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount) * orderitems.vat)/100) + ((((orderitems.quantityOfItem*orderitems.item.price) - orderitems.discount) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
														</c:if></td>
												</tr>

											</c:forEach>
										</c:if>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>Total:</td>
											<td><span id="totalamt_2100px_gst">00</span></td>
											<td><span id="discountValue_2100px_gst">00</span></td>
											<td><span id="taxableAmount_2100px_gst">00</span></td>
											<td></td>
											<td><span id="vatTax_2100px_gst">00</span></td>
											<td></td>
											<td><span id="servTax_2100px_gst">00</span></td>
											<td></td>
											<td><span id="igst_2100px_gst">00</span></td>
										</tr>
									</tbody>
								</table>
							</div>


					<div class="table-responsive" id="orderitemContId">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">
									<c:if test="${! empty orders}">
										<thead>
											<th style="font-size: 15px; width: 102px;"><span
												style="float: left;font-family: sans-serif;">Items</span></th>
											<th style="width:110px; float:right;padding-right:120px;text-align: center; font-size: 15px;font-family: sans-serif;">QTY</th>
											<th style="width:110px; padding-right:110px; text-align: center; font-size: 15px;font-family: sans-serif;">RATE</th>
											<th style="width:110px; text-align: center; font-size: 15px;font-family: sans-serif;">TOTAL</th>

										</thead>

										<tbody style="color: #000000; padding: 1px;">
					<!-- <tr>
					<td style="width: 100% !important">1--------------------------------------------------------------------------------------------------------------</td>
					<td></td>
					</tr> -->
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<c:set var="bgCol" value="#ffffff"></c:set>
												<c:if
													test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
													<c:set var="bgCol" value="#1c91bc"></c:set>

												</c:if>
												<tr style="padding: 2px;">
													<td style="padding: 1px; text-align: center;">
																${stat.index+1}</td>
													<td
														style="padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px;font-family: sans-serif;">
														<c:choose>
															<c:when test="${orderitems.ordertype==2}">

																  ${fn:substring(orderitems.item.name,0,18)}(P)...
															        ${orderitems.item.name}(P)
                                							</c:when>
															<c:otherwise>
																${fn:substring(orderitems.item.name,0,18)}...
                                										  ${orderitems.item.name}
                                							</c:otherwise>
														</c:choose>
													</td>
													<td valign="middle" style="float:right;font-size: 14px;font-family: sans-serif;padding-right:170px;text-align:center">
														${orderitems.quantityOfItem}</td>
													<td
														style="font-size: 14px;font-family: sans-serif;padding-right:110px;text-align:center"><fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>
													<td
														style="padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
									<c:if test="${empty orders}">
										<thead>

											<th>NAME</th>
											<th style="text-align: center;">QUANTITY</th>
											<th>RATE</th>
											<th>TOTAL</th>

										</thead>
										<tbody style="color: #fff; padding: 1px;">
										</tbody>
									</c:if>
								</table>
							</div>
							<!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

									<table style="height: 50px; width: 100%;">
								<tr id="showDiscount_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="discountTxt_2100px">00</span></td>
									<td
										style="text-align: right; font-size: 14px; font-family: sans-serif;"><span
										id="discountValue_2100px">00</span></td>
								</tr>
								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Amount :</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="totalamt_2100px">00</span></td>
								</tr>

								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Service Tax :</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="servTax_2100px">00</span></td>
								</tr>

								<tr id="totalVatTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Vat :</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="vatTax_2100px">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
												Amount :</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="grossAmount_2100px">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 14px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_2100px">00</span></b></td>
								</tr>
								<!-- <tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr> -->

							</table>
 <c:if test="${! empty orders.customerName}">
<div style="">-------------------------------------------------------------------------------------------------------</div>
</c:if>
							<table style="height: 50px; width: 100%;">
							  <c:if test="${! empty orders.customerName}">
								<tr id="showcustomerNameDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showcustomerNameTxt_2100px">Cust Name : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showcustomerNameValue_2100px">${orders.customerName}</span></td>
								 </tr>
								</c:if>
								<c:if test="${! empty orders.customerContact}">
								<tr id="showcustomerContactDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showcustomerContactTxt_2100px">Cust Ph : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showcustomerContactValue_2100px">${orders.customerContact}</span></td>
								</tr>
								</c:if>
								<c:if test="${! empty orders.deliveryAddress}">
								<tr id="showdeliveryAddressDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showdeliveryAddressTxt_2100px">Address : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span></td>
								</tr>
								</c:if>
								<c:if test="${! empty orders.deliveryPersonName}">
								<tr id="showdeliveryPersonNameDiv_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="showdeliveryPersonNameTxt_2100px">Del Person Name : </span></td>
									<td
										style="font-size: 14px; font-family: sans-serif;"><span
										id="showdeliveryPersonNameValue_2100px">${orders.deliveryPersonName}</span></td>
								</tr>
								</c:if>


							</table>
<div style="">-------------------------------------------------------------------------------------------------------</div>


						</div>

						<div>
							<table style="height: 50px; width: 100%;">
								<tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In figure) :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="totgrossAmount_2100px_gst">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In Words):</span></b></td>
									<td width="100%"
										style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
										id="grossAmount_2100px_word_gst"></span></td>
								</tr>
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;"><span
										style="padding-left: 52%" id="totvatTax_2100px_gst">00</span>
										<span style="padding-left: 16%" id="totservTax_2100px_gst">00</span>
										<span style="padding-left: 5%" id="totigst_2100px_gst">00</span>
									</td>

								</tr>
							</table>
						</div>

						<div style="text-align: center; margin-top: 30px;">
							<font
								style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
								You. Visit us Again*****</font>
						</div>
						<!-- <div class="modal-footer" id="removePrint_2100px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint_2100px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div> -->
					</div>
				</div>
			</div> --%>

			<div class="modal fade" data-backdrop="static"
				id="cashhelloPrintModal2100_GST" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="printDiv2100GST"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">


							<b><font
								style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
							<b><font
								style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}
							</font></b>

							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Email :</b> ${sessionScope.loggedinStore.emailId}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Tax Invoice </b>
							</div>
							<div>
								<div style="float: left;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>${sessionScope.loggedinStore.gstText} :</b>
										${sessionScope.loggedinStore.gstRegNo}
									</div>
									<br> <br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Details of Receiver</b>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Name :</b><span id="cashCustName_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b> <span id="cashCustAddr_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b><span id="cashCustState_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Contact No:</b><span id="cashCustPhone2100_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span id="cashCustGSTIN_GST"></span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="cashOrdervalue2100_GST">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Date :</b> <span id="cashOrderDate_GST"></span>
									</div>
								<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b><span id="cashtableNoValue2100">00</span></b>
							   </div>

								</div>
							</div>

							<div style="float: left; margin-bottom: 5%;"
								id="orderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"
									id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="30%;"><spring:message code="item.jsp.name"
													text="Item Name" /></th>
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
											<th><spring:message code="purinvdet.jsp.batch"
													text="SAC" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Qty" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Unit" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.pqty" text="Rate" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.lqty" text="Total" /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Disc" /></th>
											
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}"> 
											<th width="5%;">${sessionScope.loggedinStore.serviceChargeText}</th> 
											</c:if>
											
													
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Taxable Value" /></th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
											</th>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}"> 
											<td></td> 
											</c:if>
											<td></td>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
										</tr>
									</thead>
									<tbody id="itemDetailsPrint2100_GST">

									</tbody>
								</table>
							</div>



						</div>

						<div>
							<table style="height: 50px; width: 100%;">
								<tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In figure) :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashgrossAmount2100_gst">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In Words):</span></b></td>
									<td width="100%"
										style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
										id="cashgrossAmount2100_word_gst"></span></td>
								</tr>
								
								<tr id="cashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										Total ${sessionScope.loggedinStore.serviceChargeText}:(<span id="cashservChrgPercentage2100">00</span>%)</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="cashservChrg2100">00</span></b>
									</td>
								</tr>
								
								
								
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;display:none">
									    <span style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 5%"></span>
									</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="cashTotalTaxAmount2100_gst">00</span></b>
									</td>

								</tr>
								<!-- new added 10.5.2018 start -->
								 <tr>
	                             <td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount_paidbill_2100px">00</span></b></td>
								 </tr>


								 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_paidbill_2100px">00</span></b></td>
								 </tr>
								 <!-- new added 10.5.2018 end -->
									 <tr>
									<td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td>
									<td width="50%" style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
									   <b><span id="paymentmode_paidbill_2100px"></span></b></td>
								 </tr>

									<!-- new added 10.5.2018 end -->

							</table>
						</div>

						<div style="text-align: center; margin-top: 30px;">
							<font
								style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
								You. Visit us Again*****</font>
						</div>
						<!-- <div class="modal-footer" id="removePrint_2100px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint_2100px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div> -->
					</div>
				</div>
			</div>





			<div class="modal fade" data-backdrop="static"
				id="specialnoteforOrderModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								Add Special Note for <span id="headerforitemnamespnote"></span>
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="overflow-y: auto;">
								<div class="panel panel-default" style="background: #404040;">
									<div class="panel-body" style="max-height: 300px;">
										<input type="hidden" id="itemidforsetsplnote" value="">
										<div class="table-responsive"
											id="specialnoteforOrderContainerId"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								onclick="javascript:setspecialNoteforOrder();"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.ADD" text="ADD" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="creditsaleModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
								<span id="creditsalemodOrderCont" class="hide">00</span> 
								<span id="creditsalemodStoreBaseOrderCont">00</span><span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO" /><span
									id="creditsalemodTabCont">00</span></span>

							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div>
								<c:if test="${sessionScope.loggedinStore.id !=87}">
									<div align="center"
										style="font-size: 20px; margin-bottom: 5px;">
										<spring:message code="order.jsp.CREDITSALE" text="CREDIT SALE" />
									</div><br>
								</c:if>
								<c:if test="${sessionScope.loggedinStore.id ==87}">
									<div align="center"
										style="font-size: 20px; margin-bottom: 5px;">
										<spring:message code="order.jsp.STAFFFOOD" text="STAFF FOOD" />
									</div><br>
								</c:if>
								<div class="row" style="font-size: 14px; font-weight: bold;">
								 <div class="col-md-1 col-lg-1"></div>
								   <div class="col-md-5 col-lg-5">
									<spring:message code="order.jsp.Name" text="Name" />
									: <input type="text" value="" id="creditsalecustname" size="14"
										style="color: #222222;" />
								    </div>
									 <div class="col-md-6 col-lg-6">
									<spring:message code="order.jsp.ORContactNo"
										text="OR Contact No" />
									: <input type="text" value="" id="creditsalecustcontact"
										size="14" style=" color: #222222;" />
									 </div>
								 </div><br>

								<div class="row" style="text-align: center;">
									<span id='addCreditCustSpan'> <a
										href="javascript:showcreditcustaddModal()" class="btn-order-taking"
										style="font-size: 12px; margin-left: 1%; text-align: center;">NEW CUSTOMER
									</a></span>

									<span id='seeallCreditCustSpan'> <a
										href="javascript:showcreditcustDetailsDataModal()" class="btn-order-taking"
										style="font-size: 12px; margin-left: 1%; text-align: center;">CREDIT CUSTOMERS
									</a></span>
								</div><br>
								<div class="row" style="font-size: 14px; font-weight: bold;text-align:center;display:none;">
								<spring:message code="admin.storecustmgnt.jsp.crpayremark"
												text="Remark" />:
								  <input  type="text" id="creditpayremark" name="CreditPayRemark" value="" style="color:black;"/>
								</div>


								<!-- <div
									style="background: #404040; width: 99%; font-size: 12px; font-weight: bold;">
									 <span class="enable-links" id='addCustSpan'> <a
										href="javascript:addCustDetails()" class="btn-order-taking"
										style="width: 10%; height: 10%; font-size: 12px; margin-left: 1%; text-align: center;">ADD
									</a></span>
								</div> -->

								<input  type="hidden" id="hidcredisalecustid" value="" />

								<div id="creditsalecustdetailcontId"
									style="font-size: 14px; font-weight: bold; margin-top: 5px;text-align: center;"></div>
								<div id="creditsalepaymentdetailcontId"
									style="font-size: 14px; font-weight: bold; margin-top: 5px;text-align: center;"></div>
								<div
									style="display: none; font-size: 14px; font-weight: bold; margin-top: 5px;text-align: center;"
									id="hidcreditsalelastfourdigitcontid">
									Card Last 4 Digit :&nbsp;<input type="text"
										id="creditsalecardlastfourDigit" value="0000"
										style="text-align: center; color: #222222;" size="4" />
								</div>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;text-align: center;"
									id="paycreditsalealertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:payCreditSale();"
								id="creditsalepayButton" disabled="disabled"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.PAY" text="PAY" />
							</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" data-backdrop="static" id="creditcustAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <c:if test="${sessionScope.loggedinStore.id !=87}">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.storecustmgnt.jsp.addCustomer" text="Add Customer" /></h4>
                                            </c:if>
                                            <c:if test="${sessionScope.loggedinStore.id ==87}">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.storecustmgnt.jsp.addStaff" text="Add Staff" /></h4>
                                            </c:if>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
								<table>
									<tr>
										<td><spring:message code="admin.storecustmgnt.jsp.name"
												text="NAME" /> <span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<!-- <td style="margin-bottom: 3px;"><input type="text"
											id="addstorecustnameContId" onkeypress='return lettersOnlyCreditCust(event)'
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
											<td style="margin-bottom: 3px;"><input type="text"
											id="addstorecustnameContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.contactNo" text="CONTACT NO" />
											<span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="addstorecustcontactContId" maxlength="10"
											style="width: 95%; color: #222222; margin-bottom: 5px;" onkeypress='return isNumberKeyCreditCust(event)'/></td>
									</tr>

									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.emailId" text="EMAIL ID" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustemailContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.location"
												text="LOCATION" /></td>
										<td>:</td>
										<td><input type="text" id="addstorelcustlocation"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.address" text="ADDRESS" /></td>
										<td>:</td>
										<td><textarea id="addstorecustaddressContId" rows="2"
												style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.houseno"
												text="HOUSE NO" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecusthouseno"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.streetno"
												text="STREET NO" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecuststreet"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.custDOB"
												text="DATE OF BIRTH" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustdob"
											style="width: 95%; color: #222222; margin-bottom: 5px;" value=" <fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td> <%-- --%>
									</tr>

									<tr>
										<td><spring:message code="order.jsp.custAnniversary"
												text="ANNIVERSARY DATE" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustanniversarydate"
											style="width: 95%; color: #222222; margin-bottom: 5px;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td>  <%-- --%>
									</tr>
									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.creditLimmit"
												text="CREDIT LIMIT" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustcrlimitContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>


								</table>
								<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addstorecustalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelCreditCustomer()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.storecustmgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addCreditCustomer()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.storecustmgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

               <!-- new modal start     -->
           <div class="modal fade" data-backdrop="static" id="creditCustomerListModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.CREDITCUSTOMERDATA" text="CREDIT CUSTOMER DATA" />


							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div id="creditcustomerdetailsdata"  style="width: 100%; height:400px; overflow-y: scroll;">



							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>
			 <!-- new modal end     -->

                         <div class="modal fade" data-backdrop="static" id="alertcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="catdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.storecustmgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>


			<div class="modal fade" data-backdrop="static" id="paxModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.EnterNoOfPax"
									text="Enter No Of Pax" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="order.jsp.NoOfPax" text="No Of Pax" />
								: <input type="text" id="noofPax" size="4" onkeypress="return isNumberKey(event)"
									style="text-align: center; color: #222222;" />
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="paxalertMsg"></div>
							</div>
							<div align="center" style="font-size: 20px;">
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
									<table class="ui-bar-a" id="n_keypad_px"
										style="display: none; -khtml-user-select: none;">
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero7_px">7</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero8_px">8</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero9_px">9</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-danger btn-lg" id="del_px">x</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero4_px">4</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero5_px">5</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero6_px">6</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-warning btn-lg" id="clear_px">c</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero1_px">1</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero2_px">2</a></td>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numero3_px">3</a></td>
											<td><a data-role="button" data-theme="e"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="numerodot_px">&nbsp;.</a></td>
										</tr>
										<tr>
											<td><a data-role="button" data-theme="b"
												style="border: 2px solid #404040;"
												class="btn btn-primary btn-lg" id="zero_px">0</a></td>
											<td colspan="4"><a data-role="button"
												style="border: 2px solid #404040; width: 184px;"
												data-theme="done" class="btn btn-success btn-lg"
												id="done_px"><spring:message code="order.jsp.CANCEL"
														text="CANCEL" /></a></td>
										</tr>
									</table>
								</c:if>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								onclick="javascript:addnoofPax(document.getElementById('noofPax').value)"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.SAVE" text="SAVE" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="changeTableModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background:#939393;color:#fff;border-bottom:1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.ChangeTable" text="Change Table" />
							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div>
									<spring:message code="order.jsp.TABLENO" text="TABLE NO" />
									<select id="changetableId"
										style="padding: 5px 0 5px 0; color: #222222;">
										<c:forEach items="${sessionScope.TableList}" var="tablelist">
											<option value="${tablelist.tableNo}~${tablelist.isBooked}">${tablelist.tableNo}</option>
										</c:forEach>
									</select>
								</div>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="changetablealertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								onclick="javascript:updateTableNo(document.getElementById('changetableId').value)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="splitBillModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.SPLITBILL" text="SPLIT BILL" />
								<input type="hidden" id="splitbillId"
									value="${orders.orderBill.id}"> <span
									style="float: right;"><spring:message
										code="order.jsp.ORDERNO" text="ORDER NO" />: <span
									id="splitbillmodOrderCont" class="hide">00</span><span
									id="splitbillmodStoreBaseOrderCont">00</span>
									</span> <span
									style="float: right;"><spring:message
										code="order.jsp.TABLENO" text="TABLE NO" />: <span
									id="splitbillmodTabCont">00</span>&nbsp;&nbsp;&nbsp; </span>

							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">

								<div style="padding: 3px;">
									<spring:message code="order.jsp.NOOFBILL" text="NO OF BILL" />
									:&nbsp; <input type="text" value="" id="noofsplitBill"
										style="text-align: center; color: #222222" size="4" />
									<button type="button" id="noofBillCreatedWithoutPax"
										onclick="javascript:showSplitBillContent(document.getElementById('noofsplitBill').value,${sessionScope.loggedinStore.id})"
										style="width: 15%; background: #72BB4F; font-weight: bold;"
										class="btn btn-success">
										<spring:message code="order.jsp.SPLIT" text="SPLIT" />
									</button>
								</div>
								<c:choose>
                                       <c:when test="${sessionScope.loggedinStore.id == 37 || sessionScope.loggedinStore.id == 38 || sessionScope.loggedinStore.id == 111 || sessionScope.loggedinStore.id == 126}">
                                           <div class="row">
										<label class="radio-inline"> <input name="radioGroup"
											id="splitbillitemwise" checked="checked" value="1"
											type="radio"> <spring:message
												code="order.jsp.ItemWise" text="Item Wise" />
										</label> <label class="radio-inline"> <input name="radioGroup"
											id="splitbillcategorywise" value="2" type="radio"> <spring:message
												code="order.jsp.CategoryWise" text="Category Wise" />

										</label>
									    </div>
                                                                  
                                       </c:when>
                                      <c:otherwise>
                                          	<div class="row" >
										<label class="radio-inline"> <input name="radioGroup"
											id="splitbillitemwise" value="1" type="radio"> <spring:message
												code="order.jsp.ItemWise" text="Item Wise" />
										</label> <label class="radio-inline"> <input
											name="radioGroup" id="splitbillcategorywise"
											checked="checked" value="2" type="radio"> <spring:message
												code="order.jsp.CategoryWise" text="Category Wise" />
										</label>
									</div>
                                      </c:otherwise>
                                     </c:choose>
								
								
								
								
								<%-- <c:if
									test="${sessionScope.loggedinStore.id == 37 || sessionScope.loggedinStore.id == 38 || sessionScope.loggedinStore.id == 111 || sessionScope.loggedinStore.id == 126}">
									<div class="row">
										<label class="radio-inline"> <input name="radioGroup"
											id="splitbillitemwise" checked="checked" value="1"
											type="radio"> <spring:message
												code="order.jsp.ItemWise" text="Item Wise" />
										</label> <label class="radio-inline"> <input name="radioGroup"
											id="splitbillcategorywise" value="2" type="radio"> <spring:message
												code="order.jsp.CategoryWise" text="Category Wise" />

										</label>
									</div>
								</c:if>
 --%>
								<%-- <c:if
									test="${sessionScope.loggedinStore.id!=37 || sessionScope.loggedinStore.id!=38 || sessionScope.loggedinStore.id!=111 || sessionScope.loggedinStore.id==126}">
									<div class="row" >
										<label class="radio-inline"> <input name="radioGroup"
											id="splitbillitemwise" value="1" type="radio"> <spring:message
												code="order.jsp.ItemWise" text="Item Wise" />
										</label> <label class="radio-inline"> <input
											name="radioGroup" id="splitbillcategorywise"
											checked="checked" value="2" type="radio"> <spring:message
												code="order.jsp.CategoryWise" text="Category Wise" />
										</label>
									</div>
								</c:if>

 --%>								<div id="splitBillContainerId"
									style="font-size: 14px; max-height: 350px; overflow-y: auto;">

								</div>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="paycashalertMsg"></div>
							</div>

							<!-- <div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="splitbillalertMsg"></div> -->
							<div id="splitbillalertMsg"></div>
						</div>

						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="submitSplitBillBut"
								onclick="javascript:submitSpliBill(document.getElementById('noofsplitBill').value,${sessionScope.loggedinStore.id})"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.SUBMIT" text="SUBMIT" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="splitBillItemListModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.OrderItems" text="Order Items" />
							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 14px;">
								<div class="table-responsive" id="splitBillItemListContId">

								</div>
							</div>
							<div class="modal-footer"
								style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
								<button type="button"
									style="width: 25%; background: #F60; font-weight: bold;"
									class="btn btn-warning" data-dismiss="modal">
									<spring:message code="order.jsp.CANCEL" text="CANCEL" />
								</button>
								<button type="button" onclick="javascript:addItemToSplitBill()"
									style="width: 25%; background: #72BB4F; font-weight: bold;"
									class="btn btn-success">
									<spring:message code="order.jsp.OK" text="OK" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="splitBillItemListModalcatwise" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.OrderItems" text="Order Items" />
							</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 14px;">
								<div class="table-responsive"
									id="splitBillItemListContIdcatwise"></div>
							</div>
							<div class="modal-footer"
								style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
								<button type="button"
									style="width: 25%; background: #F60; font-weight: bold;"
									class="btn btn-warning" data-dismiss="modal">
									<spring:message code="order.jsp.CANCEL" text="CANCEL" />
								</button>
								<button type="button"
									onclick="javascript:addItemToSplitBillcatwise()"
									style="width: 25%; background: #72BB4F; font-weight: bold;"
									class="btn btn-success">
									<spring:message code="order.jsp.OK" text="OK" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="changeAmtModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Success" text="Success" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div style="padding: 5px;">
									<spring:message code="order.jsp.AMOUNTTOPAY"
										text="AMOUNT TO PAY" />
									:&nbsp;<span id="cashamttopaymodcontId">0.00</span>
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.TENDERAMOUNT"
										text="TENDER AMOUNT" />
									:&nbsp;<span id="cashtenderAmtmodcontId">0.00</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.CHANGEAMOUNT"
										text="CHANGE AMOUNT" />
									:&nbsp;<span id="cashchangeamtmodcontId">0.00</span>
								</div>

							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="location.href='${pageContext.request.contextPath}/table/viewtable.htm'"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade in" data-backdrop="static"
				id="printBillReasonModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Reason : <input type="text" id="printbillreasonId"
									style="color: black;" value=""> <input type="hidden"
									id="printbillcount" value="0">
							</div>
							<div id="printbillresonreq" class="hide" style="color: red;"
								align="center">reason required.</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								onclick="printBillCountt(document.getElementById('printbillcount').value);"
								class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="noOrderRecordsFoundModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								No records found.
								<%-- 								<spring:message code="order.jsp.KOTChecklisthasbeensuccessfullyprinted" text="KOT Checklist has been successfully printed" />! --%>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" data-backdrop="static"
				id="kotchecklistPrintSuccessModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.success" text="Success" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="hidden" id="hiddmanualeditItemId" value="">
								<spring:message
									code="order.jsp.KOTChecklisthasbeensuccessfullyprinted"
									text="KOT Checklist has been successfully printed" />
								!
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" data-backdrop="static" id="manualqtyModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.EnterNoOfQty"
									text="Enter No Of Qty" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">

							<div align="center" style="font-size: 20px;">
								<input type="text" id="kepadmanQty" value="" size="4"
									style="text-align: center; color: #222222;"> <br />
								<table class="ui-bar-a" id="n_keypad_man"
									style="display: none; -khtml-user-select: none;">
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero7_man">7</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero8_man">8</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero9_man">9</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-danger btn-lg del_man">x</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero4_man">4</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero5_man">5</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero6_man">6</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-warning btn-lg clear_man">c</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero1_man">1</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero2_man">2</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numero3_man">3</a></td>
										<!-- <td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg numerodot_man">&nbsp;.</a></td> -->
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg zero_man">0</a></td>

										<td colspan="4"><a onclick="javascript:setQty()"
											data-role="button"
											style="border: 2px solid #404040; width: 184px;"
											data-theme="done" class="btn btn-success btn-lg done_man"><spring:message
													code="order.jsp.OK" text="OK" /></a></td>


									</tr>
								</table>
								<div id="enterQtyAlert"></div>
							</div>
						</div>

						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:closeCancel()"
								style="background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<!-- <button type="button" onclick="javascript:addnoofPax(document.getElementById('noofPax').value)" style="background: #72BB4F;font-weight: bold;" class="btn btn-success">DONE</button> -->
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="itemnotfoundModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">

								<spring:message code="order.jsp.itemnotfound"
									text="Item not found against this code, please add the item first." />
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>




			<div class="modal fade" data-backdrop="static"
				id="cashhelloPrintModal80" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">

					<div class="modal-body" id="printDiv80"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> --%>

						<div
							style="text-align: center; width: 230px; font-size: 20px; color: #000000">

							<b><font style="font-size: 18px; font-style: inherit; font-family: sans-serif;">
							<div id="storeName80">${sessionScope.loggedinStore.storeName}</div></font></b>
							<c:if test="${sessionScope.loggedinStore.id==126}">
								<b><font
									style="font-size: 10px; font-style: normal; font-family: sans-serif;">A
										UNIT OF SAPPHIRE CAFE LLP</font></b>
							</c:if>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="storeAddr80">${sessionScope.loggedinStore.address}</div></font></b>
								<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
								<div id="storeEmail80"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div>
								</font>
								<div id="storeWeb80"><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><spring:message code="order.jsp.Web" text="Website" /> :${sessionScope.loggedinStore.url}</font></div>
								<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="storePhNo80"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>

							<%-- <div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmail80"></div>
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="storePhNo80"></div>
							</div> --%>

							<div id="paidgstdata" style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">

							</div>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="cashOrdervalue80" style="font-weight:bold">00</span>
							</div>


							<div
										style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" /> --%>
										<b>Date :</b> <span  id="cashOrderdate80">00<%-- <fmt:formatDate
												pattern="yyyy-MM-dd" value="${parsedInvDate}" /> --%></span>
									</div>

							<%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="orderType_80px">${orders.ordertype.orderTypeName}</span>
							</div> --%>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno80px">
								<%-- <spring:message code="order.jsp.TableNo" text="Table No:" /> --%>
								<b><span id="cashtableNoValue80">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId_80">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">

									<thead>
										<tr>
											<th style="font-size: 11px; width: 102px;"><span
												style="float: left; font-family: sans-serif;"><spring:message
														code="order.jsp.Items" text="Items" /></span></th>
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
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message
											code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashtotalamt80">00</span></td>
								</tr>
								<tr id="cashshowDiscount80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> (<span id="paidbilldiscpers"></span>%) :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashdiscountValue80">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge80px" class="serviceCharge80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}<span id="cashservChrgDisc80">00</span>:
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;">
										<span id="cashservChrg80">00</span>
									</td>
								</tr>

								<tr id="cashtotalServiceTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashservTax80">00</span></td>
								</tr>

								<tr id="cashtotalVatTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%)
										: :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashvatTax80px">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" /> :</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashgrossAmount80">00</span></b></td>
								</tr>

								

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashamoutToPay80">00</span></b></td>
								</tr>

								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="paidAmount80">00</span></b></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmount80">00</span></b></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundAmount80">00</span></b></td>
								</tr>



								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>
                                 <tr id="cusnametr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Name:</td>
									<td id="cusname80" style="text-align: left;"></td>
								</tr>
								 <tr id="cusphnotr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Ph No:</td>
									<td id="cusphno80" style="text-align: right;"></td>
								</tr>
                                  <tr id="cusaddresstr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Address:</td>
									<td id="cusaddress80" style="text-align: right;"></td>
								</tr>
                                   <tr id="cuslocationtr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Location:</td>
									<td id="cuslocation80" style="text-align: right;"></td>
								</tr>
                                  <tr id="cusstreettr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Street:</td>
									<td id="cusstreet80" style="text-align: right;"></td>
								</tr>
                                   <tr id="cushousenotr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >House No:</td>
									<td id="cushouseno80" style="text-align: right;"></td>
								</tr>

                                   <tr id="deliveryboytr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Dlv By:</td>
									<td id="deliveryboy80" style="text-align: right;"></td>
								</tr>

							</table>
							<div style="text-align: center;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><span
										id="payType80"></span></font></b>
							</div>
							<div style="text-align: center;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.**Thank You. Visit Again"
										text="**Thank You. Visit Again" />**</font>
							</div>
						</div>
						<div class="modal-footer" id="cashRemovePrint80"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button"
								onclick="javascript:printCashOrCardLocal80()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="printBtn_80">
								<spring:message code="order.jsp.PRINT" text="PRINT" />
							</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>


				</div>
			</div>


			<div class="modal fade" data-backdrop="static" id="helloPrintModal58"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 200px; height: auto;">


					<div class="modal-body" id="printDiv58"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<div
							style="text-align: center; height: auto; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">


							<%-- <div style="text-align: center; width: 230px;">
								<input type="image"	src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
							</div> --%>


							<b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							    <div id="storeName58">${sessionScope.loggedinStore.storeName}</div></font></b> <b>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							   <div id="storeAddr58">${sessionScope.loggedinStore.address}</div></font></b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							   <div id="storeEmail58"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							    <div id="storePhNo58"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font><br>

							<%-- <div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmail58"></div>
							</div>
							<div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b> <div id="storePhNo58"></div>
							</div> --%>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="orderValue58" style="font-weight:bold">00</span>
							</div>
                              <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Date :</b><span id="cashOrderdate58">00</span>
							</div>
                           <%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="orderType_58px">${orders.ordertype.orderTypeName}</span>
							</div> --%>

							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno">
								<%-- <spring:message code="order.jsp.TableNo"
										text="Table No :" /> --%>
										 <b><span id="tableNoValue58">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId_58">

								<table
									style="color: #000000; border: none; height: 50px; width: 130px;">

									<thead>

										<th style="font-size: 10px; width: 30px;"><span
											style="float: left; font-family: sans-serif;"><spring:message
													code="order.jsp.Items" text="Items" /></span></th>
										<th
											style="text-align: center; font-size: 10px; font-family: sans-serif;"><spring:message
												code="order.jsp.Qty" text="Qty" /></th>
										<th
											style="text-align: right; font-size: 10px; font-family: sans-serif;"><spring:message
												code="order.jsp.Rate" text="Rate" /></th>
										<th
											style="text-align: right; font-size: 10px; font-family: sans-serif;"><spring:message
												code="order.jsp.Total" text="Total" /></th>

									</thead>

									<tbody style="color: #000000; padding: 1px;"
										id="itemDetailsPrint58"></tbody>

								</table>

							</div>

							<div style="text-align: right; width: 150px;">--------------------</div>

							<table style="height: 50px; width: 150px;">

								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message
											code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id=totalAmt58>00</span></td>
								</tr>
								<tr id="totalServiceChrg_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}(${orders.orderBill.serviceChargeRate}%):
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servChrg58">00</span></td>
								</tr>

								<tr id="totalServiceTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servTax58">00</span></td>
								</tr>

								<tr id="totalVatTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="vatTax58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="grossAmount58">00</span></b></td>
								</tr>
								<tr id="showDiscount_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="discountValue58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="amoutToPay58">00</span></b></td>
								</tr>
								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>



								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="paidAmount58">00</span></b></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmount58">00</span></b></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundAmount58">00</span></b></td>
								</tr>



								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>
							</table>
							<div style="text-align: left; width: 150px;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><div
											id="payType58"></div></font></b>
							</div>
							<div style="text-align: left; width: 150px;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.ThankYouVisitAgain"
										text="**Thank You. Visit Again" /></font>
							</div>
						</div>
					</div>
					<div class="modal-footer" id="removePrint58"
						style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
						<button type="button"
							onclick="javascript:printCashOrCardLocal58()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success" id="printBtn_58">
							<spring:message code="order.jsp.PRINT" text="PRINT" />
						</button>
						<button type="button" onclick="return false"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">
							<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						</button>
					</div>
				</div>
			</div>
			<!-- modal end -->


			<div class="modal fade" data-backdrop="static"
				id="cashhelloPrintModal2100" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">

					<div class="modal-body" id="printDiv2100"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">


						<div
							style="text-align: center; width: auto; font-size: 20px; color: #000000">

							<b><font style="font-size: 19px; font-style: inherit; font-family: sans-serif;">
								<div id="storeName2100">${sessionScope.loggedinStore.storeName}</div></font></b> <b>
								<font style="font-size: 17px; font-style: normal; font-family: sans-serif;">
								<div id="storeAddr2100">${sessionScope.loggedinStore.address}</div></font></b>
								<font style="font-size: 15px; width: auto; font-style: inherit; font-family: sans-serif;">
								<div id="storeEmail2100"></div><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</font>
								<font style="font-size: 15px; width: auto; font-style: normal; font-family: sans-serif;">
								<div id="storePhNo2100"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>${sessionScope.loggedinStore.mobileNo}</div></font><br>

							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No:</b> <span id="cashOrdervalue2100">00</span>
							</div>

								 <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Date :</b><span id="cashOrderdate2100">00</span>
							</div>

                       <%-- <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="orderType_2100px">${orders.ordertype.orderTypeName}</span>
							</div> --%>

							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b><span id="cashtableNoValue2100">00</span></b>
							</div>
							<div style="text-align: left;">-------------------------------------------------------------------------------------------------------</div>

							<div class="table-responsive" id="orderitemContId_2100">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">

									<thead>
										<tr>
											<th style="font-size: 15px; width: 102px;"><span
												style="float: left; font-family: sans-serif;">Item</th>
											<th
												style="width: 110px; float: right; padding-right: 120px; text-align: center; font-size: 15px; font-family: sans-serif;">Qty</th>
											<th
												style="width: 110px; padding-right: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">Rate</th>
											<th
												style="width: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">Amt</th>
										</tr>
									</thead>


									<tbody style="color: #000000; padding: 1px;"
										id="itemDetailsPrint2100"></tbody>

								</table>
							</div>


							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<table style="height: 50px; width: 100%;">

								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">TOTAL
										AMOUNT:</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashtotalamt2100">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										${sessionScope.loggedinStore.serviceChargeText}:</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<span id="cashservChrg2100">00</span>
									</td>
								</tr>

								<tr id="cashtotalServiceTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Service Tax(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashservTax2100">00</span></td>
								</tr>

								<tr id="cashtotalVatTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Vat(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashvatTax2100px">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashgrossAmount2100">00</span></b></td>
								</tr>

								<tr id="cashshowDiscount2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										TOTAL DISCOUNT:</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashdiscountValue2100">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">AMOUNT
												TO PAY:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashamoutToPay2100">00</span></b></td>
								</tr>
							</table>

							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<table style="height: 50px; width: 100%;">

								<tr>
									<td id="paid_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount2100">00</span></b></td>
								</tr>

								<tr>
									<td id="tender_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Tender
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="tenderAmount2100">00</span></b></td>
								</tr>

								<tr>
									<td id="refund_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund
												Amount:</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b>
											<span id="refundAmount2100"><fmt:formatNumber
													type="number" value="${invPurchaseOrderItem.oldStock}"
													maxFractionDigits="2" />00</span>
									</b></td>
								</tr>



							</table>

							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<div style="text-align: center;">
								<b><font style="font-size: 15px; font-family: sans-serif;"><span
										id="payType2100"></span></font></b>
							</div>
							<div style="text-align: center;">
								<font style="font-size: 16px; font-family: sans-serif;">Thank
									You. Visit us Again</font>
							</div>
						</div>
						<div class="modal-footer" id="cashRemovePrint2100"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button"
								onclick="javascript:printCashOrCardLocal2100()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="printBtn_80">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div>
					</div>


				</div>
			</div>

						<div class="modal fade" data-backdrop="static" id="alertdeliveryboydataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="deliveryboydataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:selectOderNo()"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

			<div class="modal fade" data-backdrop="static" id="AssignDelBoyModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="header.jsp.AssignDelBoyModule"
									text="Assign Delivery Boy" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="header.jsp.delboyName"
									text="Delivery Boy Name" />
								: <select id="deliveryboyName"  onchange="javascript:selectDelBoy()" style="margin-bottom: 2px; color: #222222;"></select>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold; margin-top: 20px;"
									id="assigndelboyalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
							onclick="javascript:closeAssignDeliveryBoyModal()"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="header.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								onclick="javascript:assignDeliveryBoy()"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="header.jsp.ASSIGN" text="ASSIGN" />
							</button>
						</div>
					</div>
				</div>
			</div>

<!-- for unpaid bill or not fully paid bill 2100 without GST -->
			<div class="modal fade" data-backdrop="static"
				id="helloPrintModal_2100px" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="localPrint_2100px"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">

							<b><font
								style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
							<b><font
								style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Email :</b> ${sessionScope.loggedinStore.emailId}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No / Invoice :</b> <span id="ordervalue_2100px">00</span>
							</div>
							<%-- <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="orderType_2100px">${orders.ordertype.orderTypeName}</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Table No :</b> <span id="tableNoValue_2100px">00</span>
							</div> --%>
							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
							<b><span id="unpaidtableNoValue2100">00</span></b>
							</div>

							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<div class="table-responsive" id="orderitemContId">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">
									<c:if test="${! empty orders}">
										<thead>
											<th style="font-size: 15px; width: 102px;"><span
												style="float: left; font-family: sans-serif;">Items</span></th>
											<th
												style="width: 110px; float: right; padding-right: 120px; text-align: center; font-size: 15px; font-family: sans-serif;">QTY</th>
											<th
												style="width: 110px; padding-right: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">RATE</th>
											<th
												style="width: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">TOTAL</th>

										</thead>

										<tbody style="color: #000000; padding: 1px;">
											<!-- <tr>
					<td style="width: 100% !important">1--------------------------------------------------------------------------------------------------------------</td>
					<td></td>
					</tr> -->
											<c:forEach items="${orders.orderitem }" var="orderitems"
												varStatus="stat">
												<c:set var="bgCol" value="#ffffff"></c:set>
												<c:if
													test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
													<c:set var="bgCol" value="#1c91bc"></c:set>

												</c:if>
												<tr style="padding: 2px;">
													<%-- <td style="padding: 1px; text-align: center;">
																${stat.index+1}</td> --%>
													<td
														style="padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 15px; font-family: sans-serif;">
														<%-- <c:choose>
															<c:when test="${orderitems.ordertype==2}">--%>

																<%--   ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
															        <%--${orderitems.item.name}(P)
                                							</c:when>
															<c:otherwise>--%>
																<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                                										  ${orderitems.item.name}
                                							<%--</c:otherwise>
														</c:choose>--%>
													</td>
													<td valign="middle"
														style="float: right; font-size: 15px; font-family: sans-serif; padding-right: 170px; text-align: center">
														${orderitems.quantityOfItem}</td>
													<td
														style="font-size: 15px; font-family: sans-serif; padding-right: 110px; text-align: center"><fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.item.price}"></fmt:formatNumber></td>
													<td
														style="padding: 1px; font-family: sans-serif; text-align: center; font-size: 15px"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(orderitems.item.price-orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.item.price}"></fmt:formatNumber>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
									<c:if test="${empty orders}">
										<thead>

											<th>NAME</th>
											<th style="text-align: center;">QUANTITY</th>
											<th>RATE</th>
											<th>TOTAL</th>

										</thead>
										<tbody style="color: #fff; padding: 1px;">
										</tbody>
									</c:if>
								</table>
							</div>
							<div style="">-------------------------------------------------------------------------------------------------------</div>

							<table style="height: 50px; width: 100%;">
								<tr id="showDiscount_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
										id="discountTxt_2100px">00</span></td>
									<td
										style="text-align: right; font-size: 14px; font-family: sans-serif;"><span
										id="discountValue_2100px">00</span></td>
								</tr>
								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Amount :</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="totalamt_2100px">00</span></td>
								</tr>

								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Service Tax :</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="servTax_2100px">00</span></td>
								</tr>

								<tr id="totalVatTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
										Vat :</td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="vatTax_2100px">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
												Amount :</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="grossAmount_2100px">00</span></b></td>
								</tr>
								 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount_2100px">00</span></b></td>
								 </tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_2100px">00</span></b></td>
								</tr>
								<!-- <tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr> -->

							</table>
							<c:if test="${! empty orders.customerName}">
								<div style="">---------------------------------------------------------------------------------------------------------</div>
							</c:if>
							<table style="height: 50px; width: 100%;">
								<c:if test="${! empty orders.customerName}">
									<tr id="showcustomerNameDiv_2100px">
										<td
											style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
											id="showcustomerNameTxt_2100px">Cust Name : </span></td>
										<td style="font-size: 15px; font-family: sans-serif;"><span
											id="showcustomerNameValue_2100px">${orders.customerName}</span></td>
									</tr>
								</c:if>
								<c:if test="${! empty orders.customerContact}">
									<tr id="showcustomerContactDiv_2100px">
										<td
											style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
											id="showcustomerContactTxt_2100px">Cust Ph : </span></td>
										<td style="font-size: 15px; font-family: sans-serif;"><span
											id="showcustomerContactValue_2100px">${orders.customerContact}</span></td>
									</tr>
								</c:if>
								<c:if test="${! empty orders.deliveryAddress}">
									<tr id="showdeliveryAddressDiv_2100px">
										<td
											style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
											id="showdeliveryAddressTxt_2100px">Address : </span></td>
										<td style="font-size: 15px; font-family: sans-serif;"><span
											id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span></td>
									</tr>
								</c:if>
								<c:if test="${! empty orders.deliveryPersonName}">
									<tr id="showdeliveryPersonNameDiv_2100px">
										<td
											style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
											id="showdeliveryPersonNameTxt_2100px">Del Person Name
												: </span></td>
										<td style="font-size: 15px; font-family: sans-serif;"><span
											id="showdeliveryPersonNameValue_2100px">${orders.deliveryPersonName}</span></td>
									</tr>
								</c:if>


							</table>

							<div style="">--------------------------------------------------------------------------------------------------------</div>

							<div style="text-align: center;">
								<font style="font-size: 16px; font-family: sans-serif;">*****Thank
									You. Visit us Again*****</font>
							</div>
						</div>
						<div class="modal-footer" id="removePrint_2100px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint_2100px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div>
					</div>
				</div>
			</div>


<div class="modal fade" data-backdrop="static" id="alertalreadypaidModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.invtypemgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="alreadypaidmsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/table/viewtable.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.invtypemgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
			<!-- modal end -->
			
			
             <!-- modal added for display current qty and negetive billing etc -->
            <!--Item Current Qty Modal Start-->
	<div class="modal fade" data-backdrop="static" id="itemCurrentStockModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
                                <input type="text" id="itIdData" style="display:none;" value=""/>
								<input type="text" id="itNameData" style="display:none;" value=""/>
								<input type="text" id="itPriceData" style="display:none;" value=""/>
								<input type="text" id="discData" style="display:none;" value=""/>
								<input type="text" id="vatData" style="display:none;" value=""/>
								<input type="text" id="serviceTaxData" style="display:none;" value=""/>
								<input type="text" id="promoFlagData" style="display:none;" value=""/>
								<input type="text" id="promoValueData" style="display:none;" value=""/>
								<input type="text" id="isKotPrintData" style="display:none;" value=""/>
								<spring:message code="order.jsp.currentstockofitem"
									text="Available Stock Of Item" />&nbsp;
								   <span id="itmName"></span>&nbsp;
								   <spring:message code="order.jsp.is"
									text=" Is:" />&nbsp;&nbsp;
								    <span id="itmcurstck"></span>
								    
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="addOrUpdateOrderItems(document.getElementById('itIdData').value,document.getElementById('itNameData').value,document.getElementById('itPriceData').value,document.getElementById('discData').value,document.getElementById('vatData').value,document.getElementById('serviceTaxData').value,document.getElementById('promoFlagData').value,document.getElementById('promoValueData').value,document.getElementById('isKotPrintData').value);" id="itmSaleBtn"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								class="btn btn-success">
								<spring:message code="order.jsp.Sale" text="SALE" />
							</button>
							<button type="button" onclick="clearItemCodeSearch()"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.close" text="CLOSE" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
		
	<!-- Item Current Qty Modal End -->
	<div class="modal fade" data-backdrop="static" id="msgmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="msgspace"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itmOutOfStockmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					               <input type="text" id="itIdOfOutStckItm" style="display:none;" value=""/>
								   <input type="text" id="itNameOfOutStckItm" style="display:none;" value=""/>
								   <input type="text" id="itPriceOfOutStckItm" style="display:none;" value=""/>
								   <div style="text-align: center; font-size: 20px;" id="msgspace1"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="orderItemQtyIncrease(document.getElementById('itIdOfOutStckItm').value,document.getElementById('itNameOfOutStckItm').value,document.getElementById('itPriceOfOutStckItm').value);" id="itmQtyIncrBtn"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								class="btn btn-success">
								<spring:message code="order.jsp.increase" text="INCREASE" />
							</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itmOutOfStockmodalForManualEntry" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					               <input type="text" id="itIdOfOutStckItmForManualEntry" style="display:none;" value=""/>
								   <input type="text" id="itNameOfOutStckItmForManualEntry" style="display:none;" value=""/>
								   <input type="text" id="itQtyOfOutStckItmForManualEntry" style="display:none;" value=""/>
								   <div style="text-align: center; font-size: 20px;" id="msgspace2"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="enterItemManualQuantity(document.getElementById('itQtyOfOutStckItmForManualEntry').value,document.getElementById('itIdOfOutStckItmForManualEntry').value);" id="itmQtyIncrBtnManually"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								class="btn btn-success">
								<spring:message code="order.jsp.increase" text="INCREASE" />
							</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static"
			id="alerteditOrderquantityModal1" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="hidden" id="hiddmanualeditItmId" value="">
							Please enter a valid number!
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="javascript:setOrderItemQtyManually()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
	
	    <!--remarks modal start  -->
           <div class="modal fade" data-backdrop="static" id="remarksModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.refundRemarks" text="REMARKS" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                        	  <spring:message code="unpaidorder.jsp.Remarks" text="Remarks" />:
                                              <input type="text" id="orderRemarksData" value="" style="color: black;"/>
                                              <br><span id="rmkalert" style="color:red"></span>
                                            </div>
                                            
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <!-- <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:clearRemark()"  class="btn btn-success"><span class="fa fa-eraser"></span></button> -->
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:setRemarks()"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                            <button type="button" style="font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				
                                        </div>
                                    </div>
                                </div>
                            </div>


       <!--remarks modal  end -->
       <div class="modal fade" data-backdrop="static" id="alertDatamodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="alertmsgspace"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
   <!--  <input style="display:none;" type="text" id="orderdetails" value=${odrdetali} /> -->
		</div>

	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<c:if test="${pageContext.response.locale == 'ar'}">
		<script
			src="${pageContext.request.contextPath}/assets/js/lang/baseScript_AR.js"></script>
	</c:if>
	<c:if test="${pageContext.response.locale == 'en'}">
		<script
			src="${pageContext.request.contextPath}/assets/js/lang/baseScript_EN.js"></script>
	</c:if>
	<script
		src="${pageContext.request.contextPath}/assets/js/baseScriptNew.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/json/yahoo-min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/json/json-min.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>

	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->

	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

	<style>
.current {
	background: #939393;
}
</style>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
	var vfdPort="${sessionScope.loggedinStore.customerDisplay}";
	var storeID="${sessionScope.loggedinStore.id}";
	var storeAddr = "${sessionScope.loggedinStore.address}";
	var itcatId="${itcatno}";
	var orderType="${orderType}";
	var currentTable="${currentTable}";
	var softKey="${sessionScope.loggedinStore.softKey}";
	var printpaidBill="${sessionScope.loggedinStore.printPaidBill}";
	var cdrawerCode="${sessionScope.loggedinStore.cashDrawerCode}";
	var displayCurrentStockMenu="${sessionScope.loggedinStore.displayCurrentStockMenu}";
    var SelectedOption="${currentOrderType}";
    var mobBillPrint="${sessionScope.loggedinStore.mobBillPrint}";
	var custId=null;
	var mostPurchasedItemsCount = null;
	var orderVal="${orders.ordertype}";
	var orderDeliveryPerson="${orders.deliveryPersonName}";
	var savedOrderItemCount="${savedOrderItemCount}";
	var calledFromSavedOrder='no';
	var waiterName="${waiterName}";
	var waiterNameFlag="${sessionScope.loggedinStore.waiterNameFlag}";
	var printReason="${sessionScope.loggedinStore.isProvideReason}";
	var smsintegration="${sessionScope.loggedinStore.smsIntegration}";
	var gsttext = "${sessionScope.loggedinStore.gstText}";
	var gstno = "${sessionScope.loggedinStore.gstRegNo}";
	var ordSucc = "${sessionScope.loggedinStore.ordSucc}";
    var storeBasedOrderNumber = "${orders.orderNo}";
    var is_Acc='${is_acc}';
    var displayCurrentStockMenu="${sessionScope.loggedinStore.displayCurrentStockMenu}";
	var negativeStockBilling="${sessionScope.loggedinStore.negativeStockBilling}";
	
	//alert("printReason"+printReason);
	/* if(sessionScope.loggedinStore.waiterNameFlag=='Y'){

		waiterName="${waiterName}";
	} */
	//var tableno="${tableNo}";
	$('.list-group-item.item_sub_child').on('click',function(){
	  $(this).parent().find('.list-group-item.item_sub_child').removeClass('current');
		$(this).addClass('current');
  });
	//for hatim tai
	if(itcatId!=""){
	<c:forEach items="${allmenu.menucategory}" var="menu" varStatus="loop">
	if(itcatId=="${menu.id}")
		{
		$("#"+itcatId).addClass("collapse in");
		$('.list-group-item.item_sub_child').removeClass('current');
		$('.list-group-item.item_sub_child').addClass('current');
		<c:forEach items="${menu.menucategory}" var="submenu" varStatus="loop1">
			clickonSubmenu("${submenu.id}", "${loop.index}");
		</c:forEach>
		}
	</c:forEach>
	}
	instantPaymentOpenModal();

	function selectCustDetails()
	{
		var customerId=document.getElementById('modparcelcustIdhidden').value;
		//alert(customerId);
		if(customerId!=null || customerId!='')
		{
			var orderText="${orderTypeName}";
			document.getElementById('modOrderType').innerHTML=orderText;
			showCustDetailsModal();
			searchCustomer();
		}
	}

	function addCustDetails()
	{

			var orderText="${orderTypeName}";
			document.getElementById('modOrderType').innerHTML=orderText;

			var customerName=document.getElementById('itemNameSearch').value;
			var customerContact=document.getElementById('itemContactSearch').value;


			document.getElementById('modparcelcustName').value=customerName;
			document.getElementById('modparcelcustPhone').value=customerContact;
			showCustDetailsModal();
	}

	 function showcreditcustaddModal()
		{
		   	document.getElementById('addstorecustnameContId').value='';
			document.getElementById('addstorecustcontactContId').value='';
			document.getElementById('addstorecustaddressContId').value='';
			document.getElementById('addstorecustemailContId').value='';
			document.getElementById('addstorecustcrlimitContId').value='';
			document.getElementById('addstorecustalertMsg').innerHTML='';
			$('#creditcustAddModal').modal('show');
		}
	   function closecreditcustaddModal()
		{
			$('#creditcustAddModal').modal('hide');
		}

	 function showDelOptModal()
	{
		//alert('${sessionScope.loggedinStore.parcelAddress}');

		//validateCreateOrder();

		if(validateCreateOrder())
			{
			
			var orderText="${orderTypeName}";
			document.getElementById('modOrderType').innerHTML=orderText;
			var tabNO=document.getElementById('tablenoCont').innerHTML;
			
			// new added 29.4.2019 start
			var customerName =document.getElementById('itemNameSearch').value;
			var customerContact =document.getElementById('itemContactSearch').value;
			if(storeID == 49 && orderText != "Zomato"){ 
				if(customerName == '' ||  customerContact == ''){
					 document.getElementById('alertmsgspace').innerHTML="Please add customer details!!";
					 $('#alertDatamodal').modal('show');
					 return;
				}
			}
			// new added 29.4.2019 end
			
			
			dsblSaveOrder();

			if(tabNO=='0')
			{
				/* if(parcelAdd=='Y' && itcatId=="")
					{
					document.getElementById('PdeliveryOptionParcel').checked=true;
					//$('#ParceldelOptModal').modal('show');
					showCustDetailsModal();
					} */
					if(orderType!="" && itcatId=="")
					{
							if(orderType=='s'){
							document.getElementById('deliveryOptionswiggy').checked=true;
							}
							else if(orderType=='z'){
							document.getElementById('deliveryOptionZomato').checked=true;
							}
							else{
						//alert('deliveryOptionHomedel');
							document.getElementById('deliveryOptionHomedel').checked=true;
							}

							if(parcelAdd=='Y')
							{

							/*
								if(orderVal==null || orderVal=='')
								{
									showCustDetailsModal();
								}
								else {
						//	alert('previous order clubbing');

									showCustDetailsModal();
									calledFromSavedOrder='yes';
									searchCustomer();
								} */
								createOrder();
							}
							else
							{
							//alert('createOrder');
							//$('#delOptModal').modal('show');
							createOrder();
							}

						}
						else
				 		{
						//	showCustDetailsModal();

						/*  if(orderVal==null || orderVal=='')
							{
							showCustDetailsModal();
							}
							else {
							//alert('previous order clubbing' + orderVal);

							showCustDetailsModal();
							calledFromSavedOrder='yes';
							searchCustomer();
							}  */
							//document.getElementById('deliveryOptionParcel').checked=true;
							//$('#delOptModal').modal('show');
							createOrder();
						}
				}
			else
				{

					document.getElementById('deliveryOptionDine').checked=true;
					//for saravanaa
					//$('#delOptModal').modal('show');
					createOrder();
					// end for saravanaa
				}
			//$('#delOptModal').modal('show');
			}
		else
			{
			//alert('Please add any items!');
			$('#alertselectItemModal').modal('show');
			}
	}

	function showOrderModal()
	{
		//alert('order');
		 /* if(itcatId!="")
			{
			var begindivline="<div>"+getBaseLang.pmntOption+" ";
			var htm="<input type='radio' id='instantpayOptionCash' name='instantpayOption' value='cash' checked='checked'>&nbsp;&nbsp;<span style='font-size: 24px;font-weight:bold;'>'"+getBaseLang.cash+"'</span>&nbsp;&nbsp;"+
   			"<input type='radio' id='instantpayOptionCard' name='instantpayOption' value='card' >&nbsp;&nbsp;<span style='font-size: 24px;font-weight:bold;'>"+getBaseLang.card+"</span>";
   			var enddivline="</div>";
   			document.getElementById("instantPaycontId").innerHTML=begindivline+htm+enddivline;
			}  */
		$('#orderModal').modal('show');
	}
	function showCashModal()
	{
		//alert('order');
		$('#cashModal').modal('show');
		$('#cashModal').on('shown.bs.modal', function () {
    	$('#cashtenderAmt').focus();});
	}
	function showCardModal()
	{
		//alert('order');
		$('#cardModal').modal('show');
		/* $('#cardModal').on('shown.bs.modal', function () {
	    $('#cardlastfourDigit').focus();}); */
	}
	function hideCashModal()
	{
		//alert('order');
		$('#cashModal').modal('hide');
	}
	function hideCardModal()
	{
		//alert('order');
		$('#cardModal').modal('hide');
	}

	function showdirectOrderModal()
	{
		$('#directOrderModal').modal('show');
	}
	function showprintBillReasonModal()
	{
		$("#printBillReasonModal").modal("show");
	}
	function showspecialnoteModal()
	{
		$('#specialnoteModal').modal('show');
	}
	function showalertsaveorderModal()
	{
		$('#alertsaveOrderModal').modal('show');
	}
	function showselectitemalertModal()
	{
		$('#alertselectItemModal').modal('show');
	}
	function showconfirmdeleteOrderItemModal()
	{
		$('#confirmdeleteorderitemModal').modal('show');
	}
	function showparcelPaymentModal()
	{
		$('#parcelpayOptModal').modal('show');
	}
	function showaddDiscountModal()
	{
		$('#discountModal').modal('show');
	}
	function closeaddDiscountModal()
	{
		$('#discountModal').modal('hide');
	}
	function showalerteditOrderQuantityModal(id)
	{
		document.getElementById('hiddmanualeditItemId').value=id;
	  	$('#alerteditOrderquantityModal').modal('show');
	}
	function showCustDetailsModal()
	{

		$('#parcelCustDetailsModal').modal('show');
	}
	function showBillPrintSuccessModal()
	{
		$('#billPrintSuccessModal').modal('show');
	}
	function helloBillPrint()
	{
		$('#helloPrintModal').modal('show');
	}
	function printKotForPos()
	{
		$('#printingkot').modal('show');
	}
	function showspecialNoteforOrderModal()
	   {
		   $('#specialnoteforOrderModal').modal('show');
	   }
	function closespecialNoteforOrderModal()
	   {
		   $('#specialnoteforOrderModal').modal('hide');
	   }
	function showCreditSaleModal()
	{
		//alert('order');
		$('#creditsaleModal').modal('show');
	}
	function hideCreditSaleModal()
	{
		//alert('order');
		$('#creditsaleModal').modal('show');
	}

	 function showalertcatdataopModal()
		{
			$('#alertcatdataopModal').modal('show');
		}

	function openPaxModal()
	{
		//alert('order');
		var tabNO=document.getElementById('tablenoCont').innerHTML;
		if(tabNO!='0')
			{
			document.getElementById('noofPax').value="";
			document.getElementById('paxalertMsg').innerHTML="";
			$('#paxModal').modal('show');
			}

	}
	function closePaxModal()
	{
		//alert('order');
		$('#paxModal').modal('hide');
	}

	function openChangeTableModal()
	{
		document.getElementById('changetablealertMsg').innerHTML='';
		$('#changeTableModal').modal('show');
	}
	function closeChangeTableModal()
	{
		$('#changeTableModal').modal('hide');
	}
	function showsplitBillModal()
	{
		//alert('order');
		$('#splitBillModal').modal('show');
	}
	function hidesplitBillModal()
	{
		//alert('order');
		$('#splitBillModal').modal('hide');
	}
	function showsplitBillItemListModal()
	{
		//alert('order');
		$('#splitBillItemListModal').modal('show');
	}
	function hidesplitBillItemListModal()
	{
		//alert('order');
		$('#splitBillItemListModal').modal('hide');
	}

	function showsplitBillItemListModalcatwise()
	{
		//alert('order');
		$('#splitBillItemListModalcatwise').modal('show');
	}
	function hidesplitBillItemListModalcatwise()
	{
		//alert('order');
		$('#splitBillItemListModalcatwise').modal('hide');
	}
	function showCashChangeAmtModal()
	{
		//alert('order');
		$('#changeAmtModal').modal('show');
	}
	function showKotCheckListPrintSuccessModal()
	{
		$('#kotchecklistPrintSuccessModal').modal('show');
	}
	function showSplitPaymentCashModal()
	{
		//alert('order');
		$('#cashSplitPaymentModal').modal('show');
	}
	function hideSplitPaymentCashModal()
	{
		//alert('order');
		$('#cashSplitPaymentModal').modal('hide');
	}

	function showaddServiceChargeModal()
    {
       $('#serviceChargeModal').modal('show');
    }
	function closeaddServiceChargeModal()
	{
		$('#serviceChargeModal').modal('hide');
	}
	function openRemarksModal(){
		//document.getElementById('orderRemarksData').value="";
		document.getElementById('orderRemarksData').value = document.getElementById('orderRmks').value;
		document.getElementById('rmkalert').innerHTML ="";
		$('#remarksModal').modal('show');
	}
	function clearRemark(){
		document.getElementById('orderRemarksData').value  = "";
	}
	</script>
	<script type="text/javascript">

	 $(document).ready(function() {
              if (is_Acc=='Y') {
          	    getvendorledger_sale($('#dueties_and_tax_accf').val(),0,0,0); // for duties and tax
    			getvendorledger_sale($('#roundoff_group_codef').val(),0,0,1); // for round off
    			getvendorledger_sale($('#saleaccunt_group_codef').val(),0,0,2); // for sale account
    			getvendorledger_sale($('#dicount_codef').val(),0,0,4); // for discount acc
    			getvendorledger_sale($('#service_charge_codef').val(),0,0,7); // for service_tax acc
    			getvendorledger_sale($('#cash_codef').val(),0,0,5);// for cash ledger
    			getvendorledger_sale($('#card_codef').val(),0,0,6);// for card
			}


			$('#modparcelcustanniversary').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true,
				endDate: '0'

			});
			$('#modparcelcustdob').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true,
				endDate: '0'
			});

			$('#addstorecustdob').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true,
				endDate: '0'

			});
			$('#addstorecustanniversarydate').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true,
				endDate: '0'
			});

			var tablenoCont=document.getElementById("tablenoCont").innerHTML;
			//alert(tablenoCont);
			/* if(tablenoCont=='0')
				{ */
				var customerName= document.getElementById("itemNameSearch").value;
				var customerContact= document.getElementById("itemContactSearch").value;
				//alert(customerContact+" "+customerName);
				if(customerContact != '' ||  customerName != '')
					{

	        				enblDetailDsblAddCustomer();
	        				calledFromSavedOrder='yes';
	        				searchCustomer();
					}
				/* } */


		});

					function isNumberKey(evt){
					    var charCode = (evt.which) ? evt.which : evt.keyCode;

					    var customerName= document.getElementById("itemNameSearch").value;
						var customerContact= document.getElementById("itemContactSearch").value;

						if(customerContact == '' ||  customerName == '')
							{
							dsblDetailEnblAddCustomer();
							}
					    if (charCode > 31 && (charCode < 48 || charCode > 57))
					        return false;
					    return true;
					}

					function lettersOnly(evt) {
					       evt = (evt) ? evt : event;
					       var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
					          ((evt.which) ? evt.which : 0));
					      // alert(charCode);

					       var customerName= document.getElementById("itemNameSearch").value;
						var customerContact= document.getElementById("itemContactSearch").value;

						 if(customerContact == '' ||  customerName == '')
							{
							dsblDetailEnblAddCustomer();
							}
					       if (charCode > 31 && charCode != 32 && (charCode < 65 || charCode > 90) &&
					          (charCode < 97 || charCode > 122)) {
					         // alert("Enter letters only.");
					          return false;
					       }
					       return true;
					     }

					function isNumberKeyCreditCust(evt){
					    var charCode = (evt.which) ? evt.which : evt.keyCode;

					    if (charCode > 31 && (charCode < 48 || charCode > 57))
					        return false;
					    return true;
					}

					function lettersOnlyCreditCust(evt) {
					       evt = (evt) ? evt : event;
					       var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
					          ((evt.which) ? evt.which : 0));

					       if (charCode > 31 && charCode != 32 && (charCode < 65 || charCode > 90) &&
					          (charCode < 97 || charCode > 122)) {

					          return false;
					       }
					       return true;
					     }

	 function deactivateTabs(){

          //console.log('now here');
        //  dsblDetailEnblAddCustomer();
			$tabs = $('.nav-justified li');
			var myArray = $(".nav-justified li a").map(function() {
              return $(this).text();
           }).get();
			for(var i = 0; i<myArray.length; i++)
			{
				if(myArray[i]!='Home')
				{
					$tabs.addClass('disabled');
				}
			}
	 }

	$(function() {
	       $("#itemCodeSearch")
	               .autocomplete(
	                       {

	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompleteitemcode.htm",
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
	                                                            	   if(displayCurrentStockMenu=='Y'){
	                                                            		   return {
		                                                                	   //label : v.name+ " (" + v.currentStock+ ")",
		                                                                	   label : v.name,
		                                                                       itemCode : v.id,
		                                                                       //tagCode : v.tagCode
		                                                                       items:v,
		                                                                   };
	                                                            	   }else{
	                                                            		   return {
		                                                                	   label : v.name,
		                                                                       itemCode : v.id,
		                                                                       //tagCode : v.tagCode
		                                                                       items:v,
		                                                                   };
	                                                            	   }


	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           select : function(e, ui) {

	                              // $("#itemCode").val(ui.item.itemCode);
	                               //$("#autocompleteItemId").val(ui.item.itemCode);
	                               var disc=0.0;
	                               if(ui.item.items.promotionFlag=='Y')
	                            	   disc=ui.item.items.promotionValue;
	                        	   additemtoOrder(ui.item.items.id,ui.item.items.name,ui.item.items.price,disc,ui.item.items.vat,ui.item.items.serviceTax,ui.item.items.promotionFlag,ui.item.items.promotionValue,ui.item.items.isKotPrint);

	                           }
	                       });
	   });



	$(function() {
	       $("#itemSearchByCode")
	               .autocomplete(
	                       {

	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompleteitemsearchbycode.htm",
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
	                                                            	   if(displayCurrentStockMenu=='Y'){
	                                                            		   return {
		                                                                	   label : v.code+ " (" + v.currentStock+ ")",
		                                                                       itemCode : v.id,
		                                                                       //tagCode : v.tagCode
		                                                                       items:v,
		                                                                   };
	                                                            	   }else{
	                                                            		   return {
		                                                                	   label : v.code,
		                                                                       itemCode : v.id,
		                                                                       //tagCode : v.tagCode
		                                                                       items:v,
		                                                                   };
	                                                            	   }


	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           select : function(e, ui) {

	                              // $("#itemCode").val(ui.item.itemCode);
	                               //$("#autocompleteItemId").val(ui.item.itemCode);
	                               var disc=0.0;
	                               if(ui.item.items.promotionFlag=='Y')
	                            	   disc=ui.item.items.promotionValue;
	                        	   additemtoOrder(ui.item.items.id,ui.item.items.name,ui.item.items.price,disc,ui.item.items.vat,ui.item.items.serviceTax,ui.item.items.promotionFlag,ui.item.items.promotionValue,ui.item.items.isKotPrint);

	                           }
	                       });
	   });



	$(function() {
	       $("#creditsalecustname")
	               .autocomplete(
	                       {

	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompletecreditcustname.htm",
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
	                                                                       //tagCode : v.tagCode
	                                                                       items:v,
	                                                                   };

	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#creditsaleModal",
	                           select : function(e, ui) {


	                        	   getvendorledger_sale($('#debitor_group_codef').val(),0,ui.item.itemCode,3);// for sunndry debitor

	                        	$("#creditsalecustcontact").val(ui.item.items.contactNo);
	                        	   $("#hidcredisalecustid").val(ui.item.itemCode);
	                        	   var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.cash+"&nbsp;&nbsp;"+
                                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.card+"&nbsp;&nbsp;"+
                                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.noPay+"";
	                        	   $("#creditsalecustdetailcontId").html("Payment Type : "+htm);
	                           }
	                       });
	   });

	$(function() {
	       $("#creditsalecustcontact")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompletecreditcustcontact.htm",
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
	                                                                       label : v.contactNo,

	                                                                       itemCode : v.id,
	                                                                       //tagCode : v.tagCode
	                                                                       items:v,
	                                                                   };

	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#creditsaleModal",
	                           select : function(e, ui) {
	                           getvendorledger_sale($('#debitor_group_codef').val(),0,ui.item.itemCode,3);// for sunndry debitor
	                        	$("#creditsalecustname").val(ui.item.items.name);
	                        	$("#hidcredisalecustid").val(ui.item.itemCode);
	                        	   var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.cash+"&nbsp;&nbsp;"+
                                			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.card+"&nbsp;&nbsp;"+
                                			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.noPay+"";
	                        	   $("#creditsalecustdetailcontId").html("Payment Type : "+htm);
	                           }
	                       });
	   });

	/* $(function() {
	       $("#modparcelcustPhone")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompleteordercustcontact.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                        	   console.log(data.length);
	                                        	   if(data.length==0){
	               							$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.custNotFound+"</strong>"+getBaseLang.plsAddCustDetails+" ");
	                                        	   }else{
	                                        		   response(data);
	                                        		   $("#parcelCustModalalertMsg").html("");
	                                        	   }
	                                        	   $("#modparcelcustName")
	               									.val("");
	               							$("#modparcelcustAddress").val(
	               									"");
	               							$("#modparceldeliveryPersonName").val(
	               									"");

	                                           },
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#parcelCustDetailsModal",

	                       });
	   }); */



	/*
	$(function() {

	       $("#modparcelcustName")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchcustbyname.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                       	  	if($("#selectCustSpan").hasClass('enable-links'))
	                                    		    {
	                                        	   var custname=JSON.parse(data);
	                                        	   console.log(custname);
	                                        	   deactivateTabs();
	                                        	    if(data.length==0){
	               							$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.custNotFound+"</strong>"+getBaseLang.plsAddCustDetails+" ");
	                                        	   }else{
	                                        		   response($.map(
	                                        				   custname,
		                                                               function(v) {
	                                        					   return {
                                                                       label : v.name,
                                                                       phno:v.contactNo,
                                                                       addr:v.address,
                                                                       custId:v.id,
                                                                   };

                                                               }));
	                                        		   $("#parcelCustModalalertMsg").html("");
	                                        	   }
	                                        	    if(custname.length==0){
	        	               							$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.custNotFound+"</strong>"+getBaseLang.plsAddCustDetails+" ");
	        	                                        	   }
	               							$("#modparcelcustAddress").val(
	               									"");
	               							$("#modparceldeliveryPersonName").val(
	               									"");
	               							$("#modparcelcustlocation").val(
           									"");
	               							$("#modparcelcustAddress").val(
           									"");
	               							$("#modparcelcusthouseno").val(
           									"");
	               							$("#modparcelcuststreet").val(
           									"");
	               							$("#modparcelcustvatorcst").val(
           									"");

	                                           }},
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#parcelCustDetailsModal",
	                           select : function(e, ui) {

		                        	$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustPhone").val(ui.item.phno);
		                         $("#modparcelcustIdhidden").val(ui.item.custId);
	                        	   }


	                       })
	       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      			return $( "<li></li>" )
      				.data( "ui-autocomplete-item", item )
      				.append( "<a>" + item.label + "(" + item.phno + ")</br><font size='2'>"+item.addr + "</font></a>" )
      				.appendTo( ul );
      		};

      		 $(".ui-autocomplete-loading").ajaxStart(function(){
      	        $(this).show();
      	      });

      	      $(".ui-autocomplete-loading").ajaxStop(function(){
      	        $(this).hide();
      	      });
      		deactivateTabs();
	});




	   $(function() {

	       $("#modparcelcustPhone")
	               .autocomplete(
	                       {

	                           		source : function(request, response) {
	                               		$.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },
	                                           dataType : "json",
	                                           success : function(data)
	                                           {
	                                        	   if($("#selectCustSpan").hasClass('enable-links'))
	                                    		   {
	                                        	   	var custname=JSON.parse(data);
	                                        	   	console.log(custname);
	                                        	   	deactivateTabs();
	                                        	    if(data.length==0)
	                                        	    {
	               									$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.custNotFound+"</strong>"+getBaseLang.plsAddCustDetails+" ");
	                                        	   	}
	                                        	    else
	                                        	    {
	                                        		   response($.map(
	                                        				   custname,
		                                                               function(v) {
		                                                                   return {
		                                                                       label : v.contactNo,
		                                                                       name:v.name,
		                                                                       addr:v.address,
		                                                                   };

		                                             }));
	                                        		   $("#parcelCustModalalertMsg").html("");
	                                        	    }
	                                        	    if(custname.length==0)
	                                        	    {
	        	               							$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.custNotFound+"</strong>"+getBaseLang.plsAddCustDetails+" ");
	        	                                     }
	                                        	    $("#modparcelcustName").val("");
	               								$("#modparcelcustAddress").val("");
	               								$("#modparceldeliveryPersonName").val("");
	               								$("#modparcelcustlocation").val("");
	               								$("#modparcelcustAddress").val("");
	               								$("#modparcelcusthouseno").val("");
	               								$("#modparcelcuststreet").val("");
	               								$("#modparcelcustvatorcst").val("");
	                                           }},
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#parcelCustDetailsModal",
	                           select : function(e, ui) {

		                        	//$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustPhone").val(ui.item.phno);

		                           }

	                       })
	       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      			return $( "<li></li>" )
      				.data( "ui-autocomplete-item", item )
      				.append( "<a>" + item.label + "(" + item.name + ")</br><font size='2'>"+item.addr + "</font></a>" )
      				.appendTo( ul );
      		};
      		deactivateTabs();

	   }); */

	   $(function() {

	       $("#modparcelcustlocation")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchlocation.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {

	                                   	    	if($("#selectCustSpan").hasClass('disable-links'))
	                                   	    		{
	                                        	   var locname=JSON.parse(data);
	                                        	   console.log(locname);
	                                        	   deactivateTabs();
	                                        	   if(data.length==0)
	                                        	   {
	       	               							//$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.locNotFound+"</strong>"+getBaseLang.plsAddLocDetails+" ");
	       	                                    }
	                                        	   else{

	                                        		   response($.map(
	                                        				   locname,
                                                               function(v) {
                                                                   return {
                                                                       label : v.location,

                                                                   };

                                                               }));
	                                        		   $("#parcelCustModalalertMsg").html("");

	                                        	   }
	                                        	   if(locname.length==0){
		       	               							//$("#parcelCustModalalertMsg").html("<strong>"+getBaseLang.locNotFound+"</strong>"+getBaseLang.plsAddLocDetails+" ");
		       	                                        	   }
	                                        	 /*   $("#modparcelcustName")
	               									.val("");
	               							$("#modparcelcustAddress").val(
	               									"");
	               							$("#modparceldeliveryPersonName").val(
	               									"");

	               							$("#modparcelcustAddress").val(
           									"");
	               							$("#modparcelcusthouseno").val(
           									"");
	               							$("#modparcelcuststreet").val(
           									"");
	               							$("#modparcelcustvatorcst").val(
           									""); */
	                                           }},
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#parcelCustDetailsModal",
	                           select : function(e, ui) {

		                        	//$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustlocation").val(ui.item.label);

		                           }
	                       });

	   });

	   $(function() {
	        $("#itemNameSearch")
	                .autocomplete(
	                        {
	                            source : function(request, response) {
	                                $.ajax({
	                                            url : "${pageContext.request.contextPath}/order/searchcustbyname.htm",
	                                            type : "GET",
	                                            data : {
	                                             term : request.term
	                                            },

	                                            dataType : "json",

	                                            success : function(data) {
	                                              custname=JSON.parse(data);
	                                             console.log(custname);
	                                             //deactivateTabs();

	                                              //if(data!=null){
	                                            	   /* dsblDetailEnblAddCustomer(); */
	                                            	    		//	$("#itemContactSearch").val('');
		                		                         $("#modparcelcustIdhidden").val('');

		                		                        	$("#modparcelcustName").val('');
		                		                        	$("#modparcelcustPhone").val('');
		                		                        	$("#modparcelcustAddress").val("");
		                		                        	$("#modparcelcustlocation").val("");
			               							$("#modparceldeliveryPersonName").val("");
			               							$("#modparcelcustvatorcst").val("");
												     $("#modparcelcusthouseno").val("");
												     $("#modparcelcuststreet").val("");
												     $("#modparcelcuststate").val("");

												     $("#modparcelcustdob").val("");
												     $("#modparcelcustanniversary").val("");
												    // custId='0';
	                                              if(data==null){

	                      // $("#parcelCustModalalertMsg").html("<strong>customer name not found</strong>");
		                	                    		 dsblDetailEnblAddCustomer();
	                                             }
	                                              else{
	                                              console.log("in else");
	                                              response($.map(
	                                                custname,
	                                                                 function(v) {
	                                                                     return {
	                                                                         label : v.name,
	                                                                         phno:v.contactNo,
	                                                                         addr:v.address,
	                                                                         custId:v.id,
	                                                                     };

	                                                                 }));
	                                             }
	                                          //    }


	                                            },
	                                            error : function(error) {
	                                                console.log('error: ' + error);
	                                            }
	                                        });
	                            },
	                          //  appendTo: "#itemNameSearch",
	                            select : function(e, ui) {

	                           $("#itemNameSearch").val(ui.item.label);
	                           $("#itemContactSearch").val(ui.item.phno);
	                           $("#modparcelcustIdhidden").val(ui.item.custId);
	                        	$("#modparcelcustName").val(ui.item.label);
	                        	$("#modparcelcustPhone").val(ui.item.phno);
	                        	  custId=ui.item.custId;
	                    		enblDetailDsblAddCustomer();
	                    		searchCustomer();
	                             }

	                        })
	       /*  .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
	         return $( "<li></li>" )
	          .data( "ui-autocomplete-item", item )
	          .append( "<a>" + item.label + "(" + item.phno + ")</br><font size='2'>"+item.addr + "</font></a>" )
	          .appendTo( ul );
	        }; */
	                     //   })
	        //deactivateTabs();
	    //    dsblDetailEnblAddCustomer();
	    });


	    $(function() {

	        $("#itemContactSearch")
	                .autocomplete(
	                        {
	                            source : function(request, response) {
	                                $.ajax({
	                                            url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
	                                            type : "GET",
	                                            data : {
	                                             term : request.term
	                                            },

	                                            dataType : "json",

	                                            success : function(data) {
	                                             var custname=JSON.parse(data);
	                                             console.log(custname);
	                                            // deactivateTabs();
	                                           // 	$("#itemNameSearch").val('');
	                		                           $("#modparcelcustIdhidden").val('');
	                		                        	$("#modparcelcustName").val('');
	                		                        	$("#modparcelcustPhone").val('');
	                		                        	$("#modparcelcustAddress").val("");
	                		                        	$("#modparcelcustlocation").val("");
		               							$("#modparceldeliveryPersonName").val("");
		               							$("#modparcelcustvatorcst").val("");
											     $("#modparcelcusthouseno").val("");
											     $("#modparcelcuststreet").val("");
											     $("#modparcelcuststate").val("");

											     $("#modparcelcustdob").val("");
											     $("#modparcelcustanniversary").val("");
											     //custId='0';
	                                              if(data.length==0){
	                                            	  dsblDetailEnblAddCustomer();
	                                      //     $("#parcelCustModalalertMsg").html("<strong>customer contact not found</strong>");
	                                        }else{
	                                              response($.map(
	                                                custname,
	                                                                 function(v) {
	                                                                     return {
	                                                                         label : v.contactNo,
	                                                                         name:v.name,
	                                                                         phno:v.contactNo,
	                                                                         addr:v.address,
	                                                                         custId:v.id,
	                                                                     };

	                                                                 }));
	                                             }

	                                            },
	                                            error : function(error) {
	                                                console.log('error: ' + error);
	                                            }
	                                        });
	                            },
	                            select : function(e, ui) {

	                           //$("#modparcelcustName").val(ui.item.custname);
	                         //  $("#itemContactSearch").val(ui.item.phno);
	                           $("#itemNameSearch").val(ui.item.name);
	                           $("#itemContactSearch").val(ui.item.phno);
	                           $("#modparcelcustIdhidden").val(ui.item.custId);
	                        	$("#modparcelcustName").val(ui.item.name);
	                        	$("#modparcelcustPhone").val(ui.item.phno);
	                               custId=ui.item.custId;
	                        			enblDetailDsblAddCustomer();
	                        			searchCustomer();
	                             }

	                        })
	       /*  .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
	         return $( "<li></li>" )
	          .data( "ui-autocomplete-item", item )
	          .append( "<a>" + item.label + "(" + item.name + ")</br><font size='2'>"+item.addr + "</font></a>" )
	          .appendTo( ul );
	        }; */

	   //     dsblDetailEnblAddCustomer();
	      //  deactivateTabs();
	    });

	    function existingClassRemove()
	    {

	      	$("#selectCustSpan").removeClass('enable-links');
		     $("#selectCustSpan").removeClass('disable-links');

		   	$("#addCustSpan").removeClass('enable-links');
		     $("#addCustSpan").removeClass('disable-links');
	    }

	    function enblDetailDsblAddCustomer() {

	    	existingClassRemove();
    		$("#selectCustSpan").addClass('enable-links');
    		$("#addCustSpan").addClass('disable-links');

	    }

		function dsblDetailEnblAddCustomer() {

			existingClassRemove();
		     $("#selectCustSpan").addClass('disable-links');
		     $("#addCustSpan").addClass('enable-links');

	    }

		function existingSaveClassRemove()
	    {

	      	$("#addSaveSpan").removeClass('enable-links');
		    $("#addSaveSpan").removeClass('disable-links');
	    }

		function enblSaveOrder() {

	    		existingSaveClassRemove();
	    		document.getElementById('anchorSaveSpan').style.backgroundColor="#F60";
    			$("#addSaveSpan").addClass('enable-links');
	    }

		function dsblSaveOrder() {

			existingSaveClassRemove();
			document.getElementById('anchorSaveSpan').style.backgroundColor="#F00";
		    $("#addSaveSpan").addClass('disable-links');
	    }

	</script>

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

</body>
</html>

