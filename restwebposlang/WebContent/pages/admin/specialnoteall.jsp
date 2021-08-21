<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <title>:. POS :: Special Notes Setup :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   
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
           <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>  
           
           <div class="col-md-10 col-sm-10">
                <div class="col-md-10 col-sm-10">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.specialnoteall.jsp.specialNotes" text="Special Notes" /> </div> 
                </div>
                <div class="col-md-3 col-sm-3" style="float: right;">
                    <a href="javascript:shownmenuitemsaddModal_add()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.specialnoteall.jsp.add" text="ADD" /></a>
                    <a href="javascript:showConfirmdeleteMenuItemsModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.specialnoteall.jsp.delete" text="DELETE" /></a>
                   <!-- will be done -->
                   <a href="javascript:shownspclitemeditModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.specialnoteall.jsp.edit" text="EDIT" /></a> 
                    <!-- <a href="javascript:shownspclitemeditModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;">DELETE</a> -->
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 600px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <tbody>
                                    <%-- <c:if test="${empty allsplnoteTree.menucategory }">No special note found!</c:if> --%>
                                    	<c:if test="${! empty allsplnoteTree}">
                                    	
                												<c:forEach items="${allsplnoteTree.menucategory}" var="menucategory">
                                    								<c:forEach items="${menucategory.menucategory}" var="menusubcategory">
                                    									<c:forEach items="${menusubcategory.items}" var="menuitems">
                                    										
                                    											<label class="btn-special-note" id="btn_spl_note" style='background:${menuitems.bgColor};text-align:center;height:80px;width:10%;margin:6px;border-radius: 30px 3px;'>
                                    											<div style='font-size:11px;white-space:normal;'>
                                    											  <div>
                                    											    <input class='chk' style="float: right;" type='checkbox' name='specialnote' value='${menuitems.id}'/>
                                    											   </div>
                                    											${menuitems.name}
                                    											</div>
                                    											
                                    											
                                    											</label>
                                    											
                                    									</c:forEach>
                                    								</c:forEach>
                                    							</c:forEach>             							
                                    	</c:if>
                                        <c:if test="${empty allsplnoteTree.menucategory}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="5"><spring:message code="admin.specialnoteall.jsp.noDataFound" text="No Data found!" /></td>
                                        	</tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
           </div>
                	
            </div>
            
            <!--  MODAL STARTS ADD  -->
            
            <div class="modal fade" data-backdrop="static" id="menuitemAddModal_add" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.addMenuItem" text="Add Menu Item" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<span style="color:green"><b>Before adding Special Note please add a Category named 'SPECIAL NOTE' and Sub Category named 'REQUEST EXTRA' under 'SPECIAL NOTE' category if this are not exist.</b> </span><br><br>
                                        	<div style="text-align: left;font-size: 18px;">
                                        		
                                            	<table>
                                            		<tr class="hide"> 
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="" />CATEGORY NAME</td>
                                            			<td>:</td>
                                            			<td>                                            				
                                            					<%-- <c:if test="${! empty menucatList}">
                                            					<td><input type="text" id="menucategoryId" value="${splnote.categoryId}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            					</c:if> --%>
                                            					<%--  <c:if test="${! empty allmenuTreeforSingle}">
                                            						<c:forEach items="${allmenuTreeforSingle.menucategory}" var="menucat">
                                            						<option value="${menucat.id}">${menucat.menuCategoryName}</option>
                                            						</c:forEach> 
                                            						
                                            					</c:if>  --%>
                                            					                                           				
                                            					<select id="menucategoryId"  style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty menucatList}">
                                            					<c:forEach items="${menucatList}" var="menucat">
                                            					<c:if test="${fn:containsIgnoreCase(menucat.menuCategoryName, 'SPECIAL NOTE') }">
                                            						<option value="${menucat.id}">${menucat.menuCategoryName}</option>
                                            					</c:if>
                                            					</c:forEach>
                                            					</c:if>
                                            				   </select>
                                            					
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="All" />SUB CATEGORY NAME</td>
                                            			<td>:</td>
                                            			<td>
                                            					<c:if test="${! empty menusubcatList}">
                                            					<td><input type="text" id="menusubcategoryId" value="${splnote.id}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            					</c:if>
                                            					 <c:if test="${! empty allmenuTreeforSingle}">
                                            					<c:forEach items="${allmenuTreeforSingle.menucategory}" var="menucat" end="0">
                                            						<c:forEach items="${menucat.menucategory}" var="menusubcat">
                                            							<option value="${menusubcat.id}">${menusubcat.menuCategoryName}</option>
                                            						</c:forEach>
                                            						
                                            					</c:forEach>
                                            					</c:if> 

                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemName" text="ITEM NAME" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsName" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemDesc" text="ITEM DESC" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<textarea id="modaddmenuitemsDesc" rows="2" style="margin-bottom: 2px;color: #222222;width: 95%;"></textarea>
                                            			<!-- <input type="text" id="modaddmenuitemsDesc" value="" style="margin-bottom: 3px;color: #222222;width: 95%;"/> -->
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.price" text="PRICE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPrice" value="0" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.vat" text="VAT(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsVat" value="${sessionScope.loggedinStore.vatAmt}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.serviceTax" text="SERVICE TAX(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsStax" value="${sessionScope.loggedinStore.serviceTaxAmt}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemType" text="ITEM TYPE" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemsVeg" name="modaddmenuitemsType" checked="checked" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.veg" text="VEG" />&nbsp;
                                            			<input type="radio" id="modaddmenuitemsNonVeg" name="modaddmenuitemsType" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.nonVeg" text="NON VEG" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.spicy" text="SPICY" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemsspicyYes" name="modaddmenuitemsSpicy" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddmenuitemsspicyNo" name="modaddmenuitemsSpicy" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotion" text="PROMOTION" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemspromoYes" onchange="enablePromoFields()" name="modaddmenuitemsPromo" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddmenuitemspromoNo" onchange="disablePromoFields()" name="modaddmenuitemsPromo" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotionDesc" text="PROMOTION DESC" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPromoDesc" disabled="disabled" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotionValue" text="PROMOTION VALUE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPromoValue" disabled="disabled" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.cookTimeMin" text="COOKING TIME(MIN.)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsCookingTime"  value="10" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemUnit" text="ITEM UNIT" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modaddmenuitemsUnit" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty fmcgList}">
                                            					<c:forEach items="${fmcgList}" var="fmcg">
                                            						<option value="${fmcg.name}">${fmcg.name}</option>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            			
                                            		</tr>
                                            		<tr class="color" style="bottom:0px;" >
                                            		<c:if test="${! empty colorList}">
                                            		<c:forEach items="${colorList}" var="color">
                                            		
                                            		<label class="btn-special-note" style='background: #${color.code};height:70px;width:20%;margin:6px;border-radius: 30px 3px;'>
                                    				<div style="float: right">
                                    				<input id="modaddmenuitemsColor" class='chk_add' style="" type='checkbox' name='notecolor' value='${color.code}'/>
                                    				</div>                                    											                                 				
                                    				</label>
                                            		
                                            		</c:forEach>
                                            		</c:if>
                                            		</tr>
                                            		
                                            	</table>
                                            	
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addmenuitemsalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancleNote()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.specialnoteall.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addSplItems()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
            
            
            <!-- ADD MODAL END -->
           <!-- modal starts EDIT -->
           				 <div class="modal fade" data-backdrop="static" id="menuitemAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.addMenuItem" text="Add Menu Item" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 18px;">
                                        		
                                            	<table>
                                            		<tr class="hide" > 
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="All" />CATEGORY NAME</td>
                                            			<td>:</td>
                                            			<td>                                            				
                                            					<c:if test="${! empty menucatList}">
                                            					<td><input type="text" id="menucategoryId" value="${splnote.categoryId}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            					</c:if>
                                            					<%--  <c:if test="${! empty allmenuTreeforSingle}">
                                            						<c:forEach items="${allmenuTreeforSingle.menucategory}" var="menucat">
                                            						<option value="${menucat.id}">${menucat.menuCategoryName}</option>
                                            						</c:forEach> 
                                            						
                                            					</c:if>  --%>
                                            				
                                            				
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="All" />SUB CATEGORY NAME</td>
                                            			<td>:</td>
                                            			<td>
                                            					<c:if test="${! empty menusubcatList}">
                                            					<td><input type="text" id="menusubcategoryId" value="${splnote.id}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            					</c:if>
                                            					 <c:if test="${! empty allmenuTreeforSingle}">
                                            					<c:forEach items="${allmenuTreeforSingle.menucategory}" var="menucat" end="0">
                                            						<c:forEach items="${menucat.menucategory}" var="menusubcat">
                                            							<option value="${menusubcat.id}">${menusubcat.menuCategoryName}</option>
                                            						</c:forEach>
                                            						
                                            					</c:forEach>
                                            					</c:if> 

                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemName" text="ITEM NAME" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsName" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemDesc" text="ITEM DESC" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<textarea id="modaddmenuitemsDesc" rows="2" style="margin-bottom: 2px;color: #222222;width: 95%;"></textarea>
                                            			<!-- <input type="text" id="modaddmenuitemsDesc" value="" style="margin-bottom: 3px;color: #222222;width: 95%;"/> -->
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.price" text="PRICE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPrice" value="0" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.vat" text="VAT(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsVat" value="${sessionScope.loggedinStore.vatAmt}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.serviceTax" text="SERVICE TAX(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsStax" value="${sessionScope.loggedinStore.serviceTaxAmt}" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemType" text="ITEM TYPE" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemsVeg" name="modaddmenuitemsType" checked="checked" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.veg" text="VEG" />&nbsp;
                                            			<input type="radio" id="modaddmenuitemsNonVeg" name="modaddmenuitemsType" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.nonVeg" text="NON VEG" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.spicy" text="SPICY" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemsspicyYes" name="modaddmenuitemsSpicy" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddmenuitemsspicyNo" name="modaddmenuitemsSpicy" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="All" />PROMOTION</td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddmenuitemspromoYes" onchange="enablePromoFields()" name="modaddmenuitemsPromo" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddmenuitemspromoNo" onchange="disablePromoFields()" name="modaddmenuitemsPromo" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="All" /><spring:message code="admin.specialnoteall.jsp.promotionDesc" text="PROMOTION DESC" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPromoDesc" disabled="disabled" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotionValue" text="PROMOTION VALUE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsPromoValue" disabled="disabled" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.cookTimeMin" text="COOKING TIME(MIN.)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddmenuitemsCookingTime"  value="10" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemUnit" text="ITEM UNIT" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modaddmenuitemsUnit" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty fmcgList}">
                                            					<c:forEach items="${fmcgList}" var="fmcg">
                                            						<option value="${fmcg.name}">${fmcg.name}</option>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            			
                                            		</tr>
                                            		<tr class="color" style="bottom:0px;" >
                                            		<c:if test="${! empty colorList}">
                                            		<c:forEach items="${colorList}" var="color">
                                            		
                                            		<label class="btn-special-note" style='background: #${color.code};height:70px;width:20%;margin:6px;border-radius: 30px 3px;'>
                                    				<div style="float: right">
                                    				<input id="modaddmenuitemsColor" class='chk' style="" type='checkbox' name='notecolor' value='${color.code}'/>
                                    				</div>                                    											                                 				
                                    				</label>
                                            		
                                            		</c:forEach>
                                            		</c:if>
                                            		</tr>
                                            		
                                            	</table>
                                            	
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addmenuitemsalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancleNote()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.specialnoteall.jsp.CANCEL" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addSplItems()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.CREATE" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="menuitemEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.editMenuItem" text="Edit Menu Item" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 18px;">
                                        		<input type="hidden" id="modeditmenuitemsId" value="">
                                        		
                                            	<table>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.catName" text="CATEGORY NAME" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modeditmenucategoryId" disabled="disabled" style="margin-bottom: 2px;color: #222222;"></select>
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modeditmenusubcategoryId" disabled="disabled" style="margin-bottom: 2px;color: #222222;"></select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.specialnoteall.jsp.invType" text="All" /><spring:message code="admin.specialnoteall.jsp.itemType" text="ITEM NAME" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsName" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemDesc" text="ITEM DESC" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<textarea id="modeditmenuitemsDesc" rows="2" style="margin-bottom: 2px;color: #222222;width: 95%;"></textarea>
                                            			<!-- <input type="text" id="modeditmenuitemsDesc" value="" style="margin-bottom: 3px;color: #222222;width: 95%;"/> -->
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.price" text="PRICE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsPrice" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.vat" text="VAT(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsVat" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.serviceTax" text="SERVICE TAX(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsStax" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemType" text="ITEM TYPE" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modeditmenuitemsVeg" name="modeditmenuitemsType" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.veg" text="VEG" />&nbsp;
                                            			<input type="radio" id="modeditmenuitemsNonVeg" name="modeditmenuitemsType" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.nonVeg" text="NON VEG" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.spicy" text="SPICY" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modeditmenuitemsspicyYes" name="modeditmenuitemsSpicy" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modeditmenuitemsspicyNo" name="modeditmenuitemsSpicy" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotion" text="PROMOTION" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modeditmenuitemspromoYes" onchange="enablePromoFields()" name="modeditmenuitemsPromo" value="Y">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modeditmenuitemspromoNo" onchange="disablePromoFields()" name="modeditmenuitemsPromo" value="N">&nbsp;&nbsp;<spring:message code="admin.specialnoteall.jsp.no" text="NO" />
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotionDesc" text="PROMOTION DESC" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsPromoDesc" value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.promotionValue" text="PROMOTION VALUE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsPromoValue"  value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr class="hide">
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.cookTimeMin" text="COOKING TIME(MIN.)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modeditmenuitemsCookingTime"  value="" style="margin-bottom: 2px;color: #222222;width: 95%;"/></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemUnit" text="ITEM UNIT" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modeditmenuitemsUnit" style="margin-bottom: 2px;color: #222222;">
                                            					
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.itemStatus" text="ITEM STATUS" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modeditmenuitemsProductionId" style="margin-bottom: 2px;color: #222222;">
                                            					
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.specialnoteall.jsp.spotDisc" text="SPOT DISCOUNT" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modeditmenuitemsspotDiscId" style="margin-bottom: 2px;color: #222222;">
                                            					
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            		<c:if test="${! empty colorList}">
                                            		<c:forEach items="${colorList}" var="color">
                                            		 
                                            		<label class="btn-special-note" style='background: #${color.code};height:70px;width:20%;margin:6px;border-radius: 30px 3px;'>
                                    					<div>
                                    					<input class='clk' id="modeditmenuitemsbgcolor" value='${color.code}' style="float: right;" type='checkbox' name="selectedBox"/>
                                    					</div>                                    											                                 				
                                    				</label>
                                            		
                                            		</c:forEach>
                                            		</c:if>
                                            		</tr>
                                            	</table>
                                            	
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editmenuitemsalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancleNote()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.specialnoteall.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editSplNote()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteMenuItemsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.specialnoteall.jsp.areYouSure" text="Are you sure?" />                                        	
                                            	<input type="hidden" id="deletemodmenuitemsId" value="">
                                            	
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancleNote()" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.specialnoteall.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteSplNote()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="menuitemsDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.menuItemDetails" text="Menu Item Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 18px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 0px 0px;"><spring:message code="admin.specialnoteall.jsp.catName" text="CATEGORY NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemscatnameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemssubcatnameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.name" text="NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsnameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.desc" text="DESC" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsdescTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.price" text="PRICE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemspriceTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.vat" text="VAT" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsvatTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.serviceTax1" text="SERVICE TAX" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsstaxTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.type" text="TYPE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemstypeTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.spicy" text="SPICY" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsspicyTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.promotion" text="PROMOTION" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemspromoTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.promotionDesc" text="PROMOTION DESC" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemspromodescTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.promotionValue" text="PROMOTION VALUE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemspromovalueTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.cookTimeMin" text="COOKING TIME(MIN.)" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemscookingtimeTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.unit" text="UNIT" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsunitTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.itemStatus" text="ITEM STATUS" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsproductionTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 2px 0px;"><spring:message code="admin.specialnoteall.jsp.spotDisc" text="SPOT DISCOUNT" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailmenuitemsspotDiscTd"></td>
                                            		</tr>
                                            	</table>
                                           		
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.specialnoteall.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alertnoItemFoundModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                           <spring:message code="admin.specialnoteall.jsp.noItemFound" text="No item found!" /> 
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="menuitemaddkotPrinterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.addKotPrinter" text="Add KOT Printer" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.specialnoteall.jsp.itemId" text="ITEM ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moditemkotitemidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.specialnoteall.jsp.itemName" text="ITEM NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moditemkotitemnameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.specialnoteall.jsp.printer1" text="PRINTER 1" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<select id="moditemkotprinterloc1" style="color: #222222;"></select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.specialnoteall.jsp.printer2" text="PRINTER 2" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<select id="moditemkotprinterloc2" style="color: #222222;"></select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.specialnoteall.jsp.printer3" text="PRINTER 3" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<select id="moditemkotprinterloc3" style="color: #222222;"></select>
                                            			</td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="additemkotalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.specialnoteall.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:AddItemKOTPrinter()" style="background: #72BB4F;font-weight: bold;width: 25%;"  class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.add" text="Add" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alertmenuitemdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                               
                                            <div id="menuitemdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="location.href='${pageContext.request.contextPath}/menumgnt/loadallspecialnotes.htm'" style="background: #72BB4F;font-weight: bold;width: 25%"  data-dismiss="modal" class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div> 
           <!-- modal ends -->
           
             <!-- 2nd modal  -->
              <div class="modal fade" data-backdrop="static" id="alertmenuitemdataopModal_noaction" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                       <div class="modal-dialog" style="margin: 100px auto;">
                           <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                               <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                  
                                   <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.specialnoteall.jsp.alert" text="Alert!" /></h4>
                               </div>
                               <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                               	<div style="text-align: center;font-size: 20px;">
                      
                                   <div id="menuitemdataopmassagecont_mesg"></div>
                                   </div>
                               </div>
                               <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                   <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  data-dismiss="modal" class="btn btn-success"><spring:message code="admin.specialnoteall.jsp.ok" text="OK" /></button>
                           </div>
                       </div>
                   </div>
               </div>
           <!-- 2nd modal ends -->  
             
           
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script type="text/javascript">
   
      $(':checkbox').on('change',function(){
  		   var th = $(this), name = th.prop('name'); 
  		   if(th.is(':checked')){
  		      $(':checkbox[name="'  + name + '"]').not($(this)).prop('checked',false);   
  		   }
  	   });
    	
   
   
   var BASE_URL="${pageContext.request.contextPath}";
   var vatses='${sessionScope.loggedinStore.vatAmt}';
   var storeId='${sessionScope.loggedinStore.id}';
   var staxses='${sessionScope.loggedinStore.serviceTaxAmt}';
   var selectedspnoteRows = [];
   /* for menu items*/ 
   function shownmenuitemsaddModal()
   {
   	$('#menuitemAddModal').modal('show');
   	$('#menuitemAddModal_add').modal('hide');
   }
   function shownmenuitemsaddModal_add()
   {
	$('#menuitemAddModal').modal('hide');
   	$('#menuitemAddModal_add').modal('show');
   }
  function closenmenuitemsaddModal()
   { 
   	$('#menuitemAddModal').modal('hide');
   	$('#menuitemAddModal_add').modal('hide');
   }
/*    function shownmenuitemseditModal(catid,catname,subcatid,subcatname,id,name,desc,rate,vat,stax,type,spicy,promo,promodesc,promovalue,cookingtime,production,unit,spotDisc)
   {
	   var catselect=document.getElementById('modeditmenucategoryId');
	   var subcatselect=document.getElementById('modeditmenusubcategoryId');
	   var catoption="";
	   var subcatoption="";
	   catoption="<option value='"+catid+"'>"+catname+"</option>";
	   subcatoption="<option value='"+subcatid+"'>"+subcatname+"</option>";
	   catselect.innerHTML=catoption;
	   subcatselect.innerHTML=subcatoption;
	   document.getElementById('modeditmenuitemsId').value=id;
	   document.getElementById('modeditmenuitemsName').value=name;
	   document.getElementById('modeditmenuitemsDesc').value=desc;
	   document.getElementById('modeditmenuitemsPrice').value=rate;
	   document.getElementById('modeditmenuitemsVat').value=vat;
	   document.getElementById('modeditmenuitemsStax').value=stax;
	   if(type=='Y'){document.getElementById('modeditmenuitemsVeg').checked=true;}
	   else{document.getElementById('modeditmenuitemsNonVeg').checked=true;}
	   if(spicy=='Y'){document.getElementById('modeditmenuitemsspicyYes').checked=true;}
	   else{document.getElementById('modeditmenuitemsspicyNo').checked=true;}
	   if(promo=='Y'){
		   document.getElementById('modeditmenuitemspromoYes').checked=true;
		   document.getElementById('modeditmenuitemsPromoDesc').value=promodesc;
		   document.getElementById('modeditmenuitemsPromoValue').value=promovalue;
		   }
	   else{
		   document.getElementById('modeditmenuitemspromoNo').checked=true;
		   document.getElementById('modeditmenuitemsPromoDesc').disabled='true';
		   document.getElementById('modeditmenuitemsPromoValue').disabled='true';
		   //document.getElementById('modeditmenuitemsPromoDesc').value=promodesc;
		  // document.getElementById('modeditmenuitemsPromoValue').value=promovalue;
		   }
	   document.getElementById('modeditmenuitemsCookingTime').value=cookingtime;
	   var prodline="";
	   if(production=='Y')
		   {
		   prodline="<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
		   }
	   else
		   {
		   prodline="<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
		   }
	   document.getElementById('modeditmenuitemsProductionId').innerHTML=prodline;
	   var spotdiscline="";
	   if(spotDisc=='Y')
	   		{
		   spotdiscline="<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
	   		}
   		else
	   		{
   			spotdiscline="<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
	   		}
	   document.getElementById('modeditmenuitemsspotDiscId').innerHTML=spotdiscline;
	   var unitArray=[];
	   var unitoption="";
	   var unitoption1="";
	   <c:forEach items="${fmcgList}" var="fmcg" varStatus="loop">
	   unitArray.push('${fmcg.name}');
       </c:forEach>
       unitoption="<option value='"+unit+"'>"+unit+"</option>";
	   	for(var i=0;i<unitArray.length;i++)
	   		{
	   		if(unitArray[i]!=unit)
	   			{
	   			unitoption1+="<option value='"+unitArray[i]+"'>"+unitArray[i]+"</option>";
	   			}
	   		}
	   var unitoptionfinal=unitoption+unitoption1;
	   document.getElementById('modeditmenuitemsUnit').innerHTML=unitoptionfinal;
	   $('#menuitemEditModal').modal('show');
   } */
   
   function cancleNote() {
	  $(".chk:checked").val();
	  $(".clk:checked").val();
	  $(".chk_add:checked").val();
	  
	   $('.chk').prop('checked', false);
	   $('.clk').prop('checked', false);
	   $('.chk_add').prop('checked', false);
	   
   }
   
  function shownspclitemeditModal()
   {   
	   var removeHash;
	   if($(".chk:checked").length == 1){
	   var id=$(".chk:checked").val();
	   
	   var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/menumgnt/getItemDetailsById/" + id +"/"+ storeId  + ".htm", function(response) {
			var responseObj;
			responseObj=JSON.parse(response);
			
				var name=responseObj.name;
				var desc=responseObj.description;
				var bgColor = responseObj.bgColor;
			
				removeHash = bgColor.replace(/[#@]/g, "");
			// var remobe1st =  string.replace(/^#0+/i, '');	
			       document.getElementById('modeditmenuitemsId').value=id;
				   document.getElementById('modeditmenuitemsName').value=name;
				   document.getElementById('modeditmenuitemsDesc').value=desc;
				   //document.getElementById('modeditmenuitemsbgcolor').value=bgColor;
				  // $('#modeditmenuitemsbgcolor').val(bgColor);
				   //$('#modeditmenuitemsbgcolor').attr('checked');
				  $(":checkbox[value="+removeHash+"]").prop("checked","true");
		}, null);
		
	   $('#menuitemEditModal').modal('show');
	   
	   $(':checkbox').on('change',function(){
		   var th = $(this), name = th.prop('name'); 
		   if(th.is(':checked')){
		      $(':checkbox[name="'  + name + '"]').not($(this)).prop('checked',false);   
		   }
	   });
		   
   }else{
	 	document.getElementById('menuitemdataopmassagecont_mesg').innerHTML= getLang.plsSelectColorOneTime;
		showalertmenuitemdataopModal_noaction();
		}
   }
   function closenmenuitemseditModal()
   { 
   	$('#menuitemEditModal').modal('hide');
   }
   function shownmenuitemsdetailModal(catid,catname,subcatid,subcatname,id,name,desc,rate,vat,stax,type,spicy,promo,promodesc,promovalue,cookingtime,production,unit,spotDisc)
   {
	   document.getElementById('moddetailmenuitemscatnameTd').innerHTML=catname;
	   document.getElementById('moddetailmenuitemssubcatnameTd').innerHTML=subcatname;
	   document.getElementById('moddetailmenuitemsidTd').innerHTML=id;
	   document.getElementById('moddetailmenuitemsnameTd').innerHTML=name;
	   document.getElementById('moddetailmenuitemsdescTd').innerHTML=desc;
	   document.getElementById('moddetailmenuitemspriceTd').innerHTML=parseFloat(rate).toFixed(2);
	   document.getElementById('moddetailmenuitemsvatTd').innerHTML=vat;
	   document.getElementById('moddetailmenuitemsstaxTd').innerHTML=stax;
	   var foodtype;
	   var spicytype;
	   var promotype;
	   var status;
	   var spotdiscstatus;
	   if(type=='Y'){foodtype='VEG';} else {foodtype='NON VEG';}
	   if(spicy=='Y'){spicytype='YES';} else {spicytype='NO';}
	   if(promo=='Y'){promotype='YES';} else {promotype='NO';}
	   if(production=='Y'){status='ENABLE';} else {status='DISABLE';}
	   if(spotDisc=='Y'){spotdiscstatus='ENABLE';} else {spotdiscstatus='DISABLE';}
	   document.getElementById('moddetailmenuitemstypeTd').innerHTML=foodtype;
	   document.getElementById('moddetailmenuitemsspicyTd').innerHTML=spicytype;
	   document.getElementById('moddetailmenuitemspromoTd').innerHTML=promotype;
	   document.getElementById('moddetailmenuitemspromodescTd').innerHTML=promodesc;
	   document.getElementById('moddetailmenuitemspromovalueTd').innerHTML=promovalue;
	   document.getElementById('moddetailmenuitemscookingtimeTd').innerHTML=cookingtime;
	   document.getElementById('moddetailmenuitemsproductionTd').innerHTML=status;
	   document.getElementById('moddetailmenuitemsunitTd').innerHTML=unit;
	   document.getElementById('moddetailmenuitemsspotDiscTd').innerHTML=spotdiscstatus;
	   $('#menuitemsDetailModal').modal('show');
   }
   function showConfirmdeleteMenuItemsModal()
   {
	   if($(".chk:checked").length==1){
	   var id=$(".chk:checked").val();
	   document.getElementById('deletemodmenuitemsId').value=id;
	   $('#confirmdeleteMenuItemsModal').modal('show');
	   }else{
		 	document.getElementById('menuitemdataopmassagecont_mesg').innerHTML= getLang.plsSelectColorOneTime;
			showalertmenuitemdataopModal_noaction();
			}
 	  
   }
   function showalertnoItemFoundModal()
   {
 	   $('#alertnoItemFoundModal').modal('show');
   }
   function showspecialNoteModal()
   {
	   $('#specialnoteModal').modal('show'); 
   }
   function closespecialNoteModal()
   {
	   $('#specialnoteModal').modal('hide'); 
   }
   function showmenuitemkotaddModal()
	{
		$('#menuitemaddkotPrinterModal').modal('show');
	}
	function closemenuitemkotaddModal()
	{
		$('#menuitemaddkotPrinterModal').modal('hide');
	}
	function showalertmenuitemdataopModal()
	{
		$('#alertmenuitemdataopModal').modal('show');
	}
	function showalertmenuitemdataopModal_noaction()
	{
		$('#alertmenuitemdataopModal_noaction').modal('show');
	}
	
		
	
	
   /* end for menu items*/
   </script>
   <script type="text/javascript">
   $(function() {
       $("#itemSearch")
               .autocomplete(
                       {
                           source : function(request, response) {
                               $.ajax({
                                           url : "${pageContext.request.contextPath}/menumgnt/autocomplete.htm",
                                           type : "GET",
                                           data : {
                                               tagName : request.term
                                           },

                                           dataType : "json",

                                           success : function(data) {
                                               response($
                                                       .map(
                                                               data,
                                                               function(v) {

                                                                   return {
                                                                       label : v.name,

                                                                       itemCode : v.id,
                                                                       //tagCode : v.tagCode
                                                                   };

                                                               }));
                                           },
                                           error : function(error) {
                                               alert('error: ' + error);
                                           }
                                       });
                           },
                           select : function(e, ui) {

                              // $("#itemCode").val(ui.item.itemCode);
                               $("#autocompleteItemId").val(ui.item.itemCode);

                           }
                       });
   });
   </script>
   
   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> 
    </c:otherwise>
    </c:choose>
  
</body>
</html>
