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
<title>:. POS :: StockOut :.</title>
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

<style type="text/css">
  
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
								<a href="javascript:viewPurchaseOrder()"><spring:message code="stockoutnew.jsp.SIMPLEPURCHASEORDER" text="SIMPLE PURCHASE ORDER" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockIn()"><spring:message code="stockoutnew.jsp.SIMPLESTOCKIN" text="SIMPLE STOCK IN" /></a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #72bb4f;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/simplestock/display.htm'">SIMPLE
									STOCK DISPLAY</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="#"><spring:message code="stockoutnew.jsp.SIMPLESTOCKOUT" text="SIMPLE STOCK OUT" /></a>
							</div>
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
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								<spring:message code="stockoutnew.jsp.STOCKOUT" text="STOCK OUT" /><%--  <a href="javascript:newStockOut()" class="btn btn-success" style="background: #78B626"><spring:message code="stockoutnew.jsp.NEW" text="NEW" /></a> --%>
							     <spring:message code="stockoutnew.jsp.Date" text="Date" />&nbsp;&nbsp; <input type="text" name="selecteddate" id="stockoutDate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'> &nbsp;&nbsp; <a href="javascript:getStockOutByDate()" class="btn btn-success" style="background: #78B626"><spring:message code="stockoutnew.jsp.GO" text="GO" /></a>
							     
							</div>
						</div>
						<div class="col-md-7 col-sm-7">
							<div class="inv-requisition">
								<spring:message code="stockoutnew.jsp.Date" text="Date" />&nbsp;&nbsp; <input type="text" size="8" id="createDate" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>' style="text-align: center;"> <%-- <spring:message code="stockoutnew.jsp.Time" text="Time" />&nbsp;&nbsp; <input type="text" size="7" id="createTime" readonly value="00:00:00" style="text-align: center;"> --%> <spring:message code="stockoutnew.jsp.CreatedBy" text="Created By" />&nbsp;&nbsp; <input type="text" size="10" id="createdBy" readonly value="${sessionScope.loggedinUser.contactNo}" style="text-align: center;"><spring:message code="stockoutnew.jsp.StockOutId" text="StockOut Id" /> &nbsp;&nbsp; <input type="text" size="2" id="stockoutId" readonly value="${stockoutId}" style="text-align: center;">
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-4 ">
							<%-- <div class="inv-requisition">
								<spring:message code="stockoutnew.jsp.Date" text="Date" />&nbsp;&nbsp; <input type="text" name="selecteddate" id="stockoutDate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'> &nbsp;&nbsp; <a href="javascript:getStockOutByDate()" class="btn btn-success" style="background: #78B626"><spring:message code="stockoutnew.jsp.GO" text="GO" /></a>
							</div> --%>
						</div>
						<div class="col-md-4 col-sm-6">
							<div class="inv-requisition"></div>
						</div>
						<div class="col-md-4 col-sm-6">
							<div class="inv-requisition"></div>
						</div>
						<div class="col-md-5" id="searchDiv">
							<%-- <div class="inv-requisition">
								<input type="text" size="16" placeholder="<spring:message code="stockoutnew.jsp.search" text="SEARCH" />" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value=""> &nbsp;&nbsp; <a href="javascript:addNewStockOut()" class="btn btn-success" style="background: #78B626"><spring:message code="stockoutnew.jsp.add" text="ADD" /></a>
							</div> --%>
						</div>
					</div>
					<div id="menucatlst" class="hidden">
						<select name="menuCategoryName" class="selectedmenucat">
							<c:forEach items="${menuCategoryList}" var="menuCategory">
								<option value="${menuCategory.menuCategoryName}">${menuCategory.menuCategoryName}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;height: 450px;">
						 <div class="col-md-3 col-sm-4">
							<div style="background: #CCCCCC; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 360px;">
										<div class="table-responsive">
											<table class="table table-striped table-bordered" id="inventoryStockOutListTbl">
												<thead>
													<tr style="background: #77C5EB;">
														<th><spring:message code="stockoutnew.jsp.ID" text="ID" /></th>
														<th><spring:message code="stockoutnew.jsp.USER" text="USER" /></th>
														<th><spring:message code="stockoutnew.jsp.TIME" text="TIME" /></th>
													</tr>
												</thead>
												<c:if test="${! empty inventoryStockOutList}">
													<c:forEach items="${inventoryStockOutList}" var="inventoryStockOut" varStatus="odrStatus">
														<c:if test="${inventoryStockOut.edpId ==0}">
															<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${inventoryStockOut.id})">
																<td>${inventoryStockOut.id}</td>
																<td>${inventoryStockOut.userId}</td>
																<td>${inventoryStockOut.time}</td>
															</tr>
															<input type="hidden" id="hdnstockoutid" value="${inventoryStockOut.id}" />
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
									<div class="panel-body" style="height: 360px;">
										<div class="table-responsive" id="stockoutItemTableDiv">
										         <c:set value="0.0"  var="totalGross"></c:set>
												 <c:set value="0.0"  var="totalTax"></c:set>
												 <c:set value="0.0"  var="totalNet"></c:set>
											<table class="table table-striped table-bordered table-hover" style="" id="stockoutItemTable">
												<thead style="background: #999999;">
													<th style="text-align:center;"><spring:message code="stockoutnew.jsp.CODE" text="CODE" /></th>
													<th style="text-align:center;"><spring:message code="stockoutnew.jsp.ITEM" text="ITEM" /></th>
													<th style="text-align:center;"><spring:message code="stockoutnew.jsp.QUANTITY" text="QUANTITY" /></th>
													<th style="text-align:center;"><spring:message code="stockoutnew.jsp.UNIT" text="UNIT" /></th>
													<th style="text-align:center;">RATE</th>
													<th style="text-align:center;">GROSS</th>
													<th style="text-align:center;">Tax(%)</th>
													<th style="text-align:center;">Tax AMT</th>    
													<th style="text-align:center;">TOTAL COST</th> 
												</thead>
												<tbody id="itemdetails">
												
												<c:forEach items="${rawItemList}" var="rawItem" varStatus="status">
												<tr id="${rawItem.id}">
												   <td id="itmcode_${rawItem.id}">${rawItem.code}</td>
												   <td id="itmname_${rawItem.id}">${rawItem.name}</td>
												   <td id="itmqty_${rawItem.id}">${rawItem.rawQty}</td>
												   <td id="itmunit_${rawItem.id}">${rawItem.unit}</td>
												   <td id="itmrate_${rawItem.id}">${rawItem.rate}</td>
												   <td style="display:none;" id="itmistax_${rawItem.id}">${rawItem.tax}</td>
												   <td style="display:none;" id="itmunitid_${rawItem.id}">${rawItem.metricUnitId}</td>
												   <td style="display:none;" id="itmtaxmode_${rawItem.id}">${rawItem.isTaxExclusive}</td>
												   
												    <c:set var="gross">
												     <fmt:formatNumber  type = "number" groupingUsed="false" minFractionDigits="2"   maxFractionDigits = "2" value = "${rawItem.rate * rawItem.rawQty}" /> 
												    </c:set> 
												    <c:set var="totalGross">
												    <fmt:formatNumber  type = "number" groupingUsed="false" minFractionDigits="2"   maxFractionDigits = "2" value = "${totalGross+gross}" /> 
												    </c:set> 
												    <td id="itmgross_${rawItem.id}">${gross}</td>
												   
												    <td id="itmtaxrate_${rawItem.id}">${rawItem.taxRate}</td>
												   
												   <c:if test="${rawItem.tax == 'Y'}">
												     <c:choose>
													  <c:when test="${rawItem.isTaxExclusive == 'Y'}">
													    <fmt:formatNumber var = "i" type = "number" groupingUsed="false"
																		  minFractionDigits="2"   maxFractionDigits = "2" value = "${((rawItem.rate * rawItem.rawQty) *rawItem.taxRate)/100}" />
													    <c:set value="${i}" var="taxAmt"></c:set>
													   </c:when>
													   <c:otherwise>
													   <fmt:formatNumber var = "i" type = "number" groupingUsed="false"
																		 minFractionDigits="2"  maxFractionDigits = "2" value = "${(((rawItem.rate * rawItem.rawQty)/(1+(rawItem.taxRate/100)))*(rawItem.taxRate))/100}" />
													   <c:set value="${i}" var="taxAmt"></c:set>
													   </c:otherwise>
													 </c:choose>
													 </c:if>
													 <c:if test="${rawItem.tax == 'N'}">
													 <c:set value="0.00" var="taxAmt"></c:set>
													 </c:if>
													<c:set  var="totalTax">
													   <fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totalTax + taxAmt}" />
												    </c:set>
												   	<td id="itmtaxamt_${rawItem.id}">${taxAmt}</td>
												   	
													<c:set  var="totalNet">
													  <fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totalNet + (gross + taxAmt)}" />
													</c:set>
												    <td id="itmnetamt_${rawItem.id}"> ${gross + taxAmt}</td>
												</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
										<div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
									   </div>
										
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-3 col-sm-3"></div>
						<div class="col-md-9 col-sm-9">
							Gross Amt:<input type="text" size="8" id="grossAmtId"  value="<fmt:formatNumber type = "number"  groupingUsed="false" minFractionDigits = "2" maxFractionDigits = "2" value = "${totalGross}" />"  style="text-align: right;" readonly> 
							Total Tax:<input type="text" size="8" id="totTaxAmtId" value="<fmt:formatNumber type = "number"  groupingUsed="false" minFractionDigits = "2" maxFractionDigits = "2" value = "${totalTax}" />"    style="text-align: right;" readonly>
							Total Amt:<input type="text" size="8" id="totalAmtId"  value="<fmt:formatNumber type = "number"  groupingUsed="false" minFractionDigits = "2" maxFractionDigits = "2" value = "${totalNet}" />"    style="text-align: right;" readonly>
							<fmt:formatNumber value="${totalNet}" type="number" pattern="#" var="roundedOff"/>
							<fmt:formatNumber value="${totalNet - roundedOff}"  minIntegerDigits = "1" maxFractionDigits = "2" type="number" pattern="#" var="rountOffAmt"/>
							Round Off:<input type="text" size="8" id="roundOffAmtId"  value="<fmt:formatNumber type = "number"    groupingUsed="false" minFractionDigits = "2" maxFractionDigits = "2" value = "${rountOffAmt}" />"  style="text-align: right;" readonly>
							Grand Total:<input type="text" size="8" id="grandTotAmtId"  value="<fmt:formatNumber type = "number"  groupingUsed="false" minFractionDigits = "2" maxFractionDigits = "2" value = "${roundedOff}" />" style="text-align: right;" readonly>    
						 </div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-6" style="text-align:center;">
							 <%-- <a href="javascript:stockOutSave()" id="stockOutSave" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="stockoutnew.jsp.Save" text="Save" /></a>  --%>
						     <span id="buttonspace"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		<div class="modal fade" data-backdrop="static" id="msgmodal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="stockinnew.jsp.Alert" text="Alert" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="msgspace"></div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;"
						class="btn btn-success" data-dismiss="modal">
						<spring:message code="stockinnew.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js">
		
	</script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/stockoutScriptNew.js"></script>
	<script type="text/javascript">
	var storeID="${sessionScope.loggedinStore.id}";
	var BASE_URL="${pageContext.request.contextPath}";
		// When the document is ready
		var hdnstockoutid=$("#hdnstockoutid").val();
			console.log("hdnstockoutid="+hdnstockoutid);
			if(undefined!=hdnstockoutid){
				//rowClicked(hdnstockoutid);
			}
			setButton();
		$(document).ready(function() {
			$('#stockoutDate').datepicker({
				format : "yyyy-mm-dd",
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
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockoutnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockoutnew.jsp.Itemalreadyexistspleaseselectanother" text="Item already exists, please select another" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockoutnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="inSufficientStockInAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockoutnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockoutnew.jsp.StockoutisnotpossibleduetoinsufficientCurrentStock" text="Stock out is not possible due to insufficient Current Stock" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockoutnew.jsp.OK" text="OK" /></button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockoutnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockoutnew.jsp.PleaseenteravalidItemQuantity" text="Please enter a valid Item Quantity" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockoutnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="stockoutitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockoutnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockoutnew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnItemStockoutId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="stockoutnew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deleteStockoutItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="stockoutnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockoutnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockoutnew.jsp.PleaseenterapositiveItemQuantityOrItemRate" text="Please enter a positive Item Quantity Or Item Rate" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockoutnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>