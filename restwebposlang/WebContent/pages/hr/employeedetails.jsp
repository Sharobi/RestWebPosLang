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
    <title>:. POS :: Employee Details Management :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/customstyle.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"	rel="stylesheet" />
    
  
    

    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    
    
    <!-- Core files For Using Jalert -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery.alerts.js"></script>
	<link href="${pageContext.request.contextPath}/assets/css/jquery.alerts.css"	rel="stylesheet" />
    
    
    
   <%--  <script src="${pageContext.request.contextPath}/assets/js/jAlert-functions.js"></script> --%>
    <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datepicker.min.js"></script> --%>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datetimepicker.min.js"></script>
    
    
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
                   <strong> <%-- <spring:message code="admin.menumgnt.jsp.categorycuisinetypes" text="DEPARTMENT - TYPES" /> --%> EMPLOYEE DETAILS MANAGEMENT  </strong>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                   <%--  <a href="javascript:shownEmployeedetailaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a> --%>
                    <a href="#" id="addModal" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover" id="allemployeestable">
                                    <thead style="background:#404040; color:#FFF;">
                                              <th style="text-align:center;" class="hide" id="themployeeid">   
                                                    <spring:message code="hr.empdetails.jsp.details" text="EMPLOYEEID" />
                                            </th>   
                                            <th style="text-align:center;"> 
                                                    <spring:message code="hr.empdetails.jsp.name" text="NAME" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                    <spring:message code="hr.empdetails.jsp.presentadd" text="PRESENT ADDRESS" />
                                            </th>
                                            <th style="text-align:center; "> 
                                                    <spring:message code="hr.empdetails.jsp.phoneno" text="PHONE NO" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                    <spring:message code="hr.empdetails.jsp.email" text="EMAIL ID" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                     <spring:message code="hr.empdetails.jsp.edit" text="EDIT" />
                                            </th>
                                            <th style="text-align:center;"> 
                                                     <spring:message code="hr.empdetails.jsp.delete" text="DELETE" />
                                            </th>
                                            <th style="text-align:center;">   
                                                    <spring:message code="hr.empdetails.jsp.details" text="DETAILS" />
                                            </th>  
                                                                                  
                                    </thead>
                                    <tbody id="allemployeestbody">
                                    	<%-- <c:if test="${! empty EmployeeList1 }">
                                    		<c:forEach items="${EmployeeList1}" var="employee">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">   ${employee.type} 
                                    				  </td>
                                    				<td>   ${employee.casualLeave}   
                                    				</td>
                                    				
                                    				<td align="center">   ${employee.sickLeave}  
                                    				  </td>
                                    				<td>  ${employee.miscLeave}    
                                    				</td>
                                    				
                                    				
                                    				
                                           		   <td>
                                                     <c:choose>
                                                        <c:when test="${fn:containsIgnoreCase(dutyshift.name, 'SPECIAL NOTE') }">
                                                        </c:when>
                                                        <c:otherwise>
                                                           <a href="javascript:shownEmployeetypeeditModal(${employee.id},${employee.storeId})"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a>
                                                        </c:otherwise>
                                                     </c:choose>
                                                    </td>
                                           			
                                           			<td align="center">
                                           			   <c:choose>
                                                        <c:when test="${fn:containsIgnoreCase(designation.name, 'SPECIAL NOTE') }">
                                                        </c:when>
                                                        <c:otherwise>
                                                           <a href="javascript:showEmployeetypeDeleteModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a>
                                                        </c:otherwise>
                                                     </c:choose>
                                           			</td>
                                            		<td align="center">
                                            			  <a href="javascript:showDetailEmployeetypeModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a>  
                                            			<a href="javascript:createEmployeeViewDetailsModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> 
                                            		</td> 
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                         <c:if test="${empty dutyShiftList1}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="6"><spring:message code="admin.menumgnt.jsp.nodatafound" text="No Data found!" /></td>
                                        	</tr>
                                        </c:if>  --%>
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
                            <div class="modal fade" data-backdrop="static" id="employeeAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                            </div>
                            
                            
                            <!--edit modal starts -->
                            <div class="modal fade" data-backdrop="static" id="employeeEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                            </div>
           					<%-- <div class="modal fade" data-backdrop="static" id="employeetypeDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.addEmployeeType" text="Add EmployeeType" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                                    
                                                    <tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailCode" text="CODE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addemployeedetailCode" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" />
                                            			     </td>
                                            			<td id="empdetaddErrorcode" style="color:red;font-size:14px">  </td>     
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailName" text="NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addemployeedetailName" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;"/>
                                            			     </td>
                                            			<td id="empdetaddErrorname" style="color:red;font-size:14px">  </td>     
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailpermanent" text="PERMANENT ADDRESS" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text"  id="emppermanentaddress" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrorpermanent" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailpresent" text="PRESENT ADDRESS" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text"  id="emppresentaddress" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<!-- <td id="empdetaddErrorpresent" style="color:red;font-size:14px">  </td> -->
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailmobile" text="MOBILE NO" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number"  id="empmobile" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrormobile" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailmail" text="EMAIL ID" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text"  id="addemployeedetailEmail" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<!-- <td id="empdetaddErrormobile" style="color:red;font-size:14px">  </td> -->
                                            		</tr>
                                            		
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetaildepttype" text="DEPARTMENT TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;">
                                            			 <!--  <select id="addemployeedetailEmptype" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;"> -->
                                            			    <select id="departmentlist" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;">
                                            			   <option value="0" selected>Select a value</option>
                                            			  <c:if test="${! empty departmentList }">
                                    		               <c:forEach items="${departmentList}" var="department"> 
                                    		                   <option value="${department.id}"> ${department.name} </option>
                                    		               </c:forEach>
                                    		               </c:if>
														  </select> </td>
                                            		</tr>
                                            		
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailemptype" text="EMPLOYEE TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;">
                                            			   <!-- getDetailEmployeeType(); -->
                                            			  <!-- <select id="addemployeedetailEmptype" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onchange="myFunction()"> -->
                                            			   <select id="emptype" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;">
                                            			    <option value="0" selected>Select a value</option> 
                                            			  <c:if test="${! empty employeeTypeList }">
                                    		               <c:forEach items="${employeeTypeList}" var="employeeType"> 
                                    		                   <option value="${employeeType.id}"> ${employeeType.type} </option>
                                    		               </c:forEach>
                                    		               </c:if>
														  </select> </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetaildesgtype" text="DESIGNATION TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;">
                                            			   <select id="addemployeedetailDesgtype" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onchange="myFunction1()">
                                            			    <option value="0" selected>Select a value</option>
                                            			    <c:if test="${! empty designationList }">
                                    		               <c:forEach items="${designationList}" var="designation"> 
                                    		                   <option value="${designation.id}"> ${designation.name} </option>
                                    		               </c:forEach>
                                    		               </c:if>
                                    		               </select>
														   </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailcasual" text="CASUAL LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="addemployeedetailCasual" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrorcasual" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailsick" text="SICK LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="addemployeedetailSick" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrorsick" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailearned" text="EARNED LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="addemployeedetailEarned" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrorearned" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailmisc" text="MISC LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="addemployeedetailMisc" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrormisc" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailjoining" text="JOINING DATE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="yyyy-mm-dd"  id="addemployeedetailJoining" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrorjoining" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailLeaving" text="LEAVING DATE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="yyyy-mm-dd"  id="addemployeedetailLeaving" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="empdetaddErrorleaving" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailphoto" text="PHOTO" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="file" id="addemployeedetailPhoto" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<!-- <td id="empdetaddErrorphoto" style="color:red;font-size:14px">  </td> -->
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailidproof" text="ID PROOF" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addemployeedetailIdproof" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<!-- <td id="empdetaddErrorphoto" style="color:red;font-size:14px">  </td> -->
                                            		</tr>
                                            		
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeedetailidproofimage" text="ID PROOF IMAGE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="file" id="addemployeedetailIdproofimage" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<!-- <td id="empdetaddErrorphoto" style="color:red;font-size:14px">  </td> -->
                                            		</tr>
                                            		
                                            		
                                            		
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;" id="createemployeefooter">
                                            <button type="button" onclick="javascript:cancelEmployeetype1()"  style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addEmployeetype()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.create" text="CREATE" /></button>
                                            <button type="button" id="createemployeebutton" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.create" text="CREATE" /></button>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div> --%>
                            
                            <!--add modal end -->
                            
                            <!-- edit modal start -->
                     
                            <div class="modal fade" data-backdrop="static" id="employeetypeEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="hr.designation.jsp.editemployeetype" text="Edit Employeetype" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	<input type="hidden" id="modeditdesignationid" value="">
                                            	<table>
                                            	     <tr style="display:none">
                                            			
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editemployeetypeId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeetypeType" text="TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editemployeetypeType" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorType" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeetypeCasual" text="CASUAL LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="editemployeetypeCasual" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorCasual" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeetypeSick" text="SICK LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="editemployeetypeSick" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorSick" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.employeetypeMisc" text="MISC LEAVE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="editemployeetypeMisc" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="editerrorMisc" style="color:red;font-size:14px">  </td>
                                            		</tr>
                                       		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelEmployeetype()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editEmployeetype()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></button>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- edit modal end -->
                            
                            
                            
                            <!-- delete modal start -->
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteEmployeetypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.menumgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmemployeetypeid" value="">
                                            	<input type="hidden" id="moddeleteconfirmemployeetypstoreid" value="">
                                            	<!-- <input type="hidden" id="moddeleteconfirmcatbgcolorContId" value=""> -->
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="deleteEmployeetype()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <!-- delete modal end -->
                            
                            
                           <!-- Detail Model start -->
                            
                             
                             
                            <div class="modal fade" data-backdrop="static" id="employeetypeDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.desgDetails" text="EmployeeType Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr >
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="employeetypedetailid">  </td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.storeID" text="STORE ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="employeetypestoreid"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.type" text="TYPE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="employeetypedetailtype"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.casual" text="CASUAL LEAVE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="employeetypedetailcasual"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.sick" text="SICK LEAVE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="employeetypedetailsick"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.mics" text="MICS LEAVE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="employeetypedetailmics"></td>
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
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/hrmgnt/viewmemployee.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
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
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

   <script type="text/javascript">
   
   	
   
   var BASE_URL="${pageContext.request.contextPath}";

   var language = '<%= session.getAttribute("language") %>';

   var storeID="${sessionScope.loggedinStore.id}";

   var detmg="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png";
   var deleteimg="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png";
   var editimg="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png";
   var contextpath="${pageContext.request.contextPath}";
   function shownEmployeedetailaddModal()
	{
	 	//alert(" shownEmployeedetailaddModal() FUNCTION IS CALLED");  
	    $("#empaddErrortype").html("");
	    $("#empaddErrorcasual").html("");
	    $("#empaddErrorsick").html("");
	    $("#empaddErrormisc").html(""); 	    
		$('#employeetypeDetailModal').modal('show');
		/* $('#menucatAddModal').on('shown.bs.modal', function () {
	   	$('#addcategorynameContId').focus();}); */
	}
   
   
   
   function closenmenucataddModal()
	{
		$('#menucatAddModal').modal('hide');
	}
   
   
   
   function shownEmployeetypeeditModal(id,storeId)
	{
	    $("#editerrorType").html("");
		$("#editerrorCasual").html("");
		$("#editerrorSick").html("");
		$("#editerrorMisc").html("");
	   var url=BASE_URL + "/hrmgnt/getEmployeeTypesById.htm?storeId="+storeId+"&id="+id;
   	$.ajax({
			url :url,
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
		
			success : function(obj) {
				var employeetyperes=JSON.parse(obj);
				 /* alert("SUCCESS"); 
				 alert("RES IS:"+employeetyperes.id); */
				
				$('#editemployeetypeCasual').val(employeetyperes.casualLeave);
				$('#editemployeetypeSick').val(employeetyperes.sickLeave);
				$('#editemployeetypeMisc').val(employeetyperes.miscLeave);  
				$('#employeetypeEditModal').modal('show');
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
    
    
    function showEmployeetypeDeleteModal(id,storeId) 
   {
    	/* alert("Hi"); */
	   document.getElementById('moddeleteconfirmemployeetypeid').value=id;
	   document.getElementById('moddeleteconfirmemployeetypstoreid').value=storeId;
	   $('#confirmdeleteEmployeetypeModal').modal('show');
   }
   
    function showDetailEmployeetypeModal(id,storeId){
    	 var url=BASE_URL + "/hrmgnt/getEmployeeTypesById.htm?storeId="+storeId+"&id="+id;
    	$.ajax({
			url :url,
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
		
			success : function(obj) {
				var employeetypeDetail=JSON.parse(obj);
				/* alert("SUCCESS"); */
				/* console.log("RES IS:"+res.id); */
				$('#employeetypedetailid').html(employeetypeDetail.id);
				$('#employeetypestoreid').html(employeetypeDetail.storeId);
				$('#employeetypedetailtype').html(employeetypeDetail.type);
				$('#employeetypedetailcasual').html(employeetypeDetail.casualLeave);
				$('#employeetypedetailsick').html(employeetypeDetail.sickLeave);
				$('#employeetypedetailmics').html(employeetypeDetail.miscLeave);
				$('#employeetypeDetailModal').modal('show');
			},
			error:function(error){
				/* alert("ERROR"); */
				console.log("ERROR INSIDE showDetailDutyshiftModal IS");
				console.log(error);
			}
		}); 
		
		
	   
	   /* alert(storeId); */
	   
	   
   } 
   
    
    function getDetailEmployeeType(id,storeId){
   	 var url=BASE_URL + "/hrmgnt/getEmployeeTypesById.htm?storeId="+storeId+"&id="+id;
   	$.ajax({
			url :url,
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
		    async:false,
			success : function(obj) {
				var employeetypeDetail=JSON.parse(obj);
				/* alert("SUCCESS"); */
				/* console.log("RES IS:"+res.id); */
				$('#employeetypedetailid').html(employeetypeDetail.id);
				$('#employeetypestoreid').html(employeetypeDetail.storeId);
				$('#employeetypedetailtype').html(employeetypeDetail.type);
				$('#employeetypedetailcasual').html(employeetypeDetail.casualLeave);
				$('#employeetypedetailsick').html(employeetypeDetail.sickLeave);
				$('#employeetypedetailmics').html(employeetypeDetail.miscLeave);
				$('#employeetypeDetailModal').modal('show');
			},
			error:function(error){
				/* alert("ERROR"); */
				console.log("ERROR INSIDE showDetailDutyshiftModal IS");
				console.log(error);
			}
		}); 
		
		
	   
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
  
  function addDesignation(){
	  alert("Hi");
	  
  } 
  
  function myFunction1() {
	   alert("Hi");
	   alert($("#addemployeedetailDesgtype").val());
	   alert(storeID);
 }
  
  
  $('#addemployeedetailJoining').datepicker({
		format : "yyyy-mm-dd",
		autoclose : true
	});
  
  
  /* $('#addemployeedetailLeaving').datepicker({
		format : "yyyy-mm-dd",
		autoclose : true
	}); */
  
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
