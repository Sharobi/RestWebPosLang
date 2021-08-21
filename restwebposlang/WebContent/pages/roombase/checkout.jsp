<%@page import="com.sharobi.webpos.adm.model.StoreCustomer"%>
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Book / Cancel Room :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />

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
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/customstyle.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/credit.png">	
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
	z-index: 2147483647;
	/* add padding to account for vertical scrollbar */
	/*             padding-right: 20px; */
}

::-webkit-scrollbar {
	width: 3px;
}

::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
}
</style>

</head>
<body>

	<c:set var="today" value="<%=new java.util.Date()%>" />
	<jsp:include page="/pages/common/header.jsp"></jsp:include>

	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">

				<div class="col-md-12 col-sm-12" style="height: 150px;"
					align="center">
					<div style="margin-top: 15px;">
						<span style="color: #FFF; font-size: 22px; font-weight: bold;"><spring:message
								code="base.room.jsp.ProcessReservation" text="CHECK OUT" /></span>
					</div>
					<div style="margin-top: 15px;">

						<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
								code="base.room.jsp.ReservationDetails" text="CheckIn Details" /></span>
						<c:if test="${!empty fromdate}">
							<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
									code="base.room.jsp.frmDate" text="From Date:" /></span>
							<input type="text" id="fromdateroomsearch" size="10"
								value="${fromdate}" />">
                    			<c:set var="fromSpecificDate" value="${fromdate}" />
						</c:if>

						<c:if test="${!empty todate}">
							<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
									code="base.room.jsp.toDate" text="To Date:" /></span>
							<input type="text" id="todateroomsearch" size="10"
								value="${todate}" />">
                    			<c:set var="toSpecificDate" value="${todate}" />
						</c:if>
						<c:if test="${empty fromdate}">
							<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
									code="base.room.jsp.frmDate" text="From Date:" /></span>
							<input type="text" id="fromdateroomsearch" size="10"
								value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
							<c:set var="fromSpecificDate" value="${today}" />
							<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
									code="base.room.jsp.toDate" text="To Date :" /></span>
							<input type="text" id="todateroomsearch" size="10"
								value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">
							<c:set var="toSpecificDate" value="${today}" />
						</c:if>

						<span style="color: #FFF; font-size: 16px; font-weight: bold;">Booking
							Number:</span> <input type="text" id="bookingIdSearch" value=""
							style="color: #222222; margin-left: 0%; width: 10%;"
							placeholder="BOOKING NUMBER" maxlength="10"> <input
							type="hidden" id="hiddateroomsearch"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">

						<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"
							var="currentDate" />
						<a
							href="javascript:searchCheckedInCust(document.getElementById('fromdateroomsearch').value,document.getElementById('todateroomsearch').value,${sessionScope.loggedinUser.storeId},document.getElementById('bookingIdSearch').value)"
							class="btn btn-success"
							style="background: #0CF; margin-bottom: 3px;"><spring:message
								code="base.room.jsp.search" text="SEARCH" /></a>
					</div>
					<div style="margin-top: 15px; font-size: 12px; font-weight: bold;"
						align="center">
						<!-- <input
										type="text" id="bookingIdSearch"
										value=""
										style="color: #222222; margin-left: 1%; width: 10%;"
										placeholder="BOOKING ID" maxlength="10">  -->
						<span style="color: #FFF; font-size: 16px; font-weight: bold;">Search
							By Customer:</span> <input type="text" id="custNameSearch" value=""
							style="color: #222222; margin-left: 1%; width: 10%;"
							placeholder="CUSTOMER NAME"
							onkeypress='return lettersOnly(event)'> <input
							type="text" id="custContactSearch" value=""
							style="color: #222222; margin-left: 1%; width: 10%;"
							placeholder="CONTACT NO." maxlength="10"
							onkeypress='return isNumberKey(event)'>
					</div>
				</div>
				<input type="hidden" id="dueties_and_tax_accf"
					value="<spring:message code="accgroup.jsp.duties_code" text="DT"/>">
				<input type="hidden" id="saleaccunt_group_codef"
					value="<spring:message code="accgroup.jsp.saleac_code" text="SA"/>">
				<input type="hidden" id="roundoff_group_codef"
					value="<spring:message code="accgroup.jsp.roun_code" text="ROD"/>">
				<input type="hidden" id="debitor_group_codef"
					value="<spring:message code="accgroup.jsp.deb_code" text="SDE"/>">
				<input type="hidden" id="dicount_codef"
					value="<spring:message code="accgroup.jsp.disc_code" text="DIS" />">
				<input type="hidden" id="cash_codef"
					value="<spring:message code="accgroup.jsp.cash_code" text="CIH" />">
				<input type="hidden" id="card_codef"
					value="<spring:message code="accgroup.jsp.card_code" text="CAB" />">
				<input type="hidden" id="service_charge_codef"
					value="<spring:message code="accgroup.jsp.service_charge" text="SC" />">


				<input type="hidden" id="duties_ledger_idf" value="0"> <input
					type="hidden" id="round_ledger_idf" value="0"> <input
					type="hidden" id="sales_ledger_idf" value="0"> <input
					type="hidden" id="debitor_ledger_idf" value="0"> <input
					type="hidden" id="discount_ledger_idf" value="0"> <input
					type="hidden" id="debitor_cahs_ledger_idf" value="0"> <input
					type="hidden" id="card_ledger_idf" value="0"> <input
					type="hidden" id="service_charge_ledger_idf" value="0">
				<div class="col-md-12 col-sm-12">
					<div style="height: 100%; width: 100%;">
						<div style="height: 500px; overflow-y: auto;" id="roomlayoutid">
							<input type="hidden" id="printbillpapersize"
								value="${sessionScope.loggedinStore.printBillPaperSize}">
							<input type="hidden" id="mobPrintVal"
								value="${sessionScope.loggedinStore.mobBillPrint}">
							<!-- 	<div class="panel-body"> -->
							<div class="table-responsive" style="background: #404040;">
								<table class="table table-striped table-bordered table-hover"
									id="checkoutdetailslist">
									<thead style="background: #000; color: #FFF; font-size: 12px;">
										<th style="text-align: center;"><spring:message
												code="rb.admin.roombooking.bookingno" text="BOOKING NO" /></th>
										<th style="text-align: center;"><spring:message
												code="rb.admin.roombooking.refno" text="REF NO." /></th>		
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.fromdate" text="CHECKIN DATE" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.todate" text="TO DATE" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.name" text="CUST. NAME" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.phno" text="PHONE NO." /></th>
										<%-- <th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.email" text="EMAIL" /></th> --%>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.rooms" text="ROOMS" /></th>
										<th style="text-align: center;"><spring:message
												code="rb.roomadmin.roomservice.service" text="SERVICES" /></th>
										<th style="text-align: center;"><spring:message
												code="rb.roombooking.roomschange" text="CHANGE ROOM" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.rooms.dateextende"
												text="CHANGE CHECKOUT" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.checkout.adddiscount" text="DISCOUNT" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.checkout.nontaxable" text="NO TAX" /></th>
										<%--  <c:if test="${toSpecificDate >= currentDate}"> --%>
										<th style="text-align: center; width: 10%;"><spring:message
												code="rb.checkout.payment" text="PAYMENT" /></th>
										<th style="text-align: center;"><spring:message
												code="rb.roombooking.printbill" text="PRINT BILL" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.checkout" text="CHECK OUT" /></th>
										<th style="text-align: center;"><spring:message
												code="base.roombooking.jsp.guest" text="GUEST" /></th>
										<%-- </c:if> --%>
									</thead>
             
									<tbody style="background: #000; color: #FFF;">
									 
										<c:if test="${!empty allcheckedinCust}">
											<c:forEach items="${allcheckedinCust}"
												var="checkedinCustomer" varStatus="status">
												<c:if
													test="${(checkedinCustomer.isCheckedOut=='N') and (checkedinCustomer.isCheckedIn!='N')}">
													<tr style="background: #000; font-size: 14px; color: #FFF;"
														align="center">
														<td style="line-height: 1.4; padding: 6px;">${checkedinCustomer.bookingNo}</td>
														<td style="line-height: 1.4; padding: 6px;">${checkedinCustomer.refNo}</td>
														<td style="line-height: 1.4; padding: 6px;">${checkedinCustomer.checkInDate}</td>
														<td style="line-height: 1.4; padding: 6px;">
															<%-- ${currentDate} --%>
															${checkedinCustomer.checkoutDate}
														</td>
														<td style="line-height: 1.4; padding: 6px;">${checkedinCustomer.custId.name}</td>
														<td style="line-height: 1.4; padding: 6px;"><a href="javascript:showCustImage(${checkedinCustomer.custId.id})">${checkedinCustomer.custId.contactNo}</a></td>
														<%-- <td style="line-height: 1.4; padding: 6px;">${checkedinCustomer.custId.emailId}</td> --%>
														<c:set var="roomNumbers" value=""></c:set>
														<c:set var="roomIds" value=""></c:set>
														<c:set var="totalRoomReserved"
															value="${fn:length(checkedinCustomer.bookingDetail) - 1}" />
														<c:set var="paymentLength"
															value="${fn:length(checkedinCustomer.payment) - 1}" />
														<c:forEach items="${checkedinCustomer.bookingDetail}"
															var="roomDetails" varStatus="loop">
															<c:choose>
																<c:when
																	test="${ roomNumbers=='' && (loop.index < totalRoomReserved || totalRoomReserved<=0)}">
																	<c:set var="roomNumbers"
																		value="${roomDetails.roomId.roomNo}" />
																	<c:set var="roomIds" value="${roomDetails.roomId.id}" />
																</c:when>
																<c:when
																	test="${loop.index < totalRoomReserved && roomNumbers!=''}">
																	<c:set var="roomNumbers"
																		value="${roomNumbers},${roomDetails.roomId.roomNo}" />
																	<c:set var="roomIds"
																		value="${roomIds},${roomDetails.roomId.id}" />
																</c:when>
																<c:otherwise>
																	<c:set var="roomNumbers"
																		value="${roomNumbers},${roomDetails.roomId.roomNo}" />
																	<c:set var="roomIds"
																		value="${roomIds},${roomDetails.roomId.id}" />
																</c:otherwise>
															</c:choose>
														</c:forEach>
														<td style="line-height: 1.4; padding: 6px;">${roomNumbers}</td>
														<%-- <td align="center"><a href="javascript:openChangeRoomModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.roombookinginfo.payment.reserveId}&quot;,'${checkedinCustomer.checkInDate}','${checkedinCustomer.checkoutDate}',&quot;${roomNumbers}&quot;,&quot;${roomIds}&quot;)"><i class="fa fa-exchange" aria-hidden="true" style="font-size: 30px;color: white;"></i></a></td>
														 --%>
														<td align="center"><c:set var="roomserviceLength"
																value="${fn:length(checkedinCustomer.bookingServices)}" />
															<c:if test="${roomserviceLength>0}">
																<a
																	href="javascript:openRoomServiceUpdateModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.bookingNo}&quot;,'${checkedinCustomer.checkInDate}','${checkedinCustomer.checkoutDate}',&quot;${roomNumbers}&quot;,&quot;${roomIds}&quot;)"><i
																	class="fa fa-pencil"
																	style="font-size: 30px; color: white;"></i></a>
															</c:if> <c:if test="${roomserviceLength<=0}">
																<a
																	href="javascript:openRoomServiceModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.bookingNo}&quot;,'${checkedinCustomer.checkInDate}','${checkedinCustomer.checkoutDate}',&quot;${roomNumbers}&quot;,&quot;${roomIds}&quot;)"><i
																	class="fa fa-save"
																	style="font-size: 30px; color: white;"></i></a>
															</c:if></td>

														<td align="center"><a
															href="javascript:openChangeRoomModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.id}&quot;,'${checkedinCustomer.checkInDate}','${checkedinCustomer.checkoutDate}',&quot;${roomNumbers}&quot;,&quot;${roomIds}&quot;)"><i
																class="fa fa-exchange" aria-hidden="true"
																style="font-size: 30px; color: white;"></i></a></td>

														<%-- <td align="center"><a href="javascript:showCancelReservationModal(&quot;${reservedDetails.reserveId}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td> --%>
														<td align="center"><a
															href="javascript:showDateExtendModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.checkInDate}&quot;,&quot;${checkedinCustomer.checkoutDate}&quot;)"><input
																type="image"
																src="${pageContext.request.contextPath}/assets/images/admin/g/g_datechange.png"></a></td>

														<c:if
															test="${checkedinCustomer.payment[paymentLength].amt_to_pay > 0 && checkedinCustomer.discPer == 0.0}">
															<%-- <c:if test="${(checkedinCustomer.discPer == 0.0)}"> --%>
															<td align="center"><a
																href="javascript:showAddDiscountModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.bookingNo}&quot;,${checkedinCustomer.grossAmt + checkedinCustomer.roomServiceGross})"><input
																	type="image"
																	src="${pageContext.request.contextPath}/assets/images/admin/g/g_discount.png"></a></td>
															<%-- </c:if> --%>
														</c:if>
														<c:if
															test="${checkedinCustomer.payment[paymentLength].amt_to_pay<=0 && checkedinCustomer.discPer == 0.0}">
															<td align="center"></td>
														</c:if>

														<c:if test="${(checkedinCustomer.discPer != 0.0)}">
															<td align="center">${checkedinCustomer.discAmt}
																(${checkedinCustomer.discPer}%)</td>
														</c:if>
														<td align="center"><c:if
																test="${checkedinCustomer.payment[paymentLength].amt_to_pay>0}">
																<c:if test="${(checkedinCustomer.isTaxable != 'N')}">
																	<%-- <button type="button" id="taxchangebtn_${checkedinCustomer.id}" onclick="javascript:taxChange(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.roombookinginfo.payment.reserveId}&quot;,${checkedinCustomer.bookingNo})" style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="rb.roombooking.change=" text="CHANGE" /></button> --%>
																	<button type="button"
																		id="taxchangebtn_${checkedinCustomer.id}"
																		onclick="javascript:taxChange(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.bookingNo}&quot;,&quot;${checkedinCustomer.bookingNo}&quot;)"
																		style="background: #72BB4F; font-weight: bold;"
																		data-dismiss="modal" class="btn btn-success">
																		<spring:message code="rb.roombooking.change="
																			text="CHANGE" />
																	</button>

																</c:if>
															</c:if> <c:if test="${(checkedinCustomer.isTaxable == 'N')}">
																<spring:message code="rb.roombooking.notaxable"
																	text="Non Taxable" />
															</c:if></td>


														<%-- <c:if test="${toSpecificDate >= currentDate}"> --%>
														<td class="text-nowrap">
															<%-- <a href="javascript:showPaymentModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.roombookinginfo.payment.reserveId}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_payment.png"></a> --%>
															<c:if test="${checkedinCustomer.creditFlag=='N'}"> 
															<a
															href="javascript:showPaymentModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.id}&quot;,&quot;CASH&quot;,1,&quot;${checkedinCustomer.bookingNo}&quot;,${checkedinCustomer.discAmt},${checkedinCustomer.taxAmt},${checkedinCustomer.grossAmt},${checkedinCustomer.roomServiceGross},${checkedinCustomer.roomServiceTax},${checkedinCustomer.roomServiceDiscount})">
																<%-- <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_payment.png"> --%>
																<i class="fa fa-money" aria-hidden="true"
																style="font-size: 30px; color: white;"></i>
														</a> <a
															href="javascript:showPaymentModal(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.id}&quot;,&quot;CARD&quot;,2,&quot;${checkedinCustomer.bookingNo}&quot;,${checkedinCustomer.discAmt},${checkedinCustomer.taxAmt},${checkedinCustomer.grossAmt},${checkedinCustomer.roomServiceGross},${checkedinCustomer.roomServiceTax},${checkedinCustomer.roomServiceDiscount})">
																<i class="fa fa-credit-card" aria-hidden="true"
																style="font-size: 26px; color: white; margin-left: 10px; top: -1px; position: relative;"></i>
														</a> <a
															href="javascript:openOnlineModalCheckout(&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.id}&quot;,&quot;${checkedinCustomer.bookingNo}&quot;,${checkedinCustomer.discAmt},${checkedinCustomer.taxAmt},${checkedinCustomer.grossAmt},${checkedinCustomer.roomServiceGross},${checkedinCustomer.roomServiceTax},${checkedinCustomer.roomServiceDiscount})">
																<i class="fa fa-globe" aria-hidden="true"
																style="font-size: 30px; color: white; margin-left: 10px;"></i>
														</a>
														</c:if>
														 <%-- <c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">  --%>
												  <c:if test="${checkedinCustomer.creditFlag=='N' && sessionScope.loggedinStore.creditSale=='Y' }"> 											               
									                               <c:set var="custIdObject" value="${checkedinCustomer.custId}"/>
																	 <%StoreCustomer obj = null; 
																	String json="";
																	obj =(StoreCustomer)pageContext.getAttribute("custIdObject"); 
													              //System.out.println(" STORE  OBJECT IS:"+obj); 
															    Gson gson = new Gson();
															    json=gson.toJson(obj);
															    //System.out.println(" STORE JSON  OBJECT IS:"+json); 
															    pageContext.setAttribute("custIdObject2", json);											    
												
															    %>  
									                      
										                        <a href='javascript:openCreditCustomerModal("${checkedinCustomer.id}","${checkedinCustomer.bookingNo}",${custIdObject2})' >   
										                      <input
																type="image"
																src="${pageContext.request.contextPath}/assets/images/title/credit.png" style="margin-left:10px;" >
									                           </a>
								                            </c:if>
														</td>
														<td align="center"><a
															href="javascript:printPaidBill(&quot;${checkedinCustomer.id}&quot;,1)">
																<i class="fa fa-print" aria-hidden="true"
																style="font-size: 30px; color: white; margin-left: 10px;"></i>
														</a></td>
														<td align="center"><a
														href="javascript:showCheckOutRoomModal('${checkedinCustomer.id}','${checkedinCustomer.creditFlag}')">
															<%-- href="javascript:showCheckOutRoomModal(&quot;${checkedinCustomer.id}&quot )"> --%>
															<input
																type="image"
																src="${pageContext.request.contextPath}/assets/images/admin/g/g_checkout.png"></a></td>
														<c:choose>
                                                            
															<c:when test="${checkedinCustomer.noOfPersons-1>0}">
															<!-- <script>
															var t="${checkedinCustomer.custId.name}";
															var c="${checkedinCustomer.noOfPersons-1}";
															alert("ENTERS"+t+c);
															</script> -->
                                                               <td align="center"><a
															href="javascript:addGuestModal('${checkedinCustomer.id}','${checkedinCustomer.bookingNo}')"><input
																type="image"
																src="${pageContext.request.contextPath}/assets/images/admin/g/addguest.png" ></a></td>
                                                              </c:when>
															<c:otherwise>
                                                            <td>NA</td>
                                                             </c:otherwise>
														</c:choose>
														
														
														<%-- </c:if> --%>
													</tr>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${empty allcheckedinCust}">
											<tr style="background: #000; font-size: 14px; color: #FFF;">
												<td colspan="16"><spring:message
														code="admin.menumgnt.jsp.nodatafound"
														text="No Data found!" /></td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- modal starts -->


	<div class="modal fade" data-backdrop="static"
		id="alertsearchroomModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.rpt_inv_po_period.jsp.alert"
							text="Alert!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message code="admin.rpt_inv_po_period.jsp.cont_one"
							text="Given date is greater than today's date!" />
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="admin.rpt_inv_po_period.jsp.ok" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<div class="modal fade" data-backdrop="static"
		id="alertsearchroomgreaterModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.rpt_inv_po_period.jsp.alert"
							text="Alert!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message code="admin.rpt_inv_po_period.jsp.cont_two"
							text="From Date is greater than To Date!" />
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:resetSearch()"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="admin.rpt_inv_po_period.jsp.ok" text="OK" />
					</button>
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

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
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



	<div class="modal fade" data-backdrop="static"
		id="alertRoomBookDataopModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.menumgnt.jsp.alert" text="Alert!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<div id="roombookalertopmassagecont"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%"
						onclick="javascript:failRoomBook()" data-dismiss="modal"
						class="btn btn-success">
						<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static"
		id="successRoomBookDataopModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.menumgnt.jsp.success" text="Success!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<div id="roomBookdataopmassagecont"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%"
						onclick="javascript:successCheckOut()" data-dismiss="modal"
						class="btn btn-success">
						<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>


