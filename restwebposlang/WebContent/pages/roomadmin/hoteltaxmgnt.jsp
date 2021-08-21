<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>:. POS :: Hotel Tax Setup :.</title>
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
                   <strong> <spring:message code="admin.menumgnt.jsp.hoteltaxsetup" text="HOTEL TAX SETUP" /></strong>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showhoteltaxSetupaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.percentage" text="PERCENTAGE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.details" text="DETAILS" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.status" text="STATUS" /></th></th>
                                              
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty hoteltaxlist }">
                                    		<c:forEach items="${hoteltaxlist}" var="tax">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${tax.id}</td>
                                    				<td align="center">${tax.name}</td>
                                    				<td align="center"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${tax.percentage}"/></td>
                                    				<td align="center"><a href="javascript:showHotelTaxEditModal(${tax.id},&quot;${tax.name}&quot;,&quot;${tax.percentage}&quot;,&quot;${tax.isActive}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           		<td align="center"><a href="javascript:showConfirmDeleteHotelTaxModal(${tax.id},&quot;${tax.name}&quot;,&quot;${tax.percentage}&quot;,&quot;${tax.isActive}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailHotelTaxModal(${tax.id},&quot;${tax.name}&quot;,&quot;${tax.percentage}&quot;,&quot;${tax.isActive}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>                             
                                            		<c:if test="${fn:containsIgnoreCase(tax.isActive, 'Y') }">
                                            			<td align="center">ENABLE</td>                        
                                    				</c:if>
                                    				<c:if test="${fn:containsIgnoreCase(tax.isActive, 'N') }">
                                            			<td align="center">DISABLE</td>                        
                                    				</c:if>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty hoteltaxlist}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="5"><spring:message code="admin.menumgnt.jsp.nodatafound" text="No Data found!" /></td>
                                        	</tr>
                                        	</c:if>
                                        	<c:if test="${sessionScope.loggedinStore.countryId=='0'}">
                                        	<script>   
                                        	$(function () {
                                        		
                                        		 document.getElementById('countrylinkdataopmassagecont').innerHTML = "Link Hotel with Country First !!";
                                        		  $('#alertCountryLinkDataopModal').modal('show');
                                        	   });
										</script>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
           </div>
                	
            </div>
           <!-- modal starts -->
           					<div class="modal fade" data-backdrop="static" id="hoteltaxAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 20px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.addTax" text="ADD TAX" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 18px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.taxName" text="TAX NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="modaddhoteltaxname" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onkeypress='return lettersOnly(event)'/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.percentage" text="TAX PERCENTAGE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="modaddhoteltaxpercentage" style="text-align:center; width:95%; color: #222222" onkeypress='return isNumberKey(event)'/></td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelHotelTax()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addHotelTax()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="hoteltaxEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 20px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.editTax" text="EDIT TAX" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 18px;">
                                        	<input type="hidden" id="modedithoteltaxid" value="">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.taxName" text="TAX NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="modedithoteltaxname" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onkeypress='return lettersOnly(event)'/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.percentage" text="TAX PERCENTAGE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="modedithoteltaxpercentage" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.menumgnt.jsp.status" text="TAX STATUS" /></td>
                                            			<td>:</td>
                                            			<td><select id="modedithoteltaxstatus" style="text-align:center; color: #222222;">
													</select>
													</td>
												</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editHotelTax()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteHotelTaxModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.menumgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeletehoteltaxid" value="">
                                            	<input type="hidden" id="moddeletehoteltaxname" value="">
                                            	<input type="hidden" id="moddeletehoteltaxpercentage" value="">
                                            	<input type="hidden" id="moddeletehoteltaxstatus" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteHotelTax()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="hoteltaxDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 20px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.taxDetails" text="TAX DETAILS" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 18px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.taxid" text="TAX ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailhoteltaxid"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.taxName" text="TAX NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailhoteltaxname"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.percentage" text="TAX PERCENTAGE" />&nbsp;&nbsp;</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailhoteltaxpercentage"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.menumgnt.jsp.status" text="TAX STATUS" />&nbsp;&nbsp;</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailhoteltaxstatus"></td>
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
                                                    
                            <div class="modal fade" data-backdrop="static" id="alertHotelTaxDataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
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
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/hoteltaxmgnt/viewhoteltaxmgnt.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                             <div class="modal fade" data-backdrop="static" id="alertCountryLinkDataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="countrylinkdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/countrymgnt/viewcountryhotelmgnt.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
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

   var language = '<%= session.getAttribute("language") %>';

   var storeID="${sessionScope.loggedinStore.id}";
   
   function showhoteltaxSetupaddModal()
	{
		$('#hoteltaxAddModal').modal('show');
		$('#hoteltaxAddModal').on('shown.bs.modal', function () {
	   	$('#modaddhoteltaxid').focus();});
	}
   function cancelHotelTax()
	{
	   $('#modaddhoteltaxpercentage').val('');
	   $('#modaddhoteltaxname').val('');
		$('#hoteltaxAddModal').modal('hide');
	}
   function showHotelTaxEditModal(id,name,percentage,status)
	{
	  
	   	document.getElementById('modedithoteltaxid').value=id;
	   	document.getElementById('modedithoteltaxname').value=name;
	   	document.getElementById('modedithoteltaxpercentage').value=percentage;
	   	var taxStatus = "";
	   	if (status == 'Y') {
	   		taxStatus = "<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
		   } else {
			taxStatus = "<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
		   }
		   document.getElementById('modedithoteltaxstatus').innerHTML = taxStatus;
		   
		$('#hoteltaxEditModal').modal('show');
	}
   
   function showConfirmDeleteHotelTaxModal(id,name,percentage,status)
   {
	 
	   document.getElementById('moddeletehoteltaxid').value=id;
	   document.getElementById('moddeletehoteltaxname').value=name;
	   document.getElementById('moddeletehoteltaxpercentage').value=percentage;
	   var taxStatus = "";
	   	if (status == 'N') {
	   		taxStatus = "DISABLE";
		   } else {
			taxStatus = "ENABLE";
		   }
		   document.getElementById('moddeletehoteltaxstatus').innerHTML = taxStatus;
	   $('#confirmdeleteHotelTaxModal').modal('show');
   }
   function showDetailHotelTaxModal(id,name,percentage,status)
   {
	   document.getElementById('moddetailhoteltaxid').innerHTML=id;
	   document.getElementById('moddetailhoteltaxname').innerHTML=name;
	   document.getElementById('moddetailhoteltaxpercentage').innerHTML=percentage;
	   
	   var taxStatus = "";
	   	if (status == 'N') {
	   		taxStatus = "DISABLE";
		   } else {
			taxStatus = "ENABLE";
		   }
		   document.getElementById('moddetailhoteltaxstatus').innerHTML = taxStatus;
	   $('#hoteltaxDetailModal').modal('show');
	   
   }
  function showalertcatdataopModal()
	{
		$('#alertHotelTaxDataopModal').modal('show');
	}

	function isNumberKey(evt){
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	   
	    if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
	        return false;
	    return true;
	}
	
	function lettersOnly(evt) {
	       evt = (evt) ? evt : event;
	       var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
	          ((evt.which) ? evt.which : 0));
	      // alert(charCode);
	    
	       if (charCode > 31 && charCode != 32 && (charCode < 65 || charCode > 90) &&
	          (charCode < 97 || charCode > 122)) {
	         // alert("Enter letters only.");
	          return false;
	       }
	       return true;
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
</html>