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
<title>:. POS :: Paid Order :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
<style type="text/css">
.selected {
	background-color: #373737 !important;
}
</style>
<script>
	function rowClicked() {
		alert("Table row clicked");
	}
</script>
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<%-- 	<c:set var="today" value="<%=new java.util.Date()%>" /> --%>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">

			<div class="row">
				<div class="col-md-12 col-sm-12">
					<form modelAttribute="order" action="${pageContext.request.contextPath }/order/viewallpaidorderbydate.htm" method="post">
						<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="paidorder.jsp.SelectDateForviewOrderDetails" text="Select Date For view Order Details" /></span>&nbsp;&nbsp; <input type="text" id="daywiseorderdetails" name="orderDate" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"> <input type="hidden" id="hiddaywiseorderdetails" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
						<input type="submit" value="<spring:message code="paidorder.jsp.submit" text="Submit" />" class="btn btn-primary">
					</form>
				</div>
				<br/><br/>
				<div class="col-md-12 col-sm-12">
					<div style="background: #404040; overflow-y: auto; padding: 2px;">
						<div class="panel panel-default" style="background: #404040;">
							<div class="panel-body" style="max-height: 500px;">
								<div style="padding: 3px;">
									<div class="table-responsive" id="paidordertableContId">
										<table class="table table-striped table-bordered" id="ordertableId" style="color: #FFF; border: 1px solid #222222;">
											<thead>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.SLNO" text="SL NO" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ORDERNO" text="ORDER NO" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ORDERAMT" text="ORDER AMT" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.TABLENO" text="TABLE NO" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ORDERDATE" text="ORDER DATE" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.show" text="SHOW" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ACTION" text="ACTION" /></th>
											</thead>
											<tbody style="color: #fff;">
												<c:if test="${ empty allpaidOrderList}">
												<tr style="background: #222222; cursor: pointer;">
												<td style="text-align: center;" colspan="7"><spring:message code="paidorder.jsp.NoOrdersfound" text="No Orders found" />.</td>
												</tr>
											
											</c:if>
												<c:if test="${! empty allpaidOrderList}">
													<c:forEach items="${allpaidOrderList}" var="paidOrders" varStatus="stat">
														<tr style="background: #222222; cursor: pointer;">
															<td style="text-align: center;">${stat.index+1}</td>
															<td style="text-align: center;">${paidOrders.orderNo}</td>
															<td style="text-align: center;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${paidOrders.orderBill.grossAmt}"></fmt:formatNumber></td>
															<td style="text-align: center;">
																<c:choose>
																	<c:when test="${paidOrders.table_no=='0'}">
																	${paidOrders.ordertype.orderTypeName}
                                									</c:when>
																	<c:otherwise>
                                									${paidOrders.table_no}
                                									</c:otherwise>
																</c:choose></td>
															<td style="text-align: center;">${paidOrders.orderTime}</td>
															<td align="center">
															   <c:choose>
																	<c:when test="${paidOrders.refundStatus=='F'}">
																	<a href="javascript:showRefundBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 50%; margin-top: 2px;"><span class="fa fa-eye"></span>&nbsp;<spring:message code="paidorder.jsp.show" text="SHOW" /> </a>
                                									</c:when>
																	<c:otherwise>
                                									<a href="javascript:showPaidBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 50%; margin-top: 2px;"><span class="fa fa-eye"></span>&nbsp;<spring:message code="paidorder.jsp.show" text="SHOW" /> </a>
                                									</c:otherwise>
																</c:choose>
															</td>
															<td align="center">
															   <c:choose>
																	<c:when test="${paidOrders.refundStatus=='F'}">
																	<a href="javascript:printRefundBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 50%; margin-top: 2px;"><span class="fa fa-print"></span>&nbsp;<spring:message code="paidorder.jsp.REFUNDPRINT" text="REFUND PRINT" /> </a>
                                									</c:when>
																	<c:otherwise>
                                									<a href="javascript:printPaidBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 50%; margin-top: 2px;"><span class="fa fa-print"></span>&nbsp;<spring:message code="paidorder.jsp.PRINT" text="PRINT" /> </a>
                                									</c:otherwise>
																</c:choose>
															</td>
														</tr>
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
			<div class="modal fade" data-backdrop="static" id="paidbillPrintSuccessModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="paidorder.jsp.Success" text="Success" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="hidden" id="hiddmanualeditItemId" value=""> <spring:message code="paidorder.jsp.Billhasbeensuccessfullyprinted" text="Bill has been successfully printed" />!
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:showDirectPaymentforPacel()" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="paidorder.jsp.OK" text="OK" /></button>
						</div>
					</div>
				</div>
			</div>

		<%-- <div class="modal fade" data-backdrop="static" id="helloPrintModalPaidOrder80"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">
				
 		 <div class="modal-body" id="paidOrder80"
					style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						
						
						<div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> 
					
						<div
							style="text-align: center;  width: 230px; font-size: 20px; color: #000000">

							<b><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div id="storeNamePaidOrder80"></div></font></b>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storeAddrPaidOrder80"></div></font></b>

