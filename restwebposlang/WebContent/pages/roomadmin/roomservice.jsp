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
    <title>:. POS :: Room Service :.</title>
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
                   <strong> <spring:message code="admin.admleftpanel.jsp.roomservices" text="ROOM SERVICES" /></strong>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showrmservicesaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="order.jsp.SL" text="SL" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="rb.roomadmin.roomservice.servicerate" text="SERVICE RATE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.details" text="DETAILS" /></th>
                                           
                                        
                                    </thead>
                                  <tbody>
                                    	<c:if test="${! empty roomservicesList }">
                                    		<c:forEach items="${roomservicesList}" var="roomservicesList" varStatus="loop">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${loop.index+1}</td>
                                    				<td>${roomservicesList.name}</td>
                                    				<td>${roomservicesList.rate}</td>
                                    				<td align="center"><a href="javascript:shownrmserviceseditModal(${roomservicesList.id},&quot;${roomservicesList.name}&quot;,&quot;${roomservicesList.description}&quot;,${roomservicesList.rate},${roomservicesList.isTaxable},${roomservicesList.taxRate},${roomservicesList.isServiceChargable},${roomservicesList.serviceChargeRate})"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeleteRoomServicesModal(${roomservicesList.id},&quot;${roomservicesList.name}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailRoomServicesModal(${roomservicesList.id},&quot;${roomservicesList.name}&quot;,&quot;${roomservicesList.description}&quot;,${roomservicesList.rate},${roomservicesList.isTaxable},${roomservicesList.taxRate},${roomservicesList.isServiceChargable},${roomservicesList.serviceChargeRate})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                            		
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty roomservicesList}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="6"><spring:message code="admin.menumgnt.jsp.nodatafound" text="No Data found!" /></td>
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
		
		<div class="modal fade" data-backdrop="static" id="roomservicesAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.roombooking.menumgnt.jsp.addRoomServices" text="Add Room Service" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.roomServices" text="ROOM SERVICE" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addroomservicesContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.invtypemgnt.jsp.description" text="DESCRIPTION" /></td>
                                            			<td>:</td>
                                            			
                                            			<td style="margin-bottom: 3px;"><textarea id="addroomservicesDescripton" rows="2" style="margin-bottom: 3px;color: #222222;width: 95%;"></textarea></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="rb.roomadmin.roomservice.servicerate" text="SERVICE RATE" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addroomservicesRate" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                		                             
                		                             <tr>
														<td><spring:message code="admin.simpleinvitemmgnt.jsp.tax" text="TAX" /><span style="color: #ff0000;">*</span></td>
														<td>:</td>
														<td><select id="addroomservicesIsTax" style="margin-bottom: 5px; color: #222222;" onchange="managetaxdiv(this.value);">
														        <%-- <option value="SELECT"><spring:message code="admin.simpleinvitemmgnt.jsp.select" text="SELECT" /></option> --%>
																<option value="0"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
																<option value="1"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
																
														</select></td>
													</tr>
													<tr id="taxperctr" style="display:none;"> 
														<td><spring:message code="admin.simpleinvitemmgnt.jsp.taxperc" text="TAX(%)"/></td> 
														<td>:</td> 
				 									    <td><input type="text" id="addroomservicesTaxRate" style="text-align: left; width: 41%; color: #222222; margin-bottom: 5px;" /></td>
													</tr>
													 <tr style="display:none;">
														<td><spring:message code="rb.roomadmin.roomservice.servicecharge" text="SERVICE CHARGE" /></td>
														<td>:</td>
														<td><select id="addroomservicesIsSChrge" style="margin-bottom: 5px; color: #222222;" onchange="manageschargediv(this.value);">
														        <%-- <option value="SELECT"><spring:message code="admin.simpleinvitemmgnt.jsp.select" text="SELECT" /></option> --%>
														        <option value="0"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
																<option value="1"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
																
														</select></td>
													</tr>
													<tr id="schargeperctr" style="display:none;"> 
														<td><spring:message code="rb.roomadmin.roomservice.servicechargerate" text="SERVICE CHARGE(%)"/></td> 
														<td>:</td> 
				 									    <td><input type="text" id="addroomservicesSChargeRate" style="text-align: left; width: 41%; color: #222222; margin-bottom: 5px;" /></td>
													</tr>
													
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addRoomServices()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            
                            <div class="modal fade" data-backdrop="static" id="roomservicesEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.roombooking.menumgnt.jsp.editRoomServices" text="Edit Room Service" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	  <input type="hidden" id="modeditroomservicesidContId" value="">
                                        	
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.roomServices" text="ROOM SERVICE" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editroomservicesContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.invtypemgnt.jsp.description" text="DESCRIPTION" /></td>
                                            			<td>:</td>
                                            			
                                            			<td style="margin-bottom: 3px;"><textarea id="editroomservicesDescripton" rows="2" style="margin-bottom: 3px;color: #222222;width: 95%;"></textarea></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="rb.roomadmin.roomservice.servicerate" text="SERVICE RATE" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editroomservicesRate" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                		                             
                		                             <tr>
														<td><spring:message code="admin.simpleinvitemmgnt.jsp.tax" text="TAX" /><span style="color: #ff0000;">*</span></td>
														<td>:</td>
														<td><select id="editroomservicesIsTax" style="margin-bottom: 5px; color: #222222;" onchange="managetaxdivedit(this.value);">
														        <%-- <option value="SELECT"><spring:message code="admin.simpleinvitemmgnt.jsp.select" text="SELECT" /></option> --%>
																<option value="0"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
																<option value="1"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
																
														</select></td>
													</tr>
													<tr id="edittaxperctr" style="display:none;"> 
														<td><spring:message code="admin.simpleinvitemmgnt.jsp.taxperc" text="TAX(%)"/></td> 
														<td>:</td> 
				 									    <td><input type="text" id="editroomservicesTaxRate" style="text-align: left; width: 41%; color: #222222; margin-bottom: 5px;" /></td>
													</tr>
													 <tr style="display:none;">
														<td><spring:message code="rb.roomadmin.roomservice.servicecharge" text="SERVICE CHARGE" /></td>
														<td>:</td>
														<td><select id="editroomservicesIsSChrge" style="margin-bottom: 5px; color: #222222;" onchange="manageschargedivedit(this.value);">
														        <%-- <option value="SELECT"><spring:message code="admin.simpleinvitemmgnt.jsp.select" text="SELECT" /></option> --%>
														        <option value="0"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
																<option value="1"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
																
														</select></td>
													</tr>
													<tr id="editschargeperctr" style="display:none;"> 
														<td><spring:message code="rb.roomadmin.roomservice.servicechargerate" text="SERVICE CHARGE(%)"/></td> 
														<td>:</td> 
				 									    <td><input type="text" id="editroomservicesSChargeRate" style="text-align: left; width: 41%; color: #222222; margin-bottom: 5px;" /></td>
													</tr>
                                            		
                                            			
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editRoomServices()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.update" text="UPDATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
		
							<div class="modal fade" data-backdrop="static" id="roomservicesDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="rb.roomadmin.roomservice.details" text="Room Service Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            	
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.roomServices" text="ROOM SERVICE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.invtypemgnt.jsp.description" text="DESCRIPTION" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesDescTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="rb.roomadmin.roomservice.servicerate" text="SERVICE RATE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesRateTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.simpleinvitemmgnt.jsp.tax" text="TAX" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesIsTaxTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.simpleinvitemmgnt.jsp.taxperc" text="TAX(%)"/></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesTaxRateTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="rb.roomadmin.roomservice.servicecharge" text="SERVICE CHARGE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesSCgargeTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="rb.roomadmin.roomservice.servicechargerate" text="SERVICE CHARGE(%)"/></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailroomservicesSCgargeAmtTd"></td>
                                            		</tr>
                                            	
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
		
		
		<div class="modal fade" data-backdrop="static" id="confirmdeleterRoomServicesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.menumgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmroomservicesidContId" value="">
                                            	<input type="hidden" id="moddeleteconfirmroomservicesContId" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteRoomServices()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
		<div class="modal fade" data-backdrop="static" id="alertroomservicesdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="roomservicesdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/rmservicemgnt/loadroomservices.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
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
		
		
   function managetaxdiv(value){ //added new
		if(value == '1'){
			document.getElementById("taxperctr").style.display = "table-row";
			
			
		}
		else{
			document.getElementById("taxperctr").style.display = "none";
			document.getElementById("addroomservicesTaxRate").value = "0.0";
		}
		
		
	}  
   
   
   function manageschargediv(value){ //added new
		if(value == '1'){
			document.getElementById("schargeperctr").style.display = "table-row";
			
			
		}
		else{
			document.getElementById("schargeperctr").style.display = "none";
			document.getElementById("addroomservicesSChargeRate").value = "0.0";
		}
		
		
	}  
   
   function managetaxdivedit(value){ //added new
		if(value == '1'){
			document.getElementById("edittaxperctr").style.display = "table-row";
			
			
		}
		else{
			document.getElementById("edittaxperctr").style.display = "none";
			document.getElementById("editroomservicesTaxRate").value = "0.0";
		}
		
		
	}  
   
   function manageschargedivedit(value){ //added new
		if(value == '1'){
			document.getElementById("editschargeperctr").style.display = "table-row";
			
			
		}
		else{
			document.getElementById("editschargeperctr").style.display = "none";
			document.getElementById("editroomservicesSChargeRate").value = "0.0";
		}
		
		
	}  
   
   
   
   
   
   
   
   
	
	function showrmservicesaddModal()
   {
	document.getElementById('addalertMsg').innerHTML = '';
   	$('#roomservicesAddModal').modal('show');
   	$('#roomservicesAddModal').on('shown.bs.modal', function () {
	$('#addroomservicesContId').focus();});
   }
	
	function closermservicesaddModal()
	{
		$('#roomservicesAddModal').modal('hide');
	}
	
	   function shownrmserviceseditModal(id,roomService,description,rate,isTaxable,taxRate,isServiceChargable,serviceChargeRate)
	   {//modeditroomidContId
		   document.getElementById('editalertMsg').innerHTML = '';
		   document.getElementById('modeditroomservicesidContId').value=id;
		   document.getElementById('editroomservicesContId').value=roomService;
		   document.getElementById('editroomservicesDescripton').value=description;
		   document.getElementById('editroomservicesRate').value=rate;
		   document.getElementById('editroomservicesIsTax').value=isTaxable;
		   document.getElementById('editroomservicesTaxRate').value=taxRate;
		   document.getElementById('editroomservicesIsSChrge').value=isServiceChargable;
		   document.getElementById('editroomservicesSChargeRate').value=serviceChargeRate;
		  
		   if(isTaxable == '1'){
				document.getElementById("edittaxperctr").style.display = "table-row";
			}
			else{
				document.getElementById("edittaxperctr").style.display = "none";
			}
		   
		   if(isServiceChargable == '1'){
				document.getElementById("editschargeperctr").style.display = "table-row";
			}
			else{
				document.getElementById("editschargeperctr").style.display = "none";
			}
		  
           $('#roomservicesEditModal').modal('show');
	   }
	   
	   function closermserviceseditModal()
	   {
		   $('#roomservicesEditModal').modal('hide');
	   }
   
	   function showDetailRoomServicesModal(id,roomService,description,rate,isTaxable,taxRate,isServiceChargable,serviceChargeRate)
	   {
		   document.getElementById('moddetailroomservicesidTd').innerHTML=id;
		   document.getElementById('moddetailroomservicesTd').innerHTML=roomService;
		   document.getElementById('moddetailroomservicesDescTd').innerHTML=description;
		   document.getElementById('moddetailroomservicesRateTd').innerHTML=rate;
		   if(isTaxable == "1"){isTaxable="Y";}else{isTaxable="N";}
		   if(isServiceChargable == "1"){isServiceChargable="Y";}else{isServiceChargable="N";}
		   document.getElementById('moddetailroomservicesIsTaxTd').innerHTML=isTaxable;
		   document.getElementById('moddetailroomservicesTaxRateTd').innerHTML=taxRate;
		   document.getElementById('moddetailroomservicesSCgargeTd').innerHTML=isServiceChargable;
		   document.getElementById('moddetailroomservicesSCgargeAmtTd').innerHTML=serviceChargeRate;
		   $('#roomservicesDetailModal').modal('show');
	   }
   
	   function showConfirmdeleteRoomServicesModal(id,roomService)
	   {
		   
		   document.getElementById('moddeleteconfirmroomservicesidContId').value=id; 
		   document.getElementById('moddeleteconfirmroomservicesContId').value=roomService;
		   //document.getElementById('moddeleteconfirmfloorContId').value=floor;
		   $('#confirmdeleterRoomServicesModal').modal('show');
	   }
	   
	   function closeConfirmdeleteRoomServicesModal()
	   {
		   $('#confirmdeleterRoomServicesModal').modal('hide');

	   }
	 
	   function showalertrmservicesdataopModal()
		{
			$('#alertroomservicesdataopModal').modal('show');
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