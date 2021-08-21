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
<title>:. POS :: Recipe Ingredient :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
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
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/rm/rmleftpanel.jsp"></jsp:include>
				<div class="col-md-10 col-sm-10">
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
													<tr style="cursor: pointer;" class="selected-stockin-row" onclick="javascript:clickonSubmenu(${itemSubDesc.id},&quot;${itemSubDesc.name}&quot;)">
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
								<input type="text" size="16" placeholder="<spring:message code="recipeingredients.jsp.search" text="SEARCH"/>" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewItem()" id="addnewpoitem" class="btn btn-success" style="background: #78B626; padding: 3px 15px;"><spring:message code="recipeingredients.jsp.ADD" text="ADD"/></a> <input type="hidden" id="searchitemid" value=""><input type="hidden" id="searchitemmetricUnitId" value="">
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
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.MetricAmt" text="Metric Amt"/>.</th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Unit" text="Unit"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.IngredientName" text="Ingredient Name"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.CookingAmt" text="Cooking Amt"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Unit" text="Unit"/></th>
										<th style='text-align: center;'><spring:message code="recipeingredients.jsp.Action" text="Action"/></th>
									<tbody style='padding: 1px;' id="ingredientdetails">
									</tbody>
								</table>
							</div>
							<div align="center" style="padding: 2px 0px 0px 0px;">
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
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"> </script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/rm/recipeScript.js"></script>
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
	               $("#searchitemmetricUnitId").val(ui.item.metricUnitId);
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