<font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storeEmailPaidOrder80"></div></font>
<font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storePhNoPaidOrder80"></div></font><br>
							
							<div
								style="text-align: center; padding:0 0 0 10px; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmailPaidOrder80"></div>
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="storePhNoPaidOrder80"></div>
							</div>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice" text="Order No / Invoice "/>:</b> <span id="cashOrdervaluePaidOrder80">00</span>
							</div>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;" id="showtableno80px">
								<b><spring:message code="order.jsp.TableNo" text="Table No:"/> </b> <span id="cashtableNoValuePaidOrder80">00</span>
							</div>
							
					 <div class="table-responsive" id="orderitemContId">
								<table style="color: #000000; border: none; height: 50px; width: 100%;">
								
										<thead>
										<tr>
											<th style="font-size: 11px; width: 102px;"><span
												style="float: left;font-family: sans-serif;"><spring:message code="order.jsp.Items" text="Items"/></span></th>
											<th style="text-align: center; font-size: 11px;font-family: sans-serif;"><spring:message code="order.jsp.Qty" text="Qty"/></th>
											<th style="text-align: right; font-size: 11px;font-family: sans-serif;"><spring:message code="order.jsp.RATE" text="RATE" /></th>
											<th style="text-align: right; font-size: 11px;font-family: sans-serif;"><spring:message code="order.jsp.TOTAL" text="TOTAL" /></th>
										</tr>
										</thead>
										
								<tbody style="color: #000000; padding: 1px;" id="itemDetailsPrintPaidOrder80"></tbody>
										
						</table>
							</div> 
							
							<div style="text-align: center;">--------------------------------</div>

							<table style="height: 50px; width: 100%;">
								
								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashtotalamtPaidOrder80">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.ServiceCharge" text="Service Charge" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;">
										<span id=cashservChrgPaidOrder80>00</span></td>
								</tr>

								<tr id="cashtotalServiceTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message code="order.jsp.TotalServiceTax" text="Total Service Tax(6.0%)" /></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashservTaxPaidOrder80">00</span></td>
								</tr>

								<tr id="cashtotalVatTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message code="order.jsp.TotalVat" text="Total Vat" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashvatTaxPaidOrder80">00</span></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.GrossAmount" text="Gross Amount" /> :</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashgrossAmountPaidOrder80">00</span></b></td>
								</tr>
								
								<tr id="cashshowDiscount80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT" text="TOTAL DISCOUNT" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashdiscountValuePaidOrder80">00</span></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashamoutToPayPaidOrder80">00</span></b></td>
								</tr>
								
								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>
								
								
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="paidAmountPaidOrder80">00</span></b></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmountPaidOrder80">00</span></b></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundAmountPaidOrder80">00</span></b></td>
								</tr>
								
								
								
								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>

							</table>
							
