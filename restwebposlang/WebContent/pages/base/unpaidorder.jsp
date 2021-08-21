<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>:. POS :: Unpaid Order :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<style type="text/css">
.selected {
	background-color: #373737 !important;
}
</style>
<script>
	function rowClicked(){
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
<body onload="javascript:noUnpaidOrders(${allunpaidOrderList.size()})">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">

			<div class="row">
				<div class="col-md-4 col-sm-4">
					<div style="background: #404040; overflow-y: auto; padding: 2px;">
						<div class="panel panel-default" style="background: #404040;">
							<div class="panel-body" style="max-height: 400px;">
								<div style="padding: 3px;">
									<div class="table-responsive">
										<table class="table table-striped table-bordered" id="ordertableId" style="color: #FFF; border: 1px solid #222222;">
											<thead>
												<th style="text-align: center;"><spring:message code="unpaidorder.jsp.SLNO" text="SL NO" /></th>
												<th><spring:message code="unpaidorder.jsp.ORDERNO" text="ORDER NO" /></th>
												<th><spring:message code="unpaidorder.jsp.TABLENO" text="TABLE NO" /></th>
												<th><spring:message code="unpaidorder.jsp.ORDERTIME" text="ORDER TIME" /></th>
												<c:if test="${sessionScope.loggedinStore.parcelAddress=='Y'}">
													<th><spring:message code="unpaidorder.jsp.DELDETAILS" text="DEL. DETAILS" /></th>
												</c:if>
											</thead>
											<tbody style="color: #fff;">
												<c:if test="${! empty allunpaidOrderList}">
													<c:forEach items="${allunpaidOrderList}" var="unpaidOrders" varStatus="stat">
														<tr style="background: #222222; cursor: pointer;" id="tr_${unpaidOrders.id}" class="unpaid-order-row">
															<td id="td_id" style="text-align: center;" onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">${stat.index+1}</td>
															<td id="td_id" onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">${unpaidOrders.orderNo}</td>
															<td valign="middle" align="center" onclick="javascript:getunpaidOrderById(${unpaidOrders.id})"><c:choose>
																	<c:when test="${unpaidOrders.ordertype.id==5}">
																		<spring:message code="unpaidorder.jsp.SWIGGY" text="SWIGGY" />
																	</c:when>
																	<c:when test="${unpaidOrders.ordertype.id==6}">
																		<spring:message code="unpaidorder.jsp.ZOMATO" text="ZOMATO" />
																	</c:when>
																	<c:when test="${unpaidOrders.ordertype.id==2}">
																		<spring:message code="unpaidorder.jsp.PARCEL" text="PARCEL" />
																	</c:when>
																	<c:when test="${unpaidOrders.ordertype.id==1}">
																		<spring:message code="unpaidorder.jsp.HOMEDELIVERY" text="HOME DELIVERY" />
																	</c:when>
																	<c:otherwise>
                                				${unpaidOrders.table_no}
                                			</c:otherwise>
																</c:choose></td>
															<c:set var="ordtime" value="${fn:substring(unpaidOrders.orderTime, 11, 19)}" />
															<td onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">${ordtime}</td>
															<c:if test="${sessionScope.loggedinStore.parcelAddress=='Y'}">
																<td align="center">
																 <c:choose> 
																		<c:when test="${unpaidOrders.ordertype.orderTypeName!='Dine In' }">
																			<a href="javascript:showdeliveryDetailModal('${unpaidOrders.customerName}','${unpaidOrders.customerContact}','${unpaidOrders.deliveryAddress}','${unpaidOrders.deliveryPersonName}')"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a>
																		</c:when>
																		<%-- </c:when>
																		<c:when test="${unpaidOrders.ordertype.id==6}">
																			<a href="javascript:showdeliveryDetailModal('${unpaidOrders.customerName}','${unpaidOrders.customerContact}','${unpaidOrders.deliveryAddress}','${unpaidOrders.deliveryPersonName}')"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a>
																		</c:when>
																		<c:when test="${unpaidOrders.ordertype.id==2}">
																			<a href="javascript:showdeliveryDetailModal('${unpaidOrders.customerName}','${unpaidOrders.customerContact}','${unpaidOrders.deliveryAddress}','${unpaidOrders.deliveryPersonName}')"><input type="image"  src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a>
																			<spring:message code="unpaidorder.jsp.N/A" text="N/A" />
																		</c:when>
																		<c:when test="${unpaidOrders.ordertype.id==1}">
																			<a href="javascript:showdeliveryDetailModal('${unpaidOrders.customerName}','${unpaidOrders.customerContact}','${unpaidOrders.deliveryAddress}','${unpaidOrders.deliveryPersonName}')"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a>
																		</c:when> --%>
																		<c:otherwise>
																			<spring:message code="unpaidorder.jsp.N/A" text="N/A" />
																		</c:otherwise> 
																	</c:choose>
																	</td>
															</c:if>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${empty allunpaidOrderList}">
													<tr style="background: #222222;">
														<td colspan="5"><spring:message code="unpaidorder.jsp.NoDataFound" text="No Data Found" />!</td>
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

				<div class="col-md-8 col-sm-8">
					<div style="background: #404040;">
						<div class="col-md-12 col-sm-12">
							<c:if test="${! empty allunpaidOrderList}">
								<c:forEach items="${allunpaidOrderList}" var="unpaidorder" end="0">
									<div class="col-md-6 col-sm-6" style="color: #FFF; font-weight: bold;">
										<spring:message code="unpaidorder.jsp.ORDERNO" text="ORDER NO" />
										&nbsp;<font color="#00CC33;"><span id="unpaidordernocontId" style="display:none;">${unpaidorder.id}</span><span id="unpaidStoreBaseordernocontId">${unpaidorder.orderNo}</span></font> &nbsp;
										<spring:message code="unpaidorder.jsp.TABLENO" text="TABLE NO" />
										&nbsp;<font color="#00CC33;"><span id="unpaidordertablenocontId">${unpaidorder.table_no}</span></font>
									</div>
									<div class="col-md-6 col-sm-6" style="color: #FFF; font-weight: bold;">
										<a href="javascript:showCancelOrderModal()" class="btn-unpaid-order" style="background: #D9534F; width: auto; margin-bottom: 3px; padding: 6px;"><spring:message code="unpaidorder.jsp.cnclOrder" text="Cancel Order" /></a>
										<spring:message code="unpaidorder.jsp.Reason" text="Reason" /><input type="text" style="color:black;" id="changenoteContId" value=""/>
										<%-- <select id="changenoteContId" style="color: #000; width: 75px;">
											<option value="Misc"><spring:message code="unpaidorder.jsp.Misc" text="Misc" /></option>
											<option value="BadFood"><spring:message code="unpaidorder.jsp.BadFood" text="BadFood" /></option>
										</select> --%>
									</div>
								</c:forEach>
							</c:if>

						</div>
						<div class="col-md-12 col-sm-12">
							<div style="background: #404040; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default" style="background: #404040;">
									<div class="panel-body" style="max-height: 400px;">
										<div class="table-responsive" id="unpaidordertableContId">
											<table class="table table-striped table-bordered" style="color: #FFF; border: 1px solid #222222;">
												<thead>
													<th><spring:message code="unpaidorder.jsp.SL" text="SL" /></th>
													<th><spring:message code="unpaidorder.jsp.NAME" text="NAME" /></th>
													<th><spring:message code="unpaidorder.jsp.ORDERTYPE" text="ORDER TYPE" /></th>
													<th style="text-align: center;"><spring:message code="unpaidorder.jsp.QUANTITY" text="QUANTITY" /></th>
													<th style="text-align: center;"><spring:message code="unpaidorder.jsp.TOTAL" text="TOTAL" /></th>
													<th style="text-align: center;"><spring:message code="unpaidorder.jsp.DISCNT" text="DISCNT" /></th>
													<th style="text-align: center;"><spring:message code="unpaidorder.jsp.RATE" text="RATE" /></th>
													<th style="text-align: center;"><spring:message code="unpaidorder.jsp.REASON" text="REASON" /></th>
													<th></th>
												</thead>
												<tbody style="color: #fff;">
													<c:if test="${! empty allunpaidOrderList}">
														<c:forEach items="${allunpaidOrderList}" var="unpaidOrder" end="0">
															<c:forEach items="${unpaidOrder.orderitem}" var="orderitems" varStatus="stat">
																<tr style="background: #222222">
																	<td>${stat.index+1}</td>
																	<td>${orderitems.item.name}</td>
																	<td><c:choose>
																			<c:when test="${orderitems.ordertype==2}">
																				<spring:message code="unpaidorder.jsp.PARCEL" text="PARCEL" />
																			</c:when>
																			<c:when test="${orderitems.ordertype==1}">
																				<spring:message code="unpaidorder.jsp.HOMEDEL" text="HOME DEL" />
																			</c:when>
																			<c:otherwise>
																				<spring:message code="unpaidorder.jsp.DINEIN" text="DINE IN" />
																			</c:otherwise>
																		</c:choose></td>
																	<td valign="middle" align="center" style="padding: 1px;"><a href="javascript:decreaseItemQuantity(${orderitems.id},${orderitems.item.price},'${orderitems.item.promotionFlag}',${orderitems.item.promotionValue})"> <img border="0" height="24" width="24" alt="" src="${pageContext.request.contextPath}/assets/images/base/d/d_delete.png">
																	</a> <input type="text" size="1" id="inputqty${orderitems.id}" onkeyup="javascript:enterManualQuantity(this.value,${orderitems.id},${orderitems.item.price},'${orderitems.item.promotionFlag}',${orderitems.item.promotionValue})" value="${orderitems.quantityOfItem}" style="text-align: center; color: #fff; background-color: #333; width: 28px;"> <a href="javascript:increaseItemQuantity(${orderitems.id},${orderitems.item.price},'${orderitems.item.promotionFlag}',${orderitems.item.promotionValue})"> <img border="0" height="24" width="24" alt="" src="${pageContext.request.contextPath}/assets/images/base/d/d_add.png">
																	</a></td>
																	<td style="text-align: center;" id="tdtotal${orderitems.id}"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.item.price*orderitems.quantityOfItem}"></fmt:formatNumber></td>
																	<td style="text-align: center;" id="tddisc${orderitems.id}"><c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
																			<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${(orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
																		</c:if> <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">0.00</c:if></td>
																	<td style="text-align: center;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.item.price}"></fmt:formatNumber></td>
																	<td><input type="text" style="color:black;" id="itemcancelreason${orderitems.id}" value=""/> <input type='hidden' id='itemorderedqty${orderitems.id}' value="${orderitems.quantityOfItem}"/></td>
																	<td style="text-align: center;"><a href="#" onclick="javascript:updateUnpaidOrder(${orderitems.id},${orderitems.item.id},${unpaidOrder.id},document.getElementById('itemcancelreason${orderitems.id}').value,document.getElementById('itemorderedqty${orderitems.id}').value)" id="updatebut${orderitems.id}" class="btn-unpaid-order"><spring:message code="unpaidorder.jsp.UPDATE" text="UPDATE" /></a></td>
																</tr>
															</c:forEach>
														</c:forEach>
													</c:if>
													<c:if test="${empty allunpaidOrderList}">
														<tr style="background: #222222;">
															<td colspan="8"><spring:message code="unpaidorder.jsp.NoDataFound" text="NoDataFound" />!</td>
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
			</div>
			<!-- modal starts -->

			<div class="modal fade" data-backdrop="static" id="nounpaidOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Alert" text="Alert!" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="unpaidorder.jsp.Thereisnounpaidorders" text="There is no unpaid orders" />
								!!
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/table/viewtable.htm'" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="confirmcancelOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Confirmation" text="Confirmation" />
								!
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="unpaidorder.jsp.Areyousure" text="Are you sure?" />
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal">
								<spring:message code="unpaidorder.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F; font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="alerteditunpaidOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Alert" text="Alert" />
								!
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="unpaidorder.jsp.Pleaseenteravalidnumber" text="Please enter a valid number" />
								!
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static" id="itemQtyChangeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Alert" text="Alert" />
								!
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Please enter a valid reason!!
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static" id="successModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Alert" text="Alert" />
								!
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Item successfully updated.
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static" id="successCancelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Alert" text="Alert" />
								!
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Order successfully cancelled.
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/unpaidorder/viewunpaidorder.htm'">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static" id="failureModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.Alert" text="Alert" />
								!
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Item not updated please try again.
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="deliveryDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="unpaidorder.jsp.prsclDivDet" text="Parcel Delivery Details" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<table>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="unpaidorder.jsp.CUSTOMERNAME" text="CUSTOMER NAME" /></td>
										<td width="5%">:</td>
										<td id="moddeliverydetailcustnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="unpaidorder.jsp.PHONENO" text="PHONE NO" /></td>
										<td width="5%">:</td>
										<td id="moddeliverydetailphonenoTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="unpaidorder.jsp.CUSTOMERADDRESS" text="CUSTOMER ADDRESS" /></td>
										<td width="5%">:</td>
										<td id="moddeliverydetailcustaddressTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="unpaidorder.jsp.DELIVERYPERSON" text="DELIVERY PERSON" /></td>
										<td width="5%">:</td>
										<td id="moddeliverydetaildeliverymanTd"></td>
									</tr>
								</table>
								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="addalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success" data-dismiss="modal">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			<!-- modal ends -->

		</div>
	</div>

	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script src="${pageContext.request.contextPath}/assets/js/unpaidorderScript.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>

	<script type="text/javascript">
	var printReason="${sessionScope.loggedinStore.isProvideReason}";
    var BASE_URL="${pageContext.request.contextPath}";
  $('.unpaid-order-row').on('click',function(){
	  $(this).parent().find('.unpaid-order-row').removeClass('selected');
		$(this).addClass('selected');
  });
  /* $('#ordertableId tbody tr').on('click',function(e){
	  $(this).closest('table').find('td').removeClass('selected');
		$(this).find('td').addClass('selected');
		//e.stopPropagation();
  }); */
  </script>
	<script type="text/javascript">
  function shownounpaidOrderModal()
	{
		$('#nounpaidOrderModal').modal('show');
	}
  function showCancelOrderModal()
  	{
	  	$('#confirmcancelOrderModal').modal('show');
  	}
  function showalerteditUnpaidOrderModal()
	{
	  	$('#alerteditunpaidOrderModal').modal('show');
	}
  function showdeliveryDetailModal(custname,phoneno,custaddress,deliveryman)
  {
	  document.getElementById('moddeliverydetailcustnameTd').innerHTML=custname;
	  document.getElementById('moddeliverydetailphonenoTd').innerHTML=phoneno;
	  document.getElementById('moddeliverydetailcustaddressTd').innerHTML=custaddress;
	  document.getElementById('moddeliverydetaildeliverymanTd').innerHTML=deliveryman;
	  $('#deliveryDetailModal').modal('show');
  }
  </script>

	<c:choose>
		<c:when test="${pageContext.response.locale == 'ar'}">
			<script src="${pageContext.request.contextPath}/assets/js/lang/unpaidorderScript_AR.js"></script>
		</c:when>

		<c:otherwise>
			<script src="${pageContext.request.contextPath}/assets/js/lang/unpaidorderScript_EN.js"></script>
		</c:otherwise>
	</c:choose>

</body>
</html>