<%-- <div class="modal fade" data-backdrop="static"
		id="alertforsuccessaddingguest" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.menumgnt.jsp.success" text="Success!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<div id="roomBookdataopmassagecont"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%"
						 data-dismiss="modal"
						class="btn btn-success">
						<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div> --%>

	<%-- 	<div class="modal fade" data-backdrop="static"
				id="modRoomCheckInCustDetailsModal" tabindex="-1" role="dialog"
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
			
									<input type="hidden" id="modroombookreserveIdhidden" value="">
									<div style="text-align: left; font-size: 18px;">
										<table align="center">

											<input type="hidden" id="modroombookcustIdhidden" value="">
												<tr>
													<td><spring:message code="order.jsp.PHONENO"
															text="PHONE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcustPhone"
														maxlength="10" value="${orders.customerContact}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														autofocus="autofocus"
														onkeypress='return isNumberKey(event)' /></td>							
												</tr>
												<tr>
													<td><spring:message code="order.jsp.CUSTOMERNAME"
															text="CUSTOMER NAME" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcustName"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														onkeypress='return lettersOnly(event)' /></td>
												</tr>
												<tr>
                                            			<td><spring:message code="order.jsp.CUSTOMERGENDER" text="GENDER" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modroombookcustGender" style="margin-bottom: 2px;color: #222222;">
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
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.custDOB"
															text="DATE OF BIRTH" /></td>
													</td>
													<td>:</td>

													<td><input type="text" id="modroombookcustdob" size="10"
														style="margin-bottom: 2px; color: #222222; width: 95%;"
														value=""></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.location"
															text="LOCATION" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcustLocation"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
											 	<tr>
													<td><spring:message code="order.jsp.ADDRESS"
															text="ADDRESS" /></td>
													<td>:</td>
													<td><textarea id="modroombookcustAddress" rows="2"
															style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea>
													</td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.houseno"
															text="HOUSE NO" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcusthouseno"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td><spring:message code="order.jsp.streetno"
															text="STREET NO" /></td>
													<td>:</td>
													<td><input type="text" id="modroombookcuststreet"
														value=""
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>
												<tr>
													<td>STATE</td>
													<td>:</td>
													<td><input type="text" id="modroombookcuststate"
														value="${orders.state}"
														style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
												</tr>

										</table>
										<div
											style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
											id="modroombookCustalertMsg"></div>
									</div>
						</div>
						
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelReserve()"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javascript:createCheckIn()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								 class="btn btn-success">
								<spring:message code="m.jsp.CHECKIN" text="CHECK IN" />
							</button>
						</div>
					</div>
				</div>
			</div> --%>


	<!-- Customer Cancel -->

	<div class="modal fade" data-backdrop="static"
		id="confirmCancelCustomerModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.menuitems.jsp.confirmation"
							text="Confirmation!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<div id="cancelcustdataopmassagecont"></div>
						<div id="hiddencustdataopmassagecont" style="display: none;"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #F60; font-weight: bold; width: 25%;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="admin.menuitems.jsp.cancel" text="CANCEL" />
					</button>
					<button type="button" onclick="javacsript:CancelReserveId()"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="admin.menuitems.jsp.ok" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" data-backdrop="static" id="alertcatdataopModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="admin.menumgnt.jsp.alert" text="Alert!" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px; color: #fff;">
						<div id="catdataopmassagecont"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%"
						onclick="location.href='${pageContext.request.contextPath}/checkout/welcome.htm'"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
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
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<%-- <spring:message code="order.jsp.BOOKINGID" text="BOOKING ID:" /> --%>
						<span id="cashmodReserveCont" style="display: none;">00</span>
						BOOKING NUMBER:<span id="cashmodReserveContBookingNo"></span>
						<%--<span
									style="float: right;"> <spring:message
										code="order.jsp.TABLENO" text="TABLE NO:" /><span
									id="cashmodTabCont">00</span></span> --%>

					</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						<div style="padding: 5px;">
							<spring:message code="order.jsp.paymentmode" text="PAYMENT MODE" />
							:&nbsp;&nbsp;&nbsp;<span id="onlineselpaymenttype"></span>
						</div>
						<div style="padding: 5px;">
							<spring:message code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />
							<!-- class="hide" -->
							:&nbsp;&nbsp;&nbsp;<span id="cashtotamtcontId">0.00</span>
						</div>
						<div style="padding: 5px;">
							<spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />
							:&nbsp;&nbsp;&nbsp;<span id="cashamttopaycontId">0.00</span>
						</div>
						<div id="cashpaidamtdivId" style="padding: 5px;">
							<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
							:&nbsp;&nbsp;&nbsp;<span id="cashpaidamtcontId">0.00</span>
						</div>
						<div style="padding: 3px;">
							<%-- <spring:message code="order.jsp.CASHAMOUNT"
										text="CASH AMOUNT" /> --%>
							<spring:message code="order.jsp.TENDERAMOUNT"
								text="TENDER AMOUNT" />
							:&nbsp;<input type="text" value="" id="cashtenderAmt"
								style="text-align: center; color: #222222" size="4"
								autocomplete="off" onkeydown="javascript:numericcheck(event)" />
							<!-- onkeyup="javascript:getChangeAmt(this.value)" -->
						</div>
						<div style="padding: 5px; display: none;" id="cardNoDiv">
							<spring:message code="order.jsp.CARDLAST4DIGIT"
								text="CARD LAST 4 DIGIT" />
							:&nbsp;<input type="text" id="cardlastfourDigit"
								style="text-align: center; color: #222222" size="4"
								maxlength="4" />
						</div>
						<div style="padding: 3px;">
										<spring:message code="order.jsp.advance_payment_receipt"
										text="PRINT PAYMENT RECEIPT" />
									:&nbsp;<input type="checkbox"
										 value=""
										id="advancepaymentreceiptcheckbox" style="text-align: center; color: #222222"
										size="4" autocomplete="off" />  <!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
						<input type="text" id="paytypeid" style="display: none;" /> <input
							type="text" id="discamt" style="display: none;" /> <input
							type="text" id="taxamount" style="display: none;" /> <input
							type="text" id="grossamount" style="display: none;" /> <input
							type="text" id="roomServiceGross" style="display: none;" /> <input
							type="text" id="roomServiceTax" style="display: none;" /> <input
							type="text" id="roomServiceDiscount" style="display: none;" />
						<%-- <div style="padding: 5px;">
									<spring:message code="order.jsp.CHANGEAMOUNT"
										text="CHANGE AMOUNT" />
									:&nbsp;<span id="cashchangeamtcontId">0.00</span>
								</div> --%>
						<div
							style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
							id="paycashalertMsg"></div>
					</div>

					<div align="center" style="font-size: 20px;">
						<c:if
							test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
							<div style="padding: 5px;" id="billprintoption">
								<input type="checkbox" id="chkprintBillCash"
									style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;
								<spring:message code="order.jsp.PRINT" text="PRINT" />
								PAID BILL
							</div>
							<br />
						</c:if>
						<c:if
							test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
							<table class="ui-bar-a" id="n_keypad"
								style="-khtml-user-select: none;">
								<tr>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040; padding: 0 0;"
										class="btn btn-primary btn-lg" id="numero100"><img
											src="${pageContext.request.contextPath}/assets/images/base/payment/rm100.png" /></a></td>
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
										class="btn btn-primary btn-lg" id="numero50"><img
											src="${pageContext.request.contextPath}/assets/images/base/payment/rm50.png" /></a></td>
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
										class="btn btn-primary btn-lg" id="numero20"><img
											src="${pageContext.request.contextPath}/assets/images/base/payment/rm20.png" /></a></td>
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
										class="btn btn-primary btn-lg" id="numero10"><img
											src="${pageContext.request.contextPath}/assets/images/base/payment/rm10.png" /></a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040; padding: 0 0;"
										class="btn btn-primary btn-lg" id="numerorm5"><img
											src="${pageContext.request.contextPath}/assets/images/base/payment/rm5.png" /></a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="zero">0</a></td>
									<td colspan="4"><a data-role="button"
										style="border: 2px solid #404040; width: 184px;"
										data-theme="done" class="btn btn-success btn-lg" id="done"><spring:message
												code="order.jsp.EXACTAMT" text="EXACT AMT" /></a></td>
								</tr>
							</table>
						</c:if>
					</div>

				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:cancelPayment()"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						<div id="hiddenadvpaycustdataopmassagecont1"
							style="display: none;"></div>
					</button>


					<button type="button"
						onclick="javascript:finalBillPayment(document.getElementById('cashtenderAmt').value)"
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">
						<spring:message code="order.jsp.PAY" text="PAY" />
					</button>


				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" data-backdrop="static" id="checkOutModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="order.jsp.Confirmation" text="Confirmation" />
						!
					</h4>
				</div>
				<div class="modal-body" id="checkoutmodalbody"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<input type="hidden" id="detailssize" value="0">
					<div id="msg" style="text-align: center; font-size: 20px;"
						class="hide">
						<spring:message code="order.jsp.Areyousure"
							text="Are you sure to check-out?" />
						?
					</div>
					<table id="checkoutmodaltable"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr class="customtablerow">
								<!-- <th>SerialNo</th> -->
								<th colspan="2">RoomNo</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody id="checkoutmodaltablebody">

						</tbody>

					</table>
					<div id="paymentdiv" class="hide">
						Take Payment :
						<div id="fullIdDiv">
							<input type="radio" name="payment" value="F" checked>
							Full
						</div>
						&nbsp;

						<div id="partialIdDiv">
							<input type="radio" id="partialId" name="payment" value="P">
							Partial
						</div>
					</div>
					<div id="hiddenbookingid" style="display: none;"></div>
					<div id="hiddencreditFlag" style="display: none;"></div>

					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

						<button type="button"
							style="background: #F60; font-weight: bold; width: 25%;"
							class="btn btn-warning" data-dismiss="modal">
							<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						</button>
						<button type="button"
							onclick="javacsript:checkOut(document.getElementById('hiddenbookingid').value,document.getElementById('hiddencreditFlag').value)"
							style="background: #72BB4F; font-weight: bold; width: 25%;"
							data-dismiss="modal" class="btn btn-success">
							<spring:message code="order.jsp.OK" text="OK" />
						</button>

					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="showcustImgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Image</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                       		<!-- <img id="custimg" src="" class="img-thumbnail" width="200" height="136"> -->
                                       		<%-- <form action="${pageContext.request.contextPath }/room/uploadCustImage.htm" method="post" enctype="multipart/form-data"> --%>
												<div class="row" style="font-size: 16px;">
													<div class="col-sm-5 ">
														<div class="form-group">
														<label for="email">Upload JPEG File:</label>
														 <input type="file" name="fileUpload" class="form-control" id="fileUpload" />
														</div>
														<div style="margin-top: 12px;" class="form-group">
														<label for="email">Customer Name:</label>
															 <input type="text" name="custimgName" class="form-control" readonly id="custimgName" style="color: black;" /><input type="hidden" name="custimgid" id="custimgid" />
														</div>
														<div style="margin-top: 12px;" class="form-group">
														<label for="email">Customer Phone:</label>
															 <input type="text" name="custimgPhone" class="form-control" readonly id="custimgPhone" style="color: black;" />
														</div>
				
														<div style="margin-top: 12px;">
															<!-- <input type="submit" value="Upload" class="btn btn-success" style="background: #41A1E3; margin-top: 15px;"> -->
															<input type="button" onclick="uploadCustImg()" value="Upload" class="btn btn-success" style="background: #41A1E3; margin-top: 15px;">
														</div>
													</div>
													<div class="col-sm-5" style="margin-left: 12px;">
														<div style="margin-top: 12px;">
															<img id="custimg" src="" class="img-thumbnail" width="200" height="136">
														</div>
													</div>
													
												</div>
												
											<%-- </form> --%>
											<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"id="modroombookCustimgUploadalertMsg"></div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menuitems.jsp.ok" text="OK" /></button>
                                      
                                        </div>
                                    </div>
                                </div>
                            </div>	
	 <div id="printreceipt80mm" class="customprintreceipt80mmdiv hide">
			      
			     <!--  <div class="customprintreceipt80mmdiv"> -->
            
            <!-- <p id="headingparagraph" class="custom80mmheadingparagraph">RECEIPT  -->
            
            
             <h4 style="text-align:center"> <b> ${sessionScope.loggedinStore.storeName} </b> </h4> 
			             	  	   <p style="text-align:center"> (A Unit of Kar Group of Companies) <br> 
		                                             ${sessionScope.loggedinStore.address}<br>
		                                             Tel. - ${sessionScope.loggedinStore.mobileNo} <br>
		                                             E-mail : ${sessionScope.loggedinStore.emailId} <br>
		                                             website : ${sessionScope.loggedinStore.url}<br>
		                                             ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo}
			             	  	   </p> 
			             	  	   <p id="bookingNumberParagraph" class="center">Booking No:<span id="bookingNumberSpan" ></span></p>
			             	  	    <p id="roomsbookedParagraph" class="center">Room Nos:<span id="roomsbookedspan" ></span></p>
            <!-- <table id="custom80mmtableprint" class="custom80mmtable">
                <thead class="custom80mmtableheader">
                    <tr>
                           <th>Name</th>
                           <th>ContactNo</th>
                            <th>Address</th>
                              <th>InvoiceNo</th>
                               <th>BookingDate</th>
                               <th>No.Pax</th>
                              <th>CheckIn date</th>
                               <th>Time</th> 
                    </tr>
                </thead>
                <tbody id="custom80mmtablebodyprint" class="custom80mmtablebody text-nowrap">
                 
                </tbody>
            </table> -->
                <div>
		 	<%-- <p style="text-align:center;margin-top:0px;"> <b> ${sessionScope.loggedinStore.thanksLine2} </b> </p> --%>
		 	<div style="width:100%;margin-top:10px;">
		 		 <div style="width:100%"> 
		 		 		<p> <b class="text-nowrap"> Name:</b><span id="custnamespan" ></span>
		 		 		<br><br>
		 		 		     <b class="text-nowrap">Phone:</b><span id="custphonespan" ></span>
		 		 		     <br><br>
		 		 		
		 		 		<%-- <b> ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo}</b> <br> --%>
		 		 		<%-- <b> ${sessionScope.loggedinStore.gstText} :</b> ${sessionScope.loggedinStore.gstRegNo} <br> --%>
		 		 		    
		                  <b>Bill Amt :</b> <span id="netamountspan"></span> <br><br>
		                   <b>Paid Amt :</b> <span id="netpaidamountspan"></span> <br><br>
		                
		                    <b> Due Amt :</b> <span id="dueamountspan"></span> <br><br>
		                    <!--  Bank A/C No. : <span id="bankaccno"></span> <br> 
		                     Branch Name & IFSC Code : <span id="bankbarach"></span>  -->  
		 		 		     </p>
		 		  </div> 
		 		<!--  <div style="text-align:center;width:30%"> 
		 		 	  <p style="margin-top:140px"> <b> -------------------------------------- <br>
		                                              Guest's Signature </b> </p>
		 		 </div> -->
		 		
		 	</div>
		 	 <div style="text-align:right;"> 
		 		 		<p style="margin-top:70px"> <b> ------------- <br>Authorised Signature </b> </p>
		 		 </div>
		 	
		 </div>
               <!-- </div> -->
			      
			      </div> 
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
							<!-- <br> <br> -->
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Details of Customer :</b>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Name :</b><span id="cashCustName_GST"></span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Contact :</b> <span id="cashCustContact_GST"></span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Address :</b><span id="cashCustAddr_GST"></span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>State :</b><span id="cashCustState_GST"></span>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Booking Date :</b> <span id="cashReservation2100_GST">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Booking No :</b> <span id="cashInvoice2100_GST">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Check In Date :</b> <span id="cashCheckInDate_GST"></span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Check Out Date :</b> <span id="cashCheckOutDate_GST"></span>
							</div>
						</div>
					</div>

					<div style="float: left; margin-bottom: 5%;"
						id="orderitemContId_2100_GST">
						<table style="text-align: center; border-collapse: collapse;"orderItemTbl">
							<thead>
								<tr style="border-bottom: 1px dashed;">
									<th width="5%;"><spring:message
											code="reprintcash.jsp.invno" text="SNo" /></th>
									<th width="6%;"><spring:message code="room.jsp.name"
											text="Room No." /></th>
									<th width="15%;"><spring:message code="room.jsp.Category"
											text="Room Category" /></th>
									<th width="5%;"><spring:message code="purinvdet.jsp.pqty"
											text="Rate" /></th>
									<th width="5%;"><spring:message code="purinvdet.jsp.lqty"
											text="Total" /></th>
									<th width="14%;"><spring:message
											code="order.jsp.DISCPERCENTAGE" text="DISCOUNT(%)" /></th>
									<%-- <th width="5%;"><spring:message
													code="reprintcash.jsp.discamt" text="Disc Amt" /></th> --%>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs"
											text="Taxable Value" />&nbsp;</th>
									<c:choose>
										<c:when
											test="${fn:containsIgnoreCase(sessionScope.loggedinStore.country, 'India')}">
											<th width="20%;" colspan="2" id="cgstth">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="20%;" colspan="2" id="sgstth">&nbsp; <spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
										</c:when>
										<c:otherwise>
											<th width="20%;" colspan="2" id="othertaxth">&nbsp; <spring:message
													code="stockinnew.jsp.TAX" text="TAX" />(<span id="taxname"></span>)&nbsp;
											</th>
										</c:otherwise>
									</c:choose>

								</tr>

								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<c:choose>
										<c:when
											test="${fn:containsIgnoreCase(sessionScope.loggedinStore.country, 'India')}">
											<th width="5%;" id="cgstrateth"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;" id="cgstamtth" style="text-align: center;"><spring:message
													code="pos.jsp.mrpLs" text="Amt." /></th>
											<th width="5%;" id="sgstrateth"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;" id="sgstamtth"><spring:message
													code="pos.jsp.mrpLs" text="Amt." /></th>


										</c:when>
										<c:otherwise>

											<th width="5%;" id="othertaxrateth"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="8%;" id="othertaxamtth"
												style="text-align: center;"><spring:message
													code="pos.jsp.mrpLs" text="Amt." /></th>
										</c:otherwise>
									</c:choose>
								</tr>
							</thead>
							<tbody id="roomDetailsPrint2100_GST">

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
						<tr id="totalServiceTax_2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
								of Tax subject to Reverse Charges :</td>
							<td style="font-size: 14px; font-family: sans-serif;"><span
								style="padding-left: 52%" id="cashvatTax2100px_gst">00</span> <span
								style="padding-left: 16%" id="cashservTax2100_gst">00</span> <span
								style="padding-left: 5%"></span></td>

						</tr>
						<tr id="paidAmtInAdvance_2100px" style="display: none;">

							<td width="50%"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">
										Advance Paid Amount:</span></b></td>
							<td width="50%"
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="advPaidAmount2100px_gst">00</span></b></td>

						</tr>
						<tr id="paidAmtInTotal_2100px" style="display: none;">

							<td width="50%"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">
										Total Paid Amount:</span></b></td>
							<td width="50%"
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="totalPaidAmount2100px_gst">00</span></b></td>

						</tr>
						<tr id="amtToPay_2100px">

							<td width="50%"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">
										Amount To Pay :</span></b></td>
							<td width="50%"
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="amtToPay2100px_gst">00</span></b></td>
						</tr>
						<tr id="paymentMode_2100px">

							<td width="50%"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">
										Payment Mode :</span></b></td>
							<td width="50%"
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="paymentMode2100px_gst">00</span></b></td>
						</tr>
					</table>
				</div>

				<div style="text-align: center; margin-top: 30px;">
					<font
						style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
						You. Visit us Again*****</font>
				</div>
			</div>
		</div>
	</div>

	<!--New Bill Format Start  -->
	<c:choose>
		<c:when test="${sessionScope.loggedinStore.id!=167}">
			<div class="row" style="width: 100%; margin: auto; display: none;">
				<div id="printDiv2100GSTNew">
					<style>
