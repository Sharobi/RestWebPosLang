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
    <title>:. POS :: Employee Leave Details :.</title>
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
    
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    
    
    
   
<!-- <style>
.ui-timepicker-standard{
z-index:9999!important
}
</style> -->
</head>
<body>
  
    <%-- <jsp:include page="/pages/common/header.jsp"></jsp:include> --%>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
          <%--  <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>   --%>
            <jsp:include page="/pages/hr/hrmodules.jsp"></jsp:include>  
           
         <div class="col-md-10 col-sm-10">
					<div class="col-md-12 col-sm-12" align="center">
						
							<div id="content" align="center">
							
							 <table class="table table-striped table-bordered table-hover hide " id="employeeleavedetailstable">
                                    <thead style="background:#404040; color:#FFF;" id="employeeleavedetailstablethead">
                                            <tr id="theadrow" class="text-nowrap">
                                            <th>Employee Name</th>
                                            <th>January</th>
                                            <th>February</th>
                                            <th>March</th>
                                            <th>April</th>
                                            <th>May</th>
                                            <th>June</th>
                                            <th>July</th>
                                            <th>August</th>
                                            <th>September</th>
                                            <th>October</th>
                                            <th>November</th>
                                            <th>December</th>
                                            <th>Total<br>Leave</th>
                                            <th>Alloted<br>Leave</th>
                                            <th>Leave<br>Balance</th>
                                            
                                            
                                            
                                           </tr>
                                                                                  
                                   
                                    </thead>
                                    <tbody id="employeeleavedetailstabletbody">
                                    	
                                    </tbody>
                                </table>
							 <div id="exportbuttondiv" class="hide">
                                <a  id="employeeleavedetailsexport" class="btn btn-success customexportbutton"><spring:message code="invitemstock.jsp.export" text="EXPORT" /></a>
                                </div>
							</div>
							
                                    </div>
                                

						 
				</div>
                	
            </div>
          
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
   <script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/table2excel.js"></script>
  
   <script>
   
   
   
  
   </script>
   
   
   

   <script type="text/javascript">
   
   	
   
   var BASE_URL="${pageContext.request.contextPath}";

   var language = '<%= session.getAttribute("language") %>';

   var storeID="${sessionScope.loggedinStore.id}";

   var detmg="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png";
   var deleteimg="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png";
   var editimg="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png";
   var contextpath="${pageContext.request.contextPath}";
 
   </script>	
   
   
      
  <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> 
     <%-- <script src="${pageContext.request.contextPath}/assets/js/hradminScript.js"></script> --%>
    <%--  <script src="${pageContext.request.contextPath}/assets/js/shiftSchedule.js"></script> --%>
      <script src="${pageContext.request.contextPath}/assets/js/employeeleavedetails.js"></script>
    </c:otherwise>
    </c:choose>

  
</body>
