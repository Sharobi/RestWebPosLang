<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>:. POS :: RAWSTOCKOUT :.</title>
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
input[type=checkbox] {
    transform: scale(2);
    -ms-transform: scale(2);
    -webkit-transform: scale(2);
    padding: 10px;
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
					<input type="hidden" id="selectedpoid" value="0"> <input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
					<div class="col-md-12 col-sm-12" style="background-color: #999;">
						<div class="col-md-3 col-sm-3">
							<div class="inv-requisition-0" style="font-size: 18px;"><spring:message code="rawstockout.jsp.RawStockOut" text="Raw Stock Out"/></div>
							<input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
						<input type="hidden" id="hidCrtBy" size="2" readonly value="${sessionScope.loggedinUser.contactNo}">
						</div>
						<div class="col-md-2 col-sm-2"></div>
						<div class="col-md-7 col-sm-7">
							<div class="inv-requisition-0">
								<spring:message code="rawstockout.jsp.DATE" text="DATE"/><input type="text" id="" disabled size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"> &nbsp;&nbsp;<spring:message code="rawstockout.jsp.Time" text="Time"/>&nbsp;&nbsp; <input type="text" size="7" id="createTime" readonly value="00:00:00" style="text-align: center;">&nbsp;&nbsp; <spring:message code="rawstockout.jsp.EDPID" text="EDP ID"/>  <input type="text" id="clickededpid" disabled="disabled" size="5" value="0"> &nbsp;&nbsp; <spring:message code="rawstockout.jsp.RawStockOutID" text="Raw StockOut ID"/> <input type="text" id="rawstockoutid" disabled="disabled" size="5" value="0">
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-3">
							<div>
								<form modelAttribute="estimateDailyProd" action="${pageContext.request.contextPath }/rawstockout/getrawstockoutbydateandstoreid.htm" method="post">
									<div class="col-md-12 col-sm-12">
										<div class="col-md-3 col-sm-3" style="padding: 3px; font-weight: bold;"><spring:message code="rawstockout.jsp.DATE" text="DATE"/>:</div>
										<div class="col-md-6 col-sm-6" style="padding: 3px; font-weight: bold;">
											<input type="text" id="selecteddate" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
										</div>
										<div class="col-md-3 col-sm-3" style="padding: 3px; font-weight: bold;">
											<input type="submit" value="<spring:message code="rawstockout.jsp.go" text="GO"/>" class="btn btn-success" style="width: 100%;">
										</div>
									</div>
								</form>
							</div>

							<div class="col-md-12 col-sm-12" style="margin-top: 5%">
								<div style="height: 320px; overflow-y: auto;">
									<table id="recipeingredientlist" class="table table-bordered" cellspacing="0" width="100%">
										<thead>
											<tr style="background-color: #77C5EB">
												<th><spring:message code="rawstockout.jsp.ID" text="ID"/></th>
												<th><spring:message code="rawstockout.jsp.EDP" text="EDP"/></th>
												<th><spring:message code="rawstockout.jsp.APPROVED" text="APPROVED"/></th>
											</tr>
										</thead>
										<tbody style="background-color: success">
											<c:if test="${!empty edpList}">
												<c:forEach items="${edpList}" var="edplist" varStatus="status">
													<c:if test="${edplist.approved =='Y'}">
														<tr style="cursor: pointer;" class="selected-stockin-row" onclick="rowClicked(${edplist.id},${edplist.rawStockOutId},&quot;${edplist.rawStockOutStatus}&quot;)">
															<td>${edplist.rawStockOutId}</td>
															<td>${edplist.id}</td>
															<td>${edplist.rawStockOutStatus}</td>
														</tr>
													</c:if>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div class="col-md-3 col-sm-3">
								<div style="width: 90%; margin-top: 2%;">
								<spring:message code="rawstockout.jsp.Category" text="Category"/> : 	<select name="selectedmenucategoryName" id="selectedmenucategoryName" class="selectedmenucategory" onchange="getSelectedCat()">
										<option value="Select All"><spring:message code="rawstockout.jsp.SelectAll" text="Select All"/></option>
										<c:forEach items="${menucategoryList}" var="menucategory">
											<c:if test="${menucategory.menuCategoryName !='SPECIAL NOTE'}">
												<option value="${menucategory.menuCategoryName}">${menucategory.menuCategoryName}</option>
											</c:if>
										</c:forEach>
									</select> <input type="hidden" class="text-input" id="filterbycat" placeholder="<spring:message code="rawstockout.jsp.srhByItem" text="Item Search by Name..."/>" value="" style="width: 90%; margin-top: 2%;" />
								</div>
							</div>
							<div class="col-md-3 col-sm-3">
								<input type="text" class="text-input" id="filter" placeholder="<spring:message code="rawstockout.jsp.srhByItem" text="Item Search by Name..."/>" value="" style="width: 90%; margin-top: 2%;" />
							</div>
							<div class="col-md-5 col-sm-5 hide" id="approvediv" >
								<div class="inv-requisition">
									<spring:message code="rawstockout.jsp.Approved" text="Approved"/>&nbsp;&nbsp; <select name="select1" id="select1" onchange="getApprovedBy(this.value)">
										<option value="N">N</option>
										<option value="Y">Y</option>
									</select><spring:message code="rawstockout.jsp.By" text="By"/>&nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" id="fgstockinapprovedbuttion" style="background: #78B626"><spring:message code="rawstockout.jsp.APPROVE" text="APPROVE"/></a>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div style="height: 365px; overflow-y: auto; background-color: #fff;">
								<table class='table table-striped table-bordered' id="saverawstockout" style='border: 1px solid #fff;'>
									<thead style="background-color: #999;">
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.CODE" text="CODE"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.ITEM" text="ITEM"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.PHYSICALSTOCK" text="PHYSICAL STOCK"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.EDPQTY" text="EDP QTY"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.STOCKEDOUTEDPQTY" text="STOCKED OUT EDP QTY"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.EDPQTYTOOUT" text="EDP QTY TO OUT"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.UNIT" text="UNIT"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.TOWHOM" text="TO WHOM"/></th>
										<th style='text-align: center;'><spring:message code="rawstockout.jsp.ACTION" text="ACTION"/></th>
									<tbody style='padding: 1px;' id="itemdetails">
									</tbody>
								</table>
								<div style="background-color: black;" class="hide" id="waitimage" align="center" >
											<img alt=""  src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
								</div>
							</div>
							<div align="center" id="savefgstockin">
								<div class="col-md-4 col-sm-4 hide">
									<spring:message code="rawstockout.jsp.MiscCharges" text="Misc Charges"/>:<input type="text" size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp; <a href="javascript:poOrderPrint()" class="btn btn-success hide" style="background: #78B626; margin-top: 3px;"><spring:message code="rawstockout.jsp.PRINT" text="PRINT"/></a>
								<font style="font-weight: bold;"><spring:message code="rawstockout.jsp.GRANDTOTAL" text="GRAND TOTAL"/>:</font><input type="hidden" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
								</div>
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-4 col-sm-4">
									 <a href="javascript:rawstockOutSave()" id="rawstockoutSave" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="rawstockout.jsp.Save" text="Save"/></a>
								</div>
								<!-- 								<a href="javascript:saveRecipeIngredients()" id="saveRecipeIngredients" class="btn btn-success" style="background: #78B626; padding: 6px 15px;">SAVE</a> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="savepurchaseorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.PleasesavetheFGStockinfirst" text="Please save the FG Stockin first"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="poapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.FGstockinsuccessfullyapproved" text="FG stockin successfully approved"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:approveFGStockin()"  style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="fgsuccessdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.FGstockinsuccessfullysaved" text="FG stockin successfully saved"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:saveFGStockin()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="itemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.Stockinquantitycannotbegreaterthanestimatedquantity" text="Stock in quantity cannot be greater than estimated quantity"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"  style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="itemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.Itemsuccessfullyupdated" text="Item successfully updated"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:pagereload()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="rawstockoutapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.RawStockOutSuccessfullyApproved" text="Raw Stock Out Successfully Approved"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/rawstockout/loadrawstockout.htm'" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="rawstockoutapprovedmodal_ok" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div id= "rawstockoutapprovedmodal_alert" style="text-align: center; font-size: 20px;"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="existingrawstockoutitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rawstockout.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockout.jsp.Areyousure" text="Are you sure"/>?</div>
					<input type="hidden" id="hdnrawstockoutid" value=""> <input type="hidden" id="hdnrawstockoutitemid" value=""> <input type="hidden" id="hdnrawstockoutrowid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="rawstockout.jsp.Cancel" text="Cancel"/></button>
					<button type="button" onclick="javascript:deleteRowForExistingStockOutItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="rawstockout.jsp.OK" text="OK"/></button>
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
	
	<script src="${pageContext.request.contextPath}/assets/js/rm/rawStockOutScript.js"></script>
	<c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/rowStockOut_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/rowStockOut_EN.js"></script> 
    </c:otherwise>
    </c:choose>
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
			        $("#saverawstockout tbody tr").each(function(index){
			            // If the list item does not contain the text phrase fade it out
            $row = $(this);
            var id = $row.find("td").eq(1).text().toLowerCase();
            if (id.indexOf(filter) != 0) {
            	$row.hide();
            }
            else {
            	$row.show();
            }
			        });
			 
			    });
			
			 $("#filterbycat").change(function(){
				 
			        // Retrieve the input field text and reset the count to zero
			        var filter = $(this).val().toLowerCase(), count = 0;
			        // Loop through the comment list
			        $("#saverawstockout tbody tr").each(function(index){
			            // If the list item does not contain the text phrase fade it out
                     $row = $(this);
        				 var id = $row.find("td").eq(1).text().toLowerCase();;
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
			 
		});
		
		$('.selected-stockin-row').on('click',function(){
	 		   $(this).parent().find('.selected-stockin-row').removeClass('selected');
	 		  $(this).addClass('selected');
	 		  });
	</script>
</body>
</html>