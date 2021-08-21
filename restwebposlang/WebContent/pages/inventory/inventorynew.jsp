<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>:. POS :: Inventory :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/datepicker.css"	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/languagebody.css" rel="stylesheet" /> 
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
	    .menu-category {
	    height: 100%;
	    overflow: auto;
	    /*background: #fff;*/
	    font-size: 16px;
	    color: #fff;
	}
    </style>
</head>
<body>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<div style="padding: 8px;">
							<div class="item" style="margin-bottom: 10px;"></div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/recipemgmt/loadrecipe.htm'">RECIPE MANAGEMENT</a>
							</div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="#"><spring:message code="inventorynew.jsp.SIMPLEPURCHASEORDER" text="SIMPLE PURCHASE ORDER" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockIn()"><spring:message code="inventorynew.jsp.SIMPLESTOCKIN" text="SIMPLE STOCK IN" /></a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/simplestock/display.htm'">SIMPLE
									STOCK DISPLAY</a>
							</div>
							<c:choose>
							<c:when test="${sessionScope.loggedinStore.validateRawStockOut=='N'}">
								<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()"><spring:message code="inventorynew.jsp.SIMPLESTOCKOUT" text="SIMPLE STOCK OUT" /></a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOutMan()"><spring:message code="inventorynew.jsp.SIMPLESTOCKOUTMAN" text="SIMPLE STOCK OUT MANUAL" /></a>
							</div>
							</c:otherwise>
							</c:choose>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewPurchaseReturnPage()"><spring:message code="inventorynew.jsp.SIMPLEPURCHASERETURN" text="SIMPLE PURCHASE RETURN" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewItemStockInsertPage()"><spring:message code="rmleftpanel.jsp.FGSimpleStockIn" text="FG STOCK IN"/></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
							  <a href="javascript:location.href='${pageContext.request.contextPath}/itemreturn/loaditemreturn.htm'">FG RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/stockinfo.htm'"><spring:message code="rmleftpanel.jsp.FGSimpleStockInDispaly" text="FG STOCK DISPLAY"/></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<input type="hidden" id="selectedpoid" value="0">
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								<spring:message code="inventorynew.jsp.PURCHASEORDER" text="PURCHASE ORDER" /> <a href="javascript:newPurchaseOrder()" class="btn btn-success" style="background: #78B626"><spring:message code="inventorynew.jsp.NewRequisition" text="New Requisition" /></a>
							</div>
						</div>
						<div class="col-md-7 col-sm-7">
							<div class="inv-requisition">
								<spring:message code="inventorynew.jsp.Date" text="Date" />&nbsp;&nbsp;<input type="text" size="8" id="invCrtDate" readonly value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"><spring:message code="inventorynew.jsp.CreatedBy" text="Created By" />&nbsp;&nbsp;<input type="text" id="invCrtBy" size="2" readonly value="${sessionScope.loggedinUser.contactNo}"><spring:message code="inventorynew.jsp.POId" text="PO Id" />&nbsp;&nbsp;<input type="text" size="2" id="invPOId" readonly value="0">
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-2">
							<div class="inv-requisition">
								<spring:message code="inventorynew.jsp.Date" text="Date" />&nbsp;&nbsp;<input type="text" name="selecteddate" id="poDate" size="6" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'> <a href="javascript:getPOByDate()" class="btn btn-success" style="background: #78B626"><spring:message code="inventorynew.jsp.GO" text="GO" /></a>
							</div>
						</div>

						<div class="col-md-3" id="vendorDiv">
							<div class="inv-requisition">
								<spring:message code="stockinnew.jsp.Vendor" text="Vendor" />:
								  <select id="selectedPovendorId" name="vendorId">
									 <c:forEach items="${vendorList}" var="vendor">
										<option value="${vendor.id}">${vendor.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="col-md-3 col-sm-6" style="align:left">
							<div class="inv-requisition">
								<spring:message code="inventorynew.jsp.Approved" text="Approved" />&nbsp;&nbsp; <select name="select1" id="select1" onchange="getApprovedBy(this.value)">
									<option value="N">N</option>
									<option value="Y">Y</option>
								</select> <spring:message code="inventorynew.jsp.By" text="By" />&nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" id="poapprovedbuttion" style="background: #78B626"><spring:message code="order.jsp.OK" text="OK" /></a>
							</div>
						</div>
						<div class="col-md-4 col-sm-6" style="align:left">
							<div class="inv-requisition">
								<spring:message code="inventorynew.jsp.PO" text="PO" />&nbsp;&nbsp; <select name="select2" id="select2" onchange="getPoBy(this.value)">
									<option value="N">N</option>
									<option value="Y">Y</option>
								</select> <spring:message code="inventorynew.jsp.By" text="By" />&nbsp;&nbsp;<input type="text" id="poId" size="4" readonly> <a href="javascript:poByCall()" class="btn btn-success" id="pocreatedbutton" style="background: #78B626"><spring:message code="inventorynew.jsp.CREATE" text="CREATE" /></a>
							</div>
						</div>
						<div class="col-md-5" id="serachDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewPoItem()" id="addnewpoitem" class="btn btn-success" style="background: #78B626"><spring:message code="inventorynew.jsp.ADD" text="ADD" /></a>
							</div>
						</div>

					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-4">
							<div style="overflow-y: auto;">
								<div class="panel panel-default">
									<div class="panel-body" style="max-height: 200px;">
										<div class="table-responsive" >
											<table class="table table-striped table-bordered" id="purchaseOrderListTbl">
												<thead>
													<tr style="background: #77C5EB;">
														<th><spring:message code="inventorynew.jsp.ID" text="ID" /></th>
				    								    <th><spring:message code="inventorynew.jsp.NAME" text="NAME" /></th>
														<th><spring:message code="inventorynew.jsp.POSTATUS" text="PO STATUS" /></th>
													</tr>
												</thead>
												<c:if test="${! empty purchaseOrderList}">
													<c:forEach items="${purchaseOrderList}" var="purchaseOrder" varStatus="odrStatus">
														<c:if test="${purchaseOrder.estimateDailyProdId=='0'}">
															<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${purchaseOrder.id})">
																<td>${purchaseOrder.id}</td>
																<td>${purchaseOrder.userId}</td>
																<td id="postatus_${purchaseOrder.id}">${purchaseOrder.poStatus}</td>
															</tr>
															<input type="hidden" value="${purchaseOrder.userId}" id="hdnuserId">
															<input type="hidden" value="${purchaseOrderList[0].id}" id="hdpoId">
														</c:if>
													</c:forEach>
												</c:if>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-8">
							<div style="background: #FFF; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 260px;">
										<div class="table-responsive" id="poItemTableDiv">
											<table class="table table-striped table-bordered table-hover" style="" id="poItemTable">
												<thead style="background: #999999;">
													<tr>
														<th><spring:message code="inventorynew.jsp.ID" text="ID" /></th>
														<th><spring:message code="inventorynew.jsp.ITEM" text="ITEM" /></th>
														<th nowrap="nowrap"><spring:message code="inventorynew.jsp.OLDSTOCK" text="OLD STOCK" /></th>
														<!-- 														<th nowrap="nowrap">REQ STOCK</th> -->
														<th><spring:message code="inventorynew.jsp.QUANTITY" text="QUANTITY" /></th>
														<th><spring:message code="inventorynew.jsp.UNIT" text="UNIT" /></th>
														<th><spring:message code="inventorynew.jsp.RATE" text="RATE" /></th>
													     <th style="display:none;"><spring:message code="inventorynew.jsp.SHIPPING" text="SHIPPING" /></th>
														 <th><spring:message code="stockinnew.jsp.TAX" text="TAX" />%</th>
														<th><spring:message code="inventorynew.jsp.TOTAL" text="TOTAL" /></th>
														<th style="display:none;"><spring:message code="inventorynew.jsp.VENDOR" text="VENDOR" /></th>
														<th><spring:message code="inventorynew.jsp.ACTION" text="ACTION" /></th>
													</tr>
												</thead>
												<tbody id="itemdetails"></tbody>
											</table>
										</div>
										<div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
									</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-8 col-sm-8">
							<spring:message code="inventorynew.jsp.MiscCharges" text="Misc Charges" />:<input type="text" size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal();" onkeydown="numcheck(event);" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp; <a href="javascript:poOrderPrint()" class="btn btn-success hide" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.PRINT" text="PRINT" /></a>
						    <spring:message code="inventorynew.jsp.totaltax" text="Total Tax" />:<input readonly type="text" size="5" id="totTaxAmt"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp;
						   <%--  <input  type="text" size="10" id="totRate"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> --%>
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-6">
							<font style="font-weight: bold;"><spring:message code="inventorynew.jsp.GRANDTOTAL" text="GRAND TOTAL" />:</font><input type="text" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
						    <span id="btnspan"></span>

							<%-- <a href="javascript:poOrderSave()" id="poOrderSave" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.Save" text="Save" /></a>
							<a href="javascript:poOrderUpdate()" id="poOrderUpdate" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.Update" text="Update" /></a> --%>

						    <a href="javascript:poOrderDeleteModalOpen()" id="poOrderDelete" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.Delete" text="Delete" /></a>


						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- CONTENT-WRAPPER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"> </script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/invNewScript.js"></script>

	  <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/invNewScript_AR.js"></script>
    </c:when>

    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/invNewScript_EN.js"></script>
    </c:otherwise>
    </c:choose>

	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
		// When the document is ready
 		$(document).ready(function() {


 			var poid=$("#hdpoId").val();
 			console.log("poid="+poid);
 			if(undefined!=poid){
 				rowClicked(poid);
 			}
 			else{
 				setActiveButton();//new
 			}
 			$('#poDate').datepicker({
 				format : "yyyy-mm-dd",
//  				startDate: '-0d',
 				endDate: '+0d',
 				autoclose : true
 			});

 		});