.row {
	margin-left: 0px;
	margin-right: 0px
}

.customtable {
	border: 1px solid black;
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

.customtable th {
	text-align: center;
	padding: 2px;
	border: 1px solid black;
}

.customtable td {
	text-align: center;
	padding: 2px;
	border: 1px solid black;
}

h4 {
	margin-bottom: 0px
}

.customheight {
	border: 1px solid black;
	padding: 2px;
	border-radius: 10px;
	margin-left: 5px
}
</style>
					<!--   ..................................1st div...................................... -->
					<div style="margin: auto; width: 100%">


						<!--   ..................................1st div...................................... -->

						<div style="border: 1px solid black; border-bottom: 0px">
							<div style="display: flex; width: 100%">
								<div style="width: 20%">
									<p style="margin-left: 10px;">
										<img
											src="${pageContext.request.contextPath}/assets/images/billlogo/sweetdreamslogo.png"
											style="width: 120px; height: 120px">
									</p>
								</div>
								<div style="width: 60%">
									<h3 style="text-align: center; margin-top: 2px">
										<b> <u> INVOICE </u>
										</b>
									</h3>
									<h4 style="text-align: center">
										<b> ${sessionScope.loggedinStore.storeName} </b>
									</h4>
									<p style="text-align: center">
										(A Unit of Kar Group of Companies) <br>
										${sessionScope.loggedinStore.address}<br> Tel. -
										${sessionScope.loggedinStore.mobileNo} <br> E-mail :
										${sessionScope.loggedinStore.emailId} <br> website :
										${sessionScope.loggedinStore.url}
									</p>
								</div>
								<div style="width: 20%"></div>
							</div>



							<div style="display: flex; width: 100%">
								<div style="width: 50%">
									<!-- <p style="text-align:center;height:41px">	<img src="dokeps_residency_logo.png"> </p>
		             	 	<p style="text-align:center"> <b> A Business Class Hotel </b> </p> -->

									<div class="customheight"
										style="border: width:92%; margin-left: 5px; height: 190px;">

										<div style="display: flex; width: 100%">
											<div style="width: 28%">
												<p style="margin-top: 10px">
													<b> Name :</b>
												</p>
											</div>
											<div style="width: 72%">
												<p style="border-bottom: 1px dotted #000; margin-top: 10px">
													<span id="customerName"> 0 </span>
												</p>
											</div>
										</div>

										<div style="display: flex; width: 100%">
											<div style="width: 28%">
												<p style="margin-top: 10px">
													<b> Contact No : </b>
												</p>
											</div>
											<div style="width: 72%">
												<p style="border-bottom: 1px dotted #000; margin-top: 10px">
													<span id="customerPhone"> 0 </span>
												</p>
											</div>
										</div>

										<div style="display: flex; width: 100%">
											<div style="width: 28%">
												<p>
													<b> Address :</b>
												</p>
											</div>
											<div style="width: 72%">
												<p style="border-bottom: 1px dotted #000">
													<span id="customerAddress"> 0 </span>
												</p>
											</div>
										</div>

										<div style="display: flex; width: 100%">
											<div style="width: 28%">
												<p>
													<b> Reg. No :</b>
												</p>
											</div>
											<div style="width: 72%">
												<p style="border-bottom: 1px dotted #000">
													<span id="custgstNo"> 0 </span>
												</p>
											</div>
										</div>

										<!--  </div> -->


									</div>
								</div>
								&nbsp;
								<div style="width: 50%">

									<div class="customheight" style="width: 93%; height: 190px;">
										<div style="display: flex; width: 100%">
											<div style="width: 25%">
												<p>
													<b> Invoice No: </b>
												</p>
											</div>
											<div style="width: 75%">
												<p style="border-bottom: 1px dotted #000">
													<span id="invoiceNo"> 0 </span>
												</p>
											</div>
										</div>
										<!-- .............aparture time div................ -->
										<div style="display: flex; width: 100%">
											<div style="width: 33%">
												<p>
													<b> Booking Date</b>
												</p>
											</div>
											<div style="width: 25%">
												<p style="border-bottom: 1px dotted #000">
													<span id="bookingDate"> 0 </span>
												</p>
											</div>
											<div style="width: 17%">
												<p>
													<b> No. Pax</b>
												</p>
											</div>
											<div style="width: 25%">
												<p style="border-bottom: 1px dotted #000">
													<span id="pax"> 0 </span>
												</p>
											</div>
										</div>
										<!-- ....................Departure time div..................... -->

										<div style="display: flex; width: 100%">
											<div style="width: 33%">
												<p>
													<b> CheckIn Date </b>
												</p>
											</div>
											<div style="width: 25%">
												<p style="border-bottom: 1px dotted #000">
													<span id="checkInDate"> 0 </span>
												</p>
											</div>
											<div style="width: 17%">
												<p>
													<b> Time</b>
												</p>
											</div>
											<div style="width: 25%">
												<p style="border-bottom: 1px dotted #000">
													<span id="checkInTime"> 0 </span>
												</p>
											</div>
										</div>
										<!-- ....................Departure time div..................... -->
										<div style="display: flex; width: 100%">
											<div style="width: 33%">
												<p>
													<b> CheckOut Date </b>
												</p>
											</div>
											<div style="width: 25%">
												<p style="border-bottom: 1px dotted #000">
													<span id="checkOutDate"> 0 </span>
												</p>
											</div>
											<div style="width: 17%">
												<p>
													<b> Time</b>
												</p>
											</div>
											<div style="width: 25%">
												<p style="border-bottom: 1px dotted #000">
													<span id="checkOutTime"> 0 </span>
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>

							<h4 style="text-align: center">
								<b> <u> Particulars </u>
								</b>
							</h4>

						</div>
						<!-- ....................................2nd part...................................  -->

						<div>
							<table class="customtable">
								<tr>
									<th>Room No.</th>
									<th>Day's</th>
									<th>Rate</th>
									<th>Total</th>
									<th>CGST%</th>
									<th>CGST Amt</th>
									<th>SGST%</th>
									<th>SGST Amt</th>
									<th>Amount (Rs.)</th>
									<th>P.</th>
								</tr>
								<tbody id="bill_perticulars">
									<!--  <tr>
      <td colspan="8" style="text-align:left"> <b> Room Service </b> </td>
      <td> <p> </p> </td>
      <td> <p> </p> </td>
    </tr>
    <tr>  	
      <td colspan="8" style="text-align:left"> <b> Food / Tiffin </b> </td>
      <td> <p> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Telephone / Wi-Fi  </b> </td>
      <td> <p> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Laundry  </b> </td>
      <td> <p> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Others Charges  </b> </td>
      <td> <p> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Service Charges  </b> </td>
      <td> <p> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Sub Total  </b> </td>
      <td> <p id="subTotalAmt"> </td>
      <td> <p id="subTotalP"> </p> </td>  
    </tr> -->
									<tr>
										<td colspan="8" style="text-align: left"><b> Discount
										</b></td>
										<td>
											<p id="totalDiscAmt"></p>
										</td>
										<td>
											<p></p>
										</td>
									</tr>
									<tr>
										<td colspan="8" style="text-align: left"><b> Total </b></td>
										<td>
											<p id="totalAmt"></p>
										</td>
										<td>
											<p></p>
										</td>
									</tr>
									<tr>
										<td colspan="8" style="text-align: left"><b> Advance
										</b></td>
										<td>
											<p id="advAmt"></p>
										</td>
										<td>
											<p></p>
										</td>
									</tr>
									<!--  <tr>
      <td colspan="8" style="text-align:left"> <b> Round Off  </b> </td>
      <td> <p id="roundOffAmt"> </p> </td>
      <td> <p> </p> </td>  
    </tr> -->
									<tr>
										<td colspan="8" style="text-align: left"><b> Net
												Amount </b></td>
										<td>
											<p id="netAmt"></p>
										</td>
										<td>
											<p></p>
										</td>
									</tr>
									<tr>
										<td colspan="10" style="padding: 15px 0px">
											<div style="text-align: left; display: flex; width: 100%">
												<div style="width: 17%">
													<b> Rupees in word </b>
												</div>
												<div style="border-bottom: 1px dotted #000; width: 83%">
													aaaaaaaaaaaaaa</div>
										</td>
									</tr>
							</table>
						</div>


						<!-- ................................................3rd part.................................................. -->

						<div>
							<p style="text-align: center">
								<b> ${sessionScope.loggedinStore.thanksLine2} </b>
							</p>
							<div style="display: flex; width: 100%; padding: 10px">
								<div style="width: 34%">
									<%-- <p> <b> ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo} <br>
                     SAC CODE : 996311 <br>
                     PAN NO. : AADCK1293K <br>
                     Bank Details : <br>
                     Bank Name : State Bank of India <br>
                     Bank A/C No. : 32772398492 <br> 
                     Branch Name & IFSC Code : Contai Bazar & SBIN0012453     
 		 		</b> </p> --%>

									<p>
										<b> ${sessionScope.loggedinStore.gstText} :${sessionScope.loggedinStore.gstRegNo} <br>
											${sessionScope.loggedinStore.gstRegNo} <br> SAC CODE : <span
											id="saccode">996311</span> <br> PAN NO. : <span
											id="pancode"></span> <br> Bank Details:- <br> Bank
											Name : <span id="bankname"></span> <br> Bank A/C No. : <span
											id="bankaccno"></span> <br> Branch Name & IFSC Code : <span
											id="bankbarach"></span>
										</b>
									</p>
								</div>
								<div style="text-align: center; width: 33%">
									<p style="margin-top: 120px">
										<b> -------------------------------------- <br>
											Guest's Signature
										</b>
									</p>
								</div>
								<div style="text-align: center; width: 33%">
									<p style="margin-top: 140px">
										<b> Authorised Signature </b>
									</p>
								</div>

							</div>
							<!-- <p style="margin-left:12px"> <b> Branch Name & IFSC Code : Contai Bazar & SBIN0012453 </b> </p> -->
						</div>

						<!-- ..................................................................................................................  -->

					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row" style="width: 850px; margin: auto; display: none;">
				<div id="printDiv2100GSTNew">
					<style>
