<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<title>:. POS :: FG Close :.</title>
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
	transform: scale(2); -ms-transform: scale(2); -webkit-transform: scale(2); padding: 10px;
}
</style>
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body onload="checkApprove(document.getElementById('invCrtBy').value,document.getElementById('approved').value)">
	<%-- 	<c:set var="today" value="<%=new java.util.Date()%>" /> --%>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/rm/rmleftpanel.jsp"></jsp:include>
				<div class="col-md-10 col-sm-10">
					<input type="hidden" id="selectedpoid" value="0"> <input type="hidden" id="invCrtBy" value="${sessionScope.loggedinUser.contactNo}"><input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
					<div class="col-md-12 col-sm-12" style="background-color: #999;">
						<div class="col-md-3 col-sm-3">
							<div class="inv-requisition-0" style="font-size: 18px;"><spring:message code="rm.fgclose.jsp.fgClose" text="FG Close" /></div>
							<input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
						</div>
						<div class="col-md-2 col-sm-2"></div>
						<div class="col-md-7 col-sm-7 hide">
							<div class="inv-requisition-0">
								<spring:message code="rm.fgclose.jsp.date" text="DATE" /> <input type="text" id="" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />"> &nbsp;&nbsp; <spring:message code="rm.fgclose.jsp.edpId" text="EDP ID" /> <input type="text" id="clickededpid" disabled="disabled" size="5" value="0"> &nbsp;&nbsp; <spring:message code="rm.fgclose.jsp.fgId" text="FG ID" /> <input type="text" id="clickedfgid" disabled="disabled" size="5" value="0">
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-3">
							<div>
								<form modelAttribute="estimateDailyProd" action="${pageContext.request.contextPath }/fgclose/getfgclosebydateandstoreid.htm" method="post">
									<div class="col-md-12 col-sm-12">
										<div class="col-md-3 col-sm-3" style="padding: 3px; font-weight: bold;"><spring:message code="rm.fgclose.jsp.date" text="DATE :" /></div>
										<div class="col-md-6 col-sm-6" style="padding: 3px; font-weight: bold;">
											<input type="text" id="selecteddate" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
										</div>
										<div class="col-md-3 col-sm-3" style="padding: 3px; font-weight: bold;">
											<input type="submit" value="<spring:message code="rm.fgclose.jsp.go" text="GO" />" class="btn btn-success" style="width: 100%;">
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div class="col-md-4 col-sm-4">
								<div style="width: 90%; margin-top: 2%;">
									<spring:message code="rm.fgclose.jsp.cat" text="Category:" /> <select name="selectedmenucategoryName" id="selectedmenucategoryName" class="selectedmenucategory" onchange="getSelectedCat()">
										<option value="Select All"><spring:message code="rm.fgclose.jsp.selectAll" text="Select All" /></option>
										<c:forEach items="${menucategoryList}" var="menucategory">
											<c:if test="${menucategory.menuCategoryName !='SPECIAL NOTE'}">
												<option value="${menucategory.menuCategoryName}">${menucategory.menuCategoryName}</option>
											</c:if>
										</c:forEach>
									</select> <input type="hidden" class="text-input" id="filterbycat" placeholder="Item Search by Name..." value="" style="width: 90%; margin-top: 2%;" />
								</div>
							</div>
							<div class="col-md-3 col-sm-3">
								<input type="text" class="text-input" id="filter" placeholder="<spring:message code="rm.fgclose.jsp.cont_one" text="Item Search by Name..." />" value="" style="width: 90%; margin-top: 2%;" />
							</div>
							<div class="col-md-5 col-sm-5">
								<div class="inv-requisition ">
									<spring:message code="rm.fgclose.jsp.approved" text="Approved" />&nbsp;&nbsp; <select name="select1" id="select1" onchange="getApprovedBy(this.value)">
										<option value="N">N</option>
										<option value="Y">Y</option>
									</select><spring:message code="rm.fgclose.jsp.by" text="By" /> &nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" id="poapprovedbuttion" style="background: #78B626"><spring:message code="rm.fgclose.jsp.approve" text="APPROVE" /></a>
								</div>
							</div>
						</div>
						<div class="col-md-12 col-sm-12">
							<div style="height: 365px; overflow-y: auto; background-color: #fff;">
								<table class='table table-striped table-bordered' id="saverecipe" style='border: 1px solid #fff;'>
									<thead style="background-color: #999;">
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.id" text="ID" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.cat" text="CAT" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.subCat" text="SUB CAT" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.itemName" text="ITEM NAME" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.stockIn" text="STOCK IN" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.stockOut" text="SALE OUT" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.curStock" text="CURRENT STOCK" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.waste" text="WASTE" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.consume" text="CONSUME" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.reStockIn" text="RE-STOCKIN" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgclose.jsp.waste" text="(%)WASTE" /></th>
									<tbody style='padding: 1px;'>
										<c:if test="${!empty fgCloseChildS}">
											<c:forEach items="${fgCloseChildS}" var="fgCloseChild" varStatus="status">
												<input type="hidden" id="fgCloseId" value="${fgCloseChild.fgClseId}" style="width: 90%; margin-top: 2%;" />
												<c:set var="isapproved"> ${fgCloseChild.approved}</c:set>
												<tr id="${fgCloseChild.itemId}" class="selected-stockin-row">
													<td>${fgCloseChild.itemId}</td>
													<td>${fgCloseChild.categoryName}</td>
													<td>${fgCloseChild.subCategoryName}</td>
													<td>${fgCloseChild.itemName}</td>
													<td style='text-align: center;' id="stockin_${fgCloseChild.itemId}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${fgCloseChild.stockInQuantity}" /></td>
													<td style='text-align: center;'><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${fgCloseChild.saleOutQuantity}" /></td>
													<td style='text-align: center;'><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity}" /></td>
													<c:choose>
														<c:when test="${isapproved =='Y'}">
															<td><input disabled="disabled" type="text" id="waste_${fgCloseChild.itemId}" onkeyup="javascript:changeWaste(this.value,document.getElementById('consume_${fgCloseChild.itemId}').value,${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity},${fgCloseChild.itemId})" size="5" value="${fgCloseChild.waste}"></td>
															<td><input disabled="disabled" type="text" id="consume_${fgCloseChild.itemId}" onkeyup="javascript:changeConsume(this.value,document.getElementById('waste_${fgCloseChild.itemId}').value,${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity},${fgCloseChild.itemId})" size="5" value="${fgCloseChild.consume}"></td>
															<td id="restockin_${fgCloseChild.itemId}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity-fgCloseChild.waste-fgCloseChild.consume}" /></td>
														</c:when>
														<c:otherwise>
															<c:if test="${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity >'0'}">
																<td><input type="text" id="waste_${fgCloseChild.itemId}" onkeyup="javascript:changeWaste(this.value,document.getElementById('consume_${fgCloseChild.itemId}').value,${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity},${fgCloseChild.itemId})" size="5" value="${fgCloseChild.waste}"></td>
																<td><input type="text" id="consume_${fgCloseChild.itemId}" onkeyup="javascript:changeConsume(this.value,document.getElementById('waste_${fgCloseChild.itemId}').value,${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity},${fgCloseChild.itemId})" size="5" value="${fgCloseChild.consume}"></td>
																<td id="restockin_${fgCloseChild.itemId}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity-fgCloseChild.waste-fgCloseChild.consume}" /></td>
															</c:if>
															<c:if test="${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity <='0'}">
																<td><input disabled="disabled" type="text" id="waste_${fgCloseChild.itemId}" onkeyup="javascript:changeWaste(this.value,document.getElementById('consume_${fgCloseChild.itemId}').value,${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity},${fgCloseChild.itemId})" size="5" value="${fgCloseChild.waste}"></td>
																<td><input disabled="disabled" type="text" id="consume_${fgCloseChild.itemId}" onkeyup="javascript:changeConsume(this.value,document.getElementById('waste_${fgCloseChild.itemId}').value,${fgCloseChild.stockInQuantity - fgCloseChild.saleOutQuantity},${fgCloseChild.itemId})" size="5" value="${fgCloseChild.consume}"></td>
																<td id="restockin_${fgCloseChild.itemId}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00" /></td>
															</c:if>
														</c:otherwise>
													</c:choose>

													<td id="wasteperc_${fgCloseChild.itemId}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${fgCloseChild.variance}" /></td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>
							<div align="center" id="savefgstockin">
								<div class="col-md-4 col-sm-4 hide">
									<spring:message code="rm.fgclose.jsp.miscCharge" text="Misc Charges:" /><input type="text" size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp; <a href="javascript:poOrderPrint()" class="btn btn-success hide" style="background: #78B626; margin-top: 3px;"><spring:message code="rm.fgclose.jsp.print" text="PRINT" /></a> <font style="font-weight: bold;"><spring:message code="rm.fgclose.jsp.grndTotal" text="GRAND TOTAL:" /></font><input type="hidden" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
								</div>
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-4 col-sm-4">
									<c:choose>
										<c:when test="${isapproved =='Y'}">
											<input type="hidden" id="approved" value="Y">
											<a href="javascript:fgCloseSave()" id="fgcloseSave" class="btn btn-success" disabled style="background: #78B626; margin-top: 3px;"><spring:message code="rm.fgclose.jsp.save" text="Save" /></a>
										</c:when>
										<c:otherwise>
											<input type="hidden" id="approved" value="N">
											<a href="javascript:fgCloseSave()" id="fgcloseSave" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="rm.fgclose.jsp.save" text="Save" /></a>
										</c:otherwise>
									</c:choose>

								</div>
								<!-- 								<a href="javascript:saveRecipeIngredients()" id="saveRecipeIngredients" class="btn btn-success" style="background: #78B626; padding: 6px 15px;">SAVE</a> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="savefgclose" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgclose.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgclose.jsp.plsSvFGclsfst" text="Please save the Fg Close first." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgclose.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="fgsuccessdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgclose.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgclose.jsp.fgClsSVSucc" text="FG Close saved successfully." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:loadFGClose()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgclose.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="fgcloseapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgclose.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgclose.jsp.fgClsSuccApprvd" text="FG Close successfully approved." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:loadFGClose()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgclose.jsp.ok" text="OK" /></button>
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
	<script src="${pageContext.request.contextPath}/assets/js/rm/fgCloseScript.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	var munitlists="${metricUnit}";
	function checkApprove(createdby,isapproved){
		console.log("createdby="+createdby);
		console.log("isapproved="+isapproved);
		if(isapproved=='Y'){
			$("#select1").val(isapproved);
			$("#appvId").val(createdby);
			$('#select1').prop('disabled', true);
			$("#poapprovedbuttion").addClass('disabled');
		}
	}
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
            var id = $row.find("td").eq(3).text().toLowerCase();;
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