<div style="text-align: center;width: 150px;"><b><font style="font-size: 12px;font-family: sans-serif;"><div id="payOrderTypePaidOrder80"></div></font></b></div>
							<div style="text-align: center;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.**Thank You. Visit Again" text="**Thank You. Visit Again" />**</font>
							</div>
						</div>
						<div class="modal-footer" id="cashRemovePrintPaidOrder80"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:paidOrder80()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtnPaidOrder80"><spring:message code="order.jsp.PRINT" text="PRINT" /></button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success"><spring:message code="order.jsp.CANCEL" text="CANCEL"/></button>
						</div>
					</div>

					
				</div>
			</div> --%>
			
			
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

							<b><font style="font-size: 18px; font-style: inherit; font-family: sans-serif;"><div id="storeName80">${sessionScope.loggedinStore.storeName}</div></font></b>
										<c:if test="${sessionScope.loggedinStore.id==126}">
									<b><font style="font-size: 10px;  font-style: normal; font-family: sans-serif;">A UNIT OF SAPPHIRE CAFE LLP</font></b>
							 	</c:if> 
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storeAddr80">${sessionScope.loggedinStore.address}</div></font></b> 
							    <font style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div id="storeEmail80"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
								<div id="storeWeb80"><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><spring:message code="order.jsp.Web" text="Website" /> :${sessionScope.loggedinStore.url}</font></div>									    
							    <font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storePhNo80"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>${sessionScope.loggedinStore.mobileNo}</div></font>

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
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="cashOrdervalue80">00</span>
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
							<%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno80px">
								<b><spring:message code="order.jsp.TableNo" text="Table No:" />
								</b> <span id="cashtableNoValue80">00</span>
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

							<table style="height: 50px; width: 100%;"   id="orderAmtDetails">

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
								<tr id="cashtotalServiceCharge80px"  class="serviceCharge80px">
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
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><%-- <spring:message
											code="order.jsp.TotalCGST"
											text="Total CGST" /> --%>${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashservTax80">00</span></td>
								</tr>

								<tr id="cashtotalVatTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><%-- <spring:message
											code="order.jsp.TotalSGST" text="Total SGST" /> --%>${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%)
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
                               
                              
                               <tr id="cusnametr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Name:</td>
									<td id="cusname80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr> 
								 <tr id="cusphnotr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Ph No:</td>
									<td id="cusphno80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr> 
                                  <tr id="cusaddresstr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Address:</td>
									<td id="cusaddress80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr> 
                                   <tr id="cuslocationtr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Location:</td>
									<td id="cuslocation80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr> 
                                  <tr id="cusstreettr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Street:</td>
									<td id="cusstreet80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>  
                                   <tr id="cushousenotr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >House No:</td>
									<td id="cushouseno80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr> 
                                    
                                   <tr id="deliveryboytr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Dlv By:</td>
									<td id="deliveryboy80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
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
			
			<div class="modal fade" data-backdrop="static" id="helloPrintModalpaidOrder58"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 200px; height: auto;">


					<div class="modal-body" id="printDiv58"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						
						<div style="text-align: center; height: auto; font-size: 20px; color: #000000;word-wrap: break-word;width: 170px;">


							 <%-- <div style="text-align: center; width: 230px;">
								<input type="image"	src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
							</div> --%> 


							<b><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div id="storeName58">${sessionScope.loggedinStore.storeName}</div></font></b>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storeAddr58">${sessionScope.loggedinStore.address}</div></font></b>


                             <font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storeEmail58"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
                             <font style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div id="storePhNo58"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>${sessionScope.loggedinStore.mobileNo}</div></font><br>


							<%-- <div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmailPaidOrder58"></div>
							</div>
							<div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="storePhNoPaidOrder58"></div>
							</div> --%>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice" text="Order No / Invoice "/>:</b> <span id="orderValue58">00</span>
							</div>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Date :</b><span id="cashOrderdate58">00</span>
							</div>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;" id="showtableno">
								<%-- <spring:message code="order.jsp.TableNo" text="Table No :"/> --%> <b><span id="tableNoValue58">00</span></b>
							</div>
							
					<div class="table-responsive" id="orderitemContId">

								<table
									style="color: #000000; border: none; height: 50px; width: 130px;">
									
										<thead>

											<th style="font-size: 10px; width: 30px;"><span
												style="float: left;font-family: sans-serif;"><spring:message code="order.jsp.Items" text="Items"/></span></th>
											<th style="text-align: center; font-size: 10px;font-family: sans-serif;"><spring:message code="order.jsp.Qty" text="Qty"/></th>
											<th style="text-align: right; font-size: 10px;font-family: sans-serif;"><spring:message code="order.jsp.Rate" text="Rate"/></th>
											<th style="text-align: right; font-size: 10px;font-family: sans-serif;"><spring:message code="order.jsp.Total" text="Total"/></th>
											
										</thead>

										<tbody style="color: #000000; padding: 1px"; id="itemDetailsPrint58"></tbody>
								</table>

							</div>
						
							<div style="text-align: right;width: 150px;" >--------------------</div>

							<table style="height: 50px; width: 150px;">
								
								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="totalAmt58">00</span></td>
								</tr>
								<tr id="totalServiceChrg_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge" text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}(${sessionScope.loggedinStore.serviceChargeText}):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servChrg58">00</span></td>
								</tr>

								<tr id="totalServiceTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><%-- <spring:message code="order.jsp.TotalServiceTax" text="Total Service Tax" /> --%>${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servTax58">00</span></td>
								</tr>

								<tr id="totalVatTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><%-- <spring:message code="order.jsp.TotalVat" text="Total Vat " /> --%>${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="vatTax58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="grossAmount58">00</span></b></td>
								</tr>
								<tr id="showDiscount_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT" text="TOTAL DISCOUNT" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="discountValue58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="amoutToPay58">00</span></b></td>
								</tr>
									<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="paidAmount58">00</span></b></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmount58">00</span></b></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundAmount58">00</span></b></td>
								</tr>
								
								
								
								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>
							</table>
