<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
    <title>:. POS :: Credit Booking :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/assets/css/customstyle.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">

   <style type="text/css">
    .selected{
    background-color: #373737 !important;
    }

    /* .dataTables_empty{
         background-color:black;

    } */
    </style>
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>

           <div class="col-md-10 col-sm-10">
            <input type="hidden" id="dr_legder_id" value="0">
			 <input type="hidden" id="cr_legder_id" value="0">
                <div class="col-md-5 col-sm-5">
                <c:if test="${sessionScope.loggedinStore.id ==87}">
                <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.staffExpenditure" text="STAFF EXPENDITURE" /></div>
                </c:if>
                <c:if test="${sessionScope.loggedinStore.id !=87}">
                      <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.admleftpanel.jsp.creditBooking" text="CREDIT BOOKING" /></div>
                </c:if>
                </div>
                <div class="col-md-7 col-sm-7" id="customerdisplaydiv">
                 <c:if test="${sessionScope.loggedinStore.id !=87}">
                 <!-- ENTERS HERE IN WHERE STOREID!=*& AND CUSTOMERNAME AND PHONE IS DISPLAYED. -->
                    <div id="div1" style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.custName" text="CUSTOMER NAME" /> <span id="creditcustnameContId" style="color:#00CC33; ">${storeCustDetail.name}</span> <spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" /><span id="creditcustcontactContId" style="color:#00CC33;">${storeCustDetail.contactNo}</span></div>
                   </c:if>
                   <c:if test="${sessionScope.loggedinStore.id ==87}">
                <div id="div1" style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.staffName" text="STAFF NAME" /><span id="creditcustnameContId" style="color:#00CC33; ">${storeCustDetail.name}</span> <spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" /> <span id="creditcustcontactContId" style="color:#00CC33;">${storeCustDetail.contactNo}</span></div>
                </c:if>
                    <input type="hidden" id="creditcustidContId" value="${storeCustDetail.id}">
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div class="col-md-5 col-sm-5">
                  <div style="max-height: 500px;overflow-y:auto; ">
                    <div class="panel panel-default">

                        <div class="panel-body" id="creditcustomerlisttablepanelbody">
                            <div class="table-responsive" style="background:#404040;" id="creditcustomerlisttablediv">
                                <table class="table table-striped table-bordered table-hover" id="creditcustomerlisttable">
                                    <thead style="background:#404040; color:#FFF;">
                                    <c:if test="${sessionScope.loggedinStore.id !=87}">
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.custName" text="CUST. NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.custPh" text="CUST. CONTACT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.custAddr" text="CUST. ADDRESS" /></th>
                                            </c:if>
                                            <c:if test="${sessionScope.loggedinStore.id ==87}">
                                             <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.staffName" text="STAFF NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.staffPh" text="STAFF CONTACT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.staffAddr" text="STAFF ADDRESS" /></th>
                                            </c:if>
                                    </thead>
                                    <tbody>
                                    	 <c:if test="${! empty creditcustList }">
                                    		<c:forEach items="${creditcustList}" var="creditcust">
                                    			<tr style="background:#404040; color:#FFF;cursor:pointer;" onclick="javascript:getCreditBookingByCustomerId('${creditcust.id}','${creditcust.name}','${creditcust.contactNo}')">
                                    				<td>${creditcust.name}
                                    				<input id="hiddencreditcusid" value="${creditcust.id}" type="hidden"/>
                                    				</td>
                                    				<td align="center">${creditcust.contactNo}</td>
                                    				<td>${creditcust.address}</td>
                                    			</tr>
                                    		</c:forEach>
                                    	 </c:if>
                                        <c:if test="${empty creditcustList}">
                                              <tr style="background:#404040; color:#FFF;">
                                        		<td colspan="3"><spring:message code="admin.creditsale.jsp.noDataFound" text="No Data found!" /></td>
                                        	</tr> 
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    </div>
                    </div>
                    <div class="col-md-7 col-sm-7">
                    	<div style="max-height: 500px;overflow-y:auto; ">
                    		<div class="panel panel-default">
                        		<div class="panel-body">
                        		 <div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="/restwebposlang/assets/images/wait/wait.gif" height="150" width="150">
									</div>
                            		<div class="table-responsive" style="background:#404040;" id="creditcustomerbookingdetailsdiv">
                                		<table class="table table-striped table-bordered table-hover" id="creditcustomerbookingtable">
                                    		<thead style="background:#404040; color:#FFF;" id="creditcustomerbookingtableheader">
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.date" text="DATE" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.billAmt" text="BILL AMT" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMT" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.dueAmt" text="DUE AMT" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.pay" text="PAY" /></th>
                                            	<%-- <th style="text-align:center;"><spring:message code="paidorder.jsp.ACTION" text="ACTION" /></th> --%>
                                    		</thead>
                                    		<tbody id="creditcustomerbookingbody">
                                    		
                                    		<%-- <c:if test="${! empty creditOrderList }">
                                    		  <c:set var="totBillAmt" value="0.0"></c:set>
                                    			<c:set var="totDiscAmt" value="0.0"></c:set>
                                    			<c:set var="totPaidAmt" value="0.0"></c:set>
                                    			<c:forEach items="${creditOrderList}" var="creditorder">
                                    				<tr style="background:#404040; color:#FFF;">
                                    					<td align="center">${creditorder.orderNo}</td>
                                    					<td align="center">${fn:substring(creditorder.orderTime, 0, 10)}</td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditorder.orderBill.grossAmt}"/></td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditorder.paidAmt}"/></td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditorder.orderBill.grossAmt-creditorder.paidAmt}"/></td>
                                    					<td align="center" style="width:25%;"><a href="javascript:opencr_saleCashModal(${creditorder.id},'${creditorder.table_no}',${creditorder.orderBill.grossAmt},${creditorder.paidAmt},'${creditorder.orderNo}')" class="btn btn-success"><spring:message code="admin.creditsale.jsp.cash" text="CASH" /></a>&nbsp;<a href="javascript:opencr_saleCardModal(${creditorder.id},'${creditorder.table_no}',${creditorder.orderBill.grossAmt},${creditorder.paidAmt},'${creditorder.orderNo}')" class="btn btn-success"><spring:message code="admin.creditsale.jsp.card" text="CARD" /></a></td>
                                    				    <td align="center"><a href="javascript:getCreditOrderById(${creditorder.id},'${creditorder.table_no}',${creditorder.orderBill.grossAmt},${creditorder.paidAmt},'${creditorder.orderNo}')" class="btn btn-success"><spring:message code="order.jsp.PRINT" text="PRINT" /></a></td>
                                    				</tr>
                                    				<c:set var="totBillAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt+creditorder.orderBill.grossAmt}"/></c:set>
                                    				<c:set var="totDiscAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totDiscAmt+creditorder.orderBill.customerDiscount}"/></c:set>
                                    				<c:set var="totPaidAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPaidAmt+creditorder.paidAmt}"/></c:set>
                                    			</c:forEach>
                                    			<c:if test="${creditOrderList.size()>1}">
                                    			<tr style="background:#e2e2e2; color:#222222;">
                                    				<td colspan="2" align="center"><spring:message code="admin.creditsale.jsp.total" text="TOTAL" /></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt}"/></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPaidAmt}"/></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt-totPaidAmt}"/></td>
                                    				<td align="center"><a href="javascript:opentotcr_saleCashModal(${totBillAmt},${totPaidAmt})" class="btn btn-success"><spring:message code="admin.creditsale.jsp.cash" text="CASH" /></a>&nbsp;<a href="javascript:opentotcr_saleCardModal(${totBillAmt},${totPaidAmt})" class="btn btn-success"><spring:message code="admin.creditsale.jsp.card" text="CARD" /></a></td>
                                    			</tr>
                                    			</c:if>
                                    		</c:if>
                                        	<c:if test="${empty creditOrderList}">
                                        		<tr style="background:#404040; color:#FFF;">
                                        			<td colspan="6"><spring:message code="admin.creditsale.jsp.noDataFound" text="No Data found!" /></td>
                                        		</tr>
                                        	</c:if> --%>
                                    		</tbody>
                                		</table>
                            		</div>
                            		<%-- <div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
								          	</div> --%>
                            		<%-- <div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
									</div> --%>
                        		</div>
                    		</div>
                    	</div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
           </div>

            </div>
            <!-- DIV FOR DISPLAYING AND PREINTING BILLS -->
            <div id="wrapperbilldiv" >
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
            
            
            
            
            
            </div>
            
            
            
            
            
            
            
           <!-- modal starts -->
           	<div class="modal fade" data-backdrop="static" id="cashModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" class="hide">
		<div id="cashModaldialog" class="modal-dialog" style="margin: 100px auto;">
			<div id="cashModalContent" class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div id="cashModalHeader" class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="cashModalHeader">
						<%-- <spring:message code="order.jsp.BOOKINGID" text="BOOKING ID:" /> --%>
						<span id="cashmodReserveCont" style="display: none;">00</span>
						BOOKING NUMBER:<span id="cashModalHeaderSpanForBookingNumber"></span>
					
					</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						<div style="padding: 5px;">
							<spring:message code="order.jsp.paymentmode" text="PAYMENT MODE" />
							:&nbsp;&nbsp;&nbsp;<span id="paymentmodeincashmodal"></span>
						</div>
						<div style="padding: 5px;">
							<spring:message code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />
							<!-- class="hide" -->
							:&nbsp;&nbsp;&nbsp;<span id="totalamountincashmodal">0.00</span>
						</div>
						<div style="padding: 5px;">
							<spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />
							:&nbsp;&nbsp;&nbsp;<span id="amounttopayincashmodal">0.00</span>
						</div>
						<div id="cashpaidamtdivId" style="padding: 5px;">
							<spring:message code="order.jsp.PAIDAMOUNT" text="PAID AMOUNT" />
							:&nbsp;&nbsp;&nbsp;<span id="paidamountincashmodal">0.00</span>
						</div>
						<div style="padding: 3px;">
							<%-- <spring:message code="order.jsp.CASHAMOUNT"
										text="CASH AMOUNT" /> --%>
							<spring:message code="order.jsp.TENDERAMOUNT"
								text="TENDER AMOUNT" />
							:&nbsp;<input type="text" value="" id="cashtenderAmtinCashModal"
								style="text-align: center; color: #222222" size="4"
								autocomplete="off" onkeydown="javascript:numericcheck(event)" />
							<!-- onkeyup="javascript:getChangeAmt(this.value)" -->
						</div>
						<div style="padding: 5px; " class="hide" id="cardNoDiv">
							<spring:message code="order.jsp.CARDLAST4DIGIT"
								text="CARD LAST 4 DIGIT" />
							:&nbsp;<input type="text" id="cardlastfourDigit"
								style="text-align: center; color: #222222" size="4"
								maxlength="4" />
						</div>
						<div style="padding: 3px;">
										<spring:message code="rb.roombooking.printbill"
										text="PRINT BILL" />
									:&nbsp;<input type="checkbox"
										 value=""
										id="printbillcheckbox" style="text-align: center; color: #222222"
										size="4" autocomplete="off" />  <!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
						<input type="text" id="paytypeid" style="display: none;" /> <input
							type="text" id="discamt" style="display: none;" /> <input
							type="text" id="taxamount" style="display: none;" /> <input
							type="text" id="grossamount" style="display: none;" /> <input
							type="text" id="roomServiceGross" style="display: none;" /> <input
							type="text" id="roomServiceTax" style="display: none;" /> <input
							type="text" id="roomServiceDiscount" style="display: none;" />
							<input type="text" id="bookingId" class="hide" disabled />
							
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
							<%-- <div style="padding: 5px;" id="billprintoption">
								<input type="checkbox" id="chkprintBillCash"
									style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;
								<spring:message code="order.jsp.PRINT" text="PRINT" />
								PAID BILL
							</div> --%>
							<br />
						</c:if>
						<%-- <c:if
							test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }"> --%>
							<table class="ui-bar-a" id="cashpaymenttable">
								<tbody id="cashpaymenttabletbody">
								
								<tr>
									
									<td colspan="4"><a data-role="button"
										style="border: 2px solid #404040; width: 184px;"
										data-theme="done" class="btn btn-success btn-lg" id="exactamountincashmodal"><spring:message
												code="order.jsp.EXACTAMT" text="EXACT AMT" /></a></td>
								</tr>
								</tbody>
							</table>
						<%-- </c:if> --%>
					</div>

				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						<div id="hiddenadvpaycustdataopmassagecont1"
							style="display: none;"></div>
					</button>


					<button type="button"
						onclick="javascript:payBillInCash(document.getElementById('cashtenderAmtinCashModal').value)"
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">
						<spring:message code="order.jsp.PAY" text="PAY" />
					</button>


				</div>
			</div>
		</div>
	</div>
           <div class="modal fade" data-backdrop="static"
				id="alertOrderPaidModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Success" text="Success" /></h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;"><spring:message code="admin.unpaidOrders.jsp.PaymentSuccessful" text="Payment Successfully Done!" /></div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="javascript:creditPaymentDone()"
								style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>

						</div>
					</div>
				</div>
			</div>
           					<div class="modal fade" data-backdrop="static" id="cr_salecashModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">

                                            <spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" /> <span id="cr_salecashmodOrderCont" style="display:none;">00</span><span id="cr_salecashmodStoreBaseOrderCont" >00</span>  

              <%--                               <spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" /> <span id="cr_salecashmodOrderCont">00</span> --%>

                                            <span style="float: right;"><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />: <span id="cr_salecashmodTabCont">00</span></span>

                                            </h4>

                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="cr_salecashtotamtcontId">0.00</span></div>
                                           		<!-- <div style="padding: 5px;">DISC. AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cr_salecashdiscamtcontId">0.00</span></div> -->
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="cr_salecashpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY" /> :&nbsp;&nbsp;&nbsp;<span id="cr_salecashamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" /> :&nbsp;<input type="text" onkeyup="javascript:getcr_saleChangeAmt(this.value)"  value="" id="cr_salecashtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.changeAmt" text="CHANGE AMOUNT" /> :&nbsp;<span id="cr_salecashchangeamtcontId">0.00</span> </div>
                                            	<div style="padding: 5px;"><spring:message code="admin.storecustmgnt.jsp.crpayremarkcap" text="REMARK" /> :&nbsp;<input  type="text" id="creditpayremarkbycash" name="CreditPayRemarkByCash" value="" style="color:black;"/></div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="cr_salepaycashalertMsg"></div>

                                            </div>

										</div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" /></button>
                                           <button type="button" onclick="javascript:cr_salepayByCash(document.getElementById('cr_salecashtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" data-backdrop="static" id="cr_salecardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">

                                    <spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" />: <span id="cr_salecardmodOrderCont" style="display:none;">00</span> <span id="cr_salecardmodStoreBaseOrderCont">00</span> 

                                            <%--  <spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" />: <span id="cr_salecardmodOrderCont">00</span>--%>

                                            <span style="float: right;"><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />: <span id="cr_salecardmodTabCont">00</span></span>

                                            </h4>

                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="cr_salecardtotamtcontId">0.00</span></div>
                                           		<!-- <div style="padding: 5px;">DISC. AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cr_salecarddiscamtcontId">0.00</span></div> -->
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="cr_salecardpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY " />: &nbsp;&nbsp;&nbsp;<span id="cr_salecardamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" />&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" id="cr_salecardtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.cardLast4Digit" text="CARD LAST 4 DIGIT" /> :&nbsp;<input type="text" id="cr_salecardlastfourDigit" style="text-align:center; color: #222222" size="4"/> </div>
                                            	<div style="padding: 5px;"><spring:message code="admin.storecustmgnt.jsp.crpayremarkcap" text="REMARK" /> :&nbsp;<input  type="text" id="creditpayremarkbycard" name="CreditPayRemarkByCard" value="" style="color:black;"/></div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="cr_salepaycardalertMsg"></div>
                                            </div>

                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" /></button>
                                           <button type="button" onclick="javascript:cr_salepayByCard(document.getElementById('cr_salecardtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                          <div class="modal fade" data-backdrop="static" id="totcr_salecashModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                           <c:if test="${sessionScope.loggedinStore.id ==87}">
                                           <spring:message code="admin.creditsale.jsp.cont_one" text="Staff expense Bulk Payment By Cash" />
                                           </c:if>
                                           <c:if test="${sessionScope.loggedinStore.id !=87}">
                                           <spring:message code="admin.creditsale.jsp.cont_two" text="Credit Sale Bulk Payment By Cash" />
                                           </c:if>

                                          </h4>

                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecashtotamtcontId">0.00</span></div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="totcr_salecashpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecashamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" /> :&nbsp;<input type="text" onkeyup="javascript:gettotcr_saleChangeAmt(this.value)"  value="" id="totcr_salecashtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.changeAmt" text="CHANGE AMOUNT" /> :&nbsp;<span id="totcr_salecashchangeamtcontId">0.00</span> </div>
                                            	<div style="padding: 5px;"><spring:message code="admin.storecustmgnt.jsp.crpayremarkcap" text="REMARK" /> :&nbsp;<input  type="text" id="totcreditpayremarkbycash" name="TotCreditPayRemarkByCash" value="" style="color:black;"/></div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="totcr_salepaycashalertMsg"></div>
                                            </div>

										</div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" /></button>
                                           <button type="button" onclick="javascript:totcr_salepayByCash(document.getElementById('totcr_salecashtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><span id="totcashpaySpinner" style="display: none;"><i class="fa fa-spinner fa-spin"></i></span>&nbsp;<spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" data-backdrop="static" id="totcr_salecardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            <c:if test="${sessionScope.loggedinStore.id ==87}">
                                           <spring:message code="admin.creditsale.jsp.cont_three" text="Staff expense Bulk Payment By Card" />
                                           </c:if>
                                           <c:if test="${sessionScope.loggedinStore.id !=87}">
                                           <spring:message code="admin.creditsale.jsp.cont_four" text="Credit Sale Bulk Payment By Card" />
                                           </c:if>
                                            </h4>

                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecardtotamtcontId">0.00</span></div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="totcr_salecardpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecardamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" />&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" id="totcr_salecardtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.cardLast4Digit" text="CARD LAST 4 DIGIT" /> :&nbsp;<input type="text" id="totcr_salecardlastfourDigit" style="text-align:center; color: #222222" size="4"/> </div>
                                            	<div style="padding: 5px;"><spring:message code="admin.storecustmgnt.jsp.crpayremarkcap" text="REMARK" /> :&nbsp;<input  type="text" id="totcreditpayremarkbycard" name="TotCreditPayRemarkByCard" value="" style="color:black;"/></div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="totcr_salepaycardalertMsg"></div>
                                            </div>

                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCELD" /></button>
                                           <button type="button" onclick="javascript:totcr_salepayByCard(document.getElementById('totcr_salecardtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><span id="totcardpaySpinner" style="display: none;"><i class="fa fa-spinner fa-spin"></i></span>&nbsp;<spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                       
   <!--PRINT 80 START   -->  
             <div class="modal fade" data-backdrop="static"
				id="cashhelloPrintModal80" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">

					<div class="modal-body" id="printDiv80"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; width: 230px; font-size: 20px; color: #000000">

							<b><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							<div id="storeName80">${sessionScope.loggedinStore.storeName}</div></font></b>
							<c:if test="${sessionScope.loggedinStore.id==126}">
								<b><font
									style="font-size: 10px; font-style: normal; font-family: sans-serif;">A
										UNIT OF SAPPHIRE CAFE LLP</font></b>
							</c:if>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="storeAddr80">${sessionScope.loggedinStore.address}</div></font></b>
								<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
								<div id="storeEmail80"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
								<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="storePhNo80"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>

							

							<div id="paidgstdata" style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">

							</div>
							 <b><span id="billtype80"></span></b>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="cashOrdervalue80" style="font-weight:bold">00</span>
							</div>


							<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<b>Date :</b> <span  id="cashOrderdate80">00</span>
							</div>
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
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><%-- <spring:message
													code="order.jsp.tender_amount" text="Tender Amount" /> --%>Amount
												To Pay:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
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
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/creditsale/loadcreditbooking.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
        <!--PRINT 80 END  -->
        <!--PRINT 2100 START  -->  
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
								<b>CREDIT SALE INVOICE </b>
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
									<!-- <td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td> -->
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


        
        <!--PRINT 2100 END  -->           
                            
           <!-- modal ends -->

        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->

    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/CreditSaleBill.js"></script>
     <script src="${pageContext.request.contextPath}/assets/js/creditbooking.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- MOMENT JS FILE -->
    <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
    
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>

   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   var is_Acc='${is_acc}';
   var mobBillPrint="${sessionScope.loggedinStore.mobBillPrint}";
   var printbillpapersize = "${sessionScope.loggedinStore.printBillPaperSize}";
   var gsttext = "${sessionScope.loggedinStore.gstText}";
   var gstno = "${sessionScope.loggedinStore.gstRegNo}";
   var language = '<%= session.getAttribute("language") %>';
   var storeID="${sessionScope.loggedinStore.id}";
   var directBooking="${directBooking}";
   var frontDeskPerson = "${sessionScope.loggedinUser.contactNo}";
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
     if(is_Acc=='Y')
    	 {
    	 //getcustomerledger_pur('SDE',0,document.getElementById('hiddencreditcusid').value,2)// for customer
    	 
    	            getvendorledger_sale($('#dueties_and_tax_accf').val(),0,0,0); // for duties and tax
	    			getvendorledger_sale($('#roundoff_group_codef').val(),0,0,1); // for round off
	    			getvendorledger_sale($('#saleaccunt_group_codef').val(),0,0,2); // for sale account
	    			getvendorledger_sale($('#dicount_codef').val(),0,0,4); // for discount acc
	    			getvendorledger_sale($('#service_charge_codef').val(),0,0,7); // for service_tax acc
	    			getvendorledger_sale($('#cash_codef').val(),0,0,5);// for cash ledger
	    			getvendorledger_sale($('#card_codef').val(),0,0,6);// for card
    	 
    	 
    	 
    	 
    	 
    	 }

    $('#creditcustomerlisttable tbody tr').on('click',function(e){
	  $(this).closest('table').find('td').removeClass('selected');
		$(this).find('td').addClass('selected');
		//e.stopPropagation();
	});
    function showcr_saleCashModal()
	{
		//alert('order');
		$('#cr_salecashModal').modal('show');
	}
    function showalertOrderPaidModal()
	{
		$('#alertOrderPaidModal').modal('show');
	}
	function showcr_saleCardModal()
	{
		//alert('order');
		$('#cr_salecardModal').modal('show');
	}
	function hidecr_saleCashModal()
	{
		//alert('order');
		$('#cr_salecashModal').modal('hide');
	}
	function hidecr_saleCardModal()
	{
		//alert('order');
		$('#cr_salecardModal').modal('hide');
	}
	//for total
	function showtotcr_saleCashModal()
	{
		//alert('order');
		$('#totcr_salecashModal').modal('show');
	}
	function showtotcr_saleCardModal()
	{
		//alert('order');
		$('#totcr_salecardModal').modal('show');
	}
	function hidetotcr_saleCashModal()
	{
		//alert('order');
		$('#totcr_salecashModal').modal('hide');
	}
	function hidetotcr_saleCardModal()
	{
		//alert('order');
		$('#totcr_salecardModal').modal('hide');
	}


	

   </script>




  <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>

    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script>
    </c:otherwise>
    </c:choose>
      <%-- <script src="${pageContext.request.contextPath}/assets/js/lang/numerickey.js"></script> --%>
   <%--   <script src="${pageContext.request.contextPath}/assets/js/lang/baseScript.js"></script> --%>
				

</body>
</html>
