<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: Bill Register :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   <link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />



   <style type="text/css">
     .ui-autocomplete {
          overflow-y: scroll; max-height: 250px; width: 300px; word-break: break-all; z-index: 2150000000 !important;
        }
     .modal:nth-of-type(even) {
           z-index: 1042 !important;
         }
     .modal-backdrop.in:nth-of-type(even) {
           z-index: 1041 !important;
         }
</style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
   <%--  <c:set var="today" value="<%=new java.util.Date()%>" /> --%>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>
       <c:set var="today" value="<%=new java.util.Date()%>" />
           <div class="col-md-10 col-sm-10">
					 <div class="col-md-12 col-sm-12">
                        <form modelAttribute="roombooking" action="${pageContext.request.contextPath }/rmservicemgnt/viewallpaidbillperiodwise.htm" method="post">
								<span style="color:#FFF; font-size:16px; font-weight:bold;">Checkin Date:</span>
		                    	<input type="text" id="checkindate" name="checkInDate" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
		                    	<span style="color:#FFF; font-size:16px; font-weight:bold;">Checkout Date</span>
		                   		<input type="text" id="checkoutdate" name="checkoutDate" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
		                     	<input type="hidden" id="todaydate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
		                     	<input type="submit" value="<spring:message code="paidorder.jsp.submit" text="Submit" />" class="btn btn-primary">
					     </form>

                   </div>
                


                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">

                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered" id="paidordertable" style="color: #FFF; border: 1px solid #222222;">
											<thead>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.SLNO" text="SL NO" /></th>
												<th style="text-align:center;"><spring:message code="rb.admin.roombooking.bookingno" text="BOOKING NUMBER" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.fromdate" text="CHECKIN DATE" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.name" text="CUST. NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.phno" text="PHONE NO." /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.email" text="EMAIL" /></th>
                                            <th style="text-align:center;"><spring:message code="base.roombooking.jsp.rooms" text="BOOKED ROOMS" /></th>
                                            <th style="text-align: center;">ACTION</th>

											</thead>
											<tbody style="color: #fff;" id="billsReg">
												<c:if test="${ empty billRegister}">
												<tr style="background: #222222; cursor: pointer;">
												<td style="text-align: center;" colspan="8">NO DATA FOUND.</td>
												</tr>

											</c:if>
												<c:if test="${! empty billRegister}">
													<c:forEach items="${billRegister}" var="billRegister" varStatus="stat">
														<tr style="background: #222222; cursor: pointer;">
															<td style="text-align: center;">${stat.index+1}</td>
															<td style="line-height: 1.4; padding: 6px;">${billRegister.bookingNo}</td>
															<td style="line-height: 1.4; padding: 6px;">${billRegister.checkInDate}</td>
															<td style="line-height: 1.4; padding: 6px;">${billRegister.custId.name}</td>
															<td style="line-height: 1.4; padding: 6px;">${billRegister.custId.contactNo}</td>
															<td style="line-height: 1.4; padding: 6px;">${billRegister.custId.emailId}</td>
															   <c:set var="roomNumbers" value=""></c:set>
																	<c:set var="roomIds" value=""></c:set>
																	<c:set var ="totalRoomReserved" value="${fn:length(billRegister.bookingDetail) - 1}" />
																	<c:forEach items="${billRegister.bookingDetail}" var="roomDetails" varStatus="loop">
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
																	<td style="line-height: 1.4; padding: 6px;text-align:center;">${roomNumbers}</td>
											                      
								                          <td align="center"><a href="javascript:printPaidBill(&quot;${billRegister.id}&quot;,2)"> <i class="fa fa-print" aria-hidden="true" style="font-size: 30px;color: white;margin-left:10px;"></i></a></td>
                                                 </tr>
													</c:forEach>
												</c:if>

											</tbody>
										</table>
                            </div>
                        </div>
                    </div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
           </div>

            </div>
            <!-- modals part starts -->
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
								<table
									style="text-align: center; border-collapse: collapse; id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="6%;"><spring:message code="room.jsp.name"
													text="Room No." /></th>
											<th width="15%;"><spring:message code="room.jsp.Category"
													text="Room Category" /></th>											
											<th width="5%;"><spring:message
													code="purinvdet.jsp.pqty" text="Rate" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.lqty" text="Total" /></th>
										   <th width="14%;"><spring:message
													code="order.jsp.DISCPERCENTAGE" text="DISCOUNT(%)" /></th>
										   <%-- <th width="5%;"><spring:message
													code="reprintcash.jsp.discamt" text="Disc Amt" /></th> --%>
													 
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Taxable Value" />&nbsp;</th> 
											
										<%-- <c:if test="${storeCountry == 'INDIA' || storeCountry =='India' || storeCountry == 'india'}">	
											<th width="20%;" colspan="2" id="cgstth">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="20%;" colspan="2" id="sgstth">&nbsp;<spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
										</c:if>
										<c:if test="${storeCountry != 'INDIA' || storeCountry !='India' || storeCountry != 'india'}">	
										
											 <th width="20%;" colspan="2" id="othertaxth" >&nbsp;
											 <spring:message code="stockinnew.jsp.TAX" text="TAX" /><span id="taxname"></span>&nbsp;
											</th>
										</c:if> --%>
											 <%-- <th width="18%;" colspan="2">&nbsp;<spring:message
													code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
											</th>   --%> 
											
											
												 <c:choose> 
												  <c:when test = "${fn:containsIgnoreCase(sessionScope.loggedinStore.country, 'India')}"> 
												     <th width="20%;" colspan="2" id="cgstth">
												         &nbsp;<spring:message code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
													 </th>
														<th width="20%;" colspan="2" id="sgstth">
														&nbsp;
														<spring:message code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
														</th>									 
												  </c:when>
												  <c:otherwise>
												  <th width="20%;" colspan="2" id="othertaxth" >&nbsp;
													 <spring:message code="stockinnew.jsp.TAX" text="TAX" />(<span id="taxname"></span>)&nbsp;
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
											<!-- <td></td>  -->
											<!--<td></td>
											<td></td>   -->
											
											<%-- <c:if test="${storeCountry == 'INDIA' || storeCountry =='India' || storeCountry == 'india'}">	
										
											<th width="5%;" id="cgstrateth"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;" id="cgstamtth" style="text-align:center;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;" id="sgstrateth"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;" id="sgstamtth"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											</c:if>	
											<c:if test="${storeCountry != 'INDIA' || storeCountry !='India' || storeCountry != 'india'}">	
											
											 <th width="5%;" id="othertaxrateth" ><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="8%;" id="othertaxamtth" style="text-align:center;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>  
											</c:if>	 --%>	
																							
												<c:choose> 
												  <c:when test = "${fn:containsIgnoreCase(sessionScope.loggedinStore.country, 'India')}"> 
												     <th width="5%;" id="cgstrateth"><spring:message
																									code="reprintcash.jsp.totqty" text="Rate" /></th>
																							<th width="10%;" id="cgstamtth" style="text-align:center;"><spring:message code="pos.jsp.mrpLs"
																									text="Amt." /></th>
																							<th width="5%;" id="sgstrateth"><spring:message
																									code="reprintcash.jsp.totqty" text="Rate" /></th>
																							<th width="10%;" id="sgstamtth"><spring:message code="pos.jsp.mrpLs"
																									text="Amt." /></th>
													 
													 
												  </c:when>
												  <c:otherwise>
												  
																							 <th width="5%;" id="othertaxrateth" ><spring:message
																									code="reprintcash.jsp.totqty" text="Rate" /></th>
																							<th width="8%;" id="othertaxamtth" style="text-align:center;"><spring:message code="pos.jsp.mrpLs"
																									text="Amt." /></th> 
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
										style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 5%"></span></td>

								</tr>
								<tr id="paidAmtInAdvance_2100px" style="display:none;">
								
								     <td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">
												Advance Paid Amount:</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="advPaidAmount2100px_gst">00</span></b></td>
								
								</tr>
								<tr id="paidAmtInTotal_2100px" style="display:none;">
								
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
			
          <!-- modals part end -->
     	<!--New Bill Format Start  -->
			  
	<div class="row" style="width:1024px;margin:auto;display:none;">
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
	             	  	   <h4 style="text-align:center;font-weight:700;"> ${sessionScope.loggedinStore.storeName}  </h4> 
	             	  	   <p style="text-align:center;margin-top:0px;">${sessionScope.loggedinStore.fromDes} <br>
                                             							${sessionScope.loggedinStore.address}<br>
                                             							Tel. - ${sessionScope.loggedinStore.mobileNo} <br>
                                             							E-mail : ${sessionScope.loggedinStore.emailId}
	             	  	   </p> 
	             	  	   
                       <div style="border:1px solid black;padding:0px 10px;height:150px;border-radius:10px;width:92%">
                             <div style="display:flex;width:100%">
		             	 	    	<div style="width:30%"> <p style="margin-top:10px"> <b> Invoice No :</b> </p> </div> 
		             	 	    	<div style="margin-top:0px;width:70%"> <p style="border-bottom: 1px dotted #000;margin-top:10px;"> <span id="invoiceNo"></span> </p> </div>
	                       	  </div>
		             	  	  <!--  <div style="display:flex;width:100%">
		             	 	    	<div style="width:30%"> <p style="margin-top:0px"> <b> No. Person :</b> </p> </div> 
		             	 	    	<div style="margin-top:0px;width:70%"> <p style="border-bottom: 1px dotted #000;margin-top:0px;"> <span id="pax"></span> </p> </div>
	                       	  </div> -->
	                       	   <div style="display:flex;width:100%">
			             	 	    	<div style="width:33%"> <p style="margin-top:0px"> <b> Booking Date</b> </p> </div> 
			             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="bookingDate"></span> </p> </div>
			             	 	    	<div style="width:28%"> <p style="margin-top:0px"> <b> No. Person :</b> </p> </div> 
			             	 	    	<div style="width:14%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="pax"></span> </p> </div>
		                      </div>  
		             	 	    	    <!-- .............aparture time div................ -->
		                      <div style="display:flex;width:100%">
			             	 	    	<div style="width:33%"> <p style="margin-top:0px"> <b> Arrival Date</b> </p> </div> 
			             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkInDate"></span> </p> </div>
			             	 	    	<div style="width:17%"> <p style="margin-top:0px"> <b> Time</b> </p> </div> 
			             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkInTime"></span> </p> </div>
		                      </div>  
		             	 	    	       <!-- ....................Departure time div..................... -->
	                      		<div style="display:flex;width:100%">         
		             	 	    	<div style="width:33%"> <p style="margin-top:0px"> <b> Departure Date</b> </p> </div> 
		             	 	    	<div style="width:25%"> <p style="border-bottom: 1px dotted #000;margin-top:0px"> <span id="checkOutDate"></span> </p> </div>
		             	 	    	<div style="width:17%"> <p style="margin-top:0px"> <b> Time</b> </p> </div> 
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
		    <tfoot id = "biil_footers">
		    <!-- <tr>
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
		    </tr>
		    <tr>
		      <td colspan="8" style="text-align:left"> <b> Discount  </b> </td>
		      <td> <p id="totalDiscAmt"> </p> </td>
		      <td> <p id="totalDiscPaise"> </p> </td>  
		    </tr>
		    <tr>
		      <td colspan="8" style="text-align:left"> <b> Total  </b> </td>
		      <td> <p id="totalAmt"> </p> </td>
		      <td> <p id="totalAmtPaise"> </p> </td>  
		    </tr>
		    <tr style="display:none;">
		      <td colspan="8" style="text-align:right;border-bottom:0px"> <b> Advance  </b> </td>
		      <td> <p id="advAmt"> </p> </td>
		      <td> <p id="advAmtPaise"> </p> </td>  
		    </tr>
		    <tr style="display:none;">
		      <td colspan="8" style="text-align:right;border-bottom:0px;border-top:0px"> <b> Round Off  </b> </td>
		      <td> <p id="roundOffAmt"> </p> </td>
		      <td> <p id="roundOffPaise"> </p> </td>  
		    </tr>
		    <tr>
		      <td colspan="8" style="text-align:right;border-bottom:0px;border-top:0px"> <b> Net Amount  </b> </td>
		      <td> <p id="netAmt"> </p> </td>
		      <td> <p id="netAmtPaise"> </p> </td>  
		    </tr>
		    <tr>
		      <td colspan="10" style="padding:15px 0px"> 
		          <div style="text-align:left;display:flex;width:100%">
		          	<div style="width:17%">
		          	     <b> Rupees in word </b>   
		            </div>
		          <div style="border-bottom: 1px dotted #000;width:83%" id="billAmtInWords">
		          	
		          </div>
		      </td> 
		    </tr> -->
		</tfoot>
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
<!--New Bill Format End  -->

        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
 <script src="${pageContext.request.contextPath}/assets/js/hotelBaseScript.js"></script>
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

   <script type="text/javascript">
   var printReason="${sessionScope.loggedinStore.isProvideReason}";
   var BASE_URL="${pageContext.request.contextPath}";
   var storeID="${sessionScope.loggedinStore.id}";
   var todaydate="${today}";
   var servicechargeflag="${sessionScope.loggedinStore.serviceChargeFlag}";
   var vatTaxText="${sessionScope.loggedinStore.vatTaxText.length()}";
   var serviceTaxText="${sessionScope.loggedinStore.serviceTaxText.length()}";
   var is_Acc='${is_acc}';
   var mobPrintVal="${sessionScope.loggedinStore.mobBillPrint}";
   var printbillpapersize="${sessionScope.loggedinStore.printBillPaperSize}";
   var gsttext = "${sessionScope.loggedinStore.gstText}";
   var gstno = "${sessionScope.loggedinStore.gstRegNo}";
   var printReason="${sessionScope.loggedinStore.isProvideReason}";
   var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
   var storeAddr = "${sessionScope.loggedinStore.address}";
	var storeName = "${sessionScope.loggedinStore.storeName}";
	var storeEmail = "${sessionScope.loggedinStore.emailId}";
	var storePhNo = "${sessionScope.loggedinStore.phoneNo}";
	var storeCountry = "${sessionScope.loggedinStore.country}";
	var discountpercentage = "${sessionScope.loggedinStore.discountPercentage}";
	var billprint = "${sessionScope.loggedinStore.printPaidBill}";
	var currency = "${sessionScope.loggedinStore.currency}";
	var todesc = "${sessionScope.loggedinStore.toDes}";
   $(document).ready(function() {

		$('#checkindate').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true

		});
		$('#checkoutdate').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true

		});
      });


   </script>
  

   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>

    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script>
    </c:otherwise>
    </c:choose>

</body>
</html>
