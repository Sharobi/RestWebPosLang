<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: DutyShift Management :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/customstyle.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    
    
    
     <%-- <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script> --%>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datepicker.min.js"></script> --%>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datetimepicker.min.js"></script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    
   <%--  <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script> --%>
      <!-- <link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.css"> -->
      <!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
      <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css">  -->
     <!--  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker-standalone.css">  -->
      <!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js"></script>
 -->
   
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  <%--  <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/adminScript_ar.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script> 
    </c:otherwise>
</c:choose>  --%>  
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"/>
<script src="${pageContext.request.contextPath}/assets/js/dutyshift/dutyshift.js"></script> --%>
<style>
.ui-timepicker-standard{
z-index:9999!important
}
</style>
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
                   <strong> <%-- <spring:message code="admin.menumgnt.jsp.categorycuisinetypes" text="DEPARTMENT - TYPES" /> --%> DUTYSHIFT MANAGEMENT  </strong>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showndutyshiftaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"> 
                                                    <spring:message code="hr.designation.jsp.startname" text="START TIME" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                    <spring:message code="hr.designation.jsp.endtime" text="END TIME" />
                                            </th>
                                            <th style="text-align:center; "> 
                                                    <spring:message code="hr.designation.jsp.shiftno" text="SHIFT NO" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                    <spring:message code="hr.designation.jsp.shiftname" text="SHIFT NAME" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                     <spring:message code="hr.designation.jsp.edit" text="EDIT" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                     <spring:message code="hr.designation.jsp.delete" text="DELETE" />
                                            </th>
                                            <th style="text-align:center;">   
                                                    <spring:message code="hr.designation.jsp.details" text="DETAILS" />
                                            </th>                                        
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty dutyShiftList }">
                                    		<c:forEach items="${dutyShiftList}" var="dutyshift">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">   ${dutyshift.fromTime} 
                                    				  </td>
                                    				<td>  ${dutyshift.toTime}   
                                    				</td>
                                    				
                                    				<td align="center">   ${dutyshift.shiftingNo} 
                                    				  </td>
                                    				<td>  ${dutyshift.shiftName}   
                                    				</td>
                                    				
                                    				
                                    				<%-- <td align="center"><a href="javascript:shownmenucateditModal(${menucategoy.id},&quot;${menucategoy.menuCategoryName}&quot;,&quot;${menucategoy.bgColor}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td> --%>
                                           			<td>
                                                     <%-- <c:choose>
                                                        <c:when test="${fn:containsIgnoreCase(dutyshift.name, 'SPECIAL NOTE') }">
                                                        </c:when>
                                                        <c:otherwise> --%>
                                                           <a href="javascript:showndutyshifteditModal(${dutyshift.id},${dutyshift.storeId})"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a>
                                                        <%-- </c:otherwise>
                                                     </c:choose> --%>
                                                    </td>
                                           			
                                           			<td align="center">
                                           			   <%-- <c:choose>
                                                        <c:when test="${fn:containsIgnoreCase(designation.name, 'SPECIAL NOTE') }">
                                                        </c:when>
                                                        <c:otherwise> --%>
                                                           <a href="javascript:showDutyshiftDeleteModal(${dutyshift.id},${dutyshift.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a>
                                                        <%-- </c:otherwise>
                                                     </c:choose> --%>
                                           			</td>
                                            		<td align="center">
                                            			<a href="javascript:showDetailDutyshiftModal(${dutyshift.id},${dutyshift.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> 
                                            			<%-- <a href="javascript:showDetailDutyshiftModal(${dutyshift.id},&quot;${dutyshift.storeId}&quot;${dutyshift.fromTime}&quot;${dutyshift.toTime}&quot;${dutyshift.shiftingNo}&quot;${dutyshift.shiftName}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> --%>
                                            		</td>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty dutyShiftList}">
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
           <!--add modal starts -->
           					<div class="modal fade" data-backdrop="static" id="dutyshiftAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.addDutyshift" text="Add DutyShift" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftStarttime" text="START TIME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="HH:MM" id="adddutyshiftStarttime" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onchange="expiryCalculation($(this).val(),$('#purorderid').val(),$('#itemid').val());" />
                                            			     </td>
                                            			<td id="errorstarttime" style="color:red;font-size:14px">  </td>     
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftEndtime" text="END TIME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="HH:MM" id="adddutyshiftEndtime" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="errorendtime" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftNO" text="SHIFT NO" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" id="adddutyshiftNo" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="errorshiftno" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftName" text="SHIFT NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="adddutyshiftName" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="errorshiftname" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelDutyshift1()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addDutyshift()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.create" text="CREATE" /></button>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!--add modal end -->
                            
                            <!-- edit modal start -->
                            
                            <div class="modal fade" data-backdrop="static" id="menucatEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="hr.designation.jsp.editdesignation" text="Edit DutyShift" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	<input type="hidden" id="modeditdesignationid" value="">
                                            	<table>
                                            	     <tr style="display:none">
                                            			
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdutyshiftId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftStarttime" text="START NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdutyshiftStarttime" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorstarttime" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftEndtime" text="END NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdutyshiftEndtime" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorendtime" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftShiftno" text="SHIFT NO" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" id="editdutyshiftShiftno" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorshiftno" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.dutyshiftShiftname" text="SHIFT NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdutyshiftShiftname" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorshiftname" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                       		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelDutyshift()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editDutyshift()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></button>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- edit modal end -->
                            
                            
                            <!-- delete modal start -->
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteDutyshiftModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.menumgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmdutyshiftid" value="">
                                            	<input type="hidden" id="moddeleteconfirmdutyshiftstoreid" value="">
                                            	<!-- <input type="hidden" id="moddeleteconfirmcatbgcolorContId" value=""> -->
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="deleteDutyshift()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <!-- delete modal end -->
                            
                            
                           <!-- Detail Model start -->
                            
                            
                            <div class="modal fade" data-backdrop="static" id="dutyshiftDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.desgDetails" text="DutyShift Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr >
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="dutyshiftdetailid">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.storeID" text="STORE ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="dutyshiftdetailstoreid"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.fromtime" text="FORM TIME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="dutyshiftdetailfromtime"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.totime" text="TO TIME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="dutyshiftdetailtotime"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.shiftingNo" text="SHIFTING NO" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="dutyshiftdetailshiftingNo"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.shiftName" text="SHIFT NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="dutyshiftdetailshiftName"></td>
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
                            
                            
                            <!-- Detail Modal End -->
                            
                            <div class="modal fade" data-backdrop="static" id="menucataddkotPrinterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.addKotPrinter" text="Add KOT Printer" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="modcatkotcatidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.categoryName" text="CATEGORY NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="modcatkotcatnameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.printerLocation" text="PRINTER LOCATION" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<select id="modcatkotprinterloc" style="color: #222222;width:95%;"></select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.printerName" text="PRINTER NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<input type="text" id="modcatkotprintername" style="text-align:center; width:95%; color: #222222" />
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.kitchenName" text="KITCHEN NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<input type="text" id="modcatkotkitchenname" style="text-align:center; width:95%; color: #222222" />
                                            			</td>
                                            		</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addcatkotalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:AddCatKOTPrinter()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alertcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="catdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/hrmgnt/viewmdutyshift.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
           <!-- modal ends -->
           
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
   <script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
   
   <!-- <script src="https://raw.githubusercontent.com/smalot/bootstrap-datetimepicker/master/js/bootstrap-datetimepicker.min.js"></script> -->

   <script type="text/javascript">
    /* $("#adddutyshiftStarttimeHour").focusout(function(){
	   var i = $("#adddutyshiftStarttimeHour").val();
	   if(i<10) {
		   var l = "0"+i;
		   $("#adddutyshiftStarttimeHour").val(l);
	   }
	   alert(i);
   });
		   
		   $("#adddutyshiftStarttimeHour").change(function(){	
			   alert("Hi");
		   })   */ 
		   
		   $(document).ready(function(){
			    $('#adddutyshiftStarttime').timepicker({
			    	timeFormat:"HH:mm"
			    });
			    $("#adddutyshiftEndtime").timepicker({
			    	timeFormat:"HH:mm"
			    });
			    $("#editdutyshiftStarttime").timepicker({
			    	timeFormat:"HH:mm"
			    });
			    $("#editdutyshiftEndtime").timepicker({
			    	timeFormat:"HH:mm"
			    });
			});
   
		   
		
   
   var BASE_URL="${pageContext.request.contextPath}";

   var language = '<%= session.getAttribute("language") %>';

   var storeID="${sessionScope.loggedinStore.id}";

   
   function showndutyshiftaddModal()
	{
	    $("#errorstarttime").html("");
	    $("#errorendtime").html("");
	    $("#errorshiftno").html("");
	    $("#errorshiftname").html("");
	    
		$('#dutyshiftAddModal').modal('show');
		$('#menucatAddModal').on('shown.bs.modal', function () {
	   	$('#addcategorynameContId').focus();});
	}
   function closenmenucataddModal()
	{
		$('#menucatAddModal').modal('hide');
	}
   function showndutyshifteditModal(id,storeId)
	{
		$("#editerrorstarttime").html("");
		$("#editerrorendtime").html("");
		$("#editerrorshiftno").html("");
		$("#editerrorshiftname").html("");
	   var url=BASE_URL + "/hrmgnt/getDutyShiftsById.htm?storeId="+storeId+"&id="+id;
   	$.ajax({
			url :url,
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
		
			success : function(obj) {
				var dutyDetailres=JSON.parse(obj);
				/*  alert("SUCCESS"); 
				 console.log("RES IS:"+dutyDetailres.id); */
				
				 $('#editdutyshiftId').val(dutyDetailres.id); 
				$('#editdutyshiftStarttime').val(dutyDetailres.fromTime);
				$('#editdutyshiftEndtime').val(dutyDetailres.toTime);
				$('#editdutyshiftShiftno').val(dutyDetailres.shiftingNo);
				$('#editdutyshiftShiftname').val(dutyDetailres.shiftName); 
				$('#menucatEditModal').modal('show');
			},
			error:function(error){
				/* alert("ERROR"); */
				console.log("ERROR INSIDE showDetailDutyshiftModal IS");
				console.log(error);
			}
   	    });
	
	   	/* document.getElementById('modeditdesignationid').value=id;
	   	document.getElementById('editdesignationname').value=name; */
	
		
	}
    function closenmenucateditModal()
	{
		$('#menucatEditModal').modal('hide');
	} 
    function showDutyshiftDeleteModal(id,storeId) 
   {
    	/* alert("Hi"); */
	   document.getElementById('moddeleteconfirmdutyshiftid').value=id;
	   document.getElementById('moddeleteconfirmdutyshiftstoreid').value=storeId;
	   $('#confirmdeleteDutyshiftModal').modal('show');
   }
   
    function showDetailDutyshiftModal(id,storeId){
    	
    	 var url=BASE_URL + "/hrmgnt/getDutyShiftsById.htm?storeId="+storeId+"&id="+id;
    	$.ajax({
			url :url,
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
		
			success : function(obj) {
				var dutyDetailres=JSON.parse(obj);
				/* alert("SUCCESS"); */
				/* console.log("RES IS:"+res.id); */
				$('#dutyshiftdetailid').html(dutyDetailres.id);
				$('#dutyshiftdetailstoreid').html(dutyDetailres.storeId);
				$('#dutyshiftdetailfromtime').html(dutyDetailres.fromTime);
				$('#dutyshiftdetailtotime').html(dutyDetailres.toTime);
				$('#dutyshiftdetailshiftingNo').html(dutyDetailres.shiftingNo);
				$('#dutyshiftdetailshiftName').html(dutyDetailres.shiftName);

			},
			error:function(error){
				/* alert("ERROR"); */
				console.log("ERROR INSIDE showDetailDutyshiftModal IS");
				console.log(error);
			}
		}); 
		
		
	   $('#dutyshiftDetailModal').modal('show');
	   /* alert(storeId); */
	   
	   
   } 
   
   
   function showmenucatkotaddModal()
	{
		$('#menucataddkotPrinterModal').modal('show');
	}
  function closemenucatkotaddModal()
	{
		$('#menucataddkotPrinterModal').modal('hide');
	}
  function showalertcatdataopModal()
	{
		$('#alertcatdataopModal').modal('show');
	}
  
   </script>	   
  <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> 
     <script src="${pageContext.request.contextPath}/assets/js/hradminScript.js"></script>
    </c:otherwise>
    </c:choose>

  
</body>
</html>