</script>
	<script type="text/javascript">
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
            }
         });
     });
 </script>
	<div class="modal fade" data-backdrop="static" id="alreadyexistitem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Itemalreadyexistspleaseselecanother" text="Item already exists, please select another" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="itemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Itemsuccessfullyupdated" text="Item successfully updated" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="poitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Areyousure" text="Are you sure?" /></div>
					<input type="hidden" id="hdnItemPoId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="inventorynew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deletePoItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingpoitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnitempoid" value=""> <input type="hidden" id="hdnpoid" value=""> <input type="hidden" id="hdnpoinvitemid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:deleteExistingPoItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="poapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				    <input type="hidden" id="approvedpoid" value="0">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.POsuccessfullyapproved" text="PO successfully approved" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal" onclick="javascript:poApprovedModalClose()"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="poCreated" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.POCreated" text="PO Created" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<input type="hidden" id="createdpoid" value="0">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.POCreated" text="PO Created" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal" onclick="javascript:poCreatedModalClose()"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.PleaseenteravalidItemQuantityOrItemRateOrShippingCharge" text="Please enter a valid Item Quantity Or Item Rate Or Shipping Charge" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter a positive Item Quantity Or Item Rate Or Shipping Charge.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
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
	<div class="modal fade" data-backdrop="static" id="savepurchaseorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.PleasesavethePurchaseOrderfirst" text="Please save the Purchase Order first" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="printSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Confirmation" text="Confirmation" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Success" text="Success" /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="displayStockInPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Warning" text="Warning" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Savetheunsaveditemsfirst" text="Save the unsaved items first" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:viewStockInPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning"><spring:message code="inventorynew.jsp.CANCEL" text="CANCEL" /></button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
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


</body>



</html>