.row {
	margin-left: 0px;
	margin-right: 0px
}

.keps_resort_table {
	border: 1px solid black;
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

.keps_resort_table th {
	text-align: center;
	padding: 2px;
	border: 1px solid black;
}

.keps_resort_table td {
	text-align: center;
	padding: 2px;
	border: 1px solid black;
}

h4 {
	margin-bottom: 0px
}

.center {
	/*  text-align: center; */
	/*  padding-right: 500px; */
	padding: 500px;
	display: inline;
	text-align: center;
	/* padding-bottom:100px; */
}
</style>
					<!--   ..................................1st div...................................... -->
					<div style="border: 1px solid black; border-bottom: 0px">
						<h3 style="text-align: center; margin-top: 2px">
							<b> <u> INVOICE </u>
							</b>
						</h3>
						<div style="display: flex; width: 100%">
							<div style="width: 50%">
								<p style="text-align: center; height: 95px">
									<!-- <img src="dokeps_residency_logo.png"> -->
								</p>
								<!-- <p style="text-align:center"> <b> A Business Class Hotel </b> </p> -->

								<div
									style="border: 1px solid black; padding: 2px; height: 150px; border-radius: 10px; width: 90%; margin-left: 5px; padding: 0px 10px">

									<div style="display: flex; width: 100%">
										<div style="width: 30%">
											<p style="margin-top: 5px">
												<b> Name :</b>
											</p>
										</div>
										<div style="width: 70%">
											<p style="border-bottom: 1px dotted #000; margin-top: 5px">
												<span id="customerName"> </span>
											</p>
										</div>
									</div>
									<div style="display: flex; width: 100%">
										<div style="width: 30%">
											<p style="margin-top: 5px">
												<b> Contact No:</b>
											</p>
										</div>
										<div style="width: 70%">
											<p style="border-bottom: 1px dotted #000; margin-top: 5px">
												<span id="customerPhone"> </span>
											</p>
										</div>
									</div>

									<div style="display: flex; width: 100%">
										<div style="width: 30%">
											<p style="margin-top: 5px">
												<b> Address :</b>
											</p>
										</div>
										<div style="width: 70%">
											<p style="border-bottom: 1px dotted #000; margin-top: 5px;">
												<span id="customerAddress"></span>
											</p>
										</div>
									</div>
									<div style="display: flex; width: 100%">
										<div style="width: 30%">
											<p style="margin-top: 5px">
												<b>${sessionScope.loggedinStore.gstText} :</b>
											</p>
										</div>
										<div style="width: 70%">
											<p style="border-bottom: 1px dotted #000; margin-top: 5px;">
												<span id="custgstNo">${sessionScope.loggedinStore.gstRegNo}</span>
											</p>
										</div>
									</div>

									<!--  </div> -->
								</div>
							</div>
							<div style="width: 50%">
								<div class="center">
									<h4 style="text-align: center; font-weight: 700;">
										${sessionScope.loggedinStore.storeName}</h4>
									<p style="text-align: center; margin-top: 0px;">${sessionScope.loggedinStore.fromDes}
										<br> ${sessionScope.loggedinStore.address}<br> Tel.
										- ${sessionScope.loggedinStore.mobileNo} <br> E-mail :
										${sessionScope.loggedinStore.emailId}<br> website :
										${sessionScope.loggedinStore.url}
									</p>
								</div>

								<div
									style="border: 1px solid black; padding: 0px 10px; height: 150px; border-radius: 10px; width: 92%">
									<div style="display: flex; width: 100%">
										<div style="width: 30%">
											<p style="margin-top: 10px">
												<b> Invoice No:</b>
											</p>
										</div>
										<div style="margin-top: 0px; width: 70%">
											<p style="border-bottom: 1px dotted #000; margin-top: 10px;">
												<span id="invoiceNo"></span>
											</p>
										</div>
									</div>
									<!--  <div style="display:flex;width:100%">
		             	 	    	<div style="width:30%"> <p style="margin-top:0px"> <b> No. Person :</b> </p> </div> 
		             	 	    	<div style="margin-top:0px;width:70%"> <p style="border-bottom: 1px dotted #000;margin-top:0px;"> <span id="pax"></span> </p> </div>
	                       	  </div> -->
									<div style="display: flex; width: 100%">
										<div style="width: 33%">
											<p style="margin-top: 0px">
												<b> Booking Date:</b>
											</p>
										</div>
										<div style="width: 25%">
											<p style="border-bottom: 1px dotted #000; margin-top: 0px">
												<span id="bookingDate"></span>
											</p>
										</div>
										<div style="width: 28%">
											<p style="margin-top: 0px">
												<b> No. Person:</b>
											</p>
										</div>
										<div style="width: 14%">
											<p style="border-bottom: 1px dotted #000; margin-top: 0px">
												<span id="pax"></span>
											</p>
										</div>
									</div>
									<!-- .............aparture time div................ -->
									<div style="display: flex; width: 100%">
										<div style="width: 34%">
											<p style="margin-top: 0px">
												<b> CheckIn Date:</b>
											</p>
										</div>
										<div style="width: 24%">
											<p style="border-bottom: 1px dotted #000; margin-top: 0px">
												<span id="checkInDate"></span>
											</p>
										</div>
										<div style="width: 17%">
											<p style="margin-top: 0px">
												<b> Time:</b>
											</p>
										</div>
										<div style="width: 25%">
											<p style="border-bottom: 1px dotted #000; margin-top: 0px">
												<span id="checkInTime"></span>
											</p>
										</div>
									</div>
									<!-- ....................Departure time div..................... -->
									<div style="display: flex; width: 100%">
										<div style="width: 34%">
											<p style="margin-top: 0px">
												<b> CheckOut Date:</b>
											</p>
										</div>
										<div style="width: 24%">
											<p style="border-bottom: 1px dotted #000; margin-top: 0px">
												<span id="checkOutDate"></span>
											</p>
										</div>
										<div style="width: 17%">
											<p style="margin-top: 0px">
												<b> Time:</b>
											</p>
										</div>
										<div style="width: 25%">
											<p style="border-bottom: 1px dotted #000; margin-top: 0px">
												<span id="checkOutTime"></span>
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>

						<h4 style="text-align: center">
							<b> <u> Particulars </u>
							</b>
						</h4>

					</div>
					<!-- ....................................2nd part...................................  -->
					<div>
						<table class="keps_resort_table">
							<thead>
								<tr>
									<th>Room No.</th>
									<th>Day's</th>
									<th>Rate</th>
									<th>Total</th>
									<th>CGST%</th>
									<th>CGST Amt</th>
									<th>SGST%</th>
									<th>SGST Amt</th>
									<th>Amount (Rs.)</th>
									<th>P.</th>
								</tr>
							</thead>
							<tbody id="bill_perticulars"></tbody>
							<tfoot id="biil_footers"></tfoot>
						</table>
					</div>
					<!-- ................................................3rd part.................................................. -->

					<div>
						<p style="text-align: center; margin-top: 0px;">
							<b> ${sessionScope.loggedinStore.thanksLine2} </b>
						</p>
						<div style="display: flex; width: 100%; margin-top: 0px;">
							<div style="width: 40%">
								<p>
									<b> ${sessionScope.loggedinStore.gstText} :
										${sessionScope.loggedinStore.gstRegNo} <br> SAC CODE : <span
										id="saccode">996311</span> <br> PAN NO. : <span
										id="pancode"></span> <br> Bank Details:- <br> Bank
										Name : <span id="bankname"></span> <br> Bank A/C No. : <span
										id="bankaccno"></span> <br> Branch Name & IFSC Code : <span
										id="bankbarach"></span>
									</b>
								</p>
							</div>
							<div style="text-align: center; width: 30%">
								<p style="margin-top: 140px">
									<b> -------------------------------------- <br>
										Guest's Signature
									</b>
								</p>
							</div>
							<div style="text-align: center; width: 30%">
								<p style="margin-top: 140px">
									<b> -------------------------------------- <br>Authorised
										Signature
									</b>
								</p>
							</div>

						</div>

					</div>

					<!-- ..................................................................................................................  -->
				</div>
			</div>

		</c:otherwise>
	</c:choose>
	<!--New Bill Format End  -->

	<div class="modal fade" data-backdrop="static" id="dateextendmodal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message
							code="base.roombooking.jsp.rooms.dateextendoperation"
							text="Change Checkout Date" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<input type="text" id="lengthoflist" style="display: none;" />
					<!-- <input type="text"  id="actualcheckoutdate" style="display:none;" /> -->
					<div style="text-align: center; font-size: 20px;"
						id="chagereservation">
						<table>
							<tbody>
								<tr>
									<td style="padding-top: .5em; padding-bottom: .5em;">Checkout
										Date:</td>
									<td><input type="text" readonly id="checkoutdt"
										style="color: black;" /></td>
								</tr>
								<tr>
									<td style="padding-top: .5em; padding-bottom: .5em;">Change
										Date:</td>
									<td><input type="text" id="extendeddate"
										style="color: black;" /></td>
								</tr>
							</tbody>
						</table>
						<span id="changecheckouterrormsg"></span>

					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #F60; font-weight: bold; width: 25%;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="order.jsp.CANCEL" text="CANCEL" />
					</button>
					<button type="button"
						style="background: #72BB4F; font-weight: bold;"
						class="btn btn-success" onclick="setUpdatedRoomBooking();">
						<spring:message code="admin.rpt_inv_po_period.jsp.ok" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static"
		id="checkoutextendsuccess" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="order.jsp.Success" text="Success" />

					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message
							code="base.roombooking.checkout.checkoutdate.change"
							text="Checkout Date Change Successfully." />

					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success"
						onclick="javascript:refreshpage();">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>




	<div class="modal fade" data-backdrop="static"
		id="checkoutextendfailed" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="requisition.jsp.Alert" text="Alert" />

					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message
							code="base.roombooking.checkout.checkoutdate.notchange"
							text="Checkout Date Is Not Changed.Room Already Booked." />

					</div>
				</div>

				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>



	<div class="modal fade" data-backdrop="static" id="adddiscountmodal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<%-- <spring:message code="order.jsp.BOOKINGID" text="BOOKING ID:" /> --%>
						<span id="finalcashmodReserveCont" style="display: none;">00</span>
						BOOKING NUMBER : <span id="finalcashmodReserveContBookingNo">00</span>
					</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						<div style="padding: 5px;">
							<input type="text" value="" id="finalreserveid"
								style="display: none;" />

							<spring:message code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />
							:
							<!-- class="hide" -->
							<span id="finalcashtotamtcontId">0.00</span>
						</div>
						<div style="padding: 5px;">
							<spring:message code="order.jsp.GROSSAMMT" text="GROSS AMT" />
							<!-- class="hide" -->
							:&nbsp;&nbsp;&nbsp;<span id="finalcashgrossamtcontId">0.00</span>
						</div>


						<div style="padding: 5px; display: none;">
							<spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />
							:&nbsp;&nbsp;&nbsp;<span id="finalcashamttopaycontId">0.00</span>
						</div>
						<div id="cashpaidamtdivId" style="padding: 5px; display: none;">
							<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
							:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
								id="finalcashpaidamtcontId">0.00</span>
						</div>

						<div id="discountdiv">

							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'Y') }">
								<div style="padding: 3px;">
									<spring:message code="order.jsp.DISCPERCENTAGE"
										text="DISCOUNT(%)" />
									:&nbsp;<input type="text" value="" id="discpercentage"
										style="text-align: center; color: #222222" size="4"
										onkeyup="javascript:getDiscountAmt(this.value);"
										onkeydown="javascript:numericcheck(event);" />
									<!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.DISCAMOUNT" text="DISC AMOUNT" />
									:&nbsp;<input type="text" value="" id="discamount"
										style="text-align: center; color: #222222" size="4"
										onkeydown="javascript:numericcheck(event);" readonly />
								</div>
							</c:if>

							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'N') }">
								<div style="padding: 3px;">
									<spring:message code="order.jsp.DISCPERCENTAGE"
										text="DISCOUNT(%)" />
									:&nbsp;<input type="text" value="" id="discpercentage"
										style="text-align: center; color: #222222" size="4"
										onkeydown="javascript:numericcheck(event);" readonly />
									<!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.DISCAMOUNT" text="DISC AMOUNT" />
									:&nbsp;<input type="text" value="" id="discamount"
										style="text-align: center; color: #222222" size="4"
										onkeyup="javascript:getDiscountPercentage(this.value);"
										onkeydown="javascript:numericcheck(event);" />
								</div>
							</c:if>

							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'M') }">
								<div style="padding: 3px;">
									<spring:message code="order.jsp.DISCPERCENTAGE"
										text="DISCOUNT(%)" />
									:&nbsp;<input type="text" value="" id="discpercentage"
										style="text-align: center; color: #222222" size="4"
										onkeyup="javascript:getDiscountAmt(this.value);"
										onkeydown="javascript:numericcheck(event);" />
									<!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
								<div style="padding: 3px;">
									<spring:message code="order.jsp.DISCAMOUNT" text="DISC AMOUNT" />
									:&nbsp;<input type="text" value="" id="discamount"
										style="text-align: center; color: #222222" size="4"
										onkeyup="javascript:getDiscountPercentage(this.value);"
										onkeydown="javascript:numericcheck(event);" />
								</div>
							</c:if>
						</div>
						<span id="errormessage"></span>
						<%-- <div style="padding: 3px;">
									<spring:message code="order.jsp.CASHAMOUNT"
										text="CASH AMOUNT" />
									:&nbsp;<input type="text"
										 value=""
										id="finalcashtenderAmt" style="text-align: center; color: #222222"
										size="4" autocomplete="off" onkeydown="javascript:numericcheck(event)"/>  <!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>		 --%>
						<div
							style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
							id="finalpaycashalertMsg"></div>
					</div>



				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:canceladddiscount()"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						<div id="finalhiddenadvpaycustdataopmassagecont"
							style="display: none;"></div>
					</button>
					<button type="button"
						onclick="javascript:addingDiscount(document.getElementById('finalcashmodReserveCont').innerHTML,document.getElementById('discpercentage').value,document.getElementById('discamount').value,document.getElementById('finalreserveid').value)"
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">
						<spring:message code="order.jsp.ADD" text="ADD" />
					</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" data-backdrop="static" id="discountstatusModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="table.jsp.Alert" text="Alert" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<span id="discountmssg"></span>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #F60; font-weight: bold; width: 25%;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="admin.menuitems.jsp.cancel" text="CANCEL" />
					</button>
					<button type="button" onclick="javacsript:refreshpage()"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="admin.menuitems.jsp.ok" text="OK" />
					</button>
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

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Alert</h4>
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

	<div class="modal fade" data-backdrop="static"
		id="paymodeselectionModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="order.jsp.paymentmode" text="PAYMENT MODE" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<input type="text" id="reserveId" style="display: none;" /> <input
						type="text" id="bookingId" style="display: none;" /> <input
						type="text" id="bookingNumber" style="display: none;" /> <input
						type="text" id="discountAmt" style="display: none;" /> <input
						type="text" id="taxAmt" style="display: none;" /> <input
						type="text" id="grossAmt" style="display: none;" /> <input
						type="text" id="rbroomServiceGross" style="display: none;" /> <input
						type="text" id="rbroomServiceTax" style="display: none;" /> <input
						type="text" id="rbroomServiceDiscount" style="display: none;" />
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
						class="btn btn-success" onclick="getpaymodCheckout()">OK</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="paymentalert"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message code="rb.checkout.payment.alert"
							text="Please pay the due amount before checkout!" />
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

	<div class="modal fade" data-backdrop="static" id="roomChangeModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog modal-lg" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="rb.roombooking.roomschange"
							text="CHANGE ROOM" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff; height: 400px; overflow-y: scroll;">
					<input type="text" id="reserveId" style="display: none;" /> <input
						type="text" id="bookingId" style="display: none;" />
					<p>
						<span><spring:message
								code="rb.roombooking.roomschange.select" text="SELECT ROOM" />:</span>
						<span><select id="reservedRoomList" class="form-control"
							onchange="showSelectedRoomDetails(this.value)"
							style="margin-bottom: 2px; margin-left: 20px; color: #222222; display: inline; width: 60%;">

						</select></span>
					</p>
					<div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
						id="alertmsg"></div>
					<div style="text-align: center; font-size: 20px;"
						id="selectefRoomDetails"></div>
					<div style="text-align: center; font-size: 20px;" id="roomListDiv"></div>


				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button"
						style="background: #72BB4F; font-weight: bold;"
						class="btn btn-success" onclick="changeRoom()">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static"
		id="checkoutextendsuccess" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="order.jsp.Success" text="Success" />

					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message code="base.roombooking.roomchage.change"
							text="=Room is changed successfully." />

					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success"
						onclick="javascript:refreshpage();">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static"
		id="checkoutextendfailed" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="requisition.jsp.Alert" text="Alert" />

					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<spring:message code="base.roombooking.roomchage.notchange"
							text="Error!Room is not changed." />

					</div>
				</div>

				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static"
		id="roomChangeResponseModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="table.jsp.Alert" text="Alert" />

					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<span id="roomChangeResponseMsg"></span>

					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-success"
						onclick="javascript:refreshpage();">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="roomServiceModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog " style="margin: 100px auto; width: 1200px;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="roomservicetitle">Add Services</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff; height: 400px;">
					<input type="text" id="reserveIdForService" style="display: none;" />
					<input type="text" id="bookingIdForService" style="display: none;" />
					<table class="table table-bordered" id="tbl" style="width: 100%">
						<thead>
							<tr
								style="background: #404040; color: #FFF; font-size: 16px; font-weight: bold; border-top: 1px solid #222222;">
								<td align="center" width="">Room</td>
								<td align="center" width="">Service</td>
								<td align="center" width="">Notes</td>
								<td align="center" width="">Rate</td>
								<td align="center" width="">Qty</td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.amount" text="Amount" /></td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.taxRate" text="Tax(%)" /></td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.taxAmt" text="Tax Amt" /></td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.netAmt" text="Net Amt" /></td>
							</tr>
						</thead>
						<tbody id="tbdy">
							<tr class="item"
								style="background: #404040; color: #FFF; margin-top: 2px;">
								<td style="color: #000" align="center" width=""
									id="expenditureTypeList"><select id="selectedRomm_0"
									name="selectedRooms" class="selectedrooms" required="required"
									style="padding: 2px">

								</select></td>

								<td style="color: #000" align="center" width=""><select
									id="servicetype_0" name="servicetype" class="serviceType"
									required="required" style="padding: 2px"
									onchange="selectServiceTypeMain(this.value);">
										<option value="0">Select</option>
										<c:forEach items="${roomservicesList}" var="serviceType">
											<option value="${serviceType.id}">${serviceType.name}</option>
										</c:forEach>
								</select></td>
								<td style="color: #000" align="center" width=""><input
									type="text" id="serviceNote_0" name="servicenote"
									class="servicenote" required="required"
									style="padding: 2px; width: 200px;" /></td>

								<td style="color: #000" align="center" width=""><input
									type="text" id="serviseRate_0" name="servicerate" size="4"
									class="servicerate" required="required"
									onkeyup="setNetAmtMain(this.value);"
									onkeydown="numcheck(event);"
									style="padding: 2px; width: 100px;" /></td>
								<td style="color: #000" align="center" width=""><input
									type="text" id="serviceQty_0" class="serviceqty"
									name="serviceqty" style="padding: 2px; width: 50px;"
									onkeyup="setNetAmtMain(this.value);"
									onkeydown="numcheck(event);" value="1" /></td>
								<td style="color: #000" align="center" width=""><input
									readonly type="text" id="serviceGross_0" class="servicegross"
									name="servicegross" style="padding: 2px; width: 100px;" /></td>
								<td style="color: #000" align="center" width=""><input
									type="text" id="serviceTaxRate_0" class="servicetaxrate"
									name="servicetaxrate" style="padding: 2px; width: 50px;"
									onkeyup="setNetAmtMain(this.value);"
									onkeydown="numcheck(event);" /></td>
								<td style="color: #000" align="center" width=""><input
									readonly type="text" id="serviceTaxAmt_0" class="servicetaxamt"
									name="servicetaxamt" style="padding: 2px; width: 100px;" /></td>
								<td style="color: #000" align="center" width=""><input
									readonly type="text" id="serviceNetamt_0"
									class="servicenetamount" name="servicenetamount"
									style="padding: 2px; width: 100px;" /></td>

							</tr>

						</tbody>
					</table>
					<div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
						id="servicealertmsg"></div>
					<table class="table table-hover">
						<tr style="background: #404040; color: #FFF;">
							<td style="color: #000; text-align: center"><input
								type="button" id="add" class="btn btn-success"
								onclick="javascript:addRow('tbl')" value="+"
								style="font-size: 24px; padding: 4px 15px;" /></td>
						</tr>
					</table>


				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 10%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button"
						style="width: 10%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success" onclick="saveServices()">OK</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" data-backdrop="static"
		id="updateRoomServiceModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog " style="margin: 100px auto; width: 1200px;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Update Services</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff; height: 400px;">
					<input type="text" id="reserveIdForServiceUpdate"
						style="display: none;" /> <input type="text"
						id="bookingIdForServiceUpdate" style="display: none;" />
					<table class="table table-bordered" id="updatetbl"
						style="width: 100%">
						<thead>
							<tr
								style="background: #404040; color: #FFF; font-size: 16px; font-weight: bold; border-top: 1px solid #222222;">
								<td align="center" width="">Room</td>
								<td align="center" width="">Service</td>
								<td align="center" width="">Notes</td>
								<td align="center" width="">Rate</td>
								<td align="center" width="">Qty</td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.amount" text="Amount" /></td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.taxRate" text="Tax(%)" /></td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.taxAmt" text="Tax Amt" /></td>
								<td align="center" width=""><spring:message
										code="admin.expenditure.jsp.netAmt" text="Net Amt" /></td>
								<td align="center" width="">Action</td>
							</tr>
						</thead>
						<tbody id="tblbdy">


						</tbody>
					</table>
					<div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
						id="updateservicealertmsg"></div>
					<table class="table table-hover">
						<tr style="background: #404040; color: #FFF;">
							<td style="color: #000; text-align: center"><input
								type="button" id="add" class="btn btn-success"
								onclick="javascript:addNewRow('updatetbl')" value="+"
								style="font-size: 24px; padding: 4px 15px;" /></td>
						</tr>
					</table>


				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 10%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button"
						style="width: 10%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success" onclick="updateServices()">UPDATE</button>
				</div>
			</div>
		</div>
	</div>



