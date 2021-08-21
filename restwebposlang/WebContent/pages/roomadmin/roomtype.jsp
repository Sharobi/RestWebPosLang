<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <title>:. POS :: Room Type :.</title>
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
                    <div style="color:#FFF; font-size:16px; font-weight:bold;">
                   <strong> <spring:message code="admin.admleftpanel.jsp.roomtype" text="ROOM TYPE" /></strong>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showrmtypeaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.details" text="DETAILS" /></th>
                                           <%--  <c:if test="${sessionScope.loggedinStore.kotPrintType=='category'}">
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.kotprinter" text="KOT PRINTER" /></th></th>
                                            </c:if> --%>
                                        
                                    </thead>
                                     <tbody>
                                    	<c:if test="${! empty roomtypeList }">
                                    		<c:forEach items="${roomtypeList}" var="roomtype">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${roomtype.id}</td>
                                    				<td>${roomtype.roomType}</td>
                                    				<td align="center"><a href="javascript:showrmtypeeditModal(${roomtype.id},&quot;${roomtype.roomType}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeletermtypeModal(${roomtype.id},&quot;${roomtype.roomType}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailrmtypeModal(${roomtype.id},&quot;${roomtype.roomType}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                            		<%-- <c:if test="${sessionScope.loggedinStore.kotPrintType=='category'}">
                                            		<td align="center"><a href="javascript:showCatKOTPrinterModal(${menucategoy.id},&quot;${menucategoy.menuCategoryName}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_tprinter.png"></a></td>
                                            		</c:if> --%>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty roomtypeList}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="5"><spring:message code="admin.menumgnt.jsp.nodatafound" text="No Data found!" /></td>
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
		
		<!-- modal starts -->
           					<div class="modal fade" data-backdrop="static" id="roomtypeAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.addRoomType" text="Add Room Type" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.roomType" text="ROOM TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addroomtypeContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		
                                            			<%-- <tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.ac" text="AC" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modaddrmacYes" name="modaddrmAC" value="Y">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modaddrmacNo" name="modaddrmAC" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.no" text="NO" />
                                            			</td>
                                            			</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.amount" text="AMOUNT" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addamountContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.size" text="SIZE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addsizeContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.unit" text="UNIT" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addunitContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.description" text="DESCRIPTION" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="adddescriptionContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.tax" text="TAX" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modaddrmtypeTax" onchange=selectTaxValue(this.value) style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty seshoteltaxList}">
                                            					<c:forEach items="${seshoteltaxList}" var="seshoteltaxList">
                                            						<option value="${seshoteltaxList}">${seshoteltaxList}</option>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.percentage" text="PERCENTAGE" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modaddPercentage" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty hotelTaxList}">
                                            					<c:forEach items="${hotelTaxList}" var="hoteltaxlist">
                                            					<c:if test="${hoteltaxlist.isActive=='Y'}">
                                            						<option value="${hoteltaxlist.id}">${hoteltaxlist.id}</option>
                                            						</c:if>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr> --%>
                                            				
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addRoomType()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="roomtypeEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.editRoomType" text="Edit Room Type" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr style="display:none;">
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="modeditroomtypeid"></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.roomType" text="ROOM TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editroomtypeContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		
                                            			<%-- <tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.ac" text="AC" /></td>
                                            			<td>:</td>
                                            			<td>
                                            			<input type="radio" id="modeditrmacYes" name="modeditrmAC" value="Y">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.yes" text="YES" />&nbsp;&nbsp;
                                            			<input type="radio" id="modeditrmacNo" name="modeditrmAC" checked="checked" value="N">&nbsp;&nbsp;<spring:message code="admin.menuitems.jsp.no" text="NO" />
                                            			</td>
                                            			</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.amount" text="AMOUNT" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editamountContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.size" text="SIZE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editsizeContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.unit" text="UNIT" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editunitContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.description" text="DESCRIPTION" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdescriptionContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.tax" text="TAX" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modeditrmtypeTax" onchange=selectTaxValueEdit(this.value) style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty seshoteltaxList}">
                                            					<c:forEach items="${seshoteltaxList}" var="seshoteltaxList">
                                            						<option value="${seshoteltaxList}">${seshoteltaxList}</option>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.rmmgnt.jsp.percentage" text="PERCENTAGE" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="modEditPercentage" style="margin-bottom: 2px;color: #222222;">
                                            					<c:if test="${! empty hotelTaxList}">
                                            					<c:forEach items="${hotelTaxList}" var="hoteltaxlist">
                                            					<c:if test="${hoteltaxlist.isActive=='Y'}">
                                            						<option value="${hoteltaxlist.id}">${hoteltaxlist.id}</option>
                                            						</c:if>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr> --%>
                                            				
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editRoomType()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="roomtypeDetailsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.detailRoomType" text="Room Type Details" /></h4>
                                        </div>
                                      <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 18px;">
                                            	<table>
                                            		
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypeid"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.roomType" text="ROOM TYPE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypename"></td>                                           			
                                            		</tr>
                                            		
                                            		<%-- <tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.ac" text="AC" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypeac"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.amount" text="AMOUNT" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypeamount"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.size" text="SIZE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypesize"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.unit" text="UNIT" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypeunit"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.description" text="DESCRIPTION" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypedesc"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.tax" text="TAX" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypetax"></td>                                          		
                                            		</tr>                                           		
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.rmmgnt.jsp.percentage" text="PERCENTAGE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomtypepercentage"></td>                                         
                                            		</tr> --%>                                            				
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteRoomTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.menumgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteroomtypeid" value="">
                                            	<input type="hidden" id="moddeleteroomtypename" value="">                                       
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteRoomType()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                                                                                  
                            <div class="modal fade" data-backdrop="static" id="alertroomdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="roomtypedataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/rmtypemgnt/loadroomtype.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
		
		
		
	<script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/hotelAdminScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   var storeID="${sessionScope.loggedinStore.id}";	
		
	function showrmtypeaddModal()
   {
	//selectTaxValue($('#modaddrmtypeTax option:selected').text());
   	$('#roomtypeAddModal').modal('show');
   	$('#roomtypeAddModal').on('shown.bs.modal', function () {
	$('#addroomtypeContId').focus();});
   }	

	function showrmtypeeditModal(id,roomType)
	   {
		document.getElementById('modeditroomtypeid').innerHTML = id;
		document.getElementById('editroomtypeContId').value = roomType;
		
		/*  var radios = document.getElementsByName('modeditrmAC');
		    for (var j = 0; j < radios.length; j++) {
		        if (radios[j].value == ac) {
		            radios[j].checked = true;
		            break;
		        }
		    }
		
		document.getElementById('modeditrmtypeTax').value = taxName;	
		document.getElementById('editamountContId').value = roomPrice;
		document.getElementById('editsizeContId').value = roomSize;
		document.getElementById('editunitContId').value = roomSizeUnit;
		document.getElementById('editdescriptionContId').value = roomDesc;
		
		selectTaxValueEdit(taxName,taxPercentage); */
	
		
	   	$('#roomtypeEditModal').modal('show');
	   	$('#roomtypeEditModal').on('shown.bs.modal', function () {
		$('#editroomtypeContId').focus();});
	}	
	
	function showConfirmdeletermtypeModal(id,roomType) 
	{
		document.getElementById('moddeleteroomtypeid').value = id;
		document.getElementById('moddeleteroomtypename').value = roomType;
		
		$('#confirmdeleteRoomTypeModal').modal('show');
	}
	
	
	function showDetailrmtypeModal(id,roomType)
	{
		document.getElementById('moddetailroomtypeid').innerHTML = id;	
		document.getElementById('moddetailroomtypename').innerHTML = roomType;	
		/* document.getElementById('moddetailroomtypeac').innerHTML = ac;	
		document.getElementById('moddetailroomtypeamount').innerHTML = currency + " " + roomPrice;	
		document.getElementById('moddetailroomtypesize').innerHTML = roomSize;	
		document.getElementById('moddetailroomtypeunit').innerHTML = roomSizeUnit;	
		document.getElementById('moddetailroomtypedesc').innerHTML = roomDesc;	
		document.getElementById('moddetailroomtypetax').innerHTML = taxName;	
		document.getElementById('moddetailroomtypepercentage').innerHTML = taxPercentage;	 */
	 
		$('#roomtypeDetailsModal').modal('show');
	}
	
	function showalertroomdataopModal()
	{
		$('#alertroomdataopModal').modal('show');
	}
		
		
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