<div style="text-align: left;width: 150px;"><b><font style="font-size: 12px;font-family: sans-serif;"><div id="payOrderTypePaidOrder58"></div></font></b></div>
							<div style="text-align: left;width: 150px;"><font style="font-size: 12px;font-family: sans-serif;"><spring:message code="order.jsp.ThankYouVisitAgain" text="**Thank You. Visit Again" /></font></div>
							</div>
						</div>
						<div class="modal-footer" id="removePrint58"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:paidOrder58()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtnPaidOrder58"><spring:message code="order.jsp.PRINT" text="PRINT" /></button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success"><spring:message code="order.jsp.CANCEL" text="CANCEL"/></button>
						</div>
					</div>
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
										<b>Contact No:</b><span id="cashCustPhone2100_GST"></span>
									   </div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b><span id="cashCustState_GST"></span>
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
									<td style="font-size: 14px; font-family: sans-serif;display:none;">
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
				
			
			<!-- modal ends -->
			
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
							value="${sessionScope.loggedinStore.mobBillPrint}">
							<input
							type="hidden" id="kotPrintVal"
							value="${sessionScope.loggedinStore.kitchenPrintBt}">
							<input
							type="hidden" id="printbillpapersize"
							value="${sessionScope.loggedinStore.printBillPaperSize}">
							
							<div class="modal fade" data-backdrop="static" id="cashhelloPrintModal2100"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">
				
 		 <%-- <div class="modal-body" id="printDiv2100"
					style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						
						<div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div>
					 
						<div
							style="text-align: center;  width: auto; font-size: 20px; color: #000000">

							<b><font style="font-size: 19px; font-style: inherit; font-family: sans-serif;"><div id="storeName2100"></div></font></b>
							<b><font style="font-size: 17px; font-style: normal; font-family: sans-serif;"><div id="storeAddr2100"></div></font></b>
							
							<font style="font-size: 15px; text-align: center;  width: auto; font-style: inherit; font-family: sans-serif;"><div id="storeEmail2100"></div></font>
							<font style="font-size: 15px; text-align: center;  width: auto; font-style: normal; font-family: sans-serif;"><div id="storePhNo2100"></div></font><br>

							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No:</b> <span id="cashOrdervalue2100">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;" id="showtableno2100px">
								<b>Table No:</b> <span id="cashtableNoValue2100">00</span>
							</div>
		<!-- <div style="text-align: left;">-------------------------------------------------------------------------------------------------------</div> -->
									
					 <div class="table-responsive" id="orderitemContId_2100">
								<table style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"> <!-- color: #000000; border: none; height: 50px; width: 100%; -->
					
										<thead>
										
										<tr style="border-bottom: 1px dashed;">
									<th width="5%;"><spring:message code="reprintcash.jsp.invno" text="SNo" /></th>
									<th width="30%;"><spring:message code="item.jsp.name" text="Item Name" /></th>
									<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
									<th><spring:message code="purinvdet.jsp.batch" text="SAC"/></th>
									<th width="6%;"><spring:message code="purinvdet.jsp.expdt" text="Qty" /></th>
									<th width="6%;"><spring:message code="purinvdet.jsp.expdt" text="Unit" /></th>
									<th width="5%;"><spring:message code="purinvdet.jsp.pqty" text="Rate" /></th>
									<th width="5%;"><spring:message code="purinvdet.jsp.lqty" text="Total" /></th>
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Disc" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Taxable Value" /></th>
									<th width="18%;" colspan="2">&nbsp;<spring:message code="purinvdet.jsp.mrp" text="CGST" />&nbsp;</th>
									<th width="18%;" colspan="2">&nbsp;<spring:message code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;</th>
									<th width="18%;" colspan="2">&nbsp;<spring:message code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;</th>
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
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Amt." /></th>
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Amt." /></th>
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Amt." /></th>
								</tr>
										<!-- <tr>
											<th style="font-size: 15px; width: 102px;"><span style="float: left;font-family: sans-serif;">Item</th>
											<th style="width:110px; float:right;padding-right:120px;text-align: center; font-size: 15px;font-family: sans-serif;">Qty</th>
											<th style="width:110px; padding-right:110px; text-align: center; font-size: 15px;font-family: sans-serif;">Rate</th>
											<th style="width:110px; text-align: center; font-size: 15px;font-family: sans-serif;">Amt</th>
										</tr> -->
										</thead>
															
										
										<tbody style="color: #000000; padding: 1px;" id="itemDetailsPrint2100"></tbody>
										
						</table>
							</div> 
						
							
 <!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

							<table style="height: 50px; width: 100%;">
								
								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">TOTAL AMOUNT:</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashtotalamt2100">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										Service Charge:</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<span id="cashservChrg2100">00</span></td>
								</tr>

								<tr id="cashtotalServiceTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total Service Tax(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashservTax2100">00</span></td>
								</tr>

								<tr id="cashtotalVatTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total Vat(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="cashvatTax2100px">00</span></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashgrossAmount2100">00</span></b></td>
								</tr>
								
								<tr id="cashshowDiscount2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										TOTAL DISCOUNT:</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashdiscountValue2100">00</span></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">AMOUNT TO PAY:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashamoutToPay2100">00</span></b></td>
								</tr>
								</table>
								
