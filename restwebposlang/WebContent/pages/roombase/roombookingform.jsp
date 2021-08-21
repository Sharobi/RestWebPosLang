<%@page import="com.sharobi.webpos.adm.model.StoreCustomer"%>
<%@page import="com.sharobi.webpos.roombooking.adm.model.RoomBookingType"%>
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
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/customstyle.css"
	rel="stylesheet" />	
	<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
	<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
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
     ::-webkit-scrollbar {
            width: 3px;
            }
     ::-webkit-scrollbar-thumb {
      border-radius: 10px;
     -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
          }
          
          
        .customformcontrol {
    height: 34px!important;
    padding: 6px 12px!important;
    font-size: 14px!important;
    line-height: 1.42857143!important;
    color: #555!important;
    background-color: #fff!important;
    background-image: none!important;
    border: 1px solid #ccc!important;
    border-radius: 4px!important;
   -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075)!important;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075)!important;
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s!important;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s!important;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s!important;  
}  
     </style>
      <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
</head>
<body onload="showCustomerBookingForm(&quot;${directBooking}&quot;)"> <%--  ,showBookingSuccess(&quot;${bookingId}&quot;) --%>

	<c:set var="today" value="<%=new java.util.Date()%>" />
	<fmt:formatDate value="${today}" var="todaydate" pattern="yyyy-MM-dd"/> 
	<jsp:include page="/pages/common/header.jsp"></jsp:include>

	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
			
				<div class="col-md-12 col-sm-12" style="height:150px;" align="center">
				<div style="margin-top:15px;">
					<span style="color:#FFF; font-size:22px; font-weight:bold;"><spring:message code="base.room.jsp.ProcessReservation" text="CANCEL ROOM RESERVATION / ADVANCE PAYMENT / CHECK IN" /></span>
				</div>
				<div style="margin-top:15px;">
					
					<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.ReservationDetails" text="Reservation Details Between  " /></span>
					<c:if test="${!empty fromdate}">
							<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.frmDate" text="From Date:" /></span>
							<input type="text" id="fromdateroomsearch" readonly="readonly" size="10" value="${fromdate}" />"> 
                    			<c:set var="fromSpecificDate" value="${fromdate}" />
						</c:if>

						<c:if test="${!empty todate}">
							<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.toDate" text="To Date:" /></span>
                    			<input type="text" id="todateroomsearch" readonly="readonly" size="10" value="${todate}" />">
                    			<c:set var="toSpecificDate" value="${todate}" />
						</c:if>
						<c:if test="${empty fromdate}">
						 <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="base.room.jsp.frmDate" text="From Date:" /></span>
						   <input type="text" id="fromdateroomsearch" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
							<c:set var="fromSpecificDate" value="${today}" />
							<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
									code="base.room.jsp.toDate" text="To Date :" /></span>
							<input type="text" id="todateroomsearch" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">
							<c:set var="toSpecificDate" value="${today}" />
						</c:if>
						<span style="color:#FFF; font-size:16px; font-weight:bold;">Booking Number:</span>
						<input type="text" id="reserveIdSearch"
										value=""
										style="color: #222222; margin-left: 0%; width: 10%;"
										placeholder="BOOKING NUMBER" maxlength="10"> 
						
						<input type="hidden" id="hiddateroomsearch" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
							
                   <fmt:formatDate pattern="yyyy-MM-dd" value="${today}" var="currentDate"/>
                   	<a href="javascript:searchReservedCustAvailability(document.getElementById('fromdateroomsearch').value,document.getElementById('todateroomsearch').value,${sessionScope.loggedinUser.storeId},document.getElementById('reserveIdSearch').value)" class="btn btn-success" style="background:#0CF;margin-bottom: 3px;"><spring:message code="base.room.jsp.search" text="SEARCH" /></a>
                </div>
              
               	 <div style="margin-top:15px; font-size: 12px; font-weight: bold;"  align="center">
               	                    <span  style="color:#FFF; font-size:16px; font-weight:bold;">Search By Customer:</span> 
									<input type="text" id="custNameSearch"
										value=""
										style="color: #222222; margin-left: 1%; width: 10%;"
										placeholder="CUSTOMER NAME"
										onkeypress='return lettersOnly(event)'> 
									 <input
										type="text" id="custContactSearch"
										value=""
										style="color: #222222; margin-left: 1%; width: 10%;"
										placeholder="CONTACT NO." maxlength="10"
										onkeypress='return isNumberKey(event)'>  
								</div> 
			</div>
			
				<div class="col-md-12 col-sm-12">
					<div style="height: 100%; width: 100%;">
						<div style="height: 500px; overflow-y: auto;" id="roomlayoutid">
						
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
						
						
					<!-- 	<div class="panel-body"> -->
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-bordered" id="reservedetailslist">
                                    <thead style="background:#000; color:#FFF; font-size: 12px;">
                                        
                                            <th style="text-align:center;"><spring:message code="rb.admin.roombooking.bookingno" text="BOOKING NO." /></th>
                                            <th style="text-align:center;"><spring:message code="rb.admin.roombooking.refno" text="REF NO." /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.fromdate" text="FROM DATE" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.todate" text="TO DATE" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.name" text="CUST. NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.phno" text="PHONE NO." /></th>
                                            <%-- <th style="text-align:center;"><spring:message code="base.roombooking.jsp.email" text="EMAIL" /></th> --%>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.rooms" text="ROOMS" /></th>
                                            <th style="text-align:center;"><spring:message code="rb.roombooking.roomschange" text="CHANGE ROOM" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.cancel" text="CANCEL" /></th>
                                           
                                           <c:if test="${toSpecificDate >= currentDate}">
                                            		<th style="text-align:center;width:10%;"><spring:message code="base.roombooking.jsp.advpay" text="ADVANCE PAYMENT" /></th>
                                            		<th style="text-align:center;"><spring:message code="rb.roombooking.printbill" text="PRINT BILL" /></th>  
                                            		<th style="text-align:center;"><spring:message code="base.roombooking.jsp.checkin" text="CHECK IN" /></th>
                                  		  </c:if>
                                    </thead>
                                
                                    <tbody style="background:#000; color:#FFF;">
                                    <c:if test="${empty allreservedDetails}">
                                        	<tr style="background:#000; font-size: 14px; color:#FFF;">
                                        		<td colspan="13"><spring:message code="admin.menumgnt.jsp.nodatafound" text="No Data found!" /></td>
                                        	</tr>
                                        </c:if>
									<c:if test="${!empty allreservedDetails}">
										<c:forEach items="${allreservedDetails}" var="reservedDetails" varStatus="status">
												<c:if test="${reservedDetails.isCheckedIn != 'Y'}">			
													<tr style="background:#000; font-size: 14px; color:#FFF;" align="center">
													
														<td style="line-height: 1.4; padding: 6px;">${reservedDetails.bookingNo}</td>
														<td style="line-height: 1.4; padding: 6px;">${reservedDetails.refNo}</td>
														<td style="line-height: 1.4; padding: 6px;">${reservedDetails.checkInDate}</td>
														<td style="line-height: 1.4; padding: 6px;">${reservedDetails.checkoutDate}</td>
														<td style="line-height: 1.4; padding: 6px;"><a href="javascript:showCheckInRoomModal(&quot;0&quot;,${reservedDetails.custId.id})">${reservedDetails.custId.name}</a></td>
														<td style="line-height: 1.4; padding: 6px;"><a href="javascript:showCustImage(${reservedDetails.custId.id})">${reservedDetails.custId.contactNo}</a></td>
														<%-- <td style="line-height: 1.4; padding: 6px;">${reservedDetails.custId.emailId}</td> --%>
														
														<c:set var="roomNumbers" value=""></c:set>
														<c:set var="roomIds" value=""></c:set>
														<c:set var ="totalRoomReserved" value="${fn:length(reservedDetails.bookingDetail) - 1}" />					
														 <c:set var="custIdObject" value="${reservedDetails.custId}"/>
														 <c:set var="bookingTypeObjectTemp" value="${reservedDetails.bookingType}"></c:set>
																	 <%StoreCustomer obj = null; 
																	String json="";
																	obj =(StoreCustomer)pageContext.getAttribute("custIdObject"); 
													              //System.out.println(" STORE  OBJECT IS:"+obj); 
															    Gson gson = new Gson();
															    json=gson.toJson(obj);
															    //System.out.println(" STORE JSON  OBJECT IS:"+json); 
															    pageContext.setAttribute("custIdObject2", json);											    
												
															    %>  
															    
															    <%RoomBookingType robj = null; 
																	String json2="";
																	robj =(RoomBookingType)pageContext.getAttribute("bookingTypeObjectTemp"); 
													              //System.out.println(" STORE  OBJECT IS:"+obj); 
															    Gson gson2 = new Gson();
															    json2=gson2.toJson(robj);
															    //System.out.println(" STORE JSON  OBJECT IS:"+json); 
															    pageContext.setAttribute("bookingTypeObject", json2);											    
												
															    %>  
														
														<c:forEach items="${reservedDetails.bookingDetail}" var="roomDetails" varStatus="loop">
											                <c:choose> 
			               										<c:when test="${ roomNumbers=='' && (loop.index < totalRoomReserved || totalRoomReserved<=0)}"> 
			                    							 	 	<c:set var ="roomNumbers" value="${roomDetails.roomId.roomNo}" /> 
			                    							 	 	<c:set var ="roomIds" value="${roomDetails.roomId.id}" /> 
			              									 	</c:when> 
			               										<c:when test="${loop.index < totalRoomReserved && roomNumbers!=''}">
			                 										<c:set var ="roomNumbers" value="${roomNumbers},${roomDetails.roomId.roomNo}" /> 
			                 										<c:set var ="roomIds" value="${roomIds},${roomDetails.roomId.id}" /> 
			                									</c:when> 
			                									<c:otherwise> 
			               									  		<c:set var ="roomNumbers" value="${roomNumbers},${roomDetails.roomId.roomNo}" /> 
			               									  		<c:set var ="roomIds" value="${roomIds},${roomDetails.roomId.id}" /> 
			                									</c:otherwise>
		                 								  </c:choose>
														</c:forEach>
														<td style="line-height: 1.4; padding: 6px;">
														${roomNumbers}
														<%-- <input type="button" id="add" class="btn btn-success" onclick="javascript:addFurtherRoomsModalFunc(&quot;${reservedDetails.checkInDate}&quot;,&quot;${reservedDetails.checkoutDate}&quot;,&quot;${reservedDetails.bookingNo}&quot;,&quot;${custIdObject2}&quot;)" value="+"> --%>
														<c:if test="${reservedDetails.checkoutDate!=todaydate}">
														<input type="button" id="addFurtherRoomsModalOpeningButton" class="btn btn-success"  value="+" onclick='javascript:addFurtherRoomsModalFunc("${reservedDetails.checkInDate}","${reservedDetails.checkoutDate}","${reservedDetails.bookingNo}","${reservedDetails.id}","${roomIds}",${custIdObject2},${bookingTypeObject},"${reservedDetails.checkinTimeId}","${reservedDetails.checkoutTimeId}")' />
														</c:if>
														</td>
														
														<td align="center"><a href="javascript:openChangeRoomModal(&quot;${reservedDetails.id}&quot;,&quot;${reservedDetails.id}&quot;,'${reservedDetails.checkInDate}','${reservedDetails.checkoutDate}',&quot;${roomNumbers}&quot;,&quot;${roomIds}&quot;)"><i class="fa fa-exchange" aria-hidden="true" style="font-size: 30px;color: white;"></i></a></td>
														<td align="center"><a href="javascript:showCancelReservationModal(&quot;${reservedDetails.id}&quot;,&quot;${reservedDetails.bookingNo}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_cancel.png"></a></td>
                                           				 <c:if test="${toSpecificDate >= currentDate}">
                                           				<td align="center" style="width:10%;">
                                           					<a href="javascript:showAdvPaymentReservationModal(&quot;${reservedDetails.bookingNo}&quot;,&quot;${reservedDetails.id}&quot;,&quot;CASH&quot;,1,${reservedDetails.custId.id},${reservedDetails.discAmt},${reservedDetails.taxAmt},${reservedDetails.grossAmt})">
                                           					<%-- <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_payment.png"> --%>
                                           					<i class="fa fa-money" aria-hidden="true" style="font-size: 30px;color: white;"></i>
                                           					</a>
                                           					<a href="javascript:showAdvPaymentReservationModal(&quot;${reservedDetails.bookingNo}&quot;,&quot;${reservedDetails.id}&quot;,&quot;CARD&quot;,2,${reservedDetails.custId.id},${reservedDetails.discAmt},${reservedDetails.taxAmt},${reservedDetails.grossAmt})">
                                           					<i class="fa fa-credit-card" aria-hidden="true" style="font-size: 26px;color: white;margin-left:10px;top: -1px;position:relative;"></i>
                                           					</a>
                                           					<%-- <a href="javascript:printPaidBill(&quot;${checkedinCustomer.id}&quot;,1)"> 
                                           					<i class="fa fa-print" aria-hidden="true" style="font-size: 30px;color: white;margin-left:10px;"></i>
                                           					</a> --%>
                                           					<a href="javascript:openOnlineModal(&quot;${reservedDetails.bookingNo}&quot;,&quot;${reservedDetails.id}&quot;,${reservedDetails.custId.id},${reservedDetails.discAmt},${reservedDetails.taxAmt},${reservedDetails.grossAmt})">
                                           					  <i class="fa fa-globe" aria-hidden="true" style="font-size: 30px;color: white;margin-left:10px;"></i>
                                           				    </a>
                                           				</td>
                                           				<td align="center">
                                           				<a href="javascript:printPaidBill(&quot;${reservedDetails.id}&quot;,1)"> 
                                           					<i class="fa fa-print" aria-hidden="true" style="font-size: 30px;color: white;margin-left:10px;"></i>
                                           					</a>
                                           				</td>
                                           				</c:if>
                                           				<c:if test="${reservedDetails.checkInDate eq todaydate}">
                                            			<td align="center"><a href="javascript:showCheckInRoomModal(&quot;${reservedDetails.id}&quot;,${reservedDetails.custId.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_checkin.png"></a>
                                            			</td>
                                            			</c:if>
                                            			<c:if test="${reservedDetails.checkInDate gt todaydate}">  
                                            			<td align="center"></td> 
                                            			</c:if>                       
														
													</tr>
											</c:if>
										</c:forEach>
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
                                            <button type="button"   onclick="javascript:resetReserveSearch()" style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.rpt_inv_po_period.jsp.ok" text="OK" /></button>
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


			
			<div class="modal fade" data-backdrop="static"
				id="alertRoomBookDataopModal" tabindex="-1" role="dialog"
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
								<div id="roombookalertopmassagecont"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"								
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>  <!-- onclick="javascript:failRoomBook()" -->
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

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
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
								onclick="javascript:successRoomBook()"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			


	<div class="modal fade" data-backdrop="static"
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
									<input type="hidden" id="modroombookcustIdhidden" value="">
									
										<table align="center">
