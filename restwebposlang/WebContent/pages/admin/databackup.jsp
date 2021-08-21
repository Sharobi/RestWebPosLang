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
<title>:. POS :: Menu Management :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pick-a-color-1.2.3.min.css">
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
					<!--  <div class="col-md-10 col-sm-10">
				<div class="col-md-6 col-sm-6">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;">CHANGE PASSWORD</div> 
                </div><div class="col-md-4 col-sm-4">
                </div>
               
                </div> -->
					<div class="col-md-2 col-sm-2">
						<!-- 					               <div style="color:#FFF; font-size:16px; font-weight:bold;">CHANGE PASSWORD</div>  -->
					</div>
					<div class="col-md-4 col-sm-4">
						<div style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="admin.databackup.jsp.dbBackUp" text="DATA BACK UP" /></div>
						<br />
						<form id="myform_for_databackup" modelAttribute="user" action="${pageContext.request.contextPath }/admin/dodatabackup.htm" method="POST" class="form-horizontal" role="form">

							<div class="form-group">
								<label class="control-label col-sm-5" for="pwd" style="color: #FFF; font-weight: bold;"><spring:message code="admin.databackup.jsp.username" text="USER NAME:" /></label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="userName" name="userName" required>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-5" for="pwd" style="color: #FFF; font-weight: bold;"><spring:message code="admin.databackup.jsp.pw" text="PASSSW0RD:" /></label>
								<div class="col-sm-7">
									<input type="password" class="form-control" id="password" name="password" required>
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-offset-5 col-sm-7">
									<button type="submit" id="chpwdbutton" class="btn btn-primary "><spring:message code="admin.databackup.jsp.submit" text="Submit" /></button>
								</div>
							</div>
						</form>
					</div>
					<div class="col-md-2 col-sm-2"></div>
				</div>
				<div class="col-md-2 col-sm-2"></div>
				<div class="col-md-6 col-sm-6" style="color: #FFF; font-size: 16px; font-weight: bold;">
					<c:if test="${msg == 'success'}">
				<spring:message code="admin.databackup.jsp.dbBackUpSuccessfully" text="Data backup done successfully!" />
				</c:if>
					<c:if test="${msg == 'failure'}">
				<spring:message code="admin.databackup.jsp.error" text="There is some error. Please try again." />
				</c:if>
				<c:if test="${msg == 'invalidlogin'}">
    <spring:message code="admin.databackup.jsp.invalidUnameAndPW" text="Invalid UserName or Password." />
    </c:if>
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
	<script src="${pageContext.request.contextPath}/assets/js/tinycolor-0.9.15.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/pick-a-color-1.2.3.min.js"></script>
	<script type="text/javascript">
		function checkSamePassword(repass) {
			var newpwd = $("#newpwd").val();
			console.log("repass=" + repass);
			console.log("newpwd=" + newpwd);
			if (repass == newpwd) {
				$("#pwdchk").text("");
				$("#chpwdbutton").removeClass("disabled");
			} else {
				$("#pwdchk").text(getLang.pwNotMatch);
				$("#chpwdbutton").addClass("disabled");
			}

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