<div class="modal fade" data-backdrop="static" id="addguestmodal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog " style="margin: 100px auto; width: 1200px;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="addguestmodaltitle">Add Guest</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff; height: 400px;">
					 <input type="text" id="bookingId" style="display: none;" />
					<input type="text" id="bookingNumber" style="display: none;" />
					<table class="table table-bordered" id="addguestmodaltable" style="width:100%">
						<thead>
							<tr
								style="background: #404040; color: #FFF; font-size: 16px; font-weight: bold; border-top: 1px solid #222222;">
								<td align="center" >Name</td>
								<td align="center" >ContactNumber</td>
								<td align="center" >Email Id</td>
								<td align="center" >Address</td>
								<td align="center" >Gender</td>
								<td align="center" >UniqueIdType</td>
								<td align="center" colspan="2">UniqueidNo</td>
								
							</tr>
						</thead>
						<tbody id="addguestmodaltablebody">
							<!-- <tr class="item"
								style="background: #404040; color: #FFF; margin-top: 2px;">
								<td style="color: #000" align="center" 
									id="tdguestname"><input type="text" id="guestname" disabled></input></td>

								<td style="color: #000" align="center" width="" id="tdcontactnumber"><input type="number" id="guestcontact" disabled></input></td>
								<td style="color: #000" align="center" width="" id="tdemail"><input
									type="text" id="email"style="padding: 2px; width: 200px;" disabled /></td>

								<td style="color: #000" align="center" width="" id="tdaddress"><input
									type="text" id="guestaddress" disabled /></td>
								<td style="color: #000" align="center" width="" id="tdgender">
								<select id="gender" disabled>
								<option value="M">Male</option>
								<option value="F">Female</option>
								</select>
								
								</td>
								<td style="color: #000" align="center" width="" id="tdUniqueIdType">
								<select id="uniqueIdType" disabled>
								
								</select>
								
								</td>
								<td style="color: #000" align="center" width="" id="tduniqueId"><input  type="text" id="uniqueId" disabled /></td>
								<td style="text-align:center" width="" id="cancelguesttablerow" class="hide" ><input type="button" class="btn btn-danger" value="X"></td>
								

							</tr> -->

						</tbody>
					</table>
					<!-- <div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
						id="addFurtherGuestRowButtonDiv"></div> -->
						
						<div style="background: #404040; color: #FFF;">
						<div style="color: #000; text-align: center"><input
								type="button" id="addFurtherGuestRowButton" class="btn btn-success"
								onclick="javascript:addTableRowForGuestTable(false)" value="+"
								style="font-size: 24px; padding: 4px 15px;" />
						</div>
						</div>
					


				</div>
				<div class="modal-footer" id="addguestmodalfooterdiv"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" id="cancelguestbutton"
						style="width: 10%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button" id="addguestbutton"
						style="width: 150px; background: #72BB4F; font-weight: bold;"
						class="btn btn-success" onclick="javascript:addGuest()">ADD GUEST</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="addcreditcustomermodal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;  width:50%;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<%-- <spring:message code="order.jsp.BOOKINGID" text="BOOKING ID:" /> --%>
						<!-- <span id="finalcashmodReserveCont" style="display: none;">00</span> -->
						BOOKING NUMBER : <span id="bookingnumberspan">00</span>
					</h4>

				</div>
				<!-- <div class="modal-body"
					style="background: #404040;border-top: 1px solid #404040;  color: #fff;"> -->
					<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						

						<div id="customercreditmodalbody">

							
								<div style="padding: 3px;" class="hide">
									BOOKING ID
									:&nbsp;<input type="text" disabled  id="bookingIdForCreditCustomerModal" style="text-align: center; color: #222222" size="4" >
									
								</div>
								
								<div style="padding: 3px;" class="hide" >
									CUSTOMER JSON OBJECT
									:&nbsp;<input type="text" disabled  id="customerIdJsonObjectForCreditCustomerModal" style="text-align: center; color: #222222" size="4" >
									
								</div>
								<div style="padding: 3px;" class="hide" >
									NET AMOUNT
									:&nbsp;<input type="text" disabled  id="netamountForCreditCustomerModal" style="text-align: center; color: #222222" size="4" >
									
								</div>
								<div style="padding: 3px;" class="hide" >
									DUE AMOUNT
									:&nbsp;<input type="text" disabled  id="dueamountForCreditCustomerModal" style="text-align: center; color: #222222" size="4" >
									
								</div>
								<div style="padding: 3px;" class="hide">
									BOOKING NUMBER
									:&nbsp;<input type="text" disabled  id="bookingNumberForCreditCustomerModal" style="text-align: center; color: #222222" size="4" ">
								</div>
							
						</div>
						<span id="errormessageforcreditcustomermodal"></span>
						
						
					</div>



				</div>
				<div class="modal-footer" id="addcreditcustomermodalfooter"
					style="background: #404040;border-top: 1px solid #404040;">
					<button type="button" 
						style="width: 30%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						
					</button>
					<button type="button" id="converttocreditcustomerbutton"
						onclick="javascript:convertToCreditCustomer()"
						style="width: 40%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">
						<spring:message code="admin.storecustmgnt.jsp.convertcreditCust" text="CONVERT TO CREDIT CUSTOMER" />
					</button>
					<button type="button"
						onclick="javascript:convertToCreditBooking()"
						style="width: 40%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success hide"  id="converttocreditbookingbutton">
						<spring:message code="admin.storecustmgnt.jsp.convertcreditBooking" text="CONVERT TO CREDIT BOOKING" />
					</button>
					
				</div>
			</div>
		</div>
	</div>

 <div class="modal fade" data-backdrop="static" id="alertmessagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel2"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="alertmodalbody"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/checkout/welcome.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>






	<!-- modal ends -->

	<!-- CONTENT-WRAPPER SECTION END-->


	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/hotelBaseScript.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<%-- <script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script> --%>
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	  <!-- Core files For Using Jalert -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery.alerts.js"></script>
	<link href="${pageContext.request.contextPath}/assets/css/jquery.alerts.css"	rel="stylesheet" />
    
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	 <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

	<script
		src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/numerickey.js"></script>

	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";
		var waiterNameFlag = "${sessionScope.loggedinStore.waiterNameFlag}";
		var fromdate="${fromSpecificDate}";
		var todate="${toSpecificDate}";
		var storeID="${sessionScope.loggedinStore.id}";
		var directBooking="${directBooking}";
		var frontDeskPerson = "${sessionScope.loggedinUser.contactNo}";
		var custId=null;
		var storeAddr = "${sessionScope.loggedinStore.address}";
		var storeName = "${sessionScope.loggedinStore.storeName}";
		var storeEmail = "${sessionScope.loggedinStore.emailId}";
		var storePhNo = "${sessionScope.loggedinStore.phoneNo}";
		var storeCountry = "${sessionScope.loggedinStore.country}";
		var discountpercentage = "${sessionScope.loggedinStore.discountPercentage}";
		var billprint = "${sessionScope.loggedinStore.printPaidBill}";
		var currency = "${sessionScope.loggedinStore.currency}";
		var is_Acc='${sessionScope.loggedinStore.is_account}';
		var todesc = "${sessionScope.loggedinStore.toDes}";
		
		var roomservices =[];
		    roomservices = '${roomservices}';
		var idjson=getAllUniqueId();
		
		for(var i=0;i<idjson.length;i++){
			
		    var obj=idjson[i];
			var option="<option value="+obj.id+">"+obj.name+"</option>"
			$("#uniqueIdType").append(option);
			
		}
		 <%  
		  String responseString ="";
	      Gson gson =new Gson();
	     Customer obj=(Customer)session.getAttribute("loggedinUser"); 
	    responseString =gson.toJson(obj);
		  String today ="";
		  DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	      today = formatter.format(new Date());
	    %>
		   
		   var customerstring ='<%=responseString%>'
		   var customer=JSON.parse(customerstring);
		   var todaydate='<%=today%>'
		    
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
			
			
			
			
			var today = new Date();
			 $('[data-toggle="popover"]').popover(); 
					
				$('#fromdateroomsearch').datepicker({
					
					format : "yyyy-mm-dd",
					autoclose : true,
					startDate : '-4m',
					endDate : '+4m',
				});

				$('#todateroomsearch').datepicker({
					
					format : "yyyy-mm-dd",
					autoclose : true,
					startDate : '-4m',
					endDate : '+4m'
				});
				
				$('#modroombookcustdob').datepicker({
					format : "yyyy-mm-dd",
					autoclose : true,
					endDate: '0'
				});	
				
				 $('#checkoutdetailslist').DataTable( {
				        paging:false,
				        "info"  : false,
				        "columnDefs": [{
				            "defaultContent": "-",
				            "targets": "_all"
				          }]
				    } );
				 $('#extendeddate').datepicker({						
						format : "yyyy-mm-dd",
						defaultDate: "+1w",
						autoclose : true,				
					    startDate: today,
						endDate : '+1m',										
					});
				 
		});
		
	/* 	function clickDate() {
			
			console.log('worked');
			document.getElementById('paxroomCatsearchDiv').style.display = 'none';
		} */
		
		
		  function showCancelReservationModal(reserveId)
		   {
				
			  document.getElementById('cancelcustdataopmassagecont').innerHTML='are you sure to delete reserved id' + " " + reserveId + '?';
			
			  document.getElementById('hiddencustdataopmassagecont').value=reserveId;

			  $('#confirmCancelCustomerModal').modal('show');
			  
		   }
		
		 function showalertsearchRoomModal()
			{
			  	$('#alertsearchroomModal').modal('show');
			}
		   function showalertsearchRoomGreaterModal()
			{
			  	$('#alertsearchroomgreaterModal').modal('show');
			}
		   
		   function showsuccessbookopModal()
			{
			  	$('#successRoomBookDataopModal').modal('show');
			}
		  
		   
		   function showCheckOutRoomModal(bookingId ,creditFlag) {
			   //debugger
				//hiddenbookingid
				//$("#paymentdiv").addClass("hide");
			   
			  // console.log("DET IS:");
			   //console.log(custIdObject2);
				document.getElementById('hiddenbookingid').value = bookingId;
				$("#hiddencreditFlag").val(creditFlag);
				$("#checkoutmodaltablebody").empty();
				var res = getBillDetailsByBookingNumber(bookingId);
				var div = "";
				var roomlist = "";
				var myvar = "";
				var status = "";
				//console.log("RES AFTER CLICKING CHECKOUT MODAL IS");
				//console.log(res);
				//cashmodReserveCont
				if (res != null) {
					res.filter(function (o) {
						roombookdetaillist = o.bookingDetail;
						if (roombookdetaillist != "" && roombookdetaillist.length > 1) {
							roombookdetaillist.filter(function (m) {
								var is_checkedin = m.isCheckIn;
								var is_checkedout = m.isCheckOut;
								status = (is_checkedin == "Y" && is_checkedout == "N") ? "CheckedIn" : (is_checkedin == "Y" && is_checkedout == "Y") ? "CheckedOut" : "";
								// id="td'+m.id

								if (status == "CheckedOut") {
									myvar = '      <tr  class="customtablerow"  id="' + m.id + '"' + '>' +
										 '        <td class="input">' + '<input type="checkbox" id="idck" checked disabled>' + '</td>' + 
										'        <td>' + m.roomId.roomNo + '</td>' +
										'        <td>' + status + '</td>' +
										'      </tr>'
										
								} else {
									myvar = '      <tr  class="customtablerow"  id="' + m.id + '"' + '>' +
										'        <td class="input">' + '<input type="checkbox" id="idck" checked>' + '</td>' +
										'        <td>' + m.roomId.roomNo + '</td>' +
										'        <td>' + status + '</td>' +		
										'      </tr>'
										
								}

								$("#checkoutmodaltablebody").append(myvar);
							});
						}
					});

					//$("#detailssize").val(roombookdetaillist.length);
					if (roombookdetaillist.length == 1) {
						$("#checkoutmodaltable").addClass("hide");
						$("#msg").removeClass("hide");
						$("#detailssize").val(0);
					} else {
						$("#checkoutmodaltable").removeClass("hide");
						$("#msg").addClass("hide");
						$("#detailssize").val(roombookdetaillist.length);
					}

				}
				
				
				$('#checkOutModal').modal('show');
			}

		   function showPaymentModal(bookingId,reserveId,paymentMode,id,bookingno,discamt,taxamt,grossAmt,roomServiceGross,roomServiceTax,roomServiceDiscount)
		   {
			   //debugger
			  // document.getElementById('hiddencustdataopmassagecont').value=bookingId;cashmodReserveCont			  
			  //document.getElementById('discountdiv').style.display = "none";
			   $("#advancepaymentreceiptcheckbox").prop("checked",false);
			   $("#cashtenderAmt").val("");
			   $("#cardlastfourDigit").val("");
			   $("#roomsbookedspan").html("");
			  document.getElementById('paytypeid').value = id;
			  document.getElementById('discamt').value = discamt;
			  document.getElementById('taxamount').value = taxamt;
			  document.getElementById('grossamount').value = grossAmt;
			  document.getElementById('cashtenderAmt').value = '';
			  document.getElementById('cashmodReserveCont').innerHTML=bookingId;
			  document.getElementById('cashmodReserveContBookingNo').innerHTML=bookingno;
			  
			  document.getElementById('roomServiceGross').value=roomServiceGross;
			  document.getElementById('roomServiceTax').value=roomServiceTax;
			  document.getElementById('roomServiceDiscount').value=roomServiceDiscount;
			  
			  document.getElementById('hiddenadvpaycustdataopmassagecont1').value=reserveId;
			  amountCalculationToPayRoom(bookingId);//cashamttopaycontId
			  if(billprint ==  'N'){
			  document.getElementById('billprintoption').style.display = "none";
			  }
			  
			  document.getElementById('onlineselpaymenttype').innerHTML = paymentMode ;
			   
			   if(id == 1){
				   $("#cardNoDiv").css("display","none"); 
			   }else if(id == 2){
				   $("#cardNoDiv").css("display","block"); 
			   }else{
				   $("#cardNoDiv").css("display","none"); 
			   }
				  $('#cashModal').modal('show');
				  
				
		   }

			 function showalertcatdataopModal()//sa
				{
				 
					$('#alertcatdataopModal').modal('show');
				}
			 function alertRoomBookDataopModal()
				{
				  	$('#alertRoomBookDataopModal').modal('show');
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
			          return false;
			       }
			       return true;
			     }
			
			/*  $(function() {
			        $("#custNameSearch")
			                .autocomplete(
			                        {
			                            source : function(request, response) {
			                                $.ajax({
			                                            url : "${pageContext.request.contextPath}/order/searchcustbyname.htm",
			                                            type : "GET",
			                                            data : {
			                                             term : request.term,
			                                             fromDate : document.getElementById('fromdateroomsearch').value,
			                                             toDate : document.getElementById('todateroomsearch').value,
			                                             func : "CO"
			                                            },

			                                            dataType : "json",

			                                            success : function(data) {
			                                              custname=JSON.parse(data);
			                                             console.log(custname);				                                             
			                                         
				                		                         $("#modroombookcustIdhidden").val('');
				                		                           
				                		                        	$("#modroombookcustPhone").val('');
				                		                        	$("#modroombookcustName").val('');
				                		                        	$("#modroombookcustEmail").val('');
				                		                        	$("#modroombookcustGender").val('S');
				                		                        	$("#modroombookcustdob").val('');
				                		                        	$("#modroombookcustAddress").val("");
				                		                        	$("#modroombookcusthouseno").val("");
														    $("#modroombookcuststreet").val("");
														    $("#modroombookcustLocation").val("");
														    $("#modroombookcuststate").val("");

														    custId='0';
			                                              if(data==null){
			                                             }
			                                              else{
			                                              console.log("in else");
			                                              response($.map(
			                                                custname,
			                                                                 function(v) {
			                                                                     return {
			                                                                         label : v.name,
			                                                                         phno:v.phone,
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

			                           		$("#modroombookcustIdhidden").val(ui.item.custId);
			                        			$("#modroombookcustName").val(ui.item.label);
			                        			$("#modroombookcustPhone").val(ui.item.phno);
			                        	 		custId=ui.item.custId;   
			                        	 		
			                        	 		getCheckInDetailsOfselectedCustomer(custId);
			                             }
			                          	                            
			                        })
			        .data( "ui-autocomplete" )._renderItem = function( ul, cust ) {
			         return $( "<li></li>" )
			          .data( "ui-autocomplete-item", cust )
			          .append( "<a>" + cust.label + "(" + cust.phno + ")</a>" )
			          .appendTo( ul ); 
			        };
			    }); 
			    
			    
			    $(function() {
			 
			        $("#custContactSearch")
			                .autocomplete(
			                        {
			                            source : function(request, response) {
			                                $.ajax({
			                                            url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
			                                            type : "GET",
			                                            data : {
			                                             term : request.term,
			                                             fromDate : document.getElementById('fromdateroomsearch').value,
			                                             toDate : document.getElementById('todateroomsearch').value,
			                                             func : "CO"
			                                            },

			                                            dataType : "json",

			                                            success : function(data) {
			                                             var custname=JSON.parse(data);
			                                             console.log(custname);

			                                             $("#modroombookcustIdhidden").val('');
		                		                           
		                		                        		$("#modroombookcustPhone").val('');
		                		                        		$("#modroombookcustName").val('');
		                		                        		$("#modroombookcustEmail").val('');
		                		                        		$("#modroombookcustGender").val('S');
		                		                        		$("#modroombookcustdob").val('');
		                		                        		$("#modroombookcustAddress").val("");
		                		                        		$("#modroombookcusthouseno").val("");
												    		$("#modroombookcuststreet").val("");
												    		$("#modroombookcustLocation").val("");
												    		$("#modroombookcuststate").val("");

													     custId='0';
			                                              if(data.length==0){		                                            
			           									  }else{
			                                              response($.map(
			                                                custname,
			                                                                 function(v) {
			                                                                     return {
			                                                                         label : v.phone,
			                                                                         name:v.name,
			                                                                         phno:v.phone,
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

			                           		$("#modroombookcustIdhidden").val(ui.item.custId);
			                        			$("#modroombookcustName").val(ui.item.name);
			                        			$("#modroombookcustPhone").val(ui.item.phno);
			                               		custId=ui.item.custId;		
			                               		getCheckInDetailsOfselectedCustomer(custId);
			                             }
			                            
			                        })
			         .data( "ui-autocomplete" )._renderItem = function( ul, cust ) {
			         return $( "<li></li>" )
			          .data( "ui-autocomplete-item", cust )
			          .append( "<a>" + cust.label + "(" + cust.name + ")</a>" )
			          .appendTo( ul ); 
			        }; 
			    });
			     */
			     var custname;
			     $(function() {
			         $("#custNameSearch")
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
					                           			
					                           			
					                           		}
			                                /*  $.ajax({
			                                             url : "${pageContext.request.contextPath}/order/searchcustbyname.htm",
			                                             type : "GET",
			                                             data : {
			                                              term : request.term
			                                             },

			                                             dataType : "json",

			                                             success : function(data) {
			                                               custname=JSON.parse(data);
			                                              console.log(custname);
			                                              
			                                               if(data==null){ }
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
			                            	    $("#modroombookcustIdhidden").val(ui.item.custId);
			                        			$("#modroombookcustName").val(ui.item.label);
			                        			$("#modroombookcustPhone").val(ui.item.phno);
			                        	 		custId=ui.item.custId; 
			                        	 		getCheckInDetailsOfselectedCustomer(custId);
			                              }

			                         })
			       
			     });
			     $(function() {
			         $("#custContactSearch")
			                 .autocomplete(
			                         {
			                             source : function(request, response) {
			                            	 if (request.term.length >= 3) { 
			                            		 var searchterm=request.term;
				                            		var is_phone=true;
				                            		var res=getCustomerDetailsByPhoneOrName(storeID,searchterm,is_phone);
				                            		if(res!=null && res!=""){
				                            			 response($.map(
			                                            		   res,
			                                                                  function(v) {
			                                                                      return {
			                                                                    	  label : v.contactNo,
			                                                                          phno:v.contactNo,
			                                                                          addr:v.address,
			                                                                          custId:v.id,
			                                                                          name:v.name,
			                                                                          items:v,
			                                                                          
			                                                                      };

			                                                                  }));
				                            			
				                            			
				                            		}
			                                /*  $.ajax({
			                                			url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
			                                     		type : "GET",
			                                             data : {
			                                              term : request.term
			                                             },

			                                             dataType : "json",

			                                             success : function(data) {
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
			                                                                          name:v.name,
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
			                            	 $("#modroombookcustIdhidden").val(ui.item.custId);
			                        		 $("#modroombookcustName").val(ui.item.name);
			                        		 $("#modroombookcustPhone").val(ui.item.phno);
			                               	 custId=ui.item.custId;		
			                               	getCheckInDetailsOfselectedCustomer(custId);
			                              }

			                         })
			       
			     });
			     
			     
			    
			   /*  $(function() {
			        $("#bookingIdSearch")
			                .autocomplete(
			                        {
			                            source : function(request, response) {
			                                $.ajax({
			                                            url : "${pageContext.request.contextPath}/checkout/searchbookingid.htm",
			                                            type : "GET",
			                                            data : {
			                                             term : request.term,
			                                             fromDate : document.getElementById('fromdateroomsearch').value,
			                                             toDate : document.getElementById('todateroomsearch').value
			                                            },

			                                            dataType : "json",

			                                            success : function(data) {
			                                              custname=JSON.parse(data);
			                                             console.log(custname);				                                             
			                                              if(data==null){
			                                             }
			                                              else{
			                                              console.log("in else");
			                                              response($.map(
			                                                custname,
			                                                                 function(v) {
			                                                                     return {
			                                                                         id:v.id,
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

			                            	bookId=ui.item.id;   
			                        	 		getBookingDetailsofBookinId(bookId);
			                        	 		//getReserveDetailsOfReserveId(resId);
			                             }
			                          	                            
			                        })
			         .data( "ui-autocomplete" )._renderItem = function( ul, cust ) {
			         return $( "<li></li>" )
			          .data( "ui-autocomplete-item", cust )
			          .append( "<a>" + cust.id + "</a>" )
			          .appendTo( ul ); 
			        }; 
			    });
			     */
			    
		   
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
<script>

</script>



