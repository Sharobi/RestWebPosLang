<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>:. POS :: FGStockReturn :.</title>
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
<style type="text/css">
.selected {
	background-color: #77C5EB !important;
}
 .inv-requisition-0 {
    font-size: 12px;
    font-weight: bold;
    margin: 3px;
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
								<a href="#">RECIPE MANAGEMENT</a>
							</div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:viewPurchaseOrder()">SIMPLE PURCHASE
									ORDER</a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a href="javascript:viewStockInPage()">SIMPLE STOCK IN</a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/simplestock/display.htm'">SIMPLE
									STOCK DISPLAY</a>
							</div>
							<!-- <div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()">SIMPLE STOCK OUT</a>
							</div> -->
							<c:choose>
							<c:when test="${sessionScope.loggedinStore.validateRawStockOut=='N'}">
								<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()"><spring:message code="inventorynew.jsp.SIMPLESTOCKOUT" text="SIMPLE STOCK OUT" /></a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOutMan()"><spring:message code="inventorynew.jsp.SIMPLESTOCKOUTMAN" text="SIMPLE STOCK OUT MAN" /></a>
							</div>
							</c:otherwise>
							</c:choose>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/purchasereturn/loadpurchasereturn.htm'">SIMPLE
									PURCHASE RETURN</a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/loaditemstockin.htm'">FG
									STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
							  <a href="javascript:location.href='${pageContext.request.contextPath}/itemreturn/loaditemreturn.htm'">FG RETURN</a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/stockinfo.htm'">FG
									STOCK DISPLAY</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<div class="col-md-12 col-sm-12" style="background-color: #999;">
						<div class="col-md-4 col-sm-4">
							<div class="inv-requisition-0" style="font-size: 18px;"><spring:message code="recipeingredients.jsp.RecipeIngredients" text="Recipe Ingredients"/></div>
							<input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
						</div>
						<div class="col-md-8 col-sm-8">
							<div class="inv-requisition-0">
								<spring:message code="recipeingredients.jsp.ItemName" text="Item Name"/>: <span id="selectedmenuItemName"><spring:message code="recipeingredients.jsp.Pleaseclickonanyitemname" text="Please click on any item name"/></span>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-4 col-sm-4">
							<div style="height: 460px; overflow-y: auto;">
							<table id="recipeingredientlist" class="table  table-bordered" cellspacing="0" width="100%">
								<thead>
									<tr style="background-color: #77C5EB">
										<th><spring:message code="recipeingredients.jsp.Name" text="Name"/></th>
										<th><spring:message code="recipeingredients.jsp.Category" text="Category"/></th>
										<th><spring:message code="recipeingredients.jsp.SubCategory" text="Sub-Category"/></th>
									</tr>
								</thead>
								<tbody style="background-color: success">
									<c:if test="${!empty allmenuforrm}">
										<c:forEach items="${allmenuforrm.menucategory}" var="item" varStatus="status">
											<c:forEach items="${item.menucategory }" var="itemSub">
												<c:forEach items="${itemSub.items }" var="itemSubDesc">
													<tr style="cursor: pointer;" class="selected-stockin-row" onclick="javascript:clickonSubmenu(${itemSubDesc.id},&quot;${itemSubDesc.name}&quot; , &quot;${itemSubDesc.unit}&quot;)">
														<input type="hidden" id="selectedmenuid" value="" />
														<td style="line-height: 1.4; padding: 6px;">${itemSubDesc.name}</td>
														<td style="line-height: 1.4; padding: 6px;">${item.menuCategoryName}</td>
														<td style="line-height: 1.4; padding: 6px;">${itemSub.menuCategoryName}</td>
													</tr>
												</c:forEach>
											</c:forEach>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
							</div>
						</div>

						<div class="col-md-8 col-sm-8 hide" id="searchdiv">
							<div class="inv-requisition-0">
								<input type="text" size="16" placeholder="<spring:message code="recipeingredients.jsp.search" text="SEARCH"/>" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewItem()" id="addnewpoitem" class="btn btn-success" style="background: #78B626; padding: 3px 15px;"><spring:message code="recipeingredients.jsp.ADD" text="ADD"/></a> <input type="hidden" id="searchitemid" value=""><input type="hidden" id="searchitemmetricUnitId" value=""><input type="hidden" id="searchitemrate" value="">
							</div>
						</div>
						<div class="col-md-8 col-sm-8 hide">
							<div class="col-md-4 col-sm-4" style="border: 1px solid #999; font-size: 14px; font-weight: bold; padding: 6px;"><spring:message code="recipeingredients.jsp.CookingCost" text="Cooking Cost"/></div>
							<div class="col-md-4 col-sm-4" style="border: 1px solid #999; font-size: 14px; font-weight: bold; padding: 6px;"><spring:message code="recipeingredients.jsp.OtherCost" text="Other Cost"/></div>
							<div class="col-md-4 col-sm-4" style="border: 1px solid #999; font-size: 14px; font-weight: bold; padding: 6px;"><spring:message code="recipeingredients.jsp.TotalCost" text="Total Cost"/></div>
						</div>
						<div class="col-md-8 col-sm-8">
							<div style="height: 365px; overflow-y: auto; background-color: #fff;">
								<table class='table table-striped table-bordered' id="saverecipe" style='border: 1px solid #fff;'>
									<thead style="background-color: #999;">
										<th style='text-align: center;'><spring:message code="accgroup.jsp.code" text="Code"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.IngredientName" text="Ingredient Name"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.MetricAmt" text="Metric Amt"/>.</th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Unit" text="Unit"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.CookingAmt" text="Cooking Amt"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Unit" text="Unit"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Cost" text="Cost"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Action" text="Action"/></th>
									<tbody style='padding: 1px;' id="ingredientdetails">
									</tbody>
								</table>
							</div>
							<div align="center" style="padding: 2px 0px 0px 0px;">
							    <!--  Total Cost:<span id="totalCost"></span> -->
								<a href="javascript:saveRecipeIngredients()" id="saveRecipeIngredients" class="btn btn-success hide" style="background: #78B626; padding: 6px 15px;"><spring:message code="recipeingredients.jsp.SAVE" text="SAVE"/></a>
							</div>
						</div>
					</div>
				</div>
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
			      <option value="0">Select</option>
				<c:forEach items="${cookingUnit}" var="cookingUnit">
					<option value="${cookingUnit.id}">${cookingUnit.unit}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div id="newmetricUnitList" class="hidden">
			<select name="newmetricUnitName" id="newmetricUnitName" class="selectedmetricUnit newselectedmetricUnit">
				<c:forEach items="${metricUnit}" var="metricUnit">
					<option value="${metricUnit.id}">${metricUnit.unit}</option>
				</c:forEach>
			</select>
		</div>
	<div class="modal fade" data-backdrop="static" id="alreadyexistitem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="recipeingredients.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Itemalreadyexistspleaseselectanother" text="Item already exists, please select another"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="receipeitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="recipeingredients.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Areyousure" text="Are you sure"/>?</div>
					<input type="hidden" id="hdnreceipeitemid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="recipeingredients.jsp.Cancel" text="Cancel"/></button>
					<button type="button" onclick="javascript:deleteReceipeItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingreceipeitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="recipeingredients.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Areyousure" text="Are you sure?"/></div>
					<input type="hidden" id="hdnexixtingreceipeitemid" value=""> <input type="hidden" id="hdnexistingreceipeitemtableid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="recipeingredients.jsp.Cancel" text="Cancel"/></button>
					<button type="button" onclick="javascript:deleteExistingReceipeItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="recipeingredients.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Itemsuccessfullyupdated" text="Item successfully updated"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemsavemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="recipeingredients.jsp.Success" text="Success"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Itemsuccessfullysaved" text="Item successfully saved"/>.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="wrongmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Success</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Pleasegivesomeinputtocookingamtormetricamt" text="Please give some input to cooking amt. or metric amt"/>. </div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="addingtoitem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="recipeingredients.jsp.Alert" text="Alert"/></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="recipeingredients.jsp.Pleaseaddsomeingredienttoreceipe" text="Please add some ingredient to receipe"/>. </div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="recipeingredients.jsp.OK" text="OK"/></button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"> </script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/recipemgmtscript.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/ajax/ajax.js"></script>
	
	 <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/recipeScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/recipeScript_EN.js"></script> 
    </c:otherwise>
    </c:choose>
	
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	var munitlists="${metricUnit}";
		$(document).ready(function() {
// 			$('#recipeingredientlist').DataTable();
			 $('#recipeingredientlist').DataTable( {
		        paging:false,
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
	                    	 console.log("data="+data);
	                    	 console.log("ingredients1=" + JSON.stringify(data));
	                      response($.map(data, function(v){
	                           return  {
	                                      label: v.name,
	                                      value: v.name,
	                                      itemCode:v.code,
	                                      itemId: v.id,
	                                      metricUnitId: v.metricUnitId,
	                                      rate: v.rate,
	                                     };  
	                      }));
	                     },
	                     error: function (error) {
	                         console.log('error: ' + error);
	                      }
	                });              
	             },
	               select: function(e,ui) {
	            	   console.log(ui.item.items);
	               $("#searchCode").val(ui.item.itemCode);
	               $("#searchitemid").val(ui.item.itemId);
	               $("#searchitemmetricUnitId").val(ui.item.metricUnitId);
	               $("#searchitemrate").val(ui.item.rate);
	            }
	         });
	     });
		$('.selected-stockin-row').on('click',function(){
	 		   $(this).parent().find('.selected-stockin-row').removeClass('selected');
	 		  $(this).addClass('selected');
	 		  });
		
		
		
		
		
		function viewStockIn() {
			var selectedpoid = $("#selectedpoid").val();
			console.log("selectedpoid=" + selectedpoid);
			console.log("$('#poItemTable > tbody  > tr').=" + $('#poItemTable > tbody  > tr').length);
			var tableDatalen = $('#poItemTable > tbody  > tr').length;
			if (selectedpoid == 0 && tableDatalen > 0) {
				$("#displayStockInPage").modal('show');
			} else {
				location.href = BASE_URL + '/stockinnew/loadstockin.htm';
			}
		}

		function viewStockInPage() {
			location.href = BASE_URL + '/stockinnew/loadstockin.htm';
		}
		function viewStockOut() {
			location.href = BASE_URL + '/stockoutnew/loadstockout.htm';
		}
		function viewStockOutMan() {
			location.href = BASE_URL + '/stockoutnew/loadstockoutman.htm';
		}
		function viewPurchaseReturnPage(){
			location.href = BASE_URL + '/purchasereturn/loadpurchasereturn.htm';
			
		}
		function viewPurchaseOrder() {
			location.href = BASE_URL + '/inventorynew/loadinventory.htm';
			}

	</script>
</html>