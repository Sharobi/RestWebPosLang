<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.sharobi.webpos.util.CommonResource"%>
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
<title>:. POS :: Requisition :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<style type="text/css">
.selected {
	background-color: #D9EDF7 !important;
}
</style>
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
				<jsp:include page="/pages/rm/rmleftpanel.jsp"></jsp:include>
				<div class="col-md-10 col-sm-10">
					<input type="hidden" id="selectedpoid" value="0"> <input type="hidden" id="invCrtBy" value="${sessionScope.loggedinUser.contactNo}">
					<div class="col-md-12 col-sm-12" style="background-color: #999;">
						<div class="col-md-3 col-sm-3">
							<div class="inv-requisition-0" style="font-size: 18px;"><spring:message code="requisition.jsp.Requisition" text="Requisition"/></div>
							<input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
						</div>
						<!-- <div class="col-md-2 col-sm-2"></div> -->
						<div class="col-md-9 col-sm-9">
							<div class="inv-requisition-0">
								<spring:message code="requisition.jsp.DATE" text="DATE"/> <input type="text" id="" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"> &nbsp;&nbsp; <spring:message code="requisition.jsp.EDPID" text="EDPID"/><input type="text" id="clickededpid" disabled="disabled" size="5" value="0"> &nbsp;&nbsp;<spring:message code="requisition.jsp.POID" text="POID"/> <input type="text" id="clickedpoid" disabled="disabled" size="5" value="0">
							     <spring:message code="stockinnew.jsp.Vendor" text="Vendor" />:
								     <select id="selectedPovendorId" name="vendorId">
									      <c:forEach items="${vendorList}" var="vendor">
										      <option value="${vendor.id}">${vendor.name}</option>
									      </c:forEach>
								     </select>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-3">
							<div>
								<form modelAttribute="estimateDailyProd" action="${pageContext.request.contextPath }/requisition/getrequisitionbydateandstoreid.htm" method="post">
									<div class="col-md-12 col-sm-12">
										<div class="col-md-6 col-sm-6" style="padding: 3px; font-weight: bold;"><spring:message code="requisition.jsp.DATE" text="DATE"/> :</div>
										<div class="col-md-6 col-sm-6" style="padding: 3px; font-weight: bold;">
											<input type="text" id="selecteddate" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
										</div>
									</div>
									<div class="col-md-12 col-sm-12">
										<input type="submit" value="<spring:message code="requisition.jsp.getEdpReq" text="GET EDP REQUISITION"/>" class="btn btn-success" style="width: 100%;">
									</div>
								</form>
							</div>

							<div class="col-md-12 col-sm-12" style="margin-top: 5%">
								<div style="height: 320px; overflow-y: auto;">
									<table id="recipeingredientlist" class="table table-bordered" cellspacing="0" width="100%">
										<thead>
											<tr style="background-color: #77C5EB">
												<th><spring:message code="requisition.jsp.ID" text="ID"/></th>
												<th><spring:message code="requisition.jsp.EDP" text="EDP"/></th>
												<th><spring:message code="requisition.jsp.POSTATUS" text="PO STATUS"/></th>
											</tr>
										</thead>
										<tbody style="background-color: success">
											<c:if test="${!empty edpList}">
												<c:forEach items="${edpList}" var="edplist" varStatus="status">
													<c:if test="${edplist.approved =='Y'}">
														<c:if test="${edplist.requisitionPoStatus =='Y'}">
															<tr style="cursor: pointer;" class="selected-stockin-row success" onclick="rowClicked(${edplist.id},${edplist.poId},&quot;${edplist.requisitionPoStatus}&quot;)">
																<td>${edplist.poId}</td>
																<td>${edplist.id}</td>
																<td>${edplist.requisitionPoStatus}</td>
															</tr>
														</c:if>
														<c:if test="${edplist.requisitionPoStatus =='N'}">
															<tr style="cursor: pointer;" class="selected-stockin-row" onclick="rowClicked(${edplist.id},${edplist.poId},&quot;${edplist.requisitionPoStatus}&quot;)">
																<td>${edplist.poId}</td>
																<td>${edplist.id}</td>
																<td>${edplist.requisitionPoStatus}</td>
															</tr>
														</c:if>
													</c:if>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div class="col-md-1 col-sm-1"></div>
							<div class="col-md-6 col-sm-6">
								<input type="text" class="text-input" id="filter" placeholder="Item Search by Name..." value="" style="width: 90%; margin-top: 2%;" />
							</div>
							<div class="col-md-5 col-sm-5">
								<div class="inv-requisition">
									<spring:message code="requisition.jsp.Approved" text="Approved"/>&nbsp;&nbsp; <select name="select1" id="select1" onchange="getApprovedBy(this.value)">
										<option value="N">N</option>
										<option value="Y">Y</option>
									</select><spring:message code="requisition.jsp.By" text="By"/>&nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" id="poapprovedbuttion" style="background: #78B626"><spring:message code="requisition.jsp.APPROVE" text="APPROVE"/></a>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div style="height: 365px; overflow-y: auto; background-color: #fff;">
								<table class='table table-striped table-bordered' id="saverecipe" style='border: 1px solid #fff;'>
									<thead style="background-color: #999;">
										<th style='text-align: center;'><spring:message code="requisition.jsp.CODE" text="CODE"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.NAME" text="NAME"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.OLDSTK" text="OLD STK"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.REQQTY" text="REQQTY"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.QTYTOBUY" text="QTY TO BUY"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.UNIT" text="UNIT"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.STDRATE" text="STD RATE"/></th>
										<th style='text-align: center;display : none;'><spring:message code="requisition.jsp.SHIPPING" text="SHIPPING"/></th>
										<th style='text-align: center;'><spring:message code="stockinnew.jsp.TAX" text="TAX" />%</th> 
										<th style='text-align: center;'><spring:message code="requisition.jsp.TOTAL" text="TOTAL"/></th>
										<th style='text-align: center;display : none;'><spring:message code="requisition.jsp.VENDOR" text="VENDOR"/></th>
										<th style='text-align: center;'><spring:message code="requisition.jsp.ACTION" text="ACTION"/></th>
									<tbody style='padding: 1px;' id="itemdetails">
									</tbody>
								</table>
								<div style="background-color: black;" class="hide" id="waitimage" align="center">
									<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
								</div>
							</div>


							 <%-- <div class="col-md-10 col-sm-10" align="left">
							  <div>
							     <spring:message code="inventorynew.jsp.MiscCharges" text="Misc Charges" />:<input type="text" size="5" id="misChargeId" onkeyup="javascript:calculateGrandTotal()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp; 
								<spring:message code="requisition.jsp.GRANDTOTAL" text="GRAND TOTAL"/>:<input type="text" id="grandtotalId" name="totalId" size="8" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
							 </div>
							 <div>
								 <spring:message code="inventorynew.jsp.totaltax" text="Total Tax" />:<input type="text" id="totalTaxId" name="TotalTaxId" size="5" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
							</div>
						   </div>
							<!-- <div class="col-md-2 col-sm-2"></div> -->
							<div class="col-md-2 col-sm-2 ">
								<a href="javascript:poOrderPrint()" class="btn btn-success" id="printreq" disabled="disabled" style="background: #78B626; margin-top: 3px;"><spring:message code="requisition.jsp.PRINT" text="PRINT"/></a>
								<a href="javascript:requisitionSave()" id="poOrderSave" align="left" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="requisition.jsp.Save" text="Save"/></a>
							
							</div>  --%>
							
							
							<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-8 col-sm-8">
							<spring:message code="inventorynew.jsp.MiscCharges" text="Misc Charges" />:<input type="text" size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal()"  onkeydown="javascript:numcheck(event)" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp; <a href="javascript:poOrderPrint()" class="btn btn-success hide" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.PRINT" text="PRINT" /></a>
						    <spring:message code="inventorynew.jsp.totaltax" text="Total Tax" />:<input readonly type="text" size="5" id="totTaxAmt"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp; 						 
						   <%--  <input  type="text" size="10" id="totRate"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> --%>
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-8">
							<font style="font-weight: bold;"><spring:message code="inventorynew.jsp.GRANDTOTAL" text="GRAND TOTAL" />:</font><input type="text" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp; 
						    <span id="btnspan"></span>
						    <a href="javascript:poOrderPrint()" class="btn btn-success" id="printreq" disabled="disabled" style="background: #78B626; margin-top: 3px;"><spring:message code="requisition.jsp.PRINT" text="PRINT"/></a>
							<%-- <a href="javascript:requisitionSave()" id="poOrderSave" align="left" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="requisition.jsp.Save" text="Save"/></a>
							 --%><%-- <a href="javascript:poOrderDeleteModalOpen()" id="poOrderDelete" class="btn btn-success" style="background: #78B626; margin-top: 3px;" align="left"><spring:message code="inventorynew.jsp.Delete" text="Delete" /></a>
						  --%>
						
						</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 col-sm-12">
		<div  id="itemwiseperiodorderreportContainerId"></div>
	</div>
		</div>
		<div id="vendorsList" class="hidden">
			<select name="selectedvendorName" id="selectedvendorName" class="selectedvendor">
				<c:forEach items="${vendorList}" var="vendorList">
					<option value="${vendorList.id}">${vendorList.name}</option>
				</c:forEach>
			</select>
		</div>
		<div id="unitList" class="hidden">
			<select name="selectedunitName" id="selectedunitName" disabled="disabled" class="selectedunit">
				<c:forEach items="${metricUnitList}" var="metricunit">
					<option value="${metricunit.id}">${metricunit.unit}</option>
				</c:forEach>
			</select>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="itemdetailsmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
						<span id="itmname"></span>
					</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="height: 300px; overflow-y: auto;">
						<table class='table  table-bordered' id="geting" style='border: 1px solid #fff;'>
							<thead style="background-color: #999;">
								<th style='text-align: center;'><spring:message code="requisition.jsp.NAME" text="NAME"/></th>
								<th style='text-align: center;'><spring:message code="requisition.jsp.AMT" text="AMT"/></th>
								<th style='text-align: center;'><spring:message code="requisition.jsp.UNIT" text="UNIT"/></th>
								<th style='text-align: center;'><spring:message code="requisition.jsp.TOTALAMT" text="TOTAL AMT"/></th>
							<tbody style='padding: 1px;' id="ingdetails">
							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingedpitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.Areyousure" text="Are you sure"/>?</div>
					<input type="hidden" id="hdningid" value=""> <input type="hidden" id="hdnedpid" value=""> <input type="hidden" id="hdnid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="requisition.jsp.Cancel" text="Cancel"/></button>
					<button type="button" onclick="javascript:deleteExistingEDPItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpdeletesuccessdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.Itemsuccessfullydeleted" text="Item successfully deleted"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingpoitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.Areyousure" text="Are you sure"/>?</div>
					<input type="hidden" id="hdnitempoid" value=""> <input type="hidden" id="hdnpoid" value=""> <input type="hidden" id="hdnpoinvitemid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="requisition.jsp.Cancel" text="Cancel"/></button>
					<button type="button" onclick="javascript:deleteExistingPoItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="savepurchaseorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.PleasesavetheRequisitionfirst" text="Please save the Requisition first"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.Itemsuccessfullyupdated" text="Item successfully updated"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="poapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.Requisitionsuccessfullyapproved" text="Requisition successfully approved"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:requisitionapprovesuccess()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.PleaseenterapositiveItemQuantityOrShippingCharge" text="Please enter a positive Item Quantity Or Shipping Charge"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="requisition.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="requisition.jsp.PleaseenteravalidItemQuantityOrShippingCharge" text="Please enter a valid Item Quantity Or Shipping Charge"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="requisition.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- new modal -->
	
	<div class="modal fade" data-backdrop="static" id="existingrequisitiondeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Areyousure" text="Are you sure" />?</div>					
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:poOrderDelete();" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="itemquantityzero" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Itemquantitycantbezeroorblank" text="Item Quantity can not be zero or blank" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"> </script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/rm/requisitionScript.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	
	var munitlists="${metricUnit}";
		$(document).ready(function() {
			$('#selecteddate').datepicker({
 				format : "yyyy-mm-dd",
//  				startDate: '-0d',
 				endDate: '+0d',
 				autoclose : true
 			});
			 $("#filter").keyup(function(){
				 
			        // Retrieve the input field text and reset the count to zero
			        var filter = $(this).val().toLowerCase(), count = 0;
			        // Loop through the comment list
			        $("#saverecipe tbody tr").each(function(index){
			            // If the list item does not contain the text phrase fade it out
            $row = $(this);
            var id = $row.find("td").eq(1).text().toLowerCase();;
            if (id.indexOf(filter) != 0) {
            	$row.hide();
            }
            else {
            	$row.show();
            }
			        });
			 
			    });
			 setActiveButton();//new
		});
		$(function() {
	         $("#search").autocomplete({
	             source: function(request, response) {
	                 $.ajax({
	                     url: "${pageContext.request.contextPath}/inventorynew/inventoryitems.htm",
	                     type: "GET",
	                     data: { tagName: request.term },
	                     dataType: "json",
	                     success: function(data) {
	                      response($.map(data, function(v){
	                           return  {
	                                      label: v.name,
	                                      value: v.name,
	                                      itemCode:v.code,
	                                      itemId: v.id,
	                                     };  
	                      }));
	                     },
	                     error: function (error) {
	                         console.log('error: ' + error);
	                      }
	                });              
	             },
	               select: function(e,ui) {
	               $("#searchCode").val(ui.item.itemCode);
	               $("#searchitemid").val(ui.item.itemId);
	            }
	         });
	     });
		$('.selected-stockin-row').on('click',function(){
	 		   $(this).parent().find('.selected-stockin-row').removeClass('selected');
	 		  $(this).addClass('selected');
	 		  });
	</script>
</body>
</html>