<%-- <form:form action="${pageContext.request.contextPath }/customer/uploadidentity.htm" id="fileUp" modelAttribute="customerfile" method="post" enctype="multipart/form-data"> --%>
											
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

													<td><input type="text" id="modroombookcustdob" readonly="readonly" size="10"
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
												<tr>
													<td>GSTNO</td>
													<td>:</td>
													<td><input type="text" id="gstno"
														value="${orders.custVatRegNo}"
														style="margin-bottom: 2px; color: #222222; width: 95%;"/></td>
												</tr>
                                                <tr>
                                                <td>ID TYPE</td>
                                                <td>:</td>
                                                <td>
                                                <select  id="modroombookuniqueIdType"  style="margin-bottom: 2px; color: #222222; width: 95%;">
                                                    <option value="0">Select</option>
                                                    <c:if test="${! empty uniqueIdTypeList}">
                                                        <c:forEach items="${uniqueIdTypeList}" var="idTypeList">
                                                            <option value="${idTypeList.id}">${idTypeList.name}</option>
                                                        </c:forEach>
                                                    </c:if>
                  	                            </select>
                                                </td>
                                                </tr>
                                                <tr>
                                                <td>ID NUMBER</td>
                                                <td>:</td>
                                                <td><input type="text" id="modroombookuniqueId" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
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
									</div>
						</div>
						
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelReserve()"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" id="checkIn" onclick="javascript:createCheckIn()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								 class="btn btn-success">
								<spring:message code="m.jsp.CHECKIN" text="CHECK IN" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			
			<!-- Customer Cancel -->
			
			<div class="modal fade" data-backdrop="static" id="confirmCancelCustomerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menuitems.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
												<div id="cancelcustdataopmassagecont"></div>
												<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.isProvideReason, 'Y') }">
									<div style="text-align: center; font-size: 20px; margin-top: 20px;">
								<span>Cancel Remarks:</span>
								<input style="color:black;" type="text" id="cancelremarks"></input>
							</div>
									</c:if>
												<input id="hiddencustdataopmassagecont" style="display: none;"></input>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menuitems.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:CancelReserveId()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menuitems.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

		<div class="modal fade" data-backdrop="static" id="alertAdvPaymentDoneModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menuitems.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
												<div id="alertadvpaymentaopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">     
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menuitems.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

         <div class="modal fade" data-backdrop="static" id="alertcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px; color:#fff;">
                                            <div id="catdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:resetReserveSearch()" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
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
								<%-- <spring:message code="order.jsp.RESERVEID" text="RESERVED ID:" /> --%>
								BOOKING NUMBER
								<span id="cashmodReserveCont" style="display:none;">00</span>
								<span id="cashmodBookingNoCont">00</span>
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
									<spring:message code="order.jsp.paymentmode"
										text="PAYMENT MODE" />
									:&nbsp;&nbsp;&nbsp;<span id="onlineselpaymenttype"></span>
								 </div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.TOTALAMOUNT"
										text="TOTAL AMOUNT" />  <!-- class="hide" -->
									:&nbsp;&nbsp;&nbsp;<span id="cashtotamtcontId">0.00</span>
								</div>
								<div style="padding: 5px;">
									<spring:message code="order.jsp.AMOUNTTOPAY"
										text="AMOUNT TO PAY" />
									:&nbsp;&nbsp;&nbsp;<span id="cashamttopaycontId">0.00</span>
								</div>
								<div id="cashpaidamtdivId" style="padding: 5px;">
									<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
									:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
										id="cashpaidamtcontId">0.00</span>
								</div>
								<div style="padding: 3px;">
									<%-- <spring:message code="order.jsp.CASHAMOUNT"
										text="CASH AMOUNT" /> --%>
										<spring:message code="order.jsp.TENDERAMOUNT"
										text="TENDER AMOUNT" />
									:&nbsp;<input type="text"
										 value=""
										id="cashtenderAmt" style="text-align: center; color: #222222"
										size="4" autocomplete="off" />  <!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
								
								
								
								<div style="padding: 5px;display:none;" id="cardNoDiv">
									<spring:message code="order.jsp.CARDLAST4DIGIT"
										text="CARD LAST 4 DIGIT" />
									:&nbsp;<input type="text" id="cardlastfourDigit"
										style="text-align: center; color: #222222" size="4"
										maxlength="4" />
								   </div>
								   <div style="padding: 3px;">
									<%-- <spring:message code="order.jsp.CASHAMOUNT"
										text="CASH AMOUNT" /> --%>
										<spring:message code="order.jsp.advance_payment_receipt"
										text="PRINT PAYMENT RECEIPT" />
									:&nbsp;<input type="checkbox"
										 value=""
										id="advancepaymentreceiptcheckbox" style="text-align: center; color: #222222"
										size="4" autocomplete="off" />  <!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
								<%-- <div style="padding: 5px;">
									<spring:message code="order.jsp.CHANGEAMOUNT"
										text="CHANGE AMOUNT" />
									:&nbsp;<span id="cashchangeamtcontId">0.00</span>
								</div> --%>
								<input type="text" id="paytypeid" style="display:none;"/>
								<input type="text" id="customerid" style="display:none;"/>
								<input type="text" id="discamt" style="display:none;"/>
								<input type="text" id="taxamount" style="display:none;"/>
								<input type="text" id="grossamount" style="display:none;"/>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="paycashalertMsg"></div>
							</div>

							<div align="center" style="font-size: 20px;" >
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
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
								<div id="hiddenadvpaycustdataopmassagecont" style="display: none;"></div>
							</button>
							<button type="button"
								onclick="javascript:advancePayment(document.getElementById('cashtenderAmt').value)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="order.jsp.PAY" text="PAY" />
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
							<input type="text" id="reserveId" style="display:none;"/>
							<input type="text" id="custId" style="display:none;"/>
							<input type="text" id="discountAmt" style="display:none;"/>
							<input type="text" id="taxAmt" style="display:none;"/>
							<input type="text" id="grossAmt" style="display:none;"/>
							<input type="text" id="bookingNumberOnline" style="display:none;"/>
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
				id="roomChangeModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog modal-lg" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="rb.roombooking.roomschange" text="CHANGE ROOM" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;height:400px;overflow-y:scroll;">
							<input type="text" id="reserveId" style="display:none;"/>
							<input type="text" id="bookingId" style="display:none;"/>
							<p><span><spring:message code="rb.roombooking.roomschange.select" text="SELECT ROOM" />:</span>
							<span><select id="reservedRoomList" class="form-control" onchange="showSelectedRoomDetails(this.value)" style="margin-bottom: 2px;margin-left:20px;color: #222222;display:inline;width:40%;">
							  
                            </select></span></p>
                            <div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="alertmsg"></div>
							<div style="text-align: center; font-size: 20px;"id="selectefRoomDetails"></div>
							<div style="text-align: center; font-size: 20px;"id="roomListDiv"></div>
							
							
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

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.Success"
									text="Success" />
								
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="base.roombooking.roomchage.change" text="=Room is changed successfully." />
								
							</div>
						</div>
						 <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold; width: 25%;"
								data-dismiss="modal" class="btn btn-success" onclick="javascript:refreshpage();">
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
	
								<h4 class="modal-title"
									style="font-size: 18px; font-weight: bold;" id="myModalLabel">
									<spring:message code="requisition.jsp.Alert"
										text="Alert" />
									
								</h4>
							</div>
							<div class="modal-body"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: center; font-size: 20px;">
									<spring:message code="base.roombooking.roomchage.notchange" text="Error!Room is not changed." />
									
								</div>
							</div>
							
								 <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
								<button type="button" style="background: #72BB4F; font-weight: bold; width: 25%;"
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

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="table.jsp.Alert"
									text="Alert" />
								
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<span id="roomChangeResponseMsg"></span>
								
							</div>
						</div>
						 <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold; width: 25%;"
								data-dismiss="modal" class="btn btn-success" onclick="javascript:refreshpage();">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="modal fade" data-backdrop="static"
				id="addFurtherRoomsModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog modal-lg" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<p><spring:message code="rb.roombooking.addmoreroom" text="ADD ROOM FOR BOOKING NUMBER:" /><span id="addFurtherRoomsModalBookingNumberSpan"></span></p>
							</h4>
						</div>
						<div class="modal-body" id="addFurtherRoomsModalBody" style="background: #404040; border-top: 1px solid #404040; color: #fff;height:400px;overflow-y:scroll;">
						<input type="hidden" disabled id="addFurtherRoomsModalBookingId"></input>
						<input type="hidden" disabled id="addFurtherRoomsModalBookingNumber"></input>
						<input type="hidden" disabled id="addFurtherRoomsModalCheckInTimeId"></input>
						<input type="hidden" disabled id="addFurtherRoomsModalCheckOutTimeId"></input>
						<input type="hidden" disabled id="addFurtherRoomsModalCustomerObject"></input>
						<input type="hidden" disabled id="addFurtherRoomsModalBookingTypeObject"></input>
						<div id="addFurtherRoomsModalDisplayBookingDetailsDiv">
						
						<div class="col-md-12">
						<div class="col-md-3" id="addFurtherRoomsModalDisplayBookingDetailsDivForBookingNumber">
						<spring:message code="rb.admin.roombooking.bookingno" text="BOOKING NO." /><span id="tempspanforbookingnumber"></span>
						
						</div>
						<div class="col-md-3" id="addFurtherRoomsModalDisplayBookingDetailsDivForDisplayingBookedRoomsDiv">
						
						<div id="addFurtherRoomsModalDisplayBookingDetailsDivForDisplayingBookedRooms" >
						<span>BOOKED ROOMS:</span>
						<table id="addFurtherRoomsModalDisplayPreviousBookedRoomsTable" class="table table-striped table-bordered" style="color:#FFF;  border:1px solid #222222;">
							<thead id="addFurtherRoomsModalBodyTableHead" style="background:#404040; color:#FFF;">
							
                             <th>RoomNo</th>
                             <th>RoomPrice</th>
                             <th>Capacity</th>
							</thead>
							<tbody id="addFurtherRoomsModalDisplayPreviousBookedRoomsTableBody">
							
							
							
							</tbody>
							</table>
							
						
						
						</div>
						</div>
						</div>
						
						
						</div>
						
						
						
						<label>CustomerName:</label>
						 <span    id="addFurtherRoomsModalCustomerName"></span> 
						
						<label>CustomerPhone:</label>
						
						<!-- <input type="text" disabled style="background-color:black;" id="addFurtherRoomsModalCustomerPhone"></input> -->
						<span   id="addFurtherRoomsModalCustomerPhone"></span>
						<p id="addFurtherRoomsModalCheckInDate">Check In Date:<span id="addFurtherRoomsModalCheckInDateSpan"></span>&nbsp;&nbsp;<span><span id="addFurtherRoomsModalCheckOutDate">Check Out Date:<span id="addFurtherRoomsModalCheckOutDateSpan"></span></span></span></p>
						<!-- <div> -->
						 <span>SELECT ROOM:</span> 
						
						<!-- <select  id="addFurtherRoomsModalSelectRoomOption"  class="" style="color:black;">
						</select> -->
						<span>
						<!--  <select id=""  class="form-control" style="color:black;">
						<option>1</option>
						 <option>2</option>
						<option>3</option>   
						</select>  -->
						 <select  id="addFurtherRoomsModalSelectRoomOption" class="form-control" style="color:black;display:inline;" onchange="javascript:selectRoomForDisplayingInAddRoomModal(this.value)">
						 
						</select> 
						</span>
						
						<!-- </div> -->
								<!-- <p id="addFurtherRoomsModalCheckOutDate">Check Out Date:<span id="addFurtherRoomsModalCheckOutDateSpan"></span></p> -->
							
							
							
							
							<table id="addFurtherRoomsModalBodyTable" class="table table-striped table-bordered" style="color:#FFF;  border:1px solid #222222;">
							<thead id="addFurtherRoomsModalBodyTableHead" style="background:#404040; color:#FFF;">
							 <!--  <td>Select</td> -->
                             <td>Room Details</td>
                             <td>New Rate</td>
                             <td style="display:none;">No Taxable</td>
							</thead>
							<tbody id="addFurtherRoomsModalBodyTableBody">
							
							
							
							</tbody>
							</table>
							
							
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" onclick="addFurtherRooms()">OK</button>
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
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/customer/welcome.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
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
				<%-- <div class="modal fade" data-backdrop="static"
				id="alertRoomCheckInDataopModal" tabindex="-1" role="dialog"
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
								<div id="roomcheckinalertopmassagecont"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								onclick="javascript:failBooking()"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div> --%>

			<!-- modal ends -->
			
	
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
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/numerickey.js"></script>
  

	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";
		var waiterNameFlag = "${sessionScope.loggedinStore.waiterNameFlag}";
		var fromdate="${fromSpecificDate}";
		var todate="${toSpecificDate}";
		var storeID="${sessionScope.loggedinStore.id}";
		var directBooking="${directBooking}";
		var frontDeskPerson = "${sessionScope.loggedinUser.contactNo}";
		var custId=null;
		var billprint = "${sessionScope.loggedinStore.printPaidBill}";
		var currency = "${sessionScope.loggedinStore.currency}";
		var is_Acc='${sessionScope.loggedinStore.is_account}';
		var now = new Date();
		var currentday=moment(now, "YYYY-MM-DD").format("YYYY-MM-DD");
		var previousday=moment(now, "YYYY-MM-DD").subtract('days',1).format("YYYY-MM-DD");
		//alert("now DAY IS"+now);
		//alert("PREVIOUS DAY IS"+previousday);
		var printReason="${sessionScope.loggedinStore.isProvideReason}";
		var todesc = "${sessionScope.loggedinStore.toDes}";

		/* $(document).on("click", "#checkIn", function() {
			var file_data = $("#avatar").prop("files")[0];   // Getting the properties of file from file field
			var form_data = new FormData();                  // Creating object of FormData class
			form_data.append("file", file_data);              // Appending parameter named file with properties of file_field to form_data               // Adding extra parameters to form_data
			$.ajax({
		                url: "/upload_avatar",
		                dataType: 'script',
		                cache: false,
		                contentType: false,
		                processData: false,
		                data: form_data,                         // Setting the data attribute of ajax with file_data
		                type: 'post'
		       })
		}) */
		
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
			
			
			
			
			 $('[data-toggle="popover"]').popover(); 
						
				/* $('#fromdateroomsearch').datepicker({
					
					format : "yyyy-mm-dd",
					autoclose : true,
					startDate : '0',
					endDate : '+4m',
				}); */
				
              $('#fromdateroomsearch').datepicker({
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
					
				});

				$('#todateroomsearch').datepicker({
					
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
				
			 	   $('#reservedetailslist').DataTable( {
				        paging:false,
				        "info":false,
				        "columnDefs": [{
				            "defaultContent": "-",
				            "targets": "_all"
				          }]
				    } );  
		});
		
	/* 	function clickDate() {
			
			console.log('worked');
			document.getElementById('paxroomCatsearchDiv').style.display = 'none';
		} */
		
		
		  function showCancelReservationModal(reserveId,bookingno)
		   {
				
			  document.getElementById('cancelcustdataopmassagecont').innerHTML='Are You Sure To Cancel Booking No.' + " " + bookingno + '?';
			
			  document.getElementById('hiddencustdataopmassagecont').value=reserveId;
			  //document.getElementById('hiddenbookingno').value=bookingno;
              /* alert("RESERVE ID IS:"+$("#hiddencustdataopmassagecont").val());
              alert("BOOKING NUMBER IS:"+$("#hiddenbookingno").val()); */
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
		  
		   
		   function showCheckInRoomModal(reserveId,customerId)
		   {
			   document.getElementById('modroombookCustalertMsg').innerHTML = "";
			   if(reserveId!=0)
			   {
				   $("#checkIn").html("CHECK IN"); 
				  		setCustomerDetails(reserveId,customerId);
						$('#modRoomCheckInCustDetailsModal').modal('show');
					
			   }
			   else 
			   {
				   $("#checkIn").html("SAVE");
				   setCustomerDetails(reserveId,customerId);
				    document.getElementById('modroombookreserveIdhidden').value=reserveId;
					$('#modRoomCheckInCustDetailsModal').modal('show');
			   }
		   }

		   function showAdvPaymentReservationModal(bookingno,reserveId,paymentMode,id,customerid,discamt,taxamt,grossAmt)
		   {
			   $("#advancepaymentreceiptcheckbox").prop("checked",false);
			   $("#cashtenderAmt").val("");
			   $("#cardlastfourDigit").val("");
			   $("#roomsbookedspan").html("");
			   document.getElementById('paytypeid').value = id;
			   document.getElementById('customerid').value = customerid;
			   document.getElementById('discamt').value = discamt;
			   document.getElementById('taxamount').value = taxamt;
			   document.getElementById('grossamount').value = grossAmt;
			   document.getElementById('paycashalertMsg').innerHTML = '';
			   document.getElementById('cashtenderAmt').innerHTML = '';

			   document.getElementById('cashmodReserveCont').innerHTML =reserveId;
			   document.getElementById('cashmodBookingNoCont').innerHTML =bookingno;
			   amountCalculationAdvPayRoom(reserveId);
			   document.getElementById('hiddenadvpaycustdataopmassagecont').value=reserveId;
			   if(billprint == 'N'){
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

			 function showalertcatdataopModal()
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
			
			 /* $(function() {
			        $("#custNameSearch")
			                .autocomplete(
			                        {
			                            source : function(request, response) {
			                                $.ajax({
			                                            url : "${pageContext.request.contextPath}/customer/searchcustbyname.htm",
			                                            type : "GET",
			                                            data : {
			                                             term : request.term,
			                                             fromDate : document.getElementById('fromdateroomsearch').value,
			                                             toDate : document.getElementById('todateroomsearch').value,
			                                             func : "CI"
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
			                        	 		
			                        	 		getReserveDetailsOfselectedCustomer(custId);
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
			                                            url : "${pageContext.request.contextPath}/customer/searchcustbyphno.htm",
			                                            type : "GET",
			                                            data : {
			                                             term : request.term,
			                                             fromDate : document.getElementById('fromdateroomsearch').value,
			                                             toDate : document.getElementById('todateroomsearch').value,
			                                             func : "CI"
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
			                               	
			                               	getReserveDetailsOfselectedCustomer(custId);
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
			                        	 		getReserveDetailsOfselectedCustomer(custId);
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
			                            		//alert("ENTERS HERE AUTOCOMPLETE PHONE");
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
			                               	 getReserveDetailsOfselectedCustomer(custId);
			                              }

			                         })
			       
			     });
			     
			     
			     
			     
			     
			     
			     
			     
			     
			     
			     
			     
			     
			    /* $(function() {
			        $("#reserveIdSearch")
			                .autocomplete(
			                        {
			                            source : function(request, response) {
			                                $.ajax({
			                                            url : "${pageContext.request.contextPath}/customer/searchreserveid.htm",
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
			                                                                         resId:v.reserveId,
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

			                        	 		resId=ui.item.resId;   
			                        	 		
			                        	 		getReserveDetailsOfReserveId(resId);
			                             }
			                          	                            
			                        })
			         .data( "ui-autocomplete" )._renderItem = function( ul, cust ) {
			         return $( "<li></li>" )
			          .data( "ui-autocomplete-item", cust )
			          .append( "<a>" + cust.resId + "</a>" )
			          .appendTo( ul ); 
			        }; 
			    }); 
			     */
			
		   
	</script>
	<script type="text/javascript">
	/* $(function() {
        $("#modroombookcustPhone")
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
                                                	 $("#modroombookcustIdhidden").val('');
                                                	 $("#modroombookcustName").val('');                                                     
                                                     $("#modroombookcustAddress").val('');
                           	                         $("#modroombookcustEmail").val('');
                                                     $("#modroombookcustGender").val('');
   								                     $("#modroombookcustdob").val('');
   								                     $("#modroombookcustLocation").val('');
   								                     $("#modroombookcusthouseno").val('');
   								                     $("#modroombookcuststreet").val('');
   								                     $("#modroombookcuststate").val('');
   								                     $("#modroombookuniqueIdType").val('');
   								                     $("#modroombookuniqueId").val('');
                                                     }
                                              else{
                                            	  //alert("if else");
                                            	  
                                            	  $("#modroombookcustIdhidden").val(custcontactno.id);
                                            	  $("#modroombookcustName").val(custcontactno.name);
                                                  $("#modroombookcustPhone").val(custcontactno.phone); 
                                                  $("#modroombookcustAddress").val(custcontactno.address);
                        	                      $("#modroombookcustEmail").val(custcontactno.email);
                                                  $("#modroombookcustGender").val(custcontactno.gender);
								                  $("#modroombookcustdob").val(custcontactno.dob);
								                  $("#modroombookcustLocation").val(custcontactno.location);
								                  $("#modroombookcusthouseno").val(custcontactno.houseno);
								                  $("#modroombookcuststreet").val(custcontactno.street);
								                  $("#modroombookcuststate").val(custcontactno.state);
								                  $("#modroombookuniqueIdType").val(custcontactno.uniqueidType);
								                  $("#modroombookuniqueId").val(custcontactno.uniqueidNo);
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
	

	</script>
	<c:choose> 			
   <c:when test="${sessionScope.loggedinStore.id!=167}">		  
	<div   class="row" style="width:100%;margin:auto;display:none;">
            <div id="printDiv2100GSTNew">
               <style>
			    .row {
			        margin-left:0px;
			        margin-right:0px
			    }
			    .customtable {
			      border: 1px solid black;
			      width:100%;border-collapse:collapse;border-spacing: 0;
			    }
			    .customtable th {
			       text-align: center;
			       padding: 2px;
			       border: 1px solid black;
			    }
			    .customtable td{
			        text-align: center;
			        padding: 2px;
			        border: 1px solid black;
			    }
			    
			    h4 {
			       margin-bottom:0px
			    }
			    .customheight{
	
	        border:1px solid black;
	        padding:2px;
	        border-radius:10px;
        	margin-left:5px
           }
			 </style>
        <!--   ..................................1st div...................................... -->
         <div style="margin:auto;width:100%">


        <!--   ..................................1st div...................................... -->
           
             <div style="border:1px solid black;border-bottom:0px">
             	<div style="display:flex;width:100%">
             		 <div style="width:20%"> <p style="margin-left: 10px;">	<img src="${pageContext.request.contextPath}/assets/images/billlogo/sweetdreamslogo.png" style="width:120px;height:120px"> </p> </div>
             		  <div style="width:60%"> 
		             	  <h3 style="text-align:center;margin-top:2px"> <b> <u> INVOICE </u> </b> </h3>
		             	  <h4 style="text-align:center"> <b> ${sessionScope.loggedinStore.storeName} </b> </h4> 
			             	  	   <p style="text-align:center"> (A Unit of Kar Group of Companies) <br> 
		                                             ${sessionScope.loggedinStore.address}<br>
		                                             Tel. - ${sessionScope.loggedinStore.mobileNo} <br>
		                                             E-mail : ${sessionScope.loggedinStore.emailId} <br>
		                                             website : ${sessionScope.loggedinStore.url}
			             	  	   </p> 
			          </div>  
			          <div style="width:20%">  </div> 	  	   
	            </div>



	             <div style="display:flex;width:100%">
	             	 <div style="width:50%"> 
		             	    <!-- <p style="text-align:center;height:41px">	<img src="dokeps_residency_logo.png"> </p>
		             	 	<p style="text-align:center"> <b> A Business Class Hotel </b> </p> -->

                     <div class="customheight" style="border:width:92%;margin-left:5px;height:190px;">

	             	 	    <div style="display:flex;width:100%">
	             	 	    	<div style="width:28%"> <p style="margin-top:10px"> <b> Name :</b> </p> </div> 
	             	 	    	<div style="width:72%"> <p style="border-bottom:1px dotted #000;margin-top:10px"> <span id="customerName"> 0 </span> </p> </div>
                      </div>

                      <div style="display:flex;width:100%">
	             	 	    	<div style="width:28%"> <p style="margin-top:10px"> <b> Contact No : </b> </p> </div> 
	             	 	    	<div style="width:72%"> <p style="border-bottom:1px dotted #000;margin-top:10px"> <span id="customerPhone"> 0 </span> </p> </div>
                      </div>

                        <div style="display:flex;width:100%"> 
	             	 	    	<div style="width:28%"> <p> <b> Address :</b> </p> </div> 
	             	 	    	<div style="width:72%"> <p style="border-bottom: 1px dotted #000"> <span id="customerAddress"> 0 </span> </p> </div>
                        </div>

                        <div style="display:flex;width:100%"> 
	             	 	    	<div style="width:28%"> <p> <b> Reg. No :</b> </p> </div> 
	             	 	    	<div style="width:72%"> <p style="border-bottom: 1px dotted #000"> <span id="custgstNo"> 0 </span> </p> </div>
                        </div>

                   <!--  </div> -->


	             	 	    </div>
	             	 </div>&nbsp;
	             	  <div style="width:50%"> 
	             	  	  
                       <div class="customheight" style="width:93%;height:190px;">
	             	  	   <div style="display:flex;width:100%">
	             	 	    	<div style="width:25%"> <p> <b> Invoice No: </b> </p> </div> 
	             	 	    	<div style="width:75%"> <p style="border-bottom: 1px dotted #000"> <span id="invoiceNo"> 0 </span> </p> </div>
                       </div>
	             	 	    	    <!-- .............aparture time div................ -->
	             	 <div style="display:flex;width:100%">
	             	 	    	<div style="width:33%"> <p> <b> Booking Date</b> </p> </div> 
	             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000"> <span id="bookingDate">  0 </span> </p> </div>
	             	 	    	<div style="width:17%"> <p> <b> No. Pax</b> </p> </div> 
	             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000"> <span id="pax"> 0 </span> </p> </div>
                      </div>  
	             	 	    	       <!-- ....................Departure time div..................... -->	    	    

                      <div style="display:flex;width:100%">
	             	 	    	<div style="width:33%"> <p> <b> CheckIn Date </b> </p> </div> 
	             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000"> <span id="checkInDate">  0 </span> </p> </div>
	             	 	    	<div style="width:17%"> <p> <b> Time</b> </p> </div> 
	             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000"> <span id="checkInTime"> 0 </span> </p> </div>
                      </div>  
	             	 	    	       <!-- ....................Departure time div..................... -->
                      <div style="display:flex;width:100%">         
	             	 	    	<div style="width:33%"> <p> <b> CheckOut Date </b> </p> </div> 
	             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000"> <span id="checkOutDate"> 0 </span> </p> </div>
	             	 	    	<div style="width:17%"> <p> <b> Time</b> </p> </div> 
	             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000"> <span id="checkOutTime"> 0 </span> </p> </div>
	             	 	    </div>
	             	  </div>
	             </div>
             </div>

                     <h4 style="text-align:center"> <b> <u> Particulars </u> </b> </h4>

             </div>
           <!-- ....................................2nd part...................................  -->   

           <div>
  <table class="customtable">
    <tr>
      <th> Room No. </th>
      <th> Day's </th>
      <th> Rate </th>
      <th> Total </th>
      <th> CGST% </th>
      <th> CGST Amt </th>
      <th> SGST% </th>
      <th> SGST Amt </th>
      <th> Amount (Rs.) </th>
      <th> P. </th>
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
      <td colspan="8" style="text-align:left"> <b> Discount  </b> </td>
      <td> <p id="totalDiscAmt"> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Total  </b> </td>
      <td> <p id="totalAmt"> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="8" style="text-align:left"> <b> Advance  </b> </td>
      <td> <p id="advAmt"> </p> </td>
      <td> <p> </p> </td>  
    </tr>
   <!--  <tr>
      <td colspan="8" style="text-align:left"> <b> Round Off  </b> </td>
      <td> <p id="roundOffAmt"> </p> </td>
      <td> <p> </p> </td>  
    </tr> -->
    <tr>
      <td colspan="8" style="text-align:left"> <b> Net Amount  </b> </td>
      <td> <p id="netAmt"> </p> </td>
      <td> <p> </p> </td>  
    </tr>
    <tr>
      <td colspan="10" style="padding:15px 0px"> 
          <div style="text-align:left;display:flex;width:100%">
          	<div style="width:17%">
          	     <b> Rupees in word </b>   
            </div>
          <div style="border-bottom: 1px dotted #000;width:83%">
          	aaaaaaaaaaaaaa
          </div>
      </td> 
    </tr>

  </table>
</div>


<!-- ................................................3rd part.................................................. -->
   
 <div>
 	<p style="text-align:center"> <b> ${sessionScope.loggedinStore.thanksLine2} </b> </p>
 	<div style="display:flex;width:100%;padding:10px">
 		 <div style="width:34%"> 
 		 		<%-- <p> <b> ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo} <br>
                     SAC CODE : 996311 <br>
                     PAN NO. : AADCK1293K <br>
                     Bank Details : <br>
                     Bank Name : State Bank of India <br>
                     Bank A/C No. : 32772398492 <br> 
                     Branch Name & IFSC Code : Contai Bazar & SBIN0012453     
 		 		</b> </p> --%>
 		 		
 		 		<p> <b> ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo} <br>
		                     SAC CODE : <span id="saccode">996311</span> <br>
		                     PAN NO. : <span id="pancode"></span> <br>
		                     Bank Details:-  <br>
		                     Bank Name : <span id="bankname"></span> <br>
		                     Bank A/C No. : <span id="bankaccno"></span> <br> 
		                     Branch Name & IFSC Code : <span id="bankbarach"></span>   
		 		 		    </b> </p>
 		  </div>
 		 <div style="text-align:center;width:33%"> 
 		 	  <p style="margin-top:120px"> <b> -------------------------------------- <br>
                                              Guest's Signature </b> </p>
 		 </div>
 		 <div style="text-align:center;width:33%"> 
 		 		<p style="margin-top:140px"> <b> Authorised Signature </b> </p>
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
<div class="row" style="width:850px;margin:auto;display:none;">
            <div id="printDiv2100GSTNew">
               <style>
			    .row {
			        margin-left:0px;
			        margin-right:0px
			    }
			    .keps_resort_table {
			      border: 1px solid black;
			      width:100%;border-collapse:collapse;border-spacing: 0;
			    }
			    .keps_resort_table th {
			       text-align: center;
			       padding: 2px;
			       border: 1px solid black;
			    }
			    .keps_resort_table td{
			        text-align: center;
			        padding: 2px;
			        border: 1px solid black;
			    }
			    
			    h4 {
			       margin-bottom:0px
			    }
			    .center{
			   /*  text-align: center; */
			    /*  padding-right: 500px; */
			    padding:500px;
			     display:inline;
			     text-align: center;
			     /* padding-bottom:100px; */
			     
			    
			    }
			 </style>
        <!--   ..................................1st div...................................... -->
           <div style="border:1px solid black;border-bottom:0px">
             	 <h3 style="text-align:center;margin-top:2px"> <b> <u> INVOICE </u> </b> </h3>
	             <div style="display:flex;width:100%">
	             	 <div style="width:50%"> 
		             	    <p style="text-align:center;height:95px">	<!-- <img src="dokeps_residency_logo.png"> --> </p>
		             	 	<!-- <p style="text-align:center"> <b> A Business Class Hotel </b> </p> -->

                     <div style="border:1px solid black;padding:2px;height:150px;border-radius:10px;width:90%;margin-left:5px;padding:0px 10px">

	             	 	    <div style="display:flex;width:100%">
	             	 	    	<div style="width:30%"> <p style="margin-top:5px"> <b> Name :</b> </p> </div> 
	             	 	    	<div style="width:70%"> <p style="border-bottom:1px dotted #000;margin-top:5px"> <span id="customerName">  </span> </p> </div>
                      </div>
                       <div style="display:flex;width:100%">
	             	 	    	<div style="width:30%"> <p style="margin-top:5px"> <b> Contact No:</b> </p> </div> 
	             	 	    	<div style="width:70%"> <p style="border-bottom:1px dotted #000;margin-top:5px"> <span id="customerPhone">  </span> </p> </div>
                      </div>

                        <div style="display:flex;width:100%"> 
	             	 	    	<div style="width:30%"> <p style="margin-top:5px"> <b> Address :</b> </p> </div> 
	             	 	    	<div style="width:70%"> <p style="border-bottom: 1px dotted #000;margin-top:5px;"> <span id="customerAddress"></span>  </p> </div>
                      </div>

                   <!--  </div> -->
					 </div>
	             	 </div>
	             	  <div style="width:50%">
	             	  <div class="center"> 
	             	  	   <h4  style="text-align:center;font-weight:700;"> ${sessionScope.loggedinStore.storeName}  </h4> 
	             	  	   <p  style="text-align:center;margin-top:0px;">${sessionScope.loggedinStore.fromDes} <br>
                                             							${sessionScope.loggedinStore.address}<br>
                                             							Tel. - ${sessionScope.loggedinStore.mobileNo} <br>
                                             							E-mail : ${sessionScope.loggedinStore.emailId}
	             	  	   </p> 
	             	  	   </div>
	             	  	   
                       <div style="border:1px solid black;padding:0px 10px;height:150px;border-radius:10px;width:92%">
                             <div style="display:flex;width:100%">
		             	 	    	<div style="width:30%"> <p style="margin-top:10px"> <b> Invoice No:</b> </p> </div> 
		             	 	    	<div style="margin-top:0px;width:70%"> <p style="border-bottom: 1px dotted #000;margin-top:10px;"> <span id="invoiceNo"></span> </p> </div>
	                       	  </div>
		             	  	  <!--  <div style="display:flex;width:100%">
		             	 	    	<div style="width:30%"> <p style="margin-top:0px"> <b> No. Person :</b> </p> </div> 
		             	 	    	<div style="margin-top:0px;width:70%"> <p style="border-bottom: 1px dotted #000;margin-top:0px;"> <span id="pax"></span> </p> </div>
	                       	  </div> -->
	                       	   <div style="display:flex;width:100%">
			             	 	    	<div style="width:33%"> <p style="margin-top:0px"> <b> Booking Date:</b> </p> </div> 
			             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="bookingDate"></span> </p> </div>
			             	 	    	<div style="width:28%"> <p style="margin-top:0px"> <b> No. Person:</b> </p> </div> 
			             	 	    	<div style="width:14%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="pax"></span> </p> </div>
		                      </div>  
		             	 	    	    <!-- .............aparture time div................ -->
		                      <div style="display:flex;width:100%">
			             	 	    	<div style="width:34%"> <p style="margin-top:0px"> <b> CheckIn Date:</b> </p> </div> 
			             	 	    	<div style="width:24%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkInDate"></span> </p> </div>
			             	 	    	<div style="width:17%"> <p style="margin-top:0px"> <b> Time:</b> </p> </div> 
			             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkInTime"></span> </p> </div>
		                      </div>  
		             	 	    	       <!-- ....................Departure time div..................... -->
	                      		<div style="display:flex;width:100%">         
		             	 	    	<div style="width:34%"> <p style="margin-top:0px"> <b> CheckOut Date:</b> </p> </div> 
		             	 	    	<div style="width:24%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkOutDate"></span> </p> </div>
		             	 	    	<div style="width:17%"> <p style="margin-top:0px"> <b> Time:</b> </p> </div> 
		             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkOutTime"></span> </p> </div>
		             	 	    </div>
	             	  </div>
	             </div>
             </div>

                     <h4 style="text-align:center"> <b> <u> Particulars </u> </b> </h4>

             </div>
           <!-- ....................................2nd part...................................  -->   
           <div>
		  	<table class="keps_resort_table">
		  	 <thead>
		    <tr>
		      <th> Room No. </th>
		      <th> Day's </th>
		      <th> Rate </th>
		      <th> Total </th>
		      <th> CGST% </th>
		      <th> CGST Amt </th>
		      <th> SGST% </th>
		      <th> SGST Amt </th>
		      <th> Amount (Rs.) </th>
		      <th> P. </th>
		    </tr>
		    </thead>
		    <tbody id="bill_perticulars"></tbody>
		    <tfoot id = "biil_footers"></tfoot>
		  </table>
		  </div>
        <!-- ................................................3rd part.................................................. -->
   
		 <div>
		 	<p style="text-align:center;margin-top:0px;"> <b> ${sessionScope.loggedinStore.thanksLine2} </b> </p>
		 	<div style="display:flex;width:100%;margin-top:0px;">
		 		 <div style="width:40%"> 
		 		 		<p> <b> ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo} <br>
		                     SAC CODE : <span id="saccode">996311</span> <br>
		                     PAN NO. : <span id="pancode"></span> <br>
		                     Bank Details:-  <br>
		                     Bank Name : <span id="bankname"></span> <br>
		                     Bank A/C No. : <span id="bankaccno"></span> <br> 
		                     Branch Name & IFSC Code : <span id="bankbarach"></span>   
		 		 		    </b> </p>
		 		  </div>
		 		 <div style="text-align:center;width:30%"> 
		 		 	  <p style="margin-top:140px"> <b> -------------------------------------- <br>
		                                              Guest's Signature </b> </p>
		 		 </div>
		 		 <div style="text-align:center;width:30%"> 
		 		 		<p style="margin-top:140px"> <b> -------------------------------------- <br>Authorised Signature </b> </p>
		 		 </div>
		
		 	</div>
		 	
		 </div>

      <!-- ..................................................................................................................  -->  
      </div>
</div>

</c:otherwise> 
</c:choose> 
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