<div style="">-------------------------------------------------------------------------------------------------------</div>
								
								<table style="height: 50px; width: 100%;">
								
								<tr>
									<td id="paid_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount2100">00</span></b></td>
								</tr>
								
								<tr>
									<td id="tender_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Tender Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="tenderAmount2100">00</span></b></td>
								</tr>
								
								<tr>
									<td id="refund_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><b>
										<span id="refundAmount2100"><fmt:formatNumber  type="number" value="${invPurchaseOrderItem.oldStock}" maxFractionDigits="2" />00</span>
										</b></td>
								</tr>
								
								

							</table>
							
	<div style="">-------------------------------------------------------------------------------------------------------</div>
							
<div style="text-align: center;"><b><font style="font-size: 15px; font-family: sans-serif;"><span id="payType2100"></span></font></b></div>
<div style="text-align: center;"><font style="font-size: 16px; font-family: sans-serif;">Thank You. Visit us Again</font></div>
						</div>
						<div class="modal-footer" id="cashRemovePrint2100"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:printCashOrCardLocal2100()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="printBtn_80">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div>
					</div> --%>


<div class="modal-body" id="printDiv2100_GST"
					style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						
						<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> --%>
					 
						<div
							style="text-align: center;  width: auto; font-size: 20px; color: #000000">

							<b><font style="font-size: 19px; font-style: inherit; font-family: sans-serif;"><div id="storeName2100">${sessionScope.loggedinStore.storeName}</div></font></b>
							<b><font style="font-size: 17px; font-style: normal; font-family: sans-serif;"><div id="storeAddr2100">${sessionScope.loggedinStore.address}</div></font></b>
							
							<font style="font-size: 15px; text-align: center;  width: auto; font-style: inherit; font-family: sans-serif;"><div id="storeEmail2100"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
							<font style="font-size: 15px; text-align: center;  width: auto; font-style: normal; font-family: sans-serif;"><div id="storePhNo2100"></div></font><br>

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
										<b>${sessionScope.loggedinStore.gstText} :</b> <span id="ordervalue_2100px">${sessionScope.loggedinStore.gstRegNo}</span>
									</div><br><br>
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
										<b>GSTIN/Unique Id :</b><span id="showbillingCustomerVatRegNo_2100px"></span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="ordervalue_2100px_gst">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										 <%-- <fmt:parseDate value="${today}" var="parsedInvDate" pattern="yyyy-MM-dd" />  --%>
										<b>Date :</b> <span><fmt:formatDate pattern="yyyy-MM-dd" value="${today}" /></span> 
									</div>
								</div>
							</div>
		<!-- <div style="text-align: left;">-------------------------------------------------------------------------------------------------------</div> -->
									
					 <div class="table-responsive" id="orderitemContId_2100">
								<table style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"> <!-- color: #000000; border: none; height: 50px; width: 100%; -->
					
										<thead>
										
										<tr style="border-bottom: 1px dashed;">
									<th width="5%;"><spring:message code="reprintcash.jsp.invno" text="SNo" /></th>
									<th width="30%;"><spring:message code="item.jsp.name" text="Item Name" /></th>
									<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
									<th><spring:message code="purinvdet.jsp.batch" text="SAC"/></th>
									<th width="6%;"><spring:message code="purinvdet.jsp.expdt" text="Qty" /></th>
									<th width="6%;"><spring:message code="purinvdet.jsp.expdt" text="Unit" /></th>
									<th width="5%;"><spring:message code="purinvdet.jsp.pqty" text="Rate" /></th>
									<th width="5%;"><spring:message code="purinvdet.jsp.lqty" text="Total" /></th>
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Disc" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Taxable Value" /></th>
									<th width="18%;" colspan="2">&nbsp;<spring:message code="purinvdet.jsp.mrp" text="CGST" />&nbsp;</th>
									<th width="18%;" colspan="2">&nbsp;<spring:message code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;</th>
									<th width="18%;" colspan="2">&nbsp;<spring:message code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;</th>
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
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Amt." /></th>
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Amt." /></th>
									<th width="5%;"><spring:message code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs" text="Amt." /></th>
								</tr>
										<!-- <tr>
											<th style="font-size: 15px; width: 102px;"><span style="float: left;font-family: sans-serif;">Item</th>
											<th style="width:110px; float:right;padding-right:120px;text-align: center; font-size: 15px;font-family: sans-serif;">Qty</th>
											<th style="width:110px; padding-right:110px; text-align: center; font-size: 15px;font-family: sans-serif;">Rate</th>
											<th style="width:110px; text-align: center; font-size: 15px;font-family: sans-serif;">Amt</th>
										</tr> -->
										</thead>
															
										
										<tbody style="color: #000000; padding: 1px;" id="itemDetailsPrint2100"></tbody>
										
						</table>
							</div> 
						
							
 <!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

							<table style="height: 50px; width: 100%;">
								
								<tr>
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">TOTAL AMOUNT:</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashtotalamt2100">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										Service Charge:</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<span id="cashservChrg2100">00</span></td>
								</tr>

								<tr id="cashtotalServiceTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total CGST(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashservTax2100">00</span></td>
								</tr>

								<tr id="cashtotalVatTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total SGST(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><span
										id="cashvatTax2100px">00</span></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashgrossAmount2100">00</span></b></td>
								</tr>
								
								<tr id="cashshowDiscount2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										TOTAL DISCOUNT:</td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
										id="cashdiscountValue2100">00</span></td>
								</tr>
								
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">AMOUNT TO PAY:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashamoutToPay2100">00</span></b></td>
								</tr>
								</table>
								
