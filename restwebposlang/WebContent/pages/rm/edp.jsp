<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.sharobi.webpos.util.CommonResource"%>
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
<title>:. POS :: EDP :.</title>
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
.datepicker{z-index:1151 !important;}
</style>
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<%-- <c:set var="today" value="<%=new java.util.Date()%>" /> --%>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/rm/rmleftpanel.jsp"></jsp:include>
				<div class="col-md-10 col-sm-10">
					<div class="col-md-12 col-sm-12" style="background-color: #999;">
						<div class="col-md-3 col-sm-3">
							<div class="inv-requisition-0" style="font-size: 18px;"><spring:message code="rm.edp.jsp.estDlyPrdctn" text="Estimate Daily Production" /></div>
							<input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}"> <input type="hidden" id="hidedpCrtBy" value="${sessionScope.loggedinUser.contactNo}"> <input type="hidden" id="hidedpid" value="0">
						</div>
						<div class="col-md-9 col-sm-9">
							<div align="right" class="inv-requisition-0">
								<spring:message code="rm.edp.jsp.date" text="DATE" /> <input type="text" id="edpcreationDate" disabled="disabled" size="7" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"> &nbsp;&nbsp; <spring:message code="rm.edp.jsp.edpId" text="EDP ID" /> <input type="text" id="edpId" disabled="disabled" size="5" value="0">
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-3">
							<div class="col-md-12 col-sm-12">
								<form:form modelAttribute="estimateDailyProd" action="${pageContext.request.contextPath }/edp/getedpbydateandstoreid.htm" method="post">
									<div class="col-md-3 col-sm-3" style="padding: 3px; font-weight: bold;"><spring:message code="rm.edp.jsp.date" text="DATE" /></div>
									<div align="right" class="col-md-6 col-sm-6" style="padding: 3px; font-weight: bold;">
										<input type="text" id="edpDate" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
									</div>
									<div class="col-md-3 col-sm-3" style="padding: 3px;">
										<input type="submit" value="<spring:message code="rm.edp.jsp.go" text="GO" />" class="btn btn-success" style="background: #78B626; padding: 5px 20px;">
									</div>
								</form:form>

							</div>
							<div class="col-md-12 col-sm-12">
								<div class="col-md-6 col-sm-6" style="padding-bottom: 3px;">
									<a href="javascript:createNewEdp()" id="" class="btn btn-success" style="background: #78B626; padding: 5px 20px;"><spring:message code="rm.edp.jsp.newEdp" text="NEW EDP" /></a>
								</div>
								<div align="right" class="col-md-6 col-sm-6">
									<a href="javascript:opennewfromoldEdpModal()" id="" class="btn btn-success" style="background: #78B626; padding: 5px 20px;"><spring:message code="rm.edp.jsp.oldEdp" text="OLD EDP" /></a>
								</div>
							</div>
							<div class="col-md-12 col-sm-12">
								<div style="height: 320px; overflow-y: auto;">
									<table id="recipeingredientlist" class="table table-bordered" cellspacing="0" width="100%">
										<thead>
											<tr class="info">
												<th><spring:message code="rm.edp.jsp.id" text="Id" /></th>
												<th><spring:message code="rm.edp.jsp.type" text="Type" /></th>
												<th><spring:message code="rm.edp.jsp.approved" text="Approved" /></th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${!empty edpList}">
												<c:forEach items="${edpList}" var="edplist" varStatus="status">
													<c:choose>
														<c:when test="${edplist.approved =='Y'}">
															<tr class="selected-edp-row" style="cursor: pointer; background-color: #F7FBC5;" onclick="rowClicked(${edplist.id},&quot;${edplist.approved}&quot;,${edplist.estimateType.id})">
																<td>${edplist.id}</td>
																<td>${edplist.estimateType.name}</td>
																<td>${edplist.approved}</td>
															</tr>
														</c:when>
														<c:otherwise>
															<tr class="selected-edp-row" style="cursor: pointer;" onclick="rowClicked(${edplist.id},&quot;${edplist.approved}&quot;,${edplist.estimateType.id})">
																<td>${edplist.id}</td>
																<td>${edplist.estimateType.name}</td>
																<td>${edplist.approved}</td>
															</tr>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-md-12 col-sm-12"></div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div class="col-md-12 col-sm-12" style="padding: 3px; font-weight: bold;">
								<spring:message code="rm.edp.jsp.edpType" text="EDP TYPE" /> <select id="edpTypeId" disabled="disabled" onchange="javascript:changeEDpType(this.value)">
									<option value="0"><spring:message code="rm.edp.jsp.select" text="SELECT" /></option>
									<option value="1"><spring:message code="rm.edp.jsp.daily" text="DAILY" /></option>
									<option value="2"><spring:message code="rm.edp.jsp.extra" text="EXTRA" /></option>
									<option value="3"><spring:message code="rm.edp.jsp.misc" text="MISCELLANEOUS" /></option>
									<option value="4"><spring:message code="rm.edp.jsp.festival" text="FESTIVAL" /></option>
									<option value="5"><spring:message code="rm.edp.jsp.leftOvrFd" text="LEFT OVER FOOD" /></option>
								</select> <spring:message code="rm.edp.jsp.approved" text="APPROVED" /> <select id="edpisApproved" disabled="disabled" onchange="getApprovedBy(this.value)">
									<option value="N">N</option>
									<option value="Y">Y</option>
								</select> <spring:message code="rm.edp.jsp.by" text="BY" /> <input type="text" id="edpApprovedBy" disabled="disabled" size="5" value=""> <a href="javascript:calledpApprove()" class="btn btn-success disabled" id="edpapprovedbuttion" style="background: #78B626"><spring:message code="rm.edp.jsp.approve" text="APPROVE" /></a>

							</div>
							<div class="col-md-12 col-sm-12" style="padding: 3px; font-weight: bold;">
								<div class="col-md-6 col-sm-6 hide" id="categorydivId">
									<spring:message code="rm.edp.jsp.category" text="Category :" /> <select name="selectedmenucategoryName" id="selectedmenucategoryName" class="selectedmenucategory" onchange="getSelectedCat()">
										<option value="Select All"><spring:message code="rm.edp.jsp.selectAll" text="Select All" /></option>
										<c:forEach items="${menucategoryList}" var="menucategory">
											<c:if test="${menucategory.menuCategoryName !='SPECIAL NOTE'}">
												<option value="${menucategory.menuCategoryName}">${menucategory.menuCategoryName}</option>
											</c:if>
										</c:forEach>
									</select> <input type="hidden" class="text-input" id="filterbycat" value="" />
								</div>
								<div class="col-md-6 col-sm-6 hide" id="itemsearchdivId">
									<input type="text" id="edpitemSearch" placeholder="<spring:message code="rm.edp.jsp.itmSrhByNm" text="Item Search by Name..." />">
								</div>
							</div>
						</div>
						<!-- <div class="col-md-4 col-sm-4">
						<table id="recipeingredientlist" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr class="info">
								<th>Id</th>
								<th>Type</th>
								<th>Approved</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					</div> -->

						<!-- <div class="col-md-8 col-sm-8">
						<div class="inv-requisition-0">
							<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewItem()" id="addnewpoitem" class="btn btn-success" style="background: #78B626;padding: 3px 15px;">ADD</a>
							<input type="hidden"  id="searchitemid"  value="">
						</div>
					</div>
					<div class="col-md-8 col-sm-8">
						<div class="col-md-4 col-sm-4" style="border: 1px solid #999;font-size: 14px;font-weight: bold;padding: 6px;">Cooking Cost</div>
						<div class="col-md-4 col-sm-4" style="border: 1px solid #999;font-size: 14px;font-weight: bold;padding: 6px;">Other Cost</div>
						<div class="col-md-4 col-sm-4" style="border: 1px solid #999;font-size: 14px;font-weight: bold;padding: 6px;">Total Cost</div>
					</div>-->
						<div class="col-md-9 col-sm-9">
							<div style="height: 365px; overflow-y: auto; background-color: #fff;">
								<table class='table  table-bordered' id="saverecipe" style='border: 1px solid #fff;'>
									<thead style="background-color: #999;">
										<th id="edpchkthid" class="hide" style='text-align: center;'></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.id" text="ID" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.cat" text="CATEGORY" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.subCat" text="SUB CATEGORY" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.fdItem" text="FOOD ITEM" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.oldStk" text="OLD STK" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.minQty" text="MIN QTY" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.edProd" text="ED PROD" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.unit" text="UNIT" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.rqrQty" text="RQR QTY" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.ing" text="ING" /></th>
										<th style='text-align: center;'><spring:message code="rm.edp.jsp.action" text="ACTION" /></th>
									<tbody style='padding: 1px;' id="itemdetails">
									</tbody>
								</table>
								<div style="background-color: black;" class="hide" id="waitimage" align="center" >
											<img alt=""  src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
								</div>
							</div>
							<div align="center" style="padding: 2px 0px 0px 0px;">
								<a href="javascript:printEDP()" id="printEdpBut" class="btn btn-success disabled" style="background: #78B626; padding: 6px 15px;"><spring:message code="rm.edp.jsp.print" text="PRINT" /></a> &nbsp;&nbsp; 
								<a href="javascript:deleteEDP()" id="deleteEdpBut" class="btn btn-success disabled" style="background: #78B626; padding: 6px 15px;"><spring:message code="rm.edp.jsp.delete" text="DELETE" /></a> &nbsp;&nbsp; 
								<a href="javascript:saveEDP()" id="saveEdpBut" class="btn btn-success disabled" style="background: #78B626; padding: 6px 15px;"><spring:message code="rm.edp.jsp.save" text="SAVE" /></a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 col-sm-12">
		<div></div>
	</div>
		</div>
		<div id="metricUnitListt" class="hidden">
			<select name="metricUnitName" id="metricUnitName" class="selectedmetricUnit">
				<c:forEach items="${metricUnit}" var="metricUnit">
					<option value="${metricUnit.id}">${metricUnit.unit}</option>
				</c:forEach>
			</select>
		</div>
		<div id="coockingUnitList" class="hidden">
			<select name="cookingUnitName" id="cookingUnitName" class="selectedcookingUnit">
				<c:forEach items="${cookingUnit}" var="cookingUnit">
					<option value="${cookingUnit.id}">${cookingUnit.unit}</option>
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
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.name" text="NAME" /></th>
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.amt" text="AMT" /></th>
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.unit" text="UNIT" /></th>
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.totalAmt" text="TOTAL AMT" /></th>
							<tbody style='padding: 1px;' id="ingdetails">
							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingedpitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.areYouSure" text="Are you sure?" /></div>
					<input type="hidden" id="hdningid" value=""> <input type="hidden" id="hdnedpid" value=""> <input type="hidden" id="hdnid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="rm.edp.jsp.cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deleteExistingEDPItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpdeletesuccessdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.itemSucDelet" text="Item successfully deleted." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="alreadyexistitem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.cont_one" text="Item already exists, please select another." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.areYouSure" text="Are you sure?" /></div>
					<input type="hidden" id="hdnid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="rm.edp.jsp.cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deleteEDPItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpsuccessdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="edpcreatesuccesscontId"><spring:message code="rm.edp.jsp.cont_two" text="EDP successfully saved." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:redirectEDP()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="edpsuccessdmodal_ok" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="edpcreatesuccesscont_alert"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" data-backdrop="static" id="saveedpalert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.plsAddEdpFst" text="Please save the EDP first." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.edpSucApproved" text="EDP successfully approved." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:approveEDP()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validedpitemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.cont_three" text="Please enter a valid Item Quantity ." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveedpitemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.cont_four" text="Please enter a positive Item Quantity ." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpitemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.itemSucUpdate" text="Item successfully updated." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpitemadddmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.itemSucAdded" text="Item successfully added." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.areYouSure" text="Are you sure?" /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="rm.edp.jsp.cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deletecreatedEDP()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="edpdeletesuccessmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.edp.jsp.edpSucDeleted" text="EDP successfully deleted." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:redirectEDP()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="rm.edp.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="createnewfromoldedpmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.edp.jsp.crtNewEDPfrmOLDEdp" text="Create New EDP from Old EDP" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center;">
					<spring:message code="rm.edp.jsp.oldEdpDate" text="OLD EDP DATE" /> <input type="text" id="oldedpDate" style="color: #222222;" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
					<input type="button" value="GO" onclick="getoldEDP(document.getElementById('oldedpDate').value)" class="btn btn-success" style="background: #78B626; padding: 5px 20px;">
					<div style="height: 300px; overflow-y: auto;padding: 5px;">
						<table class='table  table-bordered' id="edptablefromold" style='border: 1px solid #fff;'>
							<thead style="background-color: #999;">
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.id" text="Id" /></th>
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.type" text="Type" /></th>
								<th style='text-align: center;'><spring:message code="rm.edp.jsp.approved" text="Approved" /></th>
								<th style='text-align: center;'></th>
							<tbody style='padding: 1px;color: #222222;' id="edpdetailsfromold">
								<c:if test="${!empty edpList}">
												<c:forEach items="${edpList}" var="edplist" varStatus="status">
													<c:choose>
														<c:when test="${edplist.approved =='Y'}">
															<tr class="selected-edp-row" style="background-color: #F7FBC5;">
																<td>${edplist.id}</td>
																<td>${edplist.estimateType.name}</td>
																<td>${edplist.approved}</td>
																<td><input type="radio" id="oldedpid" name="oldedpname" value="${edplist.id}" onclick="javascript:getoldedpItems(this.value,${edplist.estimateType.id})"></td>
															</tr>
														</c:when>
														
													</c:choose>
												</c:forEach>
											</c:if>
							</tbody>
						</table>
					</div>
					<input type="hidden" id="hidoldedpid" value="0">
					<input type="hidden" id="hidoldedptypeid" value="0">
					<div style="padding: 5px;"><spring:message code="rm.edp.jsp.newEdpDate" text="NEW EDP DATE" /> <input type="text" id="newedpDate" style="color: #222222;" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"></div>
					</div>
					<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="createnewfromoldedpalertMsg"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
				<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="rm.edp.jsp.cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:createnewedpfromOld()" style="font-weight: bold; width: 25%;" class="btn btn-success"><spring:message code="rm.edp.jsp.create" text="CREATE" /></button>
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
	<script src="${pageContext.request.contextPath}/assets/js/rm/edpScript.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	
	var munitlists="${metricUnit}";
		$(document).ready(function() {
			$('#edpDate').datepicker({
 				format : "yyyy-mm-dd",
 				autoclose : true
 			});
			$('#oldedpDate').datepicker({
 				format : "yyyy-mm-dd",
 				autoclose : true
 			});
			$('#newedpDate').datepicker({
 				format : "yyyy-mm-dd",
 				autoclose : true
 			});
			 $('#recipeingredientlist').DataTable( {
		        "filter": false,
		        "paginate":false,
		        "info"  : false,
		    } );
			
			 
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
		$('.selected-edp-row').on('click',function(){
	 		   $(this).parent().find('.selected-edp-row').removeClass('selected');
	 		  $(this).addClass('selected');
	 		  });
		
		//for autocomplete
		$(function() {
       $("#edpitemSearch")
               .autocomplete(
                       {
                           source : function(request, response) {
                               $.ajax({
                                           url : "${pageContext.request.contextPath}/edp/autocomplete.htm",
                                           type : "GET",
                                           data : {
                                               tagName : request.term
                                           },

                                           dataType : "json",

                                           success : function(data) {
                                               response($.map(data,function(v) {
															return {
                                                                       label : v.name,
                                                                       itemCode : v.id,
                                                                       itemname : v.name,
                                                                       catid : v.categoryId,
                                                                       catname : v.categoryName,
                                                                       subcatid : v.subCategoryId,
                                                                       subcatname : v.subCategoryName,
                                                                       oldstock : v.oldStock,
                                                                       minqty : v.dailyMinQty,
                                                                       edpqty :v.edpQuantity,
                                                                       unit : v.unit,
                                                                       reqrdqty : v.requiredQuantity
                                                                   };
                                                                  }));
                                           },
                                           error : function(error) {
                                               alert('error: ' + error);
                                           }
                                       });
                           },
                           select : function(e, ui) {
								addNewItemtoEDP(ui.item.itemCode,ui.item.catname,ui.item.subcatname,ui.item.itemname,ui.item.oldstock,ui.item.minqty,ui.item.edpqty,ui.item.unit,ui.item.reqrdqty);
								 $(this).val('');
								 return false;
                           }
                       });
   });
		//filtering category wise
		$("#filterbycat").change(function(){
				 
			        // Retrieve the input field text and reset the count to zero
			        var filter = $(this).val().toLowerCase(), count = 0;
			        // Loop through the comment list
			        $("#saverecipe tbody tr").each(function(index){
			            // If the list item does not contain the text phrase fade it out
                     $row = $(this);
        				 var id = $row.find("td").eq(2).text().toLowerCase();;
         					if (id.indexOf(filter) != 0) {
         					$row.hide();
         					}
        					 else {
         						$row.show();
        					 }
         				if(filter==='select all'){
        	 				$row.show();
         					}
         
			       	 });
			 
			    });
	</script>

    <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/edpScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/edpScript_EN.js"></script> 
    </c:otherwise>
    </c:choose>


</body>
</html>