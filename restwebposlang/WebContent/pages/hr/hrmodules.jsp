<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <c:if test="${sessionScope.loggedinStore.isHr=='N'}">  --%>
<head>
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
<jsp:include page="/pages/common/header.jsp"></jsp:include>

</head>
<body>
<%-- <jsp:include page="/pages/common/header.jsp"></jsp:include> --%>


<div class="col-md-2 col-sm-2" id="hrmodulesmaindiv">
<%-- <c:if test="${sessionScope.loggedinStore.isHr=='Y'}"> --%>
	<div id="hrmodulesmaindiv2" class="menu-category" style="height:auto; overflow-y: auto;">
		<!-- <div style="overflow-y: auto; height: 500px;"> -->
		
			<div id="hrmodulesmaindiv3" style="padding: 5px;">
				<div id="shiftanchordiv" class="item item-sub-child" style="background-color: #5E7E1D;">
					<a  href="javascript:loadShiftSchedule()"><spring:message code="admin.admleftpanel.jsp.shiftschedule" text="SHIFT SCHEDULE" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeAttendance()"><spring:message code="admin.admleftpanel.jsp.shiftschedule" text="EMPLOYEE ATTENDANCE" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeLeaveDetails()"><spring:message code="admin.admleftpanel.jsp.shiftschedule" text="EMPLOYEE LEAVE DETAILS" /></a>
				</div>
			</div>
		
		<!-- </div> -->
		
	</div>
	<%-- </c:if> --%>
</div>

<%-- </c:if> --%>



<script
	src="${pageContext.request.contextPath}/assets/js/adminleftpanel.js"></script>
<script type="text/javascript">
	var BASE_URL = "${pageContext.request.contextPath}";
	var PAGE_CONTEXT_LOCAL = "${pageContext.response.locale}";
	var hr="${sessionScope.loggedinStore.isHr}";
	var id="${sessionScope.loggedinStore.id}";
	
	
	
</script>

</body>