<div style="">-------------------------------------------------------------------------------------------------------</div>
								
								<table style="height: 50px; width: 100%;">
								
								<tr>
									<td id="paid_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount2100">00</span></b></td>
								</tr>
								
								<tr>
									<td id="tender_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Tender Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="tenderAmount2100">00</span></b></td>
								</tr>
								
								<tr>
									<td id="refund_amt"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund Amount:</span></b></td>
									<td
										style="float:right;padding-right:40px; text-align: center;  font-size: 14px; font-family: sans-serif;"><b>
										<span id="refundAmount2100"><fmt:formatNumber  type="number" value="${invPurchaseOrderItem.oldStock}" maxFractionDigits="2" />00</span>
										</b></td>
								</tr>
								
								

							</table>
							
	<div style="">-------------------------------------------------------------------------------------------------------</div>
							
<div style="text-align: center;"><b><font style="font-size: 15px; font-family: sans-serif;"><span id="payType2100"></span></font></b></div>
<div style="text-align: center;"><font style="font-size: 16px; font-family: sans-serif;">****Thank You. Visit us Again****</font></div>
						</div>
						<div class="modal-footer" id="cashRemovePrint2100"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:printCashOrCardLocal2100()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="printBtn_80">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div>
					</div>
					
				</div>
			</div>
 
 
 
  <!-- ///////////////////////////////////////////////////////////////////////////////// ///////// -->
            <!--Modal for refunded order bill print start  -->


                 <!--Bill print modals start  -->
			<div class="modal fade" data-backdrop="static" id="refundhelloPrintModal58"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 200px; height: auto;">


					<div class="modal-body" id="refundprintDiv58"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<div
							style="text-align: center; height: auto; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">


							<%-- <div style="text-align: center; width: 230px;">
								<input type="image"	src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
							</div> --%>


							<b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							    <div id="refundstoreName58">${sessionScope.loggedinStore.storeName}</div></font></b> <b>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							   <div id="refundstoreAddr58">${sessionScope.loggedinStore.address}</div></font></b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							   <div id="refundstoreEmail58"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							    <div id="refundstorePhNo58"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>
								<div style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">
							    <spring:message code="admin.jsp.refundbill" text="REFUND BILL" />
						       </div> <br>

							<%-- <div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="refundstoreEmail58"></div>
							</div>
							<div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b> <div id="refundstorePhNo58"></div>
							</div> --%>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="refundorderValue58" style="font-weight:bold">00</span>
							</div>
                              <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Date :</b><span id="refundcashOrderdate58">00</span>
							</div>
                           <%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="refundorderType_58px">${orders.ordertype.orderTypeName}</span>
							</div> --%>

							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="refundshowtableno">
										 <b><span id="refundtableNoValue58">00</span></b>
							</div>

							<div class="table-responsive" id="refundorderitemContId_58">

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
										id="refunditemDetailsPrint58"></tbody>

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
										id=refundtotalAmt58>00</span></td>
								</tr>
								<tr id="refundtotalServiceChrg_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}(${orders.orderBill.serviceChargeRate}%):
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundservChrg58">00</span></td>
								</tr>

								<tr id="refundtotalServiceTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundservTax58">00</span></td>
								</tr>

								<tr id="refundtotalVatTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundvatTax58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundgrossAmount58">00</span></b></td>
								</tr>
								<tr id="refundshowDiscount_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refunddiscountValue58">00</span></td>
								</tr>
								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundamoutToPay58">00</span></b></td>
								</tr>
								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>



								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundpaidAmount58">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundtenderAmount58">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundrefundAmount58">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundorderrefundAmount58">00</span></b></td>
								</tr>


								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>
							</table>
							<div style="text-align: left; width: 150px;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><div
											id="refundpayType58"></div></font></b>
							</div>
							<div style="text-align: left; width: 150px;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.ThankYouVisitAgain"
										text="**Thank You. Visit Again" /></font>
							</div>
						</div>
					</div>
					<div class="modal-footer" id="refundremovePrint58"
						style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
						<button type="button"
							onclick="javascript:refundprintCashOrCardLocal58()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success" id="refundprintBtn_58">
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
				id="refundcashhelloPrintModal80" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">

					<div class="modal-body" id="refundprintDiv80"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> --%>

						<div
							style="text-align: center; width: 230px; font-size: 20px; color: #000000">

							<b><font style="font-size: 18px; font-style: inherit; font-family: sans-serif;">
							<div id="refundstoreName80">${sessionScope.loggedinStore.storeName}</div></font></b>
							<c:if test="${sessionScope.loggedinStore.id==126}">
								<b><font
									style="font-size: 10px; font-style: normal; font-family: sans-serif;">A
										UNIT OF SAPPHIRE CAFE LLP</font></b>
							</c:if>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="refundstoreAddr80">${sessionScope.loggedinStore.address}</div></font></b>
								<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
								<div id="refundstoreEmail80"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
								<div id="refundstoreWeb80"><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><spring:message code="order.jsp.Web" text="Website" /> :${sessionScope.loggedinStore.url}</font></div>
								<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="refundstorePhNo80"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>

							<%-- <div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="refundstoreEmail80"></div>
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="refundstorePhNo80"></div>
							</div> --%>

							<div id="refundpaidgstdata" style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">

							</div>
							<div style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">
							<spring:message code="admin.jsp.refundbill" text="REFUND BILL" />
						    </div> 
						<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="refundcashOrdervalue80" style="font-weight:bold">00</span>
							</div>


							<div
										style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" /> --%>
										<b>Date :</b> <span  id="refundcashOrderdate80">00<%-- <fmt:formatDate
												pattern="yyyy-MM-dd" value="${parsedInvDate}" /> --%></span>
									</div>

							<%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="refundorderType_80px">${orders.ordertype.orderTypeName}</span>
							</div> --%>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="refundshowtableno80px">
								<%-- <spring:message code="order.jsp.TableNo" text="Table No:" /> --%>
								<b><span id="refundcashtableNoValue80">00</span></b>
							</div>

							<div class="table-responsive" id="refundorderitemContId_80">
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
										id="refunditemDetailsPrint80"></tbody>

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
										id="refundcashtotalamt80">00</span></td>
								</tr>
								<tr id="refundcashshowDiscount80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> (<span id="refundpaidbilldiscpers"></span>%) :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundcashdiscountValue80">00</span></td>
								</tr>
								<tr id="refundcashtotalServiceCharge80px" class="refundserviceCharge80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										${sessionScope.loggedinStore.serviceChargeText}<span id="refundcashservChrgDisc80">00</span>:
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;">
										<span id="refundcashservChrg80">00</span>
									</td>
								</tr>

								<tr id="refundcashtotalServiceTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundcashservTax80">00</span></td>
								</tr>

								<tr id="refundcashtotalVatTax80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%)
										: :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundcashvatTax80px">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" /> :</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundcashgrossAmount80">00</span></b></td>
								</tr>

								

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundcashamoutToPay80">00</span></b></td>
								</tr>

								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundpaidAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundtenderAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundrefundAmount80">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundorderrefundAmount80">00</span></b></td>
								</tr>


								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>
                                 <tr id="refundcusnametr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Name:</td>
									<td id="refundcusname80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
								 <tr id="refundcusphnotr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Ph No:</td>
									<td id="refundcusphno80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                  <tr id="refundcusaddresstr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Address:</td>
									<td id="refundcusaddress80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                   <tr id="refundcuslocationtr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Location:</td>
									<td id="refundcuslocation80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                  <tr id="refundcusstreettr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Street:</td>
									<td id="refundcusstreet80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                   <tr id="refundcushousenotr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >House No:</td>
									<td id="refundcushouseno80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>

                                   <tr id="refunddeliveryboytr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Dlv By:</td>
									<td id="refunddeliveryboy80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>

							</table>
							<div style="text-align: center;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><span
										id="refundpayType80"></span></font></b>
							</div>
							<div style="text-align: center;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.**Thank You. Visit Again"
										text="**Thank You. Visit Again" />**</font>
							</div>
						</div>
						<div class="modal-footer" id="refundcashRemovePrint80"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button"
								onclick="javascript:refundprintCashOrCardLocal80()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="refundprintBtn_80">
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
  
  <div class="modal fade" data-backdrop="static"
				id="refundcashhelloPrintModal2100_GST" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="refundprintDiv2100GST"
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
								<b>Refund Invoice </b>
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
										<b>Name :</b><span id="refundcashCustName_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b> <span id="refundcashCustAddr_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Contact No:</b> <span id="refundcashCustPhone2100_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b><span id="refundcashCustState_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span id="refundcashCustGSTIN_GST"></span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="refundcashOrdervalue2100_GST">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Date :</b> <span id="refundcashOrderDate_GST"></span>
									</div>
								<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b><span id="refundcashtableNoValue2100">00</span></b>
							   </div>

								</div>
							</div>

							<div style="float: left; margin-bottom: 5%;"
								id="refundorderitemContId_2100_GST">
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
									<tbody id="refunditemDetailsPrint2100_GST">

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
											id="refundcashgrossAmount2100_gst">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In Words):</span></b></td>
									<td width="100%"
										style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
										id="refundcashgrossAmount2100_word_gst"></span></td>
								</tr>
								<tr id="refundcashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										Total ${sessionScope.loggedinStore.serviceChargeText}:(<span id="refundcashservChrgPercentage2100">00</span>%)</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="refundcashservChrg2100">00</span></b>
									</td>
								</tr>
								
								
								<tr id="refundcashtotalServiceTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;display:none;">
									    <span style="padding-left: 52%;" id="refundcashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%;" id="refundcashservTax2100_gst">00</span>
										<span style="padding-left: 5%"></span>
									</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="refundcashTotalTaxAmount2100_gst">00</span></b>
									</td>

								</tr>
								<!-- new added 10.5.2018 start -->
								 <tr style="display:none;">
	                             <td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundpaidAmount_paidbill_2100px">00</span></b></td>
								 </tr>


								 <tr style="display:none;">
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundamoutToPay_paidbill_2100px">00</span></b></td>
								 </tr>

                                 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund Amount:</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundrefundorderamount2100px">00</span></b></td>
								 </tr>
                                  <tr>
									<td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td>
									<td width="50%" style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
									   <b><span id="refundpaymentmode_paidbill_2100px"></span></b></td>
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








        <!--Modal for refunded order bill print end  -->
		</div>
	</div>

	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script src="${pageContext.request.contextPath}/assets/js/baseScriptNew.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/paidrefundbillprint.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>

	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";
		var storeID="${sessionScope.loggedinStore.id}";
		var storeAddr = "${sessionScope.loggedinStore.address}";
		var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
		var gsttext = "${sessionScope.loggedinStore.gstText}";
		var gstno = "${sessionScope.loggedinStore.gstRegNo}";

	</script>
	<script type="text/javascript">
		$(document).ready(function() {

			$('#daywiseorderdetails').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true
			});

		});
		function showPaidBillPrintSuccessModal() {
			$('#paidbillPrintSuccessModal').modal('show');
		}
	</script>
	
	<c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/baseScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/baseScript_EN.js"></script> 
    </c:otherwise>
    </c:choose>

</